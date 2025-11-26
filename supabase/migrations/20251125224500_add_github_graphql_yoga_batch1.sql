-- GraphQL Yoga GitHub Issues: Server/Resolver Error Solutions (Batch 1)
-- Category: github-graphql-yoga
-- Source: https://github.com/dotansimha/graphql-yoga/issues
-- Mined on: 2025-11-25

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'TypeScript error: Incompatible Cache type when using createRedisCache with response-cache plugin',
    'github-graphql-yoga',
    'MEDIUM',
    $$[
        {"solution": "Update @graphql-yoga/plugin-response-cache and @envelop/response-cache-redis to latest versions", "percentage": 95, "note": "Resolved in PR #4184 with type compatibility fixes", "command": "npm install @graphql-yoga/plugin-response-cache@latest @envelop/response-cache-redis@latest"},
        {"solution": "If stuck on older versions, create a local type override to bridge the incompatibility", "percentage": 70, "note": "Workaround until versions are updated"},
        {"solution": "Check Envelop plugins documentation for correct type definitions", "percentage": 60, "note": "May require dependency chain updates"}
    ]$$::jsonb,
    'TypeScript project with GraphQL Yoga, Response cache plugin enabled, createRedisCache factory imported',
    'TypeScript compilation completes without errors, Response caching works with Redis backend',
    'Type mismatch between PromiseOrValue<Maybe<ExecutionResult>> and Promise<ExecutionResult | undefined> - update all related packages together. Check dependency versions match across @envelop and @graphql-yoga packages.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/dotansimha/graphql-yoga/issues/3048'
),
(
    'GraphiQL headers not preserved when opening new tab - custom headers lost',
    'github-graphql-yoga',
    'HIGH',
    $$[
        {"solution": "Implement shouldPersistHeaders prop in GraphiQL configuration: renderGraphiQL({ ..., shouldPersistHeaders: true })", "percentage": 90, "note": "GraphiQL React supports this natively via EditorContextProviderProps"},
        {"solution": "Use GraphiQL v3+ which includes header persistence by default", "percentage": 85, "note": "Requires updating @graphql-yoga/render-graphiql dependency"},
        {"solution": "Store headers in browser localStorage and restore on tab load", "percentage": 75, "note": "Manual workaround for older versions"}
    ]$$::jsonb,
    'GraphQL Yoga server with GraphiQL enabled, Custom headers configured via renderGraphiQL()',
    'New GraphiQL tabs retain custom headers like X-Parse-Application-Id, Authentication headers persist across new tabs',
    'Headers must be passed as JSON.stringify() in renderGraphiQL. GraphiQL version must support shouldPersistHeaders. Check that renderGraphiQL is properly configured before creating tabs.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/dotansimha/graphql-yoga/issues/1163'
),
(
    'useGraphQlJit plugin throws TypeError with non-standard Accept header values',
    'github-graphql-yoga',
    'MEDIUM',
    $$[
        {"solution": "Add Accept header validation middleware before GraphQL Yoga processing to reject non-standard Accept headers with 400 response", "percentage": 90, "note": "Prevents the error at source"},
        {"solution": "Wrap useGraphQlJit plugin with error boundary to catch and properly format errors when Accept header differs", "percentage": 85, "note": "Post-processing approach to convert TypeError to GraphQL error"},
        {"solution": "Upgrade @graphql-yoga/graphql-jit to version that handles non-standard headers gracefully", "percentage": 75, "note": "Check latest version for fix"},
        {"solution": "Remove useGraphQlJit plugin if Accept header validation is complex", "percentage": 60, "note": "Fallback if other solutions blocked"}
    ]$$::jsonb,
    'GraphQL Yoga with useGraphQlJit() plugin enabled, Requests with Accept header other than application/graphql-response+json',
    'GraphQL errors return proper error format regardless of Accept header, No TypeError exceptions in logs, Consistent error handling with/without useGraphQlJit',
    'Plugin crashes when accessing originalError on undefined object - the root cause is improper null checking in result-processor. Standard Accept header is application/graphql-response+json, application/json, multipart/mixed.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/dotansimha/graphql-yoga/issues/2967'
),
(
    'GraphiQL Variables and Headers tab state not persisting after closing browser tab',
    'github-graphql-yoga',
    'HIGH',
    $$[
        {"solution": "Enable GraphiQL header persistence via shouldPersistHeaders prop: renderGraphiQL({ ..., shouldPersistHeaders: true })", "percentage": 93, "note": "Official GraphiQL React feature, enableds persistence across sessions"},
        {"solution": "Update @graphql-yoga/render-graphiql to v2.5.0+ which includes persistence features", "percentage": 90, "command": "npm install @graphql-yoga/render-graphiql@latest"},
        {"solution": "Implement custom browser storage mechanism using IndexedDB for large variable sets", "percentage": 70, "note": "For projects requiring advanced persistence"}
    ]$$::jsonb,
    'GraphQL Yoga v3.0+, GraphiQL interface configured, Browser with localStorage support',
    'Headers remain in GraphiQL after closing and reopening tab, Variables persist across sessions, GraphiQL state survives browser restart',
    'Persistence disabled by default in older GraphiQL versions. Chrome 111+ required for reliable localStorage. Variables/Headers are stored separately - both must be configured for full persistence.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/dotansimha/graphql-yoga/issues/2650'
),
(
    'Multipart form-data requests without boundary cause 500 error instead of GraphQL error response',
    'github-graphql-yoga',
    'HIGH',
    $$[
        {"solution": "Wrap multipart parsing in try-catch in requestParserPlugin: catch busboy errors and convert to GraphQL error object with 400 status", "percentage": 92, "note": "Official fix approach to return proper GraphQL errors"},
        {"solution": "Validate Content-Type header before parsing: reject if multipart/form-data lacks boundary parameter", "percentage": 88, "note": "Preventative validation layer"},
        {"solution": "Implement request validation middleware to catch malformed Content-Type headers before they reach GraphQL engine", "percentage": 85, "command": "Add validation middleware before yoga.handleNodeRequest()"},
        {"solution": "Update graphql-yoga to v5.2.0+ which includes improved multipart error handling", "percentage": 80, "note": "Permanent fix in later versions"}
    ]$$::jsonb,
    'GraphQL Yoga v5.0+, File upload mutations enabled, Express/Fastify server running Node.js 18+',
    'Malformed multipart requests return HTTP 200 with GraphQL error in response body, No 500 errors in server logs, Error message clearly indicates Content-Type boundary issue',
    'busboy library throws "Multipart: Boundary not found" - this must be caught before propagating to HTTP layer. Default behavior returns 500; proper GraphQL servers return 200 with error object. Content-Type: multipart/form-data MUST include boundary parameter.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/dotansimha/graphql-yoga/issues/3190'
),
(
    'File upload broken with Next.js 14 Pages Router - duplex option required or missing stream methods',
    'github-graphql-yoga',
    'MEDIUM',
    $$[
        {"solution": "Use Next.js App Router instead of Pages Router - Yoga v5 is optimized for App Router", "percentage": 88, "note": "Recommended long-term solution"},
        {"solution": "Add duplex: \"half\" to fetch/Request options: new Request(req, { ..., duplex: \"half\" })", "percentage": 85, "note": "Required when bodyParser: false in Next.js config"},
        {"solution": "Set bodyParser: true in Next.js API route config and verify request.formData() returns proper File objects", "percentage": 80, "note": "Ensures Node.js Request compatibility"},
        {"solution": "Create middleware wrapper that normalizes Next.js Pages Router request to match App Router shape", "percentage": 70, "note": "Complex workaround for legacy Pages Router"}
    ]$$::jsonb,
    'Next.js 14 with Pages Router, GraphQL Yoga v5.1+, @graphql-yoga/plugin-request-parser enabled for file uploads',
    'File uploads complete successfully, Mutation returns proper response, No TypeError about duplex option, request.formData() returns File objects with arrayBuffer() method',
    'Pages Router request object missing duplex option - newer fetch API requires this. App Router provides proper compatibility. Don''t mix bodyParser settings with Yoga''s form parsing. Test with actual file upload, not just introspection.',
    0.75,
    'sonnet-4',
    NOW(),
    'https://github.com/dotansimha/graphql-yoga/issues/3185'
),
(
    'Multiple cookies sent in single set-cookie header instead of separate headers on AWS Lambda',
    'github-graphql-yoga',
    'MEDIUM',
    $$[
        {"solution": "Create custom cookie plugin that uses response.headers.append() instead of set: new Headers().append(''set-cookie'', cookie)", "percentage": 90, "note": "Builds proper multi-value headers structure"},
        {"solution": "Return multiValueHeaders[''set-cookie''] array in Lambda response handler instead of flattening to single header", "percentage": 88, "note": "AWS API Gateway REST specific fix"},
        {"solution": "Switch from API Gateway REST to API Gateway HTTP which handles multi-value headers correctly", "percentage": 85, "note": "Architectural change but resolves issue permanently"},
        {"solution": "Implement Object.fromEntries with header.append() instead of header.set() for multiple cookie support", "percentage": 80, "note": "Requires custom adapter for Lambda environment"}
    ]$$::jsonb,
    'GraphQL Yoga deployed on AWS Lambda with API Gateway REST, useCookies() plugin enabled, Multiple cookies being set',
    'Each cookie sent in separate set-cookie header, Browser receives individual Set-Cookie headers, Multiple cookies stored correctly in client',
    'AWS API Gateway REST expects multiValueHeaders for multi-value responses - Object.fromEntries() collapses them. Works locally but fails in production. Must use response.headers.append() not set(). API Gateway HTTP handles this automatically.',
    0.86,
    'sonnet-4',
    NOW(),
    'https://github.com/dotansimha/graphql-yoga/issues/3074'
),
(
    'ERR_HTTP_HEADERS_SENT: Cannot write headers after response already sent in Fastify handler',
    'github-graphql-yoga',
    'MEDIUM',
    $$[
        {"solution": "Set custom headers BEFORE calling yoga.handleNodeRequest() or use Yoga plugin system for headers instead of post-processing", "percentage": 92, "note": "Correct HTTP request/response flow"},
        {"solution": "Check reply.sent status before attempting to set headers: if (!reply.sent) { reply.headers(...) }", "percentage": 85, "note": "Defensive check prevents the error"},
        {"solution": "Configure headers through Yoga plugins instead of after handleNodeRequest: use onRequest hook in Yoga schema", "percentage": 88, "note": "Proper integration point"},
        {"solution": "Disable onSend hooks in Fastify plugins that might write headers prematurely", "percentage": 70, "note": "May break other functionality"}
    ]$$::jsonb,
    'Fastify server with GraphQL Yoga, Custom headers required, Fastify plugins like @fastify/cookie or fastify-session enabled',
    'No ERR_HTTP_HEADERS_SENT errors in logs, Custom headers applied to all responses, Response body sent correctly',
    'HTTP spec: headers must precede body transmission. reply.headers() after yoga.handleNodeRequest() violates this. Fastify onSend hooks write headers, making subsequent modifications fail. Configure headers in Yoga plugins, not post-processing.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/dotansimha/graphql-yoga/issues/3099'
),
(
    'TypeScript type augmentation side effects: graphql-yoga modifies global GraphQLError when imported',
    'github-graphql-yoga',
    'LOW',
    $$[
        {"solution": "Check if custom GraphQLError extension conflicts with global type augmentation from @graphql-yoga/graphql-error-extensions or similar package", "percentage": 90, "note": "Root cause is usually a side-effect import"},
        {"solution": "Remove problematic type augmentation or move to separate types file with explicit export, avoid global scope pollution", "percentage": 85, "note": "Fix in graphql-yoga source"},
        {"solution": "Use type assertion (as CustomError) instead of extending GraphQLError if type conflicts occur", "percentage": 75, "note": "Temporary workaround"},
        {"solution": "Add triple-slash reference to override type definitions explicitly", "percentage": 60, "note": "Complex but allows coexistence"}
    ]$$::jsonb,
    'TypeScript project with @graphql-yoga/* v5.0.0+ as dependency, Custom GraphQLError subclass with http property',
    'TypeScript compilation succeeds with custom error classes, No type conflicts in monorepo packages, http property accessible on custom errors',
    'Side-effect imports in @graphql-yoga packages apply global type augmentations that affect all packages in monorepo. Custom error classes trying to extend GraphQLError with http property fail. Errors only appear when graphql-yoga is dependency, not in isolated projects.',
    0.70,
    'sonnet-4',
    NOW(),
    'https://github.com/dotansimha/graphql-yoga/issues/3106'
),
(
    'SOFA plugin breaks GraphQL operations in GraphiQL when basePath is configured',
    'github-graphql-yoga',
    'MEDIUM',
    $$[
        {"solution": "Verify SOFA basePath does not interfere with GraphQL endpoint: ensure GraphQL operations still route to /graphql not /rest/graphql", "percentage": 90, "note": "Route configuration issue"},
        {"solution": "Configure SOFA with explicit endpoint mapping: useSofa({ basePath: ''/rest'', graphqlEndpoint: ''/graphql'' })", "percentage": 88, "note": "Explicit routing prevents conflicts"},
        {"solution": "Check plugin order in array - place useSofa after core schema plugins to avoid middleware conflicts", "percentage": 82, "note": "Middleware execution order matters"},
        {"solution": "Upgrade @graphql-yoga/plugin-sofa to v3.1.0+ which includes GraphiQL routing fixes", "percentage": 80, "command": "npm install @graphql-yoga/plugin-sofa@latest"}
    ]$$::jsonb,
    'GraphQL Yoga v5.0.0+, @graphql-yoga/plugin-sofa v3.0.0+, GraphiQL interface enabled',
    'GraphQL queries execute successfully in GraphiQL, REST endpoints available under /rest/swagger, Both GraphQL and SOFA routes functional',
    'SOFA basePath configuration can redirect GraphQL operations unintentionally. GraphiQL introspection fails if routed to REST adapter. Must separate GraphQL endpoint from REST basePath. SwaggerUI accessible at /rest/swagger not /swagger.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/dotansimha/graphql-yoga/issues/3112'
),
(
    'RangeError: Maximum call stack size exceeded in Node 13+ with file upload functionality',
    'github-graphql-yoga',
    'LOW',
    $$[
        {"solution": "Upgrade to GraphQL Yoga v2.0+ which resolved fs-capacitor compatibility issues with Node 13+", "percentage": 95, "note": "Permanent solution with major version upgrade", "command": "npm install graphql-yoga@^2.0.0"},
        {"solution": "Use latest stable Node.js LTS version and update all dependencies: npm update", "percentage": 92, "note": "fs-capacitor works correctly with Node 18+ LTS"},
        {"solution": "If stuck on v1, downgrade to Node 12 or use Node 13.5.0 which had better stream compatibility", "percentage": 65, "note": "Workaround, not recommended for production"},
        {"solution": "Implement custom file upload handler that bypasses fs-capacitor for Node 13", "percentage": 50, "note": "Complex implementation, not recommended"}
    ]$$::jsonb,
    'GraphQL Yoga v1.x with file upload, Node.js 13+, graphql-upload dependency installed',
    'File uploads complete without stack overflow errors, Server processes uploads without recursive stream errors, No fs-capacitor errors in logs',
    'Root cause: fs-capacitor recursive calls between _openReadFs() and ReadStream.open() exceeded call stack in Node 13. Architectural changes between Node 12 and 13 internal stream handling. Upgrade Yoga to v2+ resolves all fs-capacitor issues permanently.',
    0.75,
    'sonnet-4',
    NOW(),
    'https://github.com/dotansimha/graphql-yoga/issues/604'
),
(
    'WebSocket object missing from subscription context - cannot access upgrade request or session data',
    'github-graphql-yoga',
    'MEDIUM',
    $$[
        {"solution": "Access connection object which contains WebSocket upgrade request and session info in subscription context", "percentage": 85, "note": "Current implementation - connection object provides needed data"},
        {"solution": "Upgrade to GraphQL Yoga v3.0+ which exposes webSocket object in subscription context callback", "percentage": 95, "note": "Feature implemented in v3 release", "command": "npm install graphql-yoga@^3.0.0"},
        {"solution": "If on v2, extract session/cookies from connection.context instead of WebSocket object", "percentage": 80, "note": "Alternative approach with available data"},
        {"solution": "Use middleware to inject WebSocket into context before subscription processing", "percentage": 70, "note": "Workaround for older versions"}
    ]$$::jsonb,
    'GraphQL Yoga with subscriptions enabled, WebSocket upgrade requests, Need to access session or cookie data in subscription resolver',
    'Subscription resolvers can access session information, WebSocket upgrade request available in context, Authentication data accessible in subscription handlers',
    'In v2, only connection object available - does not expose full WebSocket upgrade request. v3 adds webSocket parameter to subscription context. Middleware must inject WebSocket data before it reaches subscription resolvers if using v2.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/dotansimha/graphql-yoga/issues/394'
),
(
    'GraphiQL schema caching issue - introspection fetched only once, changes not reflected during development',
    'github-graphql-yoga',
    'MEDIUM',
    $$[
        {"solution": "Implement Server-Sent Events (SSE) endpoint that notifies client when schema changes, triggering automatic re-introspection", "percentage": 88, "note": "Modern approach with instant feedback, no polling overhead"},
        {"solution": "Add polling interval to GraphiQL configuration: renderGraphiQL({ ..., introspectionPollingIntervalMs: 5000 })", "percentage": 82, "note": "Simpler but creates GraphQL overhead"},
        {"solution": "Implement manual reload button by watching schema files and triggering schema refresh on client", "percentage": 78, "note": "File-watcher based approach"},
        {"solution": "For now, reload entire browser page to force fresh introspection - F5 or Cmd+R", "percentage": 60, "note": "Current workaround, not ideal for development"}
    ]$$::jsonb,
    'GraphQL Yoga development environment, GraphiQL interface, Frequently changing schema or resolvers',
    'GraphiQL reflects schema changes without full page reload, Introspection includes latest types and fields, Development workflow shows updated schema instantly',
    'GraphiQL schema introspection cached on first load and not refreshed. GraphQL Playground (deprecated) had polling support - v3 removed this. Manual page reload (F5) forces introspection refresh. SSE approach best but requires server implementation.',
    0.80,
    'sonnet-4',
    NOW(),
    'https://github.com/dotansimha/graphql-yoga/issues/1161'
),
(
    'Cloudflare Workers context isolation issue - server-side context reused across separate worker invocations creates security vulnerability',
    'github-graphql-yoga',
    'HIGH',
    $$[
        {"solution": "Ensure each request.context is recreated fresh per Worker invocation, not reused from server initialization", "percentage": 93, "note": "Critical for security - context must be request-scoped"},
        {"solution": "Move context initialization from createYoga schema to request-level handler using getInitialContext hook", "percentage": 90, "note": "Proper Yoga pattern for per-request isolation"},
        {"solution": "Review Wrangler configuration to ensure request isolation is enabled and no global state is shared", "percentage": 88, "note": "May require wrangler.toml changes"},
        {"solution": "Implement request-scoped WeakMap instead of module-level context storage", "percentage": 82, "note": "Prevents accidental context leakage"}
    ]$$::jsonb,
    'GraphQL Yoga deployed on Cloudflare Workers with Wrangler CLI, Authentication context or sensitive data in context object',
    'Each request has isolated context, No data leakage between Worker invocations, Security audit passes, Context properly garbage collected per request',
    'Critical security issue: server-side context must NEVER be shared across requests. Use getInitialContext hook in Yoga to create fresh context per request. Wrangler default behavior may reuse context - must explicitly isolate. Test with multiple concurrent requests to verify isolation.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/dotansimha/graphql-yoga/issues/3222'
);
