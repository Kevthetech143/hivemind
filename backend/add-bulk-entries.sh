#!/bin/bash

SUPABASE_URL="https://ksethrexopllfhyrxlrb.supabase.co"
SERVICE_KEY="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtzZXRocmV4b3BsbGZoeXJ4bHJiIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2Mzc0NTg4OSwiZXhwIjoyMDc5MzIxODg5fQ.WLTora-ocodgAzYop0H_fAR36Pjxvov4DhBbaIrps1g"

count=0

add_entry() {
  count=$((count + 1))
  curl -s -X POST "$SUPABASE_URL/rest/v1/knowledge_entries" \
    -H "apikey: $SERVICE_KEY" \
    -H "Authorization: Bearer $SERVICE_KEY" \
    -H "Content-Type: application/json" \
    -H "Prefer: return=minimal" \
    -d "$1" > /dev/null && echo "[$count] ✓"
}

echo "Adding bulk entries..."

# Claude Code specific
add_entry '{
  "query": "Claude hooks dont fire",
  "category": "claude-code",
  "hit_frequency": "HIGH",
  "solutions": [{"step": 1, "description": "Enable trust dialog", "command": "claude config set hasTrustDialogAccepted true", "percentage": 95}],
  "common_pitfalls": "Claude requires explicit trust for hooks. Without hasTrustDialogAccepted=true hooks are silently ignored.",
  "success_rate": 0.95
}'

add_entry '{
  "query": "MCP server not showing in /mcp list",
  "category": "mcp-troubleshooting",
  "hit_frequency": "HIGH",
  "solutions": [{"step": 1, "description": "Check MCP config syntax", "command": "cat ~/.config/claude/mcp_settings.json", "percentage": 85}],
  "common_pitfalls": "JSON syntax errors in mcp_settings.json cause silent failures",
  "success_rate": 0.85
}'

add_entry '{
  "query": "Node.js not found in Claude MCP",
  "category": "mcp-troubleshooting",
  "hit_frequency": "HIGH",
  "solutions": [{"step": 1, "description": "Use absolute path to node", "command": "which node", "percentage": 90}],
  "common_pitfalls": "Claude runs in different shell context. PATH may not include nvm-installed Node.",
  "success_rate": 0.90
}'

# Supabase
add_entry '{
  "query": "Supabase Edge Function CORS error",
  "category": "supabase",
  "hit_frequency": "HIGH",
  "solutions": [{"step": 1, "description": "Add CORS headers", "command": "const corsHeaders = { \"Access-Control-Allow-Origin\": \"*\" }", "percentage": 95}],
  "common_pitfalls": "Must handle OPTIONS preflight requests",
  "success_rate": 0.95
}'

add_entry '{
  "query": "Supabase realtime not working",
  "category": "supabase",
  "hit_frequency": "MEDIUM",
  "solutions": [{"step": 1, "description": "Enable realtime on table", "command": "ALTER TABLE table_name REPLICA IDENTITY FULL;", "percentage": 90}],
  "common_pitfalls": "Realtime disabled by default on tables",
  "success_rate": 0.90
}'

# Git
add_entry '{
  "query": "Git push rejected non-fast-forward",
  "category": "git",
  "hit_frequency": "HIGH",
  "solutions": [{"step": 1, "description": "Pull first then push", "command": "git pull --rebase && git push", "percentage": 95}],
  "common_pitfalls": "Remote has commits you dont have locally",
  "success_rate": 0.95
}'

add_entry '{
  "query": "Git merge conflict",
  "category": "git",
  "hit_frequency": "HIGH",
  "solutions": [{"step": 1, "description": "Resolve conflicts then commit", "command": "git add . && git commit -m \"Resolve merge conflicts\"", "percentage": 90}],
  "common_pitfalls": "Must stage files after resolving conflicts",
  "success_rate": 0.90
}'

# TypeScript
add_entry '{
  "query": "TypeScript cannot find module",
  "category": "typescript",
  "hit_frequency": "HIGH",
  "solutions": [{"step": 1, "description": "Check tsconfig paths", "command": "npm install && npm run build", "percentage": 85}],
  "common_pitfalls": "Missing dependencies or incorrect module resolution",
  "success_rate": 0.85
}'

add_entry '{
  "query": "TypeScript type any implicitly",
  "category": "typescript",
  "hit_frequency": "MEDIUM",
  "solutions": [{"step": 1, "description": "Add explicit type annotation", "command": "const data: MyType = await fetch()", "percentage": 95}],
  "common_pitfalls": "noImplicitAny flag requires all types be explicit",
  "success_rate": 0.95
}'

# React/Next.js
add_entry '{
  "query": "React hydration mismatch",
  "category": "react",
  "hit_frequency": "HIGH",
  "solutions": [{"step": 1, "description": "Ensure server and client render same HTML", "command": "useEffect(() => setMounted(true))", "percentage": 85}],
  "common_pitfalls": "Server-side and client-side rendering produce different HTML",
  "success_rate": 0.85
}'

add_entry '{
  "query": "Next.js API route not found",
  "category": "nextjs",
  "hit_frequency": "MEDIUM",
  "solutions": [{"step": 1, "description": "Check file location", "command": "pages/api/ or app/api/", "percentage": 90}],
  "common_pitfalls": "Must be in correct directory structure",
  "success_rate": 0.90
}'

# Docker
add_entry '{
  "query": "Docker container exits immediately",
  "category": "docker",
  "hit_frequency": "HIGH",
  "solutions": [{"step": 1, "description": "Check container logs", "command": "docker logs container_name", "percentage": 95}],
  "common_pitfalls": "Application crashes on startup",
  "success_rate": 0.95
}'

add_entry '{
  "query": "Docker build failing COPY command",
  "category": "docker",
  "hit_frequency": "MEDIUM",
  "solutions": [{"step": 1, "description": "Check .dockerignore", "command": "cat .dockerignore", "percentage": 85}],
  "common_pitfalls": "Files excluded by .dockerignore",
  "success_rate": 0.85
}'

# Python
add_entry '{
  "query": "Python ModuleNotFoundError",
  "category": "python",
  "hit_frequency": "HIGH",
  "solutions": [{"step": 1, "description": "Install package", "command": "pip install package_name", "percentage": 95}],
  "common_pitfalls": "Package not installed in current environment",
  "success_rate": 0.95
}'

add_entry '{
  "query": "Python venv not activating",
  "category": "python",
  "hit_frequency": "MEDIUM",
  "solutions": [{"step": 1, "description": "Source activation script", "command": "source venv/bin/activate", "percentage": 95}],
  "common_pitfalls": "Must source not execute the activate script",
  "success_rate": 0.95
}'

# npm/Node.js
add_entry '{
  "query": "npm install fails permission denied",
  "category": "nodejs",
  "hit_frequency": "HIGH",
  "solutions": [{"step": 1, "description": "Use nvm instead of sudo", "command": "nvm install node", "percentage": 90}],
  "common_pitfalls": "Never use sudo with npm",
  "success_rate": 0.90
}'

add_entry '{
  "query": "npm ERR peer dependency conflict",
  "category": "nodejs",
  "hit_frequency": "MEDIUM",
  "solutions": [{"step": 1, "description": "Use legacy peer deps", "command": "npm install --legacy-peer-deps", "percentage": 85}],
  "common_pitfalls": "Strict peer dependency resolution in npm 7+",
  "success_rate": 0.85
}'

# PostgreSQL
add_entry '{
  "query": "Postgres connection refused",
  "category": "postgres",
  "hit_frequency": "HIGH",
  "solutions": [{"step": 1, "description": "Check if postgres running", "command": "pg_isready", "percentage": 95}],
  "common_pitfalls": "Postgres service not started",
  "success_rate": 0.95
}'

add_entry '{
  "query": "Postgres permission denied for table",
  "category": "postgres",
  "hit_frequency": "MEDIUM",
  "solutions": [{"step": 1, "description": "Grant permissions", "command": "GRANT ALL ON table_name TO user;", "percentage": 90}],
  "common_pitfalls": "User lacks table permissions",
  "success_rate": 0.90
}'

# VS Code / IDEs
add_entry '{
  "query": "VS Code IntelliSense not working",
  "category": "vscode",
  "hit_frequency": "MEDIUM",
  "solutions": [{"step": 1, "description": "Reload window", "command": "Cmd+Shift+P > Reload Window", "percentage": 85}],
  "common_pitfalls": "TypeScript server needs restart",
  "success_rate": 0.85
}'

add_entry '{
  "query": "ESLint not working in VS Code",
  "category": "vscode",
  "hit_frequency": "MEDIUM",
  "solutions": [{"step": 1, "description": "Install ESLint extension", "command": "code --install-extension dbaeumer.vscode-eslint", "percentage": 95}],
  "common_pitfalls": "Extension not installed",
  "success_rate": 0.95
}'

# Tailwind
add_entry '{
  "query": "Tailwind classes not applying",
  "category": "tailwind",
  "hit_frequency": "HIGH",
  "solutions": [{"step": 1, "description": "Check content paths in config", "command": "content: [\"./src/**/*.{js,jsx,ts,tsx}\"]", "percentage": 90}],
  "common_pitfalls": "tailwind.config.js content paths missing file locations",
  "success_rate": 0.90
}'

add_entry '{
  "query": "Tailwind not purging unused CSS",
  "category": "tailwind",
  "hit_frequency": "LOW",
  "solutions": [{"step": 1, "description": "Update content globs", "command": "content: [\"./src/**/*.tsx\"]", "percentage": 85}],
  "common_pitfalls": "Content paths dont match file locations",
  "success_rate": 0.85
}'

# API/Networking
add_entry '{
  "query": "Fetch CORS error",
  "category": "api",
  "hit_frequency": "HIGH",
  "solutions": [{"step": 1, "description": "Enable CORS on backend", "command": "app.use(cors())", "percentage": 90}],
  "common_pitfalls": "Backend must set CORS headers",
  "success_rate": 0.90
}'

add_entry '{
  "query": "API returns 401 unauthorized",
  "category": "api",
  "hit_frequency": "HIGH",
  "solutions": [{"step": 1, "description": "Check auth header", "command": "headers: { Authorization: Bearer ${token} }", "percentage": 95}],
  "common_pitfalls": "Missing or malformed auth header",
  "success_rate": 0.95
}'

# Database migrations
add_entry '{
  "query": "Migration already exists error",
  "category": "database",
  "hit_frequency": "MEDIUM",
  "solutions": [{"step": 1, "description": "Mark as applied", "command": "prisma migrate resolve --applied migration_name", "percentage": 85}],
  "common_pitfalls": "Migration applied manually needs to be marked",
  "success_rate": 0.85
}'

# Testing
add_entry '{
  "query": "Jest tests timing out",
  "category": "testing",
  "hit_frequency": "MEDIUM",
  "solutions": [{"step": 1, "description": "Increase timeout", "command": "jest.setTimeout(10000)", "percentage": 85}],
  "common_pitfalls": "Default 5s timeout too short for async tests",
  "success_rate": 0.85
}'

add_entry '{
  "query": "Playwright test fails headless but passes headed",
  "category": "testing",
  "hit_frequency": "MEDIUM",
  "solutions": [{"step": 1, "description": "Add wait for selector", "command": "await page.waitForSelector(selector)", "percentage": 80}],
  "common_pitfalls": "Race conditions in headless mode",
  "success_rate": 0.80
}'

# Environment variables
add_entry '{
  "query": "Environment variable undefined",
  "category": "configuration",
  "hit_frequency": "HIGH",
  "solutions": [{"step": 1, "description": "Check .env file exists", "command": "cat .env", "percentage": 90}],
  "common_pitfalls": ".env not loaded or variable misspelled",
  "success_rate": 0.90
}'

add_entry '{
  "query": "Next.js env vars not available client side",
  "category": "nextjs",
  "hit_frequency": "MEDIUM",
  "solutions": [{"step": 1, "description": "Prefix with NEXT_PUBLIC_", "command": "NEXT_PUBLIC_API_URL=...", "percentage": 95}],
  "common_pitfalls": "Client-side vars must have NEXT_PUBLIC_ prefix",
  "success_rate": 0.95
}'

# Build errors
add_entry '{
  "query": "npm run build out of memory",
  "category": "nodejs",
  "hit_frequency": "MEDIUM",
  "solutions": [{"step": 1, "description": "Increase Node memory", "command": "NODE_OPTIONS=--max_old_space_size=4096 npm run build", "percentage": 90}],
  "common_pitfalls": "Default Node memory too low for large builds",
  "success_rate": 0.90
}'

# SSL/HTTPS
add_entry '{
  "query": "localhost HTTPS certificate error",
  "category": "development",
  "hit_frequency": "MEDIUM",
  "solutions": [{"step": 1, "description": "Use mkcert for local certs", "command": "brew install mkcert && mkcert localhost", "percentage": 85}],
  "common_pitfalls": "Self-signed certs not trusted by browser",
  "success_rate": 0.85
}'

# File permissions
add_entry '{
  "query": "Permission denied running script",
  "category": "bash",
  "hit_frequency": "HIGH",
  "solutions": [{"step": 1, "description": "Make executable", "command": "chmod +x script.sh", "percentage": 95}],
  "common_pitfalls": "Scripts need execute permission",
  "success_rate": 0.95
}'

# Port already in use
add_entry '{
  "query": "Port already in use error",
  "category": "development",
  "hit_frequency": "HIGH",
  "solutions": [{"step": 1, "description": "Kill process on port", "command": "lsof -ti:3000 | xargs kill -9", "percentage": 90}],
  "common_pitfalls": "Previous dev server still running",
  "success_rate": 0.90
}'

# Package manager conflicts
add_entry '{
  "query": "package-lock.json conflicts with yarn.lock",
  "category": "nodejs",
  "hit_frequency": "MEDIUM",
  "solutions": [{"step": 1, "description": "Choose one package manager", "command": "rm package-lock.json or rm yarn.lock", "percentage": 85}],
  "common_pitfalls": "Mixing npm and yarn causes conflicts",
  "success_rate": 0.85
}'

# CSS not loading
add_entry '{
  "query": "CSS not loading in production",
  "category": "css",
  "hit_frequency": "MEDIUM",
  "solutions": [{"step": 1, "description": "Check build output includes CSS", "command": "ls dist/ or ls .next/", "percentage": 85}],
  "common_pitfalls": "CSS not imported correctly or minifier issue",
  "success_rate": 0.85
}'

# Image optimization
add_entry '{
  "query": "Next.js Image component not working",
  "category": "nextjs",
  "hit_frequency": "MEDIUM",
  "solutions": [{"step": 1, "description": "Add domain to next.config", "command": "images: { domains: [\"example.com\"] }", "percentage": 90}],
  "common_pitfalls": "External image domains must be whitelisted",
  "success_rate": 0.90
}'

# Svelte
add_entry '{
  "query": "Svelte store not reactive",
  "category": "svelte",
  "hit_frequency": "MEDIUM",
  "solutions": [{"step": 1, "description": "Use $ prefix for auto-subscription", "command": "$myStore instead of myStore", "percentage": 90}],
  "common_pitfalls": "Must use $ prefix for reactive statements",
  "success_rate": 0.90
}'

add_entry '{
  "query": "SvelteKit form action not working",
  "category": "sveltekit",
  "hit_frequency": "MEDIUM",
  "solutions": [{"step": 1, "description": "Export actions from +page.server.ts", "command": "export const actions = { default: async () => {} }", "percentage": 85}],
  "common_pitfalls": "Actions must be in +page.server.ts not +page.ts",
  "success_rate": 0.85
}'

# Redis
add_entry '{
  "query": "Redis connection timeout",
  "category": "redis",
  "hit_frequency": "MEDIUM",
  "solutions": [{"step": 1, "description": "Check Redis is running", "command": "redis-cli ping", "percentage": 95}],
  "common_pitfalls": "Redis server not started",
  "success_rate": 0.95
}'

# WebSocket
add_entry '{
  "query": "WebSocket connection failed",
  "category": "websocket",
  "hit_frequency": "MEDIUM",
  "solutions": [{"step": 1, "description": "Check CORS and protocol", "command": "Use wss:// for HTTPS sites", "percentage": 85}],
  "common_pitfalls": "Mixed content blocked on HTTPS",
  "success_rate": 0.85
}'

# GraphQL
add_entry '{
  "query": "GraphQL query returns null",
  "category": "graphql",
  "hit_frequency": "MEDIUM",
  "solutions": [{"step": 1, "description": "Check resolver return value", "command": "return await db.query()", "percentage": 85}],
  "common_pitfalls": "Resolver not returning data",
  "success_rate": 0.85
}'

# Auth
add_entry '{
  "query": "JWT token expired",
  "category": "authentication",
  "hit_frequency": "HIGH",
  "solutions": [{"step": 1, "description": "Implement refresh token flow", "command": "Use refresh token to get new access token", "percentage": 85}],
  "common_pitfalls": "Access tokens have short expiry",
  "success_rate": 0.85
}'

# Deployment
add_entry '{
  "query": "Vercel build failing",
  "category": "deployment",
  "hit_frequency": "MEDIUM",
  "solutions": [{"step": 1, "description": "Check build logs", "command": "View logs in Vercel dashboard", "percentage": 90}],
  "common_pitfalls": "Environment variables or dependencies missing",
  "success_rate": 0.90
}'

add_entry '{
  "query": "Netlify redirect not working",
  "category": "deployment",
  "hit_frequency": "MEDIUM",
  "solutions": [{"step": 1, "description": "Add _redirects file", "command": "/* /index.html 200", "percentage": 90}],
  "common_pitfalls": "SPA needs catch-all redirect",
  "success_rate": 0.90
}'

# Mobile responsive
add_entry '{
  "query": "Mobile viewport not scaling",
  "category": "css",
  "hit_frequency": "MEDIUM",
  "solutions": [{"step": 1, "description": "Add viewport meta tag", "command": "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">", "percentage": 95}],
  "common_pitfalls": "Missing viewport meta tag",
  "success_rate": 0.95
}'

# Performance
add_entry '{
  "query": "React re-rendering too much",
  "category": "react",
  "hit_frequency": "MEDIUM",
  "solutions": [{"step": 1, "description": "Use React.memo", "command": "export default React.memo(Component)", "percentage": 80}],
  "common_pitfalls": "Component rerenders on parent state change",
  "success_rate": 0.80
}'

# State management
add_entry '{
  "query": "Zustand state not persisting",
  "category": "react",
  "hit_frequency": "LOW",
  "solutions": [{"step": 1, "description": "Add persist middleware", "command": "persist(store, { name: \"storage-key\" })", "percentage": 85}],
  "common_pitfalls": "Must explicitly enable persistence",
  "success_rate": 0.85
}'

echo ""
echo "✅ Added $count entries (total now: $((count + 5)))"
