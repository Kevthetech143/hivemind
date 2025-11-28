-- Theme Factory Skill Migration
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
  'theme-factory',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Display theme showcase PDF to users for visual selection of 10 pre-built professional themes",
      "percentage": 85
    },
    {
      "solution": "Apply selected theme colors and fonts consistently across artifacts (slides, docs, HTML pages)",
      "percentage": 85
    },
    {
      "solution": "Create custom themes on-the-fly based on user requirements when built-in themes don''t fit",
      "percentage": 75
    }
  ]'::jsonb,
  'steps',
  'Access to theme-showcase.pdf file, artifact to style (slides/docs/HTML)',
  'Modifying the showcase PDF itself (read-only), applying inconsistent colors across pages, not verifying contrast/readability',
  'User confirms selected theme visually, colors and fonts applied consistently, readability maintained with proper contrast',
  'Toolkit for styling artifacts with professional font/color themes. 10 pre-set themes with colors/fonts for slides, docs, HTML pages. Can generate custom themes on-the-fly.',
  'https://skillsmp.com/skills/anthropics-skills-theme-factory-skill-md',
  'admin:HAIKU_1764337623_14045'
);
