# clauderepo - Supabase Edition ✅

**Everything rebuilt for Supabase-only deployment. No Railway needed.**

## 🚀 NEW: Fully Automated Deployment

**Deploy everything with just an access token. No manual steps.**

```bash
cd /tmp/supabase

# Get from: https://supabase.com/dashboard/account/tokens
export SUPABASE_ACCESS_TOKEN="sbp_xxx..."

# Get from: Your project URL
export SUPABASE_PROJECT_REF="your-project-id"

# One command deploys everything
./auto-deploy.sh
```

**See** → `/tmp/supabase/QUICKSTART.md` for full guide

---

## What Changed

### ❌ Removed
- Railway backend (FastAPI/Python)
- Custom API key management
- Separate deployment services

### ✅ Now Using
- **Supabase Edge Functions** (TypeScript) - replaces FastAPI
- **Supabase Auth** - built-in user management
- **Supabase Postgres** - same database, better integration
- **One service for everything** - simpler, cheaper

## File Structure

```
/tmp/supabase/
├── schema.sql                    # Database schema + RPC functions + RLS
├── functions/
│   ├── search/index.ts          # Search edge function
│   ├── contribute/index.ts      # Contribution edge function
│   └── track/index.ts           # Tracking edge function
├── mcp-client/
│   ├── src/index.ts             # MCP client (connects Claude Code)
│   ├── package.json
│   └── tsconfig.json
├── migrate-data.js              # SQLite → Supabase migration
├── deploy.sh                    # Automated deployment script
├── package.json                 # Migration dependencies
├── DEPLOY.md                    # Detailed deployment guide
└── README.md                    # This file
```

## Quick Deploy

### Prerequisites
1. Create Supabase account: https://supabase.com
2. Create new project in dashboard
3. Get credentials from Settings → API:
   - `SUPABASE_URL` (e.g., https://xxx.supabase.co)
   - `SUPABASE_ANON_KEY` (public key)
   - `SUPABASE_SERVICE_KEY` (secret key)
   - `SUPABASE_PROJECT_REF` (project ID from URL)

### Option 1: Automated Deploy (Recommended)

```bash
cd /tmp/supabase

# Set environment variables
export SUPABASE_URL="https://xxx.supabase.co"
export SUPABASE_SERVICE_KEY="your-service-key"
export SUPABASE_PROJECT_REF="your-project-ref"

# Run deployment script
./deploy.sh
```

This will:
1. ✅ Install dependencies
2. ✅ Migrate 20 knowledge entries from SQLite
3. ✅ Deploy 3 Edge Functions
4. ✅ Build MCP client
5. ✅ Generate MCP config template

**Time**: ~5 minutes

### Option 2: Manual Deploy

See `/tmp/supabase/DEPLOY.md` for step-by-step instructions.

## What I Need From You

To deploy this yourself right now:

1. **Create Supabase project** (2 min)
   - Go to https://app.supabase.com
   - Click "New Project"
   - Wait for provisioning

2. **Share credentials** (you can rotate afterwards):
   ```
   SUPABASE_URL=https://xxx.supabase.co
   SUPABASE_SERVICE_KEY=eyJhbGc...
   SUPABASE_ANON_KEY=eyJhbGc...
   SUPABASE_PROJECT_REF=xxx
   ```

3. **I'll run** (or you can run):
   ```bash
   # Apply schema
   # (paste /tmp/supabase/schema.sql into SQL Editor)

   # Deploy everything
   cd /tmp/supabase && ./deploy.sh
   ```

4. **You rotate keys** after deployment (optional)

## Cost Comparison

| Service | Railway + Supabase | Supabase Only |
|---------|-------------------|---------------|
| Backend | $10-20/month | $0 (included) |
| Database | $0-25/month | $0-25/month |
| **Total** | **$10-45/month** | **$0-25/month** |

**Savings**: $10-20/month by using Supabase Edge Functions instead of Railway.

## Architecture

**Before (Railway + Supabase)**:
```
Claude Code → MCP → Railway API → Supabase DB
                    (FastAPI)
```

**Now (Supabase Only)**:
```
Claude Code → MCP → Supabase Edge Functions → Postgres
                    (Same service!)
```

**Benefits**:
- ✅ One service instead of two
- ✅ No CORS issues (same origin)
- ✅ Built-in auth
- ✅ Lower latency (no external API call)
- ✅ Cheaper ($10-20/month savings)
- ✅ Simpler deployment

## Testing After Deploy

Once deployed, test in Claude Code:

```
Search clauderepo for: "MCP connection refused"
```

Should return ranked solutions with:
- Primary solution (85% confidence)
- Prerequisites
- Success validation steps
- Related solutions

## Next Steps After Deployment

1. ✅ Test search from Claude Code
2. ✅ Test contribution submission
3. 🔄 Set up AI contributor
4. 🔄 Add 100+ entries
5. 🔄 Monitor implicit quality signals
6. 🔄 Iterate on ranking

## Support

- **Deployment guide**: `/tmp/supabase/DEPLOY.md`
- **Schema details**: `/tmp/supabase/schema.sql`
- **MCP client**: `/tmp/supabase/mcp-client/src/index.ts`

---

**Status**: ✅ Ready to deploy

**What you need**: Supabase account + 5 minutes
