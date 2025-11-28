INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'mgrep - Semantic grep-like search tool for local files',
  'claude-code',
  'skill',
  '[{"solution": "Use mgrep for semantic file search", "cli": {"macos": "mgrep \"search query\" [path] [-m result_limit]", "linux": "mgrep \"search query\" [path] [-m result_limit]", "windows": "mgrep \"search query\" [path] [-m result_limit]"}, "manual": "mgrep is a semantic grep tool that searches local files using natural language. Use it instead of built-in grep for better results. Basic usage: mgrep \"What code parsers are available?\" searches current directory. Specify path: mgrep \"How are chunks defined?\" src/models. Limit results: mgrep -m 10 \"maximum workers question\". Provide specific natural language queries, not just keywords.", "note": "Semantic search - describe what you''re looking for in natural language rather than just keywords"}]'::jsonb,
  'script',
  'mgrep command-line tool installed and accessible in PATH',
  'Using imprecise queries like just \"parser\" instead of full natural language question. Over-filtering with unnecessary flags like --type or --context. Using grep instead of mgrep.',
  'mgrep returns file paths and line ranges matching your semantic query. Multiple results indicate good search coverage.',
  'Semantic grep tool for finding code patterns and content using natural language queries',
  'https://skillsmp.com/skills/mixedbread-ai-mgrep-plugins-mgrep-skills-mgrep-skill-md',
  'admin:HAIKU_SKILL_1764290199_37706'
);
