INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Prompting Skill - Advanced prompt engineering techniques and frameworks',
  'claude-code',
  'skill',
  '[{"solution": "Structure prompts with role+task+context", "note": "Define clear role (you are X), specific task (do Y), and context (background Z). This three-part structure improves output quality significantly."}, {"solution": "Use system prompts for behavior control", "note": "System prompts set baseline behavior, tone, constraints. User prompts provide specific tasks. Combine both for best results."}, {"solution": "Implement Chain-of-Thought prompting", "note": "Ask model to ''think step by step'' or ''explain your reasoning'' for complex tasks. Increases accuracy and transparency of reasoning."}, {"solution": "Few-shot prompting for task examples", "note": "Provide 2-3 examples of desired input/output format before asking model to perform task on new data. Dramatically improves consistency."}]'::jsonb,
  'steps',
  'Understanding of LLM behavior and how prompts influence outputs. Familiarity with basic prompt anatomy (system/user messages).',
  'Too much context (confuses model), ambiguous task definitions, not showing examples when task is complex, asking for output format without examples, treating all prompts the same regardless of task complexity',
  'Prompt generates responses matching desired format, outputs are consistent across multiple runs with same prompt, complex tasks produce accurate step-by-step reasoning, few-shot examples improve output quality on new data',
  'Advanced prompt engineering techniques for improving LLM output quality and consistency',
  'https://skillsmp.com/skills/danielmiessler-personal-ai-infrastructure-claude-skills-prompting-skill-md',
  'admin:HAIKU_SKILL_1764290427_67628'
);
