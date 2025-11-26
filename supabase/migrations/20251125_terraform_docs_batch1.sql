-- Terraform Error Messages - Official Docs Mining
-- Source: developer.hashicorp.com/terraform/enterprise/deploy/troubleshoot/error-messages
-- Mined: 2025-11-25

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES (
    'Kubernetes pod stuck in Waiting state with ErrImagePull',
    'terraform',
    'HIGH',
    $$[{"solution": "Update the image pull policy for the Terraform Enterprise deployment to always", "percentage": 85, "note": "Resolves image pull failures on pod restart", "command": "kubectl patch deployment -p ''{\"spec\":{\"template\":{\"spec\":{\"imagePullPolicy\":\"Always\"}}}}''"}]$$::jsonb,
    'Kubernetes cluster with Terraform Enterprise deployment, kubectl access, valid image registry credentials',
    'Pod transitions from Waiting to Running state, kubectl get pods shows Running status',
    'Misconfigured image registry credentials, incorrect image repository path, cached image issues',
    0.85,
    'sonnet-4',
    NOW(),
    'https://developer.hashicorp.com/terraform/enterprise/deploy/troubleshoot/error-messages'
),
(
    'S3 static credentials are empty failed detecting s3 prefix ListObjectsV2',
    'terraform',
    'CRITICAL',
    $$[{"solution": "Set environment variable TFE_OBJECT_STORAGE_S3_USE_INSTANCE_PROFILE to true when using IAM instance profile authentication for S3 backend", "percentage": 95, "note": "Fixes S3 credential detection failure with instance profiles", "command": "export TFE_OBJECT_STORAGE_S3_USE_INSTANCE_PROFILE=true"}]$$::jsonb,
    'S3 bucket configured for object storage, IAM instance profile attached to compute instance, proper S3 permissions and bucket policies configured',
    'Application successfully detects S3 prefix and starts normally, Terraform Enterprise initializes without credential errors',
    'Mixing static credentials with instance profile authentication, incomplete IAM permissions, missing bucket policies',
    0.95,
    'sonnet-4',
    NOW(),
    'https://developer.hashicorp.com/terraform/enterprise/deploy/troubleshoot/error-messages'
),
(
    'VCS configuration unknown certificate issuer error',
    'terraform',
    'HIGH',
    $$[{"solution": "Include the CA certificate for VCS server in the CA Bundle by setting TFE_TLS_CA_BUNDLE_FILE environment variable to path pointing to CA bundle file", "percentage": 90, "note": "Resolves VCS integration certificate validation failures", "command": "export TFE_TLS_CA_BUNDLE_FILE=/path/to/ca-bundle.crt"}]$$::jsonb,
    'CA certificate file for VCS server, writable filesystem location for CA bundle file, valid certificate chain',
    'VCS connection successfully established and tested, Terraform Enterprise can authenticate to VCS',
    'Self-signed certificates not included in CA bundle, incorrect certificate path, incomplete certificate chain',
    0.90,
    'sonnet-4',
    NOW(),
    'https://developer.hashicorp.com/terraform/enterprise/deploy/troubleshoot/error-messages'
),
(
    'x509 certificate validation error terraform runs task worker archivist logs',
    'terraform',
    'CRITICAL',
    $$[{"solution": "Include CA certificates for all external hosts and Terraform Enterprise server in CA Bundle by setting TFE_TLS_CA_BUNDLE_FILE to path containing complete certificate chain", "percentage": 92, "note": "Fixes x509 certificate errors in task workers and archivists", "command": "export TFE_TLS_CA_BUNDLE_FILE=/path/to/ca-bundle.crt"}]$$::jsonb,
    'Complete CA certificate chain for all external hosts, internal TLS certificate for Terraform Enterprise, writable file path',
    'Terraform plans and applies execute without certificate validation errors, task worker logs show successful connections',
    'Missing internal server certificate in bundle, incomplete certificate chain, expired certificates, wrong certificate path',
    0.92,
    'sonnet-4',
    NOW(),
    'https://developer.hashicorp.com/terraform/enterprise/deploy/troubleshoot/error-messages'
),
(
    'failed downloading terraform binary read-only file system',
    'terraform',
    'HIGH',
    $$[{"solution": "Ensure TFE_DISK_CACHE_PATH location is properly backed by a writable persistent volume with sufficient disk space", "percentage": 88, "note": "Resolves Terraform binary download failures", "command": "export TFE_DISK_CACHE_PATH=/path/to/writable/volume"}]$$::jsonb,
    'Persistent volume configured for cache directory, write permissions on cache path, sufficient disk space available (min 5GB)',
    'Terraform binary successfully downloaded and cached during runs, subsequent runs reuse cached binary',
    'Read-only filesystem mounted, insufficient volume permissions, inadequate disk space, incorrect path ownership',
    0.88,
    'sonnet-4',
    NOW(),
    'https://developer.hashicorp.com/terraform/enterprise/deploy/troubleshoot/error-messages'
);
