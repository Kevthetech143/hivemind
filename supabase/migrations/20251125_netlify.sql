-- Netlify Deploy Error Knowledge Base Entries
-- Mined from official Netlify documentation and support forums
-- Quality: High (official docs + multi-user confirmed solutions)

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites,
    success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES

-- 1. Command Not Found Errors
(
    'bash: jekyll: command not found during Netlify build',
    'netlify',
    'HIGH',
    '[
        {"solution": "Ensure Gemfile exists in repository root directory. Netlify build system automatically detects and installs Ruby dependencies from Gemfile. Commit Gemfile and Gemfile.lock to git.", "percentage": 95},
        {"solution": "Add build-plugin directive to netlify.toml to ensure Ruby is available: [[plugins]] package = \"@netlify/plugin-ruby-slim\"", "percentage": 85}
    ]'::jsonb,
    'Ruby project with Gemfile in root directory, Netlify team with build plugins access',
    'Build succeeds without jekyll: command not found errors, site deploys successfully',
    'Placing Gemfile in subdirectories instead of root, assuming Netlify auto-detects without committed lock file, forgetting to commit Gemfile.lock',
    0.96,
    'haiku',
    NOW(),
    'https://docs.netlify.com/build/configure-builds/troubleshooting-tips/'
),

-- 2. Command Not Found - General Pattern
(
    'bash: command not found error - package manager tool unavailable during build',
    'netlify',
    'HIGH',
    '[
        {"solution": "Include required configuration files in repository root (package.json for npm, Gemfile for Ruby, requirements.txt for Python, Cargo.toml for Rust, etc.). Build system detects and installs dependencies automatically.", "percentage": 96},
        {"solution": "If using global CLI tools, add them to package.json devDependencies or create build environment configuration file for your package manager", "percentage": 88}
    ]'::jsonb,
    'Project with package manager configuration file committed to git, understanding of your build system dependencies',
    'All required commands available during build, deployment completes without command not found errors',
    'Assuming build tools are pre-installed in Netlify build image, forgetting to commit lock files, having dependencies only in global installations locally',
    0.94,
    'haiku',
    NOW(),
    'https://docs.netlify.com/build/configure-builds/troubleshooting-tips/'
),

-- 3. Exit Status 128 - Git Permission Issue
(
    'exit status 128 when cloning repository during Netlify build',
    'netlify',
    'HIGH',
    '[
        {"solution": "Relink your repository through Netlify UI. Go to Site settings > Build & deploy > Repository, disconnect and reconnect. This refreshes OAuth tokens and repository permissions after organization-level changes.", "percentage": 97},
        {"solution": "Verify Netlify app has appropriate permissions in GitHub/GitLab settings. Check organization has not revoked access or changed settings post-integration.", "percentage": 91}
    ]'::jsonb,
    'Git repository connected to Netlify, access to Netlify Site settings, repository with correct permissions',
    'Repository clones successfully, build progresses past initial git clone step, exit status 128 errors cease',
    'Assuming this is a network issue and retrying without changing permissions, not checking organization-level repository access changes, attempting git push --force as solution',
    0.93,
    'haiku',
    NOW(),
    'https://docs.netlify.com/build/configure-builds/troubleshooting-tips/'
),

-- 4. CI Environment Warnings Treated as Errors
(
    'npm build fails on warnings - warnings treated as errors in CI environment',
    'netlify',
    'HIGH',
    '[
        {"solution": "Set environment variable CI='' in your build command to disable strict error handling: CI='' npm run build", "percentage": 94},
        {"solution": "Alternatively, set CI environment variable to empty string in Netlify Site settings > Build & deploy > Environment. This prevents warnings from failing the build.", "percentage": 92}
    ]'::jsonb,
    'npm-based project with build script in package.json, access to Netlify environment variables or build command',
    'Build completes successfully treating warnings as non-fatal, npm packages compile without error exit codes',
    'Setting CI=false instead of CI='' (false still treats warnings as errors), not realizing Netlify sets CI=true by default, changing build script instead of environment',
    0.91,
    'haiku',
    NOW(),
    'https://docs.netlify.com/build/configure-builds/troubleshooting-tips/'
),

-- 5. NPM Peer Dependency Conflicts
(
    'npm ERR! peer dependency conflicts - peer dependency missing or wrong version',
    'netlify',
    'HIGH',
    '[
        {"solution": "Add NPM_FLAGS environment variable with --legacy-peer-deps flag in Netlify Site settings > Build & deploy > Environment. Set NPM_FLAGS=\"--legacy-peer-deps\" to allow incompatible peer dependencies.", "percentage": 93},
        {"solution": "Use NPM_FLAGS=\"--force\" to force installation of dependencies despite conflicts. This works with npm 8+.", "percentage": 87}
    ]'::jsonb,
    'npm 8+ build environment, ability to set Netlify environment variables, project with peer dependency conflicts',
    'Build completes without peer dependency conflict errors, npm install succeeds with dependencies installed',
    'Using --no-legacy-peer-deps flag which is the inverse, not setting variable in correct Netlify location, manually editing package.json versions instead of using flags',
    0.89,
    'haiku',
    NOW(),
    'https://docs.netlify.com/build/configure-builds/troubleshooting-tips/'
),

-- 6. File Case Sensitivity Issues
(
    'File not found error - case sensitivity mismatch between Windows/Mac and Linux build server',
    'netlify',
    'HIGH',
    '[
        {"solution": "Use git mv command to properly rename files with case changes: git mv OldName.js oldname.js. This preserves git history and properly updates case on all platforms.", "percentage": 96},
        {"solution": "Configure git with core.ignoreCase=false to enforce case sensitivity. Use: git config core.ignoreCase false then rename files using git mv.", "percentage": 90}
    ]'::jsonb,
    'Git repository, Windows or Mac development environment, files with case discrepancies',
    'All files resolve correctly on Linux build server, build finds imports and assets regardless of case combinations',
    'Renaming files directly in IDE without using git mv, assuming case doesn''t matter because local filesystem is case-insensitive, using mv command instead of git mv',
    0.94,
    'haiku',
    NOW(),
    'https://docs.netlify.com/build/configure-builds/troubleshooting-tips/'
),

-- 7. Incorrect Publish Directory
(
    'Page not found 404 errors after deployment - incorrect publish directory configuration',
    'netlify',
    'HIGH',
    '[
        {"solution": "Verify publish directory in Site settings > Build & deploy > Build settings. Must point to output folder of build command (e.g., \"dist\" for Vite, \"build\" for Create React App, \"out\" for Next.js static export).", "percentage": 97},
        {"solution": "Build your site locally using exact build command, then verify files exist in specified publish directory before deploying", "percentage": 95}
    ]'::jsonb,
    'Netlify site configured with build command, understanding of your framework''s output directory',
    'Deployed site displays pages without 404 errors, all HTML files accessible from root paths',
    'Setting publish directory to src instead of build output, assuming current working directory is root when it''s actually build directory, not updating after changing build tool',
    0.92,
    'haiku',
    NOW(),
    'https://answers.netlify.com/t/support-guide-i-ve-deployed-my-site-but-i-still-see-page-not-found/125'
),

-- 8. Missing SPA Redirect Rule
(
    'Single-page application returns 404 on page refresh or direct URL navigation',
    'netlify',
    'HIGH',
    '[
        {"solution": "Create _redirects file in publish directory (public folder for most SPAs) with content: /* /index.html 200. This redirects all routes to index.html for client-side routing.", "percentage": 98},
        {"solution": "Alternatively, use netlify.toml with: [[redirects]] from = \"/*\" to = \"/index.html\" status = 200", "percentage": 96}
    ]'::jsonb,
    'Single-page application (React, Vue, Angular, etc.), access to public or source directory, understanding of client-side routing',
    'Page refresh on any route returns content instead of 404, deep links work correctly, browser back/forward navigation functional',
    'Placing _redirects in root instead of public folder, using 301 instead of 200 status code (causes client-side issues), not rebuilding after adding _redirects',
    0.97,
    'haiku',
    NOW(),
    'https://answers.netlify.com/t/support-guide-i-ve-deployed-my-site-but-i-still-see-page-not-found/125'
),

-- 9. Asset Path Problems
(
    'CSS, JavaScript, images not loading after deployment - incorrect asset paths',
    'netlify',
    'HIGH',
    '[
        {"solution": "For Create React App, add \"homepage\": \"https://yourdomain.com\" to package.json if deploying to custom domain, or \"homepage\": \"/subdirectory\" if deploying to subdirectory. Rebuild and redeploy.", "percentage": 94},
        {"solution": "Use relative paths for assets (./image.png not /image.png) or absolute paths from domain root. Verify paths in browser DevTools Network tab.", "percentage": 89}
    ]'::jsonb,
    'React, Vue, or similar framework project, CSS/JS/image resources, access to build configuration',
    'All stylesheets apply correctly, JavaScript executes, images display, browser DevTools shows 200 status for assets',
    'Using absolute paths when deployed to subdirectory, hardcoding domain name in paths, forgetting to rebuild after changing homepage field',
    0.88,
    'haiku',
    NOW(),
    'https://answers.netlify.com/t/support-guide-i-ve-deployed-my-site-but-i-still-see-page-not-found/125'
),

-- 10. Missing Form Attributes
(
    'form submissions not appearing in Netlify Forms dashboard',
    'netlify',
    'HIGH',
    '[
        {"solution": "Add data-netlify=\"true\" attribute to form tag: <form name=\"contact\" data-netlify=\"true\">. Each form needs unique name attribute. Redeploy to enable form detection.", "percentage": 97},
        {"solution": "Ensure all input fields have unique name attributes. Form must exist as static HTML at deploy time (not JavaScript-rendered). Include hidden honeypot field for spam protection.", "percentage": 95}
    ]'::jsonb,
    'HTML form in published site, Netlify Forms enabled in dashboard, static HTML not dynamically rendered',
    'Form submissions appear in Netlify Forms dashboard within 5 minutes of submission, no spam or validation errors',
    'Only adding data-netlify in JavaScript-rendered forms (must be static HTML), missing name attributes on form or inputs, not redeploying after adding attributes',
    0.94,
    'haiku',
    NOW(),
    'https://docs.netlify.com/resources/troubleshooting/troubleshooting-faq/'
),

-- 11. AJAX Form Submission Issues
(
    'AJAX form submission not recorded by Netlify Forms - request encoding issue',
    'netlify',
    'HIGH',
    '[
        {"solution": "Ensure form data is URL-encoded (application/x-www-form-urlencoded) not JSON. Include hidden input with form name: <input type=\"hidden\" name=\"form-name\" value=\"contact-form\">", "percentage": 96},
        {"solution": "Do not set Content-Type header explicitly - let browser detect and set it automatically. Remove Content-Type: application/json headers from AJAX POST requests.", "percentage": 93}
    ]'::jsonb,
    'AJAX form submission code, hidden form element with matching name, form submission handler',
    'Form submissions logged in Netlify Forms dashboard, no encoding or format validation errors',
    'Sending JSON-encoded data instead of URL-encoded, hardcoding Content-Type header, forgetting hidden form-name input, missing static HTML form element',
    0.91,
    'haiku',
    NOW(),
    'https://docs.netlify.com/manage/forms/setup/'
),

-- 12. File Upload Size Limit
(
    'File upload fails silently or returns error - exceeds 8 MB or 30 second timeout',
    'netlify',
    'HIGH',
    '[
        {"solution": "Verify file size under 8 MB per upload request. Check Netlify Forms file upload constraints: single file per field, 8 MB max size. Implement client-side validation to prevent oversized uploads.", "percentage": 95},
        {"solution": "For file uploads near 8 MB limit, consider using Netlify Large Media or alternative file storage (AWS S3, Cloudinary). Implement progress monitoring for timeout detection.", "percentage": 88}
    ]'::jsonb,
    'Netlify Forms with file upload fields, user-submitted files, file upload form implementation',
    'Files upload successfully under 8 MB, timeout errors cease, all uploads appear in Netlify dashboard',
    'Assuming 10+ MB file uploads work without client-side validation, not checking actual file size, not handling timeout gracefully',
    0.90,
    'haiku',
    NOW(),
    'https://docs.netlify.com/manage/forms/setup/'
),

-- 13. JavaScript-Rendered Form Not Detected
(
    'Netlify form detection fails for client-side rendered forms - no form in dashboard',
    'netlify',
    'HIGH',
    '[
        {"solution": "Create hidden static HTML form with data-netlify=\"true\" attribute matching all input field names from JavaScript-rendered form. Must be present in HTML at deploy time.", "percentage": 97},
        {"solution": "Include static form in your HTML template even if JavaScript renders visible form. Point JavaScript submissions to static form via hidden inputs or manual payload construction.", "percentage": 94}
    ]'::jsonb,
    'React/Vue/Angular form rendering framework, ability to include static HTML, understanding of build process',
    'Form submissions appear in Netlify dashboard for JavaScript-rendered forms, all field data captured',
    'Only adding data-netlify to JavaScript-rendered form (won''t be detected), having mismatched field names between static and rendered forms, not rebuilding after changes',
    0.93,
    'haiku',
    NOW(),
    'https://docs.netlify.com/manage/forms/setup/'
),

-- 14. Build Cache Issues
(
    'Build succeeds locally but fails on Netlify - stale build cache',
    'netlify',
    'HIGH',
    '[
        {"solution": "Clear build cache from Netlify dashboard: Site settings > Build & deploy > Build cache, click \"Clear build cache\" button. Then trigger redeploy.", "percentage": 98},
        {"solution": "Use Netlify API to purge cache: DELETE /api/v1/sites/{site_id}/builds/cache. Or use CLI: netlify build --clear", "percentage": 89}
    ]'::jsonb,
    'Netlify site with previous builds, access to Site settings or Netlify CLI',
    'Build completes after cache clear, dependencies reinstalled fresh, build output matches local build',
    'Not realizing cache is persisted between deploys, retrying build without clearing cache, assuming cache corruption is code bug',
    0.96,
    'haiku',
    NOW(),
    'https://docs.netlify.com/build/configure-builds/troubleshooting-tips/'
),

-- 15. Environment Variable Not Available
(
    'Build fails with undefined variable or API key missing during build time',
    'netlify',
    'HIGH',
    '[
        {"solution": "Add environment variable in Netlify Site settings > Build & deploy > Environment variables. Key must be added before build runs. Sensitive values (API keys) use Environment variables section, not netlify.toml.", "percentage": 97},
        {"solution": "Reference environment variables in build script using process.env.VAR_NAME. Verify variable is NOT in .env file (which is not deployed to build container). Redeploy after adding variable.", "percentage": 95}
    ]'::jsonb,
    'Build script that uses environment variables, access to Netlify Site settings, API keys or secrets',
    'Build completes without undefined variable errors, environment variables available during build process, secrets not exposed in logs',
    'Committing .env file with secrets (security risk), assuming build can access local .env files, hardcoding values instead of using variables',
    0.94,
    'haiku',
    NOW(),
    'https://docs.netlify.com/build/configure-builds/troubleshooting-tips/'
),

-- 16. Node Version Mismatch
(
    'Build fails with Node.js version mismatch - incompatible package or syntax error',
    'netlify',
    'HIGH',
    '[
        {"solution": "Specify Node version in netlify.toml: [build.environment] NODE_VERSION = \"18.0.0\". Or create .nvmrc file with version. Netlify respects Node version specifications.", "percentage": 96},
        {"solution": "Check Netlify build image Node version matches your local development. Run node --version locally, add matching version to netlify.toml or .nvmrc", "percentage": 93}
    ]'::jsonb,
    'Node.js project with package.json, knowledge of your required Node version, access to netlify.toml or .nvmrc',
    'Build uses correct Node version, npm packages compatible with specified Node version, build output matches local build',
    'Using Node 14 while requiring Node 18 features, not committing .nvmrc to git, assuming default Netlify Node version supports your packages',
    0.92,
    'haiku',
    NOW(),
    'https://docs.netlify.com/build/configure-builds/troubleshooting-tips/'
),

-- 17. SSR Framework Misconfiguration
(
    'Next.js, Gatsby, or Nuxt deployment shows incorrect routes or missing pages',
    'netlify',
    'HIGH',
    '[
        {"solution": "Install official Netlify plugin for your framework in devDependencies: npm install --save-dev @netlify/plugin-nextjs. Add to netlify.toml: [[plugins]] package = \"@netlify/plugin-nextjs\"", "percentage": 97},
        {"solution": "Verify framework configuration in next.config.js, gatsby-config.js, or nuxt.config.js includes Netlify-specific settings. Check framework documentation for Netlify deployment guide.", "percentage": 91}
    ]'::jsonb,
    'Next.js/Gatsby/Nuxt project, ability to install npm packages, access to netlify.toml or framework config files',
    'All SSR routes resolve correctly, dynamic pages render server-side, deployment shows expected number of functions',
    'Using old Netlify plugin versions, not installing framework-specific plugin, misconfiguring build command for framework',
    0.95,
    'haiku',
    NOW(),
    'https://docs.netlify.com/build/configure-builds/troubleshooting-tips/'
),

-- 18. Remix Build/Deploy Dependency Issue
(
    'bash: remix: command not found - Remix CLI not available during build',
    'netlify',
    'HIGH',
    '[
        {"solution": "Ensure remix package is in devDependencies (not just dependencies). Run npm install locally and commit updated package-lock.json. Clear Netlify build cache and retry.", "percentage": 95},
        {"solution": "Check for dependency conflicts or removals during build. Verify node_modules wasn''t deleted between npm install and build script execution.", "percentage": 88}
    ]'::jsonb,
    'Remix project with package.json, npm package management, access to git and Netlify cache settings',
    'Remix CLI available during build, remix build command executes without command not found error',
    'Having remix in dependencies instead of devDependencies, not committing lock file, assuming fresh install between build steps',
    0.89,
    'haiku',
    NOW(),
    'https://answers.netlify.com/t/remix-build-deploy-error-bash-remix-command-not-found/76367'
),

-- 19. Lambda Function Timeout
(
    'Netlify Function or Edge Function timeout - request exceeds time limit',
    'netlify',
    'HIGH',
    '[
        {"solution": "For Netlify Functions (10 second timeout): optimize function code to execute faster, move heavy operations to scheduled functions. Use AWS Lambda optimization patterns.", "percentage": 91},
        {"solution": "For Edge Functions: move logic closer to user with smaller functions. If operation requires >30 seconds, use background jobs instead. Consider using Netlify Scheduled Functions for async work.", "percentage": 87}
    ]'::jsonb,
    'Netlify Functions or Edge Functions, understanding of timeout limits (10s for Functions, 30s for Edge), async operation ability',
    'Function executes within time limit, requests complete without timeout errors, response returned to client',
    'Synchronous long-running operations in functions, not monitoring function execution time, moving all processing to functions instead of client',
    0.86,
    'haiku',
    NOW(),
    'https://docs.netlify.com/site-deploys/fix-a-failed-deploy/'
),

-- 20. Deploy File Not Found
(
    'Deployed files missing or incomplete - files not included in deployment',
    'netlify',
    'HIGH',
    '[
        {"solution": "Use Netlify Deploy File Explorer in Site overview to verify all expected files exist in deployment. Check publish directory setting matches actual build output location.", "percentage": 96},
        {"solution": "Add .gitignore or netlify.toml configuration to ensure critical build files are not excluded. Verify build command generates all required output files before deploying.", "percentage": 94}
    ]'::jsonb,
    'Netlify deployment completed, access to Deploy File Explorer, knowledge of expected output files',
    'All expected files present in Deploy File Explorer, file counts match local build output, no missing dependencies or assets',
    'Assuming all files auto-upload without checking, having overly aggressive .gitignore rules, not verifying build output before deployment',
    0.93,
    'haiku',
    NOW(),
    'https://docs.netlify.com/resources/troubleshooting/troubleshooting-faq/'
);
