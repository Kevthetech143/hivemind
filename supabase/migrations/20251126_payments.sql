INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES
(
    'PayPal IPN was not sent, and the handshake was not verified',
    'payments',
    'HIGH',
    '[
        {"solution": "Check if your IPN endpoint domain is flagged as malware by Cisco Talos Intelligence. Use the IPN Simulator to test. If flagged, change to a different subdomain and update PayPal settings. Request removal from Talos if necessary.", "percentage": 92},
        {"solution": "Verify IPN URL in PayPal settings matches your actual endpoint. Check SSL certificate validity and ensure the URL is accessible from PayPal''s IP ranges.", "percentage": 78}
    ]'::jsonb,
    'Access to Talos Intelligence website, ability to change domain or subdomains, PayPal merchant account access',
    'New transactions use the updated IPN URL successfully. Check IPN History in PayPal to confirm receipt of recent payments.',
    'Assuming SSL certificate issues when the real cause is domain reputation. Not checking PayPal IPN History. Using IPN Simulator but ignoring its diagnostic messages.',
    0.88,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/69502932/my-server-is-suddenly-not-receiving-ipn-requests-from-paypal-any-more-worked-fo',
    'admin:1764173694'
),
(
    'Stripe webhook signature verification failed',
    'payments',
    'HIGH',
    '[
        {"solution": "Place webhook route BEFORE express.json() middleware. Use express.raw({type: ''application/json''}) on the webhook route to preserve the raw request body needed for signature verification.", "percentage": 96},
        {"solution": "Verify you''re using the correct webhook signing secret (starts with whsec_) not the webhook ID. Check Stripe dashboard for the correct secret.", "percentage": 88}
    ]'::jsonb,
    'Express.js application with body parsing middleware, Stripe API key, webhook signing secret from Stripe dashboard',
    'stripe.webhooks.constructEvent() no longer throws signature verification errors. Webhook events are successfully processed.',
    'Parsing body to JSON before webhook handler executes. Using wrong webhook secret (webhook ID instead of signing secret). Not preserving raw request body in Firebase Functions or serverless environments.',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/70159949/webhook-signature-verification-failed-with-express-stripe',
    'admin:1764173694'
),
(
    'Stripe error: No signatures found matching the expected signature for payload',
    'payments',
    'HIGH',
    '[
        {"solution": "Apply express.raw() middleware ONLY to webhook routes, before global express.json(). In Next.js, set bodyParser: false for webhook routes. Use req.rawBody in Firebase Functions instead of req.body.", "percentage": 95},
        {"solution": "Verify webhook signing secret from Stripe dashboard (not webhook ID). For Stripe CLI testing, use the CLI-provided secret, not the dashboard secret.", "percentage": 87},
        {"solution": "Check webhook endpoint URL in Stripe dashboard matches exactly (trailing slashes, protocol, domain).", "percentage": 72}
    ]'::jsonb,
    'Web framework with body parsing middleware, access to Stripe dashboard, correct webhook signing secret',
    'constructEvent() returns event object without throwing VerificationError. Webhook events process successfully. Test with Stripe CLI: stripe listen and stripe trigger charge.succeeded.',
    'Using webhook ID instead of signing secret. Applying JSON parser before raw body parser. Incorrect webhook URL endpoint registered in Stripe dashboard. Using wrong CLI secret during local testing.',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/53899365/stripe-error-no-signatures-found-matching-the-expected-signature-for-payload',
    'admin:1764173694'
),
(
    'Stripe checkout session expires after 24 hours, need shorter timeout',
    'payments',
    'MEDIUM',
    '[
        {"solution": "Use expires_at parameter when creating checkout session. Minimum expiration is 30 minutes, maximum 24 hours. Set expires_at to Unix timestamp 30min-24hr from now.", "percentage": 85},
        {"solution": "For timeouts under 30 minutes (not supported by Stripe), manually expire sessions using Stripe API or cancel the associated Payment Intent when your application timeout occurs.", "percentage": 78}
    ]'::jsonb,
    'Stripe SDK/API access, ability to set Unix timestamps when creating checkout sessions',
    'Checkout session created with desired expires_at timestamp. Session status is "open" before expiration. Session auto-expires at specified time or can be manually expired.',
    'Expecting Stripe to support sub-30-minute expirations (not possible). Setting expires_at to past timestamp (must be future). Not handling session expiration on application side for custom timeouts.',
    0.83,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/62797608/how-to-set-a-timeout-for-a-stripe-session-checkout',
    'admin:1764173694'
),
(
    'Stripe error: Payment for subscription requires additional user action, enable_incomplete_payments',
    'payments',
    'MEDIUM',
    '[
        {"solution": "Update Stripe API version in dashboard (not just SDK library version). Go to Account Settings > API Version and set to 2019-05-16 or later for proper 3D Secure support.", "percentage": 91},
        {"solution": "When creating subscriptions with 3D Secure cards, add enable_incomplete_payments=true parameter to allow the payment intent to proceed.", "percentage": 86}
    ]'::jsonb,
    'Stripe merchant account with API version settings accessible, ability to change Stripe API version in dashboard',
    'Subscription creation succeeds with 3D Secure test cards. Payment intent returns requires_action status correctly. 3D Secure authentication flow initiates as expected.',
    'Only updating library version without changing API version in Stripe dashboard. Not enabling incomplete payments for subscriptions. Using outdated API versions (pre-2019).',
    0.89,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/56279543/why-is-stripe-not-giving-me-a-payment-intents-requires-action-status-when-i-use',
    'admin:1764173694'
),
(
    'PayPal error: INSTRUMENT_DECLINED - The instrument presented was declined by processor or bank',
    'payments',
    'MEDIUM',
    '[
        {"solution": "Provide alternative payment method option to user. In onApprove callback, handle error response and allow user to restart with different payment method.", "percentage": 88},
        {"solution": "Verify customer billing address matches cardholder records exactly. Billing address mismatch is the most common cause of this error.", "percentage": 82},
        {"solution": "Check if card has spending limits or is geographically restricted. Some prepaid cards won''t work for certain transaction types.", "percentage": 75}
    ]'::jsonb,
    'PayPal API integration with error handling, ability to display alternative payment options to user',
    'Payment method accepted or user selects alternative method. Transaction completes successfully. No INSTRUMENT_DECLINED error in logs.',
    'Assuming code issue when this is a legitimate payment decline. Not providing user with alternative payment methods. Expecting sandbox success to guarantee live success.',
    0.85,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/38731291/paypal-instrument-declined-when-in-live-mode-using-api',
    'admin:1764173694'
),
(
    'Stripe test card 4000000000000002 declined at source creation, need to test charge decline',
    'payments',
    'MEDIUM',
    '[
        {"solution": "Use test card 4000000000000341 instead of 4000000000000002. This card successfully attaches to a customer but will decline when you attempt to charge it.", "percentage": 93},
        {"solution": "Test both scenarios separately: source creation (attach card to customer) and charge processing (attempt transaction). Use appropriate test cards for each stage.", "percentage": 88}
    ]'::jsonb,
    'Stripe test account with test mode enabled, Stripe SDK integrated',
    'Test card 4000000000000341 successfully creates source. Charge attempt returns decline error. Can test full payment flow including error handling.',
    'Using 4000000000000002 for all testing (only works for charge decline, not source creation). Expecting generic decline error code for insufficient funds specifically.',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/51099776/how-to-add-a-payment-source-with-insufficient-funds-using-stripe',
    'admin:1764173694'
),
(
    'PayPal Transaction Search API error: PERMISSION_DENIED, No Permission for the requested operation',
    'payments',
    'MEDIUM',
    '[
        {"solution": "Enable Transaction Search permission in PayPal Developer Dashboard REST App settings. Check the ''Transaction Search'' permission checkbox.", "percentage": 94},
        {"solution": "After enabling permission, manually terminate cached access tokens using endpoint: https://api-m.sandbox.paypal.com/v1/oauth2/token/terminate (or wait up to 9 hours for automatic refresh).", "percentage": 89},
        {"solution": "Verify OAuth2 token response includes scope: https://uri.paypal.com/services/reporting/search/read before making API calls.", "percentage": 81}
    ]'::jsonb,
    'PayPal Developer Account with REST App created, access to App settings in dashboard, valid OAuth2 credentials',
    'Transaction Search API calls succeed without PERMISSION_DENIED error. OAuth token includes required reporting scope. Query results return successfully.',
    'Not checking token scopes in OAuth response. Not terminating cached tokens after permission changes. Using Live API credentials with Sandbox endpoint or vice versa.',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/60841785/paypal-transaction-search-api-permission-denied-no-permission-for-the-requeste',
    'admin:1764173694'
)
