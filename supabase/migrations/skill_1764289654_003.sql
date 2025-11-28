INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Code Review Excellence - Master effective code review practices to provide constructive feedback, catch bugs early, and foster knowledge sharing',
  'claude-code',
  'skill',
  '[
    {"solution": "Review Mindset and Principles", "manual": "Focus on catching bugs, ensuring maintainability, sharing knowledge, enforcing standards, and improving architecture. Avoid nitpicking formatting, showing off knowledge, or blocking unnecessarily. Make feedback specific, actionable, educational, and balanced."},
    {"solution": "Four-Phase Review Process", "manual": "Phase 1: Gather context (read PR description, check CI status, 2-3 min). Phase 2: High-level review of architecture and design (5-10 min). Phase 3: Line-by-line review of logic, security, performance, maintainability (10-20 min). Phase 4: Summarize findings and make decision (2-3 min)."},
    {"solution": "Review Techniques", "manual": "Use checklist method for security and performance checks. Ask questions instead of stating problems to encourage thinking. Suggest improvements collaboratively rather than commanding. Differentiate severity with labels: [blocking], [important], [nit], [suggestion], [learning], [praise]."},
    {"solution": "Language-Specific Patterns", "manual": "Python: Check for mutable default arguments, broad exception catching, mutable class attributes. TypeScript/JavaScript: Validate proper type usage, async error handling, avoiding prop mutations. Understand language idioms and common pitfalls."},
    {"solution": "Advanced Review Patterns", "manual": "Use architectural reviews with design docs before code. Review in stages for large changes. Request design discussion before implementation. For tests, focus on behavior not implementation details. Apply security checklist for data protection, authentication, input validation."},
    {"solution": "Handling Difficult Feedback", "manual": "Use context + specific issue + helpful solution pattern. When author disagrees, seek to understand, acknowledge valid points, provide data, escalate if needed. Know when to let go if it''s working and not critical. Review promptly (within 24 hours), limit PR size to 200-400 lines."}
  ]'::jsonb,
  'steps',
  'Software development experience, understanding of code quality principles, ability to communicate constructively',
  'Perfectionism blocking PRs for minor issues, scope creep asking for unrelated changes, inconsistent standards across reviewers, delayed reviews, rubber-stamping without actual review, bike-shedding on trivial details, focusing on personal preference over standards',
  'Review turnaround within 24 hours, authors report feeling supported and learning from feedback, consistent code quality standards across team, PRs not stuck in review cycle, team collaboration and psychological safety improved',
  'Comprehensive code review framework covering mindset, process, techniques, and language-specific patterns for constructive feedback and team knowledge sharing',
  'https://skillsmp.com/skills/wshobson-agents-plugins-developer-essentials-skills-code-review-excellence-skill-md',
  'admin:HAIKU_SKILL_1764289654_89802'
);
