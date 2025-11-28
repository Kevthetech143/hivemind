INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Art Skill - Generate visual art prompts and guide image generation',
  'claude-code',
  'skill',
  '[{"solution": "Deconstruct visual concept into detailed elements", "note": "Subject (what), Medium (how it''s made), Style (artistic approach), Composition (framing/layout), Lighting (mood/atmosphere), Colors (palette). Each element improves prompt quality."}, {"solution": "Write detailed image generation prompts", "note": "Combine elements into single descriptive prompt. Example: ''Watercolor painting of moonlit forest with silver highlights, misty atmosphere, cool color palette, wide-angle composition''"}, {"solution": "Iterate prompts based on output feedback", "note": "Analyze generated image against intent. If missing elements, add more detail to prompt. If cluttered, remove unnecessary descriptors. Refinement improves results."}]'::jsonb,
  'steps',
  'Access to image generation tool (DALL-E, Midjourney, Stable Diffusion, etc.). Visual composition knowledge helpful but not required.',
  'Too vague prompts (expecting AI to guess intent), overcrowded prompts (too many conflicting descriptors), not specifying medium/style (resulting in inconsistent aesthetic), not iterating after first attempt',
  'Generated image matches described intent and mood, composition follows specified framing, lighting creates intended atmosphere, colors match specified palette, subject is recognizable and detailed',
  'Visual art generation framework for creating detailed image prompts and iterating visual outputs',
  'https://skillsmp.com/skills/danielmiessler-personal-ai-infrastructure-claude-skills-art-skill-md',
  'admin:HAIKU_SKILL_1764290427_67628'
);
