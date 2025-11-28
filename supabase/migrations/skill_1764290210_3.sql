INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'GitHub Project Management - Comprehensive project management with swarm-coordinated issue tracking, project board automation, and sprint planning',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Create coordinated issue with swarm",
      "cli": {
        "macos": "gh issue create --title \"Feature: Advanced Authentication\" --body \"Implement OAuth2...\" --label \"enhancement,swarm-ready\"",
        "linux": "gh issue create --title \"Feature: Advanced Authentication\" --body \"Implement OAuth2...\" --label \"enhancement,swarm-ready\"",
        "windows": "gh issue create --title \"Feature: Advanced Authentication\" --body \"Implement OAuth2...\" --label \"enhancement,swarm-ready\""
      },
      "note": "Initialize swarm with: npx ruv-swarm github issue-init <number>"
    },
    {
      "solution": "Initialize project board with swarm sync",
      "cli": {
        "macos": "npx ruv-swarm github board-init --project-id $PROJECT_ID --sync-mode bidirectional",
        "linux": "npx ruv-swarm github board-init --project-id $PROJECT_ID --sync-mode bidirectional",
        "windows": "npx ruv-swarm github board-init --project-id $PROJECT_ID --sync-mode bidirectional"
      },
      "note": "Enables real-time bidirectional synchronization between swarm tasks and GitHub project"
    },
    {
      "solution": "Decompose issue into subtasks automatically",
      "cli": {
        "macos": "npx ruv-swarm github issue-decompose <issue-number> --max-subtasks 10 --assign-priorities",
        "linux": "npx ruv-swarm github issue-decompose <issue-number> --max-subtasks 10 --assign-priorities",
        "windows": "npx ruv-swarm github issue-decompose <issue-number> --max-subtasks 10 --assign-priorities"
      },
      "note": "Creates linked issues for major subtasks and updates parent with checklist"
    },
    {
      "solution": "Track sprint progress with analytics",
      "cli": {
        "macos": "npx ruv-swarm github board-progress --show burndown,velocity,cycle-time --time-period sprint",
        "linux": "npx ruv-swarm github board-progress --show burndown,velocity,cycle-time --time-period sprint",
        "windows": "npx ruv-swarm github board-progress --show burndown,velocity,cycle-time --time-period sprint"
      },
      "note": "Generates reports with throughput, cycle-time, and WIP metrics"
    }
  ]'::jsonb,
  'script',
  'GitHub CLI (gh) installed and authenticated, ruv-swarm or claude-flow MCP server configured, repository access permissions',
  'Not decomposing complex issues into subtasks, skipping swarm initialization for large tasks, not setting up project board sync before starting, ignoring task dependencies, not tracking WIP limits',
  'Issues created with proper labels and descriptions, swarm agents assigned and coordinated, project board cards syncing in real-time, sprint velocity metrics tracking, task completion rates improving',
  'Manage GitHub projects with swarm-coordinated issue tracking, automated project boards, and sprint planning',
  'https://skillsmp.com/skills/ruvnet-claude-flow-claude-skills-github-project-management-skill-md',
  'admin:HAIKU_SKILL_1764290210_38888'
);
