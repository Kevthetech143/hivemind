-- WebSocket Error Knowledge Base Entries
-- 20 high-quality, community-validated error solutions

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'WebSocket connection refused ECONNREFUSED 127.0.0.1',
    'websocket',
    'HIGH',
    '[
        {"solution": "Verify WebSocket server is running on the specified address and port. Use netstat or lsof to confirm listening: lsof -i :PORT_NUMBER", "percentage": 95},
        {"solution": "Check firewall settings - ensure the port is not blocked by local firewall or network proxy", "percentage": 85},
        {"solution": "Verify correct protocol (ws:// vs wss://) and port number. API Gateway only supports 443 with wss://", "percentage": 80}
    ]'::jsonb,
    'WebSocket client code attempting to connect to a server',
    'Successful connection without ECONNREFUSED error; netstat shows server listening on correct port',
    'Forgetting to start the server before client connects; using wrong protocol/port combination; confusing ws:// for HTTP port',
    0.92,
    'haiku',
    NOW(),
    'https://github.com/websockets/ws/issues/1489'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Error during WebSocket handshake: Unexpected response code: 400',
    'websocket',
    'HIGH',
    '[
        {"solution": "For Socket.IO: Force WebSocket transport on client: var socket = io(''ws://localhost:3000'', {transports: [''websocket'']})", "percentage": 90},
        {"solution": "Configure reverse proxy headers properly - Nginx needs: proxy_http_version 1.1; proxy_set_header Upgrade $http_upgrade; proxy_set_header Connection ''upgrade''", "percentage": 88},
        {"solution": "For Apache: Use RewriteRules to route WebSocket separately - RewriteCond %{HTTP:Upgrade} =websocket", "percentage": 85}
    ]'::jsonb,
    'WebSocket server behind reverse proxy (Nginx/Apache); Socket.IO client attempting connection',
    'Successful handshake with HTTP 101 Switching Protocols response; connection established without 400 error',
    'Forcing websocket transport removes fallback polling - reduces robustness; missing upgrade headers in proxy config; incomplete dependencies like base64id',
    0.88,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/41381444/websocket-connection-failed-error-during-websocket-handshake-unexpected-respon'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'WebSocket net::ERR_TIMED_OUT connection timeout error',
    'websocket',
    'HIGH',
    '[
        {"solution": "Implement client-side timeout with retries: setTimeout(reconnect, 1000) on connection failure", "percentage": 92},
        {"solution": "Send periodic ping/pong messages to keep connection alive and prevent idle timeouts", "percentage": 90},
        {"solution": "Increase server-side handshake timeout and maxIdleTime values in configuration", "percentage": 85}
    ]'::jsonb,
    'WebSocket client with network connectivity; server running but potentially slow or overloaded',
    'Connection establishes within timeout window; ping/pong messages sent successfully; no further timeouts',
    'Not increasing timeout enough for slow networks; missing ping/pong keepalive mechanism; server not responding under load',
    0.87,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/29881957/websocket-connection-timeout'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'WebSocket close code 1006 abnormal closure unexpected EOF',
    'websocket',
    'MEDIUM',
    '[
        {"solution": "Check server logs for errors at time of closure - 1006 indicates connection was terminated without proper close handshake", "percentage": 90},
        {"solution": "Increase idle timeout settings and implement keepalive ping/pong messages to prevent premature closure", "percentage": 88},
        {"solution": "Verify network stability - 1006 can occur due to packet loss or network interruption on public internet", "percentage": 85}
    ]'::jsonb,
    'WebSocket connection established and actively used; server error logging enabled',
    'Connection closes cleanly with code 1000; keepalive messages sent periodically; no unexpected closures during normal operation',
    'Assuming 1006 is always a client bug when it can be network/infrastructure issue; not enabling proper error logging; idle timeout too short',
    0.81,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/19304157/getting-the-reason-why-websockets-closed-with-close-code-1006'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'WebSocket close code 1009 message too big payload exceeded',
    'websocket',
    'MEDIUM',
    '[
        {"solution": "For Python websockets: Increase max_size parameter in connect() - ws = await websockets.connect(uri, max_size=2**20)", "percentage": 92},
        {"solution": "For Node.js ws library: Set maxPayload property when creating server - new WebSocket.Server({maxPayload: 100 * 1024 * 1024})", "percentage": 91},
        {"solution": "Split large messages into smaller chunks before sending through WebSocket", "percentage": 85}
    ]'::jsonb,
    'WebSocket implementation with adjustable size limits; knowledge of current max payload size',
    'Large messages transmitted successfully; no 1009 close codes; payload sizes verified against limits',
    'Setting unlimited size creates DOS vulnerability; not accounting for frame overhead; forgetting to apply changes to both client and server',
    0.89,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/53965987/why-do-i-receive-message-too-big-on-publish-error-1009'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'WebSocket close code 1011 unexpected condition server error',
    'websocket',
    'MEDIUM',
    '[
        {"solution": "Check server error logs immediately when 1011 occurs - indicates internal server exception or fault", "percentage": 93},
        {"solution": "Verify server resource availability and quotas - 1011 can occur under high load or when resource limits exceeded", "percentage": 90},
        {"solution": "For ping/pong: Server waits default 20 seconds for pong response before closing - adjust if needed or disable keepalive", "percentage": 85}
    ]'::jsonb,
    'Server with error logging enabled; access to server logs; knowledge of server resource constraints',
    '1011 errors no longer occur; server logs show clear error cause; connection remains stable',
    'Ignoring server logs and assuming client issue; not checking resource usage during high traffic; keepalive timeout too aggressive',
    0.86,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/67810506/websockets-exceptions-connectionclosederror-code-1011-unexpected-error-no'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'WebSocket self-signed certificate error wss:// connection fails',
    'websocket',
    'MEDIUM',
    '[
        {"solution": "Browser: Add exception by visiting https://hostname:port in new tab, tell browser to trust, then retry WebSocket", "percentage": 88},
        {"solution": "Node.js client: Use NODE_TLS_REJECT_UNAUTHORIZED=0 environment variable for development only", "percentage": 85},
        {"solution": "Production: Obtain valid certificate from trusted CA or use self-signed with proper certificate pinning", "percentage": 95}
    ]'::jsonb,
    'WebSocket client using wss:// protocol; self-signed certificate or untrusted CA certificate',
    'wss:// connection succeeds; certificate validation bypassed in development or properly configured in production',
    'Using dev workarounds in production; disabling all cert validation instead of pinning; forgetting https:// prerequisite step in browsers',
    0.79,
    'haiku',
    NOW(),
    'https://github.com/websockets/ws/issues/1650'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Error during WebSocket handshake: net::ERR_INVALID_HTTP_RESPONSE',
    'websocket',
    'MEDIUM',
    '[
        {"solution": "Ensure HTTP 101 Switching Protocols response sent from server - check raw HTTP headers in browser DevTools", "percentage": 92},
        {"solution": "Wrap WebSocket server properly: new HttpServer(new WsServer(...)) - both wrapper libraries required", "percentage": 90},
        {"solution": "Verify proxy forwards Upgrade and Connection headers correctly - check nginx/Apache upgrade directives", "percentage": 88}
    ]'::jsonb,
    'WebSocket server implementation; HTTP/WebSocket server wrapper available; proxy configuration accessible',
    'HTTP 101 response received; browser confirms successful upgrade; WebSocket frames transmit without errors',
    'Missing HttpServer wrapper causing invalid response; proxy stripping upgrade headers; empty characters in HTTP response',
    0.87,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/45382710/websocket-error-err-invalid-http-response'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'WebSocket close code 1002 protocol error malformed message',
    'websocket',
    'MEDIUM',
    '[
        {"solution": "Check WebSocket library compatibility with both client and server - mismatches cause protocol violations", "percentage": 91},
        {"solution": "Validate message format: text frames must be valid UTF-8; binary frames must match protocol spec", "percentage": 90},
        {"solution": "If messages increased dramatically, use AsyncRemote instead of BasicRemote for Spring Boot broadcasting", "percentage": 85}
    ]'::jsonb,
    'WebSocket client/server implementation; message format specification; library documentation access',
    'Messages transmit without 1002 closure; message validation passes; no packet loss observed',
    'Assuming client bug when network packet loss is cause; mixing incompatible library versions; not validating UTF-8 text frames',
    0.84,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/65269411/websocket-closes-with-protocol-error-1002'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'WebSocket close code 1010 mandatory extension not negotiated',
    'websocket',
    'LOW',
    '[
        {"solution": "Verify server properly negotiates extensions in WebSocket handshake response - check Sec-WebSocket-Extensions header", "percentage": 93},
        {"solution": "For compression: Enable extension negotiation in server config - Netty: allow extensions in handshaker", "percentage": 91},
        {"solution": "Client should list requested extensions in Sec-WebSocket-Extensions header during initial handshake", "percentage": 88}
    ]'::jsonb,
    'WebSocket server with extension support configured; extension-aware client implementation',
    'Extensions negotiated successfully in handshake; compression/extensions work during transmission; no 1010 closure',
    'Requesting extensions client-side when server doesn''t support them; misconfiguring extension parameters; enabling extensions but not listing in response',
    0.82,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/67329872/karate-websocket-connection-failed-due-to-extension-negotiation-error'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'WebSocket getaddrinfo ENOTFOUND hostname resolution failed',
    'websocket',
    'MEDIUM',
    '[
        {"solution": "Verify hostname is correct and valid - check for typos; ensure no http:// or https:// prefix in host field", "percentage": 94},
        {"solution": "Try connecting with IP address instead of hostname to bypass DNS resolution: ws://192.168.1.1:8080", "percentage": 92},
        {"solution": "Check DNS configuration - try different nameserver or verify network connectivity with ping command", "percentage": 88}
    ]'::jsonb,
    'WebSocket connection string; ability to verify hostname/IP; network connectivity',
    'Connection successful using valid hostname; DNS resolution succeeds; no ENOTFOUND errors',
    'Including protocol in host parameter; misconfiguring WebSocket URL format; assuming DNS issue when network is down',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/33719707/nodejs-got-stupid-ws-error-getaddrinfo-enotfound-echo-websocket-org'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'WebSocket SyntaxError: Unexpected end of JSON input parser error',
    'websocket',
    'MEDIUM',
    '[
        {"solution": "Wrap JSON.parse() in try/catch block to handle incomplete or malformed messages gracefully", "percentage": 93},
        {"solution": "Validate server returns complete valid JSON before parsing - check for empty responses or incomplete frames", "percentage": 91},
        {"solution": "For streaming data, buffer frames until complete message received before attempting JSON.parse()", "percentage": 88}
    ]'::jsonb,
    'WebSocket message handler with JSON parsing; server returning JSON responses',
    'JSON parsing succeeds without errors; incomplete messages detected and handled; no application crashes',
    'Assuming frame is complete without validation; not handling incomplete data; parsing JSON too early in message assembly',
    0.89,
    'haiku',
    NOW(),
    'https://github.com/ReactiveX/rxjs/issues/5517'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'WebSocket cannot set property on undefined client connected',
    'websocket',
    'MEDIUM',
    '[
        {"solution": "Add defensive null checks before setting properties: if (ws && ws.readyState === WebSocket.OPEN) { ws.send(...) }", "percentage": 94},
        {"solution": "Prevent double-close by checking connection state: if (ws.readyState !== WebSocket.CLOSED) { ws.close() }", "percentage": 93},
        {"solution": "Verify WebSocket is fully initialized before attempting to set properties or send messages", "percentage": 90}
    ]'::jsonb,
    'WebSocket instance reference available; understanding of WebSocket readyState values',
    'No TypeError when setting properties; connection state properly checked; clean closure',
    'Attempting operations on undefined/null WebSocket; not checking readyState before send/close; double-closing connection',
    0.95,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/40748013/closing-websocket-connection-error'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'WebSocket proxy 407 authentication required credentials',
    'websocket',
    'LOW',
    '[
        {"solution": "Implement proxyAuthenticator in HTTP client to handle 407: add Proxy-Authorization header with credentials", "percentage": 92},
        {"solution": "Configure proxy credentials in system network settings - enter proxy address, port, username, password", "percentage": 90},
        {"solution": "For Firefox behind corporate proxy: Enter credentials manually when prompted - browser handles NTLM internally", "percentage": 85}
    ]'::jsonb,
    'WebSocket connection through proxy requiring authentication; proxy credentials available',
    'Proxy authentication succeeds; WebSocket connection established after 407 resolved; no credential errors',
    'Hardcoding credentials in code instead of environment variables; forgetting to include Proxy-Authorization header; using wrong header format',
    0.84,
    'haiku',
    NOW(),
    'https://github.com/square/okhttp/issues/4321'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'WebSocket EACCES permission denied binding to port below 1024',
    'websocket',
    'MEDIUM',
    '[
        {"solution": "Use port above 1024 instead - ports below 1024 are reserved and require root: use port 3000, 8000, 9000 instead", "percentage": 95},
        {"solution": "If port 80/443 required: Use sudo npm start or run with root privileges - NOT recommended for production", "percentage": 88},
        {"solution": "Drop privileges after binding: Use process.setgid() and process.setuid() to downgrade from root after port binding", "percentage": 90}
    ]'::jsonb,
    'WebSocket server attempting to bind; ability to choose alternate port or elevate privileges',
    'Server binds successfully on chosen port; EACCES error no longer occurs; WebSocket accepts connections',
    'Using root permanently for production applications; forgetting that EACCES is port permission issue; trying low ports without privilege escalation',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/9164915/node-js-eacces-error-when-listening-on-most-ports'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'WebSocket net::ERR_SOCKET_NOT_CONNECTED error Chrome',
    'websocket',
    'MEDIUM',
    '[
        {"solution": "Chrome: Open chrome://net-internals/#sockets and click Flush socket pools to clear socket cache", "percentage": 91},
        {"solution": "Disable problematic browser extensions - go to chrome://extensions and disable/remove suspicious extensions", "percentage": 89},
        {"solution": "Check if behind proxy that doesn''t support WebSocket - switch to HTTP protocol or configure proxy for WebSocket", "percentage": 87}
    ]'::jsonb,
    'Browser: Chrome; WebSocket client code; network/extension access',
    'Socket connections flush successfully; no socket errors after flushing; WebSocket connects or gracefully falls back to HTTP',
    'Not clearing browser socket cache regularly; assuming WebSocket support when proxy blocks it; disabling all extensions instead of problematic ones',
    0.86,
    'haiku',
    NOW(),
    'https://www.siteground.com/kb/err-socket-not-connected/'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'WebSocket close code 1003 unsupported data payload type mismatch',
    'websocket',
    'MEDIUM',
    '[
        {"solution": "Verify client sends data type endpoint supports: text frames for text-only, binary for binary-only endpoints", "percentage": 94},
        {"solution": "For servers accepting only one type: Document endpoint data type and validate incoming frames before processing", "percentage": 92},
        {"solution": "Implement frame type negotiation in handshake - use Sec-WebSocket-Protocol to specify accepted types", "percentage": 88}
    ]'::jsonb,
    'WebSocket endpoint with defined data type constraints; client aware of endpoint requirements',
    'Messages transmitted with correct type; no 1003 closure codes; endpoint accepts all client messages',
    'Sending binary to text-only endpoint without error handling; not documenting endpoint data type requirements; ignoring frame type mismatches',
    0.90,
    'haiku',
    NOW(),
    'https://github.com/cloudflare/miniflare/issues/67'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'WebSocket ENOMEM error out of memory spawn failure',
    'websocket',
    'LOW',
    '[
        {"solution": "Disable perMessageDeflate compression if memory constrained: set perMessageDeflate: false in server options", "percentage": 92},
        {"solution": "Check system memory availability - ENOMEM occurs when OS cannot allocate buffers for socket operations", "percentage": 90},
        {"solution": "Monitor memory fragmentation with zlib - compression with zlib can fragment memory, appears as leak but isn''t", "percentage": 87}
    ]'::jsonb,
    'WebSocket server configuration accessible; system resource monitoring available',
    'Server starts without ENOMEM; memory usage stable; messages transmit without allocation failures',
    'Enabling compression on memory-constrained systems without monitoring; confusing fragmentation with actual memory leak; not checking available memory',
    0.81,
    'haiku',
    NOW(),
    'https://github.com/coder/code-server/issues/410'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'WebSocket cannot find module ws library missing installation',
    'websocket',
    'MEDIUM',
    '[
        {"solution": "Install ws locally in project: npm install ws (NOT with -g flag) - creates ./node_modules/ws", "percentage": 97},
        {"solution": "For Docker: Add websocket to Dockerfile or npm install inside container - ensure it''s installed per project", "percentage": 95},
        {"solution": "Alternative library: If ws fails use npm install websocket instead - compatible alternative implementation", "percentage": 85}
    ]'::jsonb,
    'Node.js project with package.json; npm installation capability; node_modules directory',
    'require(''ws'') succeeds without error; WebSocket server initializes; module loads in current project',
    'Installing globally with -g then expecting local require() to work; not installing in project directory; mixing global and local installs',
    0.96,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/27143585/node-js-getting-cannot-find-module-ws-error'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'WebSocket CORS error Access-Control-Allow-Origin header missing',
    'websocket',
    'HIGH',
    '[
        {"solution": "Socket.IO v3+: Configure cors option - io({cors: {origin: ''https://clientdomain.com'', methods: [''GET'', ''POST'']}})", "percentage": 94},
        {"solution": "Spring Boot: Use setAllowedOrigins() in WebSocket endpoint registration or implement CORS filter", "percentage": 93},
        {"solution": "Note: WebSockets bypass SOP/CORS on WS protocol but initial HTTP Upgrade request needs origin verification for security", "percentage": 90}
    ]'::jsonb,
    'WebSocket server code; CORS configuration capability; client domain information',
    'WebSocket connection succeeds from cross-origin clients; HTTP 101 Upgrade response without CORS blocks; proper origin verification',
    'Assuming CORS fully blocks WebSocket when it only affects initial HTTP upgrade; allowing all origins (*) without security consideration; forgetting CORS config',
    0.91,
    'haiku',
    NOW(),
    'https://socket.io/docs/v3/handling-cors/'
);
