# clauderepo

> **Instant troubleshooting solutions for Claude Code**
> Community-driven knowledge base with 50+ verified solutions and trigger-based feedback

[![npm version](https://img.shields.io/npm/v/clauderepo-mcp.svg)](https://www.npmjs.com/package/clauderepo-mcp)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

---

## 🎯 What is clauderepo?

clauderepo is a **Model Context Protocol (MCP) server** that gives Claude Code instant access to a searchable knowledge base of troubleshooting solutions. When you hit an error, just ask Claude to search clauderepo - get ranked solutions from the community in seconds.

**Beta Status**: Currently accepting 10-50 early adopters for testing.

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

**Current knowledge base**: 50+ solutions covering MCP, Playwright, Supabase, Claude Code, and more.

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

## 🛡️ Beta Launch Details

**Current Status**: Private beta (10-50 users)

**Rate Limits**:
- Search: 100 requests/hour per IP
- Voting: 20 votes/hour per IP
- Contributions: 5/hour per IP

**Infrastructure**:
- Backend: Supabase (Postgres + Edge Functions)
- Database: 53 solutions, growing
- Hosting: Free tier (500K requests/month)

**Known Issues**:
- MCP fetch calls may not trigger tracking in some cases (tracking endpoint works, debugging in progress)
- Small knowledge base (actively growing)
- Contribution moderation is manual (24-48 hour review)

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

**Phase 1: Beta (Current)**
- ✅ Core search and feedback
- ✅ Trigger word system
- ✅ Rate limiting
- ⏳ Testing with 10-50 users

**Phase 2: Early Growth (10-50 users)**
- Improve search ranking with thumbs data
- Display community ratings in results
- Wilson Score confidence intervals
- Grow knowledge base to 100+ solutions

**Phase 3: Public Launch (50-250 users)**
- Automated moderation
- Contributor leaderboard
- Advanced abuse detection
- A/B testing for solutions

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

Beta testers, please report issues:

1. Check [existing issues](https://github.com/Kevthetech143/clauderepo/issues)
2. Create new issue with:
   - What you tried
   - What happened
   - Claude Code version
   - Operating system

---

## 📜 License

MIT License - see [LICENSE](LICENSE) file

---

## 🙏 Beta Testers

Thank you to our early adopters! Your feedback shapes the future of clauderepo.

**Join the beta**: DM [@Kevthetech143](https://twitter.com/Kevthetech143) or email [your-email]

---

## 🌟 Star History

Just launched! Be one of the first to star ⭐

---

**Built with ❤️ for the Claude Code community**
