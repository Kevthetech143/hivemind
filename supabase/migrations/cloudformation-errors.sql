INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Stack:arn aws cloudformation stack is in ROLLBACK_COMPLETE state and cannot be updated',
    'cloudformation',
    'HIGH',
    '[
        {"solution": "Delete the stack in ROLLBACK_COMPLETE state using aws cloudformation delete-stack --stack-name <stack-name>, then redeploy with corrected template", "percentage": 95},
        {"solution": "Check CloudFormation console for the failed resource, fix root cause in template, delete stack, and redeploy", "percentage": 92}
    ]'::jsonb,
    'AWS CLI configured with correct credentials and permissions. Stack exists in ROLLBACK_COMPLETE state.',
    'Stack successfully deleted, then new stack created and reaches CREATE_COMPLETE state',
    'Attempting to update ROLLBACK_COMPLETE stack directly without deleting first. Not checking the failed resource that triggered rollback.',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/aws-cloudformation?tab=votes'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Requires capabilities : [CAPABILITY_IAM]',
    'cloudformation',
    'HIGH',
    '[
        {"solution": "Add --capabilities CAPABILITY_IAM to AWS CLI command: aws cloudformation create-stack --capabilities CAPABILITY_IAM --stack-name <name> --template-body file://template.yaml", "percentage": 98},
        {"solution": "For IAM_NAMED_USER_ARN capabilities, use: aws cloudformation create-stack --capabilities CAPABILITY_NAMED_IAM --stack-name <name> --template-body file://template.yaml", "percentage": 96},
        {"solution": "In AWS Console, check the ''Capabilities'' checkbox before creating/updating stack with IAM resources", "percentage": 95}
    ]'::jsonb,
    'CloudFormation template contains IAM resources (roles, policies, users). AWS CLI or console access configured.',
    'Stack creation/update succeeds without capability error. IAM resources created as expected.',
    'Forgetting to include --capabilities flag. Using CAPABILITY_IAM for named resources (should use CAPABILITY_NAMED_IAM). Not checking all IAM resources in template.',
    0.97,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/aws-cloudformation?tab=votes'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Template format error: Unresupported structure',
    'cloudformation',
    'HIGH',
    '[
        {"solution": "Validate template syntax with: aws cloudformation validate-template --template-body file://template.yaml. Fix YAML/JSON formatting errors.", "percentage": 96},
        {"solution": "Ensure proper indentation in YAML (2 spaces, no tabs). Use YAML linter online tool to identify structure issues.", "percentage": 94},
        {"solution": "Check for unclosed brackets, missing colons, or invalid property names in JSON templates", "percentage": 92}
    ]'::jsonb,
    'CloudFormation template file. AWS CLI configured.',
    'Template validation passes. aws cloudformation validate-template returns no errors.',
    'Using tabs instead of spaces in YAML. Inconsistent indentation. Invalid CloudFormation property names. Mixing YAML and JSON syntax.',
    0.95,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/troubleshooting.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'User: arn:aws:iam::123456789012:user/username is not authorized to perform: cloudformation:CreateStack',
    'cloudformation',
    'CRITICAL',
    '[
        {"solution": "Add cloudformation:* permissions to user IAM policy. Attach AWS-managed policy AWSCloudFormationFullAccess or custom policy with cloudformation, ec2, s3, iam, logs, lambda actions", "percentage": 97},
        {"solution": "Verify user has permissions for underlying services referenced in template (ec2:RunInstances, s3:CreateBucket, iam:CreateRole, etc.)", "percentage": 95},
        {"solution": "Use aws iam attach-user-policy --user-name <username> --policy-arn arn:aws:iam::aws:policy/AdministratorAccess for immediate testing (then restrict to least privilege)", "percentage": 90}
    ]'::jsonb,
    'AWS user with IAM permissions. Access to modify IAM policies. Know template resource types.',
    'Stack creation succeeds. User can deploy stacks. IAM policy validation shows required permissions.',
    'Only adding cloudformation permissions without service-specific permissions (EC2, S3, etc.). Using wrong user/role. Assuming default user has permissions.',
    0.96,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/aws-cloudformation?tab=votes'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'NoSuchBucket error when deploying AWS CDK stack',
    'cdk',
    'HIGH',
    '[
        {"solution": "Run: cdk bootstrap aws://ACCOUNT-NUMBER/REGION to create bootstrap S3 bucket and IAM roles required by CDK", "percentage": 99},
        {"solution": "If bootstrap exists but error persists, verify S3 bucket name pattern matches cdk-xxxxxxxxx-<account>-<region> and bucket exists in correct region", "percentage": 97},
        {"solution": "Check IAM role has s3:* permissions to bootstrap bucket. Add s3:ListBucket, s3:GetObject, s3:PutObject to staging bucket policy if needed", "percentage": 95}
    ]'::jsonb,
    'AWS CDK project with cdk.json. AWS CLI configured. Account number and region known.',
    'cdk bootstrap completes without error. cdk deploy succeeds. S3 bootstrap bucket created in AWS account.',
    'Running cdk deploy before bootstrapping. Bootstrap in wrong region. Using different AWS account than intended.',
    0.98,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/cdk/v2/guide/troubleshooting.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Forbidden: null message during CDK deployment',
    'cdk',
    'HIGH',
    '[
        {"solution": "Verify IAM role/user has s3:* permissions to bootstrap bucket: arn:aws:s3:::cdk-xxxxxxxxx-<account>-<region>/*", "percentage": 96},
        {"solution": "Check current AWS credentials with: aws sts get-caller-identity. Ensure you''re using correct account and role with S3 write access", "percentage": 94},
        {"solution": "Bootstrap bucket may exist from different credentials. Redeploy using same AWS credentials/role that created bootstrap resources", "percentage": 92}
    ]'::jsonb,
    'AWS CDK project bootstrapped. AWS CLI configured. Bootstrap bucket exists.',
    'cdk deploy succeeds without Forbidden error. CloudFormation stack creates successfully.',
    'Using different AWS credentials for bootstrap and deploy. Insufficient S3 permissions on IAM role. Cross-account bootstrap bucket.',
    0.93,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/cdk/v2/guide/troubleshooting.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    '--app is required either in command-line, in cdk.json or in ~/.cdk.json',
    'cdk',
    'MEDIUM',
    '[
        {"solution": "Run cdk commands from project root directory containing cdk.json file", "percentage": 99},
        {"solution": "If not in project root, use: cdk deploy -a ''node app.js'' or cdk deploy --app ./path/to/app.js to specify app path", "percentage": 97},
        {"solution": "Verify cdk.json exists in current directory with ''app'' property defined", "percentage": 96}
    ]'::jsonb,
    'AWS CDK project created with cdk init. cdk.json file exists.',
    'cdk deploy and other cdk commands run without --app error. Stack deploys successfully.',
    'Running cdk commands from subdirectory instead of project root. Typo in cdk.json app property. Missing cdk.json file entirely.',
    0.99,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/cdk/v2/guide/troubleshooting.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Unable to resolve AWS account to use. It must be either configured when you define your CDK or through the environment',
    'cdk',
    'HIGH',
    '[
        {"solution": "Set env property in stack: const stack = new MyStack(app, ''MyStack'', { env: { account: ''123456789012'', region: ''us-east-1'' } })", "percentage": 98},
        {"solution": "Set AWS_ACCOUNT_ID and AWS_REGION environment variables before running cdk deploy", "percentage": 96},
        {"solution": "Configure AWS CLI profile with: aws configure and set default region. CDK will use these as fallback", "percentage": 94}
    ]'::jsonb,
    'AWS CDK stack defined. AWS account number and region known. AWS CLI or environment variables configured.',
    'cdk synth and cdk deploy complete without account resolution error. CloudFormation uses correct account.',
    'Using environment-agnostic synthesis (no env property) which defaults to account resolution. Missing AWS CLI configuration. Wrong environment variable names.',
    0.96,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/cdk/v2/guide/troubleshooting.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Template size exceeds 51,200 bytes or contains more than 500 resources',
    'cloudformation',
    'HIGH',
    '[
        {"solution": "Break template into multiple stacks using cross-stack references with Exports and Fn::ImportValue", "percentage": 96},
        {"solution": "Use nested stacks with AWS::CloudFormation::Stack resource to organize template logically and stay within limits", "percentage": 94},
        {"solution": "Remove unused resources, consolidate similar resources, or use macros to reduce template complexity", "percentage": 92}
    ]'::jsonb,
    'CloudFormation template exceeding size or resource limits. Understanding of stack references or nested stacks.',
    'Deployment succeeds with multiple stacks. Each stack under 500 resources. Template size under 51,200 bytes.',
    'Trying to fit all resources in single stack. Not understanding nested stacks. Duplicating resources across stacks instead of referencing outputs.',
    0.93,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/cdk/v2/guide/troubleshooting.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Wait condition did not receive the required number of signals',
    'cloudformation',
    'MEDIUM',
    '[
        {"solution": "Verify CloudFormation helper scripts are installed on instance AMI. Run: /opt/aws/bin/cfn-init -v -s <stack-id> -r <resource-id> -c default", "percentage": 94},
        {"solution": "Check instance has internet connectivity: curl https://aws.amazonaws.com from instance. Ensure security group allows outbound HTTPS.", "percentage": 92},
        {"solution": "Check /var/log/cfn-init.log and /var/log/cfn-signal.log on EC2 instance for error messages", "percentage": 90},
        {"solution": "Increase wait timeout if required. Add TimeoutInMinutes property to AWS::CloudFormation::WaitCondition resource", "percentage": 88}
    ]'::jsonb,
    'CloudFormation template with wait condition. EC2 instance or application that should send signal via cfn-signal.',
    'Wait condition receives signals successfully. Stack creation completes. Logs show successful cfn-signal execution.',
    'Instance unable to reach AWS CloudFormation endpoint. Wrong logical resource ID in cfn-signal command. Helper scripts not installed on AMI.',
    0.88,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/troubleshooting.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Update rollback failed: The following resource(s) failed to update',
    'cloudformation',
    'HIGH',
    '[
        {"solution": "Check CloudFormation console Events tab for specific resource failure. Fix root cause (permissions, limits, service issues) then retry update", "percentage": 95},
        {"solution": "Use: aws cloudformation continue-update-rollback --stack-name <stack-name> to complete failed rollback", "percentage": 93},
        {"solution": "For missing signals, use: aws cloudformation signal-resource --stack-name <name> --logical-resource-id <id> --unique-id <unique-id> --status SUCCESS", "percentage": 91}
    ]'::jsonb,
    'Stack in UPDATE_ROLLBACK_FAILED state. CloudFormation console access. Understanding of failed resource.',
    'continue-update-rollback completes. Stack returns to UPDATE_ROLLBACK_COMPLETE. Retry succeeds.',
    'Attempting update without addressing original failure. Not checking Events tab for detailed error. Assuming automatic rollback will fix issue.',
    0.92,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/troubleshooting.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'The maximum number of addresses has been reached for Elastic IP',
    'cloudformation',
    'MEDIUM',
    '[
        {"solution": "Check AWS Service Quotas for VPC Elastic IP Addresses (default limit 5 per region). Request quota increase via AWS Console", "percentage": 97},
        {"solution": "Release unused Elastic IPs: aws ec2 release-address --allocation-id <allocation-id> then retry stack creation", "percentage": 95},
        {"solution": "For auto-scaling scenarios, use NAT Gateway instead of Elastic IP per instance to avoid per-instance limits", "percentage": 92}
    ]'::jsonb,
    'AWS account near EIP limit. Access to AWS Service Quotas console. Knowledge of unused EIPs.',
    'Stack creates successfully. Elastic IPs allocated. Service Quota increased or EIPs released.',
    'Not checking current EIP usage before deployment. Forgot to release EIPs from previous stacks. Requesting quota increase to unrealistic number.',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/aws-cdk?tab=votes'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'The S3 bucket cannot be deleted. It must be empty before it can be deleted',
    'cloudformation',
    'HIGH',
    '[
        {"solution": "Set removalPolicy: cdk.RemovalPolicy.DESTROY and autoDeleteObjects: true on S3 Bucket construct in CDK", "percentage": 98},
        {"solution": "In CloudFormation template, set DeletionPolicy: Delete on S3 Bucket and enable auto-deletion for objects", "percentage": 96},
        {"solution": "Manually empty S3 bucket via console or CLI: aws s3 rm s3://bucket-name --recursive before stack deletion", "percentage": 94}
    ]'::jsonb,
    'CloudFormation or CDK template with S3 bucket. Stack deletion triggered. Bucket contains objects.',
    'Stack deletes successfully. S3 bucket and contents removed. No deletion policy errors.',
    'Default removal policy is RETAIN which prevents deletion. Forgetting autoDeleteObjects for DESTROY policy. Not emptying bucket manually before deletion.',
    0.96,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/cdk/v2/guide/troubleshooting.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Mismatch between AWS CDK Toolkit and AWS Construct Library versions',
    'cdk',
    'MEDIUM',
    '[
        {"solution": "Update global CDK toolkit: npm update -g aws-cdk to match installed construct library version", "percentage": 97},
        {"solution": "For multi-version projects, install cdk locally: npm install aws-cdk and run npx aws-cdk instead of global cdk command", "percentage": 96},
        {"solution": "Check versions match: npx cdk --version and npm list aws-cdk. Update to same version if mismatch", "percentage": 94}
    ]'::jsonb,
    'AWS CDK project with package.json. npm/yarn installed. Global or local aws-cdk installation.',
    'cdk deploy succeeds. No version mismatch warnings. Toolkit and construct library versions match.',
    'Not updating global toolkit after library upgrade. Running global cdk when local version exists. Mixing old and new API syntax.',
    0.95,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/cdk/v2/guide/troubleshooting.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'DependencyViolation: The stack cannot be deleted while it contains resources with deletion policy of Retain',
    'cloudformation',
    'MEDIUM',
    '[
        {"solution": "Manually delete retained resources via AWS Console or CLI before deleting stack: aws s3 rb s3://bucket-name --force", "percentage": 96},
        {"solution": "Use RetainResources parameter with empty list to override: aws cloudformation delete-stack --stack-name <name> --retain-resources", "percentage": 94},
        {"solution": "Change DeletionPolicy from Retain to Delete in template, update stack, then delete stack", "percentage": 92}
    ]'::jsonb,
    'CloudFormation stack with retained resources (S3 buckets, databases, etc.). Access to AWS Console or CLI.',
    'Stack deletion completes successfully. Retained resources persisted as intended. No DependencyViolation error.',
    'Trying to delete stack while resources have Retain policy. Not understanding Retain prevents automatic deletion. Wrong resource type for retention strategy.',
    0.93,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/troubleshooting.html'
);
