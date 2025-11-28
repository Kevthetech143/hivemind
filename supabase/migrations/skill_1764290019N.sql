INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Confidence Check Plugin - Pre-implementation confidence assessment with ConfidenceChecker class',
  'claude-code',
  'skill',
  '[{"solution": "Use ConfidenceChecker class for assessment", "cli": {"macos": "import { ConfidenceChecker } from ''./confidence''; const checker = new ConfidenceChecker();", "linux": "import { ConfidenceChecker } from ''./confidence''; const checker = new ConfidenceChecker();", "windows": "import { ConfidenceChecker } from ''./confidence''; const checker = new ConfidenceChecker();"}, "note": "Main class available in confidence.ts. Call checker.assess(context) to get confidence score (0.0-1.0)"}, {"solution": "Run 5 confidence checks", "manual": "1. No duplicate implementations (25%): Use Grep/Glob to search codebase. 2. Architecture compliance (25%): Verify tech stack from CLAUDE.md. 3. Official docs verified (20%): Check for README.md, CLAUDE.md, or docs/ directory. 4. OSS implementations (15%): Search GitHub for examples. 5. Root cause identified (15%): Analyze error messages and logs."}, {"solution": "Interpret confidence score", "manual": "Score >= 0.90: High confidence - proceed immediately. Score 0.70-0.89: Medium confidence - present options, do not implement yet. Score < 0.70: Low confidence - STOP and request clarification"}, {"solution": "Calculate token ROI", "manual": "Spend 100-200 tokens on confidence check to save 5,000-50,000 tokens on wrong-direction execution. Test verified: 100% precision and recall (8/8 test cases passed)"}]'::jsonb,
  'script',
  'TypeScript/Node.js 18+; test_file context path; markers context array; duplicate/architecture/docs/oss/root_cause context flags',
  'Implementing without >=90% confidence; not searching for duplicates; skipping architecture validation; missing official docs review; guessing root cause; not checking for existing patterns',
  'Confidence score output as percentage; clear pass/fail indicators on each 5 checks; recommendation text matches score threshold; context.confidence_checks array populated with results',
  'TypeScript plugin implementation of pre-implementation confidence assessment framework with class-based API',
  'https://skillsmp.com/skills/superclaude-org-superclaude-framework-plugins-superclaude-skills-confidence-check-skill-md',
  'admin:HAIKU_SKILL_1764289895_16090'
);
