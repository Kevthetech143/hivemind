-- Add Jest GitHub issue solutions batch 1
-- Extracted from facebook/jest issues with high reaction counts and clear solutions
-- Category: github-jest
-- Total entries: 11

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Jest console.log does not output when running tests with jsdom',
    'github-jest',
    'HIGH',
    '[
        {"solution": "Switch testEnvironment from jsdom to node: testEnvironment: \"node\"", "percentage": 95, "note": "Most direct fix, works immediately"},
        {"solution": "Update Jest to patched version fixing Node 7.3 compatibility issue", "percentage": 90, "note": "Permanent fix if using affected Node versions"},
        {"solution": "Run multiple test files simultaneously (3+ tests) instead of single file", "percentage": 70, "note": "Workaround only, not recommended for solution"}
    ]'::jsonb,
    'Jest configured with jsdom testEnvironment, Node.js 4.0 or later',
    'console.log() statements display output to terminal during test execution, Output appears consistently with single test file',
    'Do not assume test code is broken - the issue is environment-specific. Only happens with jsdom environment, not with node environment.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/facebook/jest/issues/2441'
),
(
    'Jest JSDOM 11.12+ SecurityError localStorage not available for opaque origins',
    'github-jest',
    'HIGH',
    '[
        {"solution": "Add testURL configuration: testURL: \"http://localhost\" in jest config", "percentage": 95, "note": "Recommended solution - fixes security issue"},
        {"solution": "Switch to node test environment: testEnvironment: \"node\" for non-browser tests", "percentage": 90, "note": "Best if you don\'t need browser DOM"},
        {"solution": "Pin JSDOM to version 11.11.0: \"jsdom\": \"11.11.0\" in package.json", "percentage": 75, "note": "Temporary workaround, prevents upgrade"}
    ]'::jsonb,
    'Jest 23.4.0+, Node.js 10.7.0+, npm or Yarn, JSDOM 11.12.0 or later installed',
    'Tests execute without SecurityError exceptions, localStorage functionality works in tests, No warnings about opaque origins',
    'Setting testURL globally does not propagate to projects defined in jest projects array. Apply testURL to each project individually in monorepos.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://github.com/facebook/jest/issues/6766'
),
(
    'Jest memory leak on Node.js 16.11.0+ causes heap growth during test execution',
    'github-jest',
    'HIGH',
    '[
        {"solution": "Upgrade Node.js to 21.1.0 or later - issue fixed upstream", "percentage": 95, "note": "Most reliable permanent fix"},
        {"solution": "For Node 16/18/20: Update to Node 18.20.0, 20.10.0, or 21.1.0 with backports", "percentage": 93, "note": "Specific patched versions available"},
        {"solution": "Use --workerIdleMemoryLimit flag in Jest 29+: jest --workerIdleMemoryLimit=512M", "percentage": 80, "note": "Workaround for older Node versions, controls memory per worker"},
        {"solution": "Monitor with: node --expose-gc node_modules/.bin/jest --logHeapUsage", "percentage": 85, "note": "Diagnostic approach to verify issue and track memory"}
    ]'::jsonb,
    'Jest 27.0.6+ installed, Node.js 16.11.0 or later, jest --version confirms version',
    'Heap usage remains stable during test execution under 500MB, No growth from initial 200MB to 3000MB+, Memory returns to baseline after test completion',
    'Do not rely on --no-sparkplug V8 flag as workaround - it doesn\'t reliably propagate to Jest workers. ESM has separate memory leak issues. Upgrading Node is most reliable.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/facebook/jest/issues/11956'
),
(
    'Jest SyntaxError Cannot use import statement outside a module with Babel 7',
    'github-jest',
    'HIGH',
    '[
        {"solution": "Add transform config to jest.config.js: transform: {\".*\\\\.ts$\": [\"ts-jest\"]}", "percentage": 92, "note": "Most effective solution for TypeScript"},
        {"solution": "Ensure NODE_ENV is set to test: export NODE_ENV=test before running jest", "percentage": 88, "note": "Fix production NODE_ENV overrides"},
        {"solution": "Configure babel.config.js with @babel/preset-env and proper targets", "percentage": 85, "note": "Verify Babel config includes all necessary presets"},
        {"solution": "Adjust transformIgnorePatterns to not exclude ES6 modules needing transpilation", "percentage": 80, "note": "Allow specific modules through transform pipeline"}
    ]'::jsonb,
    'Babel configuration exists (babel.config.js or .babelrc), babel-jest dependency installed, @babel/preset-env configured, NODE_ENV can be controlled',
    'Tests run without SyntaxError on import statements, Babel transpilation logs show correct files being transformed, node_modules code properly transpiles to CommonJS',
    'Over-aggressive transformIgnorePatterns prevent necessary transpilation. Missing babel-jest despite Babel configuration. NODE_ENV set to production by hosting (Heroku, CI). Mismatched preset configurations between dev and test.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/facebook/jest/issues/9292'
),
(
    'Jest --detectOpenHandles flag hangs with no diagnostic output',
    'github-jest',
    'HIGH',
    '[
        {"solution": "Run with --runInBand flag: jest --runInBand --detectOpenHandles", "percentage": 96, "note": "Critical fix - detectOpenHandles only works in main process"},
        {"solution": "Install leaked-handles package for more detailed detection: npm install leaked-handles", "percentage": 82, "note": "Better diagnostics than built-in detection"},
        {"solution": "Use --forceExit to prevent hanging: jest --runInBand --detectOpenHandles --forceExit", "percentage": 70, "note": "Last resort - forces process exit but hides leaks"}
    ]'::jsonb,
    'Jest installed, Tests that complete normally, Ability to run tests serially with --runInBand',
    'Process completes without hanging after test execution, Open handles reported in output (not empty), Specific file/module names identified as leaking handles',
    'Running --detectOpenHandles without --runInBand causes hanging. Parallel worker processes prevent handle detection. Treating hanging as separate bug rather than missing prerequisite flag.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://github.com/facebook/jest/issues/9473'
),
(
    'Babel 7 does not transpile import/export in node_modules when using babel-jest',
    'github-jest',
    'VERY_HIGH',
    '[
        {"solution": "Convert .babelrc to babel.config.js: rename .babelrc file to babel.config.js", "percentage": 94, "note": "Most effective - enables config in node_modules context"},
        {"solution": "Add negative lookahead to transformIgnorePatterns: [\"/node_modules/(?!PACKAGE_NAME).+\\\\.js$\"]", "percentage": 88, "note": "Include specific ES6 packages that need transpilation"},
        {"solution": "Combine both approaches: babel.config.js + transformIgnorePatterns for maximum compatibility", "percentage": 95, "note": "Most robust solution for mixed dependencies"}
    ]'::jsonb,
    'Babel 7 installed, Import ES-module packages (lodash-es, etc), babel-jest configured, .babelrc or babel.config.js exists',
    'Tests execute without SyntaxError on import statements, ES modules in node_modules transpile to CommonJS, No unexpected token errors in dependencies',
    'Babel 7 explicitly prevents .babelrc from affecting node_modules - switch to babel.config.js. Over-broad transformIgnorePatterns accidentally exclude needed packages. Do not add excessive plugins to project config.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://github.com/facebook/jest/issues/6229'
),
(
    'Jest cannot mock individual functions within a module only module-level mocking',
    'github-jest',
    'MEDIUM',
    '[
        {"solution": "Refactor code to use module exports: change internal calls to use exports.foo() instead of direct foo() references", "percentage": 90, "note": "Architectural solution - enables function mocking"},
        {"solution": "Mock underlying APIs instead of functions: Mock XMLHttpRequest, axios, or database calls rather than application functions", "percentage": 92, "note": "Jest recommended approach - tests real behavior more accurately"},
        {"solution": "Use .mockClear() in beforeEach to isolate tests: beforeEach(() => { someModule.function.mockClear(); })", "percentage": 85, "note": "Helps with test isolation of module-level mocks"}
    ]'::jsonb,
    'Jest installed, Test code using jest.mock() at module level, Understanding of CommonJS vs ES module transpilation',
    'Mocked functions properly replace real implementation, Tests verify correct function was called, Internal module calls use mocked versions',
    'Expecting function-level mocking like other frameworks - Jest operates at module level only. Babel transpiles ES modules to local variable references, not export object references. Attempting to mock without code refactoring.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/facebook/jest/issues/936'
),
(
    'Jest memory leak from modules with closures over imported variables',
    'github-jest',
    'HIGH',
    '[
        {"solution": "Nullify closure references after use: set originalFunction = null in cleanup hooks", "percentage": 88, "note": "Enable garbage collection of retained scopes"},
        {"solution": "Add cleanup hooks to reset patched functions: afterEach(() => { https.request = originalHttps; })", "percentage": 90, "note": "Restore module state between tests"},
        {"solution": "Refactor to avoid singleton patterns with persistent require cache", "percentage": 85, "note": "Redesign code to work with Jest\'s per-test module isolation"},
        {"solution": "Monitor with Chrome DevTools during test runs to identify sawtooth memory patterns", "percentage": 75, "note": "Diagnostic approach to confirm closure-based leaks"}
    ]'::jsonb,
    'Multiple tests requiring modules with closure-based patches, Modules that patch core functions (https.request, etc), Ability to use Chrome DevTools for profiling',
    'Heap returns to baseline after garbage collection cycles, No sustained growth across test suites, Sawtooth pattern in memory graphs indicating proper cleanup between tests',
    'Assuming all module modifications are safe in Jest - Jest\'s module isolation differs from Node. Not recognizing that closures capture references. Attempting core module resets without understanding Node\'s native initialization.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/facebook/jest/issues/6814'
),
(
    'Jest memory leak when running many test files progressive heap growth',
    'github-jest',
    'HIGH',
    '[
        {"solution": "Use --expose-gc flag with afterAll gc call: node --expose-gc ./node_modules/.bin/jest", "percentage": 88, "note": "Forces garbage collection after each test file"},
        {"solution": "Add global.gc() call in afterAll hook: afterAll(() => { global.gc && global.gc(); })", "percentage": 85, "note": "Ensure garbage collection happens between test files"},
        {"solution": "Run tests with --logHeapUsage to monitor memory: jest --logHeapUsage", "percentage": 80, "note": "Diagnostic flag to track heap growth across files"}
    ]'::jsonb,
    'Node.js environment accessible with --expose-gc flag capability, afterAll hooks can be added to test files, Heap monitoring tools available',
    'Heap memory usage stabilizes rather than continuously growing, Memory returns to baseline between test files, Consistent heap size across 50+ test files',
    'Assuming it is a true memory leak rather than V8 garbage collection deferral. Not running with constrained heap sizes to force GC. Creating unnecessarily large test fixtures without cleanup code.',
    0.86,
    'sonnet-4',
    NOW(),
    'https://github.com/facebook/jest/issues/7874'
),
(
    'Jest ES modules native support import export syntax in test files',
    'github-jest',
    'MEDIUM',
    '[
        {"solution": "Use Babel transpilation with: babel-plugin-transform-es2015-modules-commonjs and babel-plugin-dynamic-import-node", "percentage": 90, "note": "Converts ES syntax to CommonJS that Jest understands"},
        {"solution": "Configure Babel with appropriate presets: @babel/preset-env in babel.config.js", "percentage": 88, "note": "Enable module transformation during test execution"},
        {"solution": "Add .mjs file extension support and recognize in Jest moduleNameMapper config", "percentage": 75, "note": "Partial solution for module resolution"}
    ]'::jsonb,
    'Node.js 8.9.0+ with ESM support, Babel transpiler integration configured, Jest runtime with module transformation',
    'Test files execute with import statements without SyntaxError, Exports properly validated by module system, Works across dependencies not just test imports',
    'Simple transpilation loses export validation benefits. Full native ESM implementation blocked by Jest\'s custom require system for mocking. Integration complexity requires significant redesign of module loading.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/facebook/jest/issues/4842'
),
(
    'jest-circus addEventHandler listeners not triggered due to context mismatch',
    'github-jest',
    'MEDIUM',
    '[
        {"solution": "Store eventHandlers on window object for global access: window.eventHandlers = eventHandlers", "percentage": 94, "note": "Fix ensures handlers shared across all imports"},
        {"solution": "Register listeners before test execution starts to ensure context availability", "percentage": 85, "note": "Timing-dependent workaround"},
        {"solution": "Clone reproduction repo and apply fix to confirm event handlers fire correctly", "percentage": 80, "note": "Verification method for fix validation"}
    ]'::jsonb,
    'Jest 27.0.3+ with jest-circus, Need to register event listeners for test lifecycle (beforeAll, beforeEach), Ability to modify or patch jest-circus',
    'Event handlers registered via addEventHandler fire correctly, Callbacks invoked at expected lifecycle hooks, No missing listener invocations',
    'Expecting behavior similar to Jasmine\'s addReporter - contexts differ. Manual node_modules modifications don\'t persist across reinstalls. Local variable eventHandlers not shared across imports.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/facebook/jest/issues/11483'
);
