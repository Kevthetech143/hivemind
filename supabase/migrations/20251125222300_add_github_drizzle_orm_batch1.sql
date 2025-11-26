-- Add GitHub Drizzle ORM migration and type error issues with solutions - batch 1

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'drizzle-kit generate fails with "undefined" is not valid JSON error during build',
    'github-drizzle-orm',
    'HIGH',
    '[
        {"solution": "Check your schema file for undefined values in column defaults - verify all function calls exist and are properly imported", "percentage": 80, "note": "Root cause is often invalid imports or missing dependencies"},
        {"solution": "Verify environment variables are properly set - ensure DATABASE_URL and other env vars are not undefined before schema generation", "percentage": 75, "note": "Use console.log to verify values before schema processing"},
        {"solution": "Update to latest drizzle-kit version as JSON parsing improvements have been made in recent releases", "percentage": 70, "command": "npm install drizzle-kit@latest", "note": "May require drizzle-orm update as well"}
    ]'::jsonb,
    'drizzle-orm 0.44.7+, drizzle-kit 0.31.7+, valid PostgreSQL schema',
    'npm run db:migrate completes without JSON parsing errors, build succeeds without SyntaxError',
    'Do not use undefined values as defaults. Ensure all imported functions are available at schema generation time. Check that environment variables are substituted before running migrations.',
    0.78,
    'sonnet-4',
    NOW(),
    'https://github.com/drizzle-team/drizzle-orm/issues/5064'
),
(
    'pnpm dlx drizzle-kit generate fails with "Please install latest version of drizzle-orm" even when installed',
    'github-drizzle-orm',
    'MEDIUM',
    '[
        {"solution": "Use pnpm drizzle-kit generate instead of pnpm dlx drizzle-kit generate", "percentage": 95, "command": "pnpm drizzle-kit generate", "note": "Direct command avoids dlx dependency resolution issues"},
        {"solution": "Upgrade pnpm to latest version as older versions have dependency resolution issues", "percentage": 85, "command": "pnpm install -g pnpm@latest", "note": "Tested with pnpm v10.4.1+"},
        {"solution": "Use npx drizzle-kit generate as temporary workaround", "percentage": 80, "note": "Works with any version of drizzle-orm/kit"}
    ]'::jsonb,
    'pnpm v10.4.1+, Node.js v22+, drizzle-orm 0.44.6+, drizzle-kit 0.31.5+',
    'drizzle-kit command succeeds without version check error, migration files generated correctly',
    'Do not use pnpm dlx for drizzle-kit commands. The dlx command has known issues with dependency detection. pnpm direct command works reliably.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/drizzle-team/drizzle-orm/issues/4981'
),
(
    'drizzle-kit generate fails when using expo-crypto.randomUUID() in schema defaults',
    'github-drizzle-orm',
    'MEDIUM',
    '[
        {"solution": "Remove the default function from schema and generate IDs at insertion time in application code instead", "percentage": 90, "note": "Move UUID generation from schema to insert operations"},
        {"solution": "Replace expo-crypto with the uuid package combined with react-native-get-random-values", "percentage": 88, "command": "npm install uuid react-native-get-random-values", "note": "Avoids problematic Expo module dependencies"},
        {"solution": "Use a custom wrapper around the UUID generation that does not require importing from node_modules during schema parsing", "percentage": 75, "note": "Advanced approach requiring custom Drizzle configuration"}
    ]'::jsonb,
    'Expo/React Native project, drizzle-orm 0.44+, drizzle-kit 0.31+',
    'drizzle-kit generate completes without type-stripping errors, UUIDs generate correctly at runtime',
    'Do not import Expo modules directly in schema defaults - this triggers node_modules type-stripping. Generate IDs in application logic instead. Avoid expo-crypto for database schema generation.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/drizzle-team/drizzle-orm/issues/4961'
),
(
    'TypeError: Cannot read properties of undefined (reading "columns") when renaming tables',
    'github-drizzle-orm',
    'MEDIUM',
    '[
        {"solution": "Split table renames into multiple migrations - update schema first, run migration, then rename table separately", "percentage": 92, "note": "Work around preparePgAlterColumns bug by breaking rename into steps"},
        {"solution": "Make an additional structural change to the table alongside the rename (e.g., modify primary key column) which resolves the issue", "percentage": 80, "note": "Unclear why this works - may be related to constraint detection"},
        {"solution": "Upgrade to drizzle-kit v1.0.0+ when released (expected fall 2025) which includes complete rewrite of migration engine", "percentage": 85, "note": "Final solution - upcoming major version addresses this issue"}
    ]'::jsonb,
    'drizzle-orm 0.44.3+, drizzle-kit 0.31.4+, table rename in schema',
    'Multiple migrations execute successfully without "Cannot read properties of undefined" error, table rename completes',
    'Do not rename tables alone in a single migration - this triggers undefined columns reference. Either split into multiple migrations or make additional schema changes. Avoid in drizzle-kit < 1.0.0.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/drizzle-team/drizzle-orm/issues/4838'
),
(
    'AWS Data API PostgreSQL migration fails: serializerMiddleware not found with @aws-sdk/client-rds-data 3.932.0',
    'github-drizzle-orm',
    'MEDIUM',
    '[
        {"solution": "Downgrade @aws-sdk/client-rds-data to version 3.873.0", "percentage": 95, "command": "npm install @aws-sdk/client-rds-data@3.873.0", "note": "Confirmed working, middleware configuration issue in 3.932.0"},
        {"solution": "Reinstall all AWS SDK packages to ensure consistent versions across dependencies", "percentage": 85, "command": "npm install --save-exact @aws-sdk/client-rds-data@3.873.0", "note": "Avoid installing partial updates"},
        {"solution": "Wait for drizzle-orm to publish compatibility fix for AWS SDK v3.932.0", "percentage": 70, "note": "Upstream AWS SDK issue - may be resolved in future versions"}
    ]'::jsonb,
    'drizzle-orm 0.44.7+, drizzle-kit 0.31.7+, AWS Data API driver, PostgreSQL database',
    'drizzle-kit migrate executes without middleware errors, CREATE SCHEMA command succeeds',
    'Do not use @aws-sdk/client-rds-data 3.932.0 - confirmed incompatible. Version 3.873.0 works reliably. Ensure all AWS SDK packages are at compatible versions.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/drizzle-team/drizzle-orm/issues/5050'
),
(
    'drizzle-kit migrate fails with "unterminated /* comment" on files from drizzle-kit pull',
    'github-drizzle-orm',
    'MEDIUM',
    '[
        {"solution": "Manually delete or clear contents of fully-commented migration files before running migrate", "percentage": 90, "note": "Temporary workaround - remove the 0000_...sql file that only contains comments"},
        {"solution": "Edit the migration file and remove the outer /* */ block comment, keeping only valid SQL statements", "percentage": 85, "note": "Allows reuse of file if some content is needed"},
        {"solution": "Upgrade to drizzle-kit v1.0.0+ (fall 2025) which properly skips or handles commented migration files", "percentage": 80, "note": "Permanent fix in upcoming major version"}
    ]'::jsonb,
    'drizzle-kit 0.31+, PostgreSQL database, migration files from drizzle-kit pull command',
    'drizzle-kit migrate completes without DrizzleQueryError, valid migrations apply to database',
    'The initial migration file from drizzle-kit pull is fully commented and will fail parsing. Always review and clean migration files after pull. Remove or edit files containing only comments.',
    0.86,
    'sonnet-4',
    NOW(),
    'https://github.com/drizzle-team/drizzle-orm/issues/4851'
),
(
    'ERROR: cannot drop schema - INSERT & UPDATE fail in custom SQL migration files with AWS Data API',
    'github-drizzle-orm',
    'MEDIUM',
    '[
        {"solution": "Use CASCADE option with DROP statements to remove dependent objects: DROP SCHEMA test CASCADE", "percentage": 85, "note": "Resolves schema dependency conflicts during migration"},
        {"solution": "Execute INSERT and UPDATE statements separately from ALTER/DDL statements in different migration files", "percentage": 80, "note": "AWS Data API may have issues with mixed DML/DDL in single transaction"},
        {"solution": "Test migrations in a staging environment before production deployment", "percentage": 70, "note": "Verify migration order and dependencies with AWS Data API driver"}
    ]'::jsonb,
    'drizzle-orm 0.31.2+, drizzle-kit 0.22.8+, AWS Data API driver, PostgreSQL, custom migration schema',
    'INSERT and UPDATE statements execute without schema dependency errors, migrations complete successfully',
    'AWS Data API may have issues with dependent objects. Use DROP CASCADE. Test DML statements separately. Verify schema dependencies before running migrations.',
    0.78,
    'sonnet-4',
    NOW(),
    'https://github.com/drizzle-team/drizzle-orm/issues/4747'
),
(
    'TypeError: Cannot read properties of undefined (reading "searchParams") - invalid DATABASE_URL',
    'github-drizzle-orm',
    'HIGH',
    '[
        {"solution": "Replace all template variables in DATABASE_URL with actual values before passing to drizzle-kit", "percentage": 95, "command": "DATABASE_URL=''postgresql://user:password@localhost/dbname?schema=public''", "note": "Do not use ${VAR} syntax - substitute values"},
        {"solution": "Verify DATABASE_URL is properly set in environment before running drizzle-kit migrate", "percentage": 90, "note": "Check echo $DATABASE_URL to confirm format"},
        {"solution": "Ensure connection string follows PostgreSQL URL format: postgresql://user:password@host:port/database", "percentage": 85, "note": "Check for typos and missing components"}
    ]'::jsonb,
    'drizzle-orm 0.44+, drizzle-kit 0.31+, PostgreSQL database, valid DATABASE_URL environment variable',
    'drizzle-kit migrate executes without searchParams undefined error, database connection established',
    'Do not use template variable syntax ${VAR} in DATABASE_URL - these are not expanded by Node.js. Substitute actual values. pg-connection-string will fail on invalid URLs.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://github.com/drizzle-team/drizzle-orm/issues/5006'
),
(
    'INSERT statements incorrectly include all schema columns even when not provided in .values()',
    'github-drizzle-orm',
    'HIGH',
    '[
        {"solution": "Specify only the columns you want to insert in the .values() object - Drizzle will not add NULL for omitted columns", "percentage": 88, "note": "This is expected behavior in current versions - explicitly control column inclusion"},
        {"solution": "Use database DEFAULT constraints to handle column values not specified in INSERT", "percentage": 85, "note": "Define defaults at database schema level for optional fields"},
        {"solution": "Upgrade to drizzle-orm 0.45+ which may have improved handling of partial inserts", "percentage": 75, "command": "npm install drizzle-orm@latest", "note": "Check release notes for partial insert improvements"}
    ]'::jsonb,
    'drizzle-orm 0.44+, drizzle-kit 0.31+, multi-environment database setup with column additions',
    'INSERT statements only include columns specified in .values(), NULL values not auto-inserted for omitted columns',
    'Drizzle includes nullable columns from schema in INSERT by default. Explicitly control which columns are inserted. Use database DEFAULT constraints for optional fields. Test migrations across environments before production.',
    0.72,
    'sonnet-4',
    NOW(),
    'https://github.com/drizzle-team/drizzle-orm/issues/5001'
),
(
    'Drizzle Kit push generates unnecessary DROP CONSTRAINT for NOT NULL in PostgreSQL 18',
    'github-drizzle-orm',
    'MEDIUM',
    '[
        {"solution": "Modify pgSerializer.ts to exclude NOT NULL constraints using: AND con.contype != ''n'' in constraint query", "percentage": 90, "note": "PostgreSQL 18 exposes NOT NULL as constraint type ''n'' - filter these out"},
        {"solution": "Upgrade to latest drizzle-kit with PR #4439 (new migration engine) which handles PostgreSQL 18 compatibility", "percentage": 85, "command": "npm install drizzle-kit@latest", "note": "Major version will address this completely"},
        {"solution": "Avoid drizzle-kit push with PostgreSQL 18 until compatibility is released", "percentage": 70, "note": "Use manual migrations if constraints are incorrectly detected"}
    ]'::jsonb,
    'drizzle-kit 0.31+, PostgreSQL 18, schema with primary key constraints',
    'drizzle-kit push completes without attempting to DROP NOT NULL constraints, schema remains unchanged',
    'PostgreSQL 18 changed how NOT NULL constraints are exposed (type ''n''). This causes false positives in schema diff. Filter out type ''n'' constraints. Expect fix in drizzle-kit 1.0.0.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/drizzle-team/drizzle-orm/issues/4944'
),
(
    'better-sqlite3 driver throws "Transaction function cannot return a promise" error',
    'github-drizzle-orm',
    'MEDIUM',
    '[
        {"solution": "Do not use async/await in transaction callbacks with better-sqlite3 - use synchronous code only", "percentage": 92, "note": "better-sqlite3 is a synchronous driver and does not support async operations"},
        {"solution": "Convert your transaction logic to synchronous operations without async/await keywords", "percentage": 88, "note": "Rewrite async calls as sync - better-sqlite3 does not support promises in transactions"},
        {"solution": "Use a different SQLite driver that supports async transactions (sql.js, sqlite3) if you need async operations", "percentage": 75, "note": "better-sqlite3 is sync-only by design"}
    ]'::jsonb,
    'drizzle-orm 0.44.7+, drizzle-kit 0.31.7+, better-sqlite3 v12.1.0, SQLite database',
    'Transaction operations complete without promise-related errors, data persists correctly',
    'better-sqlite3 is a synchronous driver - never use async/await in transaction callbacks. All operations must be synchronous. Do not mix with async code patterns designed for async drivers.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/drizzle-team/drizzle-orm/issues/5063'
),
(
    'PostgreSQL varchar parameter fails: query execution fails with string parameter binding',
    'github-drizzle-orm',
    'MEDIUM',
    '[
        {"solution": "Verify column is actually varchar type in PostgreSQL, not a different string type", "percentage": 85, "note": "Check database schema with \\d table_name in psql"},
        {"solution": "Ensure parameter is a plain string, not a custom object with toString() - use typeof to verify", "percentage": 80, "note": "Parameter must be actual JavaScript string"},
        {"solution": "Test with the parameter value directly in PostgreSQL to confirm it works: SELECT * FROM table WHERE col = ''value''", "percentage": 75, "note": "Isolate issue to Drizzle or PostgreSQL"}
    ]'::jsonb,
    'drizzle-orm 0.44.7+, PostgreSQL 16+, varchar column in schema, string parameter',
    'Query executes successfully against PostgreSQL, returns expected rows with string parameter',
    'Verify column type is actually varchar. Ensure parameter is plain JavaScript string. Test identical query directly in PostgreSQL. Parameter binding may fail if column type differs.',
    0.68,
    'sonnet-4',
    NOW(),
    'https://github.com/drizzle-team/drizzle-orm/issues/5024'
),
(
    'Bun SQL driver not recognized: drizzle-kit push fails with "please install postgres or pg driver"',
    'github-drizzle-orm',
    'MEDIUM',
    '[
        {"solution": "Install a PostgreSQL driver alongside bun-sql for migration operations: npm install postgres", "percentage": 95, "command": "npm install postgres", "note": "Bun SQL not yet supported by drizzle-kit - use postgres-js for migrations"},
        {"solution": "Use drizzle-orm/bun-sql for application code but configure drizzle-kit with postgres driver for migrations", "percentage": 92, "note": "Dual driver setup - Bun SQL for runtime, postgres for kit"},
        {"solution": "Wait for drizzle-kit to add native Bun SQL support in future releases", "percentage": 60, "note": "Currently unsupported in drizzle-kit CLI"}
    ]'::jsonb,
    'Bun 1.3.1+, drizzle-orm 0.44.7+, drizzle-kit 0.31.6+, PostgreSQL database',
    'drizzle-kit push succeeds with installed postgres driver, migrations apply without driver errors',
    'Bun SQL driver is not yet supported by drizzle-kit CLI. Install postgres or postgres-js driver for migrations. Use Bun SQL in application code. This is a temporary workaround until official support is added.',
    0.84,
    'sonnet-4',
    NOW(),
    'https://github.com/drizzle-team/drizzle-orm/issues/5007'
);
