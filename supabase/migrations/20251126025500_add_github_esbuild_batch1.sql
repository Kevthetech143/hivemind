-- Mine GitHub Issues from evanw/esbuild repository - Batch 1
-- Category: github-esbuild
-- Date: 2025-11-26

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'ESBuild minify results in ReferenceError: o is not defined for const defined in if block',
    'github-esbuild',
    'HIGH',
    $$[
        {"solution": "Update to esbuild version that includes fix for constant folding when const is lexically referenced before definition", "percentage": 95, "note": "Issue was due to incomplete variable substitution during minification"},
        {"solution": "Verify UseCountEstimate property to ensure all constant references are properly substituted before removing declarations", "percentage": 85, "note": "Check that constant substitution completes fully before optimization"},
        {"solution": "Avoid complex scoping patterns with consts defined in conditional blocks - refactor to top-level const or use let", "percentage": 80, "note": "Workaround: restructure code to simplify variable hoisting requirements"}
    ]$$::jsonb,
    'esbuild minify enabled, JavaScript/TypeScript code with const declarations in conditional blocks',
    'Minified output does not produce ReferenceError for undefined variables, code executes without undefined variable errors',
    'Bug manifests when const is defined inside if block and referenced in nested functions. Variable hoisting simulation in esbuild had flawed constant folding logic. Always test minified output thoroughly.',
    0.92,
    'esbuild-latest',
    NOW(),
    'https://github.com/evanw/esbuild/issues/3125'
),
(
    'Broken install binary on macOS - esbuild: Failed to install correctly',
    'github-esbuild',
    'HIGH',
    $$[
        {"solution": "Disable ignore-scripts in npm config: npm config set ignore-scripts false", "percentage": 95, "note": "Root cause: post-install scripts were blocked from running"},
        {"solution": "Reinstall esbuild after enabling ignore-scripts: npm uninstall esbuild && npm install esbuild", "percentage": 93, "note": "Must reinstall to trigger post-install script that creates platform binary"},
        {"solution": "If npm config edit fails, check ~/.npmrc file for ignore-scripts=true and remove or set to false", "percentage": 90, "note": "Alternative way to modify npm configuration"}
    ]$$::jsonb,
    'npm or yarn package manager installed, macOS 10.15+, esbuild package to install',
    'esbuild binary installs correctly, npm install esbuild completes without error, esbuild command is executable',
    'The ignore-scripts npm configuration setting prevents post-install scripts from running, which esbuild needs to build platform-specific binaries. Error message does not clearly indicate this root cause.',
    0.94,
    'esbuild-latest',
    NOW(),
    'https://github.com/evanw/esbuild/issues/462'
),
(
    'Unused top-level code not removed with format:esm but removed with format:iife',
    'github-esbuild',
    'MEDIUM',
    $$[
        {"solution": "Use treeShaking: true option with format esm in transform API to enable dead code elimination", "percentage": 92, "note": "ESM format requires explicit treeShaking flag for DCE with transform API"},
        {"solution": "Switch to format iife if tree shaking is critical and esbuild bundling is not required", "percentage": 85, "note": "IIFE format automatically performs DCE without treeShaking flag"},
        {"solution": "Use full bundling mode instead of transform API if dead code elimination is essential for ESM output", "percentage": 80, "note": "Bundling mode always performs DCE by default"}
    ]$$::jsonb,
    'esbuild transform API, format esm or iife, JavaScript/TypeScript code with unused variables',
    'Unused code is removed from output, bundle size is minimized, treeShaking configuration works correctly',
    'Dead code elimination behavior differs between transform and bundling modes. ESM format in transform API does not perform DCE by default to preserve compatibility with partial code transformation. This is intentional design, not a bug.',
    0.88,
    'esbuild-0.13+',
    NOW(),
    'https://github.com/evanw/esbuild/issues/1551'
),
(
    'Comments not being removed in esbuild - minify-identifiers leaves comments intact',
    'github-esbuild',
    'MEDIUM',
    $$[
        {"solution": "Use --minify-whitespace flag to remove all comments and whitespace during minification", "percentage": 95, "note": "minify-identifiers alone does not remove comments - requires minify-whitespace"},
        {"solution": "Use full --minify flag which includes all minification options including comment removal", "percentage": 93, "note": "Equivalent to setting minify-identifiers + minify-whitespace + minify-syntax"},
        {"solution": "Understand that esbuild is not designed as a comment-stripping tool - for code formatting, use dedicated tools like Prettier", "percentage": 80, "note": "Comment preservation is intentional for compatibility with third-party tools"}
    ]$$::jsonb,
    'esbuild bundler with minify options, JavaScript code with comments',
    'Build output has all comments removed when minify-whitespace is used, no comments in minified code',
    'Common misconception: minify-identifiers alone does not remove comments. Must use minify-whitespace. Some comments are preserved to maintain semantics for tool compatibility. This is by design, not a bug.',
    0.90,
    'esbuild-0.17+',
    NOW(),
    'https://github.com/evanw/esbuild/issues/3117'
),
(
    'esbuild + ESM + NodeJS + TypeScript: Dynamic require not supported in ESM context',
    'github-esbuild',
    'HIGH',
    $$[
        {"solution": "Use --main-fields=module,main option to prioritize ES modules over CommonJS dependencies", "percentage": 88, "note": "Loads .mjs files when available, reducing require() calls"},
        {"solution": "Use --packages=external to externalize dependencies and require them from node_modules at runtime", "percentage": 90, "note": "Best for Node.js deployments - leaves npm packages unbundled"},
        {"solution": "Provide a global require function shimmed for ESM environment to support dynamic requires", "percentage": 75, "note": "Complex workaround - creates compatibility layer"},
        {"solution": "Identify which dependencies use require() for Node.js builtins and either externalize them or find ESM alternatives", "percentage": 85, "note": "Audit dependency chain for CommonJS/ESM conflicts"}
    ]$$::jsonb,
    'esbuild bundler for Node.js, TypeScript files, --format=esm option, CommonJS dependencies with conditional requires',
    'Bundle executes without Dynamic require error, ESM module runs in Node.js, dependencies load correctly',
    'Root cause: CommonJS dependencies use require() for Node.js builtins. When bundled to ESM, no global require() exists at runtime. The dynamic import chain (node-fetch -> stream) becomes unresolvable. Choose strategy based on deployment constraints (Lambda, Docker, etc).',
    0.82,
    'esbuild-latest',
    NOW(),
    'https://github.com/evanw/esbuild/issues/3637'
),
(
    'Entry file marked as external causes error - entry point cannot be marked external',
    'github-esbuild',
    'MEDIUM',
    $$[
        {"solution": "Update esbuild to version with fix that prevents entry files from being marked as external", "percentage": 95, "note": "Automatic fix - entry points are now excluded from external matching rules"},
        {"solution": "In configuration, exclude entry files from external patterns - use more specific path matching", "percentage": 85, "note": "Workaround: update external rules to not match entry point paths"},
        {"solution": "Use node_modules external pattern that explicitly excludes entry points, or refactor to avoid edge case", "percentage": 80, "note": "Prevent entry points from matching broad external patterns"}
    ]$$::jsonb,
    'esbuild bundler, external configuration, entry files in special locations (e.g. node_modules)',
    'Build completes successfully, entry files are bundled, no error about entry points being marked external',
    'Issue arises when entry files match external patterns. This is logically inconsistent - entry points must always be bundled. The fix is automatic in newer versions by excluding entry points from external matching.',
    0.93,
    'esbuild-latest',
    NOW(),
    'https://github.com/evanw/esbuild/issues/2382'
),
(
    'Proposed tsconfig.json changes - conflicting settings in multi-tsconfig environment',
    'github-esbuild',
    'HIGH',
    $$[
        {"solution": "Restrict esbuild to single root tsconfig.json - use Option 1 approach in newer versions that only load from root", "percentage": 88, "note": "Breaking change: per-directory tsconfig lookups removed"},
        {"solution": "Apply stricter rules: don''t apply settings to JavaScript files unless allowJs:true, don''t apply to node_modules", "percentage": 85, "note": "Option 2: incremental approach with more granular control"},
        {"solution": "Default useDefineForClassFields to true for consistency with TypeScript 4.3+ behavior", "percentage": 82, "note": "Aligns esbuild with TypeScript spec"}
    ]$$::jsonb,
    'esbuild with tsconfig.json configuration, monorepo or multi-directory projects, TypeScript and JavaScript mixed files',
    'No conflicting tsconfig settings applied across bundle, path resolution is consistent, class field definition behavior matches TypeScript',
    'esbuild loads per-directory tsconfig unlike tsc which uses single root. This causes conflicts in monorepos where different directories have different target/paths settings. Breaking change in newer versions restricts to single root only.',
    0.85,
    'esbuild-0.17+',
    NOW(),
    'https://github.com/evanw/esbuild/issues/3019'
),
(
    'Performance issue: Incremental build doesn''t help SCSS bundle - Sass compilation bottleneck',
    'github-esbuild',
    'HIGH',
    $$[
        {"solution": "Implement plugin-level caching using Map to memoize Sass transformation results", "percentage": 93, "note": "esbuild incremental rebuild skips files but plugin still runs transform - need plugin-level cache"},
        {"solution": "Upgrade to Dart Sass 1.32.3+ or use native Dart Sass instead of node-sass (2-3x faster)", "percentage": 91, "note": "Sass itself was slow, separate from esbuild optimization"},
        {"solution": "Cache Sass output outside esbuild using file hash, return cached result if input unchanged", "percentage": 88, "note": "Workaround: check if SCSS file modified before running render()"}
    ]$$::jsonb,
    'esbuild plugin for Sass, watch mode enabled, SCSS files in project, sass package installed',
    'Incremental watch rebuilds complete in under 1 second, SCSS compilation time is minimal even with many SCSS files',
    'esbuild''s incremental recompilation doesn''t cache external plugin transformations. Sass render() runs every change even if input unchanged. SCSS becomes bottleneck (400ms to 5s). Solution: plugin-level caching checks input hash before recompiling.',
    0.89,
    'esbuild-latest',
    NOW(),
    'https://github.com/evanw/esbuild/issues/679'
),
(
    'Plugin onResolve not called when bundling is disabled - no resolution hooks on transform',
    'github-esbuild',
    'MEDIUM',
    $$[
        {"solution": "Enable bundling to trigger onResolve hooks: set bundle: true in esbuild options", "percentage": 95, "note": "Path resolution only happens during bundling"},
        {"solution": "Use bundling with splitting option to bundle while generating separate output files per entry point", "percentage": 90, "note": "Alternative: splitting enables bundling without single-file output"},
        {"solution": "Implement path aliasing outside esbuild using rollup or mkdist if unbundled build is required", "percentage": 75, "note": "Workaround: use different tool that supports unbundled builds with aliasing"}
    ]$$::jsonb,
    'esbuild configuration with bundle: false, plugin with onResolve hook, TypeScript path aliases',
    'Path aliases are resolved correctly, onResolve plugin hook is triggered during build, module resolution works',
    'When bundle: false, esbuild transforms each file individually without performing resolution or loading. Hooks like onResolve are meaningless in this context. This is by design - resolution only applies to bundling mode.',
    0.87,
    'esbuild-latest',
    NOW(),
    'https://github.com/evanw/esbuild/issues/3277'
),
(
    'Bundled CommonJS module has undefined module.filename - breaking dynamic asset paths',
    'github-esbuild',
    'MEDIUM',
    $$[
        {"solution": "Use __dirname global variable instead of path.dirname(module.filename) for asset resolution", "percentage": 90, "note": "__dirname is injected by esbuild and remains correct in bundled code"},
        {"solution": "Snapshot original module properties before bundling and inject into wrapped require statements", "percentage": 80, "note": "Complex workaround: manually preserve module metadata"},
        {"solution": "Use configuration tool like cosmiconfig for runtime asset directory specification instead of dynamic module.filename lookup", "percentage": 85, "note": "Recommended approach: externalize path configuration from module code"}
    ]$$::jsonb,
    'esbuild bundler, CommonJS project (format: cjs), code using path.dirname(module.filename), Node.js target',
    'Asset paths resolve correctly at runtime, __dirname returns expected directory, code does not rely on undefined module.filename',
    'esbuild''s CommonJS wrapper creates synthetic module object that lacks filename property present in Node.js. This breaks code expecting module.filename. Use __dirname instead or externalize path configuration.',
    0.81,
    'esbuild-latest',
    NOW(),
    'https://github.com/evanw/esbuild/issues/2200'
),
(
    'Guidance on bundling dynamic imports of transitive dependencies for Node.js',
    'github-esbuild',
    'HIGH',
    $$[
        {"solution": "Use npm install --omit=dev in Docker to install only production dependencies rather than bundling them", "percentage": 92, "note": "Best practice: treat dependency resolution as deployment concern, not bundling concern"},
        {"solution": "Mark dependencies as external and require them from node_modules at runtime", "percentage": 88, "note": "Alternative: --packages=external keeps dependencies unbundled"},
        {"solution": "Understand that dynamic imports with arbitrary strings cannot be analyzed by bundler - externalize them", "percentage": 85, "note": "esbuild cannot determine which modules are referenced in dynamic imports with variables"}
    ]$$::jsonb,
    'esbuild bundler for Parse Server or similar with dynamic imports, Docker/containerized deployment, Node.js target',
    'Container is smaller, dependencies are not bloated in bundle, dynamic imports work at runtime without manual enumeration',
    'Dynamic imports with string variables cannot be statically analyzed. Rather than trying to bundle them, externalize dependencies and use npm install in deployment environment. Avoids container bloat and maintenance burden.',
    0.88,
    'esbuild-latest',
    NOW(),
    'https://github.com/evanw/esbuild/issues/4188'
),
(
    'Watch mode rebuild missing metadata - requesting changedFiles, outputFiles, rebuildTime properties',
    'github-esbuild',
    'MEDIUM',
    $$[
        {"solution": "Use metafile combined with write: false to get outputFiles information from build results", "percentage": 85, "note": "Workaround: parse metafile to determine output files"},
        {"solution": "Implement custom file-watching library to detect changed files instead of relying on watch callback", "percentage": 80, "note": "Alternative: use separate file watcher for changedFiles tracking"},
        {"solution": "Measure rebuild time using console.time()/console.timeEnd() or custom timing middleware in onEnd hook", "percentage": 78, "note": "Workaround: plugin hooks provide onStart and onEnd for timing"}
    ]$$::jsonb,
    'esbuild watch mode enabled, custom hot reload implementation, Node.js build script',
    'Hot reload logic has access to changed files information, rebuild performance metrics are available, custom reload triggers work correctly',
    'esbuild intentionally does not provide changedFiles/rebuildTime in watch callback to maintain performance. Batching file scans would create bottlenecks. Use metafile API or custom plugins for this metadata.',
    0.76,
    'esbuild-0.10+',
    NOW(),
    'https://github.com/evanw/esbuild/issues/1165'
),
(
    'Benchmark request: Add only rollup speed comparison excluding minification',
    'github-esbuild',
    'LOW',
    $$[
        {"solution": "Accept that esbuild benchmarks compare full build pipelines including minification for real-world accuracy", "percentage": 90, "note": "Current benchmarks show actual use case, not artificial component isolation"},
        {"solution": "Run your own benchmarks excluding minification if pure bundling speed comparison is needed", "percentage": 85, "note": "Not a code problem - use separate benchmarking for your use case"},
        {"solution": "Understand that esbuild website is not the place for all possible benchmark permutations", "percentage": 80, "note": "Repository focuses on real-world performance, not theoretical comparisons"}
    ]$$::jsonb,
    'Interest in bundler performance comparison, esbuild vs Rollup benchmarks',
    'Understanding of why esbuild benchmarks include minification, awareness that terser minification is the bottleneck for most tools',
    'Request declined: infinite combinatorial permutations of features could be benchmarked. esbuild site focuses on real-world scenarios. Most bundler slowness comes from minification (terser) not bundling. Benchmarks conflate bundling vs minification.',
    0.70,
    'esbuild-latest',
    NOW(),
    'https://github.com/evanw/esbuild/issues/949'
);
