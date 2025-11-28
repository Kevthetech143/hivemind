INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'clojure-write - REPL-driven Clojure development workflow and best practices',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Start with fundamental functions and test in REPL",
      "manual": "1. Identify core features needed\n2. Break each into smallest testable functions\n3. Write and test each function in REPL directly\n4. Move tested code into source files\n5. Gradually build complexity on tested foundations\n6. Ensure every function tested before being depended on"
    },
    {
      "solution": "Evaluate code using bottom-up development loop",
      "cli": {
        "macos": "./bin/mage -repl --namespace metabase.app-db.connection",
        "linux": "./bin/mage -repl --namespace metabase.app-db.connection",
        "windows": ".\\bin\\mage -repl --namespace metabase.app-db.connection"
      },
      "manual": "1. Write code into a file\n2. Evaluate the file''s namespace\n3. Call functions with test inputs in REPL\n4. Copy successful REPL trials into test cases using deftest and is\n5. Compose functions into required tasks"
    },
    {
      "solution": "Follow critical editing rules for Clojure",
      "manual": "1. Keep parentheses counts balanced when editing\n2. After EVERY change, verify readability with -check-readable\n3. End all files with a newline\n4. Keep tabular code columns aligned\n5. Do not have trailing spaces on lines"
    }
  ]'::jsonb,
  'steps',
  'Clojure/ClojureScript development environment, access to ./bin/mage or equivalent REPL launcher',
  'Unbalanced parentheses breaking code, forgetting to verify readability after changes, not testing functions before composing them, leaving trailing spaces in tabular code',
  'Functions work correctly in REPL, code loads without syntax errors, readability check passes, tests pass using deftest',
  'Guide for REPL-driven Clojure development with emphasis on bottom-up testing and functional composition',
  'https://skillsmp.com/skills/metabase-metabase-claude-skills-clojure-write-skill-md',
  'admin:HAIKU_SKILL_1764289228_76927'
);
