# clauderepo Admin Guide

## Daily Workflow (10-15 minutes)

### Morning Routine

```bash
cd /Users/admin/Desktop/clauderepo

# Check pending queue
./scripts/admin/admin.sh pending-summary

# Review pending items
./scripts/admin/admin.sh list-pending
```

### Review Each Item

```bash
# Show full details
./scripts/admin/admin.sh show-pending 123

# If good quality → Approve
./scripts/admin/admin.sh approve 123

# If spam/low quality → Reject
./scripts/admin/admin.sh reject 123 "Duplicate solution"
```

### Check for Abuse

```bash
# Daily stats
./scripts/admin/admin.sh stats

# Recent activity
./scripts/admin/admin.sh recent-activity

# Check suspicious IP
./scripts/admin/admin.sh check-ip "1.2.3.4"
```

---

## Common Scenarios

### Scenario 1: Spam Submission

```bash
# 1. Check the contribution
./scripts/admin/admin.sh show-pending 45

# 2. Reject it
./scripts/admin/admin.sh reject 45 "Spam content"

# 3. Ban the IP (7 day ban)
./scripts/admin/admin.sh ban "1.2.3.4" "Spam submissions" 7
```

### Scenario 2: Good Quality Ticket Resolution

```bash
# 1. Review the ticket-based contribution
./scripts/admin/admin.sh show-pending 50

# 2. Verify it makes sense
# (contributor_email will be "ticket-based")

# 3. Approve if good
./scripts/admin/admin.sh approve 50
```

### Scenario 3: Malicious Commands

```bash
# 1. See malicious bash command in solution
./scripts/admin/admin.sh show-pending 60

# 2. Reject immediately
./scripts/admin/admin.sh reject 60 "Malicious command"

# 3. Permanent IP ban
./scripts/admin/admin.sh ban "1.2.3.4" "Malicious commands"
```

### Scenario 4: Delete Published Solution

```bash
# 1. Find the solution
./scripts/admin/admin.sh search-solutions "bad content"

# 2. Delete it
./scripts/admin/admin.sh delete-solution 789
```

---

## Quality Guidelines

### ✅ **Approve** if:
- Problem description is clear
- Solutions are actionable
- Commands are safe (no rm -rf, no eval, etc.)
- Prerequisites make sense
- Success indicators are verifiable
- Contributor email looks legitimate (or ticket-based)

### ❌ **Reject** if:
- Duplicate of existing solution
- Vague or unclear solution
- Contains malicious commands
- Spam or gibberish
- No actual troubleshooting value
- Success rate seems fabricated

---

## Security Red Flags

### Immediate Rejection + Ban:
- `rm -rf /`
- `eval $(curl ...)`
- `sudo chmod 777 /`
- SQL injection attempts
- XSS scripts (`<script>alert()</script>`)
- Credential harvesting commands

### Suspicious Patterns:
- Same IP submitting 5+ in short time
- Generic solutions with no specifics
- Copy-pasted Stack Overflow without attribution
- Unrealistic success rates (100%)

---

## IP Banning Best Practices

### Temporary Bans (7-30 days):
- First offense spam
- Multiple low-quality submissions
- Excessive rate limit hits

```bash
./scripts/admin/admin.sh ban "1.2.3.4" "Spam" 7
```

### Permanent Bans:
- Malicious commands
- Repeated offenses after temp ban
- Automated bot behavior

```bash
./scripts/admin/admin.sh ban "1.2.3.4" "Malicious activity"
```

### Unban if Needed:
```bash
./scripts/admin/admin.sh unban "1.2.3.4"
```

---

## Monitoring Alerts

Set up daily cron job to email you:

```bash
# Add to crontab: crontab -e
0 9 * * * cd /Users/admin/Desktop/clauderepo && ./scripts/admin/admin.sh pending-summary | mail -s "clauderepo Pending Queue" your-email@example.com
```

Or check manually each morning.

---

## Quick Reference Card

```bash
# Morning check
./scripts/admin/admin.sh stats
./scripts/admin/admin.sh list-pending

# Approve/reject
./scripts/admin/admin.sh approve <id>
./scripts/admin/admin.sh reject <id> "reason"

# Security
./scripts/admin/admin.sh ban <ip> "reason" [days]
./scripts/admin/admin.sh check-ip <ip>

# Cleanup
./scripts/admin/admin.sh delete-solution <id>
```

---

## Expected Volume (50 users)

- **Pending queue**: 2-5 new items/day
- **Spam/low quality**: 1-2/day
- **Ban rate**: 1-2 IPs/week
- **Time commitment**: 10-15 min/day

---

## Escalation

If queue grows > 20 pending:
1. Dedicate 1 hour to clear backlog
2. Consider stricter rate limits
3. Build automated filters
4. Consider admin MCP for faster workflow

If abuse is overwhelming:
1. Temporarily disable contributions endpoint
2. Review all banned IPs
3. Consider requiring email verification
4. Build admin MCP with approval workflow
