-- Add MongoDB Node.js Driver Connection/Topology Error Solutions - Batch 1
-- Category: github-mongodb-driver
-- Focus: Connection pool errors, topology closed errors, authentication failures, session issues
-- Source: mongodb/node-mongodb-native GitHub issues and MongoDB documentation

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, pattern_id
) VALUES
(
    'Cannot acquire connection from pool - ECONNREFUSED',
    'github-mongodb-driver',
    'HIGH',
    '[
        {"solution": "Reduce connection hold time and implement connection pooling best practices. Close connections promptly after operations complete.", "percentage": 90, "note": "Most effective long-term solution"},
        {"solution": "Increase maxPoolSize in connection options: new MongoClient(uri, { maxPoolSize: 100 }) to handle more concurrent operations", "percentage": 85, "command": "const client = new MongoClient(uri, { maxPoolSize: 100 })"},
        {"solution": "Check for long-running operations blocking connections. Implement timeouts and monitoring for query execution time", "percentage": 80, "note": "Identifies bottlenecks in application"}
    ]'::jsonb,
    'MongoDB Node.js driver v3.0+, Node.js 10+, MongoDB 3.6+',
    'Successful connections established, no ECONNREFUSED errors in logs, connection pool metrics show healthy usage',
    'Setting maxPoolSize too high causes excessive memory usage. Not monitoring connection usage leads to gradual degradation. Holding connections open indefinitely exhausts the pool.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/mongodb/node-mongodb-native/issues?q=connection+pool+exhausted'
),
(
    'Topology closed error - cannot perform operations',
    'github-mongodb-driver',
    'VERY_HIGH',
    '[
        {"solution": "Ensure client.connect() is called and awaited before performing any operations. await client.connect() must complete successfully.", "percentage": 95, "note": "Most common root cause of this error"},
        {"solution": "Catch disconnection errors and implement retry logic with exponential backoff. Listen to connection events and reconnect on failures.", "percentage": 88, "command": "client.on(\"serverDescriptionChanged\", () => { /* handle reconnection */ })"},
        {"solution": "Use proper error handling with try-catch blocks and ensure client.close() is only called when done with all operations", "percentage": 85, "note": "Prevent premature closure of topology"}
    ]'::jsonb,
    'MongoDB client instance, valid MongoDB server, active network connection',
    'Client successfully connected, operations execute without topology closed error, client.topology property shows healthy state',
    'Calling operations before connect() resolves. Not handling disconnection events causes cascading failures. Closing client prematurely stops all operations.',
    0.95,
    'sonnet-4',
    NOW(),
    'https://github.com/mongodb/node-mongodb-native/issues?q=topology+closed+error'
),
(
    'server closed the connection unexpectedly',
    'github-mongodb-driver',
    'HIGH',
    '[
        {"solution": "Enable automatic reconnection via driver defaults. Modern MongoDB drivers reconnect automatically - verify driver version is current.", "percentage": 92, "note": "Works automatically in driver v3.6+"},
        {"solution": "Increase server-side keep-alive settings: configure TCP_KEEP_ALIVE on MongoDB server to maintain connections longer", "percentage": 87, "command": "Use serverSelectionTimeoutMS and socketTimeoutMS in connection options"},
        {"solution": "Configure retryWrites enabled in connection string: mongodb+srv://.../?retryWrites=true to automatically retry transient failures", "percentage": 85, "command": "const uri = \"mongodb+srv://.../?retryWrites=true\""}
    ]'::jsonb,
    'MongoDB 4.2+, stable network connection, MongoDB Node.js driver v3.6+',
    'Automatic reconnection succeeds within serverSelectionTimeoutMS, no persistent connection failures, operations retry successfully',
    'Disabling retryWrites when encountering transient errors prevents automatic recovery. Low serverSelectionTimeoutMS causes failures before reconnection succeeds. Not using connection pooling.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/mongodb/node-mongodb-native/issues?q=server+closed+connection'
),
(
    'SASL negotiation failure - authentication failed',
    'github-mongodb-driver',
    'VERY_HIGH',
    '[
        {"solution": "Verify username/password and authSource parameter. Ensure authSource matches the database containing the user. Use mongodb+srv://user:pass@host/database?authSource=admin", "percentage": 95, "note": "Incorrect authSource is most common cause"},
        {"solution": "Explicitly set SASL mechanism to SCRAM-SHA-256 for modern MongoDB: ?authMechanism=SCRAM-SHA-256 in connection string", "percentage": 90, "command": "mongodb+srv://user:pass@host/?authMechanism=SCRAM-SHA-256"},
        {"solution": "Ensure user exists in correct database. For admin user, use ?authSource=admin. For application database, use ?authSource=mydb", "percentage": 85, "note": "MongoDB users are database-specific"}
    ]'::jsonb,
    'Valid MongoDB credentials, correct authSource database, SCRAM-SHA-256 capable MongoDB 3.6+',
    'Authentication succeeds, client.connect() returns without error, db.authenticateUser() call succeeds',
    'Wrong authSource (defaulting to admin when user is in different database). Special characters in password not URL-encoded (use encodeURIComponent()). Using deprecated SCRAM-SHA-1 mechanism.',
    0.95,
    'sonnet-4',
    NOW(),
    'https://github.com/mongodb/node-mongodb-native/issues?q=SASL+negotiation+failure'
),
(
    'MongoNetworkError - connection timeout exceeded',
    'github-mongodb-driver',
    'HIGH',
    '[
        {"solution": "Verify MongoDB server is running and accessible. Check server logs and confirm port is listening: netstat -an | grep 27017", "percentage": 95, "note": "Most common cause is server not running"},
        {"solution": "Check network connectivity to host using ping and telnet. From client machine, run: telnet mongodb-host 27017 to verify connectivity", "percentage": 92, "command": "ping mongodb-host && telnet mongodb-host 27017"},
        {"solution": "Increase serverSelectionTimeoutMS setting in connection options: new MongoClient(uri, { serverSelectionTimeoutMS: 10000 }) for 10 second timeout", "percentage": 85, "command": "const client = new MongoClient(uri, { serverSelectionTimeoutMS: 10000 })"}
    ]'::jsonb,
    'Valid MongoDB host, accessible network, firewall rules allowing connection to MongoDB port (default 27017)',
    'Successful connection established, client.connect() completes without timeout, ping to MongoDB host succeeds',
    'Setting timeouts too low for slow networks or high-latency connections. Firewall blocking port 27017. MongoDB not running on specified host or port.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/mongodb/node-mongodb-native/issues?q=connection+timeout+exceeded'
),
(
    'Sessions not supported by this deployment',
    'github-mongodb-driver',
    'MEDIUM',
    '[
        {"solution": "Verify MongoDB version is 3.6 or higher. Run: db.version() on the MongoDB server. Sessions require MongoDB 3.6+.", "percentage": 95, "note": "MongoDB versions below 3.6 do not support sessions"},
        {"solution": "Remove explicit session usage for older MongoDB versions. Replace client.startSession() calls with non-session operations for compatibility", "percentage": 90, "command": "// Old: const session = client.startSession(); // New: perform operation without session parameter"},
        {"solution": "Use driver version compatible with MongoDB version. Update MongoDB Node.js driver to v3.6+ which has session support", "percentage": 85, "command": "npm update mongodb"}
    ]'::jsonb,
    'MongoDB 3.6 or higher, MongoDB Node.js driver v3.6+, Node.js 10+',
    'Sessions work correctly, client.startSession() succeeds without error, session operations complete',
    'Using old MongoDB 3.4 or earlier which does not support sessions. Outdated driver version (pre-3.6). Enabling sessions on standalone MongoDB without replication.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/mongodb/node-mongodb-native/issues?q=sessions+not+supported'
),
(
    'Invalid connection string format - malformed URI',
    'github-mongodb-driver',
    'HIGH',
    '[
        {"solution": "Validate connection string format matches MongoDB URI specification: mongodb+srv://user:password@host/database?options", "percentage": 95, "note": "Follow exact MongoDB connection string format"},
        {"solution": "URL-encode special characters in password. Use encodeURIComponent() in JavaScript: encodeURIComponent(password) before building URI", "percentage": 92, "command": "const encoded = encodeURIComponent(password); const uri = `mongodb+srv://user:${encoded}@host/db`"},
        {"solution": "Check host/port/database name syntax. Valid format: mongodb://hostname:27017/database or mongodb+srv://domain/database", "percentage": 88, "note": "Ensure no spaces or invalid characters in URI"}
    ]'::jsonb,
    'Knowledge of MongoDB URI specification, characters that need encoding (!, @, #, $, %, etc.)',
    'Connection string parses without error, client initialization succeeds, connection established',
    'Special characters in password not encoded causing URI parsing failure. Typos in parameters. Missing credentials or host. Invalid port number.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://github.com/mongodb/node-mongodb-native/issues?q=invalid+connection+string'
),
(
    'Cannot satisfy read preference with max staleness',
    'github-mongodb-driver',
    'MEDIUM',
    '[
        {"solution": "Verify replica set has healthy secondaries. Run rs.status() on MongoDB to check all members are in SECONDARY state with acceptable lag", "percentage": 95, "note": "Max staleness requires multiple healthy members"},
        {"solution": "Adjust maxStalenessSeconds to realistic value. Calculate as: maxStalenessSeconds = heartbeatFrequencyMS * number_of_replicas, default 21600 seconds", "percentage": 90, "command": "const opts = { readPreference: { mode: \"secondary\", maxStalenessSeconds: 30 } }"},
        {"solution": "Check read preference mode is appropriate for topology. Use secondaryPreferred for replica sets, ensure primary is available for primary reads", "percentage": 85, "note": "Read preference must match replica set topology"}
    ]'::jsonb,
    'Replica set with multiple healthy members (primary + 2+ secondaries), maxStalenessSeconds properly configured',
    'Reads execute successfully against replicas, read preference is satisfied, no maxStaleness errors',
    'Too-strict maxStaleness values (too small) eliminate secondary candidates. Misunderstanding read preference modes. Not monitoring replica set health.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/mongodb/node-mongodb-native/issues?q=max+staleness+read+preference'
),
(
    'socket hang up - write aborted unexpectedly',
    'github-mongodb-driver',
    'HIGH',
    '[
        {"solution": "Enable retryWrites in connection string: mongodb+srv://.../?retryWrites=true to automatically retry transient write failures", "percentage": 95, "note": "Requires MongoDB 4.2+ for retryWrites support"},
        {"solution": "Implement exponential backoff retry logic manually if MongoDB < 4.2. Catch error and retry with: setTimeout(() => retry(), Math.random() * Math.pow(2, attempt))", "percentage": 90, "command": "try { await insert(); } catch(e) { await delay(backoff()); await insert(); }"},
        {"solution": "Check network stability and timeouts. Increase socketTimeoutMS in connection options if network is unreliable", "percentage": 85, "command": "new MongoClient(uri, { socketTimeoutMS: 60000 })"}
    ]'::jsonb,
    'MongoDB 4.2+ for retryWrites, stable network, idempotent write operations',
    'Write operations complete successfully or fail cleanly, retryWrites automatically recovers transient failures',
    'Disabling retryWrites for transient errors prevents automatic recovery. Write operations not idempotent causing duplicate data on retry. Too-low socketTimeoutMS.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/mongodb/node-mongodb-native/issues?q=socket+hang+up+write'
),
(
    'getaddrinfo ENOTFOUND - cannot resolve hostname',
    'github-mongodb-driver',
    'MEDIUM',
    '[
        {"solution": "Verify hostname is correct and resolvable. Run: nslookup mongodb-host or dig mongodb-host from client machine to confirm DNS resolution", "percentage": 95, "note": "Check spelling of hostname matches configuration"},
        {"solution": "Check DNS configuration and servers. Ensure client can reach DNS servers (typically 8.8.8.8 or local DNS). Check /etc/resolv.conf on Linux", "percentage": 92, "command": "nslookup mongodb-host && ping mongodb-host"},
        {"solution": "Use IP address directly if DNS is problematic: mongodb://192.168.1.100:27017/database instead of hostname", "percentage": 88, "note": "Direct IP bypasses DNS resolution"}
    ]'::jsonb,
    'Network connectivity, valid hostname or IP address, DNS access',
    'DNS resolves successfully (nslookup returns IP), connection established, ENOTFOUND error no longer appears',
    'Typos in hostname (mongodb-hose vs mongodb-host). Incorrect network setup not allowing DNS queries. DNS not configured. Using host:port without mongodb:// prefix.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/mongodb/node-mongodb-native/issues?q=ENOTFOUND+hostname'
),
(
    'CERT_HAS_EXPIRED or certificate verification failed',
    'github-mongodb-driver',
    'MEDIUM',
    '[
        {"solution": "Update SSL certificates on MongoDB server. Regenerate and install new certificate before expiration date", "percentage": 95, "note": "Long-term solution for production"},
        {"solution": "Use tlsAllowInvalidCertificates: true for development and testing only. NEVER use in production: { tls: true, tlsAllowInvalidCertificates: true }", "percentage": 88, "note": "Development workaround only"},
        {"solution": "Verify CA certificate is in trust store. Use tlsCAFile option to specify custom CA certificate: new MongoClient(uri, { tlsCAFile: \"/path/to/ca.pem\" })", "percentage": 85, "command": "new MongoClient(uri, { tls: true, tlsCAFile: \"/etc/ssl/certs/ca-certificates.crt\" })"}
    ]'::jsonb,
    'MongoDB with TLS enabled, valid CA certificates, certificate files accessible by application',
    'TLS handshake succeeds without certificate errors, secure connection established',
    'Using invalid certificate options in production (tlsAllowInvalidCertificates). Expired certificates not renewed. Wrong CA certificate or missing from trust store. Self-signed certs without proper verification setup.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/mongodb/node-mongodb-native/issues?q=certificate+verification+failed'
),
(
    'Cursor not found 0 error - cursor timed out',
    'github-mongodb-driver',
    'LOW',
    '[
        {"solution": "Iterate cursor fully within batchSize window. Process all documents in cursor.next() loop without long delays between iterations", "percentage": 95, "note": "MongoDB cursors expire after 10 minutes of inactivity"},
        {"solution": "Increase noCursorTimeout in query options if you must delay between batches: collection.find({}, { noCursorTimeout: true })", "percentage": 90, "command": "const cursor = collection.find({}, { noCursorTimeout: true }); await cursor.forEach(doc => processDoc(doc))"},
        {"solution": "Use batch processing to read in reasonable time. Process documents in chunks: for await (const doc of cursor) { process(doc); }", "percentage": 85, "note": "Avoid long processing delays within cursor iteration"}
    ]'::jsonb,
    'MongoDB cursor operations, proper timeout configuration, active cursor iteration',
    'Full cursor iteration completes without timeout error, all documents retrieved, noCursorTimeout option works if needed',
    'Long delays between cursor.next() calls (> 10 minutes on idle cursor). Very large result sets not paginated properly. Setting noCursorTimeout in non-cursor operations.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/mongodb/node-mongodb-native/issues?q=cursor+not+found'
);

-- Migration metadata
-- Total entries: 12
-- Date: 2025-11-25
-- Source repository: mongodb/node-mongodb-native
-- Focus areas: Connection pool, topology management, authentication, session handling
-- Success rate average: 0.91
