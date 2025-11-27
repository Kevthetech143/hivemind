# Checkpoint: Hivemind Flows Architecture
**Created:** 2025-11-27 14:38
**Project:** clauderepo/hivemind-mcp
**Session:** Pre-migration checkpoint

---

## Summary
Preparing to add "flows" vertical to hivemind - global how-to instructions that any AI can execute. This checkpoint captures the state before schema migration.

---

## Verified Working

### Package Rename Complete
- `clauderepo-mcp` → `hivemind-mcp@1.0.0` published to npm
- All 11 versions of old package deprecated with migration message
- Package description: "Shared AI memory for debugging. 10,000+ fixes."

### Database
- **9,558 knowledge entries** (fixes)
- Full backup created: `/Users/admin/Desktop/clauderepo/backups/backup-2025-11-27.sql` (14MB)
- Supabase project: `ksethrexopllfhyrxlrb`
- Free plan (no automatic backups)

### MCP Tools Working
- `search_kb` - searches knowledge base
- `contribute_solution` - adds new solutions
- `report_solution_outcome` - thumbs up/down
- `update_ticket_steps` - tracks debugging
- `resolve_ticket` - closes tickets, adds to KB

### Recent Changes
- Removed fake confidence percentages from search results (v2.2.3)
- Added pending_id support for auto-approving solutions (v2.2.2)

---

## Architecture Decisions Made

### Flows = Global Skills
- **Skills** = local (your machine, your paths, your setup)
- **Flows** = global skills (works anywhere, no local dependencies)
- Format: Markdown with AI-executable code blocks per platform

### Naming
- Fixes = errors → solutions (reactive)
- Flows = tasks → steps (proactive)
- "Fixes & Flows" - the two verticals

### Detection Strategy
Server-side detection, not client-side:
1. Check for error keywords first (`error`, `failed`, `timeout`, `fix`)
2. If none, check for howto phrases (`how to`, `guide`, `setup`)
3. Default to `fix` (core use case)

Dumb models (Haiku) just send query, server figures out type.

### Schema Decision
- Same `knowledge_entries` table
- Add `type` column (`fix` | `flow`)
- Store steps as JSONB (same column as solutions)
- Server detects type, client renders accordingly

---

## Files Modified This Session

| File | Change |
|------|--------|
| `backend/mcp-client/package.json` | Renamed to hivemind-mcp@1.0.0 |
| `backend/mcp-client/src/index.ts` | Removed confidence % display |
| `backend/mcp-client/src/index-admin.ts` | Removed confidence % display |

---

## Pending Work

### Immediate Next
1. Add `type` column to `knowledge_entries` table
2. Default existing entries to `type = 'fix'`
3. Update search function to detect query type
4. Update response format to include type
5. Create first test flow (respawn protocol)

### Flow Schema (Proposed)
```sql
ALTER TABLE knowledge_entries
ADD COLUMN type TEXT DEFAULT 'fix' CHECK (type IN ('fix', 'flow'));

-- Set all existing entries to 'fix'
UPDATE knowledge_entries SET type = 'fix' WHERE type IS NULL;
```

### Flow Format (Markdown)
```markdown
# Flow: Respawn Claude Session

**Triggers**: "respawn", "reload MCP"
**Platform**: macOS, Linux, Windows

## Steps

### 1. Detect Platform
\`\`\`bash
uname -s 2>/dev/null || echo "Windows"
\`\`\`

### 2. Open New Terminal with Claude --continue
**macOS:**
\`\`\`bash
osascript -e 'tell application "Terminal" to do script "claude --continue"'
\`\`\`
[etc...]
```

---

## Failed Approaches
- None this session

---

## Session Discoveries

1. **Supabase free plan has no backups** - must do manual pg_dump
2. **Flows vs Skills distinction** - skills are local capability, flows are shared knowledge
3. **Server-side detection** is key for dumb model support
4. **Same table works** - JSONB handles schema variance between fixes and flows

---

## Environment Notes
- Working directory: `/Users/admin/Desktop/clauderepo`
- npm package: `hivemind-mcp@1.0.0`
- Supabase project ID: `ksethrexopllfhyrxlrb`
- Database backup: `backups/backup-2025-11-27.sql`

---

## To Restore
```bash
# If migration fails, restore from backup:
/usr/local/opt/libpq/bin/psql "postgresql://postgres:gocwo8-wetvib-fyhgeH@db.ksethrexopllfhyrxlrb.supabase.co:5432/postgres" < /Users/admin/Desktop/clauderepo/backups/backup-2025-11-27.sql
```

---

*Checkpoint created before flows schema migration*
