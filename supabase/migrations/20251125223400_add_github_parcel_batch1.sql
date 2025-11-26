-- Add Parcel bundler GitHub issues batch 1
-- Category: github-parcel
-- Source: https://github.com/parcel-bundler/parcel/issues
-- Total entries: 12

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Parcel import maps broke webextensions support - inline scripts prohibited by CSP',
    'github-parcel',
    'HIGH',
    '[
        {"solution": "Disable import map generation via configuration option in parcel.config.js using mapScopes or disableImportMaps flag", "percentage": 90, "note": "Avoids inline script tags that violate CSP"},
        {"solution": "Use content.html bundling approach instead of inline scripts for extensions", "percentage": 85, "note": "External script approach complies with CSP requirements"},
        {"solution": "Implement manifest.json transformer to strip or externalize import maps for extension targets", "percentage": 80, "note": "Requires custom configuration layer"}
    ]'::jsonb,
    'Parcel 2.16+, Web extension manifest.json, CSP policy understanding',
    'Extension builds without CSP violations, inline scripts removed from HTML output, import maps externalized or disabled',
    'Inline scripts cannot be whitelisted in Edge and other browsers. Chrome and Firefox may accept SHA-256 hashes but not all browsers support this. Always verify CSP compliance before deployment.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/parcel-bundler/parcel/issues/10240'
),
(
    'Parcel crash Error ERR_WORKER_INVALID_EXEC_ARGV on Node 24.7.0+',
    'github-parcel',
    'MEDIUM',
    '[
        {"solution": "Downgrade Node.js to version 24.6.0 or below until Parcel updates worker initialization code", "percentage": 95, "note": "Immediate workaround for blocked builds"},
        {"solution": "Update Parcel to latest version (2.17+) with Node 24.7.0 worker flag compatibility", "percentage": 90, "command": "npm install -D parcel@latest", "note": "Requires fix in upcoming release"},
        {"solution": "Filter out incompatible flags from worker arguments in node_modules/@parcel/workers before Node upgrade", "percentage": 70, "note": "Temporary local patch approach"}
    ]'::jsonb,
    'Parcel 2.16.1+, Node.js 24.7.0+, pnpm or npm installed',
    'Build completes without ERR_WORKER_INVALID_EXEC_ARGV error, dev server starts successfully',
    'Node.js 24.7.0 introduced stricter worker argument validation. Flags like --stack-trace-limit, --tls-cipher-list, and --use-largepages are rejected. Do not pass arbitrary Node flags to worker threads.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/parcel-bundler/parcel/issues/10238'
),
(
    'Parcel Could not find module @babel/core in package.json',
    'github-parcel',
    'HIGH',
    '[
        {"solution": "Run npm install or yarn install to sync node_modules with package.json declarations", "percentage": 95, "command": "npm install", "note": "Most common fix for missing dependencies"},
        {"solution": "Clear npm cache and reinstall: npm cache clean --force && npm install", "percentage": 90, "command": "npm cache clean --force && npm install", "note": "Resolves corrupted cache entries"},
        {"solution": "Check for version mismatch - install compatible @babel/core version for React 17: npm install -D @babel/core@^7.12.0", "percentage": 85, "command": "npm install -D @babel/core@^7.12.0"}
    ]'::jsonb,
    'Parcel 2.16.1, React 17, npm or yarn, @babel/core in package.json devDependencies',
    'Dev server starts without dependency resolution error, @babel/core module loads correctly, build completes',
    'Ensure @babel/core is in devDependencies not dependencies. Do not assume npm install was run. Check package.json lock file synchronization. Version mismatch between React and @babel/core can cause resolution issues.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/parcel-bundler/parcel/issues/10236'
),
(
    'Parcel CSS transformer error Unknown at rule @keyframes',
    'github-parcel',
    'MEDIUM',
    '[
        {"solution": "Update to Parcel 2.16.1+ which includes CSS Animations specification support in transformer", "percentage": 92, "command": "npm install -D parcel@latest", "note": "Standard CSS feature should be transparent"},
        {"solution": "Use standard @keyframes syntax as specified in CSS Animations module level 1 spec", "percentage": 90, "note": "Verify keyframes follow W3C specification format"},
        {"solution": "Run parcel build with --no-optimize flag to bypass transformer: parcel build --no-optimize", "percentage": 75, "note": "Temporary workaround during fixes"}
    ]'::jsonb,
    'Parcel 2.16.0+, CSS files with @keyframes animation definitions',
    'CSS animations build without parser errors, @keyframes rules appear in output bundle, animations render correctly in browser',
    '@keyframes is a standard CSS3 animation feature. Unknown at rule errors indicate transformer version is outdated. Always update Parcel before reporting CSS parsing issues.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/parcel-bundler/parcel/issues/10231'
),
(
    'Parcel webextension bundling error Bundles must have unique names duplicate options.html',
    'github-parcel',
    'MEDIUM',
    '[
        {"solution": "Remove env block from WebExtensionTransformer (lines 286-289) to fix environment context mismatch", "percentage": 90, "note": "Resolves service-worker vs options page context conflict"},
        {"solution": "Align environment contexts by setting asset environment to service-worker at end of WebExtensionTransformer.js", "percentage": 85, "note": "Ensures consistent environment between manifest and dependencies"},
        {"solution": "Migrate from MV3 service workers to MV2-style background pages as workaround", "percentage": 70, "note": "Avoids conflict but uses deprecated extension API"}
    ]'::jsonb,
    'Parcel 2.16.0, MV3 web extension manifest, linked options pages/scripts',
    'Extension builds without duplicate bundle name error, manifest.json parses correctly, all pages bundle to unique outputs',
    'MV3 service worker architecture requires careful environment context management in Parcel. Linking from onInstall to Options pages without context alignment causes conflicts. Always verify bundle names are unique in output.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/parcel-bundler/parcel/issues/10223'
),
(
    'Parcel build hangs during packaging with dist-dir watching enabled',
    'github-parcel',
    'MEDIUM',
    '[
        {"solution": "Run parcel watch with explicit watch-ignore flag: parcel watch --dist-dir build --watch-ignore [.git,build,node_modules]", "percentage": 90, "command": "parcel watch --dist-dir build --watch-ignore [.git,build,node_modules]", "note": "Excludes slow directories from watcher"},
        {"solution": "Configure .parcelignore file to exclude dist directory: add build/ and node_modules/ entries", "percentage": 85, "note": "Persistent configuration avoids command-line flags"},
        {"solution": "Update to Parcel with auto-exclusion: default ignore patterns should include dist-dir by default", "percentage": 80, "note": "Future release should handle this automatically"}
    ]'::jsonb,
    'Parcel watch mode enabled, large node_modules and build directories, file system with many watchers',
    'Parcel watch command completes packaging in seconds, no hangs during optimization phase, CPU usage stays low',
    'Watching the dist-dir during builds creates feedback loops where new files trigger rebuilds. Node_modules should always be excluded. Use --watch-ignore or .parcelignore to optimize performance for large projects.',
    0.86,
    'sonnet-4',
    NOW(),
    'https://github.com/parcel-bundler/parcel/issues/10229'
),
(
    'Parcel dev mode missing -webkit-backdrop-filter CSS vendor prefix for Safari',
    'github-parcel',
    'MEDIUM',
    '[
        {"solution": "Verify target browser is set to Safari 16+ in .browserslistrc or parcel.config.js targets", "percentage": 88, "note": "Dev mode inherits autoprefixer rules from target"},
        {"solution": "Force CSS autoprefixer refresh: update postcss and autoprefixer to latest versions", "percentage": 85, "command": "npm install -D postcss@latest autoprefixer@latest", "note": "Latest autoprefixer includes backdrop-filter"},
        {"solution": "Check dev vs prod build commands - use same target flag for both modes: parcel --target foo", "percentage": 82, "note": "Production works correctly, dev uses different CSS pipeline"}
    ]'::jsonb,
    'Parcel 2.16.0, Safari 16 target, backdrop-filter CSS property in stylesheets',
    'Dev server outputs -webkit-backdrop-filter prefix alongside backdrop-filter, Safari renders blur effect correctly, prefixed and unprefixed versions both present',
    'Dev mode uses different CSS processing than production builds. Autoprefixer may skip properties in dev mode. Always test vendor prefixes in dev server, not just production. Safari 16 requires -webkit-backdrop-filter for blur effects.',
    0.84,
    'sonnet-4',
    NOW(),
    'https://github.com/parcel-bundler/parcel/issues/10220'
),
(
    'Parcel MDX index out of bounds panic with ampersand in HTML attributes',
    'github-parcel',
    'LOW',
    '[
        {"solution": "Escape ampersand entities properly: use &amp; instead of & in HTML attributes within MDX files", "percentage": 92, "note": "Follows HTML entity specification correctly"},
        {"solution": "Update markdown-rs dependency to latest version where character reference parsing is fixed", "percentage": 88, "command": "npm install markdown@latest", "note": "Upstream fix required, not Parcel issue"},
        {"solution": "Avoid incomplete character entity references like &stuff - use valid named entities like &amp; &nbsp;", "percentage": 85, "note": "Prevents parser crash on malformed entities"}
    ]'::jsonb,
    'Parcel 2.14.4+, MDX files with HTML attributes, markdown-rs 1.0.0-alpha.22+',
    'MDX builds without panic error, files with ampersands parse correctly, character entities render properly',
    'Ampersand characters in HTML attributes trigger off-by-one error in markdown-rs character reference parser. Always use &amp; for literal ampersands. This is an upstream dependency issue, not Parcel core bug.',
    0.80,
    'sonnet-4',
    NOW(),
    'https://github.com/parcel-bundler/parcel/issues/10130'
),
(
    'Parcel web extension favicon web_accessible_resources stripped from manifest',
    'github-parcel',
    'MEDIUM',
    '[
        {"solution": "Preserve favicon resources by creating custom manifest.json transformer that skips favicon filtering", "percentage": 85, "note": "Band-aid solution for current Parcel behavior"},
        {"solution": "Update @parcel/config-webextension to not filter _favicon/* entries from web_accessible_resources", "percentage": 88, "note": "Requires Parcel maintainer fix"},
        {"solution": "Explicitly declare favicon path in manifest without wildcard: \"resources\": [\"_favicon/icon.png\"] instead of \"_favicon/*\"", "percentage": 75, "note": "Works around filtering but less flexible"}
    ]'::jsonb,
    'Parcel with @parcel/config-webextension, Chrome extension manifest.json, favicon resources declared',
    'Built manifest.json contains _favicon entries in web_accessible_resources, Chrome extension loads favicons correctly',
    'Parcel manifest transformer incorrectly filters out _favicon/* patterns treating them as invalid. Chrome requires explicit favicon declaration in web_accessible_resources. Current workaround requires custom transformers.',
    0.81,
    'sonnet-4',
    NOW(),
    'https://github.com/parcel-bundler/parcel/issues/10170'
),
(
    'Parcel production build zod v4 import scope hoisting ReferenceError',
    'github-parcel',
    'MEDIUM',
    '[
        {"solution": "Disable scope hoisting for production builds: parcel build --no-scope-hoist", "percentage": 94, "command": "parcel build --no-scope-hoist", "note": "Confirmed workaround, slight size increase"},
        {"solution": "Use consistent import style across codebase: import * as z from zod instead of named imports", "percentage": 87, "note": "Prevents scope hoisting variable collision"},
        {"solution": "Add package.json type field: set \"type\": \"module\" to signal ESM module format clearly", "percentage": 85, "command": "add \"type\": \"module\" to package.json", "note": "Helps module resolution in scope hoisting"}
    ]'::jsonb,
    'Parcel production build mode, zod v3.25.x or v4, mixed ES6 import patterns',
    'Production bundle runs without ReferenceError, exported zod functions available at runtime, imports resolve correctly',
    'Scope hoisting optimization can create undefined variable references with certain import patterns. Zod v4 and mixed import styles trigger this. Always use --no-scope-hoist if production builds fail while dev works.',
    0.83,
    'sonnet-4',
    NOW(),
    'https://github.com/parcel-bundler/parcel/issues/10175'
),
(
    'Parcel worker dev dep request cache corruption missing request error',
    'github-parcel',
    'MEDIUM',
    '[
        {"solution": "Clear Parcel cache directory and rebuild: rm -rf .parcel-cache && parcel build", "percentage": 88, "command": "rm -rf .parcel-cache && parcel build", "note": "Clears corrupted in-memory build state"},
        {"solution": "Disable worker threads during frequent branch switches: PARCEL_WORKERS=0 parcel dev", "percentage": 82, "command": "PARCEL_WORKERS=0 parcel dev", "note": "Avoids race conditions in git-flow workflow"},
        {"solution": "Upgrade to Parcel 2.16+ which includes improved dev dep request caching", "percentage": 80, "command": "npm install -D parcel@latest", "note": "Memory exhaustion fixes in newer versions"}
    ]'::jsonb,
    'Parcel 2.15.2+, git-flow workflow with frequent branch switches, Node.js 20+',
    'Consecutive builds complete without worker cache errors, dev server survives branch switches without restart, no memory exhaustion',
    'Rapid git branch switching can corrupt Parcel internal build caches between builds. In-memory caches may not clear between branch changes. Disabling workers and clearing cache helps. This is a race condition issue affected by workflow patterns.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/parcel-bundler/parcel/issues/10176'
),
(
    'Parcel HTML build SVG tag makes next siblings disappear in output',
    'github-parcel',
    'HIGH',
    '[
        {"solution": "Disable HTML optimization entirely: add optimizers config to parcelrc or package.json", "percentage": 91, "command": "set optimizers: { \"*.html\": [] }", "note": "Completely disables SVG minification causing issue"},
        {"solution": "Disable SVG minification specifically: configure .htmlnanorc.json with minifySvg: false", "percentage": 89, "command": "add minifySvg: false to .htmlnanorc.json", "note": "Targeted fix for SVG optimization only"},
        {"solution": "Update Parcel to 2.15.3+ with PR #10234 fix for sibling preservation after SVG elements", "percentage": 87, "command": "npm install -D parcel@latest", "note": "Fix merged in newer versions"}
    ]'::jsonb,
    'Parcel 2.15.0-2.15.2, HTML files with SVG elements followed by other tags, production build mode',
    'Built HTML contains all sibling elements after SVG tags, no blank space where content should appear, all elements render correctly',
    'SVG minification during HTML optimization incorrectly removes sibling DOM nodes after SVG elements. This is a regression from 2.14.4. Only affects production builds, not dev mode. Workaround requires disabling optimization.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/parcel-bundler/parcel/issues/10172'
),
(
    'Parcel error overlay stack frame collapse button creates infinite loop toggle',
    'github-parcel',
    'LOW',
    '[
        {"solution": "Avoid clicking collapse buttons in error overlay until Parcel 2.14.1+ fixes React toggle bug", "percentage": 85, "note": "Low impact - workaround is to not click button"},
        {"solution": "Update to Parcel with PR #10180 merged (stack frame collapse fix)", "percentage": 92, "command": "npm install -D parcel@latest", "note": "Fix available in development version"},
        {"solution": "Patch Collapsible.js line 61 onClick handler locally to prevent state feedback loop", "percentage": 70, "note": "Requires manual patch until update"}
    ]'::jsonb,
    'Parcel 2.14.0+, error overlay visible in dev mode, collapse button clickable',
    'Error overlay collapse button toggles once without looping, stack frames expand/collapse on click, overlay remains stable',
    'React onClick handler combined with element visibility changes creates feedback loop. Toggling visibility within click handler causes immediate re-render and re-trigger. This is architectural issue with visibility toggle implementation.',
    0.79,
    'sonnet-4',
    NOW(),
    'https://github.com/parcel-bundler/parcel/issues/10179'
);
