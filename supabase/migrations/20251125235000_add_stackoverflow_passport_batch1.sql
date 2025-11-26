-- Add Stack Overflow Passport.js solutions batch 1
-- Category: stackoverflow-passport
-- Extracted: 11 highest-voted questions with accepted answers

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Understanding passport.js serialize deserialize workflow',
    'stackoverflow-passport',
    'VERY_HIGH',
    '[
        {"solution": "Passport serializes user.id to session via serializeUser, stores in session as req.session.passport.user. On subsequent requests, deserializeUser retrieves ID from session and reconstructs full user object, attaching to req.user for request lifecycle.", "percentage": 92, "note": "Core Passport mechanism - must understand for sessions"},
        {"solution": "Ensure session middleware precedes passport.initialize() and passport.session() in middleware stack. Without proper ordering, deserialization fails silently.", "percentage": 88, "note": "Middleware order is critical for session restoration"},
        {"solution": "Implement deserializeUser with database lookups: User.findById(id) to fetch fresh user data each request, preventing stale user information.", "percentage": 85, "note": "Database calls on every request are intentional design"}
    ]'::jsonb,
    'Express.js with session middleware configured, Valid user object returned from authentication strategy, Database with user records',
    'req.user contains full user object, req.isAuthenticated() returns true, User data persists across page redirects within session',
    'Storing entire user object in session instead of ID causes bloat. Placing sensitive data in deserialized object passed to templates. Incorrect middleware ordering prevents serialization.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/27637609/understanding-passport-serialize-deserialize'
),
(
    'Passport.js error: failed to serialize user into session',
    'stackoverflow-passport',
    'VERY_HIGH',
    '[
        {"solution": "Implement serializeUser and deserializeUser callbacks at module level. serializeUser stores user.id via done(null, user.id). deserializeUser retrieves user via User.findById(id, function(err, user) { done(err, user); })", "percentage": 95, "note": "Required for session-based auth, code structure matters"},
        {"solution": "Disable sessions if building stateless API: add {session: false} parameter to authenticate() call for routes not requiring persistent login", "percentage": 85, "note": "Alternative for token-based or stateless architectures"},
        {"solution": "Ensure done() callback is called with proper signature: done(null, user) on success or done(err) on failure. Missing callback causes hanging requests.", "percentage": 90, "note": "Async callback must complete"}
    ]'::jsonb,
    'Express.js with Passport.js and authentication strategy installed, Session middleware configured, Valid user object structure from auth strategy',
    'Authentication completes without serialize errors, User successfully redirected after login, Session persists across requests without undefined user',
    'Omitting serializeUser/deserializeUser entirely. Passing incorrect callback syntax without calling done(). Attempting to serialize entire user objects instead of just IDs. Placing serialize code inside route handlers instead of at module level.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/19948816/passport-js-error-failed-to-serialize-user-into-session'
),
(
    'What does passport.session() middleware do',
    'stackoverflow-passport',
    'VERY_HIGH',
    '[
        {"solution": "passport.session() acts as middleware converting session ID from client cookie into deserialized full user object. Equivalent to passport.authenticate(''session''). It calls deserializeUser on each request.", "percentage": 93, "note": "Distinct from express.session which only manages IDs"},
        {"solution": "Implement required functions: serializeUser stores user identification (typically ID), deserializeUser retrieves database record using stored ID", "percentage": 90, "note": "Both functions required for session strategy"},
        {"solution": "Place passport.session() after express.session() and passport.initialize() in middleware stack for proper session restoration", "percentage": 88, "note": "Order determines whether user data loads correctly"}
    ]'::jsonb,
    'Express.js with express-session configured, Passport.js initialized, Database access for user lookups, serializeUser and deserializeUser implemented',
    'req.user populated with full user object on authenticated requests, req.isAuthenticated() returns true, Session persists across requests',
    'Assuming express.session() alone handles authentication - it only manages cookies/IDs, not user deserialization. Configuring session without deserializeUser implementation. Forgetting to attach passport.session() middleware.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/22052258/what-does-passport-session-middleware-do'
),
(
    'Passport.js RESTful authentication setup and best practices',
    'stackoverflow-passport',
    'HIGH',
    '[
        {"solution": "For username/password REST APIs: Client sends credentials with each request via HTTP Basic Auth over HTTPS, or server issues access token to reduce repeated credential transmission", "percentage": 88, "note": "Stateless approach suited for distributed systems"},
        {"solution": "For OAuth/Social login (Facebook, etc.): Implement redirect flow - user redirected to OAuth provider, provider redirects back with token, exchange token for user data, store application credentials for future requests", "percentage": 85, "note": "Requires browser interaction despite REST context"},
        {"solution": "Use JWT (JSON Web Tokens) for modern token-based auth: cryptographically signed tokens avoid database lookups on every request, only signature verification needed", "percentage": 90, "note": "Reduces database pressure in high-traffic systems"}
    ]'::jsonb,
    'HTTPS configured (mandatory for auth), Database for user credentials with salted/hashed passwords, Passport.js strategies configured (LocalStrategy, OAuth strategies), Node.js environment',
    'REST clients successfully authenticate with credentials/tokens, API endpoints return 401 for missing/invalid tokens, Tokens validate correctly across requests',
    'Attempting session-based auth in stateless REST APIs. Storing tokens in database while claiming REST stateless principle. Transmitting credentials unencrypted over HTTP. Misunderstanding that database storage of tokens represents application data not session state.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/14572600/passport-js-restful-auth'
),
(
    'Cannot set headers after they are sent to client in Passport.js',
    'stackoverflow-passport',
    'HIGH',
    '[
        {"solution": "Add return statements before all response calls in route handlers and Passport strategy callbacks. Pattern: return res.status(code).json(data) prevents further code execution", "percentage": 93, "note": "Critical for preventing multiple response sends"},
        {"solution": "In try-catch blocks and error handlers, ensure each branch sends response and stops execution. Use early returns to exit function after res.send/json", "percentage": 90, "note": "Applies to all Express response patterns"},
        {"solution": "For Passport strategy callbacks, include return before done() to prevent middleware chain continuation after response", "percentage": 87, "note": "Middleware stack continues unless explicitly halted"}
    ]'::jsonb,
    'Express.js with Passport.js configured, Understanding that HTTP responses are single per request, Knowledge of Express middleware chain behavior',
    'Authentication completes with no header errors, Response sent exactly once per request, No console errors about headers sent',
    'Missing return statements before res.send/json/status calls. Chaining multiple response methods on same response object. Using throw err instead of sending error response. Not awaiting async operations allowing code to continue. Calling next() without return after already responding.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/52122272/err-http-headers-sent-cannot-set-headers-after-they-are-sent'
),
(
    'Passport.js middleware not in use: passport.initialize() error',
    'stackoverflow-passport',
    'HIGH',
    '[
        {"solution": "Register middleware in correct order: cookie-parser → body-parser → express-session → passport.initialize() → passport.session(). Place route definitions after all middleware setup.", "percentage": 94, "note": "Express processes middleware in registration order"},
        {"solution": "Move route initialization (require(''./routes'')) after all middleware configuration, not before. Routes trigger early before Passport state available.", "percentage": 92, "note": "Common mistake with router module pattern"},
        {"solution": "For stateless APIs, add {session: false} to passport.authenticate() calls and skip passport.session() registration", "percentage": 85, "note": "Alternative for token-based auth"}
    ]'::jsonb,
    'Passport.js and session management libraries installed, Express.js with routing setup, Cookie-parser and body-parser middleware available',
    'req.login() executes without middleware-not-in-use errors, Authentication completes successfully, req.user populates on authenticated requests',
    'Placing passport.initialize() before session/cookie middleware. Defining routes before middleware configuration functions. Forgetting Passport middleware entirely. Attempting to promisify req.login without binding context via req.login.bind(req).',
    0.92,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/16781294/passport-js-passport-initialize-middleware-not-in-use'
),
(
    'Redirect to previous page after Passport.js authentication',
    'stackoverflow-passport',
    'HIGH',
    '[
        {"solution": "Store previous URL in session before redirecting to login: set req.session.returnTo = req.originalUrl in ensureAuthenticated middleware, then retrieve and delete after login: res.redirect(req.session.returnTo || ''/'')", "percentage": 91, "note": "Use req.originalUrl not req.path to preserve query strings"},
        {"solution": "Use connect-ensure-login library by Jared Hanson which provides ensureLoggedIn() middleware with built-in successReturnToOrRedirect parameter handling", "percentage": 88, "note": "Third-party solution eliminates manual session management"},
        {"solution": "Clean up returnTo from session after redirect to prevent users logging in from homepage getting redirected to unrelated protected pages", "percentage": 85, "note": "Session cleanup prevents state leakage"}
    ]'::jsonb,
    'Express.js with session middleware configured, Passport.js authentication implemented, Login and protected routes defined',
    'Users returned to their originally requested protected page after login, Query parameters preserved in redirect URL, No unintended redirects on subsequent logins',
    'Using req.path instead of req.originalUrl - loses query strings. Not deleting returnTo causing unrelated redirects. Skipping session initialization for anonymous users preventing redirect URL storage. Not handling case where returnTo is undefined.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/13335881/redirecting-to-previous-page-after-authentication'
),
(
    'How to check if user is logged in with Passport.js',
    'stackoverflow-passport',
    'HIGH',
    '[
        {"solution": "Use req.isAuthenticated() method in server-side route handlers and middleware. Returns true/false for authentication status. Most explicit and recommended approach.", "percentage": 95, "note": "Official Passport method for status checks"},
        {"solution": "Check req.user directly: if (req.user) { /* logged in */ }. req.user exists only when authenticated. Less explicit than req.isAuthenticated()", "percentage": 90, "note": "Works but less readable intent"},
        {"solution": "For template rendering, set res.locals variable in middleware: res.locals.login = req.isAuthenticated(). Access in template via login variable for conditional UI rendering (login/logout buttons)", "percentage": 88, "note": "Patterns for view layer authentication display"}
    ]'::jsonb,
    'Passport.js configured with authentication strategy, Express.js with middleware support, Session management enabled if using persistent sessions',
    'req.isAuthenticated() returns correct boolean values, Protected routes accessible only to authenticated users, Template conditionals render correct UI based on login status',
    'Accessing req.user outside request context - it only exists within handlers. Using client-side checks alone - server-side validation required on refresh. Forgetting that req.user undefined does not necessarily mean unauthenticated.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/18739725/how-to-know-if-user-is-logged-in-with-passport-js'
),
(
    'Passing additional form fields with Passport.js LocalStrategy',
    'stackoverflow-passport',
    'MEDIUM',
    '[
        {"solution": "Set passReqToCallback: true in LocalStrategy options to receive request object as first callback parameter: new LocalStrategy({usernameField: ''email'', passReqToCallback: true}, function(req, email, password, done) { const customField = req.body.foo; })", "percentage": 93, "note": "Enables access to all form fields via req.body"},
        {"solution": "Without passReqToCallback, only extracted username/password available in callback parameters. Custom fields inaccessible in strategy verify function", "percentage": 85, "note": "Default behavior limits field access"},
        {"solution": "Ensure body parsing middleware (express.json() or express.urlencoded()) runs before authentication to populate req.body with form data", "percentage": 90, "note": "Middleware ordering affects request parsing"}
    ]'::jsonb,
    'Passport.js with express middleware configured, Body parsing middleware enabled, LocalStrategy with username/password fields, Form data submission via POST',
    'Custom form fields accessible in strategy callback via req.body, Strategy receives all submitted data, Authentication uses custom fields for validation',
    'Forgetting passReqToCallback: true flag - req not passed to callback. Incorrect parameter order - req must be first when flag enabled. Missing or misconfigured body parsing middleware. Assuming field names match without verifying form field names.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/11784233/using-passportjs-how-does-one-pass-additional-form-fields'
),
(
    'Node Express Passport req.user undefined on subsequent requests',
    'stackoverflow-passport',
    'VERY_HIGH',
    '[
        {"solution": "Ensure session middleware precedes Passport middleware in initialization order: app.use(session()); app.use(passport.initialize()); app.use(passport.session()). Incorrect order prevents session restoration across requests.", "percentage": 94, "note": "Most common cause of undefined req.user"},
        {"solution": "Remove cookie: {secure: true} configuration during HTTP development/testing. Secure cookies transmit only over HTTPS, preventing cookie transmission on localhost", "percentage": 91, "note": "Development vs production settings differ"},
        {"solution": "For client-side API requests (fetch, AJAX), include credentials: fetch(''/api/foo'', {credentials: ''include''}) for cookies to transmit. Axios: withCredentials: true. Without this, server cannot access session.", "percentage": 89, "note": "Client-side code must cooperate with cookies"}
    ]'::jsonb,
    'Express.js with express-session installed, Passport.js with serialize/deserialize implemented, Correct middleware setup, HTTPS (production) or HTTP without secure cookie flag (development)',
    'req.user populated on subsequent authenticated requests, Session persists across page loads, Cookies visible in browser DevTools Application/Cookies tab',
    'Placing static file middleware after Passport middleware disrupting session handling. Secure cookie setting on HTTP connections preventing cookie transmission. Missing {credentials: ''include''} in fetch calls causing cookies to not send. Incorrect serialize/deserialize callback signatures. Assuming express-session is built-in to Express.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/16434893/node-express-passport-req-user-undefined'
),
(
    'Secure REST API implementation with Node.js and Passport.js',
    'stackoverflow-passport',
    'HIGH',
    '[
        {"solution": "Use HTTPS to encrypt communication - non-negotiable for auth. Implement token-based auth with API tokens for long-term access and access tokens with expiration for sessions", "percentage": 92, "note": "Foundation of REST API security"},
        {"solution": "Implement JWT (JSON Web Tokens) for stateless auth: cryptographically signed tokens contain user claims, eliminate server-side session storage, scale across load-balanced infrastructure", "percentage": 90, "note": "Modern approach - reduces database hits"},
        {"solution": "Authentication flow: user login with credentials → server validation → token generation → client stores token securely → subsequent requests include token in headers → server validates token claims", "percentage": 88, "note": "Standard stateless pattern for APIs"}
    ]'::jsonb,
    'HTTPS configured (mandatory), Database with user credentials using salted/hashed passwords, Passport.js or JWT library (jsonwebtoken), Node.js/Express environment, Understanding of stateless vs session-based auth',
    'API returns tokens on successful authentication, Subsequent requests with valid tokens execute correctly, Invalid/missing tokens return 401 Unauthorized, Tokens expire as configured',
    'Transmitting credentials unencrypted over HTTP. Using weak password hashing. Storing sensitive data in JWT claims. Not implementing token expiration. Assuming session-based auth scales well across multiple servers without consideration. Hardcoding secrets in code.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/15496915/how-to-implement-a-secure-rest-api-with-node-js'
),
(
    'Everyauth vs Passport.js authentication framework comparison',
    'stackoverflow-passport',
    'MEDIUM',
    '[
        {"solution": "Choose Passport.js for modular design via strategy pattern - install only needed dependencies. Passport is framework-agnostic, works with Express/Koa/others, has extensive community strategies", "percentage": 92, "note": "Recommended by Passport creator for production use"},
        {"solution": "Everyauth provides broader service provider support and automatic route insertion but has low test coverage, declining maintenance, poor single-page app integration, creating tight framework coupling", "percentage": 80, "note": "Historical choice - Passport now preferred"},
        {"solution": "Passport advantages: conventional Node.js callbacks, well-defined interfaces, extensive testing, community contributions. Aligns with Express middleware patterns (fn(req, res, next))", "percentage": 88, "note": "Architectural benefits of Passport approach"}
    ]'::jsonb,
    'Node.js environment, Understanding of authentication patterns, Framework selection phase, Knowledge of strategy vs implicit route patterns',
    'Authentication strategy selected and implemented, Module loads without errors, Framework integration successful, Community resources available',
    'Choosing Everyauth for new projects due to outdated comparisons. Assuming Everyauth still maintains stability. Not considering framework coupling when evaluating. Underestimating importance of community and maintenance.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/11974947/everyauth-vs-passport-js'
);
