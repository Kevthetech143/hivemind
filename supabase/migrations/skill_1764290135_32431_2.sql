INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Skill Creator - Guide for creating effective skills with workflows and bundled resources',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Initialize a new skill from template",
      "cli": {
        "macos": "python3 scripts/init_skill.py my-skill --path ./skills",
        "linux": "python3 scripts/init_skill.py my-skill --path ./skills",
        "windows": "python scripts/init_skill.py my-skill --path ./skills"
      },
      "manual": "Run init_skill.py with skill name and output path. Script generates SKILL.md template with proper frontmatter, YAML frontmatter structure, and example resource directories (scripts/, references/, assets/).",
      "note": "Script automatically creates directory structure and TODO placeholders for customization"
    },
    {
      "solution": "Package a completed skill for distribution",
      "cli": {
        "macos": "python3 scripts/package_skill.py path/to/skill-folder",
        "linux": "python3 scripts/package_skill.py path/to/skill-folder",
        "windows": "python scripts/package_skill.py path/to/skill-folder"
      },
      "manual": "Run package_skill.py with skill directory path. Script validates skill structure and YAML frontmatter, then creates distributable zip file named after skill.",
      "note": "Validation checks YAML format, skill naming, description completeness, and resource references before packaging"
    },
    {
      "solution": "Create effective SKILL.md with proper structure",
      "cli": {
        "macos": "cat > SKILL.md << ''TEMPLATE''\n---\nname: skill-name\ndescription: Clear explanation of what skill does and WHEN to use it\n---\n\n# Skill Name\n\n## Overview\n[2 sentences explaining capability]\n\n## [Task/Workflow Section]\n[Implementation details]\nTEMPLATE",
        "linux": "cat > SKILL.md << ''TEMPLATE''\n---\nname: skill-name\ndescription: Clear explanation of what skill does and WHEN to use it\n---\n\n# Skill Name\n\n## Overview\n[2 sentences explaining capability]\n\n## [Task/Workflow Section]\n[Implementation details]\nTEMPLATE",
        "windows": "echo. > SKILL.md"
      },
      "manual": "Write SKILL.md with YAML frontmatter containing required name and description fields. Use imperative form instructions (verb-first). Keep core procedures in SKILL.md, detailed reference material in references/, and assets/templates separate.",
      "note": "Description should specify WHEN skill triggers. Use third-person language like ''This skill should be used when''"
    },
    {
      "solution": "Organize skill resources using three-level system",
      "cli": {
        "macos": "mkdir -p skill-name/{scripts,references,assets} && echo ''skill-name structure created''",
        "linux": "mkdir -p skill-name/{scripts,references,assets} && echo ''skill-name structure created''",
        "windows": "mkdir skill-name\\scripts skill-name\\references skill-name\\assets"
      },
      "manual": "Create three directories: scripts/ for executable code, references/ for documentation and detailed guides, assets/ for templates and non-context files. Include only directories needed for skill functionality.",
      "note": "Progressive disclosure: metadata (always), SKILL.md (when triggered), resources (as needed by Claude)"
    }
  ]'::jsonb,
  'script',
  'Python 3.6+, init_skill.py and package_skill.py scripts available',
  'Skipping step 1 (understanding with examples); writing SKILL.md in second person instead of imperative; including all reference details in SKILL.md rather than separating to references/; not specifying WHEN skill should trigger; forgetting YAML frontmatter validation',
  'Skill initialized with proper directory structure; SKILL.md contains clear YAML frontmatter with name and description; Packaged skill validates without errors; Resources organized in scripts/, references/, assets/; Description clearly specifies when skill triggers',
  'Python skill for creating and packaging reusable Claude skills with workflows, documentation, and bundled resources',
  'https://skillsmp.com/skills/davila7-claude-code-templates-cli-tool-components-skills-development-skill-creator-skill-md',
  'admin:HAIKU_SKILL_1764290135_32431'
);
