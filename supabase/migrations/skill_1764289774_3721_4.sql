INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Prometheus Configuration - Set up comprehensive metric collection, scrape configuration, recording rules, and alerting for infrastructure monitoring',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Kubernetes Installation with Helm",
      "cli": {
        "macos": "helm repo add prometheus-community https://prometheus-community.github.io/helm-charts && helm repo update && helm install prometheus prometheus-community/kube-prometheus-stack --namespace monitoring --create-namespace",
        "linux": "helm repo add prometheus-community https://prometheus-community.github.io/helm-charts && helm repo update && helm install prometheus prometheus-community/kube-prometheus-stack --namespace monitoring --create-namespace",
        "windows": "helm repo add prometheus-community https://prometheus-community.github.io/helm-charts && helm repo update && helm install prometheus prometheus-community/kube-prometheus-stack --namespace monitoring --create-namespace"
      },
      "manual": "Install Prometheus on Kubernetes using Helm with kube-prometheus-stack. Set retention=30d, storageVolumeSize=50Gi. Creates Prometheus server, AlertManager, Grafana, and node exporters."
    },
    {
      "solution": "Docker Compose Setup",
      "cli": {
        "macos": "docker-compose -f docker-compose.yml up -d && sleep 5 && curl http://localhost:9090",
        "linux": "docker-compose -f docker-compose.yml up -d && sleep 5 && curl http://localhost:9090",
        "windows": "docker-compose -f docker-compose.yml up -d && timeout 5 && curl http://localhost:9090"
      },
      "manual": "Create docker-compose.yml with Prometheus image, volume for data, port 9090 exposed, config file mounted. Command args: --storage.tsdb.path=/prometheus, --storage.tsdb.retention.time=30d"
    },
    {
      "solution": "Configure prometheus.yml",
      "manual": "Set global scrape_interval (15s), evaluation_interval, external_labels (cluster, region). Define alertmanagers endpoint. Load rule_files from /etc/prometheus/rules/. Add scrape_configs for prometheus, node-exporters, kubernetes-pods, applications with relabel_configs for label manipulation."
    },
    {
      "solution": "Static Target Configuration",
      "manual": "Define scrape_configs with static_configs listing targets. Add labels for environment/region. Example: job_name: node-exporter with targets [node1:9100, node2:9100]. Use relabel_configs to extract hostname from __address__."
    },
    {
      "solution": "File-based Service Discovery",
      "manual": "Configure file_sd_configs with files glob pattern (/etc/prometheus/targets/*.json). Refresh every 5m. Create JSON/YAML files with targets array and labels dict. Targets auto-reload when files change."
    },
    {
      "solution": "Kubernetes Service Discovery",
      "manual": "Use kubernetes_sd_configs with role: pod or role: service. Add relabel_configs to filter by annotation (prometheus_io_scrape=true), set __scheme__, __metrics_path__, __address__. Labels extracted: __meta_kubernetes_pod_annotation_*, __meta_kubernetes_namespace, __meta_kubernetes_pod_name."
    },
    {
      "solution": "Recording Rules",
      "manual": "Create /etc/prometheus/rules/recording_rules.yml with groups. Define rules: job:http_requests:rate5m = sum(rate(http_requests_total[5m])) by job. Error rate percentage: (errors_rate / total_rate)*100. P95 latency: histogram_quantile(0.95, rate(http_request_duration_seconds_bucket[5m])). Resource metrics: CPU/memory/disk utilization percentages."
    },
    {
      "solution": "Alert Rules Configuration",
      "manual": "Create /etc/prometheus/rules/alert_rules.yml. Define alerts: ServiceDown (up==0 for 1m), HighErrorRate (>5% for 5m), HighLatency (p95>1s for 5m), HighCPUUsage (>80% for 5m), HighMemoryUsage (>85% for 5m), DiskSpaceLow (>90% for 5m). Set severity (critical/warning), add annotations (summary, description with template variables)."
    },
    {
      "solution": "Validation Commands",
      "cli": {
        "macos": "promtool check config prometheus.yml && promtool check rules /etc/prometheus/rules/*.yml",
        "linux": "promtool check config prometheus.yml && promtool check rules /etc/prometheus/rules/*.yml",
        "windows": "promtool.exe check config prometheus.yml && promtool.exe check rules /etc/prometheus/rules/*.yml"
      },
      "manual": "Validate prometheus.yml syntax and alert/recording rules. Test queries with promtool query instant. Check API endpoints: /api/v1/targets, /api/v1/status/config."
    },
    {
      "solution": "Troubleshooting API Checks",
      "cli": {
        "macos": "curl http://localhost:9090/api/v1/targets && curl http://localhost:9090/api/v1/status/config",
        "linux": "curl http://localhost:9090/api/v1/targets && curl http://localhost:9090/api/v1/status/config",
        "windows": "curl http://localhost:9090/api/v1/targets && curl http://localhost:9090/api/v1/status/config"
      },
      "manual": "Check scrape targets status via API. Verify configuration via /status/config endpoint. Query metrics via /api/v1/query?query=up"
    }
  ]'::jsonb,
  'script',
  'Understanding of metrics and time series, Docker or Kubernetes knowledge, familiarity with YAML configuration',
  'Incorrect scrape intervals (too frequent causes load, too slow misses events), overly broad relabel_configs rules, missing recording rules for expensive queries, insufficient retention time, poor alert threshold tuning (creates noise), not validating config before deploy',
  'Prometheus accessible on port 9090, scrape targets showing healthy status, metrics being collected and queryable, recording rules computing correctly, alerts firing appropriately without false positives',
  'Setup Prometheus for metric collection with scrape configs, recording rules, and alert rules for infrastructure and application monitoring',
  'https://skillsmp.com/skills/wshobson-agents-plugins-observability-monitoring-skills-prometheus-configuration-skill-md',
  'admin:HAIKU_SKILL_1764289774_3721'
);
