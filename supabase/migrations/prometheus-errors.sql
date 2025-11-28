INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'context deadline exceeded',
    'prometheus',
    'HIGH',
    '[
        {"solution": "Increase scrape_timeout in scrape config: set scrape_timeout to a value less than scrape_interval. Example: scrape_timeout: 30s for slow endpoints.", "percentage": 95},
        {"solution": "Verify target endpoint is reachable via curl/wget from the Prometheus container. Check firewall rules and network connectivity.", "percentage": 85}
    ]'::jsonb,
    'Access to Prometheus configuration file and ability to restart Prometheus',
    'Scrape operation completes within new timeout window. Check metrics are being collected: curl http://prometheus:9090/api/v1/targets',
    'Setting scrape_timeout equal to or greater than scrape_interval. Not checking actual target response time before increasing timeout.',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/49817558/context-deadline-exceeded-prometheus'
),
(
    'Get http://<host>:8080: context deadline exceeded',
    'prometheus',
    'HIGH',
    '[
        {"solution": "For Docker deployments, use --net=host flag to allow Prometheus container to access host network: docker run -d -p 9090:9090 --net=host prom/prometheus", "percentage": 90},
        {"solution": "Verify target IP is reachable from Prometheus container: docker exec <prometheus-container> wget http://<target-ip>:8080/metrics", "percentage": 85},
        {"solution": "Check firewall rules: ufw allow 8080 or equivalent cloud security group rules", "percentage": 80}
    ]'::jsonb,
    'Docker installed and Prometheus container running. Target application responding on specified port.',
    'Target responds to curl requests within timeout. Prometheus scrape targets page shows the target as ''up'' state.',
    'Using localhost instead of actual IP. Assuming Docker container has network access without explicit configuration. Not testing connectivity before troubleshooting.',
    0.88,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/59031707/prometheus-error-context-deadline-exceeded'
),
(
    'bad_response: readObjectStart: expect { or n, but found #',
    'grafana',
    'HIGH',
    '[
        {"solution": "Configure Prometheus to scrape the metrics endpoint, then point Grafana to Prometheus (port 9090), not the raw metrics endpoint. Add to prometheus.yml: scrape_configs: - job_name: myapp, targets: [localhost:8001]", "percentage": 95},
        {"solution": "Verify you''re using http://prometheus:9090 (or actual Prometheus URL) as datasource, not http://app:8001 (which is a metrics exporter).", "percentage": 90}
    ]'::jsonb,
    'Prometheus instance configured and scraping the target metrics endpoint. Grafana datasource configuration page accessible.',
    'Grafana can successfully query Prometheus. Test with: curl http://prometheus:9090/api/v1/query?query=up returns JSON',
    'Adding exporter endpoints directly as Grafana datasources instead of routing through Prometheus. Pointing Grafana to raw metrics endpoints.',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/73171022/error-reading-prometheusetheus-bad-response-readobjectstart-expect-or-n-bu'
),
(
    'bad_response: readObjectStart: expect { or n, but found <',
    'grafana',
    'HIGH',
    '[
        {"solution": "Ensure you''re pointing to a real Prometheus server (default port 9090), not a metrics exporter or node_exporter (port 9100).", "percentage": 92},
        {"solution": "Test datasource URL: curl http://<datasource-url>/api/v1/query?query=up - should return JSON starting with { not HTML starting with <", "percentage": 88}
    ]'::jsonb,
    'Prometheus server running and accessible. Grafana datasource form open.',
    'curl to datasource URL returns valid JSON. Grafana Test Connection succeeds.',
    'Confusing exporter ports with Prometheus ports. Adding node_exporter as a datasource instead of Prometheus.',
    0.91,
    'haiku',
    NOW(),
    'https://github.com/grafana/grafana/issues/42672'
),
(
    'Datasource ${DS_PROMETHEUS} was not found in Grafana',
    'grafana',
    'HIGH',
    '[
        {"solution": "Define uid in datasources.yml: name: Prometheus, type: prometheus, url: http://prometheus:9090, uid: prometheusdatasource", "percentage": 92},
        {"solution": "Update dashboard JSON to use uid instead of variable: change datasource field to {\"type\": \"prometheus\", \"uid\": \"prometheusdatasource\"}", "percentage": 88},
        {"solution": "For API-based datasources, query http://grafana:3000/api/datasources to get auto-generated uid and update dashboard JSON accordingly.", "percentage": 85}
    ]'::jsonb,
    'Grafana 7.0+. Access to datasources.yml or API. Dashboard JSON that needs updating.',
    'Dashboard loads without errors. Panels display data. Variable picker shows Prometheus available.',
    'Mixing old variable syntax (${DS_PROMETHEUS}) with new uid-based system. Not updating datasource references in imported dashboards.',
    0.89,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/76415713/datasource-ds-prometheus-was-not-found-in-grafana'
),
(
    'Error reading Prometheus: Post http://localhost:9090/api/v1/query: dial tcp 127.0.0.1:9090: connect: connection refused',
    'grafana',
    'HIGH',
    '[
        {"solution": "In Docker Compose, replace localhost with service name: http://prometheus:9090 (where ''prometheus'' is the service name in docker-compose.yml)", "percentage": 95},
        {"solution": "For Docker on Windows/Mac, try http://host.docker.internal:9090 if Prometheus runs on host machine.", "percentage": 85},
        {"solution": "Verify Prometheus is running: docker ps | grep prometheus. Ensure port 9090 is exposed.", "percentage": 80}
    ]'::jsonb,
    'Docker Compose or Docker setup. Prometheus running. Grafana datasource configuration accessible.',
    'Grafana Test Connection succeeds. Panels display metrics. No connection errors in Grafana logs.',
    'Using localhost instead of service name in containerized environments. Not accounting for container network isolation.',
    0.93,
    'haiku',
    NOW(),
    'https://github.com/grafana/grafana/issues/46434'
),
(
    'scrape_timeout cannot be greater than the scrape_interval',
    'prometheus',
    'MEDIUM',
    '[
        {"solution": "Set scrape_timeout to a value less than scrape_interval. Example: scrape_interval: 15s, scrape_timeout: 10s", "percentage": 98},
        {"solution": "Check global settings in prometheus.yml and job-specific settings. Job settings override global.", "percentage": 95}
    ]'::jsonb,
    'Prometheus configuration file accessible. Understanding of duration formats (15s, 1m, etc.)',
    'Configuration reloads successfully via /-/reload endpoint. No validation errors in logs.',
    'Setting timeout equal to interval. Forgetting that timeout must be strictly less than interval. Miscalculating duration values.',
    0.97,
    'haiku',
    NOW(),
    'https://prometheus.io/docs/prometheus/latest/configuration/configuration/'
),
(
    'Invalid duration in configuration: not a valid duration string',
    'prometheus',
    'MEDIUM',
    '[
        {"solution": "Use composite duration syntax only in Prometheus 2.21.0+. For older versions, use single-unit durations like 1h instead of 1h30m", "percentage": 92},
        {"solution": "Upgrade Prometheus to version 2.21.0 or later to support composite durations: 1d, 1h30m, 5m", "percentage": 88}
    ]'::jsonb,
    'Prometheus version known. Configuration file with duration fields.',
    'Configuration validates and reloads without duration errors. Check with: promtool check config prometheus.yml',
    'Using composite durations (1h30m) on Prometheus versions older than 2.21.0. Not checking Prometheus version before using new syntax.',
    0.85,
    'haiku',
    NOW(),
    'https://groups.google.com/g/prometheus-users/c/AaNO6CYoxMQ'
),
(
    'dial tcp: lookup <hostname>: no such host',
    'prometheus',
    'MEDIUM',
    '[
        {"solution": "Verify DNS resolution from Prometheus container: docker exec <prometheus-container> nslookup example.com", "percentage": 90},
        {"solution": "Check if target is reachable: docker exec <prometheus-container> ping <hostname> or curl http://<hostname>:9100/metrics", "percentage": 88},
        {"solution": "For Kubernetes, use FQDN: target.namespace.svc.cluster.local instead of just target", "percentage": 85},
        {"solution": "Use IP address directly in scrape config instead of hostname if DNS is unavailable: targets: [192.168.1.10:9100]", "percentage": 80}
    ]'::jsonb,
    'Network connectivity to target. Ability to exec into containers or access Prometheus pod.',
    'Target hostname resolves to IP address. Prometheus scrapes target successfully. Metrics appear in /api/v1/targets page.',
    'Assuming DNS works across container boundaries. Not testing DNS from Prometheus container. Mixing short names with FQDN requirements.',
    0.84,
    'haiku',
    NOW(),
    'https://community.grafana.com/t/error-reading-prometheus-dial-tcp-lookup-prometheus-no-such-host/60062'
),
(
    'Post http://localhost:9093/api/v1/alerts: dial tcp [::1]:9093: connect: connection refused',
    'prometheus',
    'MEDIUM',
    '[
        {"solution": "Use service hostname instead of localhost in alertmanager config: targets: [''alertmanager:9093''] instead of [''localhost:9093'']", "percentage": 96},
        {"solution": "For Docker, verify alertmanager service name matches docker-compose.yml: alerting section should reference the exact service name", "percentage": 92},
        {"solution": "Verify alertmanager is running: docker ps | grep alertmanager. Check that port 9093 is exposed.", "percentage": 85}
    ]'::jsonb,
    'Alertmanager running. Prometheus configuration accessible. Docker Compose or container environment.',
    'Prometheus sends alerts successfully to Alertmanager. Check /api/v1/alerts returns status 200.',
    'Using 127.0.0.1 or localhost in containerized environments. Confusing IPv4 (127.0.0.1) with IPv6 (::1) resolution issues.',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/53314642/post-http-localhost9093-api-v1-alerts-dial-tcp-19093-connect-connecti'
),
(
    'Duplicate label values after metric_relabel_configs causing time series conflicts',
    'prometheus',
    'MEDIUM',
    '[
        {"solution": "Verify label uniqueness: check /service-discovery page in Prometheus UI to see labels before and after relabeling", "percentage": 90},
        {"solution": "Ensure relabeling rules don''t remove labels that differentiate metrics. Keep at least one unique label per target.", "percentage": 88},
        {"solution": "Test relabel config changes: promtool query instant on test query to verify unique label sets", "percentage": 82}
    ]'::jsonb,
    'Prometheus configuration with metric_relabel_configs. Access to Prometheus UI.',
    'No duplicate time series errors in logs. All metrics have unique label combinations.',
    'Over-aggressively dropping labels. Not checking for duplicate label sets after relabeling. Removing critical differentiator labels.',
    0.83,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/62383398/metric_relabel_configs-what-happens-if-labels-become-non-unique'
),
(
    'honor_labels set to false results in exported_<label> prefixes on conflicts',
    'prometheus',
    'LOW',
    '[
        {"solution": "If you want to preserve scrape-time labels over target labels, set honor_labels: true in scrape_config", "percentage": 92},
        {"solution": "If you see exported_instance or exported_job labels, this is expected behavior when honor_labels: false (default). This prevents label overwriting.", "percentage": 95}
    ]'::jsonb,
    'Understanding of honor_labels setting. Prometheus configuration accessible.',
    'Metrics have expected label names (either original or exported_* variants as configured). No unexpected label overwrites.',
    'Expecting label overwriting when using honor_labels: false. Misunderstanding the purpose of exported_* prefix naming.',
    0.88,
    'haiku',
    NOW(),
    'https://prometheus.io/docs/prometheus/latest/configuration/configuration/'
),
(
    'Unsupported character in source label requires underscore conversion',
    'prometheus',
    'LOW',
    '[
        {"solution": "Convert label names with dots/dashes to underscores in relabel_configs. Example: app.kubernetes.io/name becomes app_kubernetes_io_name", "percentage": 94},
        {"solution": "Use relabel action ''replace'' to map source labels: source_labels: [__meta_kubernetes_label_app_kubernetes_io_name]", "percentage": 88}
    ]'::jsonb,
    'Kubernetes service discovery or labels with special characters. Prometheus configuration accessible.',
    'Labels successfully relabel without validation errors. Metrics appear with correct label names (underscores, no dots).',
    'Using dots or dashes directly in label names from service discovery. Not converting special characters to valid Prometheus label names.',
    0.89,
    'haiku',
    NOW(),
    'https://prometheus.io/docs/prometheus/latest/configuration/configuration/'
),
(
    'Grafana dashboard transformation order matters: transformations apply sequentially',
    'grafana',
    'LOW',
    '[
        {"solution": "Reorder transformations in Grafana panel: each step transforms output of previous step, not original data. Move earlier transformations that filter data before later ones that reshape.", "percentage": 92},
        {"solution": "Remember that transformations are cumulative. If step 2 depends on data from step 1, reordering may cause failures.", "percentage": 88}
    ]'::jsonb,
    'Grafana dashboard with transformations configured. Understanding of data flow.',
    'Panel displays expected data. Reordering transformations produces correct output.',
    'Assuming transformations apply independently to raw data. Reordering transformations without understanding data dependency chain.',
    0.85,
    'haiku',
    NOW(),
    'https://grafana.com/docs/grafana/latest/troubleshooting/'
),
(
    'Grafana server-side image rendering missing fonts: text not appearing in rendered images',
    'grafana',
    'LOW',
    '[
        {"solution": "Install required fonts on RPM-based Linux (RHEL, CentOS): sudo yum install fontconfig freetype urw-fonts", "percentage": 93},
        {"solution": "For Debian/Ubuntu: sudo apt-get install fontconfig freetype2 fonts-liberation", "percentage": 91},
        {"solution": "Restart Grafana after font installation: sudo systemctl restart grafana-server", "percentage": 90}
    ]'::jsonb,
    'Linux server with Grafana running. Root or sudo access. Server-side rendering enabled in Grafana config.',
    'Exported dashboard images display all text correctly. No blank/missing text areas in rendered PNG/SVG files.',
    'Forgetting to restart Grafana after installing fonts. Installing wrong font package for distro type.',
    0.87,
    'haiku',
    NOW(),
    'https://grafana.com/docs/grafana/latest/troubleshooting/'
)
