INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Cookbook Audit - Audit Anthropic Cookbook notebooks using style guidelines and automated validation',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Step 1: Read the style guide to understand best practices",
      "manual": "Review SKILL.md section for problem-focused introductions, prerequisites patterns, and core content structure",
      "note": "The style guide contains canonical templates and good/bad examples"
    },
    {
      "solution": "Step 2: Run automated validation checks",
      "cli": {
        "macos": "python3 validate_notebook.py /path/to/notebook.ipynb",
        "linux": "python3 validate_notebook.py /path/to/notebook.ipynb",
        "windows": "python validate_notebook.py C:\\path\\to\\notebook.ipynb"
      },
      "note": "Script automatically runs detect-secrets to scan for hardcoded API keys and generates markdown in tmp/ folder for easier review"
    },
    {
      "solution": "Step 3: Review markdown output and audit against style guide",
      "manual": "Check tmp/ folder for generated markdown, evaluate against narrative quality, code quality, technical accuracy, and actionability rubrics",
      "note": "Use the Quick Reference Checklist from SKILL.md to ensure comprehensive coverage"
    },
    {
      "solution": "Step 4: Generate audit report with scoring",
      "manual": "Present findings using the Audit Report Format: Executive Summary (Overall Score /20), Detailed Scoring by dimension (/5 each), Specific Recommendations, and Examples & Suggestions",
      "note": "Score dimensions: Narrative Quality, Code Quality, Technical Accuracy, Actionability & Understanding"
    }
  ]'::jsonb,
  'script',
  'Knowledge of Python, Jupyter notebooks, basic understanding of ML/AI concepts, access to notebook files',
  'Skipping the style guide before audit, running validation without checking detect-secrets output, not mapping findings to specific templates, providing generic feedback instead of concrete examples with line references',
  'Audit report completed with clear scoring on all 4 dimensions, specific examples from notebook with suggested improvements, successful detect-secrets check or documented secrets found',
  'Automated validation and manual review process for Anthropic Cookbook notebooks with scoring rubric',
  'https://skillsmp.com/skills/anthropics-claude-cookbooks-claude-skills-cookbook-audit-skill-md',
  'admin:HAIKU_SKILL_1764289578_83128'
);
