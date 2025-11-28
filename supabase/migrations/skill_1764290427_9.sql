INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Story Explanation Skill - Explain complex concepts through narrative and storytelling',
  'claude-code',
  'skill',
  '[{"solution": "Identify core concept to explain", "note": "Isolate the single most important idea you need to convey. Avoid explaining multiple concepts simultaneously."}, {"solution": "Create relatable narrative structure", "note": "Use: Problem (character faces challenge), Struggle (attempts and failures), Resolution (learns key insight that relates to concept). Characters/scenarios should be relatable to audience."}, {"solution": "Map concept to story elements", "note": "Embed the explanation naturally into story progression. The resolution should reveal the concept insight. Avoid lectures; show through narrative."}]'::jsonb,
  'steps',
  'Understanding of the complex concept to explain. Knowledge of target audience''s background and interests. Basic storytelling structure (setup, conflict, resolution).',
  'Trying to explain multiple concepts in one story, making story too complex (too many characters/subplots), explaining the concept directly instead of showing it through story, choosing unrelatable characters/scenarios for audience',
  'Story engages audience and is easy to follow, core concept becomes clear by end of story without explicit summary, audience can relate to character/scenario, resolution naturally reveals the concept insight',
  'Narrative-based explanation framework for making complex concepts more understandable and memorable',
  'https://skillsmp.com/skills/danielmiessler-personal-ai-infrastructure-claude-skills-story-explanation-skill-md',
  'admin:HAIKU_SKILL_1764290427_67628'
);
