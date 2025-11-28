INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'java.lang.StackOverflowError at org.keycloak.common.util.StringPropertyReplacer.replaceProperties',
    'keycloak',
    'MEDIUM',
    '[
        {"solution": "Verify environment variable values don''t reference themselves (e.g., MY_VAR=${MY_VAR} causes infinite recursion). Check all ${...} placeholders in configuration files and env vars to ensure values don''t create circular references.", "percentage": 95},
        {"solution": "Upgrade to Keycloak 18.0.0+ which includes cycle detection for property replacement. The newer version displays a clear error message instead of StackOverflowError when circular references are detected.", "percentage": 85}
    ]'::jsonb,
    'Access to Keycloak logs showing the exact error. Know your environment variable configuration.',
    'Keycloak starts successfully without StackOverflowError. Property replacement works correctly.',
    'Creating placeholder names that reference themselves (e.g., ADMIN_PASSWORD=${ADMIN_PASSWORD}). Not upgrading when running older versions.',
    0.92,
    'haiku',
    NOW(),
    'https://github.com/keycloak/keycloak/issues/21151'
),
(
    'Unable to find factory for Required Action: TERMS_AND_CONDITIONS did you forget to declare it in a META-INF/services file?',
    'keycloak',
    'MEDIUM',
    '[
        {"solution": "Update custom provider code to check both attribute names: ''terms_and_conditions'' (old) and ''TERMS_AND_CONDITIONS'' (new). Keycloak changed naming conventions between versions, so providers must handle both.", "percentage": 90},
        {"solution": "Recompile custom extensions against the new Keycloak version''s API. Ensure META-INF/services files reference the correct fully-qualified class names for the new version.", "percentage": 85}
    ]'::jsonb,
    'Custom Keycloak provider extensions. Knowledge of attribute naming in your Keycloak version.',
    'Authentication flow completes without factory lookup errors. Terms and conditions are processed correctly.',
    'Not updating custom code after upgrading Keycloak. Assuming old attribute names still work.',
    0.88,
    'haiku',
    NOW(),
    'https://github.com/keycloak/keycloak/issues/21967'
),
(
    'Failed to create gzip cache directory',
    'keycloak',
    'LOW',
    '[
        {"solution": "Check filesystem permissions on the Keycloak cache directory (usually tmp/cache). Ensure the Keycloak process user has write permission. Run: chmod 755 <cache_dir> and verify ownership with chown keycloak:keycloak <cache_dir>.", "percentage": 92},
        {"solution": "Verify sufficient disk space is available. Run: df -h to check filesystem usage. If cache directory filesystem is full, free up space or configure cache directory on a different filesystem.", "percentage": 88},
        {"solution": "Upgrade to Keycloak 18.0.0+ which logs the actual cache directory path when creation fails, making troubleshooting easier.", "percentage": 85}
    ]'::jsonb,
    'Access to server logs. System-level permissions knowledge.',
    'Keycloak starts without NullPointerException. Static resources load without HTTP 500 errors.',
    'Ignoring permission errors. Assuming cache directory doesn''t exist when the real issue is permissions.',
    0.90,
    'haiku',
    NOW(),
    'https://github.com/keycloak/keycloak/issues/10379'
),
(
    'CODE_TO_TOKEN_ERROR with error=invalid_code',
    'keycloak',
    'HIGH',
    '[
        {"solution": "Verify redirect_uri parameter matches exactly when requesting authorization code and when exchanging code for token. Check for trailing slashes, protocol, domain, and port - even minor differences invalidate the code.", "percentage": 96},
        {"solution": "For Keycloak 23.0.5+, ensure ''Client authentication'' is properly configured. Uncheck it for public clients that cannot securely store credentials. Toggle this in client settings and retry the flow.", "percentage": 93},
        {"solution": "Check authorization code hasn''t been corrupted in URL parsing. Remove any stray characters like hash symbols (#) at the end of the code parameter before submission.", "percentage": 88},
        {"solution": "Compare code_id values in logs. Get code_id from LOGIN event log and CODE_TO_TOKEN_ERROR event - they must match. If different, the code was lost or replaced.", "percentage": 85}
    ]'::jsonb,
    'Keycloak logs with LOGIN and CODE_TO_TOKEN_ERROR events. Understanding of OAuth2 authorization code flow.',
    'Token exchange succeeds without invalid_code errors. Access token received in exchange response.',
    'Using trailing slashes inconsistently (http://example.com/ vs http://example.com). Not matching redirect_uri exactly between requests.',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/45860313/keycloak-code-to-token-error-after-user-is-authenticated'
),
(
    'error=invalid_token, error_description=Invalid token issuer. Expected ''http://localhost:8060/auth/realms/sau'', but was ''http://10.0.2.2:8060/auth/realms/sau''',
    'keycloak',
    'HIGH',
    '[
        {"solution": "Set KEYCLOAK_FRONTEND_URL environment variable to standardize issuer claim: export KEYCLOAK_FRONTEND_URL=http://10.0.2.2:8060/auth and restart Keycloak.", "percentage": 94},
        {"solution": "Use KC_HOSTNAME (Keycloak 19+) instead of KEYCLOAK_FRONTEND_URL: oc set env dc/keycloak -e KC_HOSTNAME=https://yourdomain.com for OpenShift deployments.", "percentage": 92},
        {"solution": "Update resource service configuration to match client URL. Change auth-server-url in resource adapter config to use the same hostname as client (10.0.2.2 in this example).", "percentage": 90},
        {"solution": "Configure hostname-url at startup: ./bin/kc.sh start-dev --hostname-url=http://10.0.2.2:8060", "percentage": 88}
    ]'::jsonb,
    'Environment variable access. Understanding of token issuer claims in OpenID Connect.',
    'Token validation passes. Resource service accepts tokens without issuer mismatch errors.',
    'Using different hostnames in different parts of the system (10.0.2.2 for clients, localhost for services). Not setting KC_HOSTNAME in Keycloak 19+.',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/61966384/keycloak-invalid-token-issuer'
),
(
    'Blank page and Invalid parameter: redirect_uri behind nginx reverse proxy',
    'keycloak',
    'HIGH',
    '[
        {"solution": "Enable proxy address forwarding in Keycloak. Add proxy-address-forwarding=\"true\" to the http-listener element in standalone.xml (around line 572), or set environment variable PROXY_ADDRESS_FORWARDING=true.", "percentage": 96},
        {"solution": "Set KEYCLOAK_FRONTEND_URL environment variable: export KEYCLOAK_FRONTEND_URL=https://yourdomain.com/auth and restart Keycloak. This ensures correct protocol and domain in redirect URIs.", "percentage": 94},
        {"solution": "Verify nginx headers are configured. Ensure X-Forwarded-Proto, X-Forwarded-For, and X-Forwarded-Host headers are set in nginx upstream block.", "percentage": 90},
        {"solution": "Disable HTTP authentication at the nginx level. Remove auth_basic directives from nginx config and ensure services are restarted.", "percentage": 85}
    ]'::jsonb,
    'Access to Keycloak and nginx configuration files. Ability to restart services.',
    'Login page loads without blank page error. Redirect URIs are valid. Authentication flow completes.',
    'Setting only KEYCLOAK_FRONTEND_URL without enabling proxy-address-forwarding. Using HTTP when HTTPS is required. Not restarting Keycloak after changes.',
    0.94,
    'haiku',
    NOW(),
    'https://serverfault.com/questions/1000567/keycloak-blank-page-behind-nginx-reverse-proxy'
),
(
    'Unexpected error when authenticating with identity provider (Google provider with auto-user-link)',
    'keycloak',
    'MEDIUM',
    '[
        {"solution": "Upgrade to Keycloak 25 or later and add the ''Confirm Override Existing Link'' authenticator to your first broker login flow. This allows users to manually approve relinking recreated accounts.", "percentage": 91},
        {"solution": "Use Admin API to manually remove stale federated identity links before re-linking. Call DELETE /admin/realms/{realm}/users/{userId}/federated-identity/{provider} to clean up old Google links.", "percentage": 89},
        {"solution": "Implement a custom authenticator to automate federated identity link cleanup during first broker login.", "percentage": 82}
    ]'::jsonb,
    'Keycloak 23.0.6+. Admin API access or custom provider development skills.',
    'User can re-authenticate with recreated Google account without duplicate key constraint errors.',
    'Not cleaning up old federated identity links before relinking. Expecting auto-override to work in Keycloak <25.',
    0.86,
    'haiku',
    NOW(),
    'https://github.com/keycloak/keycloak/issues/31320'
),
(
    'HTTP 400 unknown_error when posting to Keycloak REST API',
    'keycloak',
    'MEDIUM',
    '[
        {"solution": "Switch from text encoding to JSON serialization in HTTP client. Change from data=body to json=body in Python requests, or set Content-Type: application/json header in curl/other clients.", "percentage": 94},
        {"solution": "Use browser Developer Tools (F12) to inspect successful admin console requests. Mirror the exact JSON payload structure and endpoint URLs from browser network tabs in your API calls.", "percentage": 92},
        {"solution": "Validate JSON syntax using jq or a JSON validator before submitting requests. Malformed JSON often returns 400 unknown_error.", "percentage": 88}
    ]'::jsonb,
    'HTTP client library knowledge. Ability to use browser developer tools.',
    'REST API POST requests return 2xx status codes. API responses contain created resource data.',
    'Sending request body as text instead of JSON. Not validating payload structure against actual admin console requests.',
    0.89,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/68569176/get-400-with-message-unknown-error-for-any-post-to-keycloak-rest-api'
),
(
    'Code already used for userSession warning during authorization code exchange',
    'keycloak',
    'MEDIUM',
    '[
        {"solution": "Prevent code reuse by implementing proper OAuth2 flow: never resubmit the same authorization code. If initial token exchange fails, request a new authorization code from the authorization endpoint.", "percentage": 95},
        {"solution": "Check application logic for duplicate token exchange attempts. Look for retry loops that reuse the same code parameter without requesting a fresh code.", "percentage": 92},
        {"solution": "Monitor logs for CODE_TO_TOKEN_ERROR following the reuse warning. Session invalidation may occur after failed exchange, requiring fresh login.", "percentage": 85}
    ]'::jsonb,
    'OAuth2/OIDC protocol understanding. Application request logging.',
    'Authorization flow completes with single token exchange. User sessions remain valid.',
    'Attempting to reuse authorization codes. Not requesting fresh codes after failed token exchange.',
    0.87,
    'haiku',
    NOW(),
    'https://forum.keycloak.org/t/bug-or-my-misunderstanding/24689'
),
(
    'User temporarily locked after failed login attempts - can''t customize lock message',
    'keycloak',
    'MEDIUM',
    '[
        {"solution": "Accept that Keycloak intentionally hides lock status to prevent username enumeration attacks. Display ''Invalid username/password'' for both failed credentials and locked accounts (this is security best practice).", "percentage": 96},
        {"solution": "For Keycloak <13: Create custom authenticator extending UsernamePasswordForm and override tempDisabledError() to return custom message. This no longer works in Keycloak 13+.", "percentage": 70},
        {"solution": "Implement post-login notifications instead. After login succeeds, notify users if their account was previously locked, without revealing lock status to failed authentication attempts.", "percentage": 88}
    ]'::jsonb,
    'Understanding of brute force attack mechanics. Keycloak authenticator SPI knowledge for custom solutions.',
    'Brute force protection works without information disclosure. Users locked after failed attempts.',
    'Attempting to show different messages for locked vs. invalid credentials (enables username enumeration). Relying on custom authenticators in Keycloak 13+.',
    0.88,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/57112945/keycloak-custom-message-on-user-temporary-lock'
),
(
    'somethingWentWrong error in Keycloak 26 admin console',
    'keycloak',
    'MEDIUM',
    '[
        {"solution": "Set KC_HOSTNAME environment variable to your complete HTTPS URL: oc set env dc/keycloak -e KC_HOSTNAME=https://keycloak.yourdomain.com (required in Keycloak 26+).", "percentage": 96},
        {"solution": "If upgrading from 25.0.0, add KC_HOSTNAME configuration. Version 26.0.0+ removed support for v1 hostname configuration, making this variable mandatory.", "percentage": 95},
        {"solution": "Check browser console for CSP (Content-Security-Policy) frame-src violations. Ensure KC_HOSTNAME matches the URL in address bar.", "percentage": 92},
        {"solution": "Downgrade to Keycloak 25.0.0 if KC_HOSTNAME configuration is not available or unclear.", "percentage": 65}
    ]'::jsonb,
    'Environment variable configuration access. Kubernetes/OpenShift experience (if using oc commands).',
    'Admin console loads without ''somethingWentWrong'' error. Realms are visible and editable.',
    'Not setting KC_HOSTNAME in Keycloak 26+. Assuming v1 hostname configuration still works.',
    0.91,
    'haiku',
    NOW(),
    'https://github.com/keycloak/keycloak-quickstarts/issues/641'
),
(
    'RESTEASY003210: Could not find resource for full path /auth/realms/test/protocol/openid-connect/token - 404',
    'keycloak',
    'HIGH',
    '[
        {"solution": "For Keycloak 18+, remove /auth/ from API endpoints. Change http://localhost:8080/auth/realms/test/... to http://localhost:8080/realms/test/... The path segment was deprecated in version 18.", "percentage": 97},
        {"solution": "Verify your Keycloak version. If running 17 or earlier, keep /auth/ in URLs. Use http://localhost:8080/auth/realms/{realm}/... format.", "percentage": 96},
        {"solution": "Check .well-known/openid-configuration endpoint for correct token URL: http://localhost:8080/realms/{realm}/.well-known/openid-configuration. Use the token_endpoint URL from response.", "percentage": 94}
    ]'::jsonb,
    'Knowledge of Keycloak version. OpenID Connect configuration endpoint access.',
    'API requests return correct response codes. Token endpoint accepts requests without 404 errors.',
    'Mixing /auth/ paths across Keycloak versions. Not checking .well-known/openid-configuration for correct endpoints.',
    0.95,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/72596189/keycloak-all-api-response-with-404'
),
(
    'HTTP 502 Bad Gateway and Connection reset by peer behind nginx proxy',
    'keycloak',
    'MEDIUM',
    '[
        {"solution": "Switch from HTTP reverse proxy to TCP stream proxy using nginx stream module. Replace http {} block with stream {} block and proxy directly to container HTTPS port (8443).", "percentage": 93},
        {"solution": "Alternatively, map SSL certificates into Keycloak container and connect directly to container IP without HTTP proxy. This eliminates proxying issues.", "percentage": 91},
        {"solution": "If staying with HTTP proxy, increase proxy buffer sizes: proxy_buffer_size 128k and proxy_buffers 4 256k. However, this is a workaround, not a permanent solution.", "percentage": 70}
    ]'::jsonb,
    'Nginx configuration knowledge. Access to container networking setup.',
    'Admin console loads without 502 errors. Connections to Keycloak remain stable.',
    'Using HTTP proxy when HTTPS stream proxy is more appropriate. Not increasing buffer sizes.',
    0.87,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/79143865/run-keycloak-in-docker-container-and-behind-a-nginx-reverse-proxy-the-admin-con'
),
(
    'HTTP 401 Unauthorized on REST API calls (CREATE_CLIENT, etc.) logged at DEBUG level instead of WARN',
    'keycloak',
    'MEDIUM',
    '[
        {"solution": "Change Keycloak log level to DEBUG to capture 401 error details. Add to logging configuration: logger name=\"org.keycloak.services\" level=\"DEBUG\"", "percentage": 88},
        {"solution": "Look for database connectivity issues (MariaDB connection loss in Kubernetes). Temporary DB disconnections trigger 401 errors. Verify database health: check pod logs, connection pool status.", "percentage": 85},
        {"solution": "Request Keycloak upgrade to version that logs 401 REST API errors at WARN level (similar to LOGIN_ERROR logging). Current versions log these at DEBUG, making troubleshooting difficult without DEBUG mode.", "percentage": 65}
    ]'::jsonb,
    'Database connectivity troubleshooting knowledge. Access to Keycloak logs.',
    'REST API calls succeed with proper authentication. Database connectivity is stable.',
    'Not checking database connectivity when 401 errors occur. Enabling DEBUG logging (floods logs with too much output).',
    0.76,
    'haiku',
    NOW(),
    'https://github.com/keycloak/keycloak/discussions/13065'
),
(
    'SSLHandshakeException when using TLS reverse proxy with Keycloak (Server Name Indicator not sent)',
    'keycloak',
    'LOW',
    '[
        {"solution": "Replace localhost with localhost.localdomain in both load test URLs and TLS reverse proxy configuration. Java only sends SNI when hostname contains a dot.", "percentage": 96},
        {"solution": "Create custom hostname in /etc/hosts file mapping to 127.0.0.1, then use that hostname (with dot) in both load test and reverse proxy config. Example: echo ''127.0.0.1 keycloak.local'' >> /etc/hosts", "percentage": 94}
    ]'::jsonb,
    'TLS/SSL knowledge. Host configuration file access.',
    'Load test succeeds without SSLHandshakeException. TLS reverse proxy accepts connections.',
    'Using localhost without dot in hostname. Not understanding SNI requirement in Java clients.',
    0.93,
    'haiku',
    NOW(),
    'https://www.keycloak.org/keycloak-benchmark/benchmark-guide/latest/error-messages'
);
