INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Writing Hookify Rules - Create and configure Claude Code hookify rules for bash, file, stop, and prompt events with regex patterns',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Set up rule file structure with YAML frontmatter",
      "cli": {
        "macos": "mkdir -p .claude && touch .claude/hookify.{rule-name}.local.md",
        "linux": "mkdir -p .claude && touch .claude/hookify.{rule-name}.local.md",
        "windows": "mkdir .claude && type nul > .claude\\\\hookify.{rule-name}.local.md"
      },
      "manual": "Create a file named .claude/hookify.{descriptive-name}.local.md in your project root. Use kebab-case naming (e.g., .claude/hookify.warn-dangerous-rm.local.md). This file will contain YAML frontmatter followed by markdown message body.",
      "note": "Rules are read dynamically - no restart needed. Changes take effect on next tool use."
    },
    {
      "solution": "Define frontmatter with required fields",
      "cli": {
        "macos": "cat > .claude/hookify.example.local.md << ''RULE''\n---\nname: example-rule\nenabled: true\nevent: bash\npattern: dangerous_pattern\n---\n\nWarning message\nRULE",
        "linux": "cat > .claude/hookify.example.local.md << ''RULE''\n---\nname: example-rule\nenabled: true\nevent: bash\npattern: dangerous_pattern\n---\n\nWarning message\nRULE",
        "windows": "type nul > .claude\\\\hookify.example.local.md"
      },
      "manual": "Add YAML frontmatter with: name (unique identifier in kebab-case), enabled (true/false), event (bash|file|stop|prompt|all), pattern (regex pattern), and optionally action (warn|block). Example: name: warn-dangerous-rm, enabled: true, event: bash, pattern: rm\\\\s+-rf",
      "note": "Start name with verb: warn, prevent, block, require, check. Use unquoted patterns in YAML to avoid double-backslash issues."
    },
    {
      "solution": "Write effective warning messages",
      "cli": {
        "macos": "cat > .claude/hookify.test.local.md << ''RULE''\n---\nname: test-rule\nenabled: true\nevent: bash\npattern: rm\\\\s+-rf\n---\n\nDangerous rm command detected!\n\nYou''re using rm -rf which can permanently delete files.\nRULE",
        "linux": "cat > .claude/hookify.test.local.md << ''RULE''\n---\nname: test-rule\nenabled: true\nevent: bash\npattern: rm\\\\s+-rf\n---\n\nDangerous rm command detected!\n\nYou''re using rm -rf which can permanently delete files.\nRULE",
        "windows": "type nul > .claude\\\\hookify.test.local.md"
      },
      "manual": "Write clear markdown messages that explain what was detected, why it matters, and suggest alternatives. Use formatting (bold, lists) for clarity. Example message structure: 1) What was detected, 2) Why problematic, 3) Suggested alternatives or best practices.",
      "note": "Messages appear in Claude Code output when the rule triggers. Make them informative but concise."
    },
    {
      "solution": "Use simple pattern format for single conditions",
      "cli": {
        "macos": "python3 -c \"import re; print(re.search(r''rm\\\\s+-rf'', ''rm -rf /tmp''))\"",
        "linux": "python3 -c \"import re; print(re.search(r''rm\\\\s+-rf'', ''rm -rf /tmp''))\"",
        "windows": "python -c \"import re; print(re.search(r''rm\\\\\\\\s+-rf'', ''rm -rf /tmp''))\""
      },
      "manual": "For simple rules, use the pattern field with Python regex. Test patterns with: python3 -c \"import re; print(re.search(r''your_pattern'', ''test text''))\" or use regex101.com with Python flavor. Common patterns: rm\\\\s+-rf (dangerous rm), console\\\\.log\\\\( (debug logs), chmod\\\\s+777 (permissions), API_KEY\\\\s*= (env vars).",
      "note": "Use \\\\s for whitespace, \\\\d for digits, \\\\w for word chars. Escape special regex chars: \\\\. \\\\( \\\\) \\\\[ \\\\]"
    },
    {
      "solution": "Create advanced rules with multiple conditions",
      "cli": {
        "macos": "cat > .claude/hookify.env-api-key.local.md << ''RULE''\n---\nname: warn-env-file-edits\nenabled: true\nevent: file\nconditions:\n  - field: file_path\n    operator: regex_match\n    pattern: \\.env$\n  - field: new_text\n    operator: contains\n    pattern: API_KEY\n---\n\nYou''re adding an API key to a .env file. Ensure this file is in .gitignore!\nRULE",
        "linux": "cat > .claude/hookify.env-api-key.local.md << ''RULE''\n---\nname: warn-env-file-edits\nenabled: true\nevent: file\nconditions:\n  - field: file_path\n    operator: regex_match\n    pattern: \\.env$\n  - field: new_text\n    operator: contains\n    pattern: API_KEY\n---\n\nYou''re adding an API key to a .env file. Ensure this file is in .gitignore!\nRULE",
        "windows": "type nul > .claude\\\\hookify.env-api-key.local.md"
      },
      "manual": "For complex rules, use conditions array with field, operator, and pattern. Fields: bash (command), file (file_path, new_text, old_text, content), prompt (user_prompt). Operators: regex_match, contains, equals, not_contains, starts_with, ends_with. All conditions must match for rule to trigger.",
      "note": "Conditions are AND''ed together. Use regex_match for patterns, contains for substrings."
    },
    {
      "solution": "Match different event types appropriately",
      "cli": {
        "macos": "echo ''event: bash'' > rule1.md && echo ''event: file'' > rule2.md",
        "linux": "echo ''event: bash'' > rule1.md && echo ''event: file'' > rule2.md",
        "windows": "echo. > rules.txt"
      },
      "manual": "Event types: bash (Bash tool commands), file (Edit/Write/MultiEdit operations), stop (when agent wants to stop/complete), prompt (user input), all (all events). Choose based on what you''re monitoring. Bash event field is command. File event fields are file_path, new_text, old_text, content. Prompt event field is user_prompt.",
      "note": "Use bash for commands, file for edits, stop for completion checks, prompt for user input validation."
    },
    {
      "solution": "Avoid common pattern mistakes",
      "cli": {
        "macos": "python3 -c \"import re; print(re.search(r''log'', ''dialog''))\" # Too broad\npython3 -c \"import re; print(re.search(r''console\\\\.log\\\\('', ''console.log(var)''))\" # Better",
        "linux": "python3 -c \"import re; print(re.search(r''log'', ''dialog''))\" # Too broad\npython3 -c \"import re; print(re.search(r''console\\\\.log\\\\('', ''console.log(var)''))\" # Better",
        "windows": "python -c \"import re; print(re.search(r''log'', ''dialog''))\""
      },
      "manual": "Common pitfalls: 1) Too broad patterns (matches unintended text), 2) Too specific patterns (only exact matches), 3) Escaping issues in YAML (use unquoted pattern field). Test patterns against real examples. Avoid matching common words - be specific with boundaries and context.",
      "note": "Use word boundaries or specific context. Example: rm\\\\s+-rf matches rm -rf but not cdrm -rf."
    },
    {
      "solution": "Manage rule lifecycle and testing",
      "cli": {
        "macos": "touch .claude/hookify.my-rule.local.md && vim .claude/hookify.my-rule.local.md && rm .claude/hookify.my-rule.local.md",
        "linux": "touch .claude/hookify.my-rule.local.md && vim .claude/hookify.my-rule.local.md && rm .claude/hookify.my-rule.local.md",
        "windows": "type nul > .claude\\\\hookify.my-rule.local.md"
      },
      "manual": "Workflow: 1) Create .claude/hookify.{name}.local.md file, 2) Write frontmatter and message, 3) Test immediately on next tool use (no restart needed), 4) Adjust pattern or message as needed, 5) To disable: set enabled: false in frontmatter, 6) To delete: remove the file. Rules are read dynamically so changes take effect immediately.",
      "note": "Add .claude/*.local.md to .gitignore to keep local rules from version control."
    }
  ]'::jsonb,
  'steps',
  'Claude Code installed, understanding of regex patterns, project with .claude directory',
  'Using YAML quoted patterns (use unquoted), patterns too broad or too specific, forgetting to escape regex special characters (.), not testing patterns before deployment, mixing up event types and their available fields, double-backslashing patterns in quoted YAML strings',
  'Rule file created in .claude/ with correct naming, pattern tested with Python regex and matches intended behavior, message is clear and actionable, rule triggers on correct events (verified on next tool use), unused rules disabled with enabled: false or removed completely',
  'Create and manage Claude Code hookify rules that trigger on bash commands, file edits, stops, or prompts using regex patterns and conditional logic.',
  'https://skillsmp.com/skills/anthropics-claude-code-plugins-hookify-skills-writing-rules-skill-md',
  'admin:HAIKU_SKILL_1764288423'
);
