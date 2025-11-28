INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'SLO Implementation - Define and implement Service Level Indicators and Objectives with error budgets and alerting',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Define SLI Types",
      "manual": "Identify appropriate SLI types: Availability (successful requests / total), Latency (requests below threshold / total), or Durability (successful writes / total). Use Prometheus queries to measure actual performance."
    },
    {
      "solution": "Set SLO Targets",
      "manual": "Choose SLO percentages (99%, 99.9%, 99.95%, 99.99%) based on user expectations, business requirements, and downtime tolerance. Consider competitor benchmarks and current performance capabilities."
    },
    {
      "solution": "Calculate Error Budget",
      "manual": "Error Budget = 1 - SLO Target. For 99.9% SLO: 43.2 minutes downtime allowed per month. Track remaining budget and implement error budget policy: 100% = normal velocity, 50% = risky changes considered, 10% = non-critical freeze, 0% = feature freeze."
    },
    {
      "solution": "Implement Prometheus Rules",
      "cli": {
        "macos": "prometheus-config-reload && promtool check rules prometheus-rules.yml",
        "linux": "prometheus-reload && promtool check rules prometheus-rules.yml",
        "windows": "promtool.exe check rules prometheus-rules.yml"
      },
      "manual": "Create recording rules for SLI calculations (sli:http_availability:ratio, sli:http_latency:ratio) and SLO compliance checks (slo:http_availability:compliance). Include error budget remaining calculations."
    },
    {
      "solution": "Configure Multi-Window Burn Alerts",
      "manual": "Set up fast burn alerts (14.4x rate, 1h window - consumes 2% budget/hour) and slow burn alerts (6x rate, 6h window - consumes 5% budget/6h) to reduce false positives. Require both short and long window thresholds."
    },
    {
      "solution": "Create SLO Dashboard",
      "manual": "Build Grafana dashboard showing: current SLO compliance percentage, error budget remaining bar chart, SLI trend over 28 days, and burn rate analysis. Add threshold indicators for target SLO."
    },
    {
      "solution": "Establish Review Process",
      "manual": "Weekly: check compliance and budget status. Monthly: review achievement and incidents. Quarterly: validate SLO relevance and adjust targets based on business goals."
    }
  ]'::jsonb,
  'steps',
  'Prometheus setup with metric instrumentation, understanding of service reliability targets, familiarity with PromQL queries',
  'Setting SLO too high (99.99% is costly), missing multi-window alert combinations (causes noise), ignoring error budget usage patterns, not documenting SLO decisions, insufficient SLI coverage',
  'SLO compliance visible on dashboard, burn rate alerts firing appropriately without false positives, error budget tracked and decreasing predictably, incident impact visible in SLI metrics',
  'Framework for defining service reliability targets using SLIs, SLOs, and error budgets with Prometheus alerts and dashboards',
  'https://skillsmp.com/skills/wshobson-agents-plugins-observability-monitoring-skills-slo-implementation-skill-md',
  'admin:HAIKU_SKILL_1764289774_3721'
);
