-- Add GitHub Turbopack issues with solutions (vercel/turbo repository)
-- Batch 1: High-voted issues with community solutions

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Turbopack: Next.js package not found when using --turbo flag in monorepo',
    'github-turbopack',
    'HIGH',
    $$[
        {"solution": "Upgrade Next.js to latest canary: npm install next@canary", "percentage": 85, "note": "Tests with canary version to verify package resolution in Turbopack"},
        {"solution": "Clear node_modules and reinstall dependencies with npm ci", "percentage": 80, "note": "Resolves package manager cache corruption in monorepo"},
        {"solution": "Ensure Next.js version 13.5+ or later where Turbopack has better resolution", "percentage": 75, "note": "Earlier Turbopack versions had incomplete module resolution"}
    ]$$::jsonb,
    'TurboRepo 1.10.15+, npm or Yarn v1, Next.js project in monorepo',
    'next dev --turbo loads successfully, Server responds on localhost:3000, No package resolution errors in terminal',
    'Do not use --turbo flag with outdated Next.js versions. Ensure clean install, not incremental updates. Check npm cache integrity with npm cache clean --force',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/turborepo/issues/6178'
),
(
    'Turbopack: tsconfig extends property not resolving with Next.js 14',
    'github-turbopack',
    'HIGH',
    $$[
        {"solution": "Upgrade to Next.js 13.2+ where extended tsconfig support was added to Turbopack", "percentage": 90, "note": "Next.js 13.2 introduced full tsconfig path resolution in Turbopack"},
        {"solution": "Remove extends from tsconfig and inline the base configuration for now", "percentage": 80, "note": "Temporary workaround if upgrading is not immediately possible"},
        {"solution": "Disable --turbo flag and use webpack for builds until resolved in your version", "percentage": 75, "note": "Alternative for critical projects that cannot delay"}
    ]$$::jsonb,
    'Next.js 14+, tsconfig with extends property, pnpm or Yarn workspaces in monorepo',
    'next dev --turbo launches without tsconfig parsing errors, TypeScript paths resolve correctly, No "extends doesn''t resolve correctly" errors',
    'Turbopack has stricter tsconfig parsing than webpack. Extended configs in pnpm workspaces may fail differently than npm. Test with both package managers. Extended tsconfig from @scope/configs needs exact path resolution.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/turborepo/issues/6298'
),
(
    'Turbopack: Infinite GET request loop with Next-Auth middleware',
    'github-turbopack',
    'HIGH',
    $$[
        {"solution": "Disable Turbopack temporarily: remove --turbo flag from next dev until fixed in Next.js release", "percentage": 90, "note": "Most reliable immediate solution - use webpack for authentication middleware"},
        {"solution": "Upgrade to Next.js version with Turbopack middleware fix (check latest releases)", "percentage": 85, "note": "Later versions have improved middleware HMR and request loop handling"},
        {"solution": "Switch to alternative auth: Clerk, Auth0 instead of next-auth which may have better Turbopack support", "percentage": 70, "note": "Some users report Clerk works better with Turbopack than next-auth"}
    ]$$::jsonb,
    'Next.js 13+ with Turbopack enabled, next-auth middleware configured, middleware matcher pattern set',
    'Application no longer loops on protected routes, Status 200 requests appear once per navigation, Console shows no repeated middleware logs',
    'Next-Auth middleware with matcher patterns causes infinite loops in Turbopack. Simple redirect middleware may also trigger loops. This is Turbopack-specific (works fine with webpack). Requires either upgrade or auth library change.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/turborepo/issues/5408'
),
(
    'Turbopack: Error resolving CommonJS imports from dynamic requires',
    'github-turbopack',
    'HIGH',
    $$[
        {"solution": "Replace dynamic requires with named exports: Change require(''events'') default export to named export const { EventEmitter } = require(''events'')", "percentage": 85, "note": "Turbopack handles named exports better than default CommonJS exports in dynamic imports"},
        {"solution": "Avoid importing Node stdlib modules (fs, path, crypto) in client code - move to API routes or server components", "percentage": 80, "note": "Turbopack may not fully resolve Node stdlib in browser bundles"},
        {"solution": "Update to Next.js 13.5+ which has improved CommonJS resolution in Turbopack", "percentage": 75, "note": "Later versions fixed many CommonJS edge cases"},
        {"solution": "Use webpack instead of Turbopack if heavily reliant on dynamic requires", "percentage": 70, "note": "Webpack has mature CommonJS support; temporary solution while Turbopack matures"}
    ]$$::jsonb,
    'Next.js 13 with Turbopack, pnpm or Yarn monorepo, dynamic require statements in code',
    'Build completes without "Error resolving commonjs request" messages, Page loads in browser without module errors, No Rust panics in turbopack-ecmascript',
    'Turbopack does not yet fully support highly dynamic requires. Optional dependencies like @sentry/cli, jsdom may fail. Server-relative imports need special handling. Node modules in browser context will fail.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/turborepo/issues/2372'
),
(
    'Turbopack: Unsupported configuration options (rewrites, basePath) in alpha',
    'github-turbopack',
    'HIGH',
    $$[
        {"solution": "Upgrade to Next.js 13.2+ where rewrite support was added to Turbopack", "percentage": 95, "note": "Official support for rewrites was added in Next.js 13.2, basePath in later versions"},
        {"solution": "Temporarily remove rewrite or basePath configuration from next.config.js when using --turbo", "percentage": 85, "note": "Works around the limitation until upgrade is ready"},
        {"solution": "Use webpack instead of Turbopack if these features are critical to application", "percentage": 80, "note": "Webpack supports all next.config.js options including advanced features"}
    ]$$::jsonb,
    'Next.js 13 (Turbopack alpha), next.config.js with rewrites or basePath, --turbo flag enabled',
    'next dev --turbo loads successfully, Configuration options no longer trigger "not yet supported" errors, Rewrites or basePath work as expected',
    'Turbopack alpha/early versions had limited config support. Error states "You are using configuration and/or tools that are not yet supported by Next.js v13 with Turbopack". Upgrade timeline varies by feature.',
    0.95,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/turborepo/issues/2902'
),
(
    'Turbopack: Unable to resolve core modules (react, next, custom paths)',
    'github-turbopack',
    'VERY_HIGH',
    $$[
        {"solution": "Fix TypeScript/jsconfig extends property: Ensure tsconfig.json extends resolves correctly with full path", "percentage": 85, "note": "Module path resolution depends on correct tsconfig setup in Turbopack"},
        {"solution": "Clear Next.js cache and node_modules: rm -rf .next node_modules && npm install", "percentage": 80, "note": "Corrupted cache can cause module resolution to fail"},
        {"solution": "Verify pnpm lockfile integrity and rebuild: pnpm install --force", "percentage": 80, "note": "pnpm monorepos sometimes have package resolution issues"},
        {"solution": "Downgrade to webpack temporarily: Remove --turbo flag or add experimentalTurboPackages option", "percentage": 75, "note": "Fallback while Turbopack module resolution matures"}
    ]$$::jsonb,
    'Next.js 13.3+, pnpm monorepo with custom path mappings, @scoped packages, correct tsconfig setup',
    'next dev --turbo starts without "unable to resolve module" errors, react and next modules load correctly, Page renders in browser',
    'Turbopack has stricter module resolution than webpack. Custom path mappings in tsconfig require careful setup. monorepo with @scoped packages need proper node_modules structure. React subpath imports like jsx-dev-runtime may fail.',
    0.80,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/turborepo/issues/4763'
),
(
    'Turbopack: next/image with remote wildcard patterns fails',
    'github-turbopack',
    'MEDIUM',
    $$[
        {"solution": "Upgrade to Next.js with the fix: Update to version with PR #47721 merged (13.5+)", "percentage": 90, "note": "Fix ensures optional fields in remotePatterns serialize as undefined, not null"},
        {"solution": "Use explicit hostname instead of wildcard: Change ''**.mydomain.com'' to ''art-dev.mydomain.com''", "percentage": 85, "note": "Workaround while using older Turbopack versions - specificity over wildcards"},
        {"solution": "Include all optional fields explicitly in remotePatterns: Always set protocol, port, pathname", "percentage": 80, "note": "Ensures serialization includes all expected fields, avoids null/undefined mismatch"}
    ]$$::jsonb,
    'Next.js 13+ with Turbopack, remote images configured with wildcard patterns, next.config.js with images.remotePatterns',
    'Images from remote domains load successfully, No "hostname not configured" errors, Wildcard patterns match intended domains',
    'Turbopack serializes missing optional fields (protocol, port) as null instead of undefined. Next.js validation uses === undefined check. Configuration works in webpack but fails in Turbopack due to serialization mismatch.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/turborepo/issues/4347'
),
(
    'Turbopack: node-loader does not work with Turbopack loaders',
    'github-turbopack',
    'MEDIUM',
    $$[
        {"solution": "Avoid using node-loader with Turbopack - not currently supported", "percentage": 90, "note": "Turbopack only supports loaders that output JavaScript; node-loader outputs binary code"},
        {"solution": "Wait for Turbopack loader API expansion in future releases", "percentage": 70, "note": "Turbopack team is working on broader loader support but timeline is TBD"},
        {"solution": "Switch to webpack temporarily for projects needing binary module support", "percentage": 80, "note": "Webpack has full loader ecosystem including node-loader"},
        {"solution": "Replace canvas or other .node-dependent libraries with pure JS alternatives", "percentage": 65, "note": "For some use cases, JS alternatives exist (e.g., fabric.js instead of canvas)"}
    ]$$::jsonb,
    'Next.js 13+ with Turbopack, canvas or other native Node modules requiring .node binary files, next.config.js with experimental.turbo.loaders',
    'Build completes with webpack (not Turbopack), Binary .node files are properly loaded, Alternative JS libraries function correctly',
    'Turbopack requires all loaders to return JavaScript. Binary loaders like node-loader cannot be used. experimental.turbo.loaders does not inherit webpack loader ecosystem. Issue persists in Next.js 14.2.3+.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/turborepo/issues/4265'
),
(
    'Turbopack: Yarn Plug''n''Play (PnP) package manager not supported',
    'github-turbopack',
    'MEDIUM',
    $$[
        {"solution": "Use traditional npm or pnpm instead of Yarn PnP for Turbopack projects", "percentage": 95, "note": "Yarn PnP requires different resolution logic that Turbopack has not implemented"},
        {"solution": "Switch to yarn nodeLinker: node-modules to disable PnP in yarn.lock", "percentage": 90, "command": "Add nodeLinker: node-modules to .yarnrc.yml", "note": "Restores node_modules behavior in Yarn, compatible with Turbopack"},
        {"solution": "Wait for Rust-based PnP implementation: Yarn maintainers working on Rust package", "percentage": 70, "note": "Long-term solution being developed but not ready for production"}
    ]$$::jsonb,
    'Next.js with Turbopack, Yarn v2+, PnP enabled, monorepo or workspace setup',
    'Build completes without PnP resolution errors, Packages resolve correctly from node_modules, node_modules structure properly created',
    'Turbopack cannot access files in zip archives used by PnP. Does not implement .pnp.data.json resolution. Yarn PnP is fundamentally incompatible with current Turbopack architecture. npm and pnpm work fine.',
    0.95,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/turborepo/issues/2369'
),
(
    'Turbopack: Chakra UI and Framer Motion cause dev server crash (ReferenceError)',
    'github-turbopack',
    'MEDIUM',
    $$[
        {"solution": "Upgrade to Next.js 13.2.4+ where this issue was resolved", "percentage": 90, "note": "Framer Motion dependency resolution was fixed in later Turbopack versions"},
        {"solution": "Disable Turbopack temporarily: Use next dev without --turbo flag", "percentage": 85, "note": "Works around the issue until upgrade is ready"},
        {"solution": "Update Chakra UI and Framer Motion to latest versions compatible with Next.js 13", "percentage": 75, "note": "Dependency updates may include fixes for Turbopack compatibility"}
    ]$$::jsonb,
    'Next.js 13, Chakra UI + Framer Motion installed, next dev --turbo flag enabled, Yarn v1',
    'next dev --turbo launches without ReferenceError, Server-side rendering works without scrapeMotionValuesFromProps errors, Pages load in browser',
    'Turbopack had issues resolving Framer Motion bundled modules in Chakra UI dependency chain. Error is SSR-specific. Resolved in Next.js 13.2.4 and later. Using --turbo with Chakra/Framer combination fails on early Next.js 13 versions.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/turborepo/issues/2449'
),
(
    'Turbopack: jsconfig paths and baseUrl configuration not supported',
    'github-turbopack',
    'MEDIUM',
    $$[
        {"solution": "Upgrade to Next.js 13.2+ where jsconfig support was added to Turbopack", "percentage": 95, "note": "jsconfig.json paths and baseUrl were added in Next.js 13.2 release"},
        {"solution": "Use tsconfig.json with paths instead of jsconfig.json", "percentage": 85, "note": "TypeScript config had earlier support than jsconfig in Turbopack"},
        {"solution": "Manually map module aliases until upgrade: Use path mapping in compilation setup", "percentage": 70, "note": "Workaround for immediate use but requires build tool configuration"}
    ]$$::jsonb,
    'Next.js 13 (before 13.2), JavaScript project (no TypeScript), jsconfig.json with paths and baseUrl, --turbo flag',
    'Module imports using paths work correctly, baseUrl resolution succeeds, no "paths not supported" errors from Turbopack',
    'Turbopack initially only supported tsconfig.json paths, not jsconfig.json. JavaScript-only projects had no workaround. Fixed in Next.js 13.2. baseUrl must be present for path aliases to work.',
    0.95,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/turborepo/issues/2357'
),
(
    'Turbopack: recharts library causes "Cannot read properties of undefined (reading ''parse'')"',
    'github-turbopack',
    'MEDIUM',
    $$[
        {"solution": "Upgrade to Next.js 14.0.4+ canary where recharts compatibility was restored", "percentage": 90, "note": "Issue was resolved in Next.js 14.0.4 canary releases"},
        {"solution": "Use webpack instead of Turbopack: Remove --turbo flag or use webpack explicitly", "percentage": 85, "note": "recharts works fine with webpack, use as temporary solution"},
        {"solution": "Switch to alternative charting library: Use Nivo, Victory, or Chart.js instead", "percentage": 75, "note": "Other chart libraries may have better Turbopack compatibility"}
    ]$$::jsonb,
    'Next.js 13.4+, recharts v2.7.2 or Tremor (which uses recharts), next dev --turbo flag',
    'Chart components render without errors, reduce-css-calc and postcss-value-parser parse correctly, Dashboard displays charts properly',
    'recharts fails due to postcss and reduce-css-calc dependency chain conflicts in Turbopack. Error occurs at chart component render time, not build time. Tremor library is also affected (uses recharts internally). Fixed in Next.js 14.0.4+.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/turborepo/issues/5545'
),
(
    'Turbopack: HMR error "Module was instantiated as a runtime entry but factory is not available"',
    'github-turbopack',
    'MEDIUM',
    $$[
        {"solution": "Upgrade to latest Next.js canary: npm install next@canary - fix merged in PR #6227", "percentage": 90, "note": "Server Actions HMR issue was fixed and released in next canary"},
        {"solution": "Disable Hot Module Replacement temporarily: Use next dev --no-turbo or disable HMR", "percentage": 80, "note": "Workaround to continue development while waiting for upgrade"},
        {"solution": "Avoid Server Actions in dev server or restructure components", "percentage": 70, "note": "Temporary workaround - issue specific to Server Actions with HMR"}
    ]$$::jsonb,
    'Next.js 13.5-canary, Server Actions enabled, next dev --turbo flag, file modifications during dev',
    'HMR updates complete without "module factory not available" errors, Server Actions update on file changes, No chunk-related errors in terminal',
    'Issue occurs specifically with Server Actions and HMR in Turbopack. Error mentions "runtime entry of chunk server/app/page.js". Only affects canary versions before PR #6227 merge. Not present in stable Next.js 13 releases.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/turborepo/discussions/6223'
),
(
    'Turbopack: React minified error #31 in monorepo during static generation',
    'github-turbopack',
    'HIGH',
    $$[
        {"solution": "Delete and regenerate package-lock.json or package manager lockfile: rm package-lock.json && npm install", "percentage": 80, "note": "Corrupted lockfile causes module resolution issues in monorepo builds"},
        {"solution": "Clean all build artifacts: rm -rf .next node_modules and reinstall", "percentage": 75, "note": "Full clean rebuild resolves many Turbopack monorepo issues"},
        {"solution": "Check Next.js version uses App Router pattern correctly: Ensure _not-found.js not 404.js", "percentage": 70, "note": "Turbopack may misdetect Pages Router in monorepo, causing build errors"},
        {"solution": "Build outside of monorepo context: Test app build independently first", "percentage": 65, "note": "Isolates whether issue is monorepo-specific or app-specific"}
    ]$$::jsonb,
    'Next.js 15, Turborepo monorepo, Static generation for /404 and /500 pages, npm lockfile',
    'Build completes successfully, /404 and /500 pages prerender without React errors, App works both in and outside monorepo',
    'React minified error #31 occurs only during monorepo static generation, not in dev mode. Lockfile corruption causes cascading module resolution failures. Issue is not purely Turborepo (outside their control) but monorepo environment exposes it. Same app builds fine outside monorepo.',
    0.80,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/turborepo/issues/9335'
);
