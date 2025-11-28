INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'docs-review - Review documentation for style guide compliance and readability',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Detect and use correct review mode",
      "manual": "1. Check if mcp__github__create_pending_pull_request_review tool is available\n2. If available: use PR review mode with pending review workflow\n3. If not available: output issues as numbered markdown list in conversation"
    },
    {
      "solution": "Execute complete review process",
      "manual": "1. Detect review mode first\n2. Read changes to understand intent\n3. Check all style guide violations\n4. Flag only issues worth mentioning (material difference to reader)\n5. Number ALL feedback sequentially starting from Issue 1"
    },
    {
      "solution": "Use quick scan checklist for common issues",
      "manual": "Check for: formal/corporate language, excessive exclamation points, vague headings, buried important info, backticks on UI elements (should be bold), links on ''here'' instead of descriptive text, code examples that don''t work, condescending qualifiers like ''easy'' or ''simple'', inconsistent formatting"
    },
    {
      "solution": "Format feedback correctly for local review mode",
      "manual": "Use numbered markdown format:\n**Issue 1: [Brief title]**\nLine X: Description\n[code or example]\nSuggested fix\n\nMust number sequentially starting from 1 with no gaps"
    },
    {
      "solution": "Use pending review workflow for PR review mode",
      "manual": "1. Start review with mcp__github__create_pending_pull_request_review\n2. Get diff with mcp__github__get_pull_request_diff for line numbers\n3. Identify ALL issues and number them sequentially\n4. Add ALL comments in parallel using mcp__github__add_pull_request_review_comment_to_pending_review\n5. Submit review with mcp__github__submit_pending_pull_request_review, event type COMMENT, no body message"
    }
  ]'::jsonb,
  'steps',
  'Metabase style guide knowledge, markdown files to review, optional GitHub PR access',
  'Flagging trivial issues that won''t matter, missing sequential numbering, posting comments one-by-one instead of in parallel in PR mode, including body message in review submission, using backticks for UI elements instead of bold, leaving comments congratulating style compliance',
  'All style violations identified and documented, issues numbered sequentially without gaps, feedback formatted correctly for chosen mode, PR review submitted as single cohesive review (if applicable)',
  'Documentation review skill checking style guide compliance, tone, clarity, formatting, and code examples',
  'https://skillsmp.com/skills/metabase-metabase-claude-skills-docs-review-skill-md',
  'admin:HAIKU_SKILL_1764289228_76927'
);
