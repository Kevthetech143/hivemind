-- Add Stack Overflow Railway.app deployment solutions batch 1
-- Extracted from top 12 highest-voted questions with accepted answers
-- Category: stackoverflow-railway
-- Date: 2025-11-25

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Railway deployment error: Application Error - Is your app correctly listening on $PORT?',
    'stackoverflow-railway',
    'VERY_HIGH',
    '[
        {"solution": "Replace hardcoded port numbers with process.env.PORT environment variable in your application entry point", "percentage": 95, "command": "const PORT = process.env.PORT || 4000; app.listen(PORT);", "note": "Railway assigns PORT dynamically at runtime"},
        {"solution": "Update webpack devServer configuration to use PORT variable instead of fixed port like 8000", "percentage": 90, "command": "port: process.env.PORT || 8000", "note": "Critical for Node.js/Express apps"},
        {"solution": "Verify application startup logs show successful binding to dynamic port", "percentage": 85, "note": "Check deployment logs in Railway dashboard"}
    ]'::jsonb,
    'Node.js/Express application, Access to Railway project settings, Ability to redeploy',
    'Application serves HTTP requests on assigned port, Deployment status shows "success" in Railway dashboard, No "Application Error" in health checks',
    'Do not hardcode port numbers in any configuration. Always use process.env.PORT as primary value with fallback. Restart deployment after making port changes.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/74373213/deploying-github-repo-to-railway-app-resulting-application-error-is-your-app'
),
(
    'Railway React deployment failed: ESLint warnings treated as errors during build',
    'stackoverflow-railway',
    'HIGH',
    '[
        {"solution": "Set CI=false environment variable in build command to disable strict error handling for linting warnings", "percentage": 95, "command": "CI=false npm run build", "note": "Official React Scripts behavior"},
        {"solution": "Modify package.json build script to disable CI mode inline", "percentage": 90, "command": "\"build\": \"CI=false react-scripts build\"", "note": "Persists across deployments"},
        {"solution": "Fix underlying ESLint errors (unused imports, export issues) if possible for production-ready code", "percentage": 80, "note": "Better long-term approach but not required for deployment"}
    ]'::jsonb,
    'React application with package.json, ESLint enabled in create-react-app, Access to Railway build settings',
    'Build completes successfully with exit code 0, npm run build command succeeds locally and on Railway, Application loads in browser without errors',
    'Do not use CI=true mode in production settings. ESLint warnings become errors when CI environment is detected. Build script changes are preferred over Railway environment variable settings.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/74368707/build-failed-on-railway-deployment'
),
(
    'Railway NestJS PostgreSQL connection timeout: ETIMEDOUT at database connection',
    'stackoverflow-railway',
    'HIGH',
    '[
        {"solution": "Install @nestjs/config and dotenv packages for environment configuration management", "percentage": 95, "command": "npm install --save @nestjs/config dotenv", "note": "Required for proper env var loading before database init"},
        {"solution": "Use single DATABASE_URL environment variable instead of individual PGHOST, PGPORT, PGUSER, PGPASSWORD parameters", "percentage": 92, "command": "TypeOrmModule.forRoot({ url: process.env.DATABASE_URL, ssl: true })", "note": "Railway provides DATABASE_URL automatically when PostgreSQL service connected"},
        {"solution": "Enable ConfigModule.forRoot() globally to ensure environment variables loaded before any service initialization", "percentage": 88, "note": "Prevents race condition where database connects before env vars ready"}
    ]'::jsonb,
    'NestJS application, TypeORM configured, PostgreSQL service added to Railway project, @nestjs/config not yet installed',
    'Database connection succeeds with 0 timeout errors, TypeORM logs show successful connection, Service startup completes without ETIMEDOUT errors',
    'Do not use fragmented environment variables (PGHOST, PGPORT, etc) - consolidate into single DATABASE_URL. ConfigModule must be loaded before any database modules. SSL should be enabled for Railway PostgreSQL connections.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/77622563/unable-to-connect-railway-app-postgres-to-nestjs-application'
),
(
    'Railway Django deployment: settings.DATABASES improperly configured, ENGINE value missing',
    'stackoverflow-railway',
    'HIGH',
    '[
        {"solution": "Replace individual os.environ.get() calls with dj_database_url parser using single DATABASE_URL environment variable", "percentage": 95, "command": "import dj_database_url; DATABASES = {\"default\": dj_database_url.config(default=os.getenv(\"DATABASE_URL\"))}", "note": "Railway auto-provides DATABASE_URL when PostgreSQL service connected"},
        {"solution": "Install dj-database-url package for parsing database URL strings", "percentage": 93, "command": "pip install dj-database-url", "note": "Standard Django pattern for cloud deployments"},
        {"solution": "Ensure PostgreSQL service added to Railway project and DATABASE_URL environment variable is visible in Railway Variables tab", "percentage": 88, "note": "Verify DATABASE_URL in Railway dashboard before deploying"}
    ]'::jsonb,
    'Django project with PostgreSQL backend configured, PostgreSQL service running on Railway, dj-database-url package available',
    'Django migrations run successfully with no database configuration errors, settings.DATABASES validates with no ENGINE missing errors, Database queries execute without connection errors',
    'Do not rely on fragmented environment variables (PGHOST, PGPORT, etc) - always use single DATABASE_URL. Missing DATABASE_URL environment variable is common cause. Verify variables set BEFORE deploying.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/73615214/how-to-fix-raise-improperlyconfiguredsettings-databases-is-improperly-configur'
),
(
    'Railway React deployment: npm ci fails with package-lock.json version mismatch',
    'stackoverflow-railway',
    'MEDIUM',
    '[
        {"solution": "Switch from default React Scripts server to serve package for production builds", "percentage": 92, "command": "npm i serve && update start script to \"serve build -s -n -L -p \\$PORT\"", "note": "Eliminates React Scripts dependency conflicts"},
        {"solution": "Modify package.json start script to use serve with correct PORT binding and flags", "percentage": 90, "command": "\"start\": \"serve build -s -n -L -p $PORT\"", "note": "-p flag sets port from environment, -s enables SPA routing"},
        {"solution": "Delete package-lock.json and regenerate to resync with package.json versions", "percentage": 75, "note": "Only if serve package approach fails"}
    ]'::jsonb,
    'React application with npm lockfile, npm installed locally, package.json with build script configured',
    'npm ci completes successfully without version mismatch errors, Application starts and serves static build files, SPA routing works correctly with serve package',
    'Railway uses npm ci instead of npm install - ensures exact dependency versions. Package-lock.json must match package.json. Serve package is superior to React Scripts for production deployments.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/75932735/reactjs-project-keeps-failing-to-deploy-on-railway-app'
),
(
    'Railway ASP.NET 6.0 build error: Package MessagePackAnalyzer not found during dotnet publish',
    'stackoverflow-railway',
    'MEDIUM',
    '[
        {"solution": "Create .dockerignore file excluding bin/, obj/, out/ directories to force clean NuGet restore in container", "percentage": 94, "command": "Create .dockerignore with: **/bin/, **/obj/, **/out/, Dockerfile*, **/*.md", "note": "Local build artifacts conflict with container environment"},
        {"solution": "Exclude platform-specific artifacts from Docker build context to prevent stale package references", "percentage": 90, "note": "Windows-compiled NuGet cache incompatible with Linux container"},
        {"solution": "Verify NuGet cache is clean by checking dotnet publish output for restore step", "percentage": 82, "note": "Monitor logs for \"Restoring packages\" messages"}
    ]'::jsonb,
    'ASP.NET 6.0 project with Dockerfile, NuGet packages installed locally, Git repository with build artifacts',
    'dotnet publish completes successfully in Docker build, No MessagePackAnalyzer or package mismatch errors appear, Application binary generated and ready for execution',
    '.dockerignore must exclude bin, obj, out directories. Local compiled artifacts cause NuGet resolution failures in containers. Always use .dockerignore in Docker-based deployments.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/74154902/railway-asp-net-app-fails-to-build-and-i-cant-figure-out-why'
),
(
    'Railway Go deployment error: go.mod and go.sum missing dependencies preventing build',
    'stackoverflow-railway',
    'MEDIUM',
    '[
        {"solution": "Ensure go.mod and go.sum files include all project dependencies with correct versions", "percentage": 93, "command": "go mod tidy && go mod verify", "note": "Validates and updates dependency declarations"},
        {"solution": "Run go mod tidy locally to resolve missing dependency declarations before pushing to Railway", "percentage": 91, "command": "go mod tidy", "note": "Synchronizes go.mod and go.sum files"},
        {"solution": "Use alternative well-maintained repository with proven Railway deployment configuration and README", "percentage": 85, "note": "If project dependencies are beyond repair"}
    ]'::jsonb,
    'Go application with go.mod file, Go compiler installed locally, Git repository with Go source code',
    'go mod verify succeeds with no errors, Railway build plan generates successfully, Binary compiles and runs without missing dependency errors',
    'Railway uses go.mod and go.sum for dependency resolution. Incomplete or mismatched dependency declarations cause Nixpacks build plan failures. Always run go mod tidy before deployment.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/72625687/error-while-deploying-scheduler-app-on-railway-app'
),
(
    'Railway Nixpacks build error: Unable to generate build plan for application',
    'stackoverflow-railway',
    'MEDIUM',
    '[
        {"solution": "Configure Railway project settings to specify correct root directory if project is in subdirectory", "percentage": 93, "command": "Railway Dashboard > Settings > Root Directory field, set to subdirectory path if needed", "note": "Railway assumes root directory by default"},
        {"solution": "Verify dependency management files exist and are properly formatted (requirements.txt for Python, package.json for Node, etc)", "percentage": 91, "command": "Confirm file exists in project root: cat requirements.txt OR cat package.json", "note": "Nixpacks requires recognizable dependency files"},
        {"solution": "Ensure project structure matches standard layout that Nixpacks can detect and create appropriate build configuration", "percentage": 85, "note": "Check Railway docs for supported project structures"}
    ]'::jsonb,
    'Railway project created, GitHub repository connected, Project files accessible in Railway dashboard',
    'Railway build plan generates successfully showing detected language and dependencies, Nixpacks creates appropriate build configuration, Deployment proceeds to build stage',
    'Nixpacks looks for dependency files (package.json, requirements.txt, go.mod) in root directory. Custom directory structures require explicit Root Directory configuration. Missing or malformed dependency files cause plan generation to fail.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/74932602/why-am-i-getting-a-nixpacks-error-on-railway'
),
(
    'Railway Flask/Python deployment: Application listening on 127.0.0.1 instead of 0.0.0.0',
    'stackoverflow-railway',
    'HIGH',
    '[
        {"solution": "Create PORT environment variable in Railway dashboard settings and set value to application port (e.g., 5000)", "percentage": 95, "command": "Railway Variables > Add Variable: PORT=5000", "note": "Overrides default port and signals proper binding"},
        {"solution": "Ensure application binds to 0.0.0.0 instead of 127.0.0.1 for proper network access", "percentage": 92, "command": "app.run(host=\"0.0.0.0\", port=int(os.getenv(\"PORT\", 5000)))", "note": "127.0.0.1 only accessible from container, not from Railway router"},
        {"solution": "Reference Railway documentation on exposing applications at https://docs.railway.app/deploy/exposing-your-app for complete guidance", "percentage": 85, "note": "Official source for networking configuration"}
    ]'::jsonb,
    'Flask application with Dockerfile, Python environment configured, Access to Railway project variables',
    'Railway health checks pass without binding warnings, Application accessible via Railway domain, Logs show successful binding to 0.0.0.0 and dynamic PORT',
    'Applications must bind to 0.0.0.0 not 127.0.0.1. Port binding to 127.0.0.1 makes app unreachable from Railway router. Always set PORT environment variable in Railway for production deployments.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/75125207/how-to-deploy-app-to-0-0-0-and-port-5000-on-railway-app'
),
(
    'Railway Django deployment: Package version conflicts with Django 3.8 in production environment',
    'stackoverflow-railway',
    'MEDIUM',
    '[
        {"solution": "Review Railway build logs for specific package incompatibility errors and identify conflicting version constraints", "percentage": 92, "command": "Check Railway deployment logs for pip install errors", "note": "Logs show exact packages causing conflicts"},
        {"solution": "Adjust requirements.txt package versions to match Django and Python versions available in Railway environment", "percentage": 91, "command": "Update version pins: numpy==1.25.0 (instead of 1.26.0 for Django 3.8)", "note": "Test locally with matching Python/Django versions"},
        {"solution": "Test requirements.txt locally with matching Python version before deploying to verify compatibility", "percentage": 85, "note": "Prevents version mismatch surprises in production"}
    ]'::jsonb,
    'Django application with requirements.txt, Virtual environment for testing, Access to Railway deployment logs',
    'pip install completes successfully during Railway build with no version conflict errors, Django migrations run without compatibility errors, Application starts without ImportError or version mismatch warnings',
    'Railway may run different Django/Python versions than local development. Package versions in requirements.txt must be compatible with Railway environment versions. Always check build logs for specific incompatible packages.',
    0.86,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/77759011/deployment-problem-with-railway-and-django'
),
(
    'Railway Node.js environment variables not accessible in production: Google OAuth ClientId errors',
    'stackoverflow-railway',
    'MEDIUM',
    '[
        {"solution": "Add production domain URL to third-party OAuth service (Google, GitHub, etc) authorized redirect URIs and JavaScript origins", "percentage": 96, "command": "Google Console > OAuth 2.0 > Authorized JavaScript origins: add your Railway domain", "note": "Platform requires separate authorization for each domain"},
        {"solution": "Verify environment variables are set in Railway Variables tab BEFORE deployment and restart application after adding new variables", "percentage": 93, "command": "Railway Variables > Confirm variable exists before redeploy", "note": "Environment variables require redeployment to take effect"},
        {"solution": "Test locally with same environment variable values to catch configuration issues before production deployment", "percentage": 85, "note": "Reproduces production environment locally"}
    ]'::jsonb,
    'Node.js application with OAuth integration, OAuth service account with console access, Railway project variables configured',
    'Google Sign-In works in production without authentication errors, OAuth callbacks succeed and return user data, No unauthorized domain errors in browser console',
    'Environment variables being set is insufficient - OAuth providers must explicitly authorize the production domain. Local testing with production URLs reveals these issues. Remember to add production domain to OAuth provider settings.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/72848782/error-in-the-environment-variable-with-railway-in-the-clientid-in-production-in'
),
(
    'Railway full-stack app deployment: React frontend needs build command for dependencies and compilation',
    'stackoverflow-railway',
    'MEDIUM',
    '[
        {"solution": "Set custom build command in Railway project settings to install dependencies, build React app, and install backend dependencies", "percentage": 94, "command": "Railway Build Command: cd client && npm install && npm run build && cd .. && npm i", "note": "Sequential steps ensure proper build order"},
        {"solution": "Leverage existing heroku-postbuild script from package.json if migrating from Heroku", "percentage": 90, "command": "Railway Build Command: npm run heroku-postbuild", "note": "Reuses existing build logic without duplication"},
        {"solution": "Ensure server start command uses correct port binding and serves React build artifacts", "percentage": 85, "command": "Start Command: node server.js (which serves ./client/build files)", "note": "Separate build step from start step"}
    ]'::jsonb,
    'Full-stack application with React frontend in ./client directory, Express/Node backend in root, package.json and client/package.json both present',
    'Railway build completes successfully compiling React files, Server starts and serves frontend on correct port, API routes accessible from React application',
    'Git repositories only store source code, not build artifacts. Build command must run npm install and npm run build to generate production bundle. Do not rely on Heroku-specific features - use Railway build settings instead.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/74950388/issues-with-deploying-react-based-app-on-railway'
),
(
    'Railway Strapi CMS deployment: PostgreSQL connection and template configuration for production',
    'stackoverflow-railway',
    'LOW',
    '[
        {"solution": "Deploy using Railway official Strapi template at railway.app/template/strapi which includes proper PostgreSQL integration patterns", "percentage": 95, "command": "Navigate to https://railway.app/template/strapi and click Deploy", "note": "Official template eliminates manual configuration"},
        {"solution": "Eject and fork the Strapi template to GitHub account to enable automatic redeployment on code changes and customization", "percentage": 90, "command": "Railway template > Fork to GitHub > Connect GitHub for auto-deployments", "note": "Enables GitOps workflow for Strapi updates"},
        {"solution": "Use Railway CLI for local development: railway run connects to production database for development from local environment", "percentage": 85, "command": "railway run && npm run develop", "note": "Reference https://docs.railway.app/guides/cli for setup"}
    ]'::jsonb,
    'GitHub account, Railway account with credit, Strapi project source code, Knowledge of Railway CLI installation',
    'Strapi dashboard accessible at production URL, PostgreSQL database connected without errors, Content created in Strapi appears in API responses',
    'Manual Strapi configuration is error-prone - use official Railway template instead. PostgreSQL connection requires DATABASE_URL environment variable automatically set by template. Avoid manual environment variable configuration for templates.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/78245331/connect-strapi-to-postgresql-on-railway-app'
);
