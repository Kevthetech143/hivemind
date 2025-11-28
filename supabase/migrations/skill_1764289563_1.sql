INSERT INTO knowledge_entries 
(query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Plugin Settings - This skill should be used when the user asks about "plugin settings", "store plugin configuration", ',
  'claude-code',
  'skill',
  '[{"solution": "See SKILL.md documentation in repository", "manual": "---\nname: Plugin Settings\ndescription: This skill should be used when the user asks about \\\"plugin settings\\\", \\\"store plugin configuration\\\", \\\"user-configurable plugin\\\", \\\".local.md files\\\", \\\"plugin state "}]'::jsonb,
  'steps',
  'Claude Code installed, understand repository structure',
  'Not reading SKILL.md documentation, skipping examples directory',
  'Skill implemented and working as documented, tests passing',
  '---
name: Plugin Settings
description: This skill should be used when the user asks about "plugin se',
  'https://skillsmp.com/skills/anthropics-claude-code-plugins-plugin-dev-skills-plugin-settings-skill-md',
  'admin:HAIKU_SKILL_1764289563_82058'
);