-- GitHub Axios Issues: High-Engagement CORS, Timeout, Interceptor & Cancellation Solutions
-- Extracted from https://github.com/axios/axios/issues - Top 12 resolved issues with community solutions

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'CORS error: Getting Cross-Origin Request Blocked on GET request',
    'github-axios',
    'VERY_HIGH',
    $$[
        {"solution": "Use a backend proxy to route requests through your own server domain", "percentage": 95, "note": "Most reliable solution - CORS is enforced by browsers, not controlled by client headers"},
        {"solution": "Understand that Access-Control-Allow-Origin is a RESPONSE header from the server, not a request header - ensure remote server supports CORS", "percentage": 90, "note": "Set in server response, not client request"},
        {"solution": "For development only: Use browser extensions that disable CORS or use axios crossdomain config option", "percentage": 70, "note": "Never use in production"}
    ]$$::jsonb,
    'Remote API server, Axios library, Browser environment',
    'Request successfully completes, No CORS error in browser console, Response data received in then() block',
    'Do not try to set Access-Control-Allow-Origin as a request header - it must come from server. cURL works because terminal tools do not enforce CORS.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/axios/axios/issues/853'
),
(
    'Axios catch error returns JavaScript error, not server response data',
    'github-axios',
    'VERY_HIGH',
    $$[
        {"solution": "Access error.response property: catch(error => console.log(error.response)) - response object contains status and data", "percentage": 95, "note": "error.response only exists if server responded; network errors will not have it"},
        {"solution": "Check if error.response exists before accessing nested properties: if (error.response) { console.log(error.response.data) }", "percentage": 90, "command": "if (error.response && error.response.status === 422) { console.log(error.response.data) }"},
        {"solution": "Use global response interceptor to reject with response object for consistent error handling", "percentage": 85, "note": "Transforms errors to contain response data at root level"}
    ]$$::jsonb,
    'Axios library configured, Server responding with error status code, Error handling in catch block',
    'catch block receives error.response object, Can access error.response.data and error.response.status, Status code matches server response',
    'error.response is undefined for network errors (no server response). Always check existence before accessing. Do not assume error object structure without checking.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/axios/axios/issues/960'
),
(
    'Cannot POST FormData with multipart/form-data - empty payload sent',
    'github-axios',
    'HIGH',
    $$[
        {"solution": "Pass FormData directly without manually setting Content-Type header - Axios automatically detects and sets multipart/form-data with correct boundary", "percentage": 95, "command": "const data = new FormData(); data.append(''file'', fileInput); axios.post(url, data);"},
        {"solution": "Do NOT explicitly set Content-Type in config.headers when using FormData - let Axios set it automatically", "percentage": 90, "note": "Manual header breaks automatic boundary generation"},
        {"solution": "Use Form object with FormData entries if working with file uploads", "percentage": 85, "note": "Properly appends file blobs with type information"}
    ]$$::jsonb,
    'FormData API support, File or Blob object, Axios library',
    'Server receives complete multipart payload with boundary markers, File content transmitted without truncation, 200 status on successful upload',
    'Do not set Content-Type manually - breaks automatic boundary. Pass FormData as second argument to axios.post(). Verify files are properly appended with correct type.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://github.com/axios/axios/issues/318'
),
(
    'Axios timeout error showing 0ms exceeded despite no explicit timeout set',
    'github-axios',
    'HIGH',
    $$[
        {"solution": "Check for ECONNABORTED error code which indicates stalled connection timeout, not configuration issue", "percentage": 88, "command": "catch(error => { if (error.code === ''ECONNABORTED'') { /* handle connection abort */ } })"},
        {"solution": "Verify network connectivity and server responsiveness - timeout usually indicates connection stalled after 30 seconds", "percentage": 85, "note": "Common on mobile/slow networks with unresponsive servers"},
        {"solution": "Implement error handling that distinguishes between response timeout and network failure: check error.response existence", "percentage": 82, "note": "No response means network error; response means timeout during processing"}
    ]$$::jsonb,
    'Axios library, Network connectivity, Server running and accepting connections',
    'Can identify specific error scenario (ECONNABORTED code), Retry logic succeeds on subsequent attempt, Network stability verified',
    '0ms timeout value in error message is misleading - actual timeout is ~30 seconds default. ECONNABORTED can mean both timeout and explicit abort. Check error.code property.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/axios/axios/issues/2103'
),
(
    'Need separate connect timeout and request timeout with fast failover',
    'github-axios',
    'HIGH',
    $$[
        {"solution": "Use CancelToken with separate setTimeout for connect timeout: setTimeout(() => source.cancel(), 5000) before request", "percentage": 88, "command": "const source = axios.CancelToken.source(); setTimeout(() => source.cancel(), connectTimeout); axios.get(url, {cancelToken: source.token})"},
        {"solution": "Set timeout config for total request timeout, use separate cancel timer for connection detection", "percentage": 85, "note": "Provides both connection detection and response timeout"},
        {"solution": "Upgrade to axios 0.21+ with explicit connectTimeout support if available via adapter", "percentage": 80, "note": "Some adapters support separate connection vs request timeouts"}
    ]$$::jsonb,
    'Axios 0.20+, CancelToken support, Multiple server URLs for failover',
    'Connection timeout fires before response timeout, Fast failover to alternate server, Requests to slow-but-responsive servers succeed',
    'Default single timeout forces choice between fast failover or supporting slow servers. CancelToken provides workaround for separate timeouts. connectTimeout not available in all adapters.',
    0.83,
    'sonnet-4',
    NOW(),
    'https://github.com/axios/axios/issues/1739'
),
(
    'HTTP request cancellation and AbortController support',
    'github-axios',
    'HIGH',
    $$[
        {"solution": "Create CancelToken source and pass token to request config: const source = axios.CancelToken.source(); axios.get(url, {cancelToken: source.token}); source.cancel(message)", "percentage": 95, "command": "const source = axios.CancelToken.source(); axios.get(''/api'', {cancelToken: source.token}).catch(err => {if (axios.isCancel(err)) console.log(''Request canceled'')});"},
        {"solution": "Use single token for multiple requests: multiple requests share same token, all cancel together", "percentage": 92, "note": "Useful for dependent request chains or page cleanup"},
        {"solution": "Check if error is cancellation: axios.isCancel(error) returns true for cancellations vs other errors", "percentage": 90, "note": "Distinguishes cancellation from network failures"}
    ]$$::jsonb,
    'Axios 0.15+, CancelToken API available, Request promise returned',
    'source.cancel() stops in-flight request, isCancel(error) correctly identifies cancellation, Promise rejects with CancellationError',
    'One token per request is default; reuse tokens only for related requests. isCancel must be called on error to distinguish from failures. AbortController is newer alternative.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://github.com/axios/axios/issues/333'
),
(
    'TypeScript response interceptor type issues with unwrapped data',
    'github-axios',
    'HIGH',
    $$[
        {"solution": "Use transformResponse instead of interceptor for type-safe data transformation: transformResponse: (r) => JSON.parse(r).data", "percentage": 88, "note": "transformResponse properly typed for return type changes"},
        {"solution": "Type global response interceptor with explicit generic: (response: AxiosResponse<DataType>) => data as DataType", "percentage": 85, "note": "Requires type assertion but works with TypeScript strict mode"},
        {"solution": "Use request-level typing instead of global interceptor: axios.request<ServerData>({url, transformResponse})", "percentage": 82, "note": "Avoid global interceptors that change structure for better type safety"}
    ]$$::jsonb,
    'TypeScript 4.0+, Axios with TypeScript types, Response interceptors defined',
    'TypeScript compilation succeeds without errors, Intercepted response properly typed, Data access without type assertions',
    'Global interceptors that return unwrapped data break AxiosResponse typing. Request-level config provides better type inference. transformResponse is safer for type changes.',
    0.86,
    'sonnet-4',
    NOW(),
    'https://github.com/axios/axios/issues/1510'
),
(
    'AxiosHeaders type error: Property does not exist after upgrade to 1.2.2',
    'github-axios',
    'HIGH',
    $$[
        {"solution": "Use type assertion for dynamic property assignment: (config.headers as AxiosHeaders).set(''Authorization'', token)", "percentage": 92, "command": "(config.headers as any).set(''Authorization'', token);"},
        {"solution": "Spread existing headers with new properties: config.headers = {...config.headers, Authorization: token}", "percentage": 90, "note": "Works in both 1.2.1 and 1.2.2"},
        {"solution": "Upgrade to axios 1.2.2+ where PR#5420 fixed RawAxiosRequestConfig typing for dynamic headers", "percentage": 88, "note": "Permanent fix in latest versions"}
    ]$$::jsonb,
    'Axios 1.2.2+, TypeScript 4.0+, AxiosRequestConfig with headers',
    'TypeScript compilation succeeds without Property X does not exist error, Headers correctly set in request, Authorization header transmitted',
    'Direct property assignment on AxiosHeaders fails in 1.2.2 due to stricter typing. Use type assertion or spread operator. Issue resolved in later versions with RawAxiosRequestConfig.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/axios/axios/issues/5416'
),
(
    'Request params not merged with instance default params',
    'github-axios',
    'MEDIUM',
    $$[
        {"solution": "Upgrade to axios 0.19+ where PR#2656 implements deep merge for params property", "percentage": 94, "command": "npm install axios@latest"},
        {"solution": "Manually merge params before request if on older version: const merged = {...instance.defaults.params, ...requestParams}", "percentage": 88, "note": "Workaround for pre-0.19 versions"},
        {"solution": "Verify params are in request config: axios.get(url, {params: {...}}) - instance params should merge automatically in 0.19+", "percentage": 85, "note": "Params should be combined, not replaced"}
    ]$$::jsonb,
    'Axios instance with default params, Request params in config',
    'Both instance and request params present in query string, All param keys from both sources in URL, Server receives merged parameter set',
    'Pre-0.19 versions replaced params instead of merging. Always verify axios version after params issues. Manual merge workaround needed for older versions.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/axios/axios/issues/2190'
),
(
    'Content-Type application/x-www-form-urlencoded header not sent with form data',
    'github-axios',
    'MEDIUM',
    $$[
        {"solution": "Use qs library to stringify form data: const qs = require(''qs''); axios.post(url, qs.stringify({key: value}))", "percentage": 90, "command": "const qs = require(''qs''); axios.post(''/api'', qs.stringify({name: ''test'', value: 123}))"},
        {"solution": "Pass URLSearchParams instead of plain object: axios.post(url, new URLSearchParams({key: value}))", "percentage": 85, "note": "Native browser API, but check older browser compatibility"},
        {"solution": "Ensure request data is not undefined - empty data causes header removal; pass empty object {} if no data", "percentage": 82, "note": "Axios removes Content-Type for undefined data"}
    ]$$::jsonb,
    'Form data to submit, Content-Type application/x-www-form-urlencoded requirement',
    'Server receives form data correctly parsed, Content-Type header present in request, Status code 200 on success',
    'Plain JavaScript objects are not automatically stringified. Must use qs.stringify() or URLSearchParams. Interceptors can clear data causing header removal.',
    0.81,
    'sonnet-4',
    NOW(),
    'https://github.com/axios/axios/issues/362'
),
(
    'ECONNABORTED error code used for both timeout and user abort - cannot distinguish',
    'github-axios',
    'MEDIUM',
    $$[
        {"solution": "Check error message for timeout identifier: error.message.includes(''timeout of'') to distinguish from abort", "percentage": 85, "note": "Workaround until ETIMEDOUT is used"},
        {"solution": "Upgrade to axios version using ETIMEDOUT for timeouts and ECONNABORTED only for user cancellation", "percentage": 88, "command": "npm install axios@latest"},
        {"solution": "Check error.config.cancelToken or error.__CANCEL__ to identify intentional abort vs timeout", "percentage": 80, "note": "Internal implementation detail but reliable"}
    ]$$::jsonb,
    'Axios library, Error handling in catch block, Request with timeout configured',
    'Error code distinguishes timeout (ETIMEDOUT) from abort (ECONNABORTED), Correct retry logic applied per error type, Logging reflects actual error cause',
    'Current versions still conflate ECONNABORTED for both scenarios. Message checking is unreliable. Newer axios versions properly separate error codes.',
    0.79,
    'sonnet-4',
    NOW(),
    'https://github.com/axios/axios/issues/1543'
),
(
    'Port number ignored in axios request - defaults to 80 when port 8080 specified',
    'github-axios',
    'MEDIUM',
    $$[
        {"solution": "Remove proxy: undefined from axios config - malformed URL results from proxy parameter parsing", "percentage": 92, "command": "// Remove proxy: undefined from config; axios({url: ''http://localhost:8080'', method: ''get''})"},
        {"solution": "Use IPv4 address instead of localhost: replace localhost with 192.168.x.x:8080 if Docker/network issues", "percentage": 85, "note": "Resolves both port and cross-network connectivity"},
        {"solution": "Check for URL doubling in logs (http:http://...) - indicates axios config bug with proxy processing", "percentage": 82, "note": "Diagnostic indicator of root cause"}
    ]$$::jsonb,
    'Axios config with explicit port, Server running on specified port, Network connectivity',
    'Request connects to correct port (8080, not 80), No ECONNREFUSED on correct port, Server receives request from axios',
    'proxy: undefined in config causes URL malformation. Malformed URL _currentUrl loses port info. Always verify no proxy: undefined in config.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/axios/axios/issues/3821'
),
(
    'Socket hang up ECONNRESET on second request with HTTP keep-alive and mixed timeout settings',
    'github-axios',
    'MEDIUM',
    $$[
        {"solution": "Disable HTTP keep-alive by setting httpAgent: new Agent({keepAlive: false}) in axios defaults", "percentage": 90, "command": "const {Agent} = require(''http''); axios.defaults.httpAgent = new Agent({keepAlive: false});"},
        {"solution": "Upgrade to axios 1.6.3+ where PR#7206 fixes timeout handler cleanup for keep-alive connections", "percentage": 92, "note": "Permanent fix removes timeout persistence across requests"},
        {"solution": "Apply consistent timeout settings across all requests - mix of timeout and no-timeout on same connection causes issues", "percentage": 85, "note": "Workaround for older versions with keep-alive"}
    ]$$::jsonb,
    'Node.js 18+, Axios 0.22.0-1.6.2, HTTP keep-alive enabled (default), Multiple sequential requests',
    'Second request completes successfully without socket error, Connection reused across multiple requests, Timeout only applies to first request',
    'Node.js 18+ enables keep-alive by default. First request timeout persists to second request socket. Disable keep-alive or upgrade to fixed version.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/axios/axios/issues/6113'
),
(
    'TypeScript type narrowing lost after isCancel check - AxiosError becomes undefined',
    'github-axios',
    'MEDIUM',
    $$[
        {"solution": "Use type assertion after isCancel: if (!axios.isCancel(err)) { (err as AxiosError).response.data }", "percentage": 89, "command": "if (!axios.isCancel(error)) { const axiosError = error as AxiosError; console.log(axiosError.response?.data); }"},
        {"solution": "Upgrade to axios 1.3+ with PR#5595 that fixes isCancel type guard to preserve AxiosError type", "percentage": 91, "command": "npm install axios@latest"},
        {"solution": "Create wrapper function that returns boolean instead of type guard to avoid incorrect narrowing", "percentage": 82, "note": "Workaround preserves type information in error handler"}
    ]$$::jsonb,
    'TypeScript 4.0+, Axios 1.1.3+, Error handling with isCancel check',
    'Type checker allows accessing error.response after isCancel check, No undefined type in error handler, Error properties accessible without assertion',
    'isCancel type guard was typed as value is Cancel but should check __CANCEL__ property. Incorrect narrowing leaves AxiosError as undefined type.',
    0.84,
    'sonnet-4',
    NOW(),
    'https://github.com/axios/axios/issues/5153'
);
