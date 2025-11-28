INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Grafana Dashboards - Create and manage production-ready dashboards for system observability',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Set up dashboard hierarchy with critical metrics in stat panels, key trends in time series, and detailed metrics in tables",
      "manual": "Create panels following RED method (Rate, Errors, Duration) for services and USE method (Utilization, Saturation, Errors) for resources. Configure stat panels with thresholds, time series graphs with percentile latencies, and table panels for service status.",
      "note": "Use Grafana community dashboard templates as starting point"
    },
    {
      "solution": "Implement dashboard variables for flexibility and dynamic queries",
      "manual": "Configure query variables (label_values from Prometheus) for namespace, service, and instance. Use variables in PromQL expressions like sum(rate(http_requests_total{namespace=\"$namespace\"}[5m]))",
      "note": "Set refresh to 1 for dynamic updates and enable multi-select where needed"
    },
    {
      "solution": "Create monitoring dashboards for API, Infrastructure, and Database services",
      "manual": "For API: request rate, error rate %, p95 latency with alerts. For Infrastructure: CPU/memory per node, disk I/O, network traffic, pod counts. For Database: QPS, connection pool, query latency percentiles, replication lag.",
      "note": "Alert threshold for error rate typically >5%, configure notification channels to Slack"
    },
    {
      "solution": "Provision dashboards as code using Terraform or Ansible",
      "cli": {
        "macos": "terraform apply -var-file=dashboards.tfvars",
        "linux": "ansible-playbook deploy-dashboards.yml",
        "windows": "terraform apply -var-file=dashboards.tfvars"
      },
      "manual": "For Terraform: use grafana_dashboard resource with config_json from file. For Ansible: copy dashboard JSON files to /etc/grafana/dashboards/ and restart Grafana.",
      "note": "Use dashboards.yml for Grafana provisioning configuration"
    }
  ]'::jsonb,
  'steps',
  'Prometheus data source configured, Grafana instance running, access to PromQL',
  'Overcrowding panels, inconsistent metric naming, missing thresholds, poor color scheme, not testing with different time ranges',
  'Dashboard displays all metrics with proper color coding, alerts trigger correctly at thresholds, variables update queries dynamically',
  'Production-ready Grafana dashboards for system and application monitoring with RED/USE method principles',
  'https://skillsmp.com/skills/wshobson-agents-plugins-observability-monitoring-skills-grafana-dashboards-skill-md',
  'admin:HAIKU_SKILL_1764289744_99578'
);
