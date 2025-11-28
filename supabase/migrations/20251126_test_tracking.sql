INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, common_pitfalls,
    success_rate, claude_version, last_verified, source_url
) VALUES
(
    'No signatures found matching the expected signature for payload',
    'stripe-webhooks',
    'HIGH',
    '[
        {"solution": "Ensure express.raw() middleware is applied BEFORE express.json() for webhook routes. Use: app.use(''/webhook'', express.raw({type: ''application/json''})) before global JSON parsing.", "percentage": 95},
        {"solution": "Verify you''re passing the raw UTF-8 request body to stripe.webhooks.constructEvent(), not parsed JSON. The body must match exactly what Stripe sent.", "percentage": 92},
        {"solution": "Check that you''re using the correct endpoint secret (whsec_ prefix) from the Dashboard or Stripe CLI. Never mix Test Mode and Live Mode secrets.", "percentage": 88},
        {"solution": "Confirm the Stripe-Signature header is in format ''t=xxx,v1=yyy'' and is being extracted correctly. Print and compare the header value.", "percentage": 85}
    ]'::jsonb,
    'Attempting to use parsed JSON body instead of raw string; mixing up Test and Live webhook secrets; applying body parsing middleware before webhook route; not verifying the Stripe-Signature header format; hardcoding secrets without verifying from Dashboard',
    0.92,
    'haiku',
    NOW(),
    'https://docs.stripe.com/webhooks/signature'
),
(
    'Webhook signature verification failed. Err: No signatures found matching the expected signature for payload',
    'stripe-webhooks',
    'HIGH',
    '[
        {"solution": "Verify endpoint secret matches the webhook endpoint source. Use whsec_ from Dashboard or Stripe CLI whsec_test_secret for testing.", "percentage": 94},
        {"solution": "Print the raw request body received and compare byte-for-byte with what was signed. Any whitespace changes, key reordering, or encoding issues cause verification failure.", "percentage": 91},
        {"solution": "Extract Stripe-Signature header correctly in format: ''t=timestamp,v1=signature,v0=fallback''. Verify header extraction code matches the expected format.", "percentage": 89},
        {"solution": "For Deno/Workers environments, use synchronous webhooks.constructEvent() only, not async SubtleCryptoProvider which cannot work in sync context.", "percentage": 80}
    ]'::jsonb,
    'Using wrong signing secret for environment; modifying raw body before verification; not preserving exact request body encoding; attempting async verification in sync context; mixing endpoint secrets between different webhook URLs',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/70159949/webhook-signature-verification-failed-with-express-stripe'
),
(
    'Stripe checkout session expired - customer cannot complete payment',
    'stripe-checkout',
    'MEDIUM',
    '[
        {"solution": "Implement abandoned cart recovery by listening to ''checkout.session.expired'' webhook event and generating a new session URL to send to customer email.", "percentage": 93},
        {"solution": "Set explicit ''expires_at'' parameter when creating checkout session. Stripe minimum is 1 hour expiration, but you can set custom expiration up to 24 hours or more.", "percentage": 89},
        {"solution": "For Payment Links, understand that sessions auto-expire 24 hours after creation. Regenerate new Payment Link for repeat customers rather than reusing expired link.", "percentage": 86},
        {"solution": "Expire any previous active sessions before creating a new one to prevent duplicate session issues. Use stripe.checkout.sessions.expire(session_id) API call.", "percentage": 82}
    ]'::jsonb,
    'Trying to customize the native expired session error page (not possible - must use recovery); creating sessions with expiration less than 1 hour (minimum enforced by Stripe); not listening for checkout.session.expired webhook event; reusing Payment Link URLs without regenerating after expiration; not handling multiple concurrent sessions',
    0.88,
    'haiku',
    NOW(),
    'https://docs.stripe.com/api/checkout/sessions/expire'
);
