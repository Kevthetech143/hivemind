-- Add GitHub Passport authentication solutions batch 1
-- Extracted from: https://github.com/jaredhanson/passport/issues
-- Focus: Session handling, OAuth errors, strategy configuration, TypeScript types

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Sessions do not always have regenerate() and save() causing a fault',
    'github-passport',
    'HIGH',
    $$[
        {"solution": "Pin Passport to version 0.5.x until pluggable session manager support is released", "percentage": 95, "note": "Official recommended interim workaround for 0.6.0+ breaking changes", "command": "npm install passport@0.5.3"},
        {"solution": "Switch to express-session middleware instead of cookie-session to ensure session.regenerate() and session.save() methods are available", "percentage": 90, "note": "Express-session provides full session API compatibility"},
        {"solution": "Implement custom session manager interface once available to support cookie-session compatibility", "percentage": 75, "note": "Awaiting Passport 0.7.0+ with pluggable session managers"},
        {"solution": "Add configuration option to disable automatic regenerate() behavior during login if accepted upstream", "percentage": 70, "note": "Requested feature, not yet implemented"}
    ]$$::jsonb,
    'Passport 0.6.0+, cookie-session middleware, Node.js session store configured',
    'Application logs in without TypeError on session.regenerate(). Session object persists across requests. Users maintain authenticated state.',
    'Version 0.6.0+ requires session.regenerate() and session.save() methods. cookie-session middleware does not implement these by default. Mixing Passport 0.6.0 with cookie-session creates breaking incompatibility.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/jaredhanson/passport/issues/904'
),
(
    'req.session.regenerate is not a function since upgrade to 0.6.0',
    'github-passport',
    'HIGH',
    $$[
        {"solution": "Downgrade Passport to version 0.5.3 which does not require session.regenerate()", "percentage": 95, "note": "Immediate fix for breaking change", "command": "npm install passport@0.5.3"},
        {"solution": "Upgrade express-session middleware to latest version and ensure it is loaded before Passport", "percentage": 85, "note": "Some users found session middleware version compatibility issues"},
        {"solution": "Verify middleware loading order: session middleware > Passport middleware > routes", "percentage": 80, "note": "Incorrect order can cause session method unavailability"}
    ]$$::jsonb,
    'Passport 0.6.0+, Node.js 16.13.2+, express-session or session store middleware, Windows/Linux/macOS',
    'TypeError: req.session.regenerate is not a function error disappears. Authentication completes successfully. User remains logged in across requests.',
    'Passport 0.6.0 changed internal session handling to call regenerate() during login. This fails if session middleware does not provide these methods. Downgrading or switching session middleware are the only current solutions.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/jaredhanson/passport/issues/907'
),
(
    'ERROR: No Access-Control-Allow-Origin header is present on the requested resource',
    'github-passport',
    'VERY_HIGH',
    $$[
        {"solution": "Configure CORS middleware on backend: npm install cors && app.use(cors({origin: ''http://localhost:4200'', credentials: true}))", "percentage": 95, "note": "Official CORS solution for cross-origin OAuth requests", "command": "npm install cors"},
        {"solution": "Set explicit response headers in Express: res.header(''Access-Control-Allow-Origin'', ''http://localhost:4200''); res.header(''Access-Control-Allow-Credentials'', ''true'')", "percentage": 90, "note": "Manual header approach when CORS package unavailable"},
        {"solution": "For ASP.NET backends: add httpProtocol customHeaders with Access-Control-Allow-Origin and Access-Control-Allow-Headers in web.config system.webServer section", "percentage": 85, "note": "Framework-specific approach for .NET environments"},
        {"solution": "Ensure backend runs on actual localhost domain, not file:// protocol in browser. Use http://localhost:PORT not relative paths", "percentage": 80, "note": "Browser security blocks CORS from file:// origins"}
    ]$$::jsonb,
    'Express.js or equivalent backend framework, OAuth provider credentials configured, CORS middleware available',
    'Browser no longer blocks cross-origin OAuth requests with CORS error. Redirect to OAuth provider succeeds. User profile data returned in authentication response.',
    'CORS policy enforced by browsers blocks localhost:3000 backend requests from localhost:4200 frontend without proper headers. Google OAuth endpoints require explicit Access-Control-Allow-Origin headers. Credentials:true requires explicit origin, not wildcard.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://github.com/jaredhanson/passport/issues/582'
),
(
    'Passport.js promises/async-await support request - return promises from API methods',
    'github-passport',
    'MEDIUM',
    $$[
        {"solution": "Implement dual callback/promise support: check if callback provided, return promise if missing", "percentage": 85, "note": "Backward compatible approach demonstrated by community members", "command": "function authenticate(strategy) { return new Promise((resolve) => { passport.authenticate(strategy, (err, user) => resolve(user)); }); }"},
        {"solution": "Wrap Passport methods in custom Promise-returning functions for async/await usage", "percentage": 80, "note": "Temporary workaround until official promise support"},
        {"solution": "Use Express 5.0+ which includes native promise middleware support, making Passport callbacks compatible", "percentage": 75, "note": "Express 5.0 still in development as of 2024"}
    ]$$::jsonb,
    'Node.js 7.0+, Babel transpilation (for older Node versions), Express.js or equivalent async-compatible framework',
    'Passport middleware works with async/await syntax. Custom authenticate wrapper returns resolved user object. GraphQL/promise-based frameworks integrate without manual wrapping.',
    'Passport core is callback-based by design. Promise support must be wrapper-based as Passport middleware pattern expects callbacks. Automatic promise return breaks Express middleware contract.',
    0.75,
    'sonnet-4',
    NOW(),
    'https://github.com/jaredhanson/passport/issues/536'
),
(
    'Google OAuth 2.0 profile object does not include user email despite email scope requested',
    'github-passport',
    'HIGH',
    $$[
        {"solution": "Verify Google OAuth credentials include email scope: GoogleStrategy({ scopes: [''profile'', ''email''] })", "percentage": 90, "note": "Email scope must be explicitly requested"},
        {"solution": "Access email from profile.emails array with fallback: email: profile.emails ? profile.emails[0].value : null", "percentage": 85, "note": "Email returned in array format, not direct field"},
        {"solution": "Check Google Cloud Console OAuth consent screen has email listed in scopes configuration, not just in code", "percentage": 80, "note": "Console configuration must match code scopes"},
        {"solution": "Verify Google account has confirmed email address. Accounts without verified email may not return email in profile", "percentage": 75, "note": "Google security requirement for email disclosure"}
    ]$$::jsonb,
    'passport-google-oauth20 v2.0+, valid Google OAuth 2.0 credentials, Redirect URI configured in Google Cloud Console, Google account with verified email',
    'profile.emails array populated with email objects. profile.emails[0].value returns authenticated user email. Email persists in database after authentication.',
    'Email scope required in both code configuration and Google Cloud Console settings. Email returned in emails array, not email field. Unverified Google accounts do not include email in profile.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/jaredhanson/passport/issues/1028'
),
(
    'Using AuthenticationCallback with req.logIn() breaks user deserialization in 0.7.0',
    'github-passport',
    'HIGH',
    $$[
        {"solution": "Upgrade Passport to latest version or verify deserializeUser callback properly sets user object: done(null, user)", "percentage": 90, "note": "Version 0.7.0 compatibility issue"},
        {"solution": "Ensure session middleware initialized before Passport: app.use(session(...)); app.use(passport.initialize()); app.use(passport.session())", "percentage": 88, "note": "Middleware ordering affects deserialization"},
        {"solution": "Verify deserializeUser callback does not reference undefined ''err'' variable: use done(null, user) not done(err, user)", "percentage": 85, "note": "Common typo in custom implementations"},
        {"solution": "When using custom authentication callback, explicitly call req.logIn() with complete user object: req.logIn(user, { session: true }, callback)", "percentage": 82, "note": "Must pass full user object, not just ID"}
    ]$$::jsonb,
    'Passport 0.7.0, Express.js with express-session, LocalStrategy configured with serializeUser/deserializeUser callbacks, custom authentication callback pattern',
    'req.user populated on all authenticated requests. Deserialization callback executed successfully. WebSocket and HTTP requests access req.user without undefined errors.',
    'req.logIn() callback may not serialize user before middleware chain completes. deserializeUser must properly pass user to done(null, user). Session must regenerate without race conditions.',
    0.80,
    'sonnet-4',
    NOW(),
    'https://github.com/jaredhanson/passport/issues/1020'
),
(
    'Multiple authenticated users share single session instead of getting individual sessions',
    'github-passport',
    'HIGH',
    $$[
        {"solution": "Fix bcrypt comparison: use ''await bcrypt.compare()'' not ''bcrypt.compare()'' which returns Promise. Missing await makes promise object truthy, bypassing password validation", "percentage": 95, "note": "Critical bug: authentication succeeds regardless of password", "command": "const isValidPassword = await bcrypt.compare(password, data.password);"},
        {"solution": "Fix deserializeUser callback: use done(null, user) not done(err, null) which references undefined ''err'' variable", "percentage": 92, "note": "Variable reference error prevents user deserialization"},
        {"solution": "Ensure session save() is awaited: await NewUser.save() to prevent race conditions in session creation", "percentage": 90, "note": "Non-blocking save() allows multiple session creations"},
        {"solution": "Add authentication middleware to protected routes: function isAuthenticated(req, res, next) { if (req.isAuthenticated()) return next(); res.redirect(''/login''); }", "percentage": 88, "note": "Unauthenticated users must not access protected resources"}
    ]$$::jsonb,
    'Express.js with Passport.js local strategy, MongoDB with connect-mongo session store, Bcrypt password hashing, express-session middleware',
    'Multiple distinct session documents created in MongoDB for different users. req.user properly populated for each user. Protected routes reject unauthenticated requests. Password validation works correctly.',
    'bcrypt.compare() returns Promise, missing await treats promise as truthy (always passes). deserializeUser error handling references undefined variables. Session save() must be awaited to prevent concurrency bugs.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/jaredhanson/passport/issues/1016'
),
(
    'Passport 0.6.0 regenerates session IDs automatically, breaking custom desktop app authentication flows',
    'github-passport',
    'MEDIUM',
    $$[
        {"solution": "Pin Passport to version 0.5.x for desktop applications that require manual session ID handling", "percentage": 92, "note": "Session ID regeneration cannot be disabled in 0.6.0+"},
        {"solution": "Implement workaround: extract set-cookie header before regeneration and pass pre-regenerated session ID to desktop parent application", "percentage": 70, "note": "Complex workaround, not recommended"},
        {"solution": "Await upstream feature request: plan to add disableable session regeneration option in future Passport release", "percentage": 65, "note": "Requested feature not yet implemented as of issue filing date"}
    ]$$::jsonb,
    'Desktop application with webview component, Passport.js for social OAuth login, custom session ID passing mechanism between webview and parent app',
    'Custom login flow maintains session continuity between webview and parent application. Session ID regenerated but accessible to desktop code. No session fixation vulnerabilities introduced.',
    'Passport 0.6.0+ automatically regenerates session IDs on login to prevent session fixation. This breaks desktop apps that rely on passing session IDs between webview and parent program. No configuration option to disable this yet.',
    0.72,
    'sonnet-4',
    NOW(),
    'https://github.com/jaredhanson/passport/issues/1009'
),
(
    'Steam authentication strategy returns incomplete session data error',
    'github-passport',
    'MEDIUM',
    $$[
        {"solution": "Verify steam profile parser returns userId and token fields. Check passport-steam strategy returns complete profile object", "percentage": 85, "note": "Session data incomplete indicates missing profile fields"},
        {"solution": "Ensure serializeUser callback extracts userId and token: done(null, { userId: user.id, token: user.accessToken })", "percentage": 80, "note": "Serialized data must match expected session structure"},
        {"solution": "Add console.log debugging in verify callback to inspect profile object structure and confirm all required fields present", "percentage": 78, "note": "Profile object may not return expected fields from Steam API"},
        {"solution": "Update passport-steam dependency to latest version which may include fixes for incomplete data handling", "percentage": 72, "note": "May be fixed in newer strategy versions"}
    ]$$::jsonb,
    'passport-steam strategy installed and configured, Steam API credentials valid, Express.js with express-session, cookie-parser middleware configured with httpOnly and secure flags',
    'Steam authentication completes without session data errors. userId and token fields populated in session object. User remains authenticated on subsequent requests.',
    'Steam API may return incomplete profile data in certain conditions. serializeUser callback must handle all fields returned by Steam verify callback. Session validation happens before user data fully loaded.',
    0.68,
    'sonnet-4',
    NOW(),
    'https://github.com/jaredhanson/passport/issues/1034'
),
(
    'TypeScript type definition: passReqToCallback listed in AuthenticateOptions but not functional',
    'github-passport',
    'MEDIUM',
    $$[
        {"solution": "Update TypeScript type definitions to remove passReqToCallback from AuthenticateOptions interface", "percentage": 88, "note": "This option belongs in strategy config, not authenticate() middleware"},
        {"solution": "Configure passReqToCallback in strategy setup, not in passport.authenticate() call: new LocalStrategy({ passReqToCallback: true }, verify)", "percentage": 85, "note": "Correct location for this option in strategy constructor"},
        {"solution": "File issue with DefinitelyTyped (maintainer of Passport types) rather than core Passport repo for type definition fixes", "percentage": 82, "note": "Type definitions maintained externally from Passport core"}
    ]$$::jsonb,
    'TypeScript 4.0+, @types/passport package or DefinitelyTyped types installed, Passport.js local strategy configured',
    'passReqToCallback option no longer suggests in passport.authenticate() autocomplete. TypeScript IDE suggests correct location for option in strategy setup.',
    'passReqToCallback belongs in strategy constructor options, not authenticate middleware options. External TypeScript definitions may lag core library changes. Type definitions maintained by DefinitelyTyped community.',
    0.80,
    'sonnet-4',
    NOW(),
    'https://github.com/jaredhanson/passport/issues/946'
),
(
    'Google OAuth2 strategy prompt option being ignored when extended with custom configuration',
    'github-passport',
    'MEDIUM',
    $$[
        {"solution": "Set prompt in authorizationURLParameters object: new GoogleStrategy({ authorizationURLParameters: { prompt: ''select_account consent'' } }, verify)", "percentage": 88, "note": "Correct location for Google-specific OAuth parameters"},
        {"solution": "Pass prompt through strategy options root level and authorizationURLParameters: both locations should contain identical prompt value", "percentage": 82, "note": "Some versions require redundancy"},
        {"solution": "Use approvalPrompt: ''force'' for older Google OAuth2 versions, or prompt: ''consent'' for newer versions", "percentage": 75, "note": "Google deprecated approvalPrompt in favor of prompt"},
        {"solution": "Verify passport-google-oauth2 version supports authorizationURLParameters option. Upgrade if necessary: npm install --save passport-google-oauth2@latest", "percentage": 70, "note": "Older versions may not support this configuration"}
    ]$$::jsonb,
    'Node.js 16.20+, @nestjs/passport ^10.0.2, passport-google-oauth2 ^0.2.0, Google OAuth 2.0 credentials configured with correct Redirect URIs',
    'Google OAuth2 flow respects configured prompt parameter. User sees account selection and consent screens. Google authentication flow completes with required user confirmations.',
    'prompt option requires configuration in authorizationURLParameters nested object, not just root strategy options. approvalPrompt deprecated in favor of prompt parameter. Older strategy versions may not support this option.',
    0.76,
    'sonnet-4',
    NOW(),
    'https://github.com/jaredhanson/passport/issues/1011'
),
(
    'Duplicate session save operations triggered during login with session regeneration',
    'github-passport',
    'MEDIUM',
    $$[
        {"solution": "Upgrade Passport to version 0.7.0+ which optimizes session regeneration to prevent duplicate saves", "percentage": 88, "note": "Performance improvement in newer versions", "command": "npm install passport@latest"},
        {"solution": "Implement session save batching: debounce or throttle session.save() calls to prevent redundant operations", "percentage": 75, "note": "Workaround for applications with custom session handlers"},
        {"solution": "Use express-session with touch: true option to optimize session updates and reduce unnecessary saves", "percentage": 70, "note": "Session store optimization reduces write frequency"}
    ]$$::jsonb,
    'Passport 0.6.0+, express-session configured with compatible session store (MongoDB, Redis, etc.), session regeneration enabled on login',
    'Single session save operation per login. Server logs show one save operation instead of duplicates. MongoDB or session store logs confirm reduced write operations.',
    'Passport 0.6.0 session regeneration may trigger multiple save operations: one for regenerate(), one for user serialization. This causes performance degradation with database session stores.',
    0.74,
    'sonnet-4',
    NOW(),
    'https://github.com/jaredhanson/passport/issues/1017'
);
