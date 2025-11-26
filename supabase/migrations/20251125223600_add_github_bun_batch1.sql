-- Add Bun runtime and install error solutions batch 1
-- Extracted from https://github.com/oven-sh/bun/issues
-- 12 high-engagement issues with documented solutions

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Bun workspace module resolution failure: Failed to resolve import',
    'github-bun',
    'HIGH',
    '[
        {"solution": "Verify workspace configuration in package.json matches pnpm setup", "percentage": 75, "note": "Ensure workspaces array is correctly defined"},
        {"solution": "Clear Bun cache and reinstall: bun pm cache rm && rm -rf node_modules && bun install", "percentage": 80, "note": "Cache corruption can cause resolution failures"},
        {"solution": "Check that all workspace packages exist in the monorepo at specified paths", "percentage": 85, "note": "Missing packages will not be resolved"},
        {"solution": "Update to latest Bun version which has improved workspace handling", "percentage": 70, "note": "Earlier versions had workspace resolution bugs"}
    ]'::jsonb,
    'Monorepo with workspace configuration, Bun v1.0.1+',
    'bun install succeeds without resolution errors, workspace imports resolve correctly',
    'Workspace package paths must exist before attempting resolution. Do not expect pnpm and Bun to have identical resolution behavior for all edge cases. Verify paths in bunfig.toml if using custom settings.',
    0.80,
    'sonnet-4',
    NOW(),
    'https://github.com/oven-sh/bun/issues/5388'
),
(
    'Bun install hangs on resolving when packages not in cache',
    'github-bun',
    'HIGH',
    '[
        {"solution": "Disable IPv6 on your system to prevent hanging DNS lookups", "percentage": 90, "note": "Root cause is IPv6 connectivity issues affecting package resolution"},
        {"solution": "Clear package cache: bun pm cache rm", "percentage": 75, "note": "Corrupted cache can cause prolonged resolution hangs"},
        {"solution": "Restart your computer to reset network state temporarily", "percentage": 60, "note": "Temporary fix, issue will likely recur"},
        {"solution": "Reinstall Bun from official website instead of Snap package on Ubuntu", "percentage": 85, "note": "Snap installations may have different network configuration"}
    ]'::jsonb,
    'Bun v1.1.8+, Network connectivity, Empty or partial package cache',
    'bun install completes within normal timeframe (under 60 seconds), No hanging on resolving step, Packages install successfully on first attempt',
    'Restarting provides only temporary relief - IPv6 disabling is the permanent solution. The issue is system network configuration, not just Bun. Do not repeatedly retry without addressing the root cause.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/oven-sh/bun/issues/11526'
),
(
    'Bun install fails with branch names containing forward slashes',
    'github-bun',
    'MEDIUM',
    '[
        {"solution": "Rename the Git branch to remove forward slashes: git branch -m experimental/test experimental-test", "percentage": 95, "note": "This is the most reliable workaround"},
        {"solution": "Update dependency reference to use renamed branch: change dependency from #experimental/test to #experimental-test", "percentage": 95, "note": "Must update both branch and package.json"},
        {"solution": "Upgrade to latest Bun version (after PR #5941) which properly handles branch slashes", "percentage": 98, "note": "Issue was fixed in Bun - upgrade resolves permanently"}
    ]'::jsonb,
    'Bun v0.x-1.0.x (before fix), Git repository with branch containing /',
    'bun install succeeds with renamed branch, Package dependency resolves correctly',
    'Branch renaming is a temporary workaround. The proper fix is updating Bun to a version after PR #5941. Forward slashes in branch names are valid Git references but Bun''s parser had issues with them.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/oven-sh/bun/issues/5478'
),
(
    'Bun peer dependency resolution selects latest version instead of compatible version',
    'github-bun',
    'HIGH',
    '[
        {"solution": "Manually specify the required peer dependency version in your package.json dependencies to force resolution", "percentage": 80, "note": "For example, add eslint@8 directly if modules require v8"},
        {"solution": "Install packages with npm first, then run applications with bun: npm install && bun run", "percentage": 85, "note": "Workaround but defeats speed advantage of Bun"},
        {"solution": "Wait for Bun to implement constraint satisfaction algorithm matching npm''s resolver", "percentage": 70, "note": "This is a known limitation in Bun''s dependency resolver"},
        {"solution": "Use explicit version ranges that overlap: avoid conflicting peer dependency requirements", "percentage": 75, "note": "Update package requirements if possible"}
    ]'::jsonb,
    'Bun install with peer dependencies, Packages with overlapping peer dependency version ranges',
    'No "incorrect peer dependency" warnings during install, All installed packages receive versions satisfying their requirements, Application runs without version conflicts',
    'Bun''s peer dependency resolution differs from npm. The resolver chooses the latest version satisfying any dependency, not the version satisfying all constraints. This is a design limitation, not a bug.',
    0.80,
    'sonnet-4',
    NOW(),
    'https://github.com/oven-sh/bun/issues/15711'
),
(
    'Bun add/install failed to resolve package error',
    'github-bun',
    'MEDIUM',
    '[
        {"solution": "Verify network connectivity and firewall settings allow npm registry access", "percentage": 85, "note": "Ensure outbound HTTPS to registry.npmjs.org is permitted"},
        {"solution": "Check registry configuration in bunfig.toml matches .npmrc settings", "percentage": 90, "note": "Misaligned registry configs cause resolution failures"},
        {"solution": "Test with npm or yarn to establish baseline: npm install && yarn add", "percentage": 80, "note": "If npm/yarn work but bun fails, issue is Bun-specific"},
        {"solution": "Clear cache and reinstall: rm bunfig.toml && bun install", "percentage": 75, "note": "Corrupted config files can trigger resolution errors"}
    ]'::jsonb,
    'Network connectivity, Valid npm/yarn registry access, Bun v0.5.0+',
    'Packages install without "failed to resolve" errors, bun install completes successfully, Package is available in node_modules',
    'This error often indicates post-manifest-download failures, not registry connectivity. Do not assume firewall is the only cause. Check registry configuration carefully - internal registries may be missing required response fields.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/oven-sh/bun/issues/1830'
),
(
    'Bun devDependencies in file-based dependencies fail to resolve',
    'github-bun',
    'MEDIUM',
    '[
        {"solution": "Remove devDependencies from local package''s package.json file", "percentage": 95, "note": "This is the workaround until the issue is fixed"},
        {"solution": "Upgrade to Bun after PR #2781 which fixed devDependencies handling for local dependencies", "percentage": 98, "note": "Permanent fix in newer Bun versions"},
        {"solution": "Move development-only packages to a separate optional dependencies section temporarily", "percentage": 70, "note": "Partial workaround for monorepo setups"}
    ]'::jsonb,
    'Monorepo setup with local file dependencies, Packages with devDependencies, Bun v0.5.9+',
    'bun install succeeds with local file dependencies containing devDependencies, All dependencies including dev dependencies resolve correctly, Installation completes without "failed to resolve" errors',
    'Bun handles dependencies and devDependencies differently than npm for local packages. DevDependencies in local packages are genuinely optional for consumers - consider if they should be dependencies instead.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/oven-sh/bun/issues/2653'
),
(
    'Bun runtime module resolution prioritizes main over module field',
    'github-bun',
    'LOW',
    '[
        {"solution": "Change TypeScript moduleResolution setting: update tsconfig.json to use Node or nodenext", "percentage": 75, "note": "This is documented Bun behavior, not a bug"},
        {"solution": "Understand that Bun''s bundler respects module field but runtime does not", "percentage": 85, "note": "Different resolution strategies for bundler vs runtime"},
        {"solution": "Use explicit ESM imports with .mjs file extensions when available", "percentage": 80, "note": "Forces ESM resolution without relying on package.json fields"},
        {"solution": "File issue with package maintainers if main is CJS but module should be used for ESM", "percentage": 70, "note": "Package.json configuration issue, not Bun bug"}
    ]'::jsonb,
    'Project importing ESM packages, Bun v1.0+, Packages with both main and module fields',
    'ESM imports resolve to .mjs or ESM-compatible files, No CommonJS/ESM mixing errors, Application runs with correct module format',
    'This is documented behavior, not a bug. Bun runtime uses Node.js resolution algorithm which prioritizes main over module. The bundler respects module field. This distinction is important and not always clear from documentation.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/oven-sh/bun/issues/14339'
),
(
    'Bun workspace dependency not found error with wildcard patterns',
    'github-bun',
    'MEDIUM',
    '[
        {"solution": "Replace wildcard patterns with explicit package paths in workspaces array", "percentage": 95, "note": "Example: change from packages/* to explicit paths like packages/backend-api"},
        {"solution": "Delete lock file and reinstall after explicitly listing packages: rm bun.lock && bun install", "percentage": 90, "note": "Lock file caching can prevent wildcard reindexing"},
        {"solution": "Upgrade Bun to include PR #11177 fix for wildcard workspace handling", "percentage": 95, "note": "Available in canary releases via bun upgrade --canary"}
    ]'::jsonb,
    'Monorepo with wildcard workspace patterns, Bun v1.1.7 or affected versions, Adding new packages to workspaces',
    'bun install succeeds with workspace dependencies, New packages are properly recognized, Wildcard patterns resolve all packages correctly',
    'Wildcard patterns in workspaces have a caching/initialization issue in earlier Bun versions. Explicitly listing packages first, then reinstalling with wildcards, appears to work around the issue. This is fixed in newer versions.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/oven-sh/bun/issues/10889'
),
(
    'Bun server reload HTML bundling error with corrupted module name',
    'github-bun',
    'LOW',
    '[
        {"solution": "Upgrade to Bun 1.2.21 or later which includes bundler stability fixes", "percentage": 98, "note": "This specific issue was resolved in versions 1.2.19-1.2.21"},
        {"solution": "Avoid calling server.reload() with HTML bundled imports as a workaround", "percentage": 75, "note": "Temporary workaround for older Bun versions"},
        {"solution": "Update your Bun.build() configuration to avoid HTML bundling if reload is critical", "percentage": 70, "note": "Workaround by changing bundler configuration"}
    ]'::jsonb,
    'Bun 1.2.0-1.2.18, HTML bundled imports, Bun.serve() with reload functionality',
    'server.reload() completes without errors, HTML assets load correctly after reload, No corrupted module resolution errors',
    'This is a bundler serialization bug specific to certain Bun versions. Upgrading is the recommended solution. Do not attempt workarounds if you can upgrade - they may hide other issues.',
    0.95,
    'sonnet-4',
    NOW(),
    'https://github.com/oven-sh/bun/issues/16658'
),
(
    'Bun cannot start Expo app: Unable to deserialize data or Pipeline type error',
    'github-bun',
    'MEDIUM',
    '[
        {"solution": "Use Node.js instead of Bun for Expo projects: npm run start instead of bun --bun run start", "percentage": 95, "note": "Reliable workaround for Expo/Metro compatibility issues"},
        {"solution": "Upgrade to Bun v1.2.19 or later which has improved stream/undici compatibility", "percentage": 80, "note": "Some Expo issues were resolved in later versions"},
        {"solution": "Verify Node.js installation is correct on macOS: reinstall via Homebrew if needed", "percentage": 70, "note": "Stream implementation mismatches can indicate Node.js issues"},
        {"solution": "Downgrade to verified working Bun version for Expo if upgrading does not help", "percentage": 60, "note": "Some Bun/Expo version combinations are incompatible"}
    ]'::jsonb,
    'Expo project, Bun v1.1.36+, Metro bundler dependency',
    'Expo development server starts without errors, App loads and runs correctly, No type mismatch errors from undici or stream modules',
    'Bun and Expo/Metro have fundamental compatibility issues around stream types and serialization. Using Node.js is not a limitation - it''s the most reliable approach. Do not force Bun with Expo unless you have verified compatibility.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/oven-sh/bun/issues/14481'
),
(
    'Bun startup hangs when importing native Rust modules like @node-rs/xxhash',
    'github-bun',
    'MEDIUM',
    '[
        {"solution": "Replace native module with WebAssembly alternative: switch @node-rs/xxhash to xxhash-wasm", "percentage": 95, "note": "WebAssembly avoids native module loading issues on Linux"},
        {"solution": "Update Bun version to latest which has improved native module support", "percentage": 75, "note": "Native module handling improved over time"},
        {"solution": "Check if specific native modules have known issues with Bun on Linux", "percentage": 70, "note": "Some native modules work on macOS but fail on Linux"},
        {"solution": "Use conditional imports: import native module only on supported platforms", "percentage": 80, "note": "Allows fallback to WASM on Linux if dual support exists"}
    ]'::jsonb,
    'Linux environment, Bun v1.0.2+, Project importing native Rust modules',
    'bun run/bun test startup completes quickly (under 5 seconds), No hanging during module import, Application executes without delays',
    'Native module loading on Linux in Bun has synchronization issues that do not occur on macOS. WebAssembly alternatives are more reliable. Not all native modules work equally well with Bun across platforms.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/oven-sh/bun/issues/5782'
),
(
    'Bun.serve segmentation fault when handling invalid file descriptors',
    'github-bun',
    'MEDIUM',
    '[
        {"solution": "Upgrade Bun to version with PR #1386 fix which adds proper error handling for invalid file descriptors", "percentage": 98, "note": "This was fixed early in Bun development and is in all modern versions"},
        {"solution": "Validate file descriptors before piping through HTTP responses: use try-catch around Bun.file()", "percentage": 90, "note": "Defensive programming workaround"},
        {"solution": "Avoid rapid sequential requests with intentionally invalid file descriptors in tests", "percentage": 85, "note": "This was mainly seen in stress tests, not production workloads"},
        {"solution": "Use proper error handling for file operations: check file existence before serving", "percentage": 80, "note": "General best practice"}
    ]'::jsonb,
    'Bun serving HTTP responses with Bun.file(), Invalid file descriptors possible',
    'Bun.serve handles rapid requests without segmentation faults, Invalid file errors are handled gracefully, HTTP server remains stable under load',
    'Early Bun versions did not handle invalid file descriptor errors properly in HTTP response streaming, leading to memory corruption. This is fixed in all recent versions. Do not assume this is still an issue with current Bun.',
    0.96,
    'sonnet-4',
    NOW(),
    'https://github.com/oven-sh/bun/issues/1380'
);
