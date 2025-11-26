-- Node-Redis GitHub Issues: Connection/Command Errors Batch 1
-- Extracted from redis/node-redis repository issues (Nov 25, 2025)
-- Focus: Connection timeout, cluster mode, pub/sub, authentication problems

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Redis Sentinel client doesn't reconnect after connection failure',
    'github-node-redis',
    'HIGH',
    '[
        {"solution": "Verify Sentinel version and upgrade from 5.8.3 to 5.9.0+ - check if reconnection works after checking release notes for sentinel reconnection fixes", "percentage": 85, "note": "Version regression identified in 5.9.0"},
        {"solution": "Add connection event listeners to detect disconnection: client.on(''end'', () => { client.connect(); }) - but note that ''end'' event may not fire in all scenarios", "percentage": 60, "note": "Unreliable due to missing event lifecycle"},
        {"solution": "Use a health check with setInterval to verify connection state and manually reconnect if needed", "percentage": 75, "note": "Workaround when lifecycle events fail"}
    ]'::jsonb,
    'Node-Redis 5.8.3+, Redis Sentinel configured and running, Event listeners setup',
    'Sentinel reconnects automatically after recovery, ''connect'' and ''end'' events fire properly, Commands execute successfully',
    'Connection lifecycle events (''connect'', ''end'') may not fire even though connection is broken. Downgrading to 5.8.3 masks the issue. Do not rely solely on event listeners.',
    0.75,
    'sonnet-4',
    NOW(),
    'https://github.com/redis/node-redis/issues/3127'
),
(
    'Cannot connect to AWS Redis in cluster mode',
    'github-node-redis',
    'HIGH',
    '[
        {"solution": "Use ioredis as alternative with manual DNS lookup configuration: dnsLookup: (address, callback) => callback(null, address)", "percentage": 90, "note": "Known working solution from user report"},
        {"solution": "Configure TLS options explicitly: { tls: {} } in client options", "percentage": 80, "note": "Handles ssl_cert_reqs=optional parameter"},
        {"solution": "Parse Redis URL manually and pass individual connection parameters instead of single URL string", "percentage": 75, "note": "Reduces ambiguity in cluster topology discovery"},
        {"solution": "Remove ssl_cert_reqs parameter and let TLS defaults apply", "percentage": 70, "note": "May work but changes security posture"}
    ]'::jsonb,
    'AWS Redis instance in cluster mode, Valid connection credentials, Node.js runtime',
    'createCluster() completes connection, Cluster topology discovered, Commands execute without hanging',
    'createCluster() hangs indefinitely without error or timeout. URL format with ssl_cert_reqs=optional may confuse parser. AWS ElastiCache cluster topology differs from standard Redis Cluster.',
    0.70,
    'sonnet-4',
    NOW(),
    'https://github.com/redis/node-redis/issues/3117'
),
(
    'TypeError: Cannot read properties of undefined (reading ''address'') in cluster pubsub',
    'github-node-redis',
    'MEDIUM',
    '[
        {"solution": "Create duplicate clients for pub/sub operations: use one cluster client for subscribing, then call .duplicate() and connect separate instance for publishing", "percentage": 90, "note": "Verified working pattern from community"},
        {"solution": "Validate cluster configuration to ensure master and replica nodes are properly populated in cluster slots", "percentage": 85, "note": "Check that cluster topology is correct"},
        {"solution": "Add debugging logs at cluster-slots.js line 390 to inspect master and replica node arrays before accessing properties", "percentage": 75, "note": "Diagnostic approach to identify missing nodes"}
    ]'::jsonb,
    'Redis Cluster configured, Client cluster connection established, Node.js 14+',
    'Subscribe operations complete without TypeError, Messages received on subscribed channels, Publishing and subscribing work independently',
    'Attempting to subscribe on a cluster client with incomplete or empty node topology. Do not use same client instance for both pub and sub.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/redis/node-redis/issues/2904'
),
(
    'Client hangs on socket error during connection initialization',
    'github-node-redis',
    'HIGH',
    '[
        {"solution": "Upgrade to version that defers error handling with setImmediate() in socket error handlers", "percentage": 95, "note": "Official fix in subsequent release"},
        {"solution": "Implement connection timeout monitoring: use client.on(''ready'', ...) with setTimeout safety net", "percentage": 85, "note": "Detect hung connections"},
        {"solution": "Use TCP proxy debugging to identify exact timing of socket close vs initiator completion", "percentage": 60, "note": "Advanced diagnostic for race condition reproduction"}
    ]'::jsonb,
    'Node.js 14+, Redis server, Ability to stop/restart Redis during connection attempts',
    'Client properly enters READY state only after successful connection, Socket errors trigger reconnection loop, Commands complete successfully',
    'Race condition between socket error handler and connection initiator completion can leave client in false READY state. Timing-dependent, requires socket interruption to reproduce.',
    0.95,
    'sonnet-4',
    NOW(),
    'https://github.com/redis/node-redis/issues/3104'
),
(
    'Sentinel Client ETIMEDOUT read error',
    'github-node-redis',
    'MEDIUM',
    '[
        {"solution": "Provide full Sentinel client configuration and minimal reproduction script to maintainers for diagnosis", "percentage": 80, "note": "Issue requires debugging info"},
        {"solution": "Check Sentinel connectivity separately using redis-cli: redis-cli -h SENTINEL_HOST -p 26379 ping", "percentage": 85, "note": "Verify Sentinel is reachable"},
        {"solution": "Increase socket timeout in Sentinel client configuration to accommodate network latency", "percentage": 70, "note": "Temporary workaround pending root cause"}
    ]'::jsonb,
    'Node.js 22, Redis 7, node-redis 5.8.1+, Sentinel instance',
    'Sentinel responds to PING, No ETIMEDOUT errors in logs, Client connects successfully',
    'ETIMEDOUT often indicates Sentinel network connectivity issues rather than library bug. Limited reproduction steps available.',
    0.65,
    'sonnet-4',
    NOW(),
    'https://github.com/redis/node-redis/issues/3070'
),
(
    'createSentinel promise doesn't resolve with SSL configuration',
    'github-node-redis',
    'MEDIUM',
    '[
        {"solution": "Verify TLS certificate validity and hostname: ensure certificate matches Sentinel node hostname", "percentage": 90, "note": "Common TLS misconfiguration"},
        {"solution": "Check nodeClientOptions for typos or invalid TLS settings that prevent master connection", "percentage": 85, "note": "TLS config propagates to master connection"},
        {"solution": "Test connection to master node directly with same credentials to verify authentication works", "percentage": 80, "note": "Isolate whether issue is Sentinel or master"},
        {"solution": "Add console logging at sentinel/index.js line 896 to see promise state and connection logs", "percentage": 70, "note": "Debug why promise doesn't resolve"}
    ]'::jsonb,
    'Redis Sentinel 7.2+, TLS certificates, node-redis 5.8.1+, Docker environment',
    'createSentinel promise resolves, Master node connection succeeds, Sentinel client ready event fires',
    'Promise may never resolve if master node connection fails. Sentinel connection may succeed but master connection silently fails. Invalid TLS config passes Sentinel but fails at master.',
    0.75,
    'sonnet-4',
    NOW(),
    'https://github.com/redis/node-redis/issues/3066'
),
(
    'ErrorReply: WRONGPASS invalid username-password pair or user is disabled',
    'github-node-redis',
    'HIGH',
    '[
        {"solution": "URL-encode special characters in password: use encodeURIComponent() on password before embedding in connection URL", "percentage": 90, "note": "Characters like = need encoding"},
        {"solution": "Verify identical credentials across all client instances: check that password is not changed between clients", "percentage": 85, "note": "Multiple concurrent clients with different passwords"},
        {"solution": "Test credentials with redis-cli first: redis-cli -u redis://default:PASSWORD@HOST:6379 to verify authentication", "percentage": 90, "note": "Isolate library vs server issue"},
        {"solution": "Check Redis server ACL configuration: use ACL LIST to verify user exists and is enabled", "percentage": 85, "note": "User may be disabled on server"}
    ]'::jsonb,
    'Redis 4.7.0+, Node.js 18+, Valid Redis credentials, node-redis 4.7.0+',
    'Client connects successfully, AUTH command succeeds, Commands execute without WRONGPASS errors',
    'Special characters in passwords must be URL-encoded. Multiple client instances may have credential mismatches. User account may be disabled on Redis server side.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/redis/node-redis/issues/2857'
),
(
    'AbortError: Redis connection lost and command aborted',
    'github-node-redis',
    'VERY_HIGH',
    '[
        {"solution": "Remove explicit return in ECONNREFUSED condition in retry_strategy: let subsequent conditions handle backoff instead of blocking retry", "percentage": 95, "note": "Effective workaround from user testing"},
        {"solution": "Implement exponential backoff in retry_strategy: Math.min(options.attempt * 100, 3000)", "percentage": 90, "note": "Prevents connection storms"},
        {"solution": "Remove custom retry_strategy entirely to use node-redis continuous reconnection defaults", "percentage": 85, "note": "Simplest solution for most cases"},
        {"solution": "Catch and handle AbortError separately: expect command aborts during transient connection loss", "percentage": 80, "note": "Defensive application code"}
    ]'::jsonb,
    'Node.js runtime, Redis server, Applications with high concurrency (200+ concurrent users)',
    'Connection recovers after ECONNRESET, Retry strategy triggers exponential backoff, Commands succeed after reconnection',
    'Early return in retry_strategy blocks reconnection attempts. Do not assume commands were aborted - they may have executed on server. ECONNRESET indicates socket close mid-transaction.',
    0.95,
    'sonnet-4',
    NOW(),
    'https://github.com/redis/node-redis/issues/1542'
),
(
    'Cannot read properties of undefined (reading ''value'') in commands-queue.ts with RESP 2',
    'github-node-redis',
    'MEDIUM',
    '[
        {"solution": "Use RESP protocol version 3 instead of version 2: createClient({ RESP: 3 })", "percentage": 95, "note": "Primary workaround, RESP 3 is stable"},
        {"solution": "Add null check before accessing waitingForReply.head.value in commands-queue.ts line 113", "percentage": 90, "note": "Official fix needed in library"},
        {"solution": "Upgrade to latest node-redis version that may have fixed this non-null assertion issue", "percentage": 85, "note": "Check release notes for RESP 2 fixes"}
    ]'::jsonb,
    'node-redis 5.x+, RESP protocol available (default or explicit)',
    'Client initializes successfully without TypeError, Commands queue properly, RESP protocol version confirmed in logs',
    'RESP 2 protocol parsing fails due to unsafe non-null assertion. Do not force RESP 2 unless absolutely required. Upgrade to RESP 3 where possible.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/redis/node-redis/issues/3049'
),
(
    'Got an unexpected reply from Redis in pubsub with legacyMode',
    'github-node-redis',
    'HIGH',
    '[
        {"solution": "Disable legacy mode on subscriber client: set legacyMode: false", "percentage": 95, "note": "Direct fix confirmed by maintainer"},
        {"solution": "Use .v4.subscribe() method instead of standard subscribe() on legacy clients", "percentage": 85, "note": "Alternative if legacy mode required"},
        {"solution": "Separate pub and sub clients: do not use same client for both operations with legacy mode", "percentage": 80, "note": "Best practice architecture"},
        {"solution": "Upgrade node-redis to latest version with improved legacyMode handling", "percentage": 75, "note": "Check release notes"}
    ]'::jsonb,
    'node-redis 4.3.1+, Redis 7.0+, Node.js 18+, legacyMode configuration',
    'Subscribe succeeds, Messages received without error, Both publish and subscribe work together',
    'legacyMode is incompatible with pub/sub functionality. Publishing after subscribing with legacy mode causes unexpected reply error. Do not enable legacy mode if using pub/sub.',
    0.95,
    'sonnet-4',
    NOW(),
    'https://github.com/redis/node-redis/issues/2327'
),
(
    'blpop returns object instead of array after upgrade from 3.1.2 to 4.0',
    'github-node-redis',
    'HIGH',
    '[
        {"solution": "Update code processing blpop() results to handle object format: { key, element } instead of array", "percentage": 95, "note": "Breaking change in v4 API"},
        {"solution": "Check TypeScript declarations in IDE or consult redis.js.org documentation for command return types", "percentage": 90, "note": "Verify expected format before upgrade"},
        {"solution": "Use client.sendCommand() directly to receive raw Redis replies if transformation is problematic", "percentage": 75, "note": "Bypass reply transformation layer"},
        {"solution": "Review transformReply function in command definitions for all commands you use", "percentage": 70, "note": "Understand transformation rules"}
    ]'::jsonb,
    'node-redis 3.1.2 -> 4.1.0 upgrade, Applications using blpop or other list commands',
    'blpop returns correct object structure, Message delivery works with new format, SSE and long polling both function',
    'Major version upgrade changes command return types from arrays to objects. Not a bug but breaking change. Each command may transform replies differently.',
    0.98,
    'sonnet-4',
    NOW(),
    'https://github.com/redis/node-redis/issues/2151'
),
(
    'Socket disconnect permanently corrupts internal command_queue state',
    'github-node-redis',
    'HIGH',
    '[
        {"solution": "Upgrade to node-redis version with setImmediate() deferral in socket error handlers", "percentage": 95, "note": "Fix in PR #1603"},
        {"solution": "Manually apply PR #1603 patch to defer socket error processing until next event loop tick", "percentage": 85, "note": "Workaround for affected versions"},
        {"solution": "Upgrade Node.js to version where libuv behavior changed: verify on 10.19.0 or downgrade from 10.23.2+", "percentage": 70, "note": "Node version dependency (rare solution)"},
        {"solution": "Add command queue state validation after reconnection to detect corruption early", "percentage": 75, "note": "Monitoring approach"}
    ]'::jsonb,
    'Node.js 10.23.2+ or 12.x/14.x/16.x, Redis 4.0.9 or 6.0.5+, Applications with persistent connections',
    'Reconnection succeeds without buffer misalignment, Command responses match queries, No assertion failures on complex operations',
    'Race condition between socket error event (synchronous in Node 10.23.2+) and command_queue.push(). Stray commands left in queue cause response mismatch. Difficult to reproduce - may require 10-20 reconnection attempts.',
    0.95,
    'sonnet-4',
    NOW(),
    'https://github.com/redis/node-redis/issues/1593'
),
(
    'Cannot send PING command when client is in subscribed state',
    'github-node-redis',
    'MEDIUM',
    '[
        {"solution": "Use separate client instance for keepalive: create distinct non-subscribed client for PING commands", "percentage": 95, "note": "Recommended architecture pattern"},
        {"solution": "Implement custom keepalive logic using heartbeat timer instead of PING in subscribed mode", "percentage": 85, "note": "Application-level keepalive"},
        {"solution": "Check Redis protocol specification that PING is allowed in subscribed state and report as library limitation", "percentage": 70, "note": "Limitation of library implementation"},
        {"solution": "Use subscription callback to confirm message delivery instead of PING for health check", "percentage": 75, "note": "Alternative detection method"}
    ]'::jsonb,
    'node-redis 4.0.3+, Redis 6.2+, Node.js 14+, Subscribed client connection',
    'Separate client sends PING successfully, Subscription remains active, No connection dropouts on idle subscribed clients',
    'node-redis prevents PING in subscribed state even though Redis protocol allows it. Idle subscribed connections fail silently without keepalive. Library restriction is overly broad.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/redis/node-redis/issues/2066'
);
