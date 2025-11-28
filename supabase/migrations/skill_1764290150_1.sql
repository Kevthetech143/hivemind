INSERT INTO knowledge_entries (
  query, 
  category, 
  type, 
  solutions, 
  executable_type, 
  prerequisites, 
  common_pitfalls, 
  success_indicators, 
  preview_summary, 
  source_url, 
  contributor_email
) VALUES (
  'mcp-builder - Guide for creating high-quality MCP (Model Context Protocol) servers that enable',
  'claude-code',
  'skill',
  '[{"solution": "See full mcp-builder documentation in referenced guide", "percentage": 100, "note": "Multi-phase development skill"}]'::jsonb,
  'steps',
  'MCP SDK installed',
  'Rushing implementation without research phase',
  'MCP server successfully integrates with Claude',
  'mcp-builder',
  'https://skillsmp.com/skills/davila7-claude-code-templates-cli-tool-components-skills-development-mcp-builder-skill-md',
  'admin:HAIKU_SKILL_1764290150_33086'
);