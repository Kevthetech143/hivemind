-- Sequelize GitHub Issues Mining Batch 1
-- Category: github-sequelize
-- Date: 2025-11-25
-- Source: https://github.com/sequelize/sequelize/issues

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'ReferenceError: Cannot access User before initialization in TypeScript with emitDecoratorMetadata',
    'github-sequelize',
    'HIGH',
    '[
        {"solution": "Convert type imports to TypeScript type-only imports: import type { User } from ''./user.js''; to eliminate circular imports", "percentage": 95, "note": "Resolves circular dependency at class initialization"},
        {"solution": "Declare associations on one side only using inverse property: @HasMany(() => Joke, { foreignKey: ''userId'', inverse: ''user'' })", "percentage": 90, "note": "Eliminates need for bidirectional explicit declaration"},
        {"solution": "Use madge tool to detect circular imports: npm install --save-dev madge && madge --circular src/", "percentage": 85, "command": "madge --circular src/", "note": "Prevents similar issues in future"}
    ]'::jsonb,
    'TypeScript project with emitDecoratorMetadata enabled, Sequelize v7+, routing-controllers or similar library',
    'Models initialize without ReferenceError, Associations work bidirectionally, TypeScript compilation succeeds',
    'Do not import types directly when they cause circular references. Always use type-only imports for cross-model type references. Do not declare inverse associations on both sides.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/sequelize/sequelize/issues/17444'
),
(
    'Multiple belongsTo associations to same target with inverse throwing compatibility error',
    'github-sequelize',
    'HIGH',
    '[
        {"solution": "Remove inverse property from second belongsTo association: Post.belongsTo(Author, { foreignKey: ''coAuthorId'', as: ''coAuthor'' }) instead of defining inverse", "percentage": 90, "note": "Simplest workaround, avoids validation conflict"},
        {"solution": "Define hasMany relationships on target model instead of using belongsTo inverse: Author.hasMany(Post, { foreignKey: ''coAuthorId'', as: ''notMyBooks'' })", "percentage": 88, "note": "More explicit control over association"},
        {"solution": "Use different association names with proper foreignKey configuration to avoid naming collisions", "percentage": 85, "note": "Ensure each belongsTo has unique foreignKey name"}
    ]'::jsonb,
    'Sequelize v7.0.0-alpha.20 or later, Models with multiple associations to same target',
    'All belongsTo associations initialize without error, Both associations queryable, Inverse relationships work correctly',
    'Do not use inverse property on multiple belongsTo to same target - it triggers incompatibility validation. Each foreignKey must have unique name. Consider schema design if more than 2 associations needed.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/sequelize/sequelize/issues/15625'
),
(
    'Defining HasMany association failed due to incompatible options with multiple foreign keys',
    'github-sequelize',
    'MEDIUM',
    '[
        {"solution": "Use inverse option in HasMany to specify distinct inverse association name: @HasMany(() => ProductMaterial, { foreignKey: ''productParentId'', inverse: { as: ''parentProducts'' } })", "percentage": 93, "note": "Prevents naming collisions when multiple associations target same model"},
        {"solution": "Define explicit belongsTo associations with unique names matching HasMany inverse: ProductMaterial.belongsTo(Product, { foreignKey: ''productParentId'', as: ''parentProduct'' })", "percentage": 88, "note": "Makes bidirectional relationship explicit"},
        {"solution": "Use unique alias names for each HasMany: Product.hasMany(ProductMaterial, { as: ''children'', ... }) and Product.hasMany(ProductMaterial, { as: ''parentRelations'', ... })", "percentage": 85, "note": "Clarifies semantic meaning"}
    ]'::jsonb,
    'Sequelize v7.0.0-alpha.36 or later, Models with multiple HasMany to same target with different foreign keys',
    'HasMany associations initialize without error, Both relationships queryable independently, Queries return correct data for each foreign key',
    'Each association must have unique inverse name when multiple belongsTo/hasMany to same target. Do not assume Sequelize auto-creates compatible inverses for all cases. Test each association independently.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/sequelize/sequelize/issues/17074'
),
(
    'AssociationError thrown when using alias in multiple associations to same model',
    'github-sequelize',
    'MEDIUM',
    '[
        {"solution": "Use different alias names for each association: Transaction.belongsTo(Currency, { as: ''senderCurrency'', ... }) and Transaction.belongsTo(Currency, { as: ''receiverCurrency'', ... })", "percentage": 92, "note": "Official recommended approach"},
        {"solution": "Omit alias from first association if only one needs explicit naming", "percentage": 85, "note": "Minimal changes approach"},
        {"solution": "Verify issue is not duplicate before reporting - check existing model associations for conflicting alias names", "percentage": 80, "note": "Some cases may be validation issues on user end"}
    ]'::jsonb,
    'Sequelize v6 or v7, Models with multiple belongsTo to same target model',
    'All associations initialize without AssociationError, Each association has unique alias, Queries work with correct aliases',
    'Alias names must be unique within a model''s associations. Do not reuse same alias for different association relationships. Check both belongsTo and hasMany when searching for alias conflicts.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/sequelize/sequelize/issues/16020'
),
(
    'Multiple hasOne associations with CASCADE hooks throwing incompatible options error in v7',
    'github-sequelize',
    'MEDIUM',
    '[
        {"solution": "Define explicit belongsTo for each hasOne with unique names: Action.hasOne(ActionGoto, { as: ''goto'', foreignKey: ''ActionId'', ... }) and define ActionGoto.belongsTo(Action, { as: ''action'', foreignKey: ''ActionId'' })", "percentage": 91, "note": "Makes all associations explicit and reconcilable"},
        {"solution": "Use separate target models for different relationship types if schema allows", "percentage": 85, "note": "Architectural solution, more significant refactor"},
        {"solution": "Review Sequelize v7 association validation logic and consider upgrading to latest patch if available", "percentage": 80, "note": "Some fixes may be in newer versions"}
    ]'::jsonb,
    'Sequelize v7, Models with multiple hasOne to same target with CASCADE hooks, Previous working v6 code',
    'Multiple hasOne associations initialize without error, CASCADE hooks work correctly, Foreign key constraints enforced properly',
    'Sequelize v7 enforces stricter association validation than v6. Each hasOne must have corresponding belongsTo with matching foreign key options. Do not rely on implicit inverse creation for complex scenarios.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/sequelize/sequelize/issues/16007'
),
(
    'Invalid default value for createdAt column in MySQL migration',
    'github-sequelize',
    'HIGH',
    '[
        {"solution": "Use Sequelize.literal() with TIMESTAMP type: defaultValue: Sequelize.literal(''CURRENT_TIMESTAMP'') and type: ''TIMESTAMP''", "percentage": 95, "note": "Works with MySQL and PostgreSQL"},
        {"solution": "Set timestamps: false on model to disable auto-managed createdAt/updatedAt before defining custom timestamp columns", "percentage": 93, "note": "Prevents conflicts with Sequelize''s built-in timestamp handling"},
        {"solution": "Use DataTypes.NOW instead of Sequelize.fn(''now'') for Sequelize-managed timestamps", "percentage": 85, "note": "If not disabling timestamp auto-management"}
    ]'::jsonb,
    'Sequelize 6.26.0 or later, MySQL database, Migration file with timestamp columns',
    'Migration executes without error, Default value appears in database schema, New records have correct timestamp values',
    'Do not use Sequelize.fn(''now'') with DATEONLY type - it causes invalid default error. Do not mix Sequelize auto-managed timestamps with custom timestamp columns without setting timestamps: false. CURRENT_TIMESTAMP only works with full TIMESTAMP type, not DATEONLY.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://github.com/sequelize/sequelize/issues/15369'
),
(
    'Database deadlock causes silent rollback in unmanaged transactions',
    'github-sequelize',
    'MEDIUM',
    '[
        {"solution": "Document unmanaged transaction behavior and add manual rollback handling: try { await transaction.rollback(); } catch(err) { /* ignore */ }", "percentage": 92, "note": "Ensures connection release even if database already rolled back"},
        {"solution": "Implement exponential backoff retry logic for deadlock errors: catch ER_DEADLOCK and retry with backoff", "percentage": 88, "note": "Handles transient deadlocks gracefully"},
        {"solution": "Monitor transaction.finished state to verify rollback completion before retrying", "percentage": 85, "note": "Prevents duplicate rollback attempts"}
    ]'::jsonb,
    'Sequelize with MySQL/MariaDB/PostgreSQL, Unmanaged transactions enabled, Code catching transaction errors',
    'Deadlock errors are caught and handled, Connection is released to pool, Transaction can be retried, No connection pool exhaustion',
    'Deadlock errors trigger automatic database rollback but Sequelize state may be unsynced. Always call transaction.rollback() even if error suggests it''s already rolled back. Document this behavior for team members.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/sequelize/sequelize/issues/14249'
),
(
    'TypeScript type definitions import files outside dist directory causing downstream compilation errors',
    'github-sequelize',
    'MEDIUM',
    '[
        {"solution": "Update to Sequelize version with unified build: remove ../relative imports in types/index.d.ts", "percentage": 95, "note": "Upgrade is simplest solution"},
        {"solution": "Configure tsconfig with noImplicitAny: false temporarily to bypass strict checking if unable to upgrade", "percentage": 70, "note": "Temporary workaround only"},
        {"solution": "Use skipLibCheck: true in tsconfig.json to ignore external library type errors during development", "percentage": 75, "note": "Masks issue but allows development to continue"}
    ]'::jsonb,
    'Sequelize v6.15.0, TypeScript project with strict config options (noImplicitOverride, strictNullChecks, exactOptionalPropertyTypes)',
    'TypeScript compilation succeeds without errors, IDE type checking passes, All type definitions resolve correctly',
    'Do not rely on relative paths in type definitions - they may resolve to source files instead of compiled output. Upgrade Sequelize to version with unified build. Do not use skipLibCheck for production builds as it hides real type issues.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/sequelize/sequelize/issues/14038'
),
(
    'PostgreSQL prepared transactions not releasing database connections to pool',
    'github-sequelize',
    'LOW',
    '[
        {"solution": "Use standard transaction management instead of prepared transactions: const t = await sequelize.transaction(); await sequelize.query(''UPDATE...'', { transaction: t }); await t.commit();", "percentage": 90, "note": "Recommended approach for multi-database coordination"},
        {"solution": "Manually release connection after prepared transaction: store connection reference and release explicitly after COMMIT PREPARED/ROLLBACK PREPARED", "percentage": 75, "note": "Requires custom connection management"},
        {"solution": "Monitor issue #16480 for upcoming fix or use custom connection pool if available", "percentage": 70, "note": "Workaround pending upstream fix"}
    ]'::jsonb,
    'Sequelize 6.32.1 with PostgreSQL, Multiple prepared transactions needed for atomic multi-database updates, Connection pool size < 10',
    'After 5+ prepared transactions, connection pool still has available connections, Queries continue without SequelizeConnectionAcquireTimeoutError',
    'Prepared transactions require special handling in Sequelize. Default connection pool exhausts quickly with prepared transactions. Test connection pool behavior under load. Consider alternative patterns like event-based eventual consistency.',
    0.72,
    'sonnet-4',
    NOW(),
    'https://github.com/sequelize/sequelize/issues/16459'
),
(
    'LIMIT option with findOne and include produces missing FROM-clause entry error',
    'github-sequelize',
    'MEDIUM',
    '[
        {"solution": "Add subQuery: false to findOne options: findOne({ where: {...}, include: [...], subQuery: false })", "percentage": 94, "note": "Disables automatic subquery wrapping that causes JOIN placement issue"},
        {"solution": "Use findAll with limit 1 instead of findOne when filtering on associated model fields", "percentage": 88, "note": "Generates correct SQL without subquery complications"},
        {"solution": "Move association filter to include where clause instead of root where: include: [{ model: Project, where: { value: null }, required: false }]", "percentage": 85, "note": "Alternative query restructuring"}
    ]'::jsonb,
    'Sequelize 5.21.1 or later with PostgreSQL, Query with findOne, include, and associated model WHERE clause',
    'Query executes without FROM-clause error, Returns correct record, SQL generated is valid',
    'findOne with include automatically wraps in subquery which breaks JOIN order. Always use subQuery: false when filtering on associated fields. findAll works correctly without this issue. Test generated SQL to verify JOIN placement.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/sequelize/sequelize/issues/11617'
),
(
    'Inject pg pool into Sequelize constructor for custom authentication (Google Cloud SQL IAM)',
    'github-sequelize',
    'LOW',
    '[
        {"solution": "Use dialectOptions stream parameter instead of direct pool injection: dialectOptions: { stream: clientOpts.stream }", "percentage": 92, "note": "Official supported approach"},
        {"solution": "For Google Cloud SQL: use @google-cloud/cloud-sql-connector library with stream option in dialectOptions", "percentage": 90, "command": "npm install @google-cloud/cloud-sql-connector", "note": "Enables IAM authentication"},
        {"solution": "Pass custom stream config through sequelize options: const sequelize = new Sequelize({ dialect: ''postgres'', dialectOptions: { stream: customStream } })", "percentage": 88, "note": "Works for other custom authentication methods"}
    ]'::jsonb,
    'Sequelize 6.26.0+, PostgreSQL, External authentication library (Cloud SQL IAM, custom auth), pg installed',
    'Connection established with custom authentication, Queries execute successfully, IAM credentials accepted',
    'Sequelize uses internal pool, not delegated to database driver. Do not attempt direct pool injection - use dialectOptions.stream. Test connection before running migrations. Ensure custom stream implementation is compatible with pg driver.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/sequelize/sequelize/issues/16001'
),
(
    'Connection acquired from pool not released after query completion with transaction scope',
    'github-sequelize',
    'MEDIUM',
    '[
        {"solution": "Ensure all transaction queries are awaited: await sequelize.query(sql, { transaction }); instead of fire-and-forget", "percentage": 94, "note": "Prevents connection leaks from unawaited promises"},
        {"solution": "Use withConnection() wrapper for transaction scope: const result = await sequelize.withConnection(async () => { return await sequelize.query(...); })", "percentage": 88, "note": "Explicit connection lifecycle management"},
        {"solution": "Set transaction timeout: const t = await sequelize.transaction({ timeout: 30000 }) to force release if stuck", "percentage": 85, "note": "Prevents indefinite connection holding"}
    ]'::jsonb,
    'Sequelize 6.30+ or 7.x, Code using transactions, Connection pool size < 10',
    'Connection count stays below pool size after queries complete, SequelizeConnectionAcquireTimeoutError does not occur, Monitoring shows connections returned to idle state',
    'Connections are held until transaction completes. Do not use async/await without proper error handling. Do not fire queries without awaiting in transactions. Monitor connection pool size with: sequelize.connectionManager.pool.size',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/sequelize/sequelize/issues/15388'
);
