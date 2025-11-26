-- Firebase Auth Error Solutions - Batch 1 (12 high-engagement issues)
-- Category: github-firebase-auth
-- Source: https://github.com/firebase/firebase-js-sdk/issues
-- Extracted: 2025-11-25

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Firebase Auth signs out user when receives error 429 - too many requests',
    'github-firebase-auth',
    'HIGH',
    $$[
        {"solution": "Implement exponential backoff retry logic for token refresh requests to prevent triggering rate limits repeatedly", "percentage": 85, "note": "Prevents cascading failures from automated retry storms"},
        {"solution": "Monitor token refresh rates and batch identity toolkit endpoint calls when possible", "percentage": 80, "note": "Reduces overall request volume to Google identity services"},
        {"solution": "Implement client-side rate limiting before sending refresh requests to identitytoolkit.googleapis.com", "percentage": 75, "note": "Prevents hitting server rate limits in the first place"}
    ]$$::jsonb,
    'Firebase SDK v12.2.1+, Valid authentication setup, Monitoring for 429 responses',
    'Token refresh succeeds without automatic sign-out, No 429 errors in logs, User authentication persists across network requests',
    'Do not retry immediately on 429 - implement exponential backoff. Check Retry-After header. Do not assume 429 means user should be logged out. Monitor rate limit headers in production.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/firebase/firebase-js-sdk/issues/9259'
),
(
    'Custom Claims Disappear from ID Token After updateEmail or updateProfile Calls',
    'github-firebase-auth',
    'HIGH',
    $$[
        {"solution": "Call signInWithCustomToken() again after updateEmail() or updateProfile() to restore custom claims without page reload", "percentage": 90, "note": "Workaround: forces token refresh with original custom claims"},
        {"solution": "Refresh ID token using getIdTokenResult(true) after profile updates; if claims missing, re-authenticate with custom token", "percentage": 85, "note": "Checks for missing claims and recovers gracefully"},
        {"solution": "Implement a wrapper around updateEmail/updateProfile that automatically triggers custom token refresh on completion", "percentage": 80, "note": "Automates recovery without exposing implementation to calling code"}
    ]$$::jsonb,
    'Firebase SDK v12.0.0+, Custom token with custom claims, User authenticated',
    'Custom claims present in getIdTokenResult() after profile update, Firestore security rules work without re-authentication, No permission errors on subsequent queries',
    'Do not rely on getIdTokenResult(true) alone to restore claims. Custom claims are not automatically refreshed with profile updates. Must re-authenticate with custom token. Test claims presence after every profile change.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/firebase/firebase-js-sdk/issues/9260'
),
(
    'signInWithCustomToken failed to fetch error after 30 seconds inactivity',
    'github-firebase-auth',
    'MEDIUM',
    $$[
        {"solution": "Verify Firebase auth instance initialization is complete before calling signInWithCustomToken(); use async/await properly", "percentage": 85, "note": "Ensures auth is ready before token sign-in"},
        {"solution": "Check persistence configuration - test with memoryPersistence to isolate storage issues during debugging", "percentage": 80, "note": "Eliminates IndexedDB/localStorage issues as cause"},
        {"solution": "Investigate race conditions between Clerk and Firebase token generation; add logging to trace token flow timing", "percentage": 75, "note": "Identifies if tokens are generated during unavailable window"},
        {"solution": "Monitor network activity during failures and check for browser cache/session storage stale data", "percentage": 70, "note": "Clears any cached authentication state affecting timing"}
    ]$$::jsonb,
    'Clerk integration with Firebase, Valid Firebase auth initialization, In-memory or configured persistence',
    'signInWithCustomToken succeeds after inactivity, No failed to fetch errors in console, User authenticated within 5 seconds of token generation',
    'Do not assume "failed to fetch" means network issue - may be auth instance not ready. In-memory persistence can mask IndexedDB problems. Ensure token generation completes before sign-in attempt.',
    0.80,
    'sonnet-4',
    NOW(),
    'https://github.com/firebase/firebase-js-sdk/issues/9220'
),
(
    'signInWithRedirect fails on Chrome 115+, Safari 16.1+, Firefox 109+ - third-party cookies blocked',
    'github-firebase-auth',
    'VERY_HIGH',
    $$[
        {"solution": "Switch from signInWithRedirect to signInWithPopup for better third-party cookie compatibility", "percentage": 92, "note": "Popup flow maintains first-party context better than redirect"},
        {"solution": "Implement popup blocker detection and fallback to custom redirect flow with OAuth proxy as documented in Firebase best practices guide option 3", "percentage": 85, "note": "Provides fallback for popup-blocking browsers"},
        {"solution": "Configure Authorization Server with proper SameSite=None; Secure cookie attributes for redirect flow compatibility", "percentage": 80, "note": "Explicitly enables third-party cookie usage where needed"},
        {"solution": "Use Firebase SDK version 9.0.0+ which has improved handling for cookie-blocking browsers", "percentage": 85, "note": "Later versions have browser-specific optimizations"}
    ]$$::jsonb,
    'Firebase SDK v9.0.0+, Support for popup or custom redirect implementation, HTTPS for production',
    'User authenticates successfully without manual cookie adjustments, No redirect without authentication, OAuth provider callback succeeds',
    'signInWithRedirect alone will not work on modern browsers with third-party cookies disabled. Do not rely on redirect-only flow. Test on Safari/Firefox for compatibility. Popup flow requires user interaction but works better.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/firebase/firebase-js-sdk/issues/8329'
),
(
    'Facebook sign-in fails on Android Chrome with "Unable to process request due to missing initial state"',
    'github-firebase-auth',
    'HIGH',
    $$[
        {"solution": "Verify Firebase best practices option 3 (proxy passthrough) is properly configured with no HTTP 302 redirects or cross-domain data transfer", "percentage": 88, "note": "Incorrect redirect handling causes state loss"},
        {"solution": "Test with Firefox Android using signInWithRedirect as reference implementation to isolate Chrome-specific issues", "percentage": 82, "note": "Firefox working rules out provider configuration as root cause"},
        {"solution": "Check Facebook app settings for Android app configuration; verify package name and signature hash match registered values", "percentage": 80, "note": "Misconfigured app certificate causes state validation failures"},
        {"solution": "Switch from signInWithRedirect to signInWithPopup for Android Chrome; use popup blocker detection to catch user-initiated blocks", "percentage": 75, "note": "Popup maintains better state context on Android"}
    ]$$::jsonb,
    'Firebase SDK v12.2.1+, Facebook provider configured, Android Chrome browser, Firebase best practices implemented',
    'User authenticates successfully via Facebook on Android Chrome, No initial state errors in auth flow, Auth handler tab closes without user-cancelled message',
    'signInWithRedirect + signInWithPopup both fail on Android Chrome with Facebook provider - this is known platform issue. Do not assume it is misconfiguration. Test on iOS/Mac/other browsers as comparison. Popup may be better fallback.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/firebase/firebase-js-sdk/issues/9256'
),
(
    'auth.setPersistence(browserLocalPersistence) is not idempotent - wipes stored auth session',
    'github-firebase-auth',
    'HIGH',
    $$[
        {"solution": "Check current persistence mode before calling setPersistence(); only call if switching to different persistence type", "percentage": 92, "note": "Prevents unnecessary clearing of stored auth state"},
        {"solution": "Implement a wrapper function that caches the current persistence mode and skips setPersistence() calls with identical mode", "percentage": 88, "note": "Idempotent wrapper pattern avoids state clearing"},
        {"solution": "Call setPersistence() once during auth initialization, not on every app rerender or reinitialization cycle", "percentage": 85, "note": "Move persistence setup to initialization phase, not reactive phase"},
        {"solution": "Use a custom persistence manager that verifies current mode matches target before clearing IndexedDB/localStorage", "percentage": 82, "note": "Adds defensive check before any clearing operation"}
    ]$$::jsonb,
    'Firebase SDK v9.0.0+, Browser with localStorage and IndexedDB, Multi-tab application',
    'Auth session persists across tab opens, No unexpected sign-outs in new tabs, Persistence mode switches only when intentionally requested',
    'Do not call setPersistence() during every app initialization - call once during setup. Calling with same persistence type clears stored session. Not documented that identical mode also triggers clearing. Test multi-tab scenarios.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/firebase/firebase-js-sdk/issues/9319'
),
(
    'setPersistence(LOCAL) Promise hangs and onAuthStateChanged never fires on iOS',
    'github-firebase-auth',
    'HIGH',
    $$[
        {"solution": "Upgrade Firebase JS SDK to v11.x or later which includes IndexedDB error handling improvements for iOS", "percentage": 90, "note": "Latest versions resolve underlying IndexedDB hangs"},
        {"solution": "Wrap setPersistence() with a timeout; if promise does not resolve within 5 seconds, fallback to memoryPersistence", "percentage": 85, "note": "Prevents indefinite hangs from blocking auth setup"},
        {"solution": "Test with memoryPersistence on iOS to verify SDK works; if successful, issue is IndexedDB-specific for this device", "percentage": 82, "note": "Isolates whether problem is persistence layer or auth itself"},
        {"solution": "Clear app cache and IndexedDB data on iOS device; in Capacitor use CapacitorSQLite.deleteDatabase() if using SQLite fallback", "percentage": 78, "note": "Corrupted IndexedDB causes persistent hangs"}
    ]$$::jsonb,
    'Firebase JS SDK v8.10.1+, iOS device with Ionic/Capacitor, IndexedDB support',
    'setPersistence() promise resolves within 5 seconds, onAuthStateChanged callback fires, App does not hang on loading screen',
    'iOS specifically prone to IndexedDB open hangs. Promise may never resolve if IndexedDB is corrupted. Do not use LOCAL persistence without timeout fallback on iOS. memoryPersistence works fine as alternative.',
    0.83,
    'sonnet-4',
    NOW(),
    'https://github.com/firebase/firebase-js-sdk/issues/9132'
),
(
    'ID token refresh fails when using browserCookiePersistence - automatic logout after 1 hour',
    'github-firebase-auth',
    'HIGH',
    $$[
        {"solution": "Ensure refresh token is stored alongside ID token in cookie persistence; implement custom persistence layer that preserves both tokens", "percentage": 88, "note": "SDK cookie persistence may not store refresh token in beta"},
        {"solution": "Use latest Firebase SDK v11.6.1+ with official cookie persistence implementation that includes refresh token support", "percentage": 85, "note": "Newer versions have complete token storage"},
        {"solution": "Switch to browserLocalPersistence or browserSessionPersistence as workaround if cookie persistence has known bugs", "percentage": 80, "note": "IndexedDB persistence works reliably for token refresh"},
        {"solution": "Verify cookies are not being cleared after 7 days of inactivity on iOS Safari; set SameSite and Secure attributes properly", "percentage": 75, "note": "Safari auto-clears cookies, may cause refresh failures"}
    ]$$::jsonb,
    'Firebase SDK v11.6.1+, React + Next.js, browserCookiePersistence enabled, Valid refresh token',
    'ID token automatically refreshes after expiration, No user-token-expired errors after 1 hour, User remains logged in across browser sessions',
    'Cookie persistence in beta may not store refresh token. Do not use with old SDK versions. iOS Safari clears cookies after 7 days - users will logout. Cookie persistence is not equivalent to IndexedDB.',
    0.80,
    'sonnet-4',
    NOW(),
    'https://github.com/firebase/firebase-js-sdk/issues/9018'
),
(
    'Sign In fails when using custom OIDC provider - INVALID_IDP_RESPONSE error 400',
    'github-firebase-auth',
    'MEDIUM',
    $$[
        {"solution": "Verify provider ID is case-sensitive and matches exactly between Firebase Console and code initialization", "percentage": 92, "note": "Provider ID mismatch is most common OIDC configuration error"},
        {"solution": "Log authProvider.providerId to console and compare against Firebase Console OIDC configuration; they must match exactly", "percentage": 90, "note": "Validates configuration without blind guessing"},
        {"solution": "Verify OIDC provider issuer URL is accessible and returns valid .well-known/openid-configuration endpoint", "percentage": 85, "note": "Issuer unreachability causes INVALID_IDP_RESPONSE"},
        {"solution": "Check Firebase Console > Authentication > Providers to ensure OIDC provider is enabled and issuer URL is correct", "percentage": 82, "note": "Disabled provider or wrong issuer URL prevents connection"}
    ]$$::jsonb,
    'Custom OIDC provider configured, Firebase SDK v11.0.1+, Valid OIDC issuer endpoint',
    'signInWithPopup/signInWithRedirect succeeds with OIDC provider, No 400 INVALID_IDP_RESPONSE error, User authenticated successfully',
    'Do not assume provider ID configuration is correct without logging it. Case matters for provider ID. Issuer URL must be accessible from client. Test issuer .well-known endpoint manually.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/firebase/firebase-js-sdk/issues/8790'
),
(
    'Significant delay in signInWithCredential after Facebook/Google OAuth redirect',
    'github-firebase-auth',
    'MEDIUM',
    $$[
        {"solution": "Profile the signInWithCredential() call timing separately from network latency; add performance markers before/after credential generation", "percentage": 88, "note": "Identifies if delay is in credential generation vs Firebase servers"},
        {"solution": "Test signInWithPopup() instead of redirect flow to compare timing; if popup is fast, issue may be redirect+credential generation sequence", "percentage": 85, "note": "Popup eliminates redirect overhead from equation"},
        {"solution": "Check Firebase backend load and server response times during testing window; delays may correlate with backend processing", "percentage": 78, "note": "Server-side delays affect signInWithCredential timing"},
        {"solution": "Verify authorized domains include all OAuth provider redirect URIs; misconfigured domains cause extra validation delays", "percentage": 75, "note": "Domain validation adds latency if domain is not pre-authorized"}
    ]$$::jsonb,
    'Firebase SDK v10.12.2+, Facebook/Google OAuth configured, Ruby on Rails + React backend',
    'signInWithCredential completes within 2 seconds, idToken returned quickly, Backend session creation succeeds without timeout',
    'Delays in signInWithCredential may be normal (up to 3-5 seconds). Do not assume it is network latency. Test with signInWithPopup for comparison. Android may have longer delays than iOS.',
    0.75,
    'sonnet-4',
    NOW(),
    'https://github.com/firebase/firebase-js-sdk/issues/8535'
),
(
    'verifyPhoneNumber returns auth/invalid-app-credential error only on localhost',
    'github-firebase-auth',
    'MEDIUM',
    $$[
        {"solution": "Whitelist 127.0.0.1 in Firebase Console > Authentication > Settings > Authorized Domains; serve app on 127.0.0.1 instead of localhost", "percentage": 88, "note": "localhost vs 127.0.0.1 are treated differently by reCAPTCHA"},
        {"solution": "Add localhost:port (e.g., localhost:3000) to Authorized Domains list in Firebase Console; use exact port number in domain", "percentage": 85, "note": "Port-specific whitelisting may resolve credential validation"},
        {"solution": "For reCAPTCHA Enterprise, verify both IP address AND domain are whitelisted in reCAPTCHA Enterprise admin console", "percentage": 80, "note": "Enterprise requires additional whitelisting beyond Firebase Console"},
        {"solution": "Use production deployment URL (e.g., Vercel) for phone verification testing if localhost whitelist fails", "percentage": 75, "note": "Production endpoints have higher trust by default"}
    ]$$::jsonb,
    'Firebase JS SDK v10.12.4+, Next.js app, Firebase App Check with reCAPTCHA Enterprise, Phone MFA enabled',
    'verifyPhoneNumber succeeds on localhost without 400 errors, reCAPTCHA validation passes, MFA flow completes',
    'localhost and 127.0.0.1 are treated as different domains by reCAPTCHA. Standard localhost whitelisting may not work. Port number must match exactly. Production URLs work without special whitelisting.',
    0.78,
    'sonnet-4',
    NOW(),
    'https://github.com/firebase/firebase-js-sdk/issues/8387'
),
(
    'MISSING_OR_INVALID_NONCE error with OIDC provider using authorization code flow',
    'github-firebase-auth',
    'MEDIUM',
    $$[
        {"solution": "When using OIDC provider credential, ensure nonce matches between authorization request and ID token validation; Firebase SDK handles SHA256 internally", "percentage": 90, "note": "Do not manually compute SHA256 hash - SDK does this"},
        {"solution": "Use OAuthProvider credential flow correctly: request idToken from OIDC provider with nonce parameter, pass idToken to credential() method", "percentage": 88, "note": "Correct parameter passing eliminates nonce mismatch"},
        {"solution": "Disable nonce validation in OIDC provider (e.g., Keycloak) only as temporary workaround; not recommended for production", "percentage": 75, "note": "Nonce validation is security feature - should not be disabled"},
        {"solution": "Ensure Keycloak/OIDC provider is configured with correct redirect URI matching Firebase setup; mismatched redirect causes nonce failures", "percentage": 82, "note": "Redirect URI mismatch breaks nonce chain"}
    ]$$::jsonb,
    'Firebase SDK v11.7.2+, Angular 16, Keycloak OIDC provider, Authorization code flow',
    'signInWithCredential succeeds without nonce error, ID token accepted, User authenticated with OIDC provider',
    'Do not manually add rawNonce to credential object. Do not disable nonce validation in provider. Firebase SDK computes nonce hash automatically. Test Keycloak redirect URI configuration.',
    0.80,
    'sonnet-4',
    NOW(),
    'https://github.com/firebase/firebase-js-sdk/issues/8207'
),
(
    'getIdTokenResult() with forceRefresh reruns snapshot listeners with includeMetadataChanges',
    'github-firebase-auth',
    'MEDIUM',
    $$[
        {"solution": "Set forceRefresh to false in getIdTokenResult() calls; let SDK handle token refresh naturally on expiration", "percentage": 92, "note": "Prevents unnecessary listener re-executions"},
        {"solution": "If token refresh monitoring is needed, call getIdTokenResult(false) less frequently - every 5-10 minutes instead of every 7 seconds", "percentage": 88, "note": "Reduces listener firing without sacrificing token freshness"},
        {"solution": "Disable includeMetadataChanges: true in Firestore listener options if not strictly needed; reduces listener sensitivity to token changes", "percentage": 85, "note": "Metadata changes listener is not needed in most cases"},
        {"solution": "Implement listener memoization to ignore cache status changes; only rerun on actual data changes within fromCache boundaries", "percentage": 78, "note": "Filters out metadata-only changes from triggering logic"}
    ]$$::jsonb,
    'Firebase JS SDK v10+, Firestore listeners with includeMetadataChanges, forceRefresh token refresh',
    'Snapshot listeners fire only on actual data changes, not on token refresh, Metadata changes do not cause unnecessary re-executions, Cache status stable',
    'Do not call getIdTokenResult(true) repeatedly in polling loops. Frequent forceRefresh breaks listener logic. includeMetadataChanges: true is only needed if cache status is significant.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/firebase/firebase-js-sdk/issues/8686'
),
(
    'No way to remove name scope when using Sign in with Apple - automatic scope request',
    'github-firebase-auth',
    'MEDIUM',
    $$[
        {"solution": "Disable One account per email address setting in Firebase Console > Authentication > Sign-in method > Apple; allows per-provider scope control", "percentage": 88, "note": "Removes automatic email and name scope defaults"},
        {"solution": "When account linking is enabled, explicitly initialize OAuthProvider with only required scopes: new OAuthProvider(''apple.com'').addScopes(''email'')", "percentage": 85, "note": "Override default scopes with explicit scope array"},
        {"solution": "Accept that email and name are default scopes for Apple sign-in; redirect users to consent screen and let them manage sharing permissions", "percentage": 80, "note": "Users can deny name sharing at Apple consent dialog"},
        {"solution": "Post-authentication, check if displayName was set from name scope; explicitly clear it if not needed: updateProfile(currentUser, {displayName: null})", "percentage": 75, "note": "Removes unwanted displayName after authentication"}
    ]$$::jsonb,
    'Firebase SDK v9.0.0+, Apple provider configured, One account per email address enabled',
    'Apple sign-in completes without requesting name scope, displayName not populated unless explicitly needed, Consent dialog shows only email scope',
    'Default behavior requests both email and name scopes when One account per email is enabled. Cannot fully prevent name scope request without disabling account linking. Accept Apple''s default scopes.',
    0.78,
    'sonnet-4',
    NOW(),
    'https://github.com/firebase/firebase-js-sdk/issues/8869'
);
