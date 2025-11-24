-- Add troubleshooting ticket system
CREATE TABLE IF NOT EXISTS troubleshooting_sessions (
    id SERIAL PRIMARY KEY,
    ticket_id TEXT UNIQUE NOT NULL,
    problem TEXT NOT NULL,
    category TEXT NOT NULL,
    status TEXT DEFAULT 'open' CHECK (status IN ('open', 'in_progress', 'resolved', 'abandoned')),
    steps_tried JSONB DEFAULT '[]'::jsonb,
    solution TEXT,
    solution_data JSONB,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    resolved_at TIMESTAMPTZ,
    auto_contributed BOOLEAN DEFAULT FALSE
);

-- Index for quick lookups
CREATE INDEX idx_troubleshooting_ticket_id ON troubleshooting_sessions(ticket_id);
CREATE INDEX idx_troubleshooting_status ON troubleshooting_sessions(status);
CREATE INDEX idx_troubleshooting_created ON troubleshooting_sessions(created_at DESC);

-- Function to generate ticket ID
CREATE OR REPLACE FUNCTION generate_ticket_id() RETURNS TEXT AS $$
DECLARE
    v_id INTEGER;
    v_ticket_id TEXT;
BEGIN
    SELECT COALESCE(MAX(id), 0) + 1 INTO v_id FROM troubleshooting_sessions;
    v_ticket_id := 'TICKET_' || LPAD(v_id::TEXT, 6, '0');
    RETURN v_ticket_id;
END;
$$ LANGUAGE plpgsql;

-- Function to start troubleshooting ticket
CREATE OR REPLACE FUNCTION start_troubleshooting_ticket(
    p_problem TEXT,
    p_category TEXT
) RETURNS JSONB AS $$
DECLARE
    v_ticket_id TEXT;
    v_checklist JSONB;
    v_result JSONB;
BEGIN
    -- Generate ticket ID
    v_ticket_id := generate_ticket_id();

    -- Category-specific checklists
    v_checklist := CASE p_category
        WHEN 'mcp-troubleshooting' THEN '["Check MCP server status with claude mcp list", "Review MCP server logs", "Verify configuration in mcp_config.json", "Test with minimal configuration", "Check network connectivity"]'::jsonb
        WHEN 'web-automation' THEN '["Check browser console for errors", "Verify selector exists in DOM", "Test with longer timeout", "Check for iframes or shadow DOM", "Try alternative selector strategy"]'::jsonb
        WHEN 'database' THEN '["Check database logs", "Verify RLS policies", "Test query in SQL editor", "Check authentication token", "Review table permissions"]'::jsonb
        WHEN 'authentication' THEN '["Check localStorage for auth token", "Verify API keys in environment", "Test auth flow in incognito", "Review auth configuration", "Check token expiration"]'::jsonb
        ELSE '["Review error logs", "Check configuration", "Test in isolation", "Verify dependencies", "Check documentation"]'::jsonb
    END;

    -- Insert ticket
    INSERT INTO troubleshooting_sessions (ticket_id, problem, category, status)
    VALUES (v_ticket_id, p_problem, p_category, 'open')
    RETURNING jsonb_build_object(
        'ticket_id', ticket_id,
        'problem', problem,
        'category', category,
        'status', status,
        'checklist', v_checklist,
        'created_at', created_at
    ) INTO v_result;

    RETURN v_result;
END;
$$ LANGUAGE plpgsql;

-- Function to update ticket with steps tried
CREATE OR REPLACE FUNCTION update_ticket_steps(
    p_ticket_id TEXT,
    p_step TEXT,
    p_result TEXT
) RETURNS BOOLEAN AS $$
BEGIN
    UPDATE troubleshooting_sessions
    SET
        steps_tried = steps_tried || jsonb_build_object('step', p_step, 'result', p_result, 'timestamp', NOW()),
        status = 'in_progress'
    WHERE ticket_id = p_ticket_id;

    RETURN FOUND;
END;
$$ LANGUAGE plpgsql;

-- Function to resolve ticket and auto-contribute
CREATE OR REPLACE FUNCTION resolve_ticket(
    p_ticket_id TEXT,
    p_solution_data JSONB
) RETURNS JSONB AS $$
DECLARE
    v_ticket RECORD;
    v_knowledge_id INTEGER;
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

    -- Auto-contribute to knowledge base (bypass moderation for ticket-based solutions)
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
        source_ticket_id
    ) VALUES (
        v_ticket.problem,
        v_ticket.category,
        'MEDIUM (from ticket)',
        p_solution_data->'solutions',
        COALESCE(p_solution_data->>'prerequisites', 'Review error logs, Check configuration'),
        COALESCE(p_solution_data->>'success_indicators', 'Error resolved, Feature works as expected'),
        COALESCE(p_solution_data->>'common_pitfalls', ''),
        COALESCE((p_solution_data->>'success_rate')::NUMERIC, 0.90),
        'sonnet-4',
        NOW(),
        p_ticket_id
    )
    RETURNING id INTO v_knowledge_id;

    -- Mark as auto-contributed
    UPDATE troubleshooting_sessions
    SET auto_contributed = TRUE
    WHERE ticket_id = p_ticket_id;

    RETURN jsonb_build_object(
        'success', TRUE,
        'ticket_id', p_ticket_id,
        'knowledge_id', v_knowledge_id,
        'message', 'Solution added to knowledge base automatically'
    );
END;
$$ LANGUAGE plpgsql;

-- Add source_ticket_id to knowledge_entries for traceability
ALTER TABLE knowledge_entries ADD COLUMN IF NOT EXISTS source_ticket_id TEXT;
CREATE INDEX IF NOT EXISTS idx_knowledge_source_ticket ON knowledge_entries(source_ticket_id);
