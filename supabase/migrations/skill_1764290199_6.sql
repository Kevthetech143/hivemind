INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Claude Documentation Consultant - Quick reference for Claude Code documentation',
  'claude-code',
  'skill',
  '[{"solution": "Search Claude Code documentation for features and capabilities", "cli": {"macos": "curl -s https://docs.claude.com/api/ | grep keyword", "linux": "curl -s https://docs.claude.com/api/ | grep keyword", "windows": "curl -s https://docs.claude.com/api/ | grep keyword"}, "manual": "Use official Claude Code documentation to answer questions about: capabilities (can Claude do X?), features (how to use Y feature), hooks (implementing slash commands, MCP servers), agent SDK architecture. Search documentation first before inferring capabilities. Reference official docs when available. Clarify with user when uncertain. Look up feature limitations and requirements. Check compatibility matrices. Review API version information. Link to relevant documentation sections.", "note": "Always reference official Claude Code documentation. When uncertain, search docs first. Provide accurate feature lists and limitations from official sources."}]'::jsonb,
  'steps',
  'Claude Code documentation access, curl or web browser for searching docs',
  'Assuming capabilities without checking docs. Confusing features between different Claude Code versions. Not providing official documentation links. Inferring behavior instead of checking docs. Missing feature limitations. Incorrect API compatibility information.',
  'Answers reference official documentation. Feature descriptions match current documentation. Links provided to relevant docs sections. Capabilities accurately described. Limitations clearly stated.',
  'Quick reference guide for Claude Code features, hooks, and agent SDK documentation',
  'https://skillsmp.com/skills/centminmod-my-claude-code-setup-claude-skills-claude-docs-consultant-skill-md',
  'admin:HAIKU_SKILL_1764290199_37706'
);
