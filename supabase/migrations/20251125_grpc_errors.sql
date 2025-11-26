INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'rpc error: code = Unavailable desc = transport is closing',
    'grpc',
    'HIGH',
    '[
        {"solution": "Configure server-side keepalive parameters with MaxConnectionIdle to prevent abrupt TCP closures in containerized/load-balanced environments", "percentage": 95},
        {"solution": "Create connection once during initialization and reuse underlying connection for multiple requests", "percentage": 85},
        {"solution": "Check connection state and redial when necessary, though less reliable than keepalive configuration", "percentage": 70}
    ]'::jsonb,
    'gRPC server running, understanding of keepalive parameters, knowledge of containerized environments',
    'Error no longer occurs when idle connections are gracefully managed, connection persists across multiple requests, load balancer does not terminate idle connections',
    'Not configuring keepalive on server-side, assuming connections are always stable without explicit configuration, relying on client-side retries alone',
    0.95,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/52993259/problem-with-grpc-setup-getting-an-intermittent-rpc-unavailable-error'
),
(
    'gRPC Error (14, Error connecting: SocketException: OS Error: No route to host, errno = 111)',
    'grpc',
    'HIGH',
    '[
        {"solution": "Use actual server IP address instead of localhost/127.0.0.1 on real devices and ensure both devices are on same network", "percentage": 92},
        {"solution": "Add required Android internet permissions (INTERNET and ACCESS_NETWORK_STATE) to AndroidManifest.xml", "percentage": 88},
        {"solution": "Configure server to listen on 0.0.0.0 instead of localhost to allow remote device connections", "percentage": 90},
        {"solution": "Disable system firewall or configure firewall rules to allow traffic on gRPC port", "percentage": 75}
    ]'::jsonb,
    'Flutter/Dart gRPC client, Android manifest access, server bind configuration knowledge, firewall access',
    'Real device can reach server, gRPC connection established from external network, no socket exceptions in logs, app communicates successfully with server',
    'Using localhost on real devices, forgetting network permissions in manifest, server binding to localhost only, firewall blocking port without awareness',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/51706409/flutter-grpc-error-os-error-connection-refused'
),
(
    '[core]grpc: addrConn.createTransport failed to connect to {127.0.0.1:20201}: connection refused',
    'grpc',
    'MEDIUM',
    '[
        {"solution": "Ensure gRPC server is listening before registering gRPC-gateway handler - fix race condition in startup sequence", "percentage": 94},
        {"solution": "Call socket Listen() synchronously before gateway handler registration, even if Serve() runs asynchronously", "percentage": 92},
        {"solution": "Restructure startup code so gRPC server begins accepting connections before gateway RegisterXXXHandlerFromEndpoint() is called", "percentage": 91}
    ]'::jsonb,
    'gRPC-gateway implementation, understanding of goroutines and async execution, knowledge of socket listening phases',
    'Gateway handler registers successfully without connection refused error, gRPC server and gateway both operational, requests route correctly through gateway to backend',
    'Calling RegisterXXXHandlerFromEndpoint() before server is listening, running server listening in separate goroutine without synchronization, assuming connection buffering will handle timing',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/68339421/connection-refused-error-while-registering-grpc-gateway-handler-running-on-local'
),
(
    'Error: 14 UNAVAILABLE: No connection established when connecting to gRPC Service',
    'grpc',
    'HIGH',
    '[
        {"solution": "Use port 443 instead of 50051 for Cloud Run gRPC services which operate on HTTPS", "percentage": 96},
        {"solution": "Use secure credentials (createSecure()) instead of insecure credentials for Cloud Run connections", "percentage": 95},
        {"solution": "Remove dns: prefix from connection string when connecting to Cloud Run endpoints", "percentage": 88},
        {"solution": "Test connectivity with gRPCurl to verify endpoint configuration before adjusting client code", "percentage": 85}
    ]'::jsonb,
    'Node.js gRPC client, Google Cloud Run service deployment, understanding of HTTPS vs HTTP/2, gRPCurl installation',
    'Client successfully connects to Cloud Run service, no UNAVAILABLE errors in logs, gRPCurl list command succeeds, client receives server responses',
    'Using insecure credentials with Cloud Run, attempting to connect on wrong port (50051 instead of 443), keeping dns: prefix unnecessarily, not testing with gRPCurl first',
    0.96,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/74369119/error-14-unavailable-no-connection-established-when-connecting-to-grpc-service'
),
(
    'HTTP/2 connection error (PROTOCOL_ERROR): Invalid HTTP/2 connection preface',
    'grpc',
    'MEDIUM',
    '[
        {"solution": "Use correct Channel initialization with ChannelCredentials.Insecure, avoiding HttpClient with BaseAddress pointing to gRPC server", "percentage": 93},
        {"solution": "Verify launchSettings.json contains correct port and protocol matching client connection string", "percentage": 89},
        {"solution": "Ensure client and server reference same port for communication (typically 50051)", "percentage": 91},
        {"solution": "Confirm server is using HTTP/2 protocol, not HTTP/1.1, as gRPC requires HTTP/2", "percentage": 94}
    ]'::jsonb,
    'C# gRPC client/server setup, ASP.NET Core knowledge, understanding of HTTP/2 vs HTTP/1.1, launchSettings.json access',
    'HTTP/2 connection established successfully, no PROTOCOL_ERROR in server logs, client receives valid responses, Kestrel server runs without connection errors',
    'Using HttpClient with BaseAddress for gRPC connections, mismatched ports between client and server, HTTP/1.1 protocol instead of HTTP/2, incorrect channel credentials configuration',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/56628512/grpc-client-server-connection-failed-the-server-returned-an-invalid-or-unreco'
);
,
(
    'RESOURCE_EXHAUSTED: gRPC message exceeds maximum size 4194304',
    'grpc',
    'HIGH',
    '[
        {"solution": "Configure maxInboundMessageSize on client ManagedChannelBuilder to accept larger messages", "percentage": 96},
        {"solution": "Configure maxInboundMessageSize on server to accept incoming messages larger than 4MB default", "percentage": 95},
        {"solution": "For Python clients, use grpc.max_receive_message_length option when creating channel", "percentage": 94},
        {"solution": "For Scala/Akka, use withChannelBuilderOverrides with maxInboundMessageSize setting", "percentage": 92}
    ]'::jsonb,
    'gRPC client/server setup, knowledge of language-specific channel configuration, understanding of message size limits',
    'Messages larger than 4MB transmit successfully, no RESOURCE_EXHAUSTED errors in logs, client and server communicate large payloads',
    'Using default 4MB limit without checking payload size, not configuring both client and server settings, casting values as floats instead of ints in Python',
    0.95,
    'haiku',
    NOW(),
    'https://github.com/grpc/grpc-java/issues/10851'
),
(
    'RESOURCE_EXHAUSTED: Compressed gRPC message exceeds maximum size 4194304: 4196022 bytes',
    'grpc',
    'HIGH',
    '[
        {"solution": "Increase maxInboundMessageSize in channel builder - default is ~4MB, increase to 32MB or more", "percentage": 96},
        {"solution": "For Scala: use GrpcClientSettings.withChannelBuilderOverrides with maxInboundMessageSize", "percentage": 94},
        {"solution": "For Python: set both grpc.max_send_message_length and grpc.max_receive_message_length options", "percentage": 93},
        {"solution": "Test with gRPCurl to verify message size before adjusting client configuration", "percentage": 90}
    ]'::jsonb,
    'Scala/Akka gRPC or Python gRPC client, large message handling requirements, channel configuration knowledge',
    'Large compressed responses received successfully, no RESOURCE_EXHAUSTED errors, payload delivery completes without truncation',
    'Only configuring one direction (send vs receive), not accounting for compression ratio, using float instead of int for message size',
    0.94,
    'haiku',
    NOW(),
    'https://discuss.akka.io/t/changing-maximum-response-size-getting-error-resource-exhausted-compressed-grpc-message-exceeds-maximum-size-4194304/5337'
),
(
    'RESOURCE_EXHAUSTED: Unable to submit request because the service is temporarily out of capacity',
    'grpc',
    'MEDIUM',
    '[
        {"solution": "Implement exponential backoff retry logic with jitter for transient capacity errors", "percentage": 92},
        {"solution": "Add circuit breaker pattern to fail fast when service is consistently out of capacity", "percentage": 88},
        {"solution": "Monitor service metrics and reduce request rate when capacity warnings appear", "percentage": 85},
        {"solution": "Use gRPC server max concurrent streams setting to manage request queue properly", "percentage": 83}
    ]'::jsonb,
    'gRPC client implementation, understanding of retry strategies, service monitoring setup, Google Cloud services knowledge',
    'Client retries successfully after service recovers, requests complete during low-capacity periods, metrics show reduced error rate over time',
    'Immediate retry without backoff causing thundering herd, not implementing circuit breaker for cascading failures, ignoring capacity metrics',
    0.88,
    'haiku',
    NOW(),
    'https://github.com/googleapis/google-cloud-java/issues/11195'
),
(
    'RESOURCE_EXHAUSTED: Received message larger than max (1013478509 vs 4194304)',
    'grpc',
    'HIGH',
    '[
        {"solution": "For Cloud Run internal services, configure max inbound message size in service configuration", "percentage": 94},
        {"solution": "Ensure both Cloud Run and client are configured with matching message size limits", "percentage": 92},
        {"solution": "When using internal ingress on Cloud Run, apply same message size settings as external endpoints", "percentage": 91},
        {"solution": "Test message size configuration with gRPC services before enabling ingress control restrictions", "percentage": 88}
    ]'::jsonb,
    'Google Cloud Run deployment, gRPC configuration, internal service networking, message size management',
    'Internal Cloud Run service accepts large messages, no RESOURCE_EXHAUSTED errors when ingress is restricted, client receives complete responses',
    'Assuming internal ingress does not require message size config, testing only with external ingress enabled, not verifying configuration on Cloud Run service itself',
    0.91,
    'haiku',
    NOW(),
    'https://discuss.google.dev/t/cloud-run-internal-grpc-service-returns-resource-exhausted/158574'
),
(
    'RESOURCE_EXHAUSTED: 429 error after 2000-3000 mutate operations',
    'grpc',
    'MEDIUM',
    '[
        {"solution": "Implement rate limiting on client side to space out requests below service quota", "percentage": 91},
        {"solution": "Add exponential backoff with jitter between batch operations to avoid hitting rate limits", "percentage": 89},
        {"solution": "Batch operations more efficiently to reduce total number of RPC calls", "percentage": 87},
        {"solution": "Monitor service quota usage and implement throttling when approaching limits", "percentage": 85}
    ]'::jsonb,
    'Google Ads API or similar quota-based gRPC service, rate limiting understanding, batch operation design',
    'Batch operations complete without 429 errors, request rate stays below service quota, total mutations complete successfully',
    'Sending all mutations simultaneously without throttling, not batching efficiently to reduce RPC count, ignoring service quota warnings',
    0.88,
    'haiku',
    NOW(),
    'https://github.com/googleads/google-ads-python/issues/327'
),
(
    'context.Cancelled: request cancelled without error context',
    'grpc',
    'MEDIUM',
    '[
        {"solution": "Differentiate between context.Cancelled and context.DeadlineExceeded - cancelled means client stopped waiting, deadline means timeout", "percentage": 94},
        {"solution": "In Go gRPC handlers, check ctx.Err() to determine if context is cancelled or deadline exceeded", "percentage": 92},
        {"solution": "Implement proper cleanup in goroutines when context.Done() channel is triggered", "percentage": 90},
        {"solution": "Log context cancellation reasons separately from deadline exceeded for better debugging", "percentage": 87}
    ]'::jsonb,
    'Go gRPC server/client development, context handling understanding, goroutine management',
    'Context cancellation properly distinguished from timeouts, server cleanup completes on cancellation, logs differentiate between cancellation types',
    'Assuming all context errors are timeouts, not checking ctx.Err() to distinguish cancellation, improper goroutine cleanup on context cancellation',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/62381063/handling-context-cancelled-errors'
),
(
    'INTERNAL: transport: the stream is done or WriteHeader was already called',
    'grpc',
    'MEDIUM',
    '[
        {"solution": "Handle race condition where server writes headers after client cancels request due to deadline", "percentage": 93},
        {"solution": "Implement proper error handling that distinguishes client cancellation from actual server errors", "percentage": 91},
        {"solution": "Suppress internal error logging for streams where client has already cancelled", "percentage": 89},
        {"solution": "Use grpc-go 1.46+ which handles this scenario gracefully without reporting false INTERNAL errors", "percentage": 95}
    ]'::jsonb,
    'Go gRPC server implementation, HTTP/2 transport understanding, gRPC version management',
    'Server no longer reports false INTERNAL errors for client-cancelled requests, monitoring alerts accurate, metrics show correct error distribution',
    'Updating gRPC version without proper testing, treating all INTERNAL errors as genuine failures, not monitoring for false positive errors',
    0.93,
    'haiku',
    NOW(),
    'https://github.com/grpc/grpc-go/issues/4696'
),
(
    'INVALID_ARGUMENT: RESOURCE_EXHAUSTED: Connection closed after GOAWAY',
    'grpc',
    'MEDIUM',
    '[
        {"solution": "Implement client-side connection pooling to reuse established connections across requests", "percentage": 92},
        {"solution": "Configure proper idle timeout and keepalive settings to maintain long-lived connections", "percentage": 90},
        {"solution": "Handle GOAWAY frames gracefully by detecting and re-establishing connections", "percentage": 88},
        {"solution": "Verify that the client receiving INVALID_ARGUMENT is not the same client that sent GOAWAY", "percentage": 85}
    ]'::jsonb,
    'gRPC client implementation, connection pooling, HTTP/2 connection lifecycle understanding',
    'Client properly maintains connections across requests, GOAWAY frames handled gracefully, no connection reset errors',
    'Creating new connection for each request instead of pooling, ignoring keepalive settings, not tracking GOAWAY frame origins',
    0.89,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/75606357/invalid-argument-resource-exhausted-connection-closed-after-goaway'
),
(
    'NOT_FOUND: method not found in service',
    'grpc',
    'MEDIUM',
    '[
        {"solution": "Verify proto file is correctly compiled and generated code matches service definition", "percentage": 94},
        {"solution": "Ensure client proto definitions exactly match server proto version", "percentage": 93},
        {"solution": "Check that service and method names are correctly specified in both client and server config", "percentage": 91},
        {"solution": "Rebuild and restart both client and server after proto file changes", "percentage": 89}
    ]'::jsonb,
    'Protocol Buffers compilation, gRPC service definition, proto versioning, code generation',
    'Client successfully calls server methods, no NOT_FOUND errors, proto definitions synchronized across services',
    'Using outdated generated code after proto changes, mismatched service names between client/server, not rebuilding after proto updates',
    0.92,
    'haiku',
    NOW(),
    'https://grpc.io/docs/guides/status-codes/'
),
(
    'ALREADY_EXISTS: resource already exists error',
    'grpc',
    'LOW',
    '[
        {"solution": "Implement idempotent request handling using unique request IDs", "percentage": 93},
        {"solution": "Check if resource exists before creation attempt and return appropriate error", "percentage": 91},
        {"solution": "Use conditional operations if proto supports them (e.g., create_if_missing patterns)", "percentage": 88},
        {"solution": "Return ALREADY_EXISTS status code explicitly when resource already exists", "percentage": 90}
    ]'::jsonb,
    'gRPC service design, idempotency patterns, resource creation semantics, proto design',
    'Duplicate creation requests handled gracefully, idempotent operations work correctly, proper status codes returned for existing resources',
    'Not checking existence before creation, not implementing idempotent request handling, treating ALREADY_EXISTS as error instead of normal case',
    0.90,
    'haiku',
    NOW(),
    'https://grpc.io/docs/guides/status-codes/'
),
(
    'FAILED_PRECONDITION: operation not allowed in current state',
    'grpc',
    'MEDIUM',
    '[
        {"solution": "Validate resource state before allowing operation and return FAILED_PRECONDITION if conditions not met", "percentage": 94},
        {"solution": "Implement state machine validation on server side to enforce valid state transitions", "percentage": 92},
        {"solution": "Include current state information in error message to help clients understand why operation failed", "percentage": 89},
        {"solution": "Document valid state transitions and preconditions in service documentation", "percentage": 87}
    ]'::jsonb,
    'gRPC service design, state machine implementation, operation validation, service documentation',
    'Operations fail gracefully with clear precondition errors, state transitions properly validated, clients understand why operations fail',
    'Not validating state before operations, insufficient error detail about failed preconditions, not documenting valid state transitions',
    0.91,
    'haiku',
    NOW(),
    'https://developers.google.com/actions-center/reference/grpc-api/status_codes'
),
(
    'OUT_OF_RANGE: value is outside acceptable range',
    'grpc',
    'LOW',
    '[
        {"solution": "Implement input validation that checks values against defined ranges", "percentage": 95},
        {"solution": "Return OUT_OF_RANGE status code for numeric values outside acceptable bounds", "percentage": 93},
        {"solution": "Include min/max bounds in error message to guide client corrections", "percentage": 90},
        {"solution": "Define and document acceptable ranges in proto service definitions", "percentage": 88}
    ]'::jsonb,
    'gRPC service design, input validation, range checking, proto documentation',
    'Invalid input values caught with clear OUT_OF_RANGE errors, clients understand acceptable ranges, validation consistent across service',
    'Not validating numeric ranges, vague error messages without bounds information, inconsistent range checking across operations',
    0.92,
    'haiku',
    NOW(),
    'https://developers.google.com/actions-center/reference/grpc-api/status_codes'
),
(
    'DEADLINE_EXCEEDED: request took longer than allowed timeout',
    'grpc',
    'HIGH',
    '[
        {"solution": "Implement timeout context on client side with appropriate deadline values", "percentage": 95},
        {"solution": "On server side, check context deadline and abort long-running operations early", "percentage": 93},
        {"solution": "Optimize slow database queries or external API calls that exceed deadlines", "percentage": 91},
        {"solution": "Implement request cancellation propagation through all async operations in call chain", "percentage": 89}
    ]'::jsonb,
    'gRPC client/server development, context deadline management, performance optimization, async operation handling',
    'Requests complete within deadline, operations cancelled properly on timeout, no hanging requests consuming resources',
    'Setting unrealistic deadlines without optimizing operations, not propagating cancellation through async chain, not monitoring slow queries',
    0.93,
    'haiku',
    NOW(),
    'https://grpc.io/docs/guides/deadlines/'
),
(
    'INVALID_ARGUMENT: invalid proto message format',
    'grpc',
    'MEDIUM',
    '[
        {"solution": "Validate proto message structure on server before processing", "percentage": 94},
        {"solution": "Check required fields are present and non-null before using them", "percentage": 92},
        {"solution": "Validate enum values are valid members of the defined enum type", "percentage": 91},
        {"solution": "Return INVALID_ARGUMENT with detailed field-level validation errors", "percentage": 90}
    ]'::jsonb,
    'Protocol Buffers message format, proto validation, enum handling, error detail specification',
    'Invalid messages rejected with clear field-level errors, valid messages accepted without validation errors, client can correct and retry',
    'Not validating required fields, accepting invalid enum values, vague error messages without specifying which field is invalid',
    0.92,
    'haiku',
    NOW(),
    'https://grpc.io/docs/guides/status-codes/'
),
(
    'UNAUTHENTICATED: missing or invalid authentication credentials',
    'grpc',
    'HIGH',
    '[
        {"solution": "Implement gRPC interceptor/middleware to validate authentication before processing requests", "percentage": 96},
        {"solution": "Use TLS client certificates or OAuth tokens depending on authentication scheme", "percentage": 94},
        {"solution": "Configure metadata headers properly with authentication tokens on client side", "percentage": 93},
        {"solution": "Return UNAUTHENTICATED with clear message when credentials are missing or invalid", "percentage": 91}
    ]'::jsonb,
    'gRPC authentication, interceptor implementation, TLS configuration, metadata handling, OAuth/JWT knowledge',
    'Authenticated requests succeed, unauthenticated requests rejected with UNAUTHENTICATED status, credentials properly validated',
    'Not implementing authentication interceptor, sending credentials in wrong metadata format, not validating token expiration',
    0.94,
    'haiku',
    NOW(),
    'https://grpc.io/docs/guides/auth/'
),
(
    'PERMISSION_DENIED: authenticated but lacking required permissions',
    'grpc',
    'HIGH',
    '[
        {"solution": "Implement authorization checks after authentication to verify user has required permissions", "percentage": 95},
        {"solution": "Use role-based access control (RBAC) to manage permission granularity", "percentage": 93},
        {"solution": "Return PERMISSION_DENIED with clear explanation of which permission is required", "percentage": 92},
        {"solution": "Log permission denials for security auditing and monitoring", "percentage": 90}
    ]'::jsonb,
    'gRPC authorization, RBAC implementation, interceptor/middleware design, security auditing',
    'Authorized users can access resources, unauthorized users rejected with PERMISSION_DENIED, audit logs record all permission checks',
    'Not distinguishing PERMISSION_DENIED from UNAUTHENTICATED, insufficient permission granularity, not logging authorization failures',
    0.93,
    'haiku',
    NOW(),
    'https://grpc.io/docs/guides/auth/'
),
(
    'DATA_LOSS: unrecoverable data loss or corruption detected',
    'grpc',
    'CRITICAL',
    '[
        {"solution": "Implement data integrity checks (checksums, hashes) on critical operations", "percentage": 96},
        {"solution": "Use transactions with rollback capability for multi-step data modifications", "percentage": 95},
        {"solution": "Implement backup and recovery mechanisms to restore from data loss", "percentage": 93},
        {"solution": "Return DATA_LOSS only when data integrity cannot be recovered", "percentage": 92}
    ]'::jsonb,
    'Database design, transaction management, data integrity validation, backup/recovery systems, checksumming',
    'Data integrity maintained across all operations, transactions rollback on corruption detection, backups available for recovery',
    'Not validating data integrity, performing multi-step modifications without transactions, no backup mechanisms, returning DATA_LOSS unnecessarily',
    0.95,
    'haiku',
    NOW(),
    'https://grpc.io/docs/guides/status-codes/'
),
(
    'UNKNOWN: internal error with unspecified cause',
    'grpc',
    'MEDIUM',
    '[
        {"solution": "Log full exception stack trace when returning UNKNOWN to aid debugging", "percentage": 96},
        {"solution": "Wrap unexpected exceptions in gRPC status with context information", "percentage": 94},
        {"solution": "Implement structured logging with request IDs to correlate UNKNOWN errors with logs", "percentage": 92},
        {"solution": "Return more specific error codes if root cause can be determined", "percentage": 93}
    ]'::jsonb,
    'Go/Java/C# gRPC error handling, exception handling, structured logging, debugging practices',
    'UNKNOWN errors have corresponding log entries with stack traces, request IDs correlate client/server logs, errors eventually traced to root cause',
    'Returning UNKNOWN without logging, not including request IDs for correlation, returning UNKNOWN when more specific code applies',
    0.93,
    'haiku',
    NOW(),
    'https://grpc.io/docs/guides/status-codes/'
),
(
    'Panic in gRPC server handler causing request failure',
    'grpc',
    'HIGH',
    '[
        {"solution": "Implement recovery interceptor to catch panics and convert them to gRPC errors", "percentage": 97},
        {"solution": "Use defer-recover in handler functions to gracefully handle unexpected panics", "percentage": 95},
        {"solution": "Log panic stack trace with request context for debugging", "percentage": 94},
        {"solution": "Return INTERNAL status code when panic is caught to avoid serving corrupted state", "percentage": 92}
    ]'::jsonb,
    'Go gRPC server development, interceptor implementation, panic recovery, logging practices',
    'Server continues running after panic, client receives INTERNAL error instead of connection reset, panic stack trace logged with context',
    'Not implementing panic recovery in handlers, losing panic stack trace information, not logging panic with request context',
    0.95,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/38197485/golang-grpc-how-to-recover-the-grpc-server-from-panic'
);
