#!/bin/bash
# Run migration via Supabase Management API

PROJECT_REF="ksethrexopllfhyrxlrb"
MIGRATION_SQL="ALTER TABLE knowledge_entries ADD COLUMN IF NOT EXISTS thumbs_up INTEGER DEFAULT 0, ADD COLUMN IF NOT EXISTS thumbs_down INTEGER DEFAULT 0; CREATE INDEX IF NOT EXISTS idx_thumbs_rating ON knowledge_entries((thumbs_up - thumbs_down) DESC);"

echo "Running migration..."
echo "SQL: $MIGRATION_SQL"
echo ""

# Try via psql connection string
PGPASSWORD="Cali4nia12!$" psql "postgresql://postgres.ksethrexopllfhyrxlrb:Cali4nia12!$@aws-0-us-west-2.pooler.supabase.com:6543/postgres" -c "$MIGRATION_SQL"

if [ $? -eq 0 ]; then
    echo "✅ Migration successful"
else
    echo "❌ Migration failed"
fi
