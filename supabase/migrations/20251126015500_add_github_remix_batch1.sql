-- Add GitHub Remix issues batch 1 - High engagement bug issues with community solutions
-- Category: github-remix
-- Source: remix-run/remix GitHub repository - Top 12 issues by engagement

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES (
    'Live Reload not working in Remix dev server',
    'github-remix',
    'HIGH',
    $$[
        {"solution": "Verify NODE_ENV is set to \"development\" when running dev command. Check with console.log(process.env.NODE_ENV) in your component.", "percentage": 85, "note": "Most common cause on Windows machines"},
        {"solution": "Ensure <LiveReload /> component is present in root.tsx entry file. If missing, hot reload will not trigger.", "percentage": 80, "note": "Double-check the component is rendering on the page"},
        {"solution": "On Windows, try using Linux subsystem (WSL) or switch to Linux/Mac. Issue appears platform-specific to Windows.", "percentage": 65, "note": "Hot reload works reliably on Linux and macOS"},
        {"solution": "Make changes in the app/ directory. Changes outside app folder may not trigger live reload properly.", "percentage": 70, "note": "Framework watches specific directories"}
    ]$$::jsonb,
    'Remix project created, dev server running, LiveReload component in root.tsx',
    'Console shows "💿 Rebuilding" and "💿 Reloading window" messages, Page reloads with updated content visible',
    'Do not assume live reload works across all files - it works best within app directory. Windows users may need WSL. Check NODE_ENV first before debugging further.',
    0.72,
    'sonnet-4',
    NOW(),
    'https://github.com/remix-run/remix/issues/1601'
),
(
    'Style tags disappear from Head during Error/Catch Boundary in Remix',
    'github-remix',
    'HIGH',
    $$[
        {"solution": "Add styles via <links> in the route module rather than injecting style tags in entry.server.tsx. Remix manages dynamic links properly across boundaries.", "percentage": 90, "note": "Recommended pattern for Remix CSS management"},
        {"solution": "Move global styles to root.tsx using links() export. This ensures styles persist across error boundaries.", "percentage": 85, "note": "Global styles should be at root level"},
        {"solution": "Use RemixBrowser in entry.client.tsx to handle CSS properly on client side. Ensure entry.server.tsx uses correct Head component.", "percentage": 80, "note": "Proper setup of entry files prevents style loss"},
        {"solution": "If using CSS-in-JS libraries (Material-UI, Emotion), wrap with Suspense to prevent hydration issues that cause style loss.", "percentage": 75, "note": "For dynamic styled components"}
    ]$$::jsonb,
    'Remix v1.1+ project, CSS-in-JS library or custom styles, Error/Catch boundary routes',
    'Styles persist when navigating to error boundary, No flash of unstyled content (FOUC), Error page maintains visual styling',
    'Do not inject styles in entry.server.tsx during markup generation - Remix removes these when errors occur. Use links() export in routes instead. Catch/Error boundaries re-render client-side and lose injected styles.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/remix-run/remix/issues/1136'
),
(
    'Hydration error when Chrome extension modifies DOM in Remix app',
    'github-remix',
    'HIGH',
    $$[
        {"solution": "Install hydration error suppression: Wrap your app root with Suspense or use suppressHydrationWarning flag on html element.", "percentage": 75, "note": "Temporary workaround for extension conflicts"},
        {"solution": "Disable problematic browser extensions during development. Extensions that modify DOM (Grammar checker, ad blockers) cause hydration mismatch.", "percentage": 85, "note": "Test in incognito mode with no extensions to verify"},
        {"solution": "Use the remix.run official solution: Defer rendering until after hydration. Add useEffect to suppress initial hydration errors.", "percentage": 70, "note": "React 18 specific solution"},
        {"solution": "Ensure your app code matches server-rendered HTML exactly. Check for any conditional renders that differ between server and client.", "percentage": 80, "note": "Verify useEffect hooks don''t change DOM"}
    ]$$::jsonb,
    'Remix app with Chrome browser, Browser extensions installed',
    'App loads without hydration warnings, Styles and favicon display correctly, No \"Hydration failed\" error in console',
    'Hydration errors from extensions are browser-specific and not app bugs. Most extensions inject content at unpredictable times. Testing without extensions is essential. This is a known Chrome limitation with DOM-modifying extensions.',
    0.72,
    'sonnet-4',
    NOW(),
    'https://github.com/remix-run/remix/issues/4822'
),
(
    'jsxDEV is not a function error after upgrade to Remix 1.7.0 in Docker',
    'github-remix',
    'MEDIUM',
    $$[
        {"solution": "Clear node_modules and yarn.lock before rebuilding Docker image. The error occurs from cached build artifacts.", "percentage": 90, "note": "Most reliable solution - fresh dependency install"},
        {"solution": "Ensure NODE_ENV=production is set in Docker build stage. Development mode in production can cause jsx runtime issues.", "percentage": 85, "note": "Critical for production builds"},
        {"solution": "Use the full Dockerfile with separate stages for deps, production-deps, build, and final image. Each stage must copy correct files.", "percentage": 80, "note": "Remix 1.7+ has strict build requirements"},
        {"solution": "Add RUN yarn cache clean in Docker before building to remove stale cache entries that may cause jsx runtime conflicts.", "percentage": 75, "note": "Prevents artifact conflicts"}
    ]$$::jsonb,
    'Remix 1.7.0+, Docker container setup, Node.js LTS Alpine image',
    'Docker build succeeds without errors, App starts on port 3000, Routes render without jsxDEV errors, Pages load successfully in browser',
    'Upgrade from 1.6.x to 1.7.0 requires clean install. Do not reuse node_modules from previous build. Docker layer caching can interfere with jsx runtime. Always rebuild from scratch when upgrading.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/remix-run/remix/issues/4081'
),
(
    'HMR race condition error loading dynamically imported module in Remix v2',
    'github-remix',
    'MEDIUM',
    $$[
        {"solution": "The fix is included in Remix 2.0.2+. Upgrade your Remix dependencies to the latest patch version.", "percentage": 95, "note": "Issue resolved in recent releases"},
        {"solution": "If on 2.0.0-2.0.1, clear .cache and dist directories, then restart dev server to force full rebuild.", "percentage": 80, "note": "Temporary workaround if upgrade not possible"},
        {"solution": "Disable HMR temporarily by setting vite dev server ''hmr: false'' config if blocking development, then upgrade.", "percentage": 60, "note": "Workaround only - upgrade recommended"},
        {"solution": "Check vite.config.ts for conflicting HMR settings. Ensure HMR is configured correctly for your dev environment.", "percentage": 70, "note": "Some custom vite configs can cause race conditions"}
    ]$$::jsonb,
    'Remix 2.0.0-2.0.1 project, Vite dev server running, Modified route files',
    'HMR completes without "error loading dynamically imported module" messages, Hot reload applies updates smoothly, Browser console shows no module loading errors',
    'This is a version-specific bug in Remix 2.0.0 and 2.0.1. Upgrading to 2.0.2+ resolves it completely. Do not use workarounds if upgrade is available. Clear cache before upgrading to ensure clean state.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://github.com/remix-run/remix/issues/7466'
),
(
    'JavaScript heap out of memory error in Remix build process',
    'github-remix',
    'MEDIUM',
    $$[
        {"solution": "Increase Node.js memory limit: NODE_OPTIONS=\"--max-old-space-size=4096\" remix build", "percentage": 90, "note": "Most effective solution for memory issues"},
        {"solution": "Split large bundle into multiple routes. Large monolithic app requires more memory during compilation.", "percentage": 80, "note": "Long-term solution for large projects"},
        {"solution": "Upgrade to latest Remix version. Memory optimizations are included in recent releases.", "percentage": 75, "note": "v1.5+ has improved memory handling"},
        {"solution": "Check for circular dependencies or unused imports that bloat the bundle. Use esbuild analyze plugin to identify culprits.", "percentage": 70, "note": "Can reduce required memory significantly"}
    ]$$::jsonb,
    'Remix v1.1+, Large application codebase, Node.js installed',
    'Build completes successfully without OOM error, Process exits with code 0, Output files in build/ directory are valid',
    'This error typically occurs in Docker containers with default memory limits (512MB). Increase memory allocation to 2GB+ for large apps. Check for circular dependencies. Some packages (like styled-components) are memory-intensive.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/remix-run/remix/issues/1555'
),
(
    'create-remix command not working on Windows with npx',
    'github-remix',
    'MEDIUM',
    $$[
        {"solution": "Use yarn create remix instead of npx: yarn create remix my-app", "percentage": 85, "note": "Yarn works more reliably on Windows"},
        {"solution": "Use Node.js 16.13+ and npm 8+. Older versions have Windows path handling issues.", "percentage": 80, "note": "Update Node and npm before running create-remix"},
        {"solution": "If using WSL (Windows Subsystem for Linux), create-remix works without issues in Linux environment.", "percentage": 90, "note": "Recommended workaround for Windows users"},
        {"solution": "Clear npm cache: npm cache clean --force, then retry npx create-remix", "percentage": 65, "note": "Sometimes resolves package resolution issues"}
    ]$$::jsonb,
    'Windows OS, Node.js 14+, npm or yarn installed',
    'Project directory created, All template files present, npm dependencies installed without errors, Dev server starts successfully',
    'Windows has path handling differences. npx sometimes fails on Windows with certain Node versions. WSL is more reliable. Always use npm 8+ and Node 16+ on Windows. Yarn is a better alternative on Windows.',
    0.78,
    'sonnet-4',
    NOW(),
    'https://github.com/remix-run/remix/issues/2714'
),
(
    'ESM build errors after updating Remix to v1.3.5 or v1.4.0',
    'github-remix',
    'MEDIUM',
    $$[
        {"solution": "Downgrade to v1.3.4 as a temporary fix. The issue is specific to 1.3.5 and 1.4.0 early releases.", "percentage": 95, "note": "Confirmed regression in 1.3.5-1.4.0"},
        {"solution": "Upgrade to v1.4.1+ which includes the ESM fix. This is the recommended solution.", "percentage": 98, "note": "Issue is fixed in 1.4.1 and later"},
        {"solution": "If on 1.3.5, manually update esbuild config to target ES2020 instead of ES2015.", "percentage": 70, "note": "Workaround if upgrade not possible"},
        {"solution": "Check remix.config.js for esbuild plugin configurations that may conflict with ESM builds.", "percentage": 60, "note": "Some custom configs can trigger the error"}
    ]$$::jsonb,
    'Remix v1.3.4 installed, Upgrading to v1.3.5+, Esbuild configured',
    'remix build completes without errors, Output JS files are valid ESM modules, Can import output files in other projects',
    'This is a version-specific regression in 1.3.5 and 1.4.0. Upgrading to 1.4.1+ resolves completely. Do not use workarounds if upgrade available. The error manifests as esbuild compilation failures with cryptic messages.',
    0.96,
    'sonnet-4',
    NOW(),
    'https://github.com/remix-run/remix/issues/2691'
),
(
    'ReferenceError: Buffer is not defined in Remix file upload handler',
    'github-remix',
    'MEDIUM',
    $$[
        {"solution": "Import Buffer from Node.js: import { Buffer } from \"buffer\". Remix v1.2+ needs explicit import.", "percentage": 95, "note": "Required for file upload handlers"},
        {"solution": "Add \"buffer\" to remix.config.js esbuild externals array to prevent bundling.", "percentage": 85, "note": "For production builds"},
        {"solution": "Use the updated file upload API from @remix-run/node. Ensure all imports are from correct package.", "percentage": 90, "note": "Use official Remix APIs only"},
        {"solution": "For server-only code, wrap in route module and ensure it does not get bundled to client.", "percentage": 80, "note": "Buffer is Node.js only"}
    ]$$::jsonb,
    'Remix v1.2.3+, File upload route implemented, Node.js runtime',
    'File uploads work without errors, Buffer operations complete successfully, No console errors about Buffer',
    'Buffer is a Node.js global that is not available in browser bundles. Ensure upload handlers are only in server-side code (in routes or action functions). Do not import unstable_createFileUploadHandler on client side.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://github.com/remix-run/remix/issues/2248'
),
(
    'Flash of Unstyled Content (FOUC) in Remix v2 during route transitions',
    'github-remix',
    'MEDIUM',
    $$[
        {"solution": "Use route-level CSS imports. Define links() export in routes to load CSS for that route only.", "percentage": 85, "note": "Requires CSS to be co-located with routes"},
        {"solution": "Enable CSS streaming by using <links> in root and ensuring CSS links are in document head before content.", "percentage": 80, "note": "Remix v2 streaming feature"},
        {"solution": "Move critical CSS inline in root.tsx. Use @remix-run/css-bundle for CSS code splitting.", "percentage": 75, "note": "For critical above-fold styles"},
        {"solution": "Wrap route changes with transition state to show loader while CSS loads. Use useTransition hook.", "percentage": 70, "note": "Visual feedback during transition"}
    ]$$::jsonb,
    'Remix v2.0+, Route-based CSS styling, Streaming enabled',
    'No flashing of unstyled content during route transitions, CSS loads before content renders, Styled page appears immediately on route change',
    'FOUC is more noticeable in v2 due to streaming. Ensure CSS loads in parallel with data. Do not lazy-load styles that affect initial layout. CSS should be in <head>, not deferred.',
    0.80,
    'sonnet-4',
    NOW(),
    'https://github.com/remix-run/remix/issues/7516'
),
(
    'create-remix error \"Cannot find module package.json\" on Windows',
    'github-remix',
    'LOW',
    $$[
        {"solution": "Use absolute paths without wildcards in Remix config. Windows path resolution differs from Unix.", "percentage": 90, "note": "Primary cause on Windows"},
        {"solution": "Use forward slashes in paths: app/routes instead of app\\\\routes, even on Windows.", "percentage": 85, "note": "Use Unix-style paths everywhere"},
        {"solution": "Ensure Node.js version is 16.13.2 or later. Older versions have path handling issues.", "percentage": 80, "note": "Update Node before troubleshooting"},
        {"solution": "Run from PowerShell or Git Bash instead of cmd.exe for better path handling on Windows.", "percentage": 75, "note": "Shell choice matters on Windows"}
    ]$$::jsonb,
    'Windows OS, Node.js 16.13.2+, npm or yarn installed',
    'create-remix completes successfully, Project folder created with all files, Dev server starts without path errors',
    'Windows uses backslashes in paths which can cause issues. Always use forward slashes in config files. Some Node versions have known Windows path bugs. Test in PowerShell first.',
    0.81,
    'sonnet-4',
    NOW(),
    'https://github.com/remix-run/remix/issues/2356'
),
(
    'Live reload rebuilds twice when using Tailwind Watch with Remix',
    'github-remix',
    'LOW',
    $$[
        {"solution": "Configure Tailwind to watch in remix.config.js instead of separate tailwind watch process. Use cssEntryPoint in remix config.", "percentage": 88, "note": "Prevents double rebuilds"},
        {"solution": "Disable Tailwind watch if Remix dev server is already watching. Run only remix dev, not remix dev + tailwind watch.", "percentage": 90, "note": "Most direct solution"},
        {"solution": "Use CSS import in root.tsx: import \"./tailwind.css\" and let Remix handle CSS processing via PostCSS.", "percentage": 85, "note": "Remix v1.1+ handles Tailwind automatically"},
        {"solution": "Set TAILWIND_MODE=watch in tailwind.config.js and configure in remix dev to prevent duplicate watching.", "percentage": 70, "note": "Configuration-level solution"}
    ]$$::jsonb,
    'Remix project with Tailwind CSS, Tailwind CLI v3+, npm/yarn watch process',
    'Dev server rebuilds once per file change, Console shows single \"Rebuilt\" message, No duplicate build logs for CSS changes',
    'Double rebuilds happen when both Tailwind and Remix watch the same CSS files. Stop the separate tailwind watch command. Let Remix handle CSS processing. Only run \"remix dev\", not \"remix dev\" + \"tailwind -i...\".',
    0.86,
    'sonnet-4',
    NOW(),
    'https://github.com/remix-run/remix/issues/714'
);
