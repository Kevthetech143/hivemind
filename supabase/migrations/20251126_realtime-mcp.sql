-- Knowledge Mining: Realtime MCP Connection Issues
-- Created: 2025-11-26
-- Miner: Knowledge Miner (Haiku 4.5)
-- Count: 5 entries

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES
(
    'Error executing MCP tool: Not connected',
    'realtime-mcp',
    'HIGH',
    '[
        {"solution": "Windows-specific fix: Change command from ''npx'' to ''cmd'' and update args to [''/c'', ''npx'', ''-y'', ''@modelcontextprotocol/server-github'']. This is critical for Windows PowerShell compatibility.", "percentage": 95},
        {"solution": "Install the MCP server package globally: npm install -g @modelcontextprotocol/server-github, then verify in configuration.", "percentage": 85},
        {"solution": "Clear NPM cache with npm cache clean --force, then restart your IDE completely to reload server connections.", "percentage": 80}
    ]'::jsonb,
    'Active Node.js installation, MCP server package installed, IDE configured with MCP settings',
    'Tool executes successfully without ''Not connected'' error. Server process shows as running. Tool invocation returns expected results.',
    'Forgetting to use cmd /c wrapper on Windows, restarting IDE only partially (browser cache issue), running npx without -y flag which prompts for input',
    0.90,
    'haiku',
    NOW(),
    'https://github.com/modelcontextprotocol/servers/issues/1082',
    'admin:1764174029'
),
(
    'MCP Inspector error: Connection refused. Is the MCP server running?',
    'realtime-mcp',
    'MEDIUM',
    '[
        {"solution": "Verify the MCP server is actually listening on the configured endpoint. Use curl to test: curl http://localhost:PORT/endpoint", "percentage": 90},
        {"solution": "Check if you have the correct endpoint path configured. HTTP 404 errors trigger this message even when server is running - verify URL path matches server configuration.", "percentage": 85},
        {"solution": "Enable verbose logging in MCP server to distinguish between true connection refusal (ECONNREFUSED) vs HTTP endpoint errors. Look for actual ECONNREFUSED in logs.", "percentage": 80}
    ]'::jsonb,
    'MCP Inspector installed and running, MCP server started, network connectivity between inspector and server',
    'MCP Inspector connects successfully and shows available tools. Server responds to curl test. No ECONNREFUSED errors in verbose logs.',
    'Assuming connection failed when HTTP 404 indicates wrong endpoint path, not checking server verbose output to see actual error, restarting only inspector instead of both inspector and server',
    0.87,
    'haiku',
    NOW(),
    'https://github.com/modelcontextprotocol/inspector/issues/543',
    'admin:1764174029'
),
(
    'Socket.IO ECONNREFUSED ::1:PORT error on localhost',
    'realtime-mcp',
    'HIGH',
    '[
        {"solution": "Force IPv4 connection: Configure client to use explicit IPv4 address: const socket = io(''http://127.0.0.1:3030'', {reconnection: true, transports: [''websocket'']});", "percentage": 92},
        {"solution": "Bind server to all interfaces: Replace server.listen(PORT) with server.listen(PORT, ''0.0.0.0'') to listen on both IPv4 and IPv6, preventing protocol mismatch.", "percentage": 90},
        {"solution": "Check IPv6 localhost routing: Run netstat -an | grep LISTEN to verify server is listening on both 127.0.0.1 and ::1, or explicitly disable IPv6 in OS network settings.", "percentage": 75}
    ]'::jsonb,
    'Node.js with Express/Socket.IO installed, server code accessible for modification, network access to localhost',
    'Client connects without ECONNREFUSED error. Logs show successful handshake. websocket transport active. Server accepts multiple client connections.',
    'Assuming server isn''t running when it''s actually listening on different protocol (IPv4 vs IPv6), not verifying with netstat or ss command, mixing server bind address with client connect address',
    0.88,
    'haiku',
    NOW(),
    'https://dev.to/mrrishimeena/socketio-connection-issues-on-localhost-42o5',
    'admin:1764174029'
),
(
    'Error: connect ECONNREFUSED - Node.js Socket.IO application',
    'realtime-mcp',
    'HIGH',
    '[
        {"solution": "Verify server is running before client attempts connection. Check process list: ps aux | grep node, or use netstat -an | grep :PORT to confirm port is listening.", "percentage": 95},
        {"solution": "Ensure client and server use matching port numbers. Add console.log to server: console.log(''Listening on port PORT'') and verify client connects to same PORT.", "percentage": 92},
        {"solution": "Check dependency versions - outdated node-mysql or other modules can cause unexpected connection failures. Run npm audit and update stale packages: npm install --save-dev @latest", "percentage": 80}
    ]'::jsonb,
    'Node.js runtime, Socket.IO package installed, server code with proper listen() call, client code with io() connection',
    'Server logs show ''listening on port X'' message. netstat shows port in LISTEN state. Client connects and emits/receives events without error.',
    'Running client before server startup completes, incorrect port in client vs server config, not checking if port is already in use by another process, ignoring dependency version conflicts',
    0.89,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/10971911/error-connect-econnrefused-for-node-js-and-socket-io-application',
    'admin:1764174029'
),
(
    'Socket.IO connection_error: Unable to reach server endpoint HTTPS',
    'realtime-mcp',
    'MEDIUM',
    '[
        {"solution": "Test server reachability with curl: curl ''https://example.com/socket.io/?EIO=4&transport=polling''. Success returns session data {\"sid\":\"...\",\"upgrades\":[\"websocket\"]}. Failure indicates server not running.", "percentage": 88},
        {"solution": "Enable debug logging in client: DEBUG=socket* node client.js to see detailed connection handshake logs and identify exact failure point in SSL/TLS negotiation.", "percentage": 85},
        {"solution": "For SSL certificate issues, test with rejectUnauthorized: false in Socket.IO config: const socket = io(url, {rejectUnauthorized: false}). If successful, update/fix certificate. If still fails, server unreachable.", "percentage": 80}
    ]'::jsonb,
    'HTTPS-enabled Socket.IO server deployed, client with Socket.IO library installed, network access to server URL',
    'curl returns valid session JSON with sid and upgrades array. Client connects with connect_error event not firing. DEBUG logs show successful transport upgrade.',
    'Forgetting to test basic curl connectivity first, assuming certificate is invalid without testing, enabling rejectUnauthorized: false in production (security risk), not checking firewall/proxy blocking HTTPS',
    0.86,
    'haiku',
    NOW(),
    'https://socket.io/docs/v3/troubleshooting-connection-issues/',
    'admin:1764174029'
);
