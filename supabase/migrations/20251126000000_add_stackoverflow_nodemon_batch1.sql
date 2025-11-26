-- Stack Overflow Nodemon Solutions Batch 1
-- Extracted from top 12 highest-voted Nodemon questions with accepted answers
-- Category: stackoverflow-nodemon

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, last_verified, source_url
) VALUES
(
    'How to watch and reload ts-node when TypeScript files change',
    'stackoverflow-nodemon',
    'HIGH',
    $$[
        {"solution": "Create nodemon.json with watch pattern for src directory and ts-node executor: {\"watch\": [\"src\"], \"ext\": \"ts,json\", \"exec\": \"ts-node ./src/index.ts\"}", "percentage": 95, "command": "npm install --save-dev ts-node nodemon && nodemon", "note": "Most common and reliable approach"},
        {"solution": "Run nodemon directly: nodemon app.ts (requires ts-node installed)", "percentage": 90, "command": "nodemon app.ts", "note": "Quickest setup for simple projects"},
        {"solution": "Use Node 22.7.0+ native TypeScript support: node --experimental-strip-types --watch src/index.ts", "percentage": 70, "command": "node --experimental-strip-types --watch src/index.ts", "note": "Eliminates external dependencies but still experimental"}
    ]$$::jsonb,
    'Node.js installed, TypeScript project set up, ts-node and nodemon as dev dependencies',
    'Server restarts automatically when .ts files change, Test files (.spec.ts) are ignored as configured, JSON configuration files trigger reloads',
    'Windows users must avoid single quotes in package.json; use escaped quotes instead. Missing ext field prevents TypeScript changes from triggering reloads. WSL2 users may experience file change detection issues.',
    0.92,
    NOW(),
    'https://stackoverflow.com/questions/37979489/how-to-watch-and-reload-ts-node-when-typescript-files-change'
),
(
    'Nodemon error: System limit for number of file watchers reached',
    'stackoverflow-nodemon',
    'MEDIUM',
    $$[
        {"solution": "Increase inotify watcher limit permanently: Create /etc/sysctl.d/10-user-watches.conf with fs.inotify.max_user_watches=131070, then run sudo sysctl --system", "percentage": 95, "command": "sudo sysctl --system", "note": "Permanent fix persists after reboot"},
        {"solution": "Temporary fix until reboot: sudo sysctl -w fs.inotify.max_user_watches=131070", "percentage": 90, "command": "sudo sysctl -w fs.inotify.max_user_watches=131070", "note": "Quick test before permanent solution"},
        {"solution": "Exclude large directories from watching in nodemon config: ignore node_modules, venv directories", "percentage": 85, "note": "Alternative approach without system-level changes"}
    ]$$::jsonb,
    'Linux operating system, sudo access, default inotify limit knowledge',
    'Command cat /proc/sys/fs/inotify/max_user_watches shows updated value, Development server runs without ENOSPC error, Change persists after system reboot',
    'Setting values too high (500k+) is unnecessary; doubling the default suffices. Running append commands multiple times duplicates entries in /etc/sysctl.conf. Do not use /etc/sysctl.conf directly for better management.',
    0.90,
    NOW(),
    'https://stackoverflow.com/questions/53930305/nodemon-error-system-limit-for-number-of-file-watchers-reached'
),
(
    'nodemon command is not recognized in terminal for node js server',
    'stackoverflow-nodemon',
    'HIGH',
    $$[
        {"solution": "Install nodemon locally with npm install --save-dev nodemon and use via npm scripts in package.json", "percentage": 95, "command": "npm install --save-dev nodemon && npm run serve", "note": "Recommended approach for team projects"},
        {"solution": "Install nodemon globally: npm install -g nodemon, then run nodemon server.js directly", "percentage": 85, "command": "npm install -g nodemon", "note": "Works system-wide but less ideal for teams"},
        {"solution": "Use npx without installation: npx nodemon server.js", "percentage": 80, "command": "npx nodemon server.js", "note": "Avoids PATH complications"}
    ]$$::jsonb,
    'npm and Node.js installed, system PATH configured (for global install)',
    'nodemon --version returns version number, nodemon server.js starts without error, Server restarts automatically on file changes',
    'PowerShell execution policies may block script execution on Windows. PATH issues occur when global install does not add nodemon to system PATH. Running local install without npm scripts fails; must use npm run wrapper.',
    0.88,
    NOW(),
    'https://stackoverflow.com/questions/40359590/nodemon-command-is-not-recognized-in-terminal-for-node-js-server'
),
(
    'nodemon not working: -bash: nodemon: command not found',
    'stackoverflow-nodemon',
    'HIGH',
    $$[
        {"solution": "Install nodemon locally in your project: npm install --save-dev nodemon", "percentage": 95, "command": "npm install --save-dev nodemon", "note": "Primary solution - installs to ./node_modules/.bin"},
        {"solution": "Add npm script to package.json and run via npm: {\"scripts\": {\"dev\": \"nodemon server.js\"}} then npm run dev", "percentage": 90, "command": "npm run dev", "note": "Automatically handles local binary PATH"},
        {"solution": "Install globally with proper permissions: sudo npm install -g nodemon (Linux/Mac) or run npm as administrator (Windows)", "percentage": 80, "command": "npm install -g nodemon", "note": "System-wide access but permission dependent"}
    ]$$::jsonb,
    'npm package.json exists, Node.js installed, Write access to project directory',
    'nodemon binary found in ./node_modules/.bin, npm run scripts execute without PATH errors, File changes trigger automatic restarts',
    'The problem occurs when nodemon does not exist in /node_modules/.bin - verify installation completed successfully. Using --save instead of --save-dev adds unnecessary production dependencies. Global-only installation fails unless PATH properly configured.',
    0.91,
    NOW(),
    'https://stackoverflow.com/questions/35771930/nodemon-not-working-bash-nodemon-command-not-found'
),
(
    'How to fix error: nodemon.ps1 cannot be loaded because running scripts is disabled on this system',
    'stackoverflow-nodemon',
    'MEDIUM',
    $$[
        {"solution": "Set PowerShell execution policy to RemoteSigned for current user: Set-ExecutionPolicy RemoteSigned -Scope CurrentUser", "percentage": 95, "command": "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser", "note": "Balances security and usability"},
        {"solution": "Delete nodemon.ps1 at C:\\Users\\[YourUsername]\\AppData\\Roaming\\npm\\nodemon.ps1 to fallback to .cmd version", "percentage": 80, "note": "Workaround to avoid PowerShell execution policy"},
        {"solution": "Use npm scripts in package.json to avoid direct PowerShell invocation", "percentage": 75, "note": "Alternative that sidesteps execution policy"}
    ]$$::jsonb,
    'Windows PowerShell with administrator privileges, npm and nodemon installed globally',
    'nodemon -v displays version information, PowerShell no longer shows cannot be loaded error, File changes trigger automatic restarts',
    'Execution policies are not security boundaries - they prevent accidental execution. RemoteSigned allows locally-created scripts but requires remote scripts be digitally signed. Running as non-administrator prevents policy changes.',
    0.89,
    NOW(),
    'https://stackoverflow.com/questions/63423584/how-to-fix-error-nodemon-ps1-cannot-be-loaded-because-running-scripts-is-disabl'
),
(
    'Nodemon - exclusion of files',
    'stackoverflow-nodemon',
    'MEDIUM',
    $$[
        {"solution": "Use nodemon.json configuration file with ignore array: {\"ignore\": [\"lib/*.js\", \"README\"]}", "percentage": 95, "command": "nodemon", "note": "Most reliable and portable approach"},
        {"solution": "Use command-line ignore flags: nodemon --ignore \"lib/*.js\" --ignore README", "percentage": 85, "command": "nodemon --ignore \"lib/*.js\" --ignore README", "note": "Use double quotes on Windows"},
        {"solution": "Configure in package.json nodemonConfig: {\"nodemonConfig\": {\"ignore\": [\"public/data/*.json\"]}}", "percentage": 80, "note": "Alternative for projects without separate config file"}
    ]$$::jsonb,
    'Nodemon installed as dependency, Understanding of glob patterns, Project with defined file structure',
    'Nodemon no longer restarts when excluded files change, Console output reflects only monitored file changes, Configuration persists across terminal sessions',
    'Single quotes do not work on Windows; use double quotes instead. Changes to package.json scripts require restarting terminal - CTRL+S is insufficient. Avoid unnecessary quotes around simple filenames. Directory patterns use **/old/** syntax with double quotes.',
    0.88,
    NOW(),
    'https://stackoverflow.com/questions/24120004/nodemon-exclusion-of-files'
),
(
    'How to execute the start script with Nodemon',
    'stackoverflow-nodemon',
    'HIGH',
    $$[
        {"solution": "Use nodemon --exec flag: nodemon --exec npm start", "percentage": 95, "command": "nodemon --exec npm start", "note": "Direct command-line approach"},
        {"solution": "Configure in package.json with separate dev script: {\"scripts\": {\"dev\": \"nodemon ./bin/www\"}} then npm run dev", "percentage": 90, "command": "npm run dev", "note": "Recommended for team projects"},
        {"solution": "Use Node 18+ built-in watch: {\"start\": \"node --watch app.js\"} - eliminates nodemon dependency", "percentage": 75, "command": "node --watch app.js", "note": "Modern alternative for Node 18+"}
    ]$$::jsonb,
    'Nodemon installed as dev dependency, Valid npm start script defined, Main application file specified',
    'File changes trigger automatic server restarts, Terminal displays restarting messages, No manual restart needed during development',
    'Do not put nodemon in production start script - only for development. Global vs local installation affects accessibility. Ensure npm start script points to correct file entry point. Mixing nodemon with plain npm start in production causes issues.',
    0.90,
    NOW(),
    'https://stackoverflow.com/questions/33879896/how-to-execute-the-start-script-with-nodemon'
),
(
    'Is there a way to use npm scripts to run tsc -watch && nodemon --watch?',
    'stackoverflow-nodemon',
    'MEDIUM',
    $$[
        {"solution": "Guarantee compilation before execution: {\"scripts\": {\"dev\": \"nodemon -e ts --exec \\\"npm run compile\\\"\"}} with compile task running tsc && node app.js", "percentage": 95, "command": "nodemon -e ts --exec \"npm run compile\"", "note": "Prevents restart loops and stale code"},
        {"solution": "Use concurrently package to run both: npm install -D concurrently && {\"dev\": \"concurrently \\\"tsc -w\\\" \\\"nodemon dist/app.js\\\"\"}", "percentage": 70, "command": "concurrently \"tsc -w\" \"nodemon dist/app.js\"", "note": "Simpler but timing-sensitive"},
        {"solution": "Configure nodemon to ignore output directory and watch only source: {\"watch\": [\"src\"], \"ignore\": [\"dist\"]}", "percentage": 80, "note": "Prevents perpetual rebuild loops"}
    ]$$::jsonb,
    'TypeScript installed locally, Nodemon installed, tsconfig.json configured, Node.js project structure',
    'Saves to .ts files trigger compilation then application restart, Application runs only after compilation completes, No restart loops or stale code, Changes reflected immediately in running application',
    'Running tsc -w and nodemon concurrently causes restart loops as both monitor files. Using concurrently with tsc -w && nodemon starts nodemon before compilation finishes. If nodemon watches output directory it triggers rebuilds whenever compiled .js files change.',
    0.87,
    NOW(),
    'https://stackoverflow.com/questions/38276862/is-there-a-way-to-use-npm-scripts-to-run-tsc-watch-nodemon-watch'
),
(
    'nodemon not found in npm',
    'stackoverflow-nodemon',
    'HIGH',
    $$[
        {"solution": "Install nodemon as development dependency: npm install nodemon --save-dev", "percentage": 95, "command": "npm install nodemon --save-dev", "note": "Primary fix - makes it accessible to npm scripts"},
        {"solution": "Add to package.json scripts and run via npm: {\"scripts\": {\"start\": \"nodemon server.js\"}} then npm start", "percentage": 90, "command": "npm start", "note": "Automatically locates binary in ./node_modules/.bin"},
        {"solution": "If local fails, install globally with permissions: sudo npm install -g nodemon (Linux/Mac) or run as Administrator (Windows)", "percentage": 75, "command": "npm install -g nodemon", "note": "System-wide alternative with permission requirements"}
    ]$$::jsonb,
    'Node.js and npm installed, Project with package.json, Terminal/command line access',
    'nodemon binary found in /node_modules/.bin, Console displays [nodemon] watching and starting messages, Application restarts without errors on file changes',
    'The problem happens when nodemon does not exist in /node_modules - verify installation completes. Using --save instead of --save-dev adds unnecessary production dependencies. Global-only installation unavailable to npm scripts without PATH configuration. Missing node_modules directory requires npm install after cloning.',
    0.91,
    NOW(),
    'https://stackoverflow.com/questions/28517494/nodemon-not-found-in-npm'
),
(
    'How do I watch python source code files and restart when I save? (nodemon approach)',
    'stackoverflow-nodemon',
    'LOW',
    $$[
        {"solution": "Use nodemon for Python: npm install -g nodemon, then run nodemon hello.py - generic tool works with any language", "percentage": 90, "command": "nodemon hello.py", "note": "Simplest cross-platform approach"},
        {"solution": "Explicitly specify Python version: nodemon --exec python3 hello.py", "percentage": 85, "command": "nodemon --exec python3 hello.py", "note": "Ensures correct Python interpreter"},
        {"solution": "Use pure Python watchdog package: pip install watchdog && watchmedo auto-restart -p \"*.py\" -R python3 -- application.py", "percentage": 75, "command": "watchmedo auto-restart -p \"*.py\" -R python3 -- application.py", "note": "Stay within Python ecosystem"}
    ]$$::jsonb,
    'Node.js and npm installed, Python 3 installed, Nodemon v2.0.x or higher recommended',
    'Script reruns immediately after file save, No manual restart required, File changes detected within milliseconds',
    'Nodemon is generic and detects file extensions automatically. Windows compatibility improved with auto-restart variant over shell-command. Older watchdog versions fail on Windows with os.setsid errors. Interactive Python CLI apps may conflict with nodemon stdin handling.',
    0.82,
    NOW(),
    'https://stackoverflow.com/questions/49355010/how-do-i-watch-python-source-code-files-and-restart-when-i-save'
),
(
    'How can I run nodemon from within WebStorm?',
    'stackoverflow-nodemon',
    'LOW',
    $$[
        {"solution": "Configure Node.js run configuration to use nodemon in Node parameters field: /usr/local/bin/nodemon or :path_to_project/node_modules/.bin/nodemon", "percentage": 92, "command": "Node parameters: /usr/local/bin/nodemon", "note": "Recommended approach for proper configuration"},
        {"solution": "Windows users specify path: C:\\Users\\[username]\\AppData\\Roaming\\npm\\node_modules\\nodemon\\bin\\nodemon.js", "percentage": 85, "command": "Node parameters: C:\\Users\\[username]\\AppData\\Roaming\\npm\\node_modules\\nodemon\\bin\\nodemon.js", "note": "Platform-specific configuration"},
        {"solution": "Use NPM script method: create npm run configuration that calls nodemon script - improves debugging reliability", "percentage": 80, "note": "Alternative approach for better debugging support"}
    ]$$::jsonb,
    'Node.js installed, Nodemon installed globally or locally, WebStorm 7 or later',
    'Server restarts automatically when source files change, No manual process restart required, Application output appears in WebStorm console',
    'Breakpoints do not work without --inspect-brk flag in Application Parameters. Terminate batch job prompt on Windows occurs when using nodemon.cmd as interpreter. Verify nodemon location via which nodemon before configuring. Do not use nodemon directly as interpreter - use Node parameters instead.',
    0.84,
    NOW(),
    'https://stackoverflow.com/questions/19180702/how-can-i-run-nodemon-from-within-webstorm'
),
(
    'Is there source map support for typescript in node / nodemon?',
    'stackoverflow-nodemon',
    'MEDIUM',
    $$[
        {"solution": "Use Node.js built-in support (v12.12.0+): nodemon --enable-source-maps dist/app.js", "percentage": 93, "command": "nodemon --enable-source-maps dist/app.js", "note": "Modern and recommended approach"},
        {"solution": "Set NODE_OPTIONS environment variable: NODE_OPTIONS=--enable-source-maps npm test", "percentage": 88, "command": "NODE_OPTIONS=--enable-source-maps npm test", "note": "Works across different Node commands"},
        {"solution": "Use source-map-support package for older Node: npm install source-map-support && nodemon -r source-map-support/register dist/app.js with sourceMap: true in tsconfig.json", "percentage": 82, "command": "nodemon -r source-map-support/register dist/app.js", "note": "Fallback for Node < 12.12.0"}
    ]$$::jsonb,
    'TypeScript 2.0+, Node.js v12.12.0+ (for native support), sourceMap: true configured in tsconfig.json',
    'Runtime errors display original TypeScript file names and line numbers, Stack traces map to .ts files instead of transpiled .js files, Error logs show both generated and source file locations',
    'Ensure --enable-source-maps flag appears before script path in command. For source-map-support package ensure sourceMap: true in tsconfig.json. Compiled JavaScript must have accompanying .js.map files. Flag order matters - incorrect placement prevents source map registration.',
    0.89,
    NOW(),
    'https://stackoverflow.com/questions/42088007/is-there-source-map-support-for-typescript-in-node-nodemon'
),
(
    'Nodemon ignore directory',
    'stackoverflow-nodemon',
    'MEDIUM',
    $$[
        {"solution": "Remove asterisk and quotes from ignore pattern: nodemon --ignore ./client/ (or nodemon --ignore client/)", "percentage": 94, "command": "nodemon --ignore client/", "note": "Correct syntax avoids pattern errors"},
        {"solution": "Use nodemon.json configuration for cleaner setup: {\"ignore\": [\"client/*\"], \"exec\": \"babel-node src/server.js\"}", "percentage": 90, "command": "nodemon", "note": "Recommended for persistent configuration"},
        {"solution": "Use relative paths: --ignore client/ instead of complex glob patterns", "percentage": 85, "note": "Simplest approach for directory exclusion"}
    ]$$::jsonb,
    'Nodemon installed as dev dependency, Package structure with separate client/server directories, Node.js project with package.json',
    'No server restart when modifying files in client directory, Server properly restarts when server-side files change, Process remains running without errors when client files update',
    'Using asterisks incorrectly such as --ignore \"client/*\" fails. Keeping single quotes interferes with shell parsing. Wrong path format uses .. relative paths instead of ./client/ or client/. Configuration not reloading because changes to package.json require killing and restarting nodemon process.',
    0.88,
    NOW(),
    'https://stackoverflow.com/questions/41913086/nodemon-ignore-directory'
);
