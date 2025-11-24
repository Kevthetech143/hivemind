# clauderepo - Supabase-Only Deployment

**Everything runs on Supabase. No Railway needed.**

## Architecture

```
Claude Code → MCP Client → Supabase Edge Functions → Postgres
```

**Cost**: $0/month (free tier) or $25/month (pro tier for scale)

---

## Prerequisites

- Supabase account (https://supabase.com)
- Node.js 16+ installed
- Supabase CLI: `npm install -g supabase`

---

## Step 1: Create Supabase Project (2 min)

1. Go to https://app.supabase.com
2. Click **"New Project"**
3. Fill in:
   - **Name**: `clauderepo`
   - **Database Password**: Generate strong password (save it!)
   - **Region**: Choose closest to your users
4. Click **"Create new project"**
5. Wait ~2 minutes for provisioning

---

## Step 2: Get Your Credentials (1 min)

In Supabase dashboard:

1. Go to **Settings** → **API**
2. Copy these values:

```bash
# You'll need these:
Project URL: https://xxxxx.supabase.co
anon/public key: eyJhbGc...
service_role key: eyJhbGc... (KEEP SECRET)
Project Ref: xxxxx (from URL or Settings → General)
```

---

## Step 3: Apply Database Schema (1 min)

In Supabase dashboard:

1. Go to **SQL Editor**
2. Click **"New Query"**
3. Copy **entire contents** of `/tmp/supabase/schema.sql`
4. Paste into SQL Editor
5. Click **"RUN"** (bottom right)
6. Should see: "Success. No rows returned"

**Verify**: Go to **Table Editor** → should see:
- `knowledge_entries`
- `prerequisites`
- `success_indicators`
- `pending_contributions`
- `user_usage`

---

## Step 4: Migrate Data from SQLite (2 min)

Run the migration script:

```bash
cd /tmp/supabase

# Set your Supabase connection string
export SUPABASE_URL="https://xxxxx.supabase.co"
export SUPABASE_SERVICE_KEY="your-service-role-key"

# Run migration
node migrate-data.js
```

Expected output:
```
✅ Connected to Supabase
📦 Migrating 20 knowledge entries...
✅ Migrated 20 entries
✅ Migration complete!
```

---

## Step 5: Deploy Edge Functions (3 min)

```bash
cd /tmp/supabase

# Login to Supabase CLI
supabase login

# Link to your project
supabase link --project-ref YOUR_PROJECT_REF

# Deploy all functions
supabase functions deploy search
supabase functions deploy contribute
supabase functions deploy track
```

**Verify**: Go to **Edge Functions** tab → should see:
- ✅ search
- ✅ contribute
- ✅ track

---

## Step 6: Build MCP Client (1 min)

```bash
cd /tmp/supabase/mcp-client

# Install dependencies
npm install

# Build TypeScript
npm run build

# Should create: dist/index.js
```

---

## Step 7: Configure Claude Code (1 min)

Add to your MCP config file:

**Location**: `~/.claude/mcp.json` (or via Claude Code settings UI)

```json
{
  "mcpServers": {
    "clauderepo": {
      "command": "node",
      "args": ["/tmp/supabase/mcp-client/dist/index.js"],
      "env": {
        "SUPABASE_URL": "https://xxxxx.supabase.co",
        "SUPABASE_ANON_KEY": "your-anon-key-here"
      }
    }
  }
}
```

**Restart Claude Code** to load the MCP server.

---

## Step 8: Test End-to-End (1 min)

In Claude Code, try:

```
Search clauderepo for: "MCP connection refused"
```

Should return search results from your knowledge base!

---

## Step 9: Enable Supabase Auth (Optional, for user API keys)

If you want users to sign up and get API keys:

1. Go to **Authentication** → **Providers**
2. Enable **Email** provider
3. Configure email templates

Users can then sign up via your frontend and get JWT tokens.

---

## Step 10: Deploy Frontend to Vercel (5 min)

```bash
cd /tmp/supabase/frontend

# Update API URLs in index.html
# Replace with: https://xxxxx.supabase.co/functions/v1

# Deploy to Vercel
vercel --prod
```

---

## Maintenance

### View Knowledge Base Stats

```sql
-- In SQL Editor
SELECT
  COUNT(*) as total_entries,
  AVG(view_count) as avg_views,
  AVG(success_rate) as avg_success_rate
FROM knowledge_entries;
```

### Approve Pending Contributions

```sql
-- View pending
SELECT * FROM pending_contributions WHERE status = 'pending';

-- Approve one
SELECT add_knowledge_entry(
  'Error message here',
  'category',
  '[{"solution": "Fix here", "percentage": 85}]'::jsonb,
  ARRAY['prereq1', 'prereq2'],
  ARRAY['indicator1', 'indicator2'],
  'Common pitfalls text',
  'HIGH',
  0.85
);

-- Mark as approved
UPDATE pending_contributions SET status = 'approved' WHERE id = 123;
```

### Monitor Usage

```sql
-- Top users
SELECT email, queries_today, tier
FROM user_usage
ORDER BY queries_today DESC
LIMIT 20;
```

---

## Scaling

**Free Tier Limits**:
- 500MB database
- 2GB bandwidth/month
- Unlimited Edge Function requests

**When to upgrade** ($25/month Pro):
- Database > 500MB (~5000 entries)
- Bandwidth > 2GB/month (~100k searches)
- Need more compute for Edge Functions

**At scale** (10k+ entries):
- Enable pg_cron for daily cleanup
- Add Redis caching (via Upstash)
- Use Database connection pooling

---

## Troubleshooting

### Edge Functions not deploying

**Check**:
```bash
supabase functions list
supabase projects list
```

Make sure you're linked to the right project.

### Search returns no results

**Check data exists**:
```sql
SELECT COUNT(*) FROM knowledge_entries;
```

If 0, re-run migration script.

### MCP server won't start

**Check env vars**:
```bash
echo $SUPABASE_URL
echo $SUPABASE_ANON_KEY
```

Make sure they're set in `mcp.json`.

---

## Security

- ✅ Use `SUPABASE_ANON_KEY` in MCP client (safe for client-side)
- ✅ Use `SUPABASE_SERVICE_KEY` only in Edge Functions (server-side)
- ✅ Row Level Security (RLS) enabled on all tables
- ✅ Rate limiting via `user_usage` table
- ✅ CORS configured in Edge Functions

---

## Cost Breakdown

**Supabase Free Tier** ($0/month):
- 500MB database
- 2GB egress
- 500K Edge Function requests

**Supabase Pro** ($25/month):
- 8GB database
- 50GB egress
- 2M Edge Function requests

**Estimate for 1000 users**:
- Database: ~200MB (20k entries)
- Bandwidth: ~10GB/month (100k searches)
- Edge Functions: ~300K requests/month

**Recommendation**: Start on free tier, upgrade at ~5k entries or 50k searches/month.

---

## Next Steps

1. ✅ Deploy to Supabase
2. ✅ Test from Claude Code
3. 🔄 Set up AI contributor automation
4. 🔄 Add 100+ entries
5. 🔄 Monitor quality signals
6. 🔄 Iterate on ranking algorithm

---

**Total deployment time**: ~15 minutes

**Monthly cost**: $0-25

**Ready!** 🚀
