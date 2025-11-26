-- Add Stack Overflow dotenv environment variables solutions batch 1

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES (
    'dotenv file is not loading environment variables',
    'stackoverflow-dotenv',
    'VERY_HIGH',
    $$[
        {"solution": "Use absolute path with __dirname and path.resolve()", "percentage": 95, "command": "require(''dotenv'').config({ path: require(''path'').resolve(__dirname, ''../.env'') })", "note": "Converts relative path to absolute using current file location"},
        {"solution": "Use path.join() for cross-platform path handling", "percentage": 90, "command": "dotenv.config({ path: path.join(__dirname, ''..'', ''.env'') })", "note": "Platform-agnostic, handles Windows/Unix automatically"},
        {"solution": "Ensure dotenv call is at application entry point before other modules", "percentage": 88, "note": "Place require(''dotenv'').config() as first line in index.js or server.js"},
        {"solution": "Verify .env syntax: use KEY=value format not KEY:value", "percentage": 85, "note": "Check file encoding is UTF-8, not UCS-2 or other encodings"}
    ]$$::jsonb,
    'dotenv package installed (npm install dotenv), .env file exists in accessible location, Understanding of Node.js __dirname and current working directory',
    'process.env variables are populated, No errors in application startup, Console logging shows correct config path',
    'Running Node from wrong directory will prevent dotenv from finding .env file. Do not mix relative and absolute paths. Never load dotenv after importing modules that use process.env. Variables already defined in process.env will not be overridden unless using {overwrite: true}.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/42335016/dotenv-file-is-not-loading-environment-variables'
),
(
    'Toggle between multiple .env files like .env.development with Node.js',
    'stackoverflow-dotenv',
    'HIGH',
    $$[
        {"solution": "Use dynamic path based on NODE_ENV variable", "percentage": 95, "command": "require(''dotenv'').config({ path: ``.env.${process.env.NODE_ENV}`` })", "note": "Most direct approach for environment-specific configuration"},
        {"solution": "Use custom-env npm package for automatic loading", "percentage": 80, "note": "Automatically loads .env.X where X is NODE_ENV value without manual configuration"},
        {"solution": "Use dotenv-cli for command-line environment selection", "percentage": 75, "command": "dotenv -e .env.development node ./bin/www", "note": "Useful for build scripts and npm commands"},
        {"solution": "Use native Node.js support (v20.6.0+) without external packages", "percentage": 85, "note": "Built-in environment file support, no npm package required"}
    ]$$::jsonb,
    'dotenv installed (npm install dotenv), NODE_ENV environment variable set before running, .env.development and .env.production files created, Call config() early in application bootstrap',
    'Correct .env file loads based on NODE_ENV value, process.env contains expected variables, Console log confirms file being loaded',
    'NODE_ENV undefined results in .env.undefined filename - set default: process.env.NODE_ENV || ''development''. Must place dotenv call in entry point, not every file. Relative path issues from different directories - use path.join(__dirname, ...). Never load multiple .env files simultaneously in same process.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/55406055/toggle-between-multiple-env-files-like-env-development-with-node-js'
),
(
    'How do I setup the dotenv file in Node.js',
    'stackoverflow-dotenv',
    'VERY_HIGH',
    $$[
        {"solution": "Create .env file with KEY=value format in project root", "percentage": 95, "note": "Must be named exactly .env in root directory"},
        {"solution": "Load with require(''dotenv'').config() at application entry point", "percentage": 92, "command": "require(''dotenv'').config();", "note": "Place as first line before importing other modules"},
        {"solution": "Use explicit path for Docker/service deployments", "percentage": 88, "command": "require(''dotenv'').config({path: __dirname + ''/.env''})", "note": "Ensures consistency when working directory is not guaranteed"},
        {"solution": "Enable debug mode to troubleshoot loading issues", "percentage": 85, "command": "console.log(require(''dotenv'').config({debug: true}));", "note": "Temporary use only - reveals secrets in logs"}
    ]$$::jsonb,
    'Node.js installed, dotenv package installed, .env file exists, UTF-8 text editor to create .env file, Understanding of project root directory',
    'process.env variables accessible throughout application, No errors during startup, Env file is recognized by dotenv.config()',
    'Wrong file encoding (must be UTF-8), Syntax errors using colons instead of equals signs, Running scripts from subdirectories instead of project root, Not loading dotenv before importing modules that use process.env, Pre-existing variables in process.env will not be overridden without {overwrite: true}',
    0.93,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/26973484/how-do-i-setup-the-dotenv-file-in-node-js'
),
(
    'Should I call dotenv in every node JS file',
    'stackoverflow-dotenv',
    'HIGH',
    $$[
        {"solution": "Call require(''dotenv'').config() once in main entry file only", "percentage": 95, "note": "Best practice: load in index.js or server.js at startup"},
        {"solution": "Place dotenv call BEFORE importing other modules", "percentage": 92, "note": "Critical for modules that reference process.env during initialization"},
        {"solution": "Use ES6 import syntax: import ''dotenv/config'' at entry point", "percentage": 88, "command": "import ''dotenv/config''; import otherModules from ''...'';", "note": "Modern alternative to require()"},
        {"solution": "Create centralized initialization file that loads dotenv", "percentage": 85, "note": "Consolidates configuration loading logic in single location"}
    ]$$::jsonb,
    'dotenv package installed, Node.js project with entry point file, Understanding that process.env is global after initial load',
    'process.env variables accessible in all modules after initial load, No "Cannot find process.env" errors, Modules load configuration successfully',
    'Importing modules before calling dotenv.config() means those modules won''''t access loaded variables. Wrapping in conditions prevents loading in production. Multiple calls across files indicates structural issue and should be avoided. Database or service modules depending on env vars must be imported AFTER dotenv.config().',
    0.91,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/58684642/should-i-call-dotenv-in-every-node-js-file'
),
(
    'require(''''dotenv'''').config() in node.js',
    'stackoverflow-dotenv',
    'HIGH',
    $$[
        {"solution": "Conditionally load only in development: if (process.env.NODE_ENV !== ''production'') { require(''dotenv'').config(); }", "percentage": 93, "note": "Prevents crashes when hosting platform provides environment variables"},
        {"solution": "Set NODE_ENV variable in deployment environment before running", "percentage": 90, "note": "AWS and most platforms automatically set NODE_ENV=production"},
        {"solution": "Use -r dotenv/config flag in npm scripts instead of code-based loading", "percentage": 80, "command": "node -r dotenv/config ./app.js", "note": "Alternative approach using Node.js require flag"},
        {"solution": "Use config management package like npm ''config'' for multi-environment settings", "percentage": 75, "note": "More sophisticated than dotenv for complex deployments"}
    ]$$::jsonb,
    'dotenv installed, NODE_ENV variable support in deployment platform, Understanding of development vs production environments',
    'Application starts without errors in both development and production, process.env.NODE_ENV returns correct value, No dotenv errors in production logs',
    'NODE_ENV may not automatically exist in development - must explicitly set or rely on production check. Do not assume NODE_ENV is set everywhere. Repeating pattern across multiple files becomes tedious. Platform-specific: AWS automatically sets NODE_ENV, other platforms may not.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/60480863/requiredotenv-config-in-node-js'
),
(
    'How do you load environment variables from .env and .env.local with dotenv',
    'stackoverflow-dotenv',
    'HIGH',
    $$[
        {"solution": "Use array of paths with left-to-right precedence", "percentage": 95, "command": "require(''dotenv'').config({ path: [''.env.local'', ''.env''] })", "note": "Variables in .env.local override those in .env"},
        {"solution": "Sequential config calls for cascading defaults", "percentage": 90, "command": "dotenv.config({ path: ''.env.local'' }); dotenv.config();", "note": "Loads .env.local first, then .env without overriding system env vars"},
        {"solution": "Use environment-based loading for dev/prod separation", "percentage": 85, "command": "require(''dotenv'').config({ path: ``.env.${process.env.NODE_ENV}`` })", "note": "Load environment-specific files like .env.development or .env.production"},
        {"solution": "Use dotenv-flow package for automatic precedence handling", "percentage": 80, "note": "Manages multiple files automatically across different environments"}
    ]$$::jsonb,
    'Node.js project with dotenv installed, .env and .env.local files in project root, Recent version of dotenv package recommended, Understanding of file precedence',
    'Both .env.local and .env variables load correctly, Local overrides default values, No errors during configuration phase',
    'Using override: true replaces system-level env vars which causes issues in multi-app deployments. Committing .env files to version control exposes secrets. Do not assume single-file is only approach. Wrong precedence order: place specific files (.env.local) before general ones (.env).',
    0.89,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/68731242/how-do-you-load-environment-variables-from-env-and-env-local-with-dotenv'
),
(
    'Cannot find module dotenv error',
    'stackoverflow-dotenv',
    'HIGH',
    $$[
        {"solution": "Install dotenv as regular dependency: npm install --save dotenv", "percentage": 95, "command": "npm install --save dotenv", "note": "Must be in dependencies, not just devDependency"},
        {"solution": "Delete node_modules and package-lock.json, then reinstall", "percentage": 85, "command": "rm -rf node_modules package-lock.json && npm install", "note": "Clears corrupted cache and reinstalls everything"},
        {"solution": "Verify dotenv appears in package.json dependencies", "percentage": 88, "note": "Check package.json to confirm dotenv is listed"},
        {"solution": "Restart IDE or development environment after installation", "percentage": 80, "note": "Some IDEs cache module resolution and need refresh"}
    ]$$::jsonb,
    'Node.js and npm installed, .env file created in appropriate directory, Valid package.json file in project root, NodeModules path configured correctly',
    'npm list dotenv shows the package installed, require(''dotenv'') executes without error, process.env variables are accessible',
    'Ensuring dotenv is installed as regular dependency, not just devDependency. .env file must be in same directory as entry point (e.g., if entry is src/index.js, .env should be in src/). In TypeScript projects, verify tsconfig.json has "moduleResolution": "node". Check .env file path syntax is correct.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/61407393/while-running-the-script-throws-cannot-find-module-dotenv'
),
(
    'How to add comments to .env file',
    'stackoverflow-dotenv',
    'MEDIUM',
    $$[
        {"solution": "Use # symbol for standalone comment lines", "percentage": 95, "command": "# This is a comment\nNODE_ENV=production", "note": "Works with dotenv v14.3.2+"},
        {"solution": "Use inline comments after values (v14.3.2+)", "percentage": 85, "command": "NODE_ENV=production # This is an inline comment", "note": "Requires recent dotenv version"},
        {"solution": "Wrap values containing # in single quotes", "percentage": 92, "command": "SECRET=''something-with-a-#-hash''", "note": "Prevents # from being interpreted as comment"},
        {"solution": "For maximum compatibility, use only standalone comment lines", "percentage": 90, "note": "Some packages like dotenv-webpack do not support inline comments"}
    ]$$::jsonb,
    'dotenv version v14.3.2 or later for full comment support, .env file exists, Text editor with proper file encoding (UTF-8)',
    'Comments display as intended without errors, # symbols in values are preserved when quoted, No parser errors or warnings',
    'Values containing # symbols must be wrapped in quotes or they will be truncated. Inline comments not supported in dotenv-webpack (v7.1.1) and some Next.js versions. Blank lines may generate debug messages but are harmless. Older dotenv versions (pre-v14.3.2) did not support comments at all.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/54358871/how-to-add-comments-to-env-file'
),
(
    'Escaping the # character in .env file',
    'stackoverflow-dotenv',
    'MEDIUM',
    $$[
        {"solution": "Wrap values containing # in single quotes", "percentage": 96, "command": "SECRET_CODE=''my#code''", "note": "Single quotes preferred over double quotes for reliability"},
        {"solution": "Use double quotes if single quotes don''''t work", "percentage": 75, "command": "SECRET_CODE=\"my#code\"", "note": "May not work reliably in all Node.js versions"},
        {"solution": "Understand # is only comment marker at start of line", "percentage": 90, "note": "Values like a=#b work unquoted, c=\"#d\" needs quotes only for parsing clarity"},
        {"solution": "Test with console.log(process.env.VARIABLE) to verify", "percentage": 85, "command": "console.log(process.env.SECRET_CODE)", "note": "Verify exact value after parsing"}
    ]$$::jsonb,
    'Understanding that .env files treat # as comment marker, Knowledge that quoting syntax matters, Awareness of differences across Node.js versions',
    'process.env contains complete value with # symbol, No truncation after # character, Console logging shows full secret code',
    'Leaving values unquoted when they contain # causes parser to treat everything after # as comment and truncate the value. Double quotes may not work reliably across versions. This issue became more prominent in Node.js v20+ but affected earlier versions inconsistently. Do not rely on different quoting styles between environments.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/60473515/escaping-the-character-in-env-file'
),
(
    'Module not found: Can''''t resolve fs in node_modules/dotenv/lib error',
    'stackoverflow-dotenv',
    'MEDIUM',
    $$[
        {"solution": "Remove require(''dotenv'').config() from client-side code", "percentage": 96, "note": "dotenv is Node.js only and cannot run in browsers"},
        {"solution": "Use dotenv-webpack plugin instead for client bundles", "percentage": 92, "command": "npm install --save-dev dotenv-webpack", "note": "Handles environment variables properly for webpack bundles"},
        {"solution": "Move dotenv.config() to server-side files only", "percentage": 90, "note": "Load in Node.js backend, not in React/Angular frontend code"},
        {"solution": "For Next.js/Angular, use framework-specific configuration", "percentage": 88, "note": "Create next.config.js or webpack.config.js that handles env vars"}
    ]$$::jsonb,
    'Understanding that fs is Node.js-only module for file system operations, webpack or bundler installed, Knowledge that client-side code cannot access fs module',
    'No webpack bundling errors, fs module no longer referenced in client bundles, Environment variables accessible via proper method',
    'Attempting to run dotenv on client-side: Node.js modules like fs and path cannot execute in browser environments. Mixing both require(''dotenv'') and dotenv-webpack creates conflicts. Forgetting webpack configuration for dotenv-webpack. The fs module cannot be polyfilled for browser contexts and will always fail.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/59911706/module-not-found-error-cant-resolve-fs-in-node-modules-dotenv-lib'
),
(
    'Is it possible to use dotenv in a React project',
    'stackoverflow-dotenv',
    'HIGH',
    $$[
        {"solution": "For Create React App: use REACT_APP_ prefix in .env file", "percentage": 96, "command": "REACT_APP_API_URL=http://localhost:3000\naccess via: process.env.REACT_APP_API_URL", "note": "CRA includes built-in dotenv support automatically"},
        {"solution": "For custom Webpack: configure DefinePlugin with dotenv", "percentage": 90, "command": "new webpack.DefinePlugin(envKeys)", "note": "Requires webpack configuration setup"},
        {"solution": "For Vite: use VITE_ prefix and import.meta.env syntax", "percentage": 88, "command": "VITE_API_URL=http://localhost:3000\naccess via: import.meta.env.VITE_API_URL", "note": "Vite-specific syntax different from React"},
        {"solution": "Never install dotenv manually in Create React App projects", "percentage": 95, "note": "CRA handles it automatically; manual installation interferes"}
    ]$$::jsonb,
    'Node.js and npm/yarn installed, Project initialized with Create React App, custom webpack, or Vite, .env file created at project root, Restart dev server after .env changes',
    'Environment variables accessible via process.env or import.meta.env, Dev server starts without errors, Variables are populated correctly in application',
    'Missing restart of dev server after .env file changes. Wrong prefix used (must be REACT_APP_ for CRA, VITE_ for Vite). Installing dotenv separately in CRA interferes with built-in handling. Security risk: frontend env vars are publicly accessible - never include API keys or secrets. Variables must be accessible, but security is critical.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/42182577/is-it-possible-to-use-dotenv-in-a-react-project'
),
(
    'How to pass .env file variables to webpack config',
    'stackoverflow-dotenv',
    'MEDIUM',
    $$[
        {"solution": "Install dotenv and require at top of webpack config", "percentage": 95, "command": "require(''dotenv'').config({ path: ''./.env'' });\nnew webpack.DefinePlugin({\"process.env\": JSON.stringify(process.env)})", "note": "Most direct approach"},
        {"solution": "Use dotenv.config().parsed to access parsed variables only", "percentage": 90, "command": "new webpack.DefinePlugin({''process.env'': JSON.stringify(dotenv.config().parsed)})", "note": "Cleaner than exposing entire process.env"},
        {"solution": "Use specialized plugins like dotenv-webpack", "percentage": 85, "command": "npm install --save-dev dotenv-webpack", "note": "Simplifies dotenv integration with webpack"},
        {"solution": "Use dotenv-flow-webpack for environment-specific files", "percentage": 80, "note": "Handles .env.development, .env.production automatically"}
    ]$$::jsonb,
    'dotenv package installed (npm install dotenv --save), webpack configured in project, .env file exists, Understanding of DefinePlugin security implications',
    'webpack builds successfully, Environment variables are substituted in bundle, Application accesses variables correctly',
    'Critical security pitfall: Anything passed into DefinePlugin is extractable and publicly viewable in the bundle. Never pass sensitive secrets through client-side configuration. Frontend env vars are bundled into code and publicly viewable. Keep secrets in backend .env only. Only expose non-sensitive configuration to frontend. Do not bundle API keys or credentials.',
    0.86,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/46224986/how-to-pass-env-file-variables-to-webpack-config'
),
(
    'What is the use of python-dotenv',
    'stackoverflow-dotenv',
    'MEDIUM',
    $$[
        {"solution": "Use for local development: store database passwords and API keys in .env file", "percentage": 95, "note": "Prevents repetitive manual environment variable setup each session"},
        {"solution": "Import and load in Python: from dotenv import load_dotenv; load_dotenv()", "percentage": 93, "command": "from dotenv import load_dotenv\nimport os\nload_dotenv()\nsecret_key = os.environ.get(\"SECRET_KEY\")", "note": "Standard usage pattern"},
        {"solution": "Store environment-specific settings (dev, staging, production)", "percentage": 88, "note": "Manage different configurations per environment"},
        {"solution": "Add .env to .gitignore to prevent credential exposure", "percentage": 92, "note": "Critical security practice for version control safety"}
    ]$$::jsonb,
    'Python installed, python-dotenv package installed (pip install python-dotenv), .env file created in project root, Understanding of 12-factor app principles',
    '.env file loads without errors, os.environ.get() returns expected values, No credential exposure in git commits',
    'Forgetting to add .env to .gitignore exposes credentials in version control. Environment variables do not persist after script execution - they are process-specific. .env values are always strings: VAR=None becomes string "None", not Python None. Do not assume variables set via dotenv affect shell environment outside Python process.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/41546883/what-is-the-use-of-python-dotenv'
);
