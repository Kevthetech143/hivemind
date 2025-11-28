INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'Linear Todo Sync',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "This skill fetches open tasks assigned to the user from the Linear API and generates a markdown todo list file in the project root. This skill should be used when the user asks about their work items,"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'error_handling: 15, clarity_structure: 15, completeness: 15',
  'Score: 95, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, problem_definition: 15, example_quality: 15',
  'https://skillsmp.com/skills/qdhenry-claude-command-suite-claude-skills-linear-todo-sync-skill-md',
  'admin:MINER_BATCH_9'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'ai-sdk-model-manager',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Manages AI SDK model configurations - updates packages, identifies missing models, adds new models with research, and updates documentation"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'completeness: 15, error_handling: 11, problem_definition: 10',
  'Score: 88, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 17, clarity_structure: 15',
  'https://skillsmp.com/skills/tambo-ai-tambo-claude-skills-ai-sdk-model-manager-skill-md',
  'admin:MINER_BATCH_9'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'Create New Skills',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Creates new Agent Skills for Claude Code following best practices and documentation. Use when the user wants to create a new skill, extend Claude''''s capabilities, or package domain expertise into a reu"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'completeness: 15, clarity_structure: 12, error_handling: 8',
  'Score: 90, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 20, problem_definition: 15',
  'https://skillsmp.com/skills/disler-claude-code-hooks-multi-agent-observability-claude-skills-meta-skill-skill-md',
  'admin:MINER_BATCH_9'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'worktree-manager-skill',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Comprehensive git worktree management. Use when the user wants to create, remove, list, or manage worktrees. Handles all worktree operations including creation, deletion, and status checking."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'completeness: 10, example_quality: 2, error_handling: 2',
  'Score: 54, Tier: TIER_2_GOOD, Strengths: problem_definition: 15, clarity_structure: 15, workflow_structure: 10',
  'https://skillsmp.com/skills/disler-claude-code-hooks-multi-agent-observability-claude-skills-worktree-manager-skill-skill-md',
  'admin:MINER_BATCH_9'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'create-worktree-skill',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Use when the user explicitly asks for a SKILL to create a worktree. If the user does not mention \"skill\" or explicitly request skill invocation, do NOT trigger this. Only use when user says things lik"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'completeness: 10, error_handling: 9, example_quality: 5',
  'Score: 67, Tier: TIER_2_GOOD, Strengths: workflow_structure: 16, problem_definition: 15, clarity_structure: 12',
  'https://skillsmp.com/skills/disler-claude-code-hooks-multi-agent-observability-claude-skills-create-worktree-skill-skill-md',
  'admin:MINER_BATCH_9'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'Video Processor',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Process video files with audio extraction, format conversion (mp4, webm), and Whisper transcription. Use when user mentions video conversion, audio extraction, transcription, mp4, webm, ffmpeg, or whi"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'completeness: 15, error_handling: 13, clarity_structure: 12',
  'Score: 95, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 20, problem_definition: 15',
  'https://skillsmp.com/skills/disler-claude-code-hooks-multi-agent-observability-claude-skills-video-processor-skill-md',
  'admin:MINER_BATCH_9'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'Playwright Browser Automation',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Complete browser automation with Playwright. Auto-detects dev servers, writes clean test scripts to /tmp. Test pages, fill forms, take screenshots, check responsive design, validate UX, test login flo"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'error_handling: 15, completeness: 15, clarity_structure: 12',
  'Score: 97, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 20, problem_definition: 15',
  'https://skillsmp.com/skills/lackeyjb-playwright-skill-skills-playwright-skill-skill-md',
  'admin:MINER_BATCH_9'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'file-tools',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Simple shell utilities for files and archives."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'workflow_structure: 0, error_handling: 0, clarity_structure: 0',
  'Score: 7, Tier: TIER_4_POOR, Strengths: completeness: 5, example_quality: 2, problem_definition: 0',
  'https://skillsmp.com/skills/trpc-group-trpc-agent-go-examples-skillrun-skills-file-tools-skill-md',
  'admin:MINER_BATCH_9'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'python-math',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Small Python utilities for math and text files."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'example_quality: 0, error_handling: 0, clarity_structure: 0',
  'Score: 10, Tier: TIER_4_POOR, Strengths: workflow_structure: 5, completeness: 5, problem_definition: 0',
  'https://skillsmp.com/skills/trpc-group-trpc-agent-go-examples-skillrun-skills-python-math-skill-md',
  'admin:MINER_BATCH_9'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'user-file-ops',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Simple operations on user-provided text files including summarization."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'clarity_structure: 2, workflow_structure: 0, error_handling: 0',
  'Score: 22, Tier: TIER_4_POOR, Strengths: problem_definition: 10, example_quality: 5, completeness: 5',
  'https://skillsmp.com/skills/trpc-group-trpc-agent-go-examples-skillrun-skills-user-file-ops-skill-md',
  'admin:MINER_BATCH_9'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'devops',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Deploy and manage cloud infrastructure on Cloudflare (Workers, R2, D1, KV, Pages, Durable Objects, Browser Rendering), Docker containers, and Google Cloud Platform (Compute Engine, GKE, Cloud Run, App"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'clarity_structure: 13, workflow_structure: 10, error_handling: 3',
  'Score: 71, Tier: TIER_2_GOOD, Strengths: problem_definition: 15, example_quality: 15, completeness: 15',
  'https://skillsmp.com/skills/mrgoonie-claudekit-skills-claude-skills-devops-skill-md',
  'admin:MINER_BATCH_9'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'Systematic Debugging',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Four-phase debugging framework that ensures root cause investigation before attempting fixes. Never jump to solutions."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'example_quality: 11, problem_definition: 10, completeness: 10',
  'Score: 81, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, error_handling: 15, clarity_structure: 15',
  'https://skillsmp.com/skills/mrgoonie-claudekit-skills-claude-skills-debugging-systematic-debugging-skill-md',
  'admin:MINER_BATCH_9'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'media-processing',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Process multimedia files with FFmpeg (video/audio encoding, conversion, streaming, filtering, hardware acceleration) and ImageMagick (image manipulation, format conversion, batch processing, effects, "}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'completeness: 15, clarity_structure: 13, error_handling: 9',
  'Score: 87, Tier: TIER_1_EXCELLENT, Strengths: example_quality: 20, problem_definition: 15, workflow_structure: 15',
  'https://skillsmp.com/skills/mrgoonie-claudekit-skills-claude-skills-media-processing-skill-md',
  'admin:MINER_BATCH_9'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'sequential-thinking',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Use when complex problems require systematic step-by-step reasoning with ability to revise thoughts, branch into alternative approaches, or dynamically adjust scope. Ideal for multi-stage analysis, de"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'completeness: 10, example_quality: 8, error_handling: 0',
  'Score: 61, Tier: TIER_2_GOOD, Strengths: workflow_structure: 16, problem_definition: 15, clarity_structure: 12',
  'https://skillsmp.com/skills/mrgoonie-claudekit-skills-claude-skills-sequential-thinking-skill-md',
  'admin:MINER_BATCH_9'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'Verification Before Completion',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Run verification commands and confirm output before claiming success"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'error_handling: 12, problem_definition: 10, completeness: 10',
  'Score: 82, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 15, clarity_structure: 15',
  'https://skillsmp.com/skills/mrgoonie-claudekit-skills-claude-skills-debugging-verification-before-completion-skill-md',
  'admin:MINER_BATCH_9'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'ai-multimodal',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Process and generate multimedia content using Google Gemini API. Capabilities include analyze audio files (transcription with timestamps, summarization, speech understanding, music/sound analysis up t"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'completeness: 15, error_handling: 13, clarity_structure: 13',
  'Score: 89, Tier: TIER_1_EXCELLENT, Strengths: example_quality: 18, problem_definition: 15, workflow_structure: 15',
  'https://skillsmp.com/skills/mrgoonie-claudekit-skills-claude-skills-ai-multimodal-skill-md',
  'admin:MINER_BATCH_9'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'repomix',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Package entire code repositories into single AI-friendly files using Repomix. Capabilities include pack codebases with customizable include/exclude patterns, generate multiple output formats (XML, Mar"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'completeness: 15, clarity_structure: 10, error_handling: 5',
  'Score: 75, Tier: TIER_1_EXCELLENT, Strengths: problem_definition: 15, workflow_structure: 15, example_quality: 15',
  'https://skillsmp.com/skills/mrgoonie-claudekit-skills-claude-skills-repomix-skill-md',
  'admin:MINER_BATCH_9'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'Inversion Exercise',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Flip core assumptions to reveal hidden constraints and alternative approaches - \"what if the opposite were true?"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'problem_definition: 10, error_handling: 8, example_quality: 2',
  'Score: 63, Tier: TIER_2_GOOD, Strengths: clarity_structure: 15, completeness: 15, workflow_structure: 13',
  'https://skillsmp.com/skills/mrgoonie-claudekit-skills-claude-skills-problem-solving-inversion-exercise-skill-md',
  'admin:MINER_BATCH_9'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'web-frameworks',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Build modern full-stack web applications with Next.js (App Router, Server Components, RSC, PPR, SSR, SSG, ISR), Turborepo (monorepo management, task pipelines, remote caching, parallel execution), and"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'clarity_structure: 13, workflow_structure: 10, error_handling: 7',
  'Score: 75, Tier: TIER_1_EXCELLENT, Strengths: problem_definition: 15, example_quality: 15, completeness: 15',
  'https://skillsmp.com/skills/mrgoonie-claudekit-skills-claude-skills-web-frameworks-skill-md',
  'admin:MINER_BATCH_9'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'ui-styling',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Create beautiful, accessible user interfaces with shadcn/ui components (built on Radix UI + Tailwind), Tailwind CSS utility-first styling, and canvas-based visual designs. Use when building user inter"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'completeness: 15, clarity_structure: 12, error_handling: 1',
  'Score: 78, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, problem_definition: 15, example_quality: 15',
  'https://skillsmp.com/skills/mrgoonie-claudekit-skills-claude-skills-ui-styling-skill-md',
  'admin:MINER_BATCH_9'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'mcp-management',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Manage Model Context Protocol (MCP) servers - discover, analyze, and execute tools/prompts/resources from configured MCP servers. Use when working with MCP integrations, need to discover available MCP"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'completeness: 15, clarity_structure: 12, error_handling: 10',
  'Score: 89, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 17, problem_definition: 15',
  'https://skillsmp.com/skills/mrgoonie-claudekit-skills-claude-skills-mcp-management-skill-md',
  'admin:MINER_BATCH_9'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'Scale Game',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Test at extremes (1000x bigger/smaller, instant/year-long) to expose fundamental truths hidden at normal scales"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'problem_definition: 10, completeness: 10, example_quality: 2',
  'Score: 67, Tier: TIER_2_GOOD, Strengths: workflow_structure: 15, error_handling: 15, clarity_structure: 15',
  'https://skillsmp.com/skills/mrgoonie-claudekit-skills-claude-skills-problem-solving-scale-game-skill-md',
  'admin:MINER_BATCH_9'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'skill-creator',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Guide for creating effective skills. This skill should be used when users want to create a new skill (or update an existing skill) that extends Claude''''s capabilities with specialized knowledge, workfl"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'completeness: 15, clarity_structure: 12, error_handling: 10',
  'Score: 89, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 17, problem_definition: 15',
  'https://skillsmp.com/skills/mrgoonie-claudekit-skills-claude-skills-skill-creator-skill-md',
  'admin:MINER_BATCH_9'
);