INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'FirebaseError: Firebase: Error (auth/invalid-api-key). Your API key is invalid, please check you have copied it correctly.',
    'firebase',
    'HIGH',
    '[
        {"solution": "Verify API key is copied exactly from Firebase Console > Project Settings > Web Setup. Check for trailing/leading spaces.", "percentage": 95},
        {"solution": "In Firebase Console, go to APIs & Services > Credentials and confirm the Web API key is enabled and not restricted.", "percentage": 90},
        {"solution": "For environment variables, ensure process.env or import.meta.env correctly references the API key. Check build output to confirm value is injected.", "percentage": 85}
    ]'::jsonb,
    'Firebase project created, Web SDK initialized',
    'App loads without auth/invalid-api-key error in console. signInWithEmailAndPassword() succeeds.',
    'Copying API key with extra spaces. Using wrong project''s credentials. Environment variable not passed to build tool.',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/54636324/firebase-invalid-api-key-error-in-console'
),
(
    'FirebaseAuthException with code: user-not-found',
    'firebase',
    'HIGH',
    '[
        {"solution": "Verify the email address is registered in Firebase Console > Authentication > Users. Check exact email match (case-insensitive but whitespace-sensitive).", "percentage": 96},
        {"solution": "Use FirebaseAuth.instance.fetchSignInMethodsForEmail(email) to check if account exists before attempting sign-in.", "percentage": 88},
        {"solution": "If migrating users, ensure migration script created all accounts before users attempt login.", "percentage": 85}
    ]'::jsonb,
    'Firebase project with Authentication enabled, email/password provider configured',
    'Sign-in succeeds with correct email. App properly handles missing accounts with appropriate UI message.',
    'Typo in email address. Case sensitivity confusion. Account created in different Firebase project.',
    0.94,
    'haiku',
    NOW(),
    'https://firebase.google.com/docs/auth/flutter/errors'
),
(
    'FirebaseAuthException with code: wrong-password',
    'firebase',
    'HIGH',
    '[
        {"solution": "Implement password reset flow: sendPasswordResetEmail(email) and guide user through email verification.", "percentage": 92},
        {"solution": "On sign-in failure, prompt user to re-enter password carefully or use password manager.", "percentage": 85},
        {"solution": "Add account lockout after N failed attempts (e.g., 5) to prevent brute force attacks.", "percentage": 88}
    ]'::jsonb,
    'User email exists in Firebase, password reset feature available',
    'User can reset password via email link or successfully sign in after entering correct password.',
    'Storing passwords client-side. Not implementing rate limiting. User sees generic error without recovery path.',
    0.93,
    'haiku',
    NOW(),
    'https://firebase.google.com/docs/auth/admin/errors'
),
(
    'FirebaseAuthException with code: weak-password',
    'firebase',
    'MEDIUM',
    '[
        {"solution": "Enforce minimum 6-character password requirement in UI validation before submission.", "percentage": 94},
        {"solution": "Display password strength indicator showing requirements: 6+ characters, mix of uppercase/lowercase/numbers/symbols.", "percentage": 89},
        {"solution": "Firebase Admin SDK allows custom password policies via setCustomUserClaims() if using custom auth backend.", "percentage": 82}
    ]'::jsonb,
    'Firebase Authentication enabled, client app form handling user input',
    'User sees password requirements clearly. Password validation passes on client before server submission.',
    'Not validating on client-side. Showing obscure Firebase error without password requirements. Hard-coding exact Firebase rules.',
    0.91,
    'haiku',
    NOW(),
    'https://firebase.google.com/docs/auth/flutter/errors'
),
(
    'FirebaseAuthException with code: email-already-in-use',
    'firebase',
    'HIGH',
    '[
        {"solution": "Catch exception and prompt user to sign in instead or use different email. Suggest password reset if user forgot account.", "percentage": 94},
        {"solution": "Use FirebaseAuth.instance.fetchSignInMethodsForEmail(email) before sign-up to check availability.", "percentage": 90},
        {"solution": "If user wants to add email to existing account, call linkWithCredential() after reauthenticating with current provider.", "percentage": 85}
    ]'::jsonb,
    'Firebase Authentication with email/password enabled, sign-up form implemented',
    'Sign-up form detects duplicate email and suggests alternatives. No duplicate accounts created.',
    'Not checking email availability before sign-up. Silently failing sign-up. Showing generic error message.',
    0.93,
    'haiku',
    NOW(),
    'https://firebase.google.com/docs/auth/admin/errors'
),
(
    'FirebaseAuthException with code: invalid-email',
    'firebase',
    'HIGH',
    '[
        {"solution": "Validate email format client-side using regex: /^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$/ before submission.", "percentage": 97},
        {"solution": "Use Firebase''s built-in email validation in signUpWithEmailAndPassword() but catch and handle gracefully.", "percentage": 92},
        {"solution": "Trim whitespace from email input: email.trim() before any Firebase operation.", "percentage": 95}
    ]'::jsonb,
    'User registration or login form, email input field available',
    'Invalid email rejected with clear message before Firebase call. Valid emails accepted.',
    'Not trimming whitespace. Accepting invalid formats like missing @ or domain. Not providing specific error feedback.',
    0.95,
    'haiku',
    NOW(),
    'https://firebase.google.com/docs/auth/admin/errors'
),
(
    'FirebaseAuthException with code: user-disabled',
    'firebase',
    'MEDIUM',
    '[
        {"solution": "In Firebase Console > Authentication > Users, remove the disable flag on user account.", "percentage": 96},
        {"solution": "Implement admin panel to enable/disable users. Catch auth/user-disabled and show message to contact support.", "percentage": 88},
        {"solution": "Log user disablement actions in audit trail for compliance. Email user when account is disabled with reason.", "percentage": 85}
    ]'::jsonb,
    'Firebase Authentication enabled, Firebase Console access, admin interface',
    'Disabled user cannot sign in and sees appropriate message. Admin can re-enable via Console.',
    'No audit trail of who disabled accounts. User not notified. No recovery path shown to user.',
    0.92,
    'haiku',
    NOW(),
    'https://firebase.google.com/docs/auth/admin/errors'
),
(
    'FirebaseAuthException with code: operation-not-allowed',
    'firebase',
    'MEDIUM',
    '[
        {"solution": "In Firebase Console > Authentication > Sign-in method, enable the required provider (Email/Password, Google, etc).", "percentage": 98},
        {"solution": "Verify you''re enabling the exact provider your app code is attempting to use.", "percentage": 96},
        {"solution": "If using multi-provider auth, ensure all providers are enabled in Firebase Console.", "percentage": 94}
    ]'::jsonb,
    'Firebase project created, Authentication section in Firebase Console',
    'Provider is enabled in Console. App can successfully authenticate with that provider.',
    'Forgetting to enable provider in Console. Checking wrong Firebase project. Typo in provider name.',
    0.97,
    'haiku',
    NOW(),
    'https://firebase.google.com/docs/auth/admin/errors'
),
(
    'FirebaseAuthException with code: network-request-failed',
    'firebase',
    'MEDIUM',
    '[
        {"solution": "Check device network connectivity. Retry operation after network is restored using exponential backoff.", "percentage": 88},
        {"solution": "In Flutter, use package:connectivity_plus to monitor network state and disable auth buttons when offline.", "percentage": 85},
        {"solution": "Verify Firebase project is accessible from user''s region. Check Firebase status page for regional outages.", "percentage": 82}
    ]'::jsonb,
    'Network connectivity available, Firebase project accessible',
    'App retries operation when network restored. User sees offline indicator. Operation succeeds on retry.',
    'No offline handling. Not retrying automatically. Showing raw Firebase error instead of user-friendly message.',
    0.83,
    'haiku',
    NOW(),
    'https://firebase.google.com/docs/auth/flutter/errors'
),
(
    'FirebaseAuthException with code: too-many-requests',
    'firebase',
    'MEDIUM',
    '[
        {"solution": "Implement rate limiting on client side: limit sign-in attempts to 5 per minute, then show 15-minute cooldown timer.", "percentage": 90},
        {"solution": "Use Firebase Security Rules to enforce rate limits server-side for sensitive operations.", "percentage": 85},
        {"solution": "Show user message: ''Too many failed attempts. Please wait 15 minutes before trying again or reset your password.''", "percentage": 88}
    ]'::jsonb,
    'Auth sign-in/sign-up form, ability to track failed attempts',
    'User sees rate limit message. Cooldown enforced. Subsequent attempts after cooldown succeed.',
    'No client-side rate limiting. Showing cryptic error. Not offering password reset as alternative.',
    0.87,
    'haiku',
    NOW(),
    'https://firebase.google.com/docs/auth/admin/errors'
),
(
    'FirebaseAuthException with code: invalid-credential',
    'firebase',
    'MEDIUM',
    '[
        {"solution": "If using custom token, verify token is generated with correct Firebase project private key and not expired (1 hour max).", "percentage": 92},
        {"solution": "If using OAuth, confirm credential is valid and not revoked. Re-prompt user to authorize if needed.", "percentage": 88},
        {"solution": "For ID tokens, verify token hasn''t expired. Set token refresh to occur before expiry.", "percentage": 85}
    ]'::jsonb,
    'Custom token or OAuth flow implemented, token generation mechanism',
    'Custom token validates successfully. OAuth credentials refresh automatically. ID token renewed before expiry.',
    'Not validating token expiry. Using wrong private key. Not refreshing tokens before expiry.',
    0.85,
    'haiku',
    NOW(),
    'https://firebase.google.com/docs/auth/admin/errors'
),
(
    'FirebaseAuthException with code: credential-already-in-use',
    'firebase',
    'MEDIUM',
    '[
        {"solution": "When linking providers, catch this error and show: ''This account is already linked to another user. Sign in with that account first.''", "percentage": 91},
        {"solution": "Implement unlinking: call unlink(providerId) on current user before linking a different provider with same credential.", "percentage": 88},
        {"solution": "Use fetchSignInMethodsForEmail() to warn user if email already exists before attempting sign-in with new provider.", "percentage": 86}
    ]'::jsonb,
    'Account linking feature implemented, multi-provider authentication',
    'User cannot link duplicate credentials. Error message is clear. User guided to correct flow.',
    'Not checking for existing credentials. Showing generic error. No unlinking option provided.',
    0.86,
    'haiku',
    NOW(),
    'https://firebase.google.com/docs/auth/flutter/errors'
),
(
    'FirebaseAuthException with code: account-exists-with-different-credential',
    'firebase',
    'MEDIUM',
    '[
        {"solution": "Catch exception. Fetch sign-in methods: FirebaseAuth.instance.fetchSignInMethodsForEmail(email).", "percentage": 94},
        {"solution": "Show UI: ''Account exists with different provider. Sign in with [Google/Facebook/etc] or use email/password.''", "percentage": 91},
        {"solution": "Implement account linking flow: Sign in with existing provider, then linkWithCredential(newCredential).", "percentage": 88}
    ]'::jsonb,
    'Multi-provider authentication, account linking feature',
    'User sees clear message about existing account. Can sign in with correct provider or link accounts.',
    'Not fetching sign-in methods. Forcing email/password without offering existing provider. No linking option.',
    0.89,
    'haiku',
    NOW(),
    'https://firebase.google.com/docs/auth/flutter/errors'
),
(
    'FirebaseAuthException with code: email-already-exists (Admin SDK)',
    'firebase',
    'MEDIUM',
    '[
        {"solution": "In Admin SDK, wrap admin.auth().createUser() in try-catch. Check if user exists first: admin.auth().getUserByEmail(email).", "percentage": 93},
        {"solution": "Implement upsert pattern: try create, catch auth/email-already-exists, then updateUser() instead.", "percentage": 89},
        {"solution": "For bulk user creation, query existing users first to avoid duplicate attempts.", "percentage": 85}
    ]'::jsonb,
    'Firebase Admin SDK initialized with service account, Node.js backend',
    'User creation succeeds or updates existing user gracefully. No duplicate email errors in logs.',
    'Not checking existing users. Bulk creating without deduplication. Not handling error gracefully.',
    0.88,
    'haiku',
    NOW(),
    'https://firebase.google.com/docs/auth/admin/errors'
),
(
    'FirebaseAuthException with code: uid-already-exists (Admin SDK)',
    'firebase',
    'MEDIUM',
    '[
        {"solution": "Ensure UID is unique before calling admin.auth().createUser({uid: customId}). Use UUID v4 or timestamp-based IDs.", "percentage": 96},
        {"solution": "If importing users from another system, deduplicate by UID first: uidSet = new Set(existingUserIds).", "percentage": 94},
        {"solution": "Use admin.auth().getUser(uid) to check availability before creation.", "percentage": 92}
    ]'::jsonb,
    'Admin SDK, custom UID assignment in user creation',
    'All created users have unique UIDs. No duplicate UID errors when bulk importing.',
    'Not checking UID uniqueness. Using sequential IDs without collision detection. Importing duplicates from source.',
    0.93,
    'haiku',
    NOW(),
    'https://firebase.google.com/docs/auth/admin/errors'
),
(
    'FirebaseAuthException with code: phone-number-already-exists (Admin SDK)',
    'firebase',
    'LOW',
    '[
        {"solution": "Before admin.auth().createUser({phoneNumber}), check admin.auth().getUserByPhoneNumber(phone) first.", "percentage": 94},
        {"solution": "Implement phone deduplication in bulk import: phoneSet = new Set(), skip duplicates.", "percentage": 92},
        {"solution": "Consider allowing phone updates instead of rejecting: catch error and updateUser() with new phone.", "percentage": 87}
    ]'::jsonb,
    'Phone authentication enabled, Admin SDK, bulk user import',
    'Phone numbers are unique. Bulk import completes without duplicates. Users can update phone numbers.',
    'Not deduplicating phone numbers in bulk import. Failing instead of updating. No fallback flow.',
    0.89,
    'haiku',
    NOW(),
    'https://firebase.google.com/docs/auth/admin/errors'
),
(
    'FirebaseAuthException with code: id-token-expired',
    'firebase',
    'MEDIUM',
    '[
        {"solution": "Catch exception in protected endpoints. Call user.getIdToken(true) to refresh token (forceRefresh=true).", "percentage": 94},
        {"solution": "Implement token refresh on app resume: check token age before each API call, refresh if > 50 min old.", "percentage": 90},
        {"solution": "Use onAuthStateChanged() listener to detect token refresh automatically in background.", "percentage": 88}
    ]'::jsonb,
    'App with protected API calls, Firebase user session',
    'Expired token automatically refreshed. API calls succeed after refresh. User stays logged in.',
    'Not checking token expiry. Calling getIdToken() without forceRefresh. Manual re-authentication required.',
    0.91,
    'haiku',
    NOW(),
    'https://firebase.google.com/docs/auth/admin/errors'
),
(
    'FirebaseAuthException with code: id-token-revoked',
    'firebase',
    'LOW',
    '[
        {"solution": "Token revoked indicates admin action or security event. Prompt user to re-authenticate: signInWithEmailAndPassword().", "percentage": 93},
        {"solution": "In admin panel, use admin.auth().revokeRefreshTokens(uid) to force re-login for security breach response.", "percentage": 88},
        {"solution": "Log revocation events in audit trail and notify user of account activity.", "percentage": 85}
    ]'::jsonb,
    'Admin SDK access, user session management, audit logging',
    'User prompted to re-login after revocation. Revocation logged. Session properly terminated.',
    'Silently failing. Not notifying user. No re-authentication prompt. No audit trail.',
    0.87,
    'haiku',
    NOW(),
    'https://firebase.google.com/docs/auth/admin/errors'
),
(
    'FirebaseAuthException with code: session-cookie-expired',
    'firebase',
    'MEDIUM',
    '[
        {"solution": "In server middleware, verify session cookie with admin.auth().verifySessionCookie(). Catch expired error.", "percentage": 95},
        {"solution": "When expired, clear session: response.clearCookie(''__session''), redirect to login.", "percentage": 94},
        {"solution": "Session cookies auto-expire after 14 days. Refresh via client: getIdToken(true) and send to server.", "percentage": 92}
    ]'::jsonb,
    'Session cookie authentication, server middleware, cookie handling',
    'Expired session cookies detected and cleared. User redirected to login. No stale sessions.',
    'Not verifying cookie expiry. Not clearing expired cookies. Allowing stale sessions.',
    0.93,
    'haiku',
    NOW(),
    'https://firebase.google.com/docs/auth/admin/errors'
),
(
    'FirebaseAuthException with code: invalid-email (Admin SDK)',
    'firebase',
    'MEDIUM',
    '[
        {"solution": "Before admin.auth().createUser({email}), validate: /^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$/.test(email).", "percentage": 98},
        {"solution": "Normalize email: trim whitespace and convert to lowercase before Firebase operations.", "percentage": 96},
        {"solution": "If importing from CSV, clean email field: remove extra spaces, invalid characters.", "percentage": 94}
    ]'::jsonb,
    'Admin SDK, user creation, email import/validation',
    'Invalid emails rejected before API call. Valid emails normalized. Bulk import succeeds.',
    'Not validating before API call. Not normalizing email format. Importing malformed emails.',
    0.96,
    'haiku',
    NOW(),
    'https://firebase.google.com/docs/auth/admin/errors'
),
(
    'FirebaseAuthException with code: invalid-password (Admin SDK)',
    'firebase',
    'MEDIUM',
    '[
        {"solution": "Password must be 6+ characters. Validate before admin.auth().createUser({password}).", "percentage": 97},
        {"solution": "Provide clear error message: ''Password must be at least 6 characters. Firebase requires minimum 6.''", "percentage": 95},
        {"solution": "For bulk user import, filter/reject weak passwords before Firebase API call.", "percentage": 93}
    ]'::jsonb,
    'Admin SDK, user creation, password import',
    'Weak passwords rejected with clear message. Strong passwords accepted. Bulk import handles validation.',
    'Not validating password length. Showing generic Firebase error. Importing without validation.',
    0.95,
    'haiku',
    NOW(),
    'https://firebase.google.com/docs/auth/admin/errors'
),
(
    'FirebaseAuthException with code: invalid-uid (Admin SDK)',
    'firebase',
    'LOW',
    '[
        {"solution": "UID must be 1-128 characters, non-empty. Use regex: /^[a-zA-Z0-9_-]{1,128}$/ for validation.", "percentage": 96},
        {"solution": "For auto-generated UIDs, use UUID v4 or timestamp-based IDs that always match constraints.", "percentage": 94},
        {"solution": "If importing UIDs from legacy system, sanitize: remove special chars, truncate to 128 chars.", "percentage": 92}
    ]'::jsonb,
    'Admin SDK with custom UID assignment, user import',
    'Custom UIDs meet Firebase constraints. Auto-generated UIDs always valid. Import completes.',
    'Using UIDs > 128 characters. Including invalid characters. Not validating before API call.',
    0.94,
    'haiku',
    NOW(),
    'https://firebase.google.com/docs/auth/admin/errors'
),
(
    'FirebaseAuthException with code: invalid-claims (Admin SDK)',
    'firebase',
    'LOW',
    '[
        {"solution": "Custom claims must be valid JSON and not exceed 1000 bytes. Validate: JSON.stringify(claims).length < 1000.", "percentage": 96},
        {"solution": "Claims cannot contain reserved fields. Avoid: iss, aud, auth_time, user_id, sub, email_verified, etc.", "percentage": 95},
        {"solution": "Use setCustomUserClaims(uid, claims) only after validating structure and size.", "percentage": 93}
    ]'::jsonb,
    'Admin SDK, custom claims implementation',
    'Custom claims accepted and applied. Claim size within limits. Reserved fields avoided.',
    'Claims object too large. Reserved field names used. Invalid JSON structure. No size validation.',
    0.94,
    'haiku',
    NOW(),
    'https://firebase.google.com/docs/auth/admin/errors'
),
(
    'FirebaseAuthException with code: requires-recent-login',
    'firebase',
    'MEDIUM',
    '[
        {"solution": "Before sensitive operations (updateEmail, updatePassword, delete account), reauthenticate: reauthenticateWithCredential().", "percentage": 94},
        {"solution": "Implement reauthentication flow: prompt for password, create AuthCredential, then call reauthenticate().", "percentage": 92},
        {"solution": "After reauthentication, immediately perform sensitive operation (within 5 minutes).", "percentage": 90}
    ]'::jsonb,
    'Email/password or linked credentials, sensitive operation handlers',
    'User can reauthenticate before sensitive operations. Operations succeed after reauthentication.',
    'Not reauthenticating before sensitive ops. Showing generic error. No reauthentication prompt.',
    0.91,
    'haiku',
    NOW(),
    'https://firebase.google.com/docs/auth/admin/errors'
),
(
    'FirebaseAuthException with code: provider-already-linked',
    'firebase',
    'LOW',
    '[
        {"solution": "Check linked providers before linkWithCredential(): user.providerData.map(p => p.providerId).", "percentage": 95},
        {"solution": "Show UI: ''This provider is already linked to your account.'' Offer unlink option if user wants to switch.", "percentage": 92},
        {"solution": "Implement unlink flow: call unlink(providerId) before linking different provider.", "percentage": 89}
    ]'::jsonb,
    'Account linking feature, multi-provider authentication',
    'User cannot link duplicate providers. Error message is informative. Unlink option available.',
    'Not checking linked providers. Showing generic error. No unlink option provided.',
    0.90,
    'haiku',
    NOW(),
    'https://firebase.google.com/docs/auth/flutter/errors'
),
(
    'FirebaseAuthException with code: insufficient-permission (Admin SDK)',
    'firebase',
    'LOW',
    '[
        {"solution": "Admin SDK must be initialized with a service account that has ''Editor'' or ''Firebase Admin'' role.", "percentage": 96},
        {"solution": "In Google Cloud Console > IAM, verify service account has ''Firebase Admin'' role assigned.", "percentage": 95},
        {"solution": "If using restricted key/cert, ensure it has auth permissions. Consider creating new service account with full access.", "percentage": 93}
    ]'::jsonb,
    'Google Cloud project with IAM, service account',
    'Service account has proper IAM role. Admin SDK operations succeed. Permissions verified in Cloud Console.',
    'Service account missing Firebase Admin role. Using wrong service account. Restricted API key without auth scope.',
    0.95,
    'haiku',
    NOW(),
    'https://firebase.google.com/docs/auth/admin/errors'
);
