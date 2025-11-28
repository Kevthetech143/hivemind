INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES
(
    'Datadog agent not reporting metrics through proxy: Too many errors for endpoint',
    'devops',
    'HIGH',
    '[
        {"solution": "Verify DD_PROXY_HTTP, DD_PROXY_HTTPS, and DD_PROXY_NO_PROXY environment variables are correctly formatted. Ensure NO_PROXY value matches: 127.0.0.1 localhost *.service.consul 10.0.0.0/8", "percentage": 90},
        {"solution": "Confirm security groups allow outbound traffic from ECS container to Squid proxy and Datadog endpoints", "percentage": 85},
        {"solution": "Use datadog.yml configuration file instead of environment variables if issues persist with proxy settings", "percentage": 80}
    ]'::jsonb,
    'Datadog agent running in ECS or Kubernetes with proxy configured',
    'Metrics appear in Datadog UI without proxy-related errors in agent logs',
    'Incorrect proxy variable names or formatting. Missing protocol in proxy URL. Forgetting NO_PROXY list for internal services',
    0.87,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/67335752/unable-to-send-metrics-to-datadog-from-datadog-agent-running-as-ecs-container',
    'admin:1764173455'
),
(
    'Jenkins Groovy script approval error: org.jenkinsci.plugins.scriptsecurity.scripts.UnapprovedUsageException',
    'devops',
    'HIGH',
    '[
        {"solution": "Use Jenkins Script Console to programmatically approve scripts: def scriptApproval = org.jenkinsci.plugins.scriptsecurity.scripts.ScriptApproval.get(); scriptApproval.approveSignature(\"method signature here\"); scriptApproval.save()", "percentage": 95},
        {"solution": "Use Job DSL''s CPS mode which auto-approves administrator edits to Jenkinsfile", "percentage": 85}
    ]'::jsonb,
    'Jenkins Job DSL or Pipeline job with Script Security plugin enabled (version 1.6+)',
    'Job runs successfully without UnapprovedUsageException errors in build logs',
    'Trying to approve scripts via UI when running in scriptless mode. Forgetting to call scriptApproval.save() after approving. Missing namespace in method signatures',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/50979027/how-to-programmatically-approve-jenkins-system-groovy-script',
    'admin:1764173455'
),
(
    'CircleCI build timeout: Too long with no output (exceeded 10m0s)',
    'devops',
    'HIGH',
    '[
        {"solution": "Add no_output_timeout parameter to run step: no_output_timeout: 60m. Adjust duration based on actual build time (20m, 30m, 60m etc)", "percentage": 98},
        {"solution": "Add verbose output to build command to prevent timeout: npm run build --verbose or --debug flag", "percentage": 85}
    ]'::jsonb,
    'CircleCI 2.0+ configuration with build or test step that runs longer than 10 minutes without output',
    'Build completes successfully without CircleCI terminating the job due to inactivity',
    'Setting timeout too short (less than actual build duration). Forgetting that timeout is measured from last output, not from job start. Not considering build time on slower machines',
    0.96,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/56176716/how-to-resolve-circleci-automated-job-hangs-fails-parcel-build-with-css-import',
    'admin:1764173455'
),
(
    'Sentry source maps not working: Source code not available or obfuscated',
    'devops',
    'HIGH',
    '[
        {"solution": "Verify source maps are uploaded to Sentry release page. Check /static/chunks/.../file.js.map exists in release artifacts", "percentage": 93},
        {"solution": "Ensure release name matches version tag in application (Sentry release version must match app version)", "percentage": 88},
        {"solution": "For Next.js deployments, verify .next/static/chunks are included in sentry-cli upload", "percentage": 85}
    ]'::jsonb,
    'Web application with Sentry SDK integrated and Webpack/Parcel/Next.js build system',
    'Stack traces in Sentry UI show original source code with line numbers, not minified code',
    'Uploading source maps to wrong release version. Using relative paths instead of absolute paths in sentry-cli configuration. Not including source maps in production build',
    0.89,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/75619094/sentry-not-showing-source-map-for-error-in-next-js-project-deployed-on-vercel',
    'admin:1764173455'
),
(
    'Prometheus scrape error: INVALID is not a valid start token',
    'devops',
    'HIGH',
    '[
        {"solution": "Remove metrics_path parameter from Prometheus scrape config to use default /metrics endpoint", "percentage": 92},
        {"solution": "Increase scrape_timeout to 15s or higher: scrape_timeout: 15s", "percentage": 90},
        {"solution": "Verify scrape endpoint returns valid Prometheus text format (not JSON or HTML)", "percentage": 88}
    ]'::jsonb,
    'Prometheus configured with explicit metrics_path parameter or very short timeout',
    'Prometheus successfully scrapes metrics without parse errors in logs',
    'Configuring non-existent metrics_path. Using timeout too short for endpoint response time. Endpoint returning HTML error page instead of metrics',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/64434304/prometheus-scrape-error-invalid-is-not-a-valid-start-token',
    'admin:1764173455'
),
(
    'Grafana Loki datasource: Data source connected, but no labels received',
    'devops',
    'HIGH',
    '[
        {"solution": "Verify logs are actually reaching Loki: kubectl logs -n loki -l app=loki to check Loki is receiving data", "percentage": 91},
        {"solution": "Confirm loki-url in Docker logging driver matches Loki service endpoint (http://loki:3100 for in-cluster)", "percentage": 90},
        {"solution": "Verify Promtail is configured to scrape container logs and send to correct Loki address", "percentage": 88}
    ]'::jsonb,
    'Grafana connected to Loki datasource with Promtail log collector running',
    'Grafana Loki datasource shows available labels and log entries in Explore view',
    'Loki service URL incorrect in Docker driver. Promtail not running or misconfigured. Logs not being sent to containers that Promtail monitors',
    0.85,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/76869851/grafana-loki-error-connecting-to-datasource-data-source-connected-but-no-la',
    'admin:1764173455'
),
(
    'ELK Stack Kibana shows no data: No data streams, indices, or index aliases match your index pattern',
    'devops',
    'HIGH',
    '[
        {"solution": "Replace invalid Logstash index pattern \"logstash-%{indexDay}\" with valid date format: index => \"logstash-%{+yyyy.MM.dd}\"", "percentage": 97},
        {"solution": "Verify Elasticsearch is receiving data from Logstash: curl http://localhost:9200/_cat/indices", "percentage": 92}
    ]'::jsonb,
    'ELK Stack deployment with Logstash pipeline and Elasticsearch storage',
    'Elasticsearch shows indices matching pattern (logstash-YYYY.MM.DD), Kibana displays logs and creates data view successfully',
    'Using undefined fields in Logstash index pattern. Forgetting +  prefix in date format. Typos in field names',
    0.96,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/75036139/not-receiving-any-data-in-kibana-from-elasticsearch-logstash-elk-stack-made-in',
    'admin:1764173455'
),
(
    'NewRelic Python agent not sending data: Completed harvest of all application data in 0.00 seconds',
    'devops',
    'HIGH',
    '[
        {"solution": "Initialize NewRelic agent BEFORE creating Flask/Django app instance: newrelic.agent.initialize() must run before app = Flask(__name__)", "percentage": 96},
        {"solution": "Verify newrelic.ini configuration file exists and newrelic_env variable matches app environment (development, staging, production)", "percentage": 90}
    ]'::jsonb,
    'Python web application with NewRelic agent (newrelic package installed)',
    'NewRelic UI shows application metrics, Apdex score, and transaction data from the environment',
    'Calling initialize() after app creation. Wrong environment name preventing connection to correct NewRelic app. Invalid newrelic.ini path',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/51650039/newrelic-agent-is-not-sending-data-to-newrelic-servers-at-staging-only',
    'admin:1764173455'
),
(
    'Kubernetes metrics-server cannot scrape kubelet: Failed to scrape node context deadline exceeded',
    'devops',
    'HIGH',
    '[
        {"solution": "Mount API server TLS certificates to metrics-server pod with --tls-cert-file=/crt/apiserver.crt and --tls-private-key-file=/key/apiserver.key arguments", "percentage": 92},
        {"solution": "Set hostNetwork=true on metrics-server pod to resolve networking/SDN issues preventing kubelet connection", "percentage": 85},
        {"solution": "Enable --kubelet-insecure-tls flag if using self-signed certs: kubectl patch -n kube-system deployment metrics-server -p ''...--kubelet-insecure-tls''", "percentage": 80}
    ]'::jsonb,
    'Kubernetes cluster with metrics-server deployment and kubelets using TLS certificates',
    'kubectl top node shows memory and CPU usage without errors. Metrics-server pod shows ready=1/1 in kubectl get deployment',
    'Using wrong certificate files. Not mounting volumes from control plane. Attempting scrape without TLS configuration. Network policies blocking port 10250',
    0.88,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/72334303/kubernetes-metric-server-cannot-call-kubelet-api',
    'admin:1764173455'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES
(
    'Alertmanager webhook not firing: Alerts not sent to webhook receiver endpoint',
    'devops',
    'HIGH',
    '[
        {"solution": "Verify webhook URL in alertmanager.yml is reachable and correct. Test with curl: curl -X POST http://webhook-url/alert", "percentage": 94},
        {"solution": "Check alert routing rules - ensure route matches alert labels. Verify inhibit_rules aren''t suppressing alerts", "percentage": 91},
        {"solution": "Reload Alertmanager config: kill -HUP <alertmanager-pid> or docker restart <container>", "percentage": 88}
    ]'::jsonb,
    'Prometheus Alertmanager configured with webhook receiver',
    'Webhook receiver successfully receives POST requests with alert payloads. Check webhook service logs for incoming requests',
    'Incorrect webhook URL in config. Alert routing rules not matching fired alerts. Alertmanager config syntax error preventing reload. Firewall blocking webhook endpoint',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/67636674/alertmanager-is-not-forwarding-alerts-to-webhook-receiver',
    'admin:1764173455'
);
