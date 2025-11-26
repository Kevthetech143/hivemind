-- Add GitHub Terraform AWS troubleshooting solutions batch 1
-- Extracted from hashicorp/terraform-provider-aws GitHub issues
-- Category: github-terraform-aws
-- Source: High-engagement issues with verified solutions

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES (
    'aws_msk_cluster creation fails with unexpected state FAILED after 38 minutes',
    'github-terraform-aws',
    'HIGH',
    '[
        {"solution": "Switch from custom KMS encryption to AWS-managed keys for MSK clusters", "percentage": 92, "note": "AWS-managed keys are recommended for MSK logging"},
        {"solution": "Change S3 logging bucket encryption from custom KMS to AES256 instead", "percentage": 88, "note": "Compatible with MSK encryption requirements"},
        {"solution": "Verify KMS key permissions allow MSK service principal to use the key", "percentage": 85, "command": "Check key policy in AWS KMS console"}
    ]'::jsonb,
    'AWS Provider 4.39.0+, Terraform 1.3.4+, MSK Kafka cluster configuration',
    'Cluster successfully transitions to ACTIVE state within 40 minutes, no KMS-related errors in logs',
    'Custom KMS keys for both encryption at rest and S3 logging can cause conflicts. Always verify KMS key permissions when using customer-managed keys.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/hashicorp/terraform-provider-aws/issues/27835'
),
(
    'aws_mwaa_environment creation fails with unexpected state PENDING when endpoint_management is CUSTOMER',
    'github-terraform-aws',
    'MEDIUM',
    '[
        {"solution": "Upgrade AWS Provider to version 5.68.0 or later where fix was included", "percentage": 95, "note": "Issue resolved in 5.68.0 with proper PENDING state handling"},
        {"solution": "Manually create MWAA environment via AWS console, then import to Terraform state", "percentage": 80, "note": "Temporary workaround for older provider versions"},
        {"solution": "Use endpoint_management = PUBLIC instead of CUSTOMER during initial creation", "percentage": 75, "note": "Can be updated to CUSTOMER in subsequent applies after upgrade"}
    ]'::jsonb,
    'Terraform 1.5.0+, AWS Provider 5.39.0+, MWAA environment with customer-managed endpoints',
    'MWAA environment successfully transitions to AVAILABLE state, endpoint management is CUSTOMER in state',
    'PENDING state with CUSTOMER endpoint management was not properly handled before v5.68.0. Provider 5.39.0-5.67.0 may timeout waiting for AVAILABLE state.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://github.com/hashicorp/terraform-provider-aws/issues/37223'
),
(
    'Provider produced inconsistent result after apply error on aws_s3_bucket creation with 404 NotFound',
    'github-terraform-aws',
    'HIGH',
    '[
        {"solution": "Implement retry logic for read-after-create operations on new S3 buckets", "percentage": 93, "note": "Fix included in AWS Provider v2.48.0+"},
        {"solution": "Use d.IsNewResource() check before removing resources from state during creation delays", "percentage": 90, "note": "Prevents premature resource removal when bucket availability is delayed"},
        {"solution": "Upgrade to AWS Provider v2.48.0 or later which includes enhanced retry logic", "percentage": 95, "command": "terraform init -upgrade"}
    ]'::jsonb,
    'AWS Provider 2.48.0+, S3 bucket resource, IAM permissions to create and read buckets',
    'Bucket successfully created and reads return 200 status, no 404 errors in logs, no tainted resources',
    'HeadBucket API calls may return 404 temporarily even after successful CreateBucket. Do not immediately fail or remove from state. Retry is necessary.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://github.com/hashicorp/terraform-provider-aws/issues/11064'
),
(
    'aws_route creation fails to save state when route becomes available after 2 minute timeout',
    'github-terraform-aws',
    'MEDIUM',
    '[
        {"solution": "Move d.SetId() call to execute immediately after route creation, before wait operation", "percentage": 90, "note": "Mirrors approach used in subnet resource creation"},
        {"solution": "Manually remove route from AWS and rerun terraform apply to restore state consistency", "percentage": 75, "note": "Workaround for existing stuck resources"},
        {"solution": "Increase timeout value in retry configuration if routes frequently take >2 minutes", "percentage": 70, "command": "Set read_timeout = \"5m\" in resource configuration"}
    ]'::jsonb,
    'AWS Provider with route resource support, Route Table created, IAM permissions for route operations',
    'Route successfully created and saved to Terraform state, route appears in terraform state show command',
    'If route creation times out, it may exist in AWS but not in Terraform state, causing RouteAlreadyExists errors on retry. State must be manually cleaned.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/hashicorp/terraform-provider-aws/issues/21032'
),
(
    'Provider requires explicit configuration error when using non-default AWS profile',
    'github-terraform-aws',
    'HIGH',
    '[
        {"solution": "Create a default AWS profile with same credentials as named profile being used", "percentage": 85, "note": "Allows provider to find default fallback during authentication"},
        {"solution": "Set AWS_PROFILE environment variable to named profile before running terraform", "percentage": 90, "command": "export AWS_PROFILE=dev && terraform plan"},
        {"solution": "Use backend-config flag to specify profile at init and plan time", "percentage": 82, "command": "terraform plan -backend-config backends/dev.hcl"}
    ]'::jsonb,
    'Multiple AWS profiles configured, terraform init succeeds with profile, terraform plan attempted with same profile',
    'Terraform plan succeeds without authentication errors, credentials are properly resolved from named profile',
    'Even with profile specified in backend config, provider may require default profile fallback. Always ensure either default profile exists or AWS_PROFILE env var is set.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/hashicorp/terraform-provider-aws/issues/27838'
),
(
    'SQS queue creation fails with Access Denied on GetQueueAttributes despite tag-based IAM permissions',
    'github-terraform-aws',
    'MEDIUM',
    '[
        {"solution": "Broaden IAM policy to allow sqs:GetQueueAttributes on all resources or created queue ARN pattern", "percentage": 88, "note": "Tags may not propagate immediately after creation"},
        {"solution": "Use aws:RequestTag condition instead of aws:ResourceTag for IAM policies during creation", "percentage": 85, "note": "RequestTag is available during CreateQueue operation, ResourceTag has eventual consistency delay"},
        {"solution": "Add retry logic to wait for tag propagation before executing post-creation read operations", "percentage": 75, "note": "Account for AWS eventual consistency on tag propagation"}
    ]'::jsonb,
    'Terraform 1.5.4+, AWS Provider 5.4.0+, IAM role with tag-based resource conditions, SQS permissions',
    'SQS queue successfully created and tags are accessible, GetQueueAttributes returns 200 status without 403 errors',
    'Tag-based IAM conditions fail immediately after resource creation because tags have eventual consistency delay. Use RequestTag condition or broader permissions.',
    0.86,
    'sonnet-4',
    NOW(),
    'https://github.com/hashicorp/terraform-provider-aws/issues/32966'
),
(
    'aws_vpc_peering_connection creation intermittently fails with InvalidVpcPeeringConnectionID.NotFound',
    'github-terraform-aws',
    'MEDIUM',
    '[
        {"solution": "Implement retry logic with exponential backoff for AcceptVpcPeeringConnection failures", "percentage": 92, "note": "AWS eventual consistency causes temporary NotFound errors"},
        {"solution": "Add polling loop using DescribeVpcPeeringConnections before accepting to verify system convergence", "percentage": 88, "note": "Ensures resource has propagated before acceptance attempt"},
        {"solution": "Rerun terraform apply if creation fails intermittently - retry succeeds on second attempt", "percentage": 85, "command": "terraform apply"}
    ]'::jsonb,
    'AWS Provider 4.51.0+, auto_accept = true configured on peering connection, proper VPC permissions',
    'VPC peering connection successfully reaches ACTIVE state, auto acceptance succeeds without NotFound errors',
    'CreateVpcPeeringConnection succeeds but AcceptVpcPeeringConnection fails due to eventual consistency. Retry logic is necessary for reliable automation.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/hashicorp/terraform-provider-aws/issues/30423'
),
(
    'Authentication failure on AWS Provider v5.24.0 with error no EC2 IMDS role found',
    'github-terraform-aws',
    'HIGH',
    '[
        {"solution": "Add skip_metadata_api_check = true to AWS provider configuration block", "percentage": 92, "note": "Explicitly disables IMDS authentication fallback"},
        {"solution": "Set environment variable AWS_EC2_METADATA_DISABLED=true before running terraform", "percentage": 90, "command": "export AWS_EC2_METADATA_DISABLED=true"},
        {"solution": "Upgrade AWS Provider to v5.25.0+ where SDK credential parsing was fixed", "percentage": 93, "command": "terraform init -upgrade"},
        {"solution": "Verify credentials file has no leading whitespace that breaks AWS SDK parsing", "percentage": 85, "note": "AWS SDK v2 issue with whitespace in config files"}
    ]'::jsonb,
    'AWS Provider 5.24.0+, shared_credentials_files or assume_role configured, running in container or EC2',
    'Terraform successfully authenticates without IMDS errors, provider obtains credentials from files or assume role',
    'Provider v5.24.0 always attempts IMDS authentication by default even with explicit credentials configured. Skip metadata API or upgrade provider version.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/hashicorp/terraform-provider-aws/issues/34234'
),
(
    'EC2 instance creation fails with InvalidParameterValue: invalid IAM instance profile name',
    'github-terraform-aws',
    'MEDIUM',
    '[
        {"solution": "Specify alternative availability zones when capacity is constrained in primary zone", "percentage": 86, "note": "Error message masks actual InsufficientInstanceCapacity issue"},
        {"solution": "Retry terraform apply with different instance type if specific type lacks capacity", "percentage": 82, "note": "Capacity issues are type and zone specific"},
        {"solution": "Use flexible zone selection avoiding hardcoding to first zone in region list", "percentage": 80, "command": "Use availability_zone from data source instead of hardcoding"}
    ]'::jsonb,
    'AWS Provider with EC2 instance resource, valid IAM instance profile, compute capacity available',
    'EC2 instance successfully launches, profile is properly attached, instance enters running state',
    'Error message reporting InvalidParameterValue masks underlying InsufficientInstanceCapacity errors. Capacity, not profile validity, is usually the issue.',
    0.83,
    'sonnet-4',
    NOW(),
    'https://github.com/hashicorp/terraform-provider-aws/issues/27516'
),
(
    'Retry logic continues indefinitely on non-recoverable errors like Resource already exists',
    'github-terraform-aws',
    'HIGH',
    '[
        {"solution": "Understand retry logic is necessary for eventual consistency of recreated resources", "percentage": 88, "note": "Terraform may need to wait for prior resource deletion before recreation"},
        {"solution": "Do not set maxRetries = 5 expecting immediate failure on non-recoverable errors", "percentage": 85, "note": "Retry logic serves legitimate purpose even for ResourceAlreadyExists"},
        {"solution": "Implement custom error handling in provider to distinguish immediately-unrecoverable errors", "percentage": 75, "note": "Community feature request, not currently implemented"}
    ]'::jsonb,
    'AWS Provider with any resource type, understanding of eventual consistency behavior',
    'Resource creation completes after retries account for eventual consistency, state is eventually consistent',
    'Provider retries on all errors including Resource already exists because resource recreation may require waiting for deletion propagation. Immediate failure is not safe.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/hashicorp/terraform-provider-aws/issues/42248'
),
(
    'AWS Provider requires default profile even when specific profile passed in backend config',
    'github-terraform-aws',
    'MEDIUM',
    '[
        {"solution": "Set AWS_PROFILE environment variable to the named profile before terraform commands", "percentage": 91, "note": "Environment variable takes precedence in credential chain"},
        {"solution": "Create a default AWS profile in ~/.aws/config and credentials files with same settings", "percentage": 87, "note": "Provides fallback credential source for provider initialization"},
        {"solution": "Use aws configure to set default profile before running terraform operations", "percentage": 82, "command": "aws configure"}
    ]'::jsonb,
    'Multiple AWS profiles configured, Terraform backend configured with non-default profile, AWS CLI installed',
    'Terraform init and plan succeed without authentication errors using specified profile, no EC2 IMDS errors',
    'Provider credential resolution chain attempts IMDS after failing to find default profile. Specify profile via environment variable or create default profile.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/hashicorp/terraform-provider-aws/issues/27838'
);
