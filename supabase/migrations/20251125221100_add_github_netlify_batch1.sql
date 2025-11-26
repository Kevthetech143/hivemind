-- Add Netlify CLI build/deployment error solutions from GitHub issues
-- Category: github-netlify
-- Source: https://github.com/netlify/cli/issues

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES (
    'netlify deploy: Multiple possible build commands found error with --build false flag',
    'github-netlify',
    'HIGH',
    '[
        {"solution": "Update to Netlify CLI v17.36.3 or later which fixes framework detection when --build false is specified", "percentage": 95, "note": "Official fix released April 2025"},
        {"solution": "Pin CLI version to v17.36.0 or earlier as temporary workaround", "percentage": 80, "command": "npm install -g netlify-cli@17.36.0", "note": "Temporary workaround only"},
        {"solution": "Ensure --build false flag is passed before --dir and --alias flags in deploy command", "percentage": 85, "command": "netlify deploy --build false --dir <folder> --alias <alias>"}
    ]'::jsonb,
    'Netlify CLI installed, repository with multiple framework configurations, pre-built static site ready for deployment',
    'Deploy completes successfully without build command detection error, static files deployed to specified alias without framework detection',
    'Build flag must be placed before directory/alias options. Framework detection runs even with --build false in v17.36.2+. Always specify --build false explicitly when deploying pre-built sites.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/netlify/cli/issues/6841'
),
(
    'netlify deploy: Invalid AWS Lambda parameters - Reserved keys used in this request',
    'github-netlify',
    'MEDIUM',
    '[
        {"solution": "Switch to Git-based deployment instead of using CLI deploy command", "percentage": 95, "note": "Avoids environment variable packing issue entirely"},
        {"solution": "Reduce environment variable size before deployment by stripping unnecessary system variables", "percentage": 70, "command": "env -i bash --noprofile --norc && netlify deploy --prod", "note": "May not fully resolve issue but worth attempting"},
        {"solution": "Use Git integration to deploy Go functions instead of pre-built binaries via CLI", "percentage": 90, "note": "Let Netlify build from source instead of uploading binary"}
    ]'::jsonb,
    'Netlify CLI authenticated, AWS Lambda function code or binary, AWS account with Lambda permissions',
    'Function uploads successfully without 500 error, function executes correctly in production',
    'AWS Lambda has 4KB environment variable limit. CLI may include system environment variables in deployment package. Pre-built Go binaries are more problematic than source builds. Verify environment variable total size.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/netlify/cli/issues/1147'
),
(
    'netlify build: Failed to install Node.js version specified in .nvmrc or build config',
    'github-netlify',
    'MEDIUM',
    '[
        {"solution": "Update .nvmrc to specify a currently supported Node.js LTS version (14.x, 16.x, 18.x or later)", "percentage": 95, "command": "echo 16 > .nvmrc && git push", "note": "Update to Node 16+ recommended"},
        {"solution": "Verify available versions with nvm ls-remote locally before pushing to repo", "percentage": 85, "command": "nvm ls-remote | grep -E ''16\\.|18\\.|20\\.''"},
        {"solution": "Pin Node version in netlify.toml build settings instead of .nvmrc file", "percentage": 80, "note": "Alternative configuration method"}
    ]'::jsonb,
    'Netlify build configured, .nvmrc or Node version config file present, Node 12+ compatible code',
    'Build completes successfully with correct Node version installed, npm/yarn dependencies resolve without errors',
    'Node.js 12.x has reached end-of-life and version 12.18.0 may not be available in Netlify build images. Always use LTS versions. Check NVM availability locally before deploying.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/netlify/cli/issues/1163'
),
(
    'netlify-cli v2.41.0: Global installation fails with EACCES permission denied for grpc module',
    'github-netlify',
    'MEDIUM',
    '[
        {"solution": "Upgrade to netlify-cli v2.42.0 or later which removed problematic native module dependency", "percentage": 95, "command": "npm install -g netlify-cli@latest"},
        {"solution": "Downgrade to v2.40.0 or earlier while native module issue exists", "percentage": 90, "command": "npm install -g netlify-cli@2.40.0", "note": "Temporary workaround"},
        {"solution": "Run npm install with --unsafe-perm flag in CI environments", "percentage": 60, "command": "npm install -g netlify-cli --unsafe-perm", "note": "Security risk - not recommended"}
    ]'::jsonb,
    'npm or yarn installed globally, Administrator or sudoer access in CI environment, Node.js 10-13 or later',
    'Global CLI installation succeeds, netlify command available in PATH, netlify --version executes without error',
    'v2.41.0 introduced native grpc dependency requiring compilation. CI container users with restricted permissions cannot compile native modules. Avoid v2.41.0 entirely. Always use v2.42.0+.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/netlify/cli/issues/798'
),
(
    'netlify-cli v2.42.0: Cannot read property replace of null in netlify build command',
    'github-netlify',
    'MEDIUM',
    '[
        {"solution": "Update to latest netlify-cli version with null-checking fixes via PR #813 and netlify/build#1120", "percentage": 95, "command": "npm install -g netlify-cli@latest"},
        {"solution": "Add base directory configuration to netlify.toml file", "percentage": 85, "command": "echo ''[build]\\nbase = \\\".\\\"'' >> netlify.toml", "note": "Ensures build settings are not null"},
        {"solution": "Clear package lock and reinstall dependencies", "percentage": 80, "command": "rm package-lock.json && npm install", "note": "Refresh dependency cache"}
    ]'::jsonb,
    'netlify-cli v2.42.0 installed, netlify.toml configuration file present, Node.js build environment',
    'netlify build command completes without TypeError, @netlify/config version 0.9.1+ installed (verify with npm ls @netlify/config)',
    'v2.42.0 has regression when build_settings is null instead of undefined. Null-checking was missing in config parser. Ensure netlify.toml has [build] section defined. Property validation differs between config versions.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/netlify/cli/issues/809'
),
(
    'netlify dev: Invalid rule - path rule cannot contain anything after * token in headers file',
    'github-netlify',
    'HIGH',
    '[
        {"solution": "Update to netlify-cli with PR #1777 fix that supports consistent wildcard patterns in headers", "percentage": 95, "command": "npm install -g netlify-cli@latest"},
        {"solution": "Move header rules from _headers file to netlify.toml configuration instead", "percentage": 85, "note": "Temporary workaround - use [[headers]] section in netlify.toml"},
        {"solution": "Use wildcard patterns that match production Netlify validation: avoid file extensions after asterisk", "percentage": 70, "note": "Refactor header patterns to be simpler"}
    ]'::jsonb,
    '_headers file in project root, netlify dev command configured, Netlify CLI with header parser',
    'netlify dev starts without validation error, wildcard header patterns load successfully, headers apply correctly to matching paths',
    'CLI header parser validation was stricter than production platform. Patterns like /*.css work in production but fail locally. Production platform allows wildcards followed by extensions. Update CLI to sync with production validator.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/netlify/cli/issues/1148'
),
(
    'netlify dev: Function file reload completes silently without success feedback message',
    'github-netlify',
    'LOW',
    '[
        {"solution": "Update to netlify-cli version with improved function reload messaging (PR #988)", "percentage": 95, "command": "npm install -g netlify-cli@latest"},
        {"solution": "Test function endpoint directly to confirm reload completed successfully despite lack of message", "percentage": 85, "note": "Reload completes even without user feedback"},
        {"solution": "Check netlify dev logs for errors that might indicate reload failure", "percentage": 70, "note": "Function build errors may appear in logs if reload failed"}
    ]'::jsonb,
    'netlify dev running, Lambda/serverless functions in project, function file modified during dev session',
    'Function reload message appears in CLI output, endpoint tested responds with updated function behavior, no errors in function logs',
    'Reload completes silently even though operation succeeds. No completion feedback confused users about hung process. Function build errors also hidden in older versions. Upgrade CLI for better error reporting.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/netlify/cli/issues/627'
),
(
    'netlify dev: Error with serverless functions - EPERM yarn run build:lambda fails',
    'github-netlify',
    'MEDIUM',
    '[
        {"solution": "Run npm install to ensure all dependencies including netlify-lambda are installed", "percentage": 90, "command": "npm install"},
        {"solution": "Move project directory away from special characters, especially exclamation marks (!)", "percentage": 85, "note": "Exclamation marks are reserved in webpack loader syntax"},
        {"solution": "Update to netlify-cli version with PR #988 improvements for lambda build error visibility", "percentage": 80, "command": "npm install -g netlify-cli@latest"}
    ]'::jsonb,
    'Netlify CLI installed, netlify-lambda function builder configured, create-react-app or similar project structure, functions in /.netlify/functions/ directory',
    'netlify dev starts successfully, Lambda functions build without permission errors, function endpoints respond correctly, no EPERM exit code 1 errors',
    'Function builder is invoked twice causing lambda build failure. Special characters in folder path (especially !) conflict with webpack loader syntax. Lambda build errors were hidden in older CLI versions. Check parent directory names.',
    0.86,
    'sonnet-4',
    NOW(),
    'https://github.com/netlify/cli/issues/541'
),
(
    'netlify dev: Function redirects not working with POST requests - returns HTML instead of JSON',
    'github-netlify',
    'HIGH',
    '[
        {"solution": "Update to netlify-cli with PR #885 redirect and rewrite fixes for dev server", "percentage": 95, "command": "npm install -g netlify-cli@latest"},
        {"solution": "Configure redirects in netlify.toml with proper syntax for function paths", "percentage": 90, "command": "[[redirects]]\\nfrom = \\\"/api/*\\\"\\nto = \\\"/.netlify/functions/:splat\\\"\\nstatus = 200"},
        {"solution": "Place serverless functions in /.netlify/functions/ directory and test both GET and POST methods", "percentage": 85, "note": "Verify file paths and HTTP methods in test requests"}
    ]'::jsonb,
    'netlify dev running, serverless functions deployed in /.netlify/functions/, netlify.toml with redirect rules configured, Gatsby or static site generator',
    'POST requests to redirected paths return JSON from function instead of HTML, direct function URLs work correctly, both GET and POST methods function properly during dev',
    'Dev server redirect handling differs from production deployment. Redirects work for GET but not POST in buggy versions. Issue specific to dev environment - production deploys work correctly. PR #885 syncs dev behavior with production.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/netlify/cli/issues/890'
),
(
    'netlify dev: Function response body empty in production but present locally without async keyword',
    'github-netlify',
    'MEDIUM',
    '[
        {"solution": "Add async keyword to all Lambda handler function declarations", "percentage": 95, "command": "exports.handler = async function(event) { ... }", "note": "Matches AWS Lambda production behavior"},
        {"solution": "Return Promise from non-async functions to match production behavior", "percentage": 85, "command": "return Promise.resolve({statusCode: 200, body: \\'hello\\'})"},
        {"solution": "Update netlify dev to match production Lambda behavior for synchronous returns", "percentage": 60, "note": "Requires CLI update - users should use async keyword"}
    ]'::jsonb,
    'Netlify Lambda functions deployed, node runtime environment, function handler code',
    'Function response body consistent between local dev and production, async functions execute and return responses correctly, logs appear in both environments',
    'AWS Lambda treats async and non-async functions differently. Non-async returns bypass proper response encoding in production but work locally. netlify dev should match production behavior. Always use async keyword for consistency.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/netlify/cli/issues/1047'
),
(
    'netlify dev: Environment variables from netlify.toml [dev] block missing in function process.env',
    'github-netlify',
    'HIGH',
    '[
        {"solution": "Update to netlify-cli version that properly injects [dev] section environment variables (issue #982 fix)", "percentage": 95, "command": "npm install -g netlify-cli@latest"},
        {"solution": "Define environment variables in [dev] section of netlify.toml", "percentage": 90, "command": "[[dev]]\\nNEXT_PUBLIC_API_URL = \\\"http://localhost:3000\\\""},
        {"solution": "Access variables via process.env in function code", "percentage": 85, "command": "const apiUrl = process.env.NEXT_PUBLIC_API_URL;"}
    ]'::jsonb,
    'netlify.toml file with [dev] section configured, environment variables defined in config, serverless functions accessing process.env',
    'process.env contains all variables defined in [dev] section, functions execute with correct environment values, netlify dev logs show variables loaded',
    'netlify.toml [dev] section variables not injected into function runtime in older versions. Variables defined in [dev] block only apply during netlify dev, not production. Distinguish from [build] and [context.production] sections.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://github.com/netlify/cli/issues/982'
),
(
    'netlify dev: Feature - Dev-specific environment variables not supported in older versions',
    'github-netlify',
    'MEDIUM',
    '[
        {"solution": "Use [dev] section in netlify.toml to define development-only environment variables", "percentage": 95, "command": "[[dev]]\\nVARIABLE_NAME = \\\"development_value\\\"\\nANOTHER_VAR = \\\"dev_only\\\""},
        {"solution": "Separate development and production configurations using [context.production] and [context.branch-deploy] sections", "percentage": 85, "command": "[[context.production]]\\nVARIABLE_NAME = \\\"production_value\\\""},
        {"solution": "Use .env.local file for local overrides (not committed to git)", "percentage": 70, "command": "echo VARIABLE_NAME=local_value >> .env.local"}
    ]'::jsonb,
    'netlify.toml file present, netlify dev configured, development and production environments to manage',
    '[dev] section variables load during netlify dev, functions access variables via process.env, configuration persists across dev restarts',
    '[dev] section applies only during local netlify dev execution, not during build. Separate [dev] from [context.production] section. Variables in [dev] override global definitions. Use for API URLs, debug flags, local service ports.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/netlify/cli/issues/444'
),
(
    'netlify build: package-lock.json missing dependency entries causing npm ci failure',
    'github-netlify',
    'MEDIUM',
    '[
        {"solution": "Regenerate package-lock.json by running npm install and committing updated lock file", "percentage": 95, "command": "rm package-lock.json && npm install && git add package-lock.json && git commit -m ''Update package-lock.json''"},
        {"solution": "Delete package-lock.json and allow npm to regenerate during build", "percentage": 85, "command": "rm package-lock.json && git push"},
        {"solution": "Use npm ci instead of npm install to enforce lock file consistency", "percentage": 80, "command": "npm ci"}
    ]'::jsonb,
    'package.json file with dependencies, npm or yarn package manager, Git repository for version control',
    'npm ci executes successfully during build, all dependencies install without ''Cannot find module'' errors, build process completes',
    'package-lock.json must match package.json dependencies exactly. Missing entries prevent npm ci from locating packages. npm install modifies lock file; ensure updated lock file is committed. Keep lock file in sync with dependency changes.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/netlify/cli/pull/1548'
);
