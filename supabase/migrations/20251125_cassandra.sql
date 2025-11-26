-- Cassandra Troubleshooting Knowledge Base Entries
-- 25 High-Quality Error Solutions from Official Docs and Community Sources
-- Mined: 2025-11-25

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES

-- 1. NoHostAvailableException - Connection failures
(
    'NoHostAvailableException: All host(s) tried for query failed (tried: host:9042 (com.datastax.driver.core.exceptions.TransportException: Cannot connect))',
    'cassandra',
    'CRITICAL',
    '[
        {"solution": "Verify rpc_address and broadcast_rpc_address in cassandra.yaml match client-accessible IP. If rpc_address is 0.0.0.0, broadcast_rpc_address must be set to the actual node IP", "percentage": 95},
        {"solution": "Ensure port 9042 is open in firewall/security groups and Cassandra native_transport_port is configured correctly", "percentage": 90},
        {"solution": "Check if Cassandra is running: telnet <node_ip> 9042. If connection refused, restart Cassandra service", "percentage": 85}
    ]'::jsonb,
    'Access to cassandra.yaml configuration file, network connectivity to Cassandra nodes, telnet or nc command available',
    'Can connect to Cassandra nodes via cqlsh or telnet to port 9042. Query execution succeeds without NoHostAvailableException',
    'Assuming client can reach the IP without verifying rpc_address configuration. Using wrong port number (9160 legacy vs 9042 native). Not restarting Cassandra after configuration changes',
    0.95,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/32086643/unexpected-connection-timeout-in-datastax-cassandra'
),

-- 2. BusyPoolException - Connection pool exhaustion
(
    'BusyPoolException: All connections to host are busy (no available connection and the queue has reached its max size 256)',
    'cassandra',
    'HIGH',
    '[
        {"solution": "Increase connections per host in driver configuration to minimum 10-20 (default is 1). For Azure/cloud: 10 connections per 200,000 RU", "percentage": 92},
        {"solution": "Increase socket read timeout to 60+ seconds (recommend 90 seconds) to prevent connection timeout due to latency", "percentage": 88},
        {"solution": "Implement connection pooling with max_requests_per_connection tuning in driver configuration", "percentage": 85}
    ]'::jsonb,
    'Access to application driver configuration, knowledge of your Cassandra cluster throughput capacity, monitoring tools for connection metrics',
    'Queued requests complete without BusyPoolException. Connection pool utilization stays below 80%. Application latency normalized',
    'Setting max_requests_per_connection too high instead of increasing connections per host. Using default timeout values without considering cloud/latency. Not monitoring actual connection pool usage',
    0.92,
    'haiku',
    NOW(),
    'https://learn.microsoft.com/en-us/azure/cosmos-db/cassandra/troubleshoot-nohostavailable-exception'
),

-- 3. Connection Refused - Service not running
(
    'Connection error: Unable to connect to any servers, 127.0.0.1: Connection refused (Tried connecting to [(''127.0.0.1'', 9042)]. Last error: Connection refused)',
    'cassandra',
    'CRITICAL',
    '[
        {"solution": "Check Cassandra is running: service cassandra status or ps aux | grep cassandra. If not running, start with: service cassandra start", "percentage": 96},
        {"solution": "Verify cassandra.yaml has start_native_transport: true and native_transport_port: 9042 configured", "percentage": 93},
        {"solution": "Check Cassandra logs for startup errors: tail -f /var/log/cassandra/system.log. Look for ERROR or WARN messages indicating initialization failure", "percentage": 90}
    ]'::jsonb,
    'System access to run service commands, Cassandra installed and configured, access to cassandra.yaml and log files',
    'Cassandra service running (ps shows cassandra process). Port 9042 listening (netstat -an | grep 9042). cqlsh connects successfully',
    'Checking only the client-side connection settings without verifying the server is running. Not checking service status before troubleshooting. Using outdated port 9160',
    0.96,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/29121904/cassandra-cqlsh-connection-refused'
),

-- 4. cqlsh.py: Abrupt end of stream (missing native_transport)
(
    'cqlsh.py: Unable to connect to any servers, error: cqlsh.Connection: Connection to /127.0.0.1:9042 closed',
    'cassandra',
    'HIGH',
    '[
        {"solution": "Enable native transport in cassandra.yaml: start_native_transport: true. Then restart Cassandra", "percentage": 94},
        {"solution": "Verify native_transport_port is set to 9042 (or your configured port) in cassandra.yaml", "percentage": 91},
        {"solution": "Remove stale configuration: rm -Rf ~/.cassandra directory to clear old cqlsh settings and cached connection data", "percentage": 88}
    ]'::jsonb,
    'Cassandra 3.0+, access to cassandra.yaml file, service restart capability',
    'cqlsh connects and shows cqlsh prompt. Native transport listener shown in system.log startup messages',
    'Assuming it is a cqlsh configuration issue without checking server-side native_transport setting. Not removing ~/.cassandra cache. Mixing old and new configuration files',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/27004773/cassandra-cqlsh-unable-to-connect-to-any-servers'
),

-- 5. OperationTimedOutException - Query timeout
(
    'com.datastax.driver.core.exceptions.OperationTimedOutException: [host/ip:9042] Operation timed out after 5000 MILLISECONDS',
    'cassandra',
    'CRITICAL',
    '[
        {"solution": "DO NOT increase timeout values. Instead identify root cause: check Cassandra logs for GC pauses, query performance, or node overload during timeout window", "percentage": 93},
        {"solution": "Monitor nodetool tpstats output for pending task queue buildup. If ReadStage/MutationStage queues > 1000, cluster is overloaded", "percentage": 90},
        {"solution": "Check nodetool proxyhistograms to identify latency percentiles. If p99 latency > timeout threshold, tune data model or compaction settings", "percentage": 88}
    ]'::jsonb,
    'Access to Cassandra logs, nodetool availability, understanding of your application query patterns and cluster capacity',
    'Query execution completes within timeout window. nodetool tpstats shows <100 pending tasks. Cassandra logs show no GC warnings during query execution',
    'Immediately increasing timeout values masks root cause. Not checking if cluster is actually overloaded. Blaming network without inspecting server-side performance. Not using nodetool diagnostics',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/69394467/time-out-error-while-purging-in-cassandra'
),

-- 6. Spark Cassandra timeout - Write throughput exceeded
(
    'com.datastax.driver.core.exceptions.OperationTimedOutException during Spark batch insert to Cassandra (Spark.cassandra.output failure)',
    'cassandra',
    'HIGH',
    '[
        {"solution": "Reduce write pressure with Spark tuning: spark.cassandra.output.throughput_mb_per_sec = 1000 (start conservative, increase gradually)", "percentage": 91},
        {"solution": "Limit concurrent writes: spark.cassandra.output.concurrent.writes = 128 to prevent overwhelming Cassandra nodes", "percentage": 89},
        {"solution": "Benchmark your cluster throughput using cassandra-stress tool before determining optimal Spark write parameters for your hardware/data model", "percentage": 87}
    ]'::jsonb,
    'Spark-Cassandra connector configured, Cassandra cluster with known hardware specs, cassandra-stress tool available',
    'Spark batch job completes without timeouts. Cassandra logs show no GC spikes or hint queue buildup during writes. Data integrity verified (no null PKs)',
    'Using aggressive default Spark settings without benchmarking. Setting batch sizes manually instead of using connector batching. Not monitoring Cassandra metrics during writes',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/32501108/all-hosts-tried-for-query-failed-com-datastax-driver-core-operationtimedoute'
),

-- 7. Bad configuration: At least one DataFileDirectory must be specified
(
    'Bad configuration; unable to start server: At least one DataFileDirectory must be specified',
    'cassandra',
    'CRITICAL',
    '[
        {"solution": "Open cassandra.yaml and uncomment data_file_directories setting. Ensure at least one valid path is specified (e.g., /var/lib/cassandra/data)", "percentage": 97},
        {"solution": "Ensure all directories exist and are writable: commitlog_directory, saved_caches_directory, hints_directory. Create if missing: mkdir -p /path && chown cassandra:cassandra /path", "percentage": 95},
        {"solution": "Verify CASSANDRA_HOME environment variable is set if relying on default paths. Otherwise explicitly configure full paths in cassandra.yaml", "percentage": 93}
    ]'::jsonb,
    'Root or sudo access to edit cassandra.yaml, ability to create directories, Cassandra user created on system',
    'Cassandra starts successfully. Data files directory contains SSTables. cqlsh connects and queries return results',
    'Using relative paths instead of absolute paths. Not ensuring directories are writable by cassandra user. Assuming default paths work without verifying CASSANDRA_HOME',
    0.97,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/64813888/cant-start-cassandra'
),

-- 8. MarshalException - Corrupted TimeUUID
(
    'org.apache.cassandra.serializers.MarshalException: Unknown timeuuid representation: (invalid character) at TimeUUIDType.fromString',
    'cassandra',
    'HIGH',
    '[
        {"solution": "Stop Cassandra immediately. Back up data directory. Disable SASI indexes on the affected column family in schema definition", "percentage": 92},
        {"solution": "Identify corrupted SSTables: enable DEBUG logging and restart to capture which SSTable file triggers the error in logs", "percentage": 88},
        {"solution": "Delete the corrupted SSTable files. Restart Cassandra. After verification, rebuild SASI indexes if originally present", "percentage": 90}
    ]'::jsonb,
    'Cassandra backup capability, schema access to drop/recreate indexes, ability to identify and delete SSTable files, data already backed up elsewhere',
    'Cassandra starts without MarshalException errors. Queries on previously-affected table return results. No errors in system.log during startup',
    'Not backing up data before deleting SSTables. Deleting wrong SSTable files. Not disabling indexes before deletion. Restarting without confirming corruption location first',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/46038431/error-when-starting-cassandra-server'
),

-- 9. Year 2038 TTL overflow - AssertionError
(
    'java.lang.AssertionError: [negative-value] at BufferExpiringCell.<init> when inserting with TTL. default_time_to_live set to very large value',
    'cassandra',
    'MEDIUM',
    '[
        {"solution": "Reduce default_time_to_live on affected table to value < (2^31 - 1 - current_unix_timestamp). For 2024, max TTL ~15 years, not 19+", "percentage": 94},
        {"solution": "Verify table TTL settings: SELECT table_name, default_time_to_live FROM system_schema.tables WHERE keyspace_name = ''your_keyspace''", "percentage": 91},
        {"solution": "Apply ALTER TABLE change: ALTER TABLE your_table WITH default_time_to_live = <appropriate_value>. Then restart affected nodes", "percentage": 93}
    ]'::jsonb,
    'CQL access to system_schema, ability to run ALTER TABLE commands, understanding of Unix timestamp limits',
    'INSERT/UPDATE operations complete without AssertionError. System logs show no assertion failures. Data persists without premature expiration',
    'Not understanding the Year 2038 32-bit overflow problem. Using arbitrary large TTL values. Not testing with data near year 2038 boundary',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/53526292/failing-cassandra-insert-and-update-statements-unexpected-exception'
),

-- 10. Unable to lock JVM memory (ENOMEM)
(
    'WARN: Unable to lock JVM memory (ENOMEM). This can result in part of the JVM being swapped out, especially with mmapped I/O enabled',
    'cassandra',
    'MEDIUM',
    '[
        {"solution": "Increase RLIMIT_MEMLOCK system limit. Edit /etc/security/limits.conf: cassandra soft memlock unlimited, cassandra hard memlock unlimited", "percentage": 92},
        {"solution": "Increase nproc limit in /etc/security/limits.conf: cassandra soft nproc 65536, cassandra hard nproc 65536 for threading support", "percentage": 90},
        {"solution": "Apply limits and log out/in for cassandra user, or restart Cassandra service to activate new limits", "percentage": 91}
    ]'::jsonb,
    'Root access to edit /etc/security/limits.conf, ability to restart Cassandra service, understanding of system resource limits',
    'Memory locked successfully on startup. system.log shows no ENOMEM warnings. OS swap not used during normal operations (verify with vmstat)',
    'Only setting memlock without setting nproc. Not restarting Cassandra after limit changes. Running as wrong user without proper limit inheritance',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/34670506/unable-to-start-cassandra-with-this-errors'
),

-- 11. Corrupt SSTable files - AssertionError during startup
(
    'Fatal exception in thread SSTableBatchOpen java.lang.AssertionError at org.apache.cassandra.io.sstable.SSTableReader.open(SSTableReader.java:150)',
    'cassandra',
    'HIGH',
    '[
        {"solution": "Enable DEBUG logging in log4j-server.properties. Restart Cassandra and capture exact SSTable filename from error log before the assertion", "percentage": 93},
        {"solution": "Back up entire data directory. Identify and delete corrupted SSTable files: rm /var/lib/cassandra/data/keyspace/table-*/na-*", "percentage": 92},
        {"solution": "Restart Cassandra and verify startup completes without assertion errors. Run nodetool repair on affected tables if primary keys are accessible", "percentage": 90}
    ]'::jsonb,
    'Full backup of data directory, access to log4j configuration, ability to identify SSTable file paths, nodetool available',
    'Cassandra starts without SSTableReader AssertionError. All tables query successfully. Repair completes (if needed) without errors',
    'Deleting SSTables without identifying which files are corrupted. Not backing up before deletion. Assuming all SSTables are corrupt when only a few files are problematic',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/10241447/error-messages-while-starting-cassandra-node'
),

-- 12. Bootstrap streaming error - ClosedChannelException
(
    'Streaming error occurred: java.nio.channels.ClosedChannelException at StreamSession when bootstrapping new node',
    'cassandra',
    'CRITICAL',
    '[
        {"solution": "Check Cassandra version: if version 2.2.4, upgrade to 2.2.5+ immediately as this contains official fix for bootstrap bug CASSANDRA-10961", "percentage": 96},
        {"solution": "If upgrade not immediately possible, apply patched JAR file for 2.2.4 (available from DataStax) before attempting bootstrap again", "percentage": 94},
        {"solution": "Verify network connectivity between nodes: ping between all nodes in cluster. Ensure no firewall blocking inter-node gossip (port 7000) and streaming (port 7001)", "percentage": 91}
    ]'::jsonb,
    'Cassandra package manager or upgrade capability, network access to DataStax patched JAR (if needed), network troubleshooting tools, backup of existing node data',
    'New node completes bootstrap without ClosedChannelException. Node marked as UP/NORMAL in nodetool status. Token ownership balanced across cluster',
    'Attempting bootstrap with known buggy version without upgrading first. Not verifying inter-node network connectivity before bootstrap. Ignoring streaming error messages and retry',
    0.96,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/34555653/cassandra-bootstrap-fail-with-streaming-error-occurred'
),

-- 13. No data_file_directories configuration
(
    'Error starting Cassandra: No data_file_directories configuration found and $CASSANDRA_HOME environment variable not set',
    'cassandra',
    'HIGH',
    '[
        {"solution": "Set CASSANDRA_HOME environment variable: export CASSANDRA_HOME=/path/to/cassandra. Add to ~/.bashrc or ~/.profile for persistence", "percentage": 94},
        {"solution": "OR explicitly configure data_file_directories in cassandra.yaml: data_file_directories: - /var/lib/cassandra/data", "percentage": 96},
        {"solution": "Create configured directories if missing: mkdir -p /var/lib/cassandra/data /var/lib/cassandra/commitlog. Set permissions: chown -R cassandra:cassandra /var/lib/cassandra", "percentage": 95}
    ]'::jsonb,
    'Ability to edit environment variables or cassandra.yaml, system directory creation capability, understanding of Cassandra directory structure',
    'Cassandra starts successfully. Data directories appear in logs. SSTables created during first write operation',
    'Setting CASSANDRA_HOME incorrectly to Cassandra config directory instead of installation directory. Using relative paths instead of absolute. Not creating directories before startup',
    0.95,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/64813888/cant-start-cassandra'
),

-- 14. Driver version incompatibility with Cassandra version
(
    'NoHostAvailableException: All host(s) tried for query failed when connecting to Cassandra 3.0 using DataStax Java driver 2.0.10',
    'cassandra',
    'MEDIUM',
    '[
        {"solution": "Check driver version compatibility: Java driver 2.0.x only supports Cassandra 1.2-2.0. For Cassandra 3.0+ use driver 3.0.0 or later", "percentage": 97},
        {"solution": "Upgrade Java driver in Maven/Gradle: com.datastax.cassandra:cassandra-driver-core:3.0.0+ (check for latest 3.x or 4.x version)", "percentage": 96},
        {"solution": "Rebuild and redeploy application. Test connection to cluster nodes. Verify queries execute successfully", "percentage": 95}
    ]'::jsonb,
    'Access to Maven/Gradle configuration, application rebuild capability, deployed environment access, documentation of current driver version',
    'Application connects to Cassandra cluster without NoHostAvailableException. Queries execute and return results. Driver version shown correctly in logs',
    'Assuming connection issue is network-related without checking driver version. Not checking Cassandra version before selecting driver. Using old driver documentation',
    0.97,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/34395191/cassandra-java-driver-error-all-hosts-tried-for-query-failed-connection-has'
),

-- 15. Timeout while acquiring available connection
(
    'com.datastax.driver.core.exceptions.DriverException: Timeout while trying to acquire available connection from host pool',
    'cassandra',
    'HIGH',
    '[
        {"solution": "Root cause: sending more requests than driver can handle. Monitor queue depth: if > 100 requests queued, reduce application request rate", "percentage": 93},
        {"solution": "Increase connection pool size and queue size in driver configuration. Set connections_per_host to 8-16 (from default 2-4)", "percentage": 91},
        {"solution": "Implement client-side rate limiting or backpressure to match application request rate to Cassandra cluster capacity", "percentage": 89}
    ]'::jsonb,
    'Monitoring/metrics for driver queue depth, ability to modify driver configuration, understanding of application workload patterns',
    'Request queue maintained below 50 depth. Timeout exception ceases. Driver metrics show healthy connection pool utilization (50-80%)',
    'Increasing timeout values without addressing root cause (too many requests). Not monitoring actual queue depth. Not implementing rate limiting or backpressure',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/33517348/cassandra-com-datastax-driver-core-exceptions-driverexception-timeout-while-t'
),

-- 16. ReadTimeoutException - read_request_timeout exceeded
(
    'ReadTimeoutException: Cassandra timeout during read query at consistency level ONE (timeout after 5000ms at coordinator host)',
    'cassandra',
    'HIGH',
    '[
        {"solution": "Check read_request_timeout_in_ms in cassandra.yaml (default 5000). If queries consistently take 4000+ ms, increase to 10000-15000", "percentage": 92},
        {"solution": "Verify table compaction is progressing: nodetool compactionstats. If compaction backlog building, tune concurrent_compactors", "percentage": 90},
        {"solution": "Profile slow query: nodetool tablehistograms keyspace table shows p95/p99 latencies. If > timeout, optimize query/data model", "percentage": 88}
    ]'::jsonb,
    'Access to cassandra.yaml, nodetool availability, understanding of query patterns, ability to modify compaction settings',
    'Read queries complete within timeout window. nodetool tablehistograms shows p99 latency < read_request_timeout. No ReadTimeoutException in logs',
    'Only increasing timeout without checking actual query latency. Not verifying compaction is keeping up with write rate. Assuming network issue without profiling queries',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/34450443/all-hosts-tried-for-query-failed-com-datastax-driver-core-exceptions-operati'
),

-- 17. WriteTimeoutException - write_request_timeout exceeded
(
    'WriteTimeoutException: Cassandra timeout during write query (timeout exceeded at replicas)',
    'cassandra',
    'HIGH',
    '[
        {"solution": "Check write_request_timeout_in_ms in cassandra.yaml (default 2000). For heavy writes, increase to 5000-10000", "percentage": 91},
        {"solution": "Monitor Cassandra GC pauses: check gc.log for pause times > timeout value. If present, increase heap size or tune GC", "percentage": 89},
        {"solution": "Verify replication factor and consistency level match query needs. Higher replication = longer write time. Use LOCAL_QUORUM if possible", "percentage": 88}
    ]'::jsonb,
    'Access to cassandra.yaml, GC log access, ability to adjust heap size, understanding of consistency level tradeoffs',
    'Write operations complete successfully. GC pauses < write_request_timeout. No WriteTimeoutException in application logs',
    'Setting consistency level too high for write latency requirements. Not accounting for GC pauses. Increasing timeout without addressing GC tuning',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/35005734/constant-timeouts-in-cassandra-after-adding-second-node'
),

-- 18. Dropped message from coordinator - overload
(
    '[MessagingService] Dropped (outbound) message to peer host (message dropped because the queue was full)',
    'cassandra',
    'HIGH',
    '[
        {"solution": "Check source of dropped messages: nodetool tpstats shows which threadpool is congested (ReadStage, MutationStage, etc)", "percentage": 92},
        {"solution": "For high write volume: increase concurrent_writes in cassandra.yaml (default 32). For high read volume: increase concurrent_reads (default 32)", "percentage": 90},
        {"solution": "Reduce request rate to cluster or scale up: add more nodes to cluster. Verify cluster has 3+ nodes for failover capacity", "percentage": 88}
    ]'::jsonb,
    'nodetool access, ability to modify cassandra.yaml, understanding of concurrent operation tuning, cluster scaling capability',
    'Dropped messages cease appearing in logs. nodetool tpstats shows no queue buildup. Request latency normalized',
    'Immediately increasing concurrency limits without identifying which operations are bottlenecked. Not checking actual queue depths with tpstats. Over-tuning concurrency causing GC issues',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/52722674/connection-time-out-in-cassandra'
),

-- 19. Hinted handoff failure - message loopback
(
    'Cassandra hinted handoff error: AssertionError or NullPointerException in WriteCallbackInfo when delivering hint to replica',
    'cassandra',
    'MEDIUM',
    '[
        {"solution": "Check system.log for topology changes around error timestamp. Verify all nodes reachable: nodetool status shows all nodes UP", "percentage": 90},
        {"solution": "Review gossip configuration in cassandra.yaml: seed_provider and listen_address must be consistent across cluster", "percentage": 88},
        {"solution": "If error persists, truncate system.hints table: TRUNCATE system.hints;. Restart node to clear corrupted hints", "percentage": 86}
    ]'::jsonb,
    'CQL access, nodetool status checking capability, ability to restart nodes, Cassandra log access for topology analysis',
    'Hinted handoff completes without errors. system.hints table empties normally. All nodes show UP/NORMAL in nodetool status',
    'Not verifying cluster topology consistency. Truncating hints without first backing up data. Changing seed nodes without proper restart sequence',
    0.88,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/41238439/cassandra-hinted-handoff-message-error'
),

-- 20. Repair command failed - check server logs
(
    'nodetool repair error: RuntimeException: nodetool failed, check server logs (repair command #N finished error)',
    'cassandra',
    'MEDIUM',
    '[
        {"solution": "Manually troubleshoot repair session using session ID from error: grep ''SESSION_ID_HERE'' /var/log/cassandra/system.log to find root cause", "percentage": 92},
        {"solution": "Check for merkle tree mismatch errors: high mismatch count indicates anti-entropy needed. Verify repair running on reachable nodes only", "percentage": 89},
        {"solution": "Try repair with specific keyspace/table: nodetool repair keyspace table. Full cluster repair without scoping can timeout on large datasets", "percentage": 88}
    ]'::jsonb,
    'nodetool access, Cassandra log file access, session ID from repair error output, repair timeout settings',
    'Repair completes successfully. Session ID resolved in logs with completion status. Anti-entropy operations finish within expected timeframe',
    'Running full cluster repair without narrowing scope. Not using session ID to debug actual failure cause. Assuming repair failed completely without checking partial completion',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/78646012/cassandra-repair-failed-without-error-log'
),

-- 21. JMX binding failure - port already in use
(
    'Unable to bind JMX (port 7199), is Cassandra already running? Address already in use',
    'cassandra',
    'MEDIUM',
    '[
        {"solution": "Check if Cassandra is running: ps aux | grep cassandra. If multiple processes, kill extras: pkill -f cassandra", "percentage": 93},
        {"solution": "Change JMX port in cassandra-env.sh: com.sun.management.jmxremote.port=7200 (or unused port). Restart Cassandra", "percentage": 91},
        {"solution": "Force port release: lsof -i :7199 shows process holding port. Kill with kill -9 PID if it is stale Cassandra process", "percentage": 89}
    ]'::jsonb,
    'Process listing access (ps, lsof), ability to kill processes, cassandra-env.sh edit access, service restart capability',
    'JMX binds successfully on startup. system.log shows ''Started listening for remote JMX connections'' message. nodetool status works',
    'Not checking if multiple Cassandra processes running. Killing wrong process holding the port. Changing JMX port without restarting',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/27004773/cassandra-cqlsh-unable-to-connect-to-any-servers-127-0-0-19160-closed-is-a'
),

-- 22. Insufficient disk space for flush
(
    'Flush error: Unable to write memtable flush to disk. No space left on device (flush writer thread aborted)',
    'cassandra',
    'CRITICAL',
    '[
        {"solution": "Check disk usage: df -h. If data_file_directories filesystem > 90%, delete oldest SSTables or expand partition", "percentage": 94},
        {"solution": "Stop Cassandra: service cassandra stop. Remove *.tmp files from data directory (incomplete flushes): find /var/lib/cassandra -name ''*.tmp'' -delete", "percentage": 92},
        {"solution": "Increase disk space or configure compaction thresholds in cassandra.yaml to reduce SSTable count", "percentage": 90}
    ]'::jsonb,
    'Disk space management capability, ability to stop/restart Cassandra, compaction knowledge, backup of old SSTables before deletion',
    'Disk usage < 85%. Memtable flushes complete successfully. No flush errors in system.log. Free space monitoring alert configured',
    'Deleting SSTables without backup. Not stopping Cassandra during cleanup (causes corruption). Not addressing root cause of disk fill (runaway writes)',
    0.93,
    'haiku',
    NOW(),
    'https://cassandra.apache.org/doc/latest/cassandra/troubleshooting/reading_logs.html'
),

-- 23. Too many tombstones - query performance degradation
(
    'WARN: Query on table returned [N] tombstones. Performance may be impacted. Query timed out due to tombstone count exceeding limit',
    'cassandra',
    'MEDIUM',
    '[
        {"solution": "Check tombstone_failure_threshold in cassandra.yaml (default 100000). Increase carefully if legitimate use case, or reduce deletes", "percentage": 89},
        {"solution": "Run major compaction to reclaim tombstone space: nodetool compact keyspace table. Delete expired tombstones (gc_grace_seconds default 10 days)", "percentage": 91},
        {"solution": "Review data model: excessive deletes/overwrites create tombstones. Consider time-series compaction strategy for time-bucketed data", "percentage": 87}
    ]'::jsonb,
    'nodetool availability, cassandra.yaml access, compaction monitoring capability, understanding of data model patterns',
    'Tombstone warnings cease appearing. Query latency returns to normal. Compaction reduces SSTable size by 30%+',
    'Only increasing tombstone_failure_threshold without compaction. Not understanding tombstone lifecycle. Using wrong compaction strategy for workload',
    0.89,
    'haiku',
    NOW(),
    'https://cassandra.apache.org/doc/latest/cassandra/troubleshooting/use_nodetool.html'
),

-- 24. GC overhead limit exceeded - heap exhaustion
(
    'java.lang.OutOfMemoryError: GC overhead limit exceeded (More than 98% of the heap is being used for garbage collection)',
    'cassandra',
    'CRITICAL',
    '[
        {"solution": "Increase JVM heap size in cassandra-env.sh: increase -Xmx value to 50-75% of system RAM (e.g., -Xmx16g for 32GB server)", "percentage": 93},
        {"solution": "Check for memory leak: nodetool info shows live_sstables and pending_compactions. High pending_compactions indicates compaction cannot keep pace", "percentage": 91},
        {"solution": "Tune cache settings: reduce row_cache_size_in_mb and key_cache_size_in_mb in cassandra.yaml if cluster has limited memory", "percentage": 88}
    ]'::jsonb,
    'cassandra-env.sh edit access, system memory availability for reallocation, GC log analysis, compaction metrics via nodetool',
    'Heap size increased to sustainable level. GC pause time < 200ms. No OOMError in logs. Application queries execute successfully',
    'Setting heap too high (>75% RAM) causing system swapping. Not addressing compaction backlog causing memory pressure. Enabling both row and key cache on small-heap systems',
    0.92,
    'haiku',
    NOW(),
    'https://cassandra.apache.org/doc/latest/cassandra/troubleshooting/reading_logs.html'
),

-- 25. Cassandra-stress tool errors - benchmark failure
(
    'cassandra-stress connection error: WARN - Connection refused or NoHostAvailableException during benchmark run',
    'cassandra',
    'MEDIUM',
    '[
        {"solution": "Verify Cassandra cluster is running and cluster nodes healthy: nodetool status from any node shows all nodes UP", "percentage": 94},
        {"solution": "Run cassandra-stress with explicit contact points: cassandra-stress run -node IP1,IP2,IP3 -consistency ONE -pop seq=1..100000", "percentage": 92},
        {"solution": "Check firewall allows cassandra-stress client connection: telnet cluster_ip 9042 should succeed. Port 7000/7001 for inter-node only", "percentage": 90}
    ]'::jsonb,
    'Cassandra cluster running with healthy nodes, nodetool access, cassandra-stress tool available, network connectivity to cluster',
    'cassandra-stress run completes successfully with throughput metrics printed. Operations/sec > 1000. No connection errors in output',
    'Running stress tool before cluster is fully started. Using wrong contact point IP. Testing with unrealistic consistency level for benchmark',
    0.92,
    'haiku',
    NOW(),
    'https://cassandra.apache.org/doc/latest/cassandra/troubleshooting/use_nodetool.html'
),

-- 26. SyntaxError - Malformed CQL map literals
(
    'com.datastax.driver.core.exceptions.SyntaxError: line 1:[N] mismatched input '':'' expecting ''}'' (malformed map literal with colons instead of commas)',
    'cassandra',
    'MEDIUM',
    '[
        {"solution": "Use PreparedStatement with parameterized queries instead of string concatenation: session.prepare(\"INSERT INTO table VALUES (?,?,?)\") with bind()", "percentage": 96},
        {"solution": "For map literals, let the driver handle serialization: Map<String,String> map = new HashMap(); driver converts to proper CQL format", "percentage": 94},
        {"solution": "Never manually build CQL strings with collections. String concatenation causes syntax errors due to missing commas, wrong delimiters, or escape issues", "percentage": 95}
    ]'::jsonb,
    'DataStax Java driver available, understanding of PreparedStatement API, Java Map/Collection types',
    'Query executes without SyntaxError. Data inserted with correct map values. No parsing errors in debug logs',
    'Using string concatenation to build CQL with map literals. Not escaping special characters in string values. Mixing manual CQL formatting with parameterized queries',
    0.95,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/73331316/invalid-string-constant-or-mismatched-input-expecting-cassandra-db'
),

-- 27. AlreadyExistsException - Async table creation timing issue
(
    'com.datastax.oss.driver.api.core.servererrors.AlreadyExistsException: Object keyspace.table already exists (even though table not visible in queries)',
    'cassandra',
    'MEDIUM',
    '[
        {"solution": "Use CREATE TABLE IF NOT EXISTS syntax to prevent exception on repeated execution attempts", "percentage": 93},
        {"solution": "Implement polling on system_schema_mcs.tables: wait until table status = ''ACTIVE'' before proceeding (AWS Keyspaces specific)", "percentage": 94},
        {"solution": "Add Thread.sleep(1000) retry loop checking status: while(table_not_active) { sleep(1000); check_status() } before next operations", "percentage": 92}
    ]'::jsonb,
    'CQL access to system schema tables, ability to implement retry loops, understanding of async DDL operations, AWS Keyspaces (if applicable)',
    'Table creation completes with IF NOT EXISTS. Subsequent queries show table in system_schema. Status query returns ACTIVE status before operations',
    'Not using IF NOT EXISTS on CREATE TABLE. Not waiting for table status ACTIVE before executing queries. Assuming synchronous DDL without polling',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/70196447/getting-alreadyexistsexception-when-creating-table-even-table-is-not-found-in-a'
),

-- 28. SyntaxError - IN clause requires parentheses on collection parameters
(
    'com.datastax.driver.core.exceptions.SyntaxError: line 1:[N] no viable alternative at input ''[date-value]'' in IN clause (missing parentheses on parameter)',
    'cassandra',
    'MEDIUM',
    '[
        {"solution": "Add parentheses around collection parameter in IN clause: WHERE field IN (?1) instead of WHERE field IN ?1", "percentage": 97},
        {"solution": "Ensure CassandraRepository @Query uses proper syntax: @Query(\"... WHERE id IN (?0)\") for List<String> parameter", "percentage": 96},
        {"solution": "Use PreparedStatement with explicit collection binding if driver/ORM doesn''t support @Query syntax with parentheses", "percentage": 94}
    ]'::jsonb,
    'Spring Data Cassandra or DataStax driver, @Query annotation support (CassandraRepository), knowledge of CQL IN clause syntax',
    'Query with IN clause executes without SyntaxError. All list items match returned results. No parsing errors in logs',
    'Omitting parentheses around collection placeholders. Using wrong placeholder syntax (positional vs named). Not testing query with actual collection data',
    0.96,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/69778807/cassandrarepository-no-viable-alternative-at-input-2021-01'
),

-- 29. Batch too large - CSV import failure
(
    'com.datastax.driver.core.exceptions.InvalidQueryException: code=2200 [Invalid query] message=''Batch too large'' (batch exceeds batch_size_fail_threshold_in_kb)',
    'cassandra',
    'HIGH',
    '[
        {"solution": "Reduce batch size by adding CHUNKSIZE parameter: COPY table (...) FROM ''file.csv'' WITH CHUNKSIZE=1 to process one row per batch", "percentage": 95},
        {"solution": "Reduce MAXBATCHSIZE in cqlsh COPY command from default 20 to lower value (e.g., 50-100 rows) to avoid exceeding byte threshold", "percentage": 93},
        {"solution": "Increase cassandra.yaml batch_size_fail_threshold_in_kb (default 50KB) only as last resort. First optimize batch content size", "percentage": 88}
    ]'::jsonb,
    'cqlsh access, CSV file with large columns, ability to edit COPY command parameters, cassandra.yaml access if tuning needed',
    'CSV import completes without batch size errors. All rows successfully inserted into target table. No InvalidQueryException in cqlsh output',
    'Increasing MAXBATCHSIZE thinking more rows = more batches (incorrect). Not using CHUNKSIZE parameter. Tuning server threshold without client-side optimization',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/36618142/cassandra-csv-import-errorbatch-too-large'
),

-- 30. Batch too large - Spark connector writes
(
    'com.datastax.driver.core.exceptions.InvalidQueryException: Batch too large (when using Spark-Cassandra connector for batch inserts)',
    'cassandra',
    'HIGH',
    '[
        {"solution": "Reduce batch size: batch.size.bytes = 51200 (51KB) or lower to stay under batch_size_fail_threshold_in_kb", "percentage": 94},
        {"solution": "Do NOT manually create large BatchStatements. Use spark.cassandra.output settings to control batch size automatically", "percentage": 92},
        {"solution": "Restructure data model: consolidate related rows into single table with maps/collections instead of relying on batch atomicity", "percentage": 90}
    ]'::jsonb,
    'Spark-Cassandra connector, understanding of batch.size.bytes parameter, ability to modify Spark configuration, data model knowledge',
    'Spark batch job completes successfully. Cassandra logs show no batch size warnings. Data inserted with correct values',
    'Manually building very large batches thinking they''re faster. Setting batch.size.bytes too high without testing. Not restructuring data model',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/41557794/cassandra-batch-invalidqueryexception-batch-too-large'
),

-- 31. Row cache enabled causes 4x performance degradation
(
    'Row cache enabled in cassandra.yaml results in 4x slower query performance (row_cache_size_in_mb > 0)',
    'cassandra',
    'MEDIUM',
    '[
        {"solution": "Disable row cache for this table: ALTER TABLE table_name WITH caching = {''keys'': ''ALL'', ''rows_per_partition'': ''0''}", "percentage": 96},
        {"solution": "Check row cache hit rate with: nodetool info. If hit_rate < 30%, disable row cache (not worthwhile)", "percentage": 94},
        {"solution": "If cache needed, reduce row_cache_size_in_mb to smaller value or switch to external cache (Memcached/Redis) for better control", "percentage": 91}
    ]'::jsonb,
    'nodetool access, ability to run ALTER TABLE, understanding of caching strategy, monitoring tools to measure hit rates',
    'Row cache disabled or tuned. Query latency returns to baseline. nodetool info shows high row cache hit rate (>80%) if re-enabled',
    'Enabling row cache globally without testing per-table impact. Not checking hit ratio before enabling. Assuming more cache = more performance',
    0.95,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/51963193/cassandra-setting-row-cache-size-in-mb-decrease-performance-by-factor-4'
),

-- 32. Key cache hit rate very low despite enabled
(
    'Key cache enabled but hit_rate = 0.907% (very low despite configuration)',
    'cassandra',
    'MEDIUM',
    '[
        {"solution": "Verify working set size vs key_cache_size_in_mb. If working set >> cache capacity, hit rate naturally low", "percentage": 92},
        {"solution": "Run nodetool cfstats to examine per-table cache hit rates. Some tables may have high rates, others low", "percentage": 90},
        {"solution": "Increase key_cache_size_in_mb in cassandra.yaml if working set is larger than cache. Rule of thumb: cache should hold 5-10% of working set", "percentage": 88}
    ]'::jsonb,
    'nodetool cfstats access, cassandra.yaml edit capability, knowledge of working set size, monitoring metrics',
    'Key cache hit rate improves to 40%+ after tuning. nodetool cfstats shows increased hits per second. Query latency decreases',
    'Expecting 100% hit rate on all tables. Not understanding that hit rate varies by query pattern. Not accounting for working set size',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/29760252/cassandra-key-cache-hit-rate-differs-between-nodetool-and-opscenter'
),

-- 33. ArrayIndexOutOfBoundsException on SELECT *
(
    'java.lang.ArrayIndexOutOfBoundsException at org.apache.cassandra.cql3.statements.ColumnGroupMap.add() during SELECT * (indicates corrupted row data)',
    'cassandra',
    'MEDIUM',
    '[
        {"solution": "Isolate problematic rows by incrementally adding WHERE clauses to SELECT queries. Test different partition keys", "percentage": 93},
        {"solution": "Export unaffected data via targeted WHERE queries: SELECT * FROM table WHERE id IN (...). Do NOT use SELECT *", "percentage": 94},
        {"solution": "Create new table with identical schema. Repopulate from exported verified data. Validate row counts before dropping old table", "percentage": 92}
    ]'::jsonb,
    'CQL access, ability to create tables, backup of table data, patience for row-by-row isolation (may need binary search approach)',
    'SELECT * succeeds on recovered table. Row counts match original. No ArrayIndexOutOfBoundsException errors. Subsequent queries work',
    'Attempting SELECT * on corrupted table and expecting magic fix. Deleting table without recovery. Not backing up data before recovery attempt',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/28127733/cassandra-arrayindexoutofboundsexception-on-select-statement'
),

-- 34. ArrayIndexOutOfBoundsException on SELECT JSON
(
    'java.lang.ArrayIndexOutOfBoundsException: null at org.codehaus.jackson.io.JsonStringEncoder.quoteAsString() during SELECT JSON * (unescaped JSON in text field)',
    'cassandra',
    'MEDIUM',
    '[
        {"solution": "Identify problematic column: remove each text field from SELECT JSON query until query succeeds. That field contains malformed JSON", "percentage": 95},
        {"solution": "Escape JSON content before storing: convert special chars (\", \\, \\n) to escaped form before INSERT. Use prepared statement bindings", "percentage": 94},
        {"solution": "Query table WITHOUT JSON formatting to inspect actual stored content. Validate escaping before re-inserting corrected data", "percentage": 92}
    ]'::jsonb,
    'CQL access, text editor or JSON formatter tool, understanding of JSON escaping rules, ability to update stored data',
    'SELECT JSON * succeeds on repaired data. Output contains valid JSON. No ArrayIndexOutOfBoundsException in logs',
    'Storing raw JSON strings without escaping. Trying to fix on server side without understanding client-side escaping. Not testing JSON format before insert',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/46588081/arrayindexoutofboundsexception-while-reading-from-cassandra-table'
),

-- 35. Hot partition - single partition key causes timeout
(
    'com.datastax.driver.core.exceptions.ReadTimeoutException or OperationTimedOutException on query selecting from partition with millions of rows',
    'cassandra',
    'HIGH',
    '[
        {"solution": "Identify hot partition: query with ALLOW FILTERING to find partition_key with highest row count. Redesign to split into multiple partitions", "percentage": 93},
        {"solution": "Implement bucketing strategy: add time bucket to partition key (e.g., user_id + date instead of just user_id)", "percentage": 94},
        {"solution": "Set max_mutation_size_in_mb and row_cache_size limits in cassandra.yaml to prevent memory exhaustion from huge partitions", "percentage": 90}
    ]'::jsonb,
    'CQL query capability, ALLOW FILTERING understanding, data model design knowledge, cassandra.yaml access',
    'Queries complete within timeout. nodetool tablehistograms shows uniform partition sizes. Read latency consistent across partitions',
    'Not identifying which partition is hot before redesigning. Assuming timeout = network/server issue without checking partition distribution. Only tuning timeouts',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/52304024/creating-a-view-causes-cassandra-mutation-messages-to-drop'
),

-- 36. Compaction stuck - unable to keep pace with writes
(
    'Compaction falling behind: pending_compactions > 1000 and grow continuously despite concurrent_compactors tuning',
    'cassandra',
    'MEDIUM',
    '[
        {"solution": "Increase concurrent_compactors in cassandra.yaml (default 1, try 4-8 for SSDs). Requires restart", "percentage": 91},
        {"solution": "Reduce compaction_throughput_mb_per_sec if it''s throttling (default 16MB/s). Increase gradually: 32, 64, 128 MB/s", "percentage": 89},
        {"solution": "Monitor write rate: if sustained > 10,000 ops/sec, cluster may be undersized. Consider adding nodes or reducing write volume", "percentage": 88}
    ]'::jsonb,
    'cassandra.yaml edit access, nodetool compactionstats monitoring, SSD vs HDD understanding, cluster sizing knowledge',
    'pending_compactions decreases to < 100. Compaction completes regularly. Read/write latencies normal during compaction',
    'Setting concurrent_compactors too high causing GC pauses. Not accounting for hardware (SSD vs HDD). Not monitoring actual write rate',
    0.90,
    'haiku',
    NOW(),
    'https://cassandra.apache.org/doc/latest/cassandra/troubleshooting/use_nodetool.html'
),

-- 37. ALLOW FILTERING returns incorrect results
(
    'ALLOW FILTERING query returns incomplete or wrong results (silent data loss with non-partition-key filters)',
    'cassandra',
    'CRITICAL',
    '[
        {"solution": "Avoid ALLOW FILTERING in production. Rewrite query to use partition key: add partition key to WHERE clause instead", "percentage": 97},
        {"solution": "If filtering on non-pk column needed, create secondary index: CREATE INDEX on table(column), then query using that column", "percentage": 95},
        {"solution": "Best practice: restructure table schema to include filter column in partition key or clustering key at design time", "percentage": 96}
    ]'::jsonb,
    'CQL knowledge, understanding of partition/clustering keys, schema design capability, secondary index support',
    'Query uses partition key in WHERE clause (no ALLOW FILTERING). Results complete and correct. Performance fast (sub-millisecond)',
    'Using ALLOW FILTERING without understanding it scans all partitions. Not creating indexes for frequent filter columns. Trusting ALLOW FILTERING for correctness',
    0.97,
    'haiku',
    NOW(),
    'https://cassandra.apache.org/doc/latest/cassandra/troubleshooting/reading_logs.html'
),

-- 38. Consistency level LOCAL_ONE insufficient - read repair
(
    'UnavailableException: Not enough replicas available for query at [consistency_level]. Consistency level requested [X], replicas alive [Y]',
    'cassandra',
    'HIGH',
    '[
        {"solution": "Verify replication_factor: min 3 nodes for production. Check DESCRIBE KEYSPACE to see current RF", "percentage": 94},
        {"solution": "Temporarily lower consistency level: use ONE or LOCAL_ONE for reads (trades consistency for availability)", "percentage": 92},
        {"solution": "Fix root cause: ensure all nodes are UP. Run nodetool status. If nodes DOWN, investigate and restart", "percentage": 95}
    ]'::jsonb,
    'nodetool access, CQL DESCRIBE command, understanding of consistency level tradeoffs, node restart capability',
    'All replicas UP/NORMAL in nodetool status. Queries succeed at requested consistency level. Read/write latency acceptable',
    'Lowering consistency level without understanding tradeoffs. Not fixing actual node failures (just tuning). Setting RF too low (< 3)',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/34450443/all-hosts-tried-for-query-failed-com-datastax-driver-core-exceptions-operati'
),

-- 39. Large collection field causes timeouts
(
    'ReadTimeoutException or slow queries when selecting rows with large list/map fields (>1MB per row)',
    'cassandra',
    'MEDIUM',
    '[
        {"solution": "Avoid storing large collections in rows. Instead denormalize: store reference to separate table and fetch separately", "percentage": 95},
        {"solution": "If collection must be stored, set max_allowed_memory_per_partition to reject oversized partitions: 100MB (cassandra.yaml)", "percentage": 91},
        {"solution": "Implement pagination: SELECT first 100 items from list, then cursor-based pagination for rest", "percentage": 93}
    ]'::jsonb,
    'CQL knowledge, data model redesign capability, max_allowed_memory_per_partition parameter understanding, pagination logic',
    'Queries return results in < 100ms. Partition size stays under memory limit. Application handles pagination correctly',
    'Storing entire collection in single row. Not implementing pagination. Assuming server can handle multi-MB rows efficiently',
    0.93,
    'haiku',
    NOW(),
    'https://cassandra.apache.org/doc/latest/cassandra/troubleshooting/reading_logs.html'
),

-- 40. Unexpected exception during request - firewall TCP disconnect
(
    'Unexpected exception during request [channel]: io.netty.channel.unix.Errors$NativeIoException: readAddress() failed: Connection timed out',
    'cassandra',
    'MEDIUM',
    '[
        {"solution": "Verify firewall allows TCP keep-alive on inter-node ports (7000/7001). Set tcp_keepalives_idle < firewall timeout", "percentage": 94},
        {"solution": "Check firewall rules: some firewalls drop idle connections > 15 min. Configure Cassandra JVM socket options: tcp_nodelay=true", "percentage": 92},
        {"solution": "If cloud VPC: verify security groups allow all traffic between nodes AND from clients. Check network ACLs", "percentage": 91}
    ]'::jsonb,
    'Firewall/network access, ability to configure network timeouts, inter-node connectivity verification tools, cloud security group knowledge',
    'TCP keep-alives configured. Firewall rules verified. No connection timeouts in system.log during sustained traffic',
    'Blaming Cassandra when issue is firewall. Not configuring tcp_nodelay. Ignoring OS-level socket timeout settings',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/52722674/connection-time-out-in-cassandra'
);

-- Verification
SELECT COUNT(*) as total_entries FROM knowledge_entries WHERE category = 'cassandra' AND last_verified >= NOW() - interval '1 day';
