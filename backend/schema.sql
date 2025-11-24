-- Claude Code Knowledge Base - Supabase Schema
-- Complete schema with RPC functions and Row Level Security

-- ============================================================================
-- Main Tables
-- ============================================================================

-- Knowledge entries table
CREATE TABLE IF NOT EXISTS knowledge_entries (
    id BIGSERIAL PRIMARY KEY,
    query TEXT NOT NULL,
    category TEXT NOT NULL,
    hit_frequency TEXT DEFAULT 'MEDIUM',
    solutions JSONB NOT NULL,
    common_pitfalls TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    view_count INTEGER DEFAULT 0,
    command_copy_count INTEGER DEFAULT 0,
    repeat_search_rate REAL DEFAULT 0.0,
    success_rate REAL,
    thumbs_up INTEGER DEFAULT 0,
    thumbs_down INTEGER DEFAULT 0,
    last_verified TIMESTAMPTZ,
    claude_version VARCHAR(20),
    is_deprecated BOOLEAN DEFAULT FALSE
);

-- Full-text search index
CREATE INDEX IF NOT EXISTS idx_knowledge_fts ON knowledge_entries
USING GIN (to_tsvector('english', query || ' ' || COALESCE(common_pitfalls, '') || ' ' || category));

-- Performance indexes
CREATE INDEX IF NOT EXISTS idx_category ON knowledge_entries(category);
CREATE INDEX IF NOT EXISTS idx_success_rate ON knowledge_entries(success_rate DESC NULLS LAST);
CREATE INDEX IF NOT EXISTS idx_view_count ON knowledge_entries(view_count DESC);
CREATE INDEX IF NOT EXISTS idx_thumbs_rating ON knowledge_entries((thumbs_up - thumbs_down) DESC);

-- Prerequisites (normalized)
CREATE TABLE IF NOT EXISTS prerequisites (
    id BIGSERIAL PRIMARY KEY,
    entry_id BIGINT REFERENCES knowledge_entries(id) ON DELETE CASCADE,
    prerequisite TEXT NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_prerequisites_entry ON prerequisites(entry_id);

-- Success indicators (normalized)
CREATE TABLE IF NOT EXISTS success_indicators (
    id BIGSERIAL PRIMARY KEY,
    entry_id BIGINT REFERENCES knowledge_entries(id) ON DELETE CASCADE,
    indicator TEXT NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_success_indicators_entry ON success_indicators(entry_id);

-- Pending contributions (moderation queue)
CREATE TABLE IF NOT EXISTS pending_contributions (
    id BIGSERIAL PRIMARY KEY,
    contributor_email TEXT NOT NULL,
    query TEXT NOT NULL,
    category TEXT NOT NULL,
    hit_frequency TEXT DEFAULT 'MEDIUM',
    solutions JSONB NOT NULL,
    prerequisites TEXT,
    success_indicators TEXT,
    common_pitfalls TEXT,
    success_rate REAL,
    status TEXT DEFAULT 'pending',
    submitted_at TIMESTAMPTZ DEFAULT NOW(),
    reviewed_at TIMESTAMPTZ,
    reviewer_notes TEXT
);

CREATE INDEX IF NOT EXISTS idx_pending_status ON pending_contributions(status);
CREATE INDEX IF NOT EXISTS idx_pending_submitted ON pending_contributions(submitted_at DESC);

-- User usage tracking (for rate limiting)
CREATE TABLE IF NOT EXISTS user_usage (
    user_id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    email TEXT,
    tier TEXT DEFAULT 'free',
    queries_today INTEGER DEFAULT 0,
    queries_limit INTEGER DEFAULT 100,
    last_reset_at TIMESTAMPTZ DEFAULT NOW(),
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_user_usage_email ON user_usage(email);

-- ============================================================================
-- RPC Functions
-- ============================================================================

-- Search function with full-text search and ranking
CREATE OR REPLACE FUNCTION search_knowledge(
    search_query TEXT,
    result_limit INTEGER DEFAULT 5
)
RETURNS TABLE (
    id BIGINT,
    query TEXT,
    category TEXT,
    hit_frequency TEXT,
    solutions JSONB,
    common_pitfalls TEXT,
    created_at TIMESTAMPTZ,
    updated_at TIMESTAMPTZ,
    view_count INTEGER,
    command_copy_count INTEGER,
    repeat_search_rate REAL,
    success_rate REAL,
    search_rank REAL
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        ke.id,
        ke.query,
        ke.category,
        ke.hit_frequency,
        ke.solutions,
        ke.common_pitfalls,
        ke.created_at,
        ke.updated_at,
        ke.view_count,
        ke.command_copy_count,
        ke.repeat_search_rate,
        ke.success_rate,
        ts_rank(
            to_tsvector('english', ke.query || ' ' || COALESCE(ke.common_pitfalls, '') || ' ' || ke.category),
            plainto_tsquery('english', search_query)
        ) as search_rank
    FROM knowledge_entries ke
    WHERE to_tsvector('english', ke.query || ' ' || COALESCE(ke.common_pitfalls, '') || ' ' || ke.category)
          @@ plainto_tsquery('english', search_query)
    ORDER BY
        search_rank DESC,
        ke.success_rate DESC NULLS LAST,
        ke.view_count DESC
    LIMIT result_limit;
END;
$$ LANGUAGE plpgsql;

-- Increment command copy count
CREATE OR REPLACE FUNCTION increment_command_copy(solution_query_text TEXT)
RETURNS VOID AS $$
BEGIN
    UPDATE knowledge_entries
    SET command_copy_count = command_copy_count + 1
    WHERE query = solution_query_text;
END;
$$ LANGUAGE plpgsql;

-- Update timestamp trigger
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_knowledge_entries_updated_at
BEFORE UPDATE ON knowledge_entries
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- Reset daily query counts
CREATE OR REPLACE FUNCTION reset_daily_query_counts()
RETURNS VOID AS $$
BEGIN
    UPDATE user_usage
    SET
        queries_today = 0,
        last_reset_at = NOW()
    WHERE last_reset_at < NOW() - INTERVAL '1 day';
END;
$$ LANGUAGE plpgsql;

-- ============================================================================
-- Row Level Security (RLS) Policies
-- ============================================================================

-- Enable RLS on all tables
ALTER TABLE knowledge_entries ENABLE ROW LEVEL SECURITY;
ALTER TABLE pending_contributions ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_usage ENABLE ROW LEVEL SECURITY;

-- Knowledge entries: Public read access
CREATE POLICY "Public read access"
ON knowledge_entries
FOR SELECT
USING (true);

-- Pending contributions: Users can insert their own
CREATE POLICY "Users can submit contributions"
ON pending_contributions
FOR INSERT
WITH CHECK (auth.uid() IS NOT NULL);

-- Pending contributions: Users can read their own
CREATE POLICY "Users can read own contributions"
ON pending_contributions
FOR SELECT
USING (contributor_email = auth.email());

-- User usage: Users can read/update their own
CREATE POLICY "Users manage own usage"
ON user_usage
FOR ALL
USING (user_id = auth.uid());

-- ============================================================================
-- Helper Functions for Rate Limiting
-- ============================================================================

-- Check and increment user query count
CREATE OR REPLACE FUNCTION check_rate_limit(p_user_id UUID)
RETURNS BOOLEAN AS $$
DECLARE
    v_queries_today INTEGER;
    v_queries_limit INTEGER;
    v_last_reset TIMESTAMPTZ;
BEGIN
    -- Get user's current usage
    SELECT queries_today, queries_limit, last_reset_at
    INTO v_queries_today, v_queries_limit, v_last_reset
    FROM user_usage
    WHERE user_id = p_user_id;

    -- If user doesn't exist, create record
    IF NOT FOUND THEN
        INSERT INTO user_usage (user_id, queries_today, queries_limit)
        VALUES (p_user_id, 1, 100)
        RETURNING queries_today, queries_limit INTO v_queries_today, v_queries_limit;
        RETURN TRUE;
    END IF;

    -- Reset if it's a new day
    IF v_last_reset < NOW() - INTERVAL '1 day' THEN
        UPDATE user_usage
        SET queries_today = 1, last_reset_at = NOW()
        WHERE user_id = p_user_id;
        RETURN TRUE;
    END IF;

    -- Check if under limit
    IF v_queries_today >= v_queries_limit THEN
        RETURN FALSE;
    END IF;

    -- Increment count
    UPDATE user_usage
    SET queries_today = queries_today + 1
    WHERE user_id = p_user_id;

    RETURN TRUE;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================================================
-- Initial Data Setup
-- ============================================================================

-- Create a function to easily add entries with prerequisites and indicators
CREATE OR REPLACE FUNCTION add_knowledge_entry(
    p_query TEXT,
    p_category TEXT,
    p_solutions JSONB,
    p_prerequisites TEXT[],
    p_success_indicators TEXT[],
    p_common_pitfalls TEXT DEFAULT '',
    p_hit_frequency TEXT DEFAULT 'MEDIUM',
    p_success_rate REAL DEFAULT NULL
)
RETURNS BIGINT AS $$
DECLARE
    v_entry_id BIGINT;
    v_prereq TEXT;
    v_indicator TEXT;
BEGIN
    -- Insert main entry
    INSERT INTO knowledge_entries (
        query, category, solutions, common_pitfalls,
        hit_frequency, success_rate
    ) VALUES (
        p_query, p_category, p_solutions, p_common_pitfalls,
        p_hit_frequency, p_success_rate
    ) RETURNING id INTO v_entry_id;

    -- Insert prerequisites
    FOREACH v_prereq IN ARRAY p_prerequisites
    LOOP
        INSERT INTO prerequisites (entry_id, prerequisite)
        VALUES (v_entry_id, v_prereq);
    END LOOP;

    -- Insert success indicators
    FOREACH v_indicator IN ARRAY p_success_indicators
    LOOP
        INSERT INTO success_indicators (entry_id, indicator)
        VALUES (v_entry_id, v_indicator);
    END LOOP;

    RETURN v_entry_id;
END;
$$ LANGUAGE plpgsql;

-- ============================================================================
-- Scheduled Jobs (using pg_cron extension if available)
-- ============================================================================

-- Reset query counts daily at midnight UTC
-- Run this manually or set up via Supabase dashboard:
-- SELECT cron.schedule('reset-query-counts', '0 0 * * *', 'SELECT reset_daily_query_counts()');

-- ============================================================================
-- Grants for Edge Functions
-- ============================================================================

-- Grant necessary permissions to service role
GRANT USAGE ON SCHEMA public TO service_role;
GRANT ALL ON ALL TABLES IN SCHEMA public TO service_role;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO service_role;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO service_role;
