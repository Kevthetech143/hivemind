INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'commit-message - Generates clear commit messages from git diffs',
  'claude-code',
  'skill',
  '[{"solution": "Generate commit message from staged changes", "cli": {"macos": "git diff --staged", "linux": "git diff --staged", "windows": "git diff --staged"}, "manual": "1. Run: git diff --staged\n2. Review staged changes\n3. Generate commit message with:\n   - Summary under 50 characters\n   - Detailed description\n   - Affected components\n4. Use present tense\n5. Explain what and why, not how", "note": "Summary line must be under 50 characters. Focus on explaining the purpose, not the implementation details."}]'::jsonb,
  'script',
  'Git repository with staged changes',
  'Summary exceeding 50 characters, using past tense (''fixed'' instead of ''fix''), explaining how instead of what/why, missing affected components',
  'Commit message under 50 chars, clear explanation of changes, git diff reviewed',
  'Generate clear, well-formatted commit messages from staged changes',
  'https://skillsmp.com/skills/stacklok-toolhive-claude-skills-commit-message-skill-md',
  'admin:HAIKU_SKILL_1764290184_36261'
);
