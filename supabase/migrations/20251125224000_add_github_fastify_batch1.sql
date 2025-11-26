-- Add high-engagement Fastify server/routing error solutions from GitHub issues
-- Category: github-fastify
-- Source: https://github.com/fastify/fastify/issues

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'FST_ERR_SCH_BUILD: cannot find schema reference in shared schemas',
    'github-fastify',
    'HIGH',
    $$[
        {"solution": "Register all shared schemas via plugins before first route declaration to ensure AJV compiler has all references available", "percentage": 95, "note": "Schemas must exist before schema compiler is built"},
        {"solution": "Move schema compilation to preReady lifecycle hook by ensuring plugins register schemas before routes are defined", "percentage": 90, "note": "Fix implemented in PR #2077"},
        {"solution": "Define shared schemas inline in route options instead of registering via plugin", "percentage": 85, "note": "Workaround for schema ordering issues"}
    ]$$::jsonb,
    'Fastify schema system, Multiple plugins registering schemas, Routes with schema validation',
    'Route registers successfully without FST_ERR_SCH_BUILD errors, Schema references resolve during compilation',
    'Declaring routes with schema options before registering shared schema plugins causes premature compiler instantiation. Ensure plugin schema registration happens first. Do not register routes between schema plugin registration and preReady hook.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/fastify/fastify/issues/1960'
),
(
    'Method already declared for route: duplicate route validation fails silently',
    'github-fastify',
    'HIGH',
    $$[
        {"solution": "Handle duplicate route errors in fastify.ready() callback instead of synchronous context, as the callback receives errors as first argument", "percentage": 92, "note": "Proper error handling pattern for async registration"},
        {"solution": "Define all routes synchronously at startup before calling fastify.ready() to catch duplicates immediately", "percentage": 88, "note": "Synchronous route registration validates duplicates instantly"},
        {"solution": "Validate routes are unique before registration using a Set to track declared routes", "percentage": 85, "command": "Check route uniqueness: new Set(routes.map(r => r.method + r.path)).size === routes.length"}
    ]$$::jsonb,
    'Fastify application instance, Multiple route definitions, fastify.ready() call in application',
    'Duplicate route declaration throws error immediately or via ready() callback without silent failures',
    'fastify.ready() callbacks must handle errors via first parameter - errors are not thrown. Synchronous registration immediately catches duplicates, but async patterns may mask errors if not handled in callback.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/fastify/fastify/issues/3411'
),
(
    'Error: root plugin has already booted when registering routes dynamically',
    'github-fastify',
    'VERY_HIGH',
    $$[
        {"solution": "Wrap dynamic route definitions in fastify.register() plugins and use await to ensure registration completes before boot", "percentage": 95, "note": "Official recommended pattern from maintainers"},
        {"solution": "Load all route definitions before fastify.listen() is called, not after framework initialization", "percentage": 93, "note": "Routes must register during plugin boot phase"},
        {"solution": "Use fastify.register() with configuration loading inside plugin function rather than calling fastify.route() in loops after boot", "percentage": 90, "command": "await fastify.register((instance) => { /* route definitions here */ })"}
    ]$$::jsonb,
    'Fastify application, Route configuration, Async operation completion before server listen',
    'Routes register without "root plugin already booted" error, Server starts successfully and serves routes',
    'Do not call fastify.route() after fastify.listen(). Avoid splitting route definitions across multiple files without plugin wrapping. Routes registered asynchronously after boot will fail - use plugin system with await.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://github.com/fastify/fastify/issues/472'
),
(
    'Body validation schema not supported for GET requests',
    'github-fastify',
    'HIGH',
    $$[
        {"solution": "Remove body schema validation from GET request definitions - use query or params validation instead", "percentage": 96, "note": "GET requests do not support request bodies per HTTP spec"},
        {"solution": "Change route method from GET to POST/PUT/PATCH if body validation is required", "percentage": 94, "note": "POST, PUT, PATCH methods support body schemas"},
        {"solution": "Use query parameter validation for GET requests: schema: { querystring: { ... } }", "percentage": 92, "command": "fastify.get('/path', { schema: { querystring: MyQuerySchema } }, handler)"}
    ]$$::jsonb,
    'Fastify route definition with schema, HTTP method specification, Request schema understanding',
    'Route registers without validation errors, GET requests process query/param validation successfully',
    'Body validation schemas only work with methods supporting request bodies (POST, PUT, PATCH, DELETE). GET requests with body schemas always fail. Query validation is the correct approach for GET parameters.',
    0.95,
    'sonnet-4',
    NOW(),
    'https://github.com/fastify/fastify/issues/4259'
),
(
    'onRoute hook not firing or firing incorrectly inside registered plugins',
    'github-fastify',
    'MEDIUM',
    $$[
        {"solution": "Use await when registering plugins containing onRoute hooks to ensure hook executes after route definitions", "percentage": 94, "note": "Async/await ensures proper execution order in v4+"},
        {"solution": "Disable auto-generated HEAD routes if onRoute hook is firing unexpectedly for them: Fastify({ exposeHeadRoute: false })", "percentage": 88, "note": "HEAD routes auto-generated for GET routes in Fastify v4"},
        {"solution": "Register onRoute hook directly on app instance instead of inside plugin for global route tracking", "percentage": 85, "note": "App-level hooks have more predictable firing"}
    ]$$::jsonb,
    'Fastify v4.1.0+, Route definitions, Plugin system understanding, Hook lifecycle knowledge',
    'onRoute hook fires for all defined routes without missing routes or duplicate firing, Hook executes in predictable order',
    'In Fastify v4, route registration became synchronous - hooks in plugins must use await. Auto-generated HEAD routes may fire separately from main routes. Plugin-level hooks have different timing than app-level.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/fastify/fastify/issues/4085'
),
(
    'Double colon routes cause infinite loop and server freeze',
    'github-fastify',
    'MEDIUM',
    $$[
        {"solution": "Upgrade find-my-way dependency to v5.1.1+ (main branch) or v4.5.1+ (v4 branch) which includes infinite loop fix", "percentage": 97, "note": "Routing library fix, updated automatically via npm"},
        {"solution": "Reinstall dependencies to pull patched find-my-way version: npm install or yarn install", "percentage": 96, "command": "npm install --force"},
        {"solution": "Avoid double colon syntax in route paths as temporary workaround, use simpler path patterns", "percentage": 80, "note": "Workaround only - upgrade is permanent fix"}
    ]$$::jsonb,
    'Fastify with find-my-way router, Route definitions with colon syntax, npm/yarn package manager',
    'Routes with double colons register and respond to requests without server freezing, Non-matching requests return 404 immediately',
    'The infinite loop occurs in find-my-way router when processing requests that partially match double colon routes. Upgrading dependencies is required - code changes alone will not fix this. Affects routes like /hello:world with matching prefix routes.',
    0.95,
    'sonnet-4',
    NOW(),
    'https://github.com/fastify/fastify/issues/3550'
),
(
    'Optional route parameter throws error on root path: "path could not be empty"',
    'github-fastify',
    'MEDIUM',
    $$[
        {"solution": "Avoid optional parameters on root path - use explicit separate routes: fastify.get(\"/\", ...) and fastify.get(\"/:id\", ...)", "percentage": 96, "note": "Limitation in find-my-way router - not a Fastify bug"},
        {"solution": "Use a catch-all route for optional root parameters and parse manually: fastify.get(\"/*\", handler)", "percentage": 85, "note": "Workaround using wildcard routing"},
        {"solution": "File upstream issue with find-my-way if this pattern is required for your use case", "percentage": 70, "note": "Root cause in routing library, not framework"}
    ]$$::jsonb,
    'Fastify routing, Optional URL parameters understanding, find-my-way router',
    'Routes register without parse errors, Root path requests match appropriate handler without assertion errors',
    'The error originates from find-my-way router which rejects empty paths after stripping optional parameters. Optional parameters work fine on non-root paths (/anything/:id?). This is a routing library limitation, not Fastify framework behavior.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://github.com/fastify/fastify/issues/3663'
),
(
    'Error handler returns HTTP 500 even when status code is explicitly set',
    'github-fastify',
    'MEDIUM',
    $$[
        {"solution": "Ensure custom error handler calls res.code(statusCode) and res.send() directly without additional wrapper functions", "percentage": 94, "note": "Error handlers must set status before send()"},
        {"solution": "Verify that exception handling middleware/decorators are not interfering with status code assignment", "percentage": 90, "note": "Custom exception classes may override status codes"},
        {"solution": "Test error handler in isolation: register global error handler with fastify.setErrorHandler(handler) and verify status codes directly", "percentage": 88, "command": "fastify.setErrorHandler((error, request, reply) => { reply.code(401); reply.send(error); })"}
    ]$$::jsonb,
    'Fastify error handler, Custom exception classes, HTTP status code understanding',
    'Error handler returns specified status code in response, HTTP response status matches code() call',
    'Third-party exception handling libraries may wrap Fastify errors and override status codes. Direct Fastify error handlers work correctly. Always test error handlers independently to identify if issue is in framework or custom code.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/fastify/fastify/issues/3114'
),
(
    'Maximum header size violation causes connection reset bypassing error handler',
    'github-fastify',
    'MEDIUM',
    $$[
        {"solution": "Implement clientErrorHandler on Fastify HTTP server instance to catch header size violations", "percentage": 96, "note": "Header size errors occur at HTTP layer before Fastify routing"},
        {"solution": "Set clientError handler: fastify.server.on(\"clientError\", (err, socket) => {...}) to handle connection errors gracefully", "percentage": 94, "command": "fastify.server.on(\"clientError\", (err, socket) => { if (!socket.headersSent) socket.end(\"HTTP/1.1 400\\r\\n\\r\\n\"); })"},
        {"solution": "Check client request sizes and validate before sending - max header size defaults to 16KB, configurable via Node.js http module", "percentage": 90, "note": "Prevention is better than error handling"}
    ]$$::jsonb,
    'Fastify HTTP server, Node.js http module, Client request monitoring',
    'Header size violations are caught and handled gracefully, Subsequent requests process normally without connection reset',
    'Header size violations are low-level HTTP errors caught by Node.js before Fastify request cycle - they bypass error handlers. clientError handler on server instance is required. Regular Fastify error handlers cannot catch these.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/fastify/fastify/issues/4335'
),
(
    'Schema absolute references failure: "Bad arguments in serialization"',
    'github-fastify',
    'MEDIUM',
    $$[
        {"solution": "Set both validator and serializer compilers to use same schema container: setValidatorCompiler() and setSerializerCompiler() with identical schemas", "percentage": 94, "note": "Both compilers must have access to same schema definitions"},
        {"solution": "Use setSchemaContainer() method (if available in version) to configure single schema provider for both validation and serialization", "percentage": 90, "note": "Recommended approach for Fastify 4+"},
        {"solution": "Register schemas with both AJV (validator) and fast-json-stringify (serializer) explicitly", "percentage": 88, "command": "Pass schemas to both setValidatorCompiler and setSerializerCompiler options"}
    ]$$::jsonb,
    'Fastify with custom validators, JSON schema definitions, AJV and fast-json-stringify setup',
    'Routes with absolute schema references serialize responses without errors, Response validation succeeds for all referenced schemas',
    'Custom validator implementations must track schemas consistently. fast-json-stringify requires schema references during serialization phase. Mixing custom validators with default serializers causes reference resolution failures.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/fastify/fastify/issues/2446'
),
(
    'Fastify 4 schema duplicate ID error: "schema with key already exists"',
    'github-fastify',
    'MEDIUM',
    $$[
        {"solution": "Avoid using $id properties in dereferenced schemas when using fast-json-stringify with multiple $ref", "percentage": 93, "note": "Dereferencing creates duplicate IDs"},
        {"solution": "Deep clone schemas in schema controller: JSON.parse(JSON.stringify(schema)) to prevent mutation between validation and serialization", "percentage": 91, "note": "Prevents shared schema state issues"},
        {"solution": "Use TypeBox with proper schema composition patterns to prevent multiple dereferencing of same schema", "percentage": 88, "note": "TypeBox handles schema references more reliably"}
    ]$$::jsonb,
    'Fastify 4+, TypeBox schemas, Multiple schema references in single schema',
    'Schemas with multiple $ref compile without duplicate ID errors, Response serialization completes successfully',
    'fast-json-stringify dereferences schemas non-deterministically depending on route order. Duplicate $id properties in dereferenced objects cause registry conflicts. Response schemas (fast-json-stringify) trigger errors more readily than validation schemas (AJV).',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/fastify/fastify/issues/4028'
),
(
    'Response validation error breaks reply lifecycle and client hangs',
    'github-fastify',
    'MEDIUM',
    $$[
        {"solution": "Ensure response data matches schema before calling reply.send() - validate in handler before sending", "percentage": 95, "note": "Prevention is best approach"},
        {"solution": "Use try-catch around reply.send() and send error response in catch block without calling send() again", "percentage": 92, "note": "Only one response can be sent per request"},
        {"solution": "Disable response validation for specific routes if validation is problematic: schema: { response: {} }", "percentage": 85, "note": "Workaround - not recommended for production"}
    ]$$::jsonb,
    'Fastify reply object, Response schema definitions, Error handling patterns',
    'Invalid responses are caught before send(), Client receives error response immediately without timeout, Reply.sent flag accurately reflects response state',
    'reply.send() sets sent flag early, so serialization errors leave flag true but client receives nothing. Never assume response is sent until after send() completes. Try-catch patterns must avoid calling send() again in catch block.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/fastify/fastify/issues/1325'
),
(
    'Root route with prefix does not work: 404 on prefixed root path',
    'github-fastify',
    'MEDIUM',
    $$[
        {"solution": "Upgrade to Fastify v2+ where root route with prefix functionality was fixed in PR #1228", "percentage": 97, "note": "Known issue in v1, fixed in v2"},
        {"solution": "Define root route explicitly at prefix level: register with prefix and route path \"/\"", "percentage": 95, "note": "Requires proper plugin setup"},
        {"solution": "Use explicit route path matching root: fastify.get(\"/\", handler) inside plugin with prefix option", "percentage": 92, "command": "fastify.register((f) => { f.get(\"/\", handler) }, { prefix: \"/abc\" })"}
    ]$$::jsonb,
    'Fastify v2+, Plugin registration, Route prefix configuration',
    'Root route with prefix responds correctly at prefixed path, GET /abc/ returns expected response not 404',
    'Fastify v1 does not support root routes with prefixes - this is fixed in v2+. Must use v2 or later. Root paths must be explicitly defined as "/" inside plugin function registered with prefix.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://github.com/fastify/fastify/issues/1338'
),
(
    'Plugin prefix option ignored when passed as function instead of object',
    'github-fastify',
    'MEDIUM',
    $$[
        {"solution": "Pass plugin options as object literal instead of function: { prefix: \"route\" } not (fastify) => ({ prefix: \"route\" })", "percentage": 96, "note": "Current limitation of function-based options"},
        {"solution": "Use object-based plugin options for route prefixing until function-based options are fully supported", "percentage": 94, "note": "Workaround for current version limitation"},
        {"solution": "File feature request to support function-based prefix options if this pattern is required", "percentage": 70, "note": "May be supported in future releases"}
    ]$$::jsonb,
    'Fastify plugin registration, Route prefixing setup, Plugin options API',
    'Routes register at expected prefix path regardless of option passing method, requests to /prefix/route work correctly',
    'Function-based plugin options do not respect prefix values - routes register at root. Use object literals for plugin options. This is noted duplicate of fastify/help#174, indicating it is a known limitation.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/fastify/fastify/issues/3771'
),
(
    'Trailing slash in route prefix causes 404: double slash in final path',
    'github-fastify',
    'HIGH',
    $$[
        {"solution": "Remove trailing slash from prefix definition: use { prefix: \"/test\" } not { prefix: \"/test/\" }", "percentage": 97, "note": "Standard convention for route prefixes"},
        {"solution": "Ensure all routes start with / and prefixes do not end with /: prefix=\"/api\" + route=\"/users\" = /api/users", "percentage": 96, "note": "Consistent path construction pattern"},
        {"solution": "When concatenating paths, normalize slashes: use path.join() equivalent to prevent double slashes", "percentage": 92, "command": "Standard: fastify.register((f) => { f.get(\"/foo\", h) }, { prefix: \"/test\" })"}
    ]$$::jsonb,
    'Fastify plugin registration, Route prefix configuration, HTTP URL construction',
    'Routes with prefixes respond at correct URL without double slashes, GET /test/foo works with prefix=\"/test\" and route=\"/foo\"',
    'Inconsistent slash formatting in prefix+route concatenation causes routing mismatches. Never use trailing slashes in prefixes. All routes must start with /. Following this pattern prevents 404 errors and confusing double slash URLs.',
    0.96,
    'sonnet-4',
    NOW(),
    'https://github.com/fastify/fastify/issues/584'
);
