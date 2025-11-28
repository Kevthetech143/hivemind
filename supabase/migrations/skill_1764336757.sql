INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Canvas Design Skill - Create beautiful visual art in .png and .pdf documents using design philosophy',
  'claude-code',
  'skill',
  '[{"solution":"Create visual art through design philosophy + canvas expression","manual":"1. Create a VISUAL PHILOSOPHY (.md file) that expresses aesthetic movements through form, space, color, composition. 2. Establish design philosophy (4-6 paragraphs) covering visual essence: space and form, color and material, scale and rhythm, composition and balance, visual hierarchy. 3. Deduce subtle conceptual thread embedded in the art itself (refined, sophisticated reference that rewards sustained viewing). 4. Create canvas (.pdf or .png) expressing philosophy with expert craftsmanship: minimal text as visual element, dense composition, patterns and systematic elements. 5. Use fonts from ./canvas-fonts directory, ensure nothing overlaps, all content within canvas boundaries. 6. Emphasize meticulous, master-level execution as if created by someone at top of their field. Output final result as downloadable .pdf or .png file alongside design philosophy .md file.","note":"Must emphasize meticulously crafted appearance, labored attention to detail. Visual communication over text. Museum/magazine quality work. Avoid cartoony or amateur approaches. Use analytical visual language to suggest scientific sophistication."}]'::jsonb,
  'manual',
  'Ability to create PDF/PNG files, access to fonts directory, understanding of design philosophy and visual composition',
  'Adding too much text instead of keeping it minimal. Overlapping elements on canvas. Not making work appear sufficiently crafted/professional. Forgetting to emphasize visual expression over verbal explanation. Making cartoonish designs instead of sophisticated art',
  'Final design is museum/magazine quality. Text is minimal and integrated as visual element. Composition appears meticulously crafted as if by master craftsperson. All elements properly contained with breathing room. Philosophy clearly guides visual expression. Design could be displayed in professional gallery or design publication',
  'Create sophisticated visual art by first establishing a design philosophy emphasizing form/space/color/composition, then expressing it through carefully crafted PDF/PNG design that looks like museum-quality work',
  'https://skillsmp.com/skills/anthropics-skills-canvas-design-skill-md',
  'admin:HAIKU_MINER'
);
