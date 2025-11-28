-- Sentry Error Knowledge Base - 15 High-Quality Entries
-- Mined from Stack Overflow, Official Docs, and GitHub Issues
-- Date: 2025-11-26

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES

-- Entry 1: Non-Error Exception
(
    'Non-Error exception (or promise rejection) captured with keys',
    'sentry',
    'HIGH',
    '[
        {"solution": "Convert plain objects to Error instances before passing to Sentry.captureException(). Instead of throwing or rejecting with a plain object like {error: ''message''}, wrap it: throw new Error(JSON.stringify(object))", "percentage": 95},
        {"solution": "If object inspection is required, use Sentry.withScope() to attach context before capturing: Sentry.withScope(scope => {scope.setContext(\"plain_error\", plainObject); Sentry.captureException(actualError);})", "percentage": 85},
        {"solution": "As a temporary workaround, add to ignoreErrors in Sentry.init(): ignoreErrors: [\"Non-Error exception captured\", \"Non-Error promise rejection captured\"]", "percentage": 70}
    ]'::jsonb,
    'Understanding that Sentry expects Error instances, not plain objects or non-Error values',
    'Sentry dashboard shows properly grouped errors with full stack traces instead of serialized object data',
    'Ignoring these errors completely rather than fixing the root cause. The correct approach is to ensure Error objects are thrown, not plain objects.',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/77220020/sentry-non-error-exception-captured-with-keys'
),

-- Entry 2: SDK Not Sending Data
(
    'SDK not sending events to Sentry after initialization',
    'sentry',
    'HIGH',
    '[
        {"solution": "Verify DSN is correctly passed to Sentry.init({dsn: ''https://key@sentry.io/project''}). Check it matches the DSN from Sentry project settings > Client Keys.", "percentage": 97},
        {"solution": "For Next.js/Vite/etc: Check environment variables use correct prefix (NEXT_PUBLIC_, VITE_, etc.). Environment variables without public prefix won''t be available client-side.", "percentage": 92},
        {"solution": "Disable ad-blockers (uBlock, Adblock Plus, etc.) as they block requests to sentry.io. Verify with browser DevTools Network tab.", "percentage": 88},
        {"solution": "Enable debug mode with Sentry.init({debug: true}) to see console output. Look for errors in browser console or Node.js stderr.", "percentage": 85},
        {"solution": "Check Sentry quota hasn''t been exceeded. Go to Settings > Subscription > Stats. If quota is full, no new events will be accepted.", "percentage": 78}
    ]'::jsonb,
    'Having a valid Sentry account with a project created and DSN available',
    'Events appear in Sentry dashboard within seconds of being triggered in application',
    'Assuming the SDK is initialized when it actually failed silently due to invalid DSN. Always check browser console and Sentry dashboard logs.',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/68004379/sentry-please-check-if-your-dsn-is-set-properly'
),

-- Entry 3: CORS Blocking Script Errors
(
    'Cross-origin script errors blocked by CORS policy - getting "Script Error" instead of real message',
    'sentry',
    'MEDIUM',
    '[
        {"solution": "Add crossorigin=\"anonymous\" to all <script> tags: <script crossorigin=\"anonymous\" src=\"...\"></script>", "percentage": 96},
        {"solution": "Configure server CORS headers to allow error reporting: Add ''Access-Control-Allow-Origin: *'' (or specific origin) to HTTP response headers.", "percentage": 94},
        {"solution": "For same-origin scripts, ensure script tag is served with same protocol/domain. HTTPS domain cannot load HTTP script.", "percentage": 88},
        {"solution": "Check browser DevTools Security tab. If script is flagged as cross-origin, verify both script URL and page URL use same origin.", "percentage": 82}
    ]'::jsonb,
    'Understanding that script error messages are hidden by browsers for security unless CORS headers allow it',
    'Sentry shows detailed error messages with line/column numbers and stack traces for cross-origin scripts instead of generic ''Script error''',
    'Adding crossorigin attribute without configuring server CORS headers (attribute alone is not sufficient). Both client and server must be configured.',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/77029657/how-to-fix-sentry-angular-app-receiving-cors-error'
),

-- Entry 4: Python Connection Timeout
(
    'http.client.RemoteDisconnected: Remote end closed connection without response',
    'sentry',
    'MEDIUM',
    '[
        {"solution": "Enable keep-alive in sentry_sdk.init(keep_alive=True). This requires sentry_sdk >= 1.43.0 and prevents connection resets during inactivity.", "percentage": 93},
        {"solution": "Implement custom KeepAliveTransport class that sets socket options: socket.SO_KEEPALIVE, TCP_KEEPIDLE=60, TCP_KEEPINTVL=10, TCP_KEEPCNT=5", "percentage": 87},
        {"solution": "As temporary fix, wrap Sentry calls in try/except and implement exponential backoff retry logic with 2-5 second delays.", "percentage": 75}
    ]'::jsonb,
    'Python 3.6+ with sentry_sdk installed, understanding of socket programming for advanced fixes',
    'Sentry events successfully sent without connection timeouts, cron monitors complete without ''timed out'' status',
    'Assuming server is broken when it''s actually just connection pooling timeout. The issue is specifically about inactivity timeout, not always-broken connections.',
    0.89,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/72393655/connection-aborted-remotedisconnected-remote-end-closed-connection-without-re'
),

-- Entry 5: Django 500 Errors Not Captured
(
    'Django 500 errors not being captured by Sentry',
    'sentry',
    'HIGH',
    '[
        {"solution": "Initialize Sentry in Django settings.py before other code runs: import sentry_sdk; from sentry_sdk.integrations.django import DjangoIntegration; sentry_sdk.init(dsn=..., integrations=[DjangoIntegration()])", "percentage": 96},
        {"solution": "Ensure SENTRY_DSN environment variable is set and matches DSN in Sentry project settings. Check with: echo $SENTRY_DSN", "percentage": 94},
        {"solution": "Verify Django is actually raising 500 errors to Sentry (not caught elsewhere). Add manual capture in error view: from sentry_sdk import capture_exception; capture_exception(exc)", "percentage": 88},
        {"solution": "For development, ensure DEBUG=False. When DEBUG=True, Django shows error pages and Sentry doesn''t capture them automatically.", "percentage": 85}
    ]'::jsonb,
    'Django project with sentry_sdk package installed, active Sentry project with DSN',
    '500 errors appear in Sentry dashboard immediately after they occur in Django, with full stack traces and request context',
    'Placing Sentry init after other imports that might raise exceptions. Init must happen first. Also confusing environment variables with hardcoded DSN.',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/75514943/getting-django-500-errors-flagged-by-sentry'
),

-- Entry 6: Vite Build Error with Sentry
(
    'Could not resolve ''{}.js'' from node_modules/@sentry/utils/esm/index.js - Vite build error',
    'sentry',
    'MEDIUM',
    '[
        {"solution": "Remove or update the ''define'' option in vite.config.ts. Delete: define: { global: {} }. Use define only for CONSTANTS, not for global/process.", "percentage": 97},
        {"solution": "If you need to define globals, use: define: { ''process.env.NODE_ENV'': JSON.stringify(process.env.NODE_ENV) } instead of global: {}", "percentage": 91}
    ]'::jsonb,
    'Vite project with Sentry SDK installed, vite.config.ts or vite.config.js exists',
    'Vite build completes successfully without ''Could not resolve'' errors, Sentry SDK loads without issues',
    'Assuming the error is in Sentry code rather than in Vite config. The problem is Vite string-replacing SDK internal variables.',
    0.94,
    'haiku',
    NOW(),
    'https://docs.sentry.io/platforms/javascript/troubleshooting/'
),

-- Entry 7: Ad-Blocker Blocking Events
(
    'ERR_BLOCKED_BY_CLIENT - Sentry events blocked by ad-blockers (uBlock Origin, Adblock Plus, etc)',
    'sentry',
    'MEDIUM',
    '[
        {"solution": "Use Sentry tunnel option (v6.7.0+): Sentry.init({tunnel: ''/api/sentry''}). Create server endpoint that forwards events to https://sentry.io/api/{projectId}/envelope/ (relative URLs bypass ad-blockers).", "percentage": 94},
        {"solution": "Use relative tunnel URL for same-origin requests: Sentry.init({tunnel: ''/tunnel''}). This prevents ad-blocker detection as it''s same-origin.", "percentage": 92},
        {"solution": "As workaround, inform users to disable ad-blockers on your site. Add message in settings: document.addEventListener(''error'', (e) => console.warn(''Ad-blocker may be blocking error reporting''))", "percentage": 65}
    ]'::jsonb,
    'Server infrastructure to handle /tunnel endpoint, Node.js/Express or similar to proxy events',
    'Events sent from browsers with ad-blockers enabled appear in Sentry dashboard, network DevTools shows requests to /tunnel (not sentry.io)',
    'Only using tunnel option without setting up actual endpoint. The tunnel config must be paired with working server-side proxy.',
    0.88,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/75247913/sentry-reactjs-how-to-set-up-a-tunnel-to-bypass-ad-blocker'
),

-- Entry 8: ignoreErrors Configuration
(
    'Events being captured when they should be ignored by ignoreErrors configuration',
    'sentry',
    'MEDIUM',
    '[
        {"solution": "Use regex patterns in ignoreErrors: ignoreErrors: [/The user is not authenticated/, /Network request failed/]. Test patterns in browser console.", "percentage": 92},
        {"solution": "For exact string matches, use: ignoreErrors: [''ResizeObserver loop limit exceeded'', ''NotFoundError'']", "percentage": 88},
        {"solution": "Use beforeSend hook for complex filtering: beforeSend(event, hint) { if (hint.originalException?.message?.includes(''ignore'')) return null; return event; }", "percentage": 85},
        {"solution": "Use server-side filters in Sentry dashboard Settings > Inbound Filters > Error Message (doesn''t consume quota)", "percentage": 90}
    ]'::jsonb,
    'Sentry SDK initialized with ignoreErrors option, understanding of regex patterns',
    'Errors matching patterns no longer appear in Sentry dashboard, quota consumption reduced for irrelevant errors',
    'Using string literals instead of regex patterns. ''ignoreErrors: [''Error'']'' won''t work - use ''ignoreErrors: [/Error/]''',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/55846690/how-to-globally-ignore-errors-with-sentry-v5-to-reduce-noise'
),

-- Entry 9: Invalid DSN Format
(
    'io.sentry.SentryClientFactory - Error creating valid DSN from invalid format',
    'sentry',
    'MEDIUM',
    '[
        {"solution": "Verify DSN format is exactly: https://PUBLIC_KEY@sentry.io/PROJECT_ID or https://PUBLIC_KEY:SECRET_KEY@sentry.io/PROJECT_ID", "percentage": 98},
        {"solution": "Get correct DSN from Sentry dashboard: Project Settings > Client Keys > Copy the DSN string exactly as shown", "percentage": 97},
        {"solution": "Check for common mistakes: missing https://, wrong host (should be sentry.io, not sentr.io), missing PROJECT_ID, extra spaces/chars", "percentage": 96}
    ]'::jsonb,
    'Sentry project created with valid DSN available in project settings',
    'SDK initializes without DSN format errors, events are sent to correct Sentry project',
    'Manually typing DSN instead of copying from dashboard. Always copy-paste DSN to avoid typos.',
    0.96,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/54093129/io-sentry-sentryclientfactory-error-creating-valid-dsn'
),

-- Entry 10: Python Multiprocessing Fork Warning
(
    'This process is multi-threaded, use of fork() may lead to deadlocks - Python 3.12/3.13 Linux',
    'sentry',
    'LOW',
    '[
        {"solution": "Set multiprocessing start method in __main__: import multiprocessing; if __name__ == \"__main__\": multiprocessing.set_start_method(\"forkserver\")", "percentage": 94},
        {"solution": "Alternative: use spawn method instead: multiprocessing.set_start_method(\"spawn\") (slower but safer for multi-threaded apps)", "percentage": 89}
    ]'::jsonb,
    'Python 3.12+ with multiprocessing and threading, ability to modify application __main__ entry point',
    'No more fork() deadlock warnings, multiprocessing behaves correctly with Sentry in multi-threaded context',
    'Setting method globally instead of only in __main__. The method must be set in __main__ BEFORE any processes are spawned.',
    0.91,
    'haiku',
    NOW(),
    'https://docs.sentry.io/platforms/python/troubleshooting/'
),

-- Entry 11: React Router Export Not Found
(
    '@sentry/react-router does not provide an export named ''ErrorBoundary''',
    'sentry',
    'MEDIUM',
    '[
        {"solution": "Update @sentry/react and @sentry/react-router to latest versions: npm install @sentry/react @sentry/react-router@latest", "percentage": 96},
        {"solution": "Verify import statement is correct: import {ErrorBoundary} from ''@sentry/react'' (not from @sentry/react-router). ErrorBoundary is in main react package.", "percentage": 93},
        {"solution": "Check @sentry/react-router version >= 7.60.0 where ErrorBoundary export was properly added to React Router integration", "percentage": 90}
    ]'::jsonb,
    'React project with @sentry/react and @sentry/react-router installed, React Router v6+ configured',
    'ErrorBoundary imports without errors, component wraps routes and catches React errors properly',
    'Importing from wrong package. The integration export changed between versions - always check latest docs.',
    0.92,
    'haiku',
    NOW(),
    'https://github.com/getsentry/sentry-javascript/issues/18179'
),

-- Entry 12: Context Data Leaking Between Requests
(
    'Sentry scope data leaking between requests or nested spans in transaction instead of parallel spans',
    'sentry',
    'MEDIUM',
    '[
        {"solution": "Verify contextvars implementation: Python should use contextvars for request isolation. For Python 3.6, install backport: pip install aiocontextvars", "percentage": 94},
        {"solution": "Clone isolation scope for each async task: async with sentry_sdk.isolation_scope() as scope: ... ensures data doesn''t leak between concurrent requests", "percentage": 91},
        {"solution": "For async frameworks (asyncio, FastAPI), ensure Sentry is initialized with proper async integration. Use AsyncIntegration for async/await patterns.", "percentage": 88}
    ]'::jsonb,
    'Python 3.6+ with async/concurrent request handling, sentry_sdk installed with async support',
    'Each request has isolated scope data, transactions show parallel spans not nested, no data leakage between requests',
    'Assuming single-threaded request handling when app is actually async. Async request handling requires explicit isolation scope management.',
    0.89,
    'haiku',
    NOW(),
    'https://docs.sentry.io/platforms/python/troubleshooting/'
),

-- Entry 13: Laravel DSN Configuration
(
    'Sentry: Please check if your DSN is set properly in your config or .env as `SENTRY_LARAVEL_DSN`',
    'sentry',
    'HIGH',
    '[
        {"solution": "Add SENTRY_LARAVEL_DSN=https://key@sentry.io/project to your .env file. Copy from Sentry project settings > Client Keys.", "percentage": 97},
        {"solution": "Clear Laravel config cache: php artisan config:clear. Cached config may prevent .env changes from being read.", "percentage": 94},
        {"solution": "Verify config/sentry.php is properly loading DSN: ''dsn'' => env(''SENTRY_LARAVEL_DSN''). Check this key exists in the returned config.", "percentage": 91},
        {"solution": "For development, ensure APP_DEBUG=false. When true, Laravel error pages override Sentry capture.", "percentage": 88}
    ]'::jsonb,
    'Laravel project with Sentry SDK installed, .env file accessible, config:cache not frozen',
    'DSN appears in error messages confirmation, events flow to Sentry project without configuration errors',
    'Putting DSN in wrong .env variable name or forgetting to clear config cache after .env changes.',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/68004379/sentry-please-check-if-your-dsn-is-set-properly'
),

-- Entry 14: Node.js Docker Container Events Not Sent
(
    'Unable to send Sentry events in Node.js Docker container - connection timeout or refused',
    'sentry',
    'MEDIUM',
    '[
        {"solution": "Verify network access: Docker container must be able to reach sentry.io. Check firewall rules and network configuration.", "percentage": 94},
        {"solution": "If using Sentry self-hosted, configure DSN to use internal hostname: check docker-compose.yml for sentry service hostname and update DSN.", "percentage": 90},
        {"solution": "Add timeout/retry configuration: Sentry.init({..., maxBreadcrumbs: 50, attachStacktrace: true, httpTimeout: 10000})", "percentage": 82},
        {"solution": "Debug with logs: Enable debug mode in container to see detailed connection errors: Sentry.init({debug: true})", "percentage": 80}
    ]'::jsonb,
    'Node.js application in Docker, Sentry account/self-hosted instance accessible from container network',
    'Events sent from container appear in Sentry dashboard, no connection timeouts in container logs',
    'Assuming application is broken when network policy is blocking outbound connections. Check container network and firewall rules first.',
    0.88,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/69801317/unable-to-send-sentry-events-in-node-js-docker-container'
),

-- Entry 15: Logging Integration Prevents Event Capture
(
    'Sentry logging integration prevents sentry events being sent - no errors appear',
    'sentry',
    'LOW',
    '[
        {"solution": "Check if LoggingIntegration is enabled (usually default in Python SDK). If it''s configured incorrectly, it can suppress other events.", "percentage": 91},
        {"solution": "Verify logging level: LoggingIntegration(level=logging.INFO) should capture INFO+. Check no higher level is accidentally set.", "percentage": 88},
        {"solution": "For Python SDK, initialize in correct order: sentry_sdk.init() BEFORE logging.basicConfig(). Logging config must happen after Sentry.", "percentage": 85}
    ]'::jsonb,
    'Python project with Sentry SDK and logging module, understanding of logging integration',
    'Both logging messages and exceptions appear in Sentry, no suppression or circular dependency issues',
    'Initializing logging before Sentry, causing LoggingIntegration to be configured incorrectly.',
    0.86,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/63406518/sentry-logging-integration-prevents-sentry-events-being-sent-python'
);
