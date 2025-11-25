#!/bin/bash
# clauderepo Admin Moderation Tools
# Usage: ./scripts/admin/admin.sh <command> [args]

set -e

# Load environment
if [ -f .env.local ]; then
    source .env.local
else
    echo "Error: .env.local not found"
    exit 1
fi

PSQL="/usr/local/opt/libpq/bin/psql"
DB_URL="$DATABASE_URL"

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# ===========================================
# PENDING CONTRIBUTIONS MANAGEMENT
# ===========================================

list_pending() {
    echo -e "${YELLOW}📋 Pending Contributions (last 20)${NC}\n"
    $PSQL "$DB_URL" -c "
        SELECT
            id,
            LEFT(query, 50) as query_preview,
            category,
            contributor_email,
            submitted_at,
            status
        FROM pending_contributions
        WHERE status = 'pending_review'
        ORDER BY submitted_at DESC
        LIMIT 20;
    "
}

show_pending() {
    local pending_id=$1
    if [ -z "$pending_id" ]; then
        echo "Usage: admin.sh show-pending <id>"
        exit 1
    fi

    echo -e "${YELLOW}📄 Pending Contribution #$pending_id${NC}\n"
    $PSQL "$DB_URL" -c "
        SELECT
            id,
            query,
            category,
            hit_frequency,
            solutions::text,
            prerequisites,
            success_indicators,
            common_pitfalls,
            success_rate,
            contributor_email,
            submitted_at,
            status
        FROM pending_contributions
        WHERE id = $pending_id;
    " --expanded
}

approve() {
    local pending_id=$1
    if [ -z "$pending_id" ]; then
        echo "Usage: admin.sh approve <id>"
        exit 1
    fi

    echo -e "${YELLOW}✅ Approving contribution #$pending_id...${NC}"

    result=$($PSQL "$DB_URL" -t -c "SELECT approve_contribution($pending_id);")

    if echo "$result" | grep -q "error"; then
        echo -e "${RED}❌ Error: $result${NC}"
        exit 1
    else
        echo -e "${GREEN}✅ Contribution approved and published!${NC}"
        echo "$result" | jq '.'
    fi
}

reject() {
    local pending_id=$1
    local reason=$2

    if [ -z "$pending_id" ] || [ -z "$reason" ]; then
        echo "Usage: admin.sh reject <id> \"reason\""
        exit 1
    fi

    echo -e "${YELLOW}❌ Rejecting contribution #$pending_id...${NC}"

    result=$($PSQL "$DB_URL" -t -c "SELECT reject_contribution($pending_id, '$reason');")

    if echo "$result" | grep -q "error"; then
        echo -e "${RED}❌ Error: $result${NC}"
        exit 1
    else
        echo -e "${GREEN}✅ Contribution rejected${NC}"
        echo "$result" | jq '.'
    fi
}

pending_summary() {
    echo -e "${YELLOW}📊 Pending Queue Summary${NC}\n"
    $PSQL "$DB_URL" -t -c "SELECT get_pending_summary();" | jq '.'
}

# ===========================================
# IP BANNING
# ===========================================

ban() {
    local ip=$1
    local reason=$2
    local days=$3

    if [ -z "$ip" ] || [ -z "$reason" ]; then
        echo "Usage: admin.sh ban <ip> \"reason\" [days]"
        echo "  days: optional, omit for permanent ban"
        exit 1
    fi

    if [ -z "$days" ]; then
        echo -e "${YELLOW}🚫 Permanently banning IP: $ip${NC}"
        result=$($PSQL "$DB_URL" -t -c "SELECT ban_ip('$ip', '$reason');")
    else
        echo -e "${YELLOW}🚫 Banning IP: $ip for $days days${NC}"
        result=$($PSQL "$DB_URL" -t -c "SELECT ban_ip('$ip', '$reason', $days);")
    fi

    echo -e "${GREEN}✅ IP banned${NC}"
    echo "$result" | jq '.'
}

unban() {
    local ip=$1

    if [ -z "$ip" ]; then
        echo "Usage: admin.sh unban <ip>"
        exit 1
    fi

    echo -e "${YELLOW}✅ Unbanning IP: $ip${NC}"
    $PSQL "$DB_URL" -c "SELECT unban_ip('$ip');"
    echo -e "${GREEN}✅ IP unbanned${NC}"
}

list_banned() {
    echo -e "${YELLOW}🚫 Banned IPs${NC}\n"
    $PSQL "$DB_URL" -c "
        SELECT
            ip_address,
            reason,
            banned_at,
            CASE
                WHEN expires_at IS NULL THEN 'Permanent'
                ELSE expires_at::text
            END as expires
        FROM banned_ips
        ORDER BY banned_at DESC
        LIMIT 50;
    "
}

check_ip() {
    local ip=$1

    if [ -z "$ip" ]; then
        echo "Usage: admin.sh check-ip <ip>"
        exit 1
    fi

    echo -e "${YELLOW}🔍 Checking IP: $ip${NC}\n"

    # Check if banned
    is_banned=$($PSQL "$DB_URL" -t -c "SELECT is_ip_banned('$ip');")
    if [ "$is_banned" = " t" ]; then
        echo -e "${RED}❌ IP is BANNED${NC}"
    else
        echo -e "${GREEN}✅ IP is NOT banned${NC}"
    fi

    # Check activity
    echo -e "\n${YELLOW}Recent Activity:${NC}"
    $PSQL "$DB_URL" -t -c "SELECT check_suspicious_activity('$ip');" | jq '.'
}

# ===========================================
# KNOWLEDGE BASE MANAGEMENT
# ===========================================

delete_solution() {
    local knowledge_id=$1

    if [ -z "$knowledge_id" ]; then
        echo "Usage: admin.sh delete-solution <knowledge_id>"
        exit 1
    fi

    echo -e "${RED}⚠️  Deleting solution #$knowledge_id...${NC}"
    read -p "Are you sure? (yes/no): " confirm

    if [ "$confirm" != "yes" ]; then
        echo "Cancelled"
        exit 0
    fi

    result=$($PSQL "$DB_URL" -t -c "SELECT delete_solution($knowledge_id);")

    if echo "$result" | grep -q "error"; then
        echo -e "${RED}❌ Error: $result${NC}"
        exit 1
    else
        echo -e "${GREEN}✅ Solution deleted${NC}"
    fi
}

search_solutions() {
    local query=$1

    if [ -z "$query" ]; then
        echo "Usage: admin.sh search-solutions \"query\""
        exit 1
    fi

    echo -e "${YELLOW}🔍 Searching: $query${NC}\n"
    $PSQL "$DB_URL" -c "
        SELECT
            id,
            LEFT(query, 60) as query_preview,
            category,
            success_rate,
            view_count,
            thumbs_up,
            thumbs_down,
            created_at
        FROM knowledge_entries
        WHERE
            query ILIKE '%$query%'
            OR category ILIKE '%$query%'
        ORDER BY created_at DESC
        LIMIT 20;
    "
}

# ===========================================
# ANALYTICS
# ===========================================

stats() {
    echo -e "${YELLOW}📊 clauderepo Statistics${NC}\n"

    $PSQL "$DB_URL" -c "
        SELECT
            'Total Solutions' as metric,
            COUNT(*)::text as value
        FROM knowledge_entries
        UNION ALL
        SELECT
            'Pending Review',
            COUNT(*)::text
        FROM pending_contributions
        WHERE status = 'pending_review'
        UNION ALL
        SELECT
            'Resolved Tickets',
            COUNT(*)::text
        FROM troubleshooting_sessions
        WHERE status = 'resolved'
        UNION ALL
        SELECT
            'Banned IPs',
            COUNT(*)::text
        FROM banned_ips
        UNION ALL
        SELECT
            'Solutions Added (24h)',
            COUNT(*)::text
        FROM knowledge_entries
        WHERE created_at > NOW() - INTERVAL '24 hours'
        UNION ALL
        SELECT
            'Contributions (24h)',
            COUNT(*)::text
        FROM pending_contributions
        WHERE submitted_at > NOW() - INTERVAL '24 hours';
    "
}

recent_activity() {
    echo -e "${YELLOW}📈 Recent Activity (Last 24 Hours)${NC}\n"

    echo -e "${YELLOW}Pending Contributions:${NC}"
    $PSQL "$DB_URL" -c "
        SELECT
            id,
            LEFT(query, 50) as query,
            category,
            contributor_email,
            submitted_at
        FROM pending_contributions
        WHERE submitted_at > NOW() - INTERVAL '24 hours'
        ORDER BY submitted_at DESC;
    "

    echo -e "\n${YELLOW}Resolved Tickets:${NC}"
    $PSQL "$DB_URL" -c "
        SELECT
            ticket_id,
            LEFT(problem, 50) as problem,
            category,
            resolved_at
        FROM troubleshooting_sessions
        WHERE resolved_at > NOW() - INTERVAL '24 hours'
        ORDER BY resolved_at DESC;
    "
}

# ===========================================
# HELP
# ===========================================

show_help() {
    cat << EOF
${YELLOW}clauderepo Admin Tools${NC}

${GREEN}Pending Contributions:${NC}
  list-pending              List pending contributions (last 20)
  show-pending <id>         Show full details of pending contribution
  approve <id>              Approve and publish contribution
  reject <id> "reason"      Reject contribution with reason
  pending-summary           Show queue summary

${GREEN}IP Management:${NC}
  ban <ip> "reason" [days]  Ban an IP (omit days for permanent)
  unban <ip>                Unban an IP
  list-banned               List all banned IPs
  check-ip <ip>             Check IP status and activity

${GREEN}Knowledge Base:${NC}
  delete-solution <id>      Delete a solution from KB
  search-solutions "query"  Search for solutions

${GREEN}Analytics:${NC}
  stats                     Show overall statistics
  recent-activity           Show activity in last 24 hours

${GREEN}Examples:${NC}
  ./scripts/admin/admin.sh list-pending
  ./scripts/admin/admin.sh approve 5
  ./scripts/admin/admin.sh reject 6 "Spam content"
  ./scripts/admin/admin.sh ban "1.2.3.4" "Malicious submissions" 7
  ./scripts/admin/admin.sh stats

EOF
}

# ===========================================
# MAIN
# ===========================================

case "$1" in
    list-pending)
        list_pending
        ;;
    show-pending)
        show_pending "$2"
        ;;
    approve)
        approve "$2"
        ;;
    reject)
        reject "$2" "$3"
        ;;
    pending-summary)
        pending_summary
        ;;
    ban)
        ban "$2" "$3" "$4"
        ;;
    unban)
        unban "$2"
        ;;
    list-banned)
        list_banned
        ;;
    check-ip)
        check_ip "$2"
        ;;
    delete-solution)
        delete_solution "$2"
        ;;
    search-solutions)
        search_solutions "$2"
        ;;
    stats)
        stats
        ;;
    recent-activity)
        recent_activity
        ;;
    help|--help|-h|"")
        show_help
        ;;
    *)
        echo -e "${RED}Unknown command: $1${NC}"
        show_help
        exit 1
        ;;
esac
