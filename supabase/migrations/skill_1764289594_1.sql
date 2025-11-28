INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'create-skill-file - Guide for creating well-structured SKILL.md files following best practices',
  'claude-code',
  'skill',
  '[{"solution": "Follow SKILL.md structure with YAML frontmatter", "cli": {"macos": "mkdir -p .claude/skills/skill-name && touch .claude/skills/skill-name/SKILL.md", "linux": "mkdir -p .claude/skills/skill-name && touch .claude/skills/skill-name/SKILL.md", "windows": "mkdir .claude\\skills\\skill-name && type nul > .claude\\skills\\skill-name\\SKILL.md"}, "manual": "Create a .claude/skills/{skill-name} directory with SKILL.md file containing YAML frontmatter (name, description) followed by markdown sections: When to Use, How It Works, Examples, References", "note": "Name must be lowercase with hyphens, 64 chars max. Description should include trigger keywords and scenarios"}]'::jsonb,
  'steps',
  'Markdown knowledge, skill trigger patterns, YAML frontmatter understanding',
  'Using generic descriptions without keywords, keeping functions >500 lines without splitting, not specifying trigger scenarios, including Claude-known general knowledge',
  'SKILL.md created in correct directory with valid YAML frontmatter, name matches directory, description includes activation keywords, structure follows recommendations (200-500 lines)',
  'Guidelines for creating high-quality Claude skills with proper naming, structure, documentation, and examples',
  'https://skillsmp.com/skills/labring-fastgpt-claude-skills-create-skill-file-skill-md',
  'admin:HAIKU_SKILL_1764289594_83925'
);
