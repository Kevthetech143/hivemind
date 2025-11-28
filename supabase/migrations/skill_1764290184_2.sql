INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'prp-core-runner - Orchestrate complete PRP workflow from feature request to pull request',
  'claude-code',
  'skill',
  '[{"solution": "Use SlashCommand tool to invoke /prp-core-run-all", "manual": "1. Use SlashCommand tool with /prp-core-run-all {feature-description}\n2. Workflow executes 5 steps: Create branch, Generate PRP, Execute implementation, Create commit, Create PR\n3. Monitor progress and handle failures by reporting which step failed\n4. Confirm completion and provide PR URL", "note": "Stop immediately if any step fails - do not proceed to subsequent steps"}]'::jsonb,
  'steps',
  'Git repository initialized, feature description ready',
  'Attempting to auto-fix validation failures, proceeding after step failures, not reporting errors clearly',
  'All 5 workflow steps execute successfully, PR URL provided',
  'Orchestrates complete PRP workflow with branch creation and PR generation',
  'https://skillsmp.com/skills/wirasm-prps-agentic-eng-claude-skills-prp-core-runner-skill-md',
  'admin:HAIKU_SKILL_1764290184_36261'
);
