INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'fetch-unresolved-comments - Get only unresolved PR review comments from GitHub using GraphQL API',
  'claude-code',
  'skill',
  '[{"solution": "Use GitHub GraphQL API to query reviewThreads filtered by isResolved=false", "cli": {"macos": "GITHUB_TOKEN=$(gh auth token) uv run python .claude/skills/fetch-unresolved-comments/fetch_unresolved_comments.py owner repo pr_number", "linux": "GITHUB_TOKEN=$(gh auth token) uv run python .claude/skills/fetch-unresolved-comments/fetch_unresolved_comments.py owner repo pr_number", "windows": "$env:GITHUB_TOKEN = gh auth token; uv run python .claude\\skills\\fetch-unresolved-comments\\fetch_unresolved_comments.py owner repo pr_number"}, "manual": "1) Get PR info: If PR_NUMBER and GITHUB_REPOSITORY env vars set, use them; otherwise run gh pr view --json url -q ''.url'' to parse current branch PR. 2) Extract owner, repo, and PR number from URL. 3) Run Python script with GitHub token from gh auth token or GITHUB_TOKEN env var. 4) Script returns JSON with total count and comments grouped by file with thread info (id, outdated flag, line numbers, diff hunk, comment body/author/timestamps).", "note": "The script filters out both resolved AND outdated comments. Results are grouped by file path and then by review thread to show conversation context."}]'::jsonb,
  'script',
  'Python 3.8+, GitHub CLI (gh) installed, GitHub API token (from gh auth), uv package manager',
  'Not passing GITHUB_TOKEN env var causing authentication failure, forgetting to parse PR URL to extract owner/repo/number, confusing outdated flag behavior (script filters out outdated comments), not checking if PR has any unresolved comments',
  'JSON output with valid structure containing total comment count and by_file grouping, comments include author/timestamp/body fields, outdated comments excluded from output, file paths correctly extracted from GraphQL response',
  'Fetch and filter unresolved PR review comments using GraphQL with proper grouping by file and thread for review analysis',
  'https://skillsmp.com/skills/mlflow-mlflow-claude-skills-fetch-unresolved-comments-skill-md',
  'admin:HAIKU_SKILL_1764289594_83925'
);
