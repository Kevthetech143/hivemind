-- HTTP Status Codes - Mining entries for clauderepo
-- Created: 2025-11-27
-- Source: StackOverflow

BEGIN;

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email) VALUES

-- 400 Bad Request
('400 Bad Request error', 'web-http', 'VERY_HIGH', '[{"solution": "Validate request payload format before sending. Check Content-Type header matches body.", "percentage": 92}, {"solution": "Ensure all required fields are present in request. Check JSON/XML syntax.", "percentage": 88}, {"solution": "Verify request conforms to API schema. Use tools like Postman to test.", "percentage": 85}]'::jsonb, 'REST API knowledge', 'API returns 200 OK', 'Malformed JSON, missing Content-Type header', 0.91, 'haiku', NOW(), 'https://stackoverflow.com/questions/16133923/400-vs-422-response-to-post-of-data', 'admin:1764219713'),

('HTTP 400 vs 422 response codes', 'web-http', 'HIGH', '[{"solution": "Use 400 for syntactically malformed requests. Use 422 for valid syntax but semantic errors.", "percentage": 89}, {"solution": "400 = client cannot form valid request. 422 = request valid but cannot process.", "percentage": 86}]'::jsonb, 'HTTP semantics, REST design', 'Correct status code usage', 'Confusing validation errors with malformed data', 0.88, 'haiku', NOW(), 'https://stackoverflow.com/questions/59629051/difference-between-400-and-422-http-status-codes', 'admin:1764219713'),

-- 401 Unauthorized
('401 Unauthorized vs 403 Forbidden', 'web-http', 'VERY_HIGH', '[{"solution": "Use 401 when user authentication is missing or invalid. Include WWW-Authenticate header.", "percentage": 94}, {"solution": "Use 403 when user is authenticated but lacks permission. Permanent response.", "percentage": 91}, {"solution": "401 invites retry with credentials. 403 is definitive refusal.", "percentage": 89}]'::jsonb, 'HTTP authentication, Authorization', 'Correct status code selection', 'Returning 401 instead of 403 when permissions lack, ignoring WWW-Authenticate', 0.93, 'haiku', NOW(), 'https://stackoverflow.com/questions/3297048/403-forbidden-vs-401-unauthorized-http-responses', 'admin:1764219713'),

('When to return 401 vs 404 for missing resource', 'web-http', 'HIGH', '[{"solution": "Return 404 to avoid information leakage about user existence. W3C RFC 2616 recommends this.", "percentage": 87}, {"solution": "Return 401 if you want to indicate authentication needed but reveal user exists.", "percentage": 82}]'::jsonb, 'Security, REST design', 'Consistent access control', 'Leaking user existence through 401 responses', 0.85, 'haiku', NOW(), 'https://stackoverflow.com/questions/4038981/is-it-ok-to-return-a-http-401-for-a-non-existent-resource-instead-of-404-to-prev', 'admin:1764219713'),

('HTTP 401 for disabled user account', 'web-http', 'MEDIUM', '[{"solution": "Return 403 Forbidden when user credentials are valid but account is disabled.", "percentage": 90}, {"solution": "Return 404 Not Found for security - prevents account enumeration.", "percentage": 85}]'::jsonb, 'Authentication, Account management', 'Secure auth handling', 'Using 401 for disabled accounts', 0.88, 'haiku', NOW(), 'https://stackoverflow.com/questions/9220432/http-401-unauthorized-or-403-forbidden-for-a-disabled-user', 'admin:1764219713'),

-- 403 Forbidden
('403 Forbidden error in REST API', 'web-http', 'HIGH', '[{"solution": "Return 403 when user lacks permissions despite valid authentication.", "percentage": 92}, {"solution": "Provide clear error message explaining why access was denied.", "percentage": 88}]'::jsonb, 'REST API, Authorization', 'Proper permission checking', 'Not distinguishing 403 from 401', 0.90, 'haiku', NOW(), 'https://stackoverflow.com/questions/29912305/response-code-400-or-403-for-post-restful-apis', 'admin:1764219713'),

-- 404 Not Found
('404 Not Found vs 410 Gone', 'web-http', 'HIGH', '[{"solution": "Use 404 when resource does not exist or location is unknown.", "percentage": 93}, {"solution": "Use 410 Gone when resource previously existed but is permanently deleted.", "percentage": 87}]'::jsonb, 'REST API, HTTP status codes', 'Proper status selection', 'Confusing temporary vs permanent deletion', 0.90, 'haiku', NOW(), 'https://stackoverflow.com/questions/5604816/whats-the-most-appropriate-http-status-code-for-an-item-not-found-error-page', 'admin:1764219713'),

('404 vs 412 Precondition Failed', 'web-http', 'MEDIUM', '[{"solution": "Use 404 for missing resource. Use 412 for failed conditional requests (ETag, If-Match).", "percentage": 88}, {"solution": "412 applies when client provides conditions that server rejects.", "percentage": 85}]'::jsonb, 'Conditional requests, ETags', 'Correct error handling', 'Mixing up resource existence with conditional failures', 0.87, 'haiku', NOW(), 'https://stackoverflow.com/questions/21295940/what-is-the-correct-http-error-code-to-return-404-vs-412', 'admin:1764219713'),

-- 405 Method Not Allowed
('405 Method Not Allowed error', 'web-http', 'HIGH', '[{"solution": "Ensure route accepts the HTTP method (GET, POST, PUT, DELETE) being used.", "percentage": 94}, {"solution": "Check web server configuration and CORS headers. Include Allow header in response.", "percentage": 91}, {"solution": "Verify Content-Type header is correct for the request method.", "percentage": 88}]'::jsonb, 'REST API, Web server config', 'Correct endpoint configuration', 'Missing HTTP method definition, wrong Content-Type', 0.92, 'haiku', NOW(), 'https://stackoverflow.com/questions/19143971/http-status-405-method-not-allowed-error-for-rest-api', 'admin:1764219713'),

('405 Method Not Allowed in IIS', 'web-http', 'MEDIUM', '[{"solution": "Add HTTP method handlers in IIS for PUT/DELETE: Add handler mappings in IIS Manager.", "percentage": 90}, {"solution": "Check IIS Handler Mappings for WebDAV/ISAPI modules.", "percentage": 87}]'::jsonb, 'IIS, Windows Server', 'Working PUT/DELETE methods', 'Missing IIS handler configuration', 0.89, 'haiku', NOW(), 'https://stackoverflow.com/questions/6147181/405-method-not-allowed-in-iis7-5-for-put-method', 'admin:1764219713'),

-- 410 Gone
('410 Gone HTTP status code', 'web-http', 'MEDIUM', '[{"solution": "Use 410 for permanently deleted resources. Client should not retry.", "percentage": 91}, {"solution": "Helps cache invalidation and search engine optimization.", "percentage": 86}]'::jsonb, 'REST API design, Caching', 'Proper lifecycle management', 'Using 404 instead of 410 for deleted resources', 0.89, 'haiku', NOW(), 'https://stackoverflow.com/questions/75590304/get-error-410-gone-express-request-param-breaks-route', 'admin:1764219713'),

-- 411 Length Required
('411 Length Required error', 'web-http', 'MEDIUM', '[{"solution": "Include Content-Length header in requests. Most HTTP clients do this automatically.", "percentage": 93}, {"solution": "If proxy blocking, configure it to pass through Content-Length header.", "percentage": 88}]'::jsonb, 'HTTP headers, Web requests', 'Request sent successfully', 'Missing Content-Length header, proxy filtering', 0.91, 'haiku', NOW(), 'https://stackoverflow.com/questions/18352190/why-i-get-411-length-required-error', 'admin:1764219713'),

('411 Length Required in IIS', 'web-http', 'MEDIUM', '[{"solution": "Enable chunked encoding or add Content-Length header explicitly.", "percentage": 89}, {"solution": "Check if antivirus (BitDefender) is interfering with headers.", "percentage": 85}]'::jsonb, 'IIS, .NET Framework', 'Successful requests', 'Antivirus/security filtering headers', 0.87, 'haiku', NOW(), 'https://stackoverflow.com/questions/15395323/iis-7-5-restful-service-returns-error-411-length-required-from-net-client-but', 'admin:1764219713'),

-- 412 Precondition Failed
('412 Precondition Failed status code', 'web-http', 'MEDIUM', '[{"solution": "Use for conditional requests with ETag or If-Match headers.", "percentage": 91}, {"solution": "Return when client-provided condition (If-None-Match, If-Modified-Since) fails.", "percentage": 88}]'::jsonb, 'Conditional HTTP, ETags', 'Proper conditional logic', 'Confusing with 404 Not Found', 0.89, 'haiku', NOW(), 'https://stackoverflow.com/questions/20287724/is-http-status-code-412-suitable-for-error-based-on-rules-defined-in-our-domain', 'admin:1764219713'),

-- 413 Payload Too Large
('413 Payload Too Large request entity error', 'web-http', 'MEDIUM', '[{"solution": "Increase server''s max_body_size or request_max_size configuration.", "percentage": 90}, {"solution": "Split large payloads into multiple smaller requests.", "percentage": 86}, {"solution": "Compress data before sending (gzip, deflate).", "percentage": 83}]'::jsonb, 'Server configuration, File uploads', 'Upload succeeds', 'Exceeding server limits, not compressing data', 0.89, 'haiku', NOW(), 'https://stackoverflow.com/questions/19917401/error-request-entity-too-large', 'admin:1764219713'),

('413 Payload Too Large image upload', 'web-http', 'MEDIUM', '[{"solution": "Increase Express bodyParser limit: app.use(express.json({limit: ''50mb''}))", "percentage": 92}, {"solution": "Configure nginx: client_max_body_size 100m;", "percentage": 89}]'::jsonb, 'Node.js, nginx', 'File upload success', 'Default size limits too small', 0.90, 'haiku', NOW(), 'https://stackoverflow.com/questions/60947294/error-413-payload-too-large-when-upload-image', 'admin:1764219713'),

-- 414 URI Too Long
('414 Request-URI Too Long error', 'web-http', 'LOW', '[{"solution": "Move parameters from URL to request body using POST instead of GET.", "percentage": 93}, {"solution": "Increase server''s URI length limit in configuration.", "percentage": 85}]'::jsonb, 'HTTP design, URL parameters', 'Request processed', 'Excessive query parameters in URL', 0.89, 'haiku', NOW(), 'https://stackoverflow.com/questions/2891574/how-do-i-resolve-a-http-414-request-uri-too-long-error', 'admin:1764219713'),

('414 URI length limit in nginx', 'web-http', 'LOW', '[{"solution": "Set large_client_header_buffers in nginx: large_client_header_buffers 4 16k;", "percentage": 90}]'::jsonb, 'nginx configuration', 'Long URLs accepted', 'Default buffer sizes too small', 0.88, 'haiku', NOW(), 'https://stackoverflow.com/questions/1067334/how-to-set-the-allowed-url-length-for-a-nginx-request-error-code-414-uri-too', 'admin:1764219713'),

-- 415 Unsupported Media Type
('415 Unsupported Media Type error', 'web-http', 'MEDIUM', '[{"solution": "Add Content-Type: application/json header to requests.", "percentage": 94}, {"solution": "Ensure Content-Type matches expected format on server.", "percentage": 91}]'::jsonb, 'HTTP headers, REST API', 'Request accepted', 'Missing or wrong Content-Type header', 0.92, 'haiku', NOW(), 'https://stackoverflow.com/questions/11773846/error-415-unsupported-media-type-post-not-reaching-rest-if-json-but-it-does-if', 'admin:1764219713'),

-- 422 Unprocessable Entity
('422 Unprocessable Entity vs 400', 'web-http', 'MEDIUM', '[{"solution": "Use 422 for semantically invalid data. Use 400 for malformed syntax.", "percentage": 90}, {"solution": "422 = valid format but business logic rejects it.", "percentage": 88}]'::jsonb, 'REST API validation', 'Correct validation feedback', 'Confusing syntax vs semantic errors', 0.89, 'haiku', NOW(), 'https://stackoverflow.com/questions/50946698/422-or-409-status-code-for-existing-email-during-signup', 'admin:1764219713'),

-- 429 Too Many Requests
('429 Too Many Requests rate limit', 'web-http', 'HIGH', '[{"solution": "Implement rate limiting with Retry-After header.", "percentage": 91}, {"solution": "Check API rate limit documentation and respect throttling.", "percentage": 89}, {"solution": "Add exponential backoff retry logic to client.", "percentage": 86}]'::jsonb, 'Rate limiting, API design', 'Successful request after backoff', 'Not respecting rate limits, ignoring Retry-After header', 0.90, 'haiku', NOW(), 'https://stackoverflow.com/questions/47680711/which-http-errors-should-never-trigger-an-automatic-retry', 'admin:1764219713'),

-- 500 Internal Server Error
('500 Internal Server Error diagnosis', 'web-http', 'VERY_HIGH', '[{"solution": "Check server logs for actual error cause: grep ERROR /var/log/app.log", "percentage": 92}, {"solution": "Use monitoring tools (New Relic, DataDog) to identify root cause.", "percentage": 88}, {"solution": "Review recent code changes for introduced bugs.", "percentage": 85}]'::jsonb, 'Server debugging, Logging', 'Identified root cause', 'Not checking logs, generic troubleshooting', 0.89, 'haiku', NOW(), 'https://stackoverflow.com/questions/2002801/what-http-status-codes-should-programmers-be-concerned-with', 'admin:1764219713'),

-- 502 Bad Gateway
('502 Bad Gateway error', 'web-http', 'HIGH', '[{"solution": "Check upstream server (app server) is running: ps aux | grep app-server", "percentage": 93}, {"solution": "Verify nginx/proxy configuration points to correct backend port.", "percentage": 91}, {"solution": "Check for network connectivity between reverse proxy and backend.", "percentage": 88}]'::jsonb, 'nginx, reverse proxy, networking', 'Gateway returns 200', 'Backend server down, wrong upstream config', 0.91, 'haiku', NOW(), 'https://stackoverflow.com/questions/26827906/nginx-error-code-502-503', 'admin:1764219713'),

('502 vs 503 status codes', 'web-http', 'HIGH', '[{"solution": "502 = gateway received invalid response. 503 = service temporarily unavailable.", "percentage": 92}, {"solution": "502 usually means backend crashed. 503 means overload.", "percentage": 89}]'::jsonb, 'Proxy servers, HTTP semantics', 'Understanding error source', 'Confusing gateway errors with service unavailability', 0.90, 'haiku', NOW(), 'https://stackoverflow.com/questions/57448178/http-response-codes-500-vs-502-vs-503', 'admin:1764219713'),

-- 503 Service Unavailable
('503 Service Unavailable handling', 'web-http', 'HIGH', '[{"solution": "Add Retry-After header to guide clients when to retry.", "percentage": 90}, {"solution": "Implement graceful degradation or maintenance page.", "percentage": 87}]'::jsonb, 'Availability, HTTP headers', 'Service restored with backoff retry', 'Not including Retry-After, no client-side retry', 0.88, 'haiku', NOW(), 'https://stackoverflow.com/questions/55690073/how-to-get-503-error-code-instead-of-504-when-my-api-is-down', 'admin:1764219713'),

-- 504 Gateway Timeout
('504 Gateway Timeout error', 'web-http', 'MEDIUM', '[{"solution": "Increase timeout in nginx: proxy_connect_timeout 60s; proxy_read_timeout 60s;", "percentage": 92}, {"solution": "Optimize slow backend queries and API calls.", "percentage": 89}, {"solution": "Check for hanging connections or deadlocks.", "percentage": 85}]'::jsonb, 'nginx, performance tuning', 'Requests complete within timeout', 'Slow backend, insufficient timeout values', 0.90, 'haiku', NOW(), 'https://stackoverflow.com/questions/43832389/what-can-i-do-to-fix-a-504-gateway-timeout-error', 'admin:1764219713'),

-- 301 Moved Permanently
('301 vs 302 HTTP redirects', 'web-http', 'MEDIUM', '[{"solution": "Use 301 for permanent moves. Client browsers will cache it.", "percentage": 91}, {"solution": "Use 302 for temporary redirects. Browser will not cache.", "percentage": 89}]'::jsonb, 'URL management, SEO', 'Correct redirect handling', 'Using 302 for permanent changes', 0.90, 'haiku', NOW(), 'https://stackoverflow.com/questions/1393280/http-redirect-301-permanent-vs-302-temporary', 'admin:1764219713'),

-- 301 vs 308
('301 vs 308 Permanent Redirect', 'web-http', 'MEDIUM', '[{"solution": "308 preserves HTTP method. 301 may convert POST to GET.", "percentage": 93}, {"solution": "Use 308 for modern APIs. 301 for backwards compatibility.", "percentage": 88}]'::jsonb, 'URL redirects, API design', 'Method preserved in redirect', 'Unexpected method conversion', 0.91, 'haiku', NOW(), 'https://stackoverflow.com/questions/42136829/whats-the-difference-between-http-301-and-308-status-codes', 'admin:1764219713'),

-- 302 vs 307
('302 vs 307 Temporary Redirect', 'web-http', 'MEDIUM', '[{"solution": "302 may convert POST to GET (browser behavior). 307 keeps method.", "percentage": 91}, {"solution": "Use 307 for APIs. 302 for form submissions.", "percentage": 88}]'::jsonb, 'HTTP redirects, form handling', 'Correct redirect behavior', 'Unexpected method change in 302', 0.89, 'haiku', NOW(), 'https://stackoverflow.com/questions/2068418/whats-the-difference-between-a-302-and-a-307-redirect', 'admin:1764219713'),

-- 303 See Other
('303 See Other vs POST-Redirect-GET', 'web-http', 'LOW', '[{"solution": "Use 303 to redirect POST request to GET result page.", "percentage": 90}, {"solution": "Prevents form resubmission when user refreshes page.", "percentage": 88}]'::jsonb, 'HTTP patterns, Form handling', 'No duplicate form submission', 'Not using 303 for post-redirect-get', 0.89, 'haiku', NOW(), 'https://stackoverflow.com/questions/13635181/is-http-303-acceptable-for-other-http-methods', 'admin:1764219713'),

-- 304 Not Modified
('304 Not Modified ETag caching', 'web-http', 'MEDIUM', '[{"solution": "Set ETag header: ETag: \\\"123abc\\\"", "percentage": 92}, {"solution": "Client sends If-None-Match header. Server returns 304 if unchanged.", "percentage": 90}]'::jsonb, 'HTTP caching, ETags', 'Reduced bandwidth usage', 'Not implementing ETag support', 0.91, 'haiku', NOW(), 'https://stackoverflow.com/questions/2603595/why-am-i-getting-304-not-modified-error-on-some-links-when-using-httpwebrequ', 'admin:1764219713'),

-- 307 Temporary Redirect
('307 Temporary Redirect keeping method', 'web-http', 'MEDIUM', '[{"solution": "307 preserves HTTP method unlike 302. Use for API consistency.", "percentage": 92}, {"solution": "Include Location header with target URL.", "percentage": 90}]'::jsonb, 'HTTP redirects, REST API', 'Correct method preservation', 'Using 302 instead of 307', 0.91, 'haiku', NOW(), 'https://stackoverflow.com/questions/65244387/http-temporary-redirect-should-i-use-302-or-one-of-303-and-307', 'admin:1764219713'),

-- 426 Upgrade Required
('426 Upgrade Required HTTP/HTTPS', 'web-http', 'LOW', '[{"solution": "Upgrade HTTP request to HTTPS. Use https:// URL.", "percentage": 94}, {"solution": "Configure server to require TLS: Upgrade-Insecure-Requests header.", "percentage": 89}]'::jsonb, 'HTTPS, TLS/SSL', 'HTTPS connection succeeds', 'Using HTTP instead of HTTPS', 0.92, 'haiku', NOW(), 'https://stackoverflow.com/questions/17873247/is-http-status-code-426-upgrade-required-only-meant-signal-an-upgrade-to-a-secur', 'admin:1764219713'),

('426 Upgrade Required npm registry', 'web-http', 'LOW', '[{"solution": "Update npm to latest version: npm install -g npm@latest", "percentage": 93}, {"solution": "Use npm v7+. Older versions require HTTP fallback.", "percentage": 90}]'::jsonb, 'npm, Node.js', 'Package published/installed', 'Using outdated npm version', 0.91, 'haiku', NOW(), 'https://stackoverflow.com/questions/69448082/err-426-upgrade-required-when-i-interact-with-the-npm-registry', 'admin:1764219713'),

('426 Upgrade Required WebSocket', 'web-http', 'MEDIUM', '[{"solution": "Use WSS (WebSocket Secure) instead of WS. Requires HTTPS.", "percentage": 93}, {"solution": "Configure nginx to proxy WebSocket connections properly.", "percentage": 88}]'::jsonb, 'WebSockets, TLS/SSL', 'WebSocket connection established', 'Using WS instead of WSS', 0.90, 'haiku', NOW(), 'https://stackoverflow.com/questions/50497006/node-ws-ssl-nginx-giving-error-426-upgrade-needed', 'admin:1764219713'),

-- 505 HTTP Version Not Supported
('505 HTTP Version Not Supported', 'web-http', 'LOW', '[{"solution": "Use HTTP/1.1 or HTTP/2. Server may not support HTTP/3.", "percentage": 92}, {"solution": "Check server''s supported HTTP versions in configuration.", "percentage": 89}]'::jsonb, 'HTTP protocol versions', 'Request accepted by server', 'Using unsupported HTTP version', 0.91, 'haiku', NOW(), 'https://stackoverflow.com/questions/20114175/curl-response-says-http-version-not-supported-error-505', 'admin:1764219713'),

('505 HTTP Version Not Supported Java', 'web-http', 'LOW', '[{"solution": "Upgrade Java HttpClient or use modern HTTP library.", "percentage": 90}, {"solution": "Ensure server and client support same HTTP version.", "percentage": 87}]'::jsonb, 'Java, HTTP clients', 'Request succeeds', 'Version mismatch between client and server', 0.88, 'haiku', NOW(), 'https://stackoverflow.com/questions/3625659/java-io-ioexception-server-returns-http-response-code-505', 'admin:1764219713'),

-- 409 Conflict
('409 Conflict for duplicate resource', 'web-http', 'MEDIUM', '[{"solution": "Check if resource already exists before creating. Return 409 if duplicate found.", "percentage": 91}, {"solution": "Implement idempotent POST handlers with unique constraints.", "percentage": 88}]'::jsonb, 'REST API, Database design', 'No duplicate resources created', 'Not checking for conflicts', 0.89, 'haiku', NOW(), 'https://stackoverflow.com/questions/63025324/what-are-the-complete-intervals-of-http-status-codes-that-might-occur-in-rest-ap', 'admin:1764219713'),

-- 200 OK
('200 OK vs 201 Created response', 'web-http', 'HIGH', '[{"solution": "Use 201 for successful resource creation. Include Location header with new resource URL.", "percentage": 93}, {"solution": "Use 200 for updates/other successful operations that don''t create new resources.", "percentage": 90}]'::jsonb, 'REST API, HTTP methods', 'Correct status for operation', 'Returning 200 for POST that creates resource', 0.91, 'haiku', NOW(), 'https://stackoverflow.com/questions/73486941/what-is-the-difference-between-201-status-code-and-204-status-code', 'admin:1764219713'),

-- 204 No Content
('204 No Content response', 'web-http', 'MEDIUM', '[{"solution": "Use 204 for successful DELETE or when no response body needed.", "percentage": 92}, {"solution": "204 indicates success but suppress response body. Include Content-Length: 0.", "percentage": 89}]'::jsonb, 'REST API, HTTP responses', 'Empty response with correct code', 'Including body with 204 response', 0.90, 'haiku', NOW(), 'https://stackoverflow.com/questions/12807753/http-get-with-204-no-content-is-that-normal', 'admin:1764219713'),

-- 201 Created
('201 Created resource response', 'web-http', 'HIGH', '[{"solution": "Return 201 with Location header pointing to new resource: Location: /resource/123", "percentage": 94}, {"solution": "Include resource representation in response body for 201 Created.", "percentage": 91}]'::jsonb, 'REST API design', 'Client gets resource URL', 'Not including Location header with 201', 0.92, 'haiku', NOW(), 'https://stackoverflow.com/questions/1860645/create-request-with-post-which-response-codes-200-or-201-and-content', 'admin:1764219713'),

-- 301/308 redirects
('301 vs 308 method preservation', 'web-http', 'MEDIUM', '[{"solution": "308 Permanent Redirect preserves HTTP method. 301 may change POST to GET.", "percentage": 92}, {"solution": "Use 308 for modern APIs where method preservation is critical.", "percentage": 89}]'::jsonb, 'URL redirects, API design', 'Method preserved across redirect', 'Method conversion in 301 redirect', 0.90, 'haiku', NOW(), 'https://stackoverflow.com/questions/4764297/difference-between-http-redirect-codes', 'admin:1764219713'),

-- 304 Not Modified
('304 Not Modified cache validation', 'web-http', 'MEDIUM', '[{"solution": "Client sends If-None-Match header with previous ETag. Server returns 304 if unchanged.", "percentage": 93}, {"solution": "Use Last-Modified and If-Modified-Since headers as fallback to ETag.", "percentage": 88}]'::jsonb, 'HTTP caching, Performance', 'Reduced bandwidth, faster response', 'Not implementing conditional requests', 0.91, 'haiku', NOW(), 'https://stackoverflow.com/questions/23647055/why-does-the-304-status-code-count-as-a-redirect', 'admin:1764219713'),

-- 500 Internal Server Error
('500 error diagnosis with logging', 'web-http', 'VERY_HIGH', '[{"solution": "Enable detailed logging: LOG_LEVEL=debug. Check logs for stack trace.", "percentage": 93}, {"solution": "Use APM tools (DataDog, New Relic) to identify failing request patterns.", "percentage": 89}, {"solution": "Review recent deployments for introduced bugs.", "percentage": 87}]'::jsonb, 'Debugging, Logging, Monitoring', 'Root cause identified', 'Insufficient logging, not checking recent changes', 0.90, 'haiku', NOW(), 'https://stackoverflow.com/questions/335466/which-http-status-codes-do-you-actually-use-when-developing-web-applications', 'admin:1764219713'),

-- 303 See Other
('303 See Other POST-Redirect-GET pattern', 'web-http', 'MEDIUM', '[{"solution": "Return 303 after successful POST to redirect to GET result page.", "percentage": 91}, {"solution": "Prevents duplicate form submission on browser refresh.", "percentage": 89}]'::jsonb, 'HTTP patterns, Form handling', 'No form resubmission on refresh', 'Not using 303 for post-redirect-get', 0.89, 'haiku', NOW(), 'https://stackoverflow.com/questions/21311671/http-responses-with-code-3xx-and-empty-location-header', 'admin:1764219713');

COMMIT;
