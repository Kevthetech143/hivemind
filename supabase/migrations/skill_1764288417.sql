INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Hook Development - Create and implement Claude Code plugin hooks for event-driven automation with prompt-based and command validation',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Set up prompt-based hook for PreToolUse validation",
      "cli": {
        "macos": "echo ''{\"type\": \"prompt\", \"prompt\": \"Validate tool call: $TOOL_INPUT\"}''",
        "linux": "echo ''{\"type\": \"prompt\", \"prompt\": \"Validate tool call: $TOOL_INPUT\"}''",
        "windows": "powershell -Command \"Write-Output ''{\\\"type\\\": \\\"prompt\\\", \\\"prompt\\\": \\\"Validate tool call: $TOOL_INPUT\\\"}''\""
      },
      "manual": "Create hooks/hooks.json with PreToolUse event using prompt-based hook. Use matcher field with tool names (e.g., Write, Edit, Bash) and specify prompt type for LLM-driven validation. Include timeout setting (default 30s).",
      "note": "Prompt-based hooks are recommended for context-aware validation without bash scripting. Use $TOOL_INPUT variable to access tool information in prompt."
    },
    {
      "solution": "Set up command hook for deterministic bash validation",
      "cli": {
        "macos": "bash ${CLAUDE_PLUGIN_ROOT}/scripts/validate.sh",
        "linux": "bash ${CLAUDE_PLUGIN_ROOT}/scripts/validate.sh",
        "windows": "bash.exe ${CLAUDE_PLUGIN_ROOT}/scripts/validate.sh"
      },
      "manual": "Create hooks/hooks.json with command-type hook pointing to bash script. Always use ${CLAUDE_PLUGIN_ROOT} for portability. Script receives JSON input via stdin with fields like tool_name, tool_input, tool_result. Output JSON with continue/decision fields.",
      "note": "Command hooks run in parallel with other hooks. Ensure scripts are independent and do not rely on execution order. Default timeout is 60 seconds."
    },
    {
      "solution": "Implement SessionStart hook to load project context",
      "cli": {
        "macos": "bash ${CLAUDE_PLUGIN_ROOT}/scripts/load-context.sh",
        "linux": "bash ${CLAUDE_PLUGIN_ROOT}/scripts/load-context.sh",
        "windows": "bash.exe ${CLAUDE_PLUGIN_ROOT}/scripts/load-context.sh"
      },
      "manual": "Create SessionStart hook to detect project type and set environment. Script can use $CLAUDE_ENV_FILE to persist variables like PROJECT_TYPE. Example detects package.json (Node), Cargo.toml (Rust), go.mod (Go), pyproject.toml (Python), pom.xml (Maven), build.gradle (Gradle).",
      "note": "SessionStart runs when Claude Code session begins. Use to load project-specific context that persists for the session. Variables written to $CLAUDE_ENV_FILE are available throughout the session."
    },
    {
      "solution": "Set up Stop hook to validate task completion",
      "cli": {
        "macos": "echo ''{\"type\": \"prompt\", \"prompt\": \"Verify: tests run, build succeeded, user questions answered. Return approve or block.\"}''",
        "linux": "echo ''{\"type\": \"prompt\", \"prompt\": \"Verify: tests run, build succeeded, user questions answered. Return approve or block.\"}''",
        "windows": "powershell -Command \"Write-Output ''{\\\"type\\\": \\\"prompt\\\", \\\"prompt\\\": \\\"Verify task completion\\\"}''\""
      },
      "manual": "Add Stop event hook to hooks.json with matcher * (all tools). Use prompt-based hook to verify task completion before allowing agent to stop. Prompt can reference $TRANSCRIPT_PATH to read full conversation history. Return JSON with decision field (approve/block).",
      "note": "Stop hooks validate completeness. Use transcript context ($TRANSCRIPT_PATH) to check if tests ran, build succeeded, and questions were answered. Returning block with reason forces continued work."
    },
    {
      "solution": "Validate hook configuration and test before deployment",
      "cli": {
        "macos": "bash ${CLAUDE_PLUGIN_ROOT}/scripts/validate-hook-schema.sh hooks/hooks.json",
        "linux": "bash ${CLAUDE_PLUGIN_ROOT}/scripts/validate-hook-schema.sh hooks/hooks.json",
        "windows": "bash.exe ${CLAUDE_PLUGIN_ROOT}/scripts/validate-hook-schema.sh hooks/hooks.json"
      },
      "manual": "Use provided validate-hook-schema.sh to check hooks.json syntax. Run test-hook.sh to test hook scripts with sample input. Verify JSON output is valid with jq. Check for shell quoting issues and path traversal vulnerabilities.",
      "note": "Always validate configuration before deployment. Test with sample input matching actual hook events. Use jq to validate JSON output format. Check exit codes: 0=success, 2=blocking error."
    },
    {
      "solution": "Implement proper input validation and output formatting",
      "cli": {
        "macos": "cat ${CLAUDE_PLUGIN_ROOT}/examples/validate-write.sh | head -30",
        "linux": "cat ${CLAUDE_PLUGIN_ROOT}/examples/validate-write.sh | head -30",
        "windows": "Get-Content -Path \"${CLAUDE_PLUGIN_ROOT}/examples/validate-write.sh\" -TotalCount 30"
      },
      "manual": "Always validate tool_input fields in hooks. Extract file paths/commands safely using jq. Check for path traversal (..), sensitive files (.env, *secret*), and dangerous operations (rm -rf, dd, mkfs). Quote all bash variables. Return structured JSON with continue, decision, or permissionDecision fields.",
      "note": "Security is critical: validate inputs using jq, check for path traversal, deny sensitive files, quote variables. See examples/validate-write.sh and validate-bash.sh for production patterns."
    },
    {
      "solution": "Configure hook matchers and tool filtering",
      "cli": {
        "macos": "echo ''{\"matcher\": \"Write|Edit|Bash\"}''",
        "linux": "echo ''{\"matcher\": \"Write|Edit|Bash\"}''",
        "windows": "powershell -Command \"Write-Output ''{\\\"matcher\\\": \\\"Write|Edit|Bash\\\"}''\""
      },
      "manual": "Use matcher field to filter which tools trigger hooks. Exact match: Write. Multiple tools: Write|Edit|Read. All tools: *. Regex patterns: mcp__.*__delete.* (all MCP delete tools). Matchers are case-sensitive. Common patterns: mcp__ prefix for plugins, * for universal hooks.",
      "note": "Matcher patterns control hook execution. Wildcards (*) are useful for universal hooks like Stop/SessionStart. Regex patterns enable sophisticated filtering like mcp__plugin_asana_.*"
    },
    {
      "solution": "Handle hook lifecycle and session reloading",
      "cli": {
        "macos": "exit; claude",
        "linux": "exit; claude",
        "windows": "exit; claude.exe"
      },
      "manual": "Hooks load at session start and cannot be hot-swapped. Changes to hooks.json or hook scripts require restarting Claude Code. Exit the current session and run claude or cc again. Use claude --debug to verify hooks loaded and check debug logs for hook execution. Use /hooks command to review loaded hooks in current session.",
      "note": "Hook configuration is static during a session. Editing hooks.json during an active session has no effect. Always restart to test hook changes. Debug mode (--debug flag) shows hook registration and execution details."
    }
  ]'::jsonb,
  'script',
  'bash, jq, Claude Code plugin system. Examples use jq for JSON parsing. Optional: curl for external integrations, psql for database logging, nc for metrics collection.',
  'Path traversal attacks, unquoted variables in bash, hardcoded paths instead of ${CLAUDE_PLUGIN_ROOT}, trusting unvalidated tool input, unrealistic timeouts, hooks that modify global state unpredictably, logging sensitive information, not validating hook output JSON format',
  'Hooks execute as expected in session. JSON output is valid (verify with jq). Files are written/modified according to hook logic. Commands execute with proper permissions. SessionStart environment persists. Stop hook correctly validates completion. No errors in debug logs (claude --debug). Hook scripts have proper bash shebangs and execute permissions.',
  'Develop Claude Code plugin hooks using prompt-based and command-driven event handlers for validation, automation, and context loading across the development lifecycle.',
  'https://skillsmp.com/skills/anthropics-claude-code-plugins-plugin-dev-skills-hook-development-skill-md',
  'admin:HAIKU_SKILL_1764288417'
);
