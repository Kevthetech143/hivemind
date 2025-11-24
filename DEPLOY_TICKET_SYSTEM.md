# Deploy Ticket System (v2.0.0)

## Overview

The troubleshooting ticket system automatically opens systematic debugging workflows when search returns no results. Solutions found through tickets are auto-contributed to the knowledge base.

---

## Deployment Steps

### 1. Deploy Database Migration

**Option A: Supabase Dashboard** (Recommended)
1. Go to https://supabase.com/dashboard/project/ksethrexopllfhyrxlrb/sql/new
2. Copy contents of `backend/supabase/migrations/20251124120000_add_troubleshooting_tickets.sql`
3. Paste into SQL editor
4. Click "Run"
5. Verify: `SELECT * FROM troubleshooting_sessions LIMIT 1;` (should return empty result, not error)

**Option B: Local Supabase CLI**
```bash
cd ~/Desktop/clauderepo/backend
supabase db push --project-ref ksethrexopllfhyrxlrb
```

---

### 2. Deploy Edge Functions

**Deploy updated search function:**
```bash
cd ~/Desktop/clauderepo/backend
supabase functions deploy search --project-ref ksethrexopllfhyrxlrb
```

**Deploy new ticket function:**
```bash
supabase functions deploy ticket --project-ref ksethrexopllfhyrxlrb
```

**Verify deployment:**
```bash
# Test search with no results (should auto-create ticket)
curl -X POST "https://ksethrexopllfhyrxlrb.supabase.co/functions/v1/search" \
  -H "Authorization: Bearer <anon_key>" \
  -H "Content-Type: application/json" \
  -d '{"query":"xyzabc123nonexistentquery"}'

# Should return ticket object with ticket_id
```

---

### 3. Deploy MCP Client v2.0.0

**Option A: Publish to npm** (For public beta)
```bash
cd ~/Desktop/clauderepo/backend/mcp-client
npm publish
```

Users update with:
```bash
npm install -g clauderepo-mcp@latest
# Restart Claude Code
```

**Option B: Local testing** (Skip npm publish)
```bash
cd ~/Desktop/clauderepo/backend/mcp-client
npm link
# Restart Claude Code
```

---

## Verify Installation

### Test 1: Search with results (existing behavior)
```
User: "Search clauderepo for playwright click"
Expected: Returns existing solution from Larry migration
```

### Test 2: Search with no results (NEW - auto-ticket)
```
User: "Search clauderepo for xyzabc123testing"
Expected:
- "🎫 Troubleshooting Ticket Opened"
- Shows TICKET_000001
- Shows category-specific checklist
- Prompts to start debugging
```

### Test 3: Update ticket steps
```
Claude calls: update_ticket_steps(ticket_id, step, result)
Expected: "Step Recorded ✅"
```

### Test 4: Resolve ticket
```
Claude calls: resolve_ticket(ticket_id, solution_data)
Expected:
- "🎉 Ticket Resolved & Solution Added!"
- Shows knowledge_id
- Confirms auto-contribution to KB
```

### Test 5: Search for ticket solution
```
User: "Search clauderepo for xyzabc123testing"
Expected: Now returns the solution we just added
```

---

## Rollback Plan

If issues occur:

**1. Disable ticket creation in search:**
```sql
-- In Supabase SQL editor
CREATE OR REPLACE FUNCTION start_troubleshooting_ticket(p_problem TEXT, p_category TEXT)
RETURNS JSONB AS $$
BEGIN
  RAISE EXCEPTION 'Ticket system temporarily disabled';
END;
$$ LANGUAGE plpgsql;
```

**2. Revert MCP client:**
```bash
npm install -g clauderepo-mcp@1.1.1
# Restart Claude Code
```

**3. Re-deploy old search function:**
```bash
# Restore from git history
git checkout HEAD~1 -- backend/functions/search/index.ts
supabase functions deploy search --project-ref ksethrexopllfhyrxlrb
```

---

## Monitoring

**Check ticket creation rate:**
```sql
SELECT COUNT(*), status
FROM troubleshooting_sessions
WHERE created_at > NOW() - INTERVAL '1 day'
GROUP BY status;
```

**Check auto-contributions:**
```sql
SELECT COUNT(*)
FROM knowledge_entries
WHERE source_ticket_id IS NOT NULL
  AND created_at > NOW() - INTERVAL '1 day';
```

**View recent tickets:**
```sql
SELECT ticket_id, category, status, problem, created_at
FROM troubleshooting_sessions
ORDER BY created_at DESC
LIMIT 10;
```

---

## Database Schema Summary

### New Table: `troubleshooting_sessions`
- `id` - Serial primary key
- `ticket_id` - Unique (TICKET_000001 format)
- `problem` - Original search query
- `category` - Auto-detected or 'general'
- `status` - open | in_progress | resolved | abandoned
- `steps_tried` - JSONB array of debugging steps
- `solution` - Final solution text
- `solution_data` - Full solution JSONB
- `created_at`, `resolved_at` - Timestamps
- `auto_contributed` - Boolean flag

### New Column: `knowledge_entries.source_ticket_id`
- Links KB entries back to originating ticket
- NULL for manually contributed solutions
- Indexed for quick lookups

---

## Edge Functions Updated

### `search` (modified)
- **New**: Auto-creates ticket when 0 results
- Calls `start_troubleshooting_ticket()` RPC
- Returns ticket info in response
- Category inference from query keywords

### `ticket` (new)
- **Endpoint**: `/functions/v1/ticket`
- **Actions**:
  - `get` - Retrieve ticket status
  - `update` - Add debugging step
  - `resolve` - Mark solved + auto-contribute
- **Rate limits**: Inherits from main limits

---

## MCP Tools Added

### `update_ticket_steps`
- **Input**: ticket_id, step, result
- **Output**: Confirmation message
- **Usage**: Claude calls automatically during troubleshooting

### `resolve_ticket`
- **Input**: ticket_id, solution_data (JSONB)
- **Output**: Knowledge entry ID + confirmation
- **Usage**: Claude calls when problem is solved

---

## Known Limitations

1. **Category inference is keyword-based** - May misclassify edge cases
2. **No ticket expiration** - Abandoned tickets stay open indefinitely (future: auto-close after 7 days)
3. **Single checklist per category** - No adaptive checklists based on context
4. **No ticket search** - Can't search for similar open tickets (future enhancement)

---

## Success Metrics

Track these after deployment:

- **Ticket creation rate**: Should be < 10% of total searches
- **Resolution rate**: Target > 60% of tickets resolved within 24 hours
- **Auto-contribution quality**: Manual review of first 10-20 ticket-based solutions
- **User feedback**: Check for "ticket system" mentions in issues/feedback

---

## Next Steps

After successful deployment:

1. Monitor first 10 tickets closely
2. Adjust category inference keywords if needed
3. Refine checklists based on actual debugging patterns
4. Consider adding ticket expiration (auto-close after 7 days)
5. Add ticket search to prevent duplicates
6. Implement adaptive checklists (ML-based in future)

---

**Status**: Ready for deployment
**Version**: v2.0.0
**Date**: 2025-11-24
