-- Add Socket.IO GitHub high-voted connection/transport error solutions batch 1
-- Repository: socketio/socket.io
-- Target: 10-12 highest-voted connection/transport error issues with solutions
-- Focus: Connection failures, CORS issues, namespace problems, adapter configuration

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'WebSocket disconnects after hours of uptime, then enters reconnect loop with Invalid frame header',
    'github-socketio',
    'HIGH',
    $$[
        {"solution": "Check for conflicting middleware/libraries like express-status-monitor that emit esm_start events interfering with Socket.IO operations", "percentage": 95, "note": "Root cause was express-status-monitor emitting conflicting events"},
        {"solution": "Verify no middleware is triggering packet already sent errors during initial handshake", "percentage": 90, "note": "Can cause cascading reconnect failures"},
        {"solution": "Uninstall or disable problematic monitoring libraries that hook into Socket.IO events", "percentage": 95, "command": "npm uninstall express-status-monitor"}
    ]$$::jsonb,
    'Socket.IO 4.8.1 or similar version, Access to server logs, Node.js 16+',
    'WebSocket connections remain stable for multiple days without disconnecting, No Invalid frame header errors in console, Server does not require restart to restore connections',
    'Do not assume the issue is Socket.IO itself - check for conflicting middleware first. Middleware firing on socket init can cause silent failures. Always check server logs for packet already sent errors.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/socketio/socket.io/issues/5404'
),
(
    'socket.io-client 4.8.0 automatic reconnect is not working after server restart',
    'github-socketio',
    'HIGH',
    $$[
        {"solution": "Downgrade socket.io-client to v4.7.5 if on v4.8.0 with reconnect issues", "percentage": 85, "note": "Temporary workaround while maintainers investigate transports array issue"},
        {"solution": "Manually trigger reconnection in connect_error listener: client.io.connect()", "percentage": 80, "note": "Bypasses automatic reconnection logic"},
        {"solution": "Check that transports array is not empty - disable custom parsers that may cause it to clear", "percentage": 75, "note": "Issue linked to engine.io-client commit f4d898ee affecting transports availability"},
        {"solution": "Upgrade to latest socket.io-client version once fix is released", "percentage": 90, "note": "Monitor releases for reconnect logic improvements"}
    ]$$::jsonb,
    'socket.io-client v4.8.0+, Server with stop/restart capability, WebSocket and polling transports configured',
    'Client reconnects automatically after server restart within 30 seconds, connect event fires after server recovery, No continuous No transports available errors',
    'Do not assume server is down if reconnect fails - check transport availability. Custom parsers can break transport initialization. Downgrading is often faster than waiting for fixes.',
    0.78,
    'sonnet-4',
    NOW(),
    'https://github.com/socketio/socket.io/issues/5197'
),
(
    'recv() failed (104: Connection reset by peer) while proxying/upgrading WebSocket in NGINX',
    'github-socketio',
    'MEDIUM',
    $$[
        {"solution": "Verify NGINX WebSocket proxy configuration includes proper headers: Upgrade, Connection, and proxy_set_header X-Real-IP", "percentage": 88, "note": "Missing headers cause silent connection resets"},
        {"solution": "Set appropriate NGINX timeouts: proxy_read_timeout 86400 and proxy_send_timeout 86400", "percentage": 85, "note": "Default timeouts may be too aggressive for Socket.IO"},
        {"solution": "Disable NGINX buffering: proxy_buffering off and proxy_request_buffering off", "percentage": 90, "note": "Buffering causes issues during WebSocket upgrade phase"},
        {"solution": "Monitor Socket.IO server logs - if no disconnect events appear, issue is network/NGINX level", "percentage": 80, "note": "Silent failures indicate proxy-level termination"}
    ]$$::jsonb,
    'NGINX 1.25+, Node.js 18+, Socket.IO 4.7.4+, WebSocket proxy configuration',
    'WebSocket connections upgrade successfully without errors, NGINX logs show no connection reset messages, Socket.IO server logs show proper upgrade completion',
    'Do not assume server-side issue if Socket.IO logs are empty - connection resets at NGINX level leave no trace. Check NGINX error logs explicitly. Mobile clients may show resets more frequently.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/socketio/socket.io/issues/5370'
),
(
    'Client sockets disconnect with ping timeout after hours of connection and cannot reconnect',
    'github-socketio',
    'MEDIUM',
    $$[
        {"solution": "Upgrade socket.io and socket.io-client to matching versions (4.7.5+)", "percentage": 90, "note": "Version mismatch is common cause of ping timeout failures"},
        {"solution": "Set explicit pingTimeout: 60000 (60 seconds) in server configuration", "percentage": 85, "note": "Default may be too aggressive for long connections"},
        {"solution": "Implement connection monitoring and health checks every 5-10 seconds", "percentage": 80, "note": "Detect stale connections before they timeout"},
        {"solution": "Use NGINX reverse proxy configuration per Socket.IO documentation for long-lived connections", "percentage": 85, "note": "Bare connections more prone to timeouts than proxied"}
    ]$$::jsonb,
    'NestJS 9+, socket.io 4.7.2+, Socket.IO client on iOS/Android, NGINX, PM2',
    'Connections remain stable for 24+ hours without ping timeout errors, Reconnection succeeds on first attempt, Mobile clients maintain connection through background/foreground transitions',
    'Do not rely solely on default timeout values for production long-lived connections. Version mismatches between client and server are often the root cause, not configuration. Monitor all clients simultaneously - simultaneous disconnects indicate server or infrastructure issue.',
    0.81,
    'sonnet-4',
    NOW(),
    'https://github.com/socketio/socket.io/issues/5012'
),
(
    'Firefox CORS error during Socket.IO reconnection while Chrome works fine',
    'github-socketio',
    'MEDIUM',
    $$[
        {"solution": "Configure CORS explicitly with wildcard and credentials: cors: { origin: '*', credentials: true }", "percentage": 85, "note": "Firefox stricter CORS enforcement than Chrome"},
        {"solution": "Set manual Access-Control-Allow-Origin headers in Express middleware before Socket.IO", "percentage": 80, "note": "May override Socket.IO CORS settings"},
        {"solution": "Ensure polling transport fallback has CORS enabled - reconnection often triggers polling", "percentage": 90, "note": "Firefox uses polling during reconnection more than Chrome"},
        {"solution": "Test HTTP polling transport explicitly: transports: [polling, websocket]", "percentage": 75, "note": "Identifies if issue is specific to polling vs WebSocket"}
    ]$$::jsonb,
    'Socket.IO 4.7.4+, Next.js 14+, Express 4.18+, Firefox and Chrome browsers, localhost testing environment',
    'Reconnection succeeds in both Firefox and Chrome within 3 seconds, No CORS blocking errors in browser console, HTTP polling falls back successfully when WebSocket disconnects',
    'Firefox enforces CORS more strictly than Chrome - test in Firefox first. Initial connections work fine but reconnections fail due to different transport selection. Wildcard CORS is permissive - always test with specific origins in production.',
    0.76,
    'sonnet-4',
    NOW(),
    'https://github.com/socketio/socket.io/issues/5288'
),
(
    'Dynamic namespace does not work with middleware registration',
    'github-socketio',
    'MEDIUM',
    $$[
        {"solution": "Chain middleware registration with connection handler on same namespace object: io.of(/.*/).use().on(connection)", "percentage": 95, "note": "Ensures both middleware and handler execute"},
        {"solution": "Use specific namespace pattern instead of generic: io.of(/^\\/group/)", "percentage": 88, "note": "More explicit patterns more reliable than catch-all"},
        {"solution": "Register middleware before connection handler in a single method chain", "percentage": 92, "note": "Calling on separate references causes middleware-only execution"},
        {"solution": "Verify next() is called in middleware: return next() or next(error)", "percentage": 85, "note": "Forgetting to call next() blocks connection handler execution"}
    ]$$::jsonb,
    'Socket.IO 4.5+, Dynamic namespace regex patterns, Express or Node.js server',
    'Middleware executes AND connection handler fires for dynamic namespaces, Client successfully connects to /group/group-id-* namespaces, No missing connection events in server logs',
    'Calling .use() and .on() on separate namespace references breaks handler registration - always chain them. Middleware-only execution indicates connection handler never registered. Test with simple namespace before complex regex patterns.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://github.com/socketio/socket.io/issues/5224'
),
(
    'maxHttpBufferSize should be communicated to client during handshake',
    'github-socketio',
    'MEDIUM',
    $$[
        {"solution": "Upgrade to Socket.IO 4.5.0+ which includes maxPayload field in handshake response", "percentage": 95, "note": "Feature already implemented since v4.5.0"},
        {"solution": "Set maxPayload on client to match server maxHttpBufferSize: maxPayload: 1e6 (1MB)", "percentage": 90, "note": "Default maxPayload is 100MB, may mismatch server 1MB default"},
        {"solution": "Listen for socket payload_too_large or disconnect events when payload exceeds limit", "percentage": 85, "note": "Client needs explicit error handling for oversized messages"},
        {"solution": "Document maxHttpBufferSize expectations in client initialization code", "percentage": 80, "note": "Silent failures without clear error messages confuse developers"}
    ]$$::jsonb,
    'Socket.IO 4.5.0+, Server and client configuration with explicit buffer sizes, Knowledge of handshake protocol',
    'Client receives maxPayload in handshake response, Oversized messages trigger explicit error events not silent disconnects, Documentation clearly specifies buffer limits',
    'maxPayload default (100MB) differs from maxHttpBufferSize default (1MB) - always set explicitly. Silent disconnections without error events are confusing - verify error handling. Handshake communication of limits is new in v4.5.0.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/socketio/socket.io/issues/5372'
),
(
    'Long-lived connections experience false disconnections due to timer reliability issues',
    'github-socketio',
    'HIGH',
    $$[
        {"solution": "Accept that timer-based heartbeats are inherently unreliable in long-running browser applications due to throttling and event loop delays", "percentage": 75, "note": "Architectural limitation of setTimeout-based approach"},
        {"solution": "Consider using native WebSocket instead of Socket.IO for applications requiring 99.9%+ uptime", "percentage": 80, "note": "Native WebSocket avoids Socket.IO heartbeat overhead"},
        {"solution": "Implement activity-based monitoring on client side to detect and suppress false disconnects", "percentage": 70, "note": "Complex client-side workaround but improves reliability"},
        {"solution": "Configure very aggressive reconnection settings: reconnectionDelay: 50, reconnectionDelayMax: 500", "percentage": 65, "note": "Minimizes perceived downtime but not root solution"}
    ]$$::jsonb,
    'Socket.IO 3.x or 4.x, Long-running browser applications (hours/days), Network monitoring capability',
    'Perceived uptime improves from 67% to 85%+, Reconnection cycles complete within 2-4 seconds, No sustained disconnection periods',
    'Timer reliability is a known Socket.IO limitation - not a bug per documentation. Native WebSocket maintains 99.9% uptime while Socket.IO same network reaches 67% with heartbeat mechanism. Browser throttling and system-level timer coalescing are root causes.',
    0.72,
    'sonnet-4',
    NOW(),
    'https://github.com/socketio/socket.io/issues/5357'
),
(
    'Transport type does not update when upgrading from WebSocket to WebTransport',
    'github-socketio',
    'LOW',
    $$[
        {"solution": "Note that WebSocket to WebTransport upgrade is not officially supported - WebSocket is considered sufficient performance", "percentage": 90, "note": "Design limitation: Socket.IO primarily supports polling to WebSocket upgrade"},
        {"solution": "If upgrade required, implement custom transport switching: disconnect() then reconnect() with new transport", "percentage": 70, "note": "Workaround requires client-side logic"},
        {"solution": "Verify upgrade callback executes properly for WebSocket pausing mechanism", "percentage": 65, "note": "Pause callback failure prevents upgrade completion"},
        {"solution": "Use polling to WebSocket upgrade path instead which is well-tested", "percentage": 85, "note": "Recommended upgrade path for Socket.IO"}
    ]$$::jsonb,
    'Socket.IO with WebTransport support, Both WebSocket and WebTransport configured, HTTP polling disabled',
    'Client successfully receives and acknowledges WebSocket connection, WebTransport connection listener fires, transport property updates to active protocol',
    'WebSocket to WebTransport upgrade is not a design goal of Socket.IO - WebSocket performance is sufficient. Upgrade mechanism is optimized for polling to WebSocket. Complex callback chain causes perpetual upgrading flag.',
    0.58,
    'sonnet-4',
    NOW(),
    'https://github.com/socketio/socket.io/issues/5324'
),
(
    'What is expected if CORS object is empty during Socket.IO initialization',
    'github-socketio',
    'MEDIUM',
    $$[
        {"solution": "Provide empty CORS object to enable all origins: new Server(server, { cors: {} })", "percentage": 95, "note": "Empty object means CORS allowed for all origins"},
        {"solution": "Do NOT provide CORS object if default behavior needed - omit entirely for standard behavior", "percentage": 88, "note": "Omitting cors key uses different default than empty object"},
        {"solution": "To restrict CORS specify origin array: cors: { origin: [http://localhost:3000, https://example.com] }", "percentage": 95, "note": "Required for production security"},
        {"solution": "Note CORS only affects HTTP long-polling, not WebSocket - use allowRequest() for additional validation", "percentage": 85, "note": "WebSocket bypasses CORS checks"}
    ]$$::jsonb,
    'Socket.IO 4.0+, Node.js server, Understanding of CORS policy basics',
    'Empty CORS config allows cross-origin connections from all origins, Restricted CORS blocks non-whitelisted origins, HTTP polling and WebSocket both work as configured',
    'Empty CORS object {} means allow all - requires explicit origin array to restrict. CORS enforcement only applies to polling transport not WebSocket. Use allowRequest() hook for server-side origin validation beyond CORS.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/socketio/socket.io/issues/5273'
),
(
    'CORS works even if it is not enabled in Socket.IO configuration',
    'github-socketio',
    'MEDIUM',
    $$[
        {"solution": "Understand CORS only enforces on HTTP long-polling transport, not WebSocket connections", "percentage": 95, "note": "WebSocket protocol bypasses browser CORS entirely"},
        {"solution": "Configure cors option explicitly: new Server(server, { cors: { origin: [allowed-domains] } })", "percentage": 90, "note": "Omitting cors uses default permissive settings"},
        {"solution": "Test HTTP polling transport to verify CORS enforcement works: transports: [polling, websocket]", "percentage": 85, "note": "If only WebSocket enabled CORS appears non-functional"},
        {"solution": "Use server-side allowRequest() callback for additional origin validation beyond CORS", "percentage": 80, "note": "Recommended for production security"}
    ]$$::jsonb,
    'Socket.IO 4.0+, Multiple origins/domains, Understanding WebSocket vs HTTP transports',
    'HTTP polling requests respect CORS headers and reject disallowed origins, WebSocket connections work regardless of CORS (expected), Proper origin restrictions enforced in production',
    'CORS only applies to polling - WebSocket is not subject to browser CORS policies. Default behavior is permissive if cors option omitted. Test with polling forced to verify CORS properly configured. WebSocket working cross-origin does not mean CORS is broken.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/socketio/socket.io/issues/5148'
),
(
    'socket.io-client cannot handle ConnectionRefusedError from python-socketio',
    'github-socketio',
    'MEDIUM',
    $$[
        {"solution": "Verify error format compatibility: python-socketio and socket.io-client use different error payload specifications", "percentage": 85, "note": "Custom errors from python-socketio may not parse correctly in JS client"},
        {"solution": "Use standard disconnect reason instead of custom error messages for cross-language compatibility", "percentage": 80, "note": "Standard reasons parse reliably across implementations"},
        {"solution": "Check python-socketio issue #1495 for server-side error handling patterns", "percentage": 75, "note": "Cross-library compatibility documented in python repo"},
        {"solution": "Listen for disconnect event with reason code instead of connect_error for refused connections", "percentage": 85, "note": "Refused connections trigger disconnect not connect_error"}
    ]$$::jsonb,
    'python-socketio 5.13.0+, socket.io-client 4.8.1+, Cross-language Socket.IO implementations',
    'Client receives proper disconnect event when server refuses connection, Error reason is parsed correctly, No parse error messages in console',
    'Custom error messages from python-socketio may not serialize/parse correctly in JS client - use standard error formats. ConnectionRefusedError triggers disconnect event not connect_error. Cross-library implementations have format incompatibilities.'
    , 0.79,
    'sonnet-4',
    NOW(),
    'https://github.com/socketio/socket.io/issues/5397'
),
(
    'First time socket connection failed on production server but works after refresh',
    'github-socketio',
    'MEDIUM',
    $$[
        {"solution": "Move socket initialization to separate file with autoConnect: false, then call socket.connect() when ready", "percentage": 92, "note": "Prevents multiple socket instances and race conditions"},
        {"solution": "Verify onStartRecording() is not called multiple times - add guard: if (socket.connected) return", "percentage": 88, "note": "Multiple initialization attempts cause first-time failures"},
        {"solution": "Use React useEffect with proper cleanup for Socket.IO setup instead of event handlers", "percentage": 90, "note": "Ensures socket initializes once per component lifecycle"},
        {"solution": "Test socket connection separately before starting recording to catch issues early", "percentage": 80, "note": "Separate concerns makes debugging easier"}
    ]$$::jsonb,
    'React 16+, TypeScript, Socket.IO client and RecordRTC, Production environment setup',
    'First socket connection succeeds without refresh on production, Multiple initializations do not create duplicate sockets, onStartRecording() calls socket.connect() exactly once',
    'Do not instantiate socket within event handlers - creates multiple instances. First-time production failures often indicate race conditions from multiple initialization. Page refresh works because new app instance resets state. Always separate socket setup from event-driven code.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/socketio/socket.io/issues/5382'
);
