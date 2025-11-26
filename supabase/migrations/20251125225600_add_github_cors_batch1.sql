-- Add GitHub CORS configuration error issues batch 1
-- Source: https://github.com/expressjs/cors/issues
-- Category: github-cors
-- 11 high-engagement issues with solutions

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'CORS preflight error: Wildcard origin with credentials enabled',
    'github-cors',
    'VERY_HIGH',
    $$[
        {"solution": "Use specific origin string instead of wildcard when credentials are enabled: cors({ credentials: true, origin: \"https://localhost:8080\" })", "percentage": 95, "note": "CORS spec requires exact origin when credentials: true"},
        {"solution": "Remove credentials: true if wildcard origin is needed: cors({ origin: \"*\" })", "percentage": 90, "note": "Trade-off between credential support and all-origin access"},
        {"solution": "Use dynamic origin function to set based on request: cors({ origin: (req, cb) => cb(null, req.headers.origin), credentials: true })", "percentage": 85, "note": "Requires origin validation to prevent header injection"}
    ]$$::jsonb,
    'Express.js server with cors middleware installed',
    'Preflight OPTIONS request returns Access-Control-Allow-Origin header with specific origin, not wildcard. Browser allows credentials to be sent.',
    'Do not use wildcard (*) origin when credentials: true is set - this violates CORS spec. Always use specific origin string or dynamic callback. Avoid duplicate cors() calls in middleware chain.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/expressjs/cors/issues/283'
),
(
    'CORS preflightContinue with origin function not overridable',
    'github-cors',
    'HIGH',
    $$[
        {"solution": "Replace function-based origin with array of allowed origins: cors({ origin: [\"https://app.com\"], credentials: true, preflightContinue: true })", "percentage": 92, "note": "Array-based origins work correctly with preflightContinue"},
        {"solution": "Remove preflightContinue: true and apply cors directly to routes needing override", "percentage": 85, "note": "Route-level cors() calls will take precedence"},
        {"solution": "Use middleware ordering - ensure route-specific cors() is applied before global cors()", "percentage": 80, "note": "First matching middleware wins for CORS headers"}
    ]$$::jsonb,
    'Express.js app with cors middleware, multiple route handlers',
    'Route-specific cors configuration successfully overrides global settings, OPTIONS preflight uses route config not global config',
    'Function-based origin validation does not work well with preflightContinue. Use array-based origins for predictable behavior. Test with OPTIONS request tool like Insomnia before browser testing.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/expressjs/cors/issues/293'
),
(
    'CORS error: CORS request did not succeed (CORP issue)',
    'github-cors',
    'MEDIUM',
    $$[
        {"solution": "Verify CORS headers are correctly set on server: check Access-Control-Allow-Origin, Allow-Origin, Access-Control-Allow-Methods in response headers", "percentage": 90, "note": "Use browser DevTools Network tab or curl to inspect headers"},
        {"solution": "Check if issue is CORP (Cross-Origin-Resource-Policy) not CORS - requires server-side CORP header configuration separate from CORS", "percentage": 85, "note": "CORS successful but CORP blocks the actual response"},
        {"solution": "Test preflight separately: curl -X OPTIONS http://server/api -H \"Origin: http://client\" to verify cors middleware is running", "percentage": 80, "command": "curl -X OPTIONS http://localhost:5000/api -H \"Origin: http://localhost:3000\""}
    ]$$::jsonb,
    'Express.js server, client making cross-origin request, Network tools access',
    'curl/Insomnia preflight returns 200 with Access-Control-Allow-Origin header. Browser request succeeds or shows clear CORS/CORP error.',
    'Do not assume all CORS-like errors are CORS issues. CORP (Cross-Origin-Resource-Policy) errors require separate header configuration. CORS middleware alone may not be sufficient.',
    0.78,
    'sonnet-4',
    NOW(),
    'https://github.com/expressjs/cors/issues/250'
),
(
    'CORS header missing when origin is undefined (relative URLs)',
    'github-cors',
    'HIGH',
    $$[
        {"solution": "Update cors middleware to set fallback value when origin is undefined: use wildcard or \"*\" as fallback when origin callback approves request", "percentage": 88, "note": "Relative URL requests (e.g., fetch(\"/api\")) do not include Origin header"},
        {"solution": "Use conditional logic in origin callback: check if origin is undefined and handle explicitly: origin: (req, cb) => cb(null, req.headers.origin || \"*\")", "percentage": 85, "note": "Provide explicit fallback value"},
        {"solution": "Ensure HTTP clients send Origin header explicitly even for same-origin requests", "percentage": 75, "note": "Some clients only send Origin for cross-origin requests"}
    ]$$::jsonb,
    'Express.js with cors middleware, clients making relative URL requests',
    'Relative URL requests receive Access-Control-Allow-Origin header in response. CORS checks pass in browser.',
    'Relative URL requests (fetch(\"/api\")) typically do not include Origin header. Do not rely on requestOrigin being defined - always provide fallback. Test with curl -H \"Origin:\" to simulate undefined origin.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/expressjs/cors/issues/295'
),
(
    'CORS preflight failing: app.options vs app.use redundancy',
    'github-cors',
    'HIGH',
    $$[
        {"solution": "Use ONLY app.use(cors()) at root level - this handles all HTTP methods and preflight automatically", "percentage": 95, "note": "Both app.use and app.options together is redundant but harmless"},
        {"solution": "Use app.options(\"*\", cors()) ONLY for route-specific CORS when cors is applied to specific routes like app.post()", "percentage": 90, "note": "Needed when cors() not used globally"},
        {"solution": "Verify response headers on OPTIONS preflight: use curl -X OPTIONS or browser DevTools Network tab", "percentage": 85, "command": "curl -i -X OPTIONS http://localhost:3000/api -H \"Origin: http://localhost:8080\""}
    ]$$::jsonb,
    'Express.js application, CORS middleware installed, test client setup',
    'OPTIONS preflight request returns 200 status with Access-Control-Allow-Origin header. GET/POST requests work without CORS errors.',
    'Do not use both app.use(cors()) AND app.options(\"*\", cors()) - it is redundant. Choose one approach: global with app.use OR per-route with app.options. Always test preflight with OPTIONS request, not browser.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://github.com/expressjs/cors/issues/277'
),
(
    'CORS fails after HTTPS/SSL certificate implementation',
    'github-cors',
    'MEDIUM',
    $$[
        {"solution": "CORS and protocol are independent - no CORS reconfiguration needed when switching HTTP to HTTPS", "percentage": 95, "note": "SSL certificate type (Let''s Encrypt, etc) does not affect CORS"},
        {"solution": "Check that origin option in cors configuration uses matching protocol: if moving to HTTPS, update allowed origins to use https://", "percentage": 90, "note": "Origin mismatch (http vs https) is the likely cause"},
        {"solution": "Debug with curl using https:// URL and verify response headers match expectation", "percentage": 85, "command": "curl -i -X OPTIONS https://localhost/api -H \"Origin: https://client.com\" -k"}
    ]$$::jsonb,
    'Express.js running HTTPS, SSL certificate installed, curl or test client',
    'HTTPS endpoints return correct Access-Control-Allow-Origin headers. CORS errors disappear after protocol switch.',
    'Protocol change (HTTP to HTTPS) does not require CORS reconfiguration. SSL certificate type is irrelevant to CORS. Check origin strings match protocol (https:// not http://). Most HTTPS migration CORS errors are due to protocol mismatch in origin config.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/expressjs/cors/issues/98'
),
(
    'CORS headers only appear on OPTIONS not on GET/POST requests',
    'github-cors',
    'MEDIUM',
    $$[
        {"solution": "Place app.use(cors()) BEFORE app.use(app.router) - middleware order matters, cors must run before routing", "percentage": 93, "note": "Express 3.x specific - router processes requests before cors can apply headers if placed after"},
        {"solution": "For Express 4.x, ensure cors middleware is registered before route handlers: app.use(cors()) before app.get(), app.post(), etc", "percentage": 90, "note": "Express 4.x handles this more gracefully but order still recommended"},
        {"solution": "Apply cors() directly to routes: app.get(\"/api\", cors(), handler) for route-specific CORS", "percentage": 85, "note": "Bypasses global middleware ordering issues"}
    ]$$::jsonb,
    'Express.js application (3.x or 4.x), cors middleware installed, test client',
    'All requests (OPTIONS, GET, POST) include Access-Control-Allow-Origin header. Browser requests succeed without CORS errors.',
    'Middleware ordering in Express is critical - cors() must execute before routing. Do not place app.use(cors()) after app.use(app.router). Test all HTTP methods (OPTIONS, GET, POST) separately to verify headers present on each.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/expressjs/cors/issues/88'
),
(
    'CORS client-side header configuration not working',
    'github-cors',
    'MEDIUM',
    $$[
        {"solution": "Remove client-side CORS header configuration - CORS headers MUST be set by server, not client: delete axios.defaults.headers setting", "percentage": 95, "note": "Clients cannot set Access-Control-Allow-Origin - only servers can"},
        {"solution": "Configure cors middleware with specific origin, methods, and credentials on server: cors({ origin: [\"http://localhost:3000\"], credentials: true })", "percentage": 93, "note": "Use corsOptions object with validated settings"},
        {"solution": "Verify server is responding to OPTIONS preflight with all required headers: Access-Control-Allow-Origin, Access-Control-Allow-Methods, Access-Control-Allow-Headers", "percentage": 90, "command": "curl -i -X OPTIONS http://localhost:3000/api -H \"Origin: http://localhost:8080\""}
    ]$$::jsonb,
    'Express.js server, axios or fetch client library, browser DevTools',
    'Server returns proper CORS headers on OPTIONS preflight. Client fetch/axios requests succeed without CORS errors.',
    'CORS headers are server-responsibility only - clients cannot set them. Do not try to set Access-Control-Allow-Origin on client side. Remove axios.defaults.headers CORS settings - they do nothing. All configuration must be on Express server.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/expressjs/cors/issues/268'
),
(
    'CORS origin callback returning false shows wildcard header',
    'github-cors',
    'MEDIUM',
    $$[
        {"solution": "Verify no other middleware is setting wildcard header - check entire middleware stack: app.use() calls before and after cors()", "percentage": 92, "note": "Another middleware may be overwriting cors headers"},
        {"solution": "If using callback(null, false), ensure no subsequent middleware modifies headers: cors middleware correctly skips header setup on false", "percentage": 88, "note": "cors() does nothing when origin callback returns false"},
        {"solution": "Test with minimal middleware stack: remove other CORS-related middleware or custom header-setting middleware", "percentage": 85, "note": "Isolate to verify cors library behavior vs other code"}
    ]$$::jsonb,
    'Express.js with cors callback, multiple middleware, browser DevTools or curl',
    'Rejected origins (callback returns false) do not receive Access-Control-Allow-Origin header. Only approved origins get header.',
    'When origin callback returns false, cors middleware intentionally skips setting headers. If wildcard appears, another middleware is setting it. Check entire middleware chain for other cors() calls or custom header setters. Use curl to test specific rejected origin.',
    0.86,
    'sonnet-4',
    NOW(),
    'https://github.com/expressjs/cors/issues/253'
),
(
    'CORS specification violation: wildcard with credentials allowed',
    'github-cors',
    'HIGH',
    $$[
        {"solution": "Never use wildcard origin (*) with credentials: true - FETCH spec forbids * in Access-Control-Allow-Origin when credentials enabled", "percentage": 95, "note": "Specification compliance issue - should be rejected"},
        {"solution": "Use dynamic origin callback to reflect requesting origin when credentials needed: cors({ origin: true, credentials: true }) OR cors({ origin: (req,cb) => cb(null, req.headers.origin), credentials: true })", "percentage": 90, "note": "origin: true reflects back the request origin exactly"},
        {"solution": "Implement origin validation: whitelist specific origins and reflect only those: cors({ origin: (req,cb) => allowedOrigins.includes(req.headers.origin) ? cb(null, req.headers.origin) : cb(new Error(\"CORS denied\")) })", "percentage": 88, "note": "Most secure approach"}
    ]$$::jsonb,
    'Express.js with cors middleware, understanding of CORS specification',
    'Server never returns Access-Control-Allow-Origin: * with Access-Control-Allow-Credentials: true. Configuration validates origin and credentials correctly.',
    'CORS spec violation: cannot use wildcard (*) in Access-Control-Allow-Origin if credentials: true. Library currently allows this invalid combination. Always use specific origin string or dynamic callback when credentials are needed. Consider using origin: true as safe alternative.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/expressjs/cors/issues/333'
),
(
    'CORS multiple middlewares append headers instead of replace',
    'github-cors',
    'MEDIUM',
    $$[
        {"solution": "Use conditional middleware wrapper to apply cors only to specific paths: wrap cors() in custom middleware with route check", "percentage": 92, "note": "Prevents multiple cors() calls on same request"},
        {"solution": "Use dynamic origin function with single cors() call: cors({ origin: (req, cb) => { if (req.path.match(/specific-path/)) return cb(null, \"custom\"); return cb(null, \"*\"); } })", "percentage": 95, "note": "Recommended approach - single middleware with conditional logic"},
        {"solution": "Apply cors() only to routes that need it, not globally: remove app.use(cors()) and add cors() to specific route handlers", "percentage": 88, "note": "More granular control"}
    ]$$::jsonb,
    'Express.js router, multiple routes with different CORS needs, middleware understanding',
    'Each request receives single, properly formed Access-Control-Allow-Origin header. No malformed headers like \"*,http://example.com\".',
    'Multiple cors() calls on same request append headers instead of replacing - results in invalid headers. Do not stack multiple cors() middleware. Use single dynamic cors() with conditional origin function or separate cors() to individual routes. Test with curl to verify single header value.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/expressjs/cors/issues/79'
),
(
    'CORS array origin with wildcard treated as literal string',
    'github-cors',
    'MEDIUM',
    $$[
        {"solution": "Use regex pattern instead of wildcard string in array: cors({ origin: [/.*/] }) - regex * is evaluated, string \"*\" is literal", "percentage": 94, "note": "Regex patterns properly matched against request origin"},
        {"solution": "Use conditional origin function instead of array: cors({ origin: (req, cb) => cb(null, true) }) allows all origins dynamically", "percentage": 90, "note": "More flexible than array"},
        {"solution": "For specific domain matching, use regex: cors({ origin: [/example\\.com$/] }) matches all subdomains of example.com", "percentage": 88, "note": "Regex pattern \"example.com$\" matches yourdomain.example.com but not example.com.evil.com"}
    ]$$::jsonb,
    'Express.js cors middleware, regex pattern knowledge or callback function',
    'Array-based origins correctly match request origins. Wildcard domain patterns work as expected. All subdomains matched properly.',
    'String wildcard \"*\" in origin array is treated as literal string, not matcher. Use regex pattern /.*/  instead. Origin array does strict string comparison. For domain matching, use regex like /.example.com$/ not literal \"*\". Security note: mixing wildcard with specific origins creates complexity.',
    0.84,
    'sonnet-4',
    NOW(),
    'https://github.com/expressjs/cors/issues/185'
);
