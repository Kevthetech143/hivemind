INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Workflow Orchestration Patterns - Design durable workflows with Temporal for distributed systems, sagas, and microservice coordination.',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Workflows vs Activities Separation",
      "manual": "Divide system into orchestration (workflows) and external interactions (activities). Workflows contain business logic and decisions but MUST be deterministic (same inputs always produce same outputs). Activities handle API calls, database writes, and all non-deterministic operations. Activities MUST be idempotent (calling N times = calling once). Never call external systems directly from workflows."
    },
    {
      "solution": "Saga Pattern with Compensation",
      "manual": "Implement distributed transactions where each step registers compensation BEFORE executing. For payment workflow: reserve inventory (compensate: release), charge payment (compensate: refund), fulfill order (compensate: cancel). Run compensations in reverse (LIFO) on failure. Ensure all compensations are idempotent and can be retried safely."
    },
    {
      "solution": "Entity Workflows (Actor Model)",
      "manual": "Create long-lived workflows representing single entity instances (shopping cart, bank account, inventory). Workflow persists for entity lifetime, receives signals for state changes, supports queries for current state. Encapsulates entity behavior with guaranteed consistency. Natural event sourcing model."
    },
    {
      "solution": "Fan-Out/Fan-In Parallelization",
      "manual": "Spawn multiple child workflows or activities in parallel, wait for all completion, aggregate results. For scaling: don''t scale individual workflows; instead spawn 1K child workflows × 1K tasks each. Handle partial failures gracefully. Aggregate results from all parallel branches."
    },
    {
      "solution": "Async Callback Pattern",
      "manual": "Workflow sends request then waits for signal to resume. External system processes asynchronously and signals response back. Use cases: human approvals, webhook callbacks, long-running processes. Enables long-lived workflows waiting for external events without consuming resources."
    },
    {
      "solution": "Determinism & State Management",
      "manual": "Workflows execute as state machines with automatic state preservation via event history. Prohibited in workflows: threading, random(), datetime.now(), global state, direct file/network I/O. Use workflow.now() for deterministic time, workflow.random() for deterministic randomness. Implement versioning with workflow.get_version() for safe code changes during execution."
    },
    {
      "solution": "Resilience & Error Handling",
      "manual": "Configure retry policies with initial interval, exponential backoff, max interval, and max attempts. Mark non-retryable errors (validation, business rule violations). Implement activity heartbeats for long-running tasks (detect stalls, enable progress-based retry). Activities may execute multiple times due to network failures—ensure true idempotency."
    }
  ]'::jsonb,
  'steps',
  'Distributed systems knowledge, understanding of state management, familiarity with async patterns, experience with at least one orchestration framework',
  'Mixing orchestration and activity logic; using datetime.now() in workflows (non-deterministic); not making activities idempotent; skipping heartbeats for long tasks; insufficient retry configuration; not handling compensation failures; calling external APIs directly from workflows; ignoring payload size limits (2MB)',
  'Workflows execute deterministically across failures and crashes; activities retry safely; compensation logic runs on failure in reverse order; state persists automatically across infrastructure failures; long-running workflows survive years of uptime; signals resume waiting workflows; queries return consistent state',
  'Design reliable distributed transactions and long-running processes with Temporal using saga patterns, entity workflows, and deterministic orchestration.',
  'https://skillsmp.com/skills/wshobson-agents-plugins-backend-development-skills-workflow-orchestration-patterns-skill-md',
  'admin:HAIKU_SKILL_1764289820_8406'
);
