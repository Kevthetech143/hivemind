# GitHub Issues Scraper for clauderepo

Automated solution farming from GitHub issues.

## Overview

This scraping pipeline extracts verified solutions from closed GitHub issues and transforms them into clauderepo knowledge base format.

**Sources**: anthropics/claude-code repository (1000+ closed issues)

---

## Safety Features

✅ **Rate Limit Protection**
- Checks rate limit before starting
- Stops if < 100 requests remaining
- Monitors every 3 batches
- Safe default: 300 issues max

✅ **Retry Logic**
- 3 retries on failure
- Exponential backoff
- Graceful error handling

✅ **Batch Processing**
- Small batches (30 issues)
- 2-second delays between batches
- Incremental saves (no data loss)

✅ **Authentication Required**
- Uses `gh` CLI (official GitHub API)
- Must authenticate first: `gh auth login`

---

## Quick Start

### 1. Scrape GitHub Issues

```bash
cd ~/Desktop/clauderepo/scripts
./scrape-github-issues.sh
```

**What it does:**
- Checks your GitHub rate limit
- Fetches 300 closed issues in batches of 30
- 2-second delay between batches
- Saves to `./scraped-issues/all-issues-TIMESTAMP.json`
- Shows stats (total, with comments, bugs)

**Output:**
```
[13:45:00] Checking GitHub API rate limit...
[13:45:01] Rate limit: 4850 / 5000 remaining
[13:45:01] Resets at: 14:45:01
[13:45:01] Scraping up to 300 issues in batches of 30
...
[13:45:45] ✅ Scraping complete!
━━━━━━━━━━━━━━━━━━━━━━━━━
[13:45:45] Total issues: 300
[13:45:45] With comments: 245 (82%)
[13:45:45] Bug reports: 189
[13:45:45] API calls used: 150
[13:45:45] Rate limit remaining: 4700
```

---

### 2. Transform to clauderepo Format

```bash
node transform-issues-to-kb.js \
  ./scraped-issues/all-issues-TIMESTAMP.json \
  clauderepo-entries.json
```

**What it does:**
- Filters issues with solutions (has comments)
- Infers category from labels
- Extracts problem from title + body
- Extracts solution from last comment
- Detects code blocks for commands
- Adds metadata (GitHub issue link, date)

**Output:**
```
📖 Reading ./scraped-issues/all-issues-20251124_134500.json...
Found 300 issues
Issues with comments: 245

📊 Transform complete!
━━━━━━━━━━━━━━━━━━━━━━━━━
Total entries: 187
Skipped: 58

Category breakdown:
  general: 89
  api: 34
  mcp-troubleshooting: 28
  macos: 19
  windows: 11
  security: 6

✅ Wrote 187 entries to clauderepo-entries.json
```

---

### 3. Bulk Insert to clauderepo

```bash
cd ../backend
./add-bulk-entries.sh ../scripts/clauderepo-entries.json
```

**What it does:**
- Validates JSON format
- Inserts entries via REST API
- Uses service role key (bypasses RLS)
- Shows progress for each entry

---

## Configuration

### Adjust scraping limits

Edit `scrape-github-issues.sh`:

```bash
BATCH_SIZE=30   # Issues per batch
DELAY=2         # Seconds between batches
MAX_ISSUES=300  # Total limit
```

**Safe limits:**
- 300 issues = ~150 API calls
- 5000 calls/hour limit
- Plenty of headroom

### Target different repos

```bash
REPO="owner/repo-name"
```

---

## Rate Limits

**GitHub API (authenticated):**
- 5000 requests/hour
- Resets every hour
- Check anytime: `gh api rate_limit`

**This scraper uses:**
- ~0.5 calls per issue (list + details)
- 300 issues = ~150 calls
- Safe for hourly runs

---

## Output Format

### Scraped issues (raw):
```json
[{
  "number": 12272,
  "title": "[Bug] Consistent errors when using default model (Sonnet)",
  "body": "Bug description...",
  "labels": [{"name": "bug"}, {"name": "area:api"}],
  "comments": [{
    "body": "Fixed by updating to version X..."
  }],
  "closedAt": "2025-11-24T..."
}]
```

### Transformed entries (clauderepo format):
```json
[{
  "query": "Consistent errors when using default model (Sonnet)",
  "category": "api",
  "solutions": [{
    "solution": "Fixed by updating to version X",
    "percentage": 85,
    "command": "npm install -g @anthropic-ai/claude-code@latest",
    "note": "From GitHub issue #12272"
  }],
  "prerequisites": "Check GitHub issue for full context",
  "success_indicators": "Issue resolved, error no longer occurs",
  "success_rate": 0.85,
  "source": "github-issue-12272",
  "github_url": "https://github.com/anthropics/claude-code/issues/12272"
}]
```

---

## Quality Filters

**Issues are skipped if:**
- No comments (no solution)
- Body < 20 characters (too vague)
- Solution < 30 characters (too short)
- Solution is just "fixed in version X" (not helpful)

**Result**: ~60-70% of issues with comments become KB entries

---

## Automation

### Run daily via cron:

```bash
0 2 * * * cd ~/Desktop/clauderepo/scripts && ./scrape-github-issues.sh && node transform-issues-to-kb.js ./scraped-issues/all-issues-*.json clauderepo-daily.json && cd ../backend && ./add-bulk-entries.sh ../scripts/clauderepo-daily.json
```

Runs at 2am daily, scrapes → transforms → inserts

---

## Troubleshooting

### "Not authenticated with GitHub"
```bash
gh auth login
```

### "Low rate limit"
Wait until reset time shown, or reduce `MAX_ISSUES`

### "No more issues to fetch"
Repo has fewer issues than `MAX_ISSUES` - normal

### "Failed after 3 retries"
Network issue or GitHub API down. Try again later.

---

## Future Enhancements

- [ ] Multi-repo support (scrape multiple repos)
- [ ] Stack Overflow scraper
- [ ] Reddit r/ClaudeAI scraper
- [ ] Discord export (if API available)
- [ ] Deduplication check (don't import existing solutions)
- [ ] Quality scoring (upvotes, reactions)
- [ ] Automatic categorization (ML-based)

---

**Status**: Production-ready, rate-limit safe
**Last updated**: 2025-11-24
