INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'GitHub Multi-Repository Coordination - Multi-repository synchronization, package management, and architecture coordination with AI swarm orchestration',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Initialize multi-repo swarm coordination",
      "cli": {
        "macos": "npx claude-flow skill run github-multi-repo init --repos \"org/frontend,org/backend,org/shared\" --topology hierarchical",
        "linux": "npx claude-flow skill run github-multi-repo init --repos \"org/frontend,org/backend,org/shared\" --topology hierarchical",
        "windows": "npx claude-flow skill run github-multi-repo init --repos \"org/frontend,org/backend,org/shared\" --topology hierarchical"
      },
      "note": "Initializes swarm with shared memory and eventual consistency sync strategy"
    },
    {
      "solution": "Synchronize package versions across repositories",
      "cli": {
        "macos": "npx claude-flow skill run github-multi-repo sync --packages \"claude-code-flow,ruv-swarm\" --align-versions --update-docs",
        "linux": "npx claude-flow skill run github-multi-repo sync --packages \"claude-code-flow,ruv-swarm\" --align-versions --update-docs",
        "windows": "npx claude-flow skill run github-multi-repo sync --packages \"claude-code-flow,ruv-swarm\" --align-versions --update-docs"
      },
      "note": "Analyzes dependencies, aligns versions, updates documentation across all packages"
    },
    {
      "solution": "Optimize repository architecture",
      "cli": {
        "macos": "npx claude-flow skill run github-multi-repo optimize --analyze-structure --suggest-improvements --create-templates",
        "linux": "npx claude-flow skill run github-multi-repo optimize --analyze-structure --suggest-improvements --create-templates",
        "windows": "npx claude-flow skill run github-multi-repo optimize --analyze-structure --suggest-improvements --create-templates"
      },
      "note": "Analyzes repository structures, identifies optimizations, creates standardized templates"
    },
    {
      "solution": "Update dependencies across all repositories",
      "cli": {
        "macos": "npx claude-flow skill run github-multi-repo lib-update --library \"org/shared-lib\" --version \"2.0.0\" --find-consumers --update-imports --run-tests",
        "linux": "npx claude-flow skill run github-multi-repo lib-update --library \"org/shared-lib\" --version \"2.0.0\" --find-consumers --update-imports --run-tests",
        "windows": "npx claude-flow skill run github-multi-repo lib-update --library \"org/shared-lib\" --version \"2.0.0\" --find-consumers --update-imports --run-tests"
      },
      "note": "Finds all consumers of a library, updates imports, runs integration tests, creates PRs"
    }
  ]'::jsonb,
  'script',
  'ruv-swarm@^1.0.11, gh CLI@^2.0.0 installed and authenticated, Node.js 20+, organization with multiple repositories',
  'Not analyzing dependencies before syncing, skipping integration tests after updates, initiating mesh topology for large orgs (causes latency), ignoring documentation sync, not establishing clear repository roles',
  'All repositories successfully coordinated, package versions aligned across all consumers, integration tests passing post-update, architecture improvements implemented, multi-repo operations completing successfully',
  'Coordinate multiple repositories with swarm intelligence, synchronize packages, optimize architecture, manage cross-repo dependencies',
  'https://skillsmp.com/skills/ruvnet-claude-flow-claude-skills-github-multi-repo-skill-md',
  'admin:HAIKU_SKILL_1764290210_38888'
);
