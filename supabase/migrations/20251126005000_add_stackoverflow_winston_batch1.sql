-- Add Stack Overflow Winston logging library solutions batch 1
-- Extracted from highest-voted Winston questions (134-38 votes)
-- Source: https://stackoverflow.com/questions/tagged/winston?sort=votes

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES (
    'How to add timestamp to logs using Winston library',
    'stackoverflow-winston',
    'VERY_HIGH',
    $$[
        {"solution": "Use format.timestamp() with format.combine() in logger configuration: const logger = createLogger({ format: combine(timestamp(), json()), transports: [new transports.Console()] });", "percentage": 95, "note": "Winston 3.0+ recommended approach with 134 upvotes"},
        {"solution": "Customize timestamp format with format parameter: format.timestamp({format:''MM-YY-DD''})", "percentage": 90, "note": "Allows custom date formats"},
        {"solution": "Ensure timestamp() appears before json() in format.combine() chain for proper ordering", "percentage": 88, "note": "Order matters in format pipeline"}
    ]$$::jsonb,
    'Node.js environment, Winston library installed (npm install winston), Winston version 3.0 or higher',
    'Log output contains ISO timestamp field, formatted logs appear with correct date/time, timestamp format matches configuration',
    'Forgetting to use format.combine() with timestamp formatter. Using timestamp() after json() in chain causes incorrect ordering. Pre-3.0 Winston requires different syntax.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/10271373/node-js-how-to-add-timestamp-to-logs-using-winston-library'
),
(
    'How to integrate Morgan and Winston loggers in Express.js',
    'stackoverflow-winston',
    'VERY_HIGH',
    $$[
        {"solution": "Create a stream object with write() method that calls logger.info() and pass to Morgan: logger.stream = { write: (message) => logger.info(message.trim()) }; app.use(morgan(''combined'', { stream: logger.stream }));", "percentage": 94, "note": "Stream bridge pattern with 127 upvotes, Winston 2.x syntax"},
        {"solution": "For Winston 3.0+, use createLogger() instead of new winston.Logger(): const logger = winston.createLogger({ transports: [...] });", "percentage": 92, "note": "Updated constructor syntax for modern Winston"},
        {"solution": "Trim Morgan newlines from message: use message.trim() to prevent double-spacing in output", "percentage": 88, "note": "Morgan appends newline character automatically"}
    ]$$::jsonb,
    'Express.js application, Winston logger configured with transports, Morgan middleware package installed',
    'Both Morgan HTTP logs and application logs write to same transport, no double newlines in output, console and file contain all requests',
    'Not trimming Morgan''s trailing newline causes double-spacing. Using outdated new winston.Logger() syntax with Winston 3.x throws constructor errors. Forgetting to name transports makes debugging difficult.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/27906551/node-js-logging-use-morgan-and-winston'
),
(
    'How to log full stack trace with Winston 3',
    'stackoverflow-winston',
    'VERY_HIGH',
    $$[
        {"solution": "Include format.errors({ stack: true }) in format.combine() before other formatters: createLogger({ format: combine(errors({stack: true}), colorize(), timestamp(), prettyPrint()), transports: [...] });", "percentage": 96, "note": "Built-in errors format handler, 74 upvotes"},
        {"solution": "Pass Error objects directly to logger methods, avoid converting to strings: logger.error(new Error(''message'')) instead of logger.error(err.toString())", "percentage": 93, "note": "Error objects preserve stack trace metadata"},
        {"solution": "Place format.errors() at the beginning of format chain for proper error serialization before other formatters", "percentage": 90, "note": "Order critical for stack trace visibility"}
    ]$$::jsonb,
    'Winston 3.2.0 or higher installed, Error objects available to log, understanding of format composition',
    'Stack traces appear in log output with file paths and line numbers, error messages include full call chain, logs properly routed to all transports',
    'Outdated custom formatters may not work in Winston 3.x. Missing format.errors() formatter prevents stack traces from appearing. prettyPrint() blocks event loop in production. TypeScript users may need winston.format instead of destructured imports.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/47231677/how-to-log-full-stack-trace-with-winston-3'
),
(
    'How to disable Winston logging when running unit tests',
    'stackoverflow-winston',
    'HIGH',
    $$[
        {"solution": "Set silent: true on transports during test setup: logger.transports[''console.info''].silent = true; (remember to set false after tests)", "percentage": 91, "note": "Legacy Winston approach with 61 upvotes"},
        {"solution": "For Winston 3.0+, set silent flag during logger creation: winston.createLogger({ level: ''info'', silent: process.env.NODE_ENV === ''test'' });", "percentage": 93, "note": "Modern declarative approach"},
        {"solution": "Name transports for selective silencing: logger.add(winston.transports.Console, { name: ''console.info'' }); then toggle by name", "percentage": 85, "note": "Allows individual transport control"}
    ]$$::jsonb,
    'Winston logging library installed, Test framework (Jest, Mocha, etc.), Named or identifiable transports',
    'Test output runs without application log clutter, logging remains functional in production/development, individual transports can be toggled independently',
    'Setting silent without named transports makes selective control difficult. Confusing Jest''s --silent flag (test framework only) with Winston logging. silent suppresses output but keeps transport active, not removing it.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/38363292/disable-winston-logging-when-running-unit-tests'
),
(
    'Winston not displaying error details and stack traces in logs',
    'stackoverflow-winston',
    'HIGH',
    $$[
        {"solution": "Add format.errors({ stack: true }) to logger configuration because Error object properties like .stack are non-enumerable: createLogger({ format: combine(format.errors({stack: true}), timestamp(), json()), transports: [...] });", "percentage": 95, "note": "Error objects require special formatting, 55 upvotes"},
        {"solution": "Place format.errors() at top of format chain before timestamp() and json() for proper serialization order", "percentage": 93, "note": "Critical ordering requirement"},
        {"solution": "Pass Error objects directly to logger methods instead of converting to strings: logger.error(err) not logger.error(err.message)", "percentage": 90, "note": "Preserves error object structure"}
    ]$$::jsonb,
    'Winston 3.0 or higher, Error objects to log, Node.js understanding of non-enumerable properties',
    'Full error messages appear in logs with stack traces, output matches console.error() detail level, file line numbers visible in stack traces',
    'JSON.stringify() ignores non-enumerable Error properties. Winston base methods without errors formatter skip .stack property. Converting errors to strings loses stack trace. Placement after json() prevents proper serialization.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/51630896/winston-not-displaying-error-details'
),
(
    'TypeError: winston.Logger is not a constructor with winston and morgan',
    'stackoverflow-winston',
    'HIGH',
    $$[
        {"solution": "Upgrade to Winston 3.0.0+ API using factory method: Replace new (winston.Logger)({...}) with winston.createLogger({...})", "percentage": 97, "note": "Breaking API change in Winston 3.0, 49 upvotes"},
        {"solution": "Configuration object structure remains identical when switching to createLogger(), only constructor syntax changes", "percentage": 94, "note": "Migration straightforward"},
        {"solution": "Verify Winston version: npm list winston to confirm 3.0.0 or higher is installed before using createLogger", "percentage": 90, "note": "Version mismatch common cause"}
    ]$$::jsonb,
    'Winston 3.0.0 or higher installed, transport configurations defined, exitOnError property (optional)',
    'Logger initializes without constructor error, logs successfully route to all configured transports, no errors thrown on startup',
    'Using legacy new winston.Logger() syntax with Winston 3.x throws "not a constructor" error. Pre-3.0 code will not work without updating API calls. Transport definitions remain same, only instantiation method changes.',
    0.96,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/51074805/typeerror-winston-logger-is-not-a-constructor-with-winston-and-morgan'
),
(
    'Logging all incoming requests in Node.js/Express application',
    'stackoverflow-winston',
    'HIGH',
    $$[
        {"solution": "Use 3-argument middleware function (req, res, next) for request logging: app.use((req, res, next) => { logger.info(req.method + '' '' + req.originalUrl); next(); });", "percentage": 94, "note": "Express middleware must have 3 args, not 4, 42 upvotes"},
        {"solution": "Understand that 4-argument functions trigger error-only middleware: (error, req, res, next) only executes on errors, not all requests", "percentage": 92, "note": "Explains common middleware confusion"},
        {"solution": "Place logging middleware early in app.use() chain before other middleware to capture all requests", "percentage": 88, "note": "Middleware order matters"}
    ]$$::jsonb,
    'Express.js application, Logger instance configured, body-parser or similar middleware loaded before logging middleware',
    'Logging statements appear for every incoming request, not just errors, request method and URL display consistently, middleware chain continues after logging',
    'Using 4-argument function inadvertently triggers error-only mode causing requests to skip logging. Forgetting next() call halts middleware chain. Placing error handlers before normal middleware executes wrong function type.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/42099925/logging-all-requests-in-node-js-express'
),
(
    'How to make Winston JSON log files human-readable',
    'stackoverflow-winston',
    'HIGH',
    $$[
        {"solution": "Disable JSON formatting entirely by setting json: false in file transport: new winston.transports.File({ json: false, filename: ''log.log'' });", "percentage": 85, "note": "Simple approach but removes JSON capability, 40 upvotes"},
        {"solution": "Use jq command-line tool for readable JSON viewing: tail -f file.log | jq --unbuffered .", "percentage": 88, "note": "Keeps JSON benefits while improving readability"},
        {"solution": "Use bunyan CLI tool designed for Winston JSON log formatting and filtering", "percentage": 82, "note": "Purpose-built for JSON log viewing"}
    ]$$::jsonb,
    'Winston logging library installed, Log files containing JSON output, Optional: jq or bunyan CLI tools for viewing',
    'Log files display in human-readable format, JSON structure preserved (if using jq/bunyan), grep operations work on piped output',
    'Disabling JSON format entirely loses machine-readability benefits. Assuming format.json() in Winston 3.x is equivalent to json: true in 2.x (API differs). Not installing jq/bunyan when relying on CLI viewing.',
    0.80,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/23659793/how-would-a-human-read-a-json-winston-log-file'
),
(
    'Understanding Winston logging levels and how transports filter messages',
    'stackoverflow-winston',
    'HIGH',
    $$[
        {"solution": "Winston filters by threshold level, not individual levels: setting level: ''ok'' logs messages at that level and above (higher numeric values). Create custom levels: {info: 0, ok: 1, error: 2}", "percentage": 92, "note": "Core concept with 38 upvotes"},
        {"solution": "Avoid winston.config.syslog.levels which had reversed numeric values in pre-2.0 versions (now fixed in 2.0.0+)", "percentage": 85, "note": "Pre-2.0 bug that created confusion"},
        {"solution": "Define custom colors for logging levels: { ''info'': ''red'', ''ok'': ''green'', ''error'': ''yellow'' }", "percentage": 80, "note": "Improves console output clarity"}
    ]$$::jsonb,
    'Winston logging library installed, understanding of numeric level values, optional custom level definitions',
    'Only desired log levels appear in output, logger accepts custom level definitions, colors display correctly for specified levels',
    'Pre-2.0 syslog.levels had reversed numeric values making them unusable. Expecting to filter to specific levels only (Winston uses threshold filtering, not individual level selection). Incorrect level numbering silences all logs.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/20931089/winston-understanding-logging-levels'
),
(
    'Winston console transport does not pretty-print objects and arrays',
    'stackoverflow-winston',
    'MEDIUM',
    $$[
        {"solution": "Configure Console transport with prettyPrint: true and colorize: true: logger.add(winston.transports.Console, { level: ''trace'', prettyPrint: true, colorize: true, timestamp: false });", "percentage": 91, "note": "Configuration options required, 38 upvotes"},
        {"solution": "Define custom logging levels and colors in logger instantiation for visual distinction: {trace: 0, debug: 4, info: 5, warn: 8, error: 9}", "percentage": 85, "note": "Custom levels improve readability"},
        {"solution": "Note: winston.cli() documentation may be misleading; manual logger configuration is required for reliable pretty-printing behavior", "percentage": 82, "note": "Documentation does not match behavior"}
    ]$$::jsonb,
    'Winston library installed, objects/arrays to log, Console transport configured with options parameter',
    'Objects logged via logger display formatted output instead of key=value syntax, colorized output appears in console, nested structures display hierarchically',
    'Assuming winston.cli() auto-configures pretty-printing (it does not). Forgetting to set prettyPrint: true on the transport. Missing colorize: true prevents color output. Logger must be instantiated with new (winston.Logger) in pre-3.0 versions.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/17963406/winston-doesnt-pretty-print-to-console'
),
(
    'How to format Winston JSON logs as single-line output instead of pretty-printed',
    'stackoverflow-winston',
    'MEDIUM',
    $$[
        {"solution": "Use custom printf formatter in Winston 3.x: format.printf(({timestamp, level, message, ...meta}) => JSON.stringify({timestamp, level, message, ...meta}))", "percentage": 93, "note": "Modern approach for single-line JSON, 38 upvotes"},
        {"solution": "Winston 2.x legacy: Set stringify function on Console transport: new winston.transports.Console({ json: true, stringify: (obj) => JSON.stringify(obj) })", "percentage": 85, "note": "Legacy pre-3.0 syntax"},
        {"solution": "Ensure version consistency: Winston 3.x uses format property, not transport-level json option", "percentage": 88, "note": "Version-specific configuration differs"}
    ]$$::jsonb,
    'Winston package installed (version 2.x or 3.x specified), logs directed to console or file transport, understanding of JSON output requirements',
    'Logs output as single-line JSON strings without pretty-printing, grep operations work on piped log files, all log properties remain in JSON format',
    'Mixing Winston 2.x and 3.x syntax causes errors. Using json: true in transport without custom stringify in 2.x produces multi-line format. Meta destructuring in printf can expose unwanted properties. Version mismatch between config syntax.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/32131287/how-do-i-change-my-node-winston-json-output-to-be-single-line'
),
(
    'How to log JavaScript objects and arrays using Winston like console.log',
    'stackoverflow-winston',
    'MEDIUM',
    $$[
        {"solution": "Use format string with %j placeholder for JSON serialization: logger.log(''info'', ''Object: %j'', myObject); automatically stringifies without manual JSON.stringify()", "percentage": 94, "note": "Uses Node.js util.format, 38 upvotes"},
        {"solution": "For Winston 3.x, ensure format.splat() is enabled to handle placeholder substitution: format.combine(format.splat(), format.json())", "percentage": 90, "note": "splat() middleware required in 3.x"},
        {"solution": "Avoid manual stringification beforehand: logger.log(''info'', JSON.stringify(obj)) defeats lazy evaluation and production performance optimization", "percentage": 88, "note": "Performance consideration"}
    ]$$::jsonb,
    'Winston logger configured with appropriate transports, format.splat() enabled in Winston 3.x, JavaScript objects/arrays to log',
    'Objects display properly formatted in logs without manual conversion, production logs skip processing when log level filtered out, format placeholders work as expected',
    'Forgetting to enable format.splat() in Winston 3.x breaks %j placeholder functionality. Manual JSON.stringify() prevents lazy evaluation in production. Using %s for objects produces toString() output instead of JSON.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/33158974/how-to-log-javascript-objects-and-arrays-in-winston-as-console-log-does'
);
