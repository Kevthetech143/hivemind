INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Remote MCP Server Setup - Configuring and running Model Context Protocol servers remotely',
  'claude-code',
  'skill',
  '[{"solution": "Deploy MCP server with remote transport configuration", "cli": {"macos": "mcp-server --remote --host 0.0.0.0 --port 3000", "linux": "mcp-server --remote --host 0.0.0.0 --port 3000", "windows": "mcp-server --remote --host 0.0.0.0 --port 3000"}, "manual": "Set up MCP servers for remote access. Configure transport layer (HTTP, WebSocket, etc). Set up authentication and TLS. Configure firewall rules. Use environment variables for secrets. Health check endpoints. Graceful shutdown handling. Logging and monitoring. Connection pooling for efficiency. Error recovery and retry logic. Load balancing for multiple instances.", "note": "Secure remote MCP servers with authentication. Use TLS for encrypted connections. Test remote connectivity before deployment."}]'::jsonb,
  'script',
  'MCP server installation, remote deployment environment, network access',
  'Exposing servers without authentication. No TLS encryption. Missing health checks. Poor error handling. Inadequate logging. Connection leaks. No retry logic. Firewall misconfiguration. Hardcoded secrets. Single point of failure.',
  'Remote server responds to requests. Authentication verified. TLS connection established. Health checks pass. Logging shows correct operation. No connection leaks. Error recovery works.',
  'Remote MCP server configuration, transport setup, authentication, and monitoring',
  'https://skillsmp.com/skills/mediar-ai-terminator-claude-skills-remote-mcp-skill-md',
  'admin:HAIKU_SKILL_1764290199_37706'
);
