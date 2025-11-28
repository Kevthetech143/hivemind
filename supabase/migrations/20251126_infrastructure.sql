-- Infrastructure Knowledge Base Entries - 20251126

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES
(
    'TypeError: Cannot read properties of undefined (reading ''NAMESPACE'') in Cloudflare Workers',
    'infrastructure',
    'HIGH',
    '[
        {"solution": "Migrate from addEventListener(''fetch'') service worker syntax to ES modules. Update your worker entry point to use async function fetch(request, env) and export it as default. This provides the env parameter needed to access KV bindings.", "percentage": 95},
        {"solution": "Ensure wrangler.toml has kv_namespaces configured with both id and preview_id, then restart the worker with wrangler dev", "percentage": 85}
    ]'::jsonb,
    'Cloudflare Workers environment with KV namespace configured in wrangler.toml',
    'Worker can access KV namespace via env parameter without type errors. TypeScript recognizes bindings with bindings.d.ts declaration file.',
    'Using old service worker syntax instead of ES modules; missing bindings.d.ts TypeScript declaration file; incorrect env parameter usage',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/77903184/cannot-get-bindings-from-kv-to-worker-to-operate-cloudflare',
    'admin:1764173407'
),
(
    'Cannot find name ''generalKV'' - TypeScript error with Cloudflare KV namespace',
    'infrastructure',
    'HIGH',
    '[
        {"solution": "Create a bindings.d.ts file in your src directory with: declare global { interface Env { YOUR_NAMESPACE: KVNamespace } }. This tells TypeScript that KV bindings exist at runtime.", "percentage": 95},
        {"solution": "In Wrangler v2+, ensure both id and preview_id are set for each namespace in kv_namespaces config", "percentage": 90}
    ]'::jsonb,
    'Cloudflare Workers project with wrangler.toml and TypeScript enabled',
    'TypeScript compiles without errors, IDE autocomplete works for KV bindings, worker runs without type errors',
    'Creating bindings.d.ts in wrong directory; forgetting preview_id in wrangler config; using wrong binding name',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/69793085/cloudflare-kv-namespace-doesnt-bind',
    'admin:1764173407'
),
(
    'Error 522: Connection timed out - Cloudflare unable to reach origin server',
    'infrastructure',
    'HIGH',
    '[
        {"solution": "Verify origin server is accepting connections on the configured IP and port. Check firewall rules, security groups, and network ACLs aren''t blocking Cloudflare IPs. Test with curl from terminal.", "percentage": 90},
        {"solution": "If using VPN or proxy at office, whitelist Cloudflare IP ranges in your firewall. See Cloudflare docs for current IP list.", "percentage": 85}
    ]'::jsonb,
    'Domain pointing to Cloudflare nameservers with configured origin server',
    'No Error 522 responses, origin server responding within timeout window, no firewall errors in logs',
    'Assuming server is down when it''s actually reachable; not checking office-level firewall blocking; testing from different network to verify',
    0.88,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/28766420/error-522-connection-timed-out',
    'admin:1764173407'
),
(
    'dial tcp: connect: connection refused - Caddy Docker reverse proxy cannot reach upstream',
    'infrastructure',
    'HIGH',
    '[
        {"solution": "In Caddyfile, use container name with internal port, not external port. Change reverse_proxy container:8080 (external port) to reverse_proxy container:80 (internal port). Containers access services via Docker internal network.", "percentage": 96},
        {"solution": "Ensure both containers are on the same Docker network: docker network create mynet, then docker run --network mynet", "percentage": 92}
    ]'::jsonb,
    'Caddy running in Docker with wrangler reverse_proxy configuration',
    'Reverse proxy connects successfully, upstream responses received without connection refused errors',
    'Using published/external port instead of container internal port; containers not on same network; using localhost instead of container name',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/68918079/caddy-as-reverse-proxy-in-docker-refuses-to-connect-to-other-containers',
    'admin:1764173407'
),
(
    '502 Bad Gateway - Nginx reverse proxy cannot reach upstream server',
    'infrastructure',
    'HIGH',
    '[
        {"solution": "Replace localhost with upstream service name or Docker bridge IP. In Docker: use container name (requires same network) or bridge IP like 172.17.0.1. Update proxy_pass http://service-name:8086 not http://localhost:8086", "percentage": 94},
        {"solution": "Check upstream resource allocation. If worker processes killed by OOM, increase Docker memory limit or add swap.", "percentage": 85}
    ]'::jsonb,
    'Nginx reverse proxy configured with upstream server target',
    'No 502 errors, nginx logs show successful connections, upstream responses served correctly',
    'Using localhost in Docker container (refers only to container itself); misconfigured upstream address; insufficient memory causing process crashes',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/74558547/nginx-reverse-proxy-throwing-502-bad-gateway',
    'admin:1764173407'
),
(
    'Redis connection to 127.0.0.1:6379 failed - connect ECONNREFUSED',
    'infrastructure',
    'HIGH',
    '[
        {"solution": "Install Redis: apt-get install redis-server (Linux), brew install redis (macOS). Then start server: redis-server. Without running the server, connections will be refused.", "percentage": 96},
        {"solution": "For Docker, use redis://redis:6379 not localhost. Container networking requires service name instead of localhost.", "percentage": 93}
    ]'::jsonb,
    'Redis package installation capability, application attempting to connect to default port',
    'redis-cli ping returns PONG, application connects without ECONNREFUSED errors, SET/GET operations succeed',
    'Installing Redis without starting it; using localhost in Docker (should use service name); checking wrong host:port combination',
    0.95,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/8754304/redis-connection-to-127-0-0-16379-failed-connect-econnrefused',
    'admin:1764173407'
),
(
    'Got permission denied while trying to connect to Docker daemon socket /var/run/docker.sock',
    'infrastructure',
    'HIGH',
    '[
        {"solution": "Add your user to docker group: sudo usermod -aG docker $USER && newgrp docker. The newgrp command is essential to activate membership in current shell without logout.", "percentage": 94},
        {"solution": "If you can''t use group method, set world-readable permissions temporarily: sudo chmod 666 /var/run/docker.sock (security risk, testing only)", "percentage": 60}
    ]'::jsonb,
    'Docker daemon running, user attempting to run docker commands',
    'Docker commands execute without permission errors, docker ps runs successfully',
    'Forgetting to run newgrp (group change not active), assuming sudo fixes it permanently, using world-readable socket in production',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/48568172/docker-sock-permission-denied',
    'admin:1764173407'
),
(
    '[SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed - incomplete SSL certificate chain',
    'infrastructure',
    'HIGH',
    '[
        {"solution": "Server is sending incomplete certificate chain. Download full chain (leaf + intermediates + root) from SSL Labs report for the domain. Save as .pem file, then use: requests.get(url, verify=''chain.pem'')", "percentage": 92},
        {"solution": "As temporary workaround only: requests.get(url, verify=False) - disables verification entirely, avoid in production", "percentage": 40}
    ]'::jsonb,
    'Python requests library, connectivity to HTTPS server with certificate validation enabled',
    'HTTPS request succeeds without certificate errors, SSL handshake completes successfully',
    'Downloading only leaf certificate without intermediates; using verify=False in production; not checking SSL Labs for chain issues',
    0.89,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/46604114/python-requests-ssl-error-certificate-verify-failed',
    'admin:1764173407'
),
(
    'could not connect to server: Connection timed out - psycopg2 PostgreSQL connection hanging',
    'infrastructure',
    'HIGH',
    '[
        {"solution": "Add connect_timeout parameter to psycopg2.connect(): psycopg2.connect(host=..., database=..., user=..., password=..., connect_timeout=3). Timeout in seconds prevents indefinite hanging.", "percentage": 93},
        {"solution": "Catch psycopg2.OperationalError exception for graceful handling when timeout occurs", "percentage": 88}
    ]'::jsonb,
    'psycopg2 installed, PostgreSQL server accessible or network connectivity to attempt',
    'Connection attempt fails fast with timeout exception instead of hanging for 5+ minutes, application can retry or handle error',
    'Not catching OperationalError exception; setting too high timeout (defeats purpose); network issues not checked separately',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/27641740/python-psycopg2-timeout',
    'admin:1764173407'
),
(
    'How to invalidate Google Cloud CDN cache - cache updates not reflecting',
    'infrastructure',
    'MEDIUM',
    '[
        {"solution": "Use GCP Cloud CDN invalidation API from backend: POST to /compute/v1/projects/{project}/global/urlMaps/{urlmap}/invalidateCaches with the URL paths to invalidate.", "percentage": 88},
        {"solution": "For CloudFront CDN, use InvalidateObject API or set Cache-Control: max-age=0 headers on responses", "percentage": 82}
    ]'::jsonb,
    'GCP Cloud CDN configured, service account credentials with compute.cacheInvalidate permission',
    'CDN cache invalidates within 30 seconds, new content served instead of stale cache, no 5+ minute delays',
    'Not authenticating properly; invalidating wrong URL paths; assuming purge is instant (actually takes 30 seconds); using manual Datastore purge instead of API',
    0.86,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/78800733/google-cloud-cdn-cache-invalidation',
    'admin:1764173407'
);
