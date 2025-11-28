INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Skill Creator - Guide for creating effective skills that extend Claude''s capabilities',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Understand skill fundamentals and use cases",
      "manual": "Skills are modular packages that extend Claude with specialized knowledge, workflows, and tool integrations. They provide: (1) Specialized workflows - multi-step procedures for specific domains, (2) Tool integrations - instructions for working with APIs/file formats, (3) Domain expertise - company-specific knowledge/schemas, (4) Bundled resources - scripts, references, assets. Challenge each piece of context: does Claude really need this? Does it justify its token cost? Default assumption: Claude is already very smart.",
      "note": "Core principle: Concise is key. The context window is a public good shared with everything else Claude needs."
    },
    {
      "solution": "Design skill with appropriate degrees of freedom",
      "manual": "Match specificity to task fragility/variability: High freedom (text instructions) when multiple approaches valid, decisions depend on context. Medium freedom (pseudocode, parameters) when preferred pattern exists, some variation acceptable. Low freedom (specific scripts) when operations fragile, consistency critical, specific sequence required. Think of Claude exploring a path: narrow bridge with cliffs needs guardrails (low freedom), open field allows many routes (high freedom).",
      "note": "Balancing freedom ensures skills guide without over-constraining"
    },
    {
      "solution": "Structure skill with SKILL.md and optional bundled resources",
      "manual": "Required: SKILL.md (YAML frontmatter with name/description fields, plus Markdown instructions). Optional: scripts/ (executable Python/Bash), references/ (documentation to load as needed), assets/ (templates, icons, boilerplate used in output). Do NOT include README.md, INSTALLATION_GUIDE.md, CHANGELOG.md - only files directly supporting functionality.",
      "note": "Every skill requires SKILL.md. The frontmatter is the primary triggering mechanism."
    },
    {
      "solution": "Write effective SKILL.md frontmatter",
      "manual": "Frontmatter fields: name (skill name), description (primary triggering mechanism, 2-3 sentences). Description must include: what the skill does AND specific triggers/when to use it. ALL ''when to use'' info must be in description, not body (body only loads after triggering). Example: ''Comprehensive document creation, editing, and analysis with support for tracked changes. Use when Claude needs to work with .docx files for: (1) Creating new documents, (2) Modifying content, (3) Working with tracked changes.''",
      "note": "Description is critical - it determines when the skill gets used"
    },
    {
      "solution": "Organize skill content using progressive disclosure",
      "manual": "Three-level loading: (1) Metadata (name+description) always in context (~100 words), (2) SKILL.md body when skill triggers (<5k words), (3) Bundled resources as needed by Claude. Keep SKILL.md body under 500 lines. Split content into reference files when approaching limit. Link to references from SKILL.md and describe when to read them. Pattern: Keep core workflow in SKILL.md, move variant-specific details into separate reference files. Example: High-level guide with references (FORMS.md, REFERENCE.md, EXAMPLES.md loaded only when needed).",
      "note": "Progressive disclosure manages context efficiently"
    },
    {
      "solution": "Create and test bundled resources (scripts, references, assets)",
      "manual": "Scripts (scripts/): Use for code rewritten repeatedly or needing deterministic reliability. Run actual tests to ensure no bugs. References (references/): Use for documentation Claude references while working (schemas, APIs, policies, workflows). Include table of contents for files >100 lines. Assets (assets/): Use for templates, images, icons, boilerplate code used in output. If skill supports multiple variants/frameworks, organize references by variant (aws.md, gcp.md, azure.md). Delete example files not needed.",
      "note": "Scripts must be tested by running them to ensure correctness"
    },
    {
      "solution": "Follow skill creation process step-by-step",
      "manual": "Step 1: Understand with concrete examples (skip only if clearly understood). Step 2: Plan reusable contents (scripts/references/assets needed). Step 3: Initialize skill with: python scripts/init_skill.py <skill-name> --path <output-directory>. Step 4: Edit skill (implement resources, write SKILL.md). Step 5: Package with: python scripts/package_skill.py <path/to/skill-folder>. Step 6: Iterate based on real usage.",
      "note": "Follow steps in order. Initialization script generates template with TODO placeholders."
    },
    {
      "solution": "Write SKILL.md body with proven patterns",
      "manual": "Use imperative/infinitive form. Start with reusable resources. Consult references/workflows.md for sequential/conditional logic. Consult references/output-patterns.md for format/quality standards. Include information that''s beneficial and non-obvious to Claude. Provide procedural knowledge, domain-specific details, reusable assets. For multi-step processes, use conditional logic. For specific output formats, show template/example patterns. Link to references with clear guidance on when to read them.",
      "note": "Write for another Claude instance - include what would help them execute effectively"
    },
    {
      "solution": "Validate and package skill for distribution",
      "manual": "Run: python scripts/package_skill.py <path/to/skill-folder> [optional output dir]. Script automatically validates: YAML frontmatter format/required fields, naming conventions/directory structure, description completeness/quality, file organization/references. Creates .skill file (zip format) if validation passes. If validation fails, fix errors and rerun. Packaged skill is ready for distribution to users.",
      "note": "Validation happens automatically during packaging"
    }
  ]'::jsonb,
  'script',
  'Python 3.7+, init_skill.py and package_skill.py scripts available. Clear understanding of concrete skill use cases before starting.',
  'Including extraneous files (README.md, CHANGELOG.md). Verbose descriptions that don''t include ''when to use'' triggers. Not testing scripts before including. Loading all reference content in SKILL.md instead of progressive disclosure. Not following step-by-step creation process. Using passive voice in instructions. Not linking to references from SKILL.md.',
  'SKILL.md has proper frontmatter. Package script validates successfully. Description includes specific triggers/when to use. Resources are properly organized (scripts tested, references linked, assets excluded). Body under 500 lines with references for detailed content. Successfully packaged into .skill file.',
  'Create modular skills that extend Claude with specialized knowledge, workflows, and tool integrations',
  'https://skillsmp.com/skills/anthropics-skills-skill-creator-skill-md',
  'admin:HAIKU_SKILL_1764289880_14600'
);
