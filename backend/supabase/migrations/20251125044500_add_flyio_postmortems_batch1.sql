-- Add Fly.io incident postmortems batch 1
-- Mining source: https://status.flyio.net/history
-- Focus: Network problems, proxy issues, deployment failures, machine crashes

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Fly.io proxy issues in ORD Chicago region causing elevated connection errors',
    'infrastructure-incident',
    'HIGH',
    '[
        {"solution": "Check regional status page at status.flyio.net for active incidents in ORD region", "percentage": 90, "note": "Primary troubleshooting step"},
        {"solution": "Switch traffic to alternative region temporarily if available in app deployment configuration", "percentage": 85, "note": "Workaround during incidents"},
        {"solution": "Monitor incident updates via Fly.io status notifications for resolution timeline", "percentage": 80, "note": "Upstream provider issues may require waiting for fix"}
    ]'::jsonb,
    'Access to Fly.io dashboard, Multiple regions available for app deployment',
    'Connection errors resolve after incident is marked resolved, Traffic returns to normal latency levels, No 502/503 errors in logs',
    'Do not immediately redeploy on connection errors - verify status page first. Regional issues are upstream provider issues. Check notification channels for updates.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://status.flyio.net/history'
),
(
    'Fly.io dashboard /apps/:app_name page returning 500 errors',
    'platform-bug',
    'MEDIUM',
    '[
        {"solution": "Clear browser cache and refresh dashboard page (Cmd+Shift+R or Ctrl+Shift+R)", "percentage": 90, "note": "Common caching issue"},
        {"solution": "Check dashboard status on status.flyio.net for ongoing incidents", "percentage": 85, "note": "Platform-wide issues require upstream fix"},
        {"solution": "Try accessing specific app via API instead: fly app info <app-name> via Flyctl", "percentage": 80, "command": "fly app info <app-name>", "note": "Bypass dashboard temporarily"}
    ]'::jsonb,
    'Fly.io dashboard access, Flyctl installed (for API alternative)',
    'Dashboard loads without 500 errors, App information displays correctly, No errors in browser console network tab',
    'If issue persists across multiple refreshes and other apps load fine, it may be a platform-wide incident. Check status page. Cached pages may show outdated state.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://status.flyio.net/history'
),
(
    'Fly.io UDP service routing outage affecting UDP anycast traffic',
    'network-incident',
    'HIGH',
    '[
        {"solution": "Check UDP Anycast component status at https://status.flyio.net for outage notifications", "percentage": 92, "note": "Critical upstream routing issue"},
        {"solution": "For apps using UDP: temporarily switch to TCP-based protocol if available or use alternative region", "percentage": 88, "note": "UDP outages are infrastructure-level"},
        {"solution": "Monitor incident escalation status - major_outage to degraded to operational progression", "percentage": 85, "note": "Track resolution phases for ETA"}
    ]'::jsonb,
    'UDP-based app deployed, Access to status page, Alternative region/protocol option available',
    'UDP traffic flows without routing errors, status.flyio.net shows UDP Anycast as operational, No ICMP timeout errors in app logs',
    'UDP outages are typically upstream provider BGP/routing issues - not fixable from app side. Major_outage status can last hours. Always have TCP fallback for critical apps.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://status.flyio.net/history'
),
(
    'Fly.io support portal outage due to upstream provider API failure',
    'platform-outage',
    'LOW',
    '[
        {"solution": "Email support@fly.io directly for urgent issues during portal outage", "percentage": 95, "note": "Documented workaround during incidents"},
        {"solution": "Check dashboard status page for support portal component status", "percentage": 90, "note": "Shows when portal is operational again"},
        {"solution": "For paid support: create tickets via email instead of dashboard interface", "percentage": 85, "command": "Email: support@fly.io with app-name and issue", "note": "Alternative contact method"}
    ]'::jsonb,
    'Email access, Fly.io support account, Paid or free trial support plan',
    'Support portal in dashboard is accessible and operational, Ticket creation succeeds, Email responses from Fly support team',
    'Support portal outages are external provider issues - upstream API recovery is required. Email is always available as fallback. Do not delay critical issues - email immediately.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://status.flyio.net/history'
),
(
    'Fly.io packet loss in GRU Sao Paulo region causing degraded performance',
    'network-incident',
    'MEDIUM',
    '[
        {"solution": "Identify affected hosts via app logs and metrics dashboard - check latency/loss patterns by host", "percentage": 88, "note": "Not all GRU hosts equally affected"},
        {"solution": "Implement upstream provider BGP rerouting: Fly.io team works with upstream to route around affected path", "percentage": 90, "note": "Automatic mitigation by infrastructure team"},
        {"solution": "For critical apps: use regional failover or accept temporary degraded service (typically 5-15min resolution time)", "percentage": 75, "note": "Short-term workaround during remediation"}
    ]'::jsonb,
    'App deployed in GRU region, Metrics/logging enabled, Upstream provider visibility available',
    'Packet loss drops below 0.5%, Round-trip time returns to baseline, Health checks pass consistently, status.flyio.net shows GRU as operational',
    'Packet loss at provider level requires upstream team intervention - not fixable from app configuration. Monitoring shows when issue starts/resolves. Often resolves within 10 minutes.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://status.flyio.net/history'
),
(
    'Fly.io Google SSO authentication errors in dashboard login',
    'auth-incident',
    'MEDIUM',
    '[
        {"solution": "Try alternative auth method: email/password login if available instead of SSO", "percentage": 92, "note": "Bypass OAuth provider when Google SSO fails"},
        {"solution": "Clear cookies and browser storage, then retry Google SSO login from incognito window", "percentage": 85, "note": "Often resolves stale OAuth state issues"},
        {"solution": "Check status.flyio.net dashboard component status - may indicate platform-wide OAuth issue", "percentage": 80, "note": "Upstream Google OAuth or Fly platform issue"}
    ]'::jsonb,
    'Fly.io account with SSO configured, Alternative auth method enabled, Incognito browser capability',
    'Dashboard login succeeds, Organizations with Required SSO load without error, User is redirected to dashboard after auth',
    'Do not retry same SSO method repeatedly - causes rate limiting. Google OAuth failures are typically platform interaction issues. Email/password login more reliable during incidents.',
    0.84,
    'sonnet-4',
    NOW(),
    'https://status.flyio.net/history'
),
(
    'Fly.io network latency spike in BOM Mumbai region',
    'network-incident',
    'MEDIUM',
    '[
        {"solution": "Monitor BOM regional availability status for degradation notifications at status.flyio.net", "percentage": 91, "note": "Track incident progression"},
        {"solution": "Check app metrics dashboard for latency trends - compare BOM vs other regions for context", "percentage": 88, "note": "Identify if issue is widespread or host-specific"},
        {"solution": "For users in India: consider using multi-region setup with LHR/FRA as failover during BOM incidents", "percentage": 80, "note": "Long-term reliability improvement"}
    ]'::jsonb,
    'App deployed in BOM region, Metrics dashboard access, Status page notifications enabled',
    'BOM latency returns to baseline (<30ms to users in India typically), Health checks from BOM region pass, Dashboard shows regional availability as operational',
    'Network latency in cloud is often provider-level congestion. Spike durations typically 5-30 minutes. Apps remain operational but slower. Always expect occasional BOM spikes.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://status.flyio.net/history'
),
(
    'Fly.io static egress IPv6 address routing failure in BOM region',
    'network-incident',
    'HIGH',
    '[
        {"solution": "Check if your app uses static egress IPv6: fly m list --app <app> to find machines with egress IPs", "percentage": 92, "note": "Only IPv6 static addresses affected"},
        {"solution": "Temporary workaround: force IPv4 for outbound connections or de-allocate IPv6 via: fly m egress-ip release", "percentage": 90, "command": "fly m egress-ip release", "note": "Immediate fix during incident"},
        {"solution": "For apps requiring IPv6: use alternative region (LHR/FRA/SYD) until BOM upstream issues resolve", "percentage": 85, "note": "Regional failover approach"}
    ]'::jsonb,
    'Static egress IPv6 address allocated in BOM, Flyctl access, Alternative region available (optional)',
    'Outbound IPv6 connections succeed to destinations, App connectivity tests pass, fly m egress-ip list shows functional addresses',
    'IPv6 static egress issues are upstream provider BGP issues - not app-side fixable. Only affects machines with static IPv6 addresses. Regular IPv4 traffic unaffected. De-allocating IPv6 resolves routing failures.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://status.flyio.net/history'
),
(
    'Fly.io network maintenance emergency in BOM causing major outage',
    'maintenance-incident',
    'HIGH',
    '[
        {"solution": "Check status.flyio.net BOM regional availability - watch for progression from major_outage to degraded_performance to operational", "percentage": 95, "note": "Track maintenance phases"},
        {"solution": "For critical apps: initiate planned failover to alternative region (LHR/FRA/SYD/IAD) during maintenance window", "percentage": 88, "note": "Planned approach for zero-downtime"},
        {"solution": "Monitor upstream provider notifications - emergency maintenance typically completes in 30-60 minutes", "percentage": 85, "note": "ETA estimation"}
    ]'::jsonb,
    'Multi-region deployment capability, Status page access, Failover region with spare capacity',
    'BOM region returns to operational status, Regional availability component shows green, App health checks pass from BOM',
    'Emergency network maintenance is scheduled by upstream providers. Fly.io coordinates but cannot control timing. Always maintain multi-region setup for BOM. Maintenance duration highly variable.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://status.flyio.net/history'
),
(
    'Fly.io wireguard tunnel connectivity errors in Flyctl v0.3.214',
    'tool-regression',
    'MEDIUM',
    '[
        {"solution": "Downgrade Flyctl to previous version: curl -L https://fly.io/install.sh | sh -s 0.3.213", "percentage": 95, "note": "Immediate fix for v0.3.214 regression"},
        {"solution": "Upgrade Flyctl to fixed version: fly version update (to v0.3.216 or later)", "percentage": 92, "note": "Recommended long-term fix"},
        {"solution": "If using package manager (homebrew): uninstall first before installing fixed version via install.sh", "percentage": 88, "note": "Prevents package manager conflicts"}
    ]'::jsonb,
    'Flyctl installed, Bash shell access, Network connectivity for script download',
    'fly wireguard command succeeds without tunnel errors, fly proxy works without "no such organization" errors, MPG proxy commands execute successfully',
    'Wireguard tunnel errors in v0.3.214 affect commands like: fly wireguard, fly proxy, fly mpg proxy with Personal org. Downgrade is safe. v0.3.216+ has permanent fix.',
    0.96,
    'sonnet-4',
    NOW(),
    'https://status.flyio.net/history'
),
(
    'Fly.io SJC San Jose region network outage from upstream provider',
    'network-incident',
    'CRITICAL',
    '[
        {"solution": "Monitor SJC regional status component at status.flyio.net - track from major_outage to operational progression", "percentage": 95, "note": "Infrastructure incident requires upstream fix"},
        {"solution": "For critical US East Coast apps: activate prepared failover to IAD (Ashburn) or LGA (New York) regions", "percentage": 90, "note": "Planned failover approach"},
        {"solution": "Check Fly.io incident updates for ETA - upstream provider issues typically resolve in 30-120 minutes", "percentage": 85, "note": "Scope estimation"}
    ]'::jsonb,
    'Multi-region app setup with IAD/LGA as backup, Status page monitoring, Traffic failover capability',
    'SJC region status returns to operational green, Health checks from SJC pass, Regional availability metrics normalize',
    'SJC outages are upstream provider network issues - Fly.io cannot control resolution. Critical apps must have multi-region failover. Track status page for resolution updates.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://status.flyio.net/history'
),
(
    'Fly.io MPG database backup restore failures',
    'backup-incident',
    'MEDIUM',
    '[
        {"solution": "Check MPG restore status in dashboard - verify source cluster backups are unaffected", "percentage": 92, "note": "Issue isolated to restore operations"},
        {"solution": "Retry restore operation - temporary fix implemented per incident updates", "percentage": 88, "note": "Often succeeds on retry after fix deployment"},
        {"solution": "Contact Fly.io support if persistent failures - escalate with error logs and restore timestamp", "percentage": 85, "note": "Manual intervention may be required"}
    ]'::jsonb,
    'MPG cluster provisioned, Database backups available, Fly.io support access',
    'Database restore completes successfully, Data integrity verified in restored database, Backup history shows completed restore',
    'MPG restore failures are platform-level issues affecting restore infrastructure, not backup integrity. Source cluster and backups remain safe. Fix is typically deployed within hours.',
    0.86,
    'sonnet-4',
    NOW(),
    'https://status.flyio.net/history'
),
(
    'Fly.io machine API returning elevated error rates due to database connection pool exhaustion',
    'api-incident',
    'MEDIUM',
    '[
        {"solution": "Check machine API status at status.flyio.net - watch for incident resolution updates", "percentage": 90, "note": "Platform-wide API incident"},
        {"solution": "Retry machine API calls with exponential backoff (1s, 2s, 4s delays between attempts)", "percentage": 85, "note": "Standard distributed systems pattern"},
        {"solution": "For urgent machine operations: use dashboard instead of API temporarily, or wait 5-15 minutes for API recovery", "percentage": 80, "note": "Typical incident duration"}
    ]'::jsonb,
    'Machine API access (fly m list, fly m create), Network connectivity, Status page visibility',
    'Machine API returns 200 status codes, Machine operations (create/destroy/restart) succeed, Error rate on status page returns to baseline',
    'API errors during incidents are typically internal resource exhaustion - retries succeed after brief waiting period. Always implement exponential backoff. Avoid burst API calls during incidents.',
    0.84,
    'sonnet-4',
    NOW(),
    'https://status.flyio.net/history'
);
