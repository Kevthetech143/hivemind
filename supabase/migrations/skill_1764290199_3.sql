INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Writing Claude Code Skills - Creating new skills following Anthropic best practices',
  'claude-code',
  'skill',
  '[{"solution": "Create new skill with SKILL.md and skill-rules.json entry", "cli": {"macos": "mkdir -p .claude/skills/skill-name && echo ''---'' > .claude/skills/skill-name/SKILL.md", "linux": "mkdir -p .claude/skills/skill-name && echo ''---'' > .claude/skills/skill-name/SKILL.md", "windows": "mkdir .claude\\skills\\skill-name && echo ---^> .claude\\skills\\skill-name\\SKILL.md"}, "manual": "Create skills using UserPromptSubmit hooks and skill-rules.json configuration. Write skill content in SKILL.md with YAML frontmatter (name, description). Add entry to .claude/skills/skill-rules.json with triggers (keywords, intent patterns). Follow 500-line rule for main content. Use progressive disclosure with reference files for details. Include trigger keywords in description. Test with yarn lint:skill and yarn workspace @local/claude-hooks dev:skill. Validate configuration. Keep skills under 500 lines. Use reference files for extended content.", "note": "Anthropic best practices: 500-line rule, progressive disclosure, table of contents in reference files, one-level nesting max, gerund naming (verb + -ing)"}]'::jsonb,
  'steps',
  'Claude Code skill development environment, .claude directory structure, yarn workspace setup',
  'Exceeding 500 lines in main SKILL.md file. Not including all trigger keywords in description. Incorrectly formatted YAML frontmatter. Using block enforcement without PreToolUse hooks. Not testing trigger patterns. Forgetting to update skill-rules.json. Not using progressive disclosure. Nested reference files too deeply.',
  'yarn lint:skill passes. Skill triggers on intended keywords and patterns. No false positives. All tests pass. Reference files organized properly. Description under 1024 characters. Triggers tested with real prompts.',
  'Create Claude Code skills with UserPromptSubmit hooks, skill-rules.json, progressive disclosure, and Anthropic best practices',
  'https://skillsmp.com/skills/hashintel-hash-claude-skills-writing-skills-skill-md',
  'admin:HAIKU_SKILL_1764290199_37706'
);
