INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'at-dispatch-v2',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Convert PyTorch AT_DISPATCH macros to AT_DISPATCH_V2 format in ATen C++ code. Use when porting AT_DISPATCH_ALL_TYPES_AND*, AT_DISPATCH_FLOATING_TYPES*, or other dispatch macros to the new v2 API. For "}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'clarity_structure: 15, completeness: 10, error_handling: 8',
  'Score: 85, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 17, problem_definition: 15',
  'https://skillsmp.com/skills/pytorch-pytorch-claude-skills-at-dispatch-v2-skill-md',
  'admin:MINER_BATCH_1'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'add-uint-support',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Add unsigned integer (uint) type support to PyTorch operators by updating AT_DISPATCH macros. Use when adding support for uint16, uint32, uint64 types to operators, kernels, or when user mentions enab"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'clarity_structure: 12, completeness: 10, error_handling: 7',
  'Score: 81, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 17, problem_definition: 15',
  'https://skillsmp.com/skills/pytorch-pytorch-claude-skills-add-uint-support-skill-md',
  'admin:MINER_BATCH_1'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'skill-writer',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Guide users through creating Agent Skills for Claude Code. Use when the user wants to create, write, author, or design a new Skill, or needs help with SKILL.md files, frontmatter, or skill structure."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'clarity_structure: 15, completeness: 15, error_handling: 10',
  'Score: 95, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 20, problem_definition: 15',
  'https://skillsmp.com/skills/pytorch-pytorch-claude-skills-skill-writer-skill-md',
  'admin:MINER_BATCH_1'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'docstring',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Write docstrings for PyTorch functions and methods following PyTorch conventions. Use when writing or updating docstrings in PyTorch code."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'clarity_structure: 12, workflow_structure: 10, error_handling: 6',
  'Score: 78, Tier: TIER_1_EXCELLENT, Strengths: example_quality: 20, problem_definition: 15, completeness: 15',
  'https://skillsmp.com/skills/pytorch-pytorch-claude-skills-docstring-skill-md',
  'admin:MINER_BATCH_1'
);