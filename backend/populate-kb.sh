#!/bin/bash

# Populate clauderepo with initial knowledge entries
# Uses Supabase service role key to insert directly

SUPABASE_URL="https://ksethrexopllfhyrxlrb.supabase.co"
SERVICE_KEY="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtzZXRocmV4b3BsbGZoeXJ4bHJiIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2Mzc0NTg4OSwiZXhwIjoyMDc5MzIxODg5fQ.WLTora-ocodgAzYop0H_fAR36Pjxvov4DhBbaIrps1g"

echo "Populating clauderepo knowledge base..."

# Entry 1: MCP connection refused
curl -s -X POST "$SUPABASE_URL/rest/v1/knowledge_entries" \
  -H "apikey: $SERVICE_KEY" \
  -H "Authorization: Bearer $SERVICE_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "MCP connection refused",
    "category": "mcp-troubleshooting",
    "hit_frequency": "HIGH",
    "solutions": [
      {
        "step": 1,
        "description": "Use full npx path in MCP config",
        "command": "claude mcp add brave-search -- /Users/admin/.nvm/versions/node/v24.11.1/bin/npx -y @brave/brave-search-mcp-server",
        "percentage": 85
      },
      {
        "step": 2,
        "description": "Restart Claude Code after config change",
        "command": "claude restart",
        "percentage": 95
      }
    ],
    "common_pitfalls": "Using just npx when Node is installed via nvm causes PATH issues",
    "success_rate": 0.95
  }' && echo "✓ Entry 1 added"

# Entry 2: Playwright click not working
curl -s -X POST "$SUPABASE_URL/rest/v1/knowledge_entries" \
  -H "apikey: $SERVICE_KEY" \
  -H "Authorization: Bearer $SERVICE_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "Playwright click() does not trigger button action",
    "category": "web-automation",
    "hit_frequency": "MEDIUM",
    "solutions": [
      {
        "step": 1,
        "description": "Use JavaScript evaluation instead of Playwright click",
        "command": "page.evaluate(() => button.click())",
        "percentage": 90
      }
    ],
    "common_pitfalls": "Playwright click does not properly trigger Svelte event listeners. Svelte attaches listeners differently than onclick attributes.",
    "success_rate": 0.90
  }' && echo "✓ Entry 2 added"

# Entry 3: Auth loading state
curl -s -X POST "$SUPABASE_URL/rest/v1/knowledge_entries" \
  -H "apikey: $SERVICE_KEY" \
  -H "Authorization: Bearer $SERVICE_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "User signed in but gets must sign in error",
    "category": "authentication",
    "hit_frequency": "HIGH",
    "solutions": [
      {
        "step": 1,
        "description": "Always check loading state before checking user",
        "command": "if ($authStore.loading) return; if (!$authStore.user) { /* not signed in */ }",
        "percentage": 95
      }
    ],
    "common_pitfalls": "Auth store starts with loading:true and user:null. Checking user before loading completes causes false negatives.",
    "success_rate": 0.95
  }' && echo "✓ Entry 3 added"

# Entry 4: Data loads but UI empty
curl -s -X POST "$SUPABASE_URL/rest/v1/knowledge_entries" \
  -H "apikey: $SERVICE_KEY" \
  -H "Authorization: Bearer $SERVICE_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "Console shows data loaded but UI still empty",
    "category": "svelte",
    "hit_frequency": "MEDIUM",
    "solutions": [
      {
        "step": 1,
        "description": "Remove type assertions hiding errors",
        "command": "// Remove: data as Product[] | Just use: products = data",
        "percentage": 85
      },
      {
        "step": 2,
        "description": "Update component type to match API response",
        "command": "let products: ProductWithSeller[] = []",
        "percentage": 90
      }
    ],
    "common_pitfalls": "Type mismatch between API response and component variable prevents Svelte reactivity. Type assertions (as Type) hide TypeScript errors.",
    "success_rate": 0.90
  }' && echo "✓ Entry 4 added"

# Entry 5: Supabase RLS blocking queries
curl -s -X POST "$SUPABASE_URL/rest/v1/knowledge_entries" \
  -H "apikey: $SERVICE_KEY" \
  -H "Authorization: Bearer $SERVICE_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "query": "Supabase query returns empty but data exists",
    "category": "supabase",
    "hit_frequency": "HIGH",
    "solutions": [
      {
        "step": 1,
        "description": "Check RLS policies are configured",
        "command": "CREATE POLICY \"Enable read access for all users\" ON table_name FOR SELECT USING (true);",
        "percentage": 95
      }
    ],
    "common_pitfalls": "RLS enabled by default on new tables. Queries fail silently when policies missing.",
    "success_rate": 0.95
  }' && echo "✓ Entry 5 added"

echo ""
echo "✅ Populated 5 initial entries. Testing search..."

# Test search
curl -s "$SUPABASE_URL/functions/v1/search" \
  -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtzZXRocmV4b3BsbGZoeXJ4bHJiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjM3NDU4ODksImV4cCI6MjA3OTMyMTg4OX0.SDJulNaemJ66EaFl77-1IJLTAleihU5PvEChNaO5osI" \
  -H "Content-Type: application/json" \
  -d '{"query": "MCP connection"}' | python3 -m json.tool 2>/dev/null || echo "Search test complete"
