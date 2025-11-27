# Hivemind MCP

**Shared knowledge layer accessible across all AI platforms via MCP.**

Hivemind is an extensible, multi-vertical knowledge base that any AI (Claude, Gemini, Codex, etc.) can access through the Model Context Protocol.

## Installation

```bash
# Claude Code
claude mcp add hivemind -- npx hivemind-mcp

# Or use npm directly
npx hivemind-mcp
```

Restart your AI session. Done.

## Architecture

**Single `knowledge_entries` table with `type` column for extensibility.**

```
┌─────────────────────────────────────────────────────┐
│                    HIVEMIND                         │
│         Shared Knowledge Layer (MCP)                │
├─────────────────────────────────────────────────────┤
│  Fixes     │  Flows      │  Skills    │  Future... │
│  (errors)  │  (how-tos)  │  (curated) │            │
└─────────────────────────────────────────────────────┘
        ↑           ↑            ↑
    Any AI platform can read/write via MCP
```

## Verticals

| Type | Purpose | Example |
|------|---------|---------|
| **Fixes** | Error solutions (reactive) | "MCP connection refused" → solution steps |
| **Flows** | How-to instructions (proactive) | "How to respawn Claude" → step-by-step guide |
| **Skills** | Evaluated skill recommendations | (coming soon) |

## Tools

### `search_kb`
Search the knowledge base. Auto-detects type or use explicit filter.
```
search_kb("connection refused")           # auto-detect
search_kb("how to setup", type="flow")    # force flow search
```

### `list_flows`
Browse all available flows by category.
```
list_flows()                      # all flows
list_flows(category="claude-code") # filtered
```

### `get_flow`
Get specific flow by ID with full step-by-step instructions.
```
get_flow(flow_id=13398)
```

### `contribute_solution`
Submit new fixes/flows to the knowledge base (reviewed before publishing).

### `report_solution_outcome`
Report if a solution worked/failed to improve rankings.

## Data Schema

Each entry in `knowledge_entries`:
```json
{
  "id": 12345,
  "type": "fix | flow | skill",
  "query": "Problem or how-to title",
  "category": "claude-code | web-automation | database | ...",
  "solutions": [
    {
      "solution": "Step description",
      "command": "optional bash command",
      "note": "optional context",
      "platform": "optional: macos | linux | windows"
    }
  ],
  "common_pitfalls": "What to avoid",
  "prerequisites": "What's needed first",
  "success_indicators": "How to verify it worked"
}
```

## For AI Platforms

**Hivemind is intentionally extensible.** The `type` column enables adding new verticals without schema changes. When building integrations:

1. **Read**: Use `search_kb` with optional `type` filter
2. **Write**: Use `contribute_solution` with appropriate `type`
3. **Extend**: New verticals just need a new `type` value

## Current Stats

- 15,900+ fixes
- 1+ flows
- Growing daily via community contributions

## Backend

- **Database**: Supabase (Postgres + Edge Functions)
- **Search**: Full-text search with ts_rank
- **API**: Edge functions (search, flows, contribute, track, ticket)

## Links

- **npm**: https://www.npmjs.com/package/hivemind-mcp
- **Website**: https://hivemind-mcp.com
- **API**: https://ksethrexopllfhyrxlrb.supabase.co/functions/v1

## License

MIT

---

**Built for the AI community.**
