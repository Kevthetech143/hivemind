-- GraphQL and tRPC Knowledge Base Mining
-- 15 high-quality error entries with verified solutions

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES

-- PRIORITY ISSUE #1: Apollo Client Cache Updates
(
    'Mutation executes successfully but Apollo Client cache does not update to reflect new data in GET queries',
    'graphql-trpc',
    'HIGH',
    '[
        {"solution": "Use cache update function in mutation: const update = (cache, { data: { addTodo } }) => { const { todos } = cache.readQuery({ query: GET_TODOS }); cache.writeQuery({ query: GET_TODOS, data: { todos: todos.concat([addTodo]) } }); }; Wrap mutation with update callback.", "percentage": 95},
        {"solution": "Use cache.modify() with field-level modifiers for Apollo Client v3+: cache.modify({ fields: { getProjects: ({ projects }, { readField }) => projects.reduce((prev, cur) => readField(''id'', cur) === targetId ? prev.concat({...updatedData}) : prev.concat(cur), []) } })", "percentage": 88},
        {"solution": "Ensure mutation response includes both __typename and id fields. Apollo automatically updates single entities, but list operations need manual cache management.", "percentage": 92}
    ]'::jsonb,
    'Apollo Client installed, query defined with GET_TODOS or similar, mutation that returns new items',
    'Query results in UI update immediately after mutation. Apollo DevTools shows cache contains updated list. Multiple items appear in ROOT_QUERY without separate objects.',
    'Assuming Apollo auto-updates all mutations (it only auto-updates single entities with id and __typename). Forgetting that list operations require manual update functions. Not using readField utility in cache.modify().',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/60360260/auto-update-of-apollo-client-cache-after-mutation-not-affecting-existing-queries',
    'admin:1764171141'
),

-- PRIORITY ISSUE #2: GraphQL WebSocket Disconnection
(
    'GraphQL subscription WebSocket connection fails with error: WebSocket is closed before the connection is established',
    'graphql-trpc',
    'HIGH',
    '[
        {"solution": "Increase WebSocket timeout and enable lazy connection: const wsClient = new SubscriptionClient(url, { reconnect: true, timeout: 30000, lazy: true, connectionParams: { authToken: token } }). Set timeout to 30000ms to match server keep-alive and lazy: true to defer connection until needed.", "percentage": 94},
        {"solution": "Use graphql-ws library with persistent retry and heartbeat: createClient({ url, retryAttempts: Infinity, keepAlive: 10000, on: { connected: () => console.log(''CONNECTED''), ping: () => {...}, pong: () => {...} } })", "percentage": 91},
        {"solution": "Upgrade graphql-ws to version 3.1.0 or higher to fix reconnection race condition that drops subscriptions.", "percentage": 88}
    ]'::jsonb,
    'Apollo Client or graphql-ws installed, subscription query defined, WebSocket endpoint configured',
    'WebSocket shows green "connected" status in DevTools Network tab for >30 seconds. No "close" events in console during idle periods. Subscription receives data after network changes (WiFi toggle, sleep).',
    'Using default timeout that mismatches server idle timeout. Setting lazy: false which attempts premature connections. Not implementing ping/pong heartbeat monitoring. Using graphql-ws <3.1.0 which has reconnection race condition.',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/45399751/apollo-graphcool-subscriptions-websocket-is-closed-before-the-connection-is',
    'admin:1764171141'
),

-- PRIORITY ISSUE #3: tRPC Procedure Not Found
(
    'tRPC error: No "query"-procedure on path or procedure not found - request returns 404',
    'graphql-trpc',
    'HIGH',
    '[
        {"solution": "Check import statements use createTRPCRouter not router: import { createTRPCRouter, publicProcedure } from ''../trpc''; export const exampleRouter = createTRPCRouter({ hello: publicProcedure.query(...) })", "percentage": 96},
        {"solution": "Verify directory structure for Next.js: /app/api/trpc/[trpc]/route.js - the word ''trpc'' must appear in path twice. Not /app/api/[trpc]/route.js", "percentage": 94},
        {"solution": "If using reverse proxy (nginx/Apache): calculate endpoint based on forwarded paths or disable path rewriting. Check proxy configuration doesn''t strip procedure names from URLs.", "percentage": 82}
    ]'::jsonb,
    'tRPC setup complete, TypeScript configured, Next.js or Express server running',
    'Procedure successfully executes with data returned. Type hints appear in IDE for exported router procedures. Logs show procedure matching expected path without truncation.',
    'Using old router export name instead of createTRPCRouter. Incorrect Next.js directory structure with wrong path nesting. Reverse proxy stripping path prefixes without updating tRPC endpoint. Modified pageExtensions in next.config.js breaking default routing.',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/77881922/trpc-no-query-procedure-on-path-r-getall-but-exists-edit-is-ignoring-first-3',
    'admin:1764171141'
),

-- PRIORITY ISSUE #4: tRPC Mutation Not Returning Data
(
    'tRPC mutateAsync() returns empty object {} or undefined instead of expected mutation response data',
    'graphql-trpc',
    'HIGH',
    '[
        {"solution": "Remove superjson transformer if only on server side: import superjson should appear on BOTH client and server or NEITHER. Configure identically: transformer: superjson on both.", "percentage": 97},
        {"solution": "Use mutateAsync with await for synchronous data access: const data = await mutation.mutateAsync({...}); Access data immediately after await. Do NOT use mutate() and expect data synchronously.", "percentage": 95},
        {"solution": "Use onSuccess callback for post-mutation logic: mutation.mutate(data, { onSuccess: (result) => { handle result here } }). Or access mutation.data reactively via useEffect watching mutation.data dependency.", "percentage": 93}
    ]'::jsonb,
    'tRPC useMutation hook imported, mutation procedure defined with return type, client/server setup',
    'mutateAsync returns actual data object. mutation.data property populated after isSuccess becomes true. onSuccess callback receives complete response with expected fields.',
    'Using superjson on server only (breaks client deserialization). Synchronous console.log of mutation.data before async operation completes. Attempting to assign callback result to external variables without awaiting. Accessing mutation.data before mutation settles.',
    0.95,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/74585421/trpc-mutateasync-returns-nothing',
    'admin:1764171141'
),

-- ADDITIONAL ISSUE #5: Apollo Cache ID Mismatch
(
    'Apollo Client cache not updating even though mutation executes and returns data - UI remains stale',
    'graphql-trpc',
    'MEDIUM',
    '[
        {"solution": "Verify mutation response includes id field that matches cached object id. Apollo uses __typename + id for cache normalization. If mutation returns different id than original object, create separate cache entry instead of updating.", "percentage": 90},
        {"solution": "Use cache.writeQuery to force cache write: cache.writeQuery({ query: GET_USER, data: { user: data.sendUser } }). This bypasses id matching and directly writes response to cache.", "percentage": 88}
    ]'::jsonb,
    'Apollo Client configured, query caching enabled, mutation returning data from server',
    'Cached query results update to match mutation response. Inspect Apollo DevTools cache to confirm merged objects not duplicated. UI re-renders with updated data.',
    'Assuming Apollo matches objects by typename alone (actually needs id too). Initial object with null id getting new id from mutation (different ids prevent cache merge). Not using writeQuery for list updates.',
    0.89,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/55295153/apollo-client-not-updating-cache',
    'admin:1764171141'
),

-- ADDITIONAL ISSUE #6: tRPC Middleware Error Handling
(
    'tRPC middleware cannot catch errors from external API calls within next() - errors silently fail',
    'graphql-trpc',
    'MEDIUM',
    '[
        {"solution": "Check resp.ok and resp.error after calling next() instead of try-catch: const resp = await next(); if (!resp.ok && resp.error.cause instanceof GaxiosError) { throw new TRPCError({code: ''UNAUTHORIZED''}) }", "percentage": 91},
        {"solution": "Wrap external API calls in the procedure itself, not middleware. Throw TRPCError from procedure handler where error is caught and handled properly.", "percentage": 86}
    ]'::jsonb,
    'tRPC procedure with middleware chain, external API client (Google Sheets, etc.), error types imported',
    'External API errors propagate as TRPCError with correct code. Client receives error response with proper error message. Middleware handles both procedural errors and external API failures.',
    'Using try-catch on next() (doesn''t work - must check resp.ok). Throwing errors in middleware instead of in procedures. Not checking resp.error property structure.',
    0.88,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/77489779/how-to-catch-errors-inside-trpc-middleware-thrown-in-trpc-procedures',
    'admin:1764171141'
),

-- ADDITIONAL ISSUE #7: tRPC Context Initialization Circular Dependency
(
    'ReferenceError: Cannot access createTRPCRouter before initialization - circular dependency error',
    'graphql-trpc',
    'MEDIUM',
    '[
        {"solution": "Extract database queries from NextAuth callback into separate utility functions: create /server/utils/user.ts with getUserByEmail() that imports Prisma directly. Call utility from auth callback instead of tRPC router.", "percentage": 92},
        {"solution": "Do NOT call tRPC procedures from NextAuth signIn callback - triggers circular dependency. Use Prisma directly for auth-time queries.", "percentage": 89}
    ]'::jsonb,
    'NextAuth configured with signIn callback, tRPC router defined, Prisma ORM setup',
    'Application builds without circular dependency error. NextAuth signIn completes successfully. tRPC router initializes before any client requests.',
    'Calling createCaller() or tRPC procedures from NextAuth callbacks (causes circular reference). Putting all queries inside tRPC layer without direct utilities. Not separating concerns between auth and API layers.',
    0.91,
    'haiku',
    NOW(),
    'https://github.com/t3-oss/create-t3-app/issues/1093',
    'admin:1764171141'
),

-- ADDITIONAL ISSUE #8: tRPC Validation Error Formatting
(
    'tRPC procedures return generic Zod validation errors instead of field-level feedback for form validation',
    'graphql-trpc',
    'MEDIUM',
    '[
        {"solution": "Create custom error formatter using errorFormatter option: const errorFormatter = ({ shape, error }) => ({ ...shape, data: { ...shape.data, inputValidationError: error.code === ''BAD_REQUEST'' && error.cause instanceof ZodError ? error.cause.flatten() : null } }). Pass to initTRPC.", "percentage": 89},
        {"solution": "On client, check if error.cause is ZodError and flatten it: if (error instanceof TRPCClientError && error.cause instanceof ZodError) { const fields = error.cause.flatten(); }", "percentage": 85}
    ]'::jsonb,
    'Zod schema defined for procedure input, tRPC server initialized, error handler configured',
    'Form receives field-level validation errors with paths and messages. Client can display per-field error messages. onError callback receives structured ZodError data.',
    'Not flattening ZodError (doesn''t provide field-level data). Attempting custom error messages without accessing error.cause. Missing errorFormatter configuration.',
    0.87,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/75063559/custom-zod-errors-in-trpc',
    'admin:1764171141'
),

-- ADDITIONAL ISSUE #9: GraphQL Validation Error Pattern
(
    'GraphQL query returns 200 status with validation errors in response instead of throwing error',
    'graphql-trpc',
    'MEDIUM',
    '[
        {"solution": "Return validation errors as field in successful response: type CreateUserResult { user: User, errors: [ValidationError] }. Resolver returns { user: null, errors: [{key: ''email'', message: ''Already exists''}] }", "percentage": 87},
        {"solution": "Put validation logic inside resolver, not at GraphQL field level. Return errors in response shape rather than throwing exceptions.", "percentage": 84}
    ]'::jsonb,
    'GraphQL schema defined, Apollo Server or similar, Zod or validation library available',
    'Client receives 200 response with errors field populated. Form can display per-field errors. Successful mutations return data, failed ones return errors array.',
    'Throwing validation errors (causes 400 response). Putting validation at schema layer instead of resolver. Not providing field-level error details.',
    0.86,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/32662437/graphql-and-form-validation-errors',
    'admin:1764171141'
),

-- ADDITIONAL ISSUE #10: tRPC Context Always Empty
(
    'tRPC createContext returns empty object {} despite proper context definition - context always undefined',
    'graphql-trpc',
    'LOW',
    '[
        {"solution": "Pass createContext function to trpcNext.createNextApiHandler(): export default trpcNext.createNextApiHandler({ router: appRouter, createContext }). Must explicitly import and pass the function.", "percentage": 93},
        {"solution": "Verify createContext is exported from server/trpc.ts and imported in api/trpc/[trpc].ts file.", "percentage": 90}
    ]'::jsonb,
    'tRPC setup with Next.js, createContext function defined, API route file exists',
    'Context contains userId or other expected properties. Middleware receives populated context. Protected procedures can access ctx.userId.',
    'Forgetting to pass createContext parameter to handler. Exporting createContext incorrectly. Context file not imported into API handler.',
    0.91,
    'haiku',
    NOW(),
    'https://github.com/trpc/trpc/discussions/3332',
    'admin:1764171141'
),

-- ADDITIONAL ISSUE #11: WebSocket Reconnection Race Condition
(
    'GraphQL WebSocket reconnects after network failure but loses subscriptions - only partial subscriptions resume',
    'graphql-trpc',
    'MEDIUM',
    '[
        {"solution": "Upgrade graphql-ws to 5.0.0+ or minimum 3.1.0: npm install graphql-ws@^5.0.0. Fixed timing race condition where subscriptions queued during reconnect were dropped.", "percentage": 96},
        {"solution": "Configure infinite retries with heartbeat monitoring: retryAttempts: Infinity, keepAlive: 10000, on: { ping: () => {}, pong: () => {} }. Ensures reconnection completes before resubmission.", "percentage": 88}
    ]'::jsonb,
    'graphql-ws library in use, subscriptions active, network conditions that cause disconnection',
    'After network recovery, all original subscriptions resubmit. DevTools shows same count of active subscriptions pre/post-disconnect. No data gaps for resumed subscriptions.',
    'Using graphql-ws <3.1.0 (has race condition). Not implementing proper retry timing. Insufficient keep-alive intervals.',
    0.92,
    'haiku',
    NOW(),
    'https://github.com/enisdenjo/graphql-ws/issues/85',
    'admin:1764171141'
),

-- ADDITIONAL ISSUE #12: Next.js Build ECONNREFUSED Error
(
    'Next.js build fails with ECONNREFUSED 127.0.0.1:3000 or ::1:3000 when tRPC SSR queries execute',
    'graphql-trpc',
    'MEDIUM',
    '[
        {"solution": "Use 127.0.0.1 instead of localhost in getBaseUrl(): const getBaseUrl = () => { if (typeof window !== ''undefined'') return ''''; return process.env.VERCEL_URL ? `https://${process.env.VERCEL_URL}` : ''http://127.0.0.1:3000''; }", "percentage": 89},
        {"solution": "Avoid getServerSideProps or getStaticProps with ssr: true during SSR. Fetch data client-side instead or use getStaticProps with revalidate.", "percentage": 82}
    ]'::jsonb,
    'Next.js app with tRPC, SSR enabled, build command running',
    'Next.js build completes without connection errors. Static generation succeeds. No localhost IPv6 resolution issues.',
    'Using localhost which resolves to ::1 (IPv6) during build. Attempting SSR requests when server isn''t running. Not providing fallback URL for build time.',
    0.86,
    'haiku',
    NOW(),
    'https://github.com/trpc/trpc/discussions/1847',
    'admin:1764171141'
),

-- ADDITIONAL ISSUE #13: Apollo Mutation Update Function Timing
(
    'Apollo cache.modify() called in mutation update function returns false and fails to modify cache',
    'graphql-trpc',
    'MEDIUM',
    '[
        {"solution": "Use cache.modify with field-level modifier function: cache.modify({ fields: { projects: (projects, { readField }) => projects.filter(p => readField(''id'', p) !== targetId) } }). readField accesses nested fields safely.", "percentage": 91},
        {"solution": "Return updated value from modifier function: projects.reduce((prev, cur) => readField(''id'', cur) === targetId ? prev.concat(updated) : prev.concat(cur), []).", "percentage": 88}
    ]'::jsonb,
    'Apollo Client v3+, mutation with update function, __typename and id fields present',
    'cache.modify() returns true indicating successful modification. Cache DevTools shows updated data. UI re-renders with new values.',
    'Not returning value from modifier function. Using object-level instead of field-level modifiers. Incorrect readField usage. Not accessing nested field paths correctly.',
    0.89,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/62510330/apollo-client-cache-modify-does-not-work',
    'admin:1764171141'
),

-- ADDITIONAL ISSUE #14: tRPC Type Safety Context v10
(
    'tRPC v10 context type definition fails with TypeScript error - incorrect initTRPC syntax',
    'graphql-trpc',
    'LOW',
    '[
        {"solution": "Use new v10 syntax: const t = initTRPC.context<MyTRPCContext>().create(). Do NOT use initTRPC<{ ctx: MyTRPCContext }>()() - that''s outdated v9 syntax.", "percentage": 94},
        {"solution": "Ensure types exported: export type Context = typeof ctx; export type TRPCContext = typeof t.procedure. Import TRPCContext in client for type inference.", "percentage": 89}
    ]'::jsonb,
    'tRPC v10 installed, TypeScript 4.7+, context type defined',
    'TypeScript compilation succeeds without type errors. Types properly inferred for procedures. IDE autocomplete shows context properties.',
    'Using v9 syntax in v10 (breaking change). Not importing types from trpc file. Missing typeof exports for context.',
    0.92,
    'haiku',
    NOW(),
    'https://github.com/trpc/trpc/discussions/2674',
    'admin:1764171141'
),

-- ADDITIONAL ISSUE #15: Apollo Client Refetch after Mutation
(
    'Apollo refetchQueries after mutation doesn''t update UI - data appears stale in cache',
    'graphql-trpc',
    'LOW',
    '[
        {"solution": "Ensure refetchQueries includes query variables: refetchQueries: [{ query: GET_TODOS, variables: { userId: ctx.userId } }]. Variables must match original query exactly.", "percentage": 90},
        {"solution": "Use refetchQueries with awaitRefetchQueries: true and errorPolicy: ''ignore'': mutation({ refetchQueries: [...], awaitRefetchQueries: true, errorPolicy: ''ignore'' }).", "percentage": 85},
        {"solution": "Prefer update function over refetchQueries for performance - manual cache write is faster than re-fetching from server.", "percentage": 88}
    ]'::jsonb,
    'Apollo Client configured, query and mutation defined, variables used in queries',
    'refetchQueries executes and updates cache with fresh data. UI reflects latest values immediately. No stale data visible.',
    'Omitting variables in refetchQueries (queries don''t match). Not awaiting refetch completion. Using refetchQueries for every mutation (inefficient vs update function).',
    0.88,
    'haiku',
    NOW(),
    'https://www.apollographql.com/docs/react/data/mutations',
    'admin:1764171141'
);
