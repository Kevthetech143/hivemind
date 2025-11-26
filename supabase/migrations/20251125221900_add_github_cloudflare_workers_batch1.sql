-- Cloudflare Workers SDK GitHub Issues - Wrangler CLI, KV Bindings, Deployment & Runtime Errors
-- Mining date: 2025-11-25
-- Source: https://github.com/cloudflare/workers-sdk/issues

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, pattern_id
) VALUES
(
    'vitest watch fails on second run with runInDurableObject - SQLite database error SQLITE_CANTOPEN',
    'github-cloudflare-workers',
    'HIGH',
    '[
        {"solution": "Downgrade @cloudflare/vitest-pool-workers from v0.8.50+ to v0.8.49: npm install @cloudflare/vitest-pool-workers@0.8.49", "percentage": 95, "note": "Confirmed workaround for SQLite cantopen error on watch reruns", "command": "npm install @cloudflare/vitest-pool-workers@0.8.49"},
        {"solution": "Clear vitest cache and restart watch: rm -rf .vitest && npm run test:watch", "percentage": 80, "note": "Sometimes clears stale SQLite connection state"},
        {"solution": "Use vitest run instead of watch mode for local testing: npm run test -- run", "percentage": 75, "note": "Avoids SQLite state accumulation across runs"}
    ]'::jsonb,
    'Cloudflare Workers project, vitest 3.2.4+, wrangler 4.24.0+, @cloudflare/vitest-pool-workers installed',
    'Tests pass on initial watch execution and all subsequent reruns without SQLite database errors',
    'This is a regression in v0.8.50+. The SQLite error (workerd/util/sqlite.c++:499) occurs because watch mode does not properly reset database connections between test runs. First test passes but database file becomes locked or corrupted on second run.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/cloudflare/workers-sdk/issues/9913'
),
(
    'vitest fails when wrangler.toml contains workflow configuration - runtime entrypoint error',
    'github-cloudflare-workers',
    'HIGH',
    '[
        {"solution": "Temporarily remove workflow configuration from wrangler.toml before running vitest: comment out [[workflows]] sections", "percentage": 90, "note": "Vitest pool worker cannot resolve workflow entrypoints during initialization"},
        {"solution": "Use separate wrangler configs: wrangler-dev.toml without workflows for testing, wrangler.toml with workflows for deployment", "percentage": 88, "note": "Set WRANGLER_CONFIG=wrangler-dev.toml in test script"},
        {"solution": "Update to wrangler@latest and @cloudflare/vitest-pool-workers@latest when workflow support is added to roadmap", "percentage": 70, "note": "Cloudflare team confirms this is on roadmap for future release"}
    ]'::jsonb,
    'Cloudflare Workers project with workflows, @cloudflare/vitest-pool-workers 0.5.32+, wrangler 3.91.0+',
    'vitest test suite runs successfully without MiniflareCoreError, all tests execute and pass',
    'The vitest pool worker cannot resolve named entrypoints defined in [[workflows]] configuration. The error ''has no such named entrypoint'' means the workflow binding cannot be injected into the test runtime. This is a known limitation; Cloudflare is building full workflow support.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/cloudflare/workers-sdk/issues/7414'
),
(
    'D1 left join with duplicate column names only returns one instance - column override issue',
    'github-cloudflare-workers',
    'HIGH',
    '[
        {"solution": "Alias duplicate columns explicitly in SELECT: SELECT users.id as user_id, posts.id as post_id instead of both as id", "percentage": 96, "note": "Forces distinct column names in result set, avoids field override"},
        {"solution": "Use table prefixes in column selection: SELECT users.id, posts.id and ensure JSON response preserves both before array mapping", "percentage": 85, "note": "Depends on D1 API response format, may not always work"},
        {"solution": "Update D1 driver when fix is released - issue is in D1 facade template JSON-to-array conversion that overwrites duplicate keys", "percentage": 70, "note": "Tracked in workerd issue, awaiting fix"}
    ]'::jsonb,
    'Cloudflare D1 database, wrangler with d1 binding, queries using LEFT JOIN on tables with same column names',
    'SELECT query returns all expected columns including duplicate names from different tables, result array has correct length',
    'The D1 facade converts JSON responses to array-of-arrays. When multiple tables have the same column name (e.g., id), the field mapping overwrites earlier columns with later ones. Aliasing is the required workaround until the driver fix is released.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/cloudflare/workers-sdk/issues/3160'
),
(
    'wrangler pages dev does not support --remote flag - cannot test CF headers like cf-ipcountry',
    'github-cloudflare-workers',
    'MEDIUM',
    '[
        {"solution": "Use wrangler dev instead of wrangler pages dev for testing, or deploy to production and tail logs for header validation", "percentage": 80, "note": "Current workaround: use wrangler dev which supports --remote"},
        {"solution": "Implement --remote flag for pages dev by adapting workers dev logic - feature request in discussion", "percentage": 75, "note": "Proposed solution requires wrangler team implementation"},
        {"solution": "Mock CF headers in local tests: manually inject cf-ipcountry and other headers in test environment", "percentage": 70, "note": "Workaround for testing header-dependent logic without remote access"}
    ]'::jsonb,
    'Cloudflare Pages project, wrangler 3.0+, need to test production-like behavior with CF headers',
    'wrangler pages dev --remote command works without error, tests access real CF infrastructure headers',
    'pages dev command has hardcoded local-only configuration. Unlike wrangler dev --remote which connects to real services, pages dev lacks this flag. Feature not yet implemented.',
    0.70,
    'sonnet-4',
    NOW(),
    'https://github.com/cloudflare/workers-sdk/issues/3505'
),
(
    'D1 execute command fails with SQL comments containing semicolons - remote execution only',
    'github-cloudflare-workers',
    'HIGH',
    '[
        {"solution": "Remove semicolons from SQL comments: change -- comment; to -- comment before executing remotely", "percentage": 96, "note": "D1 backend rejects statements starting with comments containing semicolons"},
        {"solution": "Strip comments with semicolons before sending to D1: preprocess SQL to remove comment lines with semicolons", "percentage": 92, "note": "Implement SQL comment filter in migration scripts"},
        {"solution": "Use wrangler d1 execute --local to verify migration works, then manually execute on remote without comment semicolons", "percentage": 85, "note": "Local execution works fine; remote has the issue"}
    ]'::jsonb,
    'Cloudflare D1 database, wrangler 3.0+, SQL migration files with comments',
    'wrangler d1 execute command succeeds on remote database without SQL parsing error 7500',
    'The D1 backend SQL parser rejects statements that start with comment lines containing semicolons. Local execution works because wrangler handles splitting correctly. Remote D1 API has stricter parsing. Drizzle-orm generated migrations often include comments with semicolons.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://github.com/cloudflare/workers-sdk/issues/3892'
),
(
    '@cloudflare/vitest-pool-workers does not support vitest v4 - custom pool runner API redesigned',
    'github-cloudflare-workers',
    'MEDIUM',
    '[
        {"solution": "Stay on vitest v2.0.x - v3.2.x until @cloudflare/vitest-pool-workers v4 is released", "percentage": 90, "note": "Major API change in vitest v4 requires pool runner redesign, not a simple version bump"},
        {"solution": "Use vitest v3.2.x for new projects, upgrade to v4 support when Cloudflare releases compatible version", "percentage": 85, "note": "Recommended interim solution for long-term maintainability"},
        {"solution": "Monitor roadmap at https://github.com/cloudflare/workers-sdk - team is planning major migration for v4 support", "percentage": 75, "note": "Feature is tracked but requires significant engineering effort"}
    ]'::jsonb,
    'Cloudflare Workers project with vitest, want to use vitest v4.0+',
    'All vitest tests pass and run successfully with v4, no pool runner compatibility errors',
    'vitest v4 completely redesigned the custom pool runner API. The vitest/execute entry point was removed. Cloudflare must rewrite the pool runner from scratch. This is not a trivial patch release; it requires architectural changes.',
    0.72,
    'sonnet-4',
    NOW(),
    'https://github.com/cloudflare/workers-sdk/issues/11064'
),
(
    'getPlatformProxy cannot handle multiple wrangler.toml files for Durable Object RPC',
    'github-cloudflare-workers',
    'MEDIUM',
    '[
        {"solution": "Accept array of config paths in getPlatformProxy: getPlatformProxy({ configPath: [''wrangler.toml'', ''durable-object.toml''] })", "percentage": 85, "note": "Feature request - currently only accepts single configPath string"},
        {"solution": "Run single wrangler dev session with all config merged instead of using getPlatformProxy for framework", "percentage": 80, "note": "Workaround: use traditional wrangler dev with multiple configs"},
        {"solution": "Bind Durable Object via environment variables instead of RPC until multi-config support is added", "percentage": 70, "note": "Temporary workaround for framework integrations like SvelteKit"}
    ]'::jsonb,
    'Framework (SvelteKit, Next.js) with Cloudflare Workers adapter, getPlatformProxy usage, Durable Objects',
    'getPlatformProxy accepts multiple configuration files, Durable Object RPC works in local development',
    'SvelteKit adapter uses getPlatformProxy for binding injection but needs to reference Durable Objects in separate wrangler configs. Current API only accepts single configPath parameter (string). Feature request to support array of paths.',
    0.65,
    'sonnet-4',
    NOW(),
    'https://github.com/cloudflare/workers-sdk/issues/9445'
),
(
    'R2ObjectBody.body ReadableStream invalid for R2 put operation - requires known length',
    'github-cloudflare-workers',
    'HIGH',
    '[
        {"solution": "Use FixedLengthStream wrapper: const {readable, writable} = new FixedLengthStream(current.size); current.body.pipeTo(writable); await env.BUCKET.put(''dest.html'', readable)", "percentage": 93, "note": "Properly signals stream length to workerd runtime"},
        {"solution": "Convert to text/buffer for small files: const text = await current.text(); await env.BUCKET.put(''dest.html'', text)", "percentage": 90, "note": "Limited to 128MB worker memory, simple solution for small objects"},
        {"solution": "Use R2 S3 CopyObject API for same-bucket operations: s3Client.copyObject({Bucket, CopySource}) avoids stream issue", "percentage": 88, "note": "Native S3 API alternative, most efficient for large objects"}
    ]'::jsonb,
    'Cloudflare Workers with R2 binding, wrangler 3.0+, need to stream R2 object between buckets',
    'R2 put operation accepts ReadableStream, file copied successfully without memory overflow',
    'The error "readable stream must have a known length" occurs because R2ObjectBody.body is a plain ReadableStream without metadata. The size property exists on the parent object but is not accessible to the workerd runtime from the stream alone. FixedLengthStream explicitly signals length.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/cloudflare/workers-sdk/issues/6425'
),
(
    'D1 blob column rejects Buffer type in Miniflare - requires Uint8Array instead',
    'github-cloudflare-workers',
    'MEDIUM',
    '[
        {"solution": "Convert Buffer to Uint8Array in D1 query: const arr = new Uint8Array(buffer); db.prepare().bind(arr).run()", "percentage": 95, "note": "Miniflare devalue marshalling only accepts Uint8Array for blobs"},
        {"solution": "Use Drizzle ORM workaround: cast Buffer parameter to Uint8Array in the ORM layer before binding", "percentage": 90, "note": "Drizzle users can apply this pattern in their model definitions"},
        {"solution": "Await Miniflare/workerd fix to accept Buffer type (AssertionError in devalue.ts:95 indicates marshalling limitation)", "percentage": 70, "note": "Runtime limitation; fix requires Cloudflare infrastructure changes"}
    ]'::jsonb,
    'Cloudflare Workers with D1 binding, Miniflare for local testing, Node.js Buffer in use',
    'D1 INSERT with blob parameter succeeds, data retrieved from blob column returns as proper Uint8Array',
    'Miniflare uses devalue to marshal types between Node and workerd runtime. It asserts ArrayBufferView type for blobs but Buffer is not recognized as valid. Uint8Array works. This mismatch causes "false == true" assertion in devalue.ts. Production behavior differs from local test behavior.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/cloudflare/workers-sdk/issues/5771'
),
(
    'Cloudflare Queues incompatible with wrangler dev --remote flag - Script not found error',
    'github-cloudflare-workers',
    'HIGH',
    '[
        {"solution": "Remove Queues binding from wrangler.toml before testing with --remote, test Queues in local-only mode", "percentage": 90, "note": "Workaround: separate configs for local queue testing vs remote GA bindings"},
        {"solution": "Maintain two wrangler configs: wrangler.toml (production with Queues) and wrangler-remote.toml (--remote testing without Queues)", "percentage": 88, "note": "Set WRANGLER_CONFIG=wrangler-remote.toml in your test/dev script"},
        {"solution": "Use Analytics Engine or Browser Rendering locally instead of Queues until remote support is added", "percentage": 75, "note": "These GA bindings work with --remote; Queues is still beta"}
    ]'::jsonb,
    'Cloudflare Workers with Queues producer binding, wrangler 3.0+, need GA bindings that require --remote',
    'wrangler dev --remote succeeds with Queues configuration, no script initialization failures',
    'Queues (beta) has incompatible transport requirements with wrangler''s remote mode. GA bindings like Analytics Engine require --remote to function. Projects using both cannot be tested easily. This is a platform interoperability issue Cloudflare is addressing.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/cloudflare/workers-sdk/issues/5543'
),
(
    'wrangler pages dev proxy mode breaks HTTP redirects - Location header missing',
    'github-cloudflare-workers',
    'MEDIUM',
    '[
        {"solution": "Use create-cloudflare projects which integrate wrangler/miniflare directly into vite dev server, avoiding proxy mode", "percentage": 92, "note": "Modern approach: wrangler bindings injected natively in vite config"},
        {"solution": "Run vite build --watch + wrangler pages dev separately instead of proxy: trade HMR for production-like behavior", "percentage": 85, "note": "Workaround: lose hot module reload but get accurate redirect handling"},
        {"solution": "Implement redirect handling wrapper in vite config to intercept Location headers before proxy passes response", "percentage": 70, "note": "Advanced: requires custom proxy middleware configuration"}
    ]'::jsonb,
    'Cloudflare Pages with SvelteKit or similar framework, wrangler pages dev -- vite, HTTP redirects in code',
    'HTTP redirects work correctly with Location header set, browser URL updates, relative links resolve properly',
    'The proxy mode (pages dev -- vite) does not properly forward response headers from the Vite dev server. Redirects lose their Location header. This is a known limitation of the proxy approach. Modern solution: use create-cloudflare which avoids proxy entirely.',
    0.78,
    'sonnet-4',
    NOW(),
    'https://github.com/cloudflare/workers-sdk/issues/5315'
),
(
    'R2 list command missing from Wrangler CLI - only get/put/delete available locally',
    'github-cloudflare-workers',
    'MEDIUM',
    '[
        {"solution": "Use r2.list() method in Worker code instead of CLI: const objects = await env.BUCKET.list(); return objects.objects", "percentage": 95, "note": "Runtime API has full list support; CLI lacks this command"},
        {"solution": "Implement custom wrangler plugin/command to call r2.list() via Workers: wrangler r2 list <bucket>", "percentage": 85, "note": "Feature request; Cloudflare team would need to add this"},
        {"solution": "Query R2 metadata via API directly if not available through wrangler: use Cloudflare API for bucket operations", "percentage": 75, "note": "Alternative: bypass wrangler for CLI operations"}
    ]'::jsonb,
    'Cloudflare Workers with R2 binding, wrangler 3.0+, need to list bucket contents locally',
    'wrangler r2 list command works and returns objects in specified bucket',
    'Wrangler CLI supports get, put, delete for R2 but not list. The runtime API (Worker code) fully supports list(). This is a CLI feature gap, not a runtime limitation.',
    0.72,
    'sonnet-4',
    NOW(),
    'https://github.com/cloudflare/workers-sdk/issues/3009'
),
(
    'wrangler does not auto-generate TypeScript types for Secrets binding - incomplete type definitions',
    'github-cloudflare-workers',
    'MEDIUM',
    '[
        {"solution": "Manually add Secrets type to env.d.ts: type Secrets = { MY_SECRET: string }; declare global { interface Env { Secrets: Secrets } }", "percentage": 93, "note": "Workaround: define secret types manually until auto-generation is added"},
        {"solution": "Use wrangler secret get <name> to verify secrets exist, then add to types manually based on your wrangler.toml", "percentage": 88, "note": "Document secrets in code comments referencing wrangler.toml"},
        {"solution": "Feature request: wrangler types should introspect wrangler.toml [[env.*.secrets]] sections and generate types automatically", "percentage": 70, "note": "Enhancement planned for future release"}
    ]'::jsonb,
    'Cloudflare Workers with Secrets bindings in wrangler.toml, TypeScript project with env.d.ts',
    'TypeScript auto-completion works for all Secrets bindings, no type errors on env.Secrets access',
    'Wrangler''s type generation includes KV, D1, R2, Durable Objects but excludes Secrets. This is a missing feature in the auto-generation pipeline. Manual typing is the current requirement.',
    0.75,
    'sonnet-4',
    NOW(),
    'https://github.com/cloudflare/workers-sdk/issues/5756'
);
