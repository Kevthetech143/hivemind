-- Multi-category search for ambiguous queries
-- When query matches 3+ categories without a technology anchor,
-- returns top result from each category instead of single top result

-- Function to detect if a query is ambiguous (matches multiple tech contexts)
CREATE OR REPLACE FUNCTION detect_query_ambiguity(search_query TEXT)
RETURNS TABLE (
    is_ambiguous BOOLEAN,
    category_count INTEGER,
    has_anchor BOOLEAN
) AS $$
DECLARE
    v_anchors TEXT[] := ARRAY[
        'python', 'rust', 'go', 'golang', 'java', 'javascript', 'typescript', 'node', 'nodejs',
        'react', 'vue', 'svelte', 'angular', 'nextjs', 'nuxt',
        'docker', 'kubernetes', 'k8s', 'aws', 'gcp', 'azure',
        'postgres', 'postgresql', 'mysql', 'mongodb', 'redis', 'supabase',
        'playwright', 'mcp', 'claude', 'anthropic',
        'rails', 'django', 'flask', 'express', 'fastapi',
        'ios', 'android', 'swift', 'kotlin', 'flutter', 'dart'
    ];
    v_has_anchor BOOLEAN := FALSE;
    v_cat_count INTEGER;
BEGIN
    -- Check for technology anchor in query
    FOR i IN 1..array_length(v_anchors, 1) LOOP
        IF search_query ILIKE '%' || v_anchors[i] || '%' THEN
            v_has_anchor := TRUE;
            EXIT;
        END IF;
    END LOOP;

    -- Count distinct categories in top 20 matching results
    SELECT COUNT(DISTINCT category) INTO v_cat_count
    FROM (
        SELECT category FROM knowledge_entries
        WHERE to_tsvector('english', query || ' ' || COALESCE(common_pitfalls, ''))
              @@ plainto_tsquery('english', search_query)
        LIMIT 20
    ) sub;

    -- Ambiguous if: no tech anchor AND 3+ categories match
    RETURN QUERY SELECT
        (NOT v_has_anchor AND COALESCE(v_cat_count, 0) >= 3),
        COALESCE(v_cat_count, 0),
        v_has_anchor;
END;
$$ LANGUAGE plpgsql;

-- Function to search and return top result per category
CREATE OR REPLACE FUNCTION search_knowledge_multicategory(
    search_query TEXT,
    max_categories INTEGER DEFAULT 5
)
RETURNS TABLE (
    id BIGINT,
    query TEXT,
    category TEXT,
    solutions JSONB,
    common_pitfalls TEXT,
    search_rank REAL
) AS $$
WITH ranked AS (
    SELECT
        ke.id,
        ke.query,
        ke.category,
        ke.solutions,
        ke.common_pitfalls,
        ts_rank_cd(
            setweight(to_tsvector('english', ke.query), 'A') ||
            setweight(to_tsvector('english', COALESCE(ke.common_pitfalls, '')), 'B'),
            plainto_tsquery('english', search_query)
        ) as search_rank,
        ROW_NUMBER() OVER (
            PARTITION BY ke.category
            ORDER BY ts_rank_cd(
                setweight(to_tsvector('english', ke.query), 'A') ||
                setweight(to_tsvector('english', COALESCE(ke.common_pitfalls, '')), 'B'),
                plainto_tsquery('english', search_query)
            ) DESC
        ) as cat_rank
    FROM knowledge_entries ke
    WHERE to_tsvector('english', ke.query || ' ' || COALESCE(ke.common_pitfalls, ''))
          @@ plainto_tsquery('english', search_query)
),
top_cats AS (
    SELECT category, MAX(search_rank) as best_score
    FROM ranked
    WHERE cat_rank = 1
    GROUP BY category
    ORDER BY best_score DESC
    LIMIT max_categories
)
SELECT
    r.id,
    r.query,
    r.category,
    r.solutions,
    r.common_pitfalls,
    r.search_rank
FROM ranked r
JOIN top_cats t ON r.category = t.category
WHERE r.cat_rank = 1
ORDER BY r.search_rank DESC;
$$ LANGUAGE sql;

-- Test the functions
DO $$
DECLARE
    v_result RECORD;
BEGIN
    -- Test ambiguity detection
    SELECT * INTO v_result FROM detect_query_ambiguity('memory leak');
    RAISE NOTICE 'Query "memory leak": is_ambiguous=%, category_count=%, has_anchor=%',
        v_result.is_ambiguous, v_result.category_count, v_result.has_anchor;

    SELECT * INTO v_result FROM detect_query_ambiguity('python memory leak');
    RAISE NOTICE 'Query "python memory leak": is_ambiguous=%, category_count=%, has_anchor=%',
        v_result.is_ambiguous, v_result.category_count, v_result.has_anchor;

    SELECT * INTO v_result FROM detect_query_ambiguity('docker container not starting');
    RAISE NOTICE 'Query "docker container not starting": is_ambiguous=%, category_count=%, has_anchor=%',
        v_result.is_ambiguous, v_result.category_count, v_result.has_anchor;
END $$;
