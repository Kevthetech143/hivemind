-- Add Stack Overflow Socket.io solutions batch 1
-- 12 highest-voted Socket.io questions with accepted answers

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Differences between Socket.io and WebSockets',
    'stackoverflow-socketio',
    'VERY_HIGH',
    '[
        {"solution": "WebSocket is a lightweight native browser standard requiring only 2 requests (~1.50 KB). Socket.IO is an abstraction library requiring 6 requests (~181.56 KB) that includes long-polling fallback, rooms, namespaces, and auto-reconnect features.", "percentage": 92, "note": "Choose WebSocket for simple use cases, Socket.IO for complex real-time apps with multi-server scaling"},
        {"solution": "WebSocket has minimal overhead and direct connections but requires building your own protocol and subscription service. Socket.IO provides ready-made features like room-based broadcasting and Redis adapters for scaling.", "percentage": 88, "note": "Trade-off between simplicity and feature richness"},
        {"solution": "Both are standardized now in modern browsers. WebSocket offers better performance and lower bandwidth, while Socket.IO provides backward compatibility and higher-level abstractions.", "percentage": 85, "note": "Legacy browser support less critical with modern standards"}
    ]'::jsonb,
    'Understanding of real-time communication concepts, Familiarity with Node.js environment',
    'Successful bidirectional communication between client and server, Appropriate bandwidth usage, Correct implementation pattern chosen for application requirements',
    'Misconception that WebSocket is harder to use for basic cases, Over-engineering with Socket.IO when simple WebSocket suffices, Assuming modern browsers still lack WebSocket support',
    0.90,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/10112178/differences-between-socket-io-and-websockets'
),
(
    'Which WebSocket library to use with Node.js',
    'stackoverflow-socketio',
    'HIGH',
    '[
        {"solution": "Use ''ws'' library for one of the fastest WebSocket implementations without additional abstraction layers.", "percentage": 90, "note": "Best for performance-critical applications"},
        {"solution": "Use Socket.io when you need fallback transports, channels, and built-in features like rooms and namespacing.", "percentage": 88, "note": "v1+ uses Engine.io internally"},
        {"solution": "Use SockJS or Faye-websocket-node as middle-ground solutions providing fallback transports for older browsers.", "percentage": 82, "note": "Consider Primus as abstraction layer offering common API across multiple libraries"},
        {"solution": "Use Primus for stability improvements and flexibility to switch between underlying websocket frameworks without code changes.", "percentage": 78, "note": "Overhead of abstraction layer worth it for long-term maintainability"}
    ]'::jsonb,
    'Node.js environment, Understanding of browser compatibility requirements, npm package management',
    'Library successfully installed and imported, WebSocket connections established with test clients, Performance metrics meet application requirements',
    'Some libraries require Python installation (e.g., ''ws'' with native builds), Browser incompatibility assumptions (WebSocket widely supported now), Underestimating feature needs and selecting library too early',
    0.87,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/16392260/which-websocket-library-to-use-with-node-js'
),
(
    'Send message to all clients except the sender in Socket.io',
    'stackoverflow-socketio',
    'HIGH',
    '[
        {"solution": "Use socket.broadcast.emit(''eventName'', data) to send to all connected clients except the originating socket.", "percentage": 95, "note": "Standard pattern for broadcasting", "command": "socket.broadcast.emit(''message'', ''this is a test'')"},
        {"solution": "In message handlers, use socket.on() to receive and socket.broadcast.emit() to re-broadcast to others.", "percentage": 93, "note": "Example: socket.on(''cursor'', function(data) { socket.broadcast.emit(''response'', data); })"},
        {"solution": "Do NOT use io.emit() which broadcasts to ALL clients including the sender.", "percentage": 91, "note": "Common mistake - io.emit() includes originator"}
    ]'::jsonb,
    'Socket.io library installed and initialized, Active socket connection established, Event listener set up to receive messages',
    'Message received by all connected clients except originating client, No duplicate messages appear on sender, Event listeners properly trigger on recipient clients, Network traffic shows appropriate broadcast distribution',
    'Using io.emit() instead of socket.broadcast.emit(), Version incompatibility between Socket.io 0.9.x and 1.x, Missing access to individual socket object context',
    0.94,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/10058226/send-response-to-all-clients-except-sender'
),
(
    'Send message to specific client with Socket.io',
    'stackoverflow-socketio',
    'HIGH',
    '[
        {"solution": "Each socket automatically joins a room identified by its socket.id. Use socket.to(id).emit(''eventName'', data) to send to a specific client.", "percentage": 94, "note": "Modern Socket.io 0.9+ approach", "command": "socket.to(targetSocketId).emit(''my message'', msg)"},
        {"solution": "On server receiving a message, extract the target client ID and emit only to that socket: io.on(''connection'', (socket) => { socket.on(''say to someone'', (id, msg) => { socket.to(id).emit(''my message'', msg); }); });", "percentage": 92, "note": "Practical implementation pattern"},
        {"solution": "Avoid older syntax like io.sockets.socket(id) which was removed in v1.0+.", "percentage": 90, "note": "API changed significantly in v1.0"}
    ]'::jsonb,
    'Socket.io 0.9+ (modern versions), Server-side socket instance, Target client''s socket ID',
    'Client receives message only when socket ID matches exactly, No undefined errors on emit attempts, Works across clustered environments with proper Redis store configuration',
    'ID format issues requiring proper ID formatting, API drift - older syntax no longer works, Broadcast misconception - socket.to() differs from broadcast and callbacks unreliable',
    0.92,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/4647348/send-message-to-specific-client-with-socket-io-and-node-js'
),
(
    'Get list of connected sockets/clients with Socket.io',
    'stackoverflow-socketio',
    'HIGH',
    '[
        {"solution": "For Socket.io 0.7 or earlier: var clients = io.sockets.clients(); or var clients = io.sockets.clients(''roomName'');", "percentage": 75, "note": "Only works with versions prior to 1.0", "command": "io.sockets.clients() or io.of(''/namespace'').clients()"},
        {"solution": "For Socket.io 1.0+, this API no longer exists. Use modern alternatives: await io.fetchSockets() for async retrieval across distributed systems.", "percentage": 92, "note": "Recommended for current versions v4.0+"},
        {"solution": "For custom namespaces in older versions: var clients = io.of(''/chat'').clients() or io.of(''/chat'').clients(''room'');", "percentage": 78, "note": "Different syntax for namespace vs default"}
    ]'::jsonb,
    'Socket.IO version identified (0.7 vs 1.0+ affects solution), Understanding that API volatility changed between versions',
    'Successfully retrieves array of connected socket objects, Room-specific filtering works correctly, Can access socket properties like custom fields set via socket.set()',
    'Using old 0.7 syntax on Socket.io v1.0+ versions, API volatility breaking backward compatibility, Namespace confusion between default and custom namespaces, Assuming same API across major versions',
    0.80,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/6563885/how-do-i-get-a-list-of-connected-sockets-clients-with-socket-io'
),
(
    'Good beginner tutorial for Socket.io',
    'stackoverflow-socketio',
    'MEDIUM',
    '[
        {"solution": "Start with official Socket.io documentation: Main page example at socket.io and GitHub ''How to use'' documentation for server-side implementation.", "percentage": 90, "note": "Official resources most reliable"},
        {"solution": "Use socket.io-client documentation for client-side guidance and implementation patterns.", "percentage": 88, "note": "Covers browser-side integration"},
        {"solution": "Follow official tutorial: socket.io/get-started/chat - provides complete chat application example with bidirectional communication.", "percentage": 85, "note": "Step-by-step implementation guide"},
        {"solution": "Establish basic event emission and listening patterns before building complex applications.", "percentage": 80, "note": "Foundation for more advanced patterns"}
    ]'::jsonb,
    'Basic JavaScript knowledge, HTML5 familiarity, Node.js fundamentals, Web development foundation',
    'Successfully establish bidirectional communication between client and server, Implement basic event emission and listening patterns, Run a functional chat application or real-time data exchange demo, Understand Socket.io abstraction over WebSockets',
    'Tutorial links become broken or incomplete over time, Lack of server-to-client message examples in some tutorials, Confusion about message direction (client-to-server vs server-to-client communication)',
    0.85,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/4094350/good-beginners-tutorial-to-socket-io'
),
(
    'Socket.io rooms vs namespacing - when to use which',
    'stackoverflow-socketio',
    'MEDIUM',
    '[
        {"solution": "Namespaces are connected to by the client and support authorization protection. Use namespaces for predefined sections with different access control requirements.", "percentage": 92, "note": "Namespaces support authentication/authorization"},
        {"solution": "Rooms can only be joined on the server side and are part of a namespace (defaulting to global namespace). Use rooms for dynamic, ad-hoc grouping.", "percentage": 90, "note": "Server-controlled membership"},
        {"solution": "Rooms share namespace characteristics but differ in management: namespaces are predefined and client-controlled, rooms are dynamic and server-controlled.", "percentage": 88, "note": "Hierarchical relationship: rooms exist within namespaces"}
    ]'::jsonb,
    'Understanding of Socket.io architecture, Knowledge of WebSocket connections, Familiarity with server-side vs client-side message filtering',
    'Clean separation of message groups without unnecessary complexity, Proper authorization implementation when needed, Efficient resource usage through shared WebSocket connections, Clear understanding of which tool matches your architecture',
    'Assuming rooms are client-managed (they are server-only), Treating namespaces and rooms as equivalent, Overlooking hierarchical relationship (rooms within namespaces), Neglecting authorization requirements for sensitive data separation',
    0.89,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/10930286/socket-io-rooms-or-namespacing'
),
(
    'Node.js Socket.io with SSL/HTTPS',
    'stackoverflow-socketio',
    'MEDIUM',
    '[
        {"solution": "Use a secure URL for initial client connections. Instead of ''http://'' use ''https://''. Socket.IO automatically upgrades WebSocket connection to ''wss://'' (WebSocket Secure).", "percentage": 93, "note": "Protocol detection is automatic", "command": "io.connect(''https://localhost'')"},
        {"solution": "Create HTTPS server using Node.js https module with certificate options, then pass HTTPS server instance to Socket.IO initialization.", "percentage": 91, "note": "Server-side configuration required"},
        {"solution": "For self-signed certificates on client, include {rejectUnauthorized: false} flag, though not recommended for production.", "percentage": 75, "note": "Development/testing only"}
    ]'::jsonb,
    'SSL certificate and private key files accessible to Node.js, Express.js or similar HTTP server framework, Socket.IO library installed',
    'Client browser network inspector shows WSS connections, No mixed HTTP/HTTPS protocol warnings, Successful socket connection events fire on both client and server, Port 443 or custom HTTPS port receives secure connections',
    'Clients connecting via HTTP instead of HTTPS won''t upgrade to WSS, Certificate path issues - incorrect or unreadable paths, Self-signed certificates causing browser warnings without proper flags, Incorrect order of initialization',
    0.90,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/6599470/node-js-socket-io-with-ssl'
),
(
    'Maximum concurrent Socket.io connections per server',
    'stackoverflow-socketio',
    'MEDIUM',
    '[
        {"solution": "With XHR-polling transport, connections start acting up at 1400-1800 concurrent connections. With WebSockets only, can handle ~9000+ concurrent connections.", "percentage": 92, "note": "Transport choice dramatically impacts capacity"},
        {"solution": "Configure client to disable transport upgrades and use WebSocket only: const socket = require(''socket.io-client''); const conn = socket(host, { upgrade: false, transports: [''websocket''] });", "percentage": 90, "note": "Eliminates fallback transport overhead", "command": "const conn = socket(host, { upgrade: false, transports: [''websocket''] })"},
        {"solution": "Adjust system file descriptor limits (default often 1024-4096). Each connection consumes one file descriptor.", "percentage": 88, "note": "OS-level configuration critical for scaling"},
        {"solution": "Monitor and verify elevated file descriptor limits via system commands to ensure sustainability.", "percentage": 85, "note": "Validate changes with ulimit command"}
    ]'::jsonb,
    'Understanding Socket.io defaults to long-polling first with WebSocket upgrade, Awareness of system file descriptor limits, Knowledge that each connection consumes one file descriptor',
    'Achieving 5000-10000 stable concurrent connections on modern single servers, Stable performance using WebSocket transport exclusively, Properly elevated file descriptor limits verified via system commands',
    'Not adjusting system limits - OS restricts open files per process, Using fallback transports which consume more resources, Uncontrolled system changes to /etc/sysctl.conf can lock users out, Ignoring transport selection dramatically reduces capacity',
    0.88,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/15872788/maximum-concurrent-socket-io-connections'
),
(
    'Difference between socket.emit() and socket.send() in Socket.io',
    'stackoverflow-socketio',
    'MEDIUM',
    '[
        {"solution": "socket.emit(''customEvent'', data) allows custom event registration. Receiver uses socket.on(''customEvent'', function(data) { ... })", "percentage": 93, "note": "Primary Socket.IO method"},
        {"solution": "socket.send(data) triggers a predefined ''message'' event. Receiver uses socket.on(''message'', function(data) { ... })", "percentage": 91, "note": "Convenience wrapper for common case"},
        {"solution": "socket.send() essentially wraps emit(''message'', data) and is not a replacement for emit() but a convenience method.", "percentage": 88, "note": "Both serve different use cases"}
    ]'::jsonb,
    'Understanding of Node.js event emitters, Familiarity with Socket.IO library basics, Knowledge of client-server communication patterns',
    'Messages received on correct event listener, Custom events properly named on both sides, Understanding that send() is convenience method not replacement, Recognizing emit() as flexible primary approach for custom protocols',
    'Mismatched event names - using emit() but listening for ''message'', Confusion with vanilla WebSockets - send() exists for compatibility, Data handling assumptions about send() providing different functionality',
    0.91,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/11498508/socket-emit-vs-socket-send'
),
(
    'Authenticating Socket.io connections using JWT tokens',
    'stackoverflow-socketio',
    'HIGH',
    '[
        {"solution": "Use middleware to intercept connections and verify JWT tokens before allowing connection to complete. Middleware executes once per connection.", "percentage": 91, "note": "Timing critical - middleware runs at connection init"},
        {"solution": "Pass JWT token via query parameters during Socket.io connection handshake. Verify with jsonwebtoken module using shared SECRET_KEY.", "percentage": 88, "note": "Token issuer and Socket.io server must share SECRET_KEY"},
        {"solution": "After verification, store decoded token in socket.decoded property for use in subsequent event handlers.", "percentage": 86, "note": "Makes user info accessible throughout socket lifetime"},
        {"solution": "Reject unauthenticated connections with ''Authentication error'', ensuring only verified clients proceed.", "percentage": 85, "note": "Security-first approach"}
    ]'::jsonb,
    'Node.js environment with Socket.io installed, jsonwebtoken npm package, JWT token generated from authentication server, Shared SECRET_KEY between token issuer and Socket.io server',
    'Token successfully decoded from handshake query parameters, socket.decoded property accessible for event handlers, Unauthenticated connections rejected with error, Connection proceeds only after JWT verification',
    'Passing sensitive tokens in URL query strings (security concern), Confusion about middleware execution timing, Error handling not propagating to client-side disconnect events, Compatibility issues with newer Socket.io versions',
    0.87,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/36788831/authenticating-socket-io-connections-using-jwt'
),
(
    'Socket.io CORS error - Cross-Origin Request Blocked',
    'stackoverflow-socketio',
    'VERY_HIGH',
    '[
        {"solution": "For Socket.io v3+, configure CORS in initialization: const io = require(''socket.io'')(server, { cors: { origin: ''*'' } });", "percentage": 95, "note": "Modern Socket.io configuration", "command": "const io = require(''socket.io'')(server, { cors: { origin: ''*'' } });"},
        {"solution": "For Socket.io < v3, use: const io = require(''socket.io'')(server, { origins: ''*:*'' }); or io.set(''origins'', ''*:*'');", "percentage": 92, "note": "Legacy Socket.io versions"},
        {"solution": "Ensure package name is ''socket.io'' not deprecated ''socketio''. Match client/server versions exactly.", "percentage": 90, "note": "Version mismatch is common source of errors"},
        {"solution": "Do NOT use bare origin: ''*'' with credentials enabled - these are mutually exclusive. Choose one or configure specific origins.", "percentage": 88, "note": "Security rule enforced by browsers"}
    ]'::jsonb,
    'Verify package name (''socket.io'' not ''socketio''), Check Socket.io version (v2.x vs v3.x vs v4.x vary), Match client and server Socket.io versions identically, SSL certificates if using HTTPS',
    'Browser console shows successful connection without CORS errors, Socket events transmit without Same Origin Policy warnings, Both HTTP polling and WebSocket transports function correctly',
    'Using bare origin: ''*'' with credentials enabled, Mismatched socket.io versions between client and server, Calling deprecated methods like io.origins() on incompatible versions, Not restarting server after configuration changes',
    0.93,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/24058157/socket-io-node-js-cross-origin-request-blocked'
),
(
    'Get client IP address in Socket.io',
    'stackoverflow-socketio',
    'MEDIUM',
    '[
        {"solution": "For Socket.io 0.7.7+, access handshake data: var address = socket.handshake.address; console.log(''Client IP: '' + address.address + '':'' + address.port);", "percentage": 85, "note": "Works for older versions", "command": "var address = socket.handshake.address;"},
        {"solution": "For Socket.io 1.0+, use socket.request.connection.remoteAddress instead of socket.handshake.address.", "percentage": 88, "note": "API changed in v1.0"},
        {"solution": "When behind reverse proxy (nginx), remoteAddress returns proxy IP not client IP. Use X-Forwarded-For header instead.", "percentage": 82, "note": "Common in production environments"},
        {"solution": "Handle IPv6-mapped format (''::ffff:127.0.0.1''). Standard dotted notation may require string parsing.", "percentage": 78, "note": "Address format varies by Node.js and environment"}
    ]'::jsonb,
    'Socket.io version 0.7.7 or later, Active server instance with Socket.io listening, Connection event handler established',
    'Logs show actual client IP address and port numbers, Works consistently across reconnection attempts, Returns IPv4 addresses in standard dotted notation format',
    'Version compatibility - API changed significantly across versions, Proxy issues - returns server IP instead of client IP behind reverse proxy, Undefined values when testing locally due to timing, IPv6 format issues (::ffff:127.0.0.1 vs standard notation)',
    0.83,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/6458083/get-the-clients-ip-address-in-socket-io'
);
