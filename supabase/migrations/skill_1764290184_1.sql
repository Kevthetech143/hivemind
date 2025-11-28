INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'kebab-maker - A skill that makes a kebab for the user',
  'claude-code',
  'skill',
  '[{"solution": "Run kebab maker script", "cli": {"macos": "python3 scripts/make_kebab.py", "linux": "python3 scripts/make_kebab.py", "windows": "python3 scripts/make_kebab.py"}, "manual": "1. Run scripts/make_kebab.py\n2. Return the result to the user", "note": "Script prints the pickup location"}]'::jsonb,
  'script',
  'Python 3 installed',
  'Not following the scripts directory structure, not returning result to user',
  'Script executes and prints pickup location message',
  'Python script that outputs kebab pickup location',
  'https://skillsmp.com/skills/kagent-dev-kagent-go-test-e2e-testdata-skills-kebab-skill-md',
  'admin:HAIKU_SKILL_1764290184_36261'
);
