INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'pr-inline-review - Submit inline review comments to GitHub Pull Requests',
  'claude-code',
  'skill',
  '[{"solution": "Create and submit PR inline review with optional suggestions", "cli": {"macos": "gh api -X POST repos/{owner}/{repo}/pulls/{pr}/reviews --input /tmp/pr-review-comments.json", "linux": "gh api -X POST repos/{owner}/{repo}/pulls/{pr}/reviews --input /tmp/pr-review-comments.json", "windows": "gh api -X POST repos/{owner}/{repo}/pulls/{pr}/reviews --input /tmp/pr-review-comments.json"}, "manual": "1. Collect findings: file path, line number, comment, optional suggestion\n2. Read current file content to verify line numbers and context\n3. Create JSON at /tmp/pr-review-comments.json with:\n   - body: overall summary\n   - event: COMMENT, APPROVE, or REQUEST_CHANGES\n   - comments: array with path, line, body\n4. For suggestions: include ```suggestion block in comment body\n5. Submit: gh api -X POST repos/{owner}/{repo}/pulls/{pr}/reviews --input /tmp/pr-review-comments.json\n6. Report review URL and summary", "note": "Only use suggestions for simple fixes (typos, paths, constants). Use COMMENT for complex issues requiring discussion. Always verify line numbers first."}]'::jsonb,
  'script',
  'GitHub CLI installed and authenticated, PR exists, write access to repository',
  'Wrong line numbers causing review to fail, suggestions for complex changes, not reading current content before suggesting changes, incorrect JSON format, mixing blocking and non-blocking reviews',
  'Review submitted successfully, comments visible on PR, suggestions applicable if included',
  'Submit inline review comments to GitHub PRs with optional code suggestions',
  'https://skillsmp.com/skills/stacklok-toolhive-claude-skills-pr-inline-review-skill-md',
  'admin:HAIKU_SKILL_1764290184_36261'
);
