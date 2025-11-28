INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Temporal Python Testing - Test workflows with pytest, time-skipping, mocking, and replay testing strategies.',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Unit Testing Workflows",
      "manual": "Use WorkflowEnvironment.start_time_skipping() for fast test execution (month-long workflows run in seconds). Mock activities to isolate workflow logic. Create pytest async fixtures with @pytest.fixture and @pytest.mark.asyncio. Test workflow decision logic with time advancement. Verify state transitions and signal handling."
    },
    {
      "solution": "Activity Testing",
      "manual": "Use ActivityEnvironment for activity-specific testing. Test activities with edge cases (null inputs, empty strings, error conditions). Mock external dependencies (APIs, databases). Test retry behavior with controlled failures. Verify idempotency by calling multiple times with same inputs. Test heartbeat progress reporting."
    },
    {
      "solution": "Integration Testing Patterns",
      "manual": "Mock external services and test workflows with complete activity execution. Create pytest fixtures for shared test setup (temporal_client, workflow_env, test_worker). Test multi-activity workflows with sequential and parallel execution. Verify signal and query handling. Test error injection and failure scenarios. Target ≥80% logic coverage."
    },
    {
      "solution": "Replay Testing & Determinism",
      "manual": "Export production event histories and replay against updated workflow code to validate determinism. Ensures workflow code changes don''t break running executions. Test versioning with workflow.get_version(). Validate compatibility before deployment. Catch non-determinism bugs before production."
    },
    {
      "solution": "Local Development Setup",
      "manual": "Start Temporal server with docker-compose (auto-setup image with PostgreSQL). Configure pytest with asyncio_mode=auto, time-skipping, and coverage tracking. Create shared conftest.py with session/module/function-scoped fixtures. Use pytest markers (@pytest.mark.unit, @pytest.mark.integration) for test categorization. Target ≥80% coverage with coverage reports."
    },
    {
      "solution": "Test Organization & Best Practices",
      "manual": "Structure tests as: tests/unit/ (fast, isolated), tests/integration/ (mocked activities), tests/replay/ (production histories). Use pytest-xdist for parallel execution. Mock all external dependencies (never call real APIs). Clear assertions verifying both results and side effects. Fast execution with time-skipping avoids real delays. Document expected behavior and edge cases."
    }
  ]'::jsonb,
  'script',
  'Python 3.10+, pytest familiarity, understanding of async/await, Temporal workflow concepts, Docker (for local server)',
  'Not mocking external dependencies (calling real APIs); forgetting time-skipping reduces test speed; inadequate coverage of error paths; missing activity idempotency tests; not testing retry logic; insufficient signal/query testing; skipping determinism validation; using datetime.now() in workflow tests (should use mocked time)',
  'All tests pass in < 2 seconds (time-skipping); ≥80% coverage achieved; activities tested for idempotency; error paths verified; replay tests validate determinism; CI/CD pipeline runs full suite in < 5 minutes; coverage reports show gaps; Docker Compose starts Temporal instantly',
  'Test Temporal Python workflows efficiently using time-skipping, mocking, pytest async fixtures, and replay validation.',
  'https://skillsmp.com/skills/wshobson-agents-plugins-backend-development-skills-temporal-python-testing-skill-md',
  'admin:HAIKU_SKILL_1764289820_8406'
);
