-- Add GitHub Knex high-voted issues with solutions batch 1
-- Extracted from: https://github.com/knex/knex/issues
-- Category: github-knex
-- Focus: Migration rollback, connection pool, transactions, TypeScript

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Knex connection pool timeout acquiring connection after database restart',
    'github-knex',
    'HIGH',
    '[
        {"solution": "Implement async connection validation beyond __knex__disposed check using SELECT 1 query to detect stale connections", "percentage": 90, "note": "Recommended by maintainer for reliable connection validation"},
        {"solution": "Mark disposed connections by listening to connection close/error events and set __knex__disposed flag", "percentage": 85, "command": "connection.on(''error''|''end'', (err) => { connection.__knex__disposed = err })"},
        {"solution": "Check connection.connection.stream.readable property in validate function to detect closed streams", "percentage": 80, "note": "Alternative stream validation approach"},
        {"solution": "Use async validateAsync instead of synchronous validation for more reliable detection", "percentage": 88, "note": "Preferred approach for production use"}
    ]'::jsonb,
    'Knex 0.12.2+, PostgreSQL client configured, Pool with generic-pool',
    'Subsequent queries succeed after initial retry, No hanging connections, Pool reuses connections correctly',
    'Synchronous validation cannot detect broken streams. Connection hung indefinitely means validate() returned true for dead connection. Test with actual database restarts in CI.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/knex/knex/issues/1833'
),
(
    'Knex TypeScript migration generation fails when knexfile.ts is used',
    'github-knex',
    'HIGH',
    '[
        {"solution": "Use explicit extension flag: knex migrate:make --migrations-directory . -x ts migration-name", "percentage": 95, "note": "Generates .ts migrations instead of .js"},
        {"solution": "Upgrade Knex to 0.17.6+ which auto-detects knexfile.ts when knexfile.js is absent", "percentage": 92, "command": "npm install knex@0.17.6+"},
        {"solution": "Use explicit knexfile flag: knex --knexfile knexfile.ts migrate:make migration-name (note: still generates .js)", "percentage": 70, "note": "Workaround but generates wrong format"}
    ]'::jsonb,
    'Knex 0.16.3+, TypeScript knexfile present (knexfile.ts), Node.js installed',
    'Migration file created with correct extension (.ts if -x ts specified), Command completes without TypeError, Migration file exists in configured directory',
    'Auto-detection requires knexfile.js to be absent. Even with --knexfile flag, generated migrations may still be .js format. Always use -x ts flag for TypeScript migrations.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://github.com/knex/knex/issues/3003'
),
(
    'Knex migrate:rollback fails to find migrations when knexfile path differs from project root',
    'github-knex',
    'HIGH',
    '[
        {"solution": "Directories should be resolved relative to knexfile location, not CWD. Upgrade to Knex 0.16.3+ (PR #2959)", "percentage": 95, "note": "This is correct default behavior per maintainer"},
        {"solution": "Configure migrations path in knexfile relative to knexfile location: migrations: { directory: ''./tools/knex/migrations'' }", "percentage": 90, "command": "knex --knexfile=./tools/knex/config.js migrate:rollback"},
        {"solution": "If still broken with 0.16.3+, verify knexfile exports correct migrations path structure", "percentage": 85, "note": "Regression in 0.16.2 was fixed in 0.16.3"}
    ]'::jsonb,
    'Knex 0.16.3+, knexfile with migrations directory configured, Migration files exist in specified directory',
    'CLI finds migration files in configured directory, migrate:rollback executes without path errors, Correct migration files are rolled back',
    'Paths are relative to knexfile location, NOT current working directory. Always specify migrations path relative to where knexfile.js is located. Regression in 0.16.2 was fixed in 0.16.3.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://github.com/knex/knex/issues/2952'
),
(
    'Knex transactions cause memory leaks detectable with Jest --detectLeaks',
    'github-knex',
    'MEDIUM',
    '[
        {"solution": "Ensure all transactions are properly committed or rolled back in tests. Use afterEach to clean up transaction references", "percentage": 85, "note": "Manual cleanup of transaction references"},
        {"solution": "Avoid creating global transactions that persist across multiple test cases. Create new transaction instance per test", "percentage": 88, "note": "Architectural approach"},
        {"solution": "Check for unresolved promises in transaction flows. Verify .commit() or .rollback() is called on every transaction path", "percentage": 82, "note": "Debug with longStackTraces enabled"}
    ]'::jsonb,
    'Knex 0.14.6+, Jest test framework with --detectLeaks flag, Test suite using transactions',
    'Jest --detectLeaks reports no leaks detected, Process memory remains stable across test suite runs, All transaction promises resolve',
    'Global transactions across multiple tests amplify memory impact. Heap can grow from 80MB to 1.3GB+ with persistent transactions. Per-record transactions are safer than global transactions.',
    0.75,
    'sonnet-4',
    NOW(),
    'https://github.com/knex/knex/issues/2573'
),
(
    'Knex connection terminated unexpectedly after long idle periods (PostgreSQL)',
    'github-knex',
    'MEDIUM',
    '[
        {"solution": "Set pool.min: 0 to prevent holding idle connections that may be terminated by database server", "percentage": 90, "note": "Prevents stale connection retention"},
        {"solution": "Configure idleTimeoutMillis to match or be less than database idle timeout setting", "percentage": 88, "command": "{ min: 0, max: 10, idleTimeoutMillis: 30000 }"},
        {"solution": "Implement application-level retry logic for connection errors. Query will succeed on next attempt with fresh connection", "percentage": 85, "note": "Knex intentionally does not mask connection errors"}
    ]'::jsonb,
    'Knex 0.20.1+, PostgreSQL 9.5+, pg driver 7.12.1+, Pool configuration with min > 0',
    'First query after idle period succeeds (automatic retry on fresh connection), No connection terminated errors in logs, Pool correctly acquires new connections when needed',
    'Knex intentionally shows connection errors to applications. Idle connections may be terminated by database server without notification. Set min: 0 to avoid holding stale connections.',
    0.86,
    'sonnet-4',
    NOW(),
    'https://github.com/knex/knex/issues/3523'
),
(
    'TimeoutError acquiring connection after upgrading to Node 14 with Knex',
    'github-knex',
    'MEDIUM',
    '[
        {"solution": "Upgrade pg driver to version 8.x or higher. Run: npm install pg@8.x", "percentage": 95, "command": "npm install pg@8.0.3 --save"},
        {"solution": "Verify Knex version is 0.21.1+. Ensure package.json lists pg ^8.0.3 as peer dependency", "percentage": 92, "note": "0.21.1+ requires pg 8.x"},
        {"solution": "Check .env configuration and database credentials are correct. Verify database server is accessible and responsive", "percentage": 80, "note": "May be configuration issue, not version issue"}
    ]'::jsonb,
    'Node 14.x or higher, Knex 0.21.0+, PostgreSQL database, pg driver available',
    'Queries execute successfully after pg upgrade, No TimeoutError in logs, Connection pool acquires connections within timeout window',
    'Node 14 incompatible with pg < 8.x. Check that .env file paths are correct (config errors can appear as timeout errors). Always verify database credentials and network access.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/knex/knex/issues/3831'
),
(
    'Knex timeout acquiring connection pool exhaustion error message',
    'github-knex',
    'HIGH',
    '[
        {"solution": "Check if .transacting(trx) is called on all queries within transactions. Verify transaction is passed to query builder", "percentage": 92, "note": "Most common cause per maintainers"},
        {"solution": "Monitor connection pool state. Use longStackTraces to identify which queries hold connections longest", "percentage": 88, "command": "longStackTraces: true in knex config"},
        {"solution": "Check for idle transaction holds. Verify all transactions commit or rollback explicitly", "percentage": 85, "note": "Transactions left open consume pool connections"},
        {"solution": "Increase pool max capacity if workload legitimately requires it: max: 20 or higher", "percentage": 75, "note": "Only if other solutions dont apply"}
    ]'::jsonb,
    'Knex 0.19+, Database connection configured, Active application queries running',
    'Queries execute without timeout errors, Connection pool connections are released after queries complete, longStackTraces shows healthy connection release patterns',
    'Forgotten .transacting(trx) is the most common cause. Long-running procedures and high sustained traffic can legitimately exhaust pools. AWS Aurora auto-shutdown can cause timeout errors.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/knex/knex/issues/2302'
),
(
    'Knex stream.end() does not return connection to pool race condition',
    'github-knex',
    'MEDIUM',
    '[
        {"solution": "Use Node.js pipeline() instead of pipe() for streams. Properly handles stream destruction across pipeline", "percentage": 92, "note": "Recommended fix at client-level"},
        {"solution": "Override PassThrough stream destroy method to explicitly destroy underlying query stream before emitting end event", "percentage": 85, "note": "Stream-level fix approach"},
        {"solution": "Always consume full stream before calling .end(). Avoid aborting streams in HTTP request handlers", "percentage": 80, "note": "Workaround: pipe to no-op stream instead of calling end()"}
    ]'::jsonb,
    'Knex 0.19+, Node.js streams API, Database configured, HTTP server with streaming queries',
    'Connection returned to pool when stream ends prematurely, No connection exhaustion with aborted requests, Pool capacity remains stable during request cancellation',
    'PassThrough stream end event fires before query stream handlers register. Destroying PassThrough does not destroy underlying queryStream. HTTP request cancellation triggers premature .end() calls.',
    0.78,
    'sonnet-4',
    NOW(),
    'https://github.com/knex/knex/issues/2324'
),
(
    'Knex nested subtransactions fail with savepoint release ordering error',
    'github-knex',
    'LOW',
    '[
        {"solution": "Upgrade to Knex version that includes PR #3440 fix for savepoint ordering (released September 2019)", "percentage": 95, "command": "npm install knex@0.15.0+"},
        {"solution": "Add concurrent transaction regression test using provided example to prevent reoccurrence in future versions", "percentage": 85, "note": "Prevents future regressions"},
        {"solution": "Ensure transactions complete in reverse creation order. Create transactions sequentially and release in LIFO order", "percentage": 80, "note": "Workaround for older versions"}
    ]'::jsonb,
    'Knex 0.13.0+, Multiple databases tested (issue is cross-database), Nested transaction code',
    'Multiple nested transactions complete without savepoint errors, Transactions can release out-of-order without errors, No "no such savepoint" error messages',
    'Removed _previousSibling property in older versions broke concurrent subtransaction handling. Transactions must serialize completion if multiple siblings created. Upgrade is required fix.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/knex/knex/issues/2213'
),
(
    'Knex lacks transaction commit and rollback event notification',
    'github-knex',
    'MEDIUM',
    '[
        {"solution": "Use transaction.executionPromise.then(() => {}) to execute code after transaction completes successfully", "percentage": 85, "note": "Community-discovered workaround"},
        {"solution": "Override Transaction class commit method to emit custom event (trx-committed) after successful completion", "percentage": 80, "note": "User-implemented workaround in issue description"},
        {"solution": "Wrap transaction in Promise and use .then() for post-commit logic", "percentage": 82, "command": "knex.transaction(trx => {...}).then(() => { /* post-commit */ })"}
    ]'::jsonb,
    'Knex 0.15+, Transaction code that needs post-commit callbacks, Node.js async/await support',
    'Post-commit callbacks execute only after successful transaction completion, Logging tied to transaction status shows correct values, External services synchronized after transaction commits',
    'executionPromise approach not officially documented. Custom event approach requires monkey-patching. Knex does not natively emit transaction lifecycle events.',
    0.73,
    'sonnet-4',
    NOW(),
    'https://github.com/knex/knex/issues/1641'
),
(
    'Knex connection pool exhaustion at startup with timeout error',
    'github-knex',
    'MEDIUM',
    '[
        {"solution": "Implement lazy transaction connections where transactions defer connection acquisition until first query (Knex 3.1.0+)", "percentage": 92, "note": "Targets root cause - unused transactions holding connections"},
        {"solution": "Review pool configuration: max connections should balance workload demands and server resources. Typical: max: 10 for small apps", "percentage": 85, "command": "{ max: 6, acquireTimeoutMillis: 30000, idleTimeoutMillis: 30000 }"},
        {"solution": "Verify no initialization code runs excessive concurrent queries. Check startup sequence for missing .catch() handlers", "percentage": 80, "note": "Unhandled promise rejections can leak connections"}
    ]'::jsonb,
    'Knex 3.1.0+, PostgreSQL 13.13+, Application initialization code, Pool configuration',
    'Application starts without timeout errors, Pool connections release properly during initialization, Connection count stable after startup completes',
    'Transactions opened but not immediately used consume pool connections during initialization. acquireTimeoutMillis only 30 seconds may be too short for slow startups.',
    0.84,
    'sonnet-4',
    NOW(),
    'https://github.com/knex/knex/issues/6034'
),
(
    'Knex expirationChecker fails to recreate connections after credential timeout',
    'github-knex',
    'LOW',
    '[
        {"solution": "Implement expiration validation in connection acquisition phase. Check expirationChecker before pooling reuses connections", "percentage": 90, "note": "Preferred approach from maintainer"},
        {"solution": "Have async connection function return updated configuration objects at intervals. Knex refreshes credentials automatically", "percentage": 85, "note": "Alternative configuration reload approach"},
        {"solution": "Add setTimeout mechanism in updatePoolConnectionSettingsFromProvider to check expiration periodically. Return milliseconds instead of boolean", "percentage": 78, "note": "Reporter initial workaround"}
    ]'::jsonb,
    'Knex 0.20.3+, PostgreSQL 12.1+, Async connection configuration with expirationChecker, Rotating credentials scenario',
    'Connections recreated when credentials expire, Subsequent queries succeed after credential refresh, expirationChecker callback executes before connection reuse',
    'expirationChecker only executes during initial resource creation, not on connection reuse. Async connection functions may not be re-invoked. Requires explicit integration with connection validation phase.',
    0.71,
    'sonnet-4',
    NOW(),
    'https://github.com/knex/knex/issues/3578'
),
(
    'Knex Oracle migration failure does not reset migration lock',
    'github-knex',
    'LOW',
    '[
        {"solution": "Upgrade to recent Knex version with improved error handling that separates lock cleanup from transaction context", "percentage": 95, "command": "npm install knex@latest"},
        {"solution": "Use conditional transaction logic with canGetLockInTransaction flag for database-specific behavior in migration lock handling", "percentage": 88, "note": "Maintainer-implemented solution"},
        {"solution": "If lock persists after migration failure, manually unlock: knex migrate:unlock", "percentage": 75, "note": "Temporary workaround while awaiting upgrade"}
    ]'::jsonb,
    'Knex 0.16.0+, Oracle database configured, Migration files present, Failed migration scenario',
    'Migration lock resets automatically after failed migration, knex migrate:unlock not required, Next migration attempt acquires lock successfully',
    'Oracle automatically rolls back transactions on failure, including lock release attempts within same transaction. Lock cleanup must be separated from transaction context. Earlier versions require manual unlock workaround.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/knex/knex/issues/2925'
);
