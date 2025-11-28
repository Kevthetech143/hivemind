-- Git Commit Helper Skill
INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Git Commit Helper - Generate descriptive commit messages using conventional commits format',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Review staged changes before commit",
      "cli": {
        "macos": "git diff --staged",
        "linux": "git diff --staged",
        "windows": "git diff --staged"
      },
      "note": "Use git status for file list, git diff --staged --stat for summary, git diff --staged path/to/file for specific file"
    },
    {
      "solution": "Follow conventional commits format",
      "manual": "Use format: <type>(<scope>): <description>. Types: feat (new feature), fix (bug fix), docs (documentation), style (formatting), refactor (code restructure), test (tests), chore (maintenance). Keep summary under 50 chars, use imperative mood (''add'' not ''added''), capitalize first letter, no period at end.",
      "note": "Explain WHY in body, not just WHAT. Reference issue numbers if applicable. Atomic commits = one logical change per commit."
    },
    {
      "solution": "Mark breaking changes clearly",
      "manual": "Add ! after type/scope for breaking changes: feat(api)!: restructure response. Include BREAKING CHANGE footer with migration details and explanation of what changed and how to update client code.",
      "note": "Breaking changes require clear migration guidance and show impact to users"
    },
    {
      "solution": "Stage changes interactively for atomic commits",
      "cli": {
        "macos": "git add -p",
        "linux": "git add -p",
        "windows": "git add -p"
      },
      "note": "Choose which hunks to stage, review with git diff --staged before committing, enables focused commits"
    },
    {
      "solution": "Amend last commit message",
      "cli": {
        "macos": "git commit --amend",
        "linux": "git commit --amend",
        "windows": "git commit --amend"
      },
      "note": "Use --amend --no-edit to add forgotten files without changing message. Only amend before push."
    }
  ]'::jsonb,
  'steps',
  'Git configured; staged changes in repo; understanding of codebase area being modified',
  'Using vague messages like ''update'' or ''fix stuff''; writing in past tense instead of imperative; mixing unrelated changes in single commit; forgetting to test before commit; not explaining the WHY in commit body; including implementation details in summary line',
  'Commit messages follow conventional format, summary under 50 chars, type/scope accurate, body explains motivation, breaking changes clearly marked, all staged changes logical and related',
  'Generate conventional commit messages by analyzing git diffs and providing consistent message format',
  'https://skillsmp.com/skills/davila7-claude-code-templates-cli-tool-components-skills-development-git-commit-helper-skill-md',
  'admin:HAIKU_SKILL_1764290120_31772'
);
