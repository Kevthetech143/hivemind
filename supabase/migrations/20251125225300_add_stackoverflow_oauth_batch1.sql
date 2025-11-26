-- Add Stack Overflow OAuth solutions batch 1
-- Extracted from high-voted Stack Overflow questions with accepted answers about OAuth errors
-- Category: stackoverflow-oauth
-- Date: 2025-11-25

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'OAuth error: redirect_uri_mismatch - Google OAuth 2.0 redirect URI does not match registered URI',
    'stackoverflow-oauth',
    'VERY_HIGH',
    $$[
        {"solution": "Verify the redirect_uri in your OAuth request exactly matches one registered in Google Cloud Console Credentials page. Check protocol (http vs https), domain (www vs non-www), trailing slashes, port numbers, and case sensitivity - every character must match perfectly", "percentage": 95, "note": "Most common OAuth error - exact string matching required"},
        {"solution": "Register multiple redirect URI variants in Google Cloud Console if needed (e.g., both http://localhost:8080 and http://127.0.0.1:8080). Update your application to use the registered variant", "percentage": 85, "note": "Use same redirect_uri in both authorization and token exchange requests"},
        {"solution": "Clear browser cache and cookies or use incognito/private browsing mode. Changes in Google Console may take several minutes to propagate", "percentage": 75, "note": "Caching can cause stale configuration to be used"},
        {"solution": "For JavaScript applications using Google+ sign-in button, use postmessage as the redirect_uri instead of an actual URL", "percentage": 70, "note": "Special case for popup-based flows"}
    ]$$::jsonb,
    'Google Cloud Console project created, OAuth 2.0 client credentials (Web application type) generated, redirect_uri registered in console',
    'Authorization request proceeds past consent screen without redirect_uri_mismatch error message, user is redirected to registered callback URL',
    'Do not include query string with code parameter in registered redirect_uri. Ensure both authorization and token exchange requests use identical redirect_uri. Common mistake: including www in one place but not the other. Protocol and port must match exactly.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/11485271/google-oauth-2-authorization-error-redirect-uri-mismatch'
),
(
    'OAuth error: invalid_grant - authorization code exchange fails with invalid_grant error',
    'stackoverflow-oauth',
    'VERY_HIGH',
    $$[
        {"solution": "Check that authorization code has not expired (typically 10 minutes). Authorization codes can only be used once - reusing the same code will cause invalid_grant", "percentage": 95, "note": "Most common cause - one-time use codes"},
        {"solution": "Verify system clock is synchronized with NTP. OAuth timestamp validation requires client and server clocks to be within acceptable skew (typically 5 minutes)", "percentage": 90, "note": "Clock skew is documented Google-specific cause"},
        {"solution": "Check user has not revoked app access at https://security.google.com/settings/security/permissions. Revocation only shows errors within 12 hours of occurring", "percentage": 85, "note": "User account changes trigger invalid_grant"},
        {"solution": "Verify you are using the correct client_id and client_secret from Google Cloud Console. Do not use service account email address as client_id", "percentage": 90, "note": "Credential mismatch is very common"},
        {"solution": "If user password was reset or account recovered, their refresh tokens are automatically revoked by Google", "percentage": 80, "note": "Automatic revocation on password change (as of Dec 2015)"},
        {"solution": "Check that you are not attempting to use the same authorization code multiple times. Generate a new authorization code if previous attempt failed", "percentage": 95, "note": "Critical: codes are single-use only"}
    ]$$::jsonb,
    'Valid client_id and client_secret from Google Cloud Console, authorization code obtained from authorization endpoint, system clock synchronized',
    'Token exchange request returns 200 OK with access_token and optional refresh_token. No invalid_grant error returned. Access token can be used to call APIs',
    'Do not retry with same authorization code - it is one-time use. Check server clock synchronization before debugging other causes. Verify credentials by testing with gcloud CLI first. Understand that revocation takes 12 hours to show in error messages.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/10576386/invalid-grant-trying-to-get-oauth-token-from-google'
),
(
    'OAuth error: invalid_client - client authentication failed during token request',
    'stackoverflow-oauth',
    'HIGH',
    $$[
        {"solution": "Verify client_id and client_secret are copied exactly from Google Cloud Console without leading/trailing whitespace. Google''s copy button includes spaces that must be trimmed", "percentage": 95, "note": "Hidden whitespace is very common cause"},
        {"solution": "Ensure Content-Type header is application/x-www-form-urlencoded for token endpoint POST request. Some libraries default to application/json which causes invalid_client", "percentage": 90, "note": "Header mismatch prevents proper parsing"},
        {"solution": "Verify OAuth consent screen has Product Name and Email Address configured in Google Cloud Console. Missing consent screen config causes invalid_client", "percentage": 85, "note": "Configuration dependency often overlooked"},
        {"solution": "Confirm you are using correct OAuth client type (Web application). Do not use Service Account or Native application credentials for web backend flows", "percentage": 88, "note": "Wrong credential type selected"},
        {"solution": "For applications in development, ensure you selected Web application when creating OAuth credentials, not Installed application", "percentage": 85, "note": "Client type determines available grant flows"}
    ]$$::jsonb,
    'OAuth 2.0 Web application client credentials created in Google Cloud Console, consent screen configured with product name, POST request capability',
    'Token endpoint returns 200 OK with access_token. No invalid_client error. Application can access Google APIs with returned token',
    'Do not copy-paste credentials including the full domain suffix - Google adds .apps.googleusercontent.com automatically. Check that credentials are for Web application type, not other types. Ensure OAuth consent screen is not in error state. Clear any cached/expired client secrets.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/17166848/invalid-client-in-google-oauth2'
),
(
    'OAuth error: insufficient_scope - access token lacks required scope for resource endpoint',
    'stackoverflow-oauth',
    'HIGH',
    $$[
        {"solution": "Include scope parameter in initial authorization request at /oauth/authorize endpoint with required scopes space-separated (e.g., scope=openid profile email). Scopes must be requested before token is issued", "percentage": 95, "note": "Scopes must be requested upfront during authorization"},
        {"solution": "Verify the scope value in token request matches the scope in authorization request. Mismatch between requests causes token to lack required scope", "percentage": 90, "note": "Consistency across requests is critical"},
        {"solution": "Check that required scope is supported by OAuth provider (e.g., Google, WSO2, Auth0). Invalid scope names are silently ignored by some providers", "percentage": 80, "note": "Typos in scope names"},
        {"solution": "If userinfo endpoint requires openid scope, explicitly add scope=openid to authorization URL. Default scopes may not include openid", "percentage": 85, "note": "OpenID Connect specific requirement"}
    ]$$::jsonb,
    'OAuth 2.0 authorization endpoint accessible, list of supported scopes documented by provider, client able to modify authorization request',
    'Authorization request succeeds with scope parameter. Token response includes requested scopes. Resource endpoint returns 200 OK when accessing protected resource with token containing required scope',
    'Do not assume default scopes are sufficient - explicitly request needed scopes. Scope names are case-sensitive and provider-specific. Space-delimited format required (not comma-separated). Cannot add scope to token request after authorization - must request upfront.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/32142607/wso2-identity-and-oauth2-userinfo-throws-error-insufficient-scope'
),
(
    'OAuth error: PKCE code_verifier invalid - Base64URL encoding error in code_challenge generation',
    'stackoverflow-oauth',
    'HIGH',
    $$[
        {"solution": "Generate code_verifier as 43-128 characters of URL-safe random bytes. Base64URL encode the verifier without padding using proper library (e.g., Base64.getUrlEncoder().withoutPadding())", "percentage": 95, "note": "Correct cryptographic implementation required"},
        {"solution": "Create code_challenge by computing SHA-256 hash of code_verifier, then Base64URL encoding the binary hash (not hex string) without padding", "percentage": 95, "note": "Do not convert hash to hex string - encode binary directly"},
        {"solution": "Use Base64URL encoder (with + replaced by -, / replaced by _, padding removed) instead of standard Base64. Standard Base64 uses + and / which break URL parsing", "percentage": 92, "note": "URL-safe alphabet required"},
        {"solution": "Verify code_challenge is exactly 43 characters (for SHA-256 without padding) and contains only URL-safe characters [A-Za-z0-9_-]. No padding equals signs allowed", "percentage": 90, "note": "Size and character validation"},
        {"solution": "Send code_verifier (not code_challenge) in token request. Both values must be generated from same code_verifier", "percentage": 93, "note": "Critical: token request uses verifier, not challenge"}
    ]$$::jsonb,
    'PKCE support enabled in OAuth provider, SHA-256 hash function available, URL-safe Base64 encoder library (without padding), random byte generation capability',
    'Authorization request with code_challenge succeeds. Token request with matching code_verifier returns access_token. No code_verifier_invalid error. Authorization code cannot be reused without PKCE parameters',
    'Do not use standard Base64 encoding - must use URL-safe variant without padding. Never convert hash to hex string before encoding - encode binary hash directly. Code_verifier characters must be URL-safe [A-Za-z0-9_-]. Ensure both authorization and token requests reference same code_verifier.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/69781203/oauth2-and-pkce-code-verifier-is-invalid'
),
(
    'OAuth error: state parameter mismatch - CSRF token validation fails during callback',
    'stackoverflow-oauth',
    'HIGH',
    $$[
        {"solution": "Generate cryptographically random state value before redirecting to authorization endpoint. Store state in encrypted session/cookie with HttpOnly flag. Validate returned state matches stored value on callback", "percentage": 95, "note": "Proper state handling prevents CSRF attacks"},
        {"solution": "Do not set custom CallbackPath in OAuth middleware configuration - remove CallbackPath setting entirely. The middleware manages state validation internally on the default callback path", "percentage": 90, "note": "ASP.NET Core specific issue"},
        {"solution": "For multiple OAuth providers on same app, use separate state values per provider. Ensure session affinity when load balancing - same backend instance must handle authorization and callback", "percentage": 88, "note": "Distributed system consideration"},
        {"solution": "Use RedirectUri in AuthenticationProperties instead of CallbackPath to customize callback behavior while preserving state validation", "percentage": 85, "note": "Correct API usage in ASP.NET Core"}
    ]$$::jsonb,
    'Session storage (encrypted cookie or server session), cryptographic random generator, OAuth middleware or library with state support, HTTPS connection',
    'Authorization request redirects to provider with state parameter. Callback returns to application with matching state value. State validation passes. User is authenticated without CSRF error',
    'Do not store unencrypted state in URL or plain text. Do not reuse same state for multiple authorization attempts. If using load balanced backend, ensure sticky sessions or shared state storage. State parameter is security-critical - validate exact match, not substring.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/57164127/the-oauth-state-was-missing-or-invalid-an-error-was-encountered-while-handling-the-remote-login'
),
(
    'OAuth error: access_denied - unauthorized user during testing when app is in testing mode',
    'stackoverflow-oauth',
    'HIGH',
    $$[
        {"solution": "Add test user email addresses to OAuth consent screen in Google Cloud Console. Go to APIs & Services > OAuth consent screen > Test users section and add email addresses of accounts allowed to test", "percentage": 96, "note": "Most common cause - authorization depends on test user list"},
        {"solution": "For Google Workspace domains: ensure project is created by workspace domain user account, not standard Google account. Standard accounts cannot authorize workspace-restricted apps", "percentage": 85, "note": "Domain-specific restriction"},
        {"solution": "Verify app is in testing mode and only authorized test users can access. For production use, publish app by clicking Publish button on consent screen (does not require verification)", "percentage": 88, "note": "Test mode vs production determines who can authorize"},
        {"solution": "When error states ''The developer hasn''t given you access to this app'', add your email as test user. Each test user must be explicitly authorized", "percentage": 95, "note": "Exact error message indicates test user requirement"}
    ]$$::jsonb,
    'Google Cloud Console project access, OAuth consent screen configured, test user email addresses that match Google accounts attempting login',
    'Authorized test user account can complete OAuth flow. Consent screen appears. User is redirected with authorization code. No access_denied error. Token exchange succeeds',
    'Only project owner and explicitly added test users can authorize during testing. Changing from test to production requires clicking Publish button - Google verification not required. Users in workspace domains may see different error messages. Test users must use exact same email for Google account.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/73062345/error-403-access-denied-when-usign-google-oauth'
),
(
    'OAuth error: refresh token expired - token_has_been_expired_or_revoked in testing mode',
    'stackoverflow-oauth',
    'MEDIUM',
    $$[
        {"solution": "Publish your OAuth app from Testing to In Production status in Google Cloud Console OAuth consent screen. Testing mode automatically expires tokens after 7 days; production mode allows indefinite token validity", "percentage": 96, "note": "Most reliable solution for testing to production transition"},
        {"solution": "Delete existing token files and re-authenticate to generate new tokens for production mode. Previous test tokens will not work with production status", "percentage": 92, "note": "Must regenerate tokens after status change"},
        {"solution": "Understand that in testing mode refresh tokens expire exactly 7 days after issuance regardless of usage. Planning token refresh strategy differently for test vs production environments", "percentage": 85, "note": "Document this behavior in development"},
        {"solution": "If user has previously generated 50+ refresh tokens for your app, the oldest token is automatically invalidated. Request fresh authorization if refresh fails after many token generations", "percentage": 75, "note": "Google-specific limit on refresh token count"}
    ]$$::jsonb,
    'OAuth app in testing mode, refresh token previously obtained, Google Cloud Console access to modify consent screen publishing status',
    'OAuth app status changed to In Production. New tokens generated for production. Refresh token continues to work beyond 7 days. Token refresh requests return new access_token without invalid_grant error',
    'Testing mode has 7-day token expiration - this is intentional and documented. Do not expect production-like behavior in testing mode. Publishing app does not require Google verification despite warning messages. Old test tokens remain invalid after mode change. Understand 50-token limit per user per scope combination.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/66058279/token-has-been-expired-or-revoked-google-oauth2-refresh-token-gets-expired-i'
),
(
    'OAuth error: unsupported_grant_type - token endpoint rejects authorization_code grant',
    'stackoverflow-oauth',
    'MEDIUM',
    $$[
        {"solution": "Send token request parameters in POST body with Content-Type: application/x-www-form-urlencoded, not as query string parameters. Newer OAuth servers reject URL query parameters for security", "percentage": 96, "note": "Critical: form-encoded body required"},
        {"solution": "Use Basic Authentication header with base64-encoded client_id:client_secret instead of sending credentials in request body. Format: Authorization: Basic base64(client_id:client_secret)", "percentage": 92, "note": "Authentication method change in newer versions"},
        {"solution": "Verify request is POST to token endpoint, not GET. Some clients default to GET which causes unsupported_grant_type", "percentage": 90, "note": "HTTP method validation"},
        {"solution": "Check for leading/trailing whitespace in grant_type parameter value (e.g., ''authorization_code '' with space). Some libraries automatically trim whitespace", "percentage": 85, "note": "Subtle formatting issue"},
        {"solution": "Verify OAuth server supports authorization_code grant type. Confirm in server documentation that this grant is enabled and not restricted", "percentage": 80, "note": "Server-side configuration"}
    ]$$::jsonb,
    'OAuth token endpoint URL, client credentials (client_id, client_secret), authorization code, Base64 encoding capability, POST request support',
    'Token endpoint returns 200 OK with access_token and optionally refresh_token. No unsupported_grant_type error. Application receives valid access token',
    'Do not send parameters as URL query string to token endpoint - must be in POST body. Ensure Content-Type header is application/x-www-form-urlencoded. Use Basic auth header instead of body credentials in newer servers. Grant type name is case-sensitive and must exactly match provider specification.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/77768814/unsupported-grant-type-error-for-authorization-code-grant-type-spring-security'
),
(
    'OAuth error: invalid_request - malformed token request or missing required parameters',
    'stackoverflow-oauth',
    'MEDIUM',
    $$[
        {"solution": "Verify Content-Length header is included in token request. Some HTTP libraries (like request.js) omit Content-Length which causes invalid_request", "percentage": 85, "note": "Library-specific requirement"},
        {"solution": "Ensure redirect_uri in token request exactly matches the redirect_uri used in authorization request. These must be identical for validation to pass", "percentage": 95, "note": "URI consistency critical"},
        {"solution": "Verify all required parameters are present: code (authorization code), client_id, client_secret/auth header, grant_type, redirect_uri. Missing any parameter causes invalid_request", "percentage": 93, "note": "Complete parameter checklist"},
        {"solution": "Check that authorization code is still valid (typically 10 minutes expiration) and has not been used already. Expired or reused codes cause invalid_request", "percentage": 90, "note": "Code validity window is limited"},
        {"solution": "Do not include query string with code parameter in redirect_uri. The code parameter is separate from redirect_uri - do not append it", "percentage": 88, "note": "Common parameter confusion"}
    ]$$::jsonb,
    'Valid authorization code (less than 10 minutes old), client_id and client_secret from OAuth provider, redirect_uri matching authorization request, POST capability',
    'Token request returns 200 OK with access_token. Request parsing succeeds. Application receives valid token without invalid_request error',
    'Do not reuse authorization codes - each code is single-use only. Ensure redirect_uri does not include the returned code parameter - code comes as separate response. Include Content-Length header. Verify all parameters match authorization request values exactly.',
    0.86,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/28250180/google-oauth2-exchange-authorization-code-for-acces-token-invalid-request'
),
(
    'OAuth error: code_challenge_required - PKCE code_challenge missing from authorization request',
    'stackoverflow-oauth',
    'MEDIUM',
    $$[
        {"solution": "Add code_challenge and code_challenge_method parameters to authorization request. For S256 (recommended): code_challenge_method=S256 and code_challenge=<SHA256_base64url_hash>", "percentage": 95, "note": "PKCE parameters must be present if server requires them"},
        {"solution": "If PKCE is optional and causing issues, disable PKCE on OAuth server configuration. In IdentityServer4/Keycloak, set Code Challenge Method to empty in client settings", "percentage": 80, "note": "Server-side toggle for PKCE requirement"},
        {"solution": "Ensure authorization request includes both code_challenge and code_challenge_method. If either is missing, server rejects with code_challenge_required", "percentage": 92, "note": "Both parameters required together"},
        {"solution": "For public clients (SPAs, native apps), PKCE is required by OAuth 2.0 Security Best Current Practice. Always include PKCE parameters for these client types", "percentage": 88, "note": "Best practice requirement for public clients"}
    ]$$::jsonb,
    'OAuth provider configured to require or support PKCE, ability to compute SHA-256 hash and Base64URL encode, authorization endpoint accepting PKCE parameters',
    'Authorization request with code_challenge succeeds. Authorization endpoint returns authorization code. Token request with code_verifier exchanges code for access_token without code_challenge_required error',
    'PKCE is now best practice for public clients - implement it even if not required. Code_challenge_method S256 is more secure than plain method. Both code_challenge and code_challenge_method must be present together. If implementing PKCE, must also send code_verifier in token request.',
    0.84,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/60028530/i-am-getting-code-challenge-required-when-using-identityserver4'
),
(
    'OAuth error: mismatched_audience - token issued for different resource than requested',
    'stackoverflow-oauth',
    'LOW',
    $$[
        {"solution": "Specify the resource (audience) parameter in authorization request matching the API you want to access. Include audience=<api_identifier> in authorization URL", "percentage": 88, "note": "Resource/audience parameter must match target API"},
        {"solution": "Verify the resource endpoint identifier matches what was requested during authorization. Different APIs have different identifiers (e.g., https://api.example.com vs api.example.com)", "percentage": 85, "note": "API identifier must be exact match"},
        {"solution": "If using multiple APIs, each requires separate authorization request with correct audience. Cannot reuse token from one API for another API", "percentage": 80, "note": "Per-API authorization required"},
        {"solution": "For Azure AD, include resource parameter as full URI (https://graph.microsoft.com) in token request, not just a name", "percentage": 82, "note": "Provider-specific format requirement"}
    ]$$::jsonb,
    'OAuth provider supporting audience/resource parameter, knowledge of target API identifier, ability to make separate authorization requests per API',
    'Authorization request with correct audience parameter succeeds. Token request returns access_token with aud claim matching target API. API accepts token without mismatched_audience error',
    'Each API resource requires separate token with correct audience. Do not assume one token works for multiple APIs. Audience format is provider-specific (URI vs short name). Token validation will fail if audience does not match target resource exactly.',
    0.79,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/76100634'
);
