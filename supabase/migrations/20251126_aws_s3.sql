INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'AccessDenied: Access Denied',
    'cloud',
    'HIGH',
    '[
        {"solution": "Grant s3:ListBucket permission on the bucket ARN (arn:aws:s3:::bucketname) and s3:GetObject/s3:PutObject on object ARN (arn:aws:s3:::bucketname/*) in your IAM policy", "percentage": 95},
        {"solution": "Ensure Block Public Access settings are configured correctly - in bucket permissions, uncheck ''Block new public bucket policies''", "percentage": 85},
        {"solution": "If bucket has object ownership issues, verify the object uploader used ''bucket-owner-full-control'' ACL", "percentage": 75}
    ]'::jsonb,
    'IAM user or role with S3 permissions, bucket and object ARNs',
    'Access to bucket and objects works, no more 403 errors returned',
    'Only adding GetObject policy without ListBucket permission, missing the second policy statement for bucket-level access, incorrect resource ARN format',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/22077445/aws-s3-bucket-permissions-access-denied'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'NoSuchBucket: The specified bucket does not exist',
    'cloud',
    'HIGH',
    '[
        {"solution": "Run ''aws s3 ls'' to list all buckets and verify the bucket name is spelled correctly (case-sensitive)", "percentage": 95},
        {"solution": "Run ''aws s3api get-bucket-location --bucket <bucket-name>'' to confirm the bucket region and update your application configuration", "percentage": 90},
        {"solution": "If bucket was recently deleted, wait 24 hours before attempting to recreate it - S3 reserves deleted bucket names temporarily", "percentage": 80}
    ]'::jsonb,
    'AWS CLI configured, valid AWS credentials',
    'Bucket listed in aws s3 ls output, s3api get-bucket-location returns region successfully',
    'Typos in bucket name, using uppercase letters, assuming bucket name is case-insensitive, not checking regional endpoints',
    0.94,
    'haiku',
    NOW(),
    'https://repost.aws/knowledge-center/404-error-nosuchkey-s3'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'SignatureDoesNotMatch: The request signature we calculated does not match the signature you provided',
    'cloud',
    'HIGH',
    '[
        {"solution": "Verify AWS credentials file has no trailing spaces or extra characters - remove and regenerate credentials if needed via aws configure", "percentage": 93},
        {"solution": "For presigned URLs, ensure all HTTP headers used to generate signature match headers sent in the actual request (including Content-Type)", "percentage": 88},
        {"solution": "Sync system time with NTP servers - AWS only tolerates 15 minute time difference: ''ntpd -u ntp:ntp'' or use cloud provider time sync", "percentage": 85},
        {"solution": "If using session tokens, verify AWS_SESSION_TOKEN environment variable is correctly set alongside access key and secret key", "percentage": 80}
    ]'::jsonb,
    'AWS credentials with access key and secret key, for presigned URLs need the original signing parameters',
    'S3 request succeeds without signature errors, CloudTrail shows accepted request signature',
    'Copy-paste error with invisible characters in credentials, forgetting Content-Type header on presigned URL requests, local system clock skewed by >15 minutes, reusing presigned URL with modified headers',
    0.90,
    'haiku',
    NOW(),
    'https://brijendrasinghrajput.medium.com/signaturedoesnotmatch-aws-s3-solved-7a02d8578f29'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'BucketAlreadyExists: The requested bucket name is not available',
    'cloud',
    'HIGH',
    '[
        {"solution": "Choose a unique bucket name combining your company/project identifier - run ''aws s3 ls'' to verify uniqueness", "percentage": 96},
        {"solution": "If you own the bucket, verify with ''aws s3api head-bucket --bucket <name>'' - if it returns without error, bucket is yours", "percentage": 90},
        {"solution": "If bucket was deleted, wait 24+ hours before recreating - S3 reserves deleted names globally across all AWS accounts", "percentage": 85}
    ]'::jsonb,
    'AWS CLI with S3 permissions',
    'Bucket creation succeeds, new bucket appears in aws s3 ls output',
    'Using a common bucket name, attempting to recreate deleted bucket too soon, not understanding global bucket namespace across all AWS accounts',
    0.93,
    'haiku',
    NOW(),
    'https://repost.aws/knowledge-center/s3-error-bucket-already-exists'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'EntityTooLarge: Your proposed upload exceeds the maximum allowed size',
    'cloud',
    'MEDIUM',
    '[
        {"solution": "For single PUT operations, max file size is 5 GB - use multipart upload API for larger files", "percentage": 97},
        {"solution": "Use ''aws s3 cp'' which automatically handles multipart upload for large files", "percentage": 95},
        {"solution": "For files >5 TB, verify you''re not exceeding S3''s absolute maximum object size of 5 TB", "percentage": 90}
    ]'::jsonb,
    'File to upload, AWS SDK or CLI',
    'Large file uploads complete successfully, CloudWatch shows successful PutObject operations',
    'Using single PUT for files >5 GB, uploading files exceeding 5 TB absolute limit, not using aws s3 cp which handles multipart automatically',
    0.95,
    'haiku',
    NOW(),
    'https://drdroid.io/stack-diagnosis/s3-entitytoolarge-error-when-uploading-an-object-to-s3-6d734'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'BadDigest: The Content-MD5 you specified did not match what we received',
    'cloud',
    'MEDIUM',
    '[
        {"solution": "Verify MD5 is base64-encoded not hex - convert 16 octets of MD5 digest to base64 format", "percentage": 92},
        {"solution": "For UTF-8 content with multibyte characters, ensure ContentMD5 is calculated with UTF-8 encoding", "percentage": 85},
        {"solution": "In Java SDK, don''t reuse ObjectMetadata across multiple PutObjectRequest calls - SDK mutates it with computed MD5", "percentage": 88},
        {"solution": "Ensure file is fully written and closed before starting upload - in-progress files cause MD5 mismatch", "percentage": 80}
    ]'::jsonb,
    'Content file, MD5 computation method, Content-MD5 header',
    'File uploads succeed without BadDigest errors, CloudTrail shows successful uploads',
    'Using hex-encoded MD5 instead of base64, not handling UTF-8 encoding for international characters, file being modified during upload, reusing metadata objects in Java',
    0.88,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/36179310/an-exception-the-content-md5-you-specified-did-not-match-what-we-received'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'InvalidAccessKeyId: The AWS Access Key ID does not exist in our records',
    'cloud',
    'HIGH',
    '[
        {"solution": "Verify the access key ID and secret key are active in IAM Console - Security credentials tab", "percentage": 94},
        {"solution": "Remove ~/.aws/credentials and ~/.aws/config, then run ''aws configure'' to reset credentials fresh", "percentage": 90},
        {"solution": "Create new access key pair in IAM if old keys are inactive/deleted, and update configuration", "percentage": 92},
        {"solution": "For session tokens, ensure AWS_SESSION_TOKEN is passed alongside AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY", "percentage": 85}
    ]'::jsonb,
    'AWS IAM user with programmatic access keys',
    'S3 requests authenticate successfully, aws s3 ls returns bucket list',
    'Using deleted or inactive access keys, copy-paste errors in credentials with invisible characters, missing session token for temporary credentials',
    0.91,
    'haiku',
    NOW(),
    'https://repost.aws/knowledge-center/s3-access-key-error'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'InvalidBucketName: The specified bucket is not valid',
    'cloud',
    'MEDIUM',
    '[
        {"solution": "Ensure bucket name is 3-63 characters, lowercase only, no uppercase letters, numbers and hyphens allowed", "percentage": 96},
        {"solution": "Verify name starts and ends with letter or number (not dot or hyphen)", "percentage": 94},
        {"solution": "Avoid periods in bucket name if using HTTPS virtual-host-style addressing - SSL certificate won''t validate with periods", "percentage": 88},
        {"solution": "Avoid reserved prefixes: xn--, sthree-, amzn-s3-demo- and reserved suffixes: -s3alias, --ol-s3, .mrap, --x-s3, --table-s3", "percentage": 90}
    ]'::jsonb,
    'Bucket naming rules knowledge',
    'Bucket creation succeeds, bucket appears in aws s3 ls, virtual-host style URLs work',
    'Using uppercase letters in bucket name, including special characters, starting/ending with dots or hyphens, adjacent periods, using reserved prefixes/suffixes',
    0.94,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'SlowDown: Please reduce your request rate',
    'cloud',
    'MEDIUM',
    '[
        {"solution": "Distribute load across multiple random prefixes - use 10+ prefixes to achieve 35,000+ PUT requests/sec", "percentage": 88},
        {"solution": "Implement exponential backoff retry logic: start with 1s delay, double on each retry (1s, 2s, 4s, 8s...)", "percentage": 92},
        {"solution": "Queue requests through SQS then process with worker nodes to smooth burst traffic", "percentage": 85},
        {"solution": "Smooth request distribution over time instead of bursts - avoid 10k+ requests/sec in short windows", "percentage": 90}
    ]'::jsonb,
    'S3 bucket with understanding of partition limits (3,500 PUT/sec per prefix baseline)',
    'Requests complete without 503 SlowDown responses, consistent throughput maintained',
    'Sending all requests to same prefix, aggressive retries without backoff, not distributing load across time, concentrating requests in bursts',
    0.85,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/46787072/s3-slowdown-please-reduce-your-request-rate-exception'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'RequestTimeTooSkewed: The difference between the request time and the current time is too large',
    'cloud',
    'MEDIUM',
    '[
        {"solution": "Sync system clock with NTP: run ''sudo ntpd -u ntp:ntp'' or enable system time sync in OS settings", "percentage": 94},
        {"solution": "For Docker containers, restart Docker daemon: ''systemctl restart docker'' - containers sync time on startup", "percentage": 88},
        {"solution": "For VMs, restart virtual machine to trigger time resync with hypervisor", "percentage": 85},
        {"solution": "AWS SDKv3 automatically applies clock skew correction, no manual fix needed - upgrade SDK if possible", "percentage": 90}
    ]'::jsonb,
    'System with NTP capability or Docker/VM access, AWS SDK',
    'S3 requests succeed with valid signatures, no RequestTimeTooSkewed errors in logs',
    'Not syncing system time after VM creation, relying on old SDK without clock skew correction, time drift >15 minutes',
    0.89,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/4770635/s3-error-the-difference-between-the-request-time-and-the-current-time-is-too-la'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'NoSuchKey: The specified key does not exist',
    'cloud',
    'HIGH',
    '[
        {"solution": "Verify exact object name using ''aws s3api list-objects-v2 --bucket <name> --output json'' - S3 keys are case-sensitive", "percentage": 96},
        {"solution": "Remove leading slashes from key names - use ''myfile.txt'' not ''/myfile.txt''", "percentage": 92},
        {"solution": "For encrypted objects with custom KMS key, verify IAM role has kms:Decrypt permission on the key", "percentage": 85},
        {"solution": "Check for special characters, URL encoding, carriage returns (\\r) or newlines (\\n) in object keys", "percentage": 88}
    ]'::jsonb,
    'S3 bucket, AWS CLI or SDK, object key name',
    'GetObject/HeadObject requests succeed, object content retrieved successfully',
    'Typos in object key, case sensitivity issues, leading slashes, missing KMS permissions, special characters not URL-encoded',
    0.92,
    'haiku',
    NOW(),
    'https://repost.aws/knowledge-center/404-error-nosuchkey-s3'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'BucketNotEmpty: The bucket that you tried to delete is not empty',
    'cloud',
    'MEDIUM',
    '[
        {"solution": "For non-versioned buckets, use ''aws s3 rb s3://bucket --force'' to delete bucket and all contents", "percentage": 95},
        {"solution": "For versioned buckets, delete all versions: ''aws s3api list-object-versions --bucket <name> | jq -r ''.Versions[].Key'' | xargs -I {} aws s3api delete-object --bucket <name> --key {}''", "percentage": 85},
        {"solution": "Check for delete markers on deleted objects - list-object-versions shows delete markers that must be permanently deleted", "percentage": 88},
        {"solution": "Check for incomplete multipart uploads with ''aws s3api list-multipart-uploads --bucket <name>'' and abort them", "percentage": 80}
    ]'::jsonb,
    'Non-empty S3 bucket, AWS CLI access',
    'Bucket deletion succeeds, bucket no longer appears in aws s3 ls',
    'Using simple delete for versioned bucket, not handling delete markers, abandoned multipart uploads preventing deletion',
    0.88,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/AmazonS3/latest/userguide/delete-bucket.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'InvalidArgument: The specified argument was not valid',
    'cloud',
    'MEDIUM',
    '[
        {"solution": "Review error message carefully - it often specifies which argument is invalid", "percentage": 90},
        {"solution": "For event notifications, verify SNS/SQS resource policy grants s3:SendNotification permission to bucket", "percentage": 87},
        {"solution": "Check all request parameters match API documentation - verify data types and supported values", "percentage": 88},
        {"solution": "Ensure authorization header format is correct: ''Authorization: AWS4-HMAC-SHA256 Credential=..., SignedHeaders=..., Signature=...''", "percentage": 85}
    ]'::jsonb,
    'S3 API request, API documentation reference',
    'API request accepted without InvalidArgument error, operation completes successfully',
    'Typos in parameter names, incorrect data types, unsupported parameter values, malformed headers',
    0.82,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/AmazonS3/latest/API/ErrorResponses.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    '403 Forbidden: Access Denied - Explicit Deny vs Implicit Denial',
    'cloud',
    'MEDIUM',
    '[
        {"solution": "Check for explicit Deny statements in bucket policies that override Allow statements", "percentage": 94},
        {"solution": "For cross-account access, add Allow statements in BOTH bucket policy AND IAM policy", "percentage": 90},
        {"solution": "Verify Block Public Access settings - BlockPublicPolicy may prevent public bucket policies", "percentage": 88},
        {"solution": "For KMS-encrypted objects, ensure IAM user has kms:GenerateDataKey (upload) and kms:Decrypt (download) permissions", "percentage": 86},
        {"solution": "Check VPC Endpoint policies for Allow statements - implicit deny blocks all access if endpoint policy is missing", "percentage": 82}
    ]'::jsonb,
    'AWS IAM/bucket policy knowledge, CloudTrail access',
    'Access granted without 403 errors, operations complete successfully, CloudTrail shows allowed actions',
    'Forgetting Allow statement in bucket policy (implicit deny), explicit Deny statements overriding Allow, cross-account access without IAM policy, missing KMS permissions',
    0.87,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/AmazonS3/latest/userguide/troubleshoot-403-errors.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'EntityTooSmall: Your proposed upload is smaller than minimum allowed size',
    'cloud',
    'LOW',
    '[
        {"solution": "For multipart upload, each part except the last must be at least 5 MB (5,242,880 bytes)", "percentage": 96},
        {"solution": "Verify minimum part size with ''aws s3api upload-part'' - last part can be any size >=0", "percentage": 92},
        {"solution": "Use complete multipart upload with ''aws s3api complete-multipart-upload'' after all parts uploaded", "percentage": 95}
    ]'::jsonb,
    'Multipart upload initiated, AWS CLI or SDK',
    'Multipart upload completes without EntityTooSmall errors, final object is correct size',
    'Uploading parts <5 MB except for final part, not understanding per-part minimum size requirements',
    0.94,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/AmazonS3/latest/API/ErrorResponses.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'InternalError: An internal error occurred. Try again',
    'cloud',
    'LOW',
    '[
        {"solution": "Retry request with exponential backoff (1s, 2s, 4s, 8s...) - transient S3 service error", "percentage": 92},
        {"solution": "Check AWS Service Health Dashboard for S3 service issues in your region", "percentage": 88},
        {"solution": "Review CloudTrail logs for request details and contact AWS Support if errors persist", "percentage": 80}
    ]'::jsonb,
    'AWS SDK with retry capability, CloudTrail access',
    'Request succeeds on retry, operation completes without InternalError',
    'Not retrying on transient errors, single retry without backoff, not checking service health status',
    0.85,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/AmazonS3/latest/API/ErrorResponses.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'ServiceUnavailable: Service is unable to handle request',
    'cloud',
    'LOW',
    '[
        {"solution": "Implement exponential backoff and retry - S3 may be temporarily overloaded", "percentage": 93},
        {"solution": "Check AWS Service Health Dashboard for region-specific S3 outages", "percentage": 88},
        {"solution": "Reduce request rate temporarily or use queue-based architecture to smooth load", "percentage": 85}
    ]'::jsonb,
    'AWS SDK with retry logic',
    'Request succeeds after retry, consistent service availability returns',
    'Not retrying with backoff, not checking service status before escalating issue',
    0.84,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/AmazonS3/latest/API/ErrorResponses.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'PutObject with Gzip Content-Encoding - Integrity check and content-length mismatch',
    'cloud',
    'LOW',
    '[
        {"solution": "For gzip-compressed streams, calculate content-length of compressed data before upload", "percentage": 92},
        {"solution": "Use chunked transfer encoding (Transfer-Encoding: chunked) instead of Content-Length if size unknown", "percentage": 88},
        {"solution": "Set Content-Encoding: gzip header so S3 knows data is compressed", "percentage": 90},
        {"solution": "For large gzip streams, use multipart upload instead of single PUT operation", "percentage": 85}
    ]'::jsonb,
    'Gzip compression library, Content-Encoding header support',
    'Gzipped content uploads successfully, Content-Length matches compressed size, decompression works',
    'Using uncompressed content-length for gzip data, missing Content-Encoding header, streaming without calculating length',
    0.87,
    'haiku',
    NOW(),
    'https://github.com/aws/aws-sdk-js-v3/issues/7434'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Socket Exhaustion - Too many open connections in AWS SDK v3',
    'cloud',
    'LOW',
    '[
        {"solution": "Update @smithy/node-http-handler to latest version (>=4.3.0)", "percentage": 94},
        {"solution": "Configure HTTP keep-alive: set HTTP agent maxSockets and agent timeout appropriately", "percentage": 88},
        {"solution": "Reuse S3 client instances instead of creating new ones per request", "percentage": 92},
        {"solution": "Implement proper connection pooling with http.Agent configuration", "percentage": 85}
    ]'::jsonb,
    'AWS SDK v3 with Node.js, HTTP agent configuration',
    'Connections properly pooled, socket count stable, no connection exhaustion errors',
    'Creating new S3 clients per request, old Smithy version with socket leak, not configuring keep-alive',
    0.88,
    'haiku',
    NOW(),
    'https://github.com/aws/aws-sdk-js-v3/issues/7416'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'NoSuchUpload: The specified multipart upload does not exist',
    'cloud',
    'LOW',
    '[
        {"solution": "Verify the upload ID with ''aws s3api list-multipart-uploads --bucket <name>'' - upload may have timed out", "percentage": 92},
        {"solution": "Restart multipart upload from beginning if upload ID is invalid or expired", "percentage": 90},
        {"solution": "Complete multipart upload within 7 days - older incomplete uploads auto-expire", "percentage": 88}
    ]'::jsonb,
    'Active multipart upload with valid upload ID',
    'Multipart upload completes successfully with correct upload ID, final object created',
    'Using expired upload ID, upload ID from different bucket, timeout between parts >7 days',
    0.89,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/AmazonS3/latest/API/ErrorResponses.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'InvalidStorageClass: The storage class you specified is not valid',
    'cloud',
    'LOW',
    '[
        {"solution": "Use valid storage classes only: STANDARD, STANDARD_IA, ONEZONE_IA, INTELLIGENT_TIERING, GLACIER, DEEP_ARCHIVE", "percentage": 96},
        {"solution": "Verify storage class name matches exactly - case sensitive (STANDARD not standard)", "percentage": 94},
        {"solution": "Check that selected storage class is available in your region via AWS documentation", "percentage": 90}
    ]'::jsonb,
    'Storage class knowledge, PutObject with StorageClass parameter',
    'Object uploaded with valid storage class, storage class appears in object metadata',
    'Typos in storage class name, using deprecated storage classes, unsupported storage class in region',
    0.95,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/AmazonS3/latest/API/ErrorResponses.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'NotImplemented: A header you provided implies functionality that is not implemented',
    'cloud',
    'LOW',
    '[
        {"solution": "Review request headers against S3 API documentation - remove unsupported headers", "percentage": 94},
        {"solution": "Verify your SDK version supports the headers/parameters you''re using", "percentage": 90},
        {"solution": "Check for deprecated parameters that may have been removed in newer S3 API versions", "percentage": 88}
    ]'::jsonb,
    'S3 API documentation, SDK version information',
    'Request accepted without NotImplemented error, operation completes successfully',
    'Using unsupported headers, deprecated SDK features, parameters not available in your API version',
    0.91,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/AmazonS3/latest/API/ErrorResponses.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'CrossLocationLoggingProhibited: Cross location logging not allowed',
    'cloud',
    'LOW',
    '[
        {"solution": "Ensure source bucket and destination bucket for logging are in the same region", "percentage": 96},
        {"solution": "Verify S3 log delivery group has write access - grant ''s3:PutObject'' on destination bucket prefix", "percentage": 92},
        {"solution": "Use ''aws s3api put-bucket-logging --bucket <name>'' with both buckets in same region", "percentage": 94}
    ]'::jsonb,
    'Two S3 buckets, AWS CLI with S3 permissions',
    'Server access logging enabled successfully, logs written to destination bucket',
    'Source and destination buckets in different regions, missing permissions on destination bucket',
    0.93,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/AmazonS3/latest/API/ErrorResponses.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'InvalidObjectState: The object is in an invalid state',
    'cloud',
    'LOW',
    '[
        {"solution": "For S3 Object Lock protected objects, cannot modify or delete if retention applies - wait for retention period", "percentage": 93},
        {"solution": "Check object legal hold status with ''aws s3api head-object --bucket <name> --key <key>''", "percentage": 90},
        {"solution": "For governance mode retention, use ''--bypass-governance-retention'' flag with appropriate IAM permission", "percentage": 85}
    ]'::jsonb,
    'S3 Object Lock enabled bucket, object governance/retention configuration',
    'Object operations complete within retention window, legal hold properly managed',
    'Attempting to delete Object Lock protected object, missing governance retention bypass permission',
    0.88,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/AmazonS3/latest/API/ErrorResponses.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'PreconditionFailed: At least one of the pre-conditions did not hold',
    'cloud',
    'LOW',
    '[
        {"solution": "If-Match failed: verify object ETag with ''aws s3api head-object --bucket <name> --key <key>'' and request matches current ETag", "percentage": 94},
        {"solution": "If-Modified-Since failed: request time is before object modification time - check object LastModified", "percentage": 92},
        {"solution": "If-None-Match: ensure your ETag doesn''t match current object ETag - use different version", "percentage": 90},
        {"solution": "If-Unmodified-Since: request time after object modification - update request time or fetch fresh object", "percentage": 88}
    ]'::jsonb,
    'Request with conditional headers (If-Match, If-Modified-Since, etc), current object metadata',
    'Conditional request succeeds or properly returns NotModified (304), ETag or Last-Modified respected',
    'Stale ETag from cached object, incorrect date comparison, confusing If-Match with If-None-Match',
    0.87,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/AmazonS3/latest/API/ErrorResponses.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'AuthorizationHeaderMalformed: The authorization header is malformed',
    'cloud',
    'MEDIUM',
    '[
        {"solution": "Verify header format: ''Authorization: AWS4-HMAC-SHA256 Credential=<access-key>/<date>/<region>/s3/aws4_request, SignedHeaders=<headers>, Signature=<sig>''", "percentage": 96},
        {"solution": "Ensure exactly one space between components - ''AWS4-HMAC-SHA256'' must be followed by single space", "percentage": 94},
        {"solution": "Verify all SignedHeaders are included in request without modification", "percentage": 92},
        {"solution": "Check date format in Credential scope is YYYYMMDD format matching x-amz-date header", "percentage": 90}
    ]'::jsonb,
    'AWS SigV4 signing implementation, request with Authorization header',
    'Request authenticates successfully, signed request accepted by S3',
    'Extra spaces in Authorization header, missing components, SignedHeaders mismatch with actual headers, date format incorrect',
    0.93,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_sigv-troubleshooting.html'
);
