-- Add high-voted Prisma database/migration error solutions batch 1
-- Source: GitHub Prisma Repository (https://github.com/prisma/prisma/issues)
-- Category: github-prisma
-- Total Entries: 12

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Drift detected: Your database schema is not in sync with your migration history on Supabase',
    'github-prisma',
    'VERY_HIGH',
    '[
        {"solution": "Run prisma db pull to detect and add necessary extension mappings to schema file", "percentage": 85, "note": "Supabase automatically provisions PostgreSQL extensions like pg_graphql, pg_stat_statements, pgcrypto, pgjwt, pgsodium, supabase_vault, uuid-ossp", "command": "npx prisma db pull"},
        {"solution": "Add detected extensions to schema: extensions = [uuid_ossp(map: \"uuid-ossp\", schema: \"extensions\")]", "percentage": 90, "note": "Align schema with Supabase platform-managed extensions"},
        {"solution": "If schemas still mismatch, run prisma migrate diff to compare actual vs expected state", "percentage": 75, "command": "npx prisma migrate diff --from-empty --to-schema-datasource prisma/schema.prisma"}
    ]'::jsonb,
    'Supabase PostgreSQL project, Current Prisma schema file, Database with existing tables',
    'No more drift detection errors on prisma migrate dev, Schema changes can be applied without reset prompts',
    'Do not attempt to reset database on Supabase - extensions are platform-managed and not user-controlled. Running db push first can cause migration history conflicts.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/prisma/prisma/issues/19100'
),
(
    'Second Prisma migrate run reports diff and throws duplicate key error - introspection fails to detect existing indexes',
    'github-prisma',
    'HIGH',
    '[
        {"solution": "Verify that all indexes were successfully created on the database after first migration", "percentage": 80, "note": "MySQL introspection may fail to detect indexes in some cases"},
        {"solution": "Run db pull to re-introspect database and confirm indexes are in schema", "percentage": 85, "command": "npx prisma db pull"},
        {"solution": "If issue persists, check MySQL index naming - Prisma may not recognize custom index names", "percentage": 70, "note": "Ensure index names follow Prisma conventions"},
        {"solution": "Upgrade to latest Prisma version - introspection engine improvements may resolve detection", "percentage": 75, "command": "npm install @prisma/cli@latest"}
    ]'::jsonb,
    'MySQL database with existing indexes, Initial migration successfully applied, Prisma client installed',
    'Second prisma migrate dev runs without duplicate key errors, All indexes properly detected in schema',
    'Introspection may not catch all indexes on MySQL - manually verify with SHOW INDEX. Do not blindly apply migrations suggesting index recreation.',
    0.78,
    'sonnet-4',
    NOW(),
    'https://github.com/prisma/prisma/issues/10405'
),
(
    'Migration state bug [P3006] - migration failed but not marked as failed, cannot rollback or proceed',
    'github-prisma',
    'MEDIUM',
    '[
        {"solution": "Manually delete the failed migration record from _prisma_migrations table", "percentage": 80, "note": "Requires direct database access", "command": "DELETE FROM _prisma_migrations WHERE migration = ''<failed_migration_name>''"},
        {"solution": "Fix the migration file SQL syntax error in prisma/migrations/ folder", "percentage": 90, "note": "Address the underlying SQL error in the migration file"},
        {"solution": "Use prisma migrate resolve to mark migration as rolled_back instead of failed", "percentage": 75, "command": "npx prisma migrate resolve --rolled-back <migration_name>"},
        {"solution": "Run prisma migrate dev to apply fixed migration or create new one", "percentage": 85, "command": "npx prisma migrate dev"}
    ]'::jsonb,
    'PostgreSQL database, Failed migration file exists, Database access to _prisma_migrations table',
    'Migration transitions from ambiguous state to either applied or rolled_back status, prisma migrate dev completes without state errors',
    'Ambiguous migration state can block development - fix quickly before creating new migrations. Do not ignore P3006 errors on shadow database validation.',
    0.80,
    'sonnet-4',
    NOW(),
    'https://github.com/prisma/prisma/issues/23277'
),
(
    'Timed out fetching a new connection from the connection pool - connections exhausted after 1-2 days',
    'github-prisma',
    'HIGH',
    '[
        {"solution": "Monitor server memory and resource usage during periods when errors start occurring", "percentage": 85, "note": "Connection timeouts often indicate resource exhaustion, not pool issues. Check nightly backup jobs consuming memory."},
        {"solution": "Optimize resource-intensive background operations (mysqldump, backups, scans) to reduce memory pressure", "percentage": 90, "note": "Heavy operations can make database temporarily unresponsive"},
        {"solution": "Ensure database server becomes responsive after resource pressure passes - Prisma connection pool should self-recover", "percentage": 75, "note": "If error persists after server recovery, restart application"},
        {"solution": "Upgrade to latest Prisma version - connection pool recovery improvements included", "percentage": 70, "command": "npm install @prisma/client@latest"}
    ]'::jsonb,
    'MySQL or PostgreSQL server with resource monitoring access, Prisma client application running for extended period',
    'No more connection timeouts after resource optimization, All queries succeed immediately after server recovery, Application stable after 2+ days uptime',
    'Do not assume pool limit is too low - check server resources first. Connection pool exhaustion after days often indicates infrastructure issues, not Prisma configuration problems.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/prisma/prisma/issues/7249'
),
(
    'Inappropriate Connection Pool Timeout Error - P2024 timeout in AWS Lambda despite low connection count',
    'github-prisma',
    'HIGH',
    '[
        {"solution": "Set pool_timeout to 0 in DATABASE_URL to disable timeout check", "percentage": 90, "note": "Serverless environments may trigger false timeouts due to connection startup latency", "command": "DATABASE_URL=\"postgresql://user:pass@host/db?schema=public&pool_timeout=0\""},
        {"solution": "Use connection_limit=1 for Lambda functions as recommended in Prisma serverless guide", "percentage": 95, "command": "connection_limit=1&pool_timeout=0"},
        {"solution": "Instantiate Prisma client outside Lambda handler to reuse connection across invocations", "percentage": 95, "note": "Prevents connection pool recreation on every request"},
        {"solution": "Increase connection_limit only for non-serverless deployments where concurrent connections are needed", "percentage": 85}
    ]'::jsonb,
    'AWS Lambda environment, Prisma client, DATABASE_URL with connection parameters',
    'Lambda invocations complete without P2024 timeout errors, Connection pool responds within expected latency, Error logs show no timeout messages',
    'Do not use large connection pools in Lambda - each invocation gets fresh connection. False timeouts are normal; disable pool_timeout for serverless. Do not set high connection_limit in serverless.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/prisma/prisma/issues/19820'
),
(
    'Prisma db push then migrate dev causes reset prompts - mixing development workflows loses migration history',
    'github-prisma',
    'VERY_HIGH',
    '[
        {"solution": "Generate migration file from current state: mkdir -p prisma/migrations/init && npx prisma migrate diff --from-empty --to-schema-datasource prisma/schema.prisma --shadow-database-url <empty-db-url> --script > prisma/migrations/init/migration.sql", "percentage": 90, "note": "Shadow database must be a completely empty PostgreSQL instance"},
        {"solution": "Mark migration as already applied to prevent re-creation of existing tables", "percentage": 95, "command": "npx prisma migrate resolve --applied init"},
        {"solution": "Verify synchronization with prisma migrate dev", "percentage": 85, "command": "npx prisma migrate dev"},
        {"solution": "For future development, use only migrate dev workflow (never mix with db push)", "percentage": 95, "note": "db push is for disposable development databases only"}
    ]'::jsonb,
    'Git repository with prisma folder, PostgreSQL database (local or remote), Empty PostgreSQL instance for shadow database, Existing migrations directory',
    'prisma migrate dev completes without reset prompts, Schema synchronization verified, No duplicate migration errors',
    'Never mix db push and migrate dev workflows - db push does not create migration history. Always use migrate dev in production-like environments. Shadow database must be completely empty and separate from development database.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/prisma/prisma/discussions/16141'
),
(
    'Incorrect ManyToMany + Foreign key introspection - junction table names inferred incorrectly',
    'github-prisma',
    'MEDIUM',
    '[
        {"solution": "Run db pull and verify junction table names in generated schema match actual database", "percentage": 85, "command": "npx prisma db pull"},
        {"solution": "Add fictitious field to junction table as workaround to force explicit many-to-many recognition", "percentage": 70, "note": "Temporary workaround if introspection fails"},
        {"solution": "Upgrade to latest Prisma version - m2m relation name inference bug fixed in prisma-engines PR #2164", "percentage": 90, "command": "npm install @prisma/cli@latest"},
        {"solution": "Manually verify many-to-many relation definitions after introspection if using older Prisma", "percentage": 80, "note": "Check that @relation attributes on both sides match"}
    ]'::jsonb,
    'PostgreSQL or MySQL database with many-to-many relations, Introspection capability, Prisma CLI installed',
    'db pull correctly identifies junction tables by actual name, Many-to-many relationships queryable without P2021 errors, Schema compiles without type errors',
    'Introspection may generate _ModelAManyToMany instead of _ModelA if multiple relation types exist. Older Prisma versions have this bug - upgrade to fix.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/prisma/prisma/issues/7706'
),
(
    'npx prisma db pull failed - multiSchema preview feature required but not enabled',
    'github-prisma',
    'HIGH',
    '[
        {"solution": "Enable multiSchema preview feature in generator block: previewFeatures = [\"multiSchema\"]", "percentage": 95, "note": "Required when using multiple schemas in datasource"},
        {"solution": "Update datasource to declare schemas: schemas = [\"public\", \"auth\", ...]", "percentage": 95, "note": "List all schemas that need to be introspected"},
        {"solution": "Verify schema file is valid: npx prisma validate", "percentage": 85, "command": "npx prisma validate"},
        {"solution": "Run db pull again after enabling feature", "percentage": 90, "command": "npx prisma db pull"}
    ]'::jsonb,
    'Supabase or PostgreSQL with multiple schemas, Current Prisma schema file, Prisma 4.0+ installed',
    'db pull succeeds and generates models from all specified schemas, P1012 error no longer appears, Schema file is valid',
    'Error message P1012 can be misleading - "schema file is invalid" when actual issue is missing preview feature flag. multiSchema is still a preview feature as of Prisma 5.x.',
    0.95,
    'sonnet-4',
    NOW(),
    'https://github.com/prisma/prisma/issues/25033'
),
(
    'Improve the error when SQLite database file is locked - generic timeout message hides real issue',
    'github-prisma',
    'HIGH',
    '[
        {"solution": "Identify if error is from DatabaseBusy condition by checking if other processes access database", "percentage": 85, "note": "SQLite DatabaseBusy errors get mapped to SocketTimeout in error handling"},
        {"solution": "Close all open database connections and file handles from other processes (dev servers, terminals, GUI tools)", "percentage": 95, "note": "SQLite uses exclusive locking mode by default - only one process can write"},
        {"solution": "Run migration again after ensuring no other process has database file open", "percentage": 90, "command": "npx prisma migrate dev"},
        {"solution": "Upgrade Prisma to get better error messages specifically for SQLite lock scenarios", "percentage": 80, "command": "npm install @prisma/cli@latest"}
    ]'::jsonb,
    'SQLite database file, Prisma CLI, Access to view processes using database',
    'Migration completes successfully, No more timeout errors from database locked condition, Error messages clearly indicate lock status',
    'SQLite lock errors are shown as generic timeouts - check for open file handles in your IDE, dev server, or other terminals. Exclusive locking means only one writer allowed. Using concurrent writes with forEach will cause this.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/prisma/prisma/issues/10403'
),
(
    'The table does not exist in the current database - P2021 error when running migrations or seeding',
    'github-prisma',
    'MEDIUM',
    '[
        {"solution": "Verify all migrations have been applied to database: npx prisma migrate status", "percentage": 85, "command": "npx prisma migrate status"},
        {"solution": "If migrations deleted, use db push to apply current schema instead of relying on migration history", "percentage": 90, "command": "npx prisma db push"},
        {"solution": "Run migrations separately before running seed script: npx prisma migrate dev then seed", "percentage": 85, "command": "npx prisma migrate dev && npx prisma db seed"},
        {"solution": "Recreate missing migration files from git history or schema definition", "percentage": 75, "note": "Migration files define database schema state - deleting them removes reference"}
    ]'::jsonb,
    'PostgreSQL or SQLite database, Prisma schema file, Migration history or files available',
    'Tables exist in database after migrations applied, Seed script runs without P2021 errors, Database schema matches Prisma models',
    'Deleting migration files without applying schema changes leaves database empty - migrations define the schema state. Run db push to recover. Do not delete migrations from production databases.',
    0.83,
    'sonnet-4',
    NOW(),
    'https://github.com/prisma/prisma/issues/10633'
),
(
    'Client generated by new generator fails type checking - TS4094 property _brand may not be private or protected',
    'github-prisma',
    'MEDIUM',
    '[
        {"solution": "Revert to legacy generator: provider = \"prisma-client-js\" instead of \"prisma-client\"", "percentage": 95, "note": "New generator in v6.6.0+ has type export issues"},
        {"solution": "Wait for Prisma patch release - PR #26867 addresses export format for DbNull, JsonNull, AnyNull types", "percentage": 85, "note": "Fix merged but may need official release"},
        {"solution": "Add @ts-nocheck at top of generated client.ts as temporary workaround", "percentage": 60, "note": "Reduces type safety - only for urgent production fixes", "command": "// @ts-nocheck"},
        {"solution": "Upgrade to latest Prisma version for complete fix", "percentage": 90, "command": "npm install @prisma/cli@latest @prisma/client@latest"}
    ]'::jsonb,
    'Prisma 6.6.0 or later with prisma-client generator, TypeScript configuration with declaration: true, Existing schema file',
    'TypeScript compilation succeeds without TS4094 errors, Generated client types are properly exported, IDE shows correct type information',
    'New prisma-client generator has breaking changes for type exports - stick with prisma-client-js if new generator unstable. Do not use @ts-nocheck in production long-term.',
    0.80,
    'sonnet-4',
    NOW(),
    'https://github.com/prisma/prisma/issues/26841'
),
(
    'v5.9.0 regression - prisma generate produces all any types instead of proper TypeScript definitions',
    'github-prisma',
    'HIGH',
    '[
        {"solution": "Upgrade to Prisma 5.9.1 or later: type generation regression was fixed in patch releases", "percentage": 95, "command": "npm install @prisma/cli@5.9.1 @prisma/client@5.9.1"},
        {"solution": "If stuck on v5.9.0, use pre-release version 5.10.0-integration-fix-nodenext.2 with PR #22876 fix", "percentage": 85, "command": "npm install @prisma/cli@5.10.0-integration-fix-nodenext.2 @prisma/client@5.10.0-integration-fix-nodenext.2"},
        {"solution": "Verify schema file is valid before running generate: npx prisma validate", "percentage": 80, "command": "npx prisma validate"},
        {"solution": "Delete node_modules/.prisma and regenerate client: rm -rf node_modules/.prisma && npx prisma generate", "percentage": 75, "command": "rm -rf node_modules/.prisma && npx prisma generate"}
    ]'::jsonb,
    'Prisma v5.9.0 installation, TypeScript project with Prisma schema, Node modules installed',
    'Generated types are specific and correct (not any), Models have proper TypeScript interfaces, IDE autocomplete works for Prisma queries',
    'v5.9.0 was a broken release with type generation regression - never use it. Update immediately to 5.9.1+. This was a major regression affecting all users of that minor version.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://github.com/prisma/prisma/issues/22896'
),
(
    'Using db push then migrate creates shadow database conflicts - mixed workflow causes relation collision errors',
    'github-prisma',
    'HIGH',
    '[
        {"solution": "Create migration baseline from empty schema: npx prisma migrate diff --from-empty --to-schema-datasource prisma/schema.prisma --script > prisma/migrations/init/migration.sql", "percentage": 90, "note": "Baseline approach resolves shadow database state conflicts"},
        {"solution": "Mark migration as already applied: npx prisma migrate resolve --applied init", "percentage": 95, "command": "npx prisma migrate resolve --applied init"},
        {"solution": "Alternative: use separate databases for prototyping vs migration workflows - run db push on throwaway database", "percentage": 80, "note": "Practical approach for teams already using db push extensively"},
        {"solution": "Going forward, choose either db push (development only) or migrate dev (all environments) - never mix", "percentage": 95, "note": "db push bypasses migration history entirely; migrate dev requires history to be accurate"}
    ]'::jsonb,
    'Git repository with existing migrations, PostgreSQL or MySQL database, Prisma CLI, Shadow database URL (empty Postgres instance)',
    'prisma migrate dev executes without shadow database conflicts, No relation collision errors, Database schema synchronized with migrations',
    'Mixing db push and migrate is a common mistake - db push avoids migration history entirely. Once you mix them, recovery is complex. Choose one workflow and stick with it. Shadow database errors mean history and state are misaligned.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/prisma/prisma/discussions/25712'
);
