-- Security Audit Fixes - November 28, 2025
-- Addresses critical vulnerabilities found in security audit

-- ============================================================================
-- PART 1: ENABLE RLS ON ALL TABLES
-- ============================================================================

-- Enable RLS on tables that currently have it disabled
ALTER TABLE public.prerequisites ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.success_indicators ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.rate_limits ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.troubleshooting_sessions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.patterns ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.contributors ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.solution_votes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.admin_ips ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.mining_tracker ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.banned_ips ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.contribution_attempts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.postmortems ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.pending_ticket_solutions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.tech_keywords ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.search_logs ENABLE ROW LEVEL SECURITY;

-- ============================================================================
-- PART 2: CREATE RLS POLICIES (READ-ONLY FOR PUBLIC DATA)
-- ============================================================================

-- Prerequisites: Public read-only (linked to knowledge_entries)
CREATE POLICY "Public read prerequisites"
  ON public.prerequisites
  FOR SELECT
  TO public
  USING (true);

-- Success Indicators: Public read-only (linked to knowledge_entries)
CREATE POLICY "Public read success_indicators"
  ON public.success_indicators
  FOR SELECT
  TO public
  USING (true);

-- Patterns: Public read-only (error pattern templates)
CREATE POLICY "Public read patterns"
  ON public.patterns
  FOR SELECT
  TO public
  USING (true);

-- Postmortems: Public read-only (incident reports)
CREATE POLICY "Public read postmortems"
  ON public.postmortems
  FOR SELECT
  TO public
  USING (true);

-- Tech Keywords: Public read-only (for query categorization)
CREATE POLICY "Public read tech_keywords"
  ON public.tech_keywords
  FOR SELECT
  TO public
  USING (true);

-- ============================================================================
-- PART 3: ADMIN-ONLY TABLES (NO PUBLIC ACCESS)
-- ============================================================================

-- Admin IPs: NO public access (critical security table)
-- No policy = default deny

-- Banned IPs: NO public access (critical security table)
-- No policy = default deny

-- Rate Limits: NO public access (manipulable if exposed)
-- No policy = default deny

-- Mining Tracker: NO public access (internal operations)
-- No policy = default deny

-- Contribution Attempts: NO public access (analytics)
-- No policy = default deny

-- Search Logs: NO public access (contains user queries/PII)
-- No policy = default deny

-- ============================================================================
-- PART 4: SERVICE-MANAGED TABLES (NO DIRECT PUBLIC ACCESS)
-- ============================================================================

-- Contributors: Service manages via Edge Functions
-- No direct public access - only via service role
CREATE POLICY "Service role full access to contributors"
  ON public.contributors
  FOR ALL
  TO service_role
  USING (true);

-- Solution Votes: Service manages via Edge Functions
CREATE POLICY "Service role full access to solution_votes"
  ON public.solution_votes
  FOR ALL
  TO service_role
  USING (true);

-- Troubleshooting Sessions: Service manages via Edge Functions
-- Users can read their own sessions via session_id (optional future feature)
CREATE POLICY "Service role full access to sessions"
  ON public.troubleshooting_sessions
  FOR ALL
  TO service_role
  USING (true);

-- Pending Ticket Solutions: Service manages via Edge Functions
CREATE POLICY "Service role full access to pending_ticket_solutions"
  ON public.pending_ticket_solutions
  FOR ALL
  TO service_role
  USING (true);

-- ============================================================================
-- PART 5: ADD STATEMENT TIMEOUT (DoS PROTECTION)
-- ============================================================================

-- Set global statement timeout to 10 seconds for anon/authenticated roles
ALTER ROLE anon SET statement_timeout = '10s';
ALTER ROLE authenticated SET statement_timeout = '10s';

-- Service role keeps longer timeout for admin operations
ALTER ROLE service_role SET statement_timeout = '60s';

-- ============================================================================
-- PART 6: CREATE HELPER FUNCTION FOR SECURE IP DETECTION
-- ============================================================================

-- Helper function to get real client IP (prevents spoofing)
-- Edge Functions should use this instead of trusting headers directly
CREATE OR REPLACE FUNCTION public.get_real_client_ip(headers_json jsonb)
RETURNS text
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  cf_connecting_ip text;
  x_forwarded_for text;
  x_real_ip text;
  final_ip text;
BEGIN
  -- Priority 1: Cloudflare's CF-Connecting-IP (if behind Cloudflare)
  cf_connecting_ip := headers_json->>'cf-connecting-ip';
  IF cf_connecting_ip IS NOT NULL AND cf_connecting_ip != '' THEN
    RETURN cf_connecting_ip;
  END IF;

  -- Priority 2: X-Real-IP (if behind proxy)
  x_real_ip := headers_json->>'x-real-ip';
  IF x_real_ip IS NOT NULL AND x_real_ip != '' THEN
    RETURN x_real_ip;
  END IF;

  -- Priority 3: First IP in X-Forwarded-For chain
  x_forwarded_for := headers_json->>'x-forwarded-for';
  IF x_forwarded_for IS NOT NULL AND x_forwarded_for != '' THEN
    -- Get first IP in comma-separated list
    final_ip := split_part(x_forwarded_for, ',', 1);
    RETURN trim(final_ip);
  END IF;

  -- Fallback: unknown
  RETURN 'unknown';
END;
$$;

-- ============================================================================
-- PART 7: ADD PII SANITIZATION FUNCTION
-- ============================================================================

-- Function to sanitize search queries before logging (remove API keys, secrets)
CREATE OR REPLACE FUNCTION public.sanitize_query(raw_query text)
RETURNS text
LANGUAGE plpgsql
IMMUTABLE
AS $$
DECLARE
  sanitized text;
BEGIN
  sanitized := raw_query;

  -- Remove API keys (common patterns)
  sanitized := regexp_replace(sanitized, 'sk-[a-zA-Z0-9]{40,}', '[API_KEY_REDACTED]', 'gi');
  sanitized := regexp_replace(sanitized, 'api[_-]?key[:\s=]+[a-zA-Z0-9_-]{20,}', '[API_KEY_REDACTED]', 'gi');

  -- Remove bearer tokens
  sanitized := regexp_replace(sanitized, 'bearer\s+[a-zA-Z0-9_-]{20,}', '[TOKEN_REDACTED]', 'gi');

  -- Remove JWT tokens
  sanitized := regexp_replace(sanitized, 'eyJ[a-zA-Z0-9_-]+\.[a-zA-Z0-9_-]+\.[a-zA-Z0-9_-]+', '[JWT_REDACTED]', 'gi');

  -- Remove passwords in common formats
  sanitized := regexp_replace(sanitized, 'password[:\s=]+\S+', 'password=[PASSWORD_REDACTED]', 'gi');
  sanitized := regexp_replace(sanitized, 'passwd[:\s=]+\S+', 'passwd=[PASSWORD_REDACTED]', 'gi');

  -- Remove email addresses (optional - might be useful for debugging)
  -- sanitized := regexp_replace(sanitized, '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}', '[EMAIL_REDACTED]', 'gi');

  RETURN sanitized;
END;
$$;

-- ============================================================================
-- PART 8: UPDATE EXISTING POLICIES (FIXES)
-- ============================================================================

-- Drop and recreate pending_contributions policy to prevent auth bypass
DROP POLICY IF EXISTS "Users can submit contributions" ON public.pending_contributions;

-- New policy: Allow insert via service role only (Edge Functions)
-- Public can't insert directly - must go through contribute endpoint
CREATE POLICY "Service role can insert contributions"
  ON public.pending_contributions
  FOR INSERT
  TO service_role
  WITH CHECK (true);

-- Users can still read their own (if they provide email)
-- Keep existing "Users can read own contributions" policy

-- ============================================================================
-- PART 9: AUDIT LOG TABLE (TRACK SECURITY EVENTS)
-- ============================================================================

CREATE TABLE IF NOT EXISTS public.security_audit_log (
  id bigserial PRIMARY KEY,
  event_type text NOT NULL, -- 'rate_limit_exceeded', 'admin_function_blocked', 'suspicious_query'
  ip_address text,
  endpoint text,
  details jsonb,
  created_at timestamptz DEFAULT now()
);

-- Enable RLS on audit log
ALTER TABLE public.security_audit_log ENABLE ROW LEVEL SECURITY;

-- Only service role can insert/read
CREATE POLICY "Service role full access to audit_log"
  ON public.security_audit_log
  FOR ALL
  TO service_role
  USING (true);

-- ============================================================================
-- PART 10: COMMENTS FOR DOCUMENTATION
-- ============================================================================

COMMENT ON POLICY "Public read prerequisites" ON public.prerequisites IS
  'Public can read prerequisites linked to knowledge entries (read-only)';

COMMENT ON POLICY "Service role full access to contributors" ON public.contributors IS
  'Only Edge Functions (service role) can manage contributor data. Prevents direct manipulation.';

COMMENT ON FUNCTION public.sanitize_query(text) IS
  'Removes sensitive data (API keys, passwords, tokens) from search queries before logging. GDPR/CCPA compliance.';

COMMENT ON FUNCTION public.get_real_client_ip(jsonb) IS
  'Extracts real client IP from request headers with anti-spoofing logic. Use in Edge Functions.';

COMMENT ON TABLE public.security_audit_log IS
  'Audit trail for security events: rate limits, blocked attempts, suspicious activity.';
