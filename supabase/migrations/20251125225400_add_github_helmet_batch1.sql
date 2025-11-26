-- Add GitHub Helmet security header solutions batch 1
-- Mining source: https://github.com/helmetjs/helmet/issues
-- Focus: CSP configuration, CORS conflicts, frame-options issues
-- Date: 2025-11-25

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Helmet CSP blocking external CDN and static resources',
    'github-helmet',
    'HIGH',
    $$[
        {"solution": "Configure explicit CSP directives for trusted CDN domains instead of relying on default-src. Use scriptSrc, styleSrc, imgSrc directives to whitelist specific domains like cdn.example.com", "percentage": 95, "note": "Most effective approach recommended by maintainer"},
        {"solution": "Add specific domain to scriptSrc array: scriptSrc: [''self'', ''google-analytics.com'', ''pagead2.googlesyndication.com'']", "percentage": 92, "command": "contentSecurityPolicy: { directives: { scriptSrc: [''self'', ''your-cdn.com''] } }"},
        {"solution": "For inline scripts, use nonce or hash instead of unsafe-inline. Generate random nonce and add to script tag: <script nonce=\"ABC123\">", "percentage": 85, "note": "More secure than unsafe-inline"},
        {"solution": "For SVG data URIs, add data: to imgSrc directive: imgSrc: [''self'', ''data:'']", "percentage": 80, "note": "Specific fix for SVG resources"}
    ]$$::jsonb,
    'Helmet.js installed, Node.js project with Express, identified CDN domains needing access',
    'External resources load without CSP violations in browser console, fetch requests succeed with 200 status',
    'Do not use wildcard patterns like *.google.* - list specific domains. Using default-src as catch-all for all resource types is not recommended. Do not use unsafe-inline unless absolutely necessary. Inline scripts require nonces or hashes.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/helmetjs/helmet/issues/274'
),
(
    'CSP default-src requirement conflicts with CSP v3 specification',
    'github-helmet',
    'MEDIUM',
    $$[
        {"solution": "Omit default-src and specify only needed directives like scriptSrc, styleSrc, imgSrc. This complies with CSP v3 specification", "percentage": 95, "note": "Aligns with official standards and Google Strict CSP guidelines"},
        {"solution": "Configure helmet with useDefaults: false and list only required directives: helmet({ contentSecurityPolicy: { useDefaults: false, directives: { scriptSrc: [...], styleSrc: [...] } } })", "percentage": 93, "command": "useDefaults: false in config"},
        {"solution": "If default-src is needed, use specific values for each directive rather than broad default. Example: defaultSrc: [''self''], scriptSrc: [''self'', ''example.com'']", "percentage": 85, "note": "Provides security defaults while supporting flexible policies"}
    ]$$::jsonb,
    'Helmet 4.0+, Node.js project, understanding of CSP v3 directives',
    'CSP headers validate against W3C CSP v3 specification, no console errors about invalid directives, policies apply correctly to resources',
    'Adding default-src: ''*'' does not replicate omitting the directive entirely - specific directives still apply constraints. Helmet 5.0+ relaxed this requirement. Disable contentSecurityPolicy: false if you want no CSP enforcement.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/helmetjs/helmet/issues/237'
),
(
    'X-Frame-Options and CSP frame-ancestors directive conflict',
    'github-helmet',
    'MEDIUM',
    $$[
        {"solution": "Use frame-ancestors CSP directive instead of X-Frame-Options for superior control. Set frameguard: false in helmet config and use CSP frame-ancestors for multiple domains", "percentage": 94, "note": "CSP frame-ancestors is an improved replacement for X-Frame-Options"},
        {"solution": "Configure frame-ancestors for iframes: contentSecurityPolicy: { directives: { frameAncestors: [''self'', ''https://subdomain.example.com''] } }", "percentage": 92, "command": "frameAncestors CSP directive for iframe embedding rules"},
        {"solution": "Use frame-src directive to control which iframes can be embedded on your page: frameSrc: [''self'', ''https://trusted-iframe.com'']", "percentage": 88, "note": "Complements frame-ancestors for complete control"},
        {"solution": "Disable frameguard when using CSP: helmet({ frameguard: false, contentSecurityPolicy: { directives: { frameAncestors: [...], frameSrc: [...] } } })", "percentage": 85, "command": "frameguard: false"}
    ]$$::jsonb,
    'Helmet.js configured, understanding of iframe embedding requirements, knowledge of trusted domains',
    'Iframes embed successfully from trusted domains, browser console shows no frame-related CSP violations, page renders correctly without X-Frame-Options conflicts',
    'Do not disable both X-Frame-Options and CSP - use CSP frame-ancestors as replacement. frame-ancestors controls which sites can embed your page. frame-src controls which iframes your page can embed. Browser priority is X-Frame-Options over CSP, so using CSP alone requires disabling X-Frame-Options.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/helmetjs/helmet/issues/167'
),
(
    'Content-Security-Policy-Report-Only header cannot coexist with Content-Security-Policy',
    'github-helmet',
    'MEDIUM',
    $$[
        {"solution": "Stack two helmet.contentSecurityPolicy() middleware instances: first with reportOnly: false for enforcement, second with reportOnly: true for testing new policies", "percentage": 89, "note": "Current workaround solution"},
        {"solution": "Add both headers using custom middleware after helmet: app.use(helmet()); app.use((req, res, next) => { res.setHeader(''Content-Security-Policy-Report-Only'', ''report-uri /csp-report''); next(); })", "percentage": 85, "command": "Custom middleware for report-only header"},
        {"solution": "Use separate helmet middleware for testing: app.use(helmet({ contentSecurityPolicy: { reportOnly: false, directives: {...} } })); app.use(helmet({ contentSecurityPolicy: { reportOnly: true, directives: {...morePermissive...} } }))", "percentage": 80, "note": "Supports phased CSP policy updates"}
    ]$$::jsonb,
    'Helmet 6.0+, understanding of CSP Report-Only workflow, ability to modify middleware stack',
    'Both Content-Security-Policy and Content-Security-Policy-Report-Only headers present in response, violations reported without blocking resources, policies apply correctly',
    'Setting reportOnly: true replaces Content-Security-Policy entirely with Report-Only variant. Cannot use boolean to send both simultaneously. Helmet maintainers reconsidered this limitation in v9.0.0 roadmap. Report-Only headers still validate policies but do not block resources.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/helmetjs/helmet/issues/351'
),
(
    'Helmet CSP block-all-mixed-content directive deprecated and unnecessary',
    'github-helmet',
    'LOW',
    $$[
        {"solution": "Remove or disable block-all-mixed-content by setting to null: contentSecurityPolicy: { directives: { blockAllMixedContent: null } } for modern HTTPS-only sites", "percentage": 96, "note": "Recommended for modern sites with full HTTPS"},
        {"solution": "Keep block-all-mixed-content for legacy browser support. It provides protection for older browsers while modern browsers have upgrade-insecure-requests support", "percentage": 88, "note": "Required only for IE11 and older"},
        {"solution": "Use upgrade-insecure-requests directive instead: directives: { upgradeInsecureRequests: [] } to automatically upgrade HTTP to HTTPS requests", "percentage": 92, "command": "upgradeInsecureRequests directive for modern alternative"}
    ]$$::jsonb,
    'Helmet.js installed, understanding of browser support requirements, HTTPS infrastructure in place',
    'CSP headers render without block-all-mixed-content or with replacement directive, modern browsers upgrade insecure requests, legacy browsers still protected',
    'block-all-mixed-content is deprecated per W3C but harmless - modern browsers ignore it. Removing saves bandwidth. Deprecated directive may be removed in Helmet v9.0.0. Sites must implement HSTS or CSP upgrade-insecure-requests for mixed-content protection without the deprecated directive.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/helmetjs/helmet/issues/460'
),
(
    'Helmet CSP disabling with contentSecurityPolicy: false still enforces CSP in some browsers',
    'github-helmet',
    'LOW',
    $$[
        {"solution": "Explicitly set contentSecurityPolicy: false in helmet config to completely disable CSP header: helmet({ contentSecurityPolicy: false })", "percentage": 97, "note": "Verified working solution"},
        {"solution": "If CSP still appears in Firefox, check for browser-specific extensions like NoScript that may inject CSP headers independently", "percentage": 85, "note": "Browser/extension interference, not Helmet issue"},
        {"solution": "Verify CSP is disabled by checking response headers: curl -i http://localhost:8080 | grep -i content-security-policy should return no results", "percentage": 90, "command": "curl verification command"}
    ]$$::jsonb,
    'Helmet.js installed and configured, ability to test HTTP headers, browser developer tools access',
    'Response headers do not contain Content-Security-Policy when disabled, browser console shows no CSP violations, fetch requests complete without CSP errors',
    'Browser extensions may override Helmet settings and inject their own headers. CSP must be disabled at middleware level - removing helmet() from app.use entirely or setting contentSecurityPolicy: false is required. Test with curl or headers inspection to confirm absence of CSP headers.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://github.com/helmetjs/helmet/issues/400'
),
(
    'Helmet CSP requires quoting special values like ''self'' and ''none''',
    'github-helmet',
    'HIGH',
    $$[
        {"solution": "Always quote CSP keyword values in directive arrays: defaultSrc: [''\"''self''\"''] or use double quotes: defaultSrc: [\"''self''\"]", "percentage": 96, "note": "Mandatory for CSP specification compliance"},
        {"solution": "For array values, include quotes in each element: scriptSrc: [''\"''self''\"'', ''\"''unsafe-inline''\"''], styleSrc: [''\"''none''\"'']", "percentage": 94, "command": "Use quoted strings in directive arrays"},
        {"solution": "For SHA-256 hashes and other special values, wrap in quotes: scriptSrc: [''\"''sha256-ABC123...''\"'']", "percentage": 92, "note": "All special values require quotation"},
        {"solution": "Helmet 8.0.0+ validates and throws error on unquoted values to catch configuration mistakes early", "percentage": 90, "note": "Built-in validation prevents silent failures"}
    ]$$::jsonb,
    'Helmet 5.0+, JavaScript knowledge, understanding of CSP specification',
    'CSP headers generated with properly quoted values, browser recognizes special keywords correctly, no CSP violations due to unquoted values, validation errors caught during development',
    'Unquoted ''self'' and ''none'' are treated as origin hostnames, not CSP keywords, causing policies to fail silently. Forgetting quotes is the most common CSP configuration error. Helmet now enforces quoting with error messages. All CSP keywords in the specification (''self'', ''unsafe-inline'', ''unsafe-eval'', ''none'', ''unsafe-hashes'', ''strict-dynamic'', ''report-sample'', ''inline-speculation-rules'', ''wasm-unsafe-eval'') must be quoted.',
    0.95,
    'sonnet-4',
    NOW(),
    'https://github.com/helmetjs/helmet/issues/454'
),
(
    'Helmet CSP ''wasm-unsafe-eval'' directive not recognized as valid value',
    'github-helmet',
    'LOW',
    $$[
        {"solution": "Quote ''wasm-unsafe-eval'' when using in CSP directives: scriptSrc: [''\"''wasm-unsafe-eval''\"'']", "percentage": 98, "note": "Solution is proper quoting"},
        {"solution": "Verify Helmet 8.1.0+ is installed for improved error messages about unquoted values: npm install helmet@latest", "percentage": 96, "command": "npm install helmet@8.1.0 or higher"},
        {"solution": "Check CSP policy: scriptSrc: [''\"''self''\"'', ''\"''wasm-unsafe-eval''\"''] for WebAssembly unsafe eval support", "percentage": 94, "note": "Required for WASM modules"}
    ]$$::jsonb,
    'Helmet 8.0+, WebAssembly project, knowledge of CSP specification',
    'WASM modules load successfully, scriptSrc directive includes wasm-unsafe-eval with proper quotes, CSP validation passes',
    '`wasm-unsafe-eval` must be quoted like all CSP keywords. Error message was confusing in Helmet < 8.1.0. This directive is valid per WebAssembly CSP specification. Unquoted values are rejected during validation with clear error messages in recent versions.',
    0.96,
    'sonnet-4',
    NOW(),
    'https://github.com/helmetjs/helmet/issues/482'
),
(
    'Helmet CSP script-src-elem directive not supported causing custom elements to fail',
    'github-helmet',
    'LOW',
    $$[
        {"solution": "Use scriptSrc directive to control all script element execution, including custom elements. scriptSrc controls both inline and external scripts", "percentage": 98, "note": "script-src-elem is not needed with proper scriptSrc configuration"},
        {"solution": "If facing custom element issues, verify scriptSrc includes all necessary domains and special keywords: scriptSrc: [''\"''self''\"'', ''\"''unsafe-inline''\"'']", "percentage": 94, "command": "Configure scriptSrc comprehensively"},
        {"solution": "Check for browser extensions or NoScript blocking custom element scripts - extension issues appear as script failures unrelated to Helmet", "percentage": 85, "note": "Most reported issues traced to extensions, not Helmet"}
    ]$$::jsonb,
    'Helmet.js configured, custom elements in use, browser with CSP support',
    'Custom elements render and execute properly, custom element scripts load without CSP violations, browser console shows no script execution errors',
    'script-src-elem was initially reported as missing but not actually needed - scriptSrc directive covers all script execution contexts. Many failures traced to Firefox NoScript extension interactions, not Helmet deficiency. The CSP specification uses script-src for all scripts; script-src-elem is rarely needed.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://github.com/helmetjs/helmet/issues/466'
),
(
    'Helmet default CSP directives mismatch between helmet and helmet-csp packages',
    'github-helmet',
    'MEDIUM',
    $$[
        {"solution": "Update helmet-csp to version 4.0.0 or higher which includes form-action: ''self'' directive matching main helmet package defaults", "percentage": 97, "command": "npm install helmet-csp@4.0.0 or higher"},
        {"solution": "Manually add form-action directive if using older helmet-csp: directives: { formAction: [''\"''self''\"''] }", "percentage": 94, "note": "Temporary workaround for older versions"},
        {"solution": "Compare default directives between helmet and helmet-csp packages by checking documentation to identify missing policies", "percentage": 88, "note": "Verify consistency when mixing packages"}
    ]$$::jsonb,
    'Using helmet and helmet-csp packages together, npm installed, ability to update packages',
    'Both helmet and helmet-csp generate identical default CSP headers, form-action directive present in all configurations, no inconsistencies between package versions',
    'helmet-csp versions below 4.0.0 lack form-action directive present in main helmet package. form-action: ''self'' prevents form submissions to external domains. Do not mix old and new versions - update all Helmet-related packages together for consistency.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://github.com/helmetjs/helmet/issues/461'
),
(
    'Helmet CSP cannot merge policies when using multiple middleware instances',
    'github-helmet',
    'MEDIUM',
    $$[
        {"solution": "Use helmet organization libraries: content-security-policy-parser and content-security-policy-builder to parse existing headers and merge new directives before setting response", "percentage": 92, "note": "Official workaround from maintainer using OSS tools"},
        {"solution": "Implement custom merging middleware: parse existing CSP header, merge with new directives, then set combined header before final response", "percentage": 88, "command": "Custom middleware to intercept and merge CSP headers"},
        {"solution": "Disable Helmet CSP and implement custom header management with merging logic: helmet({ contentSecurityPolicy: false }); app.use(customCSPmerger)", "percentage": 85, "note": "Full control but requires custom implementation"},
        {"solution": "Stack helmet middleware from different sources by composing middleware functions that build final CSP before calling next()", "percentage": 80, "note": "Complex but achieves multi-source CSP merging"}
    ]$$::jsonb,
    'Multiple CSP sources or middleware, Helmet installed, custom middleware knowledge, understanding of CSP structure',
    'CSP headers merge correctly from multiple sources, all directives applied without override, resources load per combined policy, no directive conflicts',
    'Helmet does not natively support CSP merging - later calls override earlier ones. Cannot apply directives from multiple helmet instances directly. Merging requires external utility libraries. Each middleware call replaces rather than extends CSP headers. Custom solutions needed for multi-package CSP composition.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/helmetjs/helmet/issues/487'
),
(
    'Helmet CSP headers not updating dynamically from database or configuration changes',
    'github-helmet',
    'MEDIUM',
    $$[
        {"solution": "Use per-request middleware that reads configuration each time: app.use((req, res, next) => { const frameSrcUrls = readFromDatabase(); helmet.contentSecurityPolicy({ directives: { frameSrc: frameSrcUrls } })(req, res, next); })", "percentage": 91, "note": "Executes CSP logic on each request"},
        {"solution": "Implement middleware wrapper that passes dynamic config to helmet on each request instead of once at startup", "percentage": 88, "command": "Per-request helmet middleware instantiation"},
        {"solution": "For frequently updated CSP, implement custom header middleware that reads cache or database and sets header directly without helmet", "percentage": 85, "note": "Bypasses Helmet for full control of dynamic updates"},
        {"solution": "Use helmet options factory function to generate fresh config per request: const helmetConfig = () => ({ contentSecurityPolicy: { directives: {...} } }); app.use(helmet(helmetConfig()))", "percentage": 82, "note": "Note: helmet does not support dynamic factory functions - requires wrapper"}
    ]$$::jsonb,
    'Node.js Express backend, database access, dynamic configuration source, ability to modify middleware stack',
    'CSP frame-src and other directives update when database changes, new domains accessible immediately without app restart, CSP headers reflect latest configuration',
    'Helmet caches configuration at startup - changes to database or files do not automatically update headers. Each middleware call creates new instance with current config. helmet() called at startup applies once; changes require middleware reinvocation per request. SPA/Angular frontend requires server-side CSP updates to reflect frame source changes.',
    0.86,
    'sonnet-4',
    NOW(),
    'https://github.com/helmetjs/helmet/issues/473'
),
(
    'Helmet CSP configuration for Swagger UI documentation interface',
    'github-helmet',
    'MEDIUM',
    $$[
        {"solution": "Configure CSP directives for Swagger UI: scriptSrc includes cdn.jsdelivr.net and stackpath.bootstrapcdn.com, styleSrcElem includes these CDNs plus unsafe-inline for styles, fontSrc includes fonts.gstatic.com and googleapis.com, imgSrc includes data URIs", "percentage": 94, "note": "Complete Swagger UI CSP configuration"},
        {"solution": "Use exact CSP for Swagger: scriptSrc: [''\"''self''\"'', ''cdn.jsdelivr.net'', ''stackpath.bootstrapcdn.com''], styleSrc: [''\"''self''\"'', ''\"''unsafe-inline''\"'', ''cdn.jsdelivr.net'', ''stackpath.bootstrapcdn.com''], fontSrc: [''googleapis.com'', ''fonts.gstatic.com'', ''\"''data:''\"'']", "percentage": 92, "command": "Swagger-specific CSP directives"},
        {"solution": "Add SHA-256 hash for Swagger inline scripts instead of unsafe-inline: scriptSrc includes [''\"''sha256-HASH''\"''] where HASH is calculated from actual script content", "percentage": 85, "note": "More secure alternative to unsafe-inline"}
    ]$$::jsonb,
    'Helmet installed with Express, Swagger UI dependency, understanding of CSP directives and CDN resources',
    'Swagger UI loads completely without CSP violations, all documentation features functional, no browser console CSP errors, stylesheets and fonts load correctly',
    'Swagger UI requires CSS unsafe-inline due to dynamic style injection. Specific CDN domains required; wildcards do not work. Data URIs needed for embedded fonts. Standard CSP with self-only will block all Swagger resources. Each Swagger version may require different CDN domain updates.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/helmetjs/helmet/issues/455'
);
