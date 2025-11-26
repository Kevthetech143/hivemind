# Knowledge Mining Protocol v1

## Overview
Distributed mining system with two distinct roles:
- **MINER** agents: Spawn 5 Haiku subagents to extract knowledge in parallel, consolidate into SQL files
- **UPLOADER** agent: Monitors migration folder, fixes SQL issues, applies to database

---

## ROLE: MINER

### Your Job
Coordinate 5 Haiku subagents to mine knowledge in parallel, then consolidate their output into SQL migration files.

### CRITICAL: Spawn 5 Haiku Subagents in Parallel

You MUST use the Task tool to spawn 5 parallel Haiku agents for fast mining.

**Send ALL 5 Task calls in a SINGLE message** for parallel execution:

```
Use Task tool with these parameters for EACH of 5 subagents:

Task 1:
  description: "Mine [topic] subtopic 1"
  model: haiku
  subagent_type: general-purpose
  prompt: |
    You are mining knowledge entries for [TOPIC] - specifically [SUBTOPIC 1].

    Search for the top 3-4 most common errors/issues.
    For each, extract:
    - Exact error message or problem description
    - 2-3 ranked solutions with success percentages
    - Prerequisites needed
    - How to verify fix worked
    - Common pitfalls
    - Real source URL

    Return as JSON array:
    [
      {
        "query": "exact error message",
        "category": "category-name",
        "hit_frequency": "HIGH",
        "solutions": [{"solution": "...", "percentage": 95, "note": "..."}],
        "prerequisites": "...",
        "success_indicators": "...",
        "common_pitfalls": "...",
        "success_rate": 0.90,
        "source_url": "https://actual-url.com"
      }
    ]

Task 2: (same structure, different subtopic)
Task 3: (same structure, different subtopic)
Task 4: (same structure, different subtopic)
Task 5: (same structure, different subtopic)
```

### Example: Mining "Redis" with 5 Parallel Haiku Agents

Split the topic into 5 subtopics and spawn all at once:

| Subagent | Subtopic | Focus |
|----------|----------|-------|
| Haiku 1 | Redis connection errors | ECONNREFUSED, timeout, auth failed |
| Haiku 2 | Redis memory issues | OOM, maxmemory, eviction |
| Haiku 3 | Redis cluster errors | MOVED, ASK, slot errors |
| Haiku 4 | Redis replication | sync failed, master-slave issues |
| Haiku 5 | Redis persistence | RDB/AOF errors, BGSAVE failures |

### After Subagents Return

1. Collect all 5 JSON responses
2. Deduplicate any overlapping entries
3. Convert to SQL format (see template below)
4. Write to migration folder

### Output Location
```
/Users/admin/Desktop/clauderepo/supabase/migrations/
```

### File Naming Convention
```
YYYYMMDD_<source>_<topic>_batch<N>.sql
```
Examples:
- `20251125_github_react_batch1.sql`
- `20251125_stackoverflow_prisma_batch1.sql`
- `20251125_aws_lambda_docs_batch1.sql`

### SQL Template
```sql
-- Mining <source> for <topic> solutions
-- Category: <category-name>
-- Date: YYYY-MM-DD

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Exact error message or problem description',
    'category-name',
    'HIGH',  -- HIGH, MEDIUM, LOW, VERY_HIGH
    '[
        {"solution": "First solution with specific steps", "percentage": 95, "note": "When to use this"},
        {"solution": "Second solution", "percentage": 85, "note": "Alternative approach"},
        {"solution": "Third solution", "percentage": 75, "command": "actual command if applicable"}
    ]'::jsonb,
    'What must be in place before attempting (versions, tools, configs)',
    'How to verify the fix worked',
    'Common mistakes people make when trying to solve this',
    0.90,  -- Success rate as decimal
    'sonnet-4',
    NOW(),
    'https://actual-source-url.com/issue/123'
),
(
    -- Next entry...
);
```

### Quality Standards
1. **Real URLs** - Every entry needs actual source URL
2. **Specific errors** - Use exact error messages, not paraphrased
3. **Ranked solutions** - Order by effectiveness, include percentages
4. **Actionable** - Solutions must have concrete steps/commands
5. **10-20 entries per file** - Keep batches manageable

### DO NOT
- Include `pattern_id` or `thumbs_up` columns (don't exist)
- Use `\'` for escaping (use `''` instead)
- Mine topics already assigned to another MINER
- Overwrite existing files

### Coordination
Before mining a topic, check if a file for that topic already exists:
```bash
ls /Users/admin/Desktop/clauderepo/supabase/migrations/*<topic>*.sql
```

---

## ROLE: UPLOADER

### Your Job
Monitor the migration folder, fix SQL syntax issues, apply to production database.

### Monitor Command
```bash
ls -lt /Users/admin/Desktop/clauderepo/supabase/migrations/*.sql | head -20
```

### Fix Sequence (apply to each new file)

**Step 1: Check for pattern_id column**
```bash
grep -l "pattern_id" <file> && sed -i '' 's/, pattern_id//g; s/, source_url, pattern_id/, source_url/g' <file>
```

**Step 2: Convert single-quote JSON to dollar-quoted**
```bash
sed -i '' "s/'\[/\$\$[/g; s/\]'::jsonb/]\$\$::jsonb/g" <file>
```

**Step 3: Fix backslash escapes**
```bash
sed -i '' "s/\\\\'/''/g" <file>
```

**Step 4: Check for $$ inside content (breaks quoting)**
If file has `$$[` inside solution text (like jQuery selectors), use alternate delimiter:
```bash
sed -i '' 's/\$\$\[/$solutions$[/g; s/\]\$\$/]$solutions$/g' <file>
```

### Apply to Database
```bash
/usr/local/opt/libpq/bin/psql "postgresql://postgres.ksethrexopllfhyrxlrb:gocwo8-wetvib-fyhgeH@aws-0-us-west-2.pooler.supabase.com:6543/postgres" -f <file>
```

### Verify Success
```sql
SELECT COUNT(*) as total_entries, COUNT(DISTINCT category) as total_categories FROM knowledge_entries;
```

### Common Errors & Fixes

| Error | Cause | Fix |
|-------|-------|-----|
| `Escape sequence '\'' is invalid` | Backslash quotes in JSON | `sed -i '' "s/\\\\'/''/g" file` |
| `syntax error at or near "["` | `$$[` inside dollar-quoted string | Use `$solutions$` or `$json$` delimiter |
| `INSERT has more target columns` | Extra column like pattern_id | Remove from INSERT statement |
| `VALUES lists must all be the same length` | Missing comma before number | Add comma after previous field |

### Tracking
After each batch, report:
- Files applied
- Entry count added
- New total: X entries across Y categories

---

## COORDINATOR INSTRUCTIONS

### Assigning MINERs
Tell each MINER agent:
```
You are a MINER. Read and follow /Users/admin/Desktop/clauderepo/MINING_PROTOCOL_V1.md

Your assigned topics:
- <topic 1>
- <topic 2>
- <topic 3>

IMPORTANT: You MUST spawn 5 Haiku subagents in parallel for each topic using the Task tool.
Split each topic into 5 subtopics and mine them simultaneously.

Write SQL files to the migration folder.
Do NOT apply to database - UPLOADER handles that.
```

### Assigning UPLOADER
Tell the UPLOADER agent:
```
You are the UPLOADER. Read and follow /Users/admin/Desktop/clauderepo/MINING_PROTOCOL_V1.md

Monitor /Users/admin/Desktop/clauderepo/supabase/migrations/ for new .sql files.
Fix SQL syntax issues and apply to production database.
Report counts after each batch.
```

### Topic Assignment Tracker
Keep a list to avoid duplicates:

| Topic | Assigned To | Status |
|-------|-------------|--------|
| react | MINER-1 | done |
| vue | MINER-1 | done |
| kubernetes | MINER-2 | done |
| ... | ... | ... |

---

## Database Connection Info

**Pooler URL (for writes):**
```
postgresql://postgres.ksethrexopllfhyrxlrb:gocwo8-wetvib-fyhgeH@aws-0-us-west-2.pooler.supabase.com:6543/postgres
```

**Project ID:** `ksethrexopllfhyrxlrb`

**Table:** `knowledge_entries`

**Current Stats:** ~4,000+ entries across 340+ categories

---

## SPAWNING TMUX HAIKU MINERS (Alternative to Task subagents)

### Why tmux Haiku?
- Full tool access (web search, file write, etc.)
- Haiku cost (~20x cheaper than Sonnet)
- True parallel execution
- Persistent sessions

### Spawn Command
```bash
tmux new-session -d -s <session-name> "claude --model haiku"
```

### Spawn 5 Parallel Haiku Miners
```bash
tmux new-session -d -s miner1 "claude --model haiku"
tmux new-session -d -s miner2 "claude --model haiku"
tmux new-session -d -s miner3 "claude --model haiku"
tmux new-session -d -s miner4 "claude --model haiku"
tmux new-session -d -s miner5 "claude --model haiku"
```

### Send Initial Prompt to Each
```bash
tmux send-keys -t miner1 "You are a MINER. Read /Users/admin/Desktop/MINING_PROTOCOL_V1.md. Mine Redis connection errors. Write SQL to migration folder." Enter
tmux send-keys -t miner2 "You are a MINER. Read /Users/admin/Desktop/MINING_PROTOCOL_V1.md. Mine Redis memory errors. Write SQL to migration folder." Enter
# etc...
```

### Check Status
```bash
tmux list-sessions | grep miner
```

### View a Miner's Output (read-only)
```bash
tmux capture-pane -t miner1 -p | tail -50
```

### ⚠️ CRITICAL: DO NOT
- **NEVER** use `open -a Terminal` or `osascript` to attach - can kill parent session
- **NEVER** auto-attach to spawned sessions from within another Claude session
- Sessions are **fire and forget** - they write to migration folder independently
- To view: user manually runs `tmux attach -t <session>` in separate terminal

### Kill All Miners When Done
```bash
tmux kill-session -t miner1
tmux kill-session -t miner2
# or kill all at once:
tmux list-sessions | grep miner | cut -d: -f1 | xargs -I {} tmux kill-session -t {}
```

---

## Version History
- v1.1 (2025-11-25): Added tmux Haiku spawning, safety rules for session management
- v1 (2025-11-25): Initial protocol - MINER/UPLOADER roles, 5x Haiku parallel mining
