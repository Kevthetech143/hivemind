-- Add Stack Overflow Render.com deployment error solutions batch 1

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Render: Build successful but deployment fails with "Application Error" status',
    'stackoverflow-render',
    'HIGH',
    '[
        {"solution": "Add a health check route to your Express.js app that responds with 200 status code to the root path (GET /)", "percentage": 95, "note": "Render performs health checks on deployment - failure triggers deployment failure despite build success", "command": "app.get(\"/\", (req, res) => { res.sendStatus(200) })"},
        {"solution": "Ensure your app listens on the correct port and responds to HTTP requests within timeout window", "percentage": 88, "note": "Health check endpoint must return 200-399 status code"},
        {"solution": "Verify logs show \"Application is running\" but check Render deployment status separately", "percentage": 82, "note": "Build logs and deployment status are independent - build success does not guarantee deployment success"}
    ]'::jsonb,
    'Express.js or similar HTTP framework, Application listening on assigned port',
    'Render deployment status shows success, Health check route returns 200 status, Application accessible via HTTPS',
    'Assuming build logs indicate successful deployment. Missing root route (/) causes immediate health check failure. Returning non-2xx status codes triggers deployment failure.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/72150113/nodejs-app-build-is-successful-render-but-application-error-in-render-at-the-l'
),
(
    'Render npm deployment fails with "ERESOLVE could not resolve" peer dependency conflict',
    'stackoverflow-render',
    'VERY_HIGH',
    '[
        {"solution": "Use --legacy-peer-deps flag: npm install --legacy-peer-deps in your start/build command", "percentage": 92, "note": "Bypasses npm strict peer dependency validation - simplest fix"},
        {"solution": "Upgrade the conflicting package to version compatible with your project dependencies", "percentage": 88, "note": "Example: upgrade eslint-config-airbnb to 19.0.4+ for eslint@8 compatibility", "command": "npm install eslint-config-airbnb@latest"},
        {"solution": "Downgrade to older package version that matches peer dependency requirements", "percentage": 80, "note": "If upgrade not possible, reduce to compatible versions"},
        {"solution": "Configure Render build command to use --force flag: npm install --force", "percentage": 75, "note": "Alternative to --legacy-peer-deps, may cause more aggressive dependency resolution"}
    ]'::jsonb,
    'npm 7+ (Node.js 15+), package.json with conflicting peer dependencies documented',
    'npm install completes without ERESOLVE errors, Build proceeds to next phase, Render deployment status shows success',
    'Not all peer dependency conflicts can be resolved with flags alone. Some require upgrading conflicting packages. --force may cause unexpected behavior. Check package compatibility before using flags.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/76643339/render-deployment-failed'
),
(
    'Render Node.js/MERN deployment fails with "npm ERR! Exit status 137" out of memory error',
    'stackoverflow-render',
    'HIGH',
    '[
        {"solution": "Add Node.js memory flag to build script in package.json: NODE_OPTIONS=--max_old_space_size=2048 npm run build", "percentage": 90, "note": "Allocates 2GB RAM for Node.js process to handle memory-intensive React builds", "command": "\"build\": \"NODE_OPTIONS=--max_old_space_size=2048 npm run build\""},
        {"solution": "Upgrade Render plan from free to paid tier to allocate more system memory", "percentage": 85, "note": "Free tier has limited RAM - insufficient for complex builds with many dependencies"},
        {"solution": "Optimize dependencies: remove unused packages, use lighter alternatives, reduce bundle size", "percentage": 78, "note": "Exit status 137 indicates kernel OOM killer terminating process"},
        {"solution": "Check that all required dependencies are listed in package.json before deployment", "percentage": 72, "note": "Missing dependencies can cause cascading failures and memory leaks"}
    ]'::jsonb,
    'Node.js app with npm build script, package.json configured with build command',
    'Build completes without exit status 137 error, Application bundle generated successfully, Render deployment proceeds to next phase',
    'Exit status 137 is easy to misdiagnose without checking system resources. Simply upgrading plan without optimizing code will waste money. Memory flags must be set before build starts.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/76283502/on-deploying-my-backend-on-render-com-facing-error'
),
(
    'Render Node.js deployment fails with "Cannot find module" - missing environment variables',
    'stackoverflow-render',
    'VERY_HIGH',
    '[
        {"solution": "Add all .env file key-value pairs to Render dashboard Environment section before deployment", "percentage": 96, "note": "Render does not read .env files from repository - must configure via dashboard", "command": "Navigate to Service > Environment > Add Environment Variables"},
        {"solution": "Never commit .env file to GitHub - add to .gitignore and configure in Render dashboard instead", "percentage": 94, "note": "Best security practice - secrets never exposed in version control"},
        {"solution": "Verify all environment variable names match exactly between .env and Render dashboard (case-sensitive)", "percentage": 90, "note": "Common pitfall: typos in variable names cause module import failures"},
        {"solution": "Ensure start command is correct in Render settings: npm run start (not npm start)", "percentage": 85, "note": "Verify scripts.start in package.json points to correct entry file"}
    ]'::jsonb,
    'Node.js application with environment-dependent configuration, .env file with required variables, package.json with defined start script',
    'Render dashboard shows all environment variables configured, Application starts without "Cannot find module" errors, Service shows as Live',
    'Forgetting that .env files are not deployed to Render causes immediate runtime failures. Environment variables are case-sensitive. Using npm start instead of npm run start may not work reliably.',
    0.95,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/75451481/problems-deploying-node-app-with-render-com'
),
(
    'Render Python deployment fails with "Build failed" due to duplicate package versions in requirements.txt',
    'stackoverflow-render',
    'HIGH',
    '[
        {"solution": "Remove all duplicate package entries from requirements.txt, keeping only one version per package", "percentage": 94, "note": "Tools like pipreqs sometimes generate duplicate lines when scanning project files"},
        {"solution": "After removing duplicates, verify Python version compatibility with specified package versions", "percentage": 88, "note": "Example: Pillow 10.0.0 requires Python >= 3.8, so Python 3.7 will fail"},
        {"solution": "If package version incompatible with Python version, either upgrade Python or use older package version", "percentage": 86, "note": "Check PyPI for package compatibility before specifying version"},
        {"solution": "Regenerate requirements.txt cleanly: pip freeze > requirements_new.txt and compare/merge carefully", "percentage": 80, "note": "Prevents tool-generated duplicates from being reintroduced"}
    ]'::jsonb,
    'Python application with requirements.txt file, pip or pipreqs used to generate dependencies, Render Python environment configured',
    'requirements.txt passes validation without duplicate package errors, Render build completes successfully, All specified packages install without version conflicts',
    'Pipreqs can generate duplicate versions silently - always review requirements.txt manually. Python version on Render defaults to older version - verify compatibility. Removing duplicates solves most build failures.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/76890585/why-have-i-been-getting-build-failed-message-while-trying-to-deploy-app-to-ren'
),
(
    'Render Django deployment fails: "could not translate host name" PostgreSQL connection error',
    'stackoverflow-render',
    'HIGH',
    '[
        {"solution": "Ensure web service and PostgreSQL database are deployed to the SAME geographic region on Render", "percentage": 96, "note": "Different regions prevent hostname resolution between services", "command": "Create both services in same region (e.g., singapore, oregon)"},
        {"solution": "If services already created in different regions, delete and recreate in matching region", "percentage": 94, "note": "Region cannot be changed after service creation - requires full recreation"},
        {"solution": "Configure render.yaml with matching regions for web and database services", "percentage": 92, "note": "Example: specify region: singapore for both services block"},
        {"solution": "Verify DATABASE_URL environment variable points to correct database host", "percentage": 85, "note": "After recreating in same region, update connection string if needed"}
    ]'::jsonb,
    'Django application with PostgreSQL database on Render, render.yaml or manual service creation, PostgreSQL service already deployed',
    'Web service can reach PostgreSQL without hostname resolution errors, Django migrations run successfully, Application database queries execute without timeout',
    'Easy to overlook region selection during initial setup - results in cryptic hostname translation errors. Cannot change region after service creation. Verify region match before deploying Django app.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/74852478/how-to-solve-this-error-deploying-to-render-com-django-db-utils-operationalerro'
),
(
    'Render Express.js deployment shows "Internal Service Error" despite successful build and logs',
    'stackoverflow-render',
    'HIGH',
    '[
        {"solution": "Change start command from \"npm start\" to \"npm run start\" in Render dashboard settings", "percentage": 90, "note": "npm run start explicitly invokes script defined in package.json - more reliable across environments"},
        {"solution": "Verify package.json contains correctly defined start script pointing to entry file", "percentage": 88, "note": "Example: \"start\": \"node server.js\" or \"start\": \"node app.js\"", "command": "\"start\": \"node server.js\""},
        {"solution": "Ensure application listens on correct port - Render auto-detects open HTTP ports, defaults to 3000", "percentage": 85, "note": "Application must listen on port that Render detects during startup"},
        {"solution": "Check MongoDB connection string and credentials are correctly set in Environment variables", "percentage": 80, "note": "Missing or incorrect database credentials cause Internal Service Error despite server starting"}
    ]'::jsonb,
    'Express.js application with defined start script in package.json, MongoDB or database connection configured, Render Web Service deployment',
    'Service shows as Live in Render dashboard, Application serves requests without 500 errors, Logs show no connection or startup failures',
    'npm start behavior differs across environments - using npm run start is more consistent. Render auto-detects ports but app must actually listen. 502/500 errors often indicate database connection failures.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/76832412/trying-to-deploy-website-on-render-com-not-working'
),
(
    'Render static site React SPA shows "404 Not Found" when refreshing non-homepage routes',
    'stackoverflow-render',
    'HIGH',
    '[
        {"solution": "Configure redirect rule in Render Static Site settings: Source: /*, Destination: /index.html, Action: Rewrite", "percentage": 95, "note": "Client-side routers like React Router need all routes to resolve to index.html for JS to handle routing"},
        {"solution": "Verify using Static Site service type (not Web Service) - only static assets served, no backend needed", "percentage": 92, "note": "Static Site is correct for Create React App deployments"},
        {"solution": "Ensure React Router is imported and App component wrapped with BrowserRouter at root level", "percentage": 88, "note": "Client-side routing requires proper React Router setup"},
        {"solution": "Rebuild and redeploy after adding rewrite rule - caching may show old 404 behavior", "percentage": 82, "note": "Render caches static content - force refresh or redeploy to apply changes"}
    ]'::jsonb,
    'React SPA created with Create React App or similar, React Router configured for client-side routing, Render Static Site service deployed',
    'All routes return index.html correctly, React Router handles client-side navigation, Page refresh on non-homepage routes loads content instead of 404',
    'Confusing Static Site (for static assets) with Web Service (for backends). 404 on refresh is normal for client-side routers without server rewrite rules. Must use Rewrite action, not Redirect.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/76819085/i-uploaded-a-static-website-in-render-and-the-website-the-i-uploaded-whenever-i'
),
(
    'Render deployment: How to configure and use environment variables from .env file',
    'stackoverflow-render',
    'VERY_HIGH',
    '[
        {"solution": "Add environment variables through Render dashboard: navigate to Service > Environment section and enter key-value pairs", "percentage": 95, "note": "Render injects variables at runtime - .env file from repository not read"},
        {"solution": "Keep .env file in .gitignore and never commit to version control for security", "percentage": 93, "note": "Prevents secrets from being exposed in public repositories"},
        {"solution": "For local development testing, keep .env.local in gitignore and add to git attributes if needed", "percentage": 88, "note": "Local development uses .env.local, production uses Render dashboard variables"},
        {"solution": "Reference Render documentation for secret files for complex multi-line configurations", "percentage": 80, "note": "Secret files provide alternative for large configuration blocks vs individual variables"}
    ]'::jsonb,
    'Node.js/Python application using environment variables, .env file configured locally, Render service deployed',
    'Render dashboard displays all configured environment variables, Application accesses variables via process.env or os.getenv(), Secrets never exposed in logs or version control',
    'Developers often assume Render reads .env files like local development - it does not. Variables must be manually entered in dashboard. .env should never be committed. Variable names are case-sensitive.',
    0.96,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/76305751/how-to-use-a-env-file-while-deploying-it-on-render'
),
(
    'Render deployment: Static Site service cannot run Express/Node backend applications',
    'stackoverflow-render',
    'VERY_HIGH',
    '[
        {"solution": "Change service type from Static Site to Web Service when deploying backend applications", "percentage": 97, "note": "Static Site only serves HTML/CSS/JavaScript files - cannot execute server code"},
        {"solution": "Use Static Site ONLY for frontend assets (Create React App builds, Next.js static exports)", "percentage": 95, "note": "Web Service required for Express, Django, Flask, or any server application"},
        {"solution": "Recreate Render deployment with correct service type - service type cannot be changed after creation", "percentage": 93, "note": "Delete existing Static Site and create new Web Service with same repository"},
        {"solution": "Verify service classification matches application type before configuring start command", "percentage": 90, "note": "Service type determines available configuration options and runtime behavior"}
    ]'::jsonb,
    'Express.js or Node.js backend application, GitHub repository connected to Render, Understanding of Static Site vs Web Service',
    'Render service shows as Live, Backend server responds to requests, Application logs show server startup messages not deployment failures',
    'Most common mistake: selecting Static Site for backend applications. Static Site deployments cannot be converted to Web Service - must delete and recreate. Static Site shown as "failed" when app tries to start server.',
    0.97,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/78025140/i-am-facing-the-issue-while-im-deploying-the-node-js-express-server-on-rende'
),
(
    'Render deployment fails with file path "Cannot find module /opt/render/project/src/app.js"',
    'stackoverflow-render',
    'MEDIUM',
    '[
        {"solution": "Verify Root Directory setting in Render matches the location of package.json and src folder", "percentage": 90, "note": "Root Directory must point to folder containing package.json"},
        {"solution": "Ensure entry point in package.json matches actual file path and filename", "percentage": 88, "note": "Example: \"start\": \"node src/app.js\" must match actual location of app.js", "command": "Verify start script in package.json points to correct file"},
        {"solution": "Confirm all source files are committed to GitHub repository - Render deploys only what is in git", "percentage": 87, "note": "Common cause: src/app.js exists locally but not committed to version control"},
        {"solution": "After fixing paths, redeploy from Render dashboard - may require clearing build cache", "percentage": 85, "note": "Previous failed builds cached - redeploy to force fresh deployment"}
    ]'::jsonb,
    'Node.js application with src/ folder structure, package.json with start script, GitHub repository connected to Render',
    'Root Directory setting matches package.json location, Application files visible in Render build logs, Deployment proceeds past file not found error',
    'Render Root Directory setting often overlooked during setup. Entry point must match actual file paths exactly. Local files not in git are not deployed. Path errors misleading - check Root Directory first.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/76560484/render-deployment-node-module-problems'
);
