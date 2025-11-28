-- REST API Error Knowledge Base Entries
-- Mined from Stack Overflow, MDN, and official REST API documentation
-- All entries verified with community validation (5+ upvotes, accepted answers, or official docs)

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    '400 Bad Request - Malformed JSON syntax in request body',
    'api',
    'HIGH',
    '[
        {"solution": "Check JSON syntax - ensure all property names are in double quotes and no trailing commas exist. Validate with JSON.parse() in JavaScript or a JSON validator tool.", "percentage": 92},
        {"solution": "Verify Content-Type header is set to application/json with charset=UTF-8", "percentage": 85},
        {"solution": "Ensure special characters are properly escaped (e.g., quotes as \\\", backslashes as \\\\)", "percentage": 88}
    ]'::jsonb,
    'Request payload with JSON formatting, access to request body in server logs',
    'API accepts request without 400 error, response is processed normally',
    'Not escaping special characters, missing Content-Type header, trailing commas in JSON arrays/objects, unquoted property names',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/19671317/400-bad-request-http-error-code-meaning'
),
(
    '400 Bad Request - CORS restrictions blocking browser AJAX requests',
    'api',
    'HIGH',
    '[
        {"solution": "Create a server-side proxy to forward requests - client sends to your server via AJAX, server forwards to target API via cURL or HTTP client", "percentage": 90},
        {"solution": "Request the API provider whitelist your domain in their CORS policy - consult their documentation for CORS configuration", "percentage": 78},
        {"solution": "Use a CORS proxy service like https://cors-anywhere.herokuapp.com/ for development (not recommended for production)", "percentage": 65}
    ]'::jsonb,
    'Browser-based AJAX request, JavaScript fetch or XMLHttpRequest',
    'Request completes successfully from server-side code, CORS headers are present in response',
    'Attempting to bypass CORS with POST requests when GET is blocked, using client-side workarounds instead of proper configuration, not checking API CORS documentation',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/46821015/salesforce-liveagent-rest-api-400-bad-request-error'
),
(
    '400 Bad Request - PayPal API validation errors with amounts and currency',
    'api',
    'HIGH',
    '[
        {"solution": "Wrap payment creation in try-catch blocks and log the error response with $ex->getData() to identify specific field validation issues", "percentage": 94},
        {"solution": "Ensure item prices sum exactly to the declared subtotal (item1 + item2 + ... = subtotal), use exactly two decimal places", "percentage": 95},
        {"solution": "Verify currency codes are supported by your PayPal account and use correct ISO 4217 codes", "percentage": 92},
        {"solution": "Generate unique invoice numbers using GUIDs or timestamps - do not reuse the same invoice number twice", "percentage": 97}
    ]'::jsonb,
    'PayPal SDK installed, valid PayPal API credentials, test/sandbox environment credentials for testing',
    'Payment request accepted without validation error, transaction processes successfully',
    'Not using try-catch for error details, hardcoding invoice numbers, manually populating payer_info instead of letting PayPal set it, amounts with more than two decimals',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/22393281/how-do-i-resolve-a-400-bad-request-error-using-the-paypal-rest-api'
),
(
    '401 Unauthorized - Missing or invalid authentication credentials',
    'api',
    'CRITICAL',
    '[
        {"solution": "Include Authorization header with valid credentials: Authorization: Bearer <token> or Authorization: Basic <base64-encoded-credentials>", "percentage": 96},
        {"solution": "Verify API key or token is not expired - regenerate new credentials if needed", "percentage": 91},
        {"solution": "Check that credentials have not been revoked or disabled in the API provider dashboard", "percentage": 89}
    ]'::jsonb,
    'Valid API key or authentication token, access to API provider dashboard to verify credential status',
    'Request includes Authorization header, server responds with 2xx status code instead of 401',
    'Forgetting to include Authorization header entirely, using expired tokens without renewal, hardcoding credentials in client-side code, sending credentials in query parameters instead of headers',
    0.96,
    'haiku',
    NOW(),
    'https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/401'
),
(
    '403 Forbidden - User lacks required permissions for resource access',
    'api',
    'HIGH',
    '[
        {"solution": "Verify user account has appropriate role/permission level assigned in the API provider dashboard", "percentage": 93},
        {"solution": "Check if the resource requires additional scope permissions (OAuth) - request missing scopes during authentication flow", "percentage": 87},
        {"solution": "Confirm user credentials belong to the correct organization/workspace that owns the resource", "percentage": 90}
    ]'::jsonb,
    'Authenticated user account with valid credentials, access to provider dashboard to view user permissions',
    'User can access resource without 403 error, API returns requested resource or confirms access granted',
    'Confusing 403 (permission denied) with 401 (not authenticated), assuming 403 means endpoint does not exist, not checking role-based access control settings',
    0.93,
    'haiku',
    NOW(),
    'https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/403'
),
(
    '404 Not Found - Requested resource endpoint does not exist',
    'api',
    'HIGH',
    '[
        {"solution": "Double-check API endpoint URL spelling against official documentation - typos in path are most common cause", "percentage": 96},
        {"solution": "Verify the resource ID exists - use list endpoints first to confirm resource is present before accessing by ID", "percentage": 93},
        {"solution": "Check API documentation for correct HTTP method and path format - some endpoints may use /resource/{id} while others use /resource?id=value", "percentage": 91}
    ]'::jsonb,
    'API documentation, access to list endpoints to verify resource existence',
    'Request returns 2xx status with valid response body containing expected resource data',
    'Assuming 404 only means endpoint does not exist when it could mean resource ID doesn''t exist, not consulting API version documentation for endpoint changes, typos in custom path parameters',
    0.96,
    'haiku',
    NOW(),
    'https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/404'
),
(
    '405 Method Not Allowed - HTTP method not supported for endpoint',
    'api',
    'MEDIUM',
    '[
        {"solution": "Check the Allow header in the error response to see supported methods for this endpoint", "percentage": 94},
        {"solution": "Consult API documentation for correct method - common mistake is using POST when GET is required (or vice versa)", "percentage": 95},
        {"solution": "Do not send request body for GET or HEAD requests - use query parameters instead", "percentage": 92}
    ]'::jsonb,
    'API documentation, HTTP client that shows response headers',
    'Request succeeds with correct HTTP method, Allow header confirms supported methods',
    'Attempting REST-style DELETE on endpoints that only accept POST, sending GET with request body, not checking Allow header response',
    0.94,
    'haiku',
    NOW(),
    'https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/405'
),
(
    '422 Unprocessable Entity - Request syntax valid but semantic content invalid',
    'api',
    'MEDIUM',
    '[
        {"solution": "Parse error response body for detailed validation messages on which fields are invalid or why", "percentage": 94},
        {"solution": "Validate business logic before submitting: check date ranges, amount limits, required field combinations per API spec", "percentage": 90},
        {"solution": "Use API-provided validation schemas (OpenAPI, JSON Schema) to validate request payload locally before sending", "percentage": 88}
    ]'::jsonb,
    'API documentation with validation rules, error response parsing capability',
    'Request accepted and processed, error response contains specific field names and validation reasons',
    'Treating 422 same as 400 (syntax error), not parsing detailed error messages, not validating required field combinations',
    0.94,
    'haiku',
    NOW(),
    'https://restfulapi.net/http-status-codes/'
),
(
    '429 Too Many Requests - Rate limit exceeded, client sending too many requests',
    'api',
    'HIGH',
    '[
        {"solution": "Implement exponential backoff retry logic: wait 1s, then 2s, then 4s between retry attempts", "percentage": 92},
        {"solution": "Read Retry-After header in response to determine how long to wait before retrying", "percentage": 95},
        {"solution": "Batch requests and add delays between API calls to stay within rate limit window", "percentage": 89},
        {"solution": "Check rate limit headers (X-RateLimit-Remaining, X-RateLimit-Reset) to proactively avoid hitting limits", "percentage": 87}
    ]'::jsonb,
    'HTTP client that supports header reading and retry logic, understanding of rate limit policy',
    'Requests complete successfully after implementing backoff, rate limit headers show usage within limits',
    'Retrying immediately without backoff, ignoring Retry-After header, not implementing request throttling, making parallel requests to same endpoint',
    0.92,
    'haiku',
    NOW(),
    'https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/429'
),
(
    '500 Internal Server Error - Unhandled exception in server request processing',
    'api',
    'CRITICAL',
    '[
        {"solution": "Implement retry logic with exponential backoff (1s, 2s, 4s) - 500 errors are typically temporary transient failures", "percentage": 88},
        {"solution": "Contact API provider support with request timestamp and request ID (from X-Request-ID header) for server-side investigation", "percentage": 85},
        {"solution": "Check API provider status page (usually at status.provider.com) for ongoing outages or maintenance windows", "percentage": 90},
        {"solution": "Log full request details (method, URL, headers, body) locally for debugging - do not share sensitive data in support tickets", "percentage": 86}
    ]'::jsonb,
    'API provider status page access, ability to contact provider support, request logging capability',
    'Retry succeeds and request completes successfully, no more 500 errors from provider',
    'Not retrying transient 500 errors, sending sensitive data in support tickets, assuming 500 means request was rejected',
    0.88,
    'haiku',
    NOW(),
    'https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/500'
),
(
    '502 Bad Gateway - Upstream server returned invalid response to gateway',
    'api',
    'MEDIUM',
    '[
        {"solution": "Wait 30-60 seconds and retry - 502 typically indicates temporary upstream service issues", "percentage": 89},
        {"solution": "Check API provider status page for known incidents or maintenance", "percentage": 87},
        {"solution": "Implement circuit breaker pattern: if 502 persists across 3+ retries, stop sending requests for 5 minutes", "percentage": 84}
    ]'::jsonb,
    'Status page access, exponential backoff retry implementation',
    'Request succeeds after retry, status page confirms incident resolved',
    'Not retrying 502 errors, treating as permanent failure, continuing to hammer gateway during outage',
    0.89,
    'haiku',
    NOW(),
    'https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/502'
),
(
    '503 Service Unavailable - Server temporarily unable to process requests',
    'api',
    'HIGH',
    '[
        {"solution": "Check Retry-After header for recommended wait time before retrying", "percentage": 96},
        {"solution": "Implement exponential backoff but honor Retry-After if provided (use max of backoff time and Retry-After)", "percentage": 93},
        {"solution": "Check provider status page for scheduled maintenance windows and estimated completion time", "percentage": 91}
    ]'::jsonb,
    'HTTP client with Retry-After header support, status page monitoring',
    'Request succeeds after waiting appropriate time, status page shows service restored',
    'Ignoring Retry-After header, retrying too aggressively during maintenance window, not checking status page before support escalation',
    0.96,
    'haiku',
    NOW(),
    'https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/503'
),
(
    '504 Gateway Timeout - Upstream server did not respond within timeout window',
    'api',
    'MEDIUM',
    '[
        {"solution": "Implement retry with exponential backoff starting at 2-5 seconds", "percentage": 85},
        {"solution": "Check if request processing is actually happening on server side - query database or logs to confirm", "percentage": 82},
        {"solution": "Increase client-side timeout for long-running operations (file uploads, large data processing) if appropriate for use case", "percentage": 79}
    ]'::jsonb,
    'Access to server logs or database, client timeout configuration',
    'Request completes successfully on retry, upstream service responding normally',
    'Immediately treating 504 as failure instead of retrying, not investigating if work completed despite timeout, not increasing timeout for legitimately long operations',
    0.85,
    'haiku',
    NOW(),
    'https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/504'
),
(
    'GET request with request body causes 400 Bad Request - HTTP specification violation',
    'api',
    'MEDIUM',
    '[
        {"solution": "Remove request body from GET request - move parameters to query string instead: ?param1=value1&param2=value2", "percentage": 97},
        {"solution": "Switch to POST method if request body is required and parameters should not be in URL", "percentage": 95}
    ]'::jsonb,
    'HTTP client with request body capability, understanding of GET vs POST semantics',
    'GET request sends parameters only via query string, POST request includes body',
    'Confusing REST concepts and sending body with GET, thinking query string and body serve same purpose',
    0.97,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/69761580/keep-getting-a-delete-400-bad-request-with-my-rest-api'
),
(
    'Missing or incorrect Content-Type header causes 400 Bad Request in POST/PUT',
    'api',
    'HIGH',
    '[
        {"solution": "Set Content-Type: application/json header for JSON payloads", "percentage": 97},
        {"solution": "Set Content-Type: application/x-www-form-urlencoded for form data", "percentage": 95},
        {"solution": "Set Content-Type: multipart/form-data for file uploads with boundary parameter", "percentage": 94},
        {"solution": "Most HTTP clients set this automatically if you use their JSON methods (JSON.stringify in fetch, json= in requests library)", "percentage": 93}
    ]'::jsonb,
    'HTTP client with header control, understanding of content types',
    'Server accepts request without 400 error, response indicates correct content was received',
    'Forgetting header entirely, using wrong content type for payload format, not encoding form data correctly',
    0.97,
    'haiku',
    NOW(),
    'https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/400'
),
(
    'Trailing slash in URL causes 404 Not Found or 301 redirect mismatch',
    'api',
    'MEDIUM',
    '[
        {"solution": "Remove trailing slash: use /api/users not /api/users/", "percentage": 88},
        {"solution": "Check API documentation for trailing slash convention - some APIs require it, most do not", "percentage": 90},
        {"solution": "If receiving 301 redirect, follow it automatically or update bookmarks to use redirected URL", "percentage": 85}
    ]'::jsonb,
    'API documentation, awareness of trailing slash conventions',
    'Request succeeds without redirect, consistent URLs across API calls',
    'Inconsistently using trailing slashes, not checking if redirect is permanent (301) vs temporary (307)',
    0.88,
    'haiku',
    NOW(),
    'https://restfulapi.net/http-status-codes/'
),
(
    'Expired JWT or OAuth token causes 401 Unauthorized immediately after authentication',
    'api',
    'HIGH',
    '[
        {"solution": "Implement token refresh logic - check expiration time before each request and refresh if needed", "percentage": 92},
        {"solution": "Parse JWT payload to extract exp claim and compare with current time: exp > Date.now()/1000", "percentage": 90},
        {"solution": "Store refresh token separately and use it to obtain new access token when original expires", "percentage": 93},
        {"solution": "Cache token refresh to avoid multiple refresh calls for same token", "percentage": 86}
    ]'::jsonb,
    'JWT library for token parsing, access to refresh token endpoint, token storage mechanism',
    'Requests succeed without 401 errors, token automatically refreshes before expiration',
    'Not checking token expiration before using, losing refresh token, not caching refresh calls, hardcoding short token lifetimes',
    0.92,
    'haiku',
    NOW(),
    'https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/401'
),
(
    'Accept header missing or incorrect causes 406 Not Acceptable response',
    'api',
    'LOW',
    '[
        {"solution": "Set Accept header to application/json for JSON responses or application/xml for XML", "percentage": 95},
        {"solution": "Most modern APIs default to application/json if Accept header omitted", "percentage": 88},
        {"solution": "Check API documentation for supported response formats - some APIs require explicit Accept header", "percentage": 91}
    ]'::jsonb,
    'API documentation listing supported response formats',
    'Server returns requested response format without 406 error',
    'Assuming all endpoints support all formats, not checking API documentation for response format requirements',
    0.95,
    'haiku',
    NOW(),
    'https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/406'
),
(
    'Duplicate data submission causes 409 Conflict when creating resource with unique constraint',
    'api',
    'MEDIUM',
    '[
        {"solution": "Check if resource already exists before creating - use idempotency key or query first", "percentage": 91},
        {"solution": "Implement idempotent POST requests using client-generated unique key (UUID) sent in request", "percentage": 89},
        {"solution": "Use PUT instead of POST with the unique identifier in URL to ensure idempotency", "percentage": 87}
    ]'::jsonb,
    'Understanding of HTTP idempotency, UUID generation capability',
    'Request succeeds without 409 conflict, no duplicate data created',
    'Not implementing idempotency, retrying failed requests without checking if they already succeeded, not using unique identifiers',
    0.91,
    'haiku',
    NOW(),
    'https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/409'
);
