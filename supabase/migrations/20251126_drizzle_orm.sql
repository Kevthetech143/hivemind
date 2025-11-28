INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'TypeError: db.execute is not a function',
    'database',
    'HIGH',
    '[
        {"solution": "SQLite does not have db.execute(). Use db.run() for no results, db.get() for single row, db.all() for array of rows, or db.values() for values only", "percentage": 95},
        {"solution": "Check if you''re using SQLite driver - this method exists only in PostgreSQL/MySQL adapters. Consult drizzle documentation for your specific driver", "percentage": 85}
    ]'::jsonb,
    'Using Drizzle ORM with SQLite database driver. Knowledge of which database driver methods are available.',
    'Verify db.run(), db.get(), db.all() or db.values() executes without error. Check query returns expected data type.',
    'Copying PostgreSQL code to SQLite without checking driver API differences. Assuming all methods are universal across drivers.',
    0.95,
    'haiku',
    NOW(),
    'https://github.com/drizzle-team/drizzle-orm/issues/2331'
),
(
    'npm ERR! code ERESOLVE: ERESOLVE could not resolve peer dependency on react',
    'installation',
    'HIGH',
    '[
        {"solution": "Create .npmrc file with legacy-peer-deps=true and strict-peer-dependencies=false, then run npm install drizzle-orm", "percentage": 95},
        {"solution": "Use npm install drizzle-orm --legacy-peer-deps flag to bypass peer dependency checking", "percentage": 90},
        {"solution": "Update to latest drizzle-orm version which removed strict React peer dependency constraints", "percentage": 85}
    ]'::jsonb,
    'npm v7+ with strict peer dependency checking enabled. Drizzle ORM listed as optional dependency with conflicting React version constraints.',
    'npm install completes successfully. drizzle-orm package appears in node_modules. No dependency conflict warnings.',
    'Trying to force install with npm install --force which bypasses all dependency checks. Not updating drizzle-orm to latest version.',
    0.92,
    'haiku',
    NOW(),
    'https://github.com/drizzle-team/drizzle-orm/issues/2401'
),
(
    'TransactionRollbackError: Rollback at PostgresJsTransaction.rollback',
    'database',
    'MEDIUM',
    '[
        {"solution": "Wrap tx.rollback() in try-catch block. This is intentional design - catch TransactionRollbackError to stop transaction execution flow", "percentage": 95},
        {"solution": "Use conditional check before calling tx.rollback() to avoid throwing error", "percentage": 85}
    ]'::jsonb,
    'Using Drizzle ORM v0.27.2+ with database transactions. Understanding of transaction control flow.',
    'Transaction rolls back without crashing application. Error is caught and handled gracefully in catch block.',
    'Assuming tx.rollback() silently rolls back without throwing. Not catching TransactionRollbackError exception.',
    0.90,
    'haiku',
    NOW(),
    'https://github.com/drizzle-team/drizzle-orm/issues/1447'
),
(
    'npm ERR! code ERESOLVE: Could not resolve dependency peerOptional mysql2>=2 <3',
    'installation',
    'MEDIUM',
    '[
        {"solution": "Update to drizzle-orm v0.23.0 or later which removed the mysql2 major version restriction", "percentage": 98},
        {"solution": "Use npm install --legacy-peer-deps as temporary workaround while using older drizzle-orm version", "percentage": 85}
    ]'::jsonb,
    'Using drizzle-orm v0.21.1 with mysql2 v3.x. npm v7+ strict peer dependency checking.',
    'npm install completes. mysql2 v3.x installs alongside drizzle-orm. Drizzle MySQL operations work correctly.',
    'Downgrading mysql2 to v2.x instead of upgrading drizzle-orm. Not checking version compatibility matrix.',
    0.98,
    'haiku',
    NOW(),
    'https://github.com/drizzle-team/drizzle-orm/issues/276'
),
(
    'LibsqlError: SQLITE_UNKNOWN: SQLite error: no such table: main.__old_push_table',
    'migration',
    'MEDIUM',
    '[
        {"solution": "Use drizzle-kit v0.21.0+ which fixed DROP TABLE to use IF EXISTS clause. Or manually add IF EXISTS to drop statement.", "percentage": 95},
        {"solution": "Run drizzle-kit push without --force flag on initial migrations to avoid temporary table creation", "percentage": 80}
    ]'::jsonb,
    'Using drizzle-kit push --force on SQLite. drizzle-kit version prior to v0.21.0.',
    'drizzle-kit push completes successfully without errors. Migration applies to database.',
    'Using old drizzle-kit version that doesn''t use IF EXISTS. Running --force on first migration when not necessary.',
    0.88,
    'haiku',
    NOW(),
    'https://github.com/drizzle-team/drizzle-orm/issues/2789'
),
(
    'PostgreSQL insert removes milliseconds from timestamp - input 2023-08-15T21:36:45.531Z returned as 2023-08-15T21:36:45.000Z',
    'database',
    'MEDIUM',
    '[
        {"solution": "Update to drizzle-orm v0.29.3+ which fixed timestamp precision handling by using toISOString() instead of toUTCString()", "percentage": 98},
        {"solution": "Set timestamp column mode to ''string'' to preserve millisecond precision in older versions: timestamp(''col'', {withTimezone: true, mode: ''string''})", "percentage": 90}
    ]'::jsonb,
    'Using PostgreSQL with Drizzle ORM. Storing datetime values with millisecond precision.',
    'Timestamp stored and retrieved with milliseconds intact. Input and output match to millisecond precision.',
    'Using older drizzle-orm versions without upgrading. Not checking timestamp column mode setting.',
    0.96,
    'haiku',
    NOW(),
    'https://github.com/drizzle-team/drizzle-orm/issues/1061'
),
(
    'TypeScript error: Object literal may only specify known properties, ''where'' does not exist on one-to-one join type',
    'type-system',
    'MEDIUM',
    '[
        {"solution": "Update to drizzle-orm v0.32.0+ which fixed type definition to allow ''where'' clause on both ''many'' and ''one'' relation types", "percentage": 98},
        {"solution": "Workaround: Use raw SQL query instead of relational API for one-to-one relations until upgrade", "percentage": 75}
    ]'::jsonb,
    'Using Drizzle ORM v<0.32.0 with one-to-one relationships. TypeScript strict mode enabled.',
    'where() clause accepted on relational query without TypeScript error. Query executes and returns filtered results.',
    'Using old Drizzle version. Assuming type errors mean the query is impossible instead of type definition issue.',
    0.96,
    'haiku',
    NOW(),
    'https://github.com/drizzle-team/drizzle-orm/issues/676'
),
(
    'MySQL DatabaseError: syntax error - UPDATE generates invalid SQL with missing values: update `Group` set `name` = , `unique_name` = ?',
    'database',
    'MEDIUM',
    '[
        {"solution": "Filter out undefined values before calling .set(): const filtered = Object.fromEntries(Object.entries(data).filter(([_, v]) => v !== undefined)); await db.update(table).set(filtered)", "percentage": 95},
        {"solution": "Only pass keys you want to update to .set() instead of spreading entire object with undefined values", "percentage": 90}
    ]'::jsonb,
    'MySQL or MariaDB database. Using update().set() with object containing undefined values.',
    'UPDATE query executes without SQL syntax error. Only non-undefined columns are included in SET clause.',
    'Spreading entire object with undefined values into .set() without filtering. Assuming Drizzle handles undefined automatically.',
    0.92,
    'haiku',
    NOW(),
    'https://github.com/drizzle-team/drizzle-orm/issues/448'
),
(
    'MySQL error: You have an error in your SQL syntax - defaultNow() generates (now()) instead of now()',
    'schema',
    'MEDIUM',
    '[
        {"solution": "Update to drizzle-orm v0.28.6+ which fixed code generator to not wrap now() in extra parentheses", "percentage": 98},
        {"solution": "Use raw SQL for timestamp default until upgrade: default: sql`CURRENT_TIMESTAMP`", "percentage": 85}
    ]'::jsonb,
    'Using drizzle-orm v<0.28.6 with MySQL. Using defaultNow() on timestamp columns.',
    'Migration SQL generates correct now() syntax. Column defaults to current timestamp on insert.',
    'Using outdated drizzle-orm version. Not checking generated migration SQL before applying.',
    0.96,
    'haiku',
    NOW(),
    'https://github.com/drizzle-team/drizzle-orm/issues/1134'
),
(
    'MySQL syntax error: NOT NULL before GENERATED ALWAYS AS - `draft` boolean NOT NULL GENERATED ALWAYS AS (...) VIRTUAL',
    'schema',
    'MEDIUM',
    '[
        {"solution": "Update to drizzle-orm v0.30.0+ which fixed modifier ordering. Correct syntax is: GENERATED ALWAYS AS (...) VIRTUAL NOT NULL", "percentage": 98},
        {"solution": "Manually edit generated migration to place NOT NULL after GENERATED ALWAYS AS clause", "percentage": 85}
    ]'::jsonb,
    'Using MySQL with Drizzle ORM. Using generatedAlwaysAs() with notNull() modifier on generated columns.',
    'Migration SQL generates correct MySQL syntax with modifiers in right order. Generated column stores values correctly.',
    'Using old Drizzle version without checking. Assuming generated SQL is always correct.',
    0.95,
    'haiku',
    NOW(),
    'https://github.com/drizzle-team/drizzle-orm/issues/2638'
),
(
    'Error: Too many connections - connection pool exhausted with Hot Module Replacement (HMR)',
    'connection',
    'MEDIUM',
    '[
        {"solution": "Use singleton pattern for database instance: store db in globalThis during development to prevent creating new connections on HMR reloads", "percentage": 95},
        {"solution": "Set reasonable connection pool limits (e.g., connectionLimit: 10) to prevent unbounded growth", "percentage": 85}
    ]'::jsonb,
    'MySQL with Drizzle ORM in development environment with HMR enabled. Using mysql2/promise createPool.',
    'Database connections remain stable during HMR module reloads. ''Too many connections'' error does not occur.',
    'Creating new database connection instance on every module reload. Not implementing singleton pattern.',
    0.92,
    'haiku',
    NOW(),
    'https://github.com/drizzle-team/drizzle-orm/issues/1988'
),
(
    'PostgreSQL error: column excluded.processdefinitionid does not exist - case sensitivity in onConflictDoUpdate',
    'database',
    'MEDIUM',
    '[
        {"solution": "Wrap camelCase column names in double quotes in sql`` template: sql`excluded.\"processDefinitionId\"` to preserve casing", "percentage": 95},
        {"solution": "Use dynamic column mapping: Object.fromEntries(Object.keys(data).map(x => [x, sql.raw(`excluded.\"${x}\"`)]))", "percentage": 85}
    ]'::jsonb,
    'PostgreSQL with Drizzle ORM using onConflictDoUpdate with camelCase column names.',
    'onConflictDoUpdate executes without case sensitivity error. Conflict handling works on all columns.',
    'Not quoting column names in excluded.* references. PostgreSQL converts unquoted identifiers to lowercase.',
    0.90,
    'haiku',
    NOW(),
    'https://github.com/drizzle-team/drizzle-orm/issues/675'
),
(
    'TypeScript requires serial/autoIncrement field during insert even though PostgreSQL generates value automatically',
    'type-system',
    'MEDIUM',
    '[
        {"solution": "Use Omit utility type to remove id from insert type: type InsertTable = Omit<InferModel<typeof table, ''insert''>, ''id''>;", "percentage": 95},
        {"solution": "Explicitly define insert type without id field instead of relying on type inference", "percentage": 90}
    ]'::jsonb,
    'PostgreSQL with Drizzle ORM using serial/smallserial/bigserial primary keys. TypeScript type inference.',
    'Insert operations work without requiring id field. Type system correctly recognizes serial columns as optional on insert.',
    'Assuming type inference automatically handles serial columns. Using full table type for inserts.',
    0.88,
    'haiku',
    NOW(),
    'https://github.com/drizzle-team/drizzle-orm/issues/663'
),
(
    'TypeScript error: Argument of type ''Placeholder'' is not assignable to parameter of type ''number'' for limit/offset',
    'type-system',
    'MEDIUM',
    '[
        {"solution": "Update to drizzle-orm v0.36.1+ which fixed type definition to accept Placeholder in limit() and offset()", "percentage": 98},
        {"solution": "Workaround for older versions: cast placeholder as never: sql.placeholder(''limit'') as never", "percentage": 80}
    ]'::jsonb,
    'Using drizzle-orm v<0.36.1 with prepared statements using sql.placeholder() in limit or offset.',
    'Prepared statement with placeholder limit/offset compiles without TypeScript error. Query executes correctly.',
    'Using outdated drizzle-orm version. Not upgrading to fix type definition issue.',
    0.94,
    'haiku',
    NOW(),
    'https://github.com/drizzle-team/drizzle-orm/issues/2146'
),
(
    'Error: undefined is not an object (evaluating ''relation.referencedTable'')',
    'schema',
    'MEDIUM',
    '[
        {"solution": "Import both schema tables and relation definitions, then spread both into drizzle constructor schema object: {...schema, ...relations}", "percentage": 98},
        {"solution": "Explicitly list all tables and relations in schema config: schema: {products, productsRelations, categories, categoriesRelations}", "percentage": 95}
    ]'::jsonb,
    'Using Drizzle ORM with relational queries. Separate files for schema and relations.',
    'Relational queries execute without error. Nested relations populate correctly in results.',
    'Importing only tables into schema, forgetting to include relation definitions. Not spreading relations into config.',
    0.95,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/78177831/drizzle-db-query-throwing-undefined-is-not-an-object-evaluating-relation-refe'
),
(
    'PostgreSQL syntax error with array placeholder in inArray() prepared statements',
    'database',
    'MEDIUM',
    '[
        {"solution": "Avoid sql.placeholder() with inArray() in prepared statements - use dynamic query building instead: inArray(table.id, ids)", "percentage": 85},
        {"solution": "For SQLite workaround: use json_each() to expand array: sql`id IN (SELECT value FROM json_each(${sql.placeholder(\"ids\")}))`", "percentage": 70}
    ]'::jsonb,
    'PostgreSQL or SQLite with Drizzle ORM. Using prepared statements with array placeholders.',
    'Query executes without syntax error. Array values properly expanded in IN clause. Correct number of results returned.',
    'Using sql.placeholder() with inArray() expecting it to serialize array automatically. Not using dynamic query building.',
    0.80,
    'haiku',
    NOW(),
    'https://github.com/drizzle-team/drizzle-orm/issues/2872'
),
(
    'PostgreSQL JSONB objects stored as escaped strings instead of native JSONB - breaking JSON query operators',
    'database',
    'MEDIUM',
    '[
        {"solution": "Cast objects to JSONB explicitly: payload: sql`${data}::jsonb` when inserting into JSONB column", "percentage": 98},
        {"solution": "Use raw SQL execution instead of parameterized queries for JSONB to allow proper type conversion", "percentage": 85}
    ]'::jsonb,
    'PostgreSQL with postgres-js driver and Drizzle ORM. Inserting objects into JSONB columns.',
    'JSONB column stores native JSON structure. JSON operators (@>, ->) work on queried data. Results are parsed as objects not strings.',
    'Passing objects directly without type casting. Assuming parameterized queries handle JSONB conversion automatically.',
    0.93,
    'haiku',
    NOW(),
    'https://github.com/drizzle-team/drizzle-orm/issues/724'
),
(
    'MySQL/MariaDB syntax error: serial AUTO_INCREMENT NOT NULL - serial type already includes AUTO_INCREMENT',
    'schema',
    'MEDIUM',
    '[
        {"solution": "Use int() with autoincrement() instead of serial() for MySQL/MariaDB: int(''id'', {unsigned: true}).autoincrement().primaryKey()", "percentage": 98},
        {"solution": "serial() type is PostgreSQL-specific - check your database type when copying schemas between projects", "percentage": 85}
    ]'::jsonb,
    'MySQL or MariaDB with Drizzle ORM. Using serial() type for primary keys.',
    'Schema generates without syntax errors. Primary key auto-increments on insert. Correct MySQL SQL syntax produced.',
    'Using PostgreSQL-specific serial() type in MySQL. Not checking database dialect differences.',
    0.95,
    'haiku',
    NOW(),
    'https://github.com/drizzle-team/drizzle-orm/issues/3333'
),
(
    'Error: Can''t add new command when connection is in closed state - MySQL single connection becomes stale',
    'connection',
    'MEDIUM',
    '[
        {"solution": "Use mysql.createPool() instead of mysql.createConnection() to maintain reusable connection pool", "percentage": 98},
        {"solution": "Set connectionLimit in pool config to reasonable value (10-20) based on your workload", "percentage": 90}
    ]'::jsonb,
    'MySQL with Drizzle ORM. Using createConnection() for database access. Running in Bun or multi-threaded environment.',
    'Database queries execute without connection state errors. Connections remain stable under load across threads.',
    'Using single connection across multiple threads or HMR reloads. Not implementing connection pool pattern.',
    0.96,
    'haiku',
    NOW(),
    'https://github.com/drizzle-team/drizzle-orm/issues/1747'
),
(
    'PostgreSQL error: relation "public.artist" does not exist during migration',
    'migration',
    'MEDIUM',
    '[
        {"solution": "Add schemaFilter to drizzle.config.ts to specify target schema: schemaFilter: ''public''", "percentage": 90},
        {"solution": "Manually edit migration to remove \"public.\" prefix from foreign key references if table already exists", "percentage": 80},
        {"solution": "Ensure referenced table is created before creating foreign key constraints - check migration order", "percentage": 75}
    ]'::jsonb,
    'PostgreSQL with Drizzle ORM and drizzle-kit. Running migrations with foreign key constraints.',
    'Migration applies successfully without relation not found errors. Foreign keys reference correct tables.',
    'Not specifying target schema in config. Assuming ''public'' schema automatically. Not checking migration file order.',
    0.85,
    'haiku',
    NOW(),
    'https://github.com/drizzle-team/drizzle-orm/issues/2891'
);
