INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Confidence Check - Pre-implementation confidence assessment (>=90% required)',
  'claude-code',
  'skill',
  '[{"solution": "Run 5 confidence checks before implementation", "manual": "1. No duplicate implementations: Search codebase with Grep/Glob. 2. Architecture compliance: Verify tech stack alignment (Supabase, UV, pytest). 3. Official docs verified: Use MCP or WebFetch to review docs. 4. OSS implementations: Find proven GitHub examples. 5. Root cause identified: Analyze errors and understand core problem. Score each 25%, 25%, 20%, 15%, 15%", "note": "Requires >=90% confidence to proceed. 70-89% confidence means continue investigation without implementing. <70% means STOP and request more context"}, {"solution": "Calculate confidence score", "manual": "Total = Check1 (25%) + Check2 (25%) + Check3 (20%) + Check4 (15%) + Check5 (15%). If Total >= 0.90 proceed with implementation. If Total >= 0.70 present alternatives and ask questions. If Total < 0.70 request more context and continue investigation."}, {"solution": "Display confidence checks output", "manual": "Format: [emoji] Check description. Green checkmark for passing checks. Red X for failing checks. Show confidence percentage at bottom with recommendation"}, {"solution": "Avoid wrong-direction work", "manual": "Token savings: Spend 100-200 tokens on confidence check to save 5,000-50,000 tokens on wrong-direction execution. Test-verified: 100% precision and recall (8/8 test cases passed, 2025-10-21)"}]'::jsonb,
  'steps',
  'Read, Grep, Glob tools available; WebFetch and WebSearch for documentation and OSS references; project context (CLAUDE.md, PLANNING.md)',
  'Proceeding with implementation without >=90% confidence; assuming architecture without verification; skipping official docs review; guessing at root cause without analysis; not searching for duplicate implementations',
  'Confidence score displayed as percentage; clear pass/fail on each of 5 checks; recommendation output matches score threshold (>=0.90=proceed, >=0.70=question, <0.70=stop)',
  'Pre-implementation confidence assessment preventing wrong-direction execution with 5-check framework',
  'https://skillsmp.com/skills/superclaude-org-superclaude-framework-claude-skills-confidence-check-skill-md',
  'admin:HAIKU_SKILL_1764289895_16090'
);
