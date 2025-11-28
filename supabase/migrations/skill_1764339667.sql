INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email) VALUES (
  'grafana-dashboard',
  'claude-code',
  'skill',
  jsonb_build_array(
    jsonb_build_object(
      'solution', 'Create Grafana dashboard with JSON configuration defining panels, datasources, variables, and templating',
      'percentage', 85,
      'command', 'POST /api/dashboards/db with dashboard JSON'
    ),
    jsonb_build_object(
      'solution', 'Configure dashboard provisioning using YAML files in /etc/grafana/provisioning/dashboards',
      'percentage', 80,
      'command', 'Update dashboards.yaml and datasources.yaml'
    ),
    jsonb_build_object(
      'solution', 'Set up alerting rules with conditions, thresholds, and notification channels',
      'percentage', 75,
      'command', 'Create alert rules in /etc/grafana/provisioning/alerting/'
    ),
    jsonb_build_object(
      'solution', 'Use Grafana API client (JavaScript/Node.js) for programmatic dashboard management',
      'percentage', 70,
      'command', 'Instantiate GrafanaClient with baseUrl and apiKey, call createDashboard()'
    ),
    jsonb_build_object(
      'solution', 'Deploy Grafana with Docker Compose including Prometheus integration',
      'percentage', 80,
      'command', 'docker-compose up with provisioning volumes mounted'
    )
  ),
  'steps',
  'Grafana server running, Prometheus datasource configured, API key (if using API client), Docker and docker-compose (if using containerized setup)',
  jsonb_build_array(
    'Overloading dashboards with too many panels causing performance issues',
    'Missing datasource configuration before creating panels',
    'Setting refresh intervals too frequently (>5s) on large dashboards',
    'Not configuring alert notifications, leaving alerts without delivery channels',
    'Using inconsistent metric naming across panels and queries',
    'Forgetting to enable API key authentication for API-based dashboard creation',
    'Not version controlling dashboard JSON, losing history and configuration',
    'Mixing different time ranges without justification for comparison',
    'Leaving default passwords in Docker/Grafana configuration'
  ),
  jsonb_build_array(
    'Dashboard appears in Grafana UI with all panels rendering',
    'Metrics from Prometheus datasource display correctly with proper formatting',
    'Variables/templating work - dropdown selectors update panel queries',
    'Alerts trigger when metric thresholds are breached',
    'API client successfully creates/retrieves dashboards via REST endpoints',
    'Docker Compose deployment starts all services and Grafana is accessible on port 3000'
  ),
  'Professional Grafana dashboards with visualizations (graphs, stats, gauges), templating for dynamic filtering, alert rules with thresholds, Prometheus integration, and Docker deployment examples including API client for programmatic management.',
  'https://github.com/aj-geddes/useful-ai-prompts/tree/main/skills/grafana-dashboard',
  'admin:HAIKU_1764339667_24971'
);
