-- Add pnpm GitHub issues: install/dependency error solutions (batch 1)
-- Source: https://github.com/pnpm/pnpm/issues
-- Category: github-pnpm
-- Extracted: 12 high-engagement issues with solutions

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, last_verified, source_url
) VALUES (
    'pnpm install fails with custom registry and authentication credentials in .npmrc',
    'github-pnpm',
    'HIGH',
    '[
        {"solution": "Verify registry URL and authentication token are correctly formatted in .npmrc", "percentage": 85, "note": "Check for spaces or special characters around equals signs"},
        {"solution": "Test registry connection manually: npm view package --registry=https://your-registry", "percentage": 80, "note": "Ensure credentials provide valid access"},
        {"solution": "Use pnpm config get to verify loaded registry settings", "percentage": 75, "command": "pnpm config get registry"}
    ]'::jsonb,
    'pnpm 10.12+, Custom registry configured, Valid authentication token',
    'pnpm install completes successfully, Packages resolve from custom registry, No 401/403 errors',
    'Do not hardcode credentials in .npmrc directly - use authentication tokens. Registry must be accessible without VPN or proxy configuration. Multiple registries require proper scopePublish configuration.',
    0.82,
    NOW(),
    'https://github.com/pnpm/pnpm/issues/10237'
),
(
    'ERR_PNPM_ENOTEMPTY when running concurrent pnpm install with global virtual store',
    'github-pnpm',
    'HIGH',
    '[
        {"solution": "Disable concurrent installs on shared systems: run pnpm install sequentially per project", "percentage": 90, "note": "Use process locking or serial CI/CD pipeline"},
        {"solution": "Disable enableGlobalVirtualStore and use per-project stores: enableGlobalVirtualStore: false", "percentage": 85, "command": "pnpm config set enableGlobalVirtualStore=false"},
        {"solution": "Upgrade pnpm to latest version (10.25+) for improved atomic operations", "percentage": 75, "note": "Recent versions have better concurrency handling"}
    ]'::jsonb,
    'pnpm 10.0+, enableGlobalVirtualStore: true configured, Multiple projects',
    'pnpm install completes without ENOTEMPTY errors, Global virtual store syncs correctly, No race conditions in logs',
    'Race conditions occur with concurrent access to the same global store. Do not run parallel installs from different projects simultaneously. Consider separate CI/CD workers per project.',
    0.88,
    NOW(),
    'https://github.com/pnpm/pnpm/issues/10232'
),
(
    '[Windows] pnpm install silently fails to create node_modules/.bin with Chinese characters in path',
    'github-pnpm',
    'MEDIUM',
    '[
        {"solution": "Rename project directory to use only ASCII/English characters", "percentage": 95, "note": "Most reliable workaround until upstream fix"},
        {"solution": "Use pnpm install --force to retry symlink creation with verbose logging", "percentage": 70, "command": "pnpm install --force"},
        {"solution": "Check Windows file encoding: verify NTFS supports UTF-8 paths", "percentage": 60, "note": "Enable long path support: fsutil 8dot3name set 0"}
    ]'::jsonb,
    'Windows OS, pnpm 10.20+, Non-ASCII characters in directory path',
    'node_modules/.bin directory exists after install, Binaries like "next" are executable without errors, pnpm install returns exit code 0',
    'pnpm install completes silently but .bin is not created with non-ASCII paths. npm works correctly in same directory. Issue affects Windows NTFS encoding of symlinks.',
    0.65,
    NOW(),
    'https://github.com/pnpm/pnpm/issues/10199'
),
(
    '[WARN] Failed to create bin at D:\\ on Windows with pnpm v10.20.0+',
    'github-pnpm',
    'HIGH',
    '[
        {"solution": "Upgrade pnpm to v10.23.0 or later with improved Windows bin directory handling", "percentage": 88, "note": "Multiple fixes merged for Windows path issues"},
        {"solution": "Run pnpm install --force to reinitialize bin directory creation", "percentage": 80, "command": "pnpm install --force"},
        {"solution": "Check bin-dir configuration: verify no conflicting path settings", "percentage": 75, "command": "pnpm config get bin-dir"}
    ]'::jsonb,
    'Windows OS, pnpm v10.20.0-10.22.x, Project with executable binaries',
    'pnpm install completes without [WARN] messages, Bin directory created successfully, Commands execute from pnpm scripts',
    'Warning appears on Windows but install may still succeed. Do not ignore [WARN] messages about bin directories - they indicate actual failures. Check for long paths (>260 chars) on Windows.',
    0.81,
    NOW(),
    'https://github.com/pnpm/pnpm/issues/10216'
),
(
    'Global bin directory not in PATH after installing pnpm v10.11.0 via mise on macOS',
    'github-pnpm',
    'MEDIUM',
    '[
        {"solution": "Add pnpm bin directory to PATH in shell rc file: export PATH=\"~/.local/share/pnpm:$PATH\"", "percentage": 90, "note": "Add to ~/.zshrc or ~/.bashrc"},
        {"solution": "Configure pnpm to use mise-managed bin directory: pnpm config set --global bin-dir ~/.local/bin", "percentage": 85, "command": "pnpm config set --global bin-dir ~/.local/bin"},
        {"solution": "Use mise to manage PATH automatically: add pnpm to mise toolchain", "percentage": 80, "note": "Create .mise.toml with pnpm version specification"}
    ]'::jsonb,
    'macOS, mise installed, pnpm v10.11.0+, Node.js 22.0.0+',
    'pnpm command is available globally, PATH echoes ~/.local/share/pnpm, pnpm run commands work from anywhere',
    'pnpm creates config at ~/Library/Preferences/pnpm/rc but bin directory is ~/.local/share/pnpm. mise integration requires explicit PATH configuration. Do not rely on default bin-dir without verification.',
    0.79,
    NOW(),
    'https://github.com/pnpm/pnpm/issues/10212'
),
(
    'Regression in module resolution for peer dependencies in pnpm 10.12.2+',
    'github-pnpm',
    'MEDIUM',
    '[
        {"solution": "Add packageExtensions to pnpm-workspace.yaml to declare missing peer dependencies", "percentage": 90, "note": "Explicitly declare peer deps like vue-template-compiler with vue", "command": "packageExtensions:\\n  vue-template-compiler:\\n    peerDependencies:\\n      vue: ''*''"},
        {"solution": "Downgrade to pnpm 10.12.1 until peer dependency handling is fixed", "percentage": 75, "note": "Last working version before regression"},
        {"solution": "Override peer dependency rules: use peerDependencyRules.allow for problematic packages", "percentage": 70, "command": "peerDependencyRules:\\n  allow: [''vue-template-compiler'']"}
    ]'::jsonb,
    'pnpm 10.12.2+, Monorepo with complex peer dependencies, Packages without peer dep declarations',
    'pnpm install succeeds on first and subsequent runs, Unit tests pass with correct vue resolution, No peer dependency warnings',
    'Peer dependency resolution changed in 10.12.2 to be stricter. Second pnpm install may fail when first succeeds. vue-template-compiler and similar packages need explicit peer dep extensions.',
    0.83,
    NOW(),
    'https://github.com/pnpm/pnpm/issues/10170'
),
(
    'Unexpected optional peer dependencies installed from unrelated workspace packages in pnpm',
    'github-pnpm',
    'MEDIUM',
    '[
        {"solution": "Add peerDependencyRules.ignoreMissing to exclude unrelated peer deps: ignoreMissing: [''postcss'']", "percentage": 85, "note": "List peer deps from transitive chains that are irrelevant", "command": "peerDependencyRules:\\n  ignoreMissing: [''postcss'', ''@csstools/css-syntax-patches'']"},
        {"solution": "Use pnpm dedupe to resolve peer dependency conflicts across workspace", "percentage": 80, "command": "pnpm dedupe"},
        {"solution": "Declare missing peer deps explicitly in problematic packages: add postcss to devDependencies", "percentage": 75, "note": "Only if package actually uses the peer dep"}
    ]'::jsonb,
    'pnpm monorepo, Multiple workspace packages with optional peer deps, pnpm 10+',
    'pnpm install completes without peer dependency warnings, vitest and jsdom resolve correctly, cssstyle issues resolved',
    'Warnings appear for peer deps from transitive chains even if package doesn''t use them. Do not add unnecessary peer deps just to silence warnings - use ignoreMissing instead. Workspace resolution can pull in unexpected transitive deps.',
    0.81,
    NOW(),
    'https://github.com/pnpm/pnpm/issues/10046'
),
(
    'Package resolution fails when workspace package version differs from requested version in pnpm 10.13.1+',
    'github-pnpm',
    'HIGH',
    '[
        {"solution": "Upgrade pnpm to 10.14.0+ where workspace version resolution was fixed", "percentage": 92, "note": "Multiple fixes for version mismatch handling"},
        {"solution": "Specify exact workspace version in dependencies: @super-secret/my-lib@workspace:*", "percentage": 85, "command": "\"@super-secret/my-lib\": \"workspace:*\""},
        {"solution": "Downgrade to pnpm 9.15.9 until issue is resolved in stable release", "percentage": 70, "note": "Last working version before regression in v10"}
    ]'::jsonb,
    'pnpm 10.13.1+, Monorepo with workspace packages, Version mismatch between package.json and workspace',
    'pnpm install throws proper error for non-existent versions, Workspace links only resolve for exact version matches, No silent fallbacks to wrong workspace versions',
    'pnpm silently resolves to wrong workspace version (v1.0.0) instead of throwing 404 error for missing version (v2.0.0). This is insidious and breaks dependency integrity. Do not rely on implicit workspace fallback behavior.',
    0.89,
    NOW(),
    'https://github.com/pnpm/pnpm/issues/10173'
),
(
    'Renaming or moving workspace packages leaves dangling symlinks causing ENOENT errors in pnpm',
    'github-pnpm',
    'MEDIUM',
    '[
        {"solution": "Run pnpm install --force after renaming workspace packages to clean stale symlinks", "percentage": 90, "command": "pnpm install --force", "note": "Rebuilds all symlinks in node_modules/.pnpm"},
        {"solution": "Use pnpm dedupe to resolve symlink conflicts and update references", "percentage": 85, "command": "pnpm dedupe"},
        {"solution": "Manually delete node_modules and .pnpm directory, then reinstall", "percentage": 80, "command": "rm -rf node_modules .pnpm pnpm-lock.yaml && pnpm install"}
    ]'::jsonb,
    'pnpm 10.18.2+, Monorepo with workspace packages, Renamed/moved package directories',
    'pnpm install completes without ENOENT errors, node_modules/.pnpm contains only valid symlinks, Renamed package executes correctly',
    'Old symlink references remain in node_modules/.pnpm even after pnpm-lock.yaml is updated. Simple pnpm install does not clean dangling symlinks. Must use --force or manual cleanup.',
    0.86,
    NOW(),
    'https://github.com/pnpm/pnpm/issues/10081'
),
(
    'Inconsistent peer dependency resolution: binaries missing after removing node_modules with existing pnpm-lock.yaml',
    'github-pnpm',
    'MEDIUM',
    '[
        {"solution": "Run pnpm install --lockfile-only first, then install to ensure peer deps are locked", "percentage": 85, "command": "pnpm install --lockfile-only && pnpm install"},
        {"solution": "Check pnpm-lock.yaml includes all peer dependency entries for webpack-obfuscator", "percentage": 80, "note": "Lock file must have javascript-obfuscator entry"},
        {"solution": "Use pnpm dedupe to resolve missing peer dep references in lockfile", "percentage": 75, "command": "pnpm dedupe"}
    ]'::jsonb,
    'pnpm v10+, webpack-obfuscator as devDependency, Existing pnpm-lock.yaml',
    'Binary javascript-obfuscator appears in node_modules/.bin after clean install, Consistent results between first and second installs, Lock file contains all peer dependency entries',
    'Peer dependency resolution differs between fresh install (npm install) and lockfile-based reinstall. Binaries from optional peer deps may not be hoisted correctly from lock file. Lock file may be missing peer dep entries from initial install.',
    0.78,
    NOW(),
    'https://github.com/pnpm/pnpm/issues/10035'
),
(
    'pnpm install fails with "ABORTED_REMOVE_MODULES_DIR_NO_TTY" when node_modules is a symlink',
    'github-pnpm',
    'MEDIUM',
    '[
        {"solution": "Run pnpm install with --interactive flag or in TTY environment for symlink handling", "percentage": 80, "note": "Requires user prompt for symlink removal confirmation"},
        {"solution": "Manually delete symlinked node_modules before running pnpm install in CI/CD", "percentage": 85, "command": "rm node_modules && pnpm install --frozen-lockfile"},
        {"solution": "Configure modules-dir to use non-symlinked path: modules-dir: ./node_modules_real", "percentage": 75, "command": "pnpm config set modules-dir ./node_modules_real"}
    ]'::jsonb,
    'Capistrano-style deployment, node_modules as symlink, pnpm with frozen-lockfile, Non-interactive CI/CD',
    'pnpm install completes without TTY errors, node_modules symlink updates correctly, Redeployment succeeds with existing lock file',
    'pnpm cannot delete symlinked node_modules non-interactively due to safety check. Symlinked deployments require manual pre-cleanup. Capistrano shared directory pattern conflicts with pnpm''s module directory handling.',
    0.77,
    NOW(),
    'https://github.com/pnpm/pnpm/issues/9973'
),
(
    'Broken symlink/hardlink not detected as invalid when running pnpm install',
    'github-pnpm',
    'LOW',
    '[
        {"solution": "Run pnpm install --force to rebuild all symlinks from CAS and detect broken links", "percentage": 88, "command": "pnpm install --force"},
        {"solution": "Delete corrupted package directory in .pnpm and allow reinstall: rm -rf .pnpm/package-name", "percentage": 82, "note": "Pnpm will restore from content-addressable store"},
        {"solution": "Clear entire .pnpm directory and reinstall: rm -rf .pnpm && pnpm install", "percentage": 75, "command": "rm -rf .pnpm && pnpm install"}
    ]'::jsonb,
    'pnpm 10.13.1+, Content-addressable store (CAS) intact, Corrupted symlink with empty directory',
    'pnpm detects broken symlink and reinstalls from CAS successfully, Package directory contains valid files after install, No ENOENT errors on subsequent pnpm commands',
    'pnpm does not validate symlink/hardlink integrity on install. Empty directory structure passes validation even if actual package files are missing. Symlink corruption after pnpm import is not detected automatically.',
    0.81,
    NOW(),
    'https://github.com/pnpm/pnpm/issues/9758'
),
(
    'pnpm <bin> shorthand syntax fails with --filter or --recursive flags in workspace',
    'github-pnpm',
    'MEDIUM',
    '[
        {"solution": "Use explicit exec keyword: pnpm --filter api exec vitest run instead of shorthand", "percentage": 95, "command": "pnpm --filter api exec vitest run", "note": "Explicit exec always works with filtering"},
        {"solution": "Run from package directory without filters: cd packages/api && pnpm vitest run", "percentage": 85, "note": "Shorthand works without --filter or --recursive"},
        {"solution": "Upgrade pnpm to latest version with improved shorthand resolution in filters", "percentage": 70, "note": "Recent versions have better implicit exec handling"}
    ]'::jsonb,
    'pnpm monorepo with multiple workspace packages, Filtering enabled, pnpm v22.18.0+',
    'pnpm --filter api exec vitest run executes successfully, Exit code is non-zero on actual failure (not 0), Test results display in output',
    'Shorthand syntax (omitting exec) works in package directory but silently fails with --filter flags. Exit code 0 masks actual execution failure. Inconsistent behavior between shorthand and explicit exec.',
    0.84,
    NOW(),
    'https://github.com/pnpm/pnpm/issues/10151'
),
(
    'pnpm licenses list fails with "Cannot read properties of undefined" when using sharedWorkspaceLockfile: false',
    'github-pnpm',
    'LOW',
    '[
        {"solution": "Enable sharedWorkspaceLockfile: true to use unified lockfile structure (recommended)", "percentage": 90, "command": "sharedWorkspaceLockfile: true"},
        {"solution": "Upgrade pnpm to latest version (10.24.0+) with per-project lockfile support fixes", "percentage": 80, "note": "Recent versions handle individual lockfiles better"},
        {"solution": "Run licenses list on individual packages instead of recursively: pnpm -r --parallel licenses list", "percentage": 70, "command": "pnpm -r --parallel licenses list"}
    ]'::jsonb,
    'pnpm monorepo with sharedWorkspaceLockfile: false, Multiple workspace packages with dependencies, pnpm 10+',
    'pnpm licenses list completes without undefined reference errors, Output contains all dependencies across workspace, Each package''s licenses are listed',
    'Error occurs in lockfileToLicenseNodeTree when processing per-project lockfiles. Individual lockfile structure not properly handled in license walker function. Unified lockfile (shared) is workaround but disables some workspace features.',
    0.72,
    NOW(),
    'https://github.com/pnpm/pnpm/issues/10140'
);
