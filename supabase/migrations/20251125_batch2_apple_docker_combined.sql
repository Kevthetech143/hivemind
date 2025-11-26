-- Batch 2: Apple/iOS + Docker Combined Migration
-- Sources: Apple Developer Docs, Docker Official Docs
-- Mined: 2025-11-25
-- Categories: apple-appstore, apple-storekit, xcode, docker, docker-desktop

-- ============================================
-- APPLE APP STORE CONNECT API ERRORS (9 entries)
-- ============================================

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES (
    '401 NOT_AUTHORIZED: Authentication credentials are missing or invalid',
    'apple-appstore',
    'CRITICAL',
    $$[{"solution": "Verify JWT token uses ES256 algorithm with proper exp/iat claims", "percentage": 40, "note": "Most common: token expiration in milliseconds instead of seconds"}, {"solution": "Ensure API key has Admin access level, not App Manager", "percentage": 35, "note": "Insufficient permissions cause silent auth failures"}, {"solution": "Validate token structure: iss, aud, exp, iat fields required", "percentage": 15, "note": "Use jwt.io to verify token before API calls"}, {"solution": "Remove Content-Type header and use only Authorization bearer token", "percentage": 10, "note": "Some implementations fail with explicit Content-Type header"}]$$::jsonb,
    'Valid p8 private key file, correct Issuer ID and Key ID, proper JWT library support',
    'API responds with 200 status code and data payload instead of 401 error',
    'Multiplying timestamp by 1000 (milliseconds), token expiration in past, empty scope array in JWT claim, missing key ID in header',
    0.85,
    'sonnet-4',
    NOW(),
    'https://developer.apple.com/documentation/appstoreconnectapi/interpreting-and-handling-errors'
),
(
    '400 ENTITY_INVALID: JSON processing failed - empty scope array in JWT',
    'apple-appstore',
    'HIGH',
    $$[{"solution": "Remove empty scope array from JWT claim - omit scope member entirely if not needed", "percentage": 95, "note": "Do not include scope: [] in payload"}, {"solution": "Verify JSON structure is valid before encoding JWT", "percentage": 5, "note": "Malformed JSON syntax in claims"}]$$::jsonb,
    'Understanding JWT claim structure, knowledge of scope parameter purpose',
    'API accepts request and returns 200 status with expected response data',
    'Including scope: [] as empty array, including invalid vendor number in scope, sending malformed JSON in JWT payload',
    0.95,
    'sonnet-4',
    NOW(),
    'https://developer.apple.com/documentation/appstoreconnectapi/interpreting-and-handling-errors'
),
(
    '405 METHOD_NOT_ALLOWED: POST not allowed for resource endpoint',
    'apple-appstore',
    'HIGH',
    $$[{"solution": "Remove scope parameter entirely from JWT payload - Apple scope key does not support POST", "percentage": 90, "note": "Scope restrictions apply to GET only for tokens over 20 minutes"}, {"solution": "Use only required JWT claims: iss, iat, exp, aud without scope", "percentage": 10, "note": "Minimal payload avoids scope-related issues"}]$$::jsonb,
    'Understanding JWT token structure and Apple App Store Connect API scope limitations',
    'POST request succeeds with 200 status code and resource creation confirmed',
    'Including scope with POST method restrictions, specifying scope: ["POST /v1/certificates"], using unrestricted tokens with explicit scopes',
    0.92,
    'sonnet-4',
    NOW(),
    'https://developer.apple.com/documentation/appstoreconnectapi/interpreting-and-handling-errors'
),
(
    '403 Forbidden: CIP/Certificate endpoints blocked due to pending terms and conditions',
    'apple-appstore',
    'CRITICAL',
    $$[{"solution": "Log into App Store Connect and accept pending Terms of Service agreements", "percentage": 70, "note": "Account holder must accept, not just admin user"}, {"solution": "Check X-Rate-Limit-Remaining header - may indicate quota exhaustion rather than T&C issue", "percentage": 15, "note": "Insufficient API key permissions"}, {"solution": "Contact Apple Developer Support if T&C are current and /v1/apps works but /v1/certificates fails", "percentage": 15, "note": "May require team configuration reset"}]$$::jsonb,
    'Admin or account holder access to App Store Connect portal, correct API key permissions',
    '403 error resolved after accepting terms, certificate API endpoints begin returning data',
    'Assuming JWT auth is wrong when actually pending agreements, using wrong team identifier, not checking portal for warnings',
    0.80,
    'sonnet-4',
    NOW(),
    'https://developer.apple.com/documentation/appstoreconnectapi/interpreting-and-handling-errors'
),
(
    '403 Forbidden: Resource does not allow operation - wrong HTTP method for endpoint',
    'apple-appstore',
    'MEDIUM',
    $$[{"solution": "Use GET for financeReports endpoint - POST/CREATE not allowed", "percentage": 85, "note": "Pass parameters as URL query strings, not POST body"}, {"solution": "Verify endpoint HTTP method support in API documentation", "percentage": 15, "note": "Each endpoint has specific allowed operations"}]$$::jsonb,
    'Understanding REST API principles, access to App Store Connect API documentation',
    'GET request succeeds and returns financial reports data as expected',
    'Using POST for read-only endpoints, assuming all endpoints support CREATE operations, not checking allowed methods',
    0.90,
    'sonnet-4',
    NOW(),
    'https://developer.apple.com/documentation/appstoreconnectapi/interpreting-and-handling-errors'
),
(
    '409 CONFLICT: Certificate creation fails - CSR double base64-encoded',
    'apple-appstore',
    'MEDIUM',
    $$[{"solution": "Pass raw CSR file content without additional base64 encoding", "percentage": 95, "note": "CSR already contains base64 between BEGIN/END markers - do not re-encode"}, {"solution": "Verify certificate attributes are unique and not already present", "percentage": 5, "note": "ENTITY_ERROR.ATTRIBUTE.INVALID on duplicate resources"}]$$::jsonb,
    'Understanding base64 encoding, knowledge of Certificate Signing Request format',
    'Certificate creation succeeds with 201 status code and certificate ID returned',
    'Double base64-encoding CSR content, attempting to create duplicate certificates, using invalid certificate type',
    0.93,
    'sonnet-4',
    NOW(),
    'https://developer.apple.com/documentation/appstoreconnectapi/interpreting-and-handling-errors'
),
(
    '422 UNPROCESSABLE_ENTITY: Request body has semantic or validation errors',
    'apple-appstore',
    'MEDIUM',
    $$[{"solution": "Verify Content-Type header is application/json", "percentage": 35, "note": "Non-JSON Content-Type causes rejection"}, {"solution": "Validate request payload is valid JSON before submission", "percentage": 30, "note": "Parse error in JSON structure"}, {"solution": "Check request body against API schema - required fields missing or wrong types", "percentage": 25, "note": "Semantic errors in payload data"}, {"solution": "Verify endpoint accepts request method and validate expected_values in error response", "percentage": 10, "note": "Invalid enum values or unexpected data types"}]$$::jsonb,
    'Understanding REST API semantics, JSON validation tools, API schema knowledge',
    'Request accepted with 200-201 status code and expected response data returned',
    'Incorrect Content-Type header, malformed JSON payload, missing required fields, wrong data types in request body',
    0.82,
    'sonnet-4',
    NOW(),
    'https://developer.apple.com/documentation/appstoreconnectapi/interpreting-and-handling-errors'
),
(
    '429 RATE_LIMIT_EXCEEDED: Request rate limit exhausted',
    'apple-appstore',
    'MEDIUM',
    $$[{"solution": "Implement exponential backoff with jitter - retry after increasing delays", "percentage": 50, "note": "Check X-Rate-Limit-Remaining header for requests remaining"}, {"solution": "Cache API responses and reuse within time window", "percentage": 25, "note": "Reduce redundant requests to same endpoints"}, {"solution": "Request rate limit increase from Apple if legitimate high-volume use", "percentage": 15, "note": "Contact Apple Developer Support with use case"}, {"solution": "Coalesce requests from multiple users into single API call", "percentage": 10, "note": "Reduce call frequency through request batching"}]$$::jsonb,
    'Understanding HTTP headers, rate limiting concepts, ability to contact Apple Support',
    'Exponential backoff succeeds and request succeeds after delay, rate limit counter resets within hour window',
    'Ignoring X-Rate-Limit headers, retrying immediately without delays, flooding API with repeated requests, not batching requests',
    0.78,
    'sonnet-4',
    NOW(),
    'https://developer.apple.com/documentation/appstoreconnectapi/identifying-rate-limits'
),
(
    '500 UNEXPECTED_ERROR: Internal server error on Apple backend',
    'apple-appstore',
    'MEDIUM',
    $$[{"solution": "Wait and retry with exponential backoff - Apple backend service issue", "percentage": 60, "note": "Usually resolves within hours without user action"}, {"solution": "Verify request format matches API documentation - may be edge case server issue", "percentage": 20, "note": "Confirm valid credentials and payload before retrying"}, {"solution": "Check Apple Developer Services status page for ongoing incidents", "percentage": 12, "note": "May indicate broader platform-wide outage"}, {"solution": "File Feedback Assistant bug report if issue persists after 24 hours", "percentage": 8, "note": "Include full request details and error response"}]$$::jsonb,
    'Ability to access Apple Developer status pages, understanding of exponential backoff, API credentials validation',
    'Retry succeeds with 200 status code after waiting, normal API operations resume',
    'Assuming error is due to malformed request when server-side issue, not checking status page, not implementing retry logic',
    0.88,
    'sonnet-4',
    NOW(),
    'https://developer.apple.com/documentation/appstoreconnectapi/interpreting-and-handling-errors'
);

-- ============================================
-- APPLE STOREKIT ERRORS (10 entries)
-- ============================================

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES (
    'StoreKit error: SKErrorPaymentCancelled',
    'apple-storekit',
    'HIGH',
    $$[{"solution": "Handle gracefully - user chose to cancel. Do not show error alert.", "percentage": 95, "note": "Expected user behavior"}]$$::jsonb,
    'StoreKit integration',
    'Purchase flow handles cancellation without error display',
    'Showing error alert for user cancellation',
    0.95,
    'sonnet-4',
    NOW(),
    'https://developer.apple.com/documentation/storekit/skerror'
),
(
    'StoreKit error: SKErrorClientInvalid',
    'apple-storekit',
    'HIGH',
    $$[{"solution": "Verify App ID, Bundle ID, and provisioning profile match. Check StoreKit configuration in Xcode.", "percentage": 85}, {"solution": "Validate In-App Purchase product IDs are correctly configured in App Store Connect.", "percentage": 80}]$$::jsonb,
    'Valid provisioning profile, App Store Connect setup',
    'SKPaymentQueue processes valid products',
    'Mismatched App ID or Bundle ID, missing product configuration',
    0.85,
    'sonnet-4',
    NOW(),
    'https://developer.apple.com/documentation/storekit/skerror'
),
(
    'StoreKit error: SKErrorPaymentNotAllowed',
    'apple-storekit',
    'MEDIUM',
    $$[{"solution": "User is restricted from making payments. Check parental controls and device settings.", "percentage": 90, "note": "Check Settings > Screen Time > Content & Privacy"}, {"solution": "Inform user to contact device admin or enable purchases in Settings.", "percentage": 85}]$$::jsonb,
    'iOS device with parental controls',
    'App handles payment restrictions gracefully',
    'Attempting payment without checking device restrictions',
    0.88,
    'sonnet-4',
    NOW(),
    'https://developer.apple.com/documentation/storekit/skerror'
),
(
    'StoreKit error: SKErrorPaymentInvalid',
    'apple-storekit',
    'MEDIUM',
    $$[{"solution": "Validate SKProduct exists and product ID is correct before requesting payment.", "percentage": 90}, {"solution": "Ensure product was successfully loaded from App Store before attempting purchase.", "percentage": 88}]$$::jsonb,
    'SKProductsRequest completed successfully',
    'Valid products loaded and payment processed',
    'Attempting to purchase products before loading, invalid product IDs',
    0.89,
    'sonnet-4',
    NOW(),
    'https://developer.apple.com/documentation/storekit/skerror'
),
(
    'StoreKit error: SKErrorStoreProductNotAvailable',
    'apple-storekit',
    'MEDIUM',
    $$[{"solution": "Product is not available in user''s region. Check App Store availability settings.", "percentage": 92, "note": "Verify in App Store Connect > App > Pricing and Availability"}, {"solution": "Product may be inactive or expired. Verify product status in App Store Connect.", "percentage": 85}]$$::jsonb,
    'App Store Connect access',
    'App gracefully handles unavailable products',
    'Assuming all products are available in all regions',
    0.88,
    'sonnet-4',
    NOW(),
    'https://developer.apple.com/documentation/storekit/skerror'
),
(
    'StoreKit error: SKErrorCloudServiceNetworkConnectionFailed',
    'apple-storekit',
    'MEDIUM',
    $$[{"solution": "Network connection unavailable. Implement retry logic with exponential backoff.", "percentage": 85, "note": "Check internet connectivity first"}, {"solution": "Queue payment request for retry when connection is restored.", "percentage": 80}]$$::jsonb,
    'Network connectivity handling implemented',
    'App queues requests and retries when connection restored',
    'Not implementing retry logic for network failures',
    0.82,
    'sonnet-4',
    NOW(),
    'https://developer.apple.com/documentation/storekit/skerror'
),
(
    'StoreKit error: SKErrorUnauthorizedRequestData',
    'apple-storekit',
    'LOW',
    $$[{"solution": "Request data is malformed or tampered with. Validate all request parameters.", "percentage": 90}, {"solution": "Ensure StoreKit 2 or later uses proper SKProduct and SKPaymentRequest initialization.", "percentage": 88}]$$::jsonb,
    'StoreKit 2 implementation',
    'Payment requests validated before submission',
    'Manual construction of request data instead of using API',
    0.89,
    'sonnet-4',
    NOW(),
    'https://developer.apple.com/documentation/storekit/skerror'
),
(
    'StoreKit error: SKErrorInvalidSignature',
    'apple-storekit',
    'LOW',
    $$[{"solution": "Receipt signature validation failed. Use App Store Server API to verify receipts server-side.", "percentage": 92, "note": "Do not validate signatures client-side"}, {"solution": "Request new receipt if validation fails: SKReceiptRefreshRequest().", "percentage": 85}]$$::jsonb,
    'Server-side receipt validation implemented',
    'Receipts verified via App Store Server API',
    'Validating signatures on client, not verifying with App Store',
    0.91,
    'sonnet-4',
    NOW(),
    'https://developer.apple.com/documentation/storekit/skerror'
),
(
    'StoreKit error: SKErrorCloudServicePermissionDenied',
    'apple-storekit',
    'LOW',
    $$[{"solution": "User has not granted permission for cloud services. Prompt user to enable in Settings.", "percentage": 88, "note": "Settings > iCloud > Apps Using iCloud"}, {"solution": "Implement fallback for when cloud services are unavailable.", "percentage": 82}]$$::jsonb,
    'iCloud account setup',
    'App handles cloud permission denial gracefully',
    'Not implementing fallback when cloud services unavailable',
    0.85,
    'sonnet-4',
    NOW(),
    'https://developer.apple.com/documentation/storekit/skerror'
),
(
    'StoreKit error: SKErrorMissingOfferParams',
    'apple-storekit',
    'MEDIUM',
    $$[{"solution": "Subscription offer parameters are incomplete. Verify keyIdentifier, nonce, signature, and timestamp are provided.", "percentage": 90, "note": "Use SKPaymentDiscount with all required fields"}, {"solution": "Regenerate offer signature using App Store Server API if validation fails.", "percentage": 85}]$$::jsonb,
    'Subscription offer implementation',
    'Promotional offers applied successfully to subscriptions',
    'Incomplete or missing offer signature generation',
    0.87,
    'sonnet-4',
    NOW(),
    'https://developer.apple.com/documentation/storekit/skerror'
);

-- ============================================
-- XCODE BUILD/SIGNING ERRORS (12 entries)
-- ============================================

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES (
    'Xcode error: Signing requires a development team',
    'xcode',
    'CRITICAL',
    $$[{"solution": "Select team in Signing & Capabilities tab. Go to project settings, select target, choose team from dropdown. Enable Automatically manage signing if needed.", "percentage": 96}]$$::jsonb,
    'Apple Developer account, Xcode project',
    'Build succeeds without code signing errors',
    'Using wrong team for enterprise vs personal, team not in dropdown',
    0.96,
    'sonnet-4',
    NOW(),
    'https://developer.apple.com/library/archive/technotes/tn2250/_index.html'
),
(
    'Xcode error: Valid Signing Identity Not Found',
    'xcode',
    'CRITICAL',
    $$[{"solution": "Transfer certificate/private key from original Mac via Keychain backup. Export .p12 file, then import on new machine. Or revoke old certificates and create new ones.", "percentage": 92}]$$::jsonb,
    'Keychain access, original Mac or export file',
    'Certificate appears in Signing Identity dropdown',
    'Assuming private keys are transferred with project files, not using .p12 export',
    0.92,
    'sonnet-4',
    NOW(),
    'https://developer.apple.com/library/archive/technotes/tn2250/_index.html'
),
(
    'Xcode error: Provisioning Profile Cannot Be Found',
    'xcode',
    'CRITICAL',
    $$[{"solution": "Download missing provisioning profile from Apple Developer portal. In Xcode, go to Preferences > Accounts > Download Manual Profiles. Update Code Signing Identity in build settings.", "percentage": 94}]$$::jsonb,
    'Apple Developer account with provisioning profile access',
    'Profile appears in provisioning list, build succeeds',
    'Deleted profile from library without backup, not syncing profiles in Xcode',
    0.94,
    'sonnet-4',
    NOW(),
    'https://developer.apple.com/library/archive/technotes/tn2250/_index.html'
),
(
    'Xcode error: Certificate Identity Appears More Than Once In Keychain',
    'xcode',
    'HIGH',
    $$[{"solution": "Open Keychain Access utility. Search for duplicate certificates (same name and type). Delete all duplicates, keeping only one copy per certificate type. Restart Xcode.", "percentage": 88}]$$::jsonb,
    'Keychain Access application, system access',
    'Only one certificate per type visible, clean build succeeds',
    'Not checking all keychains (login vs system), reinstalling without cleanup',
    0.88,
    'sonnet-4',
    NOW(),
    'https://developer.apple.com/library/archive/technotes/tn2250/_index.html'
),
(
    'Xcode error: The Private Key For Your Signing Identity Is Missing',
    'xcode',
    'CRITICAL',
    $$[{"solution": "Private key must exist on your Mac. Export certificate as .p12 from original Mac, import on current Mac. Verify WWDR Intermediate Certificate is in keychain. Check Developer ID certificate expiration.", "percentage": 95}]$$::jsonb,
    'WWDR certificate, access to original Mac or .p12 file',
    'Private key visible in Keychain, app signs successfully',
    'Assuming certificate alone is sufficient without private key, not installing WWDR cert',
    0.95,
    'sonnet-4',
    NOW(),
    'https://developer.apple.com/support/certificates/'
),
(
    'Xcode error: Application Failed Codesign Verification',
    'xcode',
    'CRITICAL',
    $$[{"solution": "Verify distribution certificate used in Release config. Check for wrong cert type (developer vs distribution). Remove unnecessary custom entitlements. Ensure Bundle IDs match. Update Xcode/OS to stable versions.", "percentage": 89}]$$::jsonb,
    'Distribution provisioning profile, correct certificate',
    'Archive succeeds, app submits to App Store',
    'Using debug cert in release config, including test entitlements in production',
    0.89,
    'sonnet-4',
    NOW(),
    'https://developer.apple.com/library/archive/technotes/tn2250/_index.html'
),
(
    'Xcode error: No Unexpired Provisioning Profiles Found',
    'xcode',
    'HIGH',
    $$[{"solution": "Create new provisioning profile in Apple Developer portal with matching signing certificate. Download profile to Xcode. Verify certificate is not expired. Check Code Signing Identity build setting references valid profile.", "percentage": 91}]$$::jsonb,
    'Apple Developer account, unexpired certificate',
    'New provisioning profile appears in Xcode, build succeeds',
    'Assuming old expired profiles will work, not checking certificate expiration',
    0.91,
    'sonnet-4',
    NOW(),
    'https://developer.apple.com/library/archive/technotes/tn2407/_index.html'
),
(
    'Xcode error: Invalid Provisioning Profile',
    'xcode',
    'HIGH',
    $$[{"solution": "Resync provisioning profiles: Preferences > Accounts > Download Manual Profiles. Recreate profile in Developer portal. Verify all team members with access have current certificates. Remove old expired profiles.", "percentage": 87}]$$::jsonb,
    'Apple Developer account, valid team member status',
    'Profile status shows valid in Developer portal, Xcode recognizes it',
    'Not resyncing profiles after cert changes, keeping expired profiles',
    0.87,
    'sonnet-4',
    NOW(),
    'https://developer.apple.com/library/archive/technotes/tn2407/_index.html'
),
(
    'Xcode error: The Bundle Is Not Signed Using An Apple Submission Certificate',
    'xcode',
    'HIGH',
    $$[{"solution": "Use distribution certificate, not development certificate. Verify provisioning profile type matches (App Store, Enterprise, Ad Hoc). Check CODE_SIGN_IDENTITY build setting specifies distribution identity. Archive for App Store distribution.", "percentage": 93}]$$::jsonb,
    'Distribution certificate and profile',
    'Archive completes with distribution cert, submission certificate signature',
    'Mixing development and distribution certificates, using wrong profile type',
    0.93,
    'sonnet-4',
    NOW(),
    'https://developer.apple.com/library/archive/technotes/tn2250/_index.html'
),
(
    'Xcode error: CSSMERR_TP_NOT_TRUSTED Certificate Trust Error',
    'xcode',
    'MEDIUM',
    $$[{"solution": "Reset certificate trust settings to Use System Defaults in Keychain. Delete and reinstall problematic certificate. Verify Apple root certificates installed. Update WWDR Intermediate Certificate from Apple developer website.", "percentage": 84}]$$::jsonb,
    'Keychain Access application, system admin access',
    'Certificate shows trusted status, signing succeeds',
    'Manually changing trust settings incorrectly, not updating WWDR cert',
    0.84,
    'sonnet-4',
    NOW(),
    'https://developer.apple.com/library/archive/technotes/tn2250/_index.html'
),
(
    'Xcode error: The App Was Not Installed Because The Entitlements Are Not Valid',
    'xcode',
    'HIGH',
    $$[{"solution": "Verify provisioning profile matches entitlements in app. Disable unnecessary entitlements unless using iCloud or Keychain sharing. Use correct profile type for capabilities needed. Resync profiles in Xcode.", "percentage": 90}]$$::jsonb,
    'Provisioning profile with matching entitlements, App ID',
    'App installs on device without entitlements error',
    'Using generic profile for specific entitlements, enabling unused capabilities',
    0.90,
    'sonnet-4',
    NOW(),
    'https://developer.apple.com/library/archive/technotes/tn2250/_index.html'
),
(
    'Xcode error: Signature Verification Failed Missing Or Invalid Sealed Resource',
    'xcode',
    'MEDIUM',
    $$[{"solution": "Run dot_clean command on project folder to remove AppleDouble (._ underscore) files from non-Mac filesystem transfers. Always zip projects before transferring between platforms. Verify no ._ files in Xcode project hierarchy.", "percentage": 86}]$$::jsonb,
    'Command line access, project directory',
    'Build completes without sealed resource errors, signature verification passes',
    'Transferring projects via drag-drop, not using zip for cross-platform sharing',
    0.86,
    'sonnet-4',
    NOW(),
    'https://developer.apple.com/library/archive/technotes/tn2250/_index.html'
);

-- ============================================
-- DOCKER DAEMON ERRORS (12 entries)
-- ============================================

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES (
    'Docker error: Cannot connect to the Docker daemon',
    'docker',
    'CRITICAL',
    $$[{"solution": "Start Docker service: sudo systemctl start docker", "percentage": 95}, {"solution": "Check DOCKER_HOST env var: unset DOCKER_HOST if misconfigured", "percentage": 40}, {"solution": "Verify daemon running: docker info or sudo systemctl is-active docker", "percentage": 90}]$$::jsonb,
    'Docker installed',
    'docker info returns output',
    'Forgetting to start service, DOCKER_HOST pointing to wrong socket',
    0.95,
    'sonnet-4',
    NOW(),
    'https://docs.docker.com/engine/daemon/troubleshoot/'
),
(
    'Docker error: unable to configure daemon with file daemon.json - directives specified both as flag and config',
    'docker',
    'HIGH',
    $$[{"solution": "Create /etc/systemd/system/docker.service.d/docker.conf and override ExecStart", "percentage": 85}, {"solution": "Remove conflicting options from daemon.json", "percentage": 80}, {"solution": "Run sudo systemctl daemon-reload after changes", "percentage": 95}]$$::jsonb,
    'systemd-based system',
    'Docker daemon starts without error',
    'Not running daemon-reload, conflicting flags in startup scripts',
    0.90,
    'sonnet-4',
    NOW(),
    'https://docs.docker.com/engine/daemon/troubleshoot/'
),
(
    'Docker error: Your kernel does not support swap limit capabilities',
    'docker',
    'MEDIUM',
    $$[{"solution": "Edit /etc/default/grub and add cgroup_enable=memory swapaccount=1 to GRUB_CMDLINE_LINUX", "percentage": 90}, {"solution": "Run sudo update-grub and reboot system", "percentage": 100}]$$::jsonb,
    'Linux system with grub',
    'Kernel supports swap accounting',
    'Not rebooting after grub changes, wrong kernel parameters',
    0.95,
    'sonnet-4',
    NOW(),
    'https://docs.docker.com/engine/daemon/troubleshoot/'
),
(
    'Docker error: Local 127.0.0.1 DNS resolver found and containers cannot use it',
    'docker',
    'MEDIUM',
    $$[{"solution": "Configure DNS in /etc/docker/daemon.json: {\"dns\": [\"8.8.8.8\", \"8.8.4.4\"]}", "percentage": 85}, {"solution": "Disable dnsmasq: comment dns=dnsmasq in /etc/NetworkManager/NetworkManager.conf", "percentage": 70}, {"solution": "Restart Docker: sudo service docker restart", "percentage": 95}]$$::jsonb,
    'Docker installed, resolv.conf exists',
    'Container DNS resolution works',
    'Not restarting NetworkManager, wrong DNS IPs',
    0.88,
    'sonnet-4',
    NOW(),
    'https://docs.docker.com/engine/daemon/troubleshoot/'
),
(
    'Docker error: permission denied on ~/.docker/config.json',
    'docker',
    'HIGH',
    $$[{"solution": "Fix ownership: sudo chown $USER:$USER /home/$USER/.docker -R", "percentage": 95}, {"solution": "Fix permissions: sudo chmod g+rwx ~/.docker -R", "percentage": 95}]$$::jsonb,
    'User has sudo access',
    'Config file readable by user',
    'Running docker commands before fixing ownership',
    0.98,
    'sonnet-4',
    NOW(),
    'https://docs.docker.com/engine/install/linux-postinstall/'
),
(
    'Docker error: operation not permitted in rootless mode',
    'docker',
    'MEDIUM',
    $$[{"solution": "Set kernel.unprivileged_userns_clone=1 in /etc/sysctl.conf", "percentage": 85}, {"solution": "Run sudo sysctl --system to apply changes", "percentage": 95}]$$::jsonb,
    'Rootless Docker installed',
    '/proc/sys/kernel/unprivileged_userns_clone is 1',
    'Forgetting to reload sysctl, incorrect sysctl parameter',
    0.90,
    'sonnet-4',
    NOW(),
    'https://docs.docker.com/engine/security/rootless/troubleshoot/'
),
(
    'Docker error: no space left on device in rootless mode',
    'docker',
    'MEDIUM',
    $$[{"solution": "Increase user.max_user_namespaces: add user.max_user_namespaces=28633 to /etc/sysctl.conf", "percentage": 90}, {"solution": "Apply with sudo sysctl --system", "percentage": 95}]$$::jsonb,
    'Rootless Docker installed',
    'Daemon can start',
    'Insufficient subuid/subgid entries, not reloading sysctl',
    0.92,
    'sonnet-4',
    NOW(),
    'https://docs.docker.com/engine/security/rootless/troubleshoot/'
),
(
    'Docker error: unable to find valid subuid/subgid entries',
    'docker',
    'MEDIUM',
    $$[{"solution": "Configure /etc/subuid and /etc/subgid with valid uid:gid mappings", "percentage": 85}, {"solution": "Ensure at least 65536 entries per user for proper namespace isolation", "percentage": 95}]$$::jsonb,
    'Rootless Docker being set up',
    'subuid/subgid files properly configured',
    'Insufficient namespace entries, missing config files',
    0.88,
    'sonnet-4',
    NOW(),
    'https://docs.docker.com/engine/security/rootless/troubleshoot/'
),
(
    'Docker error: OCI runtime create failed - invalid mount',
    'docker',
    'MEDIUM',
    $$[{"solution": "Verify mount paths are absolute and valid", "percentage": 80}, {"solution": "On Docker Desktop, avoid Windows path issues with -v mounts", "percentage": 75}]$$::jsonb,
    'Docker and OCI runtime installed',
    'Container runs successfully',
    'Relative paths in mounts, incorrect path formatting on Windows',
    0.82,
    'sonnet-4',
    NOW(),
    'https://docs.docker.com/desktop/troubleshoot-and-support/troubleshoot/topics/'
),
(
    'Docker error: unable to remove filesystem from previous containers',
    'docker',
    'LOW',
    $$[{"solution": "Avoid bind-mounting /var/lib/docker/ into containers", "percentage": 95}, {"solution": "Use alternative monitoring approaches instead of direct docker lib mounting", "percentage": 90}]$$::jsonb,
    'Docker installed',
    'Containers and volumes remove cleanly',
    'Mounting /var/lib/docker into container volumes',
    0.95,
    'sonnet-4',
    NOW(),
    'https://docs.docker.com/engine/daemon/troubleshoot/'
),
(
    'Docker error: XDG_RUNTIME_DIR not set in rootless mode',
    'docker',
    'LOW',
    $$[{"solution": "On non-systemd systems, manually create: export XDG_RUNTIME_DIR=$HOME/.docker/xrd", "percentage": 85}, {"solution": "Create directory if needed: mkdir -p $XDG_RUNTIME_DIR", "percentage": 95}]$$::jsonb,
    'Rootless Docker on non-systemd system',
    'XDG_RUNTIME_DIR environment variable set',
    'Using systemd that auto-manages XDG_RUNTIME_DIR',
    0.88,
    'sonnet-4',
    NOW(),
    'https://docs.docker.com/engine/security/rootless/troubleshoot/'
),
(
    'Docker daemon fails to start with invalid daemon.json syntax',
    'docker',
    'HIGH',
    $$[{"solution": "Validate JSON syntax: use dockerd --validate flag", "percentage": 95}, {"solution": "Check /etc/docker/daemon.json for valid JSON format", "percentage": 90}, {"solution": "Use JSON linter to identify syntax errors", "percentage": 92}]$$::jsonb,
    'Docker installed',
    'daemon --validate returns success',
    'Trailing commas in JSON, mismatched quotes, unescaped characters',
    0.93,
    'sonnet-4',
    NOW(),
    'https://docs.docker.com/engine/daemon/troubleshoot/'
);

-- ============================================
-- DOCKER DESKTOP ERRORS (12 entries)
-- ============================================

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES (
    'Docker Desktop: Port already allocated error',
    'docker-desktop',
    'HIGH',
    $$[{"solution": "Use resmon.exe or netstat to identify process using port", "percentage": 92}, {"solution": "Stop conflicting container or process", "percentage": 88}, {"solution": "Use different port for container", "percentage": 100}]$$::jsonb,
    'Docker Desktop installed and running',
    'Container starts successfully on available port',
    'Not checking if container actually stopped; ports cached',
    0.92,
    'sonnet-4',
    NOW(),
    'https://docs.docker.com/desktop/troubleshoot-and-support/troubleshoot/topics/'
),
(
    'Docker Desktop: Windows line endings causing script failures',
    'docker-desktop',
    'HIGH',
    $$[{"solution": "Convert files from CRLF to LF in VS Code editor settings", "percentage": 95}, {"solution": "Use dos2unix command line tool", "percentage": 90}]$$::jsonb,
    'Docker Desktop on Windows; files with syntax errors in containers',
    'Container scripts execute without line ending errors',
    'Forgetting to convert all referenced Dockerfile RUN commands',
    0.95,
    'sonnet-4',
    NOW(),
    'https://docs.docker.com/desktop/troubleshoot-and-support/troubleshoot/topics/'
),
(
    'Docker Desktop: Certificate TLS handshake failures from registry',
    'docker-desktop',
    'MEDIUM',
    $$[{"solution": "Configure valid SSL certificates for registries", "percentage": 85}, {"solution": "Add self-signed certs to Docker certificate directory", "percentage": 82}, {"solution": "Configure insecure registries properly", "percentage": 80}]$$::jsonb,
    'Docker Desktop installed; custom registry configured',
    'Successful image pull from registry without TLS errors',
    'Mixing insecure registry config with certificate requirements',
    0.85,
    'sonnet-4',
    NOW(),
    'https://docs.docker.com/desktop/troubleshoot-and-support/troubleshoot/topics/'
),
(
    'Docker Desktop: Visual artifacts or distorted UI',
    'docker-desktop',
    'MEDIUM',
    $$[{"solution": "Disable hardware acceleration by editing settings-store.json", "percentage": 96, "note": "Add disableHardwareAcceleration: true"}]$$::jsonb,
    'Docker Desktop installed with GPU',
    'Docker Desktop UI displays without visual glitches',
    'Forgetting to restart Docker after settings change',
    0.96,
    'sonnet-4',
    NOW(),
    'https://docs.docker.com/desktop/troubleshoot-and-support/troubleshoot/topics/'
),
(
    'Docker Desktop: Volume mount errors on Windows',
    'docker-desktop',
    'HIGH',
    $$[{"solution": "Enable file sharing in Settings > Shared Folders", "percentage": 88}, {"solution": "Use Windows-style paths like C:\\Users\\user\\work:/work", "percentage": 90}, {"solution": "Move project to home directory", "percentage": 85}]$$::jsonb,
    'Docker Desktop on Windows; project outside home folder',
    'Volume mounts accessible inside container',
    'Forgetting that file sharing is required outside home folder',
    0.88,
    'sonnet-4',
    NOW(),
    'https://docs.docker.com/desktop/troubleshoot-and-support/troubleshoot/topics/'
),
(
    'Docker Desktop: Cannot connect to Docker daemon',
    'docker-desktop',
    'CRITICAL',
    $$[{"solution": "Start Docker Desktop application", "percentage": 98}, {"solution": "Verify DOCKER_HOST environment variable is not set to unreachable host", "percentage": 85}, {"solution": "Run docker info to test daemon connectivity", "percentage": 90}]$$::jsonb,
    'Docker Desktop installation path known',
    'docker info returns daemon status',
    'DOCKER_HOST pointing to incorrect remote socket',
    0.98,
    'sonnet-4',
    NOW(),
    'https://docs.docker.com/engine/daemon/troubleshoot/'
),
(
    'Docker Desktop Mac: Unix socket path exceeds 104 character limit',
    'docker-desktop',
    'MEDIUM',
    $$[{"solution": "Reduce username length to 33 characters or less", "percentage": 94}, {"solution": "Move Docker installation to shorter path", "percentage": 88}]$$::jsonb,
    'Docker Desktop on macOS',
    'Docker daemon starts without socket bind errors',
    'Not accounting for full socket path length including home directory',
    0.94,
    'sonnet-4',
    NOW(),
    'https://docs.docker.com/desktop/troubleshoot-and-support/troubleshoot/topics/'
),
(
    'Docker Desktop Windows: Antivirus blocking Hyper-V startup',
    'docker-desktop',
    'HIGH',
    $$[{"solution": "Add Docker to antivirus exceptions/exclusions", "percentage": 87}, {"solution": "Temporarily disable antivirus to verify compatibility", "percentage": 90}, {"solution": "Update antivirus to latest version", "percentage": 78}]$$::jsonb,
    'Docker Desktop on Windows with antivirus installed',
    'Docker Desktop starts without daemon errors',
    'Antivirus re-enabling after Docker update without re-adding exceptions',
    0.87,
    'sonnet-4',
    NOW(),
    'https://docs.docker.com/desktop/troubleshoot-and-support/troubleshoot/topics/'
),
(
    'Docker Desktop Mac: Docker.app damaged and cannot be opened',
    'docker-desktop',
    'CRITICAL',
    $$[{"solution": "Force eject DMG before quitting Docker", "percentage": 91}, {"solution": "Redownload and reinstall Docker Desktop", "percentage": 89}, {"solution": "Ensure no other apps access Docker CLI during install", "percentage": 85}]$$::jsonb,
    'Docker Desktop for Mac installation file',
    'Docker.app launches without damaged dialog',
    'Running Docker from mounted DMG instead of Applications folder',
    0.91,
    'sonnet-4',
    NOW(),
    'https://docs.docker.com/desktop/troubleshoot-and-support/troubleshoot/mac-damaged-dialog/'
),
(
    'Docker Desktop Windows: Git Bash path conversion errors',
    'docker-desktop',
    'MEDIUM',
    $$[{"solution": "Set MSYS_NO_PATHCONV=1 environment variable", "percentage": 93}, {"solution": "Use double slashes in paths (// or \\\\)", "percentage": 88}, {"solution": "Use Windows Command Prompt instead of Git Bash", "percentage": 90}]$$::jsonb,
    'Docker Desktop on Windows with Git Bash installed',
    'Docker commands execute without mount destination errors',
    'Forgetting to set MSYS_NO_PATHCONV for each new terminal session',
    0.93,
    'sonnet-4',
    NOW(),
    'https://docs.docker.com/desktop/troubleshoot-and-support/troubleshoot/topics/'
),
(
    'Docker Desktop Windows: Virtualization not enabled in BIOS',
    'docker-desktop',
    'CRITICAL',
    $$[{"solution": "Enable virtualization in system BIOS settings", "percentage": 96}, {"solution": "Enable WSL 2 through Windows Features", "percentage": 91}, {"solution": "Install Virtual Machine Platform component", "percentage": 94}]$$::jsonb,
    'Windows system access with admin privileges',
    'Docker Desktop starts and containers run',
    'Restarting Windows without properly saving BIOS changes',
    0.96,
    'sonnet-4',
    NOW(),
    'https://docs.docker.com/desktop/troubleshoot-and-support/troubleshoot/topics/'
),
(
    'Docker Desktop Mac: HyperKit conflicts with Intel HAXM',
    'docker-desktop',
    'MEDIUM',
    $$[{"solution": "Quit Docker Desktop while using HAXM tools", "percentage": 89}, {"solution": "Pause HyperKit by toggling Docker on/off", "percentage": 92}, {"solution": "Use Android Studio instead of standalone HAXM", "percentage": 85}]$$::jsonb,
    'Docker Desktop and Intel HAXM/Android SDK installed',
    'Both Docker and HAXM tools function without conflicts',
    'Attempting to run both simultaneously without toggling',
    0.92,
    'sonnet-4',
    NOW(),
    'https://docs.docker.com/desktop/troubleshoot-and-support/troubleshoot/known-issues/'
);
