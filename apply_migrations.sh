#!/bin/bash
# Apply all new migrations to Supabase

PROJECT_ID="ksethrexopllfhyrxlrb"

# List of new migration files to apply (batches 4-13 + doc batches)
MIGRATIONS=(
  "20251124210000_add_stackoverflow_batch4.sql"
  "20251124210500_add_stackoverflow_batch5.sql"
  "20251124211000_add_stackoverflow_batch6.sql"
  "20251124211500_add_stackoverflow_batch7.sql"
  "20251124212000_add_stackoverflow_batch8.sql"
  "20251124212500_add_stackoverflow_batch9.sql"
  "20251124213000_add_stackoverflow_batch10.sql"
  "20251124213500_add_stackoverflow_batch11.sql"
  "20251124214000_add_stackoverflow_batch12.sql"
  "20251124214500_add_stackoverflow_batch13.sql"
  "20251124210500_add_anthropic_docs_batch1.sql"
  "20251124211000_add_openai_docs_batch1.sql"
  "20251124211500_add_supabase_docs_batch1.sql"
  "20251124212000_add_mcp_docs_batch1.sql"
  "20251124212500_add_playwright_docs_batch1.sql"
  "20251124213000_add_anthropic_streaming_batch1.sql"
  "20251124213500_add_claude_code_docs_batch1.sql"
  "20251124214000_add_nodejs_docs_batch1.sql"
  "20251124215000_add_supabase_realtime_batch1.sql"
  "20251124221000_add_docker_batch1.sql"
  "20251124222500_add_rls_batch1.sql"
)

echo "Applying ${#MIGRATIONS[@]} migrations..."

for migration in "${MIGRATIONS[@]}"; do
  echo "Applying: $migration"
  # Use psql to apply migration (requires connection string)
  # Or use Supabase CLI
done

echo "Done!"
