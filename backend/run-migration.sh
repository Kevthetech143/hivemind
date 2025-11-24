#!/bin/bash
# Run migration to add thumbs_up/thumbs_down columns

SUPABASE_URL="https://ksethrexopllfhyrxlrb.supabase.co"
SERVICE_ROLE_KEY="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtzZXRocmV4b3BsbGZoeXJ4bHJiIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2Mzc0NTg4OSwiZXhwIjoyMDc5MzIxODg5fQ.sTbWJmQkfPlBZqA6L89LdYUdyNlr8fq8aRNrKpwx0NY"

echo "Running migration: add thumbs_up/thumbs_down columns..."

curl -X POST "${SUPABASE_URL}/rest/v1/rpc/exec_sql" \
  -H "apikey: ${SERVICE_ROLE_KEY}" \
  -H "Authorization: Bearer ${SERVICE_ROLE_KEY}" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "ALTER TABLE knowledge_entries ADD COLUMN IF NOT EXISTS thumbs_up INTEGER DEFAULT 0, ADD COLUMN IF NOT EXISTS thumbs_down INTEGER DEFAULT 0; CREATE INDEX IF NOT EXISTS idx_thumbs_rating ON knowledge_entries((thumbs_up - thumbs_down) DESC);"
  }'

echo ""
echo "Migration complete!"
