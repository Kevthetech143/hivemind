INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'ML Pipeline Workflow - Build end-to-end MLOps pipelines from data preparation through model training, validation, and production deployment.',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Pipeline Architecture & Design",
      "manual": "Design end-to-end ML workflows with DAG orchestration (Airflow, Dagster, Kubeflow). Define component dependencies, data flow between stages, and error handling/retry strategies. Create modular stages (data ingestion, validation, feature engineering, training, validation, deployment). Document stage interfaces and expected data formats."
    },
    {
      "solution": "Data Preparation Pipeline",
      "manual": "Implement data validation using Great Expectations, feature engineering transformations, and data versioning with DVC. Create train/validation/test splits with proper randomization. Document all transformations and maintain lineage tracking. Run quality checks at boundaries between stages."
    },
    {
      "solution": "Model Training Orchestration",
      "manual": "Set up training job orchestration with hyperparameter management and experiment tracking (MLflow, W&B). Implement distributed training patterns. Track all experiments and metrics. Version trained models and save model artifacts with metadata."
    },
    {
      "solution": "Model Validation Framework",
      "manual": "Implement validation test suites comparing against baseline models. Set up A/B testing infrastructure and performance regression detection. Generate performance reports before deployment approval. Monitor for data drift."
    },
    {
      "solution": "Deployment Automation",
      "manual": "Package model artifacts and deploy to serving infrastructure. Implement canary deployments starting with shadow mode. Use blue-green deployment strategies with automated rollback triggers. Monitor latency, throughput, and model performance drift post-deployment."
    }
  ]'::jsonb,
  'steps',
  'Understanding of ML lifecycle, orchestration tool knowledge (Airflow/Dagster/Kubeflow), Python/SQL proficiency',
  'Mixing orchestration logic with activity-specific concerns; insufficient idempotency checks; inadequate error handling; skipping data validation stages; deploying without baseline comparison; ignoring model drift detection',
  'Pipeline executes all stages successfully; data validation passes quality checks; model performance meets baseline; deployment completes with monitoring active; failed stages retry with backoff; alerts trigger on anomalies',
  'Design end-to-end MLOps pipelines with automatic state preservation, modularity, idempotency, and observability at every stage.',
  'https://skillsmp.com/skills/wshobson-agents-plugins-machine-learning-ops-skills-ml-pipeline-workflow-skill-md',
  'admin:HAIKU_SKILL_1764289820_8406'
);
