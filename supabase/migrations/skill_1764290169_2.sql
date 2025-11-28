INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'bd-issue-tracking - Track complex multi-session work with dependency graphs using beads issue tracker',
  'claude-code',
  'skill',
  '[{"solution": "Install beads CLI", "cli": {"macos": "curl -sSL https://raw.githubusercontent.com/steveyegge/beads/main/install.sh | bash", "linux": "curl -sSL https://raw.githubusercontent.com/steveyegge/beads/main/install.sh | bash", "windows": "curl -sSL https://raw.githubusercontent.com/steveyegge/beads/main/install.sh | bash"}}, {"solution": "Check ready work at session start", "cli": {"macos": "bd ready && bd list --status in_progress", "linux": "bd ready && bd list --status in_progress", "windows": "bd ready && bd list --status in_progress"}}, {"solution": "Create issue for multi-session work", "cli": {"macos": "bd create ''Issue Title'' -p 0 -t feature -d ''Description''", "linux": "bd create ''Issue Title'' -p 0 -t feature -d ''Description''", "windows": "bd create ''Issue Title'' -p 0 -t feature -d ''Description''"}}]'::jsonb,
  'steps',
  'beads CLI installed, project with .beads/ directory or ~/.beads/ available',
  'Using TodoWrite for multi-session work instead of bd, not checking ready work at session start, not updating notes before compaction',
  'bd ready returns available work, in_progress issues show current state, notes survive session compaction',
  'Persistent memory tracker for complex multi-session coding work with dependency graphs',
  'https://skillsmp.com/skills/steveyegge-beads-examples-claude-code-skill-skill-md',
  'admin:HAIKU_SKILL_1764290169_34218'
);
