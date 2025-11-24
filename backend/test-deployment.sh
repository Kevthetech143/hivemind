#!/bin/bash
# Test Supabase Deployment
# Verifies Edge Functions and database are working

set -e

echo "🧪 Testing clauderepo Deployment"
echo "================================"
echo ""

# Check for required vars
if [ -z "$SUPABASE_URL" ] || [ -z "$SUPABASE_ANON_KEY" ]; then
  echo "❌ Missing environment variables"
  echo "   SUPABASE_URL - Your project URL"
  echo "   SUPABASE_ANON_KEY - Your anon key"
  exit 1
fi

echo "🔍 Testing against: $SUPABASE_URL"
echo ""

# Test 1: Search function
echo "1️⃣  Testing search function..."
SEARCH_RESPONSE=$(curl -s -X POST \
  "$SUPABASE_URL/functions/v1/search" \
  -H "Authorization: Bearer $SUPABASE_ANON_KEY" \
  -H "Content-Type: application/json" \
  -d '{"query": "MCP timeout"}')

if echo "$SEARCH_RESPONSE" | grep -q "query"; then
  echo "   ✅ Search function working"

  # Check if results found
  if echo "$SEARCH_RESPONSE" | grep -q "primary_solution"; then
    echo "   ✅ Knowledge entries found"
  else
    echo "   ⚠️  No results found (database might be empty)"
  fi
else
  echo "   ❌ Search function failed"
  echo "   Response: $SEARCH_RESPONSE"
  exit 1
fi
echo ""

# Test 2: Database direct query
echo "2️⃣  Testing database connection..."
DB_COUNT=$(curl -s \
  "$SUPABASE_URL/rest/v1/knowledge_entries?select=count" \
  -H "apikey: $SUPABASE_ANON_KEY" \
  -H "Authorization: Bearer $SUPABASE_ANON_KEY")

if echo "$DB_COUNT" | grep -q "count"; then
  ENTRY_COUNT=$(echo "$DB_COUNT" | grep -o '"count":[0-9]*' | grep -o '[0-9]*')
  echo "   ✅ Database connected"
  echo "   📊 Knowledge entries: $ENTRY_COUNT"
else
  echo "   ❌ Database connection failed"
  exit 1
fi
echo ""

# Test 3: Track function
echo "3️⃣  Testing track function..."
TRACK_RESPONSE=$(curl -s -X POST \
  "$SUPABASE_URL/functions/v1/track" \
  -H "Authorization: Bearer $SUPABASE_ANON_KEY" \
  -H "Content-Type: application/json" \
  -d '{"event_type": "command_copy", "solution_query": "test"}')

if echo "$TRACK_RESPONSE" | grep -q "success\|error"; then
  echo "   ✅ Track function responding"
else
  echo "   ❌ Track function failed"
  echo "   Response: $TRACK_RESPONSE"
  exit 1
fi
echo ""

# Test 4: MCP client build
echo "4️⃣  Testing MCP client..."
if [ -f "mcp-client/dist/index.js" ]; then
  echo "   ✅ MCP client built"
else
  echo "   ❌ MCP client not built"
  echo "   Run: cd mcp-client && npm run build"
  exit 1
fi
echo ""

# Summary
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎉 All tests passed!"
echo ""
echo "Your deployment is working:"
echo "  ✅ Edge Functions deployed"
echo "  ✅ Database connected"
echo "  ✅ $ENTRY_COUNT knowledge entries"
echo "  ✅ MCP client ready"
echo ""
echo "Next: Add to Claude Code MCP config"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
