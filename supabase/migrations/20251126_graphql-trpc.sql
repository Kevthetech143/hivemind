INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES
(
    'Apollo Client cache not updating after mutation - mutation creates or deletes entities',
    'graphql-trpc',
    'HIGH',
    '[
        {"solution": "Add update function to mutation to manually update cache with writeQuery", "percentage": 95},
        {"solution": "Use refetchQueries to force re-fetch after mutation completes", "percentage": 85}
    ]'::jsonb,
    'Apollo Client configured with cache, mutation returning transaction data',
    'Apollo DevTools shows ROOT_QUERY.transactions includes new items, React component receives updated data from GetTransactions query',
    'Assuming Apollo auto-updates all mutations - it only knows requested fields, not server-side business logic',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/60360260/auto-update-of-apollo-client-cache-after-mutation-not-affecting-existing-queries',
    'admin:1764173598'
),
(
    'GraphQL subscription WebSocket won''t reconnect after internet drops - closed callback never triggers',
    'graphql-trpc',
    'HIGH',
    '[
        {"solution": "Implement keepAlive mechanism with ping/pong handlers and set retryAttempts: Infinity", "percentage": 96},
        {"solution": "Add timeout handler to detect unresponsive connections and force close stale sockets", "percentage": 90}
    ]'::jsonb,
    'GraphQL WebSocket client configuration, ability to modify connection handlers',
    'Console logs show CONNECTED status after network interruptions, subscriptions resume without manual intervention',
    'Assuming client will auto-detect closed connections - keepAlive is required to trigger reconnection detection',
    0.96,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/74758892/websocket-wont-reconnect-after-dropped-internet',
    'admin:1764173598'
),
(
    'tRPC no query procedure on path error - TRPC_NOT_FOUND when batching requests via proxy',
    'graphql-trpc',
    'MEDIUM',
    '[
        {"solution": "Dynamically set endpoint in tRPC handler based on actual request pathname from reverse proxy", "percentage": 92},
        {"solution": "Configure reverse proxy to preserve original path via ProxyPreserveHost directive", "percentage": 88}
    ]'::jsonb,
    'tRPC server behind Apache reverse proxy with ProxyPass, access to request pathname',
    'Batch requests like user.getAll,user.getCurrentUser all resolve successfully without 404 errors',
    'Assuming proxy passes correct pathname - reverse proxies rewrite paths causing tRPC to misdirects procedure lookup',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/77881922/trpc-no-query-procedure-on-path-r-getall-but-exists-edit-is-ignoring-first-3',
    'admin:1764173598'
),
(
    'GraphQL field argument is required but not provided - missing required argument in query',
    'graphql-trpc',
    'HIGH',
    '[
        {"solution": "Provide all required arguments marked with exclamation mark in schema when querying field", "percentage": 97},
        {"solution": "For list queries use plural query name (products instead of product) if single-ID queries aren''t needed", "percentage": 85}
    ]'::jsonb,
    'GraphQL schema with field arguments, knowledge of schema requirements',
    'Query resolves successfully and returns expected data with all arguments supplied',
    'Confusing singular vs plural queries - not all fields have list alternatives, check API documentation',
    0.97,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/69465830/graphql-query-error-message-argument-is-required-but-it-was-not-provided',
    'admin:1764173598'
),
(
    'tRPC middleware throws error but next() doesn''t propagate - UNAUTHORIZED handling in middleware',
    'graphql-trpc',
    'MEDIUM',
    '[
        {"solution": "Check resp.ok boolean property and access resp.error.cause instead of expecting thrown exceptions", "percentage": 94},
        {"solution": "Rethrow caught errors as TRPCError with appropriate code in middleware return statement", "percentage": 92}
    ]'::jsonb,
    'tRPC middleware function, access to protected procedure, error causing service (e.g. Google API)',
    'Middleware catches authorization errors and throws TRPCError with UNAUTHORIZED code to client',
    'Expecting await next() to throw exceptions - it returns object with ok/error properties instead',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/77489779/how-to-catch-errors-inside-trpc-middleware-thrown-in-trpc-procedures',
    'admin:1764173598'
),
(
    'GraphQL query returns null for fields with data - resolver returning undefined instead of data',
    'graphql-trpc',
    'HIGH',
    '[
        {"solution": "Ensure resolver returns Promise and extracts data from wrapped response objects before returning", "percentage": 96},
        {"solution": "Use array indexing [0] or findOne() if resolver calls method returning array instead of single object", "percentage": 91},
        {"solution": "Add explicit return statement in resolver to avoid untracked Promises resolving to undefined", "percentage": 94}
    ]'::jsonb,
    'GraphQL schema defining field return types, resolver implementation, API returning nested data',
    'Query returns expected data with all fields populated, server logs show correct data being returned',
    'Assuming implicit returns work in resolvers - missing return statements cause untracked Promises, nested responses need unwrapping',
    0.95,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/56319137/why-does-a-graphql-query-return-null',
    'admin:1764173598'
),
(
    'tRPC authentication redirect in middleware not working - can''t redirect directly from middleware',
    'graphql-trpc',
    'MEDIUM',
    '[
        {"solution": "Throw TRPCError with UNAUTHORIZED code in middleware, handle error on client with router.push redirect", "percentage": 93},
        {"solution": "Use Next.js getServerSideProps to check authentication and redirect before page loads", "percentage": 90},
        {"solution": "Implement Next.js middleware at routing layer to intercept requests before tRPC handler", "percentage": 89}
    ]'::jsonb,
    'tRPC middleware function, Next.js client or server component, error handler or getServerSideProps',
    'Unauthenticated users are redirected to login page, authenticated users proceed to protected procedures',
    'Expecting direct HTTP header manipulation in middleware - middleware can only throw errors and modify context',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/75169481/create-t3-app-redirect-inside-a-trpc-middleware-if-user-is-not-signed',
    'admin:1764173598'
),
(
    'TRPCClientError unexpected token DOCTYPE not valid JSON - tRPC receiving HTML error page instead of JSON',
    'graphql-trpc',
    'MEDIUM',
    '[
        {"solution": "Use VITE_ prefix for environment variables in Vite projects and update frontend imports to import.meta.env.VITE_API_URL", "percentage": 97},
        {"solution": "Verify tRPC httpBatchLink endpoint URL is correctly set and API server is responding with JSON", "percentage": 94},
        {"solution": "Check API_URL environment variable is properly passed and not undefined in frontend build", "percentage": 96}
    ]'::jsonb,
    'Vite frontend with tRPC client, SST or similar infrastructure defining environment variables, tRPC endpoint configuration',
    'API requests resolve successfully returning valid JSON, TRPCClientError with DOCTYPE messages disappears',
    'Using REACT_APP_ prefix in Vite projects - Vite requires VITE_ prefix, undefined URLs cause fallback to HTML error responses',
    0.96,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/75350658/getting-trpcclienterror-unexpected-token-doctype-is-not-valid-json',
    'admin:1764173598'
);
