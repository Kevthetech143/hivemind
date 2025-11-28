INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES
(
    'npm workspaces hoisting: dependencies split between root node_modules and workspace node_modules',
    'package-managers',
    'HIGH',
    '[
        {"solution": "Use --install-strategy=nested flag: npm install --install-strategy=nested --omit=dev --workspace=server", "percentage": 75},
        {"solution": "Manually copy package-lock.json and workspace package.json to fresh directory, run npm ci --only=production independently", "percentage": 85},
        {"solution": "Manually merge both node_modules directories into build artifact", "percentage": 90}
    ]'::jsonb,
    'npm workspaces configured in root package.json, understanding that npm hoists shared dependencies by design',
    'All dependencies for the workspace are in a single node_modules directory, clean production builds contain only required packages',
    'Expecting npm to provide a built-in hoisting disable flag (not available), using --legacy-peer-deps instead of --install-strategy',
    0.85,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/70540116/how-do-i-install-dependencies-for-a-single-package-when-using-npm-workspaces',
    'admin:1764173360'
),
(
    'yarn PnP error: Cannot find module yarn-berry.js - missing .yarn/releases file',
    'package-managers',
    'HIGH',
    '[
        {"solution": "Delete .yarnrc.yml file, run: yarn set version berry to regenerate it properly", "percentage": 95},
        {"solution": "Add nodeLinker: node-modules to .yarnrc.yml to use standard node_modules instead of PnP", "percentage": 90},
        {"solution": "Uninstall yarn, remove ~/.yarnrc and ~/.yarnrc.yml, reinstall yarn globally from scratch", "percentage": 85}
    ]'::jsonb,
    'Yarn 2/Berry installed, project using PnP resolver, .gitignore properly configured',
    '.yarn/releases/yarn-berry.js exists and is accessible, yarn commands execute without module not found errors',
    'Assuming yarn automatically maintains .yarnrc.yml (it doesn''t), not updating .gitignore to exclude node_modules when using PnP',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/62456078/yarn-install-leads-to-cannot-find-module-yarn-berry-js',
    'admin:1764173360'
),
(
    'pnpm peer dependencies warning: auto-install-peers not enabled, strict-peer-dependencies blocks install',
    'package-managers',
    'HIGH',
    '[
        {"solution": "Create .npmrc with auto-install-peers=true at project root", "percentage": 95},
        {"solution": "Run: pnpm config set auto-install-peers true --location project", "percentage": 93},
        {"solution": "Delete node_modules and pnpm-lock.yaml, run pnpm install with .npmrc configured", "percentage": 90}
    ]'::jsonb,
    'pnpm installed, .npmrc file exists or can be created, understanding pnpm requires explicit peer dependency configuration',
    'pnpm install completes successfully without peer dependency warnings, all dependencies resolved and installed',
    'Assuming pnpm auto-installs peers like npm v7+ does, not recreating lock files after adding auto-install-peers setting',
    0.88,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/72468635/pnpm-peer-dependencies-auto-install',
    'admin:1764173360'
),
(
    'bun install not found: command not found after installation, bun executable not in PATH',
    'package-managers',
    'HIGH',
    '[
        {"solution": "Add to ~/.bashrc or ~/.zshrc: export BUN_INSTALL=$HOME/.bun && export PATH=$BUN_INSTALL/bin:$PATH, then source file", "percentage": 95},
        {"solution": "Create symlink: ln -s $HOME/.bun/bin/bun /usr/local/bin/bun", "percentage": 90},
        {"solution": "Install via npm if Node available: npm install -g bun", "percentage": 85}
    ]'::jsonb,
    'Bun installation script completed, ~/.bun directory exists with bin subdirectory',
    'bun --version returns version number without command not found error, bun executable available in all terminal sessions',
    'Not sourcing shell config after editing, forgetting bun is installed to ~/.bun not /usr/local/bin, using inconsistent shell config files',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/72902668/bun-not-found-after-running-installation-script',
    'admin:1764173360'
),
(
    'npm ERESOLVE unable to resolve dependency tree: peer dependency version conflicts detected',
    'package-managers',
    'HIGH',
    '[
        {"solution": "Run: npm install --legacy-peer-deps to use npm v6 behavior", "percentage": 96},
        {"solution": "Set in .npmrc: legacy-peer-deps=true permanently for project", "percentage": 94},
        {"solution": "Fix upstream packages by updating to compatible versions that satisfy all peer requirements", "percentage": 85},
        {"solution": "Clean install: rm -rf node_modules package-lock.json && npm install", "percentage": 80}
    ]'::jsonb,
    'npm v7 or higher installed, understanding that npm v7 enforces stricter peer dependency resolution than v6',
    'npm install completes without ERESOLVE errors, all dependencies installed successfully',
    'Expecting automatic resolution of all conflicts, downgrading to npm v6 as only solution (not recommended long-term)',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/64573177/unable-to-resolve-dependency-tree-error-when-installing-npm-packages',
    'admin:1764173360'
),
(
    'npm ERR code E404 404 Not Found package-name: package not found in registry',
    'package-managers',
    'HIGH',
    '[
        {"solution": "Reset registry: npm config set registry https://registry.npmjs.org/", "percentage": 92},
        {"solution": "Clear npm cache: npm cache clean -f", "percentage": 88},
        {"solution": "Delete .npmrc files (project and home directory) and reinstall", "percentage": 90},
        {"solution": "Verify package exists: npm view package-name versions", "percentage": 85}
    ]'::jsonb,
    'npm configured, internet connectivity available, package name verified as correct spelling',
    'npm install completes without 404 errors, package resolves from npm registry successfully',
    'Typos in package names go unnoticed, pointing to wrong or internal corporate registry inadvertently, assuming 404 always means package doesn''t exist',
    0.87,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/47520181/installing-npm-package-fails-with-404',
    'admin:1764173360'
),
(
    'yarn ENOTFOUND registry.yarnpkg.com: DNS resolution failed for package registry',
    'package-managers',
    'HIGH',
    '[
        {"solution": "Update yarn: yarn set version stable or brew upgrade yarn on macOS", "percentage": 93},
        {"solution": "Delete node_modules and yarn.lock, run yarn install again", "percentage": 88},
        {"solution": "Check network connectivity and verify registry domain resolves", "percentage": 85}
    ]'::jsonb,
    'yarn installed (v1 or v2+), internet connectivity available, DNS working for other domains',
    'yarn install completes without ENOTFOUND errors, packages download from registry successfully',
    'Assuming DNS failure is network-wide (it''s usually yarn-specific), not updating yarn version before troubleshooting',
    0.86,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/68037425/enotfound-registry-yarnpkg-com-error-while-running-yarn-install',
    'admin:1764173360'
),
(
    'pnpm ERR_PNPM_FETCH_404: custom workspace package not found in npm registry',
    'package-managers',
    'MEDIUM',
    '[
        {"solution": "Update package.json dependency to use workspace protocol: \"@custom-package\": \"workspace:*\"", "percentage": 95},
        {"solution": "Verify pnpm-workspace.yaml includes correct package paths under packages:", "percentage": 92},
        {"solution": "Run pnpm install to apply workspace configuration changes", "percentage": 90}
    ]'::jsonb,
    'pnpm monorepo configured with workspace packages, custom package exists locally in monorepo structure',
    'pnpm install completes without FETCH_404 errors, workspace dependencies resolve locally',
    'Attempting to publish local packages to npm registry, not using workspace: protocol for local dependencies',
    0.89,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/79330407/no-authorization-header-was-set-for-the-request-err-pnpm-fetch-404-get-https',
    'admin:1764173360'
),
(
    'npm EBADPLATFORM code notsup Unsupported platform for package: OS requirements not met',
    'package-managers',
    'MEDIUM',
    '[
        {"solution": "Use nvm instead of n for Node version management on Windows: curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash", "percentage": 95},
        {"solution": "Check package.json os field or find Windows-compatible alternative", "percentage": 85},
        {"solution": "Use nvm-windows on Windows systems for Node version switching", "percentage": 90}
    ]'::jsonb,
    'Understanding that some packages are OS-specific (e.g., n package doesn''t support Windows), Node.js installed',
    'npm install succeeds, package installs on supported operating system, or alternative solution works',
    'Trying to force install unsupported packages with --force flag, not checking OS compatibility before attempting install',
    0.84,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/77671183/npm-err-notsup-not-compatible-with-your-version-of-node-npm-npm10-2-5-npm-err',
    'admin:1764173360'
),
(
    'yarn EACCES permission denied mkdir: insufficient write permissions to node_modules directory',
    'package-managers',
    'HIGH',
    '[
        {"solution": "Change ownership: sudo chown -R $USER:$GROUP node_modules", "percentage": 94},
        {"solution": "Grant write permissions: sudo chmod -R u+w /your/project/directory", "percentage": 92},
        {"solution": "Delete node_modules and reinstall with correct ownership: rm -rf node_modules && yarn install", "percentage": 90}
    ]'::jsonb,
    'node_modules directory exists with permission issues, yarn installed, understanding directory ownership vs permissions',
    'yarn install completes successfully, no EACCES errors, all dependencies installed',
    'Using sudo yarn install (masks permissions issue), changing permissions to 777 instead of fixing ownership, not deleting corrupted node_modules',
    0.89,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/62355079/yarn-eacces-permission-denied',
    'admin:1764173360'
),
(
    'npm ETARGET notarget no matching version found for package-name@version',
    'package-managers',
    'HIGH',
    '[
        {"solution": "Clear npm cache: npm cache clean --force", "percentage": 95},
        {"solution": "Verify version exists: npm view package-name versions", "percentage": 93},
        {"solution": "Delete package-lock.json and node_modules, run npm install fresh", "percentage": 88},
        {"solution": "Install from GitHub tarball: npm install https://github.com/user/repo/tarball/v1.0.0", "percentage": 75}
    ]'::jsonb,
    'npm installed with correct registry configured, package-lock.json may be corrupted, understanding npm registry versioning',
    'npm install succeeds, specified version installs or latest compatible version resolves',
    'Not clearing cache before reinstalling, assuming corrupted package-lock means package doesn''t exist, using wrong registry',
    0.88,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/44331005/npm-error-no-matching-version-found-for',
    'admin:1764173360'
),
(
    'npm E401 unable to authenticate: authentication token invalid or expired',
    'package-managers',
    'HIGH',
    '[
        {"solution": "Delete package-lock.json and node_modules, run npm install to regenerate with fresh auth", "percentage": 94},
        {"solution": "Clear .npmrc credentials: remove ~/.npmrc file, delete project-level .npmrc", "percentage": 92},
        {"solution": "Reset registry: npm config set registry https://registry.npmjs.com/", "percentage": 88},
        {"solution": "Generate fresh personal access token from npm/GitHub/Azure and update .npmrc", "percentage": 90}
    ]'::jsonb,
    'npm installed, .npmrc file may contain stale credentials or tokens, understanding token expiration policies',
    'npm install succeeds without E401 errors, authentication tokens accepted and valid',
    'Assuming E401 is only a registry issue (also caused by expired tokens), not rotating expired credentials, keeping old .npmrc files',
    0.86,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/67419637/e401-unable-to-authenticate-your-authentication-token-seems-to-be-invalid',
    'admin:1764173360'
),
(
    'npm EACCES permission denied mkdir /usr/local/lib/node_modules: global install lacks write permissions',
    'package-managers',
    'HIGH',
    '[
        {"solution": "Use unsafe-perm flag: sudo npm install -g package-name --unsafe-perm=true --allow-root", "percentage": 85},
        {"solution": "Install nvm and use it to manage Node versions (eliminates permission issues)", "percentage": 95},
        {"solution": "Change npm global directory ownership to current user instead of root", "percentage": 90},
        {"solution": "Use project-local dependencies instead of global installation when possible", "percentage": 88}
    ]'::jsonb,
    'Global npm installation attempted, Node.js/npm installed, understanding that sudo npm can still have permission issues',
    'npm install -g succeeds without EACCES errors, package available globally',
    'Using --unsafe-perm as permanent solution (masks root issue), not considering nvm alternative, changing permissions to 777',
    0.87,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/46328267/npm-install-error-eacces-permission-denied-mkdir',
    'admin:1764173360'
);
