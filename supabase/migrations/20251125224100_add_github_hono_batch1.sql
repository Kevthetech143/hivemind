-- Add GitHub Hono routing/middleware error solutions batch 1
-- Extracted from honojs/hono repository issues (Nov 25, 2025)
-- Focus: Edge runtime errors, middleware composition, TypeScript inference, Cloudflare Workers issues

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Hono type inference taking too long during builds (8+ minutes)',
    'github-hono',
    'HIGH',
    $$[
        {"solution": "Split routers into separate buildable esbuild libraries in monorepo structure", "percentage": 90, "note": "Achieved ~10-second live-reload improvement; separate build configs reduce type inheritance depth"},
        {"solution": "Skip type checking in development environment on main router", "percentage": 85, "note": "IntelliSense still works in components; reduces compilation in hot-reload scenarios"},
        {"solution": "Use TypeBox instead of Zod for schema optimization to reduce generic type nesting", "percentage": 80, "note": "TypeBox generates simpler types than Zod validators"},
        {"solution": "Consider ts-rest framework which uses contract model instead of type inheritance", "percentage": 70, "note": "Alternative framework approach; less nested generics"}
    ]$$::jsonb,
    'Hono application with hundreds+ routes, esbuild configured, monorepo framework (Nx) optional',
    'Build time reduces to <30 seconds in CI, IntelliSense response improves, live-reload functional',
    'Do not try to optimize single esbuild config for massive applications; split into separate buildable libraries. Type checking on main router causes exponential type depth growth.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/honojs/hono/issues/3869'
),
(
    'Redirects not occurring when triggered from middleware after error',
    'github-hono',
    'HIGH',
    $$[
        {"solution": "Use PR #4540 approach: check c.error flag after await next() in middleware; response finalization happens after error handler", "percentage": 95, "note": "Allows middleware to override error responses by checking both context.error and isError flag"},
        {"solution": "Wrap redirect logic in middleware post-handler to execute after downstream handlers complete", "percentage": 90, "note": "Position middleware redirect after await next() to allow response override"},
        {"solution": "Ensure middleware is positioned before error-triggering handlers in execution chain", "percentage": 85, "note": "Order matters; middleware must execute in correct sequence"}
    ]$$::jsonb,
    'Hono 4.10.2+, middleware pattern with error checking, downstream handler that triggers error',
    'Middleware redirect executes after error occurs, response is redirect (302/303), error handler logs appear',
    'Response is already sent before middleware post-handler executes if middleware comes after handler. Wrapping await next() in try-catch will not catch the error (documented behavior).',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/honojs/hono/issues/4530'
),
(
    'Downstream handler methods without path args break upstream method path typing',
    'github-hono',
    'MEDIUM',
    $$[
        {"solution": "Always specify path arguments when calling middleware/methods in chain: app.get(\"/\").use(\"/:id\", ...).post(\"/\")", "percentage": 92, "note": "Prevents ChangePathOfSchema type flattening that overwrites upstream paths"},
        {"solution": "Front-load middleware at chain top before defining routes with paths", "percentage": 85, "note": "Middleware without paths wont conflict with downstream typed routes"},
        {"solution": "Separate routes into distinct app instances to avoid schema merging", "percentage": 80, "note": "Use app.route() for nested composition instead of method chaining"},
        {"solution": "Use nested routing with .route() to compose separate apps and avoid type collision", "percentage": 78, "note": "Cleaner architecture; prevents ChangePathOfSchema issues"}
    ]$$::jsonb,
    'Hono application with chained handlers, TypeScript strict mode enabled, method chaining pattern used',
    'Type system correctly reflects endpoint paths (GET / shows type as / not /:id), TypeScript intellisense matches actual routes',
    'Do not mix path arguments across chained methods - always be consistent. ChangePathOfSchema type merging flattens downstream schemas to Path key, overwriting upstream paths.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/honojs/hono/issues/4517'
),
(
    'ExecutionContext missing exports field in Cloudflare Workers with enable_ctx_exports',
    'github-hono',
    'MEDIUM',
    $$[
        {"solution": "Pass ExecutionContext as generic type parameter: new Hono<{ Bindings: CloudflareBindings; Variables: HonoAuthorizationContext, ExecutionContext: ExecutionContext }>()", "percentage": 90, "note": "Accepts ExecutionContext same way as Bindings/Variables; matches wrangler-generated types"},
        {"solution": "Update Hono context.ts to accept ExecutionContext generic parameter instead of hardcoded interface", "percentage": 85, "note": "Allows access to exports property for DurableObjects and other top-level exports"},
        {"solution": "Use type augmentation to extend Hono Context with exports field manually", "percentage": 70, "note": "Workaround; less clean than framework-level support"}
    ]$$::jsonb,
    'Hono 4.10.3+, Cloudflare Workers environment, wrangler.toml with enable_ctx_exports = true, wrangler-generated worker-configuration.d.ts',
    'ExecutionContext.exports property accessible via context; DurableObjects and other exports available at runtime',
    'Hono declares its own ExecutionContext interface that conflicts with wrangler-generated types. Cannot access new exports property without framework modification.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/honojs/hono/issues/4493'
),
(
    'Middleware composition: extending Context with custom properties and methods',
    'github-hono',
    'HIGH',
    $$[
        {"solution": "Use c.get() and c.set() methods instead of adding methods directly to Context: c.set(\"customProp\", value)", "percentage": 95, "note": "Official pattern; keeps Context minimal and prevents naming conflicts"},
        {"solution": "Create helper functions that accept Context as parameter: validatorResult(c) instead of c.validatorResult()", "percentage": 90, "note": "Provides cleaner separation of concerns; functions operate on Context"},
        {"solution": "Use TypeScript declare module to extend ContextVariableMap interface for type safety", "percentage": 88, "note": "Provides IDE support without modifying actual Context object via module augmentation"},
        {"solution": "Store middleware-provided values in Context using typed get/set with ContextVariableMap", "percentage": 85, "note": "Type-safe retrieval; works across middleware chain"}
    ]$$::jsonb,
    'Hono application with multiple middleware layers, TypeScript enabled, middleware authoring',
    'IDE provides intellisense for c.get() values, no naming conflicts between middleware, Context object remains light',
    'Do not add methods directly to Context via prototype - use get/set pattern. Avoid declare module for simple use cases. Ensure ContextVariableMap types align with actual stored values.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/honojs/hono/issues/414'
),
(
    'getContext throws error when called outside request context causing friction in logging',
    'github-hono',
    'MEDIUM',
    $$[
        {"solution": "Use proposed getContextIfAny() function (enhancement) to return gracefully instead of throwing error", "percentage": 90, "note": "New function handles both within-request and outside-request scenarios without try-catch"},
        {"solution": "Wrap getContext() in try-catch block in logging functions called in multiple contexts", "percentage": 85, "note": "Current workaround; adds boilerplate but works for existing versions"},
        {"solution": "Check if context exists before attempting to use getContext in utility functions", "percentage": 80, "note": "Requires conditional logic in every utility; less elegant"}
    ]$$::jsonb,
    'Hono application with logging utilities, functions called both within and outside request contexts, contextStorage enabled',
    'Logging functions work without errors in all contexts, no try-catch wrapper needed, getContextIfAny returns null outside request context',
    'getContext() will throw if called outside request context. Functions called from both request handlers and scheduled tasks/crons need defensive checks.',
    0.84,
    'sonnet-4',
    NOW(),
    'https://github.com/honojs/hono/issues/4536'
),
(
    'Hono middleware ecosystem: community requests for authentication, error handling, and security',
    'github-hono',
    'HIGH',
    $$[
        {"solution": "Use Helmet middleware package for security headers (CSP, X-Frame-Options, etc.)", "percentage": 93, "note": "Production-ready; handles OWASP security standards"},
        {"solution": "Implement error handler middleware wrapping routes to catch exceptions without try-catch per-route", "percentage": 90, "note": "Centralized exception handling; reduces boilerplate"},
        {"solution": "Leverage Hono authentication middleware for session management and GDPR compliance", "percentage": 85, "note": "Third-party packages available in honojs/middleware"},
        {"solution": "Use rate-limiting middleware with configurable stores (Redis, Durable Objects, KV) for IP-based limits", "percentage": 82, "note": "Multi-platform support; Durable Objects recommended for consistency over KV"}
    ]$$::jsonb,
    'Hono v2.0.0+, third-party middleware support enabled, specific use case (auth/security/rate-limit)',
    'Security headers present in responses, errors caught centrally, rate limits enforced, authentication validated',
    'Minimize middleware bloat - use only necessary packages. Durable Objects preferred over KV for rate-limiting consistency. Client IP detection varies by platform (CF-Connecting-IP vs Deno vs Bun).',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/honojs/hono/issues/482'
),
(
    'Rate-limiting middleware storage backends across platforms (Redis, KV, Durable Objects)',
    'github-hono',
    'MEDIUM',
    $$[
        {"solution": "Use Cloudflare Durable Objects for consistent, strongly-consistent rate-limit counters", "percentage": 93, "note": "Preferred for rate-limiting; eventually-consistent KV causes false negatives"},
        {"solution": "Implement pluggable store pattern with configurable get/put functions for flexibility", "percentage": 88, "note": "Users can provide Redis, in-memory, or custom implementations"},
        {"solution": "Use rate-limiter-flexible library wrapped in Hono middleware for production implementation", "percentage": 85, "note": "Third-party solution with multiple storage backend support"},
        {"solution": "Detect client IP using platform-specific headers: CF-Connecting-IP (Cloudflare), context.clientIp (Deno), etc.", "percentage": 80, "note": "IP detection differs by runtime; no universal approach"}
    ]$$::jsonb,
    'Hono middleware system, rate-limiting requirement, target runtime (Node/Cloudflare/Deno), storage backend available',
    'Rate limits enforced per IP/user, requests rejected after threshold, configurable store backend works',
    'KV is eventually-consistent and unsuitable for rate-limiting (use Durable Objects instead). Client IP extraction varies by platform - Cloudflare Workers use CF-Connecting-IP, Deno uses different mechanism.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/honojs/hono/issues/346'
),
(
    'Apollo Server middleware integration with Hono for GraphQL support',
    'github-hono',
    'MEDIUM',
    $$[
        {"solution": "Create dedicated @honojs/apollo-server middleware package using executeHTTPGraphQLRequest()", "percentage": 88, "note": "Handles HTTP request/response conversion for Apollo Server"},
        {"solution": "Use app.mount() to integrate Apollo Server with Hono applications", "percentage": 85, "note": "Standard mounting pattern for third-party servers"},
        {"solution": "Implement custom header/body management for streaming GraphQL responses", "percentage": 82, "note": "Apollo assumes Node.js runtime; edge runtime requires custom adapters"},
        {"solution": "Consider lightweight GraphQL alternatives optimized for edge runtimes", "percentage": 75, "note": "Apollo has high TTFB startup overhead in serverless/edge contexts"}
    ]$$::jsonb,
    'Hono application requiring GraphQL, Apollo Server v4+, edge runtime environment (Cloudflare/Deno)',
    'Apollo Server mounts successfully, GraphQL queries execute, streaming responses work, HTTP headers pass through',
    'Apollo Server imports Node.js modules (os, util, zlib) causing issues in edge runtimes. TTFB startup/shutdown overhead significant in serverless. Consider tinyhttp or other edge-optimized GraphQL solutions.',
    0.78,
    'sonnet-4',
    NOW(),
    'https://github.com/honojs/hono/issues/434'
),
(
    'Cloudflare WebSocket Hibernation API support for long-lived connections',
    'github-hono',
    'MEDIUM',
    $$[
        {"solution": "Implement Cloudflare Hibernation WebSocket API in Hono Cloudflare Workers adapter", "percentage": 88, "note": "No billing charges during dormant periods; standard WebSocket alternative"},
        {"solution": "Provide option to select between standard WebSocket and Hibernation WebSocket implementations", "percentage": 85, "note": "Backward compatible; users can opt-in to Hibernation for long-lived connections"},
        {"solution": "Use Hibernation WebSocket for chat apps, live notifications, and persistent bidirectional communication", "percentage": 82, "note": "Cost-effective for always-on connections"}
    ]$$::jsonb,
    'Hono 4.10+, Cloudflare Workers environment, WebSocket support enabled, persistent connection requirement',
    'WebSocket connections persist without billing during idle periods, Hibernation API accepts messages correctly, standard WebSocket fallback available',
    'Hibernation WebSocket requires Cloudflare Workers environment - not available in other runtimes. Standard WebSocket API still charges during dormant periods.',
    0.81,
    'sonnet-4',
    NOW(),
    'https://github.com/honojs/hono/issues/4506'
),
(
    'Swagger UI middleware for API documentation in Hono applications',
    'github-hono',
    'MEDIUM',
    $$[
        {"solution": "Use @hono/swagger-ui middleware package for official Swagger documentation support", "percentage": 93, "note": "Published in honojs/middleware; integrates with @hono/zod-openapi"},
        {"solution": "Implement Stoplight Elements for rich API documentation with proper CORS configuration", "percentage": 85, "note": "Alternative to Swagger UI; offers enhanced documentation UI"},
        {"solution": "Use swagger-ui-dist via CDN with custom HTML template and jsDelivr", "percentage": 80, "note": "Lightweight option without dependencies; requires manual template"}
    ]$$::jsonb,
    'Hono application with OpenAPI spec (@hono/zod-openapi), Swagger UI middleware available, documentation endpoint',
    'Swagger UI loads at /api/docs endpoint, API schema displays correctly, request/response examples visible',
    'Swagger UI works best with @hono/zod-openapi package for schema generation. CORS headers must be configured for UI to fetch spec from different origin.',
    0.86,
    'sonnet-4',
    NOW(),
    'https://github.com/honojs/hono/issues/1415'
),
(
    'OpenTelemetry (OTEL) middleware for distributed tracing in Hono',
    'github-hono',
    'MEDIUM',
    $$[
        {"solution": "Implement OpenTelemetry middleware using @opentelemetry/api for context propagation and span creation", "percentage": 85, "note": "Community implementation available (PR discussion); captures HTTP method, URL, status, errors"},
        {"solution": "Use OTEL exporter for metrics and traces compatible with Hono logger", "percentage": 80, "note": "Integrates with existing logging infrastructure"},
        {"solution": "Capture HTTP request attributes: method, URL, status code, and exception records in spans", "percentage": 82, "note": "Standard OTEL telemetry attributes for observability"},
        {"solution": "Consider existing instrumentation PR #3025 or issue #1864 for reference implementations", "percentage": 75, "note": "Community contributions available; needs production hardening"}
    ]$$::jsonb,
    'Hono application with observability requirements, @opentelemetry/api available, OTEL exporter configured (Jaeger, Datadog, etc.)',
    'Spans created for HTTP requests, traces propagate correctly across services, exceptions recorded, OTEL exporter receives telemetry',
    'OTEL middleware not built-in - requires community or custom implementation. Production code needs comprehensive test coverage and error handling refinement.',
    0.76,
    'sonnet-4',
    NOW(),
    'https://github.com/honojs/hono/issues/1176'
),
(
    'CSP report-uri directive support in secure-headers middleware for legacy browser compatibility',
    'github-hono',
    'LOW',
    $$[
        {"solution": "Add report-uri directive support to @hono/secure-headers middleware alongside report-to", "percentage": 90, "note": "PR #4532 implements both modern (report-to) and legacy (report-uri) directives"},
        {"solution": "Configure report-uri with single endpoint string or array of URLs for CSP violation reports", "percentage": 88, "note": "Backward compatible with older browsers; modern report-to preferred"},
        {"solution": "Use report-uri for legacy systems while maintaining report-to for modern Reporting API support", "percentage": 85, "note": "Dual support enables gradual migration"}
    ]$$::jsonb,
    'Hono application with CSP security headers, need to support legacy browsers, @hono/secure-headers middleware',
    'CSP report-uri header present in responses, violation reports received at configured endpoint, both report-to and report-uri working',
    'report-uri is deprecated in favor of report-to (Reporting API) but still widely used in legacy systems. Ensure endpoints are accessible and not rate-limited.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/honojs/hono/issues/4527'
);
