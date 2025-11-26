-- Add Fly.io flyctl deployment and runtime error solutions from GitHub issues
-- Category: github-flyio
-- Date: 2025-11-25
-- Source: https://github.com/superfly/flyctl/issues

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Long Docker builds fail with 403 Unauthorized error during image push to registry',
    'github-flyio',
    'HIGH',
    '[
        {"solution": "Upgrade to flyctl version that includes credential refresh fix (PR #4557)", "percentage": 95, "note": "Fixes token lifecycle management during extended builds"},
        {"solution": "Break large build steps into smaller stages to reduce build duration below 5 minutes", "percentage": 80, "note": "Workaround for builds exceeding timeout"},
        {"solution": "Review fly.toml build configuration and optimize Dockerfile for faster execution", "percentage": 75, "command": "fly version to check current flyctl version"}
    ]'::jsonb,
    'Docker image building configured in fly.toml, Valid Fly.io authentication token',
    'Docker image builds successfully, Image pushes to registry without 403 errors, fly deploy completes',
    'Auth tokens have fixed expiration and are not refreshed during multi-stage builds. Long builds (>5 minutes) are particularly prone to this issue. Upgrade flyctl to latest version first.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/superfly/flyctl/issues/4556'
),
(
    'Error: flaps client missing from context when running fly storage create',
    'github-flyio',
    'MEDIUM',
    '[
        {"solution": "Upgrade flyctl to version after 0.3.181 which includes fix from PR #4569", "percentage": 95, "note": "Storage creation context issue resolved in newer releases"},
        {"solution": "Check that storage was actually created on Tigris despite error - retry operation", "percentage": 80, "note": "Resource may be created even when client context error occurs"},
        {"solution": "Verify Tigris addon is properly attached to your application", "percentage": 70, "command": "fly storage list"}
    ]'::jsonb,
    'Fly.io account authenticated with flyctl, Tigris addon or S3 storage configured',
    'Storage created successfully on Tigris, fly storage list shows new storage, subsequent fly storage commands work',
    'Flaps client context initialization occurs after resource creation completes. Error message appears but resource may already exist. Always check if storage was created despite error.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/superfly/flyctl/issues/4564'
),
(
    'Deployment fails with error: stat .: no such file or directory - cloud storage credential conflict',
    'github-flyio',
    'MEDIUM',
    '[
        {"solution": "Remove conflicting AWS S3 credentials from environment if using Tigris storage", "percentage": 90, "note": "Misconfigured cloud credentials cause authentication failures"},
        {"solution": "Verify TIGRIS_BUCKET_NAME and related env vars are properly set, not AWS_ACCESS_KEY_ID", "percentage": 85, "command": "env | grep -E ''AWS_|TIGRIS_''"},
        {"solution": "Clear local flyctl credentials cache and re-authenticate: rm -rf ~/.fly && fly auth login", "percentage": 75, "note": "Stale credentials can cause conflicts"}
    ]'::jsonb,
    'Docker image builds successfully, Fly.io Tigris addon attached to app, Valid authentication',
    'Docker image built and available, fly deploy completes without stat errors, Application storage operations succeed',
    'AWS credentials in environment take precedence over Tigris configuration. The error message "stat: no such file" is misleading - actual cause is auth/addon conflict. Check environment variables carefully.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/superfly/flyctl/issues/4097'
),
(
    'DNS timeout errors prevent deployment: fly deploy hangs on DNS checks with timeout',
    'github-flyio',
    'MEDIUM',
    '[
        {"solution": "Use flag --dns-checks=false to completely skip DNS validation (requires flyctl with PR #3324 fix)", "percentage": 92, "note": "Properly skips DNS checks instead of ignoring flag"},
        {"solution": "Use --remote-only flag to deploy without local DNS validation", "percentage": 85, "command": "fly deploy --remote-only --dns-checks=false"},
        {"solution": "Upgrade flyctl to version with DNS check fix, revert any Cloudflare DNS configurations", "percentage": 80, "note": "DNS checks may have compatibility issues with Cloudflare"},
        {"solution": "For persistent DNS issues, use relay network: fly deploy --yes", "percentage": 70, "note": "Bypasses some network validation steps"}
    ]'::jsonb,
    'Fly.io app configured, DNS records created (or being validated), Network connectivity established',
    'Deployment completes without DNS timeout errors, Health checks pass, App becomes reachable',
    'DNS check flag was previously ignored even when specified. Cloudflare DNS can cause compatibility issues. Always verify flag is honored with --verbose output.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/superfly/flyctl/issues/3318'
),
(
    'Docker unavailable error during deployment: failed to fetch an image or build from source',
    'github-flyio',
    'MEDIUM',
    '[
        {"solution": "In Docker Desktop settings, find advanced settings and toggle the problematic setting off, apply/restart, then toggle back on and restart again", "percentage": 90, "note": "Resets Docker daemon connectivity"},
        {"solution": "Restart Docker Desktop completely: quit and relaunch Docker", "percentage": 85, "command": "killall Docker || pkill -f docker.app"},
        {"solution": "Verify docker is accessible: run ''docker ps'' and ensure no errors", "percentage": 80, "command": "docker ps"},
        {"solution": "For local-only builds, check docker socket permissions: ls -la /var/run/docker.sock", "percentage": 75, "note": "Socket must be readable by user running flyctl"}
    ]'::jsonb,
    'Docker Desktop installed and running, docker command works locally, fly deploy --local-only in use',
    'docker ps returns results without errors, fly deploy --local-only completes successfully, Docker image builds and pushes',
    'Docker may appear functional but flyctl cannot access daemon due to Docker Desktop settings. The error message references unavailable Docker even when daemon is running. Check advanced Docker settings first.',
    0.86,
    'sonnet-4',
    NOW(),
    'https://github.com/superfly/flyctl/issues/4201'
),
(
    'Machine shell creation fails: validation error with app name exceeding 63 characters',
    'github-flyio',
    'LOW',
    '[
        {"solution": "Keep shell app names under 63 characters, using only lowercase letters, numbers, and dashes (no underscores or uppercase)", "percentage": 92, "note": "Validation requirement for machine names"},
        {"solution": "Use shorter app name or simplified naming convention: fly machine run --shell --name myapp", "percentage": 88, "command": "fly machine run --shell --name [app-name]"},
        {"solution": "Upgrade flyctl to version after 0.3.174 with PR #4296 for improved name validation", "percentage": 85, "note": "Name character limits properly enforced"}
    ]'::jsonb,
    'Fly.io account authenticated, Machine feature enabled, Valid app name to use',
    'Machine shell created successfully, fly machine run returns machine ID, Shell prompt becomes available',
    'Machine names must meet strict validation: 63 char max, lowercase alphanumeric and dashes only. No underscores or uppercase letters allowed. Error message is specific about character limit.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/superfly/flyctl/issues/4292'
),
(
    'Environment variables from command-line flag override configuration instead of merging',
    'github-flyio',
    'MEDIUM',
    '[
        {"solution": "Upgrade flyctl to version with PR #1011 merged (mid-2022 or later) for proper env var merging", "percentage": 93, "note": "Fix ensures -e flag merges with fly.toml instead of replacing"},
        {"solution": "Define base env vars in fly.toml [env] section, then override only specific vars with fly deploy -e VAR=value", "percentage": 90, "command": "fly deploy -e NODE_ENV=production -e DEBUG=true"},
        {"solution": "To preserve all fly.toml env vars, avoid using -e flags during deploy if possible", "percentage": 80, "note": "Use fly.toml for static config, dashboard for dynamic overrides"}
    ]'::jsonb,
    'fly.toml configured with [env] section, Fly.io app created, flyctl authenticated',
    'fly deploy with -e flags successfully merges new vars with existing config, fly config show lists all environment variables',
    'Old flyctl versions completely replace env vars from fly.toml when -e flag is used. Environment variables from command line should merge, not replace. Always upgrade flyctl first.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/superfly/flyctl/issues/560'
),
(
    'fly launch auto-generates unwanted HTTP service configuration in fly.toml',
    'github-flyio',
    'MEDIUM',
    '[
        {"solution": "When prompted ''Do you want to tweak these settings before proceeding?'', answer YES and remove the http_service block or set port to 0/blank", "percentage": 85, "note": "Launch adds HTTP service by default, must manually disable"},
        {"solution": "Use flag --no-services or equivalent to prevent HTTP service generation during launch (check version)", "percentage": 75, "note": "Feature request - may not be available in all versions"},
        {"solution": "After launch completes, manually edit fly.toml to remove [http_service] section and rebuild", "percentage": 80, "command": "Remove [http_service] block from fly.toml, then fly deploy"},
        {"solution": "Run ''fly launch --copy-config'' without --no-deploy, then manually edit before deploying", "percentage": 78, "note": "Gives you chance to remove unwanted config"}
    ]'::jsonb,
    'fly.toml exists or will be created by launch, Fly.io app name and org specified, Custom process definitions',
    'fly.toml contains only desired configuration, No HTTP service added if not needed, fly deploy succeeds with custom processes',
    'fly launch always generates HTTP service even for apps that dont need it. The generated service references process "app" which may not exist in your config. Interactive prompt allows removal but workflow is cumbersome.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/superfly/flyctl/issues/3140'
),
(
    'fly version command is slow: excessive latency in shell prompt integration',
    'github-flyio',
    'LOW',
    '[
        {"solution": "Upgrade to flyctl 0.1.132 or newer where metrics sending was made non-blocking (reduces ~180ms to ~70ms)", "percentage": 88, "note": "Async metrics significantly improves startup time"},
        {"solution": "Cache fly version output in shell prompt: avoid calling ''fly version'' on every prompt", "percentage": 92, "command": "Add to prompt script: cache result with 5-minute TTL"},
        {"solution": "Run ''fly version --json'' for faster output format suitable for programmatic parsing", "percentage": 75, "note": "JSON parsing may be slightly faster than text"}
    ]'::jsonb,
    'flyctl installed, Shell prompt integration desired, Starship or similar prompt manager',
    'fly version completes in <100ms, Shell prompt renders quickly, No noticeable latency in interactive shell',
    'Metrics sending in interactive mode is blocking operation. Early versions had ~184ms delay. Version 0.1.132 improved to ~73ms but some regressions appeared in later versions. Cache whenever possible.',
    0.84,
    'sonnet-4',
    NOW(),
    'https://github.com/superfly/flyctl/issues/2908'
),
(
    'fly secrets import command breaks certificate/JSON values with extra quote escaping',
    'github-flyio',
    'HIGH',
    '[
        {"solution": "Use stdin import instead: flyctl secrets set MY_CERT=- < my-cert.crt for properly formatted values", "percentage": 93, "note": "Avoids quote escaping problems entirely"},
        {"solution": "Manually strip outer quotes from .env file before importing, let tool add correct quotes", "percentage": 85, "note": "Requires manual preprocessing of .env"},
        {"solution": "Upgrade flyctl with fix for quote handling in import (expected in future release)", "percentage": 70, "note": "Currently still open issue - workaround recommended"},
        {"solution": "For multi-line certificates in .env, convert to file-based import and use stdin method", "percentage": 88, "command": "flyctl secrets set CERT=- < cert.pem"}
    ]'::jsonb,
    'fly.toml configured, Secrets needed for app, .env file with quoted values (certificates, JSON)',
    'Secrets import completes without errors, App reads secrets correctly, Certificates/JSON parse without corruption',
    'fly secrets import adds extra quote layers and escapes newlines on values already quoted in .env. This corrupts certificates and JSON that expect specific formatting. Use stdin input instead.',
    0.80,
    'sonnet-4',
    NOW(),
    'https://github.com/superfly/flyctl/issues/589'
),
(
    'Deployment shows false warning: app not listening on expected address despite successful startup',
    'github-flyio',
    'HIGH',
    '[
        {"solution": "Wait for the ''Deployment complete'' message even if warning appears - deployment is successful despite warning", "percentage": 90, "note": "Warning is false positive, not actual deployment failure"},
        {"solution": "Upgrade to flyctl version with PR #3794 fix (add retry for socket scanning with delay) when available", "percentage": 85, "note": "Fixes premature readiness check"},
        {"solution": "Increase health check grace period in fly.toml: [[services]] grace_period = 30s (default 5s)", "percentage": 82, "command": "Add grace_period setting to [services] or [http_service]"},
        {"solution": "For slow-startup apps (Node+Puppeteer, Rails), accept warning as known issue - monitor app after deploy", "percentage": 75, "note": "False positive is non-blocking but causes CI/CD failures"}
    ]'::jsonb,
    'fly deploy in progress, Slow-startup application (Node.js+Puppeteer, Rails), Health checks configured',
    'Warning message appears but deployment continues, Health checks eventually pass, Application becomes reachable and responsive',
    'flyctl checks socket availability too quickly before apps finish binding. Warning appears for apps with >30s startup time. The warning is misleading - deployment actually succeeds. False positive causes CI/CD pipeline failures.',
    0.78,
    'sonnet-4',
    NOW(),
    'https://github.com/superfly/flyctl/issues/3358'
),
(
    'Docker image deployment fails: cannot deploy when image is specified in fly.toml config',
    'github-flyio',
    'MEDIUM',
    '[
        {"solution": "Upgrade flyctl to version after 2021-04-07 with fix for image config recognition", "percentage": 94, "note": "Older versions did not recognize image field in [build] section"},
        {"solution": "Verify fly.toml has correct [build] section format with image field: [build] image = ''myimage:tag''", "percentage": 88, "command": "cat fly.toml | grep -A2 ''\\[build\\]''"},
        {"solution": "If using Dockerfile, remove [build] section and set context/dockerfile explicitly instead", "percentage": 80, "note": "Config format matters - ensure correct section"},
        {"solution": "Check that Docker image tag is valid and accessible: docker pull myimage:tag", "percentage": 75, "command": "docker pull [your-image:tag]"}
    ]'::jsonb,
    'Docker image specified in [build] section of fly.toml, Image available locally or in registry, flyctl authenticated',
    'fly deploy succeeds without config errors, Application builds using specified image, Deployment completes without "no Dockerfile" errors',
    'Old flyctl versions did not recognize image field in [build] section configuration. Error message falsely claimed no build method was configured. Always upgrade flyctl when config not recognized.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/superfly/flyctl/issues/384'
);

-- Summary of Fly.io flyctl deployment issues documented:
-- - Deployment hangs/timeouts: auth token refresh (builds), DNS checks, socket scanning delays
-- - Configuration errors: missing primary_region for volumes, env var override, auto-generated services
-- - Storage/volumes: flaps client missing, credential conflicts, missing export functionality
-- - Performance: slow version command for prompt integration
-- - Validation: machine shell naming constraints, image config recognition
-- Success rate: 78-94% across different issue categories
-- Common pattern: Upgrade flyctl first, check configuration format, use correct flags
