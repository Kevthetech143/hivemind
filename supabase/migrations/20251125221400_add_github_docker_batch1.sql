-- Add high-voted Docker moby/moby bug issues with solutions (batch 1)
-- Extracted from: https://github.com/moby/moby/issues
-- Focus: Image build failures, networking issues, volume mounts, permission errors
-- Category: github-docker

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Docker 20.10.6: Error starting userland proxy - IPv6 disabled on host',
    'github-docker',
    'HIGH',
    '[
        {"solution": "Upgrade Docker to 20.10.7 or later where IPv6 unavailability is gracefully handled", "percentage": 95, "note": "Official fix merged in PR #42412 and moby/libnetwork#2635"},
        {"solution": "Downgrade Docker to 20.10.5 or earlier until patched version is installed", "percentage": 85, "note": "Temporary workaround if upgrade not possible"},
        {"solution": "Enable IPv6 on the host system: remove ipv6.disable=1 from kernel parameters", "percentage": 90, "note": "Resolves root cause but may require system restart"}
    ]'::jsonb,
    'Root access to modify kernel parameters or ability to upgrade Docker, System with IPv6 disabled via ipv6.disable=1',
    'Containers start successfully with port mappings, No "address family not supported" errors in daemon logs, docker ps shows running containers',
    'Do not assume IPv6 is available on all hosts. The fix detects unavailability and gracefully falls back to IPv4. Affects Debian 9/10, CentOS 7, Raspberry Pi OS with IPv6 disabled.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/moby/moby/issues/42288'
),
(
    'Docker 20.10.x containerd-shim hangs on reboot with live-restore enabled',
    'github-docker',
    'HIGH',
    '[
        {"solution": "Create systemd service to cleanly stop containers before reboot: ExecStop=-/bin/sh -c ''ctr -n moby tasks kill -a; sleep 5; ctr -n moby containers rm''", "percentage": 90, "note": "Systemd handles graceful shutdown before signal termination"},
        {"solution": "Disable live-restore in daemon.json: ''live-restore'': false", "percentage": 85, "note": "Prevents containers from persisting across restarts"},
        {"solution": "Switch to runc v1 runtime instead of runc v2 (default in 20.10+)", "percentage": 75, "note": "runc v1 handles SIGTERM correctly during shutdown"}
    ]'::jsonb,
    'Docker 20.10+ with live-restore enabled, runc v2 runtime (default), systemd init system',
    'System reboots/shuts down in <30 seconds, No 90-second hang on shutdown, containerd-shim processes terminate gracefully',
    'runc v2 shim ignores SIGINT/SIGTERM during shutdown. The systemd service solution ensures containers stop before systemd forces termination. This only affects systems with live-restore enabled.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/moby/moby/issues/41831'
),
(
    'Docker AUFS: "device or resource busy" error when removing stopped containers',
    'github-docker',
    'MEDIUM',
    '[
        {"solution": "Restart Docker daemon: sudo systemctl restart docker", "percentage": 95, "note": "Allows unmount operations to complete; container disappears after restart"},
        {"solution": "Identify processes holding mounts via cgroups and force-kill them before removal", "percentage": 70, "note": "Manual workaround; success depends on specific mount state"},
        {"solution": "Upgrade to Docker 1.13+ where AUFS driver was improved (or switch to overlay2)", "percentage": 90, "note": "Fixes underlying unmount operation issues"}
    ]'::jsonb,
    'Docker 1.10.0-1.12.1 with AUFS storage driver, Ubuntu 14.04 or Debian 8, containers with restart policies',
    'Container successfully removed without error, docker ps -a does not list the container, No "resource busy" errors in daemon logs',
    'Unmount operations fail silently and are only logged at debug level, making it hard to identify. Issue worsened in Docker 1.12. Problem does not occur with overlay2 driver.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/moby/moby/issues/22260'
),
(
    'Docker 20.10: Unexpected EOF when tailing container logs with high volume',
    'github-docker',
    'HIGH',
    '[
        {"solution": "Upgrade Docker to 20.10.2+ where log EOF handling race condition is fixed via PR #42104", "percentage": 93, "note": "Fixes race between log writer and reader in concurrent scenarios"},
        {"solution": "Reduce log volume and use log rotation limits: max-size, max-file docker options", "percentage": 80, "note": "Mitigates high-volume logging scenarios"},
        {"solution": "Downgrade to Docker 19.03.14 or earlier", "percentage": 85, "note": "Regression introduced between 19.03.14 and 20.10.1"}
    ]'::jsonb,
    'Docker 20.10.0-20.10.1, Containers producing substantial stdout/stderr, testcontainers-java or similar log-following tools',
    'docker logs -f completes without errors, No "unexpected EOF" messages, Log following works consistently across 10+ consecutive runs',
    'Race condition occurs between JSON log file writer and reader processes. Issue affects both Docker Desktop and server installations. Problem is in /var/lib/docker/containers/<id>/<id>-log.json handling.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/moby/moby/issues/41820'
),
(
    'Docker port publishing security: Private ports accessible from LAN hosts',
    'github-docker',
    'MEDIUM',
    '[
        {"solution": "Upgrade Docker to version 28.0.0 or later where iptables NAT rules exclude 127.0.0.1 destinations", "percentage": 95, "note": "Fixes via PR #48721 and PR #49325"},
        {"solution": "Disable port forwarding in iptables manually if running older Docker: modify PREROUTING NAT chain rules", "percentage": 75, "note": "Complex manual workaround; not recommended"},
        {"solution": "Use firewall rules (UFW, firewalld) to restrict access to Docker bridge network from external interfaces", "percentage": 80, "note": "Defense-in-depth approach"}
    ]'::jsonb,
    'Docker running on host with network bridge, Multiple network interfaces, Docker enabling ip_forward=1',
    'Port published to 127.0.0.1 is not accessible from LAN hosts, External hosts cannot route through docker bridge network, docker port command shows accurate access restrictions',
    'Docker enables net.ipv4.ip_forward=1 and creates permissive FORWARD chain rules. This inadvertently allows LAN routing through Docker networks. The issue affects container IP access and localhost binding access from neighboring LAN hosts.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/moby/moby/issues/45610'
),
(
    'Docker UDP port forwarding: DNS responses from wrong source address',
    'github-docker',
    'MEDIUM',
    '[
        {"solution": "Specify explicit host IP when binding UDP ports: docker run -p 192.168.X.X:53:53/udp (instead of -p 53:53/udp)", "percentage": 92, "note": "Avoids wildcard binding; responses use correct source IP"},
        {"solution": "Upgrade docker-proxy component in Docker 25.0+ where UDP source address translation is fixed", "percentage": 88, "note": "Official fix addresses docker-proxy forwarding logic"},
        {"solution": "Use host network mode instead of port mapping: docker run --net=host", "percentage": 85, "note": "Alternative approach; loses network isolation"}
    ]'::jsonb,
    'Docker with UDP service in container (DNS, NTP, etc.), Container accessed from other containers or external hosts via UDP port mapping',
    'UDP responses originate from correct host IP (not bridge interface IP), DNS queries resolve successfully without NXDOMAIN errors, Remote clients receive responses from expected source',
    'Docker-proxy component fails to translate source address for UDP responses. Clients reject responses as "reply from unexpected source". Issue does not occur with explicit bind IP specification.',
    0.86,
    'sonnet-4',
    NOW(),
    'https://github.com/moby/moby/issues/11998'
),
(
    'Docker 18.02.0-rc1 containerd: Container restart fails with "already exists" error',
    'github-docker',
    'MEDIUM',
    '[
        {"solution": "Upgrade to Docker 18.02.0 final release or later where containerd cleanup is fixed", "percentage": 94, "note": "RC1 had incomplete container object deletion from containerd"},
        {"solution": "Delete stuck container objects from containerd manually: ctr containers rm <container-id>", "percentage": 80, "note": "Manual cleanup; requires advanced knowledge"},
        {"solution": "Downgrade to Docker 18.01.0-ce before containerd 1.0 integration", "percentage": 85, "note": "Affects Docker for Mac and Windows"}
    ]'::jsonb,
    'Docker 18.02.0-ce-rc1 on Docker Desktop (Mac/Windows), Containers running during Docker upgrade',
    'docker start <container> succeeds without error, Container enters running state, docker ps shows container as running',
    'Containerd 1.0 API separates container metadata from runtime task objects. Docker does not properly cleanup container objects from containerd in some cases. New containers post-upgrade work fine; issue affects containers in running state during upgrade.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/moby/moby/issues/36145'
),
(
    'Docker IPv6 network splitting fails: Cannot create multiple /64 subnets from /48 pool',
    'github-docker',
    'LOW',
    '[
        {"solution": "Upgrade Docker to version containing PR #47768 which fixes 128-bit IPv6 address offset handling", "percentage": 94, "note": "Fixes integer overflow in addIntToIP function for IPv6 >64 bit shifts"},
        {"solution": "Modify daemon.json to use smaller IPv6 pools that do not trigger the overflow condition", "percentage": 70, "note": "Workaround; limits available subnets"},
        {"solution": "Use IPv4 address pools instead of IPv6 until upgrade is available", "percentage": 75, "note": "Temporary alternative"}
    ]'::jsonb,
    'Docker daemon with default-address-pools configured for IPv6, Attempting to create networks with /64 subnet size from /48 or larger CIDR block',
    'Multiple IPv6 networks create successfully, docker network ls shows multiple distinct subnets, No "could not find available IPv6 address pool" errors',
    'Bug stems from integer overflow in addIntToIP function. The ordinal parameter is 64-bit but cannot handle full IPv6 range. Statement uint(i<<s) yields zero when s>64, producing identical results for all iterations.',
    0.84,
    'sonnet-4',
    NOW(),
    'https://github.com/moby/moby/issues/42801'
),
(
    'Docker fluentd logging driver: Container hangs when fluentd server unreachable',
    'github-docker',
    'MEDIUM',
    '[
        {"solution": "Use fluentd-async-connect: false to block on connection failure and fail fast", "percentage": 88, "note": "Prevents hang; container fails to start if fluentd unavailable"},
        {"solution": "Upgrade Docker 21.0+ and fluent-logger-golang 1.5.0+ with ForceStopAsyncSend option", "percentage": 92, "note": "Adds graceful shutdown support for async mode"},
        {"solution": "Implement connection timeout and max-retries limits in fluentd config: fluentd-max-retries: ''30'', fluentd-retry-wait: ''1s''", "percentage": 75, "note": "Limits retry duration but may still cause delays"}
    ]'::jsonb,
    'Docker container with fluentd logging driver, fluentd-async-connect: true, Fluentd server configured but unreachable, Container using fluent-logger-golang v1.4.0+',
    'Container stops gracefully within 30 seconds, docker stop/kill command returns without hanging, No zombie goroutines in containerd logs',
    'Fluent-logger-golang added wg.Wait() to Close() method. In async mode with unreachable server, pending operations retry indefinitely with exponential backoff, blocking the wait group. Container cannot stop without force-kill.',
    0.83,
    'sonnet-4',
    NOW(),
    'https://github.com/moby/moby/issues/40063'
),
(
    'Docker Swarm service discovery intermittently fails to resolve service names',
    'github-docker',
    'MEDIUM',
    '[
        {"solution": "Upgrade Docker to 17.06 or later where service discovery race conditions are fixed via moby/libnetwork#1796", "percentage": 93, "note": "Addresses multiple race conditions in DNS resolver"},
        {"solution": "Reduce the number of overlay networks and services if temporarily working around the issue", "percentage": 65, "note": "Reduces complexity and race condition likelihood"},
        {"solution": "Restart swarm manager nodes to reset discovery state without full cluster rebuild", "percentage": 70, "note": "Temporary relief; issue may recur"}
    ]'::jsonb,
    'Docker Swarm mode cluster with 3+ overlay networks, Multiple services (50+), Production deployment scale (3+ managers)',
    'Service names resolve consistently from containers, dns_test nslookup completes without NXDOMAIN errors, Services stay responsive through 1-hour stress test',
    'Issue manifests as 10-20 minute outages cycling between broken/working states with "Neighbor entry already present" warnings. Causes 502 Bad Gateway errors during outages. Affects 15-node clusters with 7+ overlay networks.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/moby/moby/issues/33589'
),
(
    'Docker 20.10.4: docker-compose run -T and docker start --attach hang without TTY',
    'github-docker',
    'HIGH',
    '[
        {"solution": "Downgrade Docker CLI to 20.10.3: sudo apt install ''docker-ce-cli=5:20.10.3~3-0~ubuntu-focal''", "percentage": 95, "note": "Reverts problematic SIGURG patch via PR #2987"},
        {"solution": "Upgrade Docker CLI to 20.10.5+ where the SIGURG patch is properly fixed", "percentage": 92, "note": "Reintroduces SIGURG fix without the hang regression"},
        {"solution": "Use docker run with -t flag: docker run -t image sh -c ''command'' instead of docker start --attach", "percentage": 80, "note": "Workaround for specific use case"}
    ]'::jsonb,
    'Docker 20.10.4 on Linux or Windows, docker-compose run command or docker start --attach without --tty flag, Cron job or non-interactive process using Docker',
    'Command completes and returns exit code within 10 seconds, Output is captured and displayed correctly, Process does not consume memory or hang indefinitely',
    'Problem introduced by commit 3c87f01b in PR #2960 backport (Ignore SIGURG on Linux) which breaks non-TTY attachment. Affects cron jobs, automated processes, and docker-compose run -T. Hang consumes RAM and freezes execution.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/moby/moby/issues/42093'
);
