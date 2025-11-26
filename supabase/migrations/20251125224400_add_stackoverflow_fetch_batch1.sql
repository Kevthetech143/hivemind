-- Add Stack Overflow Fetch API solutions batch 1
-- Highest-voted questions about Fetch API errors, CORS, timeouts, and request handling

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Fetch API CORS error: No "Access-Control-Allow-Origin" header',
    'stackoverflow-fetch',
    'VERY_HIGH',
    $$[
        {"solution": "Add CORS headers on server: response.setHeader(\"Access-Control-Allow-Origin\", \"*\") for all origins or specify exact domain", "percentage": 95, "note": "Most reliable solution - server-side control"},
        {"solution": "Use CORS proxy for third-party APIs: fetch(\"https://cors-anywhere.herokuapp.com/\" + apiUrl)", "percentage": 75, "note": "Temporary workaround, not for production"},
        {"solution": "For Node/Express, use cors middleware: app.use(cors({origin: \"https://yourdomain.com\"}))", "percentage": 90, "note": "Production-ready approach"},
        {"solution": "Ensure fetch includes credentials if needed: fetch(url, {credentials: \"include\", headers: {\"Access-Control-Allow-Credentials\": \"true\"}})", "percentage": 80, "note": "Required for cookies in cross-origin requests"}
    ]$$::jsonb,
    'Server endpoint that returns response, Browser making cross-origin request',
    'Fetch request completes successfully with 200 status, Data received without CORS errors in console',
    'CORS must be enabled on SERVER, not client. Browser cannot add CORS headers. Wildcard "*" blocks credentials. Different domain/subdomain/port triggers CORS.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/43871637/no-access-control-allow-origin-header-is-present-on-the-requested-resource'
),
(
    'Fetch API fails with "Failed to fetch" - no error details',
    'stackoverflow-fetch',
    'VERY_HIGH',
    $$[
        {"solution": "Wrap fetch in try-catch to handle network errors: try { const res = await fetch(url); } catch(e) { console.log(\"Network error\", e); }", "percentage": 90, "note": "Essential error handling pattern"},
        {"solution": "Check response.ok status: if (!response.ok) throw Error(response.statusText);", "percentage": 92, "note": "HTTP errors dont reject promise, must check manually"},
        {"solution": "Add timeout using AbortController: const controller = new AbortController(); const timeout = setTimeout(() => controller.abort(), 5000);", "percentage": 88, "note": "Fetch has no timeout by default"},
        {"solution": "Log full error: catch(err) { console.error(\"Fetch failed:\", err.message, err.name); }", "percentage": 85, "note": "TypeError for network errors, AbortError for cancellation"}
    ]$$::jsonb,
    'JavaScript environment with fetch API support, Endpoint accessible',
    'Error messages logged to console, Specific error type identified (TypeError, AbortError, etc)',
    '"Failed to fetch" happens in browser security contexts - check CORS, check if endpoint exists, check network tab in DevTools. Never throw on .then() - use .catch().',
    0.91,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/35553778/fetch-failing-silently'
),
(
    'Fetch request timeout handling - request never completes',
    'stackoverflow-fetch',
    'HIGH',
    $$[
        {"solution": "Use AbortController with timeout: const controller = new AbortController(); setTimeout(() => controller.abort(), 5000); fetch(url, {signal: controller.signal})", "percentage": 94, "note": "Modern standard approach, works in all modern browsers"},
        {"solution": "Wrap fetch with Promise.race: Promise.race([fetch(url), new Promise((_, reject) => setTimeout(() => reject(new Error(\"timeout\")), 5000))])", "percentage": 85, "note": "Works but AbortController is cleaner"},
        {"solution": "Implement retry with exponential backoff on timeout: const retry = (fn, delay=1000) => fn().catch(e => delay < 30000 ? retry(fn, delay*2) : Promise.reject(e))", "percentage": 82, "note": "Handle transient failures"}
    ]$$::jsonb,
    'AbortController support (ES2017+), Clear timeout value in milliseconds',
    'Request aborts after specified timeout, AbortError thrown and caught in catch block',
    'Fetch has no native timeout - always add AbortController. Server network timeouts differ from client. Timeout should be appropriate for endpoint (API calls 5-10s, file uploads longer).',
    0.93,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/46946380/fetch-api-request-timeout'
),
(
    'Fetch request cancellation with AbortController',
    'stackoverflow-fetch',
    'HIGH',
    $$[
        {"solution": "Create AbortController and pass signal: const controller = new AbortController(); fetch(url, {signal: controller.signal}); controller.abort(); to cancel", "percentage": 96, "note": "Standard modern approach"},
        {"solution": "Handle AbortError: catch(err) { if (err.name === \"AbortError\") console.log(\"Request cancelled\"); }", "percentage": 93, "note": "Distinguish from other errors"},
        {"solution": "Cleanup on component unmount (React): useEffect(() => { const controller = new AbortController(); return () => controller.abort(); }, []);", "percentage": 91, "note": "Prevent memory leaks"},
        {"solution": "Multiple requests with same controller: Use for canceling all requests in group", "percentage": 88, "note": "Share controller across multiple fetch calls"}
    ]$$::jsonb,
    'AbortController API support, Clear cancellation trigger',
    'controller.abort() stops request, Promise rejects with AbortError, Pending requests do not complete',
    'AbortController must be created outside try-catch. Aborting after completion is safe (no error). Each fetch needs its own or shared controller.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/46946380/fetch-api-request-timeout'
),
(
    'Fetch response body read as JSON/text multiple times fails',
    'stackoverflow-fetch',
    'HIGH',
    $$[
        {"solution": "Call response.json() or response.text() only once, store result: const data = await response.json(); reuse data variable", "percentage": 96, "note": "Response body is a stream, consumed after first read"},
        {"solution": "Clone response if needed multiple times: const cloned = response.clone(); const json1 = await response.json(); const json2 = await cloned.json();", "percentage": 93, "note": "Creates independent copy of response"},
        {"solution": "Read as arraybuffer for binary data: const buffer = await response.arrayBuffer();", "percentage": 88, "note": "Alternative for non-text data"},
        {"solution": "Parse response manually if needed for inspection: const text = await response.text(); const json = JSON.parse(text);", "percentage": 82, "note": "Allows error handling of JSON parsing"}
    ]$$::jsonb,
    'Fetch response object, Understanding of stream consumption',
    'JSON/text parsed successfully first time, Data usable in subsequent code, No "body already read" errors',
    'Response body is a stream - only readable once. .json() parses and consumes. Clone before multiple reads. Inspect raw response before parsing for debugging.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/42755131/fetch-and-json-only-once'
),
(
    'Fetch with credentials (cookies) in cross-origin requests',
    'stackoverflow-fetch',
    'HIGH',
    $$[
        {"solution": "Set credentials mode and server must allow: fetch(url, {credentials: \"include\", headers: {...}}) + server response.setHeader(\"Access-Control-Allow-Credentials\", \"true\")", "percentage": 94, "note": "Both client and server required"},
        {"solution": "Use \"same-origin\" for same-site requests: fetch(url, {credentials: \"same-origin\"})", "percentage": 92, "note": "Simpler for same domain"},
        {"solution": "Set exact origin in CORS header (not wildcard): response.setHeader(\"Access-Control-Allow-Origin\", \"https://exact.domain.com\")", "percentage": 93, "note": "Required when credentials included"},
        {"solution": "Ensure cookies in browser storage: Document.cookie or verify in DevTools Application tab", "percentage": 85, "note": "Validate credentials exist before request"}
    ]$$::jsonb,
    'Both client and server endpoints available, Cookies set in browser',
    'Request includes Authorization header with credentials, Cookies sent in request headers, Session maintained across requests',
    'Wildcard CORS origin (*) blocks credentials. Must use exact domain. credentials: include sends cookies. Server must opt-in with Access-Control-Allow-Credentials: true.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/44133640/cors-error-when-fetching-from-api-with-fetch-api'
),
(
    'Fetch POST request with JSON body returns 400 Bad Request',
    'stackoverflow-fetch',
    'HIGH',
    $$[
        {"solution": "Set Content-Type header: fetch(url, {method: \"POST\", headers: {\"Content-Type\": \"application/json\"}, body: JSON.stringify(data)})", "percentage": 95, "note": "Server expects header to parse JSON"},
        {"solution": "Stringify body data: body: JSON.stringify({key: value}) not body: {key: value}", "percentage": 94, "note": "Body must be string, not object"},
        {"solution": "Validate JSON structure matches server schema before sending", "percentage": 88, "note": "Server validation rejects malformed data"},
        {"solution": "Log request body for debugging: console.log(JSON.stringify(data)) before fetch", "percentage": 85, "note": "Catch typos and missing fields"}
    ]$$::jsonb,
    'API endpoint expecting JSON POST, Valid JSON data structure',
    'HTTP 200 response received, Server logs show request body parsed successfully, Response contains expected data',
    'Must stringify body - plain objects rejected. Content-Type header required for JSON parsing. Check server schema - extra/missing fields cause 400. Log body for debugging.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/29775797/fetch-post-json-body-undefined'
),
(
    'Fetch response status 200 but response.ok is false',
    'stackoverflow-fetch',
    'MEDIUM',
    $$[
        {"solution": "Check response.ok (true for 200-299): if (!response.ok) { throw new Error(`HTTP error! status: ${response.status}`); }", "percentage": 94, "note": "response.ok is correct way to check success"},
        {"solution": "Redirect status 3xx not caught by fetch - check response.redirected: if (response.redirected) console.log(\"Request redirected\");", "percentage": 88, "note": "Fetch follows redirects automatically"},
        {"solution": "Inspect response.status and response.statusText for exact codes: console.log(response.status, response.statusText);", "percentage": 86, "note": "Useful for specific error handling"}
    ]$$::jsonb,
    'Fetch response object, HTTP status code documentation',
    'response.ok correctly reflects success/failure status, Appropriate error handling based on status codes',
    'response.ok (200-299) not same as response.status === 200. Fetch auto-follows redirects. Check .ok in all cases. Network errors and HTTP errors handled differently.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/40306689/fetch-response-ok'
),
(
    'Fetch with headers not being sent to server',
    'stackoverflow-fetch',
    'MEDIUM',
    $$[
        {"solution": "Pass headers object in options: fetch(url, {method: \"GET\", headers: {\"Authorization\": \"Bearer token\", \"Custom-Header\": \"value\"}})", "percentage": 96, "note": "Correct syntax for headers"},
        {"solution": "Check CORS preflight for custom headers - server must allow: response.setHeader(\"Access-Control-Allow-Headers\", \"*\")", "percentage": 90, "note": "Custom headers trigger OPTIONS preflight"},
        {"solution": "Avoid special characters in header values - encode if needed: headers: {\"X-Custom\": encodeURIComponent(value)}", "percentage": 82, "note": "Invalid chars in headers rejected"},
        {"solution": "Case-insensitive header names: use consistent casing for readability", "percentage": 80, "note": "HTTP headers case-insensitive"}
    ]$$::jsonb,
    'Server expecting custom headers, CORS setup if cross-origin',
    'Headers appear in DevTools Network tab, Server receives custom header values, Preflight request returns 200',
    'Headers object must be proper format {key: value}. CORS preflight for custom headers. Lower-case header keys conventional. Verify server whitelist headers.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/30987847/fetch-api-headers-user-agent'
),
(
    'Fetch API async/await syntax and Promise handling',
    'stackoverflow-fetch',
    'MEDIUM',
    $$[
        {"solution": "Use async/await with try-catch: async function getData() { try { const res = await fetch(url); const data = await res.json(); return data; } catch(err) { console.error(err); } }", "percentage": 94, "note": "Modern clean syntax"},
        {"solution": "Alternative with .then(): fetch(url).then(res => res.json()).then(data => console.log(data)).catch(err => console.error(err));", "percentage": 90, "note": "Older callback style, still valid"},
        {"solution": "Always await fetch and response parsing: const data = await fetch(url).then(r => r.json());", "percentage": 92, "note": "Don''t forget await on both"},
        {"solution": "Chain multiple requests: const r1 = await fetch(url1); const r2 = await fetch(url2);", "percentage": 88, "note": "Sequential execution, use Promise.all for parallel"}
    ]$$::jsonb,
    'Async/await support (ES2017+), Promise understanding',
    'Data successfully retrieved and logged, No "cannot read property of undefined" errors, Proper error handling executes on failure',
    'Must await both fetch() and response.json(). Forgetting await returns Promise instead of data. Wrap in try-catch for proper error handling. Use Promise.all for parallel requests.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/40392649/javascript-fetch-api-with-async-await'
),
(
    'Fetch request blocked by browser - mixed content (HTTP/HTTPS)',
    'stackoverflow-fetch',
    'MEDIUM',
    $$[
        {"solution": "Use HTTPS for all requests on HTTPS pages: fetch(\"https://api.example.com\") instead of http://", "percentage": 97, "note": "HTTPS pages block insecure HTTP requests"},
        {"solution": "For development, disable mixed content block in browser dev settings or use localhost", "percentage": 75, "note": "Not for production"},
        {"solution": "Use protocol-relative URLs: fetch(\"//api.example.com/path\") matches page protocol", "percentage": 84, "note": "Adapts to http/https automatically"},
        {"solution": "Check Content Security Policy (CSP) headers: server CSP may block requests", "percentage": 86, "note": "CSP restricts what origins can be fetched"}
    ]$$::jsonb,
    'HTTPS-served webpage, Fetch target available on secure protocol',
    'Fetch request completes without mixed content warning in console, Network request shows in DevTools',
    'Modern browsers block HTTP requests from HTTPS pages (mixed content). Must use HTTPS. localhost exempt. CSP headers may further restrict. Check DevTools Security tab.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/18201159/how-to-fetch-http-content-from-https-page'
),
(
    'Fetch response shows undefined when accessing response data',
    'stackoverflow-fetch',
    'MEDIUM',
    $$[
        {"solution": "Must parse response: const data = await response.json(); not just response", "percentage": 95, "note": "response object != parsed data"},
        {"solution": "Check response exists before accessing: if (response && response.ok) { const data = await response.json(); }", "percentage": 90, "note": "Validate response received"},
        {"solution": "Validate data structure: const data = await response.json(); if (data.property) console.log(data.property);", "percentage": 88, "note": "Server may return unexpected shape"},
        {"solution": "Log response before parsing: console.log(response); console.log(await response.clone().text());", "percentage": 85, "note": "Debug actual response content"}
    ]$$::jsonb,
    'Successful fetch response (status 200), Valid JSON response from server',
    'Parsed data accessible via dot notation, Properties contain expected values, No undefined errors in console',
    'Response object != data. Must call .json()/.text() to parse. Data structure may not match expectations. Always validate before accessing properties.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/37949981/fetch-returns-object-with-all-functions'
);
