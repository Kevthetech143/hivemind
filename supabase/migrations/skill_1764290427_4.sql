INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Create Skill - System for building new Claude Code skills',
  'claude-code',
  'skill',
  '[{"solution": "Create skill directory structure", "cli": {"macos": "mkdir -p ~/.claude/skills/[skill-name]/{workflows,scripts,examples}", "linux": "mkdir -p ~/.claude/skills/[skill-name]/{workflows,scripts,examples}", "windows": "mkdir -p ~/.claude/skills/[skill-name]\\{workflows,scripts,examples}"}, "note": "Standard directory layout: SKILL.md (metadata), workflows/ (markdown files), scripts/ (executables), examples/ (usage samples)"}, {"solution": "Write SKILL.md metadata file", "note": "Include: name, description, trigger phrases, API keys needed, workflow routing, key principles, file organization. YAML frontmatter with name/description required."}, {"solution": "Define workflow files", "note": "Create markdown files in workflows/ directory for each major workflow. Each file should define trigger conditions, step-by-step instructions, and usage examples."}, {"solution": "Register skill in .claude/config", "note": "Add skill entry with trigger word and file path to ~/.claude/config for activation hook recognition."}]'::jsonb,
  'script',
  'Familiarity with skill structure and YAML frontmatter syntax. Understanding of when skills get activated (trigger words, context). Write permissions in ~/.claude/skills directory.',
  'Not including YAML frontmatter in SKILL.md, skipping workflow/ directory structure, not registering skill in .claude/config, creating scripts without examples, not documenting trigger phrases, missing API key setup instructions',
  'Skill directory created with correct structure, SKILL.md includes valid YAML frontmatter, workflows are documented in markdown with clear trigger conditions and steps, skill is registered in config and activates on trigger phrases, examples demonstrate usage',
  'Skill development framework for creating new Claude Code skills with structured workflows and metadata',
  'https://skillsmp.com/skills/danielmiessler-personal-ai-infrastructure-claude-skills-create-skill-skill-md',
  'admin:HAIKU_SKILL_1764290427_67628'
);
