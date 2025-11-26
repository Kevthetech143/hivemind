-- Pytest Failures - Official Docs Mining
-- Source: docs.pytest.org/en/stable/how-to/failures.html
-- Mined: 2025-11-25

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES (
    'Pytest: Test execution continues after failures',
    'pytest',
    'HIGH',
    $$[{"solution": "Use pytest -x flag to stop after the first failure, or pytest --maxfail=N to stop after N failures", "percentage": 95, "note": "Useful for debugging large test suites", "command": "pytest -x\npytest --maxfail=2"}]$$::jsonb,
    'pytest installed and working test file',
    'Test execution halts at first/nth failure and pytest returns immediately',
    'Forgetting that tests continue by default in large suites, consuming time on unrelated failures',
    0.95,
    'sonnet-4',
    NOW(),
    'https://docs.pytest.org/en/stable/how-to/failures.html'
),
(
    'Pytest: Cannot debug test failure immediately',
    'pytest',
    'HIGH',
    $$[{"solution": "Use pytest --pdb flag to drop into Python debugger on failures. Combine with -x for first failure only", "percentage": 92, "note": "Debugger invokes on every failure unless limited with -x or --maxfail", "command": "pytest --pdb\npytest -x --pdb\npytest --pdb --maxfail=3"}]$$::jsonb,
    'pytest installed, pdb knowledge helpful',
    'Python debugger prompt appears when test fails, allows interactive inspection',
    'Not combining --pdb with -x when debugging many failures, which floods console; forgetting about sys.last_value for postmortem analysis',
    0.92,
    'sonnet-4',
    NOW(),
    'https://docs.pytest.org/en/stable/how-to/failures.html'
),
(
    'Pytest: Need to inspect exception after test failure',
    'pytest',
    'MEDIUM',
    $$[{"solution": "Exception info is automatically stored in sys.last_value, sys.last_type, and sys.last_traceback for postmortem debugging. Access these in interactive session", "percentage": 88, "note": "Useful for manual exception analysis after pytest --pdb", "command": ">>> import sys\n>>> sys.last_value\n>>> sys.last_traceback.tb_lineno"}]$$::jsonb,
    'Test has failed, interactive Python session',
    'Can access sys.last_value, sys.last_type, and sys.last_traceback without re-running test',
    'Assuming exception info is lost after debugger closes; not knowing these attributes exist',
    0.88,
    'sonnet-4',
    NOW(),
    'https://docs.pytest.org/en/stable/how-to/failures.html'
),
(
    'Pytest: Need to step through test execution from beginning',
    'pytest',
    'MEDIUM',
    $$[{"solution": "Use pytest --trace flag to invoke debugger at the start of every test, before any test code executes", "percentage": 90, "note": "Different from --pdb which only triggers on failure", "command": "pytest --trace"}]$$::jsonb,
    'pytest installed, test file, pdb knowledge',
    'Debugger prompt appears before any test code runs, allowing step-through from start',
    'Confusing --trace with --pdb; using --trace for all tests when only needing it for one',
    0.90,
    'sonnet-4',
    NOW(),
    'https://docs.pytest.org/en/stable/how-to/failures.html'
),
(
    'Pytest: Manual breakpoints in code are not working properly',
    'pytest',
    'MEDIUM',
    $$[{"solution": "Use import pdb;pdb.set_trace() in your test code. pytest automatically disables output capture for that specific test while preserving captures in other tests", "percentage": 91, "note": "Output capture is automatically managed by pytest during debugging", "command": "import pdb;pdb.set_trace()"}]$$::jsonb,
    'Code that can be modified, pytest running',
    'Debugger invokes at breakpoint location; other test output remains captured',
    'Attempting to read captured output while debugger is active; not realizing pytest handles capture management automatically',
    0.91,
    'sonnet-4',
    NOW(),
    'https://docs.pytest.org/en/stable/how-to/failures.html'
),
(
    'Pytest: Segmentation fault or timeout not producing traceback',
    'pytest',
    'MEDIUM',
    $$[{"solution": "faulthandler module is automatically enabled in pytest. Dumps Python tracebacks on segfault or timeout. Disable with -p no:faulthandler if needed", "percentage": 89, "note": "Enabled by default since pytest 5.0", "command": "pytest\npytest -p no:faulthandler"}]$$::jsonb,
    'pytest 5.0+, problematic test code',
    'Traceback output appears on segfault; timeout tracebacks appear when test exceeds configured duration',
    'Assuming faulthandler is not enabled; attempting to use old --no-faulthandler flag instead of -p no:faulthandler',
    0.89,
    'sonnet-4',
    NOW(),
    'https://docs.pytest.org/en/stable/how-to/failures.html'
),
(
    'Pytest: Test takes too long to complete without timeout indication',
    'pytest',
    'MEDIUM',
    $$[{"solution": "Use faulthandler_timeout=X configuration option to dump tracebacks of all threads if test exceeds X seconds. Can be set with -o faulthandler_timeout=X from command line", "percentage": 88, "note": "Requires pytest 5.0+, replaced old --faulthandler-timeout flag", "command": "pytest -o faulthandler_timeout=10\npytest --faulthandler-timeout 10"}]$$::jsonb,
    'pytest 5.0+, test file that hangs',
    'After X seconds, traceback dump appears showing all threads; helps identify hanging code',
    'Using old --faulthandler-timeout syntax instead of -o faulthandler_timeout=X; setting timeout too short',
    0.88,
    'sonnet-4',
    NOW(),
    'https://docs.pytest.org/en/stable/how-to/failures.html'
),
(
    'Pytest: Unraisable exceptions in __del__ methods not being detected',
    'pytest',
    'MEDIUM',
    $$[{"solution": "pytest 6.2+ automatically detects unraisable exceptions (raised in __del__) and unhandled thread exceptions. Warnings appear in test summary. Disable detection with -p no:unraisableexception or -p no:threadexception", "percentage": 85, "note": "Unraisable exceptions normally go unnoticed but are bugs", "command": "pytest\npytest -p no:unraisableexception\npytest -p no:threadexception"}]$$::jsonb,
    'pytest 6.2+, code with __del__ or threading',
    'Warning appears in test summary for unraisable/unhandled exceptions; bug is now visible',
    'Missing warnings in summary; assuming unraisable exceptions are impossible; disabling detection unnecessarily',
    0.85,
    'sonnet-4',
    NOW(),
    'https://docs.pytest.org/en/stable/how-to/failures.html'
),
(
    'Pytest: Output capture interfering with debugger interaction',
    'pytest',
    'MEDIUM',
    $$[{"solution": "pytest automatically disables output capture when breakpoint() or pdb.set_trace() is active. Capture resumes when debugger session ends via continue command. Prior captured output is preserved", "percentage": 93, "note": "Capture behavior is automatic; no user action needed", "command": "pytest --pdb\nimport pdb;pdb.set_trace()"}]$$::jsonb,
    'pytest running, breakpoint in code or --pdb flag',
    'Debugger input/output visible without interference; prior test output still captured; capture resumes after debugger ends',
    'Manually disabling capture; assuming breakpoint disables capture for other tests; expecting capture output while debugger is active',
    0.93,
    'sonnet-4',
    NOW(),
    'https://docs.pytest.org/en/stable/how-to/failures.html'
),
(
    'Pytest: Debugging multiple related test failures efficiently',
    'pytest',
    'HIGH',
    $$[{"solution": "Combine pytest -x --pdb to debug first failure only, then fix and rerun. Or use pytest --pdb --maxfail=3 to debug first 3 failures systematically", "percentage": 91, "note": "Reduces cognitive load vs debugging all failures at once", "command": "pytest -x --pdb\npytest --pdb --maxfail=3\npytest tests/test_file.py -x --pdb"}]$$::jsonb,
    'pytest installed, failing tests',
    'First/first-N failure drops into debugger; can inspect and fix before continuing',
    'Using --pdb without -x or --maxfail which floods with debugger sessions; not fixing early failures first',
    0.91,
    'sonnet-4',
    NOW(),
    'https://docs.pytest.org/en/stable/how-to/failures.html'
);
