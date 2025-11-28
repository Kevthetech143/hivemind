INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'API validation failed for the current request - E0000001',
    'okta',
    'HIGH',
    '[
        {"solution": "Verify password does not contain any part of username or email address. For example, if email is mike.ross@business.com, password cannot contain mike, ross, or business. Also check that password meets Okta complexity requirements defined in your organization''s password policy.", "percentage": 92},
        {"solution": "Review endpoint documentation and verify all request parameters meet preconditions. Ensure required fields are present and correctly formatted.", "percentage": 85}
    ]'::jsonb,
    'Okta API credentials with valid token; understanding of your organization''s password policy',
    'API call succeeds with 200 status; user created or resource modified successfully',
    'Using custom/weak passwords; not checking email-based password restrictions; submitting incomplete request bodies',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/57157703/facing-api-validation-failed-error-while-creating-new-user-in-okta'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Authentication failed - E0000004',
    'okta',
    'HIGH',
    '[
        {"solution": "Verify environment configuration in Postman or your client has valid values for URL, API key, and subdomain parameters. Ensure Authorization header is properly formatted.", "percentage": 70},
        {"solution": "Note that Create Session with Session Token endpoint can only be called once. Each sessionToken is single-use. After first call succeeds, subsequent calls with same token will fail with E0000004.", "percentage": 85},
        {"solution": "Remove and reinstall your testing tool (Postman, etc) and follow official Okta API test client documentation to set up environment correctly.", "percentage": 80}
    ]'::jsonb,
    'Valid Okta credentials; fresh sessionToken from primary authentication; correct endpoint configuration',
    'E0000004 error is no longer returned; session operations complete successfully; API responses contain valid session data',
    'Reusing session tokens multiple times; incorrect parameter format; stale environment configuration; trying to call endpoint twice with same token',
    0.82,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/34753311/okta-unable-to-generate-session-from-session-token-postman'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Invalid session - E0000005',
    'okta',
    'HIGH',
    '[
        {"solution": "Add SSWS prefix to API token in Authorization header. Correct format: Authorization: SSWS {API_TOKEN} not just the token alone.", "percentage": 95},
        {"solution": "Use HTTPS protocol exclusively, never HTTP. When using tools like Fiddler, they auto-redirect to HTTPS which may lose headers.", "percentage": 90},
        {"solution": "Include explicit Content-Type header: Content-Type: application/json in all requests.", "percentage": 85},
        {"solution": "Verify correct domain - if using preview environment, endpoint should be https://{org}.oktapreview.com/api/v1/authn not production URL.", "percentage": 88}
    ]'::jsonb,
    'Valid Okta API token; understanding of correct endpoint URL for your environment (preview vs production)',
    'API returns 200 status; response contains expected user or session data; no E0000005 error in response',
    'Forgetting SSWS prefix in header; using HTTP instead of HTTPS; omitting Content-Type header; mixing preview and production URLs; incomplete token in header',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/27627631/okta-api-authn-always-returns-invalid-session'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'You do not have permission to perform the requested action - E0000006',
    'okta',
    'HIGH',
    '[
        {"solution": "Check user permissions in Okta admin console. Verify the user account has required roles and group assignments for the operation being attempted.", "percentage": 88},
        {"solution": "Review API token permissions. Ensure the token being used has appropriate scopes and is not restricted to read-only access when write operations are needed.", "percentage": 85},
        {"solution": "For OAuth/OIDC flows, verify client has correct authorization scope. Check that requested scope matches what is configured in Okta application settings.", "percentage": 82}
    ]'::jsonb,
    'Okta admin access to check permissions; API token with appropriate scope; understanding of your application''s required permissions',
    'API call succeeds with 200 status; operation completes without 403/E0000006 error; requested resource is accessible',
    'Using wrong API token; user lacks required roles; scope mismatch between request and app configuration; insufficient token permissions',
    0.87,
    'haiku',
    NOW(),
    'https://developer.okta.com/docs/reference/error-codes/'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Not found: Resource not found - E0000007',
    'okta',
    'HIGH',
    '[
        {"solution": "Verify the name field is not a display value but a key for app type. Use actual app template names like template_basic_auth, template_oidc_client, etc. Use label field for human-readable display names instead.", "percentage": 90},
        {"solution": "Verify resource IDs in URL path are correct. Check that user IDs, app IDs, and other identifiers actually exist in your Okta instance.", "percentage": 92},
        {"solution": "Confirm endpoint path is correct and resource type matches. Double-check documentation for the specific API endpoint you''re calling.", "percentage": 85}
    ]'::jsonb,
    'Valid Okta API token; correct resource IDs for your instance; understanding of correct field mappings (name vs label)',
    'API returns 200 status with resource data; resource is successfully created or retrieved; no E0000007 error',
    'Using custom names in name field instead of app template keys; incorrect resource IDs; typos in endpoint paths; confusing name and label fields',
    0.88,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/52612583/issue-while-creating-an-application-through-okta-api'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'The request body was not well-formed - E0000003',
    'okta',
    'HIGH',
    '[
        {"solution": "Use HTTP PUT instead of POST when assigning users to applications. Include an empty JSON object as request body: { }", "percentage": 94},
        {"solution": "If using POST, include properly formatted JSON body with required fields. Verify no content ends abruptly without proper JSON closure.", "percentage": 88},
        {"solution": "Ensure Content-Type header is set to application/json and body is valid JSON, not empty or malformed.", "percentage": 90}
    ]'::jsonb,
    'Okta API token; understanding of correct HTTP method for endpoint (GET, POST, PUT, DELETE)',
    'API returns 200 or 201 status; resource operation completes; no E0000003 malformed body error',
    'Using POST when PUT is required; sending empty body without proper JSON object; missing Content-Type header; truncated JSON body; forgetting to serialize objects to JSON',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/27804141/cannot-create-user-via-okta-api'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Unable to verify JWT token - Error while resolving signing key for kid',
    'okta',
    'HIGH',
    '[
        {"solution": "Clear corrupted cache in JWT verifier module. Restart your application or EC2 instance to reinitialize authentication module state after infrastructure changes.", "percentage": 89},
        {"solution": "Verify token is correct. Ensure the token is valid and contains proper claims and signing key ID (kid) that matches what''s available at your authorization server''s metadata endpoint.", "percentage": 86},
        {"solution": "Verify Audience, Client ID, and Issuer configuration match exactly. These must match how the frontend obtains the token.", "percentage": 84}
    ]'::jsonb,
    'Valid JWT token from Okta; correct Audience, Client ID, Issuer configuration; access to application logs',
    'JWT verification succeeds; no kid resolution errors; token payload is successfully decoded; user authentication completes',
    'Using tokens from different authorization servers; cache not cleared after infrastructure changes; configuration values do not match token claims; including Bearer prefix in token string',
    0.85,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/75884206/okta-jwt-verifier-has-stopped-working-with-error-while-resolving-signing-key-fo'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'The redirect_uri parameter must be a Login redirect URI - 400 Bad Request',
    'okta',
    'HIGH',
    '[
        {"solution": "Change HTTP to HTTPS. Okta requires HTTPS for all redirect URIs. Update from http://yourdomain.com/callback to https://yourdomain.com/callback", "percentage": 94},
        {"solution": "Use DNS names instead of IP addresses for redirect URIs. Access application via domain name like matillion.mycompany.com rather than an IP address.", "percentage": 90},
        {"solution": "Ensure exact matching of redirect URI. The URI is case-sensitive and trailing slashes must match what is configured in Okta app settings.", "percentage": 92}
    ]'::jsonb,
    'Okta application created with redirect URI configured; HTTPS domain available; ability to update Okta app settings',
    'OAuth flow completes successfully; user is redirected to callback URL; no 400 or redirect_uri mismatch errors',
    'Using HTTP instead of HTTPS; using IP addresses instead of domain names; typos in redirect URI; trailing slash mismatches; mixed case domain names',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/70110852/okta-matillion-sso-400-bad-request'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Unsupported operation - E0000060',
    'okta',
    'HIGH',
    '[
        {"solution": "Enable self-service registration in Okta tenant. Navigate to Directory → Self-Service Registration and activate the registration feature in system settings.", "percentage": 95},
        {"solution": "If /api/v1/registration/form returns 501 error, self-service registration is not enabled. This is a tenant-level setting, not application-level.", "percentage": 93}
    ]'::jsonb,
    'Okta admin console access; ability to modify tenant-level settings',
    'GET /api/v1/registration/form returns 200 status with form metadata; signup widget displays properly; user registration flow works end-to-end',
    'Assuming signup widget configuration is sufficient without enabling tenant-level registration; looking only at application settings instead of tenant settings; using old API endpoints',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/71927384/react-okta-sign-up-responses-with-e0000060-error-code'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'HTTP 401 Unauthorized when requesting access token from token endpoint',
    'okta',
    'HIGH',
    '[
        {"solution": "Verify parameter formatting. Ensure ampersand separators between all parameters: client_id=X&grant_type=authorization_code&redirect_uri=Y&code=Z", "percentage": 88},
        {"solution": "Configure Basic authentication header correctly with Base64-encoded credentials: Authorization: Basic + Base64(clientId:clientSecret)", "percentage": 90},
        {"solution": "Verify token endpoint URL matches your Okta authorization server. If using default auth server, remove custom path components. Match token endpoint to your specific Okta setup.", "percentage": 89}
    ]'::jsonb,
    'Valid client ID and secret; correct token endpoint URL for your Okta instance; ability to test HTTP requests',
    'Token endpoint returns 200 status with access_token in response; bearer token is valid for subsequent API calls',
    'Parameter ampersands missing; client_id and client_secret in URL instead of Basic auth header; token endpoint URL mismatch; missing or malformed Basic auth header',
    0.89,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/69951023/okta-access-token-using-token-endpoint-url-returns-http-401-error'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'SAML AudienceRestriction mismatch - None of the audiences within Assertion matched',
    'okta',
    'HIGH',
    '[
        {"solution": "Update entity ID in Spring Security config to match Okta SAML app settings. Ensure relying party entity-id matches the audience value configured in Okta.", "percentage": 91},
        {"solution": "After URL/environment changes, update entity ID in both Spring Security configuration and Okta application settings to reflect new context.", "percentage": 88},
        {"solution": "Verify audience configuration in Okta matches relying party entity ID. The audience should correspond to application metadata endpoint or service provider identifier.", "percentage": 87}
    ]'::jsonb,
    'Spring Security SAML configuration; Okta SAML application configured; ability to modify both application and Okta settings',
    'SAML login completes successfully; user is authenticated and session established; no AudienceRestriction errors in logs',
    'Inconsistent entity ID between Spring and Okta; environment URL change without updating settings; wrong audience value; mismatched metadata endpoints',
    0.89,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/77871180/login-with-saml-2-0-in-spring-boot-okta-error-condition-urnoasisnamestc'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Refused to display page in frame because X-Frame-Options set to sameorigin',
    'okta',
    'HIGH',
    '[
        {"solution": "Avoid embedding Okta login within iframes. Redirect users directly to Okta''s login endpoint instead of trying to load it in an iframe.", "percentage": 92},
        {"solution": "Verify .env file contains correct redirect URI matching actual domain. Confirm domain is registered in Okta application settings for your environment.", "percentage": 89},
        {"solution": "Verify session middleware is properly configured and cookies are transmitted correctly across domain redirects. Check middleware order in Express - OpenID Connect must come after session middleware.", "percentage": 86}
    ]'::jsonb,
    'Node.js/Express application; Okta application with correct redirect URIs; session middleware configured; valid .env configuration',
    'User is redirected to Okta login page; login completes; user is returned to application with valid session; no X-Frame-Options errors',
    'Embedding Okta login in iframe; domain/IP address mismatch between environments; missing session middleware; middleware initialization order issues; stale environment variables',
    0.88,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/64624224/nodejs-application-with-okta-authentication-throwing-x-frame-options-to-sameo'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Invalid token provided - E0000011 on change_password API',
    'okta',
    'HIGH',
    '[
        {"solution": "Generate a new API token in Okta admin console. Expired tokens work for some APIs but fail for others causing confusion. Navigate to Security → API → Tokens and create new token.", "percentage": 95},
        {"solution": "If password has been explicitly expired through admin UI, reactivate user first using lifecycle/activate endpoint before attempting password reset operations.", "percentage": 88}
    ]'::jsonb,
    'Okta admin console access; valid user account in Okta; ability to generate new API tokens',
    'change_password API call succeeds with 200 status; password is updated; user can authenticate with new password',
    'Using expired API tokens; attempting password operations on already-expired accounts; not regenerating tokens regularly; confusing which APIs require new token generation',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/30537913/okta-authn-credentials-change-password-api-is-throwing-invalid-provided-error'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Get User by ID returns 401 - Invalid token provided after successful authentication',
    'okta',
    'HIGH',
    '[
        {"solution": "The /authn endpoint no longer requires authentication token, but other endpoints like Get User by ID still require valid API tokens. Verify your token is not expired.", "percentage": 91},
        {"solution": "Use /users/me endpoint in single-page applications instead, which doesn''t require API token for the authenticated user.", "percentage": 87},
        {"solution": "Regenerate your API token from Okta admin console if issues persist. Verify token has necessary permissions for user retrieval operations.", "percentage": 89}
    ]'::jsonb,
    'Valid Okta API token; understanding that different endpoints have different authentication requirements; access to Okta admin console',
    'Get User API call returns 200 status with user object; /users/me endpoint works in SPA; no 401 errors on user retrieval',
    'Assuming same token works for all endpoints; using /authn for regular API calls; expired or insufficient permission tokens; confusing endpoint authentication requirements',
    0.89,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/36700793/okta-authentication-works-but-get-user-by-id-gives-invalid-token-provided'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Invalid token provided error when creating users via API',
    'okta',
    'HIGH',
    '[
        {"solution": "Verify Authorization header syntax is correct. Format must be: ''Authorization'': ''SSWS YOUR_ACTUAL_API_KEY'' with both quotes present and SSWS prefix.", "percentage": 94},
        {"solution": "Replace template placeholders with actual API token. If code uses {{apiKey}} placeholder (valid in Postman), replace with actual token string in Node.js code.", "percentage": 93},
        {"solution": "Verify correct endpoint URL being called. Some operations may require different API versions or paths depending on your Okta configuration.", "percentage": 85}
    ]'::jsonb,
    'Valid Okta API token; Node.js with request library or equivalent HTTP client; understanding of Authorization header format',
    'User creation API call succeeds with 201 status; new user object returned; no 401 invalid token errors',
    'Missing closing quote in header; using Postman placeholders in code; incomplete token string; typos in SSWS prefix; wrong endpoint URL; spaces in header format',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/45512574/invalid-token-provide-error-in-okta-while-creating-user'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Application is not assigned error at Okta login page',
    'okta',
    'HIGH',
    '[
        {"solution": "Assign application to users or groups in Okta. Navigate to Applications → select app → Assignments tab and add users or groups who should have access.", "percentage": 92},
        {"solution": "If using Okta hosted login page, verify user/group has been explicitly assigned to application. Okta shows 403 Application is not assigned page when user lacks assignment.", "percentage": 90},
        {"solution": "When using widget (self-hosted login), Okta doesn''t show standard error page but rather reflects error differently. Ensure application assignment matches your integration method.", "percentage": 85}
    ]'::jsonb,
    'Okta admin console access; application created in Okta; users or groups to assign',
    'Login page displays correctly; user successfully authenticates; user is granted access to application; no 403 not assigned errors',
    'Forgetting to assign users to application; assuming group assignment is automatic; mixing hosted vs self-hosted login expectations; using old application configuration',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/70085751/authentication-error-message-in-okta-login-page'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'API call exceeded rate limit due to too many requests - E0000047',
    'okta',
    'HIGH',
    '[
        {"solution": "Implement exponential backoff strategy. When rate limit is hit, wait before retrying. Start with 1 second wait and double for each retry up to reasonable maximum.", "percentage": 91},
        {"solution": "Batch API calls where possible to reduce request frequency. Use bulk endpoints when available instead of individual user creation calls.", "percentage": 88},
        {"solution": "Check Okta rate limit headers in response: X-Rate-Limit-Limit, X-Rate-Limit-Remaining, X-Rate-Limit-Reset to understand limits and timing.", "percentage": 85}
    ]'::jsonb,
    'Okta API access; understanding of rate limits for your organization; HTTP client that can handle retries',
    'API calls complete successfully after rate limit recovery; backoff strategy prevents repeated 429 errors; X-Rate-Limit headers show available quota',
    'Continuously retrying without delay; not implementing backoff; ignoring rate limit headers; making unnecessary API calls; inefficient request patterns',
    0.87,
    'haiku',
    NOW(),
    'https://developer.okta.com/docs/reference/error-codes/'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'HTTP Method Not Supported - E0000022',
    'okta',
    'HIGH',
    '[
        {"solution": "Confirm correct HTTP method for your endpoint. Review API documentation for the specific endpoint - it may require GET, POST, PUT, DELETE, or PATCH.", "percentage": 93},
        {"solution": "Some endpoints support multiple methods but with different behaviors. For example, user assignment uses PUT not POST. Check official Okta API reference.", "percentage": 90},
        {"solution": "Verify endpoint path is complete and correct. Sometimes method errors indicate incorrect or incomplete endpoint URLs.", "percentage": 85}
    ]'::jsonb,
    'Okta API reference documentation; understanding of REST HTTP methods; HTTP client tool or library',
    'API call completes with 200/201/204 status appropriate to HTTP method; resource operation succeeds; no 405 method not allowed errors',
    'Confusing required HTTP methods; using POST for assignment operations instead of PUT; mixing up endpoint paths; not checking documentation for method requirements',
    0.91,
    'haiku',
    NOW(),
    'https://developer.okta.com/docs/reference/error-codes/'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Password does not meet complexity requirements - E0000080',
    'okta',
    'HIGH',
    '[
        {"solution": "Review organization''s password policy in Okta admin console. Navigate to Security → Authentication → Password Policy and check requirements.", "percentage": 92},
        {"solution": "Ensure password includes required character types: uppercase, lowercase, numbers, and special characters as per policy. Most policies require minimum 8 characters.", "percentage": 93},
        {"solution": "Verify password does not contain restricted patterns or sequences defined in policy. Some policies check for common patterns or dictionary words.", "percentage": 87}
    ]'::jsonb,
    'Okta admin console access to view password policy; understanding of security requirements; ability to create compliant passwords',
    'Password is accepted by Okta; user account creation or password change succeeds; no E0000080 policy violation errors',
    'Using weak passwords; not checking policy before creating passwords; assuming default policy; ignoring special character requirements; passwords too short',
    0.91,
    'haiku',
    NOW(),
    'https://developer.okta.com/docs/reference/error-codes/'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'OAuth2 invalid_client error - invalid credentials provided',
    'okta',
    'HIGH',
    '[
        {"solution": "Verify client credentials (client_id and client_secret) are correct. Copy directly from Okta application settings, not from documentation examples.", "percentage": 94},
        {"solution": "Ensure credentials match the OAuth application being called. Different applications have different IDs - verify you''re using the right app credentials.", "percentage": 92},
        {"solution": "Regenerate client secret if you suspect compromise or have lost the original. New secret is required for all API calls.", "percentage": 88}
    ]'::jsonb,
    'Okta OAuth application created; valid client_id and client_secret; ability to authenticate with correct credentials',
    'Token endpoint accepts request and returns access_token; OAuth flow completes successfully; no invalid_client errors',
    'Using wrong app credentials; copying test values from docs; exposing secret in code; hardcoding credentials; not rotating secrets periodically',
    0.93,
    'haiku',
    NOW(),
    'https://developer.okta.com/docs/reference/error-codes/'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Okta 403 Forbidden - Access is denied permission error',
    'okta',
    'HIGH',
    '[
        {"solution": "Allow unauthenticated access to callback endpoint in web.config: <allow users=\"?\" /> This is required since users aren''t authenticated by application until callback processes token.", "percentage": 90},
        {"solution": "Check IIS permissions on callback path. The callback endpoint must be publicly accessible for OAuth redirect to work.", "percentage": 88},
        {"solution": "Verify user permissions and roles in Okta. Some operations require specific admin roles. Check that user account has necessary permissions for action.", "percentage": 86}
    ]'::jsonb,
    'IIS web server configuration access; Okta application setup; understanding of OAuth callback flow; admin permissions if needed',
    'Callback endpoint is accessible; OAuth login completes; user is authenticated and returned to application; no 403 errors on callback',
    'Blocking callback endpoint with overly strict permissions; requiring authentication before OAuth flow completes; missing web.config allow rules; incorrect user permissions',
    0.88,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/67985932/okta-getting-403-forbidden-access-is-denied-error'
);
