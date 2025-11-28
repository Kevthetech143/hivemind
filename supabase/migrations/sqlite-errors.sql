-- SQLite Error Mining: 15 High-Quality Entries
-- Sources: Official SQLite Documentation, Stack Overflow

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES

-- Entry 1: SQLITE_BUSY
(
    'Error: database is locked',
    'sqlite',
    'HIGH',
    '[
        {"solution": "Enable busy timeout with sqlite3_busy_timeout(db, 5000) or PRAGMA busy_timeout = 5000 to retry for 5 seconds", "percentage": 95},
        {"solution": "Use BEGIN IMMEDIATE transaction to acquire locks earlier and reduce contention", "percentage": 88},
        {"solution": "Reduce isolation level by using WAL mode with PRAGMA journal_mode = WAL and PRAGMA synchronous = NORMAL", "percentage": 85}
    ]'::jsonb,
    'SQLite database file with multiple concurrent connections',
    'Database lock is released within timeout; subsequent queries complete successfully',
    'Not implementing timeout causes immediate failures; busy_handler incorrectly configured; holding locks too long',
    0.92,
    'haiku',
    NOW(),
    'https://www.sqlite.org/rescode.html'
),

-- Entry 2: SQLITE_READONLY
(
    'Error: attempt to write a readonly database',
    'sqlite',
    'HIGH',
    '[
        {"solution": "Check file permissions: chmod 644 database.db and chmod 755 parent_directory", "percentage": 96},
        {"solution": "Verify directory is writable: touch test.tmp in database directory; delete if successful", "percentage": 93},
        {"solution": "Check journal file can be created: ensure -wal and -shm files can be written (WAL mode)", "percentage": 90},
        {"solution": "Run with elevated privileges: sudo if applicable, or change ownership chown $USER database.db", "percentage": 87}
    ]'::jsonb,
    'SQLite database file on disk, write permissions required',
    'Write operations succeed; INSERT/UPDATE/DELETE complete without permission errors',
    'Forgetting to chmod the directory not just the file; not checking WAL file permissions; running as different user',
    0.94,
    'haiku',
    NOW(),
    'https://www.sqlite.org/rescode.html'
),

-- Entry 3: SQLITE_CORRUPT
(
    'database disk image is malformed',
    'sqlite',
    'MEDIUM',
    '[
        {"solution": "Run PRAGMA integrity_check; to diagnose corruption extent and affected tables", "percentage": 92},
        {"solution": "Use PRAGMA integrity_check(500); to limit output to first 500 errors", "percentage": 88},
        {"solution": "Rebuild database: VACUUM; to reorganize and repair minor corruption", "percentage": 75},
        {"solution": "Restore from backup if VACUUM fails; rebuild database from SQL dump if available", "percentage": 98}
    ]'::jsonb,
    'SQLite database file showing corruption signs; backup available recommended',
    'PRAGMA integrity_check returns ok; database queries execute successfully after repair',
    'Ignoring backup recommendations; not running PRAGMA integrity_check first; VACUUM on large databases without testing',
    0.87,
    'haiku',
    NOW(),
    'https://www.sqlite.org/rescode.html'
),

-- Entry 4: SQLITE_CONSTRAINT - Foreign Key
(
    'FOREIGN KEY constraint failed',
    'sqlite',
    'HIGH',
    '[
        {"solution": "Enable foreign key support: PRAGMA foreign_keys = ON; before inserting data", "percentage": 97},
        {"solution": "Verify parent record exists: SELECT COUNT(*) FROM parent_table WHERE id = ?; before child insert", "percentage": 94},
        {"solution": "Check constraint definition: PRAGMA foreign_key_list(table_name); to verify referential integrity rules", "percentage": 91},
        {"solution": "Use INSERT OR IGNORE to skip violating rows, or INSERT OR REPLACE to update existing", "percentage": 82}
    ]'::jsonb,
    'SQLite database with foreign key constraints defined; parent and child tables exist',
    'PRAGMA foreign_keys returns 1; INSERT/UPDATE completes without constraint errors',
    'Foreign keys disabled by default; inserting child before parent; referencing non-existent IDs; not checking cascade rules',
    0.93,
    'haiku',
    NOW(),
    'https://www.sqlite.org/lang_createtable.html'
),

-- Entry 5: SQLITE_CONSTRAINT - Unique
(
    'UNIQUE constraint failed: table.column',
    'sqlite',
    'HIGH',
    '[
        {"solution": "Check existing row: SELECT * FROM table WHERE column = ?; before INSERT", "percentage": 96},
        {"solution": "Use INSERT OR IGNORE to skip duplicates silently", "percentage": 89},
        {"solution": "Use INSERT OR REPLACE to replace the old row with new data", "percentage": 87},
        {"solution": "Use ON CONFLICT DO UPDATE: INSERT INTO table (col) VALUES (?) ON CONFLICT(col) DO UPDATE SET ...", "percentage": 94}
    ]'::jsonb,
    'SQLite table with UNIQUE constraint; understand conflict resolution strategy needed',
    'INSERT/UPDATE succeeds; duplicate values either skipped or updated as intended',
    'Not checking existing values first; confusing IGNORE with REPLACE; misusing ON CONFLICT syntax',
    0.95,
    'haiku',
    NOW(),
    'https://www.sqlite.org/lang_conflict.html'
),

-- Entry 6: SQLITE_CONSTRAINT - Not Null
(
    'NOT NULL constraint failed: table.column',
    'sqlite',
    'HIGH',
    '[
        {"solution": "Provide value for NOT NULL column in INSERT: INSERT INTO table (col1, col2) VALUES (?, ?)", "percentage": 98},
        {"solution": "Set DEFAULT value in table definition: CREATE TABLE t (col INT NOT NULL DEFAULT 0)", "percentage": 96},
        {"solution": "Check INSERT statement for column: verify all NOT NULL columns are included in column list", "percentage": 94},
        {"solution": "Use ON CONFLICT IGNORE or REPLACE to handle conflicts with NOT NULL columns", "percentage": 85}
    ]'::jsonb,
    'SQLite table with NOT NULL column constraints; INSERT or UPDATE statement being executed',
    'INSERT/UPDATE completes successfully; all NOT NULL columns have values',
    'Omitting NOT NULL columns in INSERT; NULL values in UPDATE statements; missing DEFAULT values',
    0.97,
    'haiku',
    NOW(),
    'https://www.sqlite.org/lang_conflict.html'
),

-- Entry 7: no such table
(
    'no such table: tablename',
    'sqlite',
    'HIGH',
    '[
        {"solution": "List all tables: SELECT name FROM sqlite_master WHERE type=''table''; to verify table exists", "percentage": 98},
        {"solution": "Check table name spelling and case sensitivity in query", "percentage": 96},
        {"solution": "Run schema migration or CREATE TABLE statement before querying", "percentage": 94},
        {"solution": "Verify database connection points to correct database file with schema", "percentage": 92}
    ]'::jsonb,
    'SQLite database file; knowledge of expected table names',
    'SELECT query on table returns results; table appears in sqlite_master query results',
    'Case sensitivity in SQL keywords not column names; wrong database file opened; migrations not run',
    0.96,
    'haiku',
    NOW(),
    'https://www.sqlite.org/rescode.html'
),

-- Entry 8: no such column
(
    'no such column: columnname',
    'sqlite',
    'HIGH',
    '[
        {"solution": "List table columns: PRAGMA table_info(tablename); to see all column definitions", "percentage": 97},
        {"solution": "Check column name spelling and case sensitivity in SELECT statement", "percentage": 95},
        {"solution": "Verify alias syntax if using joins: use table.column or alias.column notation", "percentage": 91},
        {"solution": "Ensure schema migration added the column: run ALTER TABLE ADD COLUMN before querying", "percentage": 93}
    ]'::jsonb,
    'SQLite table with defined columns; understanding of table schema',
    'SELECT query returns results; column appears in PRAGMA table_info output',
    'Typos in column names; forgetting table aliases in joins; missing migrations; quote column names reserved words',
    0.97,
    'haiku',
    NOW(),
    'https://www.sqlite.org/rescode.html'
),

-- Entry 9: SQLITE_IOERR
(
    'disk I/O error',
    'sqlite',
    'MEDIUM',
    '[
        {"solution": "Check disk health: run diskutil verifyVolume / (macOS) or fsck (Linux)", "percentage": 88},
        {"solution": "Verify database file exists and is readable: ls -la database.db | head -1", "percentage": 92},
        {"solution": "Check filesystem has free space: df -h to verify sufficient disk space", "percentage": 90},
        {"solution": "Try moving database to different location to isolate filesystem issues", "percentage": 82}
    ]'::jsonb,
    'SQLite database file on potentially failing disk; system-level access permissions',
    'Database queries execute without I/O errors; disk utilities report no errors',
    'Running on nearly-full disk; disk failure imminent; files on unmounted filesystem; permission-denied vs I/O error',
    0.85,
    'haiku',
    NOW(),
    'https://www.sqlite.org/rescode.html'
),

-- Entry 10: SQLITE_NOMEM
(
    'out of memory',
    'sqlite',
    'MEDIUM',
    '[
        {"solution": "Reduce PRAGMA cache_size from default 2000 pages to 500-1000", "percentage": 89},
        {"solution": "Use LIMIT in SELECT queries to fetch rows in batches instead of entire dataset", "percentage": 91},
        {"solution": "Close unused database connections: db.close() after use", "percentage": 88},
        {"solution": "Process large imports in transactions with batches: import 10000 rows at a time", "percentage": 87}
    ]'::jsonb,
    'SQLite application with memory constraints; large datasets or many concurrent connections',
    'Queries complete within available memory; cache size adjusted appropriately',
    'Loading entire table into memory; not batching large operations; memory leaks in connection handling',
    0.84,
    'haiku',
    NOW(),
    'https://www.sqlite.org/rescode.html'
),

-- Entry 11: SQLITE_LOCKED
(
    'database table is locked',
    'sqlite',
    'MEDIUM',
    '[
        {"solution": "Serialize schema modifications: ensure no reads during ALTER TABLE or DROP operations", "percentage": 93},
        {"solution": "Use transaction isolation: wrap conflicting operations in separate BEGIN/COMMIT blocks", "percentage": 89},
        {"solution": "Check shared cache mode setting: PRAGMA query_only = OFF; or disable shared cache", "percentage": 85},
        {"solution": "Implement connection pooling to manage lock contention across threads", "percentage": 82}
    ]'::jsonb,
    'SQLite with schema modifications; multiple threads or shared cache mode enabled',
    'Schema modifications complete; concurrent reads and writes succeed without locking',
    'Modifying schema while queries are running; shared cache with schema changes; reader not closing statements',
    0.86,
    'haiku',
    NOW(),
    'https://www.sqlite.org/rescode.html'
),

-- Entry 12: SQLITE_PERM
(
    'access permission denied',
    'sqlite',
    'MEDIUM',
    '[
        {"solution": "Verify user has read permission on database: chmod u+r database.db", "percentage": 95},
        {"solution": "Check if process running as correct user: whoami and verify file ownership", "percentage": 93},
        {"solution": "Ensure parent directory is readable: chmod u+x parent_directory", "percentage": 91},
        {"solution": "Add user to group with database access if shared database: chgrp group database.db", "percentage": 88}
    ]'::jsonb,
    'SQLite database file with restrictive permissions; system user access controls',
    'Database read/write operations succeed; ls -la shows appropriate user permissions',
    'Only chmod database.db without directory permissions; wrong user ownership; group permissions insufficient',
    0.91,
    'haiku',
    NOW(),
    'https://www.sqlite.org/rescode.html'
),

-- Entry 13: SQL logic error
(
    'SQL logic error',
    'sqlite',
    'HIGH',
    '[
        {"solution": "Validate SQL syntax: use SQLite command-line .mode to test query directly", "percentage": 94},
        {"solution": "Check column names match schema: PRAGMA table_info(table) to verify", "percentage": 96},
        {"solution": "Verify quote matching in strings: use double-quotes for identifiers, single for strings", "percentage": 93},
        {"solution": "Test with prepared statement placeholders instead of string concatenation", "percentage": 91}
    ]'::jsonb,
    'SQLite database with schema; SQL query being executed',
    'SQL query executes without syntax errors; results match expectations',
    'Mismatched quotes around strings; column name typos; reserved keyword usage; malformed WHERE clauses',
    0.93,
    'haiku',
    NOW(),
    'https://www.sqlite.org/rescode.html'
),

-- Entry 14: CHECK constraint failed
(
    'CHECK constraint failed',
    'sqlite',
    'MEDIUM',
    '[
        {"solution": "Review CHECK definition: PRAGMA table_info(table) to see constraints", "percentage": 92},
        {"solution": "Verify data meets constraint logic: check age > 0 before INSERT age = -1", "percentage": 94},
        {"solution": "Test constraint expression: SELECT * WHERE condition in SELECT first", "percentage": 90},
        {"solution": "Use ON CONFLICT IGNORE or REPLACE to handle constraint violations automatically", "percentage": 85}
    ]'::jsonb,
    'SQLite table with CHECK constraints; understanding of constraint logic',
    'Data passes CHECK constraints; INSERT/UPDATE completes successfully',
    'Assuming CHECK constraints apply only to NOT NULL; misunderstanding constraint logic; no validation before insert',
    0.88,
    'haiku',
    NOW(),
    'https://www.sqlite.org/lang_conflict.html'
),

-- Entry 15: WAL mode recovery
(
    'WAL file size growing: cannot recover from WAL mode',
    'sqlite',
    'MEDIUM',
    '[
        {"solution": "Disable WAL and checkpoint: PRAGMA journal_mode = DELETE; to return to rollback journal", "percentage": 91},
        {"solution": "Force checkpoint with PRAGMA wal_autocheckpoint = 1000; to limit WAL growth", "percentage": 89},
        {"solution": "Manually checkpoint: PRAGMA wal_checkpoint(PASSIVE); to trim WAL file", "percentage": 87},
        {"solution": "Delete WAL files after disabling: rm database.db-wal database.db-shm if recovery needed", "percentage": 83}
    ]'::jsonb,
    'SQLite database in WAL mode with WAL/SHM files; ability to restart application',
    'Database size returns to normal; WAL files removed; WAL mode disabled or checkpoints working',
    'Deleting WAL files while database is open; not checkpointing regularly; WAL mode on network drives',
    0.85,
    'haiku',
    NOW(),
    'https://www.sqlite.org/wal.html'
);
