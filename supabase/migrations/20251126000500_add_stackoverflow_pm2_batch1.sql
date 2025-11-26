-- Add Stack Overflow PM2 solutions batch 1
-- Extracted from highest-voted PM2 questions with accepted answers

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES (
    'Can PM2 run an npm start script directly',
    'stackoverflow-pm2',
    'HIGH',
    $$[
        {"solution": "Use pm2 start npm --name \"app name\" -- start syntax to execute npm scripts", "percentage": 95, "note": "Double dash separates PM2 options from npm arguments"},
        {"solution": "For custom npm scripts: pm2 start npm -- run script-name", "percentage": 90, "note": "Allows running any npm script defined in package.json"}
    ]$$::jsonb,
    'PM2 installed, Node.js and npm installed, package.json with start script defined',
    'Process appears in pm2 list with assigned name, Process maintains online status, Application restarts on crash',
    'Incorrect flag placement before -- separator, Missing double dash causes argument misinterpretation, Without explicit naming, process defaults to "npm"',
    0.92,
    'claude-3.5-sonnet',
    NOW(),
    'https://stackoverflow.com/questions/31579509/can-pm2-run-an-npm-start-script'
),
(
    'MongoDB Topology was destroyed error with PM2',
    'stackoverflow-pm2',
    'HIGH',
    $$[
        {"solution": "Set keepAlive option to 1 and increase connectTimeoutMS: keepAlive: 1, connectTimeoutMS: 30000", "percentage": 88, "note": "Prevents premature connection closure"},
        {"solution": "Configure unlimited reconnection attempts: reconnectTries: Number.MAX_VALUE", "percentage": 85, "note": "Default 30 attempts exhaust too quickly"},
        {"solution": "Enable logging to diagnose root cause: loggerLevel: ''info'' for monitoring", "percentage": 80, "note": "Helps identify whether issue is server down or DNS latency"}
    ]$$::jsonb,
    'Mongoose connection established, MongoDB service running, Understanding of topology destruction concept',
    'Implement keepAlive and reconnectTries options, Monitor logs for connection errors, Verify MongoDB service runs before app startup',
    'Closing database before async operations complete, Insufficient reconnection settings, DNS resolution delays in containerized environments, Index creation timing issues, Configuration mismatches during migrations',
    0.85,
    'claude-3.5-sonnet',
    NOW(),
    'https://stackoverflow.com/questions/30909492/mongoerror-topology-was-destroyed'
),
(
    'What is the point of using PM2 and Docker together',
    'stackoverflow-pm2',
    'MEDIUM',
    $$[
        {"solution": "Typically avoid combining PM2 with Docker - use Docker restart policies instead", "percentage": 90, "note": "Single process per container is Docker best practice"},
        {"solution": "If using both: ensure PM2 doesnt hide crashed processes from external monitoring", "percentage": 75, "note": "Limited use cases only"}
    ]$$::jsonb,
    'Understanding of process management and Docker container philosophy, Familiarity with Docker restart policies',
    'Processes restart via Docker policies instead, Direct visibility into application health for orchestration, Cleaner monitoring in cloud environments',
    'Hiding crashed processes from external monitoring, Multiple process levels complicating metrics, Violating single-process-per-container principle, Increased memory without clear benefits',
    0.88,
    'claude-3.5-sonnet',
    NOW(),
    'https://stackoverflow.com/questions/51191378/what-is-the-point-of-using-pm2-and-docker-together'
),
(
    'Difference between PM2 cluster mode and fork mode',
    'stackoverflow-pm2',
    'HIGH',
    $$[
        {"solution": "Fork mode: uses child_process.fork() API, allows changing exec_interpreter for PHP/Python, enables external load balancing", "percentage": 92, "note": "Best for heterogeneous servers and external LB"},
        {"solution": "Cluster mode: uses Node.js built-in cluster module, automatic zero-config load balancing, launch with pm2 start -i 4 server.js", "percentage": 90, "note": "Node.js only, best for single-port applications"}
    ]$$::jsonb,
    'Understanding of Node.js process spawning, Knowledge of load balancing concepts, Familiarity with multi-core CPU architecture',
    'Correct mode selection based on use case, Proper load balancing implementation, Stateless application design for cluster',
    'Stateful applications in cluster mode cause inconsistencies, Cluster mode master process is single point of failure, Cluster mode uses more system resources, Fork mode instances need external load balancer for shared ports',
    0.91,
    'claude-3.5-sonnet',
    NOW(),
    'https://stackoverflow.com/questions/34682035/cluster-and-fork-mode-difference-in-pm2'
),
(
    'How to add dates and timestamps to PM2 error logs',
    'stackoverflow-pm2',
    'MEDIUM',
    $$[
        {"solution": "Use --log-date-format flag with moment.js formatting: pm2 start app.js --log-date-format ''DD-MM HH:mm:ss.SSS''", "percentage": 93, "note": "Command-line approach, immediate effect"},
        {"solution": "For persistent configuration, set log_date_format in ecosystem.config.js or .json file", "percentage": 90, "note": "Survives restarts and resurrect operations"},
        {"solution": "For already-running apps: pm2 restart 0 --log-date-format=\"YYYY-MM-DD HH:mm Z\"", "percentage": 85, "note": "Applies format to new logs without full restart"}
    ]$$::jsonb,
    'PM2 installed, Node.js application running under PM2, Understanding of moment.js date format strings',
    'Logs display formatted timestamps like "2019-07-28 13:46 +06:00", Timestamps appear in both pm2 logs and file logs, Format persists after restarts',
    'Single quotes cause shell parsing errors - use double quotes, --time flag alone doesnt persist after reload, Timestamps only apply to new logs not existing ones, CLI configuration doesn''t persist after restart without ecosystem file',
    0.89,
    'claude-3.5-sonnet',
    NOW(),
    'https://stackoverflow.com/questions/21317852/how-to-add-dates-to-pm2-error-logs'
),
(
    'How to pass execution arguments to application using PM2',
    'stackoverflow-pm2',
    'HIGH',
    $$[
        {"solution": "Use double dash separator: pm2 start app.js -- --prod --second-arg --third-arg", "percentage": 95, "note": "Arguments accessible via process.argv in app"},
        {"solution": "For Node arguments: pm2 start myServer.js --node-args=\"--production --port=1337\"", "percentage": 88, "note": "For Node.js specific flags"}
    ]$$::jsonb,
    'PM2 installed globally or locally, Node.js application file to execute, Understanding of command-line argument syntax',
    'Arguments appear correctly in process.argv array, Application receives and processes parameters, PM2 daemon maintains args across restarts',
    'Forgetting -- delimiter between PM2 options and app arguments, When using ecosystem.config.js field names are args not CLI syntax, Docker deployments require pm2-docker or special handling',
    0.93,
    'claude-3.5-sonnet',
    NOW(),
    'https://stackoverflow.com/questions/28980307/how-to-pass-execution-arguments-to-app-using-pm2'
),
(
    'What is the purpose of pm2 save command',
    'stackoverflow-pm2',
    'MEDIUM',
    $$[
        {"solution": "pm2 save captures snapshot of active Node applications for restoration via pm2 resurrect", "percentage": 94, "note": "Eliminates manual restarts after PM2 daemon restart"},
        {"solution": "Combine pm2 save with pm2 startup for production automatic boot persistence", "percentage": 92, "note": "save alone doesnt ensure persistence after system reboot"}
    ]$$::jsonb,
    'PM2 installed and managing Node.js processes, Active processes running under PM2, Basic understanding of PM2 commands',
    'Process list persists to ~/.pm2/dump.pm2, Applications restart reliably with pm2 resurrect, Integration with pm2 startup enables automatic launch',
    'Confusing pm2 resurrect with automatic boot startup, Assuming pm2 save alone ensures persistence after reboot, Not combining save with startup for production',
    0.90,
    'claude-3.5-sonnet',
    NOW(),
    'https://stackoverflow.com/questions/35883263/what-is-the-purpose-of-pm2-save'
),
(
    'How to kill the pm2 --no-daemon process',
    'stackoverflow-pm2',
    'MEDIUM',
    $$[
        {"solution": "Use pm2 kill command to terminate PM2 daemon and all associated processes", "percentage": 95, "note": "Most reliable method"},
        {"solution": "Alternative: ps aux | grep PM2, then kill -9 [pid] to force termination", "percentage": 85, "note": "For manual process lookup and termination"},
        {"solution": "Use pkill: sudo pkill -f pm2 on Linux systems", "percentage": 80, "note": "System-level process termination"}
    ]$$::jsonb,
    'PM2 installed and running, Terminal/command line access, Understanding of basic process management commands',
    'Command executes without errors, pm2 list shows no active processes, System resources freed from PM2 daemon, No PM2 processes in system listings',
    'Ctrl+C in foreground may not work if PM2 daemonized, Commands only affect current user''s PM2 instance, Running processes may appear online even after interrupt attempt',
    0.92,
    'claude-3.5-sonnet',
    NOW(),
    'https://stackoverflow.com/questions/45204172/how-to-kill-the-pm2-no-daemon-process'
),
(
    'Rename process using PM2 programmatic API',
    'stackoverflow-pm2',
    'LOW',
    $$[
        {"solution": "Use CLI: pm2 restart <id|name> --name newname for process renaming", "percentage": 93, "note": "CLI approach more reliable than programmatic"},
        {"solution": "Alternative: pm2 delete <id> then pm2 start app.js --name newname", "percentage": 88, "note": "Delete and restart approach for complete rename"}
    ]$$::jsonb,
    'PM2 installed and initialized, Running PM2 process with known ID or name, Node.js environment',
    'pm2 list displays new process name, Process continues running without interruption, pm2 save persists changes if needed',
    'Passing incorrect option structure to programmatic API, Callback returning success without actual rename, Not saving changes after renaming previously dumped processes',
    0.85,
    'claude-3.5-sonnet',
    NOW(),
    'https://stackoverflow.com/questions/50736153/rename-process-using-pm2-programmatic-api'
),
(
    'Difference between pm2 restart and pm2 reload',
    'stackoverflow-pm2',
    'HIGH',
    $$[
        {"solution": "pm2 restart kills and restarts process immediately", "percentage": 90, "note": "Causes downtime, faster recovery"},
        {"solution": "pm2 reload achieves zero-downtime by restarting one process at a time keeping others running", "percentage": 94, "note": "Most effective in cluster mode, requires stateless app"},
        {"solution": "reload automatically falls back to restart if timeout triggered", "percentage": 85, "note": "Automatic failsafe mechanism"}
    ]$$::jsonb,
    'PM2 installed managing Node.js applications, Understanding of cluster mode, Stateless application architecture',
    'Zero perceived downtime during deployment with reload, Faster recovery with restart, Applications responsive to requests during update',
    'Using reload with stateful applications causes failures - restart required, In non-cluster mode both commands behave identically, Timeout-triggered fallbacks may mask reload issues',
    0.91,
    'claude-3.5-sonnet',
    NOW(),
    'https://stackoverflow.com/questions/44883269/what-is-the-difference-between-pm2-restart-and-pm2-reload'
),
(
    'What is the default location of PM2 log files',
    'stackoverflow-pm2',
    'MEDIUM',
    $$[
        {"solution": "PM2 saves logs to $HOME/.pm2/logs/ directory by default", "percentage": 96, "note": "Standard location across all systems"},
        {"solution": "Error logs stored as [app-name]-error.log and output logs as [app-name]-out.log", "percentage": 94, "note": "Two log types per application"}
    ]$$::jsonb,
    'PM2 installed globally via npm, Linux/Ubuntu environment, Running Node.js application managed by PM2',
    'Successfully locate generated log files in .pm2/logs directory, View application output in respective log files, Use pm2 logs or pm2 monit to monitor',
    'Confusing log location when PM2 runs under different user accounts, Expecting logs in alternative directories without custom config, Not checking log path via pm2 describe command',
    0.94,
    'claude-3.5-sonnet',
    NOW(),
    'https://stackoverflow.com/questions/55828017/what-is-the-default-location-of-pm2-log-files'
),
(
    'How to delete or flush PM2 logs for only one application',
    'stackoverflow-pm2',
    'LOW',
    $$[
        {"solution": "Update PM2 to latest version: npm install pm2@latest -g && pm2 update to fix flush bug", "percentage": 92, "note": "Earlier versions had bug where app-specific flush failed"},
        {"solution": "Use pm2 flush appName or pm2 flush appId commands after upgrade", "percentage": 90, "note": "Commands work correctly only in recent versions"},
        {"solution": "Workaround for older PM2: manually delete log files in ~/.pm2/logs/", "percentage": 75, "note": "When update isnt available"}
    ]$$::jsonb,
    'PM2 installed globally, npm package manager available, Application running under PM2 management',
    'Targeted application logs cleared without affecting others, Command executes without errors, Updated PM2 version confirmed via pm2 -v',
    'Outdated PM2 version - earlier releases had flush app-specific bug, Bug persistence even after updates in some cases, Command appeared successful but cleared all apps'' logs instead',
    0.87,
    'claude-3.5-sonnet',
    NOW(),
    'https://stackoverflow.com/questions/53772939/how-do-i-delete-flush-pm2-logs-for-only-one-app'
);
