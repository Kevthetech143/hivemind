INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Core Skill - Fundamental skills and best practices for effective prompting',
  'claude-code',
  'skill',
  '[{"solution": "Use clear, specific language", "note": "Avoid vague terms. Example: ''Summarize the article'' is vague; ''Extract 5 key findings from the article in bullet point format'' is specific."}, {"solution": "Provide context boundary", "note": "Tell model what NOT to do. ''Analyze without referencing politics'' or ''Summarize in technical terms only'' sets clear constraints."}, {"solution": "Specify output format explicitly", "note": "State exact format wanted: JSON, markdown, bullet points, table, code block. Models perform better with format requirements stated upfront."}]'::jsonb,
  'steps',
  'Basic understanding of how to communicate with LLMs effectively.',
  'Assuming model knows context without stating it, asking open-ended questions expecting specific outputs, not clarifying edge cases, changing requirements mid-conversation',
  'Model responses match specified format, context boundaries are respected (model excludes unwanted topics), output specificity matches request specificity, consistency across multiple runs',
  'Foundational prompting practices for clear communication with language models',
  'https://skillsmp.com/skills/danielmiessler-personal-ai-infrastructure-claude-skills-core-skill-md',
  'admin:HAIKU_SKILL_1764290427_67628'
);
