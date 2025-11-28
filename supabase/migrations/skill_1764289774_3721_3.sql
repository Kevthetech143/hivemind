INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Multi-Cloud Architecture - Design frameworks for multi-cloud systems across AWS, Azure, and GCP with service selection and migration strategies',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Cloud Service Selection Framework",
      "manual": "Compare services across AWS, Azure, GCP: Compute (EC2/VM/Compute Engine, ECS/ACI/Cloud Run, EKS/AKS/GKE, Lambda/Functions/Cloud Functions). Storage (S3/Blob/Cloud Storage, EBS/Managed Disks/Persistent Disk). Database (RDS/SQL Database/Cloud SQL, DynamoDB/Cosmos DB/Firestore). Match use case to best provider."
    },
    {
      "solution": "Multi-Cloud Patterns",
      "manual": "Pattern 1 - Single Provider + DR: primary in one cloud, disaster recovery in another with database replication and automated failover. Pattern 2 - Best-of-Breed: AI/ML on GCP, enterprise on Azure, general compute on AWS. Pattern 3 - Geographic: serve from nearest region, compliance, global LB. Pattern 4 - Cloud-Agnostic: Kubernetes, PostgreSQL, S3-compatible, open-source."
    },
    {
      "solution": "Cloud-Agnostic Architecture",
      "manual": "Use portable alternatives: Kubernetes for compute (EKS/AKS/GKE), PostgreSQL for databases, Apache Kafka for messaging, Redis for caching, S3-compatible API for storage, Prometheus/Grafana for monitoring. Implement Terraform for infrastructure abstraction layer between application and cloud APIs."
    },
    {
      "solution": "Cost Comparison and Optimization",
      "manual": "AWS: on-demand, reserved (-50%), spot, savings plans. Azure: pay-as-you-go, reserved (-50%), spot. GCP: on-demand, committed-use (-50%), preemptible. Optimize: reserved capacity (30-70% savings), spot/preemptible, right-size, serverless for variable, lifecycle policies, cost tags."
    },
    {
      "solution": "Phase 1 Assessment",
      "manual": "Inventory current infrastructure, identify dependencies, assess cloud compatibility, estimate migration costs. Document findings in assessment report."
    },
    {
      "solution": "Phase 2 Pilot Deployment",
      "manual": "Select representative pilot workload, implement in target cloud, test functionality thoroughly, document learnings and issues encountered."
    },
    {
      "solution": "Phase 3 Incremental Migration",
      "manual": "Migrate workloads in waves, maintain dual-run period for validation, monitor performance metrics, validate functionality against original system."
    },
    {
      "solution": "Phase 4 Optimization",
      "manual": "Right-size provisioned resources, implement cloud-native services to replace VMs, optimize storage costs with lifecycle policies, enhance security with cloud-native tools."
    }
  ]'::jsonb,
  'steps',
  'Understanding of cloud fundamentals, familiarity with at least one cloud provider, infrastructure as code knowledge (Terraform helpful)',
  'Vendor lock-in with provider-specific services, insufficient DR testing, missing cost controls, underestimating migration complexity, poor monitoring across clouds, inadequate security model',
  'Services selected across multiple clouds based on technical fit, cloud-agnostic patterns implemented and portable, cost tools tracking spending across providers, workloads successfully migrated and operating, DR procedures tested and documented',
  'Multi-cloud design frameworks and service selection patterns across AWS, Azure, GCP with migration and cost optimization strategies',
  'https://skillsmp.com/skills/wshobson-agents-plugins-cloud-infrastructure-skills-multi-cloud-architecture-skill-md',
  'admin:HAIKU_SKILL_1764289774_3721'
);
