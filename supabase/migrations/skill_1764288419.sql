INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Command Development - Create reusable Claude Code slash commands with YAML frontmatter, dynamic arguments, file references, and bash execution',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Create command file in correct location",
      "cli": {
        "macos": "mkdir -p .claude/commands && echo \"---\ndescription: Your command description\n---\n\nYour command prompt here\" > .claude/commands/command-name.md",
        "linux": "mkdir -p .claude/commands && echo \"---\ndescription: Your command description\n---\n\nYour command prompt here\" > .claude/commands/command-name.md",
        "windows": "mkdir .claude\\commands && echo. > .claude\\commands\\command-name.md"
      },
      "manual": "1. Navigate to .claude/commands/ directory in your project\n2. Create a new .md file with your command name (e.g., review.md)\n3. Add YAML frontmatter at the top (---) with description field\n4. Write your command prompt below the frontmatter\n5. Save the file and invoke with /command-name",
      "note": "Project commands go in .claude/commands/, personal commands in ~/.claude/commands/"
    },
    {
      "solution": "Add YAML frontmatter configuration",
      "cli": {
        "macos": "cat > .claude/commands/example.md << ''EOF''\n---\ndescription: Review code for security issues\nallowed-tools: Read, Grep, Bash(git:*)\nmodel: sonnet\nargument-hint: [file-path]\n---\n\nReview @$1 for security vulnerabilities\nEOF",
        "linux": "cat > .claude/commands/example.md << ''EOF''\n---\ndescription: Review code for security issues\nallowed-tools: Read, Grep, Bash(git:*)\nmodel: sonnet\nargument-hint: [file-path]\n---\n\nReview @$1 for security vulnerabilities\nEOF",
        "windows": "type nul > .claude\\commands\\example.md"
      },
      "manual": "Add YAML frontmatter block at the start of your .md file:\n- description: Brief description shown in /help\n- allowed-tools: Tools the command can use (Read, Write, Bash, etc.)\n- model: Specify model (sonnet, opus, haiku)\n- argument-hint: Document expected arguments [arg1] [arg2]\n- disable-model-invocation: Set true to prevent programmatic execution",
      "note": "Frontmatter is optional but recommended for configuration. Use most restrictive allowed-tools needed."
    },
    {
      "solution": "Implement dynamic arguments",
      "cli": {
        "macos": "cat > .claude/commands/deploy.md << ''EOF''\n---\ndescription: Deploy to environment\nargument-hint: [environment] [version]\n---\n\nDeploy application to $1 environment using version $2\nVerify deployment succeeded\nEOF",
        "linux": "cat > .claude/commands/deploy.md << ''EOF''\n---\ndescription: Deploy to environment\nargument-hint: [environment] [version]\n---\n\nDeploy application to $1 environment using version $2\nVerify deployment succeeded\nEOF",
        "windows": "type nul > .claude\\commands\\deploy.md"
      },
      "manual": "Use positional arguments $1, $2, $3 for individual args or $ARGUMENTS for all args as string:\n- $1 = first argument\n- $2 = second argument\n- $ARGUMENTS = all arguments combined\nReference them in your command prompt and document with argument-hint",
      "note": "Always use argument-hint to document what arguments your command expects"
    },
    {
      "solution": "Use file references with @ syntax",
      "cli": {
        "macos": "cat > .claude/commands/review-file.md << ''EOF''\n---\ndescription: Review specific file\nargument-hint: [file-path]\n---\n\nReview @$1 for:\n- Code quality\n- Best practices\n- Potential bugs\nEOF",
        "linux": "cat > .claude/commands/review-file.md << ''EOF''\n---\ndescription: Review specific file\nargument-hint: [file-path]\n---\n\nReview @$1 for:\n- Code quality\n- Best practices\n- Potential bugs\nEOF",
        "windows": "type nul > .claude\\commands\\review-file.md"
      },
      "manual": "Use @ prefix to include file contents:\n- @path/to/file = includes that file''s contents\n- @$1 = includes file at path from first argument\n- @package.json = includes static file reference\nClaude will read the file before processing your command",
      "note": "File references require Read tool to be allowed. Use relative or project-relative paths."
    },
    {
      "solution": "Execute bash commands in commands",
      "cli": {
        "macos": "cat > .claude/commands/git-status.md << ''EOF''\n---\ndescription: Show git status and recent commits\nallowed-tools: Bash(git:*)\n---\n\nCurrent status: !`git status`\nRecent commits: !`git log --oneline -5`\nEOF",
        "linux": "cat > .claude/commands/git-status.md << ''EOF''\n---\ndescription: Show git status and recent commits\nallowed-tools: Bash(git:*)\n---\n\nCurrent status: !`git status`\nRecent commits: !`git log --oneline -5`\nEOF",
        "windows": "type nul > .claude\\commands\\git-status.md"
      },
      "manual": "Use backtick syntax with exclamation mark to execute bash:\n- !`command here` = execute command and include output\n- Useful for dynamic context (git status, environment info, etc.)\n- Must have Bash tool in allowed-tools\nRestrict to specific commands using patterns like Bash(git:*)",
      "note": "Keep bash commands fast as they execute when command is invoked. Avoid long-running operations."
    },
    {
      "solution": "Organize commands with namespacing",
      "cli": {
        "macos": "mkdir -p .claude/commands/ci .claude/commands/git .claude/commands/docs\necho \"Run tests\" > .claude/commands/ci/test.md\necho \"Show git log\" > .claude/commands/git/log.md\necho \"Generate docs\" > .claude/commands/docs/generate.md",
        "linux": "mkdir -p .claude/commands/ci .claude/commands/git .claude/commands/docs\necho \"Run tests\" > .claude/commands/ci/test.md\necho \"Show git log\" > .claude/commands/git/log.md\necho \"Generate docs\" > .claude/commands/docs/generate.md",
        "windows": "mkdir .claude\\commands\\ci .claude\\commands\\git .claude\\commands\\docs"
      },
      "manual": "Create subdirectories within commands/ to organize related commands:\n- .claude/commands/ci/test.md → /test (shown as ci namespace)\n- .claude/commands/git/commit.md → /commit (shown as git namespace)\nUse this for 15+ commands with clear categories",
      "note": "Namespace appears in /help output. Helps users find related commands. Flat structure fine for <15 commands."
    },
    {
      "solution": "Use plugin-specific CLAUDE_PLUGIN_ROOT variable",
      "cli": {
        "macos": "cat > my-plugin/commands/analyze.md << ''EOF''\n---\ndescription: Analyze using plugin tools\nallowed-tools: Bash(node:*)\n---\n\nRun: !`node ${CLAUDE_PLUGIN_ROOT}/scripts/analyze.js $1`\nEOF",
        "linux": "cat > my-plugin/commands/analyze.md << ''EOF''\n---\ndescription: Analyze using plugin tools\nallowed-tools: Bash(node:*)\n---\n\nRun: !`node ${CLAUDE_PLUGIN_ROOT}/scripts/analyze.js $1`\nEOF",
        "windows": "type nul > my-plugin\\commands\\analyze.md"
      },
      "manual": "In plugin commands, use ${CLAUDE_PLUGIN_ROOT} environment variable:\n- Resolves to plugin''s absolute path\n- Enables portable script/template/config references\n- Common patterns:\n  - !`node ${CLAUDE_PLUGIN_ROOT}/scripts/analyze.js`\n  - @${CLAUDE_PLUGIN_ROOT}/config/settings.json\n  - @${CLAUDE_PLUGIN_ROOT}/templates/report.md",
      "note": "Essential for multi-file plugins. Works across all installations without hardcoded paths."
    },
    {
      "solution": "Validate command arguments",
      "cli": {
        "macos": "cat > .claude/commands/deploy-safe.md << ''EOF''\n---\ndescription: Deploy with validation\nargument-hint: [environment]\nallowed-tools: Bash(echo:*)\n---\n\nValidate: !`echo \"$1\" | grep -E \"^(dev|staging|prod)$\" || echo \"INVALID\"`\nEOF",
        "linux": "cat > .claude/commands/deploy-safe.md << ''EOF''\n---\ndescription: Deploy with validation\nargument-hint: [environment]\nallowed-tools: Bash(echo:*)\n---\n\nValidate: !`echo \"$1\" | grep -E \"^(dev|staging|prod)$\" || echo \"INVALID\"`\nEOF",
        "windows": "type nul > .claude\\commands\\deploy-safe.md"
      },
      "manual": "Add validation in your command:\n1. Check arguments before processing\n2. Verify file existence with test -f\n3. Validate format/values with grep or similar\n4. Provide helpful error messages\n5. Suggest corrective actions\nInclude validation checks early in command execution",
      "note": "Good validation prevents errors and guides users to correct usage"
    }
  ]'::jsonb,
  'steps',
  'Claude Code installation, text editor, understanding of Markdown',
  'Forgetting frontmatter syntax (---), using incorrect argument syntax ($1 vs $arguments), putting commands in wrong directory, incorrect @ file reference format, trying to use bash without allowed-tools, hardcoding paths instead of ${CLAUDE_PLUGIN_ROOT} in plugins',
  'Command appears in /help, /command-name invokes it, arguments expand correctly ($1 becomes first arg), bash execution runs and includes output, file references load file contents, plugin commands access ${CLAUDE_PLUGIN_ROOT}',
  'Create reusable slash commands for Claude Code with dynamic arguments, file references, and bash execution using Markdown files with YAML configuration',
  'https://skillsmp.com/skills/anthropics-claude-code-plugins-plugin-dev-skills-command-development-skill-md',
  'admin:HAIKU_SKILL_1764288419'
);
