INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Bash Defensive Patterns - Write production-grade shell scripts with error handling and safety',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Enable strict mode to catch errors early",
      "cli": {
        "macos": "echo \"#!/bin/bash\" > script.sh && echo \"set -Eeuo pipefail\" >> script.sh",
        "linux": "echo \"#!/bin/bash\" > script.sh && echo \"set -Eeuo pipefail\" >> script.sh",
        "windows": "echo #!/bin/bash > script.sh && echo set -Eeuo pipefail >> script.sh"
      },
      "manual": "Add set -Eeuo pipefail at start of every script. Flags: -E (inherit ERR trap), -e (exit on error), -u (exit on undefined vars), -o pipefail (fail if any pipe command fails)",
      "note": "Always use strict mode. It prevents silent failures and catches bugs early"
    },
    {
      "solution": "Implement error trapping and cleanup handlers",
      "cli": {
        "macos": "trap ''cleanup_code_here'' EXIT; trap ''handle_error_here'' ERR",
        "linux": "trap ''cleanup_code_here'' EXIT; trap ''handle_error_here'' ERR",
        "windows": "trap ''cleanup_code_here'' EXIT; trap ''handle_error_here'' ERR"
      },
      "manual": "Use trap ERR to catch errors with line numbers. Use trap EXIT for guaranteed cleanup. Assign TMPDIR=$(mktemp -d) and clean it: trap ''rm -rf $TMPDIR'' EXIT. Always use explicit cleanup for file handles and temp files.",
      "note": "EXIT trap runs even if script exits with error. ERR trap gives you $LINENO for debugging"
    },
    {
      "solution": "Quote all variables and use safe conditional syntax",
      "cli": {
        "macos": "cp \"$source\" \"$dest\"; [[ -f \"$file\" ]]",
        "linux": "cp \"$source\" \"$dest\"; [[ -f \"$file\" ]]",
        "windows": "cp \"$source\" \"$dest\"; [[ -f \"$file\" ]]"
      },
      "manual": "Always quote variables: cp \"$source\" \"$dest\". Use [[ ]] for conditionals with && and ||. Test variable existence: [[ -z \"${VAR:-}\" ]]. Use -r for readable, -w for writable, -x for executable checks.",
      "note": "Unquoted variables cause word splitting and globbing. [[ ]] is bash-specific but safer than [ ]"
    },
    {
      "solution": "Handle arrays and command substitution safely",
      "cli": {
        "macos": "mapfile -t lines < <(command); for item in \"${array[@]}\"; do echo \"$item\"; done",
        "linux": "mapfile -t lines < <(command); for item in \"${array[@]}\"; do echo \"$item\"; done",
        "windows": "mapfile -t lines < <(command); for item in \"${array[@]}\"; do echo \"$item\"; done"
      },
      "manual": "Use mapfile/readarray for reading into arrays. Use $() instead of backticks. Iterate safely with for item in \"${array[@]}\". Use -d for NUL-safe iteration: while IFS= read -r -d '''' file",
      "note": "Backticks nest poorly. Process substitution < <(cmd) is safer than pipes. NUL-safe handling for filenames with spaces"
    },
    {
      "solution": "Implement robust argument parsing and validation",
      "cli": {
        "macos": "while [[ $# -gt 0 ]]; do case \"$1\" in --option) VAR=\"$2\"; shift 2;; esac; done",
        "linux": "while [[ $# -gt 0 ]]; do case \"$1\" in --option) VAR=\"$2\"; shift 2;; esac; done",
        "windows": "while [[ $# -gt 0 ]]; do case \"$1\" in --option) VAR=\"$2\"; shift 2;; esac; done"
      },
      "manual": "Use case statement for argument parsing with -- handling. Define usage() function. Validate required arguments before proceeding. Check command availability: command -v node || return 1. Check file/directory existence before operations.",
      "note": "Check dependencies early with check_dependencies(). Use default values: OUTPUT_FILE=\"${OUTPUT_FILE:-default.txt}\". Always show usage on -h/--help"
    },
    {
      "solution": "Add structured logging with timestamps and levels",
      "cli": {
        "macos": "log_info() { echo \"[$(date +%Y-%m-%d)T$(date +%H-%M-%S)] INFO: $*\" >&2; }",
        "linux": "log_info() { echo \"[$(date +%Y-%m-%d)T$(date +%H-%M-%S)] INFO: $*\" >&2; }",
        "windows": "log_info() { echo \"[$(date +%Y-%m-%d)T$(date +%H-%M-%S)] INFO: $*\" >&2; }"
      },
      "manual": "Create log_info(), log_warn(), log_error(), log_debug() functions. Output to stderr (>&2) so stdout stays clean. Include timestamps with date command. Support DEBUG env var for debug logs.",
      "note": "Structured logging aids debugging and monitoring. Timestamps help trace execution flow. Separate stdout/stderr allows piping clean output"
    },
    {
      "solution": "Support dry-run mode for safe testing",
      "cli": {
        "macos": "DRY_RUN=true ./script.sh; run_cmd() { [[ \"$DRY_RUN\" == true ]] && echo \"[DRY] $*\" || \"$@\"; }",
        "linux": "DRY_RUN=true ./script.sh; run_cmd() { [[ \"$DRY_RUN\" == true ]] && echo \"[DRY] $*\" || \"$@\"; }",
        "windows": "set DRY_RUN=true && script.sh"
      },
      "manual": "Create run_cmd() function that checks DRY_RUN variable. If true, print command instead of executing. Allows users to preview changes before running live. Document this in usage()",
      "note": "Always support dry-run for scripts that modify files/systems. Helps users understand what script will do"
    },
    {
      "solution": "Design scripts for idempotency and safe file operations",
      "cli": {
        "macos": "tmpfile=$(mktemp); atomic_write() { cat > \"$tmpfile\" && mv \"$tmpfile\" \"$1\"; }",
        "linux": "tmpfile=$(mktemp); atomic_write() { cat > \"$tmpfile\" && mv \"$tmpfile\" \"$1\"; }",
        "windows": "tmpfile=$(mktemp); atomic_write() { cat > \"$tmpfile\" && mv \"$tmpfile\" \"$1\"; }"
      },
      "manual": "Check if resource exists before creating (ensure_* functions). Use atomic writes: write to temp file, then mv to target. Use safe_move() to prevent overwriting. Create directories with mkdir -p. Test file existence and permissions before operations.",
      "note": "Idempotent scripts are safe to rerun. Atomic operations prevent partial writes. Always use mktemp for temporary files, clean with trap EXIT"
    }
  ]'::jsonb,
  'script',
  'Bash 4.0+, Unix/Linux shell environment, file permissions knowledge',
  'Omitting set -Eeuo pipefail, unquoted variables (word splitting), using [ ] instead of [[ ]], backticks instead of $(), not trapping errors, shared temp files, not checking dependencies, ignoring exit codes',
  'Script completes without errors, cleanup handler removes temp files, error messages show line numbers, script safe to rerun multiple times, dry-run mode works correctly',
  'Defensive Bash programming with strict mode, error handling, safe variable quoting, and production-ready patterns',
  'https://skillsmp.com/skills/wshobson-agents-plugins-shell-scripting-skills-bash-defensive-patterns-skill-md',
  'admin:HAIKU_SKILL_1764289744_99578'
);
