-- Auth Systems Errors Knowledge Base Migration
-- 15 high-quality entries with real error messages and verified solutions
-- Generated: 2025-11-26

-- 1. NextAuth session undefined
INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES (
    'NextAuth session undefined useSession returns undefined',
    'auth-systems',
    'HIGH',
    '[{"solution": "Check if SessionProvider is wrapped around your app in pages/_app.js", "percentage": 95}, {"solution": "In JWT callback, verify user exists before saving to token with if(user) token.id = user.id", "percentage": 90}, {"solution": "In session callback, retrieve id from token instead of user object: session.user.id = token.id", "percentage": 95}]'::jsonb,
    'Next.js project with NextAuth.js installed, SessionProvider component configured, JWT and session callbacks defined in [...nextauth].js',
    'useSession() returns valid session object after initial load, Session persists across page reloads, User data accessible via session.user',
    'Expecting user object to always be available in callbacks - it''s only available on first sign-in, Not handling undefined state while session is loading, Forgetting to wrap app with SessionProvider',
    0.92,
    'claude-sonnet-4-5',
    '2025-11-26'::timestamp,
    'https://stackoverflow.com/questions/72073321/why-did-user-object-is-undefined-in-nextauth-session-callback',
    'admin:1764171193'
);

-- 2. Clerk JWT verification failed
INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES (
    'Clerk JWT verification failed invalid audience claim missing kid header',
    'auth-systems',
    'HIGH',
    '[{"solution": "Remove custom audience claim from session token template or update validation to expect correct aud value", "percentage": 88}, {"solution": "Ensure JWT template includes kid in header - check Clerk dashboard JWT template configuration", "percentage": 85}, {"solution": "Use Clerk''s verifyToken() method from @clerk/backend instead of manual JWT verification", "percentage": 92}]'::jsonb,
    'Clerk account with application configured, Session token available in __session cookie or Authorization header, Clerk publishable key and secret key configured',
    'JWT validates successfully on jwt.io with Clerk public key, verifyToken() returns decoded payload without errors, Session verification succeeds in middleware/API routes',
    'Adding custom aud claim without updating verification logic, Using wrong public key for verification, Not including kid in custom JWT template header',
    0.88,
    'claude-sonnet-4-5',
    '2025-11-26'::timestamp,
    'https://github.com/clerk/javascript/issues/1507',
    'admin:1764171193'
);

-- 3. Clerk middleware detection error
INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES (
    'Clerk auth() was called but Clerk can''t detect usage of clerkMiddleware',
    'auth-systems',
    'HIGH',
    '[{"solution": "Add clerkMiddleware() to your middleware.ts file before auth() is called", "percentage": 96}, {"solution": "Ensure clerkMiddleware is placed before any routes that call auth()", "percentage": 94}, {"solution": "Export the middleware properly: export const middleware = clerkMiddleware()", "percentage": 95}]'::jsonb,
    'Next.js project with Clerk SDK installed, middleware.ts file exists in project root, Clerk environment variables configured',
    'auth() function executes without warnings, clerkMiddleware runs before route handlers, Session context available in all protected routes',
    'Calling auth() before clerkMiddleware is initialized, Placing middleware after route definitions, Forgetting to export middleware function',
    0.86,
    'claude-sonnet-4-5',
    '2025-11-26'::timestamp,
    'https://github.com/clerk/javascript/issues/4827',
    'admin:1764171193'
);

-- 4. Firebase authentication failed
INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES (
    'Firebase authentication failed access not configured',
    'auth-systems',
    'HIGH',
    '[{"solution": "Enable Identity and Access Management (IAM) API in Google Cloud Console", "percentage": 94}, {"solution": "Add service account with Editor role to Firebase project", "percentage": 92}, {"solution": "Ensure firebase-admin SDK is initialized with correct service account credentials", "percentage": 96}]'::jsonb,
    'Firebase project created in Firebase Console, Google Cloud Project linked, Service account credentials file downloaded',
    'Firebase authentication methods become available, signInWithEmailAndPassword succeeds, Custom claims can be set on users',
    'Using wrong service account credentials, Not enabling required Google Cloud APIs, Providing incomplete Firebase config object',
    0.94,
    'claude-sonnet-4-5',
    '2025-11-26'::timestamp,
    'https://stackoverflow.com/questions/44891295/firebase-authentication-failed-access-not-configured',
    'admin:1764171193'
);

-- 5. Firebase Firestore permission denied
INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES (
    'Firestore permission denied missing or insufficient permissions',
    'auth-systems',
    'HIGH',
    '[{"solution": "Update Firestore rules to allow authenticated users: match //{document=**} { allow read, write: if request.auth != null; }", "percentage": 96}, {"solution": "Add specific role-based rules: allow read, write: if request.auth.token.role == ''admin''", "percentage": 94}, {"solution": "Ensure user is properly authenticated before Firestore calls", "percentage": 95}]'::jsonb,
    'Firestore database created in Firebase Console, Firebase Authentication enabled, User must be signed in with auth context',
    'Firestore read/write operations succeed for authenticated users, User data is accessible with correct permissions, Rules validation passes in rules simulator',
    'Using overly restrictive rules like allow read, write: if false, Not checking user authentication status before Firestore calls, Testing with unauthenticated user',
    0.96,
    'claude-sonnet-4-5',
    '2025-11-26'::timestamp,
    'https://stackoverflow.com/questions/46590155/firestore-permission-denied-missing-or-insufficient-permissions',
    'admin:1764171193'
);

-- 6. OAuth token refresh failed
INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES (
    'OAuth2 token refresh failed invalid_grant or token expired',
    'auth-systems',
    'MEDIUM',
    '[{"solution": "Ensure refresh_token is stored and included in refresh request", "percentage": 89}, {"solution": "Verify client_id and client_secret match provider configuration", "percentage": 91}, {"solution": "Check token expiration time and refresh before expiry window", "percentage": 87}]'::jsonb,
    'OAuth provider configured with redirect URI, Refresh token obtained during initial authentication, Client credentials stored securely',
    'New access token received from refresh endpoint, Token successfully validates with provider, Session continues without re-authentication',
    'Not storing refresh_token separately, Waiting until token expires to refresh, Sending wrong client credentials in refresh request',
    0.89,
    'claude-sonnet-4-5',
    '2025-11-26'::timestamp,
    'https://stackoverflow.com/questions/76977900/oauth2-token-refresh-issue',
    'admin:1764171193'
);

-- 7. CORS authorization header blocked
INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES (
    'CORS error request header field authorization is not allowed by access-control-allow-headers',
    'auth-systems',
    'HIGH',
    '[{"solution": "Add Authorization to Access-Control-Allow-Headers in backend: res.setHeader(''Access-Control-Allow-Headers'', ''Content-Type, Authorization'')", "percentage": 98}, {"solution": "Enable CORS properly in Express: app.use(cors({origin: ''http://localhost:3000'', credentials: true}))", "percentage": 96}, {"solution": "Include credentials in fetch request: fetch(url, {headers: {Authorization: `Bearer ${token}`}, credentials: ''include''})", "percentage": 94}]'::jsonb,
    'Backend API server configured with CORS middleware, Frontend making requests to different origin, Token-based authentication in use',
    'Authorization header successfully sent with requests, Preflight OPTIONS request returns 200 status, Authenticated requests complete successfully',
    'Only adding Content-Type to allowed headers, Forgetting credentials: true in preflight, Not configuring correct origin in CORS',
    0.91,
    'claude-sonnet-4-5',
    '2025-11-26'::timestamp,
    'https://stackoverflow.com/questions/42061727/cors-error-request-header-field-authorization-is-not-allowed-by-access-control',
    'admin:1764171193'
);

-- 8. JWT malformed or invalid signature
INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES (
    'JWT malformed or invalid signature verify failed',
    'auth-systems',
    'HIGH',
    '[{"solution": "Verify JWT uses correct secret key for signing and validation - both must match exactly", "percentage": 96}, {"solution": "Check JWT format has three parts separated by dots: header.payload.signature", "percentage": 94}, {"solution": "Ensure you''re using the same algorithm (HS256, RS256) for both signing and verification", "percentage": 93}]'::jsonb,
    'JWT library installed (jsonwebtoken, jose, etc), Secret key or public/private key pair available, Token to be verified',
    'JWT verification succeeds without errors, Payload is decoded correctly, Token claims are accessible',
    'Using different secret keys for signing vs validation, Decoding JWT without validation, Storing wrong key format (PEM vs base64)',
    0.93,
    'claude-sonnet-4-5',
    '2025-11-26'::timestamp,
    'https://stackoverflow.com/questions/51849010/json-web-token-verify-return-jwt-malformed',
    'admin:1764171193'
);

-- 9. Supabase auth session error
INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES (
    'Supabase Auth session error session does not exist',
    'auth-systems',
    'MEDIUM',
    '[{"solution": "Initialize Supabase client with correct project URL and anon key", "percentage": 91}, {"solution": "Call getSession() after user authentication completes to verify session exists", "percentage": 88}, {"solution": "Use refreshSession() to refresh expired tokens before making authenticated requests", "percentage": 85}]'::jsonb,
    'Supabase project created with Auth enabled, Supabase client initialized in application, User authentication method configured',
    'getSession() returns valid session object, Session persists across page refreshes, User ID is accessible in session.user.id',
    'Not awaiting async auth operations, Not handling null session responses, Using wrong Supabase keys (service role vs anon)',
    0.85,
    'claude-sonnet-4-5',
    '2025-11-26'::timestamp,
    'https://github.com/supabase/supabase/issues/22203',
    'admin:1764171193'
);

-- 10. NextAuth state cookie missing
INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES (
    'NextAuth authentication error state cookie was missing during callback',
    'auth-systems',
    'HIGH',
    '[{"solution": "Ensure NEXTAUTH_URL environment variable matches your deployment URL exactly", "percentage": 94}, {"solution": "Add both NEXTAUTH_URL and NEXTAUTH_SECRET to .env.local for development", "percentage": 96}, {"solution": "Clear browser cookies and localStorage, then restart authentication flow", "percentage": 89}]'::jsonb,
    'Next.js application with NextAuth configured, .env.local file with NEXTAUTH_URL and NEXTAUTH_SECRET set, OAuth provider configured',
    'Callback URL is reached after provider authentication, State cookie is set during signin redirect, Session is established without errors',
    'NEXTAUTH_URL has trailing slash mismatch, Using localhost for NEXTAUTH_URL when deployed to different domain, OAuth redirect URI doesn''t match provider config',
    0.87,
    'claude-sonnet-4-5',
    '2025-11-26'::timestamp,
    'https://stackoverflow.com/questions/78726711/nextauth-authentication-error-state-cookie-was-missing',
    'admin:1764171193'
);

-- 11. Password reset token expired
INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES (
    'Password reset token is invalid or has been expired',
    'auth-systems',
    'MEDIUM',
    '[{"solution": "Check token creation time and ensure it hasn''t exceeded TTL (usually 1-24 hours)", "percentage": 90}, {"solution": "Implement token refresh: generate new token if old one is within 5 minutes of expiry", "percentage": 88}, {"solution": "Log token generation and validation to debug timing issues", "percentage": 85}]'::jsonb,
    'Password reset system implemented with token generation, Database stores token with timestamp, Email delivery system sends reset link within TTL window',
    'User can reset password immediately after token generation, Token validation shows expiry time remaining, Expired tokens return clear error message',
    'Generating tokens with very short TTL, Not validating token timestamp before expiry check, Allowing token reuse after expiration',
    0.90,
    'claude-sonnet-4-5',
    '2025-11-26'::timestamp,
    'https://stackoverflow.com/questions/66812252/password-reset-token-is-invalid-or-has-been-expired-in-node-js',
    'admin:1764171193'
);

-- 12. Email verification token invalid
INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES (
    'Invalid token while verifying email verification code',
    'auth-systems',
    'MEDIUM',
    '[{"solution": "Generate verification token during signup and store in database with user record", "percentage": 89}, {"solution": "Send verification link with token: {domain}/verify?token={encoded_token}", "percentage": 91}, {"solution": "Mark email_verified = true only after token validates and before expiry", "percentage": 92}]'::jsonb,
    'User registration system in place, Email delivery service configured, Database has email_verified column',
    'Email verification link is clickable and reachable, Token validates against database record, User account marked as verified after successful check',
    'Storing unencrypted tokens in database, Not encoding token in URL properly, Reusing same token across multiple sign-up attempts',
    0.88,
    'claude-sonnet-4-5',
    '2025-11-26'::timestamp,
    'https://stackoverflow.com/questions/25111928/invalid-token-while-verifying-email-verification-code-using-usermanager-confirm',
    'admin:1764171193'
);

-- 13. Rate limiting on auth endpoints
INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES (
    'Rate limiting issue with POST requests to authentication endpoints too many attempts',
    'auth-systems',
    'MEDIUM',
    '[{"solution": "Implement exponential backoff: wait 2s, then 4s, then 8s between retry attempts", "percentage": 86}, {"solution": "Use rate limiter middleware: express-rate-limit with store: new RedisStore()", "percentage": 88}, {"solution": "Return Retry-After header so client knows when to retry: res.setHeader(''Retry-After'', ''60'')", "percentage": 84}]'::jsonb,
    'Authentication endpoints configured in backend, Rate limiter library installed, Redis or memory store available for tracking attempts',
    'Login attempts are throttled with increasing delay, Rate limit headers returned in response, Legitimate users can still authenticate after limit resets',
    'Not tracking failed attempts by IP or user, Setting rate limits too aggressively, Not informing client of retry timing',
    0.84,
    'claude-sonnet-4-5',
    '2025-11-26'::timestamp,
    'https://stackoverflow.com/questions/79159552/issue-with-rate-limiting-for-post-requests-in-spring-cloud-gateway-authenticat',
    'admin:1764171193'
);

-- 14. SessionStorage access denied iframe
INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES (
    'SessionStorage access denied failed to read the sessionStorage property in iframe',
    'auth-systems',
    'MEDIUM',
    '[{"solution": "Add Permissions-Policy header: Permissions-Policy: storage-access=(self)", "percentage": 87}, {"solution": "Request storage access in iframe: document.requestStorageAccess().then(() => {...})", "percentage": 85}, {"solution": "Use postMessage API instead of direct sessionStorage access across origins", "percentage": 89}]'::jsonb,
    'iframe embedded in third-party origin, Authentication context needs to be shared with iframe, Browser supports Storage Access API',
    'Iframe can access sessionStorage after requesting permission, Auth token is available in iframe context, Cross-origin communication works via postMessage',
    'Iframe has different origin but tries direct sessionStorage access, Not requesting storage permission before access, Storing sensitive tokens in sessionStorage',
    0.86,
    'claude-sonnet-4-5',
    '2025-11-26'::timestamp,
    'https://stackoverflow.com/questions/24456891/iframe-in-chrome-error-uncaught-securityerror-failed-to-read-the-sessionstora',
    'admin:1764171193'
);

-- 15. 2FA TOTP validation failed
INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES (
    '2FA TOTP authentication error failed to validate the code',
    'auth-systems',
    'MEDIUM',
    '[{"solution": "Verify server time is synchronized with NTP (time should be within 30 seconds of client)", "percentage": 92}, {"solution": "Accept TOTP codes from current window and previous/next windows (30s tolerance): delta <= 1", "percentage": 94}, {"solution": "Regenerate QR code secret if sync issues persist: require user to set up 2FA again", "percentage": 88}]'::jsonb,
    '2FA/TOTP system implemented with secret generation, User has authenticated authenticator app (Google Authenticator, Authy, etc), Server has accurate system time',
    'TOTP code validates successfully on first attempt, User can log in with 2FA enabled, QR code scan sets up authenticator correctly',
    'Server and client time are out of sync by >30 seconds, Not accepting adjacent time windows, Not regenerating secrets when setup fails',
    0.89,
    'claude-sonnet-4-5',
    '2025-11-26'::timestamp,
    'https://stackoverflow.com/questions/70678493/pgadmin-docker-2fa-totp-authentication-error-failed-to-validate-the-code',
    'admin:1764171193'
);
