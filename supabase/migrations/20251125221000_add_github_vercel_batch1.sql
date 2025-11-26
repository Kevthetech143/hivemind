-- Add GitHub Vercel deployment/build error issues batch 1
-- Extracted from https://github.com/vercel/vercel/issues with focus on high-engagement deployment and build failures

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, source_url
) VALUES (
    'UND_ERR_CONNECT_TIMEOUT: Fetch timeout failures in Next.js serverless functions on Vercel production',
    'github-vercel',
    'HIGH',
    '[
        {"solution": "Set NODE_OPTIONS environment variable to --no-experimental-fetch in Vercel project settings to disable undici fetch client", "percentage": 70, "note": "Helps stabilize fetch requests but may impact performance"},
        {"solution": "Implement retry logic with AbortController using 2-second timeouts and exponential backoff for transient failures", "percentage": 75, "note": "Vercel support recommended approach"},
        {"solution": "Increase staticPageGenerationTimeout in next.config.js to 1000+ seconds for long-running operations", "percentage": 65, "note": "Helps for slow external API calls but increases build time"},
        {"solution": "Switch external API calls to use a middleware service or API gateway with connection pooling instead of direct fetch", "percentage": 80, "note": "Most reliable workaround but requires architecture change"}
    ]'::jsonb,
    'Next.js 13.1.6+ or 14.2.3+, Node.js v20.x, Vercel serverless functions calling external APIs',
    'External API calls complete successfully, 95%+ of requests return 200 status, Function execution logs show no timeout errors',
    'Intermittent failures (~30% failure rate) are characteristic. Disabling experimental fetch may hide actual errors. Do not assume timeout is always external API fault - check Vercel function logs. Retries alone may not fix underlying connectivity issues.',
    0.72,
    'https://github.com/vercel/vercel/issues/11692'
),
(
    'Cannot find module runtime error: Missing dependencies in serverless function after build',
    'github-vercel',
    'HIGH',
    '[
        {"solution": "Update @vercel/nft to v0.27.0+ which adds support for import assertions parsing", "percentage": 95, "note": "Official fix in PR #11580"},
        {"solution": "Explicitly import remote.js or problematic modules in entry point to ensure they are included in dependency graph", "percentage": 85, "note": "Workaround for older @vercel/nft versions"},
        {"solution": "Verify all imports use standard syntax - avoid conditional imports or dynamic requires that confuse dependency scanner", "percentage": 80, "note": "Prevention measure for future deployments"}
    ]'::jsonb,
    'Vercel CLI v34.2+, Project with dependencies using import assertions, @google-labs/breadboard or similar packages',
    'vercel build completes without errors, All required modules appear in .vercel/output/functions/*/node_modules, Runtime request to function succeeds with 200 status',
    'Dependencies disappear during build despite existing locally - this is a scanner issue, not missing packages. Import assertions in nested dependencies can cause incomplete dependency graphs. Update @vercel/nft is the primary fix.',
    0.93,
    'https://github.com/vercel/vercel/issues/11533'
),
(
    'Serverless functions crash with module not found: Cannot find module during Vercel CLI v32.3.0 deployment',
    'github-vercel',
    'MEDIUM',
    '[
        {"solution": "Upgrade Vercel CLI from v32.3.0 to v32.3.1 or later which fixes the module loading bug", "percentage": 98, "note": "Official fix released in patch version"},
        {"solution": "Temporarily downgrade to vercel@32.2.5 by setting VERCEL_CLI_VERSION environment variable until upgrade", "percentage": 85, "note": "Temporary workaround, remove after upgrading"},
        {"solution": "Redeploy project after upgrading CLI to force rebuild with correct module loading", "percentage": 90, "note": "Required action after fix is applied"}
    ]'::jsonb,
    'Vercel CLI v32.3.0, Next.js 13.4.3-13.5.1, Project with react-dom or similar packages with exports field',
    'Deployment completes without errors, Server-side rendered pages return 200 status, Runtime errors mention correct modules, Function invocation succeeds without module not found',
    'Bug was introduced in single PR (#10553) affecting only v32.3.0. Error message "Package subpath \'./server.edge\' is not defined by exports" is the signature. This only affected SSR, client-side navigation worked. Always upgrade CLI immediately after release.',
    0.97,
    'https://github.com/vercel/vercel/issues/10564'
),
(
    'Monorepo preBuilds deployment fails in Vercel CLI v33.3.0: .next directory validation error',
    'github-vercel',
    'MEDIUM',
    '[
        {"solution": "Downgrade Vercel CLI to v33.2.0 which does not have the file validation bug", "percentage": 90, "note": "Temporary solution until upgrade available"},
        {"solution": "Pin Vercel CLI version in package.json devDependencies to avoid automatic updates to v33.3.0", "percentage": 85, "note": "Prevents future CI/CD deployments from failing"},
        {"solution": "Run vercel deploy with --prebuilt flag and build artifacts already generated in .next directory", "percentage": 80, "note": "Ensure .next directory exists locally before deployment"}
    ]'::jsonb,
    'Vercel CLI v33.3.0, Monorepo with pnpm/turborepo, --prebuilt flag usage, Pre-built artifacts in .next directory',
    'Deployment completes successfully, Artifacts are deployed to Vercel infrastructure, Application serves requests correctly on preview/production',
    'v33.3.0 introduced file path validation that incorrectly assumes .next exists for prebuilt deployments. This breaks CI/CD pipelines that separate build from deploy phases. Downgrading to v33.2.0 is recommended temporary measure.',
    0.88,
    'https://github.com/vercel/vercel/issues/11097'
),
(
    'Deployment error: Build fails when Vercel build passes locally but fails when pushing',
    'github-vercel',
    'MEDIUM',
    '[
        {"solution": "Check for environment variable differences - set environment variables in Vercel project settings that are available locally", "percentage": 85, "note": "Most common cause of local pass / remote fail"},
        {"solution": "Test Turbo cache behavior with TURBO_FORCE=1 environment variable to bypass cache during build", "percentage": 80, "note": "Helps identify cache-related issues"},
        {"solution": "Review build logs for esbuild plugin errors - ensure all MDX or content processing dependencies are installed", "percentage": 75, "note": "Content-collections build failures often affect edge cases"},
        {"solution": "Sync Node.js versions between local development and Vercel build environment", "percentage": 70, "note": "Version mismatches cause subtle build failures"}
    ]'::jsonb,
    'Vercel project with esbuild plugins, MDX or content-collections, Local build that succeeds, Push to Vercel that fails',
    'Vercel build logs show successful completion, Deployment URL is accessible, All pages render without esbuild errors',
    'Discrepancy between local and remote builds usually stems from environment variables, cache state, or file processing plugins. Local .env files are not available in Vercel. MDX with special characters like Mermaid diagrams can trigger esbuild failures.',
    0.68,
    'https://github.com/vercel/vercel/issues/13216'
),
(
    'Monorepo build fails on first deployment with Module not found: Cannot resolve workspace package',
    'github-vercel',
    'HIGH',
    '[
        {"solution": "On second deployment (manual redeploy), the build succeeds because Turbo cache is now populated - analyze cache usage in Turbo logs", "percentage": 80, "note": "Indicates cache bypass issue on first run"},
        {"solution": "Verify pnpm-lock.yaml includes all workspace packages and their dependencies explicitly", "percentage": 85, "note": "Lock file must be complete and committed"},
        {"solution": "Check Turbo pipeline configuration - ensure dependsOn fields include all required workspace dependencies", "percentage": 90, "note": "Configuration error is primary cause"},
        {"solution": "Use pnpm install locally and verify same packages appear in node_modules before committing", "percentage": 75, "note": "Ensure reproducible build environment"}
    ]'::jsonb,
    'Turborepo with pnpm, Monorepo with 10+ workspace packages, pnpm 8+, Build succeeds on manual redeploy',
    'First deployment completes without errors, All workspace packages resolve correctly, Build logs show no module resolution errors on first attempt',
    'First deployment failure despite successful redeploy indicates incomplete Turbo cache or missing lock file entries. Do not assume pnpm-lock.yaml is complete - run pnpm install locally to verify. Cache bypass on subsequent runs can mask configuration issues.',
    0.72,
    'https://github.com/vercel/vercel/issues/10996'
),
(
    'Deployment error: "Error! Your deployment failed. Please retry later" with no detailed error information',
    'github-vercel',
    'MEDIUM',
    '[
        {"solution": "Check deployment size - remove large assets (images >50MB, videos) and use CDN services like Cloudinary or AWS S3 instead", "percentage": 90, "note": "Vercel enforces deployment size limits"},
        {"solution": "Verify Node.js version compatibility - set engines field in package.json to Node version available on Vercel", "percentage": 85, "note": "Version mismatch causes silent failures"},
        {"solution": "Check build logs for SIGKILL errors indicating memory exhaustion - optimize dependency tree and reduce bundle size", "percentage": 80, "note": "Memory limits trigger generic error"},
        {"solution": "Review framework dependencies - pin compatible versions and avoid latest tag for framework packages", "percentage": 75, "note": "Incompatible dependencies cause build failures with generic message"}
    ]'::jsonb,
    'Vercel project with large assets or heavy dependencies, Node.js version specified in package.json, Project with 1000+ files in deployment',
    'Deployment completes successfully, Build logs show no memory warnings or SIGKILL events, Application serves without 500 errors',
    'Generic error message hides multiple possible root causes: size limits (5 GB max), incompatible framework versions, memory exhaustion. Always check full build logs, not just deployment summary. Large files must be stored externally.',
    0.65,
    'https://github.com/vercel/vercel/issues/2778'
),
(
    'Edge Functions deployment error: Edge functions misidentified as Serverless Functions after Rollup bundling',
    'github-vercel',
    'MEDIUM',
    '[
        {"solution": "Avoid bundling edge functions with Rollup - import external modules directly instead of bundling them", "percentage": 85, "note": "Best practice for edge functions"},
        {"solution": "Use external config file (vercel.json) to explicitly specify runtime instead of relying on export const config detection", "percentage": 80, "note": "Resilient to code transformations"},
        {"solution": "If bundling is required, preserve export const config statement - do not allow Rollup to optimize or inline it", "percentage": 70, "note": "Workaround but limits bundler optimizations"}
    ]'::jsonb,
    'Edge function code bundled with Rollup, External module imports in edge function, export const config { runtime: \'experimental-edge\' }',
    'Deployment shows function marked as Edge Runtime, Function executes on edge infrastructure, Response latency indicates edge execution (<100ms)',
    'Rollup transformations remove or rename export const config, breaking Vercel detection. Detection relies on exact export statement - optimization or inlining breaks it. External config file approach more resilient than code-based detection.',
    0.62,
    'https://github.com/vercel/vercel/issues/8678'
),
(
    'Edge function upload error: "We could not upload the edge function temporarily. Please try again later"',
    'github-vercel',
    'LOW',
    '[
        {"solution": "Wait for Vercel infrastructure issue to resolve - check vercel-status.com for incident status", "percentage": 85, "note": "Service outage, not code issue"},
        {"solution": "Retry deployment after 5-10 minutes once Vercel infrastructure recovers", "percentage": 90, "note": "Transient service issue"},
        {"solution": "Monitor Vercel status page (@vercelstatus on Twitter) for infrastructure incident updates", "percentage": 80, "note": "Get notified when service is restored"}
    ]'::jsonb,
    'Vercel edge function deployment, Valid build output, Network connectivity',
    'Deployment completes with 200 status, Function is accessible at edge location, Response from edge function returns expected data',
    'This error indicates Vercel infrastructure issue, not code problem. Build completes successfully - failure is during upload phase. Do not retry immediately - wait for service recovery. Multiple simultaneous deployments during outage may worsen issue.',
    0.58,
    'https://github.com/vercel/vercel/issues/10793'
),
(
    'Monorepo deployment fails with ENOSPC: no space left on device during npm/yarn install',
    'github-vercel',
    'MEDIUM',
    '[
        {"solution": "Switch from yarn to npm in monorepo - yarn caches dependencies doubling disk usage during install", "percentage": 90, "note": "Eliminates caching overhead"},
        {"solution": "Use npm with --prefer-offline flag to avoid reinstalling duplicate packages", "percentage": 80, "note": "Works within Vercel 500MB limit for most projects"},
        {"solution": "Optimize dependencies - remove unused packages to reduce total node_modules size", "percentage": 75, "note": "Reduces overall deployment footprint"},
        {"solution": "Use monorepo workspace with selective dependency installation instead of installing all dependencies", "percentage": 70, "note": "Requires monorepo tool configuration"}
    ]'::jsonb,
    'Yarn workspace monorepo or yarn v2, Free Vercel plan or limited storage, Dependencies >350MB uncompressed',
    'Dependency installation completes without ENOSPC error, Vercel build logs show successful npm install, Deployment proceeds to next build phase',
    'Yarn caches all dependencies during install, effectively doubling disk usage - causes ENOSPC on Vercel 500MB free tier limit. Create React App with TypeScript alone exceeds 240MB. Switch to npm is most effective solution.',
    0.88,
    'https://github.com/vercel/vercel/issues/1664'
),
(
    'React Router edge runtime deployment fails: Routes not recognized as edge functions',
    'github-vercel',
    'MEDIUM',
    '[
        {"solution": "Update @vercel/react-router preset to latest version - ensure build manifest runtime specifications are generated correctly", "percentage": 85, "note": "Integration between preset and Vercel may have gaps"},
        {"solution": "Explicitly configure edge functions in vercel.json functions array instead of relying on preset auto-detection", "percentage": 80, "note": "Manual configuration as workaround"},
        {"solution": "Use React Router build output without preset - manually generate serverless/edge function configuration", "percentage": 70, "note": "More control but requires manual setup"}
    ]'::jsonb,
    'React Router v7.3+, @vercel/react-router preset v1.1.0+, Vercel project with edge runtime configuration',
    'Build manifest shows correct edge runtime designation, Deployment shows functions marked as Edge Runtime, Functions execute on Vercel edge network',
    'Build manifest correctly marks routes as edge (e.g., "routes/home": "edge_...") but Vercel deployment ignores runtime field. Preset integration with Vercel deployment system appears incomplete. Manual configuration more reliable.',
    0.64,
    'https://github.com/vercel/vercel/issues/13165'
),
(
    'Serverless function cold start delays: Lambda cold starts take 2-3 seconds on Vercel',
    'github-vercel',
    'MEDIUM',
    '[
        {"solution": "Reduce function bundle size by removing unused dependencies - Prisma ORM and Prettier modules account for significant overhead", "percentage": 85, "note": "Bundle size directly correlates with cold start duration"},
        {"solution": "Implement function warming strategy - issue dummy requests every 3-4 minutes to keep function warm", "percentage": 65, "note": "Reduces cold starts to <100ms but requires additional infrastructure"},
        {"solution": "Use Node.js APIs instead of bundled libraries for common operations - minimize function dependencies", "percentage": 75, "note": "Lighter functions have faster initialization"},
        {"solution": "Consider alternative platforms (DigitalOcean, AWS) if consistent <100ms latency is critical", "percentage": 60, "note": "Vercel Lambda cold starts inherent to architecture"}
    ]'::jsonb,
    'Next.js serverless function on Vercel, GraphQL/Apollo Server setup, Prisma or heavy ORM dependencies, Function inactivity >10 minutes',
    'Function responds in <500ms for warm requests, Cold start latency is 2-3 seconds (acceptable for most use cases), No function crashes or timeout errors',
    'Cold start delays are inherent to AWS Lambda on Vercel - cannot be fully eliminated. Function size (20-60MB) heavily impacts latency. Warming strategies help but are not reliable across all cases. Consider architecture alternatives for performance-critical APIs.',
    0.58,
    'https://github.com/vercel/vercel/issues/6292'
),
(
    'Monorepo build fails: packageManager field in workspace package.json is ignored by Vercel',
    'github-vercel',
    'MEDIUM',
    '[
        {"solution": "Add packageManager field to repository root package.json even if other languages are used - Vercel only checks root", "percentage": 95, "note": "Required workaround for multi-language monorepos"},
        {"solution": "Ensure Root Directory setting in Vercel project points to location where packageManager is specified", "percentage": 85, "note": "May require changing Vercel configuration"},
        {"solution": "Use package.json with packageManager at root level and maintain language-specific configs in subdirectories", "percentage": 80, "note": "Restructure for compatibility with Vercel"}
    ]'::jsonb,
    'Multi-language monorepo without root package.json, Workspace packageManager specified in ui/package.json or similar, Vercel Root Directory set to subdirectory (ui/apps/dashboard)',
    'Vercel build uses correct package manager version, Build logs confirm pnpm/yarn/npm version matches specification, Dependencies install correctly without version conflicts',
    'Vercel only checks repository root package.json for packageManager field - it does not walk up filesystem from Root Directory setting. Multi-language monorepos must add dummy package.json at root with packageManager only. This is inelegant but required.',
    0.82,
    'https://github.com/vercel/vercel/issues/10687'
),
(
    'Yarn 2 monorepo deployment fails: Next.js not detected with Yarn PnP mode on Vercel',
    'github-vercel',
    'MEDIUM',
    '[
        {"solution": "Set YARN_NODE_LINKER=node-modules environment variable in Vercel build settings to force traditional node_modules", "percentage": 95, "note": "Official Vercel workaround for Yarn 2 PnP"},
        {"solution": "Use CLI flag vc -b FORCE_BUILDER_TAG=canary during deployment to enable Yarn 2 support", "percentage": 85, "note": "Alternative approach via CLI"},
        {"solution": "Downgrade to Yarn 1 or use npm instead of Yarn 2 if possible", "percentage": 75, "note": "Avoids PnP complexity entirely"},
        {"solution": "Enable Node linker in .yarnrc.yml: nodeLinker: node-modules for Vercel builds only", "percentage": 80, "note": "Local config approach"}
    ]'::jsonb,
    'Yarn 2 Berry in PnP mode, Monorepo with Next.js, Vercel deployment, Yarn v2.0+',
    'Vercel build detects Next.js successfully, Dependencies resolve correctly with node-modules linker, Deployment completes without "Next.js version could not be detected" error',
    'Yarn 2 PnP module resolution incompatible with Vercel detection. Setting YARN_NODE_LINKER=node-modules switches to traditional node_modules during Vercel build while preserving PnP in local development. This is the standard Vercel workaround.',
    0.90,
    'https://github.com/vercel/vercel/issues/5280'
);
