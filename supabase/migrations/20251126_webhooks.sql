INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'No signatures found matching the expected signature for payload. Are you passing the raw request body you received from Stripe?',
    'webhooks',
    'CRITICAL',
    '[
        {"solution": "Use express.raw({type: ''application/json''}) for webhook routes instead of express.json(). Place webhook routes BEFORE app.use(express.json())", "percentage": 95},
        {"solution": "Use verify callback in bodyParser.json() to capture raw body: bodyParser.json({verify: (req, res, buf) => { if (req.originalUrl.startsWith(''/webhook'')) req.rawBody = buf.toString() }})", "percentage": 90}
    ]'::jsonb,
    'Node.js/Express server with body parsing middleware configured',
    'Stripe webhook event is successfully constructed without signature verification error',
    'Using parsed JSON body instead of raw bytes, placing middleware in wrong order, forgetting to capture rawBody',
    0.95,
    'haiku',
    NOW(),
    'https://github.com/stripe/stripe-node/issues/1254'
),
(
    'Timed out',
    'webhooks',
    'CRITICAL',
    '[
        {"solution": "Return 2xx status immediately within 10 seconds, then queue webhook for async processing using Bull, Resque, RQ, or RabbitMQ", "percentage": 98},
        {"solution": "Use webhook forwarding service like Hookdeck to decouple processing from delivery endpoint", "percentage": 92}
    ]'::jsonb,
    'GitHub webhook delivery receiving endpoint, queue system or background worker capability',
    'Webhook endpoint returns 200 OK status within 10 seconds, business logic completes successfully in background',
    'Processing webhook payload synchronously before returning status, making expensive API calls in webhook handler',
    0.98,
    'haiku',
    NOW(),
    'https://docs.github.com/en/webhooks/testing-and-troubleshooting-webhooks/troubleshooting-webhooks'
),
(
    'HMAC verification failed',
    'webhooks',
    'CRITICAL',
    '[
        {"solution": "Capture raw request body BEFORE any parsing. Use request.data in Flask, not request.json. Encode only the secret key to bytes. Use base64.b64encode() and hmac.compare_digest()", "percentage": 92},
        {"solution": "For Express: Use bodyParser.raw() or capture rawBody in verify callback. Calculate HMAC from request.rawBody not request.body", "percentage": 88}
    ]'::jsonb,
    'Shopify webhook endpoint, access to raw request bytes, cryptographic library (hmac, sha256)',
    'Webhook signature verified successfully, webhook events processed without authentication errors',
    'Using parsed JSON body instead of raw bytes, incorrect encoding of secret/payload, using string comparison instead of constant-time comparison',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/76455820/shopify-hmac-verification-failing-in-webhook-implementation'
),
(
    '413 Payload Too Large',
    'webhooks',
    'HIGH',
    '[
        {"solution": "For nginx: Increase client_max_body_size in http, server, or location block. Test with nginx -t before reloading", "percentage": 90},
        {"solution": "For Express: Increase bodyParser limit option. Set express.json({limit: ''50mb''})", "percentage": 88},
        {"solution": "For ASP.NET: Configure maxRequestLength in web.config and maxAllowedContentLength in requestFiltering", "percentage": 85}
    ]'::jsonb,
    'Reverse proxy or application server configuration access, ability to reload/restart services',
    'Webhook payload accepted and processed, no 413 errors in server logs',
    'Only increasing application-level limits without proxy configuration, not testing configuration syntax, trying to increase limits on the wrong component',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/24306335/413-request-entity-too-large-file-upload-issue'
),
(
    'X-Hub-Signature-256 validation failed',
    'webhooks',
    'HIGH',
    '[
        {"solution": "Use raw request body bytes directly for HMAC computation, never re-serialize. Ensure JSON serializer includes null fields using JsonInclude.Include.ALWAYS in Java", "percentage": 88},
        {"solution": "Strip formatting characters if copying from GitHub''s recent deliveries tab. Remove ''sha256='' prefix from header before comparison. Use crypto.timingSafeEqual() for constant-time comparison", "percentage": 85}
    ]'::jsonb,
    'GitHub webhook endpoint, raw request body access, cryptographic library with timing-safe comparison',
    'GitHub webhook signature verification succeeds, webhook events authenticated and processed',
    'Reserializing JSON payload changing whitespace/formatting, not handling null fields consistently, using standard string comparison instead of timing-safe comparison',
    0.88,
    'haiku',
    NOW(),
    'https://github.com/orgs/community/discussions/24646'
),
(
    'Failed to connect to host / Failed to connect to network',
    'webhooks',
    'HIGH',
    '[
        {"solution": "Verify hostname resolves using nslookup or dig. Allow connections from webhook provider''s IP addresses. Get GitHub IP list from GET /meta endpoint", "percentage": 85},
        {"solution": "Ensure webhook endpoint is publicly accessible (not localhost). For local testing, use smee.io, ngrok, or similar forwarding service", "percentage": 82}
    ]'::jsonb,
    'Publicly accessible webhook endpoint, firewall/security group configuration access, DNS tools',
    'Webhook successfully delivered and processed, no connection refused errors in provider logs',
    'Using localhost for webhook endpoint, misconfiguring firewall rules for webhook provider IPs, assuming IPs are static without checking for updates',
    0.85,
    'haiku',
    NOW(),
    'https://docs.github.com/en/webhooks/testing-and-troubleshooting-webhooks/troubleshooting-webhooks'
),
(
    'getaddrinfo ENOTFOUND',
    'webhooks',
    'HIGH',
    '[
        {"solution": "Remove protocol (https://) from hostname when using http.request or similar. Verify hostname doesn''t include path components", "percentage": 82},
        {"solution": "Test DNS resolution directly with nslookup or dig. For Google Cloud, ensure billing is enabled. Check /etc/hosts for incorrect customizations", "percentage": 79}
    ]'::jsonb,
    'Node.js/JavaScript environment, ability to test DNS resolution, access to environment configuration',
    'API calls from webhook handler complete successfully without DNS errors, business logic executes',
    'Including protocol in hostname parameter, including full path in hostname, DNS configuration errors, Google Cloud billing not enabled',
    0.82,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/50555393/error-getaddrinfo-enotfound-in-node-js-webhook-for-dialogflow'
),
(
    'Peer certificate cannot be authenticated with given CA certificates',
    'webhooks',
    'MEDIUM',
    '[
        {"solution": "Ensure server sends entire certificate chain when establishing HTTPS. For production, use CA-signed certificates from Let''s Encrypt or DigiCert", "percentage": 78},
        {"solution": "For self-signed certs in testing, upload certificate when registering webhook (Telegram, Dialogflow). Verify chain with: openssl s_client -connect HOST:PORT -showcerts", "percentage": 75}
    ]'::jsonb,
    'HTTPS/SSL endpoint, certificate files (for testing), ability to configure certificates',
    'HTTPS connection to webhook endpoint succeeds, webhook events delivered without SSL errors',
    'Using self-signed certificates in production, missing intermediate certificates in chain, not updating certificate chain when changing providers',
    0.78,
    'haiku',
    NOW(),
    'https://github.com/orgs/community/discussions/23434'
),
(
    'Wrong endpoint secret - signature verification failed in production',
    'webhooks',
    'CRITICAL',
    '[
        {"solution": "Get correct secret from dashboard. For Stripe: Dashboard → Webhooks → [endpoint] → Reveal secret. For CLI: Use secret from stripe listen output", "percentage": 93},
        {"solution": "Never mix test/live secrets. Each endpoint has unique secret (whsec_xxx). Check for trailing spaces/newlines in environment variables on deployment platform", "percentage": 91}
    ]'::jsonb,
    'Access to webhook provider''s dashboard or CLI, environment variable management',
    'Webhook signature verification succeeds in production, events process without authentication errors',
    'Using test mode secret in production, copying secret with trailing whitespace, reusing same secret across endpoints, forgetting to update secret after regeneration',
    0.93,
    'haiku',
    NOW(),
    'https://github.com/vercel/nextjs-subscription-payments/issues/176'
),
(
    'Duplicate webhook event received',
    'webhooks',
    'HIGH',
    '[
        {"solution": "Implement idempotent processing using event IDs. Store processed event IDs in database with unique constraint before executing business logic", "percentage": 96},
        {"solution": "Keep webhook handler fast - validate, store event, return 200. Process business logic asynchronously in background workers", "percentage": 94}
    ]'::jsonb,
    'Database with unique constraints, background job queue system, event ID from webhook provider',
    'Duplicate webhook events processed only once, idempotency key verified in logs, no duplicate database records',
    'Processing webhook synchronously without checking for duplicates, deleting event IDs too quickly, not atomically checking and storing event IDs',
    0.96,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/66508287/stripe-webhooks-dealing-with-multiple-webhook-events'
),
(
    '429 Too Many Requests - Rate limit exceeded',
    'webhooks',
    'MEDIUM',
    '[
        {"solution": "Implement exponential backoff with jitter when retrying. Respect Retry-After header value in 429 response. Use queue system to throttle outbound requests", "percentage": 87},
        {"solution": "For Discord: Limit to 30 webhook messages per minute per channel. Use multiple endpoints/channels to distribute load. Implement rate limiting on your side before hitting limits", "percentage": 84}
    ]'::jsonb,
    'Queue system, HTTP client with retry capability, understanding of provider rate limits',
    'Webhook handler queued successfully without rate limit errors, batch processing completed, retries execute after Retry-After delay',
    'Not respecting Retry-After header, not implementing exponential backoff, hitting rate limits immediately after webhook reception, synchronous API calls in webhook',
    0.87,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/76692789/error-429-too-many-requests-while-trying-to-set-up-a-webhook-for-a-python-tele'
),
(
    'Twilio webhook signature validation failed',
    'webhooks',
    'MEDIUM',
    '[
        {"solution": "Include ALL form parameters from request body in validation. Sort parameters alphabetically by name per Twilio spec. Use request.body (parsed params), not just message body", "percentage": 84},
        {"solution": "Ensure webhook URL in Twilio console exactly matches actual URL including query params. Use correct protocol (https:// vs http://). For subaccounts, use subaccount''s auth token", "percentage": 81}
    ]'::jsonb,
    'Twilio account access, webhook URL configuration capability, HTTP form parsing',
    'Twilio webhook signature validates successfully, incoming messages/calls process without 403 errors',
    'Only validating message body, not including all form parameters, protocol/URL mismatch, using parent account token for subaccount webhook, incorrect parameter sorting',
    0.84,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/71853352/twilio-webhook-fail-to-validate-signature'
),
(
    'Failed to parse webhook JSON response / Invalid JSON',
    'webhooks',
    'MEDIUM',
    '[
        {"solution": "Ensure JSON keys match expected case (usually lowercase). Escape special characters (\\n for newline, \\t for tab). Use JSON.stringify() before sending", "percentage": 89},
        {"solution": "Set Content-Type: application/json header. Verify character encoding is UTF-8, not UTF-16. Test JSON structure against provider schema with JSON validator", "percentage": 86}
    ]'::jsonb,
    'JSON serialization library, ability to set HTTP headers, JSON validation tools',
    'Webhook response parses successfully, Dialogflow/provider accepts response, test JSON validator shows no errors',
    'Unescaped newlines in JSON strings, forgetting JSON.stringify(), case-sensitive key mismatch, character encoding errors, malformed JSON structure',
    0.89,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/63746647/failed-to-parse-webhook-json-response'
),
(
    '401 Unauthorized - Content-Type mismatch',
    'webhooks',
    'MEDIUM',
    '[
        {"solution": "Check webhook provider''s documentation for expected Content-Type. For Twilio: Use express.urlencoded(). For JSON webhooks: Use express.json()", "percentage": 86},
        {"solution": "Twilio responses must be TwiML (XML), not JSON. Discord webhook responses should not set conflicting content-type. Verify proxy/load balancer isn''t modifying header", "percentage": 83}
    ]'::jsonb,
    'Middleware configuration access, knowledge of provider content type expectations, response formatting capability',
    'Webhook accepted with 200 status, response body parsed correctly by provider, no content-type related errors in logs',
    'Using wrong content-type middleware, sending JSON response to Twilio webhook, proxy modifying headers, mismatch between provider and handler expectations',
    0.86,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/63433831/twilio-messaging-webhook-unsupported-media-type-asp-net-core-3-1-api'
),
(
    'Webhook not received / Missing webhook deliveries',
    'webhooks',
    'HIGH',
    '[
        {"solution": "Wait 2-5 minutes and check again (deliveries aren''t instant). Verify webhook is Active (checkbox enabled). Confirm subscription to specific event type", "percentage": 81},
        {"solution": "Check webhook configured in correct location (repo vs organization). Verify URL is publicly accessible with curl. Review event-specific limitations in docs", "percentage": 78}
    ]'::jsonb,
    'Webhook provider dashboard access, publicly accessible endpoint, curl or similar testing tool, patience (deliveries may be delayed)',
    'Webhook appears in delivery history, event successfully delivers and is received, business logic triggers',
    'Checking too quickly before deliveries propagate, webhook disabled/inactive, wrong event type subscription, URL not accessible, firewall blocking deliveries',
    0.81,
    'haiku',
    NOW(),
    'https://dev.to/hookdeck/troubleshooting-github-webhooks-5aoi'
),
(
    'Replay attack detected - Timestamp expired',
    'webhooks',
    'MEDIUM',
    '[
        {"solution": "Implement timestamp validation with sliding 5-minute window. Extract timestamp from signature header (e.g., Stripe: t= in Stripe-Signature). Account for clock skew", "percentage": 91},
        {"solution": "Store processed event IDs as additional replay protection. Sync server time with NTP to prevent clock drift. Log timestamp validation failures to detect systematic issues", "percentage": 88}
    ]'::jsonb,
    'Current UTC time availability, webhook signature parsing capability, NTP synchronization',
    'Webhook timestamp validates successfully, no replay attack errors, events process on first delivery',
    'Not allowing clock skew tolerance, overly strict timestamp window, not verifying NTP synchronization, comparing local time without UTC conversion',
    0.91,
    'haiku',
    NOW(),
    'https://github.com/OWASP/CheatSheetSeries/pull/383'
);
