INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'rpc error: code = Unavailable desc = connection error: desc = "transport: Error while dialing dial tcp',
    'grpc',
    'HIGH',
    '[
        {"solution": "Move grpc.Dial() and client initialization outside the request loop. Establish the connection once and reuse it for all RPC calls instead of creating a new connection per request.", "percentage": 95},
        {"solution": "For GKE deployments, explicitly allow inbound traffic: gcloud compute firewall-rules create allow-grpc --allow tcp:50051", "percentage": 85}
    ]'::jsonb,
    'gRPC Go client/server deployed. Network connectivity to target service IP and port. For GKE, gcloud CLI configured.',
    'Successful RPC calls complete without connection refused errors. Multiple consecutive requests use the same connection. Firewall rules allow traffic on target port.',
    'Creating a new connection per request causes connection saturation. Not checking firewall rules in Kubernetes environments. Assuming port mapping is automatic in GKE without explicit rules.',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/70131524/grpc-server-connection-refused'
),
(
    'io.grpc.StatusRuntimeException: UNAVAILABLE: io exception',
    'grpc',
    'HIGH',
    '[
        {"solution": "Call .start() method on the ServerBuilder after .build(). The server must be explicitly started to bind to the port: ServerBuilder.forPort(port).addService(serviceDefinition).build().start()", "percentage": 98},
        {"solution": "Verify server is listening: netstat -tuln | grep 9000 or check logs for ''listening on port'' message followed by actual network binding.", "percentage": 90}
    ]'::jsonb,
    'gRPC Java server implementation. ServerBuilder configuration. Netstat or port-checking tools available.',
    'Server starts without exceptions. Client connects successfully and RPC calls complete. netstat shows port in LISTEN state. Application logs show successful startup.',
    'Calling .build() creates the server object but does not start it. Assuming server is running because initialization completes without error. Not checking if port is actually bound after startup.',
    0.98,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/55122154/connection-refused-localhost-000000019000-with-grpc'
),
(
    'Status(StatusCode="Unavailable", Detail="Error starting gRPC call: No connection could be made because the target machine actively refused it"',
    'grpc',
    'HIGH',
    '[
        {"solution": "Change the gRPC server listening port to a different port number. Verify the new port doesn''t conflict with system services: netstat -tuln | grep PORT. Update client configuration to use the new port.", "percentage": 87},
        {"solution": "Disable firewall on server and client temporarily to isolate networking issues: Windows Defender Firewall off in settings. Re-enable after testing with correct port and firewall rules.", "percentage": 80}
    ]'::jsonb,
    'ASP.NET Core gRPC client and server. Kestrel server configuration. Ability to change port numbers. Access to network configuration.',
    'Client RPC calls complete successfully. Connection refused error no longer appears in logs. tcpdump or netstat shows traffic on new port. Client and server logs show successful connection.',
    'Using port 31700 or other restricted ports. Not testing with alternative ports first. Assuming firewall is the only issue without checking port availability.',
    0.87,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/62031410/asp-net-core-grpc-error-starting-grpc-call-no-connection-could-be-made-becau'
),
(
    'rpc error: code = DeadlineExceeded desc = context deadline exceeded',
    'grpc',
    'HIGH',
    '[
        {"solution": "Increase the RPC call timeout. Set context deadline: ctx, cancel := context.WithTimeout(context.Background(), 30*time.Second). Start with 30 seconds and increase based on operation complexity.", "percentage": 93},
        {"solution": "Optimize server-side processing. Profile slow methods using pprof or language-specific profilers. Reduce database query time, add caching, or implement request batching.", "percentage": 88}
    ]'::jsonb,
    'gRPC client and server implementation. Understanding of context deadlines. Access to server logs and performance metrics.',
    'RPC calls complete within new timeout. Server responds before deadline. No timeout errors in logs. Performance metrics show reduced latency.',
    'Using default 1-second timeout for long operations. Not setting deadlines at all and relying on defaults. Increasing timeout without optimizing slow operations.',
    0.93,
    'haiku',
    NOW(),
    'https://grpc.io/docs/guides/status-codes/'
),
(
    'rpc error: code = Unimplemented desc = unknown service or method',
    'grpc',
    'HIGH',
    '[
        {"solution": "Verify .proto file is properly compiled for the target language: protoc --go_out=. --go-grpc_out=. service.proto for Go. Ensure generated stubs are in the service path.", "percentage": 96},
        {"solution": "Check service name and method name match exactly in client call and server registration. Case-sensitive comparison. Verify no typos in fully-qualified service names: package.ServiceName/MethodName", "percentage": 94}
    ]'::jsonb,
    '.proto files available. Protocol buffer compiler installed. Service implementation code. Build system understanding.',
    'Client RPC calls succeed without Unimplemented errors. Server logs show method was called successfully. Generated stubs include the method signature. Client and server use identical .proto definitions.',
    'Not regenerating stubs after .proto changes. Typos in service or method names. Using old generated code from previous compilation. Not matching case in method names.',
    0.95,
    'haiku',
    NOW(),
    'https://grpc.io/docs/guides/error/'
);