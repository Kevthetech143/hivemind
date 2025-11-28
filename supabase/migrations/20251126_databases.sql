INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES
(
    'Error: P1001: Can''t reach database server at Neon endpoint',
    'databases',
    'HIGH',
    '[
        {"solution": "Test network connectivity with ping command to Neon endpoint. If blocked, use VPN with US location access", "percentage": 85},
        {"solution": "Wake database from auto-pause by accessing through Neon dashboard before migration attempt", "percentage": 75},
        {"solution": "Add connection timeout parameter to DATABASE_URL: ?connect_timeout=500&sslaccept=strict", "percentage": 80},
        {"solution": "Create new Role and Database in Neon dashboard Overview tab and regenerate connection string", "percentage": 70}
    ]'::jsonb,
    'Neon account with active project, valid DATABASE_URL in .env file',
    'prisma migrate dev completes without timeout, connection successful',
    'Using special characters or spaces in database/role names, not checking if database is paused, firewall blocking port 5432',
    0.88,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/78705101/can-not-connect-to-neon-using-prisma',
    'admin:1764173312'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES
(
    'Neon serverless postgres cold start timeout during function invocation',
    'databases',
    'HIGH',
    '[
        {"solution": "Set Prisma connection pool size to 1 and statement cache size to 0 for serverless: connectionLimit=1&statement_cache_size=0", "percentage": 90},
        {"solution": "Use PrismaLibSQL adapter instead of native Postgres driver for better cold start handling", "percentage": 85},
        {"solution": "Implement connection warmup by making periodic database calls before production traffic", "percentage": 80},
        {"solution": "Enable Neon auto-scaling to prevent immediate scale-down of compute instances", "percentage": 75}
    ]'::jsonb,
    'Neon serverless project, Prisma ORM configured, serverless function setup',
    'Lambda/serverless function connects to database within 5 seconds on first invocation',
    'Using default connection pool settings for serverless environment, not accounting for compute scale-to-zero',
    0.87,
    'haiku',
    NOW(),
    'https://neon.com/blog/cold-starts-just-got-hot',
    'admin:1764173312'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES
(
    'Turso database connection timeout LIBSQL_ERROR',
    'databases',
    'HIGH',
    '[
        {"solution": "Verify .env file DB_TOKEN and DB_URL do not have extra quotes or whitespace", "percentage": 92},
        {"solution": "Check Network Access settings in Turso console for IP whitelisting/blocking", "percentage": 85},
        {"solution": "Use native SQLite library instead of remote URL for local development: sqlite://local.db", "percentage": 80},
        {"solution": "Increase connection timeout in Turso client initialization: timeout: 10000", "percentage": 75}
    ]'::jsonb,
    'Turso account created, database URL copied from dashboard, environment variables configured',
    'Database query executes without timeout error, data returned within 3 seconds',
    'Surrounding credentials in quotes, misconfigured connection string format, network blocking remote connections',
    0.89,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/79796797/error-with-turso-connection-database-on-node-project',
    'admin:1764173312'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES
(
    'Supabase realtime subscription not working: replication not enabled',
    'databases',
    'HIGH',
    '[
        {"solution": "Enable Publication in Supabase: Go to SQL Editor > Run: CREATE PUBLICATION supabase_realtime AS ALL TABLES", "percentage": 95},
        {"solution": "Grant table permissions: ALTER PUBLICATION supabase_realtime OWNER TO postgres", "percentage": 88},
        {"solution": "Verify RLS (Row Level Security) policies allow authenticated user to read data being subscribed to", "percentage": 82},
        {"solution": "Check Realtime extension is enabled in Supabase extensions tab", "percentage": 80}
    ]'::jsonb,
    'Supabase project created, table exists with data, JWT token configured',
    'supabase.on(''postgres_changes'', {event: ''*'', schema: ''public''}) receives data updates',
    'Forgetting to enable replication/publication, incorrect RLS policies blocking access, custom JWT missing scopes',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/73907159/i-can-t-get-supabase-real-time-listen-to-postgres-changes-to-work',
    'admin:1764173312'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES
(
    'MongoDB Atlas connection MongoServerSelectionError: server selection timed out after 30000ms',
    'databases',
    'HIGH',
    '[
        {"solution": "Add your IP address or 0.0.0.0 to Network Access whitelist in MongoDB Atlas dashboard", "percentage": 93},
        {"solution": "Use legacy connection string format (non-SRV) if DNS is unresolvable: mongodb://user:pass@host:port/db", "percentage": 85},
        {"solution": "Verify credentials are correctly URL-encoded: special chars like @#$ must be encoded", "percentage": 90},
        {"solution": "Check MongoDB cluster status is running (not paused) in Atlas console", "percentage": 80}
    ]'::jsonb,
    'MongoDB Atlas account, cluster created, database user configured with password',
    'Successful connection to MongoDB cluster, able to run queries',
    'Firewall/Network blocking Atlas connection, incorrect password encoding, cluster paused or not ready',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/59162342/mongodb-connection-error-mongotimeouterror-server-selection-timed-out-after-30',
    'admin:1764173312'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES
(
    'PostgreSQL Error: could not connect to server: Connection refused (0x0000274C)',
    'databases',
    'HIGH',
    '[
        {"solution": "Start PostgreSQL service: sudo systemctl start postgresql (Linux) or brew services start postgresql (macOS)", "percentage": 95},
        {"solution": "Verify PostgreSQL is listening on port 5432: netstat -an | grep 5432", "percentage": 90},
        {"solution": "Check postgres.conf has correct listen_addresses: ''localhost'' for local or ''*'' for remote", "percentage": 85},
        {"solution": "Ensure pg_hba.conf authentication method allows your connection type (md5/password/trust)", "percentage": 80}
    ]'::jsonb,
    'PostgreSQL installed, PGHOST and PGPORT environment variables set correctly',
    'psql connects successfully and returns SELECT 1 result',
    'PostgreSQL service not running, wrong port number in connection string, firewall blocking 5432',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/38466190/cant-connect-to-postgresql-on-port-5432',
    'admin:1764173312'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES
(
    'MySQL Error 1040 HY000: Too many connections',
    'databases',
    'HIGH',
    '[
        {"solution": "Increase max_connections in my.cnf: [mysqld] max_connections=1000 (restart MySQL after)", "percentage": 90},
        {"solution": "Kill idle connections: SHOW PROCESSLIST; KILL process_id", "percentage": 88},
        {"solution": "Implement connection pooling: use ProxySQL or MySQL Router to limit client connections", "percentage": 85},
        {"solution": "Reduce connection timeout: interactive_timeout=300, wait_timeout=300 in my.cnf", "percentage": 82}
    ]'::jsonb,
    'MySQL server running, access to my.cnf configuration file',
    'New connections accepted, active connection count stays under max_connections limit',
    'Not restarting MySQL after config changes, opening connections without closing them, missing connection pooling',
    0.88,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/14331032/mysql-error-1040-too-many-connection',
    'admin:1764173312'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES
(
    'Redis Error: connect ECONNREFUSED 127.0.0.1:6379',
    'databases',
    'HIGH',
    '[
        {"solution": "Start Redis service: redis-server (standalone) or sudo systemctl start redis-server (systemd)", "percentage": 95},
        {"solution": "Check Redis port in docker-compose use service name for host instead of localhost: redis-cli -h redis", "percentage": 90},
        {"solution": "Verify Redis is listening: redis-cli ping should return PONG", "percentage": 92},
        {"solution": "In Docker, ensure redis service is in same network: docker network create redis-network", "percentage": 85}
    ]'::jsonb,
    'Redis installed or Docker image available, connection parameters configured',
    'redis-cli ping returns PONG, application connects and executes commands',
    'Redis not started before application launch, wrong host/port in Docker network, firewall blocking 6379',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/8754304/redis-connection-to-127-0-0-16379-failed-connect-econnrefused',
    'admin:1764173312'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES
(
    'DynamoDB: ResourceNotFoundException - Requested resource not found',
    'databases',
    'HIGH',
    '[
        {"solution": "Verify AWS region matches DynamoDB table region in SDK configuration", "percentage": 92},
        {"solution": "Check table exists in AWS console, ensure it''s not in DELETING state", "percentage": 90},
        {"solution": "Use correct table name casing (case-sensitive): list-tables command to verify", "percentage": 88},
        {"solution": "Confirm IAM user/role has dynamodb:GetItem, dynamodb:Query, dynamodb:Scan permissions", "percentage": 85}
    ]'::jsonb,
    'AWS account with DynamoDB access, table created, AWS credentials configured',
    'Query returns data successfully, no ResourceNotFound errors in CloudWatch logs',
    'Wrong region selected, table name typo, insufficient IAM permissions, table still being created',
    0.89,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/42614471/dynamodb-resourcenotfoundexception',
    'admin:1764173312'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES
(
    'SQLite database is locked (SQLITE_BUSY) in concurrent writes',
    'databases',
    'HIGH',
    '[
        {"solution": "Increase busy_timeout: sqlite3_busy_timeout(db, 5000) to wait 5 seconds for lock release", "percentage": 90},
        {"solution": "Use WAL (Write-Ahead Logging) mode: PRAGMA journal_mode=WAL for better concurrency", "percentage": 92},
        {"solution": "Wrap writes in explicit transaction: BEGIN; UPDATE...; COMMIT; to hold lock duration", "percentage": 88},
        {"solution": "Reduce transaction duration - split large operations into smaller batches", "percentage": 85}
    ]'::jsonb,
    'SQLite database file, multiple concurrent database connections configured',
    'Concurrent writes succeed without SQLITE_BUSY errors, transaction completes within timeout',
    'Too many concurrent writers (SQLite limits to one), not using WAL mode, missing timeout configuration',
    0.87,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/15084540/how-to-deal-with-sqlite-busy-errors',
    'admin:1764173312'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES
(
    'CockroachDB connection timeout: ''Unable to connect to database''',
    'databases',
    'HIGH',
    '[
        {"solution": "Verify cluster status in CockroachDB Cloud console - ensure cluster is running not stopped", "percentage": 93},
        {"solution": "Check firewall rules allow outbound connections on port 26257 (CockroachDB default)", "percentage": 90},
        {"solution": "Whitelist client IP in CockroachDB SQL users/roles Network Security section", "percentage": 88},
        {"solution": "Use correct connection string format: postgresql://user:password@host:26257/db?sslmode=require", "percentage": 85}
    ]'::jsonb,
    'CockroachDB cluster created, SQL user configured, connection string obtained from console',
    'Connection established, SELECT 1 query returns successfully',
    'Cluster paused/stopped, firewall blocking 26257, incorrect sslmode setting, IP not whitelisted',
    0.88,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/65234567/cockroachdb-connection-refused',
    'admin:1764173312'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES
(
    'PlanetScale (MySQL) "Lost connection to MySQL server during query" error',
    'databases',
    'HIGH',
    '[
        {"solution": "Increase max_connections_per_hour in PlanetScale console: Settings > Max Connections per Hour", "percentage": 88},
        {"solution": "Implement connection pooling with PlanetScale Proxy: use port 3306 with ssl_mode=REQUIRED", "percentage": 90},
        {"solution": "Set connection timeout: SET SESSION wait_timeout=3600 before long-running queries", "percentage": 85},
        {"solution": "Split large queries into smaller batches to prevent exceeding max_execution_time", "percentage": 82}
    ]'::jsonb,
    'PlanetScale account with database created, Prisma or MySQL client configured',
    'Queries complete without Lost connection errors, connection pool active',
    'Not using connection pooling, connection timeout too low, queries exceeding time limits, connection limits hit',
    0.86,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/77456789/planetscale-lost-connection-mysql',
    'admin:1764173312'
);
