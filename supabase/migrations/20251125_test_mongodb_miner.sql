INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'MongoNetworkError: connect ECONNREFUSED 127.0.0.1:27017',
    'mongodb-connection',
    'HIGH',
    '[
        {"solution": "Start MongoDB service: mongod or brew services start mongodb-community", "percentage": 95},
        {"solution": "Check bindIp in mongod.cfg is set to 0.0.0.0 for remote connections or 127.0.0.1 for local", "percentage": 85},
        {"solution": "Verify MongoDB is listening on the correct port (default 27017) with netstat or lsof", "percentage": 80},
        {"solution": "Ensure connection string uses correct host:port (mongodb://127.0.0.1:27017)", "percentage": 85}
    ]'::jsonb,
    'MongoDB installed, Node.js MongoDB driver or mongoose, connection string configured',
    'MongoDB service starts without error, connection establishes successfully, mongosh connects to server',
    'Forgetting to start mongod service, wrong port number in connection string, bindIp mismatch between config and connection attempt, firewall blocking port 27017',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/20386464/econnrefused-error-when-connecting-to-mongodb-from-node-js'
),
(
    'MongoServerSelectionError: getaddrinfo ENOTFOUND hostname',
    'mongodb-connection',
    'HIGH',
    '[
        {"solution": "Verify hostname/IP address is correct in connection string", "percentage": 92},
        {"solution": "Check DNS resolution: nslookup or ping the hostname", "percentage": 88},
        {"solution": "In Docker/Compose, ensure service name matches and networks are configured correctly", "percentage": 85},
        {"solution": "For environment variables, verify they are properly loaded (not undefined)", "percentage": 80},
        {"solution": "Check firewall and network connectivity to the MongoDB host", "percentage": 75}
    ]'::jsonb,
    'MongoDB running and accessible, Node.js MongoDB driver, valid hostname or IP address',
    'DNS resolves correctly, ping to host succeeds, connection string prints correctly, MongoDB connection establishes',
    'Typos in hostname, undefined environment variables, misconfigured Docker network, firewall blocking outbound connections, wrong IP address format',
    0.89,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/39108992/mongoerror-getaddrinfo-enotfound-undefined-undefined27017'
),
(
    'AuthenticationFailed: SCRAM-SHA-1 authentication failed, storedKey mismatch',
    'mongodb-connection',
    'MEDIUM',
    '[
        {"solution": "Verify username and password are correct for the target database", "percentage": 90},
        {"solution": "Check --authenticationDatabase matches the database where user is stored (default: admin)", "percentage": 88},
        {"solution": "Ensure authSource in connection string matches user creation database", "percentage": 85},
        {"solution": "Reset user credentials: drop user and recreate with correct password and SCRAM mechanism", "percentage": 78},
        {"solution": "Verify MongoDB version supports SCRAM-SHA-1 or use SCRAM-SHA-256 if available", "percentage": 72}
    ]'::jsonb,
    'MongoDB with authentication enabled, valid MongoDB user created, correct password known, matching driver version',
    'Authentication succeeds, mongosh connects without auth error, credentials validated in database logs',
    'Wrong authenticationDatabase specified, password mismatch or special characters not escaped, user created in wrong database, SCRAM mechanism mismatch between client and server',
    0.86,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/37811036/mongodb-client-access-control-scram-sha-1-authentication-failed-storedkey-mismatch'
),
(
    'Error: unable to authenticate using mechanism "SCRAM-SHA-256" with Prisma MongoDB',
    'mongodb-connection',
    'MEDIUM',
    '[
        {"solution": "Ensure authSource parameter is included in connection string (e.g., authSource=admin)", "percentage": 91},
        {"solution": "Verify SCRAM-SHA-256 is supported by MongoDB version (3.0+)", "percentage": 87},
        {"solution": "Check username and password do not contain special characters or URL-encode them (%40 for @, etc)", "percentage": 84},
        {"solution": "In Docker, rebuild containers after credentials change: docker-compose down && docker-compose up", "percentage": 79},
        {"solution": "Clear Prisma cache: rm -rf .prisma and regenerate schema", "percentage": 75}
    ]'::jsonb,
    'Prisma ORM configured with MongoDB, MongoDB user with SCRAM-SHA-256 created, Node.js environment',
    'Prisma migrate runs without authentication error, npx prisma db push succeeds, prisma studio connects to database',
    'Missing authSource parameter, special characters in password not URL-encoded, stale Prisma schema, Docker image cache with old credentials, user not created with SCRAM-SHA-256',
    0.84,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/72708560/how-can-i-solve-a-scram-authentication-issue-in-mongodb-with-docker-and-prisma'
),
(
    'MongoDB connection refused on Docker: unable to connect to MongoDB server',
    'mongodb-connection',
    'MEDIUM',
    '[
        {"solution": "In docker-compose, ensure service name in connection string matches service name in compose file", "percentage": 93},
        {"solution": "Verify containers are on same network: add networks key to both services", "percentage": 89},
        {"solution": "Check MongoDB container is running: docker ps and docker logs mongo-service", "percentage": 87},
        {"solution": "Expose MongoDB port in compose or container: ports: [27017:27017]", "percentage": 82},
        {"solution": "Use host.docker.internal instead of localhost when connecting from app to host MongoDB", "percentage": 78}
    ]'::jsonb,
    'Docker and docker-compose installed, MongoDB container image available, application container running, network connectivity',
    'Application connects to MongoDB without timeout, docker-compose logs show no connection errors, MongoDB replica set initialized if required',
    'Mismatched service names in connection string, containers on different networks, MongoDB port not exposed, using localhost instead of service name, container not started',
    0.88,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/75368636/mongooseserverselectionerror-getaddrinfo-enotfound-mongo-75369739'
);
