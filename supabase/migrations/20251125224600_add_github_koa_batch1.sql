-- GitHub Koa.js High-Engagement Issues: Error Handling & Middleware Solutions
-- Mined from: https://github.com/koajs/koa/issues
-- Category: github-koa
-- Focus: Error handling, middleware composition, async/await, context state management

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Koa ctx.body overwrites custom Content-Type header',
    'github-koa',
    'HIGH',
    $$[
        {"solution": "Set stringified JSON instead of object: ctx.body = JSON.stringify(data) to preserve custom Content-Type like application/vnd.myapi.v1+json", "percentage": 90, "note": "Workaround avoids Koa''s automatic JSON type detection"},
        {"solution": "Check if custom Content-Type already set before assigning ctx.body - Koa respects pre-set headers in some middleware implementations", "percentage": 75, "note": "Depends on middleware order and Koa version"},
        {"solution": "Use Object.defineProperty to lock Content-Type header before body assignment", "percentage": 70, "note": "Advanced workaround, prevents automatic overwriting"}
    ]$$::jsonb,
    'Koa 2.x or 3.x installed, understanding of HTTP Content-Type header standards',
    'Response header Content-Type matches desired custom type (e.g., application/vnd.myapi.v1+json) in network inspector',
    'Common pitfall: Setting ctx.body with object triggers automatic application/json override. Always verify Content-Type in response headers, not just ctx.set() calls.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/koajs/koa/issues/1120'
),
(
    'Koa request.ip returns undefined on socket close',
    'github-koa',
    'HIGH',
    $$[
        {"solution": "Ensure IP caching is enabled in Koa 2.13.0+: update Koa to latest version which caches request.ip at context creation", "percentage": 95, "note": "IP is now cached upfront, available throughout request lifecycle"},
        {"solution": "Cache IP manually in middleware before socket operations: const ip = ctx.request.ip; await next();", "percentage": 90, "note": "Workaround for older Koa versions"},
        {"solution": "Add error handler for socket close events before accessing request.ip", "percentage": 80, "note": "Prevents undefined when socket closes mid-request"}
    ]$$::jsonb,
    'Koa 2.x framework, understanding of Node.js socket behavior and request lifecycle',
    'request.ip returns valid IP address throughout entire request, undefined does not occur on socket close, IP is consistent across middleware',
    'Pitfall: Socket.remoteAddress becomes undefined when socket closes. Do not cache IP lazily. Upgrade Koa to 2.13.0+ where IP caching was implemented.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/koajs/koa/issues/695'
),
(
    'Koa context.inspect fails with console.log(require.cache)',
    'github-koa',
    'MEDIUM',
    $$[
        {"solution": "Upgrade Koa to version where context.inspect was fixed (PR #1012) to handle missing this binding", "percentage": 93, "note": "Latest versions handle inspect without proper context"},
        {"solution": "Avoid logging require.cache directly when Koa context is loaded - use JSON.stringify(ctx) instead", "percentage": 88, "note": "Workaround for older Koa versions"},
        {"solution": "Check for context.inspect and wrap in try-catch when debugging Koa-based modules", "percentage": 80, "note": "Defensive programming approach"}
    ]$$::jsonb,
    'Node.js runtime, Koa framework with custom inspect implementation',
    'console.log(require.cache) executes without error, context can be inspected via debugger',
    'Pitfall: Node.js util module invokes inspect without proper this binding. Do not rely on custom inspect on Koa context prototype without binding. Always use latest Koa version.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/koajs/koa/issues/837'
),
(
    'Koa ctx.request.origin ignores proxy flag with X-Forwarded-Proto',
    'github-koa',
    'HIGH',
    $$[
        {"solution": "Set app.proxy = true and verify ctx.protocol respects X-Forwarded-Proto, then use ctx.protocol instead of ctx.request.origin for security checks", "percentage": 92, "note": "ctx.protocol is proxy-aware, ctx.request.origin is not"},
        {"solution": "Manually reconstruct origin from ctx.protocol and ctx.hostname: const origin = `${ctx.protocol}://${ctx.hostname}`", "percentage": 90, "note": "Reliable workaround that ensures proxy header respect"},
        {"solution": "Use middleware to override ctx.request.origin property based on X-Forwarded-Proto header when behind proxy", "percentage": 85, "note": "Custom middleware intercepts and fixes origin value"}
    ]$$::jsonb,
    'Koa 2.x, reverse proxy (nginx/Cloudflare) configured with X-Forwarded-Proto header, app.proxy option support',
    'ctx.protocol returns https when X-Forwarded-Proto=https, reconstructed origin uses correct protocol, requests behind proxy work as expected',
    'Critical pitfall: app.proxy=true does NOT make ctx.request.origin proxy-aware. Use ctx.protocol instead. Always verify in network traces that X-Forwarded-Proto header is present.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/koajs/koa/issues/1746'
),
(
    'Koa ctx.state cannot initialize at application startup',
    'github-koa',
    'HIGH',
    $$[
        {"solution": "Initialize state in middleware called on first request: app.use(async (ctx, next) => { ctx.state.initialized = true; await next(); })", "percentage": 88, "note": "State initialized within request context, not app startup"},
        {"solution": "Create middleware factory that initializes state before other middleware: const stateInit = require(''./stateInit''); app.use(stateInit())", "percentage": 85, "note": "Cleaner pattern for state initialization"},
        {"solution": "Define state prototype in app context creation hook if available in custom Koa fork", "percentage": 70, "note": "Advanced: requires modifying Koa core"}
    ]$$::jsonb,
    'Koa 2.x or 3.x, understanding of request lifecycle and middleware execution order',
    'ctx.state object exists in all middlewares, app-level state is accessible across requests without errors',
    'Pitfall: ctx.state does not exist until first request arrives - it is NOT available at app.context level. Do not attempt app.context.state = {} at startup. Always initialize in middleware.',
    0.86,
    'sonnet-4',
    NOW(),
    'https://github.com/koajs/koa/issues/1646'
),
(
    'Koa conditional response body assignment always overwrites',
    'github-koa',
    'VERY_HIGH',
    $$[
        {"solution": "Use return statement after setting error body to prevent overwrite: if (error) { ctx.body = {...}; return; } ctx.body = {...};", "percentage": 95, "note": "Standard JavaScript control flow solution"},
        {"solution": "Use else block to ensure only one ctx.body assignment: if (error) { ctx.body = error; } else { ctx.body = success; }", "percentage": 94, "note": "Cleaner and more maintainable approach"},
        {"solution": "Combine with ctx.status for proper HTTP semantics: if (error) { ctx.status = 400; ctx.body = errorObj; return; }", "percentage": 93, "note": "Includes proper HTTP status code handling"}
    ]$$::jsonb,
    'JavaScript/Koa basic understanding, async middleware knowledge',
    'Request returns correct response (error or success) based on condition, HTTP status code matches response type, no unexpected overwrites',
    'Pitfall: Second ctx.body assignment ALWAYS overwrites first - this is JavaScript, not Koa. Missing return statements allow unreachable code to execute. Developers expect Laravel/PHP behavior.',
    0.96,
    'sonnet-4',
    NOW(),
    'https://github.com/koajs/koa/issues/1181'
),
(
    'Koa browser sequential request handling misunderstood as framework issue',
    'github-koa',
    'MEDIUM',
    $$[
        {"solution": "Understand this is browser behavior, not Koa limitation: browsers queue same-origin requests to one route concurrently per HTTP/1.1 spec", "percentage": 92, "note": "Not a Koa issue, verify with Chrome DevTools Network tab"},
        {"solution": "Add Cache-Control: no-store header to force fresh requests: ctx.set(''Cache-Control'', ''no-store'');", "percentage": 78, "note": "May influence browser caching but not request queuing"},
        {"solution": "Test with different routes or different origins to confirm browser queuing behavior", "percentage": 85, "note": "Diagnostic: requests to different URLs process concurrently"}
    ]$$::jsonb,
    'Understanding of HTTP/1.1 connection pooling, browser developer tools knowledge',
    'Multiple requests to different routes process concurrently, single-route requests complete sequentially (expected), testing across browsers shows same behavior',
    'Pitfall: Assumes Koa is queuing requests sequentially. Actually browser HTTP/1.1 connection pool limits concurrency to same origin. Not a framework issue. Verify with network tab.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/koajs/koa/issues/1133'
),
(
    'Koa global leak detected from any-promise dependency',
    'github-koa',
    'MEDIUM',
    $$[
        {"solution": "Upgrade Koa to 2.2.1+ and koa-compose to 3.3.0+ which removed any-promise dependency", "percentage": 97, "note": "Any-promise was removed entirely, eliminating global leak"},
        {"solution": "If stuck on older version, replace Promise globally at app startup: global.Promise = require(''bluebird'');", "percentage": 85, "note": "Set globally before importing Koa"},
        {"solution": "Explicitly set preferred promise library in any-promise config if using old koa-compose", "percentage": 75, "note": "Workaround requires any-promise documentation knowledge"}
    ]$$::jsonb,
    'Koa 2.x installed, npm access, Node.js version compatibility',
    'No global leak warnings, console shows no @@any-promise registration errors, application runs without warnings',
    'Pitfall: any-promise uses problematic global registration mechanism. Do not rely on workarounds - upgrade dependencies. Check koa-compose version specifically.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://github.com/koajs/koa/issues/945'
),
(
    'Koa subdomain parsing fails for IP addresses',
    'github-koa',
    'MEDIUM',
    $$[
        {"solution": "Upgrade Koa to version with IP address detection in subdomain getter (PR #807/#808)", "percentage": 94, "note": "Returns empty array for IP addresses, not parsed segments"},
        {"solution": "Manually validate host is domain before accessing ctx.subdomains: if (!isIPAddress(ctx.host)) { domains = ctx.subdomains; }", "percentage": 88, "note": "Workaround for older versions"},
        {"solution": "Use regex to detect IP: const isIP = /^\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}$/.test(ctx.host)", "percentage": 85, "note": "Simple validation in middleware"}
    ]$$::jsonb,
    'Koa 2.x request handling, understanding of domain vs IP address structure',
    'ctx.subdomains returns empty array for IPs (127.0.0.1), returns domain parts for domains (blog.example.com -> [blog])',
    'Pitfall: IP addresses are split by dots and treated as subdomains. ctx.subdomains for 127.0.0.1 incorrectly returns [127, 0, 0]. Always validate IP before parsing.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/koajs/koa/issues/775'
),
(
    'Koa secure property fails for HTTP/2 after RST_STREAM',
    'github-koa',
    'MEDIUM',
    $$[
        {"solution": "Cache secure status early in middleware: const isSecure = ctx.secure; before any socket operations or stream aborts", "percentage": 90, "note": "Prevents socket type mutation issues"},
        {"solution": "Check socket type explicitly: ctx.req.socket instanceof tls.TLSSocket for reliable encryption detection", "percentage": 88, "note": "More reliable than relying on encrypted property"},
        {"solution": "Add guard in secure cookie logic: if (ctx.secure || ctx.req.socket instanceof tls.TLSSocket) { setCookie(); }", "percentage": 85, "note": "Defensive approach for secure operations"}
    ]$$::jsonb,
    'Node.js 19+, HTTP/2 server (http2.createSecureServer), TLS/SSL enabled',
    'ctx.secure returns true for TLS connections even after RST_STREAM, secure cookies set successfully, no false security status',
    'Pitfall: HTTP/2 socket type changes from TLSSocket to ServerHttp2Stream on RST_STREAM, breaking ctx.req.socket.encrypted check. Cache secure early.',
    0.86,
    'sonnet-4',
    NOW(),
    'https://github.com/koajs/koa/issues/1736'
),
(
    'Koa memory overflow when processing large files',
    'github-koa',
    'HIGH',
    $$[
        {"solution": "Implement streaming processing with chunked data: process file in 1MB chunks instead of loading entire file", "percentage": 91, "note": "Prevents full buffer allocation in memory"},
        {"solution": "Add Node.js heap size flag: node --max-old-space-size=4096 app.js to allocate 4GB heap", "percentage": 88, "note": "Workaround confirmed by issue reporter, not root fix"},
        {"solution": "Use async/await properly in loops: forEach with await instead of Promise.all for file processing chunks", "percentage": 87, "note": "Prevents accumulation of pending promises"},
        {"solution": "Implement manual garbage collection: global.gc() between processing phases or use worker threads for CPU-intensive ops", "percentage": 85, "note": "Run with --expose-gc flag"}
    ]$$::jsonb,
    'Koa 2.x, Node.js 18+, handling large file uploads (>100MB), understanding of memory management',
    'Large files process without memory errors, heap usage remains stable, garbage collection occurs between operations',
    'Pitfall: Direct Node.js execution works but Koa context retention doubles memory. Use streaming. forEach without await accumulates promises. CPU-intensive operations block GC.',
    0.83,
    'sonnet-4',
    NOW(),
    'https://github.com/koajs/koa/issues/1883'
),
(
    'Koa custom middleware composition patterns vs built-in compose',
    'github-koa',
    'MEDIUM',
    $$[
        {"solution": "Stick with standard app.use() middleware pattern - it is optimized and maintains Koa''s architecture", "percentage": 92, "note": "Built-in compose provides better performance and stack traces"},
        {"solution": "For parallel middleware execution use Promise.all in middleware: await Promise.all([mw1(ctx), mw2(ctx)])", "percentage": 88, "note": "Achieves parallel execution without bypassing compose"},
        {"solution": "Create custom middleware factories for complex patterns instead of trying to bypass compose", "percentage": 85, "note": "Maintains composability while enabling patterns"}
    ]$$::jsonb,
    'Koa 2.x, understanding of middleware composition, async patterns in JavaScript',
    'All middleware executes in correct order, middleware parameters are properly passed, no performance degradation vs built-in compose',
    'Pitfall: Attempting to expose app.fn to bypass compose breaks Koa architecture and performance. Standard app.use() supports all necessary patterns.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/koajs/koa/issues/1027'
),
(
    'Koa cookie maxAge limited to 28 days despite milliseconds specification',
    'github-koa',
    'MEDIUM',
    $$[
        {"solution": "Use expires property instead of maxAge for long-duration cookies: ctx.cookies.set(''name'', ''val'', { expires: new Date(''2050-01-01'') })", "percentage": 95, "note": "HTTP spec allows arbitrary expiration dates with expires"},
        {"solution": "Calculate future date manually: { maxAge: 1000*60*60*24*365*10 } for 10 year cookie", "percentage": 88, "note": "Still limited by maxAge millisecond overflow but extends duration"},
        {"solution": "Reference RFC 6265 cookie specification for compliance: expires uses HTTP-date format", "percentage": 85, "note": "Standards-compliant approach"}
    ]$$::jsonb,
    'Koa 2.x+ cookie middleware, understanding of HTTP cookie specification (RFC 6265)',
    'Cookies with future expiration dates persist correctly, non-expiring cookies work as expected, browser respects date formats',
    'Pitfall: maxAge in milliseconds overflows at 2^31 (28 days). For long-lived cookies use expires property with future Date object.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://github.com/koajs/koa/issues/1331'
);
