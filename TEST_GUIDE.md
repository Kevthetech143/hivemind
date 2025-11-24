# clauderepo v2.0.0 Testing Guide

**What's Deployed:**
- ✅ Ticket system (auto-creates on 0 search results)
- ✅ 85 solutions (53 original + 32 from Larry)
- ✅ MCP client v2.0.0 installed locally
- ✅ All edge functions live on Supabase

---

## Quick Test Checklist

### 1. Test Search (Known Solution)
```
Search clauderepo for "playwright click"
```
**Expected**: Returns solution from Larry migration

---

### 2. Test Ticket Auto-Creation (No Results)
```
Search clauderepo for "my custom fake error that doesnt exist"
```
**Expected**:
- "🎫 Troubleshooting Ticket Opened"
- Shows TICKET_000005 (or next available)
- Shows checklist (5 steps)
- Status: open

---

### 3. Test Ticket Resolution Flow

**Step 1**: Let Claude work through the checklist
**Step 2**: When solved, Claude should call `resolve_ticket`
**Step 3**: Verify solution added to KB

**Check in Supabase:**
```sql
-- View the resolved ticket
SELECT * FROM troubleshooting_sessions WHERE ticket_id = 'TICKET_000005';

-- Verify KB entry created
SELECT * FROM knowledge_entries WHERE source_ticket_id = 'TICKET_000005';
```

---

### 4. Test Rate Limiting

**Search endpoint** (100/hr):
```bash
for i in {1..101}; do
  curl -X POST "https://ksethrexopllfhyrxlrb.supabase.co/functions/v1/search" \
    -H "Authorization: Bearer <anon_key>" \
    -H "Content-Type: application/json" \
    -d '{"query":"test"}' &
done
```
**Expected**: Request #101 returns 429 (rate limited)

---

### 5. Test Contributions

```bash
# Submit contribution via MCP
mcp__clauderepo__contribute_solution(...)
```
**Expected**:
- Returns CONTRIB_000006 (or next)
- Status: pending
- 24-48hr review message

---

### 6. Verify No Test Data in Production

**Supabase Dashboard → SQL Editor:**
```sql
-- Check for test tickets (should be empty after cleanup)
SELECT * FROM troubleshooting_sessions
WHERE problem LIKE '%xyz%' OR problem LIKE '%test%';

-- Check for test knowledge entries
SELECT * FROM knowledge_entries
WHERE query LIKE '%test%' OR query LIKE '%example%' OR query LIKE '%dummy%';
```

---

## Known Issues to Test Around

### ❌ Ticket System Security Gaps
- **No moderation** - Resolved tickets auto-add to KB
- **No validation** - Malicious commands can be submitted
- **No rollback** - Only admin can delete bad solutions

**Testing**: Try resolving a ticket with a harmless but obviously wrong solution. Verify it gets added to KB immediately.

---

## Admin Operations (Dashboard Only)

### Delete Test Tickets
```sql
DELETE FROM troubleshooting_sessions
WHERE ticket_id IN ('TICKET_000001', 'TICKET_000002', 'TICKET_000003', 'TICKET_000004');
```

### View Analytics
```sql
-- Most searched queries
SELECT query, COUNT(*) as searches
FROM knowledge_entries
GROUP BY query
ORDER BY searches DESC
LIMIT 10;

-- Ticket resolution rate
SELECT
  status,
  COUNT(*) as count,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) as percentage
FROM troubleshooting_sessions
GROUP BY status;

-- Top categories
SELECT category, COUNT(*) as count
FROM knowledge_entries
GROUP BY category
ORDER BY count DESC;
```

---

## Files to Review

- `ROADMAP.md` - Phase 0 security items
- `DEPLOY_TICKET_SYSTEM.md` - Deployment verification
- `MONITORING.md` - Dashboard checks

---

## Post-Testing Cleanup

Before public launch:
1. Delete all test tickets
2. Review all 85 solutions for quality
3. Implement Phase 0 security items
4. Set up admin MCP server

---

## Emergency Rollback

If ticket system causes issues:

```sql
-- Disable ticket creation
CREATE OR REPLACE FUNCTION start_troubleshooting_ticket(p_problem TEXT, p_category TEXT)
RETURNS JSONB AS $$
BEGIN
  RAISE EXCEPTION 'Ticket system temporarily disabled';
END;
$$ LANGUAGE plpgsql;
```

Then revert MCP to v1.1.1:
```bash
npm install -g clauderepo-mcp@1.1.1
# Restart Claude Code
```

---

**Ready to test!** Start with test #1 and work through the checklist.
