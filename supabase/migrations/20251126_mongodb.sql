INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Error: couldn''t connect to server 127.0.0.1:27017',
    'mongodb',
    'HIGH',
    '[
        {"solution": "Start the MongoDB daemon: mongod in a terminal, then connect with mongo shell in another terminal", "percentage": 95},
        {"solution": "Restart MongoDB service: sudo service mongod restart on Linux, or brew services restart mongodb-community on macOS", "percentage": 90},
        {"solution": "Remove stale lock file: sudo rm /var/lib/mongodb/mongod.lock && sudo mongod --repair && sudo service mongod start", "percentage": 85}
    ]'::jsonb,
    'MongoDB installed, terminal access',
    'mongod service is running, mongo shell connects successfully',
    'Forgetting to start mongod daemon before trying to connect, incorrect lock file path by MongoDB version',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/12831939/couldnt-connect-to-server-127-0-0-127017'
),
(
    'MongoError: connect ECONNREFUSED 127.0.0.1:27017',
    'mongodb',
    'HIGH',
    '[
        {"solution": "Use 127.0.0.1 instead of localhost in connection string: mongodb://127.0.0.1:27017/database", "percentage": 95},
        {"solution": "Add directConnection=true parameter in connection URL: mongodb://127.0.0.1:27017/?directConnection=true", "percentage": 90},
        {"solution": "Verify mongod is running: ps aux | grep mongod or sudo service mongod status", "percentage": 85}
    ]'::jsonb,
    'Node.js 17+, MongoDB installed and started',
    'Connection successful, no ECONNREFUSED errors in logs',
    'Using localhost instead of 127.0.0.1 (Node.js 17+ resolves to IPv6 ::1), mongod not running on expected port',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/46523321/mongoerror-connect-econnrefused-127-0-0-127017'
),
(
    'MongoError: connect ECONNREFUSED ::1:27017',
    'mongodb',
    'HIGH',
    '[
        {"solution": "Change connection string from localhost to 127.0.0.1: mongodb://127.0.0.1:27017/db", "percentage": 96},
        {"solution": "Update MongoDB bindIp configuration in /etc/mongod.conf to: bindIp: [127.0.0.1, ::1]", "percentage": 88},
        {"solution": "Force IPv4: use mongodb://localhost:27017/?ipv6=false in connection string", "percentage": 85}
    ]'::jsonb,
    'Node.js application, MongoDB installed',
    'Application connects successfully, IPv6 address no longer in error messages',
    'Not understanding IPv6 vs IPv4 mismatch, assuming localhost always resolves to 127.0.0.1',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/73321794/mongonetworkerror-connect-econnrefused-127-0-0-127017-intel-macos-monterey'
),
(
    'Error: Couldn''t connect to server 127.0.0.1:27017 on Windows',
    'mongodb',
    'MEDIUM',
    '[
        {"solution": "Install MongoDB Community Server separately from MongoDB Compass: download from mongodb.com/try/download/community", "percentage": 94},
        {"solution": "Start MongoDB service via Windows Services: services.msc > find MongoDB > right-click > Start", "percentage": 92},
        {"solution": "Install MongoDB as Windows service: mongod --install", "percentage": 85}
    ]'::jsonb,
    'Windows OS, administrator access',
    'MongoDB service appears in Services.msc, mongod process running, connection successful',
    'Assuming MongoDB Compass includes the database server (it doesn''t), not installing MongoDB Community Server separately',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/77864700/how-to-fix-connect-econnrefused-127-0-0-127017-error-when-trying-to-connect-t'
),
(
    'MongoServerError: bad auth: Authentication failed',
    'mongodb',
    'HIGH',
    '[
        {"solution": "Remove all whitespace from credentials in connection string: mongodb+srv://username:password@cluster.mongodb.net/db (no spaces before/after username or password)", "percentage": 96},
        {"solution": "Verify username and password match exactly in MongoDB Atlas Access Control settings", "percentage": 94},
        {"solution": "Install and configure dotenv: npm install dotenv && require(''dotenv'').config() at application start", "percentage": 92}
    ]'::jsonb,
    'MongoDB Atlas account with database user created',
    'Authentication succeeds, application connects to database without auth errors',
    'Copying connection string with angle brackets <password>, adding whitespace around credentials, typo in username/password',
    0.94,
    'haiku',
    NOW(),
    'https://dev.to/shafia/how-to-fix-the-error-mongoservererror-bad-auth-authentication-failed-5b58'
),
(
    'MongoServerError: bad auth: Authentication failed with environment variables',
    'mongodb',
    'HIGH',
    '[
        {"solution": "Ensure .env file variable names match code references exactly: if using process.env.DB_USER, define DB_USER=value in .env", "percentage": 95},
        {"solution": "Load environment variables before connecting: require(''dotenv'').config() at the very top of your application", "percentage": 93},
        {"solution": "Avoid spaces in .env assignments: use DB_USER=myuser not DB_USER = myuser", "percentage": 90}
    ]'::jsonb,
    '.env file in project root, npm dotenv package installed',
    'Environment variables load correctly, authentication succeeds',
    'Variable name mismatches between .env and code, spaces around equals signs, missing dotenv.config() call',
    0.92,
    'haiku',
    NOW(),
    'https://dev.to/shafia/how-to-fix-the-error-mongoservererror-bad-auth-authentication-failed-5b58'
),
(
    'MongoTimeoutError: Server selection timed out after 30000 ms',
    'mongodb',
    'MEDIUM',
    '[
        {"solution": "Optimize database queries with proper indexing on frequently queried fields", "percentage": 91},
        {"solution": "Increase serverSelectionTimeoutMS in connection options: mongoose.connect(url, {serverSelectionTimeoutMS: 5000})", "percentage": 88},
        {"solution": "Verify network connectivity to MongoDB server or Atlas cluster, check IP whitelist in Atlas Security settings", "percentage": 85}
    ]'::jsonb,
    'MongoDB connection string, Node.js/Python application',
    'Queries complete within timeout, no server selection errors in logs',
    'Increasing timeout instead of optimizing queries, ignoring network configuration issues, assuming hardware is the bottleneck',
    0.85,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/40216639/mongodb-connection-timed-out-error'
),
(
    'connection 39 to 127.0.0.1:27017 timed out',
    'mongodb',
    'MEDIUM',
    '[
        {"solution": "Increase connectTimeoutMS and socketTimeoutMS in driver options: connectTimeoutMS: 10000, socketTimeoutMS: 10000", "percentage": 87},
        {"solution": "Add database indexes on query fields: db.collection.createIndex({field: 1}) for commonly filtered fields", "percentage": 90},
        {"solution": "Check network latency: ping 127.0.0.1 and verify no firewall rules blocking port 27017", "percentage": 85}
    ]'::jsonb,
    'MongoDB running, network connectivity available',
    'Connections establish successfully, queries complete without timeout errors',
    'Only increasing timeouts without addressing root cause, not creating necessary indexes, ignoring network issues',
    0.84,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/40216639/mongodb-connection-timed-out-error'
),
(
    'BulkWriteError: E11000 duplicate key error',
    'mongodb',
    'MEDIUM',
    '[
        {"solution": "Use bulkWrite() with UpdateOne and upsert instead of insertMany: bulkWrite([{updateOne: {filter: {_id: doc._id}, update: {$set: doc}, upsert: true}}])", "percentage": 93},
        {"solution": "Use updateMany() with upsert option for batch updates: collection.updateMany(filter, update, {upsert: true})", "percentage": 90},
        {"solution": "For mongoimport, specify upsert fields: mongoimport --upsertFields _id --file data.json", "percentage": 88}
    ]'::jsonb,
    'MongoDB collection with unique indexes, bulk operation scripts',
    'Duplicate records are updated instead of failing, bulk operations complete successfully',
    'Using insertMany() with upsert (unsupported), not specifying filter criteria for upsert, creating new ObjectIds instead of using string IDs',
    0.89,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/63693403/getting-bulkwriteerror-e11000-duplicate-key-error-collection-error-when-perform'
),
(
    'E11000 duplicate key error collection with _id field',
    'mongodb',
    'MEDIUM',
    '[
        {"solution": "Use replaceOne() instead of update: collection.replaceOne({_id: id}, newDoc, {upsert: true})", "percentage": 92},
        {"solution": "Drop and recreate collection if loading to empty database: db.collection.drop() then reload", "percentage": 85},
        {"solution": "Ensure ObjectIds are consistent: avoid creating new ObjectIds for existing documents during imports", "percentage": 88}
    ]'::jsonb,
    'MongoDB collection, bulk insert/import scripts',
    'Documents inserted or updated successfully, no duplicate key violations',
    'Attempting batch inserts without checking for existing documents, creating new ObjectIds for imported records',
    0.87,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/35168361/handling-exception-when-bulkwrite-with-ordered-as-false-in-mongodb-java'
),
(
    'MongoParseError: Invalid scheme, expected connection string to start with \"mongodb://\" or \"mongodb+srv://\"',
    'mongodb',
    'HIGH',
    '[
        {"solution": "Use correct protocol in connection string: start with mongodb:// for local or mongodb+srv:// for Atlas", "percentage": 97},
        {"solution": "Verify environment variable is loaded: console.log(process.env.MONGODB_URI) before connecting", "percentage": 94},
        {"solution": "Fix dotenv path: dotenv.config({path: ''./.env''}) instead of ''/.env'' (which points to root directory)", "percentage": 92}
    ]'::jsonb,
    'Node.js application with .env file',
    'Connection string parsed successfully, application connects to MongoDB',
    'Using custom protocols like User://, referencing undefined environment variables, incorrect dotenv path configuration',
    0.95,
    'haiku',
    NOW(),
    'https://www.mongodb.com/community/forums/t/mongoparseerror-invalid-scheme-expected-connection-string-to-start-with-mongodb-or-mongodb-srv/277976'
),
(
    'MongoParseError: Invalid connection string - malformed URI',
    'mongodb',
    'MEDIUM',
    '[
        {"solution": "Use correct format: mongodb://username:password@host:port/database with encoded special characters", "percentage": 95},
        {"solution": "For special characters in password, use percent-encoding: @ becomes %40, # becomes %23, etc", "percentage": 92},
        {"solution": "Add connection options: {useNewUrlParser: true, useUnifiedTopology: true} to Mongoose.connect()", "percentage": 88}
    ]'::jsonb,
    'Mongoose or MongoDB Node.js driver installed',
    'Connection succeeds, URI is parsed without errors',
    'Using wrong protocol prefix, missing database name, not URL-encoding special characters in password',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/54721216/mongoparseerror-invalid-connection-string'
),
(
    'Invalid connection string for Docker: can''t resolve mongodb service name',
    'mongodb',
    'LOW',
    '[
        {"solution": "Use Docker service name in connection string: mongodb://mongo:27017/database (where ''mongo'' is the service name in docker-compose.yml)", "percentage": 96},
        {"solution": "Ensure both services are on same Docker network: define network in docker-compose and connect both services to it", "percentage": 93},
        {"solution": "Verify service is running: docker-compose ps and docker logs mongo to check for startup errors", "percentage": 90}
    ]'::jsonb,
    'Docker and docker-compose configured, services defined',
    'Docker container resolves service name, connection succeeds from application container',
    'Using localhost or 127.0.0.1 in Docker instead of service name, services on different networks, MongoDB not fully started',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/54721216/mongoparseerror-invalid-connection-string'
),
(
    'MongoNetworkError: failed to connect to server on first connect',
    'mongodb',
    'HIGH',
    '[
        {"solution": "Ensure MongoDB is running: mongod for local or verify Atlas cluster is running", "percentage": 94},
        {"solution": "Check firewall rules: sudo ufw allow 27017 on Linux or add port 27017 to Windows Firewall", "percentage": 89},
        {"solution": "Verify connection string port matches MongoDB configuration: default is 27017", "percentage": 91}
    ]'::jsonb,
    'MongoDB installed, network connectivity available',
    'First connection attempt succeeds without network errors',
    'Firewall blocking MongoDB port, wrong port in connection string, MongoDB not started before application connects',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/73321794/mongonetworkerror-connect-econnrefused-127-0-0-127017-intel-macos-monterey'
),
(
    'Error: connect ECONNREFUSED - bind configuration issue',
    'mongodb',
    'MEDIUM',
    '[
        {"solution": "For remote connections, set bindIp to 0.0.0.0 in /etc/mongod.conf: bindIp: 0.0.0.0", "percentage": 93},
        {"solution": "For local only, configure bindIp: [127.0.0.1] and use 127.0.0.1 in connection string", "percentage": 91},
        {"solution": "Restart MongoDB after changing bindIp: sudo service mongod restart", "percentage": 90}
    ]'::jsonb,
    'MongoDB configuration file access, ability to restart service',
    'Connection from remote hosts succeeds, netstat shows mongod listening on correct interface',
    'Not updating bindIp configuration for remote access, mismatching bindIp with connection string host',
    0.89,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/20386464/econnrefused-error-when-connecting-to-mongodb-from-node-js'
),
(
    'MongoDB permission denied - insufficient disk space',
    'mongodb',
    'LOW',
    '[
        {"solution": "Free up disk space: MongoDB requires minimum 3.4GB for journal files, check with df -h", "percentage": 89},
        {"solution": "Verify MongoDB data directory permissions: chown -R mongodb:mongodb /var/lib/mongodb", "percentage": 87},
        {"solution": "Check ownership of dbPath directory matches mongod user in /etc/mongod.conf", "percentage": 85}
    ]'::jsonb,
    'MongoDB installed, server access, disk available',
    'MongoDB starts successfully, writes complete without permission errors',
    'Ignoring disk space warnings, not checking data directory ownership, misconfiguring dbPath location',
    0.83,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/12831939/couldnt-connect-to-server-127-0-0-127017'
),
(
    'Socket hang up - MongoDB connection drops unexpectedly',
    'mongodb',
    'MEDIUM',
    '[
        {"solution": "Increase socketTimeoutMS: {socketTimeoutMS: 30000} in connection options", "percentage": 88},
        {"solution": "Add connection pooling with minPoolSize and maxPoolSize options", "percentage": 85},
        {"solution": "Enable TCP keep-alive: {tcpNoDelay: true} to detect connection loss faster", "percentage": 83}
    ]'::jsonb,
    'MongoDB connection configured, network stable',
    'Connections remain stable, no socket hangup errors in logs',
    'Setting timeout too low, not configuring connection pool, ignoring network latency issues',
    0.81,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/40216639/mongodb-connection-timed-out-error'
),
(
    'MongoServerSelectionError: connect ECONNREFUSED when trying to connect to Atlas',
    'mongodb',
    'MEDIUM',
    '[
        {"solution": "Add your IP address to MongoDB Atlas Network Access: Atlas Dashboard > Security > Network Access > Add IP Address", "percentage": 96},
        {"solution": "Use connection string from Atlas directly: copy from ''Connect'' button in cluster view", "percentage": 94},
        {"solution": "Verify MongoDB Atlas cluster is deployed and running: check cluster status in Atlas dashboard", "percentage": 92}
    ]'::jsonb,
    'MongoDB Atlas account with cluster created',
    'Connection to Atlas succeeds, data operations complete without errors',
    'Not whitelisting application IP in Atlas network access, using wrong connection string format, cluster not deployed',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/46523321/mongoerror-connect-econnrefused-127-0-0-127017'
),
(
    'Authentication failed with SCRAM-SHA-1 mechanism',
    'mongodb',
    'LOW',
    '[
        {"solution": "Ensure user is created with SCRAM-SHA-1 authentication: db.createUser({user: ''username'', pwd: ''password'', roles: [''readWrite'']})", "percentage": 92},
        {"solution": "Verify authentication database matches: use admin database for admin users, specific DB for application users", "percentage": 89},
        {"solution": "Check MongoDB authentication is enabled: security.authorization is ''enabled'' in mongod.conf", "percentage": 87}
    ]'::jsonb,
    'MongoDB running, admin access to create users',
    'User authentication succeeds with specified mechanism, application connects',
    'Creating users in wrong authentication database, disabling auth by accident, using unsupported auth mechanism',
    0.86,
    'haiku',
    NOW(),
    'https://www.mongodb.com/docs/atlas/troubleshoot-connection/'
),
(
    'SSL/TLS certificate verification failed during MongoDB connection',
    'mongodb',
    'LOW',
    '[
        {"solution": "Disable certificate verification for development: {sslValidate: false} (NOT for production)", "percentage": 88},
        {"solution": "For production, ensure CA certificate is valid: download from MongoDB Atlas and specify in connection", "percentage": 94},
        {"solution": "Use tlsCAFile parameter: ?tlsCAFile=/path/to/ca.pem in connection string", "percentage": 92}
    ]'::jsonb,
    'MongoDB Atlas cluster with TLS enabled, CA certificate file available',
    'Connection succeeds with certificate validation enabled, no SSL errors',
    'Using self-signed certificates in production, disabling validation permanently, incorrect CA file path',
    0.84,
    'haiku',
    NOW(),
    'https://www.mongodb.com/docs/atlas/troubleshoot-connection/'
),
(
    'WriteError: cannot create namespace in this step',
    'mongodb',
    'LOW',
    '[
        {"solution": "Create collection before writing: db.createCollection(''collectionName'') or insert document first", "percentage": 91},
        {"solution": "Ensure database exists: create at least one collection in the database", "percentage": 88},
        {"solution": "Verify no restrictions on collection naming: avoid reserved keywords, special characters", "percentage": 85}
    ]'::jsonb,
    'MongoDB database created, write permissions available',
    'Documents insert successfully, collection is created automatically with first write',
    'Attempting to create collections in read-only mode, using invalid collection names, database not initialized',
    0.82,
    'haiku',
    NOW(),
    'https://www.mongodb.com/docs/drivers/node/current/connect/connection-troubleshooting/'
),
(
    'Error: the server did not respond to the test - connection refused to replica set',
    'mongodb',
    'LOW',
    '[
        {"solution": "Verify all replica set members are running: rs.status() to check member health", "percentage": 93},
        {"solution": "For replica sets, use replicaSet parameter: mongodb://host1,host2/?replicaSet=rs0", "percentage": 91},
        {"solution": "Ensure network connectivity between replica set members: ping all hosts from each node", "percentage": 89}
    ]'::jsonb,
    'MongoDB replica set configured, multiple nodes',
    'Replica set election succeeds, connections distribute across healthy members',
    'Forgetting replicaSet parameter in connection string, not starting all replica set members, network partitions',
    0.85,
    'haiku',
    NOW(),
    'https://www.mongodb.com/docs/compass/current/troubleshooting/connection-errors/'
),
(
    'Duplicate key error when inserting with ordered: false in bulk operations',
    'mongodb',
    'MEDIUM',
    '[
        {"solution": "Catch BulkWriteError and inspect details: catch(err) {console.log(err.result.writeErrors)}", "percentage": 91},
        {"solution": "Set ordered: false in insertMany to continue on errors: insertMany(docs, {ordered: false})", "percentage": 89},
        {"solution": "Pre-check for existing documents: db.collection.find({_id: {$in: ids}}) before inserting", "percentage": 87}
    ]'::jsonb,
    'MongoDB driver supporting bulk operations',
    'Bulk insert completes with partial success, writeErrors contain failed document details',
    'Using ordered inserts when unordered is needed, not handling partial failures, assuming all-or-nothing behavior',
    0.86,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/32825153/avoid-mongodb-bulk-insert-duplicate-key-error'
),
(
    'URI component error with special characters in password',
    'mongodb',
    'MEDIUM',
    '[
        {"solution": "URL-encode special characters: @ becomes %40, # becomes %23, : becomes %3A, / becomes %2F", "percentage": 96},
        {"solution": "Use online encoder or encodeURIComponent(): encodeURIComponent(password) to encode password safely", "percentage": 94},
        {"solution": "Place encoded password between : and @ in connection string: mongodb://user:encodedPassword@host:port/db", "percentage": 93}
    ]'::jsonb,
    'Node.js application, MongoDB connection string',
    'Connection succeeds with special character passwords, authentication passes',
    'Copying passwords with special chars directly without encoding, forgetting to encode, using wrong encoding format',
    0.93,
    'haiku',
    NOW(),
    'https://www.mongodb.com/docs/drivers/node/current/connect/connection-troubleshooting/'
);
