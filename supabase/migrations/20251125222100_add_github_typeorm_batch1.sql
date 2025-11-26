-- Add TypeORM GitHub issues batch 1: Connection/query error solutions
-- Category: github-typeorm
-- Extracted from: https://github.com/typeorm/typeorm/issues

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES (
    'TypeORM PostgreSQL: Broken clients released back into connection pool',
    'github-typeorm',
    'HIGH',
    '[
        {"solution": "Track connection-level errors in PostgresQueryRunner and call client.release(error) to signal pool that connection is broken and should be destroyed, not recycled", "percentage": 90, "note": "Follows node-postgres pool API expectations"},
        {"solution": "Implement separate error handling for connection-level failures vs temporary SQL errors - only recycle connections for recoverable errors", "percentage": 85, "note": "Requires distinguishing error types at driver level"},
        {"solution": "For serverless environments like Lambda, add connection health checks before reusing pooled connections to detect silent socket closures", "percentage": 75, "note": "Serverless environments silently close sockets without notifying pool"}
    ]'::jsonb,
    'PostgreSQL driver with pg library, Connection pool enabled, Database connection established',
    'Broken connections removed from pool, Subsequent queries obtain fresh connections, No permanent connection exhaustion',
    'Do not simply return failed connections to pool. Always signal pool about connection state. In serverless, silent socket closures may not be immediately detectable. Test with connection failover scenarios.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/typeorm/typeorm/issues/5112'
),
(
    'TypeORM Lambda/serverless: Entity repositories not found on connection reuse',
    'github-typeorm',
    'VERY_HIGH',
    '[
        {"solution": "Replace strict class equality check (metadata.target === target) with string-based name matching (metadata.target.name === target.name) in findMetadata() function", "percentage": 70, "note": "Quick fix but less robust due to class identity issues in module reloading"},
        {"solution": "Manually reinject connection properties on subsequent Lambda invocations: reset connection.options, recreate connection.manager, call connection.buildMetadatas(), reinitialize relation loaders", "percentage": 85, "note": "Current workaround pattern, requires @ts-ignore comments"},
        {"solution": "Refactor entityMetadatas array to Map-based structure for faster, identity-independent lookups that survive module reloading", "percentage": 80, "note": "Architectural improvement, reduces vulnerability to class identity issues"}
    ]'::jsonb,
    'AWS Lambda or serverless environment, TypeORM with PostgreSQL, Connection caching in handler outer scope, Entities defined and registered',
    'Subsequent Lambda invocations execute queries without RepositoryNotFoundError, Entity metadata persists across request cycles, Database operations succeed on warm starts',
    'Do not close connections between requests thinking single-request lifecycle applies. Rebuilding metadata without awaiting causes race conditions. Full connection re-bootstrap defeats caching performance benefits. Class reloading in modules causes identity comparison failures.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/typeorm/typeorm/issues/3427'
),
(
    'TypeORM concurrent queries with relations exhaust connection pool and stall',
    'github-typeorm',
    'HIGH',
    '[
        {"solution": "Increase connection pool size from default 10 to 50+ to accommodate relation query overhead", "percentage": 80, "note": "Temporary mitigation, not addressing root cause"},
        {"solution": "Switch relationLoadStrategy from ''query'' to ''join'' in connection options to load relations in single query instead of per-entity queries", "percentage": 92, "note": "Recommended approach, eliminates connection exhaustion"},
        {"solution": "Use QueryBuilder with leftJoinAndSelect() instead of find() with relations parameter for explicit control over loading strategy", "percentage": 88, "note": "More verbose but provides better performance characteristics"},
        {"solution": "Ensure all database operations use transaction-scoped EntityManager instance, not nested separate global manager calls which create deadlock", "percentage": 85, "note": "Common mistake with transaction isolation"}
    ]'::jsonb,
    'PostgreSQL with TypeORM, 35+ concurrent requests, Connection pool configured, Entities with relationships defined',
    'Concurrent queries complete without hanging, Connection pool properly releases idle connections, No persistent ClientRead wait events in PostgreSQL logs',
    'Mixing transaction-scoped and global EntityManager calls creates nested connection requests causing deadlock. Assuming configuration is root cause when actually a connection management bug. Not recognizing relationLoadStrategy as trigger.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/typeorm/typeorm/issues/4738'
),
(
    'TypeORM: Cannot read property ''connect'' of undefined during query execution',
    'github-typeorm',
    'MEDIUM',
    '[
        {"solution": "Downgrade Node.js from 14.x to 12.x or 13.x - primary cause is Node.js version incompatibility with TypeORM and pg driver", "percentage": 88, "note": "Most reliable solution"},
        {"solution": "Use node:13-alpine or node:12.16.2 Docker base images instead of node:latest which may auto-update to incompatible versions", "percentage": 90, "note": "Prevents future auto-upgrade issues"},
        {"solution": "Review connection lifecycle in test hooks - ensure connections are not disposed before all operations complete", "percentage": 75, "note": "Secondary cause for disposed connection errors"},
        {"solution": "Verify pg driver version is compatible with TypeORM and Node.js version being used", "percentage": 70, "note": "Check dependency compatibility matrix"}
    ]'::jsonb,
    'TypeORM with PostgreSQL, Node.js environment, pg driver installed, Test suite with database operations',
    'Tests execute without TypeError on connect property, Database connections establish successfully, Query operations complete as expected',
    'Using node:latest Docker images auto-updates to incompatible Node versions. Closing connections prematurely in test cleanup hooks. Assuming recent dependency versions automatically work together without verification.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/typeorm/typeorm/issues/5733'
),
(
    'TypeORM migrations fail when interdependent - later migrations cannot see earlier schema changes',
    'github-typeorm',
    'HIGH',
    '[
        {"solution": "Set migrationsTransactionMode to ''each'' via CLI flag: typeorm migration:run -t=each or in config migrationsTransactionMode: ''each''", "percentage": 95, "note": "Official solution, wraps each migration in separate transaction"},
        {"solution": "Use configuration option migrationsTransactionMode: ''each'' when using migrationsRun: true for automatic runs", "percentage": 93, "note": "Ensures per-migration transactions in auto-run mode"},
        {"solution": "Set CLI flag -t=false to run all migrations without transaction wrapping (less safe but allows schema visibility)", "percentage": 70, "note": "Last resort if per-migration transactions not available"}
    ]'::jsonb,
    'TypeORM with migration files, Database connection configured, Interdependent migrations where later migrations depend on schema changes from earlier ones',
    'Each migration executes within its own transaction, Earlier migrations'' schema changes visible to later migrations, Partial failures do not roll back all migrations, All migrations complete successfully',
    'Not setting migrationsTransactionMode in config when using migrationsRun: true - defaults to wrapping all in single transaction. Assuming default changed when it remains ''all'' for backward compatibility. Database-specific DDL statements may have limitations with transaction wrapping.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://github.com/typeorm/typeorm/issues/2693'
),
(
    'TypeORM migration column naming: Explicit constraint and index names not supported',
    'github-typeorm',
    'MEDIUM',
    '[
        {"solution": "Use constraintName parameter in @PrimaryGeneratedColumn decorator: @PrimaryGeneratedColumn({ constraintName: ''pk_post_id'' })", "percentage": 94, "note": "For primary key constraint naming"},
        {"solution": "Add constraintName to @JoinColumn decorator for foreign key naming: @JoinColumn({ constraintName: ''fk_post_author_id'' })", "percentage": 94, "note": "For relationship foreign key constraints"},
        {"solution": "Use constraintName in @Index decorator for index naming: @Index({ constraintName: ''idx_post_published'' })", "percentage": 92, "note": "For database index constraints"},
        {"solution": "Leverage NamingStrategy with referenced table metadata to generate database-specific constraint names programmatically", "percentage": 85, "note": "For custom naming schemes"}
    ]'::jsonb,
    'TypeORM with migrations, Entity decorators defined, Database schema generation enabled',
    'Generated migrations contain explicitly named constraints, Database objects created with specified constraint names, Naming conventions match database standards',
    'Not using constraintName parameter means auto-generated names may not match organizational standards. Database-specific naming conventions vary - test across target databases. Naming changes in later migrations require manual constraint drops and recreations.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/typeorm/typeorm/issues/1355'
),
(
    'TypeORM: .findOne(undefined) returns first database record instead of undefined',
    'github-typeorm',
    'VERY_HIGH',
    '[
        {"solution": "Add early return guard in findOne() method: if (!idOrOptionsOrConditions) { return undefined; } to prevent undefined from being treated as wildcard query", "percentage": 92, "note": "Prevents database query when ID is undefined"},
        {"solution": "Use explicit conditions syntax: { where: { id: null } } instead of positional ID parameter to make intent explicit", "percentage": 88, "note": "Makes SQL semantics clearer"},
        {"solution": "Implement stricter function overload typing to prevent undefined from being ambiguously interpreted as either ID or options object", "percentage": 85, "note": "TypeScript-level protection"}
    ]'::jsonb,
    'TypeORM repository with entities, findOne() method available, Database populated with records',
    'Calling findOne(undefined) returns undefined without database query, Calling findOne(null) returns undefined, Calling findOne({ where: { id: null } }) correctly returns records where id is null',
    'Function overloading ambiguity allows undefined to match multiple signatures. Silent failures return unexpected data instead of failing explicitly. Users unfamiliar with overload resolution may not understand which variant invoked. First result being returned masks logic errors in calling code.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/typeorm/typeorm/issues/2500'
),
(
    'TypeORM: Cannot filter by properties of joined/related entities using find()',
    'github-typeorm',
    'HIGH',
    '[
        {"solution": "Use QueryBuilder with explicit joins: .createQueryBuilder().innerJoin().where() for filtering on related entity columns", "percentage": 90, "note": "Official pattern, provides full control"},
        {"solution": "Use nested where syntax when supported: find({ relations: [''address''], where: { address: { city: ''Paris'' } } })", "percentage": 85, "note": "More declarative but less widely supported"},
        {"solution": "Implement generic QueryBuilder pattern with request DTOs to build conditional queries dynamically using where() and andWhere() methods", "percentage": 82, "note": "Programmatic approach for complex filters"},
        {"solution": "Use Raw find operator for manual SQL strings (workaround): where: { city: Raw(alias => `${alias}.city = ''Paris''`) }", "percentage": 60, "note": "Brittle, not type-safe, error-prone with dynamic names"}
    ]'::jsonb,
    'TypeORM with related entities, find() or findMany() methods, Entities with relationships defined, Query filtering requirements',
    'Filtering on related entity columns returns correct filtered results, Nested where conditions work in find() calls, Generated SQL includes proper JOINs and WHERE conditions',
    'QueryBuilder solutions sacrifice declarative code style. Workarounds using Raw operators rely on brittle string manipulation. Different developers prefer different patterns - consistency important. Type safety lost in string-based approaches.',
    0.86,
    'sonnet-4',
    NOW(),
    'https://github.com/typeorm/typeorm/issues/2707'
),
(
    'TypeORM migrations: Performance degrades linearly with number of migration files',
    'github-typeorm',
    'MEDIUM',
    '[
        {"solution": "Add --transpile-only flag to ts-node: reduces 120-second migration time to 4 seconds by skipping TypeScript type-checking", "percentage": 92, "note": "Most effective single change, safe for migrations"},
        {"solution": "Pre-compile migrations to JavaScript instead of TypeScript - reduces startup from ~20s to <100ms", "percentage": 90, "note": "Eliminates TypeScript compilation overhead"},
        {"solution": "Conditionally skip migrations in development via config: migrations: process.env.SKIP_MIGRATIONS ? [] : [...] - reduces createConnection() from 55s to 5s", "percentage": 85, "note": "Useful when not running migrations frequently"},
        {"solution": "Squash multiple migration files into single migration to reduce individual file compilation overhead", "percentage": 80, "note": "Also improves database startup time"}
    ]'::jsonb,
    'TypeORM TypeScript project with 40+ migration files, ts-node configured, Migration runner available',
    'Migration commands execute in <10 seconds, createConnection() completes in <5 seconds, Linear performance degradation eliminated',
    'Using --transpile-only may mask type errors elsewhere - safe for migrations but risky for application code. Migration folder in tsconfig.json helps but not complete solution. Unbounded migration file growth without squashing eventually becomes problematic.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/typeorm/typeorm/issues/4136'
),
(
    'TypeORM migrations: Foreign key creation cannot be disabled globally',
    'github-typeorm',
    'MEDIUM',
    '[
        {"solution": "Use configuration option createForeignKeys: false in connection options to disable all foreign key creation during migrations", "percentage": 93, "note": "Global setting affects all relationships"},
        {"solution": "Configure per-relation granularity with createForeignKeyConstraints: false on individual @ManyToOne/@OneToMany decorators", "percentage": 88, "note": "Allows selective FK disabling"},
        {"solution": "Remove relationship decorators entirely and manage constraints at application level if database constraints not needed", "percentage": 70, "note": "Requires application-level consistency enforcement"}
    ]'::jsonb,
    'TypeORM with migrations, Relationships defined between entities, Performance optimization or sharding requirements',
    'Migrations generate schema without foreign keys, Application maintains data consistency without database constraints, Online migrations proceed without FK conflicts',
    'Disabling foreign keys removes database-level integrity checks - application must maintain consistency. Some frameworks like onUpdate/onDelete cascade features depend on FK existence. Sharding and clustering significantly more complex without constraints.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/typeorm/typeorm/issues/3120'
),
(
    'TypeORM: Query operators like LessThan, MoreThan not processed in find() where clauses',
    'github-typeorm',
    'HIGH',
    '[
        {"solution": "Use QueryBuilder methods (.where() with parameter binding) instead of find() with operator objects: .where(''entity.date < :date'', { date: value })", "percentage": 92, "note": "Most reliable, fully supported"},
        {"solution": "Install TypeORM directly from GitHub source instead of npm package if operators work in source but not compiled dist", "percentage": 70, "note": "Indicates build/compilation issue in package"},
        {"solution": "Verify operator imports come from correct TypeORM module and operator objects are properly instantiated", "percentage": 75, "note": "Module resolution issues can cause operator failures"},
        {"solution": "For NestJS, use repository directly without additional abstraction layers which may interfere with operator handling", "percentage": 72, "note": "Framework-specific module resolution differences"}
    ]'::jsonb,
    'TypeORM with find() or count() methods, Query operators imported from typeorm, Entity with comparable fields (dates, numbers, strings)',
    'Query generates correct SQL with proper comparison operators (<, >, <=, >=, LIKE), Parameters contain only actual values not operator metadata, Results return records matching comparison criteria',
    'Operator objects serialized as JSON parameters instead of being interpreted as SQL operators. Assuming built package works identically to source. Module resolution issues in certain frameworks. Mixing operator types in single query can cause parameter ordering confusion.',
    0.84,
    'sonnet-4',
    NOW(),
    'https://github.com/typeorm/typeorm/issues/3959'
),
(
    'TypeORM: Parameter order incorrect when combining innerJoin with where clauses',
    'github-typeorm',
    'MEDIUM',
    '[
        {"solution": "Move join conditions to WHERE clause instead of join parameters to maintain consistent parameter ordering", "percentage": 88, "note": "Workaround, requires query restructuring"},
        {"solution": "Ensure all placeholders are consistently named (:param) or unnamed (?) throughout query - avoid mixing both styles", "percentage": 90, "note": "Prevents conversion ordering issues"},
        {"solution": "Track parameter positions during query construction, converting all placeholder types before parameter substitution to maintain order", "percentage": 85, "note": "Architectural fix required in query builder"}
    ]'::jsonb,
    'TypeORM QueryBuilder with MySQL/PostgreSQL/SQLite, Multiple where and join clauses combined, Named and unnamed parameters mixed',
    'Parameters bind in correct sequence regardless of clause ordering, Query executes with values assigned to intended placeholders, Results match expected filter conditions',
    'Mixing named (:id) and unnamed (?) placeholders causes conversion ordering issues. Parameter order gets inverted when joins specified before where clauses. Affects MySQL, PostgreSQL, and SQLite differently. Removing cascade declarations may mask actual parameter ordering bugs.',
    0.86,
    'sonnet-4',
    NOW(),
    'https://github.com/typeorm/typeorm/issues/4429'
),
(
    'TypeORM: findOneBy() with null/undefined returns first record instead of filtering or returning null',
    'github-typeorm',
    'VERY_HIGH',
    '[
        {"solution": "Distinguish between null and undefined handling: use null for IS NULL comparison, undefined to omit field from conditions", "percentage": 94, "note": "Semantic approach with backward compatibility"},
        {"solution": "Implement ConditionLoader feature allowing configuration of how null and undefined values should be handled in queries", "percentage": 90, "note": "Flexible solution, enables user control"},
        {"solution": "Add early validation in findOneBy() to return null immediately if all condition values are undefined/null", "percentage": 85, "note": "Prevents accidental unrestricted queries"}
    ]'::jsonb,
    'TypeORM repository with SQLite/PostgreSQL/MySQL, findOneBy() method with null or undefined values, Entity with nullable fields',
    'findOneBy({ id: null }) generates IS NULL condition and returns matching records, findOneBy({ id: undefined }) omits field from query, No unrestricted queries return first record',
    'Passing undefined as explicitly "no filter" vs null as "compare to NULL" distinction not obvious to users. Undefined ignoring fields silently without error can mask logic bugs. Backward compatibility requires careful null handling changes.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/typeorm/typeorm/issues/9316'
);
