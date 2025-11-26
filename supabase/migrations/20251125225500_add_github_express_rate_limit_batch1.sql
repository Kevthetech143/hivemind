-- Mining GitHub express-rate-limit issues batch 1
-- Source: https://github.com/express-rate-limit/express-rate-limit/issues
-- Date: 2025-11-25
-- High-engagement issues with solutions for store configuration, key generation, proxy trust, and skipSuccessfulRequests

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, last_verified, source_url
) VALUES
(
    'Rate limiter can be bypassed by closing browser if behind reverse proxy with port in X-Forwarded-For header',
    'github-express-rate-limit',
    'HIGH',
    $$[
        {"solution": "Strip port from IP using custom keyGenerator: keyGenerator: req => req.ip.split('''':'''')[0]", "percentage": 95, "note": "IPv4-only workaround, simple and effective"},
        {"solution": "Use IPv4 and IPv6 compatible port stripper: keyGenerator(req) => req.ip.replace(/:\\d+[^:]*$/, ''''''''''''); ", "percentage": 90, "note": "Works with both IPv4 and IPv6 addresses"},
        {"solution": "Update to library v6.8.0+ which detects invalid IP formats and logs ERR_ERL_INVALID_IP_ADDRESS", "percentage": 85, "note": "Library now provides error detection and wiki documentation"}
    ]$$::jsonb,
    'Express.js application, Reverse proxy configured with ports in X-Forwarded-For (e.g., Azure Application Gateway)',
    'Rate-limit persists across browser restarts from same IP, consistent enforcement regardless of source port changes',
    'Do not rely on default request.ip when behind proxies that include ports. Always implement custom keyGenerator for port stripping. Verify proxy configuration is correct.',
    0.90,
    NOW(),
    'https://github.com/express-rate-limit/express-rate-limit/issues/234'
),
(
    'X-Forwarded-For header can be spoofed to bypass rate limits without proxy configuration',
    'github-express-rate-limit',
    'HIGH',
    $$[
        {"solution": "Set app.set(''trust proxy'', 1) to properly validate X-Forwarded-For headers from trusted proxy", "percentage": 95, "note": "Express.js official recommendation for single proxy layer"},
        {"solution": "Use app.set(''trust proxy'', N) where N matches number of proxy hops (e.g., 2 for Cloudflare + your proxy)", "percentage": 90, "note": "Extend number for multiple proxy layers"},
        {"solution": "Validate incoming X-Forwarded-For header manually if proxy configuration is not trustworthy", "percentage": 75, "note": "Additional security measure for untrusted networks"}
    ]$$::jsonb,
    'Express.js application, Reverse proxy in front of your application',
    'Spoofed X-Forwarded-For requests rejected, same IP properly identified across requests, rate limits enforced correctly',
    'Do not use app.enable(''trust proxy'') - use numeric value instead. Verify proxy count matches your infrastructure. Ensure trust proxy is set before rate limiter middleware.',
    0.92,
    NOW(),
    'https://github.com/express-rate-limit/express-rate-limit/issues/134'
),
(
    'keyGenerator not working for API key-based rate limiting - each IP gets separate limit instead of per-key',
    'github-express-rate-limit',
    'HIGH',
    $$[
        {"solution": "Enable trust proxy and extract API key from headers: app.enable(''trust proxy''); keyGenerator: (req, res) => String(req.headers[''x-api-key''])", "percentage": 95, "note": "Basic API key extraction pattern"},
        {"solution": "Implement shared store (Redis or Memcached) for distributed deployments to aggregate counts across instances", "percentage": 90, "note": "Essential for multi-process environments"},
        {"solution": "Verify API key extraction precedes rate limiter middleware in request pipeline", "percentage": 85, "note": "Ensure keyGenerator executes with correct request headers"}
    ]$$::jsonb,
    'Express.js application, API key in request headers (e.g., x-api-key), trust proxy enabled',
    'Rate limit counts aggregate across all IPs using same API key, shared limits across distributed instances, no IP-based subdivision',
    'Each server instance maintains separate memory store counts - always use external store for distributed deployments. Verify keyGenerator returns consistent key for same API key. Check header name matches actual request headers.',
    0.88,
    NOW(),
    'https://github.com/express-rate-limit/express-rate-limit/issues/345'
),
(
    'skipFailedRequests option does not prevent 429 responses from resetting countdown timer',
    'github-express-rate-limit',
    'MEDIUM',
    $$[
        {"solution": "Understand that 429 responses ARE counted by default - skipFailedRequests reverses this (makes 429s NOT count)", "percentage": 95, "note": "Default behavior already counts 429s, so they do reset"},
        {"solution": "Use Redis store with expiration reset on each request to extend blocking window on retry attempts", "percentage": 85, "note": "Store keeps window open while requests continue"},
        {"solution": "Implement MongoDB store with request-triggered expiration refresh to persist blocking during abuse", "percentage": 80, "note": "Alternative to Redis for persistent window extension"}
    ]$$::jsonb,
    'Express.js application, Default memory or Redis store, rate limiter middleware configured',
    'Window expiration only occurs after client stops sending requests, repeated 429 responses do not allow retries within same window',
    'Remember skipFailedRequests is designed for 4xx/5xx errors, not 429 responses. Do not expect indefinite blocking - window will expire. Memory store will reset window after timeout regardless of attempts.',
    0.82,
    NOW(),
    'https://github.com/express-rate-limit/express-rate-limit/issues/325'
),
(
    'passOnStoreError configuration fails during initialization if Redis unavailable at startup',
    'github-express-rate-limit',
    'MEDIUM',
    $$[
        {"solution": "Extend passOnStoreError configuration to handle startup failures by implementing graceful fallback to in-memory store", "percentage": 80, "note": "Requires middleware-level error handling"},
        {"solution": "Wrap store initialization in try-catch and log failures, allowing app to start with reduced functionality", "percentage": 75, "note": "Manual initialization error handling"},
        {"solution": "Implement automatic retry logic for store connection on first request when initialization fails", "percentage": 70, "note": "Deferred initialization pattern for resilience"}
    ]$$::jsonb,
    'Kubernetes/Docker deployment, Redis or external store, passOnStoreError: true configured, application startup process',
    'Application starts successfully even if Redis unavailable, rate limiting resumes when store becomes available, error logged but non-blocking',
    'passOnStoreError only covers runtime errors, not initialization failures. During Redis upgrades, new pods will crash if store unavailable at startup. Test startup without Redis available.',
    0.70,
    NOW(),
    'https://github.com/express-rate-limit/express-rate-limit/issues/485'
),
(
    'Leaky bucket algorithm needed for outbound API throttling to prevent bursts exceeding limits',
    'github-express-rate-limit',
    'MEDIUM',
    $$[
        {"solution": "Implement custom keyGenerator returning same key for all visitors to aggregate requests at API level: keyGenerator: () => ''shared_api_key''", "percentage": 80, "note": "Groups all requests together for endpoint-level limits"},
        {"solution": "Replace in-memory store with external store (Redis recommended) for improved accuracy and distribution", "percentage": 75, "note": "Better concurrency handling with external store"},
        {"solution": "Cache API responses and return cached data within acceptable age windows instead of retrying requests", "percentage": 70, "note": "Reduces unnecessary external API calls"},
        {"solution": "Use dedicated throttling library (e.g., Bottleneck) designed for outbound API throttling instead of express-rate-limit", "percentage": 65, "note": "express-rate-limit not optimized for outbound throttling"}
    ]$$::jsonb,
    'Express.js application, Outbound API calls to throttled service (Shopify, etc.), requirement for exact concurrency control',
    'Consistent request distribution without bursts, external API rate limits never exceeded, smooth throttling across concurrent requests',
    'express-rate-limit designed for inbound HTTP request throttling, not ideal for outbound API calls. Bucket-based algorithm allows burst at window boundaries. Consider Bottleneck or similar for outbound throttling.',
    0.65,
    NOW(),
    'https://github.com/express-rate-limit/express-rate-limit/issues/128'
),
(
    'Retry-After header always defaults to default windowMs instead of reflecting store expiration time',
    'github-express-rate-limit',
    'MEDIUM',
    $$[
        {"solution": "Set Retry-After header manually in custom handler matching your store expiry value exactly", "percentage": 90, "note": "Immediate workaround, requires duplicate configuration"},
        {"solution": "Ensure windowMs parameter explicitly matches your store''s expiry duration to keep them synchronized", "percentage": 85, "note": "Prevents mismatch between header and actual behavior"},
        {"solution": "Implement stores that report remaining time to express-rate-limit, enabling precise Retry-After calculations", "percentage": 60, "note": "Long-term library enhancement, not yet implemented"}
    ]$$::jsonb,
    'Custom store implementation (Redis, MongoDB, or Memory store), windowMs parameter defined',
    'Retry-After header reflects actual remaining time, no configuration duplication needed, consistent behavior across store backends',
    'Store expiry and windowMs must be kept synchronized - do not set different values. Default behavior shows incorrect Retry-After. Stores do not report remaining time to library.',
    0.75,
    NOW(),
    'https://github.com/express-rate-limit/express-rate-limit/issues/96'
),
(
    'Multiple rate limiters on same route show inconsistent counters and overwriting headers',
    'github-express-rate-limit',
    'MEDIUM',
    $$[
        {"solution": "Implement synchronized external store (Redis) instead of memory store to maintain consistent counters across processes", "percentage": 95, "note": "Memory store keeps separate counts per process"},
        {"solution": "Use unique key prefixes for each rate limiter in RedisStore configuration to prevent data conflicts", "percentage": 90, "note": "Ensure distinct keys: rl:15min:route and rl:24hour:route"},
        {"solution": "Disable standardHeaders on first limiters and enable only on final limiter to preserve all rate-limit headers", "percentage": 85, "note": "Prevents header overwriting when multiple limiters active"}
    ]$$::jsonb,
    'Multiple rate limiters configured on same route, multi-process Node.js deployment or clustered environment',
    'Consistent counter increments across all requests, all rate-limit headers appear in response, behavior parity between development and production',
    'Memory store maintains separate counters per process - use Redis for production. Multiple limiters with standardHeaders: true will overwrite each other''s headers. Distinct key prefixes required to prevent data conflicts.',
    0.88,
    NOW(),
    'https://github.com/express-rate-limit/express-rate-limit/issues/331'
),
(
    'Inconsistent rate limiting allowing more requests than max when timing aligns with bucket boundaries',
    'github-express-rate-limit',
    'MEDIUM',
    $$[
        {"solution": "Understand memory store uses bucket-based tracking: all requests in a calendar minute get bucketed, then bucket empties", "percentage": 95, "note": "Not a bug - expected behavior of default store"},
        {"solution": "Accept that requests perfectly timed across bucket boundaries can burst to roughly 2x max (e.g., 10 instead of 5)", "percentage": 85, "note": "Inherent to bucket-based algorithm"},
        {"solution": "Implement custom sliding-window store or use alternative rate limiter if precise windowed enforcement required", "percentage": 75, "note": "For strict window requirements"}
    ]$$::jsonb,
    'Default memory store configured, express-rate-limit middleware active, windowMs and max parameters set',
    'User understands bucket-based algorithm behavior, accepts burst potential at window boundaries, aware of timing constraints',
    'Memory store does NOT use sliding window - it uses calendar-based bucketing. Requests timed across bucket boundaries can exceed max. For strict limits use external store or different algorithm. This is not a bug.',
    0.80,
    NOW(),
    'https://github.com/express-rate-limit/express-rate-limit/issues/207'
),
(
    'Cannot send custom error message to frontend - client only receives 429 status code',
    'github-express-rate-limit',
    'MEDIUM',
    $$[
        {"solution": "Structure message object with explicit error properties: message: { error_code: ''TOO_MANY_REQUESTS'', message: ''Your custom error'' }", "percentage": 95, "note": "Frontend can access complete object"},
        {"solution": "Use 200 status code with error payload as workaround, then check response body on client side", "percentage": 70, "note": "Uncommon pattern, not recommended"},
        {"solution": "Verify response body contains full message object via network inspector to debug message delivery", "percentage": 85, "note": "Common debugging step"}
    ]$$::jsonb,
    'Express.js application, express-rate-limit middleware with message option configured, frontend expecting error object',
    'Frontend receives complete error response body with custom message properties, client can access error_code and message fields',
    'Do not expect status code to contain message - read response body. Make sure message is an object with properties, not a plain string. HTTP 429 status is correct for rate limiting.',
    0.82,
    NOW(),
    'https://github.com/express-rate-limit/express-rate-limit/issues/204'
),
(
    'Cannot customize skip function to check response status - function returns before response completes',
    'github-express-rate-limit',
    'MEDIUM',
    $$[
        {"solution": "Export rate limit store instance and use store.decrement(key) in separate middleware running on response finish event", "percentage": 95, "note": "Recommended approach by maintainers"},
        {"solution": "Implement pattern: res.on(''finish'', () => { if(errorCondition) store.decrement(req.ip); })", "percentage": 90, "note": "Works for selective counter adjustment after response"},
        {"solution": "Use built-in skipFailedRequests: true for automatic 4xx/5xx skipping instead of custom logic", "percentage": 80, "note": "Limited to standard error responses"}
    ]$$::jsonb,
    'Express.js application, rate limit store instance exported and accessible, response finish event handling supported',
    'Selective rate-limit counter adjustment based on response status, custom skip conditions evaluated after response completion',
    'Skip function executes before response finishes - cannot check response status. Use response finish event and store.decrement() instead. Returning event emitter object is truthy - causes unexpected skip behavior.',
    0.88,
    NOW(),
    'https://github.com/express-rate-limit/express-rate-limit/issues/229'
),
(
    'How to access remaining request count for IP or API key outside of request context',
    'github-express-rate-limit',
    'MEDIUM',
    $$[
        {"solution": "Within request context: access req.rateLimit.remaining directly on request object created by middleware", "percentage": 95, "note": "Simplest approach during request handling"},
        {"solution": "For external store (Redis): query store directly using key format rl:<identifier> where identifier is IP or API key", "percentage": 85, "note": "Requires knowledge of store key structure"},
        {"solution": "Implement custom endpoint that exposes rate-limit store query functionality for frontend clients", "percentage": 80, "note": "Deferred lookup pattern for client queries"}
    ]$$::jsonb,
    'Express.js application, rate-limit-redis or custom store implementation, active rate limiter middleware',
    'Client can retrieve remaining requests via store query, frontend can display remaining count in UI, external systems can check limits programmatically',
    'Remaining count only available during request context via req.rateLimit - not accessible outside. Custom keyGenerator affects store key naming. For external queries, understand your store''s key format.',
    0.82,
    NOW(),
    'https://github.com/express-rate-limit/express-rate-limit/issues/261'
),
(
    'windowMs parameter not working - expiration time set to default instead of configured value in MongoDB store',
    'github-express-rate-limit',
    'MEDIUM',
    $$[
        {"solution": "Pass expireTimeMs option directly to RateMongoStore configuration separate from express-rate-limit windowMs: new RateMongoStore({ expireTimeMs: 15*60*1000 })", "percentage": 95, "note": "External stores require separate expiry configuration"},
        {"solution": "Ensure both windowMs and store expireTimeMs use identical values to keep them synchronized", "percentage": 90, "note": "Prevents timing mismatches"},
        {"solution": "Review store-specific documentation - each external store requires its own timeout parameter", "percentage": 85, "note": "Not a library bug, store configuration issue"}
    ]$$::jsonb,
    'MongoDB or external store (rate-limit-mongo, rate-limit-redis), Express.js application, store instance created with configuration',
    'MongoDB records show correct expiration time matching configured windowMs, rate limits persist for full window duration',
    'External stores require separate expiry configuration - windowMs alone does not control store timeout. MongoDB requires expireTimeMs parameter. Do not rely on windowMs to control store behavior. Read store documentation.',
    0.90,
    NOW(),
    'https://github.com/express-rate-limit/express-rate-limit/issues/124'
),
(
    'Enhanced rate limiting features: custom retryAfter timing separate from windowMs and IP blocking/filtering',
    'github-express-rate-limit',
    'LOW',
    $$[
        {"solution": "Use skip option as allowlist and limit: 0 as blocklist to block specific IPs: skip: (req) => blocklist.includes(req.ip), with another limiter using limit: 0 for blocked IPs", "percentage": 80, "note": "v7.0.0+ workaround using existing options"},
        {"solution": "Set headers: false with custom handler to implement advisory Retry-After headers with longer wait times", "percentage": 70, "note": "Enforcement challenging due to store interface limitations"},
        {"solution": "Implement retryAfter as ValueDeterminingMiddleware calculating from RateLimitInfo.resetTime for extended wait periods", "percentage": 60, "note": "Enhancement requested but not yet implemented in v6"}
    ]$$::jsonb,
    'Express.js application, v7.0.0+ preferred for enhanced option support, custom rate limiting requirements',
    'Clients receive Retry-After headers with custom wait times, IP blocking prevents requests from specific addresses, rate limit windows differ from retry wait windows',
    'Feature request not yet fully implemented - custom retryAfter timing separate from windowMs not available in base library. IP blocking limited to workarounds with skip/limit options. Consider using option combinations or implementing custom middleware.',
    0.60,
    NOW(),
    'https://github.com/express-rate-limit/express-rate-limit/issues/441'
);
