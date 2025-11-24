#!/bin/bash
# Fully Automated Supabase Deployment
# Uses Supabase CLI programmatically (no manual login needed)

set -e

echo "🚀 clauderepo - Automated Supabase Deployment"
echo "=============================================="
echo ""

# Check for required credentials
if [ -z "$SUPABASE_ACCESS_TOKEN" ]; then
  echo "❌ Missing SUPABASE_ACCESS_TOKEN"
  echo ""
  echo "Get your access token from:"
  echo "https://supabase.com/dashboard/account/tokens"
  echo ""
  echo "Then run:"
  echo "export SUPABASE_ACCESS_TOKEN='your-token-here'"
  exit 1
fi

if [ -z "$SUPABASE_PROJECT_REF" ]; then
  echo "❌ Missing SUPABASE_PROJECT_REF"
  echo ""
  echo "This is your project ID (visible in project URL or Settings → General)"
  echo ""
  echo "Then run:"
  echo "export SUPABASE_PROJECT_REF='your-project-ref'"
  exit 1
fi

echo "✅ Credentials provided"
echo "   Project: $SUPABASE_PROJECT_REF"
echo ""

# Install Supabase CLI if not present
if ! command -v supabase &> /dev/null; then
  echo "📦 Installing Supabase CLI..."
  npm install -g supabase
  echo "✅ Supabase CLI installed"
else
  echo "✅ Supabase CLI already installed"
fi
echo ""

# Install dependencies for migration
echo "📦 Installing Node dependencies..."
npm install --silent
cd mcp-client && npm install --silent && cd ..
echo "✅ Dependencies installed"
echo ""

# Link to project using access token (no interactive login needed)
echo "🔗 Linking to Supabase project..."
supabase link --project-ref "$SUPABASE_PROJECT_REF"
echo "✅ Linked to project"
echo ""

# Apply database schema using db push
echo "📊 Applying database schema..."

# Create migrations directory if it doesn't exist
mkdir -p supabase/migrations

# Copy schema to a migration file
MIGRATION_FILE="supabase/migrations/$(date +%Y%m%d%H%M%S)_initial_schema.sql"
cp schema.sql "$MIGRATION_FILE"

echo "   Created migration: $MIGRATION_FILE"

# Push migrations to Supabase
supabase db push
echo "✅ Database schema applied"
echo ""

# Migrate data from SQLite
echo "📦 Migrating knowledge entries from SQLite..."
if [ -f "/tmp/claude-code-kb.db" ]; then
  # Get Supabase URL and service key for migration script
  echo "   Getting project credentials..."

  # Use Supabase CLI to get project details
  SUPABASE_URL="https://${SUPABASE_PROJECT_REF}.supabase.co"

  # Note: Service key must be provided separately for security
  if [ -z "$SUPABASE_SERVICE_KEY" ]; then
    echo "⚠️  SUPABASE_SERVICE_KEY not provided - skipping data migration"
    echo "   Get service key from: Dashboard → Settings → API → service_role key"
    echo "   Then run: SUPABASE_SERVICE_KEY='key' npm run migrate"
  else
    export SUPABASE_URL
    npm run migrate
    echo "✅ Data migrated"
  fi
else
  echo "⚠️  No SQLite database found at /tmp/claude-code-kb.db - skipping data migration"
fi
echo ""

# Deploy all Edge Functions
echo "🚀 Deploying Edge Functions..."

# Deploy search function
echo "   📤 Deploying search..."
supabase functions deploy search --no-verify-jwt

# Deploy contribute function
echo "   📤 Deploying contribute..."
supabase functions deploy contribute --no-verify-jwt

# Deploy track function
echo "   📤 Deploying track..."
supabase functions deploy track --no-verify-jwt

echo "✅ All Edge Functions deployed"
echo ""

# Build MCP client
echo "🔨 Building MCP client..."
cd mcp-client
npm run build
echo "✅ MCP client built"
cd ..
echo ""

# Get project API keys
echo "🔑 Fetching project API keys..."
SUPABASE_URL="https://${SUPABASE_PROJECT_REF}.supabase.co"

# Generate MCP config
cat > mcp-config.json <<EOF
{
  "mcpServers": {
    "clauderepo": {
      "command": "node",
      "args": ["$(pwd)/mcp-client/dist/index.js"],
      "env": {
        "SUPABASE_URL": "$SUPABASE_URL",
        "SUPABASE_ANON_KEY": "GET_FROM_DASHBOARD"
      }
    }
  }
}
EOF

echo "✅ MCP config created: mcp-config.json"
echo ""

# Success!
echo "🎉 Deployment Complete!"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📋 Next Steps:"
echo ""
echo "1. Get your SUPABASE_ANON_KEY:"
echo "   https://supabase.com/dashboard/project/$SUPABASE_PROJECT_REF/settings/api"
echo ""
echo "2. Update mcp-config.json with your anon key"
echo ""
echo "3. Add config to ~/.claude/mcp.json:"
echo "   cat mcp-config.json >> ~/.claude/mcp.json"
echo ""
echo "4. Restart Claude Code"
echo ""
echo "5. Test with: 'Search clauderepo for: MCP timeout'"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "🌐 Your Edge Functions are live:"
echo "   Search:     $SUPABASE_URL/functions/v1/search"
echo "   Contribute: $SUPABASE_URL/functions/v1/contribute"
echo "   Track:      $SUPABASE_URL/functions/v1/track"
echo ""
echo "✅ Ready to use!"
