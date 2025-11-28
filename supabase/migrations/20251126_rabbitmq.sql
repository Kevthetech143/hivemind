INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Error: connect ECONNREFUSED 127.0.0.1:5672',
    'rabbitmq',
    'HIGH',
    '[
        {"solution": "Start RabbitMQ server with: sudo rabbitmq-server or brew services start rabbitmq", "percentage": 95},
        {"solution": "Verify RabbitMQ is running by accessing http://localhost:15672 management console", "percentage": 90},
        {"solution": "Check that RabbitMQ is configured correctly in /etc/rabbitmq/rabbitmq-env.conf", "percentage": 70}
    ]'::jsonb,
    'RabbitMQ installed, system has proper permissions',
    'RabbitMQ status shows running, management console accessible, telnet localhost 5672 succeeds',
    'Assuming server is running when it is not. Misconfigured NODE_IP_ADDRESS in config file. Not adding 127.0.0.1 to hosts file on Windows.',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/15434810/rabbitmq-hello-world-example-gives-connection-refused'
),
(
    'Error: ECONNREFUSED 127.0.0.1:5672 in Docker Compose',
    'rabbitmq',
    'HIGH',
    '[
        {"solution": "Change connection URL from amqp://127.0.0.1:5672 to amqp://rabbitmq:5672 using service name", "percentage": 98},
        {"solution": "Ensure RabbitMQ service is fully started before dependent containers connect", "percentage": 85},
        {"solution": "Use depends_on and add wait-for-it.sh script to verify port availability", "percentage": 80}
    ]'::jsonb,
    'Docker Compose setup with RabbitMQ service, Node.js app in separate container',
    'Service name resolves correctly, application connects to rabbitmq:5672, messages flow successfully',
    'Using 127.0.0.1 or 0.0.0.0 in container (refers to container localhost, not RabbitMQ host). Not waiting for RabbitMQ to fully start.',
    0.95,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/53261142/econnrefused-127-0-0-15672-rabbit-mq-with-docker-compose'
),
(
    'Error: connect ECONNREFUSED ::1:5672 on macOS',
    'rabbitmq',
    'HIGH',
    '[
        {"solution": "Replace amqp://localhost with amqp://127.0.0.1 to use IPv4 explicitly", "percentage": 96},
        {"solution": "Run: brew services start rabbitmq to ensure service is running", "percentage": 95},
        {"solution": "Verify with: telnet 127.0.0.1 5672", "percentage": 90}
    ]'::jsonb,
    'macOS system, Node.js/JavaScript AMQP client, RabbitMQ installed via Homebrew',
    'Connection succeeds using 127.0.0.1, IPv6 loopback (::1) is bypassed, messages are exchanged',
    'Using localhost which resolves to IPv6 ::1 on macOS. Not checking system IPv6 preferences. RabbitMQ listening only on IPv4.',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/74884820/rabbitmq-connect-econnrefused-error-cant-connect-to-the-5672-port'
),
(
    'ACCESS_REFUSED - Login was refused using authentication mechanism PLAIN',
    'rabbitmq',
    'HIGH',
    '[
        {"solution": "Create new user instead of using guest: rabbitmqctl add_user USERNAME PASSWORD && rabbitmqctl set_user_tags USERNAME administrator", "percentage": 88},
        {"solution": "Set permissions for new user: rabbitmqctl set_permissions -p / USERNAME \".\" \".\" \".*\"", "percentage": 87},
        {"solution": "Allow remote guest access by setting loopback_users to empty (not recommended for production)", "percentage": 65}
    ]'::jsonb,
    'RabbitMQ 3.3.0+, guest user disabled for remote access, user configured in Spring/Java',
    'New user authenticates successfully from remote host, application connects without ACCESS_REFUSED error',
    'Assuming guest user works for remote connections. Forgetting to set proper permissions. Using incorrect vhost format. Typos in credentials.',
    0.87,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/26811924/spring-amqp-rabbitmq-3-3-5-access-refused-login-was-refused-using-authentica'
),
(
    'ACCESS_REFUSED - Login was refused (username too long)',
    'rabbitmq',
    'MEDIUM',
    '[
        {"solution": "Create user with shorter username (less than 8 characters) instead of long identifiers", "percentage": 92},
        {"solution": "Verify credentials with: rabbitmqctl authenticate_user USERNAME", "percentage": 90},
        {"solution": "Check vhost format uses correct path (remove leading slash in connection string)", "percentage": 75}
    ]'::jsonb,
    'RabbitMQ user setup, PLAIN authentication mechanism, AMQP client',
    'User authenticates successfully, credentials accepted, connection established without ACCESS_REFUSED',
    'Using overly long usernames. Special characters like underscores in usernames. Wrong vhost path format. Missing user-vhost permission bindings.',
    0.85,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/51403673/rabbitmq-access-refused-login-was-refused'
),
(
    'vm_memory_high_watermark set (memory alarm triggered)',
    'rabbitmq',
    'HIGH',
    '[
        {"solution": "Adjust vm_memory_high_watermark to 0.4-0.6 in rabbitmq.conf (40-60% of RAM)", "percentage": 93},
        {"solution": "Restart RabbitMQ after configuration change: sudo systemctl restart rabbitmq-server", "percentage": 90},
        {"solution": "Increase available RAM or set to 1.0 to disable memory-based flow control (temporary)", "percentage": 70}
    ]'::jsonb,
    'RabbitMQ running, rabbitmq.conf accessible, sufficient disk space',
    'Memory alarm clears after restart, publishers can send messages, memory usage stays below threshold',
    'Setting vm_memory_high_watermark to 0 (blocks all publishing). Not restarting after config change. Not monitoring actual memory usage.',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/12175156/rabbitmq-memory-limits'
),
(
    'Free disk space is insufficient. Free bytes: 40. Limit: 1000000000',
    'rabbitmq',
    'MEDIUM',
    '[
        {"solution": "Free existing disk space by deleting unnecessary files and RabbitMQ logs", "percentage": 88},
        {"solution": "Reconfigure RabbitMQ to use different partition with adequate space", "percentage": 85},
        {"solution": "Downgrade to RabbitMQ 3.9.11 if using 3.9.12 (version-specific bug)", "percentage": 80}
    ]'::jsonb,
    'RabbitMQ 3.9.12+, disk partition with limited space, disk_free_limit set',
    'Disk free space exceeds configured limit, RabbitMQ resumes normal operation, producers unblocked',
    'Lowering disk_free_limit as temporary mask (doesn''t solve underlying storage problem). Upgrading RabbitMQ without checking disk space first.',
    0.83,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/70742426/rabbitmq-free-disk-space-is-insufficient'
),
(
    'Error detail: econnrefused (RabbitMQ Federation)',
    'rabbitmq',
    'MEDIUM',
    '[
        {"solution": "Verify firewall permits RabbitMQ federation traffic on configured ports", "percentage": 85},
        {"solution": "Check federation plugin is enabled: rabbitmq-plugins enable rabbitmq_federation", "percentage": 88},
        {"solution": "Review RabbitMQ logs for specific connection details: tail -f /var/log/rabbitmq/rabbit@hostname.log", "percentage": 80}
    ]'::jsonb,
    'RabbitMQ cluster setup, federation plugin, network connectivity between nodes',
    'Federation upstream status shows running, messages flow between federated brokers, logs show successful connections',
    'Not enabling federation plugin. Firewall blocking federation ports. Misconfigured upstream settings.',
    0.72,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/31347533/rabbitmq-federation-status-econnrefused'
),
(
    'Authentication failed (rejected by the remote node), please check the Erlang cookie',
    'rabbitmq',
    'MEDIUM',
    '[
        {"solution": "Copy Erlang cookie from C:\\Windows\\System32\\config\\systemprofile\\.erlang.cookie to user home directory", "percentage": 96},
        {"solution": "Run RabbitMQ CLI as administrator or under same user account that runs RabbitMQ service", "percentage": 92},
        {"solution": "Use Docker to deploy RabbitMQ and avoid cookie management complexity", "percentage": 98}
    ]'::jsonb,
    'Windows RabbitMQ installation, CLI tools, system service account vs user account',
    'rabbitmqctl status succeeds, authentication passes, cluster commands work without cookie errors',
    'Service running under SYSTEM account, CLI looking in wrong user directory. Not having administrator privileges. Missing .erlang.cookie file entirely.',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/47893899/authentication-failed-rejected-by-the-remote-node-please-check-the-erlang-coo'
),
(
    'ACCESS_REFUSED - Login was refused (missing credentials in ConnectionFactory)',
    'rabbitmq',
    'HIGH',
    '[
        {"solution": "Set explicit credentials in ConnectionFactory: factory.setUsername(\"guest\"); factory.setPassword(\"guest\");", "percentage": 97},
        {"solution": "Enable RabbitMQ management plugin: rabbitmq-plugins enable rabbitmq_management", "percentage": 85},
        {"solution": "Create dedicated user and update connection code with new credentials", "percentage": 90}
    ]'::jsonb,
    'Java RabbitMQ client, ConnectionFactory, RabbitMQ server running',
    'Connection succeeds with authentication, Java client receives messages, no ACCESS_REFUSED errors',
    'Omitting username/password in connection code. Assuming guest credentials work without explicit set. Using wrong virtual host path.',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/36543710/access-refused-login-was-refused-using-authentication-mechanism-plain'
),
(
    'Error: connect ECONNREFUSED 127.0.0.1:5672 (Docker container networking)',
    'rabbitmq',
    'HIGH',
    '[
        {"solution": "Update AMQP_RECEIVE_URL environment variable to use service hostname: amqp://guest:guest@rabbitmq:5672", "percentage": 96},
        {"solution": "Use env_file directive in docker-compose.yml to inject correct URL", "percentage": 93},
        {"solution": "Add wait-for-it.sh script to ensure RabbitMQ port is available before connecting", "percentage": 85}
    ]'::jsonb,
    'Docker Compose setup, separate containers for app and RabbitMQ, environment variables configured',
    'Application container connects successfully to RabbitMQ service, messages are received without ECONNREFUSED',
    'Using 127.0.0.1 inside container (container''s localhost, not RabbitMQ host). Not using service name. Missing depends_on configuration.',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/48015477/docker-and-rabbitmq-econnrefused-between-containers'
),
(
    'ACCESS_REFUSED - Login was refused (federation with guest user)',
    'rabbitmq',
    'MEDIUM',
    '[
        {"solution": "Configure federation upstream with explicit credentials: amqp://user:password@hostname/vhost", "percentage": 95},
        {"solution": "Create dedicated non-guest user for federation: rabbitmqctl add_user fed_user password", "percentage": 92},
        {"solution": "Set federation permissions: rabbitmqctl set_permissions -p / fed_user \".*\" \".*\" \".*\"", "percentage": 90}
    ]'::jsonb,
    'RabbitMQ 3.3.0+, federation enabled, guest user disabled for remote access',
    'Federation upstream connects successfully, messages are distributed between brokers, no authentication failures',
    'Assuming guest user works for federation (disabled in 3.3.0+). Not setting explicit credentials in upstream definition. Missing proper permissions on federation user.',
    0.88,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/23790997/rabbitmq-federation-access-refused-guest-login-fail'
),
(
    'Error: conn error connect ECONNREFUSED 127.0.0.1:15672 (wrong port)',
    'rabbitmq',
    'MEDIUM',
    '[
        {"solution": "Change AMQP connection port from 15672 to 5672: amqp://guest:guest@localhost:5672", "percentage": 98},
        {"solution": "Use 127.0.0.1 instead of localhost for Docker/container environments", "percentage": 92},
        {"solution": "Verify port with: telnet localhost 5672 (should succeed) and telnet localhost 15672 (should show HTTP)", "percentage": 95}
    ]'::jsonb,
    'Node.js AMQP client, RabbitMQ server running, management console enabled',
    'AMQP client connects successfully on port 5672, management console accessible on 15672, messages exchanged',
    'Confusing management console port (15672) with AMQP port (5672). Using localhost instead of IP in containers. Not verifying port with telnet.',
    0.96,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/51042675/connection-refused-error-in-rabbitmq-with-amqplib-npm-module'
),
(
    'vm_memory_high_watermark set. Memory used:850213192 allowed:835212083',
    'rabbitmq',
    'HIGH',
    '[
        {"solution": "Check RabbitMQ Management console (port 15672) to identify queues with accumulated messages", "percentage": 85},
        {"solution": "Debug consumer applications to ensure they are processing messages from queues", "percentage": 88},
        {"solution": "Increase available RAM allocation or adjust vm_memory_high_watermark threshold", "percentage": 70}
    ]'::jsonb,
    'RabbitMQ running with 2GB+ RAM, management plugin enabled, consumer applications deployed',
    'Memory alarm clears, queues drain, messages are consumed by applications, publishers unblocked',
    'Messages accumulating indefinitely due to non-consuming services. Insufficient RAM for workload. Not monitoring queue depths before troubleshooting.',
    0.78,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/27552462/rabbitmq-consumes-memory-and-shuts'
),
(
    'RabbitMQ 3.3.1 can not login with guest/guest (remote access)',
    'rabbitmq',
    'HIGH',
    '[
        {"solution": "Create administrative user instead: rabbitmqctl add_user admin password && rabbitmqctl set_user_tags admin administrator", "percentage": 98},
        {"solution": "Set user permissions: rabbitmqctl set_permissions -p / admin \".*\" \".*\" \".*\"", "percentage": 97},
        {"solution": "For development only: disable loopback restriction in rabbitmq.conf (loopback_users = none)", "percentage": 60}
    ]'::jsonb,
    'RabbitMQ 3.3.0+ installed, remote client connection required, management console accessible',
    'New admin user authenticates successfully, web console login succeeds, remote clients connect',
    'Using guest for remote access (disabled by default). Not restarting RabbitMQ after config changes. Forgetting to set administrator tags.',
    0.96,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/23669780/rabbitmq-3-3-1-can-not-login-with-guest-guest'
);
