INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'WooCommerce Development Cycle - Run tests, linting, and quality checks',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Run PHP Unit Tests",
      "cli": {
        "macos": "pnpm run test:php:env -- --filter YourTestClass",
        "linux": "pnpm run test:php:env -- --filter YourTestClass",
        "windows": "pnpm run test:php:env -- --filter YourTestClass"
      },
      "manual": "Execute PHP unit tests using pnpm. Use --filter to run specific tests. Test environment auto-configures WordPress/WooCommerce via Docker.",
      "note": "Stop on first failure with --stop-on-failure flag for easier debugging"
    },
    {
      "solution": "Run PHP Code Quality Checks",
      "cli": {
        "macos": "pnpm run lint:changes:branch:php",
        "linux": "pnpm run lint:changes:branch:php",
        "windows": "pnpm run lint:changes:branch:php"
      },
      "manual": "Check changed files for WordPress Coding Standards violations. Only lint code you''ve modified in your branch.",
      "note": "Use lint:php:fix to automatically fix style issues"
    },
    {
      "solution": "Auto-fix PHP Code Style Issues",
      "cli": {
        "macos": "pnpm run lint:php:fix",
        "linux": "pnpm run lint:php:fix",
        "windows": "pnpm run lint:php:fix"
      },
      "manual": "Automatically fix WordPress Coding Standards violations. Modifies files in place. Always review changes with git diff before committing.",
      "note": "Some issues require manual intervention. See php-linting-patterns.md for manual fixes."
    },
    {
      "solution": "Run JavaScript Linting",
      "cli": {
        "macos": "pnpm run lint:changes:branch:js",
        "linux": "pnpm run lint:changes:branch:js",
        "windows": "pnpm run lint:changes:branch:js"
      },
      "manual": "Check JavaScript/TypeScript files for linting issues. Only checks files changed in current branch.",
      "note": "Refer to client/admin/CLAUDE.md for detailed JS/TS linting patterns"
    },
    {
      "solution": "Run Markdown Linting",
      "cli": {
        "macos": "markdownlint --fix path/to/file.md && markdownlint path/to/file.md",
        "linux": "markdownlint --fix path/to/file.md && markdownlint path/to/file.md",
        "windows": "markdownlint --fix path/to/file.md && markdownlint path/to/file.md"
      },
      "manual": "Lint and auto-fix markdown files. Run from repository root so .markdownlint.json config loads. Always verify encoding after edits.",
      "note": "Use UTF-8 box-drawing characters for directory trees, never ASCII art"
    }
  ]'::jsonb,
  'script',
  'WooCommerce repository, pnpm package manager, Docker for test environment, markdownlint-cli installed globally',
  'Linting entire codebase instead of just changed files; Not reviewing auto-fixes before committing; Running commands from wrong directory; Linting unrelated code',
  'All tests pass; Linting output shows zero errors; Code follows WordPress Coding Standards; Markdown files display correctly',
  'Run tests with pnpm, fix linting issues with auto-fix commands, verify changes before committing',
  'https://skillsmp.com/skills/woocommerce-woocommerce-ai-skills-woocommerce-dev-cycle-skill-md',
  'admin:HAIKU_SKILL_1764290165_33917'
);
