# clauderepo - Quick Start (Programmatic Deployment)

**Deploy everything with just 2 environment variables. No manual steps.**

---

## What You Need

1. **Supabase account** (free): https://supabase.com
2. **Create a project** in the dashboard (2 min)
3. **Get 2 values**:

### Get Access Token
- Go to: https://supabase.com/dashboard/account/tokens
- Click **"Generate new token"**
- Name it: `clauderepo-deploy`
- Copy the token

### Get Project Ref
- In your project dashboard, look at the URL:
  ```
  https://supabase.com/dashboard/project/abcdefgh123456/...
                                          ^^^^^^^^^^^^^^^^
                                          This is your project ref
  ```
- Or: Settings → General → Reference ID

---

## Automated Deployment (Recommended)

**One command. Deploys everything.**

```bash
cd /tmp/supabase

# Set credentials
export SUPABASE_ACCESS_TOKEN="sbp_xxx..."
export SUPABASE_PROJECT_REF="abcdefgh123456"

# Optional: Migrate data from SQLite (if you have existing data)
export SUPABASE_SERVICE_KEY="eyJhbG..."  # Get from: Settings → API → service_role

# Deploy everything
./auto-deploy.sh
```

**What it does**:
1. ✅ Installs Supabase CLI
2. ✅ Links to your project (no manual login)
3. ✅ Applies database schema via migrations
4. ✅ Migrates 20 knowledge entries from SQLite
5. ✅ Deploys 3 Edge Functions (search, contribute, track)
6. ✅ Builds MCP client
7. ✅ Generates MCP config

**Time**: ~3 minutes

---

## After Deployment

### 1. Get Your Anon Key

Go to: https://supabase.com/dashboard/project/YOUR_PROJECT_REF/settings/api

Copy the **anon/public key** (starts with `eyJhbG...`)

### 2. Update MCP Config

Edit the generated `mcp-config.json`:

```json
{
  "mcpServers": {
    "clauderepo": {
      "command": "node",
      "args": ["/tmp/supabase/mcp-client/dist/index.js"],
      "env": {
        "SUPABASE_URL": "https://xxx.supabase.co",
        "SUPABASE_ANON_KEY": "YOUR_ANON_KEY_HERE"
      }
    }
  }
}
```

### 3. Add to Claude Code

```bash
# Append to your Claude Code MCP config
cat /tmp/supabase/mcp-config.json >> ~/.claude/mcp.json

# Or manually add it via Claude Code settings UI
```

### 4. Restart Claude Code

### 5. Test

In Claude Code:

```
Search clauderepo for: "MCP connection refused"
```

Should return ranked solutions!

---

## Verify Deployment

Run the test script:

```bash
cd /tmp/supabase

export SUPABASE_URL="https://xxx.supabase.co"
export SUPABASE_ANON_KEY="eyJhbG..."

./test-deployment.sh
```

Expected output:
```
✅ Search function working
✅ Knowledge entries found
✅ Database connected
📊 Knowledge entries: 20
✅ Track function responding
✅ MCP client built
```

---

## What Gets Deployed

| Component | Location | Purpose |
|-----------|----------|---------|
| **Database** | Postgres (Supabase) | Stores 20+ knowledge entries |
| **Search Function** | Edge Function | Full-text search with ranking |
| **Contribute Function** | Edge Function | Submit solutions |
| **Track Function** | Edge Function | Track implicit quality signals |
| **MCP Client** | Local Node.js | Connects Claude Code to Supabase |

---

## Architecture

```
Claude Code
    ↓
MCP Client (local)
    ↓ HTTPS + SUPABASE_ANON_KEY
Supabase Edge Functions
    ↓
Postgres Database
```

**All on one service** - No Railway, no multiple services.

---

## Programmatic Deployment Details

### How It Works

The `auto-deploy.sh` script uses:

1. **Supabase CLI with Access Token**
   - No interactive login needed
   - `SUPABASE_ACCESS_TOKEN` env var authenticates automatically
   - CLI commands work in CI/CD, scripts, anywhere

2. **Database Migrations**
   - Schema is deployed via `supabase db push`
   - Creates migration file from `schema.sql`
   - Applies it to your project

3. **Edge Functions Deploy**
   - `supabase functions deploy <name>` for each function
   - Deployed directly to your project
   - No manual dashboard interaction

4. **Data Migration**
   - Node.js script connects to Supabase
   - Uses `@supabase/supabase-js` client
   - Reads SQLite, writes to Postgres

### Key CLI Commands Used

```bash
# Link to project (no login prompt with access token in env)
supabase link --project-ref $SUPABASE_PROJECT_REF

# Apply schema
supabase db push

# Deploy all functions
supabase functions deploy search
supabase functions deploy contribute
supabase functions deploy track
```

### Environment Variables

```bash
SUPABASE_ACCESS_TOKEN    # From: dashboard/account/tokens
SUPABASE_PROJECT_REF     # Your project ID
SUPABASE_SERVICE_KEY     # For data migration (Settings → API)
```

---

## Manual Deployment (Alternative)

If you prefer step-by-step control, see `/tmp/supabase/DEPLOY.md`

---

## Troubleshooting

### "Failed to link project"

**Cause**: Invalid access token or project ref

**Fix**:
```bash
# Verify token works
curl https://api.supabase.com/v1/projects \
  -H "Authorization: Bearer $SUPABASE_ACCESS_TOKEN"

# Should list your projects
```

### "Migration failed"

**Cause**: Schema already exists or permission issue

**Fix**:
```bash
# Check schema in dashboard: Table Editor
# If tables exist, skip migration
# If empty, check service key permissions
```

### "Edge Functions not deploying"

**Cause**: CLI not linked or network issue

**Fix**:
```bash
# Re-link
supabase link --project-ref $SUPABASE_PROJECT_REF

# Check CLI version (need v1.62+)
supabase --version
```

### "No data after migration"

**Cause**: Missing SQLite database or service key

**Fix**:
```bash
# Check SQLite exists
ls -lh /tmp/claude-code-kb.db

# Run migration manually
export SUPABASE_SERVICE_KEY="..."
npm run migrate
```

---

## CI/CD Integration

For GitHub Actions:

```yaml
name: Deploy to Supabase

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Setup Node
        uses: actions/setup-node@v3
        with:
          node-version: 18

      - name: Deploy
        env:
          SUPABASE_ACCESS_TOKEN: ${{ secrets.SUPABASE_ACCESS_TOKEN }}
          SUPABASE_PROJECT_REF: ${{ secrets.SUPABASE_PROJECT_REF }}
          SUPABASE_SERVICE_KEY: ${{ secrets.SUPABASE_SERVICE_KEY }}
        run: |
          cd /tmp/supabase
          ./auto-deploy.sh
```

---

## Cost

**Free Tier** ($0/month):
- 500MB database
- 2GB bandwidth
- Unlimited Edge Function requests

**Enough for**:
- ~5,000 knowledge entries
- ~100,000 searches/month
- Small to medium usage

**Pro Tier** ($25/month):
- 8GB database
- 50GB bandwidth
- ~50k entries, 1M+ searches

---

## Next Steps

1. ✅ Deploy with `auto-deploy.sh`
2. ✅ Test with `test-deployment.sh`
3. ✅ Add to Claude Code MCP config
4. 🔄 Set up AI contributor
5. 🔄 Add 100+ entries
6. 🔄 Monitor quality signals

---

**Questions?** See `/tmp/supabase/DEPLOY.md` for detailed guide.

**Ready!** Deploy in ~3 minutes with `auto-deploy.sh` 🚀
