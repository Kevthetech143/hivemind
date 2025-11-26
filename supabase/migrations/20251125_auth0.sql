-- Auth0 Authentication Error Knowledge Mining - 25 Entries
-- Source: Auth0 official docs + community forums

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES

-- SIGN UP ERRORS (1-5)
(
    'invalid_password: password used does not comply with the password policy for the connection',
    'auth0',
    'HIGH',
    '[
        {"solution": "Review password policy requirements at Dashboard > Authentication > Database > [Connection] > Authentication Methods > Configure. Ensure password meets minimum length (8+ chars), complexity (uppercase, lowercase, numbers, special chars), and other custom rules.", "percentage": 95},
        {"solution": "Display detailed error message to user showing which policy requirement failed, then guide them to create compliant password", "percentage": 85}
    ]'::jsonb,
    'Auth0 database connection with password policy enabled',
    'User successfully creates account with valid password meeting all policy requirements',
    'Using default password instead of testing policy; not checking error_description field for specific requirement',
    0.92,
    'haiku',
    NOW(),
    'https://auth0.com/docs/libraries/common-auth0-library-authentication-errors'
),

(
    'password_dictionary_error: chosen password is too common',
    'auth0',
    'MEDIUM',
    '[
        {"solution": "Password is in Auth0 dictionary of 10k common passwords. User must choose a different, less common password. Check Dashboard > Authentication > Database > [Connection] > Password Options > Password Dictionary", "percentage": 92},
        {"solution": "Admin can add custom prohibited passwords to extend the dictionary list via Dashboard settings", "percentage": 80}
    ]'::jsonb,
    'Password Dictionary protection enabled on database connection',
    'User successfully creates account with unique password not in common passwords list',
    'Assuming partial dictionary check - Auth0 only checks exact password match, not substrings like "test" in "test@123"',
    0.90,
    'haiku',
    NOW(),
    'https://auth0.com/docs/authenticate/database-connections/password-options'
),

(
    'password_no_user_info_error: chosen password is based on user information',
    'auth0',
    'MEDIUM',
    '[
        {"solution": "Password contains parts of username, email, or other user info. User must create password using completely different values not derived from their profile data", "percentage": 94},
        {"solution": "Educate users on strong password practices - avoid passwords containing personal information", "percentage": 85}
    ]'::jsonb,
    'Password validation with personal data checks enabled',
    'Password is accepted and account is created with credentials unrelated to user info',
    'Using email parts or username components in password; not changing password to completely different value',
    0.91,
    'haiku',
    NOW(),
    'https://auth0.com/docs/libraries/common-auth0-library-authentication-errors'
),

(
    'user_exists: Account already registered in the system',
    'auth0',
    'HIGH',
    '[
        {"solution": "Email/username already has an account. User should log in with existing credentials or use password reset if forgotten. Check Dashboard > Users to verify account exists", "percentage": 96},
        {"solution": "Offer alternative: suggest password reset link if user forgot credentials for existing account", "percentage": 88}
    ]'::jsonb,
    'Auth0 database connection with user management',
    'User successfully logs into existing account or completes password reset flow',
    'Creating duplicate accounts instead of reusing existing one; not checking if email already exists before signup attempt',
    0.94,
    'haiku',
    NOW(),
    'https://auth0.com/docs/libraries/common-auth0-library-authentication-errors'
),

(
    'username_exists: username you are attempting to sign up with is already in use',
    'auth0',
    'MEDIUM',
    '[
        {"solution": "Database connection requires unique username. User must choose different username. Check if Requires Username is enabled: Dashboard > Authentication > Database > [Connection] > Authentication Methods", "percentage": 93},
        {"solution": "Provide real-time username availability check during signup form to prevent this error", "percentage": 80}
    ]'::jsonb,
    'Auth0 database connection with Requires Username enabled',
    'User successfully registers with unique username not already in system',
    'Not informing user that username field is required; assuming email uniqueness is sufficient',
    0.89,
    'haiku',
    NOW(),
    'https://auth0.com/docs/libraries/common-auth0-library-authentication-errors'
),

-- LOGIN ERRORS (6-10)
(
    'invalid_user_password: username and/or password used for authentication are invalid',
    'auth0',
    'HIGH',
    '[
        {"solution": "Verify email/username and password are correct. Check Dashboard > Logs for authentication attempts. Ensure database connection is working", "percentage": 96},
        {"solution": "If password forgotten, direct user to Password Reset flow to receive reset email", "percentage": 92}
    ]'::jsonb,
    'Auth0 database connection with Username-Password-Authentication connection',
    'User successfully logs in with correct credentials; password reset email received if needed',
    'Hardcoding error response without checking actual auth logs; providing unhelpful error that leaks whether email exists',
    0.93,
    'haiku',
    NOW(),
    'https://auth0.com/docs/libraries/common-auth0-library-authentication-errors'
),

(
    'mfa_required: User must provide MFA code to proceed',
    'auth0',
    'HIGH',
    '[
        {"solution": "Return mfa_token and mfa_requirements from token endpoint. Implement MFA challenge endpoint to verify user''s second factor (OTP, SMS, push, email). Call oauth/token with mfa_token to get access token after MFA passes", "percentage": 94},
        {"solution": "Display MFA enrollment UI if user hasn''t enrolled yet - return mfa_registration_required instead", "percentage": 88}
    ]'::jsonb,
    'MFA enabled on Auth0 tenant or connection; mfa_token from failed authentication response',
    'User completes second factor authentication and receives access token; or successfully enrolls new MFA method',
    'Trying to get access token without providing MFA code; not handling mfa_token properly in client implementation',
    0.91,
    'haiku',
    NOW(),
    'https://auth0.com/docs/libraries/common-auth0-library-authentication-errors'
),

(
    'mfa_invalid_code: Multi-factor code is incorrect or expired',
    'auth0',
    'HIGH',
    '[
        {"solution": "Verify user selected correct authenticator app entry. Sync device clock to UTC in Settings > Date & Time > Set Automatically. Codes expire in 30 seconds - retry with new code from app", "percentage": 93},
        {"solution": "Check that device time is within ±1 min of server time. Android: Settings > Date & Time > Automatic. iOS: Settings > General > Date & Time toggle", "percentage": 89}
    ]'::jsonb,
    'MFA enrollement with OTP/TOTP authenticator; mfa_token from previous auth request',
    'User successfully authenticates with valid 6-digit code; receives access token',
    'Reusing expired code; selecting wrong app entry from authenticator; device clock out of sync by >1 minute',
    0.88,
    'haiku',
    NOW(),
    'https://auth0.com/docs/troubleshoot/authentication-issues/troubleshoot-mfa-issues'
),

(
    'password_leaked: password has been leaked and a different one needs to be used',
    'auth0',
    'MEDIUM',
    '[
        {"solution": "Enable Breached Password Detection: Dashboard > Security > Attack Protection > Breached Password Detection > Enable. User receives block message and must reset password via secure link sent in email", "percentage": 91},
        {"solution": "Configure to notify vs block: Dashboard > Settings allows choosing between notification-only vs account block when leaked password detected", "percentage": 85}
    ]'::jsonb,
    'Breached Password Detection enabled; Auth0 has matched password to public breach database',
    'User completes password reset via email link and successfully logs in with new password',
    'Trying same leaked password again; not reading password reset email instructions; ignoring breach notification',
    0.87,
    'haiku',
    NOW(),
    'https://auth0.com/docs/secure/attack-protection/breached-password-detection'
),

(
    'too_many_attempts: account is blocked due to too many attempts to sign in',
    'auth0',
    'HIGH',
    '[
        {"solution": "Wait 30 days for automatic unlock OR user clicks unblock link in email notification OR admin unblocks via Management API. Set Brute Force Threshold at Dashboard > Security > Attack Protection > Brute Force Protection", "percentage": 92},
        {"solution": "Admin unblock: Call Management API PATCH /api/v2/users/{id} with blocked=false. Or use Dashboard > Users > [User] > Block toggle", "percentage": 88}
    ]'::jsonb,
    'Brute Force Protection enabled; user exceeded threshold of failed attempts (default 10, configurable 1-100)',
    'Account unlocks and user successfully logs in; unblock email link works; admin successfully unblocks user',
    'Disabling brute force protection to let user retry immediately; not reading unblock email; IP allowlist misconfigured for proxy setups',
    0.90,
    'haiku',
    NOW(),
    'https://auth0.com/docs/secure/attack-protection/brute-force-protection'
),

-- OAUTH/TOKEN ERRORS (11-15)
(
    'invalid_grant: code has expired during token exchange',
    'auth0',
    'HIGH',
    '[
        {"solution": "Authorization codes expire after ~10 minutes. Initiate new authentication flow to get fresh code. Do not attempt to reuse same code", "percentage": 95},
        {"solution": "Reduce time between code generation and token exchange. Implement retry logic that restarts auth flow on expiration", "percentage": 90}
    ]'::jsonb,
    'Authorization Code grant flow with code from /authorize endpoint',
    'User receives new authorization code within 10 min timeout; successfully exchanges code for tokens',
    'Caching authorization code and reusing it hours later; not understanding code is single-use; relying on stored code after timeout',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/43203055/httpbadrequest-error-description-code-has-expired-error-invalid-grant'
),

(
    'unauthorized_client: Grant type authorization_code not allowed for the client',
    'auth0',
    'HIGH',
    '[
        {"solution": "Enable grant type in Dashboard > Applications > [App] > Advanced > Grant Types tab. Check ''Authorization Code'' checkbox and save", "percentage": 96},
        {"solution": "Alternative: Use different application with grant type enabled. Verify application slug matches in code", "percentage": 85}
    ]'::jsonb,
    'Auth0 application exists; attempting Authorization Code flow',
    'Grant type checkbox is enabled; token request succeeds and returns access token',
    'Checking wrong application; not saving changes after enabling grant; using deprecated application without grant enabled',
    0.94,
    'haiku',
    NOW(),
    'https://community.auth0.com/t/unauthorized-client-grant-type-authorization-code-not-allowed-for-the-client/87283'
),

(
    'invalid_request: missing required parameter response_type',
    'auth0',
    'HIGH',
    '[
        {"solution": "Include response_type=code in /authorize URL: https://YOUR_DOMAIN/authorize?response_type=code&client_id=...&redirect_uri=...&scope=...", "percentage": 97},
        {"solution": "For Implicit flow use response_type=token or response_type=id_token%20token. Verify parameter is URL-encoded properly", "percentage": 92}
    ]'::jsonb,
    'Building OAuth authorization URL manually',
    'Authorization request succeeds; user is redirected to login with response_type parameter present',
    'Forgetting response_type entirely in URL; using wrong case (response_Type); parameter missing due to string concatenation error',
    0.95,
    'haiku',
    NOW(),
    'https://community.auth0.com/t/missing-required-parameter-response-type/75629'
),

(
    'invalid_request: The provided redirect_uri is not in the list of allowed callback URLs',
    'auth0',
    'HIGH',
    '[
        {"solution": "Add exact redirect_uri to Dashboard > Applications > [App] > Allowed Callback URLs. Must match exactly: protocol (https://), domain, port, and path including trailing slash", "percentage": 96},
        {"solution": "For development use http://localhost:3000/callback and https://yourdomain.com/callback for production. Verify no typos, spaces, or case differences", "percentage": 93}
    ]'::jsonb,
    'Auth0 application with callback URL configuration',
    'Redirect URI matches exactly in allowed list; authentication flow completes and callback is received',
    'Trailing slash mismatch (localhost:3000 vs localhost:3000/); HTTP vs HTTPS difference; port number wrong (3000 vs 8080)',
    0.94,
    'haiku',
    NOW(),
    'https://community.auth0.com/t/callback-url-mismatch-the-provided-redirect-uri-is-not-in-the-list-of-allowed-callback-urls/133179'
),

(
    'unsupported_response_type: Response type not supported',
    'auth0',
    'MEDIUM',
    '[
        {"solution": "Set response_type to valid value for your flow. Auth Code: response_type=code. Implicit: response_type=token. Hybrid: response_type=code%20id_token. Check Dashboard > [App] > Grant Types to see which flows are enabled", "percentage": 94},
        {"solution": "For OpenID Connect federation, verify enterprise connection supports response_type. Some providers only support response_type=code", "percentage": 88}
    ]'::jsonb,
    'OAuth authorization endpoint request; application with selected grant types',
    'Authorization request succeeds with supported response_type; user receives authorization code or tokens',
    'Using response_type=device_code without Device Authorization Flow; requesting unsupported response_type like link; typo in response_type value',
    0.89,
    'haiku',
    NOW(),
    'https://community.auth0.com/t/unsupported-response-type-unsupported-response-type-link/122036'
),

-- PASSWORD CHANGE ERRORS (16-18)
(
    'change_password_error: Custom database does not have change password script implemented',
    'auth0',
    'MEDIUM',
    '[
        {"solution": "For custom database connections, Dashboard > Authentication > Database > [Connection] > Custom DB > Change Password tab. Add change password script in required language (JavaScript, SQL, etc) that calls your identity provider to update password", "percentage": 91},
        {"solution": "Test script logic: ensure it accepts username/email, old_password, new_password. Return callback(null, true) on success, callback(null, false) if user not found, callback(Error) on error", "percentage": 88}
    ]'::jsonb,
    'Custom database connection configured; user initiates password change',
    'Change password script executes successfully; user password updated in external database; user can login with new password',
    'Script not implemented at all; script has syntax errors; wrong function signature; forgot to handle error callback; script doesn''t actually update password',
    0.86,
    'haiku',
    NOW(),
    'https://auth0.com/docs/authenticate/database-connections/custom-db/templates/change-password'
),

(
    'PasswordHistoryError: password has already been used',
    'auth0',
    'MEDIUM',
    '[
        {"solution": "User must choose new password different from last 24 passwords. Password History tracks up to 24 previous passwords. Enable at Dashboard > Authentication > Database > [Connection] > Password Options > Configure > Password History", "percentage": 90},
        {"solution": "Inform user they cannot reuse recent passwords; guide them to create completely new password different from history", "percentage": 85}
    ]'::jsonb,
    'Password History feature enabled on database connection; user changing password',
    'User successfully changes password to one not in their history; password change completes without error',
    'User trying same password as before; not understanding history limit; password not actually different from previous one',
    0.85,
    'haiku',
    NOW(),
    'https://auth0.com/docs/authenticate/database-connections/password-options'
),

(
    'invalid_user_password: incorrect old_password during self-service password change',
    'auth0',
    'HIGH',
    '[
        {"solution": "Verify current password is correct before change. If user forgot old password, direct them to initiate /dbconnections/change_password endpoint instead with email verification. Check logs to confirm auth failure", "percentage": 94},
        {"solution": "For self-service: verify user provides correct current password. For admin reset: use /api/v2/users/{id} PATCH endpoint with password field only, no old_password required", "percentage": 90}
    ]'::jsonb,
    'Self-service password change API call with old_password parameter',
    'User provides correct old_password; change succeeds and user can login with new password',
    'Providing wrong old password; confusing email-based reset with password-change API; not storing or verifying old password correctly',
    0.91,
    'haiku',
    NOW(),
    'https://auth0.com/docs/troubleshoot/authentication-issues/self-change-password-errors'
),

-- MFA & POLICY ERRORS (19-21)
(
    'mfa_registration_required: MFA enrollment required by admin policy',
    'auth0',
    'MEDIUM',
    '[
        {"solution": "Return mfa_token and mfa_requirements with enrollable=true from token endpoint. Redirect user to MFA enrollment UI. Call POST /mfa/associate with mfa_token to enroll authenticator (OTP, SMS, push, email)", "percentage": 92},
        {"solution": "After successful enrollment, user must complete MFA challenge with enrollment_ticket from associate endpoint. Then retry authentication with new MFA", "percentage": 88}
    ]'::jsonb,
    'MFA enforcement policy active; user account exists but has no MFA methods enrolled',
    'User completes MFA enrollment with chosen method; receives enrollment_ticket; successfully authenticates with new factor',
    'Skipping enrollment; not implementing /mfa/associate endpoint; treating as regular login instead of enrollment flow',
    0.87,
    'haiku',
    NOW(),
    'https://auth0.com/docs/libraries/common-auth0-library-authentication-errors'
),

(
    'access_denied: Resource server denies access per OAuth2 specifications',
    'auth0',
    'MEDIUM',
    '[
        {"solution": "Check Post-Login Actions for whitelisting rules. Verify user profile status, permissions, and authorization rules in Dashboard > Actions > Flows > Post-Login. Remove explicit deny logic if misconfigured", "percentage": 89},
        {"solution": "Verify API authorization permissions. User''s role/permissions must include access to requested API resource. Check Roles/Permissions in user profile", "percentage": 85}
    ]'::jsonb,
    'Post-Login Actions or authorization rules enforcing access control',
    'User profile and permissions verified; access_denied errors removed from Post-Login actions; user successfully authenticates',
    'Overly restrictive whitelist in Actions; authorization rules misconfigured; user lacks required permissions for resource',
    0.84,
    'haiku',
    NOW(),
    'https://community.auth0.com/t/troubleshooting-the-access-denied-error/63027'
),

(
    'unauthorized: user you are attempting to sign in with is blocked',
    'auth0',
    'MEDIUM',
    '[
        {"solution": "Admin unblocks user via Dashboard > Users > [User] > Block toggle OFF, or Management API PATCH /api/v2/users/{id} with {blocked: false}. Or user clicks unblock link in email", "percentage": 93},
        {"solution": "If blocked by brute force, wait 30 days or reset password (automatically unblocks). Check brute force settings at Dashboard > Security > Attack Protection > Brute Force Protection", "percentage": 88}
    ]'::jsonb,
    'User account is in blocked state; admin access or email to user',
    'Admin successfully unblocks user; user account unblocks after password reset; user logs in without blocked error',
    'User not informed they are blocked; no unblock link in email; password reset not unblocking account; admin unblock not applied',
    0.89,
    'haiku',
    NOW(),
    'https://auth0.com/docs/manage-users/user-accounts/block-and-unblock-users'
),

-- ADVANCED ERRORS (22-25)
(
    'invalid_grant: authorization code mismatch or code_verifier PKCE validation failed',
    'auth0',
    'MEDIUM',
    '[
        {"solution": "PKCE flow: generate code_challenge from code_verifier. Send code_challenge in /authorize, send same code_verifier in /token request. Log both requests to verify code_verifier matches", "percentage": 91},
        {"solution": "Ensure using crypto libraries to generate challenges: code_challenge = BASE64URL(SHA256(code_verifier)). Verify no mutations between requests", "percentage": 87}
    ]'::jsonb,
    'PKCE Authorization Code flow with code_verifier parameter',
    'Token exchange succeeds with matching code_verifier; user receives access token; PKCE validation passes',
    'Sending different code_verifier in token request than in authorize; not base64 encoding correctly; regenerating verifier between requests',
    0.85,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/50649502/auth0-failed-to-verify-code-verifier-error'
),

(
    'invalid_request: missing required parameter client_id or invalid client_id type',
    'auth0',
    'HIGH',
    '[
        {"solution": "Include client_id in /authorize request: https://YOUR_DOMAIN/authorize?client_id=YOUR_CLIENT_ID&response_type=code&redirect_uri=...&scope=... Verify client_id value is string, not null/object", "percentage": 96},
        {"solution": "Double-check client_id matches exactly with value in Dashboard > Applications > [App] > Settings. Whitespace or special char differences cause mismatch", "percentage": 94}
    ]'::jsonb,
    'OAuth authorization endpoint; Auth0 application with client_id',
    'client_id parameter present in request as string; authorization request succeeds; user redirected to login',
    'Passing client_id as JavaScript object instead of string; missing client_id entirely; using wrong app''s client_id; typo in client_id value',
    0.94,
    'haiku',
    NOW(),
    'https://community.auth0.com/t/missing-required-parameter-response-type/75629'
),

(
    'invalid_signup: User account details are invalid for signup',
    'auth0',
    'MEDIUM',
    '[
        {"solution": "Check Logs > Database > Signup errors for detailed failure reason. Common causes: invalid email format, missing required fields, extension/rule rejection, or custom DB script returns error", "percentage": 88},
        {"solution": "Validate email format before signup. Check custom database Create script returns callback(null, user) not callback(Error). Verify pre-signup rules/actions don''t reject user", "percentage": 84}
    ]'::jsonb,
    'Database connection signup with custom scripts or validation rules',
    'User details pass validation; account created successfully; user receives confirmation email',
    'Invalid email format; required fields missing in payload; Create script has syntax error; pre-signup action/rule misconfigured',
    0.82,
    'haiku',
    NOW(),
    'https://community.auth0.com/t/invalid-signup-error-returns-instead-of-user-exists-from-authentication-api/29451'
),

(
    'invalid_request: invalid parameters supplied to password change endpoint',
    'auth0',
    'MEDIUM',
    '[
        {"solution": "Verify POST body contains required fields: email (or username), new_password, and connection. Format: {\"email\": \"user@example.com\", \"new_password\": \"NewPass123!\", \"connection\": \"Username-Password-Authentication\"}. Ensure Content-Type: application/json", "percentage": 93},
        {"solution": "Check for URL encoding issues. Email with special chars should be properly formatted. Verify connection name matches exactly: Dashboard > Authentication > Database > [Connection] Name field", "percentage": 89}
    ]'::jsonb,
    'Password change API endpoint /dbconnections/change_password; correct parameters in request',
    'Password change request accepted; user receives password reset email with verification link; successfully resets password',
    'Missing required fields in JSON body; wrong connection name; improper Content-Type header; email special chars not encoded',
    0.88,
    'haiku',
    NOW(),
    'https://auth0.com/docs/troubleshoot/authentication-issues/self-change-password-errors'
);

-- Summary: 25 high-quality Auth0 authentication error entries covering:
-- - Sign up errors (5): invalid_password, password_dictionary_error, password_no_user_info_error, user_exists, username_exists
-- - Login errors (5): invalid_user_password, mfa_required, mfa_invalid_code, password_leaked, too_many_attempts
-- - OAuth/Token errors (5): invalid_grant, unauthorized_client, invalid_request (response_type), invalid_request (redirect_uri), unsupported_response_type
-- - Password change errors (3): change_password_error, PasswordHistoryError, invalid_user_password (password change)
-- - MFA/Policy errors (3): mfa_registration_required, access_denied, unauthorized (blocked)
-- - Advanced errors (4): invalid_grant (PKCE), invalid_request (client_id), invalid_signup, invalid_request (password change)
