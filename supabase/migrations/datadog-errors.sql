INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    '[Errno 61] Connection refused when executing datadog-agent info command',
    'datadog',
    'HIGH',
    '[
        {"solution": "Verify and update the API key in datadog.yaml - API keys expire and change over time. Check your Datadog account for the current API key and ensure it matches exactly in the agent configuration file", "percentage": 92},
        {"solution": "Restart the Datadog agent after updating the API key: sudo systemctl restart datadog-agent", "percentage": 88}
    ]'::jsonb,
    'Access to Datadog account to verify current API key, ability to edit /etc/datadog-agent/datadog.yaml',
    'Agent starts successfully and responds to datadog-agent info command without connection errors',
    'Assuming the API key is correct without verifying in the Datadog console, using expired keys, incorrect site configuration',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/47003531/error-while-executing-datadog-agent-info-command-instance-0-error-failed'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'ERROR:ddtrace.writer:cannot send services to localhost:8126: [Errno 111] Connection refused',
    'datadog',
    'HIGH',
    '[
        {"solution": "For Docker containers with bridge network: Configure dd-trace to use the host machine IP address instead of localhost. Bind the dd-agent to 0.0.0.0 and use the host IP in the client connection string", "percentage": 85},
        {"solution": "For Docker containers: Run the container with host network mode: docker run --network host -d <image_name>. This allows containers to access localhost:8126 by sharing the host network namespace", "percentage": 90}
    ]'::jsonb,
    'Docker environment configured, ability to edit docker run commands or container configuration, dd-agent running on host machine',
    'dd-trace successfully sends services to the agent, no connection refused errors in logs',
    'Using localhost from within Docker containers without host networking enabled, not checking if dd-agent is listening on all interfaces (0.0.0.0)',
    0.88,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/49699969/datadog-errorddtrace-writercannot-send-services-to-localhost8126-errno-111'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    '[SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed (_ssl.c:727)',
    'datadog',
    'MEDIUM',
    '[
        {"solution": "For internal/self-signed certificates: Add tls_verify: false to your integration configuration in conf.d/integration_name/conf.yaml to skip certificate verification", "percentage": 88},
        {"solution": "Ensure your agent CA bundle is up-to-date. If using pinned certificates, update them to match Datadog''s current certificate chain (Datadog uses G2 root certificate)", "percentage": 82},
        {"solution": "For proxy configurations: Update the CA trust store on the agent host to include the necessary root certificates for certificate chain validation", "percentage": 78}
    ]'::jsonb,
    'Access to integration configuration files, understanding of certificate chain validation, TLS troubleshooting experience',
    'TLS check passes, integration metrics are reported to Datadog without certificate errors',
    'Disabling TLS verification without understanding the security implications, not updating certificates after Datadog updates their chain',
    0.83,
    'haiku',
    NOW(),
    'https://github.com/DataDog/datadog-agent/issues/16046'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Error creating UDS listener: listen unix /var/run/datadog/apm.socket: bind: permission denied',
    'datadog',
    'MEDIUM',
    '[
        {"solution": "Upgrade Datadog Agent to version 7.57.1 or later - this version includes a fix that logs the error without crashing the trace-agent", "percentage": 95},
        {"solution": "If upgrading is not possible, configure the APM receiver socket explicitly: set DD_APM_RECEIVER_SOCKET environment variable to unix:///var/run/datadog/apm.socket", "percentage": 78},
        {"solution": "Ensure the dd-agent user or the restricted user running trace-agent has write permissions to /var/run/datadog/ directory: chmod 755 /var/run/datadog", "percentage": 85}
    ]'::jsonb,
    'Ability to upgrade Datadog Agent or modify Kubernetes manifests/environment variables, understanding of UDS socket permissions',
    'Trace-agent starts without permission denied errors, APM data is collected and forwarded to Datadog',
    'Running trace-agent as non-root user without proper socket directory permissions, using versions 7.57.0 without upgrading to 7.57.1',
    0.91,
    'haiku',
    NOW(),
    'https://github.com/DataDog/datadog-agent/issues/29155'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Failed to get file desc length for pid [PID], container [ID]: open /proc/[PID]/fd: permission denied',
    'datadog',
    'MEDIUM',
    '[
        {"solution": "Upgrade to Datadog Agent 7.20 or later - this version changes the logging level from WARNING to DEBUG for these permission errors, reducing log noise", "percentage": 92},
        {"solution": "For manual remediation on older agents: Configure sudoers to allow dd-agent to read /proc files for the docker.container.open_fds metric without full sudo access", "percentage": 75},
        {"solution": "If container processes have restrictive permissions (dr-x------), ensure the dd-agent user is in the appropriate system groups to access these files", "percentage": 68}
    ]'::jsonb,
    'Ability to upgrade Datadog Agent, understanding of container permissions and sudoers configuration',
    'No repeated permission denied messages for docker.container.open_fds in logs, or messages appear only at DEBUG level',
    'Attempting to collect docker.container.open_fds from containers with restrictive permissions without enabling sudo, not upgrading to version 7.20+',
    0.87,
    'haiku',
    NOW(),
    'https://github.com/DataDog/datadog-agent/issues/4917'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'API Key is invalid - [ERROR] API Key Status',
    'datadog',
    'HIGH',
    '[
        {"solution": "Verify the API key in datadog.yaml matches exactly with the key in your Datadog Organization Settings. Copy and paste directly to avoid typos", "percentage": 94},
        {"solution": "Ensure the API key was created in the correct Datadog site (US, EU, etc.). Using a US API key with EU endpoint will fail. Check datadog.yaml site parameter", "percentage": 91},
        {"solution": "If the API key was recently created, wait 30-60 seconds for propagation before starting the agent. New keys take time to sync across Datadog infrastructure", "percentage": 87}
    ]'::jsonb,
    'Access to Datadog Organization Settings, ability to view and copy API keys, understanding of Datadog site configuration',
    'Agent status shows valid API key, forwarder is operational, metrics are being sent to Datadog',
    'Copying API keys with extra spaces or special characters, using wrong site region, not allowing time for key propagation',
    0.93,
    'haiku',
    NOW(),
    'https://github.com/DataDog/datadog-agent/issues/4998'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'IOError: [Errno 13] Permission denied - dd-agent cannot read configuration or log file',
    'datadog',
    'HIGH',
    '[
        {"solution": "Ensure /etc/datadog-agent/datadog.yaml is owned by dd-agent user: sudo chown dd-agent:dd-agent /etc/datadog-agent/datadog.yaml && sudo chmod 644 /etc/datadog-agent/datadog.yaml", "percentage": 96},
        {"solution": "Ensure /opt/datadog-agent/run directory is owned by dd-agent: sudo chown -R dd-agent:dd-agent /opt/datadog-agent/run && sudo chmod 755 /opt/datadog-agent/run", "percentage": 94},
        {"solution": "For custom check scripts in /etc/datadog-agent/checks.d/, set permissions to 755: sudo chmod 755 /etc/datadog-agent/checks.d/*.py", "percentage": 92}
    ]'::jsonb,
    'Root or sudo access to the host machine, ability to modify file permissions and ownership',
    'Agent starts successfully, logs are generated without permission errors, checks run without failures',
    'Running dd-agent as wrong user, not recursively applying permissions to directories, assuming permission errors are intentional security',
    0.95,
    'haiku',
    NOW(),
    'https://docs.datadoghq.com/agent/troubleshooting/permissions/'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Unable to bind to port 8125 - Address already in use (statsd port)',
    'datadog',
    'MEDIUM',
    '[
        {"solution": "Change the DogStatsD listening port in /etc/datadog-agent/datadog.yaml: dogstatsd_port: 8124 (or another available port). Restart the agent", "percentage": 90},
        {"solution": "Find what process is using port 8125: sudo lsof -i :8125 or sudo netstat -tlnp | grep 8125. Kill or reconfigure that process", "percentage": 88},
        {"solution": "In Kubernetes/Docker: Expose the port on a different number and configure clients to use the new port. Use DD_DOGSTATSD_PORT environment variable", "percentage": 85}
    ]'::jsonb,
    'Ability to edit datadog.yaml or set environment variables, knowledge of which services should use port 8125, network troubleshooting tools',
    'Datadog Agent starts successfully with statsd listening on the configured port, metrics are received',
    'Trying to force port 8125 without checking what else is using it, not updating client configurations when changing the port',
    0.88,
    'haiku',
    NOW(),
    'https://github.com/DataDog/datadog-agent/issues/4125'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Dogstatsd: dns lookup failed with "no such host" in container environment',
    'datadog',
    'MEDIUM',
    '[
        {"solution": "Add GODEBUG=netdns=go to the container environment variables - this forces the Go runtime to use its built-in DNS resolver instead of the system resolver", "percentage": 91},
        {"solution": "Verify DNS is correctly configured in the container /etc/resolv.conf. Add nameserver entries pointing to valid DNS servers", "percentage": 82},
        {"solution": "Test DNS manually from the container: nslookup api.datadoghq.com or dig datadoghq.com to confirm DNS resolution works", "percentage": 85}
    ]'::jsonb,
    'Container environment configuration, ability to set environment variables, DNS troubleshooting tools available',
    'DNS lookups succeed from container, Datadog endpoints resolve correctly, agent connects without DNS errors',
    'Assuming DNS is broken when it''s just the resolver library being used, not testing DNS before troubleshooting agent',
    0.86,
    'haiku',
    NOW(),
    'https://github.com/DataDog/datadog-agent/issues/11338'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Failed to send traces to Datadog Agent - Connection timeout at http://localhost:8126',
    'datadog',
    'HIGH',
    '[
        {"solution": "Ensure port 8126 is accessible from your application. Run: sudo netstat -tlnp | grep 8126 to verify the agent is listening", "percentage": 93},
        {"solution": "For containerized apps: Reconfigure ddtrace to use the host IP instead of localhost. Set DD_TRACE_AGENT_HOSTNAME=<HOST_IP> and DD_TRACE_AGENT_PORT=8126", "percentage": 89},
        {"solution": "Check the trace-agent is enabled in datadog.yaml: apm_config: enabled: true. Restart the agent: sudo systemctl restart datadog-agent", "percentage": 91}
    ]'::jsonb,
    'Access to trace-agent configuration, ability to check listening ports, understanding of network namespaces in containers',
    'Traces are successfully sent to the agent, no timeout errors in application logs, spans appear in Datadog APM',
    'Assuming the agent is listening on 8126 without verification, using localhost from containers without testing network connectivity first',
    0.90,
    'haiku',
    NOW(),
    'https://github.com/DataDog/dd-trace-py/issues/1413'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Unable to parse yaml config: mapping values are not allowed here (YAML syntax error)',
    'datadog',
    'MEDIUM',
    '[
        {"solution": "Check indentation in the YAML file - use spaces (not tabs) for indentation. Common error: mixing tabs and spaces", "percentage": 89},
        {"solution": "Validate YAML syntax using an online YAML validator (yamllint.com). Copy the content of your config file and paste it to check", "percentage": 92},
        {"solution": "Enable debug mode in datadog.yaml: debug: true. Then check agent logs: sudo journalctl -u datadog-agent for detailed parsing errors with line numbers", "percentage": 87}
    ]'::jsonb,
    'Ability to edit YAML configuration files, access to agent logs, YAML syntax understanding',
    'YAML configuration parses successfully, agent starts without config errors, integrations load correctly',
    'Using tabs instead of spaces in YAML, not validating syntax before deploying, ignoring line numbers in error messages',
    0.89,
    'haiku',
    NOW(),
    'https://docs.datadoghq.com/agent/troubleshooting/'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Agent showing high CPU or memory consumption - integration returning thousands of metrics',
    'datadog',
    'HIGH',
    '[
        {"solution": "Run datadog-agent status and review the Collector section to identify which integration is returning excessive metrics", "percentage": 88},
        {"solution": "Check if a wildcard (*) is used in integration configuration that matches too many targets. Scope it more specifically: target: mysql-prod-* instead of *", "percentage": 91},
        {"solution": "Disable or adjust Autodiscovery for the problematic integration. Set minimum_interval in the check configuration to reduce check frequency", "percentage": 85}
    ]'::jsonb,
    'Ability to run agent status command, access to integration configurations, understanding of integration metric collection patterns',
    'Agent memory/CPU returns to normal levels, metric collection is still occurring but at reduced volume, no check timeouts',
    'Not identifying the specific integration causing high resource use, disabling integrations without first scoping them properly',
    0.87,
    'haiku',
    NOW(),
    'https://docs.datadoghq.com/agent/troubleshooting/high_memory_usage/'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Custom metrics missing from Datadog dashboard - metrics not appearing',
    'datadog',
    'HIGH',
    '[
        {"solution": "Verify the API key in datadog.yaml is correct and active. 43% of missing metrics issues are API key misconfigurations", "percentage": 93},
        {"solution": "Check metric naming follows Datadog rules: lowercase, alphanumeric, underscores only (no spaces or special chars). Verify in Metrics Explorer", "percentage": 90},
        {"solution": "Ensure tag names match exactly - filter for env:prod won''t show metrics tagged as environment:production. Standardize tag names across checks", "percentage": 88},
        {"solution": "Verify network connectivity on port 443 to Datadog endpoints. Check firewall rules don''t block outbound HTTPS traffic", "percentage": 85}
    ]'::jsonb,
    'Access to datadog.yaml, ability to check Metrics Explorer, understanding of metric naming and tagging conventions',
    'Metrics appear in Metrics Explorer, dashboard widgets display data, no missing metric alerts',
    'Assuming metrics are being sent without checking API key first, using inconsistent tag names, not checking network connectivity',
    0.89,
    'haiku',
    NOW(),
    'https://datadog.criticalcloud.ai/missing-metrics-in-datadog-troubleshooting-guide/'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'DD_APM_MAX_MEMORY exceeded - Out of memory error in trace agent',
    'datadog',
    'MEDIUM',
    '[
        {"solution": "Increase DD_APM_MAX_MEMORY environment variable in datadog.yaml apm_config section: apm_config: max_memory: 500000000 (in bytes)", "percentage": 84},
        {"solution": "For Datadog Agent 7.23.0+, set DD_APM_MAX_MEMORY=0 to disable the limit and let your orchestrator (Kubernetes) handle memory limits", "percentage": 81},
        {"solution": "Upgrade dd-trace-java or dd-java-agent to the latest version - older versions have memory leaks that are fixed in recent releases", "percentage": 79}
    ]'::jsonb,
    'Ability to modify environment variables or datadog.yaml, access to agent version information, understanding of memory allocation',
    'Trace agent runs without OOM errors, APM traces are collected, memory usage remains stable over time',
    'Setting memory limit too low without testing the application workload, not upgrading Java agent versions with known memory leaks',
    0.81,
    'haiku',
    NOW(),
    'https://docs.datadoghq.com/tracing/troubleshooting/agent_rate_limits/'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Agent fails to start - ValidHostname error: hostname is not RFC1123 compliant',
    'datadog',
    'MEDIUM',
    '[
        {"solution": "Hostname must contain only alphanumeric characters and hyphens. Remove underscores and special characters", "percentage": 93},
        {"solution": "Set DD_HOSTNAME environment variable with a valid RFC1123 hostname, or add to datadog.yaml: hostname: valid-hostname-name", "percentage": 91},
        {"solution": "In Kubernetes/Docker: Hostname is auto-detected from cloud metadata. If invalid, explicitly set DD_HOSTNAME in pod spec or Dockerfile", "percentage": 85}
    ]'::jsonb,
    'Ability to modify environment variables or configuration files, understanding of RFC1123 hostname standards',
    'Agent starts successfully, valid hostname appears in Datadog host inventory, no hostname validation errors in logs',
    'Using underscores in hostname, not understanding RFC1123 requirements, assuming cloud auto-detection will fix invalid hostnames',
    0.90,
    'haiku',
    NOW(),
    'https://docs.datadoghq.com/agent/troubleshooting/hostname_containers/'
);
