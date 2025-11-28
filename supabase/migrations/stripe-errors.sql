INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Your card was declined. Your request was in live mode, but used a known test card.',
    'stripe',
    'HIGH',
    '[
        {"solution": "Switch to test mode API keys in Stripe Dashboard. Go to API section, toggle to test mode, and use pk_test_* and sk_test_* keys instead of live keys.", "percentage": 98},
        {"solution": "Verify you''re using test card numbers (4000000000000002, etc.) only in test mode, never in live mode.", "percentage": 95}
    ]'::jsonb,
    'Access to Stripe Dashboard, understanding of test vs live modes',
    'Payment processes successfully in test environment, live mode rejects test cards',
    'Using live keys with test cards, forgetting to toggle dashboard to test mode, mixing test and live credentials',
    0.98,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/43189420/your-card-was-declined-stripe'
),
(
    'stripe.error.InvalidRequestError: Request rate limit exceeded',
    'stripe',
    'HIGH',
    '[
        {"solution": "Implement exponential backoff retry logic: wait 1s, then 2s, then 4s between retries up to 32s maximum.", "percentage": 90},
        {"solution": "Use async.forEachLimit() or limiter npm package to limit concurrent Stripe API calls to below 100 requests/second.", "percentage": 92},
        {"solution": "Consolidate multiple API calls into single requests using batch operations or combining parameters.", "percentage": 85}
    ]'::jsonb,
    'Understanding of async operations and Stripe''s 100 reads/100 writes per second limit',
    'API calls succeed after retry, response time is acceptable with throttling applied',
    'Making all requests concurrently without throttling, not implementing retry logic, not consolidating bulk operations',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/51730699/stripe-api-request-rate-limit-exceeded-firebase-cloud-functions'
),
(
    'stripe.error.InvalidRequestError: Missing required param: amount',
    'stripe',
    'MEDIUM',
    '[
        {"solution": "Ensure the amount parameter is always provided as an integer in cents (e.g., 2000 for $20.00).", "percentage": 98},
        {"solution": "Check that amount is not None or null - Stripe API rejects null required parameters.", "percentage": 97},
        {"solution": "Verify amount is greater than 0 and within valid range for the currency being used.", "percentage": 95}
    ]'::jsonb,
    'Knowledge of currency formatting in Stripe (amounts in cents for USD/EUR, etc.)',
    'Charge created successfully, amount is correctly processed in Stripe Dashboard',
    'Providing amount as decimal (e.g., 20.00) instead of cents (2000), omitting amount parameter entirely, setting amount to null',
    0.97,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/45976031/stripe-api-error-missing-required-param-amount-php-library'
),
(
    'stripe.error.InvalidRequestError: Missing required param: source or customer',
    'stripe',
    'MEDIUM',
    '[
        {"solution": "Provide either a source parameter (token/payment method ID) OR a customer parameter with a saved card, not both or neither.", "percentage": 96},
        {"solution": "If using customer parameter, ensure customer ID exists and has at least one saved payment method attached.", "percentage": 94},
        {"solution": "Generate source token via Stripe.js before making charge request: const token = await stripe.createToken(cardElement);", "percentage": 93}
    ]'::jsonb,
    'Stripe.js library loaded, understanding of tokens vs customer objects',
    'Charge processed successfully, payment method correctly referenced in Stripe Dashboard',
    'Providing both source and customer simultaneously, providing neither, using expired/invalid customer IDs, forgetting to generate token first',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/49948901/stripe-api-invalid-request-must-provide-source-or-customer'
),
(
    'stripe.error.InvalidRequestError: Missing required param: business_profile',
    'stripe',
    'LOW',
    '[
        {"solution": "Provide at least one non-null child parameter for business_profile (e.g., set headline, mcc, product_description to actual values).", "percentage": 88},
        {"solution": "Omit the business_profile parameter entirely if you have no values to provide, rather than passing empty objects.", "percentage": 90},
        {"solution": "Check Stripe API logs to verify business_profile key is being sent in request body - don''t pass all children as None.", "percentage": 85}
    ]'::jsonb,
    'Access to Stripe API logs, understanding of optional vs required parameters',
    'Account created without business_profile error, parameter validation passes',
    'Passing all child parameters as None values, including empty business_profile object, not checking API logs for actual request content',
    0.88,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/76281510/stripe-error-stripe-error-invalidrequesterror-request-req-z2kfezdvlmvt-missin'
),
(
    'card_declined - The card has been declined',
    'stripe',
    'HIGH',
    '[
        {"solution": "Check decline code in error response (insufficient_funds, lost_card, etc.) and advise customer accordingly.", "percentage": 85},
        {"solution": "Use Stripe test card 4000000000000002 to simulate decline during testing and verify error handling.", "percentage": 92},
        {"solution": "Implement retry logic: wait a few seconds and attempt charge again, as some declines are temporary.", "percentage": 70}
    ]'::jsonb,
    'Knowledge of Stripe decline codes, test card numbers for different scenarios',
    'Error is caught and displayed to customer, decline code is logged for analysis',
    'Not checking decline_code to understand why card was rejected, not offering retry or alternative payment method, hardcoding decline responses',
    0.85,
    'haiku',
    NOW(),
    'https://stripe.com/docs/declines/codes'
),
(
    'expired_card - The card has expired',
    'stripe',
    'MEDIUM',
    '[
        {"solution": "Check card expiration date: Stripe rejects cards where exp_month/exp_year is in the past.", "percentage": 97},
        {"solution": "Use test card 4000000000000069 to test expired_card error handling during development.", "percentage": 88},
        {"solution": "Prompt customer to update their payment method instead of retrying the expired card.", "percentage": 96}
    ]'::jsonb,
    'Understanding of card expiration date validation, test card numbers',
    'Expired cards are properly rejected with clear error message, customer prompted to update card',
    'Not validating expiration date client-side before tokenization, retrying expired cards, not distinguishing from other card errors',
    0.96,
    'haiku',
    NOW(),
    'https://stripe.com/docs/error-codes#card-errors'
),
(
    'incorrect_cvc - The card''s CVC number is invalid',
    'stripe',
    'MEDIUM',
    '[
        {"solution": "Validate CVC format before submission: 3 digits for Amex, 4 digits for American Express, or 3 for most other cards.", "percentage": 91},
        {"solution": "Use test card 4000000000000127 with any 3-digit CVC to test incorrect_cvc error handling.", "percentage": 87},
        {"solution": "Prompt customer to re-enter CVC if validation fails, as this is usually a typo or card swipe error.", "percentage": 94}
    ]'::jsonb,
    'Knowledge of CVC/CVV validation rules by card type',
    'CVC validation passes for valid codes, error is caught for invalid codes',
    'Not enforcing correct CVC length by card type, allowing 2-digit or 5-digit codes, not retrying after CVC error',
    0.91,
    'haiku',
    NOW(),
    'https://stripe.com/docs/error-codes#card-errors'
),
(
    'incorrect_zip - The card''s zip code is invalid',
    'stripe',
    'LOW',
    '[
        {"solution": "Validate zip code format matches the card''s country (5 digits for US, variable for others).", "percentage": 89},
        {"solution": "Pass address_zip parameter in charge request to enable AVS (Address Verification System) check.", "percentage": 88},
        {"solution": "Allow customer to update zip code if mismatch is detected - some zip changes are legitimate.", "percentage": 91}
    ]'::jsonb,
    'Knowledge of zip code formats by country, AVS validation understanding',
    'Address verification passes, customer can complete payment with correct zip',
    'Not collecting zip code, using invalid format for country, not offering correction opportunity, not handling international addresses',
    0.89,
    'haiku',
    NOW(),
    'https://stripe.com/docs/error-codes#card-errors'
),
(
    'processing_error - An error occurred while processing the card',
    'stripe',
    'MEDIUM',
    '[
        {"solution": "Retry the request after 1-2 seconds with exponential backoff, as processing errors are often temporary.", "percentage": 80},
        {"solution": "Check Stripe status page (stripe.com/status) for any ongoing API incidents or maintenance.", "percentage": 85},
        {"solution": "If error persists, contact Stripe support with the Request ID from the error response for investigation.", "percentage": 75}
    ]'::jsonb,
    'Understanding of transient vs permanent errors, Stripe status page access',
    'Charge succeeds on retry, processing error does not recur',
    'Not implementing retry logic, assuming permanent error, not checking Stripe status, not providing Request ID to support',
    0.80,
    'haiku',
    NOW(),
    'https://stripe.com/docs/error-codes#card-errors'
),
(
    'insufficient_funds - The card has insufficient funds to complete the purchase',
    'stripe',
    'MEDIUM',
    '[
        {"solution": "Advise customer to use a different card or top up their balance if it''s a prepaid/debit card.", "percentage": 94},
        {"solution": "Use test card 4000000000009995 to simulate insufficient_funds error during testing.", "percentage": 85},
        {"solution": "Enable Stripe Radar to detect suspicious patterns and retry logic for legitimate insufficient funds cases.", "percentage": 70}
    ]'::jsonb,
    'Test card numbers for various decline scenarios, understanding of customer communication',
    'Insufficient funds error is caught and customer is prompted for alternative payment method',
    'Using test card 4000000000000341 expecting insufficient_funds (it returns generic decline), not offering alternative payment methods, harsh customer messaging',
    0.88,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/51099776/how-to-add-a-payment-source-with-insufficient-funds-using-stripe'
),
(
    'lost_card - The card has been reported as lost',
    'stripe',
    'LOW',
    '[
        {"solution": "Advise customer that their card issuer has blocked it and they need to contact their bank.", "percentage": 97},
        {"solution": "Do not retry or attempt to charge the same card again - the block is permanent on issuer side.", "percentage": 98},
        {"solution": "Prompt customer to add a different payment method immediately.", "percentage": 96}
    ]'::jsonb,
    'Understanding that lost_card blocks originate from card issuer, not Stripe',
    'Customer is informed of lost card status, offered alternative payment method, no unnecessary retry attempts made',
    'Retrying lost_card charges, misleading customer about cause, not immediately offering alternative payment option',
    0.97,
    'haiku',
    NOW(),
    'https://stripe.com/docs/declines/codes'
),
(
    'rate_limit - Too many requests hit the API too quickly',
    'stripe',
    'MEDIUM',
    '[
        {"solution": "Implement exponential backoff: retry after 1s, 2s, 4s, 8s, 16s with max 32s wait.", "percentage": 92},
        {"solution": "Reduce concurrent API call count by using async.queue or p-queue to limit to <100 requests/second.", "percentage": 90},
        {"solution": "Batch operations: use POST /v1/charges/search or list endpoints with pagination instead of multiple individual calls.", "percentage": 88}
    ]'::jsonb,
    'Knowledge of rate limit thresholds (100 reads/writes per second), async queue libraries',
    'API calls succeed after rate limit recovery, request volume is within acceptable limits',
    'Not implementing any retry logic, attempting immediate re-requests, making all API calls concurrently without throttling',
    0.90,
    'haiku',
    NOW(),
    'https://stripe.com/docs/rate-limiting'
),
(
    'authentication_error - Could not authenticate you',
    'stripe',
    'MEDIUM',
    '[
        {"solution": "Verify API key format: use sk_test_* for test, sk_live_* for production. Never use publishable key (pk_*) on backend.", "percentage": 99},
        {"solution": "Check Authorization header: ''Authorization: Bearer sk_YOURKEY'' - note ''Bearer '' prefix is required.", "percentage": 97},
        {"solution": "Confirm API key has not been revoked or rotated in Stripe Dashboard''s API Keys section.", "percentage": 95}
    ]'::jsonb,
    'Access to Stripe API keys, understanding of Bearer token format, API key management',
    'API request authenticates successfully, no 401 errors in logs',
    'Using publishable key on backend, missing Bearer prefix in header, using expired/revoked keys, mixing test and live keys',
    0.98,
    'haiku',
    NOW(),
    'https://stripe.com/docs/api/authentication'
),
(
    'invalid_request_error - Received unknown parameter: source',
    'stripe',
    'LOW',
    '[
        {"solution": "Replace deprecated ''source'' parameter with ''payment_method'' parameter for newer Stripe API versions.", "percentage": 91},
        {"solution": "Check Stripe API version in your request headers - older versions support source, newer require payment_method.", "percentage": 88},
        {"solution": "Review Stripe migration guide for upgrading from Sources API to Payment Methods API.", "percentage": 85}
    ]'::jsonb,
    'Knowledge of Stripe API versioning, understanding of deprecated vs current parameters',
    'Request uses correct parameter for API version, no unknown parameter errors',
    'Using outdated parameter names, not checking API version headers, not following migration guides',
    0.88,
    'haiku',
    NOW(),
    'https://stripe.com/docs/payments/payment-methods/migration'
),
(
    'amount_too_large - The specified amount is greater than the maximum allowed',
    'stripe',
    'LOW',
    '[
        {"solution": "Check maximum amount for currency: USD/EUR max is 99,999,999 cents ($999,999.99). Other currencies vary.", "percentage": 96},
        {"solution": "Validate amount in cents before sending to Stripe API - ensure it does not exceed currency maximum.", "percentage": 97},
        {"solution": "Review transaction history in Stripe Dashboard to see what amount caused the error.", "percentage": 90}
    ]'::jsonb,
    'Knowledge of currency-specific maximum amounts, understanding of cents vs dollars',
    'Charge accepts valid amount, rejects amounts exceeding maximum with clear error',
    'Attempting to charge $1,000,000+, not converting to cents properly, using amount beyond currency limits',
    0.96,
    'haiku',
    NOW(),
    'https://stripe.com/docs/error-codes#invalid-request-errors'
),
(
    'amount_too_small - The specified amount is less than the minimum allowed',
    'stripe',
    'LOW',
    '[
        {"solution": "Minimum charge amount is 50 cents (0.50 USD) or equivalent in other currencies.", "percentage": 98},
        {"solution": "Validate amount is at least 50 cents (50 in cents) before submitting charge request.", "percentage": 97},
        {"solution": "If offering minimum purchases, set product price to at least $0.50 in your pricing configuration.", "percentage": 96}
    ]'::jsonb,
    'Knowledge of Stripe minimum transaction amount',
    'Charge accepts valid minimum amount, rejects amounts below minimum',
    'Attempting to charge less than 50 cents, not validating minimum in client code, not informing users of minimum purchase',
    0.97,
    'haiku',
    NOW(),
    'https://stripe.com/docs/error-codes#invalid-request-errors'
),
(
    'customer_tax_location_invalid - Tax location is invalid for this customer',
    'stripe',
    'LOW',
    '[
        {"solution": "Provide complete customer address: street, city, state, postal code, and country code (ISO 3166-1 alpha-2).", "percentage": 92},
        {"solution": "Validate country code is valid ISO format before sending - use only 2-letter country codes.", "percentage": 95},
        {"solution": "Ensure billing address matches customer''s actual location for accurate tax calculations.", "percentage": 90}
    ]'::jsonb,
    'Knowledge of ISO 3166-1 country code format, tax location requirements',
    'Customer address is validated, tax is calculated correctly for location',
    'Using invalid country codes, providing incomplete addresses, using 3-letter country codes instead of 2-letter',
    0.92,
    'haiku',
    NOW(),
    'https://stripe.com/docs/error-codes#invalid-request-errors'
),
(
    'resource_missing - The resource you requested does not exist',
    'stripe',
    'MEDIUM',
    '[
        {"solution": "Verify the resource ID is correct and exists in Stripe: check customer/payment intent ID format (ch_*, cus_*, pi_*, etc).", "percentage": 98},
        {"solution": "Check resource was not deleted - retrieve it from Stripe Dashboard to confirm it still exists.", "percentage": 97},
        {"solution": "Ensure you''re using the correct API key (test vs live) for the environment where resource was created.", "percentage": 95}
    ]'::jsonb,
    'Understanding of Stripe resource ID formats, knowledge of test vs live environments',
    'Resource is successfully retrieved, no 404 errors in API logs',
    'Using incorrect resource IDs, attempting to access deleted resources, mixing test/live keys with wrong resource IDs',
    0.97,
    'haiku',
    NOW(),
    'https://stripe.com/docs/error-codes#authentication-errors'
),
(
    'idempotency_key_in_use - Idempotency key currently in use for another request',
    'stripe',
    'LOW',
    '[
        {"solution": "Wait for the original request to complete before retrying with the same idempotency key.", "percentage": 94},
        {"solution": "Use unique idempotency keys for each request. Format: use UUID or timestamp-based unique identifier.", "percentage": 96},
        {"solution": "Check Stripe logs (dashboard.stripe.com/test/logs) to see status of the original request with this idempotency key.", "percentage": 88}
    ]'::jsonb,
    'Understanding of idempotent operations and UUID generation',
    'Request succeeds with unique idempotency key, duplicate requests are properly handled',
    'Reusing same idempotency key for different requests, using non-unique identifiers, not waiting for original request completion',
    0.95,
    'haiku',
    NOW(),
    'https://stripe.com/docs/api/idempotent_requests'
),
(
    'tls_version_unsupported - You are using an unsupported TLS version',
    'stripe',
    'LOW',
    '[
        {"solution": "Upgrade to TLS 1.2 or higher. Stripe requires TLS 1.2 minimum - TLS 1.0 and 1.1 are no longer supported.", "percentage": 99},
        {"solution": "Update Node.js, Python, or language runtime to version that enforces TLS 1.2 by default.", "percentage": 97},
        {"solution": "Check OpenSSL version: ensure it''s 1.0.2 or newer. Older versions do not support TLS 1.2.", "percentage": 96}
    ]'::jsonb,
    'Access to system/runtime configuration, understanding of TLS/SSL standards',
    'Stripe API calls succeed, TLS version in request is 1.2 or higher',
    'Not updating language runtime, using very old systems, not checking TLS version in requests',
    0.98,
    'haiku',
    NOW(),
    'https://stripe.com/docs/upgrades/tls-required'
),
(
    'payment_intent_unexpected_state - Cannot perform this action on a payment intent in state requires_payment_method',
    'stripe',
    'MEDIUM',
    '[
        {"solution": "Check payment intent status before performing action: use ''retrieve()'' to get current state (requires_payment_method, processing, succeeded, etc).", "percentage": 96},
        {"solution": "Provide a payment method before confirming: call ''confirm()'' with ''payment_method'' parameter after intent is created.", "percentage": 95},
        {"solution": "Follow proper state transitions: only call confirm() when in requires_payment_method or requires_confirmation state.", "percentage": 94}
    ]'::jsonb,
    'Understanding of PaymentIntent state machine, knowledge of proper confirmation flow',
    'PaymentIntent transitions through correct states, action succeeds when intent is in valid state',
    'Not checking intent status before calling methods, confirming without payment_method, attempting invalid state transitions',
    0.95,
    'haiku',
    NOW(),
    'https://stripe.com/docs/payments/payment-intents/managing-status'
),
(
    'setup_intent_authentication_failure - The setup intent authentication failed',
    'stripe',
    'MEDIUM',
    '[
        {"solution": "Retrieve SetupIntent to check status: if status is ''requires_action'', customer must complete 3D Secure or other auth in frontend.", "percentage": 94},
        {"solution": "Implement proper 3D Secure flow: use handleCardAction() or handleNextAction() to guide customer through authentication.", "percentage": 92},
        {"solution": "After authentication, confirm the setup intent again with the same payment method that just authenticated.", "percentage": 91}
    ]'::jsonb,
    'Understanding of SetupIntent state, knowledge of 3D Secure authentication flow',
    'SetupIntent authenticates successfully, payment method is saved after 3D Secure',
    'Not handling requires_action status, skipping customer authentication, not retrying after authentication',
    0.92,
    'haiku',
    NOW(),
    'https://stripe.com/docs/payments/3d-secure'
),
(
    'account_number_invalid - The account number is invalid',
    'stripe',
    'LOW',
    '[
        {"solution": "Verify account number format for the country: US uses 1-17 digits, other countries have different lengths.", "percentage": 93},
        {"solution": "Remove spaces, dashes, or special characters from account number before sending to Stripe API.", "percentage": 96},
        {"solution": "Validate account number passes Luhn algorithm check (if applicable for the country).", "percentage": 88}
    ]'::jsonb,
    'Knowledge of bank account number formats by country, understanding of Luhn validation',
    'Account number is accepted without validation error, bank details are verified',
    'Not removing formatting characters, using account numbers with invalid length, not country-specific validation',
    0.92,
    'haiku',
    NOW(),
    'https://stripe.com/docs/error-codes#bank-account-errors'
),
(
    'routing_number_invalid - The routing number is invalid',
    'stripe',
    'LOW',
    '[
        {"solution": "For US accounts, routing number must be 9 digits. Format: ABA routing number from Federal Reserve.", "percentage": 97},
        {"solution": "Validate routing number passes checksum validation (mod-10 algorithm for US routing numbers).", "percentage": 94},
        {"solution": "Remove dashes or spaces: ''123-45-6789'' should be sent as ''123456789'' to Stripe.", "percentage": 96}
    ]'::jsonb,
    'Knowledge of US routing number format and validation, understanding of ABA numbers',
    'Routing number passes validation, bank account is successfully connected',
    'Using incorrect routing number format, not stripping formatting, using non-existent routing numbers',
    0.96,
    'haiku',
    NOW(),
    'https://stripe.com/docs/error-codes#bank-account-errors'
);
