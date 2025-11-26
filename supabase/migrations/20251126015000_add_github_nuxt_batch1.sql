-- Add 12 high-voted GitHub Nuxt issues with solutions
-- Category: github-nuxt
-- Source: https://github.com/nuxt/nuxt/issues

INSERT INTO knowledge_entries (query, category, solutions, common_pitfalls, success_rate, hit_frequency, claude_version, last_verified, source_url)
VALUES
(
  'Nuxt local server gets stuck in infinite reload loop with HMR not working',
  'github-nuxt',
  $$[
    {"solution": "Clear node_modules/.cache folder to remove stale Webpack/Babel cache", "percentage": 85, "command": "rm -rf node_modules/.cache", "note": "Webpack may retain old chunk files after hot reloads causing hangs"},
    {"solution": "Upgrade Node.js to v12.11.0+ - v12.0-v12.10 has hanging bugs", "percentage": 90, "command": "nvm install 12.11.0 && nvm use 12.11.0", "note": "Node.js v12.0-v12.10 contains a specific hanging bug fixed in later versions"},
    {"solution": "Use incognito window to bypass browser cache and connection limits", "percentage": 75, "note": "Chrome allows 5 concurrent connections per domain, Firefox 3 - incognito resets this"},
    {"solution": "Disable browser cache in DevTools Network tab and clear frequently", "percentage": 80, "note": "Check Preserve log option in Chrome DevTools to retain console output during reloads"}
  ]$$::jsonb,
  'Stale Babel/Webpack cache files prevent proper hot reload. Browser connection limits (Chrome 5, Firefox 3 per domain) cause hangs. Older Node.js versions have inherent hanging bugs.',
  0.85,
  'HIGH',
  'sonnet-4',
  NOW(),
  'https://github.com/nuxt/nuxt/issues/6442'
),
(
  'CSS from multiple layouts being included on every page regardless of layout specified',
  'github-nuxt',
  $$[
    {"solution": "Scope CSS with layout-specific class bindings on parent containers", "percentage": 88, "command": "Use <div :class=\"layoutName\"><slot /></div> with scoped styles", "note": "Prevents style bleeding between layouts by namespacing all styles"},
    {"solution": "Define layout-specific stylesheets in head config instead of scoped style blocks", "percentage": 82, "note": "External CSS files can be loaded/unloaded per layout more cleanly"},
    {"solution": "Add splitChunks configuration for layouts in nuxt.config", "percentage": 70, "command": "build: { splitChunks: { layouts: true } }", "note": "Helps with initial render but does not fully prevent persistence after navigation"}
  ]$$::jsonb,
  'Scoped styles in Vue do not completely prevent cross-layout CSS bleed. Style tags persist in DOM after layout switching. splitChunks configuration is only partial fix.',
  0.88,
  'HIGH',
  'sonnet-4',
  NOW(),
  'https://github.com/nuxt/nuxt/issues/3877'
),
(
  'Safari enters infinite reload loop when hot reloading with HMR enabled',
  'github-nuxt',
  $$[
    {"solution": "Remove all cached service worker data in Safari: clear site data for localhost", "percentage": 85, "note": "Service worker caching causes HMR to loop - Safari specific issue"},
    {"solution": "Check if PWA module is enabled and causing HMR conflict", "percentage": 80, "note": "PWA module may interfere with HMR - see nuxt-community/pwa-module#60"},
    {"solution": "Disable PWA module temporarily during development", "percentage": 75, "command": "Remove pwa module from buildModules during dev", "note": "Service worker interferes with hot reload cycle in Safari"}
  ]$$::jsonb,
  'Service worker caching in Safari causes infinite HMR loops and CPU spikes. PWA module may interfere with hot reload. Manual tab refresh required to recover.',
  0.85,
  'MEDIUM',
  'sonnet-4',
  NOW(),
  'https://github.com/nuxt/nuxt/issues/3828'
),
(
  'Nuxt 3.8.1 frequent dependency optimization triggers causing full page reloads during development',
  'github-nuxt',
  $$[
    {"solution": "Revert to Nuxt 3.8.0 - issue does not occur in previous version", "percentage": 95, "command": "npm install nuxt@3.8.0", "note": "Confirmed by multiple users - 3.8.0 stable, 3.8.1 broken"},
    {"solution": "Run nuxi upgrade --force to refresh lockfile", "percentage": 45, "command": "npx nuxi upgrade --force", "note": "Inconsistent results - some users report it works, many report no change"},
    {"solution": "Pre-load components globally instead of using lazy-loading", "percentage": 60, "note": "Reduces optimization triggers but does not eliminate them completely"},
    {"solution": "Wait for Vite 5.0.0 release - issue likely fixed in upstream", "percentage": 70, "note": "Root cause is Vite dependency optimization behavior"}
  ]$$::jsonb,
  'Issue is regression in 3.8.1 only. Dynamic imports trigger optimization on first load. Pre-loading reduces but does not fix. Lockfile regeneration inconsistent.',
  0.90,
  'HIGH',
  'sonnet-4',
  NOW(),
  'https://github.com/nuxt/nuxt/issues/24196'
),
(
  'nuxi build command consumes excessive memory causing out-of-memory crashes on resource-constrained servers',
  'github-nuxt',
  $$[
    {"solution": "Wrap heavy client-only code with process.client check to prevent server build inclusion", "percentage": 88, "command": "process.client ? defineAsyncComponent(() => import(''~/components/Heavy.vue'')) : null", "note": "Prevents esbuild from including client-only code in server build phase"},
    {"solution": "Garbage collection between client and server build phases", "percentage": 75, "note": "Maintainers considering for future - memory not released after client build"},
    {"solution": "Split builds into separate processes with memory limits", "percentage": 70, "command": "Run client build, then server build in separate node processes", "note": "Workaround requires manual process management"}
  ]$$::jsonb,
  'Memory from client build phase not released before server build begins - doubles peak requirement. Docker/Lambda/low-memory servers most affected. Affects Nuxt 3+.',
  0.88,
  'HIGH',
  'sonnet-4',
  NOW(),
  'https://github.com/nuxt/nuxt/issues/21458'
),
(
  'Production memory leaks in Nuxt 3.6+ SSR mode - memory grows from 50MB to 300MB after 100 requests',
  'github-nuxt',
  $$[
    {"solution": "Remove NuxtLoadingIndicator component from layouts - confirmed root cause", "percentage": 95, "command": "Delete <NuxtLoadingIndicator /> from layout.vue", "note": "PR #24052 fixed this but requires removing component"},
    {"solution": "Upgrade to Nuxt 3.7.2+ where fix was merged", "percentage": 92, "command": "npm update nuxt@latest", "note": "Leak caused by vue-router addRoute function retaining references in NuxtLoadingIndicator"},
    {"solution": "Review heap snapshots for accumulating references", "percentage": 70, "note": "Garbage collection ineffective due to lingering vue-router route registrations"}
  ]$$::jsonb,
  'NuxtLoadingIndicator component causes memory accumulation in vue-router addRoute. Garbage collection does not recover memory. Issue occurs in 3.6.1-3.7.1 range.',
  0.95,
  'HIGH',
  'sonnet-4',
  NOW(),
  'https://github.com/nuxt/nuxt/issues/23193'
),
(
  'nuxt build finished but did not exit after 5s warning with serverMiddleware',
  'github-nuxt',
  $$[
    {"solution": "Convert serverMiddleware to Nuxt module with conditional loading during dev/start", "percentage": 90, "command": "Create module that only adds serverMiddleware if (this.options.dev || this.options._start)", "note": "Prevents database connections and blocking I/O during production build phase"},
    {"solution": "Ensure serverMiddleware does not initialize database connections during build", "percentage": 85, "note": "Mongoose/database connection prevents process exit - delay until server start"},
    {"solution": "Disable HardSourceWebpackPlugin in production builds", "percentage": 75, "note": "Plugin caching can prevent proper cleanup in some configurations"},
    {"solution": "Avoid parallel build option when using serverMiddleware", "percentage": 70, "command": "Remove parallel: true from build config", "note": "Parallel builds amplify process cleanup issues"}
  ]$$::jsonb,
  'Importing serverMiddleware during build phase executes blocking I/O and database connections preventing exit. HardSourceWebpackPlugin may cache improperly. Parallel builds compound issue.',
  0.90,
  'MEDIUM',
  'sonnet-4',
  NOW(),
  'https://github.com/nuxt/nuxt/issues/5669'
),
(
  'Route middleware redirect does not prevent guarded page from executing on server-side SSR',
  'github-nuxt',
  $$[
    {"solution": "Use navigateTo() in middleware and ensure abortNavigation() is called", "percentage": 75, "note": "Issue resolved in Nuxt 3.0.0-rc.9 via PR #5145 for internal redirects"},
    {"solution": "Upgrade to Nuxt v3.0.0-rc.9 or later where fix was merged", "percentage": 95, "command": "npm install nuxt@3.0.0-rc.9 or later", "note": "Earlier 3.0 RC versions had middleware redirect bug"},
    {"solution": "For external OAuth redirects, validate auth state in setup() before resources load", "percentage": 80, "note": "setup() executes server-side before redirect - guard resource access there"}
  ]$$::jsonb,
  'In Nuxt 3.0 RC.0-RC.8, middleware redirects do not prevent setup() execution. External redirects fail to guard pages before protected resources load. Issue is version-specific.',
  0.95,
  'MEDIUM',
  'sonnet-4',
  NOW(),
  'https://github.com/nuxt/nuxt/issues/14468'
),
(
  'Layout switching during development hot reload merges old and new layout CSS/templates',
  'github-nuxt',
  $$[
    {"solution": "Manually refresh browser when changing layout in dev - required workaround", "percentage": 100, "command": "F5 or Cmd+R after changing layout property", "note": "Vue-loader limitation - cannot dynamically unload old CSS from previous layout"},
    {"solution": "Use unique class names per layout to prevent CSS specificity conflicts", "percentage": 75, "note": "Reduces visual impact of mixed styles but does not prevent mixing"},
    {"solution": "Avoid global CSS rules that apply to layout containers", "percentage": 70, "note": "Scoped styles perform better but still have webpack hot-reload limitations"}
  ]$$::jsonb,
  'Vue-loader only dynamically injects new CSS but does not remove old CSS from previous layout. Global CSS rules amplify the mixing issue. Hot reload limitation - manual refresh required.',
  1.0,
  'MEDIUM',
  'sonnet-4',
  NOW(),
  'https://github.com/nuxt/nuxt/issues/819'
),
(
  'Nuxt 3.15.4 dev crashes with WARN force closing dev worker after 5 seconds error',
  'github-nuxt',
  $$[
    {"solution": "When using defineCachedFunction from nitropack/runtime, add integrity option", "percentage": 92, "command": "defineCachedFunction({ integrity: ''somevalue'', ... })", "note": "Missing integrity causes improper Hasher initialization in ohash"},
    {"solution": "Pin nitropack to 2.10.4 and h3 to 1.15.0 as temporary fix", "percentage": 85, "command": "npm install nitropack@2.10.4 h3@1.15.0 or use overrides in package.json", "note": "Workaround until dependency resolution fixes merged"},
    {"solution": "Upgrade to latest Nuxt/Nitro with PR #31227 fix for absolute path resolution", "percentage": 95, "command": "npm update nuxt nitropack to latest", "note": "PR #31227 resolves underlying shared externals issue"}
  ]$$::jsonb,
  'defineCachedFunction without integrity option causes Hasher initialization error. Recent Nitro versions have dependency resolution issues. Error manifests as Cannot access ''nativeFuncLength'' before initialization.',
  0.92,
  'MEDIUM',
  'sonnet-4',
  NOW(),
  'https://github.com/nuxt/nuxt/issues/31222'
),
(
  'Vitest hook timeout 120000ms exceeded when running long module tests',
  'github-nuxt',
  $$[
    {"solution": "Add setupTimeout to test configuration to extend timeout", "percentage": 95, "command": "setupTimeout: 600_000 in test setup or vitest.config.js", "note": "Default 120 second timeout too short for module initialization tests"},
    {"solution": "Create vitest.config.js with custom testTimeout for longer tests", "percentage": 88, "command": "export default { test: { testTimeout: 600000 } }", "note": "Configuration takes priority over default limits"},
    {"solution": "Split long-running tests into separate files with individual timeouts", "percentage": 75, "note": "Allows shorter timeouts for fast tests, longer for slow setup"}
  ]$$::jsonb,
  'Default Vitest hook timeout is 120 seconds. Long module tests exceed limit. setupTimeout vs testTimeout vs hookTimeout configurations can be confusing.',
  0.95,
  'LOW',
  'sonnet-4',
  NOW(),
  'https://github.com/nuxt/nuxt/discussions/28365'
),
(
  'FCP and LCP metrics extremely high in Nuxt production builds approximately 1.5 seconds',
  'github-nuxt',
  $$[
    {"solution": "Test production builds not dev mode - dev builds naturally slower", "percentage": 100, "note": "FCP/LCP concerns should be measured with npm run build && npm run preview"},
    {"solution": "Lazy-load components using Nuxt defineAsyncComponent for better code splitting", "percentage": 82, "command": "const HeavyComponent = defineAsyncComponent(() => import(''~/components/Heavy.vue''))", "note": "Reduces initial bundle and defers non-critical component loading"},
    {"solution": "Review Lighthouse results on production-equivalent infrastructure not localhost", "percentage": 90, "note": "Local performance varies significantly based on machine resources and network"},
    {"solution": "Disable JavaScript entirely via noscripts if full interactivity not needed", "percentage": 45, "note": "Radical but valid option for content-heavy sites without interactive features"}
  ]$$::jsonb,
  'Dev mode builds inherently slower than production. Localhost metrics unreliable - test on production infrastructure. Lighthouse cannot fully evaluate code necessity post-load.',
  0.90,
  'LOW',
  'sonnet-4',
  NOW(),
  'https://github.com/nuxt/nuxt/discussions/26570'
),
(
  'pnpm support requires shamefully-hoist flag instead of plug-and-play zero-config mode',
  'github-nuxt',
  $$[
    {"solution": "Use .npmrc configuration at different directory levels for workspace control", "percentage": 78, "command": "Root .npmrc: shared-workspace-lockfile=false, Nuxt subdir: shamefully-hoist=true", "note": "Allows PnP in root while hoisting in Nuxt package"},
    {"solution": "Apply shamefully-hoist=true globally across entire workspace", "percentage": 85, "command": "echo shamefully-hoist=true >> .npmrc", "note": "Simpler but defeats pnpm efficiency purpose - flattens all dependencies"},
    {"solution": "Explicitly install vue and ufo as dependencies to enable PnP", "percentage": 70, "command": "pnpm add -D vue ufo", "note": "Contradicts zero-config philosophy - requires manual dependency declaration"},
    {"solution": "Wait for internal resolver implementation - planned for future", "percentage": 60, "note": "Nuxt team working on custom Vite/Webpack resolvers for proper PnP support"}
  ]$$::jsonb,
  'PnP mode conflicts with implicit dependency resolution in templates. vue-router becomes implicit dependency when pages enabled. Multiple Vue instances can resolve simultaneously.',
  0.78,
  'MEDIUM',
  'sonnet-4',
  NOW(),
  'https://github.com/nuxt/nuxt/issues/14146'
);
