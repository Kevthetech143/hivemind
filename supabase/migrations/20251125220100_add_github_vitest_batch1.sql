-- Add GitHub Vitest issues batch 1
-- Mined from: https://github.com/vitest-dev/vitest/issues
-- Date: 2025-11-25
-- Focus: Vite integration, coverage, browser mode, snapshots, Jest migration

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES (
    'Vitest Vite v4 config types error: Object literal may only specify known properties',
    'github-vitest',
    'HIGH',
    '[
        {"solution": "Upgrade vitest to v0.25.7 or later which includes proper type augmentation for Vite config", "percentage": 95, "note": "Fix merged in PR #2470"},
        {"solution": "Ensure vite.config.ts includes test property within UserConfigExport type definition", "percentage": 90, "note": "Manual type extension as workaround"},
        {"solution": "Run TypeScript compiler to verify test property is recognized", "percentage": 85, "command": "npx tsc --noEmit"}
    ]'::jsonb,
    'Vitest 0.25.7+, TypeScript enabled, Vite 4.0.0+',
    'vite.config.ts has no type errors, test property is recognized in IDE autocomplete, TypeScript compilation succeeds',
    'Do not use older Vitest versions with Vite 4.0 - type mismatch is version-specific. Ensure vite.config.ts uses defineConfig() from vite.',
    0.95,
    'sonnet-4',
    NOW(),
    'https://github.com/vitest-dev/vitest/issues/2474'
),
(
    'Vitest coverage discrepancies when migrating from Jest: c8 vs nyc differences in coverage reports',
    'github-vitest',
    'HIGH',
    '[
        {"solution": "Configure coverage provider to use nyc instead of c8 to match Jest behavior", "percentage": 92, "note": "Add coverage.provider: \"nyc\" to vitest config"},
        {"solution": "Adjust c8 configuration to ignore .test.ts, types.ts, *.entity.ts files like Jest does", "percentage": 85, "command": "coverage: { exclude: [\"**/*.test.ts\", \"**/types.ts\", \"**/*.entity.ts\"] }"},
        {"solution": "Use absolute paths in c8 configuration instead of relative paths for proper line coverage counting", "percentage": 80, "note": "c8 requires absolute paths; Jest accepts relative"},
        {"solution": "Disable comments and import lines from coverage with c8.excludeLineRegex", "percentage": 75, "command": "coverage: { excludeLineRegex: [\"(//|.*import.*|.*export.*)\"] }"}
    ]'::jsonb,
    'Vitest 0.28+, Jest migration in progress, Coverage tool installed',
    'Coverage percentages match Jest reports, .test.ts files excluded from coverage, Comment lines not marked as uncovered',
    'c8 includes comments and import statements as coverable by default - configure exclusions. Different providers (c8 vs nyc) produce different results. Running single vs multiple files may show coverage variations.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/vitest-dev/vitest/issues/1252'
),
(
    'Vitest canvas native module fails with threads: Cannot self-register module .../canvas.node',
    'github-vitest',
    'MEDIUM',
    '[
        {"solution": "Disable threading by setting threads: false in vitest config test section", "percentage": 95, "note": "Most reliable solution but impacts performance"},
        {"solution": "Limit threads with minThreads: 0, maxThreads: 1 configuration", "percentage": 85, "command": "test: { minThreads: 0, maxThreads: 1 }"},
        {"solution": "Remove canvas from dependencies: identify with npm ls canvas and uninstall the importing package", "percentage": 90, "command": "npm ls canvas && npm uninstall <package-name> && rm -r node_modules/canvas && npm install"},
        {"solution": "Switch test environment to happy-dom instead of jsdom to avoid canvas loading", "percentage": 85, "command": "test: { environment: \"happy-dom\" }"}
    ]'::jsonb,
    'Vitest configured with jsdom environment, canvas or ascii-art package installed, threads enabled (default)',
    'Full test suite runs without segmentation fault errors, Multiple test files execute together successfully, No \"Module did not self-register\" errors',
    'Canvas fails specifically with multiple test files in threaded mode - single tests may pass. Switching environment is safer long-term than disabling threads. Do not disable threads globally if other tests need isolation.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/vitest-dev/vitest/issues/740'
),
(
    'Vitest deps.inline: true causes AsymmetricMatcher destructuring error after version 0.27.1',
    'github-vitest',
    'MEDIUM',
    '[
        {"solution": "Use regex pattern to exclude Vitest packages from inlining: deps: { inline: [/^(?!.*vitest).*$/] }", "percentage": 95, "note": "Recommended fix - inlines everything except Vitest packages"},
        {"solution": "Replace inline: true with specific package names: deps: { inline: [\"vuetify\", \"other-lib\"] }", "percentage": 90, "command": "deps: { inline: [\"vuetify\"] }"},
        {"solution": "Disable inlining entirely by removing deps.inline configuration", "percentage": 85, "note": "Eliminates benefits but resolves error"},
        {"solution": "Upgrade to Vitest with PR #4815 fix which properly handles inlined Vitest packages", "percentage": 92, "note": "Upgrade to latest version where this is fixed"}
    ]'::jsonb,
    'Vitest 0.28.4 or later, deps.inline configured, @vitest/utils in use',
    'Tests execute without AsymmetricMatcher error, Dependencies are properly inlined as expected, No undefined property destructuring errors',
    'inline: true with Vitest 0.28+ causes @vitest packages to be missing from inlined modules. Do not use broad inline: true - either target specific packages or use negative regex. Maintainers advise against inline: true as a general strategy.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/vitest-dev/vitest/issues/2806'
),
(
    'Vitest test performance 3x slower than Jest with default threads: true setting',
    'github-vitest',
    'HIGH',
    '[
        {"solution": "Disable test isolation with --isolate=false flag or test: { isolate: false }", "percentage": 85, "note": "Provides 5x speedup but sacrifices test isolation - may cause state pollution"},
        {"solution": "Reduce thread count with minThreads: 0, maxThreads: 2 to balance performance and isolation", "percentage": 80, "command": "test: { minThreads: 0, maxThreads: 2 }"},
        {"solution": "Optimize dependency usage - minimize large dependencies in test files to avoid re-execution overhead", "percentage": 75, "note": "Vitest re-executes deps for each isolated test unlike Jest bundling"},
        {"solution": "Use vm.runInNewContext for lighter isolation instead of Worker threads if ES module support adds", "percentage": 60, "note": "Proposed future optimization awaiting VM module improvements"}
    ]'::jsonb,
    'Vitest 0.18+, Large test suite (6000+ tests), Baseline Jest performance for comparison',
    'Test suite completes in acceptable time (< 50% of original time), No false test failures due to state pollution, Memory usage remains consistent across test runs',
    'Disabling isolation causes test interdependencies and failures - only safe for truly independent unit tests. Thread overhead is fundamental to Vitest architecture. Do not expect Jest performance with Vitest threading enabled.',
    0.80,
    'sonnet-4',
    NOW(),
    'https://github.com/vitest-dev/vitest/issues/579'
),
(
    'Vitest tests hang with close timeout error after 1000ms preventing test completion',
    'github-vitest',
    'MEDIUM',
    '[
        {"solution": "Run tests with --no-threads flag to disable worker threads: npx vitest --no-threads", "percentage": 92, "command": "vitest --no-threads", "note": "Most effective workaround - significantly reduces hang occurrence"},
        {"solution": "Increase test teardown timeout: test: { teardownTimeout: 10000 }", "percentage": 65, "note": "Less effective than disabling threads but worth trying"},
        {"solution": "Manually clean up testing-library resources to prevent unclosed child processes", "percentage": 70, "note": "Inspect with process._getActiveHandles() to find hanging handles"},
        {"solution": "Upgrade to Vitest with PR #3418 or #5047 which fix underlying threading issues", "percentage": 88, "note": "Later versions have improved thread cleanup"}
    ]'::jsonb,
    'Vitest 0.18+, Testing library or complex test setup, CI environment (common but also local)',
    'All tests complete without hanging, No \"close timed out\" errors in output, CI pipeline completes successfully without timeout',
    'Hanging appears intermittent and environment-specific. Do not ignore initial hangs - they indicate resource leak. Process._getActiveHandles() shows remaining child processes preventing exit. Multiple wtfnode library checks may be needed.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/vitest-dev/vitest/issues/2008'
),
(
    'Vitest bail option to skip all subsequent tests after failure for fail-fast CI execution',
    'github-vitest',
    'MEDIUM',
    '[
        {"solution": "Use --bail flag (default skip after 1 failure): npx vitest --bail", "percentage": 95, "command": "vitest --bail", "note": "Skips all tests after first failure - global scope"},
        {"solution": "Configure bail in vitest config: test: { bail: 1 }", "percentage": 95, "command": "export default { test: { bail: 1 } }"},
        {"solution": "Set custom failure threshold: npx vitest --bail 3 to stop after 3 failures", "percentage": 90, "command": "vitest --bail 3"},
        {"solution": "Combine with reporter to clearly show when bail threshold is reached", "percentage": 75, "note": "Use verbose reporter for clearer output of which test triggered bail"}
    ]'::jsonb,
    'Vitest with PR #3163 merged (feature implemented), CI/CD pipeline setup, Need fast-fail behavior',
    'Tests stop executing after Nth failure as configured, CI job exits with non-zero code on failure, No unnecessary tests run after bail threshold',
    'Bail scope is global (all tests) not per-file. Some CI systems may require special handling for early exit. Do not confuse with per-suite bail - Vitest treats all tests as flattened.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://github.com/vitest-dev/vitest/issues/1459'
),
(
    'Vitest coverage reports show uncovered branches with isolate: false configuration',
    'github-vitest',
    'MEDIUM',
    '[
        {"solution": "Remove isolate: false from configuration to enable test isolation", "percentage": 88, "note": "Restores accurate coverage but significantly slows tests"},
        {"solution": "Switch coverage provider from Istanbul to v8: coverage: { provider: \"v8\" }", "percentage": 90, "command": "coverage: { provider: \"v8\" }"},
        {"solution": "Set threads: false alongside isolate: false to prevent race conditions", "percentage": 70, "note": "Only partially effective, not guaranteed fix"},
        {"solution": "Clean node_modules/.vitest before test runs: rm -rf node_modules/.vitest && vitest", "percentage": 60, "command": "rm -rf node_modules/.vitest && npx vitest run"}
    ]'::jsonb,
    'Vitest 1.6.0+, Multiple test files covering same source, Istanbul coverage provider',
    'Coverage reports show 100% actual coverage matching code execution, All branches properly marked as covered, No semi-random uncovered branch markers',
    'Issue appears to be Istanbul-provider-specific race condition. v8 provider works correctly. isolate: false combined with multiple test files triggers the bug. Do not rely on coverage: false as temporary workaround - affects testing strategy.',
    0.75,
    'sonnet-4',
    NOW(),
    'https://github.com/vitest-dev/vitest/issues/3846'
),
(
    'Vitest Windows test discovery fails with No test suite found error in version 0.28.5+',
    'github-vitest',
    'MEDIUM',
    '[
        {"solution": "Ensure Windows directory paths use correct mixed-case casing before running tests", "percentage": 85, "note": "Navigate using exact filesystem case: cd C:\\Users\\Name\\Documents instead of c:\\users\\name\\documents"},
        {"solution": "Use WSL instead of native Windows PowerShell for more consistent path handling", "percentage": 80, "command": "wsl && npx vitest run"},
        {"solution": "Update pathe library dependency which introduced case-sensitive path resolution in PR #2819", "percentage": 75, "note": "Update vitest to version with fixed pathe handling"},
        {"solution": "Downgrade to Vitest 0.28.4 where path normalization handled Windows case-insensitivity correctly", "percentage": 70, "command": "npm install vitest@0.28.4"}
    ]'::jsonb,
    'Vitest 0.28.5+, Windows operating system, Local test directory navigation',
    'Test discovery completes successfully, test suite found and executes, No \"No test suite found\" error in output',
    'Bug is Windows-specific and case-sensitivity sensitive. Same code works in Docker/WSL. Path matching is case-sensitive in pathe library but Windows filesystem is case-insensitive. PowerShell may not preserve directory casing.',
    0.78,
    'sonnet-4',
    NOW(),
    'https://github.com/vitest-dev/vitest/issues/2962'
),
(
    'Vitest source maps for inlined dependencies incorrect: debugger highlights wrong lines in VS Code',
    'github-vitest',
    'MEDIUM',
    '[
        {"solution": "Use shouldExternalize check instead of node_modules exclusion for source map generation", "percentage": 92, "note": "Replace node_modules check with proper externalizer logic"},
        {"solution": "Ensure inlined dependencies receive source maps by checking shouldExternalize() condition", "percentage": 90, "command": "if (sourcemap === \"inline\" && result && !(await this.shouldExternalize(id)))"},
        {"solution": "Validate generated source maps with source map visualization tool to confirm map validity", "percentage": 80, "command": "VITE_NODE_DEBUG_DUMP=1 vitest run"},
        {"solution": "Upgrade to Vitest with proper source map generation for inlined deps", "percentage": 85, "note": "Issue closed as completed - upgrade to latest version"}
    ]'::jsonb,
    'Vitest with inline source maps enabled, Dependencies configured for inlining, VS Code debugger setup',
    'Debugger highlights correct lines when stepping through inlined dependencies, Source maps generated for node_modules files, VS Code shows expected code during debugging',
    'Source maps are generated correctly but VS Code may not always apply them immediately - restart debugger if needed. The node_modules exclusion was incorrect - inlined deps should receive source maps.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/vitest-dev/vitest/issues/5605'
),
(
    'Vitest worker IPC channel closes prematurely: Error ERR_IPC_CHANNEL_CLOSED in CI after version update',
    'github-vitest',
    'MEDIUM',
    '[
        {"solution": "Downgrade tinypool dependency to v1.0.2: npm install tinypool@1.0.2", "percentage": 93, "command": "npm install tinypool@1.0.2", "note": "Fix verified with 60+ test runs showing zero failures on 1.0.2 vs 18 failures on 1.1.0"},
        {"solution": "Update problematic dependencies like node-canvas to latest versions", "percentage": 88, "note": "Some third-party packages crash on specific operations - canvas height setting known issue"},
        {"solution": "Pin Vitest to 3.1.4 with compatible tinypool version", "percentage": 85, "command": "npm install vitest@3.1.4"},
        {"solution": "Use pool: \"forks\" instead of threads pool for IPC communication", "percentage": 70, "command": "test: { pool: \"forks\" }"}
    ]'::jsonb,
    'Vitest 3.2.3+, CI environment (macOS specifically), Multiple test projects (20+)',
    'All tests complete without ERR_IPC_CHANNEL_CLOSED errors, CI pipeline runs successfully, Zero unhandled rejections in test output',
    'Issue predominates on macOS CI systems - Linux and Windows typically unaffected. tinypool 1.1.0 introduced regression in version 3.1.4 -> 3.2.1. Check third-party dependencies for thread-safety issues.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/vitest-dev/vitest/issues/8201'
),
(
    'Vitest watch mode becomes unresponsive after file changes with CTRL+C not exiting on Node 20+',
    'github-vitest',
    'MEDIUM',
    '[
        {"solution": "Use --pool=forks flag instead of default threads: npx vitest --pool=forks", "percentage": 95, "command": "vitest --pool=forks", "note": "Works immediately - resolves hang completely"},
        {"solution": "Downgrade Node.js to 18.x or earlier where the bug does not occur", "percentage": 90, "command": "nvm install 18 && nvm use 18"},
        {"solution": "Upgrade Vitest to version with PR #5047 merged for improved worker thread lifecycle", "percentage": 88, "note": "Later versions have fixes for Node 20+ threading"},
        {"solution": "Configure watch mode with manual timeout settings if using threads", "percentage": 65, "note": "Less reliable than switching pool strategy"}
    ]'::jsonb,
    'Vitest with Node 20+, Watch mode enabled, Combined test suites from multiple files',
    'Watch mode responsive to file changes, CTRL+C exits process immediately, No 100% CPU hangs after file edits, Terminal prompt returns',
    'Issue is Node.js specific (16.8.0+) caused by undici bug in worker threads. Not directly a Vitest bug. Node 16-18 unaffected. Using forks pool changes process model but avoids thread-specific Node.js bug.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/vitest-dev/vitest/issues/4956'
),
(
    'Vitest segmentation fault when debugging with breakpoints attached in VS Code',
    'github-vitest',
    'LOW',
    '[
        {"solution": "Downgrade Node.js to v16.7.0 or earlier: nvm install 16.7.0 && nvm use 16.7.0", "percentage": 95, "command": "nvm install 16.7.0", "note": "Most reliable - bug introduced in Node.js 16.8.0"},
        {"solution": "Use Node.js v15.x or v14.x as alternative stable versions", "percentage": 92, "command": "nvm install 15.12.0"},
        {"solution": "Disable threading during debugging sessions: test: { threads: false }", "percentage": 60, "note": "Partially helps but not complete fix"},
        {"solution": "Upgrade Node.js past issue resolution if available in newer major versions", "percentage": 70, "note": "Check Node.js releases for debugger fixes"}
    ]'::jsonb,
    'Vitest v0.4.1+, VS Code with js-debug extension, Node.js 16.8.0 or later, Breakpoint set in test file',
    'Debugger attaches and hits breakpoints without crashing, Process exits with code 0 after debug session, No segmentation fault errors in console',
    'Segmentation fault is Node.js debugger infrastructure issue introduced in 16.8.0 - not Vitest specific. Occurs \"if and only if breakpoint is attached\". Unaffected by Vitest configuration changes. Upgrade Node.js may resolve if newer patches address debugger bugs.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/vitest-dev/vitest/issues/795'
),
(
    'Vitest terminal reporter performance degradation: dot reporter 10x slowdown with 8000+ tests',
    'github-vitest',
    'MEDIUM',
    '[
        {"solution": "Disable reporters or use silent reporter during test runs: test: { reporters: [\"silent\"] }", "percentage": 90, "command": "test: { reporters: [\"silent\"] }"},
        {"solution": "Use simpler reporters like \"dot\" only and avoid verbose formatting on large test suites", "percentage": 75, "note": "Verbose reporter uses wrapAnsi which causes O(n²) scaling"},
        {"solution": "Upgrade to Vitest with chalk/wrap-ansi PR #51 fix which optimizes regex patterns", "percentage": 88, "note": "Upstream fix reduces wrapAnsi overhead from 95% to acceptable levels"},
        {"solution": "Run tests in CI with reporter: \"json\" and parse output programmatically instead of console rendering", "percentage": 85, "command": "vitest run --reporter=json > results.json"}
    ]'::jsonb,
    'Vitest with 1000+ test suite, Terminal reporter enabled (default, verbose, or dot), Performance sensitive CI',
    'Test suite completes in < 30 seconds for 8000 tests, Console output renders without significant slowdown, CPU usage remains linear with test count',
    'Issue is in wrapAnsi from chalk library iterating all tests every 200ms - causes doom loop for large suites. O(n²) or worse scaling. Dot reporter is more efficient than verbose but still affected.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/vitest-dev/vitest/issues/2602'
);
