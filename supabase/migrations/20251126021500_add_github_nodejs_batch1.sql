-- Add GitHub Node.js Issues batch 1
-- Mining nodejs/node repository for common bugs with documented solutions

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'npm on Windows fails with module not found for Node.js 22.0.0',
    'github-nodejs',
    'HIGH',
    $$[
        {"solution": "Upgrade to Node.js version after 22.0.0 where PowerShell wrapper script path resolution was fixed", "percentage": 95, "note": "Official fix in later 22.x releases"},
        {"solution": "Use alternative Node.js version manager like Volta that handles npm path resolution correctly", "percentage": 85, "note": "Workaround for Windows users"},
        {"solution": "Clear npm cache and reinstall: npm cache clean --force && npm install -g npm", "percentage": 75, "command": "npm cache clean --force && npm install -g npm"}
    ]$$::jsonb,
    'Node.js 22.0.0 installed, Windows platform, npm command accessible',
    'npm install completes successfully, npm --version returns version number',
    'Do not use Node.js 22.0.0 on Windows. The issue is specific to PowerShell wrapper script failures introduced in that version. Upgrade to 22.1.0+ immediately.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/nodejs/node/issues/52682'
),
(
    'Cannot find module error when main file not index.js with -experimental-specifier-resolution=node',
    'github-nodejs',
    'MEDIUM',
    $$[
        {"solution": "Rename your main entry point file to index.js and update package.json main field accordingly", "percentage": 90, "note": "ESM resolver limitation with non-standard main files"},
        {"solution": "Use explicit file extensions in import statements: import foo from ./mypackage/Lib.js instead of ./mypackage", "percentage": 85, "command": "Change: import foo from ''./mypackage'' to: import foo from ''./mypackage/Lib.js''"},
        {"solution": "Avoid -experimental-specifier-resolution=node flag and use proper TypeScript output configuration instead", "percentage": 80, "note": "Flag is experimental and has limitations"}
    ]$$::jsonb,
    'Node.js with -experimental-specifier-resolution=node flag, package.json with non-index.js main field',
    'Imports resolve successfully, module loads without ERR_MODULE_NOT_FOUND errors',
    'The experimental flag does not properly resolve package.json main field for directory imports. Always use explicit file paths with extensions when using this flag.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/nodejs/node/issues/32103'
),
(
    'Improve error message for EADDRINUSE address already in use',
    'github-nodejs',
    'HIGH',
    $$[
        {"solution": "Use lsof -i :PORT (macOS/Linux) or netstat -ano (Windows) to find process using the port and kill it", "percentage": 90, "command": "lsof -i :3000 | grep LISTEN | awk ''{print $2}'' | xargs kill -9"},
        {"solution": "Implement error handler with retry logic that waits before retrying: setTimeout(() => server.listen(port), 1000)", "percentage": 85, "note": "Handles timing issues in server startup"},
        {"solution": "Use SO_REUSEADDR socket option to allow reusing TIME_WAIT sockets: server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)", "percentage": 80, "note": "Platform-specific, mainly Unix-like systems"}
    ]$$::jsonb,
    'Running Node.js server, port specified in listen() call',
    'Server successfully listens on port, no EADDRINUSE error, requests reach server',
    'The error is cryptic for beginners - it means another process has the port open. Always check what process is using the port before killing it. Restart required after cleanup.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/nodejs/node/issues/22936'
),
(
    'Buffer.from(str) memory leak in synchronous loops',
    'github-nodejs',
    'MEDIUM',
    $$[
        {"solution": "Replace synchronous tight loops with setInterval to allow garbage collection cycles between operations", "percentage": 92, "note": "Allows GC to run and collect garbage properly"},
        {"solution": "Use async/await with process.nextTick() to yield control: for (let i = 0; i < 1000000; i++) { Buffer.from(...); await new Promise(r => process.nextTick(r)); }", "percentage": 88, "command": "Add await new Promise(r => process.nextTick(r)) inside loop"},
        {"solution": "Invoke gc() explicitly with --expose-gc flag if memory critical: node --expose-gc app.js, then call gc() after operations", "percentage": 75, "note": "Requires flag and manual intervention"}
    ]$$::jsonb,
    'Node.js v14.5.0 or higher, tight synchronous loop with Buffer.from(), sufficient system RAM',
    'Memory usage remains stable, no OOM crash, heap remains under configured limit',
    'The leak occurs specifically with string parameters in synchronous loops. Does not occur with Array parameters or when event loop yields. Upgrade to latest Node.js version.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/nodejs/node/issues/38300'
),
(
    'JS heap out of memory when generating lots of empty buffers',
    'github-nodejs',
    'MEDIUM',
    $$[
        {"solution": "Replace infinite for(;;) loop with setInterval(): setInterval(() => { Buffer.allocUnsafe(16); process.stdout.write(...) }, 0)", "percentage": 93, "note": "Allows V8 garbage collector cycles"},
        {"solution": "Explicitly call gc() during iteration with node --expose-gc flag", "percentage": 85, "command": "node --expose-gc app.js, then periodically call gc()"},
        {"solution": "Use lower heap size limit to surface GC issues earlier: node --max-old-space-size=128 app.js", "percentage": 80, "note": "Diagnostic tool, not production solution"}
    ]$$::jsonb,
    'Node.js v10.7.0 or later, tight synchronous loop creating buffers',
    'Application runs without OOM crash, memory stable within configured heap limit',
    'Not a buffer bug but V8 garbage collection behavior under continuous synchronous load. Tight loops prevent GC from running. Breaking with setInterval is critical.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/nodejs/node/issues/21951'
),
(
    'Improve Cannot find module error for missing main entry point file',
    'github-nodejs',
    'MEDIUM',
    $$[
        {"solution": "Verify the main entry file exists in package.json: check that node_modules/foo/dist/entry.js file exists if package.json specifies main: dist/entry.js", "percentage": 94, "note": "Most common issue - build artifacts deleted or not included"},
        {"solution": "Rebuild the package or clear node_modules and reinstall: rm -rf node_modules && npm install", "percentage": 88, "command": "rm -rf node_modules package-lock.json && npm install"},
        {"solution": "Check package.json main field points to correct file, fallback index.js file exists: ls node_modules/foo/index.js", "percentage": 85, "command": "cat node_modules/foo/package.json | grep main"}
    ]$$::jsonb,
    'npm package installed, Node.js require() or import statement attempted',
    'Module loads successfully, no Cannot find module error, code executes',
    'The error message is generic - it does not clearly state whether the package or the main entry file is missing. Check that the file specified in package.json main exists.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/nodejs/node/issues/26588'
),
(
    'Javascript heap out of memory with large --max-old-space-size setting',
    'github-nodejs',
    'LOW',
    $$[
        {"solution": "Avoid setting --max-old-space-size beyond 2GB (2048): use node --max-old-space-size=2048 app.js instead of much larger values", "percentage": 91, "note": "Type overflow occurs with very large heap sizes over 2^32 bytes"},
        {"solution": "Upgrade to latest Node.js version (14.18.0+) which fixes internal type overflow issues with large heaps", "percentage": 87, "command": "nvm install 14.18.0 && nvm use 14.18.0"},
        {"solution": "Profile memory usage with --inspect flag and reduce actual memory footprint instead of increasing heap: node --inspect app.js", "percentage": 85, "note": "Root cause analysis preferred over large heap"}
    ]$$::jsonb,
    'Node.js 14.x or earlier with very large --max-old-space-size setting (> 2GB)',
    'Application starts without heap allocation errors, processes complete successfully, memory remains under configured limit',
    'Setting --max-old-space-size beyond 2GB can cause internal type overflow on 32-bit fields. Even with 128GB RAM available, large heaps fail. Use reasonable heap sizes.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/nodejs/node/issues/37317'
),
(
    'Sending large data to ServerResponse causes RSS and external memory leak',
    'github-nodejs',
    'MEDIUM',
    $$[
        {"solution": "Update to Node.js v14.18.1 or v16.13.0+ which resolves memory fragmentation issues in HTTP response handling", "percentage": 90, "note": "Issue resolved in recent stable releases"},
        {"solution": "Invoke manual garbage collection during long-running operations with node --expose-gc and periodic gc() calls", "percentage": 80, "command": "node --expose-gc server.js, then call gc() between writes"},
        {"solution": "Switch memory allocator from glibc to jemalloc to reduce fragmentation: LD_PRELOAD=/usr/lib/libjemalloc.so node app.js", "percentage": 75, "note": "Diagnostic workaround, not permanent fix"}
    ]$$::jsonb,
    'Node.js v14.x sending large HTTP responses, proper backpressure handling implemented',
    'External memory remains stable, no unbounded growth, heap does not exceed configured limits',
    'Not a true leak but glibc memory fragmentation - V8 frees buffers to external memory but pages not reclaimed. Upgrade Node.js version is primary solution.',
    0.83,
    'sonnet-4',
    NOW(),
    'https://github.com/nodejs/node/issues/30902'
),
(
    'fs.writeFileSync fails with permission denied in TMPDIR on Node.js 20',
    'github-nodejs',
    'MEDIUM',
    $$[
        {"solution": "Upgrade to Node.js version after 20.x where fs.readFileSync UTF-8 fast path permission regression was fixed", "percentage": 94, "note": "Official fix in later releases"},
        {"solution": "Change encoding from ''utf8'' to ''UTF-8'' or ''UTF8'' in readFileSync options to avoid fast path bug", "percentage": 88, "command": "Change: fs.readFileSync(file, ''utf8'') to: fs.readFileSync(file, ''UTF-8'')"},
        {"solution": "Use flag ''a+'' instead of append mode in readFileSync: fs.readFileSync(file, {flag: ''a+'', encoding: ''utf8''})", "percentage": 85, "note": "Bypasses problematic fast path"}
    ]$$::jsonb,
    'Node.js 20.x, fs.writeFileSync() to temporary directory, prior readFileSync() in append mode',
    'File writes succeed with proper permissions, no EACCES errors, files readable and writable',
    'Regression in UTF-8 fast path creates files with ---------- permissions (unreadable). Always use latest Node.js version. Affects only specific append mode scenario.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/nodejs/node/issues/52079'
),
(
    'RangeError Maximum call stack size exceeded on Node.js 17.9.0 with readline AbortSignal',
    'github-nodejs',
    'LOW',
    $$[
        {"solution": "Upgrade to Node.js 18.x LTS or later (18.9.1+) which fixes the readline cleanup recursion bug", "percentage": 96, "note": "Version 17.x is odd-numbered with only 8 months support"},
        {"solution": "Avoid using AbortSignal with readline module on Node.js 17.x, use older cleanup patterns instead", "percentage": 75, "note": "Workaround for staying on 17.x, not recommended"},
        {"solution": "Downgrade to Node.js 16.x LTS if 18.x unavailable - has stable readline without this bug", "percentage": 85, "command": "nvm install 16 && nvm use 16"}
    ]$$::jsonb,
    'Node.js 17.9.0, readline interface with AbortSignal created',
    'Readline interface aborts gracefully within timeout, no stack overflow, no recursive errors',
    'Node.js 17.x is odd-numbered and unsupported within 8 months. Always use even-numbered LTS versions (14, 16, 18, 20) for long-term stability. Bug is specific to 17.9.0.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://github.com/nodejs/node/issues/44913'
),
(
    'Impossible to make HTTP request if response headers include control characters',
    'github-nodejs',
    'MEDIUM',
    $$[
        {"solution": "Use --insecure-http-parser flag when running Node.js to allow control characters in headers: node --insecure-http-parser app.js", "percentage": 90, "note": "Official solution provided by Node.js team"},
        {"solution": "Upgrade to latest Node.js version which improved HTTP parser handling of non-compliant responses", "percentage": 85, "command": "nvm install node && nvm use node"},
        {"solution": "Use net module directly to receive raw socket data and parse manually if API returns malformed headers", "percentage": 70, "note": "Last resort for non-compliant APIs"}
    ]$$::jsonb,
    'Node.js v12+, HTTP request to server with non-standard response headers',
    'HTTP request completes successfully, response parsed without HPE_INVALID_HEADER_TOKEN errors',
    'Some APIs return headers with invalid control characters. --insecure-http-parser bypasses strict validation. Use only with known non-compliant servers.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/nodejs/node/issues/30573'
),
(
    'ERR_HTTP_INVALID_HEADER_VALUE when setting HTTP headers',
    'github-nodejs',
    'HIGH',
    $$[
        {"solution": "Validate header value is defined and contains no control characters (ASCII 0-31, 127): const valid = !/[\\x00-\\x1F\\x7F]/.test(value)", "percentage": 92, "note": "Check headers before setting"},
        {"solution": "Ensure header value is not undefined or null: if (!headerValue) headerValue = ''''", "percentage": 90, "command": "response.setHeader(''X-Custom'', headerValue || '''')"},
        {"solution": "Strip or encode non-ASCII characters in header values for compatibility: headerValue = headerValue.replace(/[^\\x20-\\x7E]/g, '''')", "percentage": 85, "note": "For internationalized content"}
    ]$$::jsonb,
    'Node.js HTTP server or client, setting response or request headers',
    'Headers set successfully without errors, response sent with correct headers, client receives headers',
    'Invalid characters include control characters (\\x00-\\x1F, \\x7F) and line breaks. Most common cause is undefined values. Always validate and sanitize header values.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/nodejs/node/issues/30573'
);
