INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'WooCommerce Copy Guidelines - UI text, labels, buttons, and message writing',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Use Sentence Case for All UI Text",
      "cli": {},
      "manual": "Always use sentence case (capitalize only first word and proper nouns) for all user-facing text. Never use title case for buttons, labels, headings, or messages. Maintain consistency with WooCommerce copy patterns.",
      "note": "Sentence case is more readable, conversational, and better for accessibility"
    },
    {
      "solution": "Capitalize Proper Nouns and Brand Names",
      "cli": {},
      "manual": "Proper nouns and official brand names must use their correct capitalization: WooPayments, WordPress, Stripe, PayPal, WooCommerce, Google Analytics. These are exceptions to the sentence case rule.",
      "note": "Always check official brand capitalization when referencing external products"
    },
    {
      "solution": "Capitalize Acronyms",
      "cli": {},
      "manual": "Acronyms are always capitalized: API, URL, CSV, SSL, SEO, etc. They are exceptions to sentence case rules.",
      "note": "Acronyms appear as all caps in UI copy"
    },
    {
      "solution": "Write Button Text in Sentence Case",
      "cli": {},
      "manual": "Button text should be sentence case: ''Save changes'', ''Add product'', ''Continue to checkout'', ''Send test email''. NOT ''Save Changes'' or ''Add Product''.",
      "note": "Use action-oriented, concise language for buttons"
    },
    {
      "solution": "Write Labels in Sentence Case",
      "cli": {},
      "manual": "Form labels and UI labels should be sentence case: ''Payment method'', ''Shipping address'', ''Order notes'', ''Tax rate''. NOT ''Payment Method'' or ''Tax Rate''.",
      "note": "Keep labels clear and simple"
    },
    {
      "solution": "Write Headings in Sentence Case",
      "cli": {},
      "manual": "Page headings and section headings should be sentence case: ''Payment settings'', ''Configure your store'', ''Advanced options''. NOT ''Payment Settings'' or ''Configure Your Store''.",
      "note": "Headings should be clear and descriptive"
    },
    {
      "solution": "Write Messages and Notifications in Sentence Case",
      "cli": {},
      "manual": "Error messages, success messages, and notifications should be sentence case: ''Settings saved successfully'', ''Unable to connect to payment provider''. NOT ''Settings Saved Successfully''.",
      "note": "Messages should be clear about what happened and what action is needed"
    }
  ]'::jsonb,
  'steps',
  'WooCommerce repository, understanding of UI copy conventions',
  'Using title case for UI text; Inconsistent capitalization; Not capitalizing proper nouns; Forgetting to capitalize acronyms; Overly verbose copy',
  'All UI text uses sentence case correctly; Proper nouns and brand names are properly capitalized; Acronyms are capitalized; Copy is concise and action-oriented',
  'Follow sentence case for all UI copy - only capitalize first word, proper nouns, and acronyms',
  'https://skillsmp.com/skills/woocommerce-woocommerce-ai-skills-woocommerce-copy-guidelines-skill-md',
  'admin:HAIKU_SKILL_1764290165_33917'
);
