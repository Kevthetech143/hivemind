INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'docs-write - Write clear, user-focused documentation following Metabase''s conversational style guide. Use when creating or editing markdown/MDX documentation files.',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Understand your audience and structure content for clarity",
      "manual": "1. Ask: Who is this for? Match complexity to audience level. 2. Ask: What do they need? Get them to the answer fast. 3. Consider what you struggled with when learning - answer those common questions without stating the question explicitly."
    },
    {
      "solution": "Follow the writing process: Draft, Edit, Polish, Format",
      "manual": "Draft: Write steps as you''d tell a colleague, lead with what to do then why. Edit: Read aloud for natural tone, cut unnecessary content, verify each paragraph has one clear purpose. Polish: Make links descriptive, use backticks only for code/variables, bold for UI elements, verify spelling and commas. Format: Run prettier: yarn prettier --write <file-path>"
    },
    {
      "solution": "Use clear headings that state your point",
      "manual": "Use headings like ''Set SAML before adding users'' (action-focused) not ''SAML configuration timing'' (vague). Include environment setup instructions clearly with separate code blocks for each command step."
    },
    {
      "solution": "Follow the quick reference style guide for terminology",
      "manual": "Use: people/companies (not users), summarize (not aggregate), take a look at (not reference), can''t/don''t (not cannot/do not). Format UI elements with **bold**, not backticks. Write links as [descriptive text](url) never ''here''."
    },
    {
      "solution": "Watch out for common pitfalls in documentation",
      "manual": "Avoid: describing tasks as ''easy'', using ''we'' for features (use ''Metabase'' or ''it''), formal language (utilize, reference, offerings), multiple exclamation points, burying actions in explanation, non-working code examples, outdated numbers."
    }
  ]'::jsonb,
  'steps',
  'Metabase repository access, understanding of markdown/MDX, familiarity with the specific documentation domain',
  'Using vague headings, burying actions in paragraphs, including non-working code examples, formal language, using ''easy'' or ''we'' inappropriately, outdated numbers, ambiguous links (''here'')',
  'Documentation is clear and user-focused, uses appropriate complexity for audience, includes working examples, follows formatting with prettier, uses action-oriented headings, contains descriptive links',
  'Write documentation using Metabase''s conversational, clear, and user-focused style with proper formatting and terminology.',
  'https://skillsmp.com/skills/metabase-metabase-claude-skills-docs-write-skill-md',
  'admin:HAIKU_SKILL_1764288411'
);
