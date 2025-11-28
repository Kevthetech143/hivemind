INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'GitHub Code Review Skill - Comprehensive code review with AI-powered swarm coordination for pull requests',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Initialize Multi-Agent Code Review",
      "cli": {
        "macos": "PR_DATA=$(gh pr view 123 --json files,additions,deletions,title,body) && PR_DIFF=$(gh pr diff 123) && npx ruv-swarm github review-init --pr 123 --pr-data \"$PR_DATA\" --diff \"$PR_DIFF\" --agents \"security,performance,style,architecture\"",
        "linux": "PR_DATA=$(gh pr view 123 --json files,additions,deletions,title,body) && PR_DIFF=$(gh pr diff 123) && npx ruv-swarm github review-init --pr 123 --pr-data \"$PR_DATA\" --diff \"$PR_DIFF\" --agents \"security,performance,style,architecture\"",
        "windows": "for /f %%i in (''gh pr view 123 --json title'') do set PR_DATA=%%i && npx ruv-swarm github review-init --pr 123 --agents security,performance,style,architecture"
      },
      "manual": "1. Install: npm install ruv-swarm github-cli\n2. Get PR context with gh cli: gh pr view <PR_NUM> --json files,diff\n3. Run review-init with agents: npx ruv-swarm github review-init --pr <PR_NUM> --agents \"security,performance,style\"\n4. Agents spawn in parallel topology\n5. Reviews execute simultaneously\nChoose agents: security, performance, architecture, style, accessibility",
      "note": "Hierarchical topology recommended for large PRs (>500 lines), mesh for medium PRs, star for small PRs"
    },
    {
      "solution": "Run Specialized Security Review",
      "cli": {
        "macos": "CHANGED_FILES=$(gh pr view 123 --json files --jq ''.files[].path'') && npx ruv-swarm github review-security --pr 123 --files \"$CHANGED_FILES\" --check \"owasp,cve,secrets,permissions\" --suggest-fixes",
        "linux": "CHANGED_FILES=$(gh pr view 123 --json files --jq ''.files[].path'') && npx ruv-swarm github review-security --pr 123 --files \"$CHANGED_FILES\" --check \"owasp,cve,secrets,permissions\" --suggest-fixes",
        "windows": "for /f %%i in (''gh pr view 123 --json files'') do npx ruv-swarm github review-security --pr 123 --check owasp,cve,secrets"
      },
      "manual": "1. Extract changed files from PR\n2. Run security review: npx ruv-swarm github review-security --pr <NUM>\n3. Analyzes: SQL injection, XSS, authentication, authorization, cryptography, dependencies, secrets\n4. For critical issues: gh pr review <NUM> --request-changes\n5. For non-critical: gh pr comment <NUM> --body \"<results>\"\n6. Add labels: gh pr edit <NUM> --add-label security-review-required",
      "note": "Blocks PR merge on critical security issues. Always suggest alternatives and add security references"
    },
    {
      "solution": "Analyze Performance Impact",
      "cli": {
        "macos": "npx ruv-swarm github review-performance --pr 123 --profile \"cpu,memory,io\" --benchmark-against main --suggest-optimizations",
        "linux": "npx ruv-swarm github review-performance --pr 123 --profile \"cpu,memory,io\" --benchmark-against main --suggest-optimizations",
        "windows": "npx ruv-swarm github review-performance --pr 123 --profile cpu,memory,io --benchmark-against main"
      },
      "manual": "1. Run performance agent: npx ruv-swarm github review-performance --pr <NUM>\n2. Analyzes: Big O complexity, database queries, memory patterns, cache usage, network optimization\n3. Compare against main branch baseline\n4. Run load tests if applicable\n5. Detect memory leaks\n6. Identify bottlenecks\n7. Post findings with optimization suggestions",
      "note": "Performance regressions >5% should be warned. Show benchmarks comparing PR vs baseline"
    },
    {
      "solution": "Review Architecture and Design",
      "cli": {
        "macos": "npx ruv-swarm github review-architecture --pr 123 --check \"patterns,coupling,cohesion,solid\" --visualize-impact --suggest-refactoring",
        "linux": "npx ruv-swarm github review-architecture --pr 123 --check \"patterns,coupling,cohesion,solid\" --visualize-impact --suggest-refactoring",
        "windows": "npx ruv-swarm github review-architecture --pr 123 --check patterns,coupling,cohesion,solid"
      },
      "manual": "1. Run architecture agent: npx ruv-swarm github review-architecture --pr <NUM>\n2. Checks: Design patterns, SOLID principles, DRY violations, separation of concerns, dependency injection\n3. Analyzes coupling and cohesion metrics\n4. Identifies layer violations and circular dependencies\n5. Suggest refactoring opportunities\n6. Visualize architecture impact",
      "note": "Flag high cyclomatic complexity (>10) and tight coupling (>5 dependencies)"
    },
    {
      "solution": "Enforce Code Style and Standards",
      "cli": {
        "macos": "npx ruv-swarm github review-style --pr 123 --check \"formatting,naming,docs,tests\" --auto-fix \"formatting,imports,whitespace\"",
        "linux": "npx ruv-swarm github review-style --pr 123 --check \"formatting,naming,docs,tests\" --auto-fix \"formatting,imports,whitespace\"",
        "windows": "npx ruv-swarm github review-style --pr 123 --check formatting,naming,docs,tests --auto-fix formatting,imports"
      },
      "manual": "1. Run style agent: npx ruv-swarm github review-style --pr <NUM>\n2. Checks: Code formatting, naming conventions, documentation, comments, test coverage, error handling, logging\n3. Auto-fix: Formatting, import organization, whitespace\n4. Suggest improvements for manual fixes\n5. Verify test coverage meets threshold\n6. Check documentation completeness",
      "note": "Auto-fix formatting and imports. Manual review for naming convention violations"
    },
    {
      "solution": "Post Review Results and Manage PR Status",
      "cli": {
        "macos": "REVIEW_OUTPUT=$(npx ruv-swarm github review-all --pr 123 --agents \"security,performance,style,architecture\") && echo \"$REVIEW_OUTPUT\" | gh pr review 123 --comment -F - && gh pr comment 123 --body \"Review complete: $(echo $REVIEW_OUTPUT | jq -r .summary)\"",
        "linux": "REVIEW_OUTPUT=$(npx ruv-swarm github review-all --pr 123 --agents \"security,performance,style,architecture\") && echo \"$REVIEW_OUTPUT\" | gh pr review 123 --comment -F - && if echo \"$REVIEW_OUTPUT\" | grep -q approved; then gh pr review 123 --approve; fi",
        "windows": "npx ruv-swarm github review-all --pr 123 --agents security,performance,style > review.txt && gh pr comment 123 --body-file review.txt"
      },
      "manual": "1. Run complete review: npx ruv-swarm github review-all --pr <NUM>\n2. Post inline comments using gh api for specific files/lines\n3. Post summary comment: gh pr comment <NUM> --body \"<summary>\"\n4. Approve if all checks pass: gh pr review <NUM> --approve\n5. Request changes if issues found: gh pr review <NUM> --request-changes\n6. Add labels based on results: gh pr edit <NUM> --add-label security-review\n7. Track completion status in PR",
      "note": "Always post actionable feedback. Use constructive tone. Include code examples and references to best practices"
    }
  ]'::jsonb,
  'script',
  'GitHub CLI (gh) installed and authenticated, ruv-swarm package installed, repository with branch protection enabled, proper GitHub token with repo scope',
  'Posting generic comments (must be specific), not using gh api for inline review comments, ignoring critical security issues, not tracking false positives, missing performance baselines, not grouping related issues',
  'PR agents spawn and execute in parallel, security review blocks on critical issues, performance regressions detected, architectural violations flagged, style violations auto-fixed, review results posted with inline comments, PR status updated correctly',
  'Deploy specialized review agents for comprehensive AI-powered code review with security, performance, and architecture analysis',
  'https://skillsmp.com/skills/ruvnet-claude-flow-claude-skills-github-code-review-skill-md',
  'admin:HAIKU_SKILL_1764290225_40761'
);
