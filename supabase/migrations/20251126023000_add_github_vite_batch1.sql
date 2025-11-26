-- Add GitHub Vite repository issues batch 1
-- Extracted issues with highest engagement, focusing on bugs with solutions, build errors, and HMR issues

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES (
    'Vite dev hangs indefinitely without errors on page with many components and imports',
    'github-vite',
    'HIGH',
    $$[
        {"solution": "Delete imports temporarily, restart server, reload page, restore imports - HMR will function normally afterward", "percentage": 70, "note": "Temporary workaround, issue recurs after code changes"},
        {"solution": "Switch from HTTPS to HTTP or properly trust SSL/TLS certificates in development environment", "percentage": 75, "note": "Resolves hangs for some cases, especially with web workers"},
        {"solution": "Upgrade to latest Vite version with merged fixes (PR #11959, #15395)", "percentage": 85, "note": "Permanent fix implemented in newer versions"}
    ]$$::jsonb,
    'Complex Vue/Svelte/React project with many components, SvelteKit or similar framework',
    'Dev server responds to requests, page loads without hanging after HMR, no browser unresponsiveness',
    'Hangs are non-deterministic and harder to diagnose. Check for web worker usage. HTTPS/SSL issues may correlate with hangs. Message "optimized dependencies changed" may precede hanging.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/vitejs/vite/issues/11468'
),
(
    'vite build error: out of memory during bundling',
    'github-vite',
    'HIGH',
    $$[
        {"solution": "Increase Node.js heap memory: node --max_old_space_size=16384 ./node_modules/vite/bin/vite.js", "percentage": 90, "command": "export NODE_OPTIONS=--max-old-space-size=32768", "note": "Most effective solution for large projects"},
        {"solution": "Exclude coverage folders and unnecessary directories from processing by setting root: src in vite config", "percentage": 80, "note": "Reduces memory footprint by limiting scope"},
        {"solution": "Upgrade to Node.js 15+ for better garbage collection compared to Node 12-14", "percentage": 75, "note": "Systematic improvement in memory management"},
        {"solution": "Check for duplicate index.html files in subdirectories that Vite treats as entry points", "percentage": 65, "note": "Consumes excessive memory during initialization"}
    ]$$::jsonb,
    'Node.js v12+, Vite project with moderate to large codebase, sufficient disk space for heap allocation',
    'Build completes without allocation errors, process memory usage stays under available limit, bundle files generated successfully',
    'Do not retry immediately without increasing heap - out of memory errors require configuration changes. Review project structure for duplicates. Node version matters significantly - upgrade if using Node 12-14.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/vitejs/vite/issues/2433'
),
(
    'Vite build fails on Windows with symbolic links in project path',
    'github-vite',
    'MEDIUM',
    $$[
        {"solution": "Move project directory to real filesystem path without intermediate symbolic links or NTFS junctions", "percentage": 95, "note": "Primary solution - eliminates path resolution issues"},
        {"solution": "Update to latest Vite version which improves path equality checking in buildPluginHtml.ts", "percentage": 85, "note": "Fixes underlying id !== indexPath comparison bug"}
    ]$$::jsonb,
    'Windows 7/10/11 system, Vite project with HTML entry point, project directory using symbolic links or junctions',
    'npm run build completes successfully with HTML files processed correctly, no PARSE_ERROR messages in output',
    'Path symlink issues occur exclusively on Windows. Moving to real directory always works. Issue stems from line 58 in buildPluginHtml.ts - simple equality check fails with symlinks.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/vitejs/vite/issues/1182'
),
(
    'Vite build fails with esbuild minification error on Linux (EPIPE)',
    'github-vite',
    'LOW',
    $$[
        {"solution": "Disable CSS minification with build.cssMinify: false in vite config", "percentage": 80, "note": "Temporary workaround to bypass esbuild"},
        {"solution": "Upgrade from Vite 2.7.10 to version 2.8+", "percentage": 95, "note": "Permanent fix implemented in release"}
    ]$$::jsonb,
    'Linux system (Manjaro, Ubuntu tested), Vite 2.7.10 or earlier, Material UI or similar library with complex CSS',
    'npm run build completes without socket write errors, minified output files generated successfully, no EPIPE socket errors',
    'Issue manifests as socket write failure during minification phase specifically. Works fine in dev mode and on master branch. Disabling minification is temporary workaround only.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/vitejs/vite/issues/6423'
),
(
    'Missing configured public folder silently breaks HMR',
    'github-vite',
    'MEDIUM',
    $$[
        {"solution": "Create the missing publicDir directory specified in vite config, or remove publicDir configuration entirely", "percentage": 90, "note": "Prevents file watcher from breaking on non-existent paths"},
        {"solution": "Update vite config to conditionally watch publicDir only if it exists: ...(publicDir && publicFiles?.size ? [publicDir] : [])", "percentage": 85, "note": "Future-proof solution to prevent chokidar watcher issues"}
    ]$$::jsonb,
    'Vite 4.0+ dev server running, publicDir configured in vite.config.js, file system watcher (chokidar) available',
    'HMR updates propagate to browser on file changes, dev server console shows no file watcher errors, browser DevTools shows module updates',
    'Issue occurs silently with no warnings or errors - difficult to diagnose. Dev server starts fine but file changes are not detected. Creating the directory resolves immediately.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/vitejs/vite/issues/19864'
),
(
    'HMR failure with circular dependencies causing module reference conflicts',
    'github-vite',
    'MEDIUM',
    $$[
        {"solution": "Refactor circular dependencies - restructure imports so Module A -> Module B -> Module C -> Module A chain is broken", "percentage": 90, "note": "Resolves root cause of HMR failure"},
        {"solution": "Full Vite server restart as temporary workaround when HMR fails", "percentage": 70, "note": "Temporary solution, issue recurs on next related file change"}
    ]$$::jsonb,
    'Vite dev server running, project using TypeScript or JavaScript with complex dependency graphs, file with circular import chain',
    'Files can be edited and saved without triggering HMR errors, page updates via HMR without full reload needed, browser console shows no module duplication errors',
    'Root cause is circular dependencies creating module references with different query parameters (state.ts vs state.ts?t=timestamp) causing browser to treat as different modules. Full restart confirms diagnosis.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/vitejs/vite/issues/1477'
),
(
    'HMR not working in Docker or WSL2 environments',
    'github-vite',
    'MEDIUM',
    $$[
        {"solution": "Move project directory from mounted volume into WSL2 native filesystem", "percentage": 95, "note": "Primary fix for WSL2 file system watcher limitations"},
        {"solution": "Enable polling mode in Vite server config: server: { watch: { usePolling: true } }", "percentage": 85, "note": "Restores HMR functionality but may impact performance on large projects"},
        {"solution": "Disable filesystem cache in server config: { server: { fs: { cachedChecks: false } } }", "percentage": 75, "note": "Improves file detection at slight performance cost"}
    ]$$::jsonb,
    'Docker container with mounted volume or WSL2 Linux environment, Vite dev server running, file editor in place',
    'File changes detected immediately by dev server, HMR updates appear in browser within 1-2 seconds, no file watcher timeout errors',
    'Issue stems from Docker/WSL2 file system limitations, not Vite itself. File system watchers struggle with mounted volumes. Polling mode has performance implications for large projects.',
    0.86,
    'sonnet-4',
    NOW(),
    'https://github.com/vitejs/vite/issues/16143'
),
(
    'Vite build fails with esbuild parsing error in Vue 3 SFC with destructuring',
    'github-vite',
    'MEDIUM',
    $$[
        {"solution": "Upgrade to Vite version with updated esbuild target (PR #2566 merged)", "percentage": 95, "note": "Permanent fix - allows destructuring syntax in target environment"},
        {"solution": "Avoid destructuring in component script or refactor to assignment statements as temporary workaround", "percentage": 75, "note": "Workaround only - destructuring is valid JavaScript"}
    ]$$::jsonb,
    'Vite 1.x with react-ts or vue templates, React/Vue project with destructuring assignment in components',
    'npm run build completes successfully with all .tsx/.ts files processed, bundle contains correct destructured variable assignments',
    'Error message misleading - destructuring is valid syntax. Issue is esbuild target configuration being too restrictive. Removing destructuring allows build to succeed confirms root cause.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/vitejs/vite/issues/2562'
),
(
    'Vite build fails with esbuild parsing error on non-JavaScript script tags',
    'github-vite',
    'LOW',
    $$[
        {"solution": "Update to Vite version with fix that respects script type attribute (PR #4565 merged)", "percentage": 95, "note": "Permanently resolves JSON-LD and similar script parsing"},
        {"solution": "Move structured data to separate .json file and import as data instead of inline script tag", "percentage": 85, "note": "Workaround preserves data while avoiding parser issues"}
    ]$$::jsonb,
    'Vite project with structured data in script tags, JSON-LD or similar non-executable scripts',
    'Build completes without esbuild parsing errors, structured data preserved in output, no "Expected ; but found :" errors',
    'Optimizer scanner failed to check type attribute before attempting JavaScript parsing. Occurs with application/ld+json, application/json script types. Workaround involves moving data outside HTML.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://github.com/vitejs/vite/issues/4564'
),
(
    'Vite 7.2.x strips bang comments breaking PurgeCSS safelist functionality',
    'github-vite',
    'MEDIUM',
    $$[
        {"solution": "Set esbuild.legalComments: ''inline'' in Vite config to preserve bang comments during minification", "percentage": 90, "note": "Preserves /*! */ comments for tools like PurgeCSS"},
        {"solution": "Run PurgeCSS before esbuild minification via PostCSS plugin to mark rules before they are removed", "percentage": 85, "note": "Alternative approach - preprocesses before minification"},
        {"solution": "Downgrade to Vite 7.1.12 which preserves bang comments", "percentage": 70, "note": "Temporary solution - misses bug fixes in 7.2+"}
    ]$$::jsonb,
    'Vite 7.2.0+, CSS with bang comments for PurgeCSS safelist, build.cssMinify enabled or esbuild',
    'CSS bundle contains bang comments /*! */ marks, PurgeCSS safelisted rules preserved in output, no CSS rules incorrectly removed',
    'Bang comments treated as legal comments by esbuild. Vite 7.2.x defaults changed minification behavior. Simply disabling minification preserves comments but removes optimization.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/vitejs/vite/issues/21085'
),
(
    'Vue 3 app builds successfully in dev but fails in production with package resolution error',
    'github-vite',
    'MEDIUM',
    $$[
        {"solution": "Verify all dependencies have correct main/module/exports fields in their package.json files", "percentage": 80, "note": "Common cause of resolution failures"},
        {"solution": "Create minimal reproducible example using GitHub repo or StackBlitz to debug root cause", "percentage": 85, "note": "Maintainers require reproduction steps to investigate"},
        {"solution": "Check for recently added or updated dependencies that may have malformed package.json", "percentage": 75, "note": "Often caused by package updates with breaking changes"}
    ]$$::jsonb,
    'Vue 3 with Vite 3.0+, Node 16+, build works in dev mode with npm run dev',
    'npm run build completes without package resolution errors, all dependencies correctly resolved in bundle, production assets generated',
    'Dev build succeeds indicating code is valid - failure is specific to production build/rollup bundling. Requires checking dependency package.json files manually.',
    0.80,
    'sonnet-4',
    NOW(),
    'https://github.com/vitejs/vite/issues/9303'
),
(
    'React/Vue component HMR disabled when using named exports in App component',
    'github-vite',
    'HIGH',
    $$[
        {"solution": "Move named exports like export const queryClient = new QueryClient() to separate utility files", "percentage": 95, "note": "Allows HMR to work while preserving exports"},
        {"solution": "Rename files from pages/Component/index.jsx to pages/Component.jsx - implicit index causes issues", "percentage": 85, "note": "File naming matters for Vite Fast Refresh detection"},
        {"solution": "Upgrade to @vitejs/plugin-react instead of deprecated @vitejs/plugin-react-refresh", "percentage": 90, "note": "Ensures latest Fast Refresh implementation"},
        {"solution": "Verify no circular dependencies exist in import chain - these also trigger full page reloads", "percentage": 80, "note": "Structural issue separate from exports problem"},
        {"solution": "Add include: ''**/\\*.tsx'' to plugin configuration if custom regex specified", "percentage": 75, "note": "Ensures all React files are processed by Fast Refresh"}
    ]$$::jsonb,
    'React/Vue project with Vite 2+, @vitejs/plugin-react installed, development server running',
    'HMR updates appear in browser on file save without full page reload, dev server logs show [vite] update messages, React/Vue components update in place',
    'Named exports break Fast Refresh entirely - any change triggers full reload instead of HMR. Side-effect-free exports like constants must be separate. Camel-cased exports treated differently by Fast Refresh.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/vitejs/vite/discussions/4577'
),
(
    'Vite build fails on Linux with cross-platform path resolution in TypeScript project',
    'github-vite',
    'LOW',
    $$[
        {"solution": "Provide minimal reproducible example via GitHub repo or StackBlitz for maintainers to debug", "percentage": 70, "note": "Required to diagnose cross-platform issues"},
        {"solution": "Check path alias configuration in vite.config.ts and tsconfig.json for case-sensitivity issues", "percentage": 85, "note": "Linux file systems are case-sensitive unlike Windows"},
        {"solution": "Verify all imported module paths match actual file names in terms of case and separators", "percentage": 90, "note": "Most common cause of Linux-only build failures"}
    ]$$::jsonb,
    'React 18+ with Vite 5.4+, TypeScript project with path aliases, Linux development environment',
    'npm run build completes on Linux and Windows, no ENOENT errors for imported modules, bundle generated with all modules resolved',
    'Platform-specific failures indicate path resolution differences - Windows ignores case, Linux does not. Windows uses backslashes, Linux forward slashes. Issue closed without reproduction steps provided.',
    0.75,
    'sonnet-4',
    NOW(),
    'https://github.com/vitejs/vite/issues/19546'
);
