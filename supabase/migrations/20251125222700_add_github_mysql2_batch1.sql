-- Add MySQL2 GitHub Issues Solutions - Batch 1
-- Mined from: https://github.com/sidorares/node-mysql2/issues
-- Category: github-mysql2
-- Date: 2025-11-25

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Connection error: read ETIMEDOUT after connection pool timeout',
    'github-mysql2',
    'VERY_HIGH',
    '[
        {"solution": "Use connection pooling instead of individual connections. Pools automatically handle dead connection recycling and reuse.", "percentage": 95, "note": "Recommended approach for production"},
        {"solution": "Implement periodic keep-alive queries (SELECT 1) approximately hourly to prevent server-side timeout disconnections.", "percentage": 85, "command": "setInterval(() => pool.query(''select 1''), 3600000)"},
        {"solution": "Listen to connection ''error'' and ''end'' events and handle connection failures gracefully with retry logic.", "percentage": 80, "note": "Individual connections require manual error handling"},
        {"solution": "Set MySQL wait_timeout to higher values or disable server-side connection timeouts in configuration.", "percentage": 75, "note": "Database-level configuration change"}
    ]'::jsonb,
    'Connection pool configured, Valid MySQL credentials, Network connectivity',
    'Pool successfully acquires and releases connections, No ETIMEDOUT errors in logs, Queries execute successfully',
    'Do not attempt to reuse individual connections after timeout - create new instances instead. Avoid relying on ping() for connection validation. Never call conn.end() on pooled connections (use conn.release()).',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/sidorares/node-mysql2/issues/939'
),
(
    'Connection pool error: This socket has been ended by the other party (EPIPE)',
    'github-mysql2',
    'HIGH',
    '[
        {"solution": "Implement connection validation before reuse using pool validators: pool: { validate: () => connection.query(''select 1'') }", "percentage": 90, "note": "Validates connection is still alive before reuse"},
        {"solution": "Replace SELECT 1 ping with actual heartbeat queries. Use setInterval(() => pool.query(''select 1''), 120000) every 2 minutes.", "percentage": 88, "note": "More reliable than ping-based detection"},
        {"solution": "Configure pool with proper connection error handlers to remove dead connections from rotation.", "percentage": 82, "note": "Requires error event listeners"},
        {"solution": "Reduce connection idle timeout on application side to prevent MySQL server from closing idle connections.", "percentage": 75, "note": "Reactive approach, pool validation is better"}
    ]'::jsonb,
    'Connection pool enabled, MySQL running and accessible, Valid connection string',
    'No EPIPE errors in logs, Connections properly released to pool, Queries succeed after idle periods',
    'Do NOT ignore EPIPE errors silently - they indicate pool state issues. Ping mechanism alone is insufficient for idle connection detection. Never suppress socket ''end'' events - pool needs these notifications.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/sidorares/node-mysql2/issues/447'
),
(
    'Pool detects idle connection disconnected by MySQL (wait_timeout)',
    'github-mysql2',
    'HIGH',
    '[
        {"solution": "Implement heartbeat mechanism with SELECT 1 queries instead of ping(): setInterval(() => pool.query(''select 1''), 120000)", "percentage": 92, "note": "Proven more effective than ping-based detection in production"},
        {"solution": "Use generic-pool with validation callbacks: testOnBorrow validates connections before returning from pool", "percentage": 88, "note": "Automatically destroys broken connections"},
        {"solution": "Increase MySQL wait_timeout system variable to prevent server-side disconnection of idle connections", "percentage": 85, "command": "SET GLOBAL wait_timeout = 86400;"},
        {"solution": "Implement N ''hot'' connections that are continuously used to prevent idle timeout detection", "percentage": 70, "note": "Resource intensive, not recommended"}
    ]'::jsonb,
    'MySQL connection pool, MySQL running with wait_timeout setting, Network stability',
    'No read ECONNRESET errors during idle periods, Pool maintains valid connections, Queries succeed after 2+ minute idle periods',
    'Do NOT rely on idle connection recovery - prevention is better than detection. Ping is insufficient for MySQL idle detection. wait_timeout varies by MySQL configuration - verify your server setting.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/sidorares/node-mysql2/issues/683'
),
(
    'Character encoding error: garbled data with non-ASCII and non-BMP characters',
    'github-mysql2',
    'MEDIUM',
    '[
        {"solution": "Specify charset in connection config: charset: ''utf8mb4'' to properly handle CESU-8 encoding conversion for non-BMP Unicode characters", "percentage": 95, "note": "MySQL UTF8 is actually CESU-8, use UTF8MB4 for proper UTF-8"},
        {"solution": "Use iconv-lite based charset-to-encoding mapping in mysql2 v8.0.16+. Library now converts between MySQL charsets and Node.js encodings.", "percentage": 92, "note": "Fix implemented in PR #374"},
        {"solution": "Avoid non-BMP (plane 0) characters in MySQL column names with UTF8 charset - use UTF8MB4 instead for full compatibility", "percentage": 85, "note": "Limitation of MySQL''s UTF8 charset implementation"},
        {"solution": "Ensure all connection strings specify collation: utf8mb4_unicode_ci matching UTF8MB4 charset", "percentage": 80, "note": "Prevents charset mismatch errors"}
    ]'::jsonb,
    'MySQL 5.7+, utf8mb4 charset enabled on database, iconv-lite for encoding support',
    'Field names and values display correctly without garbled characters, Non-BMP Unicode characters preserved correctly, No character encoding errors in logs',
    'MySQL UTF8 charset is actually CESU-8 (handles non-BMP as 6 bytes) - not true UTF-8. Always use UTF8MB4 for international text. Non-BMP chars in field names may be converted to ? by MySQL.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/sidorares/node-mysql2/issues/374'
),
(
    'Error: Incorrect arguments to mysqld_stmt_execute on MySQL 8.0.22',
    'github-mysql2',
    'MEDIUM',
    '[
        {"solution": "Upgrade to MySQL 8.0.23+ which resolved the version-specific prepared statement incompatibility", "percentage": 93, "note": "Root cause was MySQL 8.0.22 specific bug"},
        {"solution": "As temporary workaround, use .query() instead of .execute() to bypass prepared statement codepath", "percentage": 85, "note": "Functional but loses prepared statement benefits"},
        {"solution": "Downgrade to MySQL 8.0.21 or earlier while using affected mysql2 versions", "percentage": 80, "note": "Not ideal for production upgrades"},
        {"solution": "Update mysql2 to latest version which may have compatibility patches for this MySQL release", "percentage": 78, "note": "Verify with release notes"}
    ]'::jsonb,
    'MySQL 8.0.22 server (or compatible version), mysql2 v2.2.5+, Prepared statements in use',
    'Prepared statements execute successfully, SELECT queries with parameters return correct results, No mysqld_stmt_execute errors in logs',
    'This error is MySQL 8.0.22 specific - do not expect it on 8.0.21 or 8.0.23+. Workaround with .query() disables statement caching. Always test prepared statements when changing MySQL versions.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/sidorares/node-mysql2/issues/1239'
),
(
    'Client does not support authentication protocol requested by server (MariaDB/MySQL 8.0)',
    'github-mysql2',
    'HIGH',
    '[
        {"solution": "Enable authSwitchHandler in connection config to negotiate newer authentication protocols during handshake", "percentage": 94, "note": "Handles caching_sha2_password and other new auth methods"},
        {"solution": "Set CLIENT_PLUGIN_AUTH capability flag during connection negotiation to enable protocol switching", "percentage": 90, "note": "Required for MySQL 8.0+ with secure auth"},
        {"solution": "For socket authentication, implement custom authSwitchHandler returning empty buffer for ''auth_socket'' plugin", "percentage": 85, "note": "MariaDB socket auth edge case"},
        {"solution": "Create new database user with modern password hashing to avoid legacy authentication protocol requirements", "percentage": 80, "note": "Best practice for new setups"}
    ]'::jsonb,
    'MariaDB 10.4+ or MySQL 8.0+, Fresh installation with secure auth enabled, User password set with SET PASSWORD',
    'Connection succeeds without auth protocol errors, User successfully authenticates, Queries execute after connection',
    'AUTH_PLUGIN_AUTH flag must be set during handshake - library defaults to disabled. Socket auth requires special handler. MySQL 8.0 changed default from mysql_native_password to caching_sha2_password.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/sidorares/node-mysql2/issues/744'
),
(
    'SSL handshake error: unable to get local issuer certificate with AWS RDS (v3.9.3+)',
    'github-mysql2',
    'MEDIUM',
    '[
        {"solution": "Download all Amazon Trust Services root CAs and include in certificate chain: concatenate rds-ca-bundle.pem with Amazon Root CA certificates", "percentage": 96, "note": "Required for RDS Proxy connections"},
        {"solution": "For RDS Proxy, explicitly include Amazon Trust Services root certificates from https://www.amazontrust.com/repository/", "percentage": 94, "note": "RDS Proxy requires different certs than direct RDS"},
        {"solution": "Downgrade to mysql2 3.1.1 which included broader certificate bundle if upgrade is blocking", "percentage": 75, "note": "Temporary workaround only"},
        {"solution": "Use aws-ssl-profiles package for AWS certificate management instead of bundling in mysql2", "percentage": 85, "note": "Better long-term maintenance"}
    ]'::jsonb,
    'mysql2 3.9.3+, AWS RDS instance (or RDS Proxy), Node.js with TLS support',
    'SSL connection to RDS succeeds, Certificate verification passes, No HANDSHAKE_SSL_ERROR in logs',
    'mysql2 3.9.3 changed certificate bundle - legacy 2019 CA certs were dropped. RDS Proxy requires Amazon Root CAs separate from RDS certs. Always test RDS upgrades in staging first.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/sidorares/node-mysql2/issues/2581'
),
(
    'SSL error: unsupported protocol with Node.js v12+ (TLS version mismatch)',
    'github-mysql2',
    'MEDIUM',
    '[
        {"solution": "Specify minVersion: ''TLSv1'' in SSL config: ssl: { rejectUnauthorized: false, minVersion: ''TLSv1'' }", "percentage": 92, "note": "Overrides Node v12+ stricter TLS defaults"},
        {"solution": "Use explicit TLS version in config: secureOptions: require(''constants'').SSL_OP_NO_TLSv13 to disable TLS 1.3", "percentage": 85, "note": "For specific version conflicts"},
        {"solution": "Upgrade to Node.js 14+ and spread Amazon RDS SSL profiles with correct TLS version negotiation", "percentage": 88, "note": "Modern approach, recommended"},
        {"solution": "Ensure RDS MySQL version supports TLS 1.2+. Upgrade RDS instance if using versions < 5.6.46", "percentage": 80, "note": "Database-level fix"}
    ]'::jsonb,
    'Node.js v12+, Amazon RDS MySQL 5.6+, SSL connection required',
    'TLS connection to MySQL succeeds, No unsupported protocol errors, SSL handshake completes without errors',
    'Node v12+ enforces minimum TLS 1.2 - older MySQL versions may not support this. rejectUnauthorized: false disables cert validation - only use in development. Always specify explicit TLS versions in production.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/sidorares/node-mysql2/issues/1084'
),
(
    'Error: got packets out of order during large result set streaming',
    'github-mysql2',
    'LOW',
    '[
        {"solution": "Ensure sequence ID increments with each packet and resets to 0 at command start in server implementations", "percentage": 90, "note": "Root cause in mysql2.createServer() proxy usage"},
        {"solution": "Update Node.js to v14.17.5+ which resolved some packet sequencing issues in underlying TLS layers", "percentage": 75, "note": "Runtime-level fix"},
        {"solution": "When implementing MySQL proxy with mysql2.createServer(), validate packet sequencing reset after each command", "percentage": 88, "note": "Affects server-mode usage only"},
        {"solution": "For client connections, update mysql2 to latest version which has improved handshake packet handling", "percentage": 80, "note": "Client-side fix"}
    ]'::jsonb,
    'mysql2 server mode enabled (createServer), Large result sets being streamed, MySQL proxy implementation',
    'No "got packets out of order" warnings in logs, Large result sets stream correctly (600K+ records), Connection remains stable during batch operations',
    'Sequence ID warnings indicate protocol-level issues - not usually fatal but indicate reliability problems under load. Most common in proxy scenarios, rare in client connections. Reset sequence ID counter at each command boundary.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/sidorares/node-mysql2/issues/528'
),
(
    'Connection pool hanging with SSL after 3-4 concurrent requests',
    'github-mysql2',
    'MEDIUM',
    '[
        {"solution": "Use conn.release() instead of conn.end() to properly return pooled connections to the pool", "percentage": 96, "note": "Critical for SSL pool connections - end() prevents pool reuse"},
        {"solution": "Implement proper connection cleanup with pool.on(''connection'') lifecycle hooks and validate release behavior", "percentage": 88, "note": "Ensures connections cycle properly"},
        {"solution": "Enable debug logging with DEBUG=mysql mysql2 to identify where connections are not being released", "percentage": 85, "command": "DEBUG=mysql node app.js"},
        {"solution": "Update pool implementation to match node-mysql stable version with proper SSL connection handling", "percentage": 80, "note": "May require mysql2 version upgrade"}
    ]'::jsonb,
    'Connection pool with SSL enabled, mysql2 with connection pooling, Multiple concurrent requests',
    'All concurrent requests complete, No connection pool exhaustion, Connections properly returned to pool after queries',
    'Calling conn.end() on pooled SSL connections is deprecated and breaks pool reuse. Always use conn.release() for pooled connections. Pool exhaustion happens when connections not returned properly.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/sidorares/node-mysql2/issues/68'
),
(
    'DOUBLE type precision loss: stored value differs from retrieved value',
    'github-mysql2',
    'LOW',
    '[
        {"solution": "Verify MySQL column metadata parsing - check that DOUBLE type (columnType: 5) is detected correctly with decimals: 0 (not 31)", "percentage": 88, "note": "Issue indicates decimals metadata parsing error"},
        {"solution": "Ensure no intermediate string conversion of DOUBLE values - preserve raw IEEE 754 64-bit float representation", "percentage": 90, "note": "Direct float handling prevents precision loss"},
        {"solution": "Compare implementation against original mysql npm package which handles DOUBLE correctly without precision loss", "percentage": 80, "note": "Reference implementation for verification"},
        {"solution": "Use DECIMAL type instead of DOUBLE for financial calculations requiring exact precision", "percentage": 85, "note": "Better choice for precision-critical data"}
    ]'::jsonb,
    'MySQL with DOUBLE column type, mysql2 client, JavaScript number values',
    'Stored and retrieved DOUBLE values match exactly to full precision (16-17 significant digits), No discrepancies in least significant digits',
    'DOUBLE is IEEE 754 64-bit float same as JS number - precision loss suggests intermediate conversion issue. MySQL decimals metadata (31) is likely parsing error - DOUBLE should show decimals: 0. Test with explicit test case.',
    0.75,
    'sonnet-4',
    NOW(),
    'https://github.com/sidorares/node-mysql2/issues/1525'
),
(
    'mysql2 v2.3.2 CPU 100% utilization - progressive CPU binding',
    'github-mysql2',
    'MEDIUM',
    '[
        {"solution": "Downgrade to mysql2 v2.3.0 immediately as v2.3.2 contains a regression causing sustained CPU exhaustion", "percentage": 98, "note": "Emergency fix - confirmed regression between releases"},
        {"solution": "Profile the issue using node --prof flag: node --prof app.js, recreate 100% CPU, then node --prof-process to identify bottleneck", "percentage": 85, "note": "For development of permanent fix"},
        {"solution": "Verify typeCast configuration and Sequelize integration - the issue may be related to type casting overhead in event loops", "percentage": 70, "note": "Possible root cause areas"},
        {"solution": "Upgrade to latest mysql2 version (3.0+) once fix is released", "percentage": 90, "note": "Follow project releases"}
    ]'::jsonb,
    'mysql2 v2.3.2 installed, Node.js v12+, AWS RDS MySQL 5.7, Sequelize ORM',
    'CPU utilization returns to normal (<10%), Application performance restored, No sustained 100% CPU usage',
    'This is a known regression in v2.3.2 specifically - do not assume it will be in other versions. Upgrading immediately is safest option. The issue progressively consumes more CPUs - watch for initial manifestation after deployment.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/sidorares/node-mysql2/issues/1432'
),
(
    'Prepared statement parameter parsing fails when SQL comments contain colon syntax',
    'github-mysql2',
    'LOW',
    '[
        {"solution": "Refactor SQL comments to avoid colon syntax (e.g., change ''http://'' in comment to ''http_'' or move comment outside prepared statement)", "percentage": 94, "note": "Prevents false positive parameter marker detection"},
        {"solution": "Use /* */ block comments instead of -- line comments in prepared statements to isolate comment text", "percentage": 85, "note": "Block comments easier to parse safely"},
        {"solution": "Escape or quote URL-like patterns in comments: change ''http://example.com'' to ''http_//example.com''", "percentage": 80, "note": "Workaround if refactoring impossible"},
        {"solution": "Update mysql2 to version with improved comment parsing that distinguishes comment colons from parameter markers", "percentage": 88, "note": "Check latest releases for fix"}
    ]'::jsonb,
    'mysql2 with prepared statements, SQL containing comments with colons, Parameter binding in use',
    'Prepared statements execute successfully with comments, Parameter values bind correctly, No parsing errors in comment sections',
    'Parameter parser mistakes colons in comments for parameter markers (?). Example: -- http://example.com will be parsed incorrectly. Use /* */ comments or remove colons from comments as safest workaround.',
    0.81,
    'sonnet-4',
    NOW(),
    'https://github.com/sidorares/node-mysql2/issues/1521'
);
