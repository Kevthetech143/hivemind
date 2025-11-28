INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'helm-chart-bump - Ensures all necessary tasks for Helm Chart version bump',
  'claude-code',
  'skill',
  '[{"solution": "Bump Helm Chart version systematically", "manual": "1. Update chart version in deploy/charts/operator/Chart.yaml\n2. Update same version change to badge in deploy/charts/operator/README.md\n3. Ensure appVersion in Chart.yaml matches image version being bumped to\n4. Run helm-docs command with args from .pre-commit-config.yaml file\n5. Do NOT run pre-commit command - only helm-docs with specific args\n6. Do NOT format files before commit - only run helm-docs and commit output\n7. Use present tense in commit message", "note": "You have access to helm-docs binary directly - do not attempt to run full pre-commit. Read the exact args from .pre-commit-config.yaml"}]'::jsonb,
  'steps',
  'Helm Chart files, helm-docs binary, .pre-commit-config.yaml present',
  'Running full pre-commit instead of just helm-docs, formatting files before commit, using wrong helm-docs args, mixing chart version and appVersion updates',
  'Chart version updated, badge updated, appVersion matches image version, helm-docs output committed',
  'Bump Helm Chart version with proper pre-commit hook integration',
  'https://skillsmp.com/skills/stacklok-toolhive-claude-skills-helm-chart-bump-skill-md',
  'admin:HAIKU_SKILL_1764290184_36261'
);
