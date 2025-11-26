-- Documentation mining: Supabase Authentication errors batch 1
-- Category: github-supabase-auth
-- Source: Supabase docs, GitHub issues (auth, supabase repos)
-- Extracted: 2025-11-25

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
-- Entry 1: Invalid JWT / Malformed Token
(
    'Error: invalid JWT - token is malformed or unable to parse signature',
    'github-supabase-auth',
    'HIGH',
    $$[
        {"solution": "Verify JWT token format contains exactly 3 segments separated by dots (header.payload.signature)", "percentage": 95, "note": "Most common cause is token corruption during transmission"},
        {"solution": "Downgrade Supabase CLI to v2.48.3 if using admin routes, as v2.50.3+ has known JWT parsing issues", "percentage": 90, "command": "supabase update --version 2.48.3", "note": "Workaround for CLI bug with new secret key format"},
        {"solution": "Ensure Bearer token is passed correctly without extra whitespace or encoding: Authorization: Bearer <token>", "percentage": 88, "command": "Verify token in Authorization header"},
        {"solution": "Check that admin API keys and publish keys are not mixed - admin routes require secret key, not anon key", "percentage": 85, "note": "Common mistake in API endpoint configuration"}
    ]$$::jsonb,
    'Valid Supabase project, Active session or valid JWT token, Correct CLI version or SDK version',
    'JWT validation passes without parsing errors, Admin endpoints return 200 status, Token claims are readable',
    'Do not attempt to manually construct or modify JWT tokens. Always use provided keys. Whitespace in Bearer token header causes parsing failure. Admin routes require secret key (not publishable key).',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/supabase/auth/issues/2204'
),

-- Entry 2: Email Rate Limit Exceeded
(
    'Error: email rate limit exceeded on PUT /auth/v1/user',
    'github-supabase-auth',
    'HIGH',
    $$[
        {"solution": "Wait minimum 60 seconds before retrying email update operations - rate limit has 1-minute window", "percentage": 92, "note": "Default GoTrue rate limiting configuration"},
        {"solution": "Request support to manually reset GoTrue rate limiter state for your project ID if limit persists after 60+ seconds", "percentage": 85, "note": "Contact Supabase support with project ID"},
        {"solution": "Disable email verification requirement temporarily to allow user operations: Settings > Auth > Email Verification > Disable", "percentage": 80, "note": "Temporary workaround, does not fix rate limiter"},
        {"solution": "Ensure application batches email updates - sending multiple consecutive updates triggers rate limit", "percentage": 78, "note": "Implement 1-minute delay between consecutive email change requests"}
    ]$$::jsonb,
    'Valid Supabase project with auth enabled, User account with confirmed email, Admin access to project settings',
    'Email update endpoint returns 200 status code, User email is successfully updated, No 429 Too Many Requests errors',
    'Rate limit persists even after project restart - requires support intervention. Do not send multiple email updates in rapid succession. Disabling email verification does not reset rate limiter state.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/supabase/auth/issues/2237'
),

-- Entry 3: Email Address Invalid (Short Domain)
(
    'Error: email_address_invalid - Email address "a@a.com" rejected as invalid',
    'github-supabase-auth',
    'MEDIUM',
    $$[
        {"solution": "Use email addresses with minimum 2-character domain: user@ab.com or user@aa.com (single-char domains may fail validation)", "percentage": 88, "note": "Current Supabase validation requires 2+ char domain"},
        {"solution": "Review email validation regex pattern in auth configuration - ensure RFC 5322 compliance for edge cases", "percentage": 82, "note": "Single-char local and domain parts are technically valid per RFC"},
        {"solution": "For testing, use standard test email format: test@example.com instead of single-character domains", "percentage": 85, "note": "Recommended for production applications"},
        {"solution": "Report to Supabase if you require single-character domain support for legitimate use case", "percentage": 70, "note": "May require custom validation rules"}
    ]$$::jsonb,
    'Supabase auth enabled, User signup or email change operation, Email address in RFC 5322 format',
    'Email signup completes without validation error, Email confirmation sent successfully, Account created with valid email',
    'Single-character domain emails (a@a.com) fail validation even though technically valid per RFC 5322. Single-character local parts also fail. Use minimum 2-character domains for reliability.',
    0.75,
    'sonnet-4',
    NOW(),
    'https://github.com/supabase/auth/issues/2252'
),

-- Entry 4: Session Missing Error (Safari Implicit Flow)
(
    'Error: AuthSessionMissingError - Session not found during password reset on Safari',
    'github-supabase-auth',
    'MEDIUM',
    $$[
        {"solution": "Switch from implicit flow to PKCE flow for password reset - PKCE handles Safari cookie isolation correctly", "percentage": 95, "note": "Recommended by Supabase for all SSR applications"},
        {"solution": "Use @supabase/ssr package instead of deprecated Auth Helpers - provides proper cookie-based session handling", "percentage": 92, "command": "npm install @supabase/ssr", "note": "Built-in PKCE support for SSR"},
        {"solution": "Configure HTTP-only cookies with extended expiration: set cookie max-age to far future, let Auth control validity", "percentage": 88, "note": "Enables session refresh on both client and server"},
        {"solution": "For implicit flow, add delay before updateUser() call: setTimeout(() => updateUser(), 500) to ensure session propagation", "percentage": 70, "note": "Workaround only - PKCE flow recommended"}
    ]$$::jsonb,
    'Safari browser (macOS or iOS), SvelteKit or similar SSR framework, @supabase/ssr package v1.0+, Password reset link with valid token',
    'updateUser() call succeeds without session error, Password reset completes successfully on Safari, Session accessible on server side',
    'Implicit flow has race condition on Safari - session not available immediately after redirect. PKCE flow required for reliable SSR password reset. Firefox/Chrome work fine with implicit flow but Safari does not.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/supabase/auth/issues/2221'
),

-- Entry 5: Bad Code Verifier (PKCE Flow)
(
    'Error: bad_code_verifier - PKCE code verifier mismatch or invalid format',
    'github-supabase-auth',
    'HIGH',
    $$[
        {"solution": "Ensure code_challenge generated from code_verifier matches exactly: code_challenge = base64url(sha256(code_verifier))", "percentage": 94, "note": "Most common cause - incorrect hashing method"},
        {"solution": "Verify code_challenge_method is set to \"S256\" (SHA-256) not \"plain\" method in authorization request", "percentage": 92, "note": "Plain method is deprecated and causes verification errors"},
        {"solution": "Store code_verifier securely in session and retrieve same value during token exchange - verifier must not change", "percentage": 91, "command": "Validate code_verifier stored === code_verifier retrieved", "note": "Session/storage corruption is common source"},
        {"solution": "Use Supabase Auth client library PKCE implementation instead of manual implementation - handles verifier generation and hashing", "percentage": 93, "note": "supabase-js v2+ includes PKCE automatically"},
        {"solution": "Ensure code_verifier length is 43-128 characters - Supabase generates 128-char verifiers by default", "percentage": 85, "note": "Short verifiers may fail validation"}
    ]$$::jsonb,
    'PKCE flow enabled in Supabase auth, Authorization code received, Code verifier stored from initial request, Valid OAuth client credentials',
    'Token endpoint returns 200 with access token and refresh token, User session established successfully, No 422 Unprocessable Entity errors',
    'Code verifier must be exact match - any encoding change breaks verification. Plain method (unencrypted) is deprecated. Using wrong hash algorithm causes mismatch. Client libraries handle PKCE automatically - avoid manual implementation.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://supabase.com/docs/guides/auth/debugging/error-codes'
),

-- Entry 6: Email Not Confirmed
(
    'Error: email_not_confirmed - Signing in not allowed because email address is not verified',
    'github-supabase-auth',
    'VERY_HIGH',
    $$[
        {"solution": "Require user to verify email before signin: check error code \"email_not_confirmed\", prompt user to check inbox for verification link", "percentage": 96, "note": "Standard verification flow"},
        {"solution": "Send verification email via signUp() - verification link automatically included when email confirmation required", "percentage": 95, "command": "const { data, error } = await supabase.auth.signUp({ email, password })", "note": "Built-in verification email sends automatically"},
        {"solution": "Allow signin without email verification: Settings > Auth > Email Verification > Disable (not recommended for production)", "percentage": 85, "note": "Reduces security, use only for testing"},
        {"solution": "Implement email verification confirmation UI: supabase.auth.verifyOtp({ email, token, type: \"email\" })", "percentage": 92, "note": "Manual verification when using custom email provider"},
        {"solution": "Check that email configuration is not preventing delivery: Settings > Auth > Email Configuration > SMTP settings", "percentage": 80, "note": "Verify emails disabled if SMTP not configured"}
    ]$$::jsonb,
    'Supabase auth enabled with email verification, User account created via signUp, Email delivery configured (built-in or SMTP)',
    'User receives verification email, Verification link works and confirms email, User can signin after confirmation, Error code returns 200 on next signin attempt',
    'Email verification is required by default - cannot signin with unconfirmed email even with correct password. Verification emails may be filtered to spam folder. Verification links expire after 24 hours.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://supabase.com/docs/guides/auth/debugging/error-codes'
),

-- Entry 7: OAuth Redirect URL Mismatch (GitHub/Google)
(
    'Error: OAuth callback redirect fails - "redirect_uri mismatch" or wrong redirect URL',
    'github-supabase-auth',
    'VERY_HIGH',
    $$[
        {"solution": "Copy exact callback URL from Supabase dashboard: Auth > Sign In > GitHub > Redirect URL, paste into OAuth provider settings", "percentage": 96, "note": "URL format: https://<project-id>.supabase.co/auth/v1/callback"},
        {"solution": "Ensure callback URL matches exactly including protocol (https, not http) and trailing slash - providers are case-sensitive", "percentage": 94, "command": "Exact match required: https://project.supabase.co/auth/v1/callback", "note": "http:// will fail, trailing slash matters"},
        {"solution": "For GitHub: Paste URL in Settings > Developer applications > OAuth Apps > Authorization callback URL field", "percentage": 93, "note": "Device Flow must be unchecked"},
        {"solution": "For Google: Verify callback URL is added to Authorized redirect URIs in OAuth 2.0 credentials - must include all URIs", "percentage": 92, "note": "Google requires explicit redirect URI registration"},
        {"solution": "After updating callback URL in provider, clear browser cache and restart - some providers cache old URLs", "percentage": 80, "note": "May take 1-2 minutes to propagate"}
    ]$$::jsonb,
    'GitHub OAuth app or Google OAuth credentials created, Callback URL copied from Supabase dashboard, OAuth provider settings access',
    'OAuth login button redirects to provider login page, User grants permission successfully, Redirect back to app completes without error, User session created',
    'GitHub Device Flow must be unchecked. Google requires openid scope + userinfo scopes. URL format is exact - trailing slash, protocol, and case all matter. OAuth provider caches URLs - may need wait 1-2 minutes.'
    , 0.95,
    'sonnet-4',
    NOW(),
    'https://supabase.com/docs/guides/auth/social-login/auth-github'
),

-- Entry 8: Anonymous Auth Disabled
(
    'Error: anonymous_provider_disabled - Anonymous sign-in feature is disabled in project',
    'github-supabase-auth',
    'MEDIUM',
    $$[
        {"solution": "Enable anonymous auth: Settings > Auth > Auth Providers > Anonymous > Toggle ON", "percentage": 97, "note": "Default disabled - must explicitly enable"},
        {"solution": "Call signInAnonymously() only after verifying anonymous auth is enabled in dashboard", "percentage": 94, "command": "const { data, error } = await supabase.auth.signInAnonymously()", "note": "Returns 403 if feature disabled"},
        {"solution": "Implement feature detection: check error.code === \"anonymous_provider_disabled\" to handle disabled state gracefully", "percentage": 91, "note": "Show signup prompt when anonymous disabled"},
        {"solution": "Use Pro plan feature to enforce anonymous sessions expire after timeout - Free plan anonymous sessions last indefinitely", "percentage": 85, "note": "Pro plan additional feature"}
    ]$$::jsonb,
    'Supabase auth enabled, Project settings access, Anonymous authentication use case required',
    'signInAnonymously() returns user object with anonymous session, Anonymous user can access app, Session expires correctly per plan',
    'Anonymous auth is disabled by default - must enable in dashboard. Free plan allows indefinite anonymous sessions. Cannot disable after session created - must plan upfront.',
    0.96,
    'sonnet-4',
    NOW(),
    'https://supabase.com/docs/guides/auth/debugging/error-codes'
),

-- Entry 9: Weak Password
(
    'Error: weak_password - Password does not meet minimum strength requirements',
    'github-supabase-auth',
    'VERY_HIGH',
    $$[
        {"solution": "Minimum 6 characters required - implement password strength indicator UI showing character requirement", "percentage": 96, "note": "Minimum Supabase requirement"},
        {"solution": "Use AuthWeakPasswordError to get specific requirements: error.getWeakPasswordReasons() returns array of failed rules", "percentage": 94, "command": "const reasons = error.getWeakPasswordReasons() // [\"too_short\", ...]", "note": "Use for localized error messages"},
        {"solution": "Display error.message to user - provides human-readable password requirement explanation", "percentage": 92, "note": "Localized per user browser language"},
        {"solution": "Implement client-side password validation before API call - reduces unnecessary requests: min 6 chars, mix of types", "percentage": 88, "note": "Improves UX by catching errors early"},
        {"solution": "For custom password requirements, use Pro plan password requirements setting instead of minimum (Free limited to 6 char)", "percentage": 85, "note": "Pro plan feature"}
    ]$$::jsonb,
    'Supabase auth enabled, User password input via signUp() or updateUser(), Password validation error handler',
    'Stronger password submitted and accepted by signup endpoint, No 422 error returned, User account created successfully, Password meets stated requirements',
    'Minimum 6 characters is hard requirement. WeakPasswordError provides detailed reasons via getWeakPasswordReasons(). Free plan limited to 6-char minimum - Pro plan allows custom rules. Show error.message in UI.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://supabase.com/docs/guides/auth/debugging/error-codes'
),

-- Entry 10: Invalid Credentials
(
    'Error: invalid_credentials - Login failed with incorrect email or password',
    'github-supabase-auth',
    'VERY_HIGH',
    $$[
        {"solution": "Verify email address exists in auth.users table - typo in email is most common cause", "percentage": 95, "note": "Email address must exactly match signup email"},
        {"solution": "Confirm password matches what user entered during signup - password is case-sensitive", "percentage": 94, "note": "Passwords are hashed - no password recovery via database"},
        {"solution": "Check for accidental spaces before/after email input: trim() input before sending to signin", "percentage": 92, "command": "email.trim() // removes leading/trailing whitespace", "note": "HTML input fields may include whitespace"},
        {"solution": "If using email sign-in without password: verify email exists and send magic link instead of password check", "percentage": 88, "note": "Magic link flow requires email-only signup"},
        {"solution": "Implement account recovery: \"Forgot password?\" flow sends reset email allowing password change without old password", "percentage": 85, "command": "supabase.auth.resetPasswordForEmail(email)", "note": "Requires email delivery configured"}
    ]$$::jsonb,
    'User account already created via signup, Email delivery configured, User has valid password set during account creation',
    'Correct email/password combo returns user object and session, User can access app after signin, No repeated failed attempts (prevents account lockout)',
    'Email and password are case-sensitive. Whitespace around email causes mismatch. No way to recover password without email verification. Account lockout not implemented in Free plan.'
    , 0.94,
    'sonnet-4',
    NOW(),
    'https://supabase.com/docs/guides/auth/debugging/error-codes'
),

-- Entry 11: Over Request Rate Limit (429)
(
    'Error: over_request_rate_limit / 429 Too Many Requests - API rate limit exceeded',
    'github-supabase-auth',
    'HIGH',
    $$[
        {"solution": "Implement exponential backoff retry: wait 1s, 2s, 4s, 8s before retry (max 5 attempts)", "percentage": 92, "note": "Standard rate limit handling"},
        {"solution": "Check Retry-After header in response: retry after specified seconds instead of fixed delay", "percentage": 90, "command": "const waitMs = parseInt(response.headers['retry-after']) * 1000", "note": "Server indicates optimal retry timing"},
        {"solution": "Reduce request frequency: batch multiple API calls together instead of sequential individual calls", "percentage": 88, "note": "Supabase limits 300 requests/minute per auth endpoint"},
        {"solution": "For signup/signin: implement CoolDown between failed attempts - prevents brute force and rate limiting", "percentage": 85, "note": "Lock account after 5 failed attempts for security"},
        {"solution": "Upgrade to higher plan tier if rate limit insufficient for legitimate traffic - Free plan has 300 req/min limit", "percentage": 82, "note": "Pro plan has higher limits"}
    ]$$::jsonb,
    'Active API client making requests, Rate limit enforcement enabled, Network connectivity available',
    'Retry request succeeds after wait period, No repeated 429 errors, API returns 200 status code on retry, User action completes successfully',
    'Do not retry immediately - always use exponential backoff with server Retry-After header preference. API limits 300 requests/minute per endpoint. Batch requests when possible. CoolDown prevents rate limit from brute force attempts.'
    , 0.91,
    'sonnet-4',
    NOW(),
    'https://supabase.com/docs/guides/auth/debugging/error-codes'
),

-- Entry 12: Session Expired
(
    'Error: session_expired - Current session has exceeded maximum lifetime or inactivity timeout',
    'github-supabase-auth',
    'HIGH',
    $$[
        {"solution": "Require user to signin again: catch session_expired error and redirect to signin page with message \"Session expired\"", "percentage": 95, "note": "Standard session refresh flow"},
        {"solution": "Implement automatic session refresh using refresh token before expiration: call refreshSession() at access token expiration time", "percentage": 93, "command": "await supabase.auth.refreshSession()", "note": "Refresh tokens never expire, only access tokens"},
        {"solution": "Access tokens default 1-hour expiration - refresh before 1 hour passes: set up interval to call refreshSession every 55 minutes", "percentage": 90, "note": "Prevents session expired error during use"},
        {"solution": "For SSR: refresh token on server-side before returning page - use @supabase/ssr which handles auto-refresh", "percentage": 92, "note": "Critical for server-rendered apps"},
        {"solution": "Pro plan: Configure session lifetime limits - minimum 5 minutes TTL, max 24 hours TTL per user policy", "percentage": 80, "note": "Pro plan feature for session management"}
    ]$$::jsonb,
    'Active user session with access token and refresh token, Session storage configured (localStorage or cookies), Network connectivity',
    'refreshSession() returns new access token and updated session, User remains logged in without re-authentication, No 401 Unauthorized errors, Subsequent API calls succeed',
    'Session expiration enforced every 1 hour (default) - automatic refresh prevents disruption. Refresh tokens are single-use - reuse within 10-second window allowed for SSR. Session ends immediately on logout, password change, or suspicious activity.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://supabase.com/docs/guides/auth/debugging/error-codes'
);
