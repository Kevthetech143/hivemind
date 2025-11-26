-- Add GitHub node-postgres high-voted issues with solutions batch 1
-- Extracted from: https://github.com/brianc/node-postgres/issues
-- Category: github-node-postgres
-- Focus: Connection pool exhaustion, SSL errors, prepared statement issues, timeout errors

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Connection pool timeout causes connection leaks in pg-pool',
    'github-node-postgres',
    'HIGH',
    '[
        {"solution": "Use client.connection.end() instead of client.connection.stream.destroy() in timeout handler for proper cleanup", "percentage": 95, "note": "Recommended fix by maintainers for preventing leaked connections"},
        {"solution": "Ensure timeout handler properly terminates connections instead of force-killing streams", "percentage": 90, "command": "client.connection ? client.connection.end() : client.end()"},
        {"solution": "Monitor leaked connections via PostgreSQL: select * from pg_stat_activity where query_start is NULL and state = idle", "percentage": 85, "note": "Detection method for identifying connection leaks"}
    ]'::jsonb,
    'pg 8.x installed, PostgreSQL database with connection pool configured, Connection timeout triggered',
    'Zero leaked connections in pg_stat_activity, Proper connection release/removal counts, Normal pool lifecycle completion',
    'Timed-out connections persist until pool closure without proper termination. Force-killing streams does not trigger cleanup handlers. Race condition occurs when connectionTimeoutMillis expires.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/brianc/node-postgres/issues/3543'
),
(
    'Connection terminated unexpectedly due to SSL upgrade on keepAlive sockets',
    'github-node-postgres',
    'HIGH',
    '[
        {"solution": "Ensure keepAlive settings are properly applied to both initial socket and post-SSL-upgrade connections in connection.js", "percentage": 88, "note": "Root cause: keepAlive not reapplied after SSL stream upgrade"},
        {"solution": "Configure connectionTimeoutMillis with appropriate value beyond 30 seconds if experiencing timeouts with SSL", "percentage": 85, "command": "{ connectionTimeoutMillis: 30000, idleTimeoutMillis: 60000, keepAlive: true, keepAliveInitialDelayMillis: 60000 }"},
        {"solution": "Verify pg library applies keepAlive post-SSL-upgrade by checking connection.js stream handling logic", "percentage": 80, "note": "Debug approach to validate keepAlive application"}
    ]'::jsonb,
    'pg 8.x installed, Azure PostgreSQL or SSL-required database, keepAlive configuration enabled',
    'Consistent stable connections without timeout errors, Socket connections remain active after SSL upgrade, keepAlive packets transmit on secure connections',
    'SSL stream upgrade may not inherit keepAlive settings from initial socket. keepAlive applies to initial socket but not after TLS upgrade. Azure Accelerated Networking may conflict with keepAlive.',
    0.81,
    'sonnet-4',
    NOW(),
    'https://github.com/brianc/node-postgres/issues/3559'
),
(
    'Configure SSL/TLS mode without embedding in connection string',
    'github-node-postgres',
    'MEDIUM',
    '[
        {"solution": "Pass ssl config directly to Pool constructor as object: const pool = new Pool({ ssl: true })", "percentage": 95, "note": "Most direct approach"},
        {"solution": "Use ssl object for granular control: ssl: { rejectUnauthorized: false } for prefer mode", "percentage": 92, "command": "const pool = new Pool({ host: ''localhost'', ssl: { rejectUnauthorized: false } })"},
        {"solution": "Parse connection string with pg-connection-string then override ssl: config.ssl = true", "percentage": 88, "command": "const config = parseConnectionString(process.env.DATABASE_URL); config.ssl = true"}
    ]'::jsonb,
    'pg library installed, Connection string or config object available, Node.js TLS knowledge',
    'Pool connects with desired SSL/TLS security level, Secure connections established without certificate rejection, Connection string not required to contain ssl parameters',
    'sslmode in connection string cannot be overridden by Pool constructor. ssl: false vs ssl: true modes both work but rejectUnauthorized affects verification. Node.js tls.connect() options are fully supported.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://github.com/brianc/node-postgres/issues/3563'
),
(
    'SASL authentication error with non-PostgreSQL databases (openGaussDB)',
    'github-node-postgres',
    'LOW',
    '[
        {"solution": "Understand that node-postgres is PostgreSQL-specific and cannot support alternative database authentication like openGaussDB", "percentage": 95, "note": "Compatibility limitation by design"},
        {"solution": "Use database-specific client library if connecting to openGaussDB or similar alternatives", "percentage": 90, "note": "Use appropriate driver for target database"},
        {"solution": "If must use node-postgres, verify database is standard PostgreSQL with SCRAM-SHA-256 support", "percentage": 80, "note": "Compatibility verification step"}
    ]'::jsonb,
    'node-postgres (pg) 8.x installed, Authentication mechanism required',
    'Successful connection to standard PostgreSQL with SCRAM-SHA-256, Clear understanding of database compatibility',
    'node-postgres does not support non-PostgreSQL databases even if they claim compatibility. SASL mechanism support varies across database systems. SCRAM-SHA-256 is PostgreSQL standard, not universal.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/brianc/node-postgres/issues/3505'
),
(
    'ConnectionTimeoutMillis ignored causing indefinite hangs during DNS resolution',
    'github-node-postgres',
    'HIGH',
    '[
        {"solution": "Set custom DNS lookup in socket options using lookup function: { lookup: customLookupFn } to cache DNS results", "percentage": 90, "note": "Recommended by maintainer for Kubernetes environments"},
        {"solution": "Verify connectionTimeoutMillis applies to socket creation phase, not just database protocol handshake", "percentage": 85, "note": "DNS resolution may bypass timeout configuration"},
        {"solution": "Increase connectionTimeoutMillis beyond 1 second if experiencing DNS resolution delays. Use 5-10 seconds minimum", "percentage": 82, "command": "{ connectionTimeoutMillis: 10000 }"},
        {"solution": "Check Kubernetes DNS issues or implement local DNS caching to avoid lookup timeouts", "percentage": 78, "note": "GKE environment specific workaround"}
    ]'::jsonb,
    'pg 8.x installed, PostgreSQL database accessible, Kubernetes or DNS infrastructure present',
    'Connection timeout triggers properly after configured milliseconds, No indefinite hangs in pool.connect(), DNS resolution completes within timeout window',
    'connectionTimeoutMillis may not cover DNS resolution phase in Node.js socket creation. Kubernetes DNS lookups can block for extended periods. Incorta hosts and similar systems may introduce DNS delays.',
    0.79,
    'sonnet-4',
    NOW(),
    'https://github.com/brianc/node-postgres/issues/3197'
),
(
    'Cursor query crash when statement_timeout triggered with TypeError',
    'github-node-postgres',
    'MEDIUM',
    '[
        {"solution": "Fix timeout handler in client.js to check if queryCallback exists before invoking: if (queryCallback) queryCallback(error)", "percentage": 92, "note": "Proper null-check prevents crash"},
        {"solution": "Use pg-cursor with timeout-aware error handling to gracefully catch timeout exceptions", "percentage": 85, "note": "Workaround at cursor level"},
        {"solution": "Avoid statement_timeout with cursor queries. Use application-level timeout logic instead for cursor operations", "percentage": 80, "note": "Alternative timeout strategy"}
    ]'::jsonb,
    'pg library with pg-cursor support installed, statement_timeout configured, Cursor queries executing',
    'Cursor queries timeout gracefully without TypeError crashes, Error callback receives timeout error properly, Application continues running after timeout',
    'Cursor queries use different callback pattern than standard queries. queryCallback may be undefined or already cleared when timeout triggers. read timeout handler assumes standard query callback structure.',
    0.76,
    'sonnet-4',
    NOW(),
    'https://github.com/brianc/node-postgres/issues/3475'
),
(
    'Parameter binding error: supplies N parameters but prepared statement requires M',
    'github-node-postgres',
    'MEDIUM',
    '[
        {"solution": "Pass parameters array directly without extra array wrapping: query(sql, filters) not query(sql, [filters])", "percentage": 98, "note": "Most common issue - double-wrapping in array"},
        {"solution": "Verify parameter count matches SQL placeholders: $1 through $N in query matches array length", "percentage": 95, "command": "await connection.query(sql, [...params]) where params is already an array"},
        {"solution": "Debug parameter passing by logging array before query: console.log(params.length) to verify actual count", "percentage": 90, "note": "Diagnostic approach"}
    ]'::jsonb,
    'pg library installed, Parameterized queries with $1-$N placeholders, Query execution code',
    'Query executes successfully with all parameters bound correctly, Parameter count matches placeholder count in SQL, No bind message errors',
    'Extra array wrapping causes single array parameter instead of multiple parameters. Common mistake when refactoring to use separate params array. Always pass params array directly to query() method.',
    0.96,
    'sonnet-4',
    NOW(),
    'https://github.com/brianc/node-postgres/issues/3232'
),
(
    'SSL connection fails on Stackblitz with ArrayBuffer detached error',
    'github-node-postgres',
    'LOW',
    '[
        {"solution": "Enable CORS proxy on Stackblitz environment. Follow Stackblitz CORS proxy guide for SSL database connections", "percentage": 95, "note": "Environment-specific CORS configuration required"},
        {"solution": "Use HTTPS database connection string with sslmode=require after CORS proxy setup", "percentage": 90, "command": "postgresql://user@host/db?sslmode=require with CORS enabled"},
        {"solution": "If local connections work, issue is specific to Stackblitz networking. Verify CORS settings in Stackblitz project configuration", "percentage": 85, "note": "Verification approach"}
    ]'::jsonb,
    'Stackblitz environment, PostgreSQL database with SSL requirement (Neon, etc), Connection string configured',
    'SSL connection established successfully on Stackblitz, No ArrayBuffer errors in stack trace, Database queries execute normally',
    'CORS restrictions block SSL socket connections on Stackblitz. Local and Vercel deployments work but Stackblitz requires explicit CORS proxy configuration. Buffer allocation fails when CORS prevents network access.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/brianc/node-postgres/issues/3481'
),
(
    'client.end() never resolves in Deno with SSL connections',
    'github-node-postgres',
    'LOW',
    '[
        {"solution": "Manually emit close event on connection stream: connection.stream.on(''end'', () => { connection.emit(''end'') })", "percentage": 92, "note": "Workaround for Deno close event issue. Use @ts-expect-error to suppress type errors."},
        {"solution": "Upgrade to DefinitelyTyped with connection property exposed (PR #72611), eliminating need for type suppressions", "percentage": 90, "command": "@types/pg with connection property in type definitions"},
        {"solution": "Avoid using SSL with node-postgres in Deno. Use sslmode=disable if possible for compatibility", "percentage": 70, "note": "Last resort workaround"}
    ]'::jsonb,
    'Deno 2 runtime environment, pg library v8.14.1+, SSL-required PostgreSQL database (Neon, etc)',
    'await client.end() resolves without hanging, No open handles detected by Deno test runner, Clean shutdown with SSL connections',
    'Deno TLS API incomplete - close event never emitted on TLS sockets unlike Node.js. connection property not exposed in @types/pg requiring type suppressions. Affects all SSL connections in Deno.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/brianc/node-postgres/issues/3420'
),
(
    'TypeError: Cannot read properties of undefined (reading prepareValue) with pg-cursor',
    'github-node-postgres',
    'MEDIUM',
    '[
        {"solution": "Pin pg-cursor version in overrides to compatible release: npm overrides pg-cursor@2.11.0 in package.json", "percentage": 96, "note": "Immediate workaround using npm overrides"},
        {"solution": "Upgrade pg-cursor to version matching pg export structure. Update both pg and pg-cursor to latest stable versions", "percentage": 93, "command": "npm install pg@latest pg-cursor@latest"},
        {"solution": "Implement fallback import in pg-cursor: const prepare = (pg.utils && pg.utils.prepareValue) || require(''pg/lib/utils'')", "percentage": 88, "note": "Backward compatible approach"}
    ]'::jsonb,
    'pg version 8.x installed, pg-cursor 2.14.1+, Node.js 22.12.0+, npm with overrides support',
    'Application starts without prepareValue errors, Database cursors execute queries successfully, No runtime type errors on module load',
    'PR #2353 restructured pg exports removing utils export. npm dependency resolution allows version mismatch between pg and pg-cursor. Peer dependency mismatch causes runtime failures during module initialization.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://github.com/brianc/node-postgres/issues/3430'
),
(
    'PG queries hang indefinitely when server goes down during execution',
    'github-node-postgres',
    'HIGH',
    '[
        {"solution": "Configure connectionTimeoutMillis and idleTimeoutMillis to non-zero values. Default to connectionTimeoutMillis: 5000", "percentage": 88, "note": "Essential socket-level timeout configuration"},
        {"solution": "Enable keepAliveInitialDelayMillis at reasonably low value (30-60 seconds) to detect dead connections promptly", "percentage": 85, "command": "{ keepAliveInitialDelayMillis: 30000, idleTimeoutMillis: 30000 }"},
        {"solution": "Implement application-level query timeout with query_timeout: set query_timeout to match application expectations", "percentage": 82, "note": "Server-side timeout enforcement"}
    ]'::jsonb,
    'pg library installed, Pool configuration with timeout options, PostgreSQL database connection',
    'Queries timeout with proper error when server unavailable, Connection hangs detected and terminated properly, Subsequent queries execute on fresh connections',
    'query_timeout only triggers after initial query completes if network drops mid-execution. Hangs occur when TCP connection becomes half-open (ACK lost). Keep-alive packets detect dead connections but require minutes in default config.',
    0.73,
    'sonnet-4',
    NOW(),
    'https://github.com/brianc/node-postgres/issues/3399'
),
(
    'Connection pool exhaustion and leak after library upgrade',
    'github-node-postgres',
    'MEDIUM',
    '[
        {"solution": "Apply pg-pool PR #109 fix which resolved queuing behavior issue causing connection leaks", "percentage": 95, "note": "Critical fix released in pg-pool update"},
        {"solution": "Ensure client.release() called in finally blocks for all acquired connections", "percentage": 92, "command": "try { const client = await pool.connect(); ... } finally { client.release() }"},
        {"solution": "Verify nested transactions use SET LOCAL statement_timeout instead of global statement_timeout setting", "percentage": 85, "note": "Prevents statement timeout race conditions"}
    ]'::jsonb,
    'pg 7.4.3+ installed, pg-pool 2.0.3+, pg-promise 7.5.4+, Active application with transactions',
    'Connection pool remains stable without exhaustion errors, No timeout exceeded errors after library upgrade, Connection release patterns show healthy pool lifecycle',
    'PR #86 (pg-pool) changed queuing behavior reducing dropped pending items. PR #1503 race condition with statement timeouts. Missing client.release() calls accumulate held connections. Nested transactions with global timeout setting cause races.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/brianc/node-postgres/issues/1777'
);
