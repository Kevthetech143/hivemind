#!/bin/bash
# Smart GitHub Issues Scraper - Rate limit aware
# Extracts problems + solutions for clauderepo KB

set -euo pipefail

REPO="anthropics/claude-code"
MAX_ISSUES=300 # Total limit (gh max is 1000)
OUTPUT_DIR="./scraped-issues"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log() { echo -e "${GREEN}[$(date +%H:%M:%S)]${NC} $*"; }
warn() { echo -e "${YELLOW}[$(date +%H:%M:%S)]${NC} $*"; }
error() { echo -e "${RED}[$(date +%H:%M:%S)]${NC} $*"; }

# Check rate limit before starting
check_rate_limit() {
  log "Checking GitHub API rate limit..."
  RATE_LIMIT=$(gh api rate_limit --jq '.resources.core')
  REMAINING=$(echo "$RATE_LIMIT" | jq -r '.remaining')
  LIMIT=$(echo "$RATE_LIMIT" | jq -r '.limit')
  RESET=$(echo "$RATE_LIMIT" | jq -r '.reset')
  RESET_TIME=$(date -r "$RESET" +"%H:%M:%S" 2>/dev/null || date -d "@$RESET" +"%H:%M:%S")

  log "Rate limit: $REMAINING / $LIMIT remaining"
  log "Resets at: $RESET_TIME"

  if [ "$REMAINING" -lt 100 ]; then
    error "Low rate limit ($REMAINING remaining). Wait until $RESET_TIME"
    exit 1
  fi
}

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Check auth
if ! gh auth status &>/dev/null; then
  error "Not authenticated with GitHub. Run: gh auth login"
  exit 1
fi

check_rate_limit

log "Fetching up to $MAX_ISSUES closed issues..."
log "Output directory: $OUTPUT_DIR"

OUTPUT_FILE="$OUTPUT_DIR/all-issues-${TIMESTAMP}.json"

# Fetch with retry logic
RETRY_COUNT=0
MAX_RETRIES=3

while [ $RETRY_COUNT -lt $MAX_RETRIES ]; do
  if gh issue list \
    --repo "$REPO" \
    --state closed \
    --limit "$MAX_ISSUES" \
    --json number,title,body,labels,comments,closedAt \
    > "$OUTPUT_FILE" 2>&1; then

    log "✓ Fetch successful"
    break
  else
    RETRY_COUNT=$((RETRY_COUNT + 1))
    warn "Request failed. Retry $RETRY_COUNT/$MAX_RETRIES..."
    sleep $((2 * RETRY_COUNT))
  fi
done

if [ $RETRY_COUNT -eq $MAX_RETRIES ]; then
  error "Failed after $MAX_RETRIES retries"
  cat "$OUTPUT_FILE" 2>/dev/null || true
  exit 1
fi

# Stats
TOTAL=$(jq 'length' "$OUTPUT_FILE")
SOLVED=$(jq '[.[] | select(.comments | length > 0)] | length' "$OUTPUT_FILE")
BUGS=$(jq '[.[] | select(.labels | map(.name) | contains(["bug"]))] | length' "$OUTPUT_FILE")

log ""
log "✅ Scraping complete!"
log "━━━━━━━━━━━━━━━━━━━━━━━━━"
log "Total issues: $TOTAL"
log "With comments: $SOLVED ($(( SOLVED * 100 / TOTAL ))%)"
log "Bug reports: $BUGS"
log ""
log "Output: $OUTPUT_FILE"

# Check final rate limit
FINAL_REMAINING=$(gh api rate_limit --jq '.resources.core.remaining')
USED=$((REMAINING - FINAL_REMAINING))
log "API calls used: $USED"
log "Rate limit remaining: $FINAL_REMAINING"

# Show sample
log ""
log "Sample issue with solution:"
jq '[.[] | select(.comments | length > 0)] | .[0] | {
  number,
  title,
  labels: [.labels[].name],
  comments_count: .comments | length
}' "$OUTPUT_FILE"

log ""
log "Next: Run transform script to convert to clauderepo format"
