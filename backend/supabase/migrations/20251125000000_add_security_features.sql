-- Security Features for 50-User Launch
-- 1. IP banning system
-- 2. Modified resolve_ticket() to route to pending queue
-- 3. Admin moderation functions

-- ===========================================
-- IP BANNING SYSTEM
-- ===========================================

CREATE TABLE IF NOT EXISTS banned_ips (
    ip_address TEXT PRIMARY KEY,
    reason TEXT NOT NULL,
    banned_by TEXT DEFAULT 'admin',
    banned_at TIMESTAMPTZ DEFAULT NOW(),
    expires_at TIMESTAMPTZ -- NULL = permanent ban
);

CREATE INDEX idx_banned_ips_expires ON banned_ips(expires_at) WHERE expires_at IS NOT NULL;

-- Function to check if IP is banned
CREATE OR REPLACE FUNCTION is_ip_banned(p_ip_address TEXT)
RETURNS BOOLEAN AS $$
BEGIN
    RETURN EXISTS (
        SELECT 1 FROM banned_ips
        WHERE ip_address = p_ip_address
        AND (expires_at IS NULL OR expires_at > NOW())
    );
END;
$$ LANGUAGE plpgsql;

-- Function to ban IP
CREATE OR REPLACE FUNCTION ban_ip(
    p_ip_address TEXT,
    p_reason TEXT,
    p_expires_days INTEGER DEFAULT NULL -- NULL = permanent
) RETURNS JSONB AS $$
DECLARE
    v_expires TIMESTAMPTZ;
BEGIN
    v_expires := CASE
        WHEN p_expires_days IS NOT NULL
        THEN NOW() + (p_expires_days || ' days')::INTERVAL
        ELSE NULL
    END;

    INSERT INTO banned_ips (ip_address, reason, expires_at)
    VALUES (p_ip_address, p_reason, v_expires)
    ON CONFLICT (ip_address)
    DO UPDATE SET
        reason = EXCLUDED.reason,
        expires_at = EXCLUDED.expires_at,
        banned_at = NOW();

    RETURN jsonb_build_object(
        'success', TRUE,
        'ip', p_ip_address,
        'expires', v_expires
    );
END;
$$ LANGUAGE plpgsql;

-- Function to unban IP
CREATE OR REPLACE FUNCTION unban_ip(p_ip_address TEXT)
RETURNS BOOLEAN AS $$
BEGIN
    DELETE FROM banned_ips WHERE ip_address = p_ip_address;
    RETURN FOUND;
END;
$$ LANGUAGE plpgsql;

-- ===========================================
-- MODIFIED RESOLVE_TICKET (PENDING QUEUE)
-- ===========================================

-- Drop old version
DROP FUNCTION IF EXISTS resolve_ticket(TEXT, JSONB);

-- New version: Routes to pending_contributions instead of direct KB
CREATE OR REPLACE FUNCTION resolve_ticket(
    p_ticket_id TEXT,
    p_solution_data JSONB
) RETURNS JSONB AS $$
DECLARE
    v_ticket RECORD;
    v_pending_id INTEGER;
    v_result JSONB;
BEGIN
    -- Get ticket info
    SELECT * INTO v_ticket
    FROM troubleshooting_sessions
    WHERE ticket_id = p_ticket_id AND status != 'resolved';

    IF NOT FOUND THEN
        RETURN jsonb_build_object('error', 'Ticket not found or already resolved');
    END IF;

    -- Update ticket status
    UPDATE troubleshooting_sessions
    SET
        status = 'resolved',
        solution = p_solution_data->>'solution',
        solution_data = p_solution_data,
        resolved_at = NOW()
    WHERE ticket_id = p_ticket_id;

    -- Route to PENDING queue (not direct to KB)
    INSERT INTO pending_contributions (
        contributor_email,
        query,
        category,
        hit_frequency,
        solutions,
        prerequisites,
        success_indicators,
        common_pitfalls,
        success_rate,
        status
    ) VALUES (
        'ticket-based',  -- Mark as ticket-originated
        v_ticket.problem,
        v_ticket.category,
        'MEDIUM (ticket)',
        p_solution_data->'solutions',
        COALESCE(p_solution_data->>'prerequisites', 'Review error logs, Check configuration'),
        COALESCE(p_solution_data->>'success_indicators', 'Error resolved'),
        COALESCE(p_solution_data->>'common_pitfalls', ''),
        COALESCE((p_solution_data->>'success_rate')::REAL, 0.90),
        'pending_review'  -- Requires admin approval
    )
    RETURNING id INTO v_pending_id;

    -- Store reference in ticket
    UPDATE troubleshooting_sessions
    SET auto_contributed = FALSE  -- Not auto-contributed anymore
    WHERE ticket_id = p_ticket_id;

    RETURN jsonb_build_object(
        'success', TRUE,
        'ticket_id', p_ticket_id,
        'pending_id', v_pending_id,
        'message', 'Solution submitted for review. Pending approval by admin.'
    );
END;
$$ LANGUAGE plpgsql;

-- ===========================================
-- ADMIN MODERATION FUNCTIONS
-- ===========================================

-- Approve pending contribution
CREATE OR REPLACE FUNCTION approve_contribution(p_pending_id INTEGER)
RETURNS JSONB AS $$
DECLARE
    v_pending RECORD;
    v_knowledge_id INTEGER;
    v_contributor_id INTEGER;
BEGIN
    -- Get pending contribution
    SELECT * INTO v_pending
    FROM pending_contributions
    WHERE id = p_pending_id AND status = 'pending_review';

    IF NOT FOUND THEN
        RETURN jsonb_build_object('error', 'Pending contribution not found or already processed');
    END IF;

    -- Get or create contributor
    INSERT INTO contributors (email)
    VALUES (v_pending.contributor_email)
    ON CONFLICT (email) DO UPDATE SET contribution_count = contributors.contribution_count + 1
    RETURNING id INTO v_contributor_id;

    -- Move to knowledge base
    INSERT INTO knowledge_entries (
        query,
        category,
        hit_frequency,
        solutions,
        prerequisites,
        success_indicators,
        common_pitfalls,
        success_rate,
        claude_version,
        last_verified,
        contributor_id
    ) VALUES (
        v_pending.query,
        v_pending.category,
        COALESCE(v_pending.hit_frequency, 'MEDIUM'),
        v_pending.solutions,
        v_pending.prerequisites,
        v_pending.success_indicators,
        v_pending.common_pitfalls,
        COALESCE(v_pending.success_rate, 0.85),
        'sonnet-4',
        NOW(),
        v_contributor_id
    )
    RETURNING id INTO v_knowledge_id;

    -- Update pending status
    UPDATE pending_contributions
    SET
        status = 'approved',
        reviewed_at = NOW()
    WHERE id = p_pending_id;

    RETURN jsonb_build_object(
        'success', TRUE,
        'pending_id', p_pending_id,
        'knowledge_id', v_knowledge_id,
        'message', 'Contribution approved and published'
    );
END;
$$ LANGUAGE plpgsql;

-- Reject pending contribution
CREATE OR REPLACE FUNCTION reject_contribution(
    p_pending_id INTEGER,
    p_reason TEXT
) RETURNS JSONB AS $$
BEGIN
    UPDATE pending_contributions
    SET
        status = 'rejected',
        reviewed_at = NOW(),
        reviewer_notes = p_reason
    WHERE id = p_pending_id AND status = 'pending_review';

    IF NOT FOUND THEN
        RETURN jsonb_build_object('error', 'Pending contribution not found');
    END IF;

    RETURN jsonb_build_object(
        'success', TRUE,
        'pending_id', p_pending_id,
        'message', 'Contribution rejected: ' || p_reason
    );
END;
$$ LANGUAGE plpgsql;

-- Delete solution from knowledge base (admin only)
CREATE OR REPLACE FUNCTION delete_solution(p_knowledge_id INTEGER)
RETURNS JSONB AS $$
BEGIN
    DELETE FROM knowledge_entries WHERE id = p_knowledge_id;

    IF NOT FOUND THEN
        RETURN jsonb_build_object('error', 'Solution not found');
    END IF;

    RETURN jsonb_build_object(
        'success', TRUE,
        'knowledge_id', p_knowledge_id,
        'message', 'Solution deleted'
    );
END;
$$ LANGUAGE plpgsql;

-- Get pending contributions summary
CREATE OR REPLACE FUNCTION get_pending_summary()
RETURNS JSONB AS $$
DECLARE
    v_pending_count INTEGER;
    v_oldest_date TIMESTAMPTZ;
    v_recent JSONB;
BEGIN
    SELECT COUNT(*), MIN(submitted_at)
    INTO v_pending_count, v_oldest_date
    FROM pending_contributions
    WHERE status = 'pending_review';

    SELECT jsonb_agg(
        jsonb_build_object(
            'id', id,
            'query', query,
            'category', category,
            'submitted_at', submitted_at,
            'contributor', contributor_email
        )
    )
    INTO v_recent
    FROM (
        SELECT * FROM pending_contributions
        WHERE status = 'pending_review'
        ORDER BY submitted_at DESC
        LIMIT 10
    ) recent;

    RETURN jsonb_build_object(
        'pending_count', COALESCE(v_pending_count, 0),
        'oldest_submission', v_oldest_date,
        'recent_items', COALESCE(v_recent, '[]'::jsonb)
    );
END;
$$ LANGUAGE plpgsql;

-- ===========================================
-- SANITIZATION HELPERS
-- ===========================================

-- Function to sanitize text input
CREATE OR REPLACE FUNCTION sanitize_text(p_text TEXT)
RETURNS TEXT AS $$
BEGIN
    IF p_text IS NULL THEN
        RETURN NULL;
    END IF;

    -- Remove dangerous patterns
    p_text := regexp_replace(p_text, '<script[^>]*>.*?</script>', '', 'gi');
    p_text := regexp_replace(p_text, '<iframe[^>]*>.*?</iframe>', '', 'gi');
    p_text := regexp_replace(p_text, 'javascript:', '', 'gi');
    p_text := regexp_replace(p_text, 'on\w+\s*=', '', 'gi');

    -- Limit length
    IF length(p_text) > 10000 THEN
        p_text := substring(p_text, 1, 10000);
    END IF;

    RETURN p_text;
END;
$$ LANGUAGE plpgsql;

-- ===========================================
-- ANALYTICS FOR MONITORING
-- ===========================================

-- Track contribution attempts (for abuse detection)
CREATE TABLE IF NOT EXISTS contribution_attempts (
    id SERIAL PRIMARY KEY,
    ip_address TEXT NOT NULL,
    endpoint TEXT NOT NULL,
    success BOOLEAN DEFAULT TRUE,
    attempted_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_contrib_attempts_ip_time ON contribution_attempts(ip_address, attempted_at DESC);

-- Function to log contribution attempt
CREATE OR REPLACE FUNCTION log_contribution_attempt(
    p_ip_address TEXT,
    p_endpoint TEXT,
    p_success BOOLEAN
) RETURNS VOID AS $$
BEGIN
    INSERT INTO contribution_attempts (ip_address, endpoint, success)
    VALUES (p_ip_address, p_endpoint, p_success);

    -- Auto-cleanup old records (keep last 7 days)
    DELETE FROM contribution_attempts
    WHERE attempted_at < NOW() - INTERVAL '7 days';
END;
$$ LANGUAGE plpgsql;

-- Check for suspicious activity
CREATE OR REPLACE FUNCTION check_suspicious_activity(p_ip_address TEXT)
RETURNS JSONB AS $$
DECLARE
    v_recent_count INTEGER;
    v_failed_count INTEGER;
BEGIN
    -- Count recent attempts in last hour
    SELECT
        COUNT(*),
        COUNT(*) FILTER (WHERE success = FALSE)
    INTO v_recent_count, v_failed_count
    FROM contribution_attempts
    WHERE ip_address = p_ip_address
    AND attempted_at > NOW() - INTERVAL '1 hour';

    RETURN jsonb_build_object(
        'ip', p_ip_address,
        'recent_attempts', v_recent_count,
        'failed_attempts', v_failed_count,
        'suspicious', (v_recent_count > 20 OR v_failed_count > 10)
    );
END;
$$ LANGUAGE plpgsql;
