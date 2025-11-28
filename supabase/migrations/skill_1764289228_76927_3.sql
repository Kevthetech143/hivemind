INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'docs-write - Write documentation with Metabase conversational style and clarity',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Start documentation writing with audience and purpose",
      "manual": "1. Identify who the documentation is for and match complexity to their level\n2. Determine what readers need and get them to the answer fast\n3. Recall what was difficult when learning and answer those questions\n4. Lead with ''what to do'' before explaining ''why''"
    },
    {
      "solution": "Write and edit documentation following best practices",
      "manual": "Draft phase: Write steps as you''d tell a colleague, lead with action then explanation\nEdit phase: Read aloud for conversational tone, cut non-essential content, verify one purpose per paragraph, test examples\nPolish phase: Make links descriptive (never ''here''), use backticks only for code/variables, bold for UI elements, American spelling, serial commas, minimal scoped images"
    },
    {
      "solution": "Format documentation with prettier",
      "cli": {
        "macos": "yarn prettier --write <file-path>",
        "linux": "yarn prettier --write <file-path>",
        "windows": "yarn prettier --write <file-path>"
      },
      "note": "Run after making edits to ensure consistent formatting"
    },
    {
      "solution": "Use correct patterns for instructions and links",
      "manual": "Instructions: Show commands in code blocks, then explain what happens\nHeadings: State the point directly (''Use environment variables for configuration'' not ''Environment variables'')\nLinks: ''Check out the [SAML documentation](link)'' not ''Read [here](link)''\nDo not bury actions in explanation or tell readers to remember steps"
    },
    {
      "solution": "Avoid common documentation pitfalls",
      "manual": "Avoid: describing tasks as ''easy'', using ''we'' for Metabase features, formal language (utilize, reference, offerings), multiple exclamation points, burying actions, non-working code examples, numbers that become outdated\nUse: people/companies instead of users, conversational contractions (can''t, don''t), **bold** for UI elements"
    }
  ]'::jsonb,
  'steps',
  'Metabase style guide knowledge, markdown editor, yarn/prettier for formatting, access to write documentation files',
  'Using formal tone instead of conversational, burying the action in explanation, providing code examples that error, using backticks for UI elements, linking on the word ''here'', describing tasks as ''easy'', not testing examples, forgetting to run prettier',
  'Documentation reads naturally when spoken aloud, examples tested and working, links are descriptive, consistent formatting with prettier, correct markdown patterns followed, clear point stated in headings',
  'Writing guide for Metabase documentation emphasizing conversational tone, clear structure, and user-focused content',
  'https://skillsmp.com/skills/metabase-metabase-claude-skills-docs-write-skill-md',
  'admin:HAIKU_SKILL_1764289228_76927'
);
