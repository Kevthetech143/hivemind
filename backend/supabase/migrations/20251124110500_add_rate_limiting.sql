-- Add rate limiting table
CREATE TABLE IF NOT EXISTS rate_limits (
    ip_address TEXT NOT NULL,
    endpoint TEXT NOT NULL,
    request_count INTEGER DEFAULT 1,
    window_start TIMESTAMPTZ DEFAULT NOW(),
    PRIMARY KEY (ip_address, endpoint)
);

-- Create index for cleanup
CREATE INDEX IF NOT EXISTS idx_rate_limits_window ON rate_limits(window_start);

-- Function to check and update rate limit
CREATE OR REPLACE FUNCTION check_rate_limit(
    p_ip_address TEXT,
    p_endpoint TEXT,
    p_limit INTEGER,
    p_window_minutes INTEGER DEFAULT 60
) RETURNS BOOLEAN AS $$
DECLARE
    v_count INTEGER;
    v_window_start TIMESTAMPTZ;
BEGIN
    -- Get current count and window start
    SELECT request_count, window_start
    INTO v_count, v_window_start
    FROM rate_limits
    WHERE ip_address = p_ip_address AND endpoint = p_endpoint;

    -- If no record or window expired, reset
    IF v_count IS NULL OR (NOW() - v_window_start) > (p_window_minutes || ' minutes')::INTERVAL THEN
        INSERT INTO rate_limits (ip_address, endpoint, request_count, window_start)
        VALUES (p_ip_address, p_endpoint, 1, NOW())
        ON CONFLICT (ip_address, endpoint)
        DO UPDATE SET request_count = 1, window_start = NOW();
        RETURN TRUE;
    END IF;

    -- If under limit, increment
    IF v_count < p_limit THEN
        UPDATE rate_limits
        SET request_count = request_count + 1
        WHERE ip_address = p_ip_address AND endpoint = p_endpoint;
        RETURN TRUE;
    END IF;

    -- Over limit
    RETURN FALSE;
END;
$$ LANGUAGE plpgsql;

-- Function to cleanup old rate limit entries (run periodically)
CREATE OR REPLACE FUNCTION cleanup_rate_limits() RETURNS INTEGER AS $$
DECLARE
    v_deleted INTEGER;
BEGIN
    DELETE FROM rate_limits
    WHERE (NOW() - window_start) > INTERVAL '2 hours';

    GET DIAGNOSTICS v_deleted = ROW_COUNT;
    RETURN v_deleted;
END;
$$ LANGUAGE plpgsql;
