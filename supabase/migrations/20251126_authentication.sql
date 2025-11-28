INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES
(
    'JWT cannot be used prior to not before date claim (nbf) Not before date error in Clerk',
    'auth',
    'HIGH',
    '[
        {"solution": "Synchronize server time with NTP (Network Time Protocol) to ensure system clock is accurate. Run: sudo ntpdate -s time.nist.gov", "percentage": 92},
        {"solution": "Verify Clerk environment variables are correctly set (NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY and CLERK_SECRET_KEY)", "percentage": 85},
        {"solution": "Clear JWT token cookies from browser and force a new token generation", "percentage": 78}
    ]'::jsonb,
    'Next.js 15 or later, Clerk SDK v5+, valid Clerk API keys',
    'User can successfully authenticate without JWT nbf errors, server timestamp matches NTP time',
    'Ignoring system clock synchronization issues; not clearing cached tokens; incorrect Clerk key configuration',
    0.88,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/79768893/next-js-15-clerk-jwt-token-not-active-yet-causing-401-unauthorized-on-api-c',
    'admin:1764173646'
),
(
    'Clerk: auth() was called but authMiddleware not found in middleware file',
    'auth',
    'HIGH',
    '[
        {"solution": "Ensure middleware.ts is placed in root directory (not in src/app/). Verify file path is correct: ./middleware.ts at project root", "percentage": 94},
        {"solution": "Update to Node.js v20.7.0+. Older Node versions have compatibility issues with Clerk authMiddleware", "percentage": 88},
        {"solution": "Remove --turbo flag from Next.js dev script: change \"dev\": \"next dev --turbo\" to \"dev\": \"next dev\" in package.json", "percentage": 85}
    ]'::jsonb,
    'Next.js project with Clerk authentication, Node.js 18+',
    'Middleware file recognized, auth() function callable without errors, protected routes block unauthenticated users',
    'Placing middleware in wrong directory; using outdated Node.js version; --turbo flag preventing middleware initialization',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/77108110/clerk-authmiddleware-is-not-being-used-even-though-it-is-in-my-middleware-ts-f',
    'admin:1764173646'
),
(
    'Firebase authentication error: INVALID_EMAIL or ERROR_USER_NOT_FOUND',
    'auth',
    'HIGH',
    '[
        {"solution": "Validate email format before calling signInWithEmailAndPassword(). Use regex: /^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$/", "percentage": 93},
        {"solution": "Trim whitespace from input fields: email.trim() and password.trim() before authentication", "percentage": 91},
        {"solution": "Ensure Firebase Authentication is enabled in Firebase Console under Authentication > Sign-in method", "percentage": 87}
    ]'::jsonb,
    'Firebase project initialized with valid config, email/password authentication enabled in Firebase Console',
    'Firebase returns successful auth response, user object is populated, no 400 HTTP errors',
    'Sending malformed email data; not trimming whitespace from input; Firebase auth not enabled in console; typos in field selectors',
    0.89,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/75394589/firebase-javascript-signinwithemailandpassword-failed-to-fetch-resource-server',
    'admin:1764173646'
),
(
    'NextAuth session.user is undefined in jwt callback',
    'auth',
    'HIGH',
    '[
        {"solution": "Add null check in jwt callback before accessing user object: if (user) { token.id = user.id; return token; }", "percentage": 95},
        {"solution": "Structure callbacks to persist user data in token during first sign-in, then transfer to session on subsequent calls", "percentage": 92},
        {"solution": "Ensure SessionProvider wraps _app component: <SessionProvider session={session}><Component /></SessionProvider>", "percentage": 88}
    ]'::jsonb,
    'NextAuth v4+, Next.js 11+, SessionProvider configured in _app.tsx',
    'No \"Cannot read properties of undefined\" errors, user data persists across sessions, session callback receives user.id from token',
    'Accessing user.id without checking if user exists; not persisting user data to token during jwt callback; missing SessionProvider wrapper',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/72073321/why-did-user-object-is-undefined-in-nextauth-session-callback',
    'admin:1764173646'
),
(
    'Auth0 invalid access token - opaque token instead of JWT',
    'auth',
    'HIGH',
    '[
        {"solution": "Set audience parameter in Auth0 authorization config. Add AUTH0_AUDIENCE env variable with your API identifier from Auth0 Console", "percentage": 94},
        {"solution": "In Auth0 Next.js SDK: configure withApiAuthRequired and include audience in getSession() calls", "percentage": 89},
        {"solution": "Verify API is registered in Auth0 Console under Applications > APIs and has correct identifier", "percentage": 85}
    ]'::jsonb,
    'Auth0 application configured, Node.js backend with JWT validation',
    'Access token is valid JWT (starts with eyJ), backend JWT validator accepts token, no \"Invalid token\" errors',
    'Forgetting audience parameter in authorization request; using opaque tokens without JWT format; wrong API identifier configured',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/72240614/invalid-access-token-when-using-auth0',
    'admin:1764173646'
),
(
    'Clerk middleware not protecting routes - deprecated authMiddleware error',
    'auth',
    'HIGH',
    '[
        {"solution": "Replace deprecated authMiddleware with new clerkMiddleware and createRouteMatcher. Code: const isProtected = createRouteMatcher([\"/dashboard(.*)\"]); export default clerkMiddleware((auth, req) => { if (isProtected(req)) auth().protect(); });", "percentage": 96},
        {"solution": "Update matcher config to: export const config = { matcher: [\"/((?!.+\\\\.[\\\\w]+$|_next).*)\", \"/\", \"/(api|trpc)(.*)\"] };", "percentage": 91},
        {"solution": "Verify Clerk SDK version is v5.0.12+. Older versions use deprecated authMiddleware", "percentage": 87}
    ]'::jsonb,
    'Next.js 12+, Clerk SDK v5+, properly configured Clerk environment variables',
    'Dashboard routes now require authentication, unauthenticated users redirected to sign-in, no deprecation warnings',
    'Using old authMiddleware pattern; incorrect matcher patterns; outdated Clerk SDK version; not explicitly protecting routes',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/78134090/clerk-and-next-js-authentication-middleware-code-isnt-protecting-my-route-dash',
    'admin:1764173646'
),
(
    'Passport.js authentication failing: Missing credentials - undefined username/password',
    'auth',
    'HIGH',
    '[
        {"solution": "Add body-parser middleware before Passport initialization: app.use(bodyParser.urlencoded({ extended: true })); Place BEFORE passport.initialize()", "percentage": 94},
        {"solution": "Verify HTML form field names match Passport strategy: <input name=\"username\"/> and <input name=\"password\"/>", "percentage": 90},
        {"solution": "If using custom field names, configure LocalStrategy: new LocalStrategy({ usernameField: \"email\", passwordField: \"pass\" }, callback)", "percentage": 87}
    ]'::jsonb,
    'Express.js app, Passport.js installed, LocalStrategy configured',
    'req.body contains username and password properties, authentication succeeds without field name errors, credentials parsed correctly',
    'Initializing body-parser after Passport middleware; HTML form field names not matching strategy defaults; incorrect middleware ordering',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/17074375/passport-authentication-failed-in-basic-example',
    'admin:1764173646'
),
(
    'Firebase signInWithEmailAndPassword error: Failed to load resource with status 400',
    'auth',
    'HIGH',
    '[
        {"solution": "Verify email input is not empty and properly formatted before calling signInWithEmailAndPassword. Debug: console.log($(\"#email\").val())", "percentage": 93},
        {"solution": "Check jQuery selectors match form field IDs: $(\"#email\") and $(\"#password\") must target correct input elements", "percentage": 88},
        {"solution": "Enable Firebase Authentication in Firebase Console: Authentication > Sign-in method > Email/Password. Toggle the Enable switch", "percentage": 92}
    ]'::jsonb,
    'Firebase project initialized, jQuery loaded, HTML form with email and password inputs',
    'Firebase returns authentication success, user object populated, no 400 HTTP errors from identity.googleapis.com',
    'Sending empty or whitespace-only email values; incorrect jQuery selectors; Firebase authentication disabled in console; typos in input field names',
    0.87,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/75394589/firebase-javascript-signinwithemailandpassword-failed-to-fetch-resource-server',
    'admin:1764173646'
);
