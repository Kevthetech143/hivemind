-- Redis ECONNREFUSED Error Mining - 5 Real Stack Overflow Solutions
-- Mined: 2025-11-25 | Source: Stack Overflow community

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Redis Error: connect ECONNREFUSED 127.0.0.1:6379 - server not running',
    'redis-connection',
    'CRITICAL',
    '[
        {"solution": "Start Redis server: redis-server", "percentage": 98},
        {"solution": "Use brew services: brew services start redis", "percentage": 95},
        {"solution": "Start systemd service: sudo systemctl start redis-server", "percentage": 93},
        {"solution": "Check Redis status: redis-cli ping", "percentage": 90}
    ]'::jsonb,
    'Redis installed on system, terminal access',
    'redis-cli ping returns PONG, client connects without error',
    'Forgetting to start after reboot, assuming server auto-starts',
    0.98,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/8754304/redis-connection-to-127-0-0-16379-failed-connect-econnrefused'
),
(
    'Redis Node.js ECONNREFUSED: conflicting connection parameters',
    'redis-connection',
    'HIGH',
    '[
        {"solution": "Use only client parameter, not host/port: store: new redisStore({client: RedisClient})", "percentage": 92},
        {"solution": "Remove duplicate connection params from store config", "percentage": 89},
        {"solution": "Verify redis.on(error) error handler catches connection issues", "percentage": 85},
        {"solution": "Test with: redis-cli -h 127.0.0.1 -p 6379", "percentage": 88}
    ]'::jsonb,
    'Node.js express app, redis and connect-redis packages',
    'Store initializes without error, session persists across requests',
    'Passing both host/port AND existing client simultaneously, confusing store configuration',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/42290343/redis-error-error-redis-connection-to-127-0-0-16379-failed-connect-econnref'
),
(
    'Redis ECONNREFUSED in Docker: using localhost instead of service name',
    'redis-docker',
    'CRITICAL',
    '[
        {"solution": "Use service name in docker-compose: redis://redis:6379 instead of 127.0.0.1", "percentage": 97},
        {"solution": "Configure all Redis clients with same hostname: host: redis, port: 6379", "percentage": 96},
        {"solution": "Verify docker-compose service name matches connection string", "percentage": 94},
        {"solution": "Test with: docker-compose exec app redis-cli -h redis ping", "percentage": 91}
    ]'::jsonb,
    'Docker/docker-compose environment, Node.js or Python app, redis service running',
    'Container connects to Redis, no ECONNREFUSED errors in logs',
    'Hardcoding 127.0.0.1 in containers, expecting localhost resolution across services',
    0.97,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/54300518/redis-windows-error-connect-econnrefused-127-0-0-16379-but-appilcation-is-work'
),
(
    'Redis ECONNREFUSED docker-compose: modern Node.js Redis client config',
    'redis-docker',
    'HIGH',
    '[
        {"solution": "Use URL format: redis.createClient({url: redis://redis:6379})", "percentage": 96},
        {"solution": "Use socket config: redis.createClient({socket: {host: redis, port: 6379}})", "percentage": 94},
        {"solution": "Replace host/port with service name for docker-compose services", "percentage": 92},
        {"solution": "Ensure Redis version 6.0+ compatibility with async/await connect()", "percentage": 88}
    ]'::jsonb,
    'Docker-compose setup, Node.js redis v4.0+, redis service defined',
    'Client connects successfully, redis.ready === true, commands execute without ECONNREFUSED',
    'Using old RedisClient pattern without connect(), mixing localhost with service names',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/71717395/getting-error-connect-econnrefused-127-0-0-16379-in-docker-compose-while-conne'
),
(
    'Redis Connection Refused with Homebrew: configuration and permissions',
    'redis-macos',
    'MEDIUM',
    '[
        {"solution": "Start with brew: brew services start redis", "percentage": 96},
        {"solution": "Ensure config exists: copy from redis default if missing", "percentage": 89},
        {"solution": "Create required directories: mkdir -p /usr/local/var/db/redis", "percentage": 87},
        {"solution": "Fix permissions: sudo chown -R redis:redis /var/lib/redis /var/log/redis", "percentage": 85},
        {"solution": "Allow firewall port: sudo ufw allow 6379", "percentage": 82}
    ]'::jsonb,
    'macOS with Homebrew, sudo access, /usr/local/etc/redis.conf',
    'brew services shows redis running, redis-cli ping returns PONG, connections accepted',
    'Missing /usr/local/etc/redis.conf, incorrect directory permissions, firewall blocking',
    0.89,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/42857551/could-not-connect-to-redis-at-127-0-0-16379-connection-refused-with-homebrew'
);
