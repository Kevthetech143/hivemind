INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'blog-post-writer - Write effective technical blog posts from outline, code samples, and user guidance',
  'claude-code',
  'skill',
  '[{"solution": "Create blog post structure", "manual": "Start with outline covering: introduction (hook + thesis), problem statement, solution approach, implementation example, lessons learned, call to action"}, {"solution": "Write with code samples", "manual": "Include working code examples that demonstrate the concept, explain key sections, show common pitfalls"}, {"solution": "Optimize for readers", "manual": "Use clear headings, short paragraphs, highlight key insights, end sections with clear takeaways"}]'::jsonb,
  'steps',
  'Blog platform accessible, understanding of target audience',
  'Writing without concrete examples, overly theoretical tone, missing call to action, neglecting editing',
  'Post publishes successfully, includes working code examples, has clear structure with introduction-problem-solution-lessons',
  'Write technical blog posts with code examples and practical guidance',
  'https://skillsmp.com/skills/nicknisi-dotfiles-home-claude-skills-blog-post-writer-skill-md',
  'admin:HAIKU_SKILL_1764290169_34218'
);
