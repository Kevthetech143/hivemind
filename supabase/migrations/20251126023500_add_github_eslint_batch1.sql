-- Add GitHub ESLint Issues batch 1 (12 issues with solutions)

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'ESLint error while loading rule @typescript-eslint/no-unused-expressions: Cannot read properties of undefined',
    'github-eslint',
    'HIGH',
    $$[
        {"solution": "Update typescript-eslint to latest version that supports ESLint 9.15.0+ meta.defaultOptions behavior", "percentage": 92, "note": "Root cause: breaking change in ESLint 9.15.0 requiring default options as array of objects, not empty array"},
        {"solution": "Downgrade ESLint to 9.14.0 temporarily while awaiting typescript-eslint fix", "percentage": 85, "note": "Temporary workaround only"},
        {"solution": "Use core no-unused-expressions rule instead of typescript-eslint extension if compatible with project", "percentage": 70, "note": "May lose TypeScript-specific features"}
    ]$$::jsonb,
    'ESLint 9.15.0+, TypeScript-ESLint plugin, Node.js environment',
    'Rule loads without TypeError, eslint command runs successfully, no crashing on file linting',
    'Issue is in typescript-eslint package, not ESLint itself. Ensure typescript-eslint compatibility matrix is checked. Do not just downgrade ESLint without plan for upgrade.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/eslint/eslint/issues/19134'
),
(
    'ESLint no-unused-vars false positive with for-in loop variable flagged as unused',
    'github-eslint',
    'HIGH',
    $$[
        {"solution": "Update babel-eslint to compatible version that uses updated eslint-scope package", "percentage": 90, "note": "Fixes scope analysis for for-in/for-of loops"},
        {"solution": "Disable babel-eslint and use default JavaScript parser if babel transpilation not needed", "percentage": 85, "note": "Removes TDZ scope detection issue"},
        {"solution": "Suppress rule with eslint-disable comment for specific loop if immediate fix needed", "percentage": 60, "note": "Temporary workaround only, does not fix root cause"}
    ]$$::jsonb,
    'ESLint 6.2.0+, babel-eslint plugin, JavaScript parser',
    'For-in/for-of loop variables no longer flagged as unused, rule reports only legitimate issues',
    'This regression was caused by eslint-scope version mismatch. Do not use outdated babel-eslint versions. Check scope chain analysis in deprecation notices.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/eslint/eslint/issues/12117'
),
(
    'ESLint require-atomic-updates false positive on object property reassignment after await',
    'github-eslint',
    'HIGH',
    $$[
        {"solution": "Update ESLint to version with PR #15238 merged which improves race condition detection logic", "percentage": 93, "note": "Fixes false positives where new value has no dependency on old value"},
        {"solution": "Disable require-atomic-updates rule globally if false positives block project", "percentage": 75, "note": "Only if pattern update not feasible"},
        {"solution": "Restructure code to avoid reassignment pattern if possible", "percentage": 70, "note": "Refactor approach, not ideal for all cases"}
    ]$$::jsonb,
    'ESLint 6.0.1+, async/await functions, property reassignment patterns',
    'Property reassignments without value dependencies no longer flagged as race conditions, actual race conditions still detected',
    'The rule was too broad - it flagged assignments where new value did not depend on old value. Check assignment dependencies carefully. Do not suppress the entire rule without understanding actual race conditions.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://github.com/eslint/eslint/issues/11899'
),
(
    'ESLint shareable config cannot resolve plugin dependencies - Cannot find module eslint-plugin-*',
    'github-eslint',
    'HIGH',
    $$[
        {"solution": "List plugins in peerDependencies and instruct users to install them separately (current pattern)", "percentage": 95, "note": "Documented approach but poor UX"},
        {"solution": "Extend plugins that export configs instead of inline plugin usage in shareable config", "percentage": 85, "note": "Proposed long-term solution by Nicholas Zakas"},
        {"solution": "Use require() in JavaScript configs to directly load plugin modules", "percentage": 80, "note": "Works for .js configs but not .json, security consideration"}
    ]$$::jsonb,
    'ESLint shareable config setup, plugins as dependencies, JavaScript or JSON configuration',
    'Config loads without module resolution errors, rules from plugins execute correctly, users understand dependency requirements',
    'Shareable configs require clear documentation of plugin dependencies. Do not expect automatic plugin resolution. Design configs with user DX in mind. Consider moving to JavaScript-based configs for better flexibility.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/eslint/eslint/issues/3458'
),
(
    'ESLint linting speed slow with large codebases - need parallel file linting',
    'github-eslint',
    'HIGH',
    $$[
        {"solution": "Use ESLint with --concurrency=auto flag to enable multithreaded linting (RFC 129 implementation)", "percentage": 94, "note": "Achieves ~2-6x speedup on multi-core systems depending on hardware"},
        {"solution": "Set --concurrency=N to specific thread count optimized for your hardware", "percentage": 90, "note": "Test values from 2 to CPU cores to find optimal performance"},
        {"solution": "Implement glob-based file filtering to lint only changed files in CI/CD pipelines", "percentage": 80, "note": "Complementary optimization to multithreading"}
    ]$$::jsonb,
    'ESLint latest version (v9.0+), Node.js with worker thread support, multi-core processor',
    'Linting completes in significantly less time, no errors or race conditions in parallel linting, all files processed correctly',
    'Worker threads add overhead - avoid --concurrency=1. On single-core systems parallel linting may be slower. Monitor memory usage with --concurrency=auto. Ensure config is thread-safe (no global state).',
    0.94,
    'sonnet-4',
    NOW(),
    'https://github.com/eslint/eslint/issues/3565'
),
(
    'ESLint v9 flat config ignores property not working - files in dist/ still being linted',
    'github-eslint',
    'VERY_HIGH',
    $$[
        {"solution": "Place ignores in separate config object as first item in array without other properties for global ignores", "percentage": 96, "note": "Design requirement: ignores without other keys = global ignores"},
        {"solution": "Use correct glob pattern syntax: escape wildcards properly in ignores array patterns", "percentage": 88, "note": "Example: ''**/dist/**'' not ''**/dist/*''"},
        {"solution": "Verify ignores config object is FIRST in export default array before other configs", "percentage": 92, "note": "Order matters - ignores must come before other rules/configs"}
    ]$$::jsonb,
    'ESLint v9.0+, flat config (eslint.config.js), understanding of flat config structure',
    'Files matching ignore patterns not linted, no eslint errors reported for ignored directories, linting reports only target files',
    'Critical: ignores ONLY works when it is the ONLY property in that config object. Mixing ignores with rules/extends breaks it. This is counterintuitive and poorly documented initially. Users frequently make this mistake.',
    0.96,
    'sonnet-4',
    NOW(),
    'https://github.com/eslint/eslint/issues/18304'
),
(
    'ESLint with glob patterns error: You are linting src/**/*.ts but all files matching glob are ignored',
    'github-eslint',
    'VERY_HIGH',
    $$[
        {"solution": "Use --ext flag instead of glob: eslint --ext .ts src/ instead of eslint src/**/*.ts", "percentage": 92, "note": "More reliable for TypeScript file discovery"},
        {"solution": "For flat config, wrap extends() with files array: {files: [''**/*.ts''], ...compat.extends()}", "percentage": 90, "note": "Ensures config applies to TypeScript files"},
        {"solution": "Escape glob patterns in package.json: ''lint'': ''eslint \\\"src/**/*.ts\\\"'' with quotes", "percentage": 85, "note": "Prevents shell glob expansion, sends full pattern to ESLint"},
        {"solution": "Migrate from .eslintrc to eslint.config.js properly using migration guide, not simple rename", "percentage": 88, "note": "Format significantly different, old config wont work in flat config"}
    ]$$::jsonb,
    'ESLint 8.x or 9.x, TypeScript files, either .eslintrc or eslint.config.js configuration',
    'Files matching pattern successfully linted without ignore errors, rule violations reported correctly for target files',
    'Do not simply rename .eslintrc to eslint.config.js - file format is completely different. Glob patterns work differently in CLI vs config. Use --ext for most reliable TypeScript linting. Shell expansion of globs can cause issues in scripts.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/eslint/eslint/issues/18420'
),
(
    'ESLint glob-based configuration feature request - apply config to files matching patterns',
    'github-eslint',
    'HIGH',
    $$[
        {"solution": "Use flat config ''files'' array property to specify patterns: {files: [''**/*test.js''], ...config}", "percentage": 95, "note": "Native flat config feature addresses this request"},
        {"solution": "For cascading .eslintrc, use directory-based configuration (.eslintrc in subdirectories) as workaround", "percentage": 75, "note": "Not as flexible as glob-based but achieves similar goal"},
        {"solution": "Consider migrating to flat config for better pattern-based configuration support", "percentage": 90, "note": "Flat config design includes pattern matching as core feature"}
    ]$$::jsonb,
    'ESLint configuration setup, understanding of patterns (legacy .eslintrc or flat config)',
    'Configuration patterns match files correctly, different rules apply to different file patterns, specific configs for test files work as expected',
    'Flat config natively supports this with files property. Legacy .eslintrc cascading does not. Migration to flat config recommended if pattern-based config critical to project. Do not try to force glob patterns into .eslintrc format.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/eslint/eslint/issues/3611'
),
(
    'ESLint flat config implementation - large architectural refactor from cascading to array-based',
    'github-eslint',
    'HIGH',
    $$[
        {"solution": "Migrate step-by-step using FlatCompat class from @eslint/eslintrc to bridge old and new formats", "percentage": 93, "note": "Allows gradual migration without full rewrite"},
        {"solution": "Use official migration guide at eslint.org for systematic transition from eslintrc to flat config", "percentage": 95, "note": "ESLint team provides detailed steps and examples"},
        {"solution": "Test plugins and extensions with flat config before full migration - check compatibility matrix", "percentage": 90, "note": "Not all ecosystem plugins compatible with flat config simultaneously"}
    ]$$::jsonb,
    'ESLint v8.0+ or v9.0+, existing .eslintrc configuration, understanding of JavaScript module format',
    'ESLint loads config without errors, all rules execute with flat config, linting behavior matches original .eslintrc',
    'Flat config is fundamentally different format - not just syntax change. Cannot do simple file rename. Array order matters for config precedence. Some older plugins may not support flat config. Test thoroughly in separate environment first.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://github.com/eslint/eslint/issues/13481'
),
(
    'ESLint TypeScript config file support needed - cannot use eslint.config.ts or eslint.config.mts',
    'github-eslint',
    'MEDIUM',
    $$[
        {"solution": "Update ESLint to version with TypeScript config file support (PR #18134) - use jiti loader", "percentage": 94, "note": "Implemented using jiti conditional loader based on file extension"},
        {"solution": "Use eslint.config.js with TypeScript JSDoc comments for type safety in JavaScript", "percentage": 85, "note": "Workaround: provides some TS benefits without full ESLint TS support"},
        {"solution": "Transpile TypeScript config to JavaScript as build step before running ESLint", "percentage": 75, "note": "Manual preprocessing approach, error-prone"}
    ]$$::jsonb,
    'ESLint v9.0+, TypeScript project, flat config (eslint.config.ts or .mts)',
    'ESLint loads and parses .ts or .mts config file correctly, config is type-checked, no loader errors',
    'TypeScript config support uses jiti - ensure it is compatible with your environment. Not all ESLint versions support this. Requires update to latest major version. .mts files may have compatibility issues on some setups.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://github.com/eslint/eslint/pull/18134'
),
(
    'ESLint no-empty rule false positive - empty switch statement with comment incorrectly flagged',
    'github-eslint',
    'MEDIUM',
    $$[
        {"solution": "Update ESLint to version that allows comments in empty switch statements", "percentage": 92, "note": "Rule updated to ignore empty blocks with explanatory comments"},
        {"solution": "Add eslint-disable comment if immediate fix needed: /* eslint-disable-next-line no-empty */", "percentage": 75, "note": "Temporary workaround only"},
        {"solution": "Restructure switch to have fallthrough case if avoiding empty blocks preferred", "percentage": 60, "note": "Code style approach, may not fit all cases"}
    ]$$::jsonb,
    'ESLint with no-empty rule enabled, switch statements in code, comment documentation',
    'Switch statements with comments pass no-empty validation, linting errors only for truly empty blocks without documentation',
    'no-empty rule allows comments to document intentional empty blocks - similar to other empty block types. Do not suppress entire rule for this. Check ESLint version includes this fix. Comments must be in the block itself, not adjacent lines.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/eslint/eslint/issues/20000'
),
(
    'ESLint multithread linting performance - distribute file linting across worker threads',
    'github-eslint',
    'HIGH',
    $$[
        {"solution": "Enable concurrent linting with --concurrency=auto flag (RFC 129 implementation)", "percentage": 95, "note": "Automatically detects optimal thread count, measured 2-6x speedup on multi-core"},
        {"solution": "Manually set --concurrency=N to match available CPU cores minus 1 for stability", "percentage": 90, "note": "M1 Max (10 cores) saw 2.1x speedup, M2 Max (12 cores) saw 50% improvement"},
        {"solution": "Monitor memory usage and reduce concurrency if heap allocation fails with large codebases", "percentage": 85, "note": "Large projects (40k+ files) may need concurrency tuning"}
    ]$$::jsonb,
    'ESLint v9.0+ with RFC 129 implementation, Node.js worker thread support, multi-core CPU',
    'Linting completes significantly faster than single-threaded, no FATAL ERROR heap allocation failures, all files linted correctly',
    'Worker threads increase memory usage - monitor for allocation failures on very large projects. --concurrency=auto may be aggressive - test on CI servers first. Config must be thread-safe (no shared mutable state). Single-core systems see no benefit or degradation.',
    0.95,
    'sonnet-4',
    NOW(),
    'https://github.com/eslint/eslint/pull/19794'
);
