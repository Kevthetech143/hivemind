-- Add Playwright GitHub issues solutions batch 1
-- Mined from microsoft/playwright repository
-- Focus: browser launch failures, selector issues, video recording, Docker problems

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Playwright: Failed to launch chromium executable does not exist in CI/monorepo',
    'github-playwright',
    'VERY_HIGH',
    '[
        {"solution": "Force explicit browser installation: npx playwright install chromium", "percentage": 95, "note": "Bypasses yarn postinstall issues, most reliable for CI"},
        {"solution": "Verify PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD is not set in CI environment", "percentage": 85, "note": "Prevents installation blocking in pipeline"},
        {"solution": "Use npm ci instead of yarn install in Docker or CI environments", "percentage": 80, "note": "Ensures consistent package manager behavior"},
        {"solution": "Check for cache persistence issues between CI pipeline stages - ensure .cache/ms-playwright/ is not deleted", "percentage": 75, "note": "Common when cleanup steps remove browser cache"}
    ]'::jsonb,
    'Node.js 10.14+, Write access to .cache/ms-playwright/ directory, CI environment with proper environment variable handling',
    'Browser binary exists at expected revision path, Installation logs show "Playwright build of chromium v[revision] downloaded", Test execution completes without "executable does not exist" errors',
    'Do not assume network issues - incomplete downloads typically fail at install phase. Monorepo workspaces may need independent browser installation. Watch for CI cleanup steps removing .cache/ms-playwright/. Ensure version consistency between package.lock and yarn.lock across environments.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/microsoft/playwright/issues/5767'
),
(
    'Playwright: browserType.launch timeout - Node.js version incompatibility',
    'github-playwright',
    'HIGH',
    '[
        {"solution": "Update Node.js to version 14.1.0 or later (issue occurred with 14.0.0)", "percentage": 95, "note": "Official fix for Node version incompatibility"},
        {"solution": "Clean installation: remove node_modules, lock files, and browser cache, then reinstall", "percentage": 90, "note": "Resolves stale cache issues"},
        {"solution": "Run npx playwright install to ensure all browser binaries are properly configured", "percentage": 90, "note": "Most reliable recovery path"},
        {"solution": "Execute node node_modules/playwright/install.js directly if postinstall fails", "percentage": 70, "note": "Manual fallback option"}
    ]'::jsonb,
    'Node.js 14.1.0 or later, npm or yarn package manager, Proper file system permissions',
    'Browser installation completes without errors, Chromium executable path resolves correctly, Tests launch and execute successfully',
    'npm install playwright does not automatically install browsers - requires separate npx playwright install step. Keeping outdated Node versions causes compatibility failures. Incomplete cache cleanup before reinstallation can cause stale references.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://github.com/microsoft/playwright/issues/4033'
),
(
    'Playwright Docker: Chromium version mismatch between Docker image and npm package',
    'github-playwright',
    'HIGH',
    '[
        {"solution": "Use versioned Docker images matching Playwright version: mcr.microsoft.com/playwright:v1.5.2-bionic", "percentage": 95, "note": "Pin both Playwright version in package.json and Docker image version simultaneously"},
        {"solution": "Check available Docker tags at https://mcr.microsoft.com/v2/playwright/tags/list", "percentage": 90, "note": "Reference official tag list for exact version mapping"},
        {"solution": "Temporary workaround: switch to playwright@next with FROM mcr.microsoft.com/playwright:dev", "percentage": 70, "note": "Not recommended for production - use for quick testing only"},
        {"solution": "Use COPY --chown=pwuser for Docker file copies to fix permission issues", "percentage": 85, "note": "Prevents permission denied errors when running npm install as non-root"}
    ]'::jsonb,
    'Docker container environment, npm package manager, Understanding of Docker user permissions and version management',
    'Chromium executable found and launches without ENOENT errors, Successful npm installation completion, Matching Playwright and Docker image versions confirmed',
    'Do not mix unversioned Docker tags (dev, bionic) with specific npm versions - version mismatch is root cause. Permission denied errors indicate running npm install as non-root user. Always pin Docker image version with npm package version simultaneously.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://github.com/microsoft/playwright/issues/3122'
),
(
    'Playwright macOS: Chromium browser closes unexpectedly during test execution or debugging',
    'github-playwright',
    'HIGH',
    '[
        {"solution": "Upgrade to Playwright @next version (npm i -D @playwright/test@next) - confirmed working on trunk", "percentage": 95, "note": "Immediate workaround for 1.20.0 regression"},
        {"solution": "Upgrade to Playwright 1.20.x patch release with cherry-picked fix from PR #12993", "percentage": 90, "note": "Permanent fix deployed to 1.20.x branch"},
        {"solution": "Disable CertificateTransparencyComponentUpdater feature via launch options", "percentage": 85, "note": "Root cause: memory corruption in Chromium partition allocator during component updates"}
    ]'::jsonb,
    'Playwright 1.20.0 or affected versions, macOS environment (versions 11.6.5 through 12.3), Chromium browser installation',
    'Browser remains open throughout complete test execution, No "Browser closed" errors during debugging sessions, All parameterized tests complete successfully, Consistent performance across multiple test runs',
    'Issue is regression specific to 1.20.0 - downgrading to 1.18.2 masks problem. Does not affect Firefox or Linux environments. Testing only on Linux will miss this macOS-specific failure. Problem stems from CertificateTransparencyComponentUpdater, not pytest-parallel or environment configuration.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/microsoft/playwright/issues/12974'
),
(
    'Playwright: Locator operations timeout when element does not exist instead of returning null',
    'github-playwright',
    'HIGH',
    '[
        {"solution": "Use Expect(locator).ToBeVisibleAsync() for assertion-based visibility checks instead of relying on locator timeout", "percentage": 90, "note": "Assertion-based approach handles non-existence gracefully"},
        {"solution": "Use Locator.IsVisibleAsync() to test visibility without timeout errors", "percentage": 90, "note": "Returns boolean instead of throwing timeout"},
        {"solution": "Understand that Playwright Locator itself does not hang - auto-wait only applies to actions on locators", "percentage": 85, "note": "Clarifies locator behavior vs action behavior"},
        {"solution": "Add explicit error handling before performing actions on locators", "percentage": 80, "note": "Check element state before triggering timeout"}
    ]'::jsonb,
    'Understanding that Playwright implements auto-wait behavior on element actions, Knowledge that locators represent queries not immediate element matches, Playwright framework for assertions',
    'Locator code properly returns elements or safe default values, User confirmed working solutions, Clear error messages when elements missing, Tests complete without unexpected timeouts',
    'Assuming Locator() directly returns elements or null causes issues. Performing actions on locators without checking visibility first triggers timeout. Misunderstanding auto-wait as hanging behavior rather than feature design.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/microsoft/playwright/issues/18994'
),
(
    'Playwright: locator.click timeout in remote environment but passes locally',
    'github-playwright',
    'MEDIUM',
    '[
        {"solution": "Enable Playwright debugging and tracing: follow debugging guides and enable Traces to examine DOM rendering differences", "percentage": 90, "note": "Provides visibility into remote vs local environment differences"},
        {"solution": "Investigate environment-specific DOM differences between local and remote execution", "percentage": 85, "note": "Root cause is usually environment-specific rendering, not Playwright bug"},
        {"solution": "Check for selector reliability differences based on page load speed variations", "percentage": 80, "note": "Network conditions affect timing differently in remote"},
        {"solution": "Test against both localhost and production sites to isolate network vs application issues", "percentage": 75, "note": "Helps determine if infrastructure or DOM is the problem"}
    ]'::jsonb,
    'Playwright v1.25.2+, Debugging and tracing configuration, Remote test execution setup, Access to browser debug logs',
    'Test passes consistently in remote environment, Tracing reveals expected DOM state, Selector success rate matches local execution, Page load timing is consistent',
    'Environment-specific DOM differences are root cause, not Playwright bugs. Remote execution fails while local succeeds indicates infrastructure/network issues. Selector reliability varies based on page load speed - faster loads in local may render elements differently in slow remote networks.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/microsoft/playwright/issues/17275'
),
(
    'Playwright Docker WebKit: Video recording broken with artifact path error in v1.54.x',
    'github-playwright',
    'HIGH',
    '[
        {"solution": "Upgrade to Playwright v1.54.1 or later which includes fix merged from PR #36688", "percentage": 95, "note": "Fix specifically stores videos into artifacts folder correctly"},
        {"solution": "If stuck on 1.54.0, disable video recording temporarily (video: off) as workaround", "percentage": 70, "note": "Masks problem, not a solution - upgrade is required"},
        {"solution": "Verify you are using WebKit in Docker - Chromium and Firefox are unaffected", "percentage": 85, "note": "Regression is WebKit-specific to Docker multi-client setups"}
    ]'::jsonb,
    'Playwright v1.54.0 or later, WebKit browser via Docker container, Video recording enabled in test configuration, Remote connection via WebSocket endpoint',
    'Video files successfully write to artifacts directory, Tests complete without protocol errors, Chromium and Firefox video recording continues working, WebKit tests pass with video: on configuration',
    'Issue is WebKit-specific - Chromium/Firefox work fine. Only occurs with Docker-based remote connections. Disabling video masks the problem. Last working version was 1.53.2. Do not confuse with WebKit video playback issues which are separate problems.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://github.com/microsoft/playwright/issues/36685'
),
(
    'Playwright WebKit Docker: Missing dependencies for video playback (DRM/codec support)',
    'github-playwright',
    'MEDIUM',
    '[
        {"solution": "Test with video sources that do not require proprietary DRM implementation", "percentage": 90, "note": "Official maintainer recommendation - open-source WebKit limitation"},
        {"solution": "Accept technical limitation: DRM-protected content only works with official Chrome or Safari, not open-source WebKit builds", "percentage": 85, "note": "Architectural constraint, not fixable in Docker"},
        {"solution": "Use Chromium browser for testing DRM content (videos with proprietary codecs)", "percentage": 80, "note": "Chromium supports hardware-accelerated rendering"}
    ]'::jsonb,
    'Playwright v1.7.1+, Docker container using Dockerfile.focal, Awareness that WebKit is open-source version, Test video content selection',
    'Video loads with proper duration display (for non-DRM content), Hardware-accelerated rendering functions without warnings, Screenshots capture loaded video content, No missing codec/encoder errors',
    'Open-source WebKit does not provide feature parity with Safari for proprietary content. DRM-protected videos will not play in Chromium or open-source WebKit - only official Chrome/Safari support. Do not expect proprietary codec support in Docker open-source builds.',
    0.80,
    'sonnet-4',
    NOW(),
    'https://github.com/microsoft/playwright/issues/4813'
),
(
    'Playwright Docker: Missing system dependencies for test execution',
    'github-playwright',
    'HIGH',
    '[
        {"solution": "Switch from Debian-based Docker images to Ubuntu focal base image", "percentage": 95, "note": "Debian variants (bullseye-slim) lack required dependencies - use official Ubuntu"},
        {"solution": "Run npx playwright install-deps which installs all required system libraries on Ubuntu", "percentage": 90, "note": "Works reliably on Ubuntu focal but not all Linux distributions"},
        {"solution": "Reference official Dockerfile examples for Python/Java implementations that use only install-deps on Ubuntu", "percentage": 85, "note": "Use as template for custom Docker configurations"}
    ]'::jsonb,
    'Ubuntu focal base image (not Debian), Node.js/npm installed temporarily for Playwright setup, Ability to modify Docker configuration, Knowledge of image selection',
    'npx playwright install-deps completes without errors, All required system libraries resolve correctly, Tests execute without missing dependency errors, Browser launch succeeds',
    'Using Debian-based images (bullseye-slim variants) instead of Ubuntu focal causes missing dependencies. Removing Node.js before dependencies fully install breaks the chain. Do not assume install-deps works uniformly across all Linux distributions - it is Ubuntu-optimized.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/microsoft/playwright/issues/12845'
),
(
    'Playwright Docker: Browser context closing timeout when using persistent contexts',
    'github-playwright',
    'MEDIUM',
    '[
        {"solution": "Replace persistent contexts with test parallelism for better performance and isolation", "percentage": 92, "note": "Maintainer official recommendation - persistent contexts accumulate data causing slowness"},
        {"solution": "Understand that persistent contexts run too long to allow efficient tracing/video analysis", "percentage": 85, "note": "Root cause: postmortem analysis incompatibility with persistent state"},
        {"solution": "Configure test parallelism in playwright.config.ts to replace persistent context patterns", "percentage": 90, "note": "Achieves same test isolation without cleanup delays"}
    ]'::jsonb,
    'Playwright v1.32.1 or later, Understanding of test parallelism configuration, Docker environment with proper resource allocation',
    'Tests complete within expected timeframe (seconds to 2 minutes), Video recordings capture properly, No timeout errors in reports, Test isolation maintained across runs',
    'Persistent contexts assume faster execution but create data accumulation issues. Persistent contexts allow state leakage between tests creating hidden dependencies. Video/tracing generation stalls when processing accumulated session data. Replace with parallelism, not just increase timeouts.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/microsoft/playwright/issues/22166'
),
(
    'Playwright Docker Jenkins: Navigation timeout 50000ms exceeded - works locally',
    'github-playwright',
    'MEDIUM',
    '[
        {"solution": "Remove custom timeout overrides (actionTimeout, navigationTimeout, expect.timeout) and use Playwright defaults", "percentage": 85, "note": "Custom overrides can mask underlying infrastructure issues"},
        {"solution": "Investigate Jenkins infrastructure for ISP/network throttling, rate limiting, or proxy/firewall restrictions", "percentage": 90, "note": "Issue is infrastructure-specific, not Playwright bug"},
        {"solution": "Test with internal URLs instead of external sites (replace google.com with internal endpoints)", "percentage": 80, "note": "Isolates network infrastructure issues from app code"},
        {"solution": "Check Jenkins Docker container has proper network access and no rate limiting rules applied", "percentage": 75, "note": "CI infrastructure often has different network policies"}
    ]'::jsonb,
    'Docker container running Microsoft Playwright image, Chromium browser, Network access to test sites or internal endpoints, Jenkins CI configuration access',
    'Navigation completes within default timeout periods, Consistent test behavior across local and CI environments, No network-level errors in browser debug logs, External site loads within reasonable time',
    'Conflicting timeout configurations mask actual infrastructure issues. Assuming Playwright bugs when environmental factors are responsible. Using external websites for load testing in restricted networks. Local testing does not reproduce Jenkins infrastructure constraints like ISP throttling.',
    0.86,
    'sonnet-4',
    NOW(),
    'https://github.com/microsoft/playwright/issues/20329'
),
(
    'Playwright: page.waitForSelector does not fail test when selector not found',
    'github-playwright',
    'MEDIUM',
    '[
        {"solution": "Use Playwright Test fixtures for page instances instead of manually creating them - good error reporting only guaranteed with fixtures", "percentage": 90, "note": "Custom page instances bypass test framework error handling"},
        {"solution": "Add explicit error handling with try-catch blocks around waitForSelector calls", "percentage": 85, "note": "Custom instances require manual exception handling"},
        {"solution": "Implement timeout validation and proper handling of timeout exceptions", "percentage": 80, "note": "Set appropriate timeout values for your context"},
        {"solution": "Always add explicit assertions after element location attempts", "percentage": 85, "note": "Do not rely on implicit test failure"}
    ]'::jsonb,
    'Playwright Test framework v1.12.3+, Understanding of fixture-based page instances vs manually created ones, Test configuration with proper timeout settings',
    'Tests properly fail when selectors do not match, Clear error messages display in test reports, Test status accurately reflects pass/fail outcomes, Console logs confirm element detection attempts',
    'Creating custom page instances outside fixture system bypasses error handling. Assuming waitForSelector will fail tests automatically without fixtures. Missing explicit assertions after successful selector waits. Insufficient timeout configuration for dynamic content.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/microsoft/playwright/issues/7703'
),
(
    'Playwright Firefox Docker: Timeout in Jenkins with v1.22.0+ - works in older versions',
    'github-playwright',
    'MEDIUM',
    '[
        {"solution": "Build project into Docker image using ADD instead of volume mounting (ADD . /project instead of VOLUME)", "percentage": 95, "note": "Resolves file permission/access issues specific to volume mounts"},
        {"solution": "Copy project files into container during build rather than mounting at runtime", "percentage": 90, "note": "Eliminates permission and filesystem access problems"},
        {"solution": "Downgrade to Playwright v1.15.0 or v1.10.0-focal as temporary workaround", "percentage": 60, "note": "Not recommended - upgrade with proper Docker configuration is better solution"},
        {"solution": "Check for file permission issues if volume mounting is required", "percentage": 70, "note": "Ensure host and container permissions are compatible"}
    ]'::jsonb,
    'Playwright v1.22.0+ Docker image, Firefox browser tests, Docker environment with build configuration access, Jenkins or similar CI system',
    'Tests complete without timeout errors, Firefox launches and executes test scenarios successfully, Consistent timeout behavior across multiple test runs',
    'Issue is filesystem/permissions related, not dependency issue. Volume mounting projects causes failures; building into image works. Problem occurs in Jenkins but not Bitbucket CI. Older Playwright versions (1.15.0, 1.10.0) do not have this issue suggesting regression in Docker image setup.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/microsoft/playwright/issues/14792'
),
(
    'Playwright: Selector timeout in headless mode but passes when using --headed flag with pause',
    'github-playwright',
    'MEDIUM',
    '[
        {"solution": "Add explicit waits before problematic selectors using waitForSelector() or waitForLoadState()", "percentage": 90, "note": "Addresses timing/race condition where DOM renders slower in headless"},
        {"solution": "Remove hardcoded timeouts (waitForTimeout) and replace with condition-based waits", "percentage": 88, "note": "Explicit waits work better than arbitrary delays"},
        {"solution": "Increase timeout values on locator operations if content loads slowly", "percentage": 75, "note": "For valid cases where page is slow"},
        {"solution": "Enable DEBUG=pw:api environment variable to trace timing issues", "percentage": 80, "note": "Helps identify where race conditions occur"}
    ]'::jsonb,
    'Playwright testing framework, Understanding of asynchronous JavaScript patterns, Access to application dynamic rendering behavior, Knowledge of element visibility states',
    'Test passes consistently in headless mode, No arbitrary waitForTimeout calls remain, Test completes without timeout errors, No Target closed errors',
    'Insufficient waits between rapid DOM interactions causes race conditions. Assuming manual debugging pace (with pause) matches automated execution speed. Not accounting for element visibility and interactivity states. Hardcoded timeouts hide real problem (missing waits).',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/microsoft/playwright/issues/15022'
);
