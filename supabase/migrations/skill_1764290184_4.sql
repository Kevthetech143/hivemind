INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'testing - Run and troubleshoot tests for DBHub with Testcontainers',
  'claude-code',
  'skill',
  '[{"solution": "Run test commands", "cli": {"macos": "pnpm test", "linux": "pnpm test", "windows": "pnpm test"}, "manual": "1. Basic tests: pnpm test or pnpm test:watch\n2. Integration tests: pnpm test:integration (requires Docker)\n3. Database-specific: pnpm test src/connectors/__tests__/{postgres|mysql|mariadb|sqlserver|sqlite}.integration.test.ts\n4. Verify Docker: docker ps\n5. Check Docker memory: 4GB+ recommended\n6. Debug: pnpm test:integration --reporter=verbose", "note": "SQL Server containers require 3-5 minutes to start. Ensure Docker has sufficient memory allocated."}]'::jsonb,
  'script',
  'Docker running, 4GB+ Docker memory, pnpm installed, Docker images available',
  'Not verifying Docker is running, insufficient Docker memory for SQL Server, not checking network access to pull images, ignoring container startup warnings',
  'All tests pass, containers start successfully, database connections established',
  'Run and troubleshoot DBHub tests with integration testing via Testcontainers',
  'https://skillsmp.com/skills/bytebase-dbhub-claude-skills-testing-skill-md',
  'admin:HAIKU_SKILL_1764290184_36261'
);
