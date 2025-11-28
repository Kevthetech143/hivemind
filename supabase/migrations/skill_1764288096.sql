INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'TypeScript/JavaScript Code Review - Review TypeScript and JavaScript code changes for compliance with Metabase coding standards, style violations, and code quality issues',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Review code for Metabase coding standards compliance",
      "cli": {
        "macos": "# Use Read tool to examine files: Read /path/to/file.ts",
        "linux": "# Use Read tool to examine files: Read /path/to/file.ts",
        "windows": "# Use Read tool to examine files: Read /path/to/file.ts"
      },
      "manual": "1. Read the TypeScript/JavaScript files being reviewed\n2. Check for compliance with Metabase coding standards and conventions\n3. Review code quality and best practices\n4. Verify JSDoc comments are clear and correct\n5. Ensure proper TypeScript usage and type safety\n6. Check React best practices (when applicable)",
      "note": "Use allowed-tools: Read, Grep, Bash, Glob for code analysis"
    },
    {
      "solution": "Use Grep to search for style violations across files",
      "cli": {
        "macos": "grep -r \"pattern\" /path/to/files --include=\"*.ts\" --include=\"*.tsx\"",
        "linux": "grep -r \"pattern\" /path/to/files --include=\"*.ts\" --include=\"*.tsx\"",
        "windows": "findstr /S \"pattern\" /path/to/files"
      },
      "manual": "Use Grep tool to search for common violations:\n- Missing type annotations\n- Unused variables or imports\n- Inconsistent naming conventions\n- Missing JSDoc comments on exported functions\n- Type-unsafe comparisons or operations",
      "note": "Search patterns should be specific to Metabase''s coding standards"
    },
    {
      "solution": "Verify code changes against pull request diffs",
      "cli": {
        "macos": "# View diff using Bash: git diff HEAD~1",
        "linux": "# View diff using Bash: git diff HEAD~1",
        "windows": "# View diff using Bash: git diff HEAD~1"
      },
      "manual": "1. Use Bash to run git diff commands to see changes\n2. Review each change for type safety\n3. Check for breaking changes or API modifications\n4. Verify test coverage for new functionality\n5. Ensure backward compatibility where needed",
      "note": "Context available from PR description and commit messages"
    }
  ]'::jsonb,
  'steps',
  'Access to TypeScript/JavaScript files, understanding of Metabase coding standards, git repository access',
  'Assuming all code is correct without checking type definitions, missing JSDoc comments, not verifying type safety, ignoring React hooks rules, not checking for breaking changes',
  'Pull request has been reviewed for all coding standard violations, type safety verified, JSDoc comments are complete and accurate, code follows React best practices where applicable',
  'Review TypeScript and JavaScript code for compliance with Metabase standards and code quality issues',
  'https://skillsmp.com/skills/metabase-metabase-claude-skills-typescript-review-skill-md',
  'admin:HAIKU_SKILL_1764288096'
);
