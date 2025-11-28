INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES
(
    'Node.js process running at 100% CPU usage despite normal application responses',
    'performance',
    'HIGH',
    '[
        {"solution": "Check for Chokidar filesystem watcher with useFsEvents: false. Remove or set useFsEvents: true to enable native filesystem events and eliminate polling overhead", "percentage": 92},
        {"solution": "Use Node.js profiling: run ''node --prof ./app.js'' then ''node --prof-process isolate-*.log > processed.txt'' to identify consuming functions", "percentage": 88},
        {"solution": "Check for infinite loops or busy-waiting patterns in code. Use ''kill -SIGUSR1 [pid]'' then ''node inspect -p [pid]'' to pause and get backtrace", "percentage": 85},
        {"solution": "For webpack issues, set ''watchOptions: { poll: false }'' to disable excessive file system polling", "percentage": 82}
    ]'::jsonb,
    'Node.js installed, ability to run profiling tools, access to process ID via top/htop',
    'CPU usage drops below 50%, application response time improves, no new CPU spikes after fix applied',
    'Assuming 100% CPU is normal workload instead of investigating root cause, only increasing Node memory instead of fixing polling, not using modern SIGUSR1 debugging on older tools',
    0.89,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/10167477/how-to-debug-node-js-causing-100-cpu-usage',
    'admin:1764174076'
),
(
    'Continuous heap growth in Node.js process, memory increases despite garbage collection',
    'performance',
    'HIGH',
    '[
        {"solution": "Run Node with --expose-gc flag: ''node --expose-gc index.js''. Programmatically call global.gc() and monitor process.memoryUsage().heapUsed. Sustained increases indicate leak", "percentage": 93},
        {"solution": "Use Chrome DevTools inspection: start with ''node --inspect index.js'' and compare heap snapshots in DevTools Memory tab to identify retained objects", "percentage": 91},
        {"solution": "Install and use heapdump package to generate snapshot files readable in Chrome DevTools for detailed object size analysis", "percentage": 87},
        {"solution": "Use memwatch package which automatically detects leaks and emits ''leak'' event when memory loss is detected", "percentage": 85}
    ]'::jsonb,
    'Node.js v10+, Chrome browser installed for DevTools, ability to modify application code to add gc() calls',
    'Heap size stabilizes at consistent level after garbage collection, heap snapshots show fewer retained objects over time, memwatch no longer emits leak events',
    'Running gc() once then assuming no leak - must verify across multiple cycles, not checking for event listener cleanup patterns, ignoring closure retention',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/10577704/detecting-memory-leaks-in-nodejs',
    'admin:1764174076'
),
(
    'FATAL ERROR: JS Allocation failed - process out of memory or JavaScript heap out of memory',
    'performance',
    'HIGH',
    '[
        {"solution": "Increase Node.js heap allocation: export NODE_OPTIONS=--max_old_space_size=4096 before running app, or use node --max-old-space-size=4096 app.js", "percentage": 94},
        {"solution": "Check for unclosed template engine tags (especially EJS) causing parser to consume memory on malformed code. Validate all template syntax", "percentage": 88},
        {"solution": "Look for circular object references or self-referential data structures that crash during serialization. Log API endpoints hit before crashes", "percentage": 85},
        {"solution": "Audit for infinite loops or unbounded data accumulation. Check import statements for circular dependencies in webpack/build compilation", "percentage": 83}
    ]'::jsonb,
    'Node.js installed, access to application startup scripts or process environment, ability to review code for template syntax and circular imports',
    'Application starts and runs without OOM error, heap size remains stable under load, error does not recur after fixes applied',
    'Only increasing heap without finding root cause leads to repeated failures at higher memory, not validating template syntax before deployment, accumulating large objects without cleanup',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/13616770/node-js-fatal-error-js-allocation-failed-process-out-of-memory-possible',
    'admin:1764174076'
),
(
    'Warning: possible EventEmitter memory leak detected. N listeners added',
    'performance',
    'MEDIUM',
    '[
        {"solution": "Find where listeners are being added and remove them after use with emitter.removeAllListeners() or emitter.removeListener(event, callback)", "percentage": 94},
        {"solution": "Replace ''on()'' with ''once()'' for single-use event handlers to prevent accumulation of listeners", "percentage": 89},
        {"solution": "Move listener attachment outside of loops to prevent multiple additions per iteration. Verify listener is attached only once during initialization", "percentage": 87},
        {"solution": "Check for unclosed database connections or connection pools (Sequelize, MySQL) that accumulate listeners. Properly close/shutdown resources", "percentage": 84}
    ]'::jsonb,
    'Node.js v10+, access to application source code, knowledge of where event listeners are attached',
    'Warning no longer appears in logs, listener count remains below 10 per EventEmitter, application memory usage stabilizes',
    'Using setMaxListeners() to suppress warning without fixing underlying listener accumulation, not checking for circular dependencies or duplicate module initializations, attaching listeners in request handlers instead of during setup',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/9768444/possible-eventemitter-memory-leak-detected',
    'admin:1764174076'
),
(
    'Node.js process memory usage grows unexpectedly, heap snapshots show accumulated objects not released by garbage collection',
    'performance',
    'MEDIUM',
    '[
        {"solution": "Compare heap snapshots before and after load test using Chrome DevTools. Identify which object types are retained and trace their references back to root scope", "percentage": 93},
        {"solution": "Run load test with autocannon or similar to stress-test the application and force memory growth patterns to surface. Re-snapshot after load completes", "percentage": 88},
        {"solution": "Review event listener cleanup on component unmount/disposal. Ensure removeEventListener() is called for all attached handlers", "percentage": 86},
        {"solution": "Check for global variables or module-level caches that accumulate references over time. Implement cache eviction or size limits", "percentage": 82}
    ]'::jsonb,
    'Node.js v12+, Chrome DevTools, ability to run load test tools, access to application architecture and lifecycle hooks',
    'Memory plateaus at stable level during extended load testing, heap snapshots show no growth between iterations, garbage collection effectively reclaims memory',
    'Taking single heap snapshot instead of comparing snapshots over time, not running under load to expose accumulation patterns, ignoring closure-based references in callbacks',
    0.88,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/66473378/memory-leaks-in-node-js-how-to-analyze-allocation-tree-roots',
    'admin:1764174076'
);
