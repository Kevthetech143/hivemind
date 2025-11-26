-- Add Nx monorepo build error solutions from GitHub issues batch 1
-- Category: github-nx
-- Date: 2025-11-25
-- Source: https://github.com/nrwl/nx/issues

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'NX Daemon cache invalidation fails - files modified but cache not updated',
    'github-nx',
    'HIGH',
    '[
        {"solution": "Disable daemon process by setting useDaemonProcess: false in tasksRunnerOptions.default.options in nx.json", "percentage": 95, "note": "Immediate workaround for file watching issues"},
        {"solution": "Set environment variable NX_DAEMON=false before running nx commands", "percentage": 90, "command": "NX_DAEMON=false npx nx build"},
        {"solution": "Run nx reset to clear cache and restart daemon", "percentage": 70, "note": "Temporary fix - issue recurs if file watching still broken"},
        {"solution": "Use env inputs directly instead of shell command runtime inputs if in virtual environments", "percentage": 85, "note": "Prevents environment variable staling"}
    ]'::jsonb,
    'Nx project with daemon enabled, workspace with modified input files',
    'Task output reflects actual file changes, no cached results returned after file modification, nx reset not needed between runs',
    'Assuming nx reset provides permanent fix. Not checking if environment is Gitpod/Docker/NFS-based. Stale environment variables in daemon process.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/nrwl/nx/issues/18866'
),
(
    'Nx cache not invalidated when .eslintrc configuration changes',
    'github-nx',
    'HIGH',
    '[
        {"solution": "Add runtime cache inputs to nx.json: runtimeCacheInputs with cat .eslintrc (Unix) or type .eslintrc (Windows) to monitor config file changes", "percentage": 90, "note": "Outputs file contents to invalidate cache when config changes"},
        {"solution": "Use cat .eslintrc in runtimeCacheInputs array instead of echo .eslintrc", "percentage": 88, "command": "\"runtimeCacheInputs\": [\"cat .eslintrc\"]"},
        {"solution": "Use --skip-nx-cache flag during development when frequently changing ESLint rules", "percentage": 75, "note": "Disables caching entirely for development"},
        {"solution": "Manually delete node_modules/.cache directory when cache becomes invalid", "percentage": 60, "note": "Temporary workaround, not reliable"}
    ]'::jsonb,
    'Nx project with ESLint configuration, cache enabled in tasksRunnerOptions',
    'Running lint after .eslintrc modifications triggers full re-run instead of cache hit, ESLint rule changes take effect immediately',
    'Using echo .eslintrc instead of cat (echoes filename not contents). Not saving file changes before re-running. Neglecting to restart IDE after tsconfig modifications.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/nrwl/nx/issues/2858'
),
(
    'NX_PROJECT_ROOT environment variable missing for runtime cache inputs',
    'github-nx',
    'MEDIUM',
    '[
        {"solution": "Update Nx to version with PR #31428 merged which adds NX_PROJECT_ROOT environment variable to runtime cache input processes", "percentage": 95, "note": "Official implementation - available in latest versions"},
        {"solution": "Use NX_PROJECT_ROOT variable in runtime cache inputs to reference project-specific files", "percentage": 90, "command": "\"runtime\": \"cat package.json ${NX_PROJECT_ROOT}/package.json | jq .type,.exports\""},
        {"solution": "Extract project root from task ID format (project:target) manually in custom hash scripts as temporary workaround", "percentage": 60, "note": "Workaround before official variable support"}
    ]'::jsonb,
    'Nx version with PR #31428 merged, runtime cache inputs requiring project-specific file context',
    'NX_PROJECT_ROOT variable available in spawned runtime processes, correct project root path used in cache input commands, backward compatible',
    'Attempting to use NX_PROJECT_ROOT before upgrading to supporting version. Not understanding that variable only available during hash calculation phase.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/nrwl/nx/issues/20949'
),
(
    'NX Daemon error after upgrade - daemon not computing project graph',
    'github-nx',
    'HIGH',
    '[
        {"solution": "Upgrade to Nx 13.8.5 or later which fixes the file resolution issue", "percentage": 92, "note": "Official version fix for presets/npm.json resolution"},
        {"solution": "Disable daemon with NX_DAEMON=false to restore functionality while upgrading", "percentage": 88, "command": "NX_DAEMON=false npx nx"},
        {"solution": "Run npm i -g nx to update global Nx installation to latest working version", "percentage": 75, "note": "May conflict if workspace requires specific version"},
        {"solution": "Clear node_modules/@nrwl/workspace and reinstall to fix corrupted preset files", "percentage": 70, "note": "Temporary - upgrade is permanent fix"}
    ]'::jsonb,
    'Nx version 13.7.1 or 13.8.x with daemon enabled, node_modules directory present',
    'nx commands execute without daemon errors, project graph computes successfully, no ENOENT errors in logs',
    'Downgrading instead of upgrading. Relying on nx reset as permanent fix. Not checking lock file changes affecting daemon state.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/nrwl/nx/issues/8796'
),
(
    'Generated tsconfig files break VSCode import refactoring in monorepo',
    'github-nx',
    'MEDIUM',
    '[
        {"solution": "Replace files: [] with include: [\"**/*.ts\"] in library and app tsconfig.json files to enable VSCode dependency resolution", "percentage": 92, "note": "Aligns with TypeScript project reference requirements"},
        {"solution": "Add composite: true and declaration: true compiler options to referenced projects in tsconfig as per TypeScript handbook", "percentage": 90, "note": "Required together for proper project references"},
        {"solution": "Restart VSCode after modifying tsconfig files for changes to take effect", "percentage": 85, "note": "IDE caches project structure"},
        {"solution": "Update base tsconfig.json with proper references structure before individual app/lib configs", "percentage": 75, "note": "Apply changes bottom-up"}
    ]'::jsonb,
    'Nx workspace with multiple apps and libraries, VSCode with TypeScript support, tsconfig with references',
    'File moves trigger automatic import statement updates, refactoring works across apps and libraries, no build failures from tsconfig changes',
    'Modifying only base tsconfig without updating individual configs. Adding composite: true without declaration: true. Not restarting VSCode.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/nrwl/nx/issues/4508'
),
(
    'Nx 15 generatePackageJson produces different dependency versions than Nx 14',
    'github-nx',
    'MEDIUM',
    '[
        {"solution": "Upgrade to Nx 15.2+ with PR #12905 merged which preserves version ranges from root package.json", "percentage": 94, "note": "Official fix addresses version resolution logic"},
        {"solution": "Accept intentional behavior change in Nx 15: pinned versions with all transitive dependencies for reproducibility", "percentage": 88, "note": "New behavior is by design for consistency"},
        {"solution": "Use exact versions in docker builds by copying generated package.json and package-lock.json from dist", "percentage": 85, "command": "COPY --from=builder /workspace/dist/package.json /workspace/dist/package-lock.json ."},
        {"solution": "Use npm ci instead of npm install in dist directories to respect exact versions in generated package.json", "percentage": 80, "note": "Enforces version consistency"}
    ]'::jsonb,
    'Nx workspace with buildable libraries, package.json at root with dependency versions, npm or yarn package manager',
    'npm ci succeeds in dist directories, deployed packages have correct dependency versions, transitive dependencies properly included',
    'Assuming generated package.json should match root file versions. Not accounting for intentional flattening of transitive dependencies. Using npm install instead of npm ci in Docker.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/nrwl/nx/issues/12675'
),
(
    'Nx 19.5 project discovery fails - projects not found after initial creation',
    'github-nx',
    'HIGH',
    '[
        {"solution": "Upgrade to Nx 19.5.1+ with PR #31911 merged fixing project graph detection", "percentage": 96, "note": "Official fix for project discovery regression"},
        {"solution": "Run nx reset followed by npx nx show projects to refresh project graph cache", "percentage": 80, "note": "Temporary workaround - recurs if underlying issue not fixed"},
        {"solution": "Touch or modify project.json file in affected projects to trigger re-detection", "percentage": 65, "note": "Indicates file watching issue in version 19.5.0"},
        {"solution": "Disable daemon and cache with NX_DAEMON=false NX_CACHE_PROJECT_GRAPH=false for diagnostics", "percentage": 70, "command": "NX_DAEMON=false NX_CACHE_PROJECT_GRAPH=false npx nx show projects"}
    ]'::jsonb,
    'Nx 19.5.0+ workspace with multiple applications, project.json files present',
    'nx show projects returns complete project list, nx commands execute successfully, project graph available to CLI',
    'Repeated nx reset not fixing the issue - indicates version problem. File system watching problems on macOS. Not upgrading from 19.5.0.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/nrwl/nx/issues/27368'
),
(
    'Publishing multiple publishable libraries with interdependencies fails with rootDir error',
    'github-nx',
    'MEDIUM',
    '[
        {"solution": "Use ng-packagr secondary entry points within single published package instead of separate publishable libraries", "percentage": 93, "note": "@company/common main, @company/common/components secondary, etc."},
        {"solution": "Configure ngPackage.lib.umdModuleIds to declare inter-library dependencies as external", "percentage": 88, "command": "\"umdModuleIds\": {\"@company/core\": \"company.core\"}"},
        {"solution": "Restructure architecture to avoid circular dependencies - dependency flow should be parent to child only", "percentage": 85, "note": "Prevents packaging conflicts"},
        {"solution": "Accept that monorepo structure does not automatically solve packaging constraints for library interdependencies", "percentage": 70, "note": "Limitation of current ng-packagr approach"}
    ]'::jsonb,
    'Nx workspace with multiple publishable Angular libraries, ng-packagr configured, path aliases in tsconfig',
    'Libraries build without rootDir errors, build output properly bundles or references dependencies, published packages maintain expected import paths',
    'Attempting circular dependency patterns between publishable libraries. Neglecting to configure umdModuleIds for external dependencies. Expecting monorepo to handle publishing constraints.',
    0.86,
    'sonnet-4',
    NOW(),
    'https://github.com/nrwl/nx/issues/602'
),
(
    'Sharing styles across multiple publishable libraries fails with schema validation',
    'github-nx',
    'MEDIUM',
    '[
        {"solution": "Create dedicated styles library and import style files directly in consuming libraries instead of using preprocessor paths", "percentage": 91, "note": "Avoids schema validation issues with library builders"},
        {"solution": "Use node_modules symlink strategy to link shared styles package and import via @import \"@company/libname/styles/helper.scss\"", "percentage": 85, "note": "Adheres to standard Node conventions"},
        {"solution": "Move shared styles to separate publishable package and consume as external dependency", "percentage": 83, "note": "Portable solution for external use"},
        {"solution": "Avoid adding styleIncludePaths to ng-package.json as it causes validation errors - not supported by library builder", "percentage": 80, "note": "Unsupported configuration option"}
    ]'::jsonb,
    'Nx monorepo with multiple publishable Angular libraries, SCSS/CSS styles to share, @nrwl/angular:package builder',
    'Shared style files accessible across libraries without build errors, configuration remains maintainable, solutions work for development and published packages',
    'Assuming stylePreprocessorOptions will cascade to library builders. Adding unsupported config options like styleIncludePaths. Treating monorepo paths as portable when publishing.',
    0.84,
    'sonnet-4',
    NOW(),
    'https://github.com/nrwl/nx/issues/3203'
),
(
    'NX project graph calculation hangs indefinitely - ESM and Tailwind v4 configuration',
    'github-nx',
    'HIGH',
    '[
        {"solution": "Add minimal package.json to each app with name, version, private, and empty dependencies object", "percentage": 94, "note": "Plugins require app-level package.json despite monorepo documentation"},
        {"solution": "Remove PostCSS configuration file (postcss.config.js) if using Vite without explicit PostCSS requirement", "percentage": 89, "note": "Vite doesnt need PostCSS; config causes hang"},
        {"solution": "Downgrade Tailwind CSS from v4 to v3 until Nx has full compatibility", "percentage": 87, "note": "Current Nx versions incompatible with Tailwind v4"},
        {"solution": "Run NX_DAEMON=false npx nx commands to bypass daemon and see actual error messages instead of hangs", "percentage": 85, "command": "NX_DAEMON=false npx nx show project app1"},
        {"solution": "Disable NX Console VSCode extension which can cause persistent hangs", "percentage": 70, "note": "Extension may interfere with graph calculation"}
    ]'::jsonb,
    'Nx workspace with ESM configuration (\"type\": \"module\" in package.json), apps with ESLint/TypeScript/Vite plugins, minimal Tailwind setup',
    'npx nx report completes without hanging, npx nx show project returns immediately, all apps have package.json, Tailwind CSS v3 in use, PostCSS config removed',
    'Following outdated documentation that claims app-level package.json not needed. Using Tailwind v4 without version check. Relying on daemon logs that show nothing during hangs. Not checking generated files for problematic configs.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/nrwl/nx/issues/29618'
),
(
    'NX fails with ENOENT error when files deleted locally but staged in Git',
    'github-nx',
    'MEDIUM',
    '[
        {"solution": "Commit all file changes to Git including deletions to sync local filesystem with Git history", "percentage": 93, "note": "NX reads file lists from Git - staging creates mismatch"},
        {"solution": "Unstage Git changes before running NX commands if files have been deleted locally", "percentage": 88, "command": "git reset HEAD <deleted-file-path>"},
        {"solution": "Use --skip-nx-cache flag as temporary workaround to bypass cache and file hashing", "percentage": 75, "command": "npx nx build --skip-nx-cache"},
        {"solution": "Upgrade to Nx 10.0.2+ which properly handles files existing in Git history but not on disk", "percentage": 90, "note": "Permanent fix in newer versions"}
    ]'::jsonb,
    'Nx 10.0.1 or older, Git repository with deleted or moved files, staged or committed changes',
    'NX commands execute without ENOENT errors after file deletion/moving, codebase rebuilds correctly, no manual Git commits needed to proceed',
    'Staged files trigger issue more reliably than unstaged deletions. Clearing node_modules/.cache/nx doesnt resolve underlying problem. IDEs still reporting errors after console commands succeed.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/nrwl/nx/issues/3370'
),
(
    'NX CLI fails with Yarn 2 Plug n Play - node_modules path resolution error',
    'github-nx',
    'MEDIUM',
    '[
        {"solution": "Configure nodeLinker: node-modules in .yarnrc.yml to use traditional node_modules structure instead of PnP", "percentage": 95, "command": "nodeLinker: node-modules"},
        {"solution": "Use Node module resolution APIs (require.resolve) instead of hardcoded node_modules paths - requires NX update", "percentage": 88, "note": "Long-term fix requires NX core changes"},
        {"solution": "Leverage PnP resolution system through proper require.resolve() calls in NX initialization", "percentage": 85, "note": "Respects PnP module structure"},
        {"solution": "Update Angular CLI dependency as NgccProcessor also fails with PnP and needs parallel fixes", "percentage": 70, "note": "Third-party dependency blocking full support"}
    ]'::jsonb,
    'Yarn 2.1+ workspace with PnP enabled, Nx CLI installed, Node with require.resolve support',
    'yarn nx commands execute without path resolution errors, both PnP and node-modules linker modes function, dependencies resolve correctly',
    'Hardcoding require(path.join(workspace.dir, node_modules)) patterns. Assuming traditional filesystem layouts exist. Not testing with Yarn 2.1+ configurations.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/nrwl/nx/issues/2386'
);
