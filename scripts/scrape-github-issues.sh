#!/bin/bash
# Smart GitHub Issues Scraper - Rate limit aware
# Extracts problems + solutions for clauderepo KB

set -euo pipefail

REPO="anthropics/claude-code"
BATCH_SIZE=30  # Small batches to avoid rate limits
DELAY=2        # Seconds between batches
MAX_ISSUES=300 # Total limit
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

log "Scraping up to $MAX_ISSUES issues in batches of $BATCH_SIZE"
log "Delay between batches: ${DELAY}s"
log "Output directory: $OUTPUT_DIR"

# Calculate number of batches
BATCHES=$(( (MAX_ISSUES + BATCH_SIZE - 1) / BATCH_SIZE ))
SCRAPED=0

for ((i=1; i<=BATCHES; i++)); do
  PAGE=$i
  OUTPUT_FILE="$OUTPUT_DIR/batch_${i}_${TIMESTAMP}.json"

  log "Batch $i/$BATCHES: Fetching $BATCH_SIZE issues..."

  # Fetch batch with retry logic
  RETRY_COUNT=0
  MAX_RETRIES=3

  while [ $RETRY_COUNT -lt $MAX_RETRIES ]; do
    if gh issue list \
      --repo "$REPO" \
      --state closed \
      --limit "$BATCH_SIZE" \
      --json number,title,body,labels,comments,closedAt \
      --page "$PAGE" \
      > "$OUTPUT_FILE" 2>/dev/null; then

      # Count issues in batch
      BATCH_COUNT=$(jq 'length' "$OUTPUT_FILE")

      if [ "$BATCH_COUNT" -eq 0 ]; then
        log "No more issues to fetch"
        rm "$OUTPUT_FILE"
        break 2
      fi

      SCRAPED=$((SCRAPED + BATCH_COUNT))
      WITH_COMMENTS=$(jq '[.[] | select(.comments | length > 0)] | length' "$OUTPUT_FILE")

      log "✓ Fetched $BATCH_COUNT issues ($WITH_COMMENTS with comments)"
      log "Total scraped: $SCRAPED"

      # Check rate limit every 3 batches
      if [ $((i % 3)) -eq 0 ]; then
        REMAINING=$(gh api rate_limit --jq '.resources.core.remaining')
        log "Rate limit remaining: $REMAINING"

        if [ "$REMAINING" -lt 50 ]; then
          warn "Rate limit low. Stopping early to be safe."
          break 2
        fi
      fi

      break
    else
      RETRY_COUNT=$((RETRY_COUNT + 1))
      warn "Request failed. Retry $RETRY_COUNT/$MAX_RETRIES..."
      sleep $((DELAY * RETRY_COUNT))
    fi
  done

  if [ $RETRY_COUNT -eq $MAX_RETRIES ]; then
    error "Failed after $MAX_RETRIES retries"
    exit 1
  fi

  # Stop if we hit max
  if [ "$SCRAPED" -ge "$MAX_ISSUES" ]; then
    log "Reached maximum ($MAX_ISSUES issues)"
    break
  fi

  # Delay between batches
  if [ $i -lt $BATCHES ]; then
    sleep "$DELAY"
  fi
done

# Merge all batch files
log "Merging batches..."
jq -s 'add' "$OUTPUT_DIR"/batch_*.json > "$OUTPUT_DIR/all-issues-${TIMESTAMP}.json"

# Stats
TOTAL=$(jq 'length' "$OUTPUT_DIR/all-issues-${TIMESTAMP}.json")
SOLVED=$(jq '[.[] | select(.comments | length > 0)] | length' "$OUTPUT_DIR/all-issues-${TIMESTAMP}.json")
BUGS=$(jq '[.[] | select(.labels | map(.name) | contains(["bug"]))] | length' "$OUTPUT_DIR/all-issues-${TIMESTAMP}.json")

log ""
log "✅ Scraping complete!"
log "━━━━━━━━━━━━━━━━━━━━━━━━━"
log "Total issues: $TOTAL"
log "With comments: $SOLVED ($(( SOLVED * 100 / TOTAL ))%)"
log "Bug reports: $BUGS"
log ""
log "Output: $OUTPUT_DIR/all-issues-${TIMESTAMP}.json"

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
}' "$OUTPUT_DIR/all-issues-${TIMESTAMP}.json"

log ""
log "Next: Run transform script to convert to clauderepo format"
