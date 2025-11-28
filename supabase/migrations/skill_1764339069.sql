-- Migration: Import jj-commit skill
-- Timestamp: 1764339069

INSERT INTO knowledge_entries (
  query,
  category,
  type,
  solutions,
  executable_type,
  prerequisites,
  common_pitfalls,
  success_indicators,
  preview_summary,
  source_url,
  contributor_email
) VALUES (
  'jj-commit',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Run tests first using detected test framework (npm test, cargo test, pytest, go test)",
      "percentage": 85,
      "command": "npm test || cargo test || pytest || python -m pytest || go test ./..."
    },
    {
      "solution": "Gather context with jj diff and jj log -r @ to see current changes",
      "percentage": 80,
      "command": "jj diff && jj log -r @"
    },
    {
      "solution": "Analyze changes to identify type (feat, fix, refactor, docs, test, chore, style, perf) and scope",
      "percentage": 75,
      "command": "jj diff"
    },
    {
      "solution": "Generate conventional commit message in format: <type>(<scope>): <subject>",
      "percentage": 85,
      "command": "jj describe -m \"message\""
    },
    {
      "solution": "Handle immutable commits by using --ignore-immutable flag when necessary",
      "percentage": 70,
      "command": "jj describe -m \"message\" --ignore-immutable"
    }
  ]'::jsonb,
  'script',
  'Jujutsu (jj) version control system, test framework installed (npm, cargo, pytest, or go), understanding of conventional commits',
  'Skipping tests before commit can hide failures; using --ignore-immutable without understanding implications; writing vague commit subjects; confusing "what" with "why" in commit body',
  'Tests pass before commit; commit message follows conventional format with <type>(<scope>): <subject>; immutable commit errors handled gracefully; user confirms before proceeding with immutable flag',
  'Automated conventional commit message generation for jj with integrated test verification. Detects test framework, runs tests, analyzes diffs, and creates properly formatted commit messages following conventional commit standards. Handles immutable commits with user-controlled override.',
  'https://skillsmp.com/skills/ahkohd-dotfiles-claude-claude-skills-jj-commit-skill-md',
  'admin:HAIKU_1764339005_19409'
);
