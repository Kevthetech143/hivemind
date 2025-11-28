INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Hooks Automation - Automated coordination and learning from Claude Code operations using intelligent hooks with MCP integration',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Initialize Hooks System",
      "cli": {
        "macos": "npm install -g claude-flow@alpha && npx claude-flow init --hooks",
        "linux": "npm install -g claude-flow@alpha && npx claude-flow init --hooks",
        "windows": "npm install -g claude-flow@alpha && npx claude-flow init --hooks"
      },
      "manual": "1. Install Claude Flow: npm install -g claude-flow@alpha\n2. Run initialization: npx claude-flow init --hooks\n3. Creates .claude/settings.json with pre-configured hooks\n4. Creates hook command documentation in .claude/commands/hooks/\n5. Edit .claude/settings.json to customize hooks",
      "note": "Hooks require Claude Code with hooks enabled and .claude/settings.json configuration"
    },
    {
      "solution": "Configure Pre-Operation Hooks",
      "cli": {
        "macos": "npx claude-flow hook pre-edit --file src/auth.js --auto-assign-agent --validate-syntax",
        "linux": "npx claude-flow hook pre-edit --file src/auth.js --auto-assign-agent --validate-syntax",
        "windows": "npx claude-flow hook pre-edit --file src/auth.js --auto-assign-agent --validate-syntax"
      },
      "manual": "Pre-operation hooks validate and prepare:\n- pre-edit: Validate syntax, assign agents, check conflicts, backup files\n- pre-bash: Check command safety, estimate resources\n- pre-task: Auto-spawn agents, load memory, optimize topology\n- pre-search: Check cache, optimize query\nAdd to .claude/settings.json PreToolUse section",
      "note": "Pre-hooks run before tool execution. Use continueOnError: true to proceed despite hook failure"
    },
    {
      "solution": "Configure Post-Operation Hooks",
      "cli": {
        "macos": "npx claude-flow hook post-edit --file src/auth.js --memory-key auth/login --auto-format --train-patterns",
        "linux": "npx claude-flow hook post-edit --file src/auth.js --memory-key auth/login --auto-format --train-patterns",
        "windows": "npx claude-flow hook post-edit --file src/auth.js --memory-key auth/login --auto-format --train-patterns"
      },
      "manual": "Post-operation hooks process and learn:\n- post-edit: Format code, validate output, store in memory, train patterns\n- post-bash: Log output, update metrics, store results\n- post-task: Performance analysis, decision storage, metrics export\n- post-search: Cache results, improve patterns\nAdd to .claude/settings.json PostToolUse section. Use async: true for non-blocking",
      "note": "Post-hooks enable continuous learning and neural pattern training"
    },
    {
      "solution": "Manage Session State with Hooks",
      "cli": {
        "macos": "npx claude-flow hook session-start --session-id dev-session --load-context && npx claude-flow hook session-end --session-id dev-session --export-metrics --generate-summary",
        "linux": "npx claude-flow hook session-start --session-id dev-session --load-context && npx claude-flow hook session-end --session-id dev-session --export-metrics --generate-summary",
        "windows": "npx claude-flow hook session-start --session-id dev-session --load-context && npx claude-flow hook session-end --session-id dev-session --export-metrics --generate-summary"
      },
      "manual": "Session hooks manage context and metrics:\n- session-start: Initialize session, create directory, load previous context\n- session-restore: Load previous session state and memory\n- session-end: Save state, export metrics, generate summary, cleanup\nDefine in .claude/settings.json SessionStart/SessionEnd sections",
      "note": "Session hooks persist work context across multiple sessions. Always call session-end to save progress"
    },
    {
      "solution": "Coordinate Multiple Agents with Memory",
      "cli": {
        "macos": "npx claude-flow hook pre-task --description Build REST API --auto-spawn-agents --load-memory && npx claude-flow hook notify --message API complete --broadcast --swarm-status",
        "linux": "npx claude-flow hook pre-task --description Build REST API --auto-spawn-agents --load-memory && npx claude-flow hook notify --message API complete --broadcast --swarm-status",
        "windows": "npx claude-flow hook pre-task --description Build REST API --auto-spawn-agents --load-memory && npx claude-flow hook notify --message API complete --broadcast --swarm-status"
      },
      "manual": "Agent coordination via hooks:\n1. Pre-task spawns agents and loads context memory\n2. Each agent runs post-edit hooks storing work to swarm/[role]/[task] key\n3. Agents access shared memory via session-restore\n4. Use notify with --broadcast to alert all agents\n5. Post-task exports collective decisions and learnings\nFollows 3-phase memory protocol: STATUS PROGRESS COMPLETE",
      "note": "Memory keys use pattern: swarm/[agent-role]/[task-name] for cross-agent coordination"
    },
    {
      "solution": "Integrate with Git Workflows",
      "cli": {
        "macos": "cat > .git/hooks/pre-commit << HOOK && chmod +x .git/hooks/pre-commit",
        "linux": "cat > .git/hooks/pre-commit << HOOK && chmod +x .git/hooks/pre-commit",
        "windows": "powershell -Command mkdir -Force .git\\hooks"
      },
      "manual": "Git integration:\n1. Create .git/hooks/pre-commit for quality checks\n2. Validate syntax and format before commit\n3. Run tests on staged files\n4. Create pre-push hook for additional quality gates\n5. Use post-commit hook to track metrics\nHooks prevent committing broken code and maintain quality standards",
      "note": "Use husky for cross-platform git hooks: npm install husky && npx husky install"
    }
  ]'::jsonb,
  'script',
  'Claude Flow CLI installed (npm install -g claude-flow@alpha), Claude Code with hooks enabled, Node.js 14+, .claude/settings.json configured',
  'Not enabling async for long-running hooks (blocks operation), missing continueOnError flag (stops on hook failure), not using memory coordination (agents cannot share context), ignoring session-end (progress lost)',
  'Hooks execute before/after tool calls, pre-edit auto-assigns agents, post-edit formats and trains patterns, session state persists across restarts, agents share memory via coordination namespace, neural patterns improve with each operation',
  'Automate development workflows with intelligent hooks, agent coordination, and neural pattern learning',
  'https://skillsmp.com/skills/ruvnet-claude-flow-claude-skills-hooks-automation-skill-md',
  'admin:HAIKU_SKILL_1764290225_40761'
);
