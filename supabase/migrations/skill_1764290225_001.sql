INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Flow Nexus Swarm - Cloud-based AI swarm deployment and event-driven workflow automation',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Initialize Swarm with Topology",
      "cli": {
        "macos": "mcp__flow-nexus__swarm_init({ topology: \"hierarchical\", maxAgents: 8, strategy: \"balanced\" })",
        "linux": "mcp__flow-nexus__swarm_init({ topology: \"hierarchical\", maxAgents: 8, strategy: \"balanced\" })",
        "windows": "mcp__flow-nexus__swarm_init({ topology: \"hierarchical\", maxAgents: 8, strategy: \"balanced\" })"
      },
      "manual": "1. Register at flow-nexus.ruv.io\n2. Install Flow Nexus: npm install -g flow-nexus@latest\n3. Login: npx flow-nexus@latest login\n4. Add MCP server: claude mcp add flow-nexus\n5. Choose topology: hierarchical (tree), mesh (peer-to-peer), ring (sequential), or star (hub)\n6. Set maxAgents and strategy (balanced, specialized, adaptive)",
      "note": "Hierarchical topology best for complex projects, mesh for collaborative research"
    },
    {
      "solution": "Spawn Specialized Agents",
      "cli": {
        "macos": "mcp__flow-nexus__agent_spawn({ type: \"coder\", name: \"Backend Developer\", capabilities: [\"api_dev\", \"database\"] })",
        "linux": "mcp__flow-nexus__agent_spawn({ type: \"coder\", name: \"Backend Developer\", capabilities: [\"api_dev\", \"database\"] })",
        "windows": "mcp__flow-nexus__agent_spawn({ type: \"coder\", name: \"Backend Developer\", capabilities: [\"api_dev\", \"database\"] })"
      },
      "manual": "Agent types: researcher (web search, analysis), coder (code generation), analyst (data analysis), optimizer (performance tuning), coordinator (task delegation)\nSpawn multiple agents to build specialized team",
      "note": "Vector similarity matching automatically assigns best agent to each task"
    },
    {
      "solution": "Create Event-Driven Workflow",
      "cli": {
        "macos": "mcp__flow-nexus__workflow_create({ name: \"CI/CD Pipeline\", steps: [{id: \"test\", action: \"run_tests\", depends_on: []}], triggers: [\"push_to_main\"] })",
        "linux": "mcp__flow-nexus__workflow_create({ name: \"CI/CD Pipeline\", steps: [{id: \"test\", action: \"run_tests\", depends_on: []}], triggers: [\"push_to_main\"] })",
        "windows": "mcp__flow-nexus__workflow_create({ name: \"CI/CD Pipeline\", steps: [{id: \"test\", action: \"run_tests\", depends_on: []}], triggers: [\"push_to_main\"] })"
      },
      "manual": "Define workflow steps with dependencies, set parallel execution where applicable, define triggers (GitHub events, schedules, manual), configure retry policies and priorities",
      "note": "Use async: true for long-running workflows to queue in message queue"
    },
    {
      "solution": "Execute Workflow and Monitor",
      "cli": {
        "macos": "mcp__flow-nexus__workflow_execute({ workflow_id: \"id\", async: true })\nmcp__flow-nexus__workflow_status({ workflow_id: \"id\", include_metrics: true })",
        "linux": "mcp__flow-nexus__workflow_execute({ workflow_id: \"id\", async: true })\nmcp__flow-nexus__workflow_status({ workflow_id: \"id\", include_metrics: true })",
        "windows": "mcp__flow-nexus__workflow_execute({ workflow_id: \"id\", async: true })\nmcp__flow-nexus__workflow_status({ workflow_id: \"id\", include_metrics: true })"
      },
      "manual": "Run workflow synchronously (async: false) for immediate execution or asynchronously (async: true) for queue-based processing. Monitor with workflow_status to get progress, metrics, and audit trail",
      "note": "Check workflow_queue_status to see pending messages in pipeline"
    },
    {
      "solution": "Use Pre-built Templates",
      "cli": {
        "macos": "mcp__flow-nexus__swarm_create_from_template({ template_name: \"full-stack-dev\", overrides: {maxAgents: 6} })",
        "linux": "mcp__flow-nexus__swarm_create_from_template({ template_name: \"full-stack-dev\", overrides: {maxAgents: 6} })",
        "windows": "mcp__flow-nexus__swarm_create_from_template({ template_name: \"full-stack-dev\", overrides: {maxAgents: 6} })"
      },
      "manual": "Available templates: full-stack-dev, research-team, code-review, data-pipeline, ml-development, mobile-dev, devops-automation, security-audit, enterprise-migration, multi-repo-sync, compliance-review, incident-response",
      "note": "Templates provide pre-configured swarms and workflows for common use cases"
    }
  ]'::jsonb,
  'script',
  'Flow Nexus MCP server installed, Active Flow Nexus account, Claude Code with MCP support',
  'Confusing topology selection (star vs mesh vs hierarchical), not using async for long-running workflows, missing retry policies, not scaling based on workload',
  'Swarm initializes successfully, agents spawn and receive task assignments, workflows execute with proper dependency ordering, metrics show agent utilization, message queue processes async tasks',
  'Deploy AI agent swarms with cloud-based orchestration and event-driven workflows',
  'https://skillsmp.com/skills/ruvnet-claude-flow-claude-skills-flow-nexus-swarm-skill-md',
  'admin:HAIKU_SKILL_1764290225_40761'
);
