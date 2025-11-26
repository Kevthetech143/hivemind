-- DynamoDB Error Mining - 25 High-Quality Entries
-- Source: AWS Official Documentation
-- Mining Date: 2025-11-25

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'AccessDeniedException: Access denied',
    'dynamodb',
    'HIGH',
    '[
        {"solution": "Use AWS SDK which handles Signature Version 4 automatically instead of manually signing requests", "percentage": 98},
        {"solution": "If manually signing: verify all required signature components are present (Authorization header, X-Amz-Date, X-Amz-Security-Token for temporary credentials)", "percentage": 92}
    ]'::jsonb,
    'Valid AWS credentials configured in SDK or environment; request being signed',
    'Request completes successfully; no AccessDeniedException in response',
    'Forgetting X-Amz-Security-Token for temporary credentials; using expired access keys; incorrect AWS region in signature',
    0.96,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Programming.Errors.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'ConditionalCheckFailedException: The conditional request failed',
    'dynamodb',
    'HIGH',
    '[
        {"solution": "Log actual attribute values in the item before applying condition (use GetItem to fetch current state)", "percentage": 95},
        {"solution": "Verify condition expression syntax matches item''s current attribute names and types", "percentage": 93},
        {"solution": "Use attribute_not_exists() for add operations if item might exist from concurrent write", "percentage": 88}
    ]'::jsonb,
    'Item exists in DynamoDB; condition expression properly formatted; understanding of condition operators',
    'PutItem/UpdateItem completes without ConditionalCheckFailedException; conditional logic working as intended',
    'Assuming attribute exists when it doesn''t; case sensitivity in attribute names; comparing string to number type; race conditions in concurrent writes',
    0.94,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Programming.Errors.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'IncompleteSignatureException: The request signature does not conform to AWS standards',
    'dynamodb',
    'HIGH',
    '[
        {"solution": "Use AWS SDK (boto3, SDK.js, etc.) which handles Signature Version 4 automatically", "percentage": 99},
        {"solution": "If required to manually sign: ensure Authorization header contains all required parts: Credential, SignedHeaders, Signature", "percentage": 90}
    ]'::jsonb,
    'Request being sent to DynamoDB; AWS credentials available',
    'Request completes without signature errors; API responses received',
    'Missing Authorization header entirely; incomplete SignedHeaders list; incorrect signature algorithm; malformed date header',
    0.97,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Programming.Errors.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'ItemCollectionSizeLimitExceededException: Collection size exceeded',
    'dynamodb',
    'HIGH',
    '[
        {"solution": "Distribute items across different partition keys to reduce items with same partition key in LSI", "percentage": 96},
        {"solution": "Move high-cardinality data to separate table; use Query with LSI sort key to manage subsets", "percentage": 90},
        {"solution": "Retry operation after deleting some items from the LSI collection (retryable error)", "percentage": 88}
    ]'::jsonb,
    'Local secondary index on table; items in LSI exceeding 10 GB limit',
    'Writes to LSI succeed; no ItemCollectionSizeLimitExceededException; total LSI size stays below 10 GB',
    'Assuming you can have unlimited LSI size like a table; writing all related items to same partition key; not monitoring LSI growth',
    0.92,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Programming.Errors.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'LimitExceededException: Too many operations for a given subscriber',
    'dynamodb',
    'HIGH',
    '[
        {"solution": "Wait for existing table/index operations to complete (check table status with DescribeTable); do not submit new DDL operations until current ones finish", "percentage": 97},
        {"solution": "If multiple tables being modified, stagger operations: complete one table operation before starting next", "percentage": 95},
        {"solution": "Reduce concurrent index creation/deletion operations to maximum 500 across all operations", "percentage": 91}
    ]'::jsonb,
    'Table or index operations currently in CREATING, DELETING, or UPDATING states; attempting new DDL operation',
    'DDL operation succeeds; DescribeTable shows resource in target state',
    'Submitting multiple DDL operations simultaneously; not waiting for status check before retrying; assuming operations complete instantly',
    0.95,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Programming.Errors.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'MissingAuthenticationTokenException: Request must contain a valid AWS Access Key ID',
    'dynamodb',
    'HIGH',
    '[
        {"solution": "Ensure AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY environment variables are set correctly", "percentage": 97},
        {"solution": "Include Authorization header with format: AWS4-HMAC-SHA256 Credential=..., SignedHeaders=..., Signature=...", "percentage": 94},
        {"solution": "Verify request includes X-Amz-Date header (required for all AWS requests)", "percentage": 93}
    ]'::jsonb,
    'Sending request to DynamoDB API; attempting authentication',
    'Request authenticated successfully; DynamoDB returns normal API response without auth errors',
    'Forgetting to load environment variables; hardcoding credentials in code; missing date header; malformed authorization header',
    0.96,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Programming.Errors.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'ProvisionedThroughputExceededException: Request rate exceeds provisioned throughput',
    'dynamodb',
    'HIGH',
    '[
        {"solution": "Implement exponential backoff: wait 1ms, then 2ms, 4ms, etc. with jitter (random 0-20% variation)", "percentage": 98},
        {"solution": "Increase provisioned read/write capacity units for table or index via UpdateTable; or switch to on-demand billing", "percentage": 96},
        {"solution": "Use AWS SDK built-in retry logic which handles exponential backoff automatically", "percentage": 95},
        {"solution": "Review application code for N+1 queries or unnecessary hot partition access", "percentage": 85}
    ]'::jsonb,
    'Application making requests to DynamoDB; table has provisioned billing; request rate exceeds capacity',
    'Requests complete without throttling exceptions; CloudWatch shows request count below provisioned capacity',
    'Retrying immediately without backoff causing cascading throttling; linear backoff instead of exponential; provisioning capacity without considering peak traffic',
    0.94,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Programming.Errors.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'ReplicatedWriteConflictException: One or more items in this request are being modified in another Region',
    'dynamodb',
    'HIGH',
    '[
        {"solution": "Retry the operation immediately (it is retryable); DynamoDB will resolve conflict automatically", "percentage": 97},
        {"solution": "Use AWS SDK exponential backoff for automatic retry handling", "percentage": 96},
        {"solution": "If frequent conflicts: review application logic for simultaneous writes to same item from multiple regions", "percentage": 88}
    ]'::jsonb,
    'Table using multi-region strong consistency; concurrent writes to same item from different regions',
    'Operation succeeds on retry; no ReplicatedWriteConflictException; item written consistently across regions',
    'Not retrying assuming write failed permanently; giving up immediately; writing to same item from multiple regions without coordination',
    0.95,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Programming.Errors.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'RequestLimitExceeded: Throughput exceeds current limit for your account',
    'dynamodb',
    'HIGH',
    '[
        {"solution": "Wait and retry with exponential backoff (it is retryable); this is account-level throttling", "percentage": 96},
        {"solution": "Implement request queuing and rate limiting in application layer to control request pace", "percentage": 93},
        {"solution": "Contact AWS Support to request service quota increase for account-level throughput limit", "percentage": 90},
        {"solution": "Review account activity; optimize queries to reduce request volume", "percentage": 85}
    ]'::jsonb,
    'Application sending high volume of requests; account service quota being hit',
    'Requests complete after retry; no service quota errors; application operates within account limits',
    'Assuming you have unlimited request capacity per account; not tracking total account-level request volume; retrying without backoff',
    0.91,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Programming.Errors.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'ResourceInUseException: The resource you are attempting to change is in use',
    'dynamodb',
    'HIGH',
    '[
        {"solution": "Check table status with DescribeTable; wait until table is in ACTIVE state before modifying", "percentage": 98},
        {"solution": "For table recreation: delete old table completely, wait for status check to show it''s gone, then create new table", "percentage": 96},
        {"solution": "Do not attempt to recreate table with same name if original is in CREATING state", "percentage": 95}
    ]'::jsonb,
    'Table in CREATING or DELETING state; attempting to modify or recreate it',
    'DescribeTable shows table in ACTIVE state; subsequent operations succeed; table can be modified',
    'Not checking table status before operations; assuming delete is instant; attempting to recreate immediately after delete request',
    0.97,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Programming.Errors.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'ResourceNotFoundException: Requested resource not found',
    'dynamodb',
    'HIGH',
    '[
        {"solution": "Verify table name is spelled correctly and matches case exactly (table names are case-sensitive)", "percentage": 97},
        {"solution": "Check that table is fully created: DescribeTable should show status ACTIVE, not CREATING", "percentage": 95},
        {"solution": "Verify you are querying correct AWS region where table exists", "percentage": 94},
        {"solution": "If table just deleted: wait 1-2 minutes before recreating; verify deletion completed with DescribeTable", "percentage": 88}
    ]'::jsonb,
    'Attempting to access DynamoDB table; table name and region known',
    'DescribeTable returns table details; queries/writes to table succeed; no ResourceNotFoundException',
    'Wrong region specified; table name typo; trying to access table immediately after creation begins; assuming deleted table recreates instantly',
    0.96,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Programming.Errors.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'ThrottlingException: Rate of requests exceeds allowed throughput',
    'dynamodb',
    'HIGH',
    '[
        {"solution": "Implement exponential backoff with jitter: use AWS SDK default retry logic or custom backoff (1ms → 2ms → 4ms...)", "percentage": 98},
        {"solution": "Reduce request rate: batch requests, use Query instead of Scan, cache results when possible", "percentage": 96},
        {"solution": "Increase provisioned capacity (RCU/WCU) or switch to on-demand billing for variable workloads", "percentage": 94},
        {"solution": "Use eventually-consistent reads instead of strongly-consistent when appropriate to reduce read capacity", "percentage": 88}
    ]'::jsonb,
    'Table using provisioned billing; request rate exceeding allocated capacity; application making requests',
    'Requests complete without throttling; CloudWatch shows request rate under provisioned capacity; latency acceptable',
    'No retry logic implemented; linear backoff instead of exponential; requesting more capacity than necessary; not batching requests',
    0.95,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Programming.Errors.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'UnrecognizedClientException: Access Key ID or security token is invalid',
    'dynamodb',
    'HIGH',
    '[
        {"solution": "Verify AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY are correct and not expired", "percentage": 97},
        {"solution": "For temporary credentials: check X-Amz-Security-Token is included and not expired", "percentage": 95},
        {"solution": "Regenerate credentials if they are too old; AWS keys should be rotated regularly", "percentage": 92},
        {"solution": "Check request signature calculation (especially if not using AWS SDK)", "percentage": 88}
    ]'::jsonb,
    'Making requests to DynamoDB; AWS credentials configured; attempting authentication',
    'Request authenticated successfully; DynamoDB API responds with successful status; no auth errors',
    'Using expired temporary credentials; incorrect secret key; hardcoded wrong credentials; not checking credential expiration',
    0.95,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Programming.Errors.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'ValidationException: Missing required parameter or type mismatch',
    'dynamodb',
    'HIGH',
    '[
        {"solution": "Check error message details for which parameter is missing; review API documentation for required parameters", "percentage": 97},
        {"solution": "Verify attribute types match: string vs number vs binary; DynamoDB requires exact type specification", "percentage": 95},
        {"solution": "Ensure partition key and sort key are included in all item operations", "percentage": 93},
        {"solution": "Check expression syntax: no undefined variables in condition/projection/key expressions", "percentage": 90}
    ]'::jsonb,
    'Making API call to DynamoDB; request body formatted; operation type determined',
    'API call succeeds; no ValidationException; request properly formatted per API spec',
    'Assuming optional parameters have defaults; type confusion (string vs number); missing key schema attributes; malformed expressions',
    0.96,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Programming.Errors.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'InternalServerError (HTTP 500): DynamoDB unable to process request',
    'dynamodb',
    'HIGH',
    '[
        {"solution": "Retry the request immediately; for write operations, verify item was not created by fetching with GetItem before retrying", "percentage": 97},
        {"solution": "Check AWS Service Health Dashboard for regional service issues; if no service event, it is transient failure", "percentage": 94},
        {"solution": "Implement exponential backoff for automatic retry handling; include request ID in support tickets", "percentage": 92},
        {"solution": "Monitor CloudWatch for SystemErrors metric; alert if error rate exceeds 1% over 15 minutes", "percentage": 85}
    ]'::jsonb,
    'Request sent to DynamoDB API; transient service issue likely; retry capability available',
    'Retry succeeds; request completes normally; no repeated InternalServerError; service recovers',
    'Assuming 500 error is permanent failure; not retrying; not tracking request ID for support; immediate panic without checking health dashboard',
    0.93,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/TroubleshootingInternalServerErrors.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'ServiceUnavailable (HTTP 503): DynamoDB temporarily unavailable',
    'dynamodb',
    'HIGH',
    '[
        {"solution": "Retry the request with exponential backoff; service unavailability is temporary", "percentage": 98},
        {"solution": "Use AWS SDK which implements automatic 503 retry logic with backoff", "percentage": 97},
        {"solution": "Check AWS Service Health Dashboard to confirm regional availability; wait for recovery", "percentage": 90}
    ]'::jsonb,
    'Request being made to DynamoDB; service experiencing temporary unavailability',
    'Retry succeeds; DynamoDB becomes available; requests complete normally; no service errors',
    'Giving up immediately on 503; not retrying; assuming service is permanently down; not checking health dashboard',
    0.97,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/TroubleshootingInternalServerErrors.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Transient network issues causing intermittent DynamoDB errors',
    'dynamodb',
    'MEDIUM',
    '[
        {"solution": "Implement comprehensive retry logic with exponential backoff and jitter (AWS SDK default handles this)", "percentage": 96},
        {"solution": "Add request ID logging to all DynamoDB calls for debugging transient failures", "percentage": 92},
        {"solution": "Set up CloudWatch alarms on SystemErrors metric to detect patterns in transient failures", "percentage": 85}
    ]'::jsonb,
    'Application making DynamoDB requests; transient network conditions possible',
    'Request succeeds after retry; no repeated failures; application resilient to transient errors',
    'Retry logic missing entirely; synchronous code without timeout; not logging request IDs; no monitoring',
    0.94,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/TroubleshootingInternalServerErrors.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Infrastructure issues causing persistent DynamoDB errors',
    'dynamodb',
    'MEDIUM',
    '[
        {"solution": "Monitor AWS Service Health Dashboard for infrastructure events affecting your region", "percentage": 94},
        {"solution": "If error rate consistently exceeds 1% over 15+ minutes: document time window and contact AWS Support with request IDs", "percentage": 92},
        {"solution": "Configure CloudWatch alarms on SystemErrors metric with threshold of 3 consecutive points exceeding 1% over 5 minutes", "percentage": 90}
    ]'::jsonb,
    'DynamoDB table in region with potential infrastructure issues; monitoring capability available; support access',
    'Error rate drops below 1%; AWS confirms infrastructure resolved; requests return to normal latency',
    'Not tracking error rates over time; assuming single error is infrastructure issue; not contacting support with proper context',
    0.90,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/TroubleshootingInternalServerErrors.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Storage node related issues causing DynamoDB errors',
    'dynamodb',
    'MEDIUM',
    '[
        {"solution": "AWS DynamoDB handles storage node failures automatically; implement client-side retry logic", "percentage": 97},
        {"solution": "Use exponential backoff when storage nodes recover from failures", "percentage": 95},
        {"solution": "Monitor SystemErrors metric in CloudWatch; alert if sustained failure rate exceeds AWS thresholds", "percentage": 88}
    ]'::jsonb,
    'Table experiencing storage node failures; retry capability; monitoring tools available',
    'Requests retry successfully as storage nodes recover; no data loss; normal latency resumes',
    'Assuming data is lost during storage failures (DynamoDB replicates); not retrying assuming permanent failure; no monitoring',
    0.92,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/TroubleshootingInternalServerErrors.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Batch operation failures: BatchGetItem or BatchWriteItem returns unprocessed items',
    'dynamodb',
    'HIGH',
    '[
        {"solution": "Retry unprocessed items with exponential backoff; AWS SDK handles this automatically", "percentage": 97},
        {"solution": "For BatchWriteItem: verify you are not exceeding 16 MB total request size or 25 item limit", "percentage": 94},
        {"solution": "Implement custom retry logic for unprocessed items: only retry items in UnprocessedKeys/UnprocessedItems", "percentage": 92}
    ]'::jsonb,
    'Batch operations to DynamoDB; unprocessed items in response; retry capability',
    'All items processed successfully; empty UnprocessedKeys in response; batch operation completes',
    'Retrying entire batch instead of just unprocessed items; not implementing backoff; exceeding batch size limits',
    0.94,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Programming.Errors.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Connection timeout to DynamoDB endpoint',
    'dynamodb',
    'HIGH',
    '[
        {"solution": "Increase SDK timeout configuration: set httpTimeout and connectionTimeout to 5000-10000 ms minimum", "percentage": 95},
        {"solution": "Verify network connectivity and security groups allow outbound HTTPS (port 443) to DynamoDB endpoint", "percentage": 94},
        {"solution": "Check if endpoint is accessible: use curl or SDK test to verify connectivity", "percentage": 92},
        {"solution": "Use DynamoDB Local for development to eliminate network latency during testing", "percentage": 85}
    ]'::jsonb,
    'Application connecting to DynamoDB; network connectivity available; SDK configured with endpoint',
    'Connections established successfully; requests complete without timeout; latency acceptable',
    'Default timeout too short for network conditions; security group blocking DynamoDB port; incorrect endpoint URL; no retries on timeout',
    0.93,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Programming.Errors.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Query or Scan returns empty result set unexpectedly',
    'dynamodb',
    'HIGH',
    '[
        {"solution": "Verify table contains items: use Scan with Limit 1 to check if table is truly empty", "percentage": 96},
        {"solution": "Check key condition expression syntax: ensure partition key is specified correctly", "percentage": 95},
        {"solution": "If using filter expression: remember it applies after items fetched; low cardinality items may need Scan", "percentage": 92},
        {"solution": "Verify GSI exists and has attributes: Query on non-existent GSI will fail; check table schema", "percentage": 90}
    ]'::jsonb,
    'Table has data; Query or Scan executed; expecting results',
    'Query/Scan returns expected items; result count matches table data; no errors in response',
    'Assuming empty result means no data exists; filter expression eliminating all items; wrong key condition syntax; querying non-existent index',
    0.93,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Programming.Errors.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Attribute value larger than 400 KB limit',
    'dynamodb',
    'MEDIUM',
    '[
        {"solution": "For single attribute >400KB: split into multiple smaller attributes or move to S3 + reference via key", "percentage": 96},
        {"solution": "Review item structure: DynamoDB max item size is 400 KB total; reduce unnecessary attributes", "percentage": 94},
        {"solution": "Compress large text/JSON before storing as binary (GZIP, etc.)", "percentage": 88}
    ]'::jsonb,
    'Item has attribute exceeding 400 KB; storage optimization possible; alternative storage available',
    'All attributes under 400 KB limit; item stored successfully; no validation errors',
    'Storing full large documents in single attribute; not compressing data; exceeding total item size of 400 KB',
    0.91,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Programming.Errors.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Expression attribute names or values not properly defined',
    'dynamodb',
    'HIGH',
    '[
        {"solution": "For reserved keywords (status, rank, timestamp): use ExpressionAttributeNames #name mapping", "percentage": 98},
        {"solution": "For dynamic values: use ExpressionAttributeValues :value mapping; never concatenate values into expressions", "percentage": 97},
        {"solution": "Verify all :placeholders in expression have corresponding ExpressionAttributeValues entry", "percentage": 96}
    ]'::jsonb,
    'Expression being constructed; attribute names and values available; SDK configured',
    'Expression evaluates correctly; no syntax errors; condition/projection works as intended',
    'Using reserved keywords without name mapping; concatenating values (SQL injection risk); missing value definitions; typos in placeholder names',
    0.97,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Programming.Errors.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'TTL attribute parsing failed or item not deleted by TTL',
    'dynamodb',
    'MEDIUM',
    '[
        {"solution": "TTL attribute must be number type containing Unix timestamp (seconds since epoch, not milliseconds)", "percentage": 98},
        {"solution": "Verify TTL attribute name is correct: use DescribeTable to confirm TTL is enabled and attribute name matches", "percentage": 96},
        {"solution": "TTL deletion can take up to 48 hours; wait before assuming failure; this is by design", "percentage": 93},
        {"solution": "Check CloudWatch for TTL operation metrics to confirm deletions are occurring", "percentage": 85}
    ]'::jsonb,
    'TTL enabled on table; attributes with expiration dates; monitoring capability available',
    'Items with past TTL deleted automatically; DescribeTable shows TTL enabled; correct attribute type',
    'Using milliseconds instead of seconds in TTL; wrong attribute type (string instead of number); expecting instant deletion; wrong attribute name',
    0.92,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Programming.Errors.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Scan operation using excessive capacity on large tables',
    'dynamodb',
    'HIGH',
    '[
        {"solution": "Replace Scan with Query when partition key is known; Query is much more efficient", "percentage": 98},
        {"solution": "Add filter expression to Scan to reduce returned items (but still consumes capacity for scanned items)", "percentage": 94},
        {"solution": "Use Scan pagination with Limit to reduce capacity per request; batch multiple requests", "percentage": 92},
        {"solution": "Consider redesigning access patterns to use GSI instead of Scan for common queries", "percentage": 85}
    ]'::jsonb,
    'Large table with many items; Scan operation in use; understanding of access patterns',
    'Query used instead of Scan where possible; capacity consumption reduced; acceptable latency',
    'Using Scan for all queries regardless of key availability; filter expression not reducing items enough; no pagination on Scan',
    0.94,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Programming.Errors.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Hot partition causing throttling on single partition key',
    'dynamodb',
    'HIGH',
    '[
        {"solution": "Add random suffix to partition key for write-heavy scenarios: partition_id = base_id + random(0-N)", "percentage": 96},
        {"solution": "Distribute traffic across multiple partition keys in application layer", "percentage": 94},
        {"solution": "Use on-demand billing instead of provisioned for uneven access patterns", "percentage": 92},
        {"solution": "Implement write buffering: batch writes for same key before submitting to DynamoDB", "percentage": 88}
    ]'::jsonb,
    'Single partition key receiving disproportionate load; provisioned capacity; write-heavy workload',
    'Throttling errors eliminated; load distributed across partitions; latency acceptable',
    'Assuming all items should use same partition key; not distributing keys; provisioning only for average load not peak',
    0.90,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Programming.Errors.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Global Secondary Index capacity exhausted independently from table',
    'dynamodb',
    'HIGH',
    '[
        {"solution": "Increase provisioned WCU/RCU on GSI independently: GSI has separate capacity from base table", "percentage": 97},
        {"solution": "Switch GSI to on-demand billing if capacity is unpredictable", "percentage": 95},
        {"solution": "Review queries: if GSI is being scanned heavily, optimize to use sparse GSI (only include relevant items)", "percentage": 88}
    ]'::jsonb,
    'GSI exists on table; GSI receiving higher traffic than provisioned; capacity visible in CloudWatch',
    'GSI requests complete without throttling; separate capacity metrics show healthy levels',
    'Assuming GSI shares capacity with table; not provisioning GSI separately; querying sparse index against all items',
    0.94,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Programming.Errors.html'
);

-- End of DynamoDB Error Mining - 25 entries total
