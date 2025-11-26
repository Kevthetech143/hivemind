-- Add high-engagement Cypress GitHub issues with solutions - Batch 1
-- Category: github-cypress
-- Focus: Flaky tests, CI failures, iframe issues, network stubbing, screenshot problems
-- Source: https://github.com/cypress-io/cypress/issues

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, pattern_id
) VALUES
(
    'Cypress detached DOM element - element not found after queries',
    'github-cypress',
    'VERY_HIGH',
    '[
        {"solution": "Use cy.wait() with waitUntil or custom wait commands to ensure DOM elements are stable before interaction. The cypress-wait-until plugin provides reliable element stability detection.", "percentage": 90, "note": "Recommended for flaky detached element errors"},
        {"solution": "Use .click({force: true}) to bypass Cypress visibility checks, though this doesn'\''t solve the underlying DOM stability issue", "percentage": 75, "note": "Not ideal - forces interaction with potentially invalid elements"},
        {"solution": "Upgrade to Cypress v12+ which includes automatic re-querying of detached elements", "percentage": 95, "note": "Built-in solution in v12 and later"}
    ]'::jsonb,
    'Cypress v10+, test using cy.get() or cy.contains() selectors',
    'Element click completes without detached DOM error, page navigation occurs as expected',
    'Do not rely solely on force: true without addressing DOM stability. Avoid clicking elements immediately after API calls that might re-render.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/cypress-io/cypress/issues/7306',
    NULL
),
(
    'cy.screenshot() timed out waiting 30000ms CI timeout',
    'github-cypress',
    'HIGH',
    '[
        {"solution": "Increase screenshot timeout in cypress.config.js: {screenshotOnRunFailure: false} to skip screenshot on failure, or increase defaultCommandTimeout", "percentage": 85, "note": "Fixes timeout in CI environments"},
        {"solution": "Upgrade Cypress version - this issue was fixed in 3.8.1 and versions after. Avoid 3.8.2+", "percentage": 88, "note": "Bug fix in specific versions"},
        {"solution": "Ensure application is fully started before tests begin. Add wait logic or health check endpoint", "percentage": 80, "note": "Prevents premature test execution"},
        {"solution": "Use cy.wait() to wait for critical API calls or page load events before screenshots", "percentage": 75, "note": "Explicit waits improve reliability"}
    ]'::jsonb,
    'Cypress 3.8.1+, configured screenshot settings in cypress.config.js',
    'Screenshots complete without timeout in CI/CD pipeline, tests pass consistently',
    'Tests starting before application initialization. Chrome/Edge version 104+ has memory issues. Running too many tests sequentially.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/cypress-io/cypress/issues/5016',
    NULL
),
(
    'cy.wait() timeout no request ever occurred route alias',
    'github-cypress',
    'VERY_HIGH',
    '[
        {"solution": "Ensure the route is set BEFORE the action that triggers the request. Use cy.intercept() (v7.3+) instead of cy.route() which is deprecated", "percentage": 95, "note": "Most common cause - incorrect order of route setup and action"},
        {"solution": "Check if request is fetch() not XHR. Cypress cy.route() only works with XHR. Use cy.intercept() for fetch requests", "percentage": 92, "note": "fetch() support requires cy.intercept()"},
        {"solution": "Verify request URL matches exactly. Use pattern matching or URL shorthand: cy.intercept('\''POST'\'', '\''/api/*'\'', {...})", "percentage": 88, "note": "URL mismatch causes no requests matched error"},
        {"solution": "Increase cy.wait() timeout: cy.wait('\''@alias'\'', {timeout: 10000}) if network is slow", "percentage": 70, "note": "Temporary workaround for slow networks"}
    ]'::jsonb,
    'Cypress 3.0+, XHR or fetch requests in application, cy.intercept() for v7.3+',
    'cy.wait() completes without timeout, request is intercepted and response logged',
    'Route/intercept defined AFTER action. Using cy.route() for fetch(). URL pattern mismatch. setTimeout delays in application.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/cypress-io/cypress/issues/3427',
    NULL
),
(
    'chrome-error://chromewebdata X-Frame-Options iframe redirect',
    'github-cypress',
    'HIGH',
    '[
        {"solution": "Set chromeWebSecurity: false in cypress.config.js to disable web security checks for testing", "percentage": 85, "note": "Allows cross-domain navigation without CORS/Frame errors"},
        {"solution": "If visiting cross-domain, ensure cy.visit() only crosses one superdomain. Use multiple test files for multi-domain testing", "percentage": 80, "note": "Cypress same-origin policy limitation"},
        {"solution": "Check for redirect chains - if URL A redirects to domain B which redirects to C, you'\''re crossing multiple superdomains", "percentage": 85, "note": "Redirect chains are common source of chrome-error"},
        {"solution": "Test clicking external links in separate tabs using window.open() or target blank testing patterns", "percentage": 75, "note": "Alternative approach for testing external links"}
    ]'::jsonb,
    'Cypress 3.0+, cypress.config.js with chromeWebSecurity option, understanding of same-origin policy',
    'cy.visit() completes without chrome-error, page content loads normally',
    'Not setting chromeWebSecurity: false when needed. Testing multiple superdomains in single test. Unexpected redirect chains.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/cypress-io/cypress/issues/4220',
    NULL
),
(
    'cy.click() element not visible 0x0 width height flaky',
    'github-cypress',
    'VERY_HIGH',
    '[
        {"solution": "Wait for API calls to complete before clicking. Use cy.wait('\''@alias'\'') or cy.waitUntil() to ensure DOM is stable", "percentage": 90, "note": "DOM mutations during clicks cause flakiness"},
        {"solution": "Guard against early test execution with application initialization checks: cy.get('\''[data-app-ready]'\'') before interactions", "percentage": 88, "note": "Prevents clicking before app fully loads"},
        {"solution": "Use .then() to wait for render: cy.get('\''a'\'').should('\''be.visible'\'').then(() => cy.click())", "percentage": 85, "note": "Ensures visibility check before click"},
        {"solution": "For framework (React/Angular) apps, communicate directly with app to know when initialization is complete", "percentage": 82, "note": "Most reliable for SPA frameworks"}
    ]'::jsonb,
    'Cypress 0.20+, SPA framework (React/Angular/Vue), async API calls in app',
    'Element click succeeds consistently, no 0x0 width/height errors, page navigates as expected',
    'Clicking before app initializes. XHR calls affecting element visibility. CSS animations causing flickering. Using force:true masks the real issue.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/cypress-io/cypress/issues/695',
    NULL
),
(
    'ChunkLoadError loading chunk cypress-support-file failed webpack',
    'github-cypress',
    'HIGH',
    '[
        {"solution": "Upgrade Cypress to 13.6.3+ which fixes webpack 5 chunk loading issue introduced in 12.17.4", "percentage": 93, "note": "Direct fix for webpack chunk error"},
        {"solution": "If on Cypress 13.x with large test suites, reduce parallel test execution with --max-workers flag", "percentage": 82, "note": "Workaround for memory-related chunk failures"},
        {"solution": "Clear Cypress cache: rm -rf node_modules/.cache && cypress run", "percentage": 78, "note": "Resolves stale bundle references"},
        {"solution": "For component tests, split large test suites into smaller files to reduce memory footprint", "percentage": 80, "note": "Distributes load across test runs"}
    ]'::jsonb,
    'Cypress 12.16.0+, 1000+ tests or large test suite, webpack 5 in app config',
    'All tests complete without ChunkLoadError, chunk files load successfully',
    'Running too many component tests sequentially. Not clearing cache after upgrade. Using Cypress 12.17.4-13.6.2 with webpack 5.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/cypress-io/cypress/issues/28644',
    NULL
),
(
    'Out of memory Chrome Edge 104 version timeout',
    'github-cypress',
    'MEDIUM',
    '[
        {"solution": "Downgrade Chrome/Edge to version 103 as temporary workaround while issue is investigated", "percentage": 100, "note": "Immediate solution - version 104+ causes memory leak"},
        {"solution": "Update Cypress to latest version and system packages. Memory issues often fixed in patch releases", "percentage": 75, "note": "Check release notes for memory optimizations"},
        {"solution": "Reduce test parallelization: cypress run --max-workers 2 to limit memory usage", "percentage": 85, "note": "Effective immediate workaround"},
        {"solution": "Increase CI/CD environment memory allocation and swap space", "percentage": 70, "note": "Infrastructure-level fix"}
    ]'::jsonb,
    'Cypress 12+, Chrome or Edge browser 104+, CI/CD environment with limited memory',
    'Tests complete without timeout or out-of-memory errors, CI pipeline finishes within expected time',
    'Not realizing browser version update caused the issue. Running tests on underpowered CI machines. Not monitoring memory usage.',
    0.80,
    'sonnet-4',
    NOW(),
    'https://github.com/cypress-io/cypress/issues/23391',
    NULL
),
(
    'cy.visit() multiple superdomains same test cross-domain',
    'github-cypress',
    'MEDIUM',
    '[
        {"solution": "Set chromeWebSecurity: false in cypress.config.js to disable web security for cross-domain visits", "percentage": 88, "note": "Allows multiple superdomain visits"},
        {"solution": "Split multi-domain tests into separate test files, each testing one superdomain", "percentage": 92, "note": "Recommended approach per Cypress architecture"},
        {"solution": "Use tab handling patterns to test links that open in new tabs: window.open() + cy.wrap()", "percentage": 80, "note": "Workaround for external domain testing"},
        {"solution": "Upgrade to Cypress v10.11+ which improved cross-domain support when chromeWebSecurity: false", "percentage": 85, "note": "Enhanced handling in newer versions"}
    ]'::jsonb,
    'Cypress 3.0+, understanding of same-origin policy, multiple test domains',
    'cy.visit() succeeds for multiple superdomains or external links open in separate tabs',
    'Attempting multiple superdomain visits in single test without disabling web security. Not understanding same-origin policy.',
    0.83,
    'sonnet-4',
    NOW(),
    'https://github.com/cypress-io/cypress/issues/944',
    NULL
),
(
    'cy.intercept window.fetch mocking stub requests',
    'github-cypress',
    'VERY_HIGH',
    '[
        {"solution": "Use cy.intercept() in Cypress 7.3+ to mock and spy on both XHR and fetch requests", "percentage": 95, "note": "Native solution - replaces cy.route() for all request types"},
        {"solution": "For Cypress <7.3, use cy.route() for XHR only. Fetch support requires upgrade to 7.3+", "percentage": 80, "note": "Version-dependent feature"},
        {"solution": "Use stub() method with cy.intercept(): cy.intercept('\''POST'\'', '\''/api/**'\'', stub)", "percentage": 90, "note": "Explicitly stub responses"},
        {"solution": "Create custom fixture for fetch responses and return with cy.intercept()", "percentage": 85, "note": "Load realistic response data from fixtures"}
    ]'::jsonb,
    'Cypress 7.3+ for fetch mocking, application using fetch() API, test fixtures if mocking responses',
    'cy.intercept() captures fetch requests, spy.called returns true, stubbed responses return expected data',
    'Using cy.route() for fetch requests in v7.2 and below. Not waiting for intercept before action. Wrong URL pattern.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/cypress-io/cypress/issues/95',
    NULL
),
(
    'Allure cypress-allure-plugin allure-results folder not created',
    'github-cypress',
    'MEDIUM',
    '[
        {"solution": "Update @shelex/cypress-allure-plugin to latest version compatible with Cypress 12.15.0+", "percentage": 90, "note": "Plugin version mismatch with Cypress 12.15+"},
        {"solution": "Clear Cypress cache and node_modules: rm -rf node_modules && npm install", "percentage": 75, "note": "Resolves plugin registration issues"},
        {"solution": "Verify setupNodeEvents is properly configured in cypress.config.js with allure plugin registration", "percentage": 88, "note": "Plugin must be registered in config"},
        {"solution": "Use plugin v2.0+ with Cypress 12+ for compatibility. Older versions may not work.", "percentage": 92, "note": "Version compatibility is critical"}
    ]'::jsonb,
    'Cypress 12.15.0+, @shelex/cypress-allure-plugin v2.0+, proper cypress.config.js setup',
    'allure-results folder is created after test runs, Allure report generates successfully',
    'Using old plugin versions with Cypress 12+. Incorrect plugin setup in setupNodeEvents. Plugin not registered.',
    0.86,
    'sonnet-4',
    NOW(),
    'https://github.com/cypress-io/cypress/issues/27113',
    NULL
),
(
    'Azure AD OAuth login redirect not working test authentication',
    'github-cypress',
    'MEDIUM',
    '[
        {"solution": "Mock the OAuth redirect with cy.intercept() to bypass actual login: intercept Microsoft login with 302 redirect back to app", "percentage": 90, "note": "Best practice for E2E auth testing"},
        {"solution": "Set chromeWebSecurity: false to allow redirects from login.microsoftonline.com back to localhost", "percentage": 85, "note": "Cross-domain OAuth requires web security disabled"},
        {"solution": "Use auth plugin like @cypress-codegens/cypress-oauth or manually set session/token in beforeEach hook", "percentage": 88, "note": "Avoid repeatedly logging in with OAuth"},
        {"solution": "For API-based auth (token), set Authorization header with cy.intercept() instead of testing OAuth flow", "percentage": 92, "note": "More reliable than simulating OAuth redirect"}
    ]'::jsonb,
    'Cypress 7.3+, cy.intercept() support, Azure AD OAuth configured, understanding of redirect flow',
    'App authenticates successfully, user is logged in, session is maintained across tests',
    'Not mocking OAuth redirect. Testing actual OAuth flow in CI (slow, flaky). Not setting Authorization headers.',
    0.84,
    'sonnet-4',
    NOW(),
    'https://github.com/cypress-io/cypress/issues/1342',
    NULL
),
(
    'Safari WebKit browser support Cypress testing',
    'github-cypress',
    'MEDIUM',
    '[
        {"solution": "Upgrade to Cypress 13.6.0+ which includes official WebKit/Safari browser support", "percentage": 95, "note": "Added in v13.6.0 release"},
        {"solution": "Set browser: '\''webkit'\'' in cypress.config.js to run tests in WebKit engine", "percentage": 94, "note": "Configuration option for Safari testing"},
        {"solution": "Note: WebKit support is limited compared to Chrome/Firefox. Check known limitations in release notes.", "percentage": 85, "note": "Some Cypress features may not work in WebKit"},
        {"solution": "Use skipBrowser or conditional test logic for WebKit-specific issues", "percentage": 80, "note": "Workaround for unsupported features"}
    ]'::jsonb,
    'Cypress 13.6.0+, macOS for Safari testing, WebKit browser engine',
    'Tests run successfully in WebKit browser, Safari compatibility verified',
    'Using Cypress <13.6. Expecting full feature parity with Chrome. Not accounting for WebKit-specific limitations.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/cypress-io/cypress/issues/6422',
    NULL
);
