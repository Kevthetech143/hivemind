INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'IdeaVim Doc Sync - Keep documentation synchronized with code changes',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Establish Ground Truth from Working Code",
      "cli": {
        "macos": "grep -r ''@VimPlugin\\|@Plugin\\|class.*Extension'' --include=\"*.kt\" | head -5",
        "linux": "grep -r ''@VimPlugin\\|@Plugin\\|class.*Extension'' --include=\"*.kt\" | head -5",
        "windows": "findstr /R \"@VimPlugin @Plugin\" **.kt"
      },
      "manual": "FIRST STEP: Find working implementations in codebase. Search for @VimPlugin, real examples, and working patterns. Read at least 1-2 real implementations to understand correct patterns. This is your ground truth.",
      "note": "Working implementation in codebase is highest truth source"
    },
    {
      "solution": "Check Recent Breaking Changes",
      "cli": {
        "macos": "git log --oneline -10 -- ''**/[ChangedFile]*'' && git log --grep=\"remove\\|deprecate\" --oneline -10",
        "linux": "git log --oneline -10 -- ''**/[ChangedFile]*'' && git log --grep=\"remove\\|deprecate\" --oneline -10",
        "windows": "git log --oneline -10 -- **.kt"
      },
      "manual": "Check recent commits for removals and deprecations. Run git show on removal commits to see what was deleted. Deletions matter more than additions for documentation updates.",
      "note": "Removed functions will break documentation examples"
    },
    {
      "solution": "Extract Code Examples from Documentation",
      "cli": {
        "macos": "grep -E ''\\\\w+\\\\s*=|fun \\\\w+\\\\(|nmap\\\\('' doc/*.md -B1 -A3",
        "linux": "grep -E ''\\\\w+\\\\s*=|fun \\\\w+\\\\(|nmap\\\\('' doc/*.md -B1 -A3",
        "windows": "findstr /R \"fun nmap vmap map\" doc\\*.md"
      },
      "manual": "Find all code examples and function signatures in documentation. Extract every function call and parameter. Compare signatures and patterns against current API and working implementations.",
      "note": "Every parameter name in docs must exist in actual API"
    },
    {
      "solution": "Verify Code Examples Match Current API",
      "cli": {},
      "manual": "For EACH code block in documentation: verify function signatures exist in current API, check parameter names match exactly, compare pattern against working implementation. If different from working code, documentation is WRONG.",
      "note": "Default to updating when in doubt about code examples"
    },
    {
      "solution": "Update Documentation When Necessary",
      "cli": {},
      "manual": "Update when: API signatures changed (parameters added/removed/renamed), function/class names renamed, behavior fundamentally changed, features removed/added, file paths incorrect, code examples no longer work. Do NOT update for minor wording improvements or internal implementation changes.",
      "note": "Be aggressive finding issues, conservative making fixes"
    },
    {
      "solution": "Generate Sync Report",
      "cli": {},
      "manual": "List files checked, describe discrepancies found with severity levels (Critical/Minor), note updates made, include observations about what needs human review.",
      "note": "Clear reporting helps track documentation accuracy"
    }
  ]'::jsonb,
  'script',
  'IdeaVim repository, git access for history checking, documentation files in doc/ folder and README.md',
  'Assuming documentation is always correct; Not checking working implementations; Ignoring git history of deletions; Updating docs for minor wording improvements; Missing parameter name mismatches',
  'All code examples match current API; Every function signature is accurate; All parameters in examples exist in code; Documentation reflects actual working patterns',
  'Keep IdeaVim documentation synchronized: verify docs against code changes, update examples, check API signatures and parameters',
  'https://skillsmp.com/skills/jetbrains-ideavim-claude-skills-doc-sync-skill-md',
  'admin:HAIKU_SKILL_1764290165_33917'
);
