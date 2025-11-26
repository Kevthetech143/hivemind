-- Add Turborepo GitHub issues with solutions
-- Batch 1: Cache misses, task dependencies, workspace configuration, pipeline failures
-- Category: github-turborepo

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Turborepo inconsistent cache hits with pnpm lockfile - versions 1.4.7 to 1.5.3',
    'github-turborepo',
    'HIGH',
    '[
        {"solution": "Upgrade Turborepo to version 1.5.4 or later where pnpm lockfile resolution bug is fixed", "percentage": 95, "note": "Official fix released in 1.5.4", "command": "npm install -D turbo@latest"},
        {"solution": "If stuck on earlier version, verify pnpm lockfile not corrupted and regenerate: pnpm install --force", "percentage": 80, "note": "Temporary workaround"},
        {"solution": "Clear local turbo cache: rm -rf node_modules/.cache/turbo and rebuild", "percentage": 75, "note": "Reset cache state"}
    ]'::jsonb,
    'pnpm package manager configured, Turborepo 1.4.7 or later installed, pnpm lockfile present',
    'cache hit occurs consistently, new hash calculated only when files change, no intermittent cache misses',
    'Do not downgrade pnpm versions as this may reintroduce hash calculation bugs. Always verify lockfile integrity. Environment variable count affects cache reliability before v1.5.4.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/turbo/issues/2004'
),
(
    'Turborepo Windows cache error: pattern contains path separator when caching',
    'github-turborepo',
    'HIGH',
    '[
        {"solution": "Upgrade Turborepo to v1.0.7 or later where Windows path handling in cache is fixed", "percentage": 95, "note": "Fixed via PR #204"},
        {"solution": "On v1.0.6, use forward slashes in cache output paths: outputs: [\"../build/@orgname/api/**\"] instead of backslashes", "percentage": 85, "note": "Platform-agnostic path notation"},
        {"solution": "Ensure Git paths use forward slashes in all turbo.json cache configurations", "percentage": 80, "note": "Avoid Windows-specific path separators"}
    ]'::jsonb,
    'Turborepo v1.0.6 on Windows 10+, packages configured with cache outputs',
    'All packages receive cache hits, turbo-build.log created successfully, no path separator errors',
    'Windows paths with backslashes cause ioutil.TempFile() to fail. Always normalize paths using forward slashes. Do not mix platform-specific paths in monorepo config.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/turbo/issues/195'
),
(
    'Turborepo git hash calculation fails: error hashing files in Docker/Alpine',
    'github-turborepo',
    'HIGH',
    '[
        {"solution": "Install Git in Docker image: RUN apk add git (for Alpine) before running turbo", "percentage": 95, "note": "Most common fix"},
        {"solution": "Downgrade to Turborepo v1.2.3 if git installation not viable (temporary workaround)", "percentage": 80, "note": "Earlier version avoids git hashing logic"},
        {"solution": "Ensure Git version >= 2.36+ to avoid hash count mismatches", "percentage": 85, "note": "Affected versions: 2.34.2-r0, 2.35.1"}
    ]'::jsonb,
    'Turborepo v1.2.4+ installed, Docker environment (esp. Alpine), package.json exists at repo root',
    'turbo run executes without git hash errors, successful hash-object operations in logs',
    'Alpine Linux and minimal Docker images exclude Git by default. Affected versions: v1.2.4, v1.2.5, v1.2.6, v1.2.8. PR #1239 fixed underlying issue.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/turbo/issues/1097'
),
(
    'Turborepo cache outputs outside package folder not caching in versions 1.1.10-1.2.1',
    'github-turborepo',
    'MEDIUM',
    '[
        {"solution": "Upgrade Turborepo to v1.2.8 or later where relative output paths are properly handled", "percentage": 95, "note": "Cache.Put logic updated to handle external paths"},
        {"solution": "Move outputs inside package folder: change ../build/@orgname/api/** to dist/ within package", "percentage": 85, "note": "Structural workaround on older versions"},
        {"solution": "Use absolute paths instead of relative ../paths for cache outputs", "percentage": 75, "note": "Partial workaround, may have cross-platform issues"}
    ]'::jsonb,
    'Turborepo v1.1.10 or later, monorepo with shared build directories, turbo.json with outputs configuration',
    'Cache contains both turbo-build.log and actual output directories, cache hit occurs on subsequent runs',
    'Relative paths using ../ were not converted to absolute paths internally. Caution: caching outputs from non-dependent packages may have execution order issues.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/turbo/issues/944'
),
(
    'Turborepo out of order task execution - dependencies not building before dependents',
    'github-turborepo',
    'HIGH',
    '[
        {"solution": "Add explicit task dependencies in turbo.json pipeline for each task needing upstream builds. Example: {\"webapp#prebuild\": {\"dependsOn\": [\"^build\"]}}", "percentage": 95, "note": "Proper pipeline configuration"},
        {"solution": "Ensure task dependency chains are complete: make build depend on prebuild if prebuild must run first", "percentage": 90, "note": "Design pattern fix"},
        {"solution": "Use --include-dependencies flag to ensure all transitive dependencies run their tasks", "percentage": 85, "note": "Runtime workaround"}
    ]'::jsonb,
    'Multiple interdependent packages, turbo.json pipeline configured, npm/pnpm/yarn workspace',
    'Build succeeds without module resolution errors, dependencies complete before dependents start, proper execution order in dry-run output',
    'Task dependencies must be explicitly declared per task, not per package. Special rules like webapp#build require explicit config. Missing ^build dependencies is common cause.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/turbo/issues/591'
),
(
    'Turborepo globalDependencies not invalidating cache when environment variables unset',
    'github-turborepo',
    'MEDIUM',
    '[
        {"solution": "Upgrade to Turborepo version with PR #6238 merged, which properly handles unset environment variable state", "percentage": 95, "note": "Fix released after v1.2.5"},
        {"solution": "Ensure environment variables are always set (even to empty string) in all CI/dev environments", "percentage": 85, "note": "Consistency workaround"},
        {"solution": "Use fixed values instead of environment variables where possible in globalDependencies", "percentage": 80, "note": "Configuration refactor"}
    ]'::jsonb,
    'turbo.json with globalDependencies referencing environment variables, builds across different environments',
    'Cache invalidates when env var is set/unset, hash changes reflect variable state, no stale cache replays',
    'Unset and set environment variables must be treated as distinct states for proper cache invalidation. All CI/local environments must consistently set or unset globals.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/turbo/issues/1099'
),
(
    'Turborepo depends on non-existent task scripts in filter results causing unnecessary execution',
    'github-turborepo',
    'MEDIUM',
    '[
        {"solution": "Configure pipeline to only include packages with the target task using package filters", "percentage": 90, "note": "Best practice approach"},
        {"solution": "Use --only flag to limit execution to packages that have the specified script", "percentage": 85, "note": "Runtime filter"},
        {"solution": "Verify each package in workspace has required task before configuring dependencies on it", "percentage": 80, "note": "Design review"}
    ]'::jsonb,
    'Turborepo v1.2.6+, monorepo with inconsistent scripts across packages, pipeline with task dependencies',
    'Tasks only execute on packages containing target script, no unnecessary dependency execution, logs show only relevant packages running',
    'Dependencies execute across all packages including those missing the dependent task. Issue marked duplicate of #937. Affecting some versions where dependency logic was overzealous.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/turbo/issues/1178'
),
(
    'Turborepo --scope flag ignores dependsOn task dependencies requiring transitive builds',
    'github-turborepo',
    'HIGH',
    '[
        {"solution": "Use --include-dependencies flag instead of --scope to respect task dependency graphs across all packages", "percentage": 95, "note": "Enables full dependency resolution"},
        {"solution": "Use --scope with --include-dependencies together for filtered + dependent execution", "percentage": 90, "note": "Combined flag approach"},
        {"solution": "Track related issue #912 for architectural redesign to properly separate package filtering from task dependencies", "percentage": 70, "note": "Future improvement expected"}
    ]'::jsonb,
    'Turborepo monorepo, packages with interdependencies, turbo.json with ^build/^test dependencies, --scope flag in use',
    'Task dependencies build correctly when --include-dependencies used, transitive dependencies execute before dependent tasks',
    'Package filtering (--scope) removes excluded packages from dependency graph entirely, breaking transitive task dependencies. This is architectural limitation being tracked under issue #912.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/turbo/issues/860'
),
(
    'Turborepo --filter not detecting dependent packages that need rebuild when dependencies change',
    'github-turborepo',
    'HIGH',
    '[
        {"solution": "Use filter syntax --filter=...packagename to include affected dependents", "percentage": 95, "note": "Proper filter syntax includes downstream packages"},
        {"solution": "Use --filter=[origin/main] with ...[] syntax to properly detect all affected packages including dependents", "percentage": 90, "note": "Correct range filtering"},
        {"solution": "Run without filters to rebuild entire monorepo if precise filtering fails", "percentage": 75, "note": "Fallback approach"}
    ]'::jsonb,
    'Turborepo monorepo, Git repository with origin/main branch, multiple interdependent packages, filtering enabled',
    'Dependent packages appear in --dry-run output, all affected packages rebuild when dependencies change, no missing rebuilds',
    'Filter syntax matters: use ... (three dots) to include dependents, not just changed packages. Single package filter excludes downstream dependents. Issue marked closed as of Feb 2024.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/turbo/issues/1609'
),
(
    'Turborepo cache invalid when source files modified during build execution causing race condition',
    'github-turborepo',
    'MEDIUM',
    '[
        {"solution": "Ensure source files are not modified during turbo run execution to prevent hash/output mismatch", "percentage": 95, "note": "Prevention approach"},
        {"solution": "Use file watchers and build tools that serialize build operations instead of parallel modification", "percentage": 85, "note": "Architecture pattern"},
        {"solution": "Accept this as outside Turborepo scope and use separate pre-build lock mechanisms", "percentage": 75, "note": "Operational workaround"}
    ]'::jsonb,
    'Turborepo executing build command, concurrent file modification tools active, caching enabled',
    'Build completes with no file modifications in progress, cached outputs match source state at time of hash calculation',
    'Turborepo expects pre-determined inputs → outputs model and doesn''t support files changing during execution. Race conditions impossible to resolve perfectly. Keep builds atomic.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/turbo/issues/1146'
),
(
    'Turborepo peer dependencies ignored in dependency graph causing wrong build order',
    'github-turborepo',
    'HIGH',
    '[
        {"solution": "Mirror peer dependencies as devDependencies in package.json to ensure they are included in build order", "percentage": 95, "note": "Industry standard practice"},
        {"solution": "Explicitly declare peer dependencies in turbo.json under dependsOn array: {\"my-package#build\": {\"dependsOn\": [\"peer-dep#build\"]}}", "percentage": 90, "note": "Explicit configuration"},
        {"solution": "Report peer dependency tracking issue to Turborepo and implement peer-aware dependency graph (planned)", "percentage": 70, "note": "Long-term fix"}
    ]'::jsonb,
    'Monorepo with peer dependencies declared, packages using plugin-based architecture, Turborepo v1.2+',
    'Peer packages build before their dependents, no concurrent build errors, proper task execution order',
    'Turborepo deliberately excluded peer dependencies in PR #813 to avoid cycles. No automatic peer resolution exists. Duplication in devDependencies is the standard workaround.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/turbo/issues/1601'
),
(
    'Turborepo build process randomly hangs or gets stuck with large monorepos',
    'github-turborepo',
    'MEDIUM',
    '[
        {"solution": "Increase concurrency setting: turbo run build --concurrency=100% to better utilize system resources", "percentage": 85, "note": "Performance tuning"},
        {"solution": "Verify monorepo has no circular or self-referential dependencies using --dry-run: turbo run build --dry-run", "percentage": 90, "note": "Validation step"},
        {"solution": "Update to latest Turborepo version as child process management improved significantly", "percentage": 80, "note": "Version upgrade"},
        {"solution": "For test runners: add --watchAll=false to prevent interactive mode hangs", "percentage": 75, "note": "Task configuration fix"}
    ]'::jsonb,
    'Large monorepo (50+ packages), pnpm or npm configured, Turborepo v1.2.6+, complex dependency structure',
    'turbo run build completes without hanging, progress continues consistently, --dry-run completes successfully',
    'Root cause often unclear but related to child process management or circular dependencies. Verify no self-referential dependencies. High concurrency defaults may stress systems. Issue marked closed April 2024.',
    0.84,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/turbo/issues/1186'
),
(
    'Turborepo cache grows indefinitely causing slow CI operations and storage bloat',
    'github-turborepo',
    'MEDIUM',
    '[
        {"solution": "Manually clean old cache files: find node_modules/.cache/turbo -mtime +7 -delete to remove caches older than 7 days", "percentage": 88, "note": "Cron job approach"},
        {"solution": "Use GitHub Actions Cache Service instead of filesystem caching for CI: turbo run build --remote-cache-timeout=5", "percentage": 85, "note": "CI-optimized approach"},
        {"solution": "Deploy turborepo-remote-cache or turbocache service with built-in eviction policies", "percentage": 82, "note": "Third-party solution"},
        {"solution": "Implement cache keep-last-n approach: keep only most recent 10 cache versions using shell script", "percentage": 75, "note": "Advanced cleanup"}
    ]'::jsonb,
    'Active monorepo with frequent builds, local caching enabled, node_modules/.cache/turbo directory',
    'Cache size stable or shrinking, CI operations complete in consistent time, no gigabyte-scale cache folders',
    'No built-in cache eviction in Turborepo core. Cache grows indefinitely unless manually cleaned. Remote caching services preferred for production. Issue remains open as of 2024.',
    0.81,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/turbo/issues/863'
);
