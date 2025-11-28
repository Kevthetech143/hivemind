-- Tech-keyword filter to reduce false positives
-- When query contains a specific technology keyword, penalize results
-- from categories that don't match that technology

-- Comprehensive tech keywords lookup table
CREATE TABLE IF NOT EXISTS tech_keywords (
    keyword TEXT PRIMARY KEY,
    category_patterns TEXT[] NOT NULL  -- Categories that should match this keyword
);

-- Populate with tech keywords and their expected category patterns
INSERT INTO tech_keywords (keyword, category_patterns) VALUES
    -- Languages
    ('python', ARRAY['python', 'django', 'flask', 'fastapi', 'pip']),
    ('javascript', ARRAY['javascript', 'js', 'nodejs', 'node', 'npm', 'react', 'vue', 'svelte', 'angular']),
    ('typescript', ARRAY['typescript', 'ts', 'nodejs', 'node']),
    ('rust', ARRAY['rust', 'cargo']),
    ('go', ARRAY['go', 'golang']),
    ('golang', ARRAY['go', 'golang']),
    ('java', ARRAY['java', 'spring', 'maven', 'gradle']),
    ('ruby', ARRAY['ruby', 'rails', 'gem']),
    ('php', ARRAY['php', 'laravel', 'composer', 'symfony']),
    ('swift', ARRAY['swift', 'ios', 'xcode']),
    ('kotlin', ARRAY['kotlin', 'android']),
    ('dart', ARRAY['dart', 'flutter']),
    ('csharp', ARRAY['csharp', 'dotnet', '.net', 'asp']),
    ('c#', ARRAY['csharp', 'dotnet', '.net', 'asp']),

    -- Frontend frameworks
    ('react', ARRAY['react', 'reactjs', 'nextjs', 'next']),
    ('vue', ARRAY['vue', 'vuejs', 'nuxt']),
    ('svelte', ARRAY['svelte', 'sveltekit']),
    ('angular', ARRAY['angular', 'angularjs']),
    ('nextjs', ARRAY['next', 'nextjs', 'react']),
    ('next.js', ARRAY['next', 'nextjs', 'react']),
    ('nuxt', ARRAY['nuxt', 'nuxtjs', 'vue']),
    ('remix', ARRAY['remix', 'react']),
    ('astro', ARRAY['astro']),

    -- Backend frameworks
    ('express', ARRAY['express', 'nodejs', 'node']),
    ('fastify', ARRAY['fastify', 'nodejs', 'node']),
    ('django', ARRAY['django', 'python']),
    ('flask', ARRAY['flask', 'python']),
    ('fastapi', ARRAY['fastapi', 'python']),
    ('rails', ARRAY['rails', 'ruby']),
    ('laravel', ARRAY['laravel', 'php']),
    ('spring', ARRAY['spring', 'java']),

    -- Package managers / runtimes
    ('npm', ARRAY['npm', 'nodejs', 'node', 'javascript']),
    ('yarn', ARRAY['yarn', 'nodejs', 'node', 'javascript']),
    ('pnpm', ARRAY['pnpm', 'nodejs', 'node']),
    ('bun', ARRAY['bun']),
    ('pip', ARRAY['pip', 'python']),
    ('composer', ARRAY['composer', 'php']),
    ('cargo', ARRAY['cargo', 'rust']),
    ('gem', ARRAY['gem', 'ruby']),

    -- Databases
    ('postgres', ARRAY['postgres', 'postgresql', 'sql', 'supabase']),
    ('postgresql', ARRAY['postgres', 'postgresql', 'sql', 'supabase']),
    ('mysql', ARRAY['mysql', 'sql']),
    ('mongodb', ARRAY['mongodb', 'mongo']),
    ('redis', ARRAY['redis']),
    ('sqlite', ARRAY['sqlite', 'sql']),
    ('supabase', ARRAY['supabase', 'postgres']),
    ('prisma', ARRAY['prisma']),
    ('drizzle', ARRAY['drizzle']),
    ('typeorm', ARRAY['typeorm']),
    ('sequelize', ARRAY['sequelize']),

    -- DevOps / Cloud
    ('docker', ARRAY['docker', 'container']),
    ('kubernetes', ARRAY['kubernetes', 'k8s']),
    ('k8s', ARRAY['kubernetes', 'k8s']),
    ('aws', ARRAY['aws', 'amazon', 'lambda', 's3', 'ec2']),
    ('gcp', ARRAY['gcp', 'google', 'firebase']),
    ('azure', ARRAY['azure', 'microsoft']),
    ('vercel', ARRAY['vercel', 'next']),
    ('netlify', ARRAY['netlify']),
    ('heroku', ARRAY['heroku']),
    ('cloudflare', ARRAY['cloudflare', 'workers']),
    ('terraform', ARRAY['terraform', 'infrastructure']),
    ('ansible', ARRAY['ansible']),

    -- CI/CD
    ('github', ARRAY['github', 'gh', 'actions']),
    ('gitlab', ARRAY['gitlab']),
    ('circleci', ARRAY['circleci', 'circle']),
    ('jenkins', ARRAY['jenkins']),

    -- Testing
    ('jest', ARRAY['jest', 'testing']),
    ('vitest', ARRAY['vitest', 'testing']),
    ('mocha', ARRAY['mocha', 'testing']),
    ('cypress', ARRAY['cypress', 'testing', 'e2e']),
    ('playwright', ARRAY['playwright', 'testing', 'e2e']),

    -- Auth
    ('firebase', ARRAY['firebase', 'google', 'auth']),
    ('clerk', ARRAY['clerk', 'auth']),
    ('auth0', ARRAY['auth0', 'auth']),
    ('nextauth', ARRAY['nextauth', 'auth', 'next']),
    ('auth.js', ARRAY['authjs', 'auth', 'next']),

    -- AI/ML
    ('openai', ARRAY['openai', 'gpt', 'ai']),
    ('anthropic', ARRAY['anthropic', 'claude', 'ai']),
    ('langchain', ARRAY['langchain', 'ai', 'llm']),
    ('huggingface', ARRAY['huggingface', 'transformers', 'ai']),
    ('pinecone', ARRAY['pinecone', 'vector']),

    -- Build tools
    ('webpack', ARRAY['webpack', 'bundler']),
    ('vite', ARRAY['vite', 'bundler']),
    ('rollup', ARRAY['rollup', 'bundler']),
    ('esbuild', ARRAY['esbuild', 'bundler']),
    ('turbopack', ARRAY['turbopack', 'next']),
    ('babel', ARRAY['babel', 'transpiler']),

    -- UI Libraries
    ('tailwind', ARRAY['tailwind', 'css']),
    ('chakra', ARRAY['chakra', 'ui']),
    ('shadcn', ARRAY['shadcn', 'ui', 'radix']),
    ('radix', ARRAY['radix', 'ui']),
    ('mui', ARRAY['mui', 'material', 'ui']),

    -- Others
    ('graphql', ARRAY['graphql', 'apollo']),
    ('trpc', ARRAY['trpc']),
    ('socket.io', ARRAY['socket', 'websocket']),
    ('socketio', ARRAY['socket', 'websocket']),
    ('nginx', ARRAY['nginx', 'server']),
    ('apache', ARRAY['apache', 'server']),
    ('elasticsearch', ARRAY['elasticsearch', 'elastic']),
    ('kafka', ARRAY['kafka', 'streaming']),
    ('mcp', ARRAY['mcp', 'claude', 'anthropic']),
    ('electron', ARRAY['electron', 'desktop']),
    ('tauri', ARRAY['tauri', 'desktop']),
    ('three.js', ARRAY['threejs', 'webgl', '3d']),
    ('threejs', ARRAY['threejs', 'webgl', '3d'])
ON CONFLICT (keyword) DO UPDATE SET category_patterns = EXCLUDED.category_patterns;

-- Function to extract tech keyword from query
CREATE OR REPLACE FUNCTION extract_tech_keyword(search_query TEXT)
RETURNS TEXT AS $$
DECLARE
    v_keyword TEXT;
    v_query_lower TEXT := lower(search_query);
BEGIN
    -- Check for each keyword in descending length order (to match "next.js" before "next")
    SELECT keyword INTO v_keyword
    FROM tech_keywords
    WHERE v_query_lower LIKE '%' || keyword || '%'
    ORDER BY length(keyword) DESC
    LIMIT 1;

    RETURN v_keyword;
END;
$$ LANGUAGE plpgsql;

-- Function to check if category matches tech keyword
CREATE OR REPLACE FUNCTION category_matches_tech(
    p_category TEXT,
    p_tech_keyword TEXT
)
RETURNS BOOLEAN AS $$
DECLARE
    v_patterns TEXT[];
    v_pattern TEXT;
    v_cat_lower TEXT := lower(p_category);
BEGIN
    IF p_tech_keyword IS NULL THEN
        RETURN TRUE;  -- No tech keyword means no filtering
    END IF;

    SELECT category_patterns INTO v_patterns
    FROM tech_keywords
    WHERE keyword = p_tech_keyword;

    IF v_patterns IS NULL THEN
        RETURN TRUE;  -- Unknown keyword, don't filter
    END IF;

    -- Check if category contains any of the patterns
    FOREACH v_pattern IN ARRAY v_patterns
    LOOP
        IF v_cat_lower LIKE '%' || v_pattern || '%' THEN
            RETURN TRUE;
        END IF;
    END LOOP;

    RETURN FALSE;
END;
$$ LANGUAGE plpgsql;

-- Updated search function with tech-keyword filtering
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
DECLARE
    v_tech_keyword TEXT;
BEGIN
    -- Extract tech keyword from query
    v_tech_keyword := extract_tech_keyword(search_query);

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
        -- Apply penalty if tech keyword found but category doesn't match
        CASE
            WHEN v_tech_keyword IS NOT NULL
                 AND NOT category_matches_tech(ke.category, v_tech_keyword)
            THEN ts_rank(
                to_tsvector('english', ke.query || ' ' || COALESCE(ke.common_pitfalls, '') || ' ' || ke.category),
                plainto_tsquery('english', search_query)
            ) * 0.1  -- 90% penalty for category mismatch
            ELSE ts_rank(
                to_tsvector('english', ke.query || ' ' || COALESCE(ke.common_pitfalls, '') || ' ' || ke.category),
                plainto_tsquery('english', search_query)
            )
        END)::REAL as search_rank
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

-- Test the filter functions
DO $$
DECLARE
    v_tech TEXT;
    v_match BOOLEAN;
BEGIN
    -- Test keyword extraction
    v_tech := extract_tech_keyword('Python pip permission denied');
    RAISE NOTICE 'Extracted from "Python pip permission denied": %', v_tech;

    v_tech := extract_tech_keyword('Bun install package not found');
    RAISE NOTICE 'Extracted from "Bun install package not found": %', v_tech;

    v_tech := extract_tech_keyword('Cloudflare 522 connection timed out');
    RAISE NOTICE 'Extracted from "Cloudflare 522 connection timed out": %', v_tech;

    -- Test category matching
    v_match := category_matches_tech('nodejs', 'python');
    RAISE NOTICE 'Does "nodejs" match "python"? %', v_match;

    v_match := category_matches_tech('python', 'python');
    RAISE NOTICE 'Does "python" match "python"? %', v_match;

    v_match := category_matches_tech('composer', 'bun');
    RAISE NOTICE 'Does "composer" match "bun"? %', v_match;

    v_match := category_matches_tech('bun', 'bun');
    RAISE NOTICE 'Does "bun" match "bun"? %', v_match;
END $$;
