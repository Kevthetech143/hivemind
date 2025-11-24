#!/bin/bash
# clauderepo Supabase Deployment Script

set -e

echo "🚀 clauderepo Supabase Deployment"
echo "=================================="
echo ""

# Check for required env vars
if [ -z "$SUPABASE_URL" ] || [ -z "$SUPABASE_SERVICE_KEY" ]; then
  echo "❌ Missing required environment variables:"
  echo "   SUPABASE_URL - Your Supabase project URL"
  echo "   SUPABASE_SERVICE_KEY - Your service role key"
  echo ""
  echo "Get these from: Supabase Dashboard → Settings → API"
  exit 1
fi

if [ -z "$SUPABASE_PROJECT_REF" ]; then
  echo "❌ Missing SUPABASE_PROJECT_REF"
  echo "   This is the project ID from your Supabase URL"
  echo "   Example: if URL is https://abcdefgh.supabase.co"
  echo "   Then PROJECT_REF is: abcdefgh"
  exit 1
fi

echo "✅ Environment variables set"
echo ""

# Step 1: Install dependencies
echo "📦 Installing dependencies..."
npm install
cd mcp-client && npm install && cd ..
echo "✅ Dependencies installed"
echo ""

# Step 2: Migrate data
echo "📊 Migrating data from SQLite to Supabase..."
npm run migrate
echo "✅ Data migrated"
echo ""

# Step 3: Deploy Edge Functions
echo "🔧 Deploying Edge Functions..."

# Check if supabase CLI is installed
if ! command -v supabase &> /dev/null; then
  echo "❌ Supabase CLI not found. Installing..."
  npm install -g supabase
fi

# Login check
echo "🔐 Checking Supabase authentication..."
supabase projects list > /dev/null 2>&1 || {
  echo "❌ Not logged in. Please run: supabase login"
  exit 1
}

# Link project
echo "🔗 Linking to Supabase project..."
supabase link --project-ref "$SUPABASE_PROJECT_REF"

# Deploy functions
echo "📤 Deploying search function..."
supabase functions deploy search

echo "📤 Deploying contribute function..."
supabase functions deploy contribute

echo "📤 Deploying track function..."
supabase functions deploy track

echo "✅ Edge Functions deployed"
echo ""

# Step 4: Build MCP client
echo "🔨 Building MCP client..."
cd mcp-client
npm run build
echo "✅ MCP client built"
cd ..
echo ""

# Step 5: Generate MCP config
echo "📝 Generating MCP configuration..."
ANON_KEY=$(echo "$SUPABASE_SERVICE_KEY" | sed 's/SERVICE_KEY/ANON_KEY/g')  # This is just for display

cat > mcp-config-template.json <<EOF
{
  "mcpServers": {
    "clauderepo": {
      "command": "node",
      "args": ["$(pwd)/mcp-client/dist/index.js"],
      "env": {
        "SUPABASE_URL": "$SUPABASE_URL",
        "SUPABASE_ANON_KEY": "GET_FROM_SUPABASE_DASHBOARD"
      }
    }
  }
}
EOF

echo "✅ MCP config template created: mcp-config-template.json"
echo ""

# Success!
echo "🎉 Deployment Complete!"
echo ""
echo "Next steps:"
echo "1. Get your SUPABASE_ANON_KEY from Supabase Dashboard → Settings → API"
echo "2. Add the MCP config to ~/.claude/mcp.json (see mcp-config-template.json)"
echo "3. Restart Claude Code"
echo "4. Test: 'Search clauderepo for: MCP timeout'"
echo ""
echo "Your Edge Functions are live at:"
echo "  Search: $SUPABASE_URL/functions/v1/search"
echo "  Contribute: $SUPABASE_URL/functions/v1/contribute"
echo "  Track: $SUPABASE_URL/functions/v1/track"
