INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'TypeScript/JavaScript Development - Write TypeScript and JavaScript code following Metabase coding standards and best practices',
  'claude-code',
  'skill',
  '[
    {"solution": "Follow Metabase TypeScript/JavaScript coding standards", "manual": "Install project dependencies with npm or yarn. Follow established patterns in the codebase for imports, exports, and module structure. Use TypeScript strict mode. Follow naming conventions (camelCase for variables/functions, PascalCase for classes/types). Add proper type annotations. Use the development workflow defined in shared development guidelines.", "note": "Refer to development-workflow.md and typescript-commands.md for detailed commands and patterns"},
    {"solution": "Set up development environment", "manual": "Ensure Node.js and npm/yarn are installed matching the project''s requirements. Run npm install or yarn install to install dependencies. Follow the shared development workflow for project setup.", "note": "Check the project''s package.json for Node version requirements"},
    {"solution": "Write TypeScript with proper typing", "manual": "Always provide type annotations for function parameters and return values. Use interfaces and types appropriately. Avoid using ''any'' type except when absolutely necessary. Follow the TypeScript strict mode configuration. Use generics when appropriate for reusable components.", "note": "Enforce type safety to catch errors at compile time rather than runtime"}
  ]'::jsonb,
  'steps',
  'Node.js, npm or yarn, TypeScript knowledge, familiarity with Metabase codebase',
  'Skipping type annotations, using ''any'' type everywhere, ignoring linter warnings, not following established code patterns, mixing coding styles',
  'Code compiles without TypeScript errors, linter passes, follows Metabase naming conventions, includes proper type annotations, code follows existing patterns in the codebase',
  'Write TypeScript/JavaScript code following Metabase standards and best practices for development and refactoring',
  'https://skillsmp.com/skills/metabase-metabase-claude-skills-typescript-write-skill-md',
  'admin:HAIKU_SKILL_1764288126'
);
