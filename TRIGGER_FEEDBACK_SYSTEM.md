# Trigger-Based Feedback System

## ✅ Implementation Complete (v1.1.0)

The clauderepo MCP now includes **trigger word support** for reliable user feedback collection.

---

## How It Works

### 1. User Searches for Solution
```
User: "MCP connection refused"
```

Claude uses clauderepo MCP to search and returns solutions with this footer:
```
💬 After trying a solution, tell me: "clauderepo: worked" or "clauderepo: failed"
   This helps improve rankings for the community.
```

### 2. User Tries Solution and Reports
**Explicit trigger (recommended)**:
```
User: "clauderepo: worked"
```

**Natural language (also supported)**:
```
User: "that worked"
User: "it worked"
User: "that fixed it"
User: "didn't work"
User: "still broken"
```

### 3. Claude Automatically Calls Feedback Tool
The MCP tool description now includes:
```
TRIGGER WORDS: When the user says "clauderepo: worked" or "clauderepo: failed",
call this tool IMMEDIATELY. Also call when user says "that worked", "it worked",
"that fixed it", "didn't work", "still broken", etc.
```

Claude recognizes these patterns and calls `report_solution_outcome` automatically.

### 4. Backend Tracks Thumbs Up/Down
- **Success**: Increments `thumbs_up` column
- **Failure**: Increments `thumbs_down` column + tracks repeat_search

---

## Technical Architecture

### MCP Client (v1.1.0)
**File**: `mcp-client/src/index.ts`

**Tool Description** (lines 141-145):
```typescript
description:
  'Report solution feedback to improve rankings and quality. ' +
  'TRIGGER WORDS: When the user says "clauderepo: worked" or "clauderepo: failed", call this tool IMMEDIATELY. ' +
  'Also call when user says "that worked", "it worked", "that fixed it", "didn\'t work", "still broken", etc. ' +
  'Extract the solution_query from the most recent search result you showed them.',
```

**Tracking Logic** (lines 335-357):
```typescript
// Track thumbs up/down
if (args.outcome === 'success') {
  trackingCalls.push(
    callEdgeFunction('track', {
      event_type: 'solution_success',
      solution_query: args.solution_query
    })
  );
} else if (args.outcome === 'failure') {
  trackingCalls.push(
    callEdgeFunction('track', {
      event_type: 'solution_failure',
      solution_query: args.solution_query
    })
  );
}
```

### Edge Function (Deployed)
**File**: `supabase/functions/track/index.ts`

**New Event Types**:
- `solution_success` → Increments `thumbs_up`
- `solution_failure` → Increments `thumbs_down`

**Logic** (lines 95-163):
```typescript
if (event_type === 'solution_success') {
  const { data: entry } = await supabaseClient
    .from('knowledge_entries')
    .select('thumbs_up')
    .eq('query', solution_query)
    .single()

  await supabaseClient
    .from('knowledge_entries')
    .update({ thumbs_up: (entry.thumbs_up || 0) + 1 })
    .eq('query', solution_query)
}
```

### Database Schema
**File**: `schema.sql` (lines 22-23)

```sql
thumbs_up INTEGER DEFAULT 0,
thumbs_down INTEGER DEFAULT 0,
```

**Index** (line 37):
```sql
CREATE INDEX IF NOT EXISTS idx_thumbs_rating ON knowledge_entries((thumbs_up - thumbs_down) DESC);
```

---

## Installation & Usage

### For Users
```bash
# Install/upgrade to v1.1.0
npm install -g clauderepo-mcp@latest

# Or use via npx
npx clauderepo-mcp@latest
```

Then configure in Claude Code MCP settings.

### For Developers
```bash
cd backend/mcp-client
npm run build
npm publish --access public
```

---

## Database Migration (Required)

**Status**: ⚠️ **PENDING** - User must run manually

**Steps**:
1. Go to [Supabase SQL Editor](https://supabase.com/dashboard/project/ksethrexopllfhyrxlrb/sql)
2. Run the migration:

```sql
ALTER TABLE knowledge_entries
ADD COLUMN IF NOT EXISTS thumbs_up INTEGER DEFAULT 0,
ADD COLUMN IF NOT EXISTS thumbs_down INTEGER DEFAULT 0;

CREATE INDEX IF NOT EXISTS idx_thumbs_rating
ON knowledge_entries((thumbs_up - thumbs_down) DESC);
```

3. Verify:
```sql
SELECT column_name, data_type, column_default
FROM information_schema.columns
WHERE table_name = 'knowledge_entries'
AND column_name IN ('thumbs_up', 'thumbs_down');
```

**Note**: Migration file available at `backend/migrations/add_thumbs_feedback.sql`

---

## Metrics Tracked

| Metric | Event | Column | Calculation |
|--------|-------|--------|-------------|
| **Thumbs Up** | User says "worked" | `thumbs_up` | Increment +1 |
| **Thumbs Down** | User says "failed" | `thumbs_down` | Increment +1 |
| **Net Rating** | Sorting | `(thumbs_up - thumbs_down)` | Index calculation |
| **Command Copies** | Existing | `command_copy_count` | Increment +1 |
| **Repeat Searches** | Failures only | `repeat_search_rate` | Weighted average |

---

## Future Enhancements

### Phase 2 (10-50 users)
- [ ] Use thumbs data to improve search ranking
- [ ] Display thumbs counts in search results
- [ ] Add Wilson Score confidence intervals

### Phase 3 (50-250 users)
- [ ] Community leaderboard for contributors
- [ ] Voting decay (recent votes weigh more)
- [ ] Abuse detection (IP-based rate limiting)

### Phase 4 (250-1000 users)
- [ ] Machine learning to predict solution success
- [ ] A/B testing different solutions
- [ ] Auto-deprecate low-rated solutions

---

## Testing

**Manual Test Flow**:
```
1. User: "MCP connection refused"
   → Claude searches clauderepo
   → Returns solution with feedback prompt

2. User: "clauderepo: worked"
   → Claude calls report_solution_outcome (outcome: success)
   → Backend increments thumbs_up for "MCP connection refused"
   → Returns: "✅ Feedback Recorded - Thanks for confirming this solution worked!"

3. Verify in Supabase:
   SELECT query, thumbs_up, thumbs_down FROM knowledge_entries WHERE query LIKE '%MCP%';
```

---

## Version History

- **v1.0.0** (Nov 23, 2024): Initial release with 53 solutions
- **v1.0.1** (Nov 23, 2024): Hardcoded Supabase credentials for easy installation
- **v1.1.0** (Nov 24, 2024): ✅ **Trigger-based feedback system**
  - Added trigger word support ("clauderepo: worked/failed")
  - Added natural language interpretation
  - Added thumbs_up/thumbs_down tracking
  - Deployed updated track endpoint
  - Updated search results with feedback prompt

---

## Published To

📦 **npm**: https://www.npmjs.com/package/clauderepo-mcp
🔗 **Version**: 1.1.0
📅 **Published**: Nov 24, 2024

---

**Next Steps**:
1. Run database migration (see above)
2. Users upgrade to v1.1.0: `npm install -g clauderepo-mcp@latest`
3. Test feedback flow
4. Monitor thumbs data in Supabase dashboard
