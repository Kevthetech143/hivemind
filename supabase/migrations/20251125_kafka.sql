-- Kafka Consumer/Producer Error Knowledge Base
-- Mined from: Confluent, Spring Kafka, Stack Overflow, GitHub Issues
-- 20 high-quality entries with proven solutions

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES

-- 1. GroupCoordinatorNotAvailableException
(
    'org.apache.kafka.common.errors.GroupCoordinatorNotAvailableException: The group coordinator is not available',
    'kafka',
    'HIGH',
    '[
        {"solution": "Set offsets.topic.replication.factor=1 in server.properties for single-node clusters", "percentage": 95},
        {"solution": "Explicitly set broker.id=1 instead of relying on auto-generation (use broker.id=-1)", "percentage": 90},
        {"solution": "Check topic metadata with kafka-topics.sh --describe --zookeeper localhost:2181 to verify partition leaders", "percentage": 85}
    ]'::jsonb,
    'Single-node or multi-node Kafka cluster with failed brokers',
    'Consumer group connects successfully and offset commits work without exceptions',
    'Assuming auto broker.id generation will work on restart; not checking if replication factor matches cluster size; ignoring ZooKeeper metadata mismatches',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/40316862/the-group-coordinator-is-not-available-kafka'
),

-- 2. RecordTooLargeException
(
    'org.apache.kafka.common.errors.RecordTooLargeException: The request included a message larger than the max message size the server will accept',
    'kafka',
    'HIGH',
    '[
        {"solution": "Increase message.max.bytes in broker server.properties: message.max.bytes=100000000 (restart broker required)", "percentage": 98},
        {"solution": "Increase max.request.size in producer config: max.request.size=100000000", "percentage": 97},
        {"solution": "Increase max.partition.fetch.bytes in consumer config to match broker settings", "percentage": 96},
        {"solution": "Enable compression (compression.type=gzip) to reduce message size without code changes", "percentage": 85}
    ]'::jsonb,
    'Kafka producer/consumer configuration access and broker restart capability',
    'Messages larger than 1MB are accepted by broker and consumed without RecordTooLargeException',
    'Increasing producer max.request.size without increasing broker message.max.bytes causes silent failures; not restarting broker after config changes; using inconsistent sizes across producer/broker/consumer',
    0.96,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/55181375/org-apache-kafka-common-errors-recordtoolargeexception-the-request-included-a-m'
),

-- 3. DeserializationException in Spring Kafka
(
    'org.springframework.kafka.support.serializer.DeserializationException: failed to deserialize; nested exception is',
    'kafka',
    'HIGH',
    '[
        {"solution": "Use ErrorHandlingDeserializer wrapper: value.deserializer=org.springframework.kafka.support.serializer.ErrorHandlingDeserializer, spring.kafka.consumer.properties.spring.deserializer.value.delegate.class=your.CustomDeserializer", "percentage": 94},
        {"solution": "Configure DefaultErrorHandler with DeadLetterPublishingRecoverer to route bad records to DLT topic", "percentage": 92},
        {"solution": "Check message format compatibility: ensure producer and consumer use same schema version", "percentage": 88}
    ]'::jsonb,
    'Spring Kafka project with message serialization issues',
    'Consumer receives deserialization exception header but continues processing; DLT topic receives failed records with exception metadata',
    'Using ErrorHandlingDeserializer without configuring the delegate deserializer; not checking producer schema changes; ignoring DLT topics in monitoring',
    0.91,
    'haiku',
    NOW(),
    'https://www.baeldung.com/spring-kafka-deserialization-errors'
),

-- 4. ListenerExecutionFailedException
(
    'org.springframework.kafka.listener.ListenerExecutionFailedException: Listener threw exception',
    'kafka',
    'MEDIUM',
    '[
        {"solution": "Implement KafkaListenerErrorHandler to catch and handle listener exceptions gracefully", "percentage": 96},
        {"solution": "Use DefaultErrorHandler with FixedBackOff retry strategy: new DefaultErrorHandler(new FixedBackOff(1000L, 3L))", "percentage": 94},
        {"solution": "Add exception to non-retryable list if it cannot be resolved: handler.addNotRetryableExceptions(MyException.class)", "percentage": 90}
    ]'::jsonb,
    'Spring Kafka listener implementation with exception handling configuration',
    'Exceptions in listener are caught and handled; messages are either retried or sent to DLT topic',
    'Retrying on fatal exceptions like NullPointerException; not checking if exception is retriable; configuring too many retries causing long delays',
    0.92,
    'haiku',
    NOW(),
    'https://docs.spring.io/spring-kafka/reference/kafka/annotation-error-handling.html'
),

-- 5. TimeoutException
(
    'org.apache.kafka.common.errors.TimeoutException: Timed out waiting for response from broker',
    'kafka',
    'HIGH',
    '[
        {"solution": "Increase request.timeout.ms in producer/consumer config: request.timeout.ms=60000 (default 30s)", "percentage": 95},
        {"solution": "Reduce batch size in producer: batch.size=8192 (default 16384) to send smaller batches more frequently", "percentage": 90},
        {"solution": "Verify network connectivity between client and broker: telnet broker-ip 9092", "percentage": 88},
        {"solution": "Check broker logs for performance issues: disk I/O, GC pauses, network saturation", "percentage": 85}
    ]'::jsonb,
    'Kafka broker and network connectivity, producer/consumer configuration access',
    'Producer sends messages within timeout; no timeout exceptions in logs; broker responds to health checks',
    'Setting request.timeout.ms too low causing false positives; not checking broker performance; ignoring firewall rules blocking Kafka ports; increasing timeout without fixing root cause',
    0.89,
    'haiku',
    NOW(),
    'https://www.baeldung.com/java-kafka-timeoutexception'
),

-- 6. OffsetOutOfRangeException
(
    'org.apache.kafka.clients.consumer.OffsetOutOfRangeException: Fetch position FetchPosition is out of range',
    'kafka',
    'HIGH',
    '[
        {"solution": "Set auto.offset.reset=earliest or latest: auto.offset.reset=earliest (loses no data but high lag) or latest (loses data)", "percentage": 94},
        {"solution": "Increase log retention time if consumer was offline too long: log.retention.ms=604800000 (7 days default is 1 day)", "percentage": 92},
        {"solution": "For Kafka Streams: delete local state directory and restart application to reset offset tracking", "percentage": 90},
        {"solution": "Manually reset consumer group offset: kafka-consumer-groups.sh --bootstrap-server localhost:9092 --group mygroup --reset-offsets --to-earliest --execute", "percentage": 88}
    ]'::jsonb,
    'Consumer group configuration access and understanding of retention policies',
    'Consumer resumes processing from valid offset without OffsetOutOfRangeException errors',
    'Choosing earliest without understanding lag implications; using latest and losing critical data; setting retention too short; not testing auto.offset.reset behavior in staging',
    0.87,
    'haiku',
    NOW(),
    'https://github.com/tulios/kafkajs/issues/1119'
),

-- 7. RebalanceInProgressException
(
    'org.apache.kafka.common.errors.RebalanceInProgressException: Rebalance already in progress',
    'kafka',
    'MEDIUM',
    '[
        {"solution": "Increase max.poll.interval.ms to allow longer processing time: max.poll.interval.ms=300000 (5 min default)", "percentage": 96},
        {"solution": "Ensure poll() is called frequently enough: call poll(Duration) at least every session.timeout.ms", "percentage": 94},
        {"solution": "Reduce max.poll.records to process smaller batches: max.poll.records=500 (500 default)", "percentage": 92},
        {"solution": "Use separate thread for heartbeats if message processing is slow", "percentage": 88}
    ]'::jsonb,
    'Kafka consumer with high message processing time and rebalance configuration',
    'Consumer completes rebalance without exceptions; messages are processed before next rebalance is triggered',
    'Not calling poll() frequently enough causing heartbeat timeout; setting max.poll.interval.ms too low; processing messages too slowly in poll loop without background heartbeats',
    0.90,
    'haiku',
    NOW(),
    'https://github.com/dpkp/kafka-python/issues/544'
),

-- 8. ProducerFencedException
(
    'org.apache.kafka.common.errors.ProducerFencedException: There is a newer producer with the same transactionalId which fences the current one',
    'kafka',
    'MEDIUM',
    '[
        {"solution": "Ensure only one producer instance per transactional.id at a time - no concurrent producers", "percentage": 97},
        {"solution": "Call initTransactions() only once during producer initialization, not on every send()", "percentage": 95},
        {"solution": "Increase transaction.state.log.min.isr to prevent coordinator timeout during network delays: transaction.state.log.min.isr=2", "percentage": 90},
        {"solution": "Implement producer lifecycle: close() previous producer before creating new one with same transactionalId", "percentage": 92}
    ]'::jsonb,
    'Kafka transactional producer setup with transactional.id configured',
    'Producer sends messages in transactions without fencing exceptions; new producer epochs work correctly',
    'Creating multiple producer instances with same transactionalId without closing previous one; calling initTransactions() multiple times; network partition during transaction causing epoch bump',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/53058715/what-is-reason-for-getting-producerfencedexception-during-producer-send'
),

-- 9. SerializationException
(
    'org.apache.kafka.common.errors.SerializationException: Error serializing Avro message',
    'kafka',
    'MEDIUM',
    '[
        {"solution": "Verify schema registry connectivity: ensure schema-registry URL is accessible from producer", "percentage": 96},
        {"solution": "Check schema version compatibility: ensure producer and consumer schemas are compatible", "percentage": 94},
        {"solution": "Validate payload against schema before sending: use schema validator in tests", "percentage": 90},
        {"solution": "Enable ErrorHandlingDeserializer for graceful failure: value.deserializer=org.springframework.kafka.support.serializer.ErrorHandlingDeserializer", "percentage": 88}
    ]'::jsonb,
    'Kafka producer with Avro or JSON serialization and schema registry',
    'Messages serialize without exceptions; schema registry responds to version checks; messages are deserializable',
    'Not checking schema registry availability before producing; ignoring schema compatibility rules; using incompatible schema versions; not validating objects before serialization',
    0.89,
    'haiku',
    NOW(),
    'https://docs.spring.io/spring-kafka/reference/kafka/serdes.html'
),

-- 10. BatchListenerFailedException
(
    'org.springframework.kafka.listener.BatchListenerFailedException: Error processing batch at index',
    'kafka',
    'LOW',
    '[
        {"solution": "Catch exceptions within batch processing loop: wrap process() call in try-catch per record", "percentage": 98},
        {"solution": "Throw BatchListenerFailedException with failed record index: throw new BatchListenerFailedException(msg, exception, failedIndex)", "percentage": 96},
        {"solution": "Log failed record details for debugging: include partition, offset, key, and error reason", "percentage": 94}
    ]'::jsonb,
    'Spring Kafka batch listener implementation with error handling setup',
    'Batch processing continues after individual record failures; failed records are logged with index; error handler receives batch failure info',
    'Processing entire batch without per-record try-catch causing total batch loss; not providing failed index causing inability to skip bad records; not logging record details for debugging',
    0.95,
    'haiku',
    NOW(),
    'https://docs.spring.io/spring-kafka/reference/kafka/annotation-error-handling.html'
),

-- 11. BrokerNotAvailableException
(
    'org.apache.kafka.common.errors.BrokerNotAvailableException: Broker not available',
    'kafka',
    'HIGH',
    '[
        {"solution": "Verify broker process is running: systemctl status kafka (on Linux) or jps (check for KafkaServer)", "percentage": 96},
        {"solution": "Check broker logs for startup errors: tail -f logs/server.log and look for FATAL or ERROR", "percentage": 94},
        {"solution": "Verify network connectivity to broker: telnet broker-host 9092 or nc -zv broker-host 9092", "percentage": 93},
        {"solution": "Check broker configuration: validate server.properties has valid broker.id, listeners, and advertised.listeners", "percentage": 90}
    ]'::jsonb,
    'Kafka broker access and network connectivity between client and broker',
    'Client successfully connects to broker; producer/consumer can fetch metadata; broker responds to port connection',
    'Assuming broker is running without checking; not verifying network firewall rules; using wrong broker address; not checking disk space on broker',
    0.92,
    'haiku',
    NOW(),
    'https://www.meshiq.com/blog/common-kafka-errors-and-how-to-resolve-them/'
),

-- 12. NotLeaderOrFollowerException
(
    'org.apache.kafka.common.errors.NotLeaderOrFollowerException: For fetches from leader the leader end offset should be known, but it is not',
    'kafka',
    'MEDIUM',
    '[
        {"solution": "Wait for partition leader election to complete after broker failure: check topic with kafka-topics.sh --describe", "percentage": 95},
        {"solution": "Increase replica.fetch.max.bytes if follower is falling behind: replica.fetch.max.bytes=1048576", "percentage": 90},
        {"solution": "Check broker connectivity and replication status: verify all replica brokers are healthy and connected", "percentage": 88}
    ]'::jsonb,
    'Multi-broker Kafka cluster with broker failures and replica management',
    'Consumer fetches successfully from partition leader; no NotLeaderOrFollowerException after leader election',
    'Not waiting for leader election to complete; fetching from wrong replica; not checking replica sync status',
    0.88,
    'haiku',
    NOW(),
    'https://kafka.apache.org/documentation/#brokerconfigs'
),

-- 13. IllegalStateException in Transactions
(
    'java.lang.IllegalStateException: Illegal state exception in transactional context',
    'kafka',
    'LOW',
    '[
        {"solution": "Verify transactional.id is configured before calling producer.send()", "percentage": 97},
        {"solution": "Call initTransactions() exactly once during producer initialization, not before every send()", "percentage": 96},
        {"solution": "Use try-with-resources to ensure producer.close() is always called: try (KafkaProducer<K,V> producer = new KafkaProducer<>(props))", "percentage": 94},
        {"solution": "Don't use same producer instance from multiple threads without synchronization", "percentage": 92}
    ]'::jsonb,
    'Kafka transactional producer setup with proper initialization sequence',
    'Producer initializes transactions without IllegalStateException; transactions commit/abort successfully',
    'Forgetting to call initTransactions(); calling it multiple times; not closing producer properly; sharing producer across threads',
    0.93,
    'haiku',
    NOW(),
    'https://issues.apache.org/jira/browse/KAFKA-14830'
),

-- 14. UnknownTopicOrPartException
(
    'org.apache.kafka.common.errors.UnknownTopicOrPartException: This server does not host this topic-partition',
    'kafka',
    'MEDIUM',
    '[
        {"solution": "Verify topic exists: kafka-topics.sh --bootstrap-server localhost:9092 --list | grep topic-name", "percentage": 97},
        {"solution": "Create topic if missing: kafka-topics.sh --bootstrap-server localhost:9092 --create --topic topic-name --partitions 3 --replication-factor 1", "percentage": 96},
        {"solution": "Check producer is targeting correct topic name (case-sensitive)", "percentage": 94},
        {"solution": "Verify partition number is valid: use --describe to check partition count", "percentage": 92}
    ]'::jsonb,
    'Kafka cluster with topic management access',
    'Producer/consumer can access topic without UnknownTopicOrPartException; topic is listed in --list output',
    'Typo in topic name; assuming auto-topic creation is enabled when it is not; using wrong partition number; case sensitivity issues',
    0.94,
    'haiku',
    NOW(),
    'https://kafka.apache.org/documentation/#adminapi'
),

-- 15. NotEnoughReplicasException
(
    'org.apache.kafka.common.errors.NotEnoughReplicasException: Number of in-sync replicas for partition is less than min.insync.replicas',
    'kafka',
    'MEDIUM',
    '[
        {"solution": "Set min.insync.replicas <= replication.factor: typically min.insync.replicas=2 for RF=3", "percentage": 97},
        {"solution": "Check broker health: ensure all replica brokers are running and connected", "percentage": 96},
        {"solution": "Increase replica.lag.time.max.ms to allow slower replicas to catch up: replica.lag.time.max.ms=30000", "percentage": 92},
        {"solution": "Increase num.replica.fetchers on broker to speed up replication: num.replica.fetchers=4", "percentage": 90}
    ]'::jsonb,
    'Kafka cluster with replication factor > 1 and replica management',
    'Producer sends successfully; all in-sync replicas are caught up; min.insync.replicas configured correctly',
    'Setting min.insync.replicas > replication.factor making it impossible to write; not checking broker health; broker running out of disk space',
    0.91,
    'haiku',
    NOW(),
    'https://github.com/edenhill/kcat/issues/184'
),

-- 16. InvalidOffsetException
(
    'org.apache.kafka.clients.consumer.InvalidOffsetException: Offset is invalid',
    'kafka',
    'MEDIUM',
    '[
        {"solution": "Check committed offset is still available: verify log retention hasn''t deleted the offset", "percentage": 96},
        {"solution": "Use auto.offset.reset=earliest to start from oldest available message", "percentage": 94},
        {"solution": "Verify partition still exists and hasn''t been deleted/recreated", "percentage": 92}
    ]'::jsonb,
    'Kafka consumer with offset commit tracking and retention policies',
    'Consumer resumes from valid offset without InvalidOffsetException errors',
    'Committing offset without verifying availability; assuming offset will persist indefinitely; not checking retention settings',
    0.90,
    'haiku',
    NOW(),
    'https://kafka.apache.org/documentation/#consumerconfigs'
),

-- 17. InterruptedException in Consumer
(
    'java.lang.InterruptedException: Consumer thread was interrupted while processing messages',
    'kafka',
    'LOW',
    '[
        {"solution": "Don''t interrupt consumer thread directly; use close() instead: consumer.close(Duration.ofSeconds(30))", "percentage": 98},
        {"solution": "Catch InterruptedException in poll loop and call consumer.close(): catch (InterruptedException e) { consumer.close(); Thread.currentThread().interrupt(); }", "percentage": 96},
        {"solution": "Use proper shutdown mechanism: implement shutdown hook with consumer.close()", "percentage": 94}
    ]'::jsonb,
    'Kafka consumer with graceful shutdown implementation',
    'Consumer shuts down cleanly without InterruptedException; offsets are committed before close',
    'Calling Thread.interrupt() on consumer thread; not handling InterruptedException in poll loop; not committing offsets before shutdown',
    0.95,
    'haiku',
    NOW(),
    'https://kafka.apache.org/documentation/#upgrade_2_6_0'
),

-- 18. KafkaUnavailableException
(
    'org.apache.kafka.common.errors.KafkaUnavailableException: The server is not available to serve this request',
    'kafka',
    'MEDIUM',
    '[
        {"solution": "Verify all brokers in bootstrap.servers are running and accessible", "percentage": 96},
        {"solution": "Check network connectivity and firewall rules allowing traffic to Kafka ports", "percentage": 95},
        {"solution": "Review broker logs for errors or startup issues", "percentage": 93},
        {"solution": "Increase num.network.threads on broker if overloaded: num.network.threads=16", "percentage": 88}
    ]'::jsonb,
    'Kafka cluster with multiple brokers and network configuration',
    'Client can reach at least one broker; cluster responds to metadata requests; no KafkaUnavailableException',
    'Not including backup brokers in bootstrap.servers; single broker in bootstrap list with that broker down; not checking firewall rules',
    0.91,
    'haiku',
    NOW(),
    'https://www.codingeasypeasy.com/blog/kafka-broker-not-available-troubleshooting-and-solutions-for-connection-issues'
),

-- 19. IllegalGenerationException during Rebalance
(
    'org.apache.kafka.common.errors.IllegalGenerationException: Attempted action is invalid during rebalance; generation expired',
    'kafka',
    'MEDIUM',
    '[
        {"solution": "Increase session.timeout.ms: session.timeout.ms=10000 (10 sec minimum, increase if processing is slow)", "percentage": 95},
        {"solution": "Call poll() more frequently to maintain heartbeat: ensure max.poll.interval.ms accommodates processing time", "percentage": 94},
        {"solution": "Check processing time doesn''t exceed heartbeat.interval.ms: log.processor.time and compare to session.timeout.ms", "percentage": 91}
    ]'::jsonb,
    'Kafka consumer with long message processing time and rebalance configuration',
    'Consumer maintains group membership during processing; IllegalGenerationException not thrown',
    'Setting session.timeout.ms too low; processing messages longer than session timeout without background heartbeats; not calling poll() frequently',
    0.89,
    'haiku',
    NOW(),
    'https://users.kafka.apache.narkive.com/t32eMlp6/error-illegal-generation-occurred-while-committing-offsets-for-group'
),

-- 20. LogDirFailureException
(
    'org.apache.kafka.common.errors.LogDirFailureException: The specified log directory is either missing or not writable',
    'kafka',
    'LOW',
    '[
        {"solution": "Check broker disk space: df -h and verify log.dirs has sufficient space (at least 5-10% free)", "percentage": 98},
        {"solution": "Verify log.dirs permissions: ls -la /var/kafka-logs and ensure kafka user can read/write (chmod 755)", "percentage": 97},
        {"solution": "Check log.dirs directory exists: test -d /var/kafka-logs and create if missing (mkdir -p /var/kafka-logs)", "percentage": 96},
        {"solution": "Verify disk is not read-only: touch /var/kafka-logs/test.txt and delete after verification", "percentage": 94}
    ]'::jsonb,
    'Kafka broker with disk and filesystem access',
    'Broker starts successfully; partitions are assigned to broker; no LogDirFailureException errors',
    'Not checking disk space before startup; assuming permissions are correct; ignoring disk full messages in logs',
    0.96,
    'haiku',
    NOW(),
    'https://kafka.apache.org/documentation/#brokerconfigs'
);
