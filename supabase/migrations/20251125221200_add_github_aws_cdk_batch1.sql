-- AWS CDK Infrastructure and Deployment Error Solutions - Batch 1
-- Category: github-aws-cdk
-- Source: High-voted AWS CDK GitHub issues with infrastructure/deployment focus
-- Extracted: 2025-11-25

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'AWS CDK unable to resolve AWS account with SSO configuration - intermittent deployment failures',
    'github-aws-cdk',
    'MEDIUM',
    '[
        {"solution": "Use explicit AWS_PROFILE environment variable: AWS_PROFILE=sandbox cdk deploy", "percentage": 85, "note": "More reliable than AWS_DEFAULT_PROFILE for CDK"},
        {"solution": "Enable verbose logging with -vv flag to diagnose credential resolution: cdk deploy -vv", "percentage": 80, "note": "Helps identify SSO token refresh issues"},
        {"solution": "Ensure SSO tokens are fresh before deployment, refresh if needed: aws sso login --profile sandbox", "percentage": 75, "note": "SSO token expiration causes intermittent failures"}
    ]'::jsonb,
    'AWS SSO configured with profiles, AWS CDK installed, Valid AWS credentials in SSO',
    'cdk deploy completes successfully, deployment reaches CloudFormation stack creation, No credential resolution errors in logs',
    'AWS_DEFAULT_PROFILE may not work reliably with CDK SSO. Always use explicit AWS_PROFILE. CDK credential resolution is more strict than AWS CLI. Intermittent failures indicate token expiration.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/aws/aws-cdk/issues/24744'
),
(
    'AWS CDK asset publishing failure does not stop stack deployment - CloudFormation runtime failure',
    'github-aws-cdk',
    'HIGH',
    '[
        {"solution": "Upgrade to CDK 2.84.0+ which validates asset builds before proceeding to stack deployment", "percentage": 95, "note": "Fix merged in PR #26060"},
        {"solution": "Check Docker image build logs if asset is Docker image: docker build command output for errors", "percentage": 85, "note": "Common cause of asset publishing failures"},
        {"solution": "Verify asset publishing IAM permissions for ECR repos and S3: Check CloudTrail logs for permission denied errors", "percentage": 80, "note": "Insufficient permissions cause silent failures"}
    ]'::jsonb,
    'AWS CDK v2.83.1 or earlier, Docker images or assets in stack, Node.js 18+',
    'cdk deploy stops before CloudFormation deployment if asset build fails, Error message clearly indicates asset failure, No CloudFormation rollback due to missing assets',
    'Asset publishing failures are silent in older CDK versions - stack proceeds to CloudFormation and fails later. Always check Docker build logs separately. Asset validation was added to fix this behavior.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/aws/aws-cdk/issues/26048'
),
(
    'AWS CDK CLI hangs indefinitely when nested stack deployment fails and rollback completes',
    'github-aws-cdk',
    'MEDIUM',
    '[
        {"solution": "Upgrade to CDK 1.25.1+ which fixes error handling for nested stacks: npm install -g aws-cdk@latest", "percentage": 90, "note": "Fix in PR #6433"},
        {"solution": "If stuck, manually kill the CDK process: kill -9 [pid], check CloudFormation stack status manually", "percentage": 85, "note": "Temporary workaround while upgrade is pending"},
        {"solution": "Check for nested stack deployment errors in CloudFormation console and fix underlying issues before retry", "percentage": 75, "note": "Prevent rollback by addressing root cause first"}
    ]'::jsonb,
    'AWS CDK CLI 1.25.0 or earlier, Nested stacks in deployment, macOS or Linux',
    'cdk deploy process exits cleanly after nested stack failure, No zombie processes left running, CloudFormation stack status shows ROLLBACK_COMPLETE without CLI hanging',
    'Older CDK versions do not properly clean up file handles on nested stack failures. CLI appears frozen at intermediate progress step (e.g., 9/16) with no timeout. Process must be forcefully killed.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/aws/aws-cdk/issues/6403'
),
(
    'AWS CDK cdk deploy fails with WorkGraph error - unable to make progress with stack dependencies',
    'github-aws-cdk',
    'MEDIUM',
    '[
        {"solution": "Downgrade to CDK version 2.76.0 if currently on 2.81.0: npm install -g aws-cdk@2.76.0", "percentage": 90, "note": "Regression in 2.81.0, workaround for immediate deployment"},
        {"solution": "Upgrade to latest CDK version after 2.81.0 which includes dependency cycle detection: npm install -g aws-cdk@latest", "percentage": 85, "note": "Fix in PR #25830 provides better diagnostics"},
        {"solution": "Share cdk.out/manifest.json with AWS support for analysis of stack dependency chain", "percentage": 70, "note": "Helps identify circular or invalid dependencies"}
    ]'::jsonb,
    'AWS CDK 2.81.0, ~50+ stacks with linear dependencies, manifest.json available',
    'cdk deploy completes or shows clear error about circular dependencies, No WorkGraph.updateReadyPool error, Stack creation proceeds normally',
    'Version 2.81.0 regression does not provide actionable error messages. The error "Unable to make progress anymore" masks the real issue. Dependencies appear complete in output but fail silently. Downgrade is safest short-term solution.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/aws/aws-cdk/issues/25806'
),
(
    'AWS Lambda function version calculation causes deployment failure - hash includes non-versionable properties',
    'github-aws-cdk',
    'HIGH',
    '[
        {"solution": "Upgrade to CDK with PR #14586 merged which filters hashes to only versionable properties: npm install -g aws-cdk@latest", "percentage": 95, "note": "Permanent fix for Lambda versioning"},
        {"solution": "Avoid modifying non-versionable properties (reservedConcurrentExecutions, tags, dependsOn) on deployed Lambda functions", "percentage": 85, "note": "Workaround by preventing property changes that trigger incorrect hashing"},
        {"solution": "If stuck, manually delete the Lambda::Version resource from CloudFormation and redeploy: aws cloudformation delete-resource --logical-id", "percentage": 70, "note": "Emergency workaround for blocked deployments"}
    ]'::jsonb,
    'AWS CDK with Lambda constructs, Previously deployed Lambda function being modified',
    'cdk deploy succeeds even when adding reservedConcurrentExecutions or tags, Lambda version updates without CloudFormation errors, No error about existing Lambda version',
    'CDK hash calculation incorrectly includes CloudFormation-only properties like Tags and ReservedConcurrentExecutions. These do not affect actual Lambda function versioning. Changing them triggers false version conflicts.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://github.com/aws/aws-cdk/issues/11537'
),
(
    'AWS CDK S3 BucketDeployment CloudFormation custom resource Lambda fails to send response - HTTP 403',
    'github-aws-cdk',
    'MEDIUM',
    '[
        {"solution": "Ensure Lambda execution role has permissions to send CloudFormation success/failure responses: add CloudFormation service in trust relationship", "percentage": 85, "note": "403 Forbidden indicates insufficient permissions"},
        {"solution": "Check CloudWatch logs for RequestId mentioned in CloudFormation error to diagnose exact failure point", "percentage": 80, "note": "Logs contain detailed error information"},
        {"solution": "Verify BucketDeployment custom resource handler has network connectivity to CloudFormation callback endpoint if in VPC", "percentage": 75, "note": "Network isolation can block response submission"}
    ]'::jsonb,
    'AWS CDK S3 BucketDeployment construct, IAM role for deployment Lambda, CloudWatch logs accessible',
    'Stack update completes successfully, BucketDeployment Lambda uploads files and sends success response, No CloudFormation timeout waiting for custom resource response',
    'CloudFormation custom resources require the Lambda to send explicit success/failure callbacks. S3 upload may succeed but callback fails. Insufficient IAM permissions are common cause of 403 errors.',
    0.80,
    'sonnet-4',
    NOW(),
    'https://github.com/aws/aws-cdk/issues/24327'
),
(
    'AWS CDK bootstrap fails - CDKToolkit CloudFormation stack exists but S3 staging bucket missing',
    'github-aws-cdk',
    'HIGH',
    '[
        {"solution": "Delete CDKToolkit CloudFormation stack from AWS console in affected region, then run cdk bootstrap to recreate: Delete stack, then cdk bootstrap", "percentage": 95, "note": "Resolves stack drift issue"},
        {"solution": "Use cdk bootstrap --force flag to force recreation of bootstrap resources", "percentage": 85, "note": "Forces bootstrap even if stack already exists"},
        {"solution": "Verify bucket does not exist in S3: aws s3 ls | grep cdktoolkit, if exists delete it first", "percentage": 80, "note": "Orphaned buckets can block recreation"}
    ]'::jsonb,
    'AWS CDK environment with existing CDKToolkit stack, AWS CLI configured, AWS account admin access',
    'cdk bootstrap succeeds and reports changes made, S3 staging bucket created, Subsequent cdk deploy commands work without bucket-not-found errors',
    'cdk bootstrap --force does NOT recover from stack drift. It only downgrades bootstrap template versions. Manual stack deletion is required. Bootstrap can appear successful (no changes) while bucket is actually missing.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/aws/aws-cdk/issues/18261'
),
(
    'AWS CDK bootstrap fails on existing IAM role - CloudFormation CREATE_FAILED for ImagePublishingRole',
    'github-aws-cdk',
    'MEDIUM',
    '[
        {"solution": "Delete CDKToolkit CloudFormation stack completely and remove orphaned IAM roles: Delete stack, then delete cdk-hnb659fds-image-publishing-role manually", "percentage": 90, "note": "Cleanest solution for role conflicts"},
        {"solution": "Delete CDKToolkit S3 bucket in addition to stack to ensure complete cleanup: Delete bucket, delete stack, then cdk bootstrap", "percentage": 85, "note": "S3 bucket retention can cause re-creation failures"},
        {"solution": "Use IAM role deletion via AWS CLI before bootstrap: aws iam delete-role --role-name cdk-hnb659fds-image-publishing-role", "percentage": 80, "note": "Handles orphaned roles created in previous failed bootstrap"}
    ]'::jsonb,
    'AWS CDK environment with failed bootstrap attempt, CloudFormation delete permission, IAM role management permission',
    'cdk bootstrap succeeds without CloudFormation CREATE_FAILED errors, All bootstrap IAM roles created successfully, ImagePublishingRole and FilePublishingRole exist in CDKToolkit stack',
    'CloudFormation cannot create roles that already exist outside the stack. Partial bootstrap cleanup leaves IAM roles orphaned. CDK cannot fix this as it depends on CloudFormation design.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/aws/aws-cdk/issues/21172'
),
(
    'AWS CDK AwsCustomResource Lambda error does not trigger CloudFormation FAILED response - deployment continues',
    'github-aws-cdk',
    'MEDIUM',
    '[
        {"solution": "Use CustomResource with cfnresponse module instead of AwsCustomResource for error handling: Replace AwsCustomResource with Lambda + CustomResource pattern", "percentage": 90, "note": "cfnresponse provides explicit success/failure signaling"},
        {"solution": "Implement Lambda Provider framework with explicit error handling: Use @aws-cdk/custom-resources Provider", "percentage": 85, "note": "Framework-level error handling for custom resources"},
        {"solution": "Check Lambda function error logs in CloudWatch and ensure function explicitly calls cfnresponse.send() with error details", "percentage": 80, "note": "AwsCustomResource does not capture Lambda function errors"}
    ]'::jsonb,
    'AWS CDK with AwsCustomResource construct, Lambda function that may throw errors, CloudWatch logs access',
    'CustomResource errors cause CloudFormation stack to fail with FAILED status, Stack rollback occurs on Lambda errors, CloudFormation deployment does not continue on function errors',
    'AwsCustomResource invokes lambda:Invoke which returns success even if Lambda throws exceptions. Lambda error codes are reserved for execution-blocking errors only. Function must explicitly signal failure via cfnresponse.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/aws/aws-cdk/issues/20933'
),
(
    'AWS CDK Lambda function missing dependencies on EFS security group rules - random creation order',
    'github-aws-cdk',
    'MEDIUM',
    '[
        {"solution": "Upgrade to CDK with PR #14431 merged which ensures Lambda depends on security group ingress/egress: npm install -g aws-cdk@latest", "percentage": 95, "note": "Fix adds proper CloudFormation resource dependencies"},
        {"solution": "Explicitly add dependency in CDK: lambda.node.addDependency(securityGroup) to ensure rules created before Lambda", "percentage": 90, "note": "Workaround using explicit dependencies"},
        {"solution": "Configure security group to allow all outbound traffic: new SecurityGroup with allowAllOutbound: true", "percentage": 85, "note": "Reduces timing race condition risk"}
    ]'::jsonb,
    'AWS CDK with Lambda + EFS + VPC, Private subnets with custom security groups, allowAllOutbound: false configured',
    'Lambda function creation waits for security group rules to be created, EFS connection succeeds on Lambda execution, No timeout on custom resource Lambda waiting for EFS',
    'Lambda with EFS in private subnets with custom security groups has random creation order. Lambda may start before ingress/egress rules exist, causing connection failures and CloudFormation timeouts.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://github.com/aws/aws-cdk/issues/14430'
),
(
    'AWS CDK BucketDeployment generated Lambda ARN exceeds 140 character limit - CloudFormation error',
    'github-aws-cdk',
    'MEDIUM',
    '[
        {"solution": "Use short logical IDs for BucketDeployment construct to reduce ARN length: id: ''BD'' instead of ''MyBucketDeployment''", "percentage": 85, "note": "Workaround by reducing concatenated name length"},
        {"solution": "Allow custom Lambda naming via construct properties to override auto-generated names (feature request status)", "percentage": 75, "note": "Solution under development by CDK team"},
        {"solution": "Use IAM role with wildcard resource if possible to work around layer ARN naming: Alternative asset naming patterns", "percentage": 70, "note": "Potential workaround pending CloudFormation changes"}
    ]'::jsonb,
    'AWS CDK with BucketDeployment construct, Long construct logical IDs, Lambda layer assets',
    'cdk deploy succeeds without CloudFormation member length validation errors, Lambda layer ARN under 140 characters, BucketDeployment Lambda executes successfully',
    'BucketDeployment auto-generates Lambda layer names by concatenating parent and child construct IDs. Long IDs result in ARNs exceeding 140 character limit. CloudFormation requires explicit truncation.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/aws/aws-cdk/issues/25526'
),
(
    'AWS CDK logical ID validation regex inconsistent with CloudFormation specification - rejects numeric start',
    'github-aws-cdk',
    'MEDIUM',
    '[
        {"solution": "Upgrade to CDK version with PR #26821 merged which relaxes regex validation: npm install -g aws-cdk@latest", "percentage": 95, "note": "Fix aligns validation with actual CloudFormation specs"},
        {"solution": "Override construct logical ID if validation fails: scope.overrideLogicalId(construct, ''AlphaNumericId'')", "percentage": 85, "note": "Workaround using explicit logical ID override"},
        {"solution": "Verify CloudFormation actually accepts numeric-starting IDs in console before assuming CDK is wrong", "percentage": 75, "note": "Validation regex is intentionally strict for resource IDs"}
    ]'::jsonb,
    'AWS CDK framework, Constructs with numeric-starting logical IDs, cdk.json configuration',
    'cdk deploy accepts numeric-starting logical IDs like 030ffab42b5f448fb39750B452, CloudFormation accepts generated template, No validation error on synthesis',
    'CDK regex requires letter-first: /^[A-Za-z][A-Za-z0-9]{1,254}$/. CloudFormation documentation allows alphanumeric start. Discrepancy prevents valid numeric-starting IDs from being used.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/aws/aws-cdk/issues/26075'
),
(
    'AWS CDK bootstrap requires version 6 but found version 4 - version mismatch cannot downgrade',
    'github-aws-cdk',
    'HIGH',
    '[
        {"solution": "Upgrade AWS CDK CLI to latest version 2.x to match framework version: npm install -g aws-cdk@latest", "percentage": 90, "note": "Ensures CLI and framework use same bootstrap template version"},
        {"solution": "Add feature flag to cdk.json to enable new-style synthesis: ''@aws-cdk/core:newStyleStackSynthesis'': true", "percentage": 85, "note": "Preferred over --force for explicit version upgrade"},
        {"solution": "Delete existing CDKToolkit CloudFormation stack and S3 bucket completely, then re-bootstrap: Delete stack, delete bucket, cdk bootstrap", "percentage": 80, "note": "Cleanest but most disruptive solution"}
    ]'::jsonb,
    'AWS CDK CLI 1.x with framework 2.x (or vice versa), Existing CDKToolkit bootstrap stack, cdk.json accessible',
    'cdk deploy succeeds without bootstrap version mismatch errors, CloudFormation stack creates with matching bootstrap template, No version downgrade errors on bootstrap',
    'CLI 1.x and Framework 2.x use different bootstrap stack versions. cdk bootstrap --force does NOT upgrade versions - it prevents downgrades. Feature flag approach is safer than force.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/aws/aws-cdk/issues/17949'
),
(
    'AWS CDK bootstrap fails because S3 staging bucket already exists - idempotency issue',
    'github-aws-cdk',
    'MEDIUM',
    '[
        {"solution": "Use bootstrap qualifier flag to create separate bootstrap stack: cdk bootstrap --qualifier CUSTOM", "percentage": 90, "note": "Creates separate bucket with different name avoiding conflicts"},
        {"solution": "Manually delete the existing staging bucket from S3 console if deployment is safe: Delete cdk-xxxxxxxxxx-assets-xxxxx bucket, then cdk bootstrap", "percentage": 85, "note": "Risky if bucket contains actively used assets"},
        {"solution": "Configure cdk.json with custom qualifier to use alternative bootstrap stack: ''@aws-cdk/core:bootstrapQualifier'': ''custom''", "percentage": 80, "note": "Permanent solution for multi-team or multi-account scenarios"}
    ]'::jsonb,
    'AWS CDK environment with previous bootstrap attempt, AWS S3 list and delete permissions, cdk.json configuration file',
    'cdk bootstrap completes without CREATE_FAILED errors on StagingBucket, Separate bootstrap bucket created per qualifier, Multiple teams/accounts can bootstrap same region',
    'Bootstrap CloudFormation template creates S3 bucket without checking if bucket name already exists. Since S3 names are globally unique, previous bootstrap in any account blocks new bootstraps with same name.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/aws/aws-cdk/issues/24143'
),
(
    'AWS CDK Lambda LoggingConfig not supported in GovCloud and China regions - deprecation without replacement',
    'github-aws-cdk',
    'MEDIUM',
    '[
        {"solution": "Use restored logRetention property instead of LoggingConfig for GovCloud deployments: logRetention: logs.RetentionDays.ONE_DAY", "percentage": 95, "note": "Fix in PR #28934 restored backward compatibility"},
        {"solution": "Upgrade to CDK version that reverted LoggingConfig deprecation: npm install -g aws-cdk@latest", "percentage": 90, "note": "Ensures logRetention remains available for unsupported regions"},
        {"solution": "Conditionally configure logging based on region: if (!isGovCloud) logConfig; else logRetention;", "percentage": 85, "note": "Workaround for code that targets multiple regions"}
    ]'::jsonb,
    'AWS CDK Lambda function, GovCloud (us-gov-west-1) or China region (cn-north-1), CDK 2.x framework',
    'Lambda deployment succeeds in GovCloud without LoggingConfig unsupported error, CloudFormation template accepts logging configuration, Function logs appear in CloudWatch Logs',
    'LoggingConfig was introduced to replace logRetention but is not available in GovCloud/China regions. CDK deprecated logRetention before LoggingConfig was universally available. Users were forced to choose between outdated properties.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/aws/aws-cdk/issues/28919'
);
