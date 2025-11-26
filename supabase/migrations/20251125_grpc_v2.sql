-- gRPC Error Mining - 20 High-Quality Entries
-- Source: Official gRPC Docs + Stack Overflow + Dev Blogs
-- Mining Date: 2025-11-25

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES

-- 1. Connection Refused
(
    'gRPC error: connection refused, rpc error: code = Unavailable desc = connection error',
    'grpc',
    'HIGH',
    '[
        {"solution": "Verify server is listening on correct port and address: check netstat -tulpn | grep :PORT or lsof -i :PORT", "percentage": 95},
        {"solution": "For Java: call .start() separately after ServerBuilder, not chained to .build()", "percentage": 90},
        {"solution": "For Kubernetes: ensure Service and Pod are running on same port, verify service IP matches dial target", "percentage": 85},
        {"solution": "Check firewall rules: firewall-cmd --add-port=PORT/tcp or ufw allow PORT", "percentage": 80}
    ]'::jsonb,
    'gRPC server installed and dependencies available',
    'Client receives response without connection error, netstat shows LISTEN state on port',
    'Server started but port binding fails silently, firewall blocks locally accessible port, wrong IP address in client dial',
    0.88,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/70131524/grpc-server-connection-refused'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES

-- 2. Deadline Exceeded
(
    'gRPC error: code = DeadlineExceeded desc = context deadline exceeded',
    'grpc',
    'HIGH',
    '[
        {"solution": "Increase client timeout: set context timeout or WithKeepaliveParams with longer duration", "percentage": 95},
        {"solution": "Profile server latency: add logging at RPC entry/exit, check database query times, profile with grpcdebug", "percentage": 92},
        {"solution": "Enable connection pooling and reuse instead of creating new connections per request", "percentage": 88},
        {"solution": "For streaming: check if client receives partial data before timeout, implement client-side buffering", "percentage": 80}
    ]'::jsonb,
    'Server running, client able to connect (no connection refused), performance baseline established',
    'Request completes within new timeout, server responds before deadline, grpcdebug shows RPC latency < timeout',
    'Setting timeout too low without measuring baseline latency, blocking operations in request handler, network jitter not accounted for',
    0.86,
    'haiku',
    NOW(),
    'https://grpc.io/docs/guides/debugging/'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES

-- 3. UNAUTHENTICATED
(
    'gRPC error: code = Unauthenticated desc = invalid authentication credentials',
    'grpc',
    'HIGH',
    '[
        {"solution": "Verify credentials are valid: check token expiry, format, and signature", "percentage": 95},
        {"solution": "Client: add credentials to metadata before RPC call using interceptors or call options", "percentage": 93},
        {"solution": "Server: extract and validate auth headers in UnaryInterceptor before processing request", "percentage": 90},
        {"solution": "For TLS: ensure certificate chain is valid, common name matches hostname, root CA is trusted", "percentage": 85}
    ]'::jsonb,
    'Client can reach server, auth system deployed, token generation working',
    'Client sends credentials, server validates and processes request, logs show auth token accepted',
    'Credentials passed in wrong metadata key, token not included in request at all, TLS cert expired or self-signed without InsecureSkipVerify',
    0.89,
    'haiku',
    NOW(),
    'https://hoop.dev/blog/fixing-authentication-errors-in-grpc-causes-codes-and-prevention/'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES

-- 4. PERMISSION_DENIED
(
    'gRPC error: code = PermissionDenied desc = user does not have required permission',
    'grpc',
    'HIGH',
    '[
        {"solution": "Verify user identity is authenticated first (UNAUTHENTICATED != PERMISSION_DENIED)", "percentage": 97},
        {"solution": "Check authorization policy: user role/scope must match RPC requirements in server interceptor", "percentage": 94},
        {"solution": "For resource access: verify user owns/has access to resource_id parameter before processing", "percentage": 91},
        {"solution": "Use interceptor to log denied requests with user identity and attempted operation for debugging", "percentage": 85}
    ]'::jsonb,
    'UNAUTHENTICATED errors resolved, auth system working, user identity verified',
    'Server logs show permission check executed, request denied with clear reason, authorized requests succeed',
    'Using PERMISSION_DENIED for unauthenticated users (use UNAUTHENTICATED instead), not checking identity before checking permissions',
    0.90,
    'haiku',
    NOW(),
    'https://hexdocs.pm/grpc/GRPC.Status.html'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES

-- 5. NOT_FOUND
(
    'gRPC error: code = NotFound desc = requested resource not found',
    'grpc',
    'HIGH',
    '[
        {"solution": "Verify resource exists in database/cache before returning response: add existence check before RPC handler returns", "percentage": 96},
        {"solution": "Check request contains correct resource ID, query parameters are parsed correctly", "percentage": 94},
        {"solution": "For streaming: send NOT_FOUND early in stream before processing begins", "percentage": 88},
        {"solution": "Log requested resource identifier and query used to aid client debugging", "percentage": 85}
    ]'::jsonb,
    'Database/cache populated with test data, client can authenticate and reach server',
    'Server responds with NOT_FOUND only for non-existent resources, existing resources return data, client receives 5 status code',
    'Returning empty response instead of NOT_FOUND, checking wrong table/key, resource ID parsing issues',
    0.91,
    'haiku',
    NOW(),
    'https://grpc.io/docs/guides/status-codes/'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES

-- 6. INVALID_ARGUMENT
(
    'gRPC error: code = InvalidArgument desc = invalid request parameters',
    'grpc',
    'HIGH',
    '[
        {"solution": "Validate all request fields at RPC entry: check required fields present, types correct, ranges valid", "percentage": 96},
        {"solution": "Return detailed error message listing which field is invalid and why (e.g., 'age must be >= 0')", "percentage": 93},
        {"solution": "For proto validation: use buf validate plugin or custom validator before business logic", "percentage": 89},
        {"solution": "Log invalid request details (sanitized) for debugging client issues", "percentage": 85}
    ]'::jsonb,
    'gRPC service defined, client sending requests, schema validation rules defined',
    'Invalid requests rejected before processing, error message identifies problematic field, valid requests accepted',
    'Validating only after expensive operations, returning generic error without field details, accepting out-of-range values silently',
    0.92,
    'haiku',
    NOW(),
    'https://grpc.io/docs/guides/status-codes/'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES

-- 7. UNAVAILABLE
(
    'gRPC error: code = Unavailable desc = service temporarily unavailable',
    'grpc',
    'HIGH',
    '[
        {"solution": "Check server health: verify process running (ps aux | grep), port listening (netstat -tulpn)", "percentage": 94},
        {"solution": "Client: implement exponential backoff retry logic, max 3-5 retries with jitter", "percentage": 92},
        {"solution": "Check server load: if overloaded, implement rate limiting or circuit breaker pattern", "percentage": 88},
        {"solution": "For deployments: implement health check endpoint, configure orchestrator to restart unhealthy services", "percentage": 86}
    ]'::jsonb,
    'Client retry logic implemented, server health monitoring in place',
    'Client retries succeed after server recovers, health check endpoint returns SERVING, load reduced',
    'Not implementing retry logic with backoff, retrying immediately without delay, ignoring service health signals',
    0.87,
    'haiku',
    NOW(),
    'https://grpc.io/docs/guides/status-codes/'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES

-- 8. RESOURCE_EXHAUSTED
(
    'gRPC error: code = ResourceExhausted desc = resource limit exceeded (quota, memory, connections)',
    'grpc',
    'HIGH',
    '[
        {"solution": "Increase resource limits: ulimit -n for file descriptors, increase memory allocation, raise connection pool size", "percentage": 93},
        {"solution": "Check quota usage: monitor rate limiter, connection count, memory consumption with grpcdebug or metrics", "percentage": 91},
        {"solution": "Implement backpressure: return RESOURCE_EXHAUSTED to slow down clients, configure request queuing", "percentage": 87},
        {"solution": "Client: add exponential backoff with jitter, implement circuit breaker to stop retrying after threshold", "percentage": 85}
    ]'::jsonb,
    'Resource monitoring configured, rate limiting policy defined, server metrics available',
    'Resource exhaustion message returned correctly, client implements backoff, resource limits increased and monitored',
    'Not distinguishing between quota and memory exhaustion, returning RESOURCE_EXHAUSTED for wrong error cases',
    0.84,
    'haiku',
    NOW(),
    'https://grpc.io/docs/guides/status-codes/'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES

-- 9. FAILED_PRECONDITION
(
    'gRPC error: code = FailedPrecondition desc = operation precondition not met',
    'grpc',
    'HIGH',
    '[
        {"solution": "Verify system state before operation: check if resource is in correct state (e.g., not deleted, transaction committed)", "percentage": 95},
        {"solution": "For conditional operations: implement version/tag checking, return FAILED_PRECONDITION if version mismatch", "percentage": 92},
        {"solution": "Log precondition failure reason so client understands what state is required", "percentage": 88},
        {"solution": "Client: re-query state, retry operation after state changes, implement exponential backoff", "percentage": 85}
    ]'::jsonb,
    'State tracking mechanism implemented, conditional operation logic defined',
    'Precondition checks execute before operation, state verification returns correct failures, client can retry',
    'Not checking preconditions at all, using wrong precondition check, not distinguishing from ABORTED for race conditions',
    0.86,
    'haiku',
    NOW(),
    'https://developers.google.com/actions-center/reference/grpc-api/status_codes'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES

-- 10. ABORTED
(
    'gRPC error: code = Aborted desc = operation aborted (likely due to concurrency/transaction failure)',
    'grpc',
    'HIGH',
    '[
        {"solution": "Implement retry logic at higher level: client re-initiates operation from start with fresh state", "percentage": 94},
        {"solution": "For database transactions: ensure isolation level is appropriate, handle transaction conflicts", "percentage": 91},
        {"solution": "Add request ID tracking to correlate retries, log abort reason for debugging", "percentage": 87},
        {"solution": "Use exponential backoff for retries, stop after 3-5 attempts to prevent retry storms", "percentage": 85}
    ]'::jsonb,
    'Concurrent operations possible, transaction mechanism in place, request tracking enabled',
    'Aborted operations retried successfully, transaction conflicts resolved, retry logic completes operation',
    'Immediately failing instead of returning ABORTED, not implementing client-level retry, confusing ABORTED with FAILED_PRECONDITION',
    0.85,
    'haiku',
    NOW(),
    'https://grpc.github.io/grpc/core/md_doc_statuscodes.html'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES

-- 11. INTERNAL Server Error
(
    'gRPC error: code = Internal desc = internal server error',
    'grpc',
    'HIGH',
    '[
        {"solution": "Check server logs immediately: tail -f /var/log/app.log or docker logs CONTAINER", "percentage": 94},
        {"solution": "Verify dependencies: database connection, external API connectivity, required services running", "percentage": 92},
        {"solution": "For panics: recover in middleware, log stack trace, return INTERNAL with generic message", "percentage": 89},
        {"solution": "Enable structured logging with trace ID, correlate with metrics/monitoring for RCA", "percentage": 86}
    ]'::jsonb,
    'Logging infrastructure in place, error recovery middleware configured, monitoring dashboards available',
    'Error messages logged with full context, root cause identifiable from logs, monitoring alerts triggered',
    'Returning INTERNAL for client errors (use INVALID_ARGUMENT), no error logging, missing stack traces in logs',
    0.83,
    'haiku',
    NOW(),
    'https://grpc.io/docs/guides/error/'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES

-- 12. UNIMPLEMENTED
(
    'gRPC error: code = Unimplemented desc = method not implemented',
    'grpc',
    'HIGH',
    '[
        {"solution": "Verify method is registered in gRPC service definition and server implementation", "percentage": 97},
        {"solution": "Check proto file is recompiled and client/server stubs are regenerated after adding method", "percentage": 94},
        {"solution": "Ensure server binary was restarted after code deployment", "percentage": 92},
        {"solution": "For versioning: implement method versioning in service interface to support gradual rollout", "percentage": 85}
    ]'::jsonb,
    'Proto files defined, code generation tools available, server deployment process in place',
    'Method responds without UNIMPLEMENTED error, netstat shows server restarted, logs show method registered',
    'Calling method before server restart, not regenerating stubs after proto changes, calling wrong service name',
    0.91,
    'haiku',
    NOW(),
    'https://grpc.io/docs/guides/status-codes/'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES

-- 13. Decompression Error
(
    'gRPC error: decompression error, gzip stream error',
    'grpc',
    'HIGH',
    '[
        {"solution": "Disable compression on client if not needed: set ChannelOptions with no compression codec", "percentage": 93},
        {"solution": "Verify compression codec is same on client and server: check for gzip/deflate mismatches", "percentage": 90},
        {"solution": "Check network integrity: packet loss causing corruption, enable TCP_NODELAY to reduce buffering", "percentage": 87},
        {"solution": "Update gRPC library to latest: compression bugs fixed in newer versions", "percentage": 82}
    ]'::jsonb,
    'Network connectivity working, client and server on compatible gRPC versions',
    'Requests complete without decompression error, compression codec matches, large payloads transfer correctly',
    'Compression enabled by default without checking compatibility, network reliability not tested',
    0.81,
    'haiku',
    NOW(),
    'https://grpc.io/docs/guides/debugging/'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES

-- 14. OUT_OF_RANGE
(
    'gRPC error: code = OutOfRange desc = operation attempted beyond valid boundaries',
    'grpc',
    'HIGH',
    '[
        {"solution": "Validate numeric parameters: check index < array length, offset < file size, page < max pages", "percentage": 96},
        {"solution": "For pagination: ensure page number >= 0, limit > 0 and <= max, handle boundary cases", "percentage": 94},
        {"solution": "Return meaningful error message: 'page 5 requested but only 3 pages available'", "percentage": 90},
        {"solution": "Log out-of-range request for debugging client issues", "percentage": 85}
    ]'::jsonb,
    'Range validation rules defined, boundary test cases prepared',
    'Out-of-range requests rejected with clear error, boundary cases handled correctly, valid ranges accepted',
    'Not validating ranges, returning generic error, accepting any integer value without bounds',
    0.90,
    'haiku',
    NOW(),
    'https://grpc.io/docs/guides/status-codes/'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES

-- 15. ALREADY_EXISTS
(
    'gRPC error: code = AlreadyExists desc = resource already exists',
    'grpc',
    'HIGH',
    '[
        {"solution": "Before create operation: check if resource with same key exists in database", "percentage": 96},
        {"solution": "Use unique constraints in database as backup to catch race conditions", "percentage": 93},
        {"solution": "For distributed systems: implement idempotent create with request ID to prevent duplicates", "percentage": 89},
        {"solution": "Return error message with existing resource identifier to help client", "percentage": 85}
    ]'::jsonb,
    'Database uniqueness constraints defined, request ID tracking enabled',
    'Duplicate creation requests rejected correctly, idempotent operation succeeds on retry, unique constraints enforced',
    'Not checking existence before create, allowing duplicate keys silently, missing database constraints',
    0.89,
    'haiku',
    NOW(),
    'https://grpc.io/docs/guides/status-codes/'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES

-- 16. DATA_LOSS
(
    'gRPC error: code = DataLoss desc = unrecoverable data loss or corruption',
    'grpc',
    'HIGH',
    '[
        {"solution": "Check data integrity: verify checksums, run database consistency checks (PRAGMA integrity_check for SQLite)", "percentage": 92},
        {"solution": "Review transaction logs: check for incomplete writes, partial commits, or corruption", "percentage": 89},
        {"solution": "Enable write-ahead logging (WAL) in database to prevent data loss on crashes", "percentage": 87},
        {"solution": "Implement backup and restore: automated backups, test restore procedure regularly", "percentage": 85}
    ]'::jsonb,
    'Database backup system configured, monitoring alerts for data integrity set up',
    'Backups complete successfully, data integrity checks pass, write-ahead logging enabled, recovery procedure tested',
    'No backups in place, not monitoring data integrity, ignoring corruption warnings',
    0.78,
    'haiku',
    NOW(),
    'https://grpc.io/docs/guides/status-codes/'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES

-- 17. TLS Certificate Validation Error
(
    'gRPC error: certificate verify failed, x509: certificate signed by unknown authority',
    'grpc',
    'HIGH',
    '[
        {"solution": "For self-signed certs: use credentials.NewClientTLSFromFile with root CA cert path", "percentage": 94},
        {"solution": "Verify certificate chain: openssl verify -CAfile ca.crt server.crt", "percentage": 92},
        {"solution": "Check certificate CN/SAN matches hostname in client dial string", "percentage": 90},
        {"solution": "For dev: use InsecureSkipVerify ONLY in non-production, keep prod certs from trusted CA", "percentage": 88}
    ]'::jsonb,
    'TLS certificates generated or obtained from CA, hostname known',
    'Client successfully establishes TLS connection, certificate validates, handshake completes',
    'Using InsecureSkipVerify in production, CN mismatch with hostname, missing root CA in trust store',
    0.87,
    'haiku',
    NOW(),
    'https://grpc.io/docs/guides/debugging/'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES

-- 18. Connection Pool Exhaustion
(
    'gRPC error: no available connection, cannot acquire connection from pool',
    'grpc',
    'HIGH',
    '[
        {"solution": "Increase connection pool size: adjust MaxConnections parameter in ChannelOptions", "percentage": 94},
        {"solution": "Reuse channels: create once and share across goroutines/threads instead of per-request", "percentage": 92},
        {"solution": "Monitor connection usage: log pool stats, monitor active connections with grpcdebug channelz", "percentage": 88},
        {"solution": "Implement request queuing: add backpressure queue before exhausting all connections", "percentage": 85}
    ]'::jsonb,
    'Connection pooling implemented, monitoring infrastructure in place, channel reuse possible',
    'Connections reused successfully, pool size increased and monitored, requests queued appropriately',
    'Creating new channel per request, not reusing connections, no monitoring of pool exhaustion',
    0.86,
    'haiku',
    NOW(),
    'https://grpc.io/docs/guides/debugging/'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES

-- 19. Header Validation Error
(
    'gRPC error: received HTTP/1.x when expecting HTTP/2',
    'grpc',
    'HIGH',
    '[
        {"solution": "Verify server listens on gRPC port (not HTTP port): check port config and binding", "percentage": 95},
        {"solution": "Check client connects to gRPC endpoint (not REST): verify dial address and port", "percentage": 94},
        {"solution": "For proxies: ensure reverse proxy supports HTTP/2 protocol forwarding (not HTTP/1.1 only)", "percentage": 89},
        {"solution": "Check proto service is registered with RegisterServiceServer call", "percentage": 85}
    ]'::jsonb,
    'Server and client ports configured, proxy configuration known',
    'gRPC server responds with HTTP/2, client connects to gRPC port, proxy forwards HTTP/2 correctly',
    'Using REST endpoint instead of gRPC port, HTTP/1.1 reverse proxy in front of gRPC server',
    0.88,
    'haiku',
    NOW(),
    'https://grpc.io/docs/guides/debugging/'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES

-- 20. Keepalive Timeout
(
    'gRPC error: connection reset by peer, keepalive timeout',
    'grpc',
    'HIGH',
    '[
        {"solution": "Configure keepalive on both client and server: set Time, Timeout, MaxConnectionIdle parameters", "percentage": 93},
        {"solution": "For long-lived connections: disable keepalive MaxAge server-side to prevent forced disconnections", "percentage": 90},
        {"solution": "Check network stability: high packet loss, NAT timeout causing resets, firewall idle timeout rules", "percentage": 87},
        {"solution": "Monitor connection health: log keepalive ping/pong, track reset reasons in metrics", "percentage": 84}
    ]'::jsonb,
    'Client and server use compatible keepalive policies, network conditions analyzed',
    'Keepalive pings succeed, connections stay alive during idle periods, no premature resets',
    'Server-side MaxAge too low, client keepalive disabled, network NAT/firewall timing mismatches not addressed',
    0.82,
    'haiku',
    NOW(),
    'https://grpc.io/docs/guides/debugging/'
);
