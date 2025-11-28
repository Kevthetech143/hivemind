INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Python Testing Patterns - Implement comprehensive testing strategies with pytest, fixtures, mocking, and test-driven development',
  'claude-code',
  'skill',
  '[
    {"solution": "Basic pytest Tests", "manual": "Create test files with test_ prefix. Use pytest.raises() for exceptions. Organize tests with AAA pattern (Arrange-Act-Assert)", "note": "Run tests with: pytest test_file.py"},
    {"solution": "Fixtures for Setup and Teardown", "manual": "Use @pytest.fixture decorator for setup/teardown. Fixtures are reusable across tests. Scope: function (default), class, module, session", "note": "Fixtures automatically provide test data and clean up resources"},
    {"solution": "Parameterized Tests", "manual": "Use @pytest.mark.parametrize() to run same test with multiple inputs. Use pytest.param() for custom test IDs. Reduces test duplication", "note": "Each parameter set runs as separate test"},
    {"solution": "Mocking with unittest.mock", "manual": "Use Mock(), patch() for external dependencies. Set return_value for mocked returns. Use side_effect for exceptions. Assert mock calls", "note": "Mock requests, databases, APIs to isolate unit tests"},
    {"solution": "Testing Async Code", "manual": "Use @pytest.mark.asyncio for async tests. Use async fixtures with async def. Use asyncio.gather() for concurrent tests", "note": "Install: pip install pytest-asyncio"},
    {"solution": "Property-Based Testing", "manual": "Use hypothesis library with @given decorator. Test properties that must always hold (e.g., reverse twice = original). Use strategies like st.text(), st.integers()", "note": "Generates 100s of test cases automatically"},
    {"solution": "Test Organization", "manual": "Create tests/ directory with conftest.py for shared fixtures. Organize by: test_unit/, test_integration/, test_e2e/. Use clear test names", "note": "Use pytest.ini or pyproject.toml for configuration"},
    {"solution": "Coverage Reporting", "cli": {"macos": "pip install pytest-cov && pytest --cov=myapp --cov-report=html tests/", "linux": "pip install pytest-cov && pytest --cov=myapp --cov-report=html tests/", "windows": "pip install pytest-cov && pytest --cov=myapp --cov-report=html tests/"}, "note": "Generate HTML reports, set coverage thresholds with --cov-fail-under=80"}
  ]'::jsonb,
  'steps',
  'Python 3.7+, pip, pytest installed',
  'Testing external APIs without mocking (use unittest.mock), overly specific assertions that break with minor changes, not isolating test dependencies, skipping edge case testing, measuring coverage as quality metric',
  'Tests run successfully with pytest, coverage reports generated, fixtures properly setup and teardown, all test markers working, async tests executing correctly',
  'Comprehensive Python testing with pytest, fixtures, mocking, parameterization, and TDD patterns',
  'https://skillsmp.com/skills/wshobson-agents-plugins-python-development-skills-python-testing-patterns-skill-md',
  'admin:HAIKU_SKILL_1764289790_5412'
);
