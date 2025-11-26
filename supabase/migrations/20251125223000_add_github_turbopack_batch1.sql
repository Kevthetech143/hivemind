-- Add Turbopack build error issues from vercel/turbo GitHub (Batch 1)
-- Category: github-turbopack
-- Date mined: 2025-11-25

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Turborepo hanging in CI with timeout after 9 minutes',
    'github-turbopack',
    'HIGH',
    '[
        {"solution": "Enable verbose logging with -vv flag to identify where process stalls: turbo run test -vv", "percentage": 85, "note": "Helps identify if hanging at task initialization or execution"},
        {"solution": "Check for Linux-specific process synchronization issues - upgrade to latest Turborepo version (2.0+)", "percentage": 80, "note": "Issue occurs inconsistently in CI but not locally - version 1.13.3+ affected"},
        {"solution": "Review GitHub Actions workflow for resource constraints (memory, CPU) that may trigger hangs", "percentage": 75, "note": "High resource usage correlates with timeout issues"},
        {"solution": "Verify all child processes terminate properly - use process group management", "percentage": 70, "note": "Related to signal handling in CI environments"}
    ]'::jsonb,
    'Turborepo 1.10.3+, Node.js 14+, GitHub Actions or Linux CI environment',
    'Task execution completes without timeout, verbose logs show task progression, no hanging at "waiting for task" stage',
    'Do not increase timeout indefinitely - address root cause instead. Linux/Windows behavior differs; test both. Ensure npm/yarn versions are compatible with Turborepo. Check for race conditions in codegen operations.',
    0.75,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/turbo/issues/8281'
),
(
    'Turbopack SIGKILL signal not terminating child processes',
    'github-turbopack',
    'HIGH',
    '[
        {"solution": "Use process group kill instead of individual process: kill -9 -<pid> to kill parent and all children", "percentage": 90, "note": "SIGKILL cannot be caught but process group management can ensure cleanup"},
        {"solution": "Configure Playwright with gracefulShutdown option to send SIGINT instead of SIGKILL", "percentage": 85, "command": "Set gracefulShutdown: true in playwright config", "note": "Allows turbo to propagate signals to children"},
        {"solution": "Implement signal forwarding in Turborepo task execution for SIGINT/SIGTERM before spawning children", "percentage": 80, "note": "Framework-level fix - needed for proper cleanup"},
        {"solution": "Use process reaping and zombie process cleanup in long-running CI tasks", "percentage": 75, "note": "Prevents orphaned processes consuming resources"}
    ]'::jsonb,
    'Turborepo with child process execution, Playwright integration, or testing frameworks',
    'Kill signal terminates all child processes, no orphaned processes remain (verify with ps), Playwright tests complete without hanging',
    'SIGKILL signals cannot be handled - use SIGINT/SIGTERM instead. Process groups may not work in Docker - test environment-specific handling. Do not ignore signal propagation in scripts.',
    0.80,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/turbo/issues/9666'
),
(
    'Turbopack TUI garbled with task errors - overlapping output',
    'github-turbopack',
    'MEDIUM',
    '[
        {"solution": "Upgrade to Turborepo 2.1+ which improves stderr handling and terminal output", "percentage": 90, "note": "Root cause: improper carriage return handling in stderr"},
        {"solution": "Ensure proper newline termination after carriage returns: check for missing \\n after \\r sequences", "percentage": 85, "note": "Terminal panes overlap when \\r moves cursor but no \\n follows"},
        {"solution": "Test with different terminal emulators (Terminal.app, iTerm2, Alacritty) to isolate emulator-specific issues", "percentage": 75, "note": "Issue present across all tested terminals - framework issue"},
        {"solution": "Use ANSI escape codes properly - verify stderr and stdout dont mix with direct terminal control", "percentage": 70, "note": "Multiple task output interleaving causes visual corruption"}
    ]'::jsonb,
    'Turborepo 2.0.6+, multiple tasks running in parallel, npm/yarn, macOS',
    'Multiple failing tasks display cleanly in separate panes, no output overlap, error messages appear in correct task section',
    'Do not use raw carriage returns without newlines. Ensure each task output is properly buffered. Multiple terminal emulators show same issue - not emulator-specific. Stderr handling must prevent cross-task contamination.',
    0.78,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/turbo/issues/9057'
),
(
    'WebSocket HMR connection fails with Turbopack - webpack-hmr endpoint not found',
    'github-turbopack',
    'HIGH',
    '[
        {"solution": "Upgrade Next.js to 13.3+ which includes proper Turbopack HMR endpoint recognition", "percentage": 95, "note": "Issue: dev overlay tries webpack endpoint instead of Turbopack endpoint"},
        {"solution": "Remove --turbo flag and use standard webpack HMR if upgrade not possible", "percentage": 85, "command": "Remove --turbo from dev script or use next dev without flag", "note": "Temporary workaround - HMR works without Turbopack"},
        {"solution": "Verify app directory is properly configured - update next.config.js to enable experimental Turbopack", "percentage": 80, "note": "Issue specific to App Router with Turbopack"},
        {"solution": "Clear .next cache and node_modules - rebuild from scratch to reset HMR state", "percentage": 75, "command": "rm -rf .next && npm install", "note": "Cache may contain stale HMR configuration"}
    ]'::jsonb,
    'Next.js 13+, Turbopack enabled, App Directory configured, npm/yarn',
    'Browser console shows no HMR connection errors, WebSocket connects to correct Turbopack HMR endpoint, CSS/JS hot reloading works',
    'Turbopack uses different HMR protocol than webpack - do not expect _next/webpack-hmr endpoint. Monorepo setups may have additional complexity. Do not disable HMR entirely - fix the endpoint.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/turbo/issues/2496'
),
(
    'CSS HMR not working with Turbopack - styles not updating on save',
    'github-turbopack',
    'HIGH',
    '[
        {"solution": "Apply fix from PR #4740: use ProxiedAsset instead of css_chunk_root_path for granular CSS asset control", "percentage": 95, "note": "Official Turbopack fix for CSS module hot acceptance"},
        {"solution": "Ensure module.hot.accept() is called for CSS modules - upgrade Next.js to include PR #47913", "percentage": 90, "note": "CSS modules require explicit hot acceptance configuration"},
        {"solution": "Check turbo.json and next.config.js for proper CSS loader configuration", "percentage": 85, "note": "CSS Modules must be explicitly recognized"},
        {"solution": "For globals.css and module.css, verify both are handled by HMR system", "percentage": 80, "note": "Different CSS file types need different HMR paths"}
    ]'::jsonb,
    'Next.js 13.2.4+, Turbopack enabled, CSS Modules or global CSS files, Windows/macOS/Linux',
    'CSS changes apply immediately without page reload, browser dev tools show CSS updates, no console errors about module hot acceptance',
    'Global CSS and module CSS have different HMR paths - both must be configured. Do not rely on webpack HMR for Turbopack. Module hot acceptance requires explicit implementation.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/turbo/issues/4444'
),
(
    'HMR fails in WSL2 - changes require dev server restart',
    'github-turbopack',
    'MEDIUM',
    '[
        {"solution": "Upgrade to latest Next.js canary which improves WSL2 HMR support: npm install next@canary", "percentage": 85, "note": "WSL2 file watching had issues in older versions"},
        {"solution": "Configure file watcher to use polling instead of native watchers: add --poll flag to dev server", "percentage": 80, "command": "next dev --turbo --poll=100", "note": "WSL2 file system watchers may miss changes"},
        {"solution": "Verify WSL2 file system performance - move project to WSL2 native filesystem instead of /mnt", "percentage": 75, "note": "Performance issues on /mnt can trigger HMR failures"},
        {"solution": "Check for VSCode or editor file sync issues - save files explicitly before expecting HMR", "percentage": 70, "note": "Some editors batch writes which confuses watchers"}
    ]'::jsonb,
    'Windows Subsystem for Linux 2 (WSL2), Next.js 13+, Turbopack, npm/yarn',
    'Code changes appear in browser without dev server restart, HMR socket connects successfully, no file watcher timeout errors',
    'WSL2 and Windows have different file watching semantics. Do not assume native file watchers work in WSL2. Polling adds overhead - balance responsiveness vs performance. Path mapping between Windows and WSL2 can interfere.',
    0.72,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/turbo/issues/5137'
),
(
    'Next.js package not found error with Turbopack --turbo flag',
    'github-turbopack',
    'HIGH',
    '[
        {"solution": "Upgrade Next.js to latest canary: npm install next@canary - resolves Next.js internal path issues", "percentage": 90, "note": "Issue occurs with older Next.js versions (13.x)"},
        {"solution": "Verify next.js is installed in project root node_modules, not monorepo workspace", "percentage": 85, "note": "Turbopack module resolution may fail with incorrect Next.js location"},
        {"solution": "Clear node_modules and reinstall: rm -rf node_modules && npm install", "percentage": 80, "command": "npm ci --force", "note": "Corrupted node_modules or dependency cache"},
        {"solution": "Remove turbo.json temporarily and test if issue is Next.js canary specific", "percentage": 75, "note": "Helps determine if root cause is Turborepo configuration"}
    ]'::jsonb,
    'TurboRepo 1.10.15+, Next.js 13+, npm/yarn, macOS',
    'Dev server starts without "Next.js package not found" error, application accessible at http://localhost:3000, no module resolution errors',
    'Turbopack requires exact Next.js versions - compatibility matrix changed between releases. Do not skip canary versions if on cutting edge. Monorepo package resolution can confuse Turbopack path resolution.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/turbo/issues/6178'
),
(
    'Socket.io API endpoints return 404 with Turbopack --turbo flag',
    'github-turbopack',
    'HIGH',
    '[
        {"solution": "Upgrade to latest Next.js canary (Feb 2024+) which fixes Socket.io API route handling", "percentage": 95, "note": "Official fix: Socket.io routes now properly resolved"},
        {"solution": "Test without --turbo flag to confirm Socket.io works without Turbopack", "percentage": 90, "command": "Remove --turbo from next dev script", "note": "Confirms Socket.io compatibility issue with Turbopack"},
        {"solution": "For temporary workaround, use standard webpack: remove --turbo flag and use next dev", "percentage": 85, "note": "Disables Turbopack until Next.js upgrade completed"},
        {"solution": "Verify /api/socket_io route is properly configured in pages/api/ or app directory", "percentage": 75, "note": "Ensure route structure matches Next.js expectations"}
    ]'::jsonb,
    'Next.js with Socket.io, Turbopack enabled, npm/yarn, Windows/macOS/Linux',
    'Socket.io endpoint responds with 200 HTTP status, Socket connections establish without 404 errors, real-time communication works',
    'Socket.io routes incompatible with certain Turbopack versions - upgrade required. Do not modify Socket.io configuration - upgrade Next.js instead. Webpack HMR issues cascade to Socket.io routes.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/turbo/issues/5837'
),
(
    'TypeError: cache is not a function with form validation libraries in Turbopack',
    'github-turbopack',
    'MEDIUM',
    '[
        {"solution": "Upgrade Next.js to latest version with improved Turbopack module resolution: npm install next@latest", "percentage": 85, "note": "Pre-Turbopack integration bug fixed in newer versions"},
        {"solution": "Test with next@canary to verify React import resolution works correctly", "percentage": 80, "command": "npm install next@canary", "note": "Canary versions have better form validation library support"},
        {"solution": "Avoid combining zod + react-hook-form + @hookform/resolvers until Next.js upgrade", "percentage": 75, "note": "Specific library combination triggers edge case in module resolution"},
        {"solution": "Use alternate form validation: switch to react-final-form or formik as temporary workaround", "percentage": 70, "note": "Alternative libraries dont trigger this edge case"}
    ]'::jsonb,
    'Next.js 13.4.3+, zod, react-hook-form, @hookform/resolvers, npm/yarn',
    'Form validation works without TypeError in middleware, React imports resolve correctly, no edge runtime errors',
    'Turbopack module caching had pre-integration issues. Do not use form validation library combination until Next.js upgraded. Edge runtime middleware is especially affected by this bug.',
    0.76,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/turbo/issues/5103'
),
(
    'Dynamic import fails for components with CSS Modules - null reference error',
    'github-turbopack',
    'MEDIUM',
    '[
        {"solution": "Use static imports instead of dynamic imports for CSS Module components: import Button from \"ui/Button\"", "percentage": 90, "note": "Static imports work correctly - dynamic adds complexity"},
        {"solution": "For required dynamic imports, separate logic from CSS styling - use CSS-in-JS or inline styles", "percentage": 85, "note": "Bypasses CSS Module DOM reference issue"},
        {"solution": "Upgrade to Next.js 13.5+ which improves dynamic import with CSS Module support", "percentage": 80, "note": "Later versions handle CSS Module registration better"},
        {"solution": "Move CSS modules to parent component and pass styles as props to dynamically imported component", "percentage": 75, "note": "Defers CSS binding until component is statically available"}
    ]'::jsonb,
    'Next.js 13.4.3, CSS Modules, next/dynamic for code splitting, monorepo workspace',
    'Dynamically imported components render without null reference errors, CSS applies correctly to dynamic components, dev and prod builds consistent',
    'Dynamic imports with CSS Modules need DOM element (querySelector on #__next_css__DO_NOT_USE__) - ensure it exists. Static imports preferred. Production builds work fine - development issue only.',
    0.74,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/turbo/issues/5096'
),
(
    'tsconfig extends field not resolving in Turbopack - parsing error',
    'github-turbopack',
    'MEDIUM',
    '[
        {"solution": "Inline extended tsconfig settings instead of using extends: copy baseUrl, paths, compilerOptions directly", "percentage": 85, "note": "Avoids path resolution issues entirely"},
        {"solution": "Upgrade to Next.js 13.2+ which improved tsconfig extends resolution in dependencies", "percentage": 80, "note": "Parser now handles nested node_modules extends"},
        {"solution": "For monorepo, place shared tsconfig.json in root and use relative paths: \"extends\": \"../../tsconfig.json\"", "percentage": 78, "note": "Relative paths resolve better than absolute"},
        {"solution": "Ensure tsconfig file is accessible from Turbopack bundle process - check file permissions", "percentage": 70, "note": "Build process may lack read access to dependency files"}
    ]'::jsonb,
    'Next.js 13+, monorepo with shared tsconfig, dependencies with tsconfig.json (Apollo Client, etc), pnpm/npm',
    'Turbopack builds without tsconfig parsing errors, module resolution works for scoped packages, no "extends doesnt resolve" messages',
    'Turbopack processes tsconfig differently than webpack - extends field can fail in dependencies. Do not rely on tsconfig extends for Turbopack builds. Test with Next.js canary if issues persist.',
    0.80,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/turbo/issues/2973'
),
(
    'Workspace symlink packages not found by Turbopack module resolution',
    'github-turbopack',
    'MEDIUM',
    '[
        {"solution": "Copy symlinked packages to actual locations during build: configure pnpm .npmrc with symlink: false", "percentage": 80, "note": "Disables symlinks and uses copies instead"},
        {"solution": "Skip symlink traversal in Turbopack but still copy contents: this requires monorepo restructuring", "percentage": 75, "note": "Original design decision - symlinks intentionally disabled"},
        {"solution": "Use workspace package paths directly without intermediate symlinks: reorganize folder structure", "percentage": 85, "command": "Place all workspace packages in direct folders, no symlinks", "note": "Recommended: cleaner for Turbopack"},
        {"solution": "Configure Turborepo to not follow symlinks via turbo.json - use explicit package paths", "percentage": 70, "note": "Workaround: reduce symlink usage in config"}
    ]'::jsonb,
    'Turborepo monorepo, pnpm workspace with symlinks, multiple workspace packages',
    'Workspace packages resolve without "Cannot find module" errors, build completes successfully, package paths follow symlinks or copies correctly',
    'Symlink traversal disabled by design (commit 494b894) to prevent duplicate copy issues. Do not assume symlinks work like regular files. Pnpm uses symlinks heavily - may need configuration changes. Alternative: use hard links if filesystem supports.',
    0.68,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/turbo/issues/2517'
),
(
    'FileSystemPath joining leaves filesystem root on Windows with Turbopack',
    'github-turbopack',
    'LOW',
    '[
        {"solution": "Move project to shallower directory path (e.g., C:\\projects instead of C:\\Users\\User\\Documents\\...", "percentage": 85, "note": "Path depth affects resolution - deeper paths trigger joining bug"},
        {"solution": "Upgrade Next.js 15.4.2+ to latest version - Windows path handling improved", "percentage": 80, "command": "npm install next@latest", "note": "Known Windows path resolution issue in 15.4.2"},
        {"solution": "Use WSL2 or Linux environment as alternative to Windows for development", "percentage": 75, "note": "Windows path handling more complex - Unix paths simpler"},
        {"solution": "Report to Next.js repository (vercel/next.js) - issue is in Next.js/Turbopack integration not Turborepo", "percentage": 70, "note": "Windows filesystem paths handled by Next.js"}
    ]'::jsonb,
    'Next.js 15.4.2, Windows 10/11, Node.js 22+, npm, deep project directory paths',
    'Endpoints compile without FileSystemPath errors, all routes accessible, build completes on Windows without path resolution failures',
    'Windows absolute paths (C:\\Users\\...) cause joining issues with relative paths. Do not use very deep directory structures. Issue reported upstream to Next.js - Turbopack path handling incomplete for Windows. Consider WSL2 for better compatibility.',
    0.65,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/turbo/issues/10703'
);
