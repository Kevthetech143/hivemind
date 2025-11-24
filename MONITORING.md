# clauderepo Monitoring Guide (Beta Launch)

## Supabase Dashboard Access
**URL**: https://supabase.com/dashboard/project/ksethrexopllfhyrxlrb

---

## Daily Checks (First 2 Weeks)

### 1. Edge Function Logs
**Path**: Dashboard → Functions → Select function → Logs

**Check for**:
- ❌ 429 errors (rate limit exceeded - expected some, but watch for patterns)
- ❌ 500 errors (backend failures - investigate immediately)
- ❌ 401/403 errors (auth issues - should be none after contribute fix)
- ✅ 200 responses (successful requests)

**Command**:
```bash
# Check via MCP
mcp__supabase__get_logs project_id="ksethrexopllfhyrxlrb" service="edge-function"
```

### 2. Database Usage
**Path**: Dashboard → Settings → Usage

**Monitor**:
- **Database Size**: Should stay under 500 MB (free tier)
- **API Requests**: Should stay under 500K/month (free tier)
- **Bandwidth**: Should stay under 5 GB/month (free tier)

**Thresholds**:
- 🟢 < 50% = Normal
- 🟡 50-80% = Watch closely
- 🔴 > 80% = Consider upgrade or optimization

### 3. Rate Limiting Data
**Check abuse patterns**:
```sql
-- Top IPs hitting rate limits
SELECT
  ip_address,
  endpoint,
  request_count,
  window_start
FROM rate_limits
WHERE request_count > 50
ORDER BY request_count DESC
LIMIT 20;
```

**Red flags**:
- Same IP hitting limits repeatedly
- Multiple IPs from same subnet (coordinated abuse)
- Unusual spike in one endpoint

### 4. Thumbs Data Quality
**Check for manipulation**:
```sql
-- Solutions with suspicious voting patterns
SELECT
  query,
  thumbs_up,
  thumbs_down,
  view_count,
  (thumbs_up + thumbs_down) as total_votes
FROM knowledge_entries
WHERE (thumbs_up + thumbs_down) > view_count * 0.5 -- More than 50% vote rate is suspicious
ORDER BY total_votes DESC
LIMIT 10;
```

**Normal**: 5-15% of viewers vote
**Suspicious**: >50% vote rate (possible manipulation)

---

## Weekly Checks

### 1. Growth Metrics
```sql
-- Total solutions
SELECT COUNT(*) FROM knowledge_entries;

-- Total votes
SELECT SUM(thumbs_up + thumbs_down) FROM knowledge_entries;

-- Top solutions by net rating
SELECT query, thumbs_up, thumbs_down, (thumbs_up - thumbs_down) as net_rating
FROM knowledge_entries
ORDER BY net_rating DESC
LIMIT 10;

-- Pending contributions
SELECT COUNT(*) FROM pending_contributions WHERE status = 'pending';
```

### 2. Edge Function Performance
**Path**: Dashboard → Functions → Performance tab

**Check**:
- Average response time (should be < 1000ms)
- Cold start frequency
- Memory usage

### 3. Clean Up Rate Limits
**Manual cleanup** (optional, auto-cleans after 2 hours):
```sql
-- Delete old rate limit entries
SELECT cleanup_rate_limits();
```

---

## Alert Triggers (Manual Check)

| Metric | Threshold | Action |
|--------|-----------|--------|
| 500 errors | > 10/hour | Check logs, investigate backend |
| Rate limit hits | > 100/hour | Check if abuse, consider IP blocking |
| Database size | > 400 MB | Review data growth, optimize |
| API requests | > 400K/month | Plan for upgrade or optimization |
| Suspicious votes | Net rating > 50 on new solution | Manual review, possible spam |

---

## Incident Response

### Edge Function Down
1. Check Supabase status page: https://status.supabase.com/
2. Check function logs for deployment errors
3. Redeploy if needed: `supabase functions deploy <function> --project-ref ksethrexopllfhyrxlrb`

### Database Connection Issues
1. Check database status in dashboard
2. Verify connection pooler settings
3. Check if free tier limits exceeded

### Abuse/Spam Detected
1. Identify IP from rate_limits table
2. Document pattern (what, when, how many)
3. Consider temporary IP block (manual via Supabase RLS)
4. Review and remove spam data if needed

---

## Automation (Future)

For production scale, consider:
- **Grafana/Prometheus**: Real-time dashboards
- **Sentry**: Error tracking and alerts
- **PagerDuty**: On-call notifications
- **Datadog**: Full observability stack

---

## Quick Commands

```bash
# View recent logs
mcp__supabase__get_logs project_id="ksethrexopllfhyrxlrb" service="edge-function"

# Check database
source ~/.claude/scripts/turso-helpers.sh
checkpoint-list

# Test endpoints
curl -X POST "https://ksethrexopllfhyrxlrb.supabase.co/functions/v1/search" \
  -H "Authorization: Bearer <anon_key>" \
  -H "Content-Type: application/json" \
  -d '{"query": "test"}'
```

---

## Contact

If you see persistent issues:
1. Check logs first
2. Review this monitoring guide
3. Create issue: https://github.com/Kevthetech143/clauderepo/issues
4. Tag with `incident` label

---

**Status**: Beta monitoring (manual checks)
**Next**: Automated alerting at 100+ users
