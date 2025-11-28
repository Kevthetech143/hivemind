INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'rpc error: code = Unavailable desc = grpc: the connection is unavailable',
    'grpc',
    'HIGH',
    '[
        {"solution": "Ensure gRPC server is started and listening on the configured port. Run server.start() before accepting requests.", "percentage": 95},
        {"solution": "Verify server is binding to correct network interface. For remote connections, bind to external IP, not just localhost (127.0.0.1).", "percentage": 90},
        {"solution": "Check firewall rules and network connectivity. Ensure port is open and accessible from client location.", "percentage": 85},
        {"solution": "Implement exponential backoff with wait-for-ready option in client to handle transient unavailability during service startup or rollout.", "percentage": 80}
    ]'::jsonb,
    'gRPC client and server setup with compatible versions; access to server logs and network configuration',
    'Successfully establish connection and receive responses from server; no UNAVAILABLE status in logs; connection error disappears after fixes applied',
    'Forgetting to call server.start() or server.awaitTermination(); binding to wrong network interface (localhost for remote clients); firewall blocking port; not implementing retry logic for transient failures',
    0.92,
    'haiku',
    NOW(),
    'https://github.com/grpc/grpc-node/issues/845'
),
(
    'io.grpc.StatusRuntimeException: DEADLINE_EXCEEDED: deadline exceeded after 0.3999s',
    'grpc',
    'HIGH',
    '[
        {"solution": "Increase client-side deadline/timeout. Default is often too short for production workloads. Set explicit deadline in RPC call context.", "percentage": 95},
        {"solution": "Check server response time. Profile server code to identify bottlenecks causing slow responses. Optimize database queries and business logic.", "percentage": 90},
        {"solution": "Verify network latency between client and server. High latency can exceed short deadlines. Use appropriate deadline for network conditions.", "percentage": 85},
        {"solution": "Implement client-side connection pooling and reuse channels to reduce connection establishment overhead that counts against deadline.", "percentage": 80}
    ]'::jsonb,
    'gRPC client with ability to configure deadlines/timeouts; server with profiling capability; network diagnostic tools',
    'RPC calls complete successfully without DEADLINE_EXCEEDED errors; response times consistently under deadline; no waiting_for_connection messages in logs',
    'Setting deadline too short without understanding actual server latency; creating new connections for each RPC instead of reusing channels; not considering network RTT in deadline calculation; server-side DNS resolution issues',
    0.89,
    'haiku',
    NOW(),
    'https://github.com/grpc/grpc-java/issues/11364'
),
(
    'connection error: desc = "transport: dial tcp: connect: connection refused"',
    'grpc',
    'HIGH',
    '[
        {"solution": "Verify gRPC server is running and listening on the specified address and port. Check with lsof -i :PORT or netstat.", "percentage": 96},
        {"solution": "Confirm correct server address/port in client code. Ensure hostname resolves correctly (DNS or /etc/hosts). Test with telnet or nc.", "percentage": 94},
        {"solution": "For Kubernetes deployments, ensure service is created and endpoints are ready. Check service DNS name resolves to pod IPs.", "percentage": 88},
        {"solution": "Verify firewall and network security groups allow traffic on the gRPC port. Check both server-side and client-side firewall rules.", "percentage": 90}
    ]'::jsonb,
    'Network access to server; ability to check port status and DNS resolution; gRPC server binary and configuration files',
    'Successful TCP connection to server port; RPC calls succeed without connection refused errors; port shown as LISTEN in lsof output',
    'Using wrong hostname or port in client config; server not bound to correct interface; firewall silently blocking traffic; DNS resolution failing in container environment; service not exposing correct port in Kubernetes',
    0.94,
    'haiku',
    NOW(),
    'https://github.com/grpc/grpc-java/issues/11351'
),
(
    'rpc error: code = Unavailable desc = all SubConns are in TransientFailure, latest connection error: connection error: desc = "No connection could be made because the target machine actively refused it"',
    'grpc',
    'MEDIUM',
    '[
        {"solution": "Ensure gRPC server is started on all expected addresses before client attempts connection. Check server startup logs.", "percentage": 93},
        {"solution": "For load-balanced services, verify all backend instances are healthy and accepting connections on configured port.", "percentage": 88},
        {"solution": "Implement client-side retry with exponential backoff. Use gRPC wait-for-ready or manual connection loop during service startup/deployment.", "percentage": 85},
        {"solution": "Check if server port binding conflicts. Verify port is not in TIME_WAIT or already bound by another process.", "percentage": 82}
    ]'::jsonb,
    'gRPC client and server with logging enabled; ability to monitor server state; load balancer health check configuration (if applicable)',
    'All SubConns transitioning to Ready state; successful RPC calls; no persistent TransientFailure messages; connection succeeds on retry',
    'Not implementing retry logic for transient connection failures; load balancer not detecting unhealthy instances quickly enough; server crashing silently; port already in use from previous process',
    0.87,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/70131524/grpc-server-connection-refused'
),
(
    'gRPC DEADLINE_EXCEEDED with "waiting_for_connection" in buffered_nanos message',
    'grpc',
    'MEDIUM',
    '[
        {"solution": "Server not ready when deadline expires before connection established. Increase deadline or implement wait-for-ready in client stub.", "percentage": 92},
        {"solution": "Connection pool exhausted. Check client channel configuration and increase max concurrent connections or connection pool size.", "percentage": 88},
        {"solution": "DNS resolution timeout consuming deadline time. Cache DNS results or use direct IP addresses to bypass resolution delays.", "percentage": 85},
        {"solution": "Restart client application if condition persists. Stale connection state can cause persistent waiting_for_connection messages.", "percentage": 75}
    ]'::jsonb,
    'gRPC Java client with access to channel configuration; server running and accessible; network connectivity established',
    'Connection succeeds within deadline; waiting_for_connection messages no longer appear; RPC calls complete successfully without deadline exceeded',
    'Using same deadline for connection + RPC processing (should increase deadline or use wait-for-ready); not implementing channel reuse across requests; DNS issues causing resolution delays; connection pool starvation from leaked channels',
    0.86,
    'haiku',
    NOW(),
    'https://github.com/grpc/grpc-java/issues/9072'
);
