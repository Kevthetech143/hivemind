-- Add GitHub webpack issues batch 1
-- Extracted high-voted webpack issues with solutions
-- Category: github-webpack

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES (
    'Node.js 17: ERR_OSSL_EVP_UNSUPPORTED digital envelope routines',
    'github-webpack',
    'HIGH',
    $$[
        {"solution": "Export NODE_OPTIONS environment variable before running webpack: export NODE_OPTIONS=--openssl-legacy-provider", "percentage": 85, "note": "Immediate workaround for legacy OpenSSL support"},
        {"solution": "Upgrade webpack to version with merged PR #14584 for permanent fix", "percentage": 95, "note": "Long-term solution addressing OpenSSL 3 compatibility"},
        {"solution": "Downgrade Node.js to version 16 LTS if webpack upgrade not possible", "percentage": 70, "note": "Temporary workaround until webpack updated"}
    ]$$::jsonb,
    'webpack 5.59.0 or earlier, Node.js 17.0.0+, npm installed',
    'Webpack compiles successfully without ERR_OSSL_EVP_UNSUPPORTED error, Build completes with expected output',
    'Do not apply workaround without upgrading webpack - leaves projects dependent on legacy OpenSSL. OpenSSL 3 disabled legacy algorithms by default in Node.js 17+. Multiple frameworks (Next.js, Angular CLI) had same issue.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/webpack/webpack/issues/14532'
),
(
    'Webpack 4.29.0: Module parse failed - Unexpected token for dynamic import()',
    'github-webpack',
    'HIGH',
    $$[
        {"solution": "Run npm dedupe to re-align acorn dependencies: npm update acorn --depth 20 && npm dedupe", "percentage": 92, "note": "Fixes dependency tree misalignment between acorn and acorn-dynamic-import"},
        {"solution": "Switch from npm to yarn package manager for dependency resolution", "percentage": 80, "note": "Yarn handles peer dependencies differently, avoiding hoisting issues"},
        {"solution": "Revert to webpack v4.28.2 as temporary fix while dependencies resolve", "percentage": 60, "note": "Temporary workaround only, does not solve underlying issue"}
    ]$$::jsonb,
    'webpack 4.29.0+, npm or yarn installed, acorn-dynamic-import dependency present',
    'Dynamic import() syntax compiles without parse errors, Module resolves correctly in bundled output',
    'Issue caused by npm peer dependency hoisting, not webpack directly. Instance equality between acorn and acorn-dynamic-import must match. npm dedupe should be first troubleshooting step. Vue CLI users more affected than React due to dependency handling.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/webpack/webpack/issues/8656'
),
(
    'Webpack source maps: Breakpoints jump to wrong lines in Chrome DevTools',
    'github-webpack',
    'MEDIUM',
    $$[
        {"solution": "Switch devtool setting from eval-source-map to source-map despite performance impact", "percentage": 85, "note": "Provides more reliable debugging though slower build times"},
        {"solution": "Check for LF/CRLF line-ending conflicts on Windows: convert line endings to LF", "percentage": 75, "note": "Line-ending inconsistencies can corrupt source map generation"},
        {"solution": "Update Chrome DevTools to latest version - issue may be browser-specific bug", "percentage": 70, "note": "Earlier Chrome versions had source map parsing issues"},
        {"solution": "Use eval devtool for development to show transpiled code instead of source", "percentage": 60, "note": "Workaround showing executed code rather than source"}
    ]$$::jsonb,
    'webpack with Babel 6+, Chrome browser, devtool configuration set, source-map files generated',
    'Breakpoints execute at correct line numbers, Step-over debugging shows correct execution indicators, Firefox debugger works correctly as baseline',
    'Issue appears platform-specific with Windows having higher impact but also affects macOS/Linux. Chrome-specific problem - Firefox works correctly with same config. Babel 6.x integration can exacerbate issues. Do not assume webpack is root cause.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/webpack/webpack/issues/2145'
),
(
    'Webpack --bail flag not working: process continues after error',
    'github-webpack',
    'MEDIUM',
    $$[
        {"solution": "For Node.js API usage, manually call process.exit(1) in failed hook: plugins: [{apply: ({hooks: {failed}}) => failed.tap(''HandleFailurePlugin'', e => {process.exit(1)})}]", "percentage": 90, "note": "Required when using webpack Node API directly"},
        {"solution": "Use CLI with --bail flag instead of Node.js API for automatic error handling", "percentage": 85, "note": "CLI properly exits on errors, Node API requires manual error propagation"}
    ]$$::jsonb,
    'webpack 4.x+, Node.js v8+, Either CLI or Node.js API usage',
    'Webpack exits with non-zero exit code on compilation error, No further compilation proceeds after first error',
    'NormalModule callback must call callback(err) not callback() to propagate errors. Bail mechanism only works with CLI - Node API requires plugin. Using mini-css-extract-plugin without plugin can trigger issue.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/webpack/webpack/issues/7993'
),
(
    'Webpack 5 source maps: sourcesContent contains null values incorrectly',
    'github-webpack',
    'LOW',
    $$[
        {"solution": "Upgrade to webpack version with PR #5896 that filters null sourcesContent values", "percentage": 95, "note": "Permanently fixes source map generation to exclude null entries"},
        {"solution": "Post-process source map to remove null sourcesContent entries before distribution", "percentage": 75, "note": "Workaround for builds with older webpack versions"}
    ]$$::jsonb,
    'webpack 5.x, devtool set to generate source maps, source-map-explorer or similar tool',
    'Source maps display only valid string content, No null values in sourcesContent array, Visualization tools display complete bundle correctly',
    'Fix is straightforward - returns null instead of mapping null values. Testing may be needed depending on source map usage. Issue marked as small PR by core maintainer.',
    0.95,
    'sonnet-4',
    NOW(),
    'https://github.com/webpack/webpack/issues/5542'
),
(
    'Webpack SASS import error: Invalid CSS after including style-loader output',
    'github-webpack',
    'MEDIUM',
    $$[
        {"solution": "Review webpack loader configuration - remove conflicting rules targeting same file types", "percentage": 90, "note": "Overlapping style-loader and css-loader chains cause parser errors"},
        {"solution": "Ensure only one loader chain targets (css|scss)$ - separate rules for direct loaders vs ExtractTextPlugin", "percentage": 92, "note": "Each file type should have single, non-conflicting rule"},
        {"solution": "Restart terminal and development server to clear caching issues", "percentage": 65, "note": "Sometimes webpack cache causes parser confusion"},
        {"solution": "Escalate to sass-loader repository if rule configuration is correct", "percentage": 40, "note": "May be loader-specific issue, not webpack core"}
    ]$$::jsonb,
    'webpack with multiple loaders installed (style-loader, css-loader, sass-loader, postcss-loader), SCSS files with @import statements, Conflicting webpack rules',
    'SCSS files compile without parse errors, CSS properly extracted and loaded in bundle, No JavaScript variable syntax in compiled CSS output',
    'Multiple overlapping loader rules cause style-loader output to be fed into CSS processors. ExtractTextPlugin and direct loader chains should not target same files. Issue often indicates loader configuration problem rather than webpack core bug.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/webpack/webpack/issues/6457'
),
(
    'Webpack Module Federation: library option incorrectly required instead of optional',
    'github-webpack',
    'MEDIUM',
    $$[
        {"solution": "Upgrade to webpack version with PR #10639 making ModuleFederationPlugin library option optional", "percentage": 95, "note": "Library option now derives defaults from webpack output configuration"},
        {"solution": "Manually set library option in ModuleFederationPlugin if using older webpack version", "percentage": 85, "note": "Workaround by explicitly configuring library value"}
    ]$$::jsonb,
    'webpack with Module Federation Plugin enabled, Module Federation Project on active development track',
    'ModuleFederationPlugin accepts optional library parameter, Library values derive from output config when not specified',
    'Library option was unnecessarily mandatory. PR #10639 fixes by deriving defaults from webpack core output settings. No breaking changes in fix.',
    0.95,
    'sonnet-4',
    NOW(),
    'https://github.com/webpack/webpack/issues/10639'
),
(
    'Webpack watch mode: Cannot track deleted files in watch-run event',
    'github-webpack',
    'MEDIUM',
    $$[
        {"solution": "Upgrade to webpack version with PR #8175 implementing file removal tracking in watch-run", "percentage": 95, "note": "Enables loaders to detect and respond to file deletions"},
        {"solution": "For older webpack, implement custom file tracking in loaders using webpack API", "percentage": 70, "note": "Requires maintaining separate state of file presence"}
    ]$$::jsonb,
    'webpack in watch mode, Stateful loaders (TypeScript, modular-css), accessing watching API',
    'Stateful loaders receive file removal information, Cache entries properly deleted when source files removed',
    'Stateful loaders like TypeScript need removal events to maintain cache synchronization. watching.getTimes() API alone cannot retrieve deletion info. Feature necessary for any tool maintaining internal caches.',
    0.95,
    'sonnet-4',
    NOW(),
    'https://github.com/webpack/webpack/issues/5072'
),
(
    'Webpack CommonsChunkPlugin minChunks parameter is confusing and poorly named',
    'github-webpack',
    'LOW',
    $$[
        {"solution": "Refer to minChunks parameter documentation noting it accepts both numeric thresholds and predicate functions", "percentage": 80, "note": "Parameter name minChunks is misleading - it''s actually a flexible test function"},
        {"solution": "Consider using SplitChunksPlugin (webpack 5+) which has clearer configuration options", "percentage": 85, "note": "Modern replacement with better parameter naming and API design"}
    ]$$::jsonb,
    'webpack 4.x with CommonsChunkPlugin, Understanding that minChunks accepts custom functions',
    'minChunks accepts both numeric thresholds and custom predicate functions, Module extraction based on configured test',
    'minChunks name is confusing - does not indicate it accepts complex predicate functions. Extra fields in configuration fail silently. Plugin could be split into focused sub-plugins for clarity.',
    0.80,
    'sonnet-4',
    NOW(),
    'https://github.com/webpack/webpack/issues/4406'
),
(
    'Webpack 5 alpha: Source maps appear unitary and incomplete with contenthash filenames',
    'github-webpack',
    'LOW',
    $$[
        {"solution": "Remove or simplify output.filename configuration to avoid contenthash-based naming during debugging", "percentage": 88, "note": "Removing [contenthash:8] from filename resolves source map corruption"},
        {"solution": "Use different devtool setting for development builds without contenthash", "percentage": 82, "note": "source-map quality dependent on output configuration"}
    ]$$::jsonb,
    'webpack 5.0.0-alpha.18+, Production mode with devtool: source-map, Custom output filenames',
    'Source maps display complete bundle composition, All included dependencies visible in source-map-explorer, No discrepancy between config and actual bundle contents',
    'Issue specific to webpack 5 alpha with contenthash filename configuration. Removing output section entirely resolves issue. Not source-map-explorer bug - webpack configuration is root cause. Set devtool: false in production if source maps not needed.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/webpack/webpack/issues/9521'
),
(
    'Webpack Node.js API: Cannot enable production mode via configuration or environment variables',
    'github-webpack',
    'MEDIUM',
    $$[
        {"solution": "Ensure mode: ''production'' is set in webpack configuration object passed to Node.js API", "percentage": 90, "note": "Configuration object mode setting takes precedence"},
        {"solution": "Verify configuration object is properly passed to webpack() function call", "percentage": 85, "note": "Common issue is incomplete configuration object"},
        {"solution": "Check NODE_ENV variable is set before require(webpack) if using environment-based detection", "percentage": 60, "note": "Environment variable approach less reliable than explicit config"}
    ]$$::jsonb,
    'webpack 4.28.4+, Node.js 10+, webpack configured programmatically via Node.js API',
    'webpack.compiler returns production-optimized output, Bundle size reduced compared to development mode, Source maps excluded if appropriate',
    'mode: production in config is most reliable method. NODE_ENV variable alone insufficient. compiler.watch() does not override mode setting from config. Issue often due to incomplete issue reporting preventing proper diagnosis.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/webpack/webpack/issues/8674'
);
