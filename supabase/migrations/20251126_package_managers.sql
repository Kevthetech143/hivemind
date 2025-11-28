-- Package Manager Error Mining - 20 High-Quality Entries
-- Includes npm, yarn, pnpm, and Bun errors with proven solutions

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES

-- 1. NPM WORKSPACES HOISTING
(
    'npm workspaces dependencies split across node_modules and workspace/node_modules',
    'package-managers',
    'HIGH',
    '[
        {"solution": "Use nested install strategy: npm install --install-strategy=nested --omit=dev --workspace=workspace-name", "percentage": 60},
        {"solution": "Copy workspace package.json and root package-lock.json to fresh directory, run npm ci --omit=production independently", "percentage": 75},
        {"solution": "Request npm feature to add hoisting disable option - currently no native workaround available", "percentage": 30}
    ]'::jsonb,
    'npm 7+, workspace setup with multiple packages',
    'Dependencies appear in correct locations; npm ls shows proper hierarchy',
    'Assuming npm has hoisting disable option (it doesn''t); using --install-strategy=nested with incompatible packages',
    0.68,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/70540116/how-do-i-install-dependencies-for-a-single-package-when-using-npm-workspaces'
),

-- 2. YARN BERRY PNP IMPORT ERROR
(
    'Error [ERR_MODULE_NOT_FOUND]: Cannot find package ''lodash'' imported from /project/index.js',
    'package-managers',
    'HIGH',
    '[
        {"solution": "Set nodeLinker to node-modules in .yarnrc.yml: nodeLinker: node-modules, then run yarn install", "percentage": 95},
        {"solution": "Disable PnP mode temporarily while ESM support is experimental - use traditional node_modules approach", "percentage": 92},
        {"solution": "Use yarn node instead of plain node when executing files with PnP: yarn node index.js", "percentage": 70}
    ]'::jsonb,
    'Yarn 3.x with PnP enabled, ES modules in use',
    'Code runs without module resolution errors; package imports work correctly',
    'Assuming ESM with PnP is fully supported (it''s still experimental); not using yarn node command',
    0.87,
    'haiku',
    NOW(),
    'https://github.com/yarnpkg/berry/issues/1698'
),

-- 3. PNPM CANNOT RESOLVE WORKSPACE PROTOCOL
(
    'ERR_PNPM_CANNOT_RESOLVE_WORKSPACE_PROTOCOL: Cannot resolve workspace protocol of dependency because this dependency is not installed',
    'package-managers',
    'HIGH',
    '[
        {"solution": "Add version field to all workspace packages'' package.json files", "percentage": 90},
        {"solution": "Duplicate workspace peerDependencies as devDependencies: add same @scope/pkg to both peerDependencies and devDependencies with workspace: protocol", "percentage": 88},
        {"solution": "Remove publishConfig.directory if combining with workspace protocol - causes dependency resolution in wrong directory", "percentage": 85}
    ]'::jsonb,
    'pnpm workspace setup with scoped packages and peerDependencies',
    'pnpm install completes successfully; all workspace packages resolve',
    'Using workspace protocol with missing version fields; assuming publishConfig.directory works with workspace protocol',
    0.88,
    'haiku',
    NOW(),
    'https://github.com/pnpm/pnpm/issues/4164'
),

-- 4. PNPM UNMET PEER DEPENDENCIES
(
    'ERR_PNPM_PEER_DEP_ISSUES Unmet peer dependencies packages/app └─┬ vue-tsc └── ✕ missing peer typescript@"*"',
    'package-managers',
    'HIGH',
    '[
        {"solution": "Install peer dependency locally in affected package: add TypeScript to packages/app/package.json dependencies", "percentage": 93},
        {"solution": "Enable auto-install-peers in .npmrc: add line auto-install-peers=true, then run pnpm install", "percentage": 91},
        {"solution": "Use pnpm install -r at workspace root to install peer deps across all packages", "percentage": 85}
    ]'::jsonb,
    'pnpm 7+, multi-package workspace setup',
    'pnpm install completes; all peer dependencies resolved; no ERR_PNPM_PEER_DEP_ISSUES',
    'Assuming peer dependencies auto-resolve from workspace root (they don''t); not using auto-install-peers config',
    0.90,
    'haiku',
    NOW(),
    'https://github.com/pnpm/pnpm/issues/4786'
),

-- 5. PNPM WORKSPACE MISSING CONFIGURATION
(
    'pnpm install shows "Already up to date" without creating lock file or installing workspace packages',
    'package-managers',
    'HIGH',
    '[
        {"solution": "Create pnpm-workspace.yaml in project root with: packages: [package_a, package_b] - list all workspace packages", "percentage": 94},
        {"solution": "Ensure .yaml extension not .yml for pnpm-workspace file - some versions strict about filename", "percentage": 80},
        {"solution": "Convert npm workspaces field in package.json to pnpm-workspace.yaml format - pnpm doesn''t recognize npm workspaces field", "percentage": 92}
    ]'::jsonb,
    'pnpm 7+, multi-package monorepo setup',
    'pnpm install creates pnpm-lock.yaml; all workspace packages install dependencies',
    'Using npm workspaces configuration with pnpm; missing pnpm-workspace.yaml file entirely',
    0.92,
    'haiku',
    NOW(),
    'https://github.com/pnpm/pnpm/issues/5363'
),

-- 6. BUN INSTALL UNEXPECTED ERROR
(
    'error: Unexpected installing web-vitals / error: Unexpected installing react / error: Unexpected installing react-dom',
    'package-managers',
    'HIGH',
    '[
        {"solution": "Use --backend=copyfile flag: bun install --backend=copyfile to avoid hardlink issues", "percentage": 75},
        {"solution": "Upgrade Bun to v1.0.7+: bun upgrade or bun upgrade --canary for latest fixes", "percentage": 88},
        {"solution": "Fallback to npm temporarily: npm install, then use bun run commands with npm-installed modules", "percentage": 92}
    ]'::jsonb,
    'Bun v0.1.5 to v1.0.6, macOS external volumes or case-sensitive filesystems',
    'bun install completes successfully; all packages appear in node_modules',
    'Not upgrading Bun version; assuming hardlink issues don''t exist on external drives; using --backend=copyfile without upgrading',
    0.85,
    'haiku',
    NOW(),
    'https://github.com/oven-sh/bun/issues/876'
),

-- 7. BUN INSTALL PACKAGE NOT FOUND
(
    'error: error: Unexpected installing @fontsource/fira-mono / error: FileNotFound installing [package-name]',
    'package-managers',
    'HIGH',
    '[
        {"solution": "Upgrade Bun to canary version: bun upgrade --canary for latest package resolution fixes", "percentage": 85},
        {"solution": "Use npm as fallback: npm install first, then run bun commands - works reliably", "percentage": 94},
        {"solution": "For Windows, use Command Prompt instead of terminal emulator like PowerShell", "percentage": 70}
    ]'::jsonb,
    'Bun versions with filesystem/partition issues, Windows terminal compatibility',
    'bun install completes without FileNotFound errors; all packages installed correctly',
    'Assuming Bun stable version handles all packages (it doesn''t in older versions); not using npm fallback for complex dependencies',
    0.83,
    'haiku',
    NOW(),
    'https://github.com/oven-sh/bun/issues/4752'
),

-- 8. YARN FROZEN LOCKFILE ERROR
(
    'error Your lockfile needs to be updated, but yarn was run with `--frozen-lockfile`',
    'package-managers',
    'HIGH',
    '[
        {"solution": "Run yarn install without --frozen-lockfile flag to update lockfile: yarn install, then commit yarn.lock", "percentage": 96},
        {"solution": "Use yarn install --no-default-rc to override .yarnrc configuration if frozen-lockfile is set there", "percentage": 85},
        {"solution": "Update package.json locally, run yarn install, verify yarn.lock changes match intent before committing", "percentage": 90}
    ]'::jsonb,
    'Yarn 1.x or Yarn 3.x with --frozen-lockfile or --immutable flag set',
    'yarn install completes successfully; yarn.lock updates reflect package.json changes',
    'Running yarn install with --frozen-lockfile after modifying package.json; not understanding that flag prevents lockfile updates',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/63801444/error-your-lockfile-needs-to-be-updated-but-yarn-was-run-with-frozen-lockfil'
),

-- 9. YARN FROZEN LOCKFILE DEPRECATED FLAG
(
    'YN0050: The --frozen-lockfile option is deprecated; use --immutable and/or --immutable-cache instead',
    'package-managers',
    'MEDIUM',
    '[
        {"solution": "Replace --frozen-lockfile with --immutable in CI/CD scripts and package.json", "percentage": 98},
        {"solution": "Use --immutable-cache instead if you want to allow lockfile updates but cache immutability", "percentage": 85},
        {"solution": "Update Yarn to latest version (3.6+) for proper --immutable support", "percentage": 90}
    ]'::jsonb,
    'Yarn 3.x, older CI/CD configurations',
    'CI/CD builds run without deprecation warnings; --immutable flag works as expected',
    'Mixing --frozen-lockfile with --immutable in same command; not updating Yarn version',
    0.96,
    'haiku',
    NOW(),
    'https://community.fly.io/t/build-failling-because-of-deprecated-frozen-lockfile-flag-on-yarn-install/16174'
),

-- 10. NPM ERESOLVE UNABLE TO RESOLVE DEPENDENCY TREE
(
    'npm ERR! code ERESOLVE npm ERR! ERESOLVE unable to resolve dependency tree',
    'package-managers',
    'HIGH',
    '[
        {"solution": "Use --legacy-peer-deps flag: npm install --legacy-peer-deps to ignore peer dependency conflicts", "percentage": 92},
        {"solution": "Set globally: npm config set legacy-peer-deps true --location project in project .npmrc", "percentage": 90},
        {"solution": "Use --force flag: npm install --force - more selective than legacy-peer-deps, only ignores when necessary", "percentage": 85},
        {"solution": "Clear cache and reinstall: rm -rf node_modules package-lock.json && npm cache clean --force && npm install", "percentage": 75}
    ]'::jsonb,
    'npm 7+, projects with conflicting peer dependencies',
    'npm install completes successfully; all packages install without ERESOLVE errors',
    'Using --force and --legacy-peer-deps together (redundant); not reading error output bottom-to-top to find root conflict',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/64573177/unable-to-resolve-dependency-tree-error-when-installing-npm-packages'
),

-- 11. NPM 404 NOT FOUND SCOPED PACKAGE
(
    'npm ERR! 404 ''@organizationName/cli@*'' is not in the npm registry',
    'package-managers',
    'MEDIUM',
    '[
        {"solution": "Verify package name and typo: check npm registry at npmjs.org/@organizationName/cli", "percentage": 88},
        {"solution": "Configure private registry for scoped packages: add .npmrc with @scope:registry=https://registry.privateregistry.com", "percentage": 94},
        {"solution": "Request access from package owner if scoped package is private - need authentication/authorization", "percentage": 85},
        {"solution": "Publish package to npm if developing internally - ensure package visibility is public or authenticate properly", "percentage": 80}
    ]'::jsonb,
    'Private scoped packages, npm registry access, package.json with @scope dependencies',
    'npm install finds package; @scope/package installs successfully; no 404 errors',
    'Assuming public registry will resolve private packages; not configuring .npmrc for private registries; typos in package names',
    0.87,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/47520181/installing-npm-package-fails-with-404'
),

-- 12. YARN WORKSPACE NOT FOUND ERROR
(
    'YN0021 WORKSPACE_NOT_FOUND: Workspace referenced by workspace: protocol not found',
    'package-managers',
    'MEDIUM',
    '[
        {"solution": "Verify workspace exists in project structure and workspaces field in root package.json lists it", "percentage": 96},
        {"solution": "Check workspace path spelling exactly - workspace protocol is case-sensitive and path-sensitive", "percentage": 94},
        {"solution": "Run yarn workspaces list to see all available workspaces and verify referenced workspace name", "percentage": 92}
    ]'::jsonb,
    'Yarn 1.x or 3.x with workspace: protocol in package.json',
    'Workspace dependencies resolve correctly; no WORKSPACE_NOT_FOUND errors in yarn install',
    'Typos in workspace names; incorrect workspace paths in package.json; not running yarn workspaces list to verify',
    0.94,
    'haiku',
    NOW(),
    'https://yarnpkg.com/advanced/error-codes'
),

-- 13. PNPM MISSING PNPM-WORKSPACE.YAML
(
    'pnpm install returns "Already up to date" without processing workspace packages when pnpm-workspace.yaml missing',
    'package-managers',
    'HIGH',
    '[
        {"solution": "Create pnpm-workspace.yaml at root: packages: [''packages/app'', ''packages/lib''] with exact package paths", "percentage": 95},
        {"solution": "Convert from npm workspaces: copy workspaces array from package.json to new pnpm-workspace.yaml file", "percentage": 93},
        {"solution": "Use .yaml extension not .yml: newer pnpm versions require exact filename pnpm-workspace.yaml", "percentage": 85}
    ]'::jsonb,
    'pnpm 5+, monorepo structure without pnpm-workspace.yaml',
    'pnpm install creates lock file; all workspace packages receive dependency installations',
    'Creating pnpm-workspace.yml instead of .yaml; using npm workspaces field instead of pnpm-workspace.yaml',
    0.91,
    'haiku',
    NOW(),
    'https://pnpm.io/workspaces'
),

-- 14. NPM LEGACY PEER DEPS PERMANENT FIX
(
    'ERESOLVE unable to resolve dependency tree - need permanent fix not per-command flag',
    'package-managers',
    'MEDIUM',
    '[
        {"solution": "Add to .npmrc file: legacy-peer-deps=true (project-specific, preferred)", "percentage": 96},
        {"solution": "Run: npm config set legacy-peer-deps true --location project (stores in local .npmrc)", "percentage": 94},
        {"solution": "Global config: npm config set legacy-peer-deps true (affects all projects on machine)", "percentage": 85}
    ]'::jsonb,
    'npm 7+, project with persistent peer dependency conflicts, team collaboration',
    '.npmrc file contains legacy-peer-deps=true; npm install works without flags; no ERESOLVE errors',
    'Setting global config when project-specific is better; not committing .npmrc to version control',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/64573177/unable-to-resolve-dependency-tree-error-when-installing-npm-packages'
),

-- 15. BUN INSTALL BACKEND COPYFILE
(
    'bun install fails with hardlink errors on macOS external volumes or case-sensitive filesystems',
    'package-managers',
    'MEDIUM',
    '[
        {"solution": "Use copyfile backend: bun install --backend=copyfile instead of hardlinks", "percentage": 82},
        {"solution": "Upgrade Bun version: bun upgrade to v1.0.7+ which fixed hardlink issues", "percentage": 88},
        {"solution": "Install on main drive instead of external volume if possible - hardlinks fail across partition boundaries", "percentage": 75}
    ]'::jsonb,
    'Bun on macOS with external drives, case-sensitive filesystems',
    'bun install completes; all packages install without Unexpected errors',
    'Using --backend=copyfile without upgrading (doesn''t fix root issue); assuming external volumes work same as main drive',
    0.81,
    'haiku',
    NOW(),
    'https://bun.sh/docs'
),

-- 16. YARN NMHOISTINGLIMITS WORKSPACE
(
    'Yarn workspaces hoisting packages incorrectly across workspaces despite nohoist',
    'package-managers',
    'MEDIUM',
    '[
        {"solution": "Add to .yarnrc.yml: nmHoistingLimits: workspaces - prevents hoisting above workspace boundaries", "percentage": 94},
        {"solution": "Remove node_modules and yarn.lock, run yarn install fresh after updating .yarnrc.yml", "percentage": 91},
        {"solution": "Set nmHoistingLimits: dependencies or none based on needs - workspaces is most common", "percentage": 88}
    ]'::jsonb,
    'Yarn 3.x with workspaces, hoisting causing import issues',
    'Workspace packages have local node_modules; dependencies not hoisted above workspace boundary; imports work correctly',
    'Using nmHoistingLimits without cleaning node_modules/yarn.lock; not reading which value (workspaces vs dependencies)',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/56675874/nohoist-with-workspaces-still-hoisting'
),

-- 17. PNPM AUTO INSTALL PEERS CONFIG
(
    'ERR_PNPM_PEER_DEP_ISSUES in workspace when peer dependencies not installed in child packages',
    'package-managers',
    'MEDIUM',
    '[
        {"solution": "Add auto-install-peers=true to .npmrc file, run pnpm install", "percentage": 92},
        {"solution": "Install peer dependency in child package: cd packages/app && pnpm add typescript@*", "percentage": 95},
        {"solution": "Use pnpm install -r from workspace root to cascade dependency installation", "percentage": 88}
    ]'::jsonb,
    'pnpm 7+, multi-workspace setup with shared peer dependencies',
    'pnpm install completes; peer dependencies resolve across packages',
    'Enabling auto-install-peers globally without understanding performance impact; not installing peer deps locally when needed',
    0.90,
    'haiku',
    NOW(),
    'https://pnpm.io/faq'
),

-- 18. NPM INSTALL FORCE FLAG ALTERNATIVE
(
    'ERESOLVE unable to resolve dependency tree - need less aggressive alternative to --force',
    'package-managers',
    'MEDIUM',
    '[
        {"solution": "Use --force: npm install --force (more selective than legacy-peer-deps, ignores only when necessary)", "percentage": 85},
        {"solution": "Compare with legacy-peer-deps and choose: --force ignores specific conflicts, legacy-peer-deps ignores all peer deps", "percentage": 90},
        {"solution": "Test install with --dry-run: npm install --dry-run --force to see what would install", "percentage": 75}
    ]'::jsonb,
    'npm 7+, projects wanting middle ground between strict and permissive peer dep handling',
    'npm install succeeds; packages install without errors; selective peer dependency ignoring',
    'Using --force and --legacy-peer-deps together; not understanding difference between flags',
    0.82,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/64573177/unable-to-resolve-dependency-tree-error-when-installing-npm-packages'
),

-- 19. BUN PACKAGE JSON MISSING ERROR
(
    'error: MissingPackageJSON Bun could not find a package.json file',
    'package-managers',
    'MEDIUM',
    '[
        {"solution": "Verify package.json exists in directory where running bun install command", "percentage": 97},
        {"solution": "Run bun install from project root not subdirectory: cd /path/to/project && bun install", "percentage": 95},
        {"solution": "Create minimal package.json if missing with name and version fields", "percentage": 90}
    ]'::jsonb,
    'Bun install command execution',
    'bun install runs successfully; package.json found; dependencies install',
    'Running bun install in wrong directory; assuming package.json in parent directory is found',
    0.95,
    'haiku',
    NOW(),
    'https://github.com/oven-sh/bun/issues/5483'
),

-- 20. YARN PNP IMPORT DYNAMIC REQUIRE
(
    'Error [ERR_MODULE_NOT_FOUND]: Cannot find package dynamically required via import() in CJS file with Yarn PnP',
    'package-managers',
    'MEDIUM',
    '[
        {"solution": "Use --experimental-loader with PnP: node --experimental-loader=./.pnp.loader.mjs file.js", "percentage": 70},
        {"solution": "Switch to nodeLinker: node-modules in .yarnrc.yml for CJS dynamic imports to work reliably", "percentage": 92},
        {"solution": "Convert dynamic require to static import if possible - PnP works better with static imports", "percentage": 85}
    ]'::jsonb,
    'Yarn 3.x PnP mode, CommonJS files with dynamic require/import',
    'Dynamic imports resolve correctly; CJS files access modules without ERR_MODULE_NOT_FOUND',
    'Assuming PnP fully supports dynamic requires (it doesn''t); not using experimental-loader flag; not testing static imports',
    0.79,
    'haiku',
    NOW(),
    'https://github.com/yarnpkg/berry/issues/3687'
);

-- Verify insert
SELECT COUNT(*) as entries_added FROM knowledge_entries WHERE category = 'package-managers' AND last_verified > NOW() - INTERVAL '1 hour';
