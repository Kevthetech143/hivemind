# hivemind-mcp - Installation Guide

## Quick Install (Recommended)

**One command setup:**

```bash
npm install -g hivemind-mcp
claude mcp add hivemind -- npx hivemind-mcp
```

Restart Claude Code. You're done!

## Platform-Specific Setup

### Claude Code

```bash
npm install -g hivemind-mcp
claude mcp add hivemind -- npx hivemind-mcp
```

### Codex CLI (OpenAI)

```bash
npm install -g hivemind-mcp
codex mcp add hivemind -- npx -y hivemind-mcp
```

### Gemini CLI (Google)

```bash
npm install -g hivemind-mcp
gemini mcp add hivemind npx -y hivemind-mcp
```

### Cursor / Windsurf

```bash
npm install -g hivemind-mcp
# Add to MCP settings: npx hivemind-mcp
```

## Verify Installation

In your AI CLI:

```
Search hivemind for "MCP connection refused"
```

You should get instant results!

## Usage

### Search for solutions

```
Search hivemind for "[your error message]"
```

Examples:
- `Search hivemind for "MCP connection refused"`
- `Search hivemind for "Supabase RLS blocking queries"`
- `Search hivemind for "React hydration mismatch"`

### Give feedback

After trying a solution:

```
hivemind: worked
```

Or:

```
hivemind: failed
```

This helps rank solutions by what actually works!

## Troubleshooting

### MCP server not showing

```bash
# Check MCP config (Claude Code)
claude mcp list

# Verify hivemind is listed
```

### Connection errors

1. Check internet connection
2. Try: `Search hivemind for test`
3. Restart your AI CLI/editor

### Still not working?

1. Reinstall: `npm install -g hivemind-mcp@latest`
2. Restart your AI CLI
3. Open issue: https://github.com/Kevthetech143/hivemind/issues

## Architecture

```
Your AI CLI/Editor
    ↓
MCP Client (hivemind-mcp npm package)
    ↓
Supabase Edge Functions
    ↓
Postgres (full-text search, 16k+ solutions)
```

## What Data is Sent

The MCP client only sends:
- Search queries (your error messages)
- Feedback votes (worked/failed)
- Solution contributions (if you submit any)

**Never sent**: Your code, files, or conversation history.

## License

MIT - Free forever, open source

## Support

- GitHub Issues: https://github.com/Kevthetech143/hivemind/issues
- npm Package: https://www.npmjs.com/package/hivemind-mcp
