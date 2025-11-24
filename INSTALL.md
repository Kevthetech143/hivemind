# clauderepo - Installation Guide

## Quick Install (After npm publish)

**One command setup:**

```bash
claude mcp add clauderepo -- npx clauderepo-mcp
```

Restart Claude Code. You're done!

## Manual Setup (Development)

If you want to use clauderepo before it's published to npm:

### 1. Clone the repo

```bash
cd ~/Desktop
git clone https://github.com/Kevthetech143/clauderepo.git
cd clauderepo/backend/mcp-client
npm install
npm run build
```

### 2. Add to Claude Code config

```bash
claude mcp add clauderepo -- node /Users/admin/Desktop/clauderepo/backend/mcp-client/dist/index.js
```

### 3. Restart Claude Code

```bash
# Restart Claude Code (Cmd+Q and reopen)
```

### 4. Verify it works

In Claude Code:

```
Search clauderepo for "MCP connection refused"
```

You should get instant results!

## Usage

### Search for solutions

```
Search clauderepo for "[your error message]"
```

Examples:
- `Search clauderepo for "MCP connection refused"`
- `Search clauderepo for "Supabase RLS blocking queries"`
- `Search clauderepo for "React hydration mismatch"`

### Report solution success

After trying a solution:

```
Report to clauderepo: solution for "MCP connection refused" worked
```

This helps rank solutions by what actually works!

## Troubleshooting

### MCP server not showing

```bash
# Check MCP config
cat ~/.config/claude/mcp_settings.json

# Verify clauderepo is listed
claude mcp list
```

### Connection errors

```bash
# Test API directly
curl https://ksethrexopllfhyrxlrb.supabase.co/functions/v1/search \
  -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..." \
  -H "Content-Type: application/json" \
  -d '{"query": "test"}'
```

### Still not working?

1. Restart Claude Code
2. Check Claude Code version (needs latest)
3. Open issue: https://github.com/Kevthetech143/clauderepo/issues

## Publishing to npm (For maintainers)

```bash
cd ~/Desktop/clauderepo/backend/mcp-client

# Login to npm
npm login

# Publish
npm publish

# Update version
npm version patch
npm publish
```

## Supabase Backend

The knowledge base runs on Supabase:
- **Database**: `ksethrexopllfhyrxlrb`
- **Search endpoint**: `/functions/v1/search`
- **Contribute endpoint**: `/functions/v1/contribute`
- **Track endpoint**: `/functions/v1/track`

## Database Schema

- `knowledge_entries` - Verified solutions (53 entries)
- `prerequisites` - Requirements for solutions
- `success_indicators` - How to verify solution worked
- `pending_contributions` - Moderation queue
- `user_usage` - Anonymous usage tracking

## Architecture

```
Claude Code
    ↓
MCP Client (npm package)
    ↓
Supabase Edge Functions
    ↓
Postgres (full-text search)
```

## License

MIT - Free forever, open source

## Support

- GitHub Issues: https://github.com/Kevthetech143/clauderepo/issues
- Frontend: file:///Users/admin/Desktop/clauderepo/frontend/index.html
