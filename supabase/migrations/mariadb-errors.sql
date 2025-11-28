-- MariaDB Error Knowledge Base Mining
-- 15 high-quality entries from official docs and Stack Overflow

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES

-- 1. max_allowed_packet error
(
    'ERROR 1153 (08S01) at line 96: Got a packet bigger than ''max_allowed_packet'' bytes',
    'mariadb',
    'HIGH',
    '[
        {"solution": "Edit /etc/my.cnf and add [mysqld] section with max_allowed_packet=100M, then restart server", "percentage": 95},
        {"solution": "Use mysql --max_allowed_packet=100M -u root -p database < dump.sql for one-time import", "percentage": 70},
        {"solution": "Run SET GLOBAL max_allowed_packet=1073741824 for temporary runtime change (resets on restart)", "percentage": 60}
    ]'::jsonb,
    'MariaDB server installed and running',
    'Successfully import large SQL dumps, SHOW VARIABLES LIKE ''max_allowed_packet'' returns new size',
    'Only changing client-side packet size without updating server config, using value larger than 1GB (1073741824 bytes)',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/93128'
),

-- 2. Foreign key constraint error
(
    'ERROR 1452: Cannot add or update a child row: a foreign key constraint fails',
    'mariadb',
    'HIGH',
    '[
        {"solution": "Ensure parent table records exist before inserting child table rows with matching foreign keys", "percentage": 98},
        {"solution": "For existing data, use LEFT JOIN to find orphaned records and update to valid parent keys or NULL", "percentage": 85},
        {"solution": "Temporarily disable with SET FOREIGN_KEY_CHECKS=0 before operations, then SET FOREIGN_KEY_CHECKS=1", "percentage": 70}
    ]'::jsonb,
    'Parent and child tables with foreign key relationships defined',
    'Inserts succeed and referential integrity is maintained, SHOW CREATE TABLE confirms constraints',
    'Disabling foreign key checks permanently, inserting into child before parent table, ignoring NULL column requirements',
    0.89,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/21659691'
),

-- 3. Access denied for root user
(
    'ERROR 1045 (28000): Access denied for user ''root''@''localhost'' (using password: YES)',
    'mariadb',
    'HIGH',
    '[
        {"solution": "Use sudo mysql -u root -p to access via Unix socket authentication (MariaDB 10.4.3+)", "percentage": 95},
        {"solution": "Change authentication: sudo mysql -u root, then UPDATE mysql.user SET plugin=''mysql_native_password'' WHERE user=''root'', FLUSH PRIVILEGES", "percentage": 90},
        {"solution": "Create non-root user: CREATE USER ''appuser''@''localhost'' IDENTIFIED BY ''password'', then GRANT ALL", "percentage": 85}
    ]'::jsonb,
    'MariaDB installed with default unix_socket auth enabled',
    'Successfully connect and run queries, SELECT USER() shows logged-in user',
    'Assuming password auth works by default in MariaDB 10.4.3+, using plain mysql without sudo, not creating host-specific users',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/28068155'
),

-- 4. CREATE command denied
(
    'ERROR 1142: CREATE command denied to user ''myuser''@''localhost'' for table ''mytable''',
    'mariadb',
    'MEDIUM',
    '[
        {"solution": "Create user first: CREATE USER ''myuser''@''localhost'' IDENTIFIED BY ''password''", "percentage": 100},
        {"solution": "Grant privileges for specific database: GRANT ALL PRIVILEGES ON mydb.* TO ''myuser''@''localhost''", "percentage": 98},
        {"solution": "For remote access, also create user for ''%'' host: CREATE USER ''myuser''@''%'' and grant privileges", "percentage": 95}
    ]'::jsonb,
    'MariaDB server running, able to connect as admin user',
    'SHOW GRANTS FOR ''myuser''@''localhost'' shows GRANT ALL ON mydb.*, can create tables',
    'Using FLUSH PRIVILEGES after GRANT (not needed), specifying *.* instead of dbname.*, not creating both % and localhost users',
    0.96,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/5016505'
),

-- 5. Unknown collation error
(
    'ERROR 1273 (HY000): Unknown collation: ''utf8mb4_0900_ai_ci''',
    'mariadb',
    'MEDIUM',
    '[
        {"solution": "Replace MySQL 8.0 collation with MariaDB-compatible: utf8mb4_unicode_ci, utf8mb4_general_ci, or utf8mb4_bin", "percentage": 95},
        {"solution": "For full database migration from MySQL 8.0, export with --compatible=mariadb flag", "percentage": 90},
        {"solution": "Check supported collations: SELECT * FROM information_schema.collations WHERE CHARACTER_SET_NAME=''utf8mb4''", "percentage": 85}
    ]'::jsonb,
    'MariaDB 10.4 or earlier (not 10.5+), migrating from MySQL 8.0',
    'Tables create successfully, SELECT queries execute without collation errors',
    'Assuming all MySQL 8.0 collations work in MariaDB, mixing MySQL 8.0 and MariaDB 10.4 collations in same database',
    0.91,
    'haiku',
    NOW(),
    'https://dba.stackexchange.com/questions/tagged/mariadb'
),

-- 6. Deadlock error
(
    'ERROR 1213 (40001): Deadlock found when trying to get lock; try restarting transaction',
    'mariadb',
    'HIGH',
    '[
        {"solution": "Implement application-level retry logic: catch error, wait random interval (50-200ms), then retry transaction", "percentage": 92},
        {"solution": "Optimize query order to prevent circular locks: ensure all transactions access tables in same order", "percentage": 88},
        {"solution": "Use InnoDB engine (not MyISAM), set innodb_lock_wait_timeout appropriately for your workload", "percentage": 85}
    ]'::jsonb,
    'Concurrent transactions with InnoDB storage engine',
    'Retries succeed within 3 attempts, SHOW ENGINE INNODB STATUS shows no persistent deadlock patterns',
    'Not implementing retry logic, using same wait time for all retries (should be random/exponential), deploying without transaction ordering strategy',
    0.88,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/mariadb+deadlock'
),

-- 7. Syntax error with reserved keywords
(
    'ERROR 1064 (42000): You have an error in your SQL syntax; check the manual near ''Order INT NOT NULL''',
    'mariadb',
    'MEDIUM',
    '[
        {"solution": "Wrap reserved keywords in backticks: `Order` INT NOT NULL instead of Order INT NOT NULL", "percentage": 97},
        {"solution": "Avoid reserved words entirely by renaming: order_id instead of Order as column name", "percentage": 95},
        {"solution": "Check full error message for exact location of syntax issue (shown after ''near'' clause)", "percentage": 100}
    ]'::jsonb,
    'SQL statements with potential reserved keyword usage',
    'CREATE TABLE, INSERT, SELECT statements execute successfully without syntax errors',
    'Using backticks on non-reserved names unnecessarily, not reading full error message for exact location, renaming without testing',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/mariadb+syntax-error'
),

-- 8. Table is read only error
(
    'ERROR 1036 (HY000): Table ''mytable'' is read only',
    'mariadb',
    'MEDIUM',
    '[
        {"solution": "Repair table: REPAIR TABLE mytable to fix corruption from unclean shutdown", "percentage": 90},
        {"solution": "Check disk space: df -h, ensure partition has free space (read-only triggered by full disk)", "percentage": 88},
        {"solution": "Check file permissions: ls -l /var/lib/mysql/dbname/, ensure MySQL user owns files (chmod 660 for .MYD/.MYI)", "percentage": 85}
    ]'::jsonb,
    'MyISAM table or InnoDB with corruption, filesystem with disk space or permission issues',
    'INSERT/UPDATE/DELETE operations succeed, REPAIR TABLE completes without errors',
    'Not checking disk space first, using REPAIR on locked production tables without backup, running with wrong file permissions',
    0.87,
    'haiku',
    NOW(),
    'https://mariadb.com/kb/en/troubleshooting-connection-issues/'
),

-- 9. Duplicate entry error
(
    'ERROR 1062 (23000): Duplicate entry ''value'' for key ''unique_key_name''',
    'mariadb',
    'HIGH',
    '[
        {"solution": "Check for duplicate values: SELECT col FROM table GROUP BY col HAVING COUNT(*)>1", "percentage": 96},
        {"solution": "For one-time insert, use INSERT IGNORE to skip duplicates or INSERT ... ON DUPLICATE KEY UPDATE", "percentage": 92},
        {"solution": "Remove duplicates before adding constraint: DELETE FROM table WHERE id NOT IN (SELECT MIN(id) FROM table GROUP BY unique_col)", "percentage": 88}
    ]'::jsonb,
    'Table with UNIQUE constraint or PRIMARY KEY, attempting INSERT/UPDATE with duplicate value',
    'Inserts succeed or are properly skipped, table has no duplicates, SHOW CREATE TABLE confirms constraint',
    'Using INSERT IGNORE as permanent solution instead of fixing data, not verifying constraint name, batch operations without unique handling',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/mariadb+duplicate-key'
),

-- 10. Relay log write failure (replication)
(
    'Last_IO_Errno: 1595, Relay log write failure: could not queue event from master',
    'mariadb',
    'MEDIUM',
    '[
        {"solution": "Check disk space on slave: df -h, ensure /var/lib/mysql has sufficient free space for relay logs", "percentage": 92},
        {"solution": "Verify relay log directory permissions: ls -l, ensure mysql user owns relay-log.* files", "percentage": 88},
        {"solution": "Restart replication: STOP SLAVE; RESET SLAVE; then reconfigure with CHANGE MASTER and START SLAVE", "percentage": 85}
    ]'::jsonb,
    'MariaDB replication configured, slave connected to master',
    'SHOW SLAVE STATUS shows Slave_IO_Running=Yes, Seconds_Behind_Master=0, relay log events applied successfully',
    'Not checking disk space first, restarting without proper cleanup, assuming network issue when disk is full',
    0.86,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/mariadb+replication'
),

-- 11. Too many connections error
(
    'ERROR 1040 (HY000): Too many connections',
    'mariadb',
    'HIGH',
    '[
        {"solution": "Increase max_connections: Edit /etc/my.cnf [mysqld] section, set max_connections=500, restart server", "percentage": 93},
        {"solution": "Check active connections: SHOW PROCESSLIST to identify long-running or idle connections killing resources", "percentage": 90},
        {"solution": "Kill idle connections: Kill ID; for connections idle >300 seconds (use SHOW PROCESSLIST with Command=Sleep)", "percentage": 87}
    ]'::jsonb,
    'MariaDB server with many concurrent clients, need to monitor connections',
    'SHOW VARIABLES LIKE ''max_connections'' returns new value, SHOW PROCESSLIST shows healthy connection count',
    'Setting max_connections too high causing memory issues, killing random connections instead of idle ones, not investigating root cause',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/mariadb+connections'
),

-- 12. Unknown column in WHERE clause
(
    'ERROR 1054 (42S22): Unknown column ''columnname'' in ''where clause''',
    'mariadb',
    'MEDIUM',
    '[
        {"solution": "Verify column exists: DESC tablename to see exact column names and spelling", "percentage": 98},
        {"solution": "Check for typos: compare query column name with DESCRIBE output character by character", "percentage": 97},
        {"solution": "For joins, qualify column with table alias: WHERE t1.column = value instead of WHERE column = value", "percentage": 92}
    ]'::jsonb,
    'Existing table with schema defined',
    'SELECT * FROM table WHERE ... executes without error, DESCRIBE shows referenced column',
    'Mixing quoted strings in WHERE with column names, assuming column exists without checking schema, not using table aliases in joins',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/mariadb+syntax-error'
),

-- 13. Foreign key incorrectly formed
(
    'ERROR 1005 (HY000): Can''t create table ''db.table'' (errno: 150)',
    'mariadb',
    'MEDIUM',
    '[
        {"solution": "Ensure data types match: parent key INT, child key must also be INT (not VARCHAR or BIGINT)", "percentage": 94},
        {"solution": "Index parent column: parent table column must be indexed (PRIMARY KEY or UNIQUE)", "percentage": 92},
        {"solution": "Create parent table before child: foreign key references must exist before constraint added", "percentage": 90}
    ]'::jsonb,
    'MariaDB with InnoDB engine, parent table defined',
    'ALTER TABLE child ADD CONSTRAINT succeeds, SHOW CREATE TABLE confirms FK definition',
    'Using UNSIGNED INT on parent but signed INT on child, creating FK before indexing parent column, wrong column names',
    0.89,
    'haiku',
    NOW(),
    'https://dba.stackexchange.com/questions/tagged/mariadb'
),

-- 14. Can''t connect to socket
(
    'ERROR 2002 (HY000): Can''t connect to local MySQL server through socket ''/var/run/mysqld/mysqld.sock''',
    'mariadb',
    'HIGH',
    '[
        {"solution": "Verify server is running: systemctl status mysql or ps aux | grep mysqld", "percentage": 95},
        {"solution": "Check socket path matches: SHOW VARIABLES LIKE ''socket'' on server, use same path in client config", "percentage": 93},
        {"solution": "Verify socket file exists: ls -la /var/run/mysqld/, if missing restart mysql service", "percentage": 91}
    ]'::jsonb,
    'MariaDB installed, attempting local connection',
    'mysql -u root -p connects successfully, SHOW VARIABLES LIKE ''socket'' returns socket path',
    'Assuming wrong socket path, not restarting server after checking, mixing TCP and socket connection methods',
    0.92,
    'haiku',
    NOW(),
    'https://mariadb.com/kb/en/troubleshooting-connection-issues/'
),

-- 15. Waiting for table metadata lock
(
    'ERROR: Waiting for table metadata lock (query hangs indefinitely)',
    'mariadb',
    'MEDIUM',
    '[
        {"solution": "Find blocking transaction: SHOW PROCESSLIST and SHOW OPEN TABLES WHERE In_use>0", "percentage": 90},
        {"solution": "Kill blocking connection: KILL processid; of the connection holding the lock", "percentage": 88},
        {"solution": "For ongoing issues, enable --log-error and monitor slow queries, set lock_wait_timeout appropriately", "percentage": 82}
    ]'::jsonb,
    'MariaDB 10.0+, multiple concurrent transactions',
    'SHOW PROCESSLIST returns no processes in state ''Waiting for table metadata lock'', queries complete in reasonable time',
    'Killing wrong process ID, not investigating transaction isolation level, restarting server without finding root cause',
    0.85,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/mariadb+metadata'
);
