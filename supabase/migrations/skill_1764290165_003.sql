INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'WooCommerce Code Review - Review code for coding standards compliance',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Check for Architecture Violations",
      "cli": {},
      "manual": "Flag standalone functions - must use class methods. Flag classes using ''new'' instead of dependency injection with $container->get(). Flag classes outside src/Internal/ without explicit public design.",
      "note": "Refer to file-entities.md and dependency-injection.md in woocommerce-backend-dev skill"
    },
    {
      "solution": "Check Naming Conventions",
      "cli": {},
      "manual": "Flag camelCase naming - must use snake_case for methods, variables, and hooks. Flag Yoda condition violations - must follow WordPress Coding Standards.",
      "note": "Refer to code-entities.md and coding-conventions.md in woocommerce-backend-dev skill"
    },
    {
      "solution": "Check Documentation Standards",
      "cli": {},
      "manual": "Flag missing @since annotations on public/protected methods. Flag missing docblocks on hooks and methods. Flag verbose docblocks - keep them concise, one line is ideal.",
      "note": "Refer to code-entities.md in woocommerce-backend-dev skill"
    },
    {
      "solution": "Check Data Integrity",
      "cli": {},
      "manual": "Flag missing validation before deletion or modification. Verify that state is checked before data operations.",
      "note": "Refer to data-integrity.md in woocommerce-backend-dev skill"
    },
    {
      "solution": "Check Test Quality",
      "cli": {},
      "manual": "Flag use of $instance variable in tests - must use $sut. Flag missing @testdox in test method docblocks. Verify test file naming follows conventions.",
      "note": "Refer to unit-tests.md in woocommerce-backend-dev skill"
    },
    {
      "solution": "Check UI Text and Copy",
      "cli": {},
      "manual": "Flag title case in UI text - must use sentence case. Exceptions: proper nouns (WooPayments), acronyms (API), and brand names. Examples of violations: ''Save Changes'' (should be ''Save changes''), ''Order Details'' (should be ''Order details'').",
      "note": "Refer to sentence-case.md in woocommerce-copy-guidelines skill"
    },
    {
      "solution": "Format Review Output",
      "cli": {},
      "manual": "For each violation: [Violation]: [Problem], Location: [File path], Standard: [Link to skill file], Fix: [Brief explanation]. Group related issues for clarity. Be constructive and explain why standards exist.",
      "note": "Cite specific skill files when flagging issues"
    }
  ]'::jsonb,
  'steps',
  'WooCommerce repository, woocommerce-backend-dev and woocommerce-copy-guidelines skills, understanding of WooCommerce coding standards',
  'Not citing specific skill files; Being overly critical without explaining why standards matter; Mixing unrelated issues; Missing violations due to incomplete checklist',
  'All architecture issues flagged; Naming conventions verified; Documentation complete; Data integrity validated; Tests follow conventions; UI text uses correct case',
  'Review code for WooCommerce standards: architecture, naming, documentation, data integrity, testing, and UI text',
  'https://skillsmp.com/skills/woocommerce-woocommerce-ai-skills-woocommerce-code-review-skill-md',
  'admin:HAIKU_SKILL_1764290165_33917'
);
