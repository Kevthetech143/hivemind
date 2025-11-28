INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'pr-review-reply - Reply to and resolve GitHub PR review comments interactively',
  'claude-code',
  'skill',
  '[{"solution": "Gather and respond to PR review comments", "cli": {"macos": "gh api repos/{owner}/{repo}/pulls/{pr}/comments | jq", "linux": "gh api repos/{owner}/{repo}/pulls/{pr}/comments | jq", "windows": "gh api repos/{owner}/{repo}/pulls/{pr}/comments | jq"}, "manual": "1. Fetch review comments: gh api repos/{owner}/{repo}/pulls/{pr}/comments\n2. Parse with jq to show: id, path, line, author, body, replies\n3. Group by status (unresolved/resolved) and type (suggestion/question/nitpick)\n4. Recommend action for each: fix+reply+resolve OR answer+wait OR acknowledge+defer\n5. Draft reply messages for user approval\n6. Submit replies after user confirms: gh api -X POST repos/{owner}/{repo}/pulls/{pr}/comments/{id}/replies\n7. Resolve threads when appropriate using GraphQL mutation\n8. Track progress and report results", "note": "Always get user approval before replying or resolving. Don''t auto-resolve without confirmation."}]'::jsonb,
  'script',
  'GitHub CLI installed and authenticated, PR exists and is open, write access to repository',
  'Auto-resolving without user approval, resolving before reviewer acknowledges, not grouping comments logically, submitting replies without drafting first, mixing fixed vs question comments',
  'All comments processed per user decisions, replies sent with user confirmation, threads resolved appropriately',
  'Interactive workflow for reviewing and responding to GitHub PR comments',
  'https://skillsmp.com/skills/stacklok-toolhive-claude-skills-pr-review-reply-skill-md',
  'admin:HAIKU_SKILL_1764290184_36261'
);
