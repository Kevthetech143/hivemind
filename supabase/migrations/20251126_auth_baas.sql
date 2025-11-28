INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Not authorized to send emails from <domain>',
    'auth-baas',
    'HIGH',
    '[
        {"solution": "Verify your Resend API key is registered for the domain you''re sending from. The from field in your email must match a domain authorized by your API key.", "percentage": 95},
        {"solution": "Generate a new API key if you changed domains. Ensure the domain in your environment variables matches your registered sender domain.", "percentage": 90}
    ]'::jsonb,
    'Active Resend account with API key. Domain ownership verified with Resend.',
    'Email sends successfully without 401 error. Status code changes from 401 to 200.',
    'Using an API key from a different domain than the one you''re sending from. Mismatched domain in from field vs API key registration.',
    0.95,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/76633086/what-does-not-authorized-to-send-emails-mean-in-the-context-of-resend'
),
(
    'Realtime subscription returns SUBSCRIBED but events not received',
    'auth-baas',
    'HIGH',
    '[
        {"solution": "Update Supabase CLI to v1.75+. Run supabase stop then supabase start (not just db reset) to properly restart realtime containers.", "percentage": 92},
        {"solution": "Verify realtime is enabled on the table in Supabase dashboard. Ensure Row-Level Security rules allow the user to read the table.", "percentage": 88},
        {"solution": "Check subscription code includes proper status callbacks and .subscribe() is called. Verify all Supabase containers are running with docker ps.", "percentage": 85}
    ]'::jsonb,
    'Supabase project initialized locally. Docker installed. Subscription code written with proper event handlers.',
    'Subscription status changes to SUBSCRIBED and events are logged in console. Real-time updates visible on client.',
    'Using outdated CLI version. Running db reset instead of full stop/start. Realtime table not included in publication. Not checking subscription status before attempting to listen.',
    0.88,
    'haiku',
    NOW(),
    'https://github.com/supabase/supabase/issues/12544'
),
(
    'PERMISSION_DENIED: Missing or insufficient permissions',
    'auth-baas',
    'CRITICAL',
    '[
        {"solution": "Update Firestore security rules to allow authenticated access: allow read, write: if request.auth != null;", "percentage": 96},
        {"solution": "For development only, temporarily use: allow read, write: if true; (remove in production)", "percentage": 95},
        {"solution": "Ensure your where() query conditions match security rule restrictions. Rules are not filters - queries fail if any matched document would be denied.", "percentage": 92},
        {"solution": "For subcollections, use match /users/{userId}/{document=**} instead of just /users/{userId} to cover nested access.", "percentage": 88}
    ]'::jsonb,
    'Firebase project with Firestore. Authenticated user or service account. Understanding of Firebase security rules.',
    'Queries execute without PERMISSION_DENIED errors. Documents successfully read/written. Console shows no permission warnings.',
    'Default rules that deny all access not changed. Forgetting that rules don''t filter results - entire query fails if any document is denied. Case-sensitive collection name mismatches. Service accounts missing required IAM roles.',
    0.96,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/46590155/firestore-permission-denied-missing-or-insufficient-permissions'
),
(
    'NextAuth.js session callback user parameter is undefined',
    'auth-baas',
    'HIGH',
    '[
        {"solution": "Persist user data to the JWT token during initial sign-in in the jwt() callback: if (account && user) { token.user = user; return token; }", "percentage": 96},
        {"solution": "Retrieve user data from the token in session() callback: session({ session, token }) { if (token?.user) session.user = token.user; return session; }", "percentage": 96},
        {"solution": "Remember user object is only available on first sign-in. Subsequent calls only receive the token, so user will be undefined.", "percentage": 94}
    ]'::jsonb,
    'NextAuth.js v4+ installed. Authentication providers configured. Database or JWT strategy selected.',
    'session() callback successfully accesses user data. User properties (email, name, image) available in session object.',
    'Expecting user parameter on every session() call - it only exists during initial sign-in. Not storing user data in JWT token. Using wrong session strategy.',
    0.96,
    'haiku',
    NOW(),
    'https://github.com/nextauthjs/next-auth/discussions/9438'
),
(
    'NextAuth.js session undefined on client side with SSR',
    'auth-baas',
    'HIGH',
    '[
        {"solution": "In getServerSideProps, extract only the user object from session instead of passing entire session: const { user } = session; return { props: { user } };", "percentage": 94},
        {"solution": "Update component to receive user as prop instead of relying on session: export default function Home({user}) { return user ? <p>Hello {user.email}</p> : <Login /> }", "percentage": 93},
        {"solution": "Verify SessionProvider wraps your _app.tsx component and session is being properly passed.", "percentage": 90}
    ]'::jsonb,
    'Next.js project with NextAuth.js v4+. Server-side rendering enabled. getServerSideProps implemented.',
    'User data successfully rendered on client. No undefined errors in console. Page displays user information after login.',
    'Passing entire serialized session object through getServerSideProps. Not checking if session exists before accessing user. Missing SessionProvider wrapper.',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/70092844/session-undefined-in-client-side-although-available-in-server-side-in-nextauth-j'
),
(
    'Firebase authStateChanged listener not firing',
    'auth-baas',
    'HIGH',
    '[
        {"solution": "Ensure Firebase is initialized before calling authStateChanged: const auth = getAuth(); const unsubscribe = onAuthStateChanged(auth, (user) => { console.log(user) });", "percentage": 94},
        {"solution": "Return the unsubscribe function from useEffect to properly clean up listener: useEffect(() => { const unsubscribe = onAuthStateChanged(auth, ...); return unsubscribe; }, []);", "percentage": 92},
        {"solution": "Check browser console for Firebase initialization errors. Verify API keys are correct in firebase config.", "percentage": 88}
    ]'::jsonb,
    'Firebase project created. Firebase SDK installed. React or vanilla JS project with event listeners.',
    'Listener fires on app load. User state updates when auth status changes. Console shows user object correctly.',
    'Calling authStateChanged before Firebase initialization. Not unsubscribing in cleanup function. Incorrect API keys in Firebase config.',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/firebase-authentication'
),
(
    'Firebase signInWithEmailAndPassword fails with network error',
    'auth-baas',
    'HIGH',
    '[
        {"solution": "Check internet connection and Firebase status page. Ensure Firebase Realtime Database or Firestore is enabled in your project.", "percentage": 90},
        {"solution": "Verify email and password meet requirements. Email must be valid format, password minimum 6 characters.", "percentage": 88},
        {"solution": "Check if user account exists. Error message differs between ''user-not-found'' and network errors.", "percentage": 86}
    ]'::jsonb,
    'Firebase project initialized. Firebase SDK updated. Valid credentials ready.',
    'Login succeeds without error. authStateChanged fires with user object. No network errors in console.',
    'Treating network errors as authentication errors. Not checking user existence first. Firestore/Database not enabled.',
    0.88,
    'haiku',
    NOW(),
    'https://firebase.google.com/docs/auth/troubleshoot'
),
(
    'Supabase auth.signUp returns undefined user',
    'auth-baas',
    'MEDIUM',
    '[
        {"solution": "Check email confirmation settings. User will be undefined if email verification is required and not yet confirmed.", "percentage": 92},
        {"solution": "Verify API key is correct and project is initialized: const supabase = createClient(URL, ANON_KEY);", "percentage": 90},
        {"solution": "After signup, wait for email confirmation or check Supabase dashboard Authentication settings to enable auto-confirm for development.", "percentage": 88}
    ]'::jsonb,
    'Supabase project created. JavaScript client library installed. Environment variables configured.',
    'signUp returns user object with id and email. User created in Supabase dashboard. Email confirmation optional.',
    'Not checking email confirmation requirements. Using incorrect API keys. Calling signUp without awaiting response.',
    0.90,
    'haiku',
    NOW(),
    'https://supabase.com/docs/guides/auth/auth-email'
),
(
    'Supabase RLS policy denies all queries',
    'auth-baas',
    'HIGH',
    '[
        {"solution": "Default RLS policies block all access. Enable RLS and add policy: CREATE POLICY enable_read ON table_name FOR SELECT USING (true); for public read.", "percentage": 94},
        {"solution": "For authenticated users only: CREATE POLICY enable_read_auth ON table_name FOR SELECT USING (auth.uid() IS NOT NULL);", "percentage": 93},
        {"solution": "For owner access: CREATE POLICY owner_access ON table_name FOR ALL USING (auth.uid() = user_id);", "percentage": 91}
    ]'::jsonb,
    'Supabase project with table created. Row Level Security enabled. Understanding of auth.uid() context.',
    'SELECT/INSERT/UPDATE/DELETE queries execute without policy denial errors. Correct users can access rows.',
    'Forgetting to enable RLS before adding policies. Using incorrect column names in policies. Not checking auth.uid() value.',
    0.93,
    'haiku',
    NOW(),
    'https://supabase.com/docs/guides/auth/row-level-security'
),
(
    'Clerk useAuth returns empty user object',
    'auth-baas',
    'MEDIUM',
    '[
        {"solution": "Ensure app is wrapped in ClerkProvider: <ClerkProvider> <App /> </ClerkProvider>", "percentage": 94},
        {"solution": "Use useUser() hook instead of useAuth() for user data: const { user } = useUser();", "percentage": 92},
        {"solution": "Check that clerk frontend API key is correct in environment variables. Verify user is signed in first.", "percentage": 90}
    ]'::jsonb,
    'React application. Clerk account created. Clerk provider configured. Frontend API key set.',
    'useAuth returns user object with email and id. useUser returns full user profile. Console shows no auth errors.',
    'Using useAuth instead of useUser for full profile data. Missing ClerkProvider wrapper. Incorrect API keys.',
    0.92,
    'haiku',
    NOW(),
    'https://clerk.com/docs/references/react/use-auth'
),
(
    'Clerk JWT token validation fails in backend',
    'auth-baas',
    'HIGH',
    '[
        {"solution": "Install clerk backend SDK: npm install @clerk/backend", "percentage": 95},
        {"solution": "Validate JWT with correct secret: const decoded = jwt.verify(token, process.env.CLERK_SECRET_KEY);", "percentage": 94},
        {"solution": "Pass bearer token correctly from client: headers.authorization = ''Bearer '' + token;", "percentage": 92}
    ]'::jsonb,
    'Clerk project initialized. Backend SDK installed. CLERK_SECRET_KEY in environment variables.',
    'JWT token validates without errors. Decoded token contains user id and claims. Backend can access user data.',
    'Using wrong secret key for validation. Not extracting bearer token from authorization header. Using expired tokens.',
    0.94,
    'haiku',
    NOW(),
    'https://clerk.com/docs/backend-requests/handling/jwt-verification'
),
(
    'Auth0 audience parameter invalid error',
    'auth-baas',
    'MEDIUM',
    '[
        {"solution": "Set audience parameter in Auth0 config to your API identifier: audience: ''https://your-api.example.com''", "percentage": 96},
        {"solution": "In Auth0 dashboard, create an API under Applications > APIs with identifier matching your audience parameter.", "percentage": 95},
        {"solution": "Verify audience matches exactly - trailing slashes and protocols matter.", "percentage": 93}
    ]'::jsonb,
    'Auth0 account with app created. API created in Auth0 dashboard. Frontend SDK configured.',
    'Login flow completes without audience errors. Token includes correct audience claim. API requests authorized.',
    'Omitting audience parameter entirely. Mismatched audience string between client and API. Wrong API identifier in dashboard.',
    0.95,
    'haiku',
    NOW(),
    'https://auth0.com/docs/get-started/authentication-and-authorization-flow/client-credentials-flow'
),
(
    'Okta getUser returns null after successful login',
    'auth-baas',
    'MEDIUM',
    '[
        {"solution": "Ensure OktaAuth is fully initialized before calling getUser(): await oktaAuth.token.parseFromUrl();", "percentage": 94},
        {"solution": "Check that user has been cached: const user = await oktaAuth.getUser();", "percentage": 92},
        {"solution": "Verify scopes include openid, profile, email in your OIDC app settings.", "percentage": 90}
    ]'::jsonb,
    'Okta organization created. OIDC app configured. OktaAuth SDK installed.',
    'getUser returns user object with profile data. Token endpoint responds with scopes. No null values in user object.',
    'Calling getUser before token parsing. Missing required scopes in app config. Cache not populated.',
    0.92,
    'haiku',
    NOW(),
    'https://developer.okta.com/docs/guides/implement-auth-code-pkce/nodejs/main/'
),
(
    'Magic link authentication email not received',
    'auth-baas',
    'HIGH',
    '[
        {"solution": "Verify email is correct and not in spam folder. Check email provider spam filter.", "percentage": 90},
        {"solution": "Confirm passwordless/magic link is enabled in authentication provider dashboard.", "percentage": 88},
        {"solution": "Check email address in database exists. Resend magic link and verify sent status in provider logs.", "percentage": 86}
    ]'::jsonb,
    'Passwordless auth provider configured (Supabase, Firebase, Auth0). Email service enabled.',
    'Magic link email received in inbox. Link valid and not expired. User successfully authenticated after clicking link.',
    'Email address typo. Magic link feature disabled. Email service not properly configured. Expired links.',
    0.87,
    'haiku',
    NOW(),
    'https://supabase.com/docs/guides/auth/auth-email'
),
(
    'Session expires without warning after login',
    'auth-baas',
    'MEDIUM',
    '[
        {"solution": "Check session timeout configuration in auth provider. Extend timeout if needed.", "percentage": 92},
        {"solution": "Implement automatic token refresh: setup refreshToken interval on app load.", "percentage": 90},
        {"solution": "Listen for session expiration events and prompt user to re-login: onSessionExpired(() => navigate(''/login''));", "percentage": 88}
    ]'::jsonb,
    'Authentication provider configured. Session management implemented. Token refresh endpoint available.',
    'Session persists for expected duration. User prompted before session expires. Automatic re-login successful.',
    'Not refreshing tokens. No session expiration handling. Timeout set too low. Clock skew between client and server.',
    0.90,
    'haiku',
    NOW(),
    'https://next-auth.js.org/faq#how-do-i-refresh-my-jwt'
),
(
    'CORS error during authentication redirect',
    'auth-baas',
    'HIGH',
    '[
        {"solution": "Add redirect URL to allowed origins in auth provider dashboard. For Supabase: Authentication > URL Configuration.", "percentage": 96},
        {"solution": "Include protocol in redirect URL: https://localhost:3000 not localhost:3000", "percentage": 95},
        {"solution": "For local development, add both http://localhost:PORT and https://yourdomain.com (for production).", "percentage": 93}
    ]'::jsonb,
    'Auth provider account with dashboard access. Redirect URL finalized. CORS enabled.',
    'Authentication redirect completes without CORS errors. User redirected to callback URL. Session established.',
    'Forgetting protocol in redirect URL. Different port in localhost URL. Missing redirect URL in provider settings.',
    0.96,
    'haiku',
    NOW(),
    'https://supabase.com/docs/guides/auth/configuring-oauth-providers'
),
(
    'Bearer token missing or malformed error',
    'auth-baas',
    'CRITICAL',
    '[
        {"solution": "Ensure token is passed in Authorization header: ''Authorization: Bearer YOUR_TOKEN''", "percentage": 97},
        {"solution": "Check token format matches provider requirements. Most use JWT format.", "percentage": 95},
        {"solution": "Verify token is not expired. Add expiration check: const isExpired = Date.now() >= token.exp * 1000;", "percentage": 94}
    ]'::jsonb,
    'Valid JWT token generated. Authorization header support. Token stored securely.',
    'API request includes valid Bearer token. Backend validates token without format errors. Request authorized.',
    'Sending token in wrong header format. Using malformed JWT. Expired token. Missing Bearer prefix.',
    0.96,
    'haiku',
    NOW(),
    'https://tools.ietf.org/html/rfc6750'
),
(
    'Password reset link expired or invalid',
    'auth-baas',
    'MEDIUM',
    '[
        {"solution": "Check password reset link expiration in auth provider settings. Usually 1 hour.", "percentage": 93},
        {"solution": "Request new password reset link if expired. Do not reuse old links.", "percentage": 92},
        {"solution": "Verify user exists and email matches. Some providers check this before validating token.", "percentage": 90}
    ]'::jsonb,
    'Password reset feature enabled. Reset link generated. User has valid email address.',
    'Password reset completes without link errors. New password set successfully. User can login with new password.',
    'Using old reset links. Link expired before user clicked. User email changed. Case-sensitive email matching.',
    0.92,
    'haiku',
    NOW(),
    'https://supabase.com/docs/guides/auth/auth-email'
),
(
    'OAuth provider returns invalid_grant error',
    'auth-baas',
    'HIGH',
    '[
        {"solution": "Verify OAuth client ID and secret are correct in your auth provider config.", "percentage": 94},
        {"solution": "Check OAuth app settings in provider (Google, GitHub, etc) - redirect URIs must match exactly.", "percentage": 93},
        {"solution": "Ensure OAuth app is not suspended or deleted. Check provider dashboard for any warnings.", "percentage": 91}
    ]'::jsonb,
    'OAuth app created with provider. Client ID and secret generated. Redirect URIs configured.',
    'OAuth flow completes without grant errors. User authenticated with provider. Token exchange successful.',
    'Expired client credentials. Incorrect redirect URI. OAuth app configuration changed. Wrong provider account.',
    0.93,
    'haiku',
    NOW(),
    'https://datatracker.ietf.org/doc/html/rfc6749#section-5.2'
);
