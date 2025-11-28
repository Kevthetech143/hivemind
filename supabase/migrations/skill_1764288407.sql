INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Clojure Development Skill - Guide for REPL-driven Clojure/ClojureScript development using coding conventions and best practices',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Start with small, fundamental functions in REPL-driven workflow",
      "cli": {
        "macos": "./bin/mage -repl --namespace metabase.app-db.connection",
        "linux": "./bin/mage -repl --namespace metabase.app-db.connection",
        "windows": ".\\bin\\mage -repl --namespace metabase.app-db.connection"
      },
      "manual": "1. Identify core features and break them into smallest basic functions\n2. Write and test each function in the REPL with typical and edge case inputs\n3. Test thoroughly to ensure correct behavior before moving to source code\n4. Once verified, move function from REPL into appropriate source code files and namespaces",
      "note": "Test each function fully in the REPL before other functions depend on it"
    },
    {
      "solution": "Evaluate and load Clojure code into REPL",
      "cli": {
        "macos": "./bin/mage -repl --namespace metabase.app-db.connection",
        "linux": "./bin/mage -repl --namespace metabase.app-db.connection",
        "windows": ".\\bin\\mage -repl --namespace metabase.app-db.connection"
      },
      "manual": "1. Write code into a file in the appropriate namespace\n2. Load the namespace into the REPL using mage with the correct --namespace parameter\n3. Call functions with test inputs and verify outputs are correct\n4. Copy successful REPL trials into actual test cases using deftest and is macros",
      "note": "Always verify that the namespace loads correctly before proceeding"
    },
    {
      "solution": "Compose functions and build complex functionality",
      "cli": {
        "macos": "",
        "linux": "",
        "windows": ""
      },
      "manual": "1. Ensure every function is fully tested in REPL before other functions depend on it\n2. Build upon tested, basic functions to create more complex functions or components\n3. Compose smaller functions together, testing each composition in REPL\n4. Follow functional programming principles: keep functions small, focused, and composable\n5. Use Clojure''s features like immutability, higher-order functions, and standard library",
      "note": "Each layer must be reliable before building on it"
    },
    {
      "solution": "Verify code readability and syntax",
      "cli": {
        "macos": "./bin/mage -check-readable",
        "linux": "./bin/mage -check-readable",
        "windows": ".\\bin\\mage -check-readable"
      },
      "manual": "1. After every change to Clojure code, run the readability check\n2. Ensure all files end with a newline\n3. When editing tabular code with aligned columns, keep alignment consistent\n4. Remove any trailing whitespace on lines\n5. Be careful with parentheses counts when editing",
      "note": "Readability verification is critical after each change to catch syntax errors early"
    }
  ]'::jsonb,
  'script',
  'Clojure/ClojureScript development environment, ./bin/mage CLI tool, knowledge of functional programming paradigms',
  'Not testing in REPL before integration, neglecting to verify parentheses balance, not running readability checks after changes, skipping edge case testing, moving code to source before REPL validation',
  'Functions work correctly in REPL with test inputs, code loads without namespace errors, readability check passes, test cases cover typical and edge cases, composition works with dependent functions',
  'REPL-driven Clojure/ClojureScript development using small composable functions, functional programming principles, and bottom-up testing workflow',
  'https://skillsmp.com/skills/metabase-metabase-claude-skills-clojure-write-skill-md',
  'admin:HAIKU_SKILL_1764288407'
);
