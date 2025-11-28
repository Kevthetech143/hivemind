INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'System CreateCLI - Generate CLI tools from function specifications',
  'claude-code',
  'skill',
  '[{"solution": "Define CLI function intent and arguments", "note": "Specify what the CLI tool does, required arguments, optional flags, and expected output format."}, {"solution": "Generate executable CLI script", "cli": {"macos": "createcli [intent] [args] [flags]", "linux": "createcli [intent] [args] [flags]", "windows": "createcli [intent] [args] [flags]"}, "note": "System generates shell/Python/Node script with argument parsing, error handling, and help documentation."}, {"solution": "Add CLI to PATH for global access", "note": "Copy generated script to ~/bin or ~/.local/bin and add directory to $PATH for immediate use anywhere in terminal."}]'::jsonb,
  'script',
  'CLI function description and arguments defined. Write permissions in ~/bin or ~/.local/bin directories. Basic shell/scripting knowledge recommended.',
  'Not specifying all required arguments upfront, insufficient error handling in generated script, not documenting CLI usage/examples, changing function behavior after CLI generation',
  'Generated CLI script runs without errors, all arguments are properly parsed and validated, help documentation is accurate (-h/--help works correctly), script is accessible from any directory in PATH',
  'Automated CLI generation tool that creates command-line interfaces from function specifications',
  'https://skillsmp.com/skills/danielmiessler-personal-ai-infrastructure-claude-skills-system-createcli-skill-md',
  'admin:HAIKU_SKILL_1764290427_67628'
);
