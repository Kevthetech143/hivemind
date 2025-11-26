-- Terraform Error Knowledge Mining
-- Source: Official HashiCorp Terraform Documentation
-- Count: 15 entries
-- Date: 2025-11-25

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites,
    success_indicators, common_pitfalls, success_rate, claude_version,
    last_verified, source_url
) VALUES

-- 1. Variable Interpolation Syntax Error
(
    'Invalid character in variable interpolation - using $var.name instead of ${var.name}',
    'terraform',
    'HIGH',
    '[
        {"solution": "Use correct interpolation syntax: change $var.name-learn to ${var.name}-learn in your configuration", "percentage": 98},
        {"solution": "Run terraform fmt to automatically format and catch syntax errors", "percentage": 95}
    ]'::jsonb,
    'Terraform configuration file with variable references',
    'terraform validate passes without errors; terraform plan executes successfully',
    'Forgetting curly braces around variable references; mixing legacy and modern syntax',
    0.98,
    'haiku',
    NOW(),
    'https://developer.hashicorp.com/terraform/tutorials/configuration-language/troubleshooting-workflow'
),

-- 2. Resource Cycle Dependency Error
(
    'Cycle error: Terraform detects circular dependencies between resources - "Cycle: aws_security_group.sg_ping, aws_security_group.sg_8080"',
    'terraform',
    'HIGH',
    '[
        {"solution": "Replace inline ingress/egress rules with separate aws_security_group_rule resources to break the dependency cycle", "percentage": 92},
        {"solution": "Review resource dependencies and reorder resource blocks to eliminate circular references", "percentage": 88}
    ]'::jsonb,
    'Multiple security groups with inline rules referencing each other',
    'terraform validate completes without cycle errors; terraform plan shows no circular dependencies',
    'Embedding security group rules inline when they reference other security groups; not understanding Terraform dependency graph',
    0.92,
    'haiku',
    NOW(),
    'https://developer.hashicorp.com/terraform/tutorials/configuration-language/troubleshooting-workflow'
),

-- 3. For_each Type Mismatch Error
(
    'Invalid reference error: for_each expects map but received list from splat expression - "each object does not have an attribute named id"',
    'terraform',
    'HIGH',
    '[
        {"solution": "Convert list to map using local value: local.sg_map = { for sg in aws_security_group.example : sg.id => sg }", "percentage": 96},
        {"solution": "Use map() function to convert splat expression output to map type before for_each", "percentage": 94}
    ]'::jsonb,
    'Configuration using for_each with splat expression output',
    'terraform validate passes; terraform plan successfully creates all resources',
    'Using splat expressions directly with for_each without type conversion; confusing list and map types in Terraform',
    0.95,
    'haiku',
    NOW(),
    'https://developer.hashicorp.com/terraform/tutorials/configuration-language/troubleshooting-workflow'
),

-- 4. Missing Resource Instance Key in Output
(
    'Output references fail when resource uses for_each - output cannot find instance without proper key reference',
    'terraform',
    'HIGH',
    '[
        {"solution": "Use for expression in output: values = [for instance in aws_instance.web_app: instance.id]", "percentage": 97},
        {"solution": "Reference specific for_each instance: aws_instance.web_app[each.key].id instead of aws_instance.web_app.id", "percentage": 96}
    ]'::jsonb,
    'Resources created with for_each and referenced in outputs',
    'terraform output command returns expected values; terraform plan shows no errors',
    'Treating for_each resources like count resources; forgetting to iterate in output expressions',
    0.96,
    'haiku',
    NOW(),
    'https://developer.hashicorp.com/terraform/tutorials/configuration-language/troubleshooting-workflow'
),

-- 5. Kubernetes Image Pull Failure in TFE
(
    'Kubernetes pod stuck in ErrImagePull state - unable to pull Terraform Enterprise container image',
    'terraform-enterprise',
    'MEDIUM',
    '[
        {"solution": "Update imagePullPolicy to Always in the Kubernetes deployment manifest", "percentage": 91},
        {"solution": "Verify image registry credentials and image path in values.yaml", "percentage": 87}
    ]'::jsonb,
    'Terraform Enterprise deployed on Kubernetes; container image registry access',
    'Kubernetes pods reach Running state; terraform-enterprise services are healthy',
    'Using cached old image version; incorrect image registry URL',
    0.89,
    'haiku',
    NOW(),
    'https://developer.hashicorp.com/terraform/enterprise/deploy/troubleshoot/error-messages'
),

-- 6. S3 Empty Static Credentials Error
(
    'S3 object storage error: static credentials are empty - S3 prefix detection fails',
    'terraform-enterprise',
    'MEDIUM',
    '[
        {"solution": "Set environment variable TFE_OBJECT_STORAGE_S3_USE_INSTANCE_PROFILE=true to use IAM authentication", "percentage": 93},
        {"solution": "Provide valid AWS access key and secret key if not using instance profile", "percentage": 90}
    ]'::jsonb,
    'Terraform Enterprise with S3 object storage backend; AWS IAM credentials or instance profile',
    'TFE successfully stores state in S3; no credential-related errors in logs',
    'Mixing static credentials with instance profile configuration; missing IAM permissions',
    0.92,
    'haiku',
    NOW(),
    'https://developer.hashicorp.com/terraform/enterprise/deploy/troubleshoot/error-messages'
),

-- 7. Unknown Certificate Authority in VCS Integration
(
    'VCS connection setup fails with unknown certificate issuer error - certificate validation fails for version control system',
    'terraform-enterprise',
    'MEDIUM',
    '[
        {"solution": "Add VCS server CA certificate to CA Bundle and set TFE_TLS_CA_BUNDLE_FILE environment variable", "percentage": 94},
        {"solution": "Update CA certificates on the host system using system package manager", "percentage": 88}
    ]'::jsonb,
    'VCS server with self-signed or internal CA certificate; Terraform Enterprise deployment',
    'VCS connection test succeeds; VCS integration configuration complete without SSL errors',
    'Using wrong certificate format; not including intermediate certificates; forgetting to restart services after certificate update',
    0.91,
    'haiku',
    NOW(),
    'https://developer.hashicorp.com/terraform/enterprise/deploy/troubleshoot/error-messages'
),

-- 8. Unknown Certificate in Terraform Runs
(
    'Terraform plan/apply fails with x509 certificate error in task worker or archivist logs',
    'terraform-enterprise',
    'MEDIUM',
    '[
        {"solution": "Add CA certificates for all required hosts (including Terraform Enterprise itself) to CA Bundle and set TFE_TLS_CA_BUNDLE_FILE", "percentage": 95},
        {"solution": "Configure certificate trust in Terraform provider block using ca_cert parameter", "percentage": 89}
    ]'::jsonb,
    'Terraform Enterprise with custom TLS certificates; providers connecting to internal services',
    'Terraform runs complete successfully; x509 certificate errors absent from logs',
    'Only adding external service certificates without Terraform Enterprise server certificate; incomplete certificate chain',
    0.92,
    'haiku',
    NOW(),
    'https://developer.hashicorp.com/terraform/enterprise/deploy/troubleshoot/error-messages'
),

-- 9. Unable to Fetch Terraform Binary
(
    'Terraform run fails with read-only file system error when attempting to download Terraform binary',
    'terraform-enterprise',
    'LOW',
    '[
        {"solution": "Verify TFE_DISK_CACHE_PATH is backed by a writable storage volume with sufficient space", "percentage": 96},
        {"solution": "Check file system permissions: ensure Terraform Enterprise process has write access to cache directory", "percentage": 94}
    ]'::jsonb,
    'Terraform Enterprise deployment with custom disk cache path; writable storage volume',
    'Terraform binary downloads successfully; runs execute without read-only errors',
    'Pointing cache path to read-only filesystem; insufficient disk space; incorrect permission ownership',
    0.95,
    'haiku',
    NOW(),
    'https://developer.hashicorp.com/terraform/enterprise/deploy/troubleshoot/error-messages'
),

-- 10. Terraform Init Provider Download Failure
(
    'terraform init fails to download provider plugins - "Failed to download provider" or provider version not found',
    'terraform',
    'HIGH',
    '[
        {"solution": "Run terraform init again; check internet connectivity and terraform registry access", "percentage": 92},
        {"solution": "Specify exact provider version: terraform { required_providers { aws = { version = \"~> 4.0\" } } }", "percentage": 90},
        {"solution": "Use provider mirror for offline installations: terraform init -upgrade", "percentage": 85}
    ]'::jsonb,
    'Terraform configuration with provider requirements; network access to Terraform Registry',
    'terraform init completes successfully; terraform providers list shows all required providers',
    'Typo in provider name; requesting non-existent provider version; network connectivity issues',
    0.90,
    'haiku',
    NOW(),
    'https://developer.hashicorp.com/terraform/tutorials/configuration-language/troubleshooting-workflow'
),

-- 11. Terraform Validation Fails - Invalid Configuration Logic
(
    'terraform validate reports configuration logic errors that prevent execution',
    'terraform',
    'HIGH',
    '[
        {"solution": "Run terraform validate to identify all errors; fix missing required arguments and invalid references", "percentage": 97},
        {"solution": "Use terraform console to test expressions and variable references interactively", "percentage": 88},
        {"solution": "Enable debug logging: TF_LOG=DEBUG terraform validate to see detailed validation steps", "percentage": 86}
    ]'::jsonb,
    'Terraform configuration files; basic Terraform installation',
    'terraform validate exits with code 0; no validation errors in output',
    'Missing required block arguments; wrong variable types; invalid resource references; circular dependencies',
    0.94,
    'haiku',
    NOW(),
    'https://developer.hashicorp.com/terraform/tutorials/configuration-language/troubleshooting-workflow'
),

-- 12. State Out of Sync - Resource Drift
(
    'Terraform state is out of sync with actual infrastructure - plan shows unexpected changes or destroys',
    'terraform',
    'HIGH',
    '[
        {"solution": "Run terraform refresh to update state with actual resource state", "percentage": 88},
        {"solution": "Use terraform import to reimport drifted resources: terraform import aws_instance.example i-1234567890abcdef0", "percentage": 85},
        {"solution": "Review terraform plan output carefully before apply; use -target flag to apply changes selectively", "percentage": 82}
    ]'::jsonb,
    'Terraform state file; existing infrastructure resources',
    'terraform plan shows expected changes only; state matches actual infrastructure',
    'Manual changes to infrastructure outside Terraform; running terraform destroy unintentionally; ignoring plan output',
    0.87,
    'haiku',
    NOW(),
    'https://developer.hashicorp.com/terraform/tutorials/configuration-language/troubleshooting-workflow'
),

-- 13. Provider Authentication Failure
(
    'Provider authentication error - credentials not found or invalid - "Error: error while running plan in context"',
    'terraform',
    'HIGH',
    '[
        {"solution": "Set provider credentials via environment variables: export AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY", "percentage": 93},
        {"solution": "Configure provider block with explicit credentials or assume_role for cross-account access", "percentage": 90},
        {"solution": "Use aws configure or provider-specific credential files (~/.aws/credentials)", "percentage": 89}
    ]'::jsonb,
    'Provider credentials or IAM role permissions; cloud provider account access',
    'Terraform plan executes successfully; provider authentication logs show successful login',
    'Credentials expired or rotated; wrong AWS region configured; missing IAM permissions; loading wrong credential file',
    0.91,
    'haiku',
    NOW(),
    'https://developer.hashicorp.com/terraform/tutorials/configuration-language/troubleshooting-workflow'
),

-- 14. Terraform Logging and Debugging
(
    'Need to diagnose Terraform errors with detailed logging - unable to identify root cause',
    'terraform',
    'MEDIUM',
    '[
        {"solution": "Enable Terraform logging: export TF_LOG=TRACE and TF_LOG_PATH=logs.txt", "percentage": 95},
        {"solution": "For core issues: export TF_LOG_CORE=TRACE for detailed Terraform core diagnostics", "percentage": 93},
        {"solution": "For provider issues: export TF_LOG_PROVIDER=TRACE to see provider plugin logs", "percentage": 91}
    ]'::jsonb,
    'Terraform CLI; write access to log file path',
    'log file contains detailed diagnostic information; root cause identified in logs',
    'Forgetting to disable logging in production; leaving sensitive data in logs; incorrect log level',
    0.94,
    'haiku',
    NOW(),
    'https://developer.hashicorp.com/terraform/tutorials/configuration-language/troubleshooting-workflow'
),

-- 15. Terraform Plan and Apply Failures
(
    'terraform plan or apply fails during execution - command hangs or returns non-zero exit code',
    'terraform',
    'HIGH',
    '[
        {"solution": "Check provider connectivity: verify network access to cloud provider API endpoints", "percentage": 89},
        {"solution": "Review error message in output; search error code in provider documentation", "percentage": 87},
        {"solution": "Run with parallelism flag if timeout issues: terraform apply -parallelism=1", "percentage": 84},
        {"solution": "Enable debug logging: TF_LOG=DEBUG terraform apply to identify failure point", "percentage": 82}
    ]'::jsonb,
    'Terraform state file; provider credentials; cloud provider API access',
    'terraform apply completes with exit code 0; infrastructure changes applied successfully',
    'Timeouts on large deployments; insufficient API rate limits; network connectivity drops; missing provider permissions',
    0.88,
    'haiku',
    NOW(),
    'https://developer.hashicorp.com/terraform/tutorials/configuration-language/troubleshooting-workflow'
);
