# clauderepo

> **Instant troubleshooting solutions for AI coding assistants**
> Community-driven knowledge base with 2,400+ solutions - works with Claude Code, Codex CLI, Gemini CLI, Grok CLI

[![npm version](https://img.shields.io/npm/v/clauderepo-mcp.svg)](https://www.npmjs.com/package/clauderepo-mcp)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

---

## 🎯 What is clauderepo?

clauderepo is a **Model Context Protocol (MCP) server** that gives AI coding assistants instant access to a searchable knowledge base of troubleshooting solutions. Works with any MCP-compatible CLI: Claude Code, OpenAI Codex, Google Gemini CLI, Grok CLI, and more.

When you hit an error, search clauderepo - get ranked solutions from the community in seconds.

---

## ✨ Features

- 🔍 **Full-text search** - Fast Postgres FTS with relevance ranking
- 👍 **Community feedback** - Say "clauderepo: worked" to rate solutions
- 🎯 **Trigger words** - Claude automatically tracks your feedback
- 📊 **Smart ranking** - Solutions sorted by success rate and votes
- 🚀 **Zero config** - No API keys, no setup, just install and use
- ⚡ **Fast** - < 1s search response time

---

## 📦 Installation

### Step 1: Install the MCP package

```bash
npm install -g clauderepo-mcp@latest
```

### Step 2: Add to Claude Code MCP settings

Open Claude Code and configure MCP:

**Option A: Via Claude Code UI**
1. Open Claude Code settings
2. Go to MCP Servers section
3. Add new server:
   - Name: `clauderepo`
   - Command: `npx`
   - Args: `["clauderepo-mcp"]`

**Option B: Via config file**

Edit `~/.config/claude/mcp_config.json`:

```json
{
  "mcpServers": {
    "clauderepo": {
      "command": "npx",
      "args": ["clauderepo-mcp"]
    }
  }
}
```

### Step 3: Restart Claude Code

Reload Claude Code to activate the MCP server.

---

## 🚀 Usage

### Search for Solutions

```
User: "MCP connection refused"
Claude: [searches clauderepo automatically]
```

Or explicitly:
```
User: "Search clauderepo for playwright timeout"
```

### Give Feedback

After trying a solution:
```
User: "clauderepo: worked"
```

Or:
```
User: "clauderepo: failed"
```

Claude automatically tracks your feedback to improve rankings!

---

## 📚 Example Queries

| Problem | Query |
|---------|-------|
| MCP won't connect | "MCP connection refused" |
| Playwright issues | "playwright click not working" |
| Claude hooks | "hooks don't fire" |
| Auth problems | "user signed in but gets must sign in error" |
| Supabase issues | "supabase migration failed" |

**Current knowledge base**: 2,400+ solutions covering MCP, Playwright, Supabase, web development, databases, security, and more.

---

## 🤝 Contributing Solutions

Have a solution that helped you? Share it with the community!

### Via MCP Tool

```
User: "I want to contribute a solution"
Claude: [guides you through contribution form]
```

### Via Email

Send to: [your-email] (Beta testers will get this in welcome message)

Include:
- Problem/error message
- Category (mcp-troubleshooting, web-automation, etc.)
- Step-by-step solutions
- What to check before/after
- Common mistakes

---

## 🎓 How Trigger Words Work

When you say **"clauderepo: worked"** or **"clauderepo: failed"**:

1. Claude recognizes the trigger phrase
2. Automatically calls feedback tool
3. Backend increments thumbs_up or thumbs_down
4. Future searches show better-ranked solutions

**Why trigger words?**
Natural language ("that worked") is ambiguous. Trigger phrases ensure Claude ALWAYS catches your feedback.

---

## 🛡️ Infrastructure

**Rate Limits**:
- Search: 100 requests/hour per IP
- Voting: 20 votes/hour per IP
- Contributions: 5/hour per IP

**Stack**:
- Backend: Supabase (Postgres 17 + Edge Functions)
- Database: 2,400+ solutions
- Security: IP banning, input sanitization, moderated contributions

---

## 📊 Monitoring

Beta testers: We monitor usage via Supabase dashboard. You can check your own usage:

```bash
# View your recent searches (if you clone the repo)
source ~/.claude/scripts/turso-helpers.sh
db-stats
```

See [MONITORING.md](MONITORING.md) for admin dashboard access.

---

## 🗺️ Roadmap

**Completed**:
- ✅ Core search and feedback
- ✅ Trigger word system
- ✅ Rate limiting
- ✅ Security (IP bans, sanitization, moderation queue)
- ✅ 2,400+ solutions
- ✅ Version update notifications

**Coming Soon**:
- Semantic search (AI embeddings)
- Contributor leaderboard
- Browser extension
- Dangerous command blocklist

See [ROADMAP.md](ROADMAP.md) for full details.

---

## 🔧 Technical Details

**Stack**:
- MCP Server: TypeScript + @modelcontextprotocol/sdk
- Backend: Supabase (Postgres 17 + Deno Edge Functions)
- Search: Postgres Full-Text Search (ts_rank)
- Hosting: Supabase free tier + npm registry

**Architecture**:
```
User → Claude Code → MCP → Supabase Edge Functions → Postgres
```

**Files**:
- `backend/mcp-client/` - MCP server source
- `backend/functions/` - Edge functions (search, track, contribute)
- `backend/schema.sql` - Database schema

---

## 📄 Documentation

- [INSTALL.md](INSTALL.md) - Detailed installation guide
- [TRIGGER_FEEDBACK_SYSTEM.md](TRIGGER_FEEDBACK_SYSTEM.md) - How feedback works
- [MONITORING.md](MONITORING.md) - Admin monitoring guide
- [ROADMAP.md](ROADMAP.md) - Product roadmap

---

## ❓ Troubleshooting

### MCP not loading

```bash
# Check if installed
npm list -g clauderepo-mcp

# Reinstall
npm install -g clauderepo-mcp@latest

# Restart Claude Code
```

### Search not working

1. Check Claude Code MCP logs
2. Verify internet connection
3. Try: "Search clauderepo for test"

### Feedback not tracked

Known issue - tracking endpoint works but MCP may not call it consistently. We're debugging this.

---

## 🐛 Reporting Issues

1. Check [existing issues](https://github.com/Kevthetech143/clauderepo/issues)
2. Create new issue with:
   - What you tried
   - What happened
   - Your AI CLI (Claude Code, Codex, Gemini, etc.)
   - Operating system

---

## 📜 License

MIT License - see [LICENSE](LICENSE) file

---

## 🌟 Star History

If clauderepo helped you, give it a star ⭐

---

**Built with ❤️ for the AI coding community**
