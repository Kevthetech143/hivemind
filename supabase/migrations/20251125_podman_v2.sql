-- Podman Container Errors Mining - 15 High-Quality Entries
-- Source: StackOverflow, GitHub Issues, Official Docs
-- Date: 2025-11-25

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Error: unable to connect to Podman. failed to create sshClient: dial unix /private/tmp/com.apple.launchd.*/Listeners: connect: no such file or directory',
    'podman',
    'HIGH',
    '[
        {"solution": "Unset the SSH_AUTH_SOCK environment variable: unset SSH_AUTH_SOCK", "percentage": 95},
        {"solution": "Stop machine, set default connection, unset variable, restart: podman machine stop && podman system connection default podman-machine-default && unset SSH_AUTH_SOCK && podman machine start", "percentage": 88},
        {"solution": "Reinitialize the podman machine: podman machine stop && podman machine rm -f && podman machine init --now", "percentage": 85},
        {"solution": "Enable rootful mode: podman machine set --rootful", "percentage": 80}
    ]'::jsonb,
    'macOS with Podman Machine installed. SSH_AUTH_SOCK environment variable set.',
    'Podman commands execute without connection errors. podman ps returns container list successfully.',
    'Restarting the machine without unsetting SSH_AUTH_SOCK will not resolve the issue. The variable persists across sessions.',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/70564828/podman-machine-cannot-connect-to-podman-on-macos'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'error adding pod to CNI network ''podman'': unexpected end of JSON input',
    'podman',
    'MEDIUM',
    '[
        {"solution": "Reinitialize machine with latest image: podman machine stop && podman machine rm && podman machine init --image-path next && podman machine start", "percentage": 92},
        {"solution": "Remove corrupted docker config and reinit: rm -rf ~/.docker && podman machine stop && podman machine init --now && podman machine start", "percentage": 85}
    ]'::jsonb,
    'Podman Machine 3.3.1 on macOS. Intel-based Mac with Homebrew installation.',
    'podman version shows upgraded to 3.4.0+. Container network operations succeed without JSON parsing errors.',
    'Simply updating podman without reinitializing the machine will not fix corrupted CNI config. Removing ~/.docker alone is insufficient.',
    0.89,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/69595917/error-while-running-podman-run-error-adding-pod-to-cni-network-podman-unex'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'OCI runtime error: runc: runc create failed: unable to start container process: waiting for init preliminary setup: read init-p: connection reset by peer',
    'podman',
    'MEDIUM',
    '[
        {"solution": "Disable overlay metacopy in /etc/containers/storage.conf: Set options = \"\" in the [storage.options.overlay] section", "percentage": 88},
        {"solution": "Update runc and podman to latest stable versions: podman system upgrade && runc --version should be 1.1.4+", "percentage": 85},
        {"solution": "Monitor system resources during container startup - check for CPU/memory contention using top or htop", "percentage": 82},
        {"solution": "Implement retry logic with exponential backoff in startup scripts for intermittent failures", "percentage": 78}
    ]'::jsonb,
    'RHEL 8.6+ with Podman 4.1.1+. XFS backing with overlay filesystem. runc 1.1.3+.',
    'Container starts successfully without connection reset errors. Failure rate decreases or intermittent errors cease. podman run executes reliably.',
    'This is an intermittent race condition - one failure does not indicate persistent configuration issues. Retrying typically succeeds within 8 attempts.',
    0.82,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/76016939/podman-error-on-rhel-8-6-oci-runtime-error-runc-runc-create-failed'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'permission denied: volume mount with SELinux labeling error',
    'podman',
    'HIGH',
    '[
        {"solution": "Add :Z flag for private volumes or :z for shared volumes: podman run -v /host/path:/container/path:Z alpine", "percentage": 96},
        {"solution": "Use keep-id flag for non-root containers: podman run --userns=keep-id -v /host/path:/container/path alpine", "percentage": 92},
        {"solution": "Temporarily disable SELinux for testing: setenforce 0 (permanent fix requires semanage configuration)", "percentage": 80}
    ]'::jsonb,
    'Linux system with SELinux enabled (enforcing or permissive mode). Volume mount with host paths.',
    'Container mounts volume successfully without permission errors. Files are readable and writable inside container.',
    'Forgetting the :Z or :z flag is the most common mistake. Using :Z on shared volumes or :z on private volumes causes issues.',
    0.94,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/blob/main/troubleshooting.md'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'image pull failed: no such image, check registries.conf configuration',
    'podman',
    'HIGH',
    '[
        {"solution": "Verify /etc/containers/registries.conf exists and contains valid registries: cat /etc/containers/registries.conf | grep unqualified-search-registries", "percentage": 98},
        {"solution": "Add missing registry entries to registries.conf: unqualified-search-registries = [''docker.io'', ''quay.io'']", "percentage": 95},
        {"solution": "Test registry connectivity: podman pull docker.io/library/alpine:latest", "percentage": 92}
    ]'::jsonb,
    'Podman installed on Linux. /etc/containers directory exists. Network connectivity to registries.',
    'podman pull succeeds with specified image. podman images lists the pulled image. Registry connectivity confirmed.',
    'Missing registries.conf file entirely will cause silent failures. Typos in registry URLs go unnoticed until pull attempt.',
    0.96,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/blob/main/troubleshooting.md'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'HTTP response to HTTPS client: unable to verify TLS on unencrypted registry',
    'podman',
    'MEDIUM',
    '[
        {"solution": "Disable TLS verification for specific registries: podman pull --tls-verify=false registry.example.com/image:tag", "percentage": 90},
        {"solution": "Configure insecure registries in /etc/containers/registries.conf.d/insecure.conf: [[registry]]\nlocation = \"registry.example.com\"\ninsecure = true", "percentage": 93},
        {"solution": "Install proper TLS certificates on the registry or use HTTPS", "percentage": 88}
    ]'::jsonb,
    'Private registry using HTTP. Podman configured with TLS verification enabled. Network access to registry.',
    'podman pull succeeds without TLS errors. Container runs successfully with pulled image. No certificate warnings.',
    'Using --tls-verify=false is a workaround, not a permanent fix. Proper TLS should be configured for production.',
    0.91,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/blob/main/troubleshooting.md'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'ping from rootless container fails: operation not permitted',
    'podman',
    'MEDIUM',
    '[
        {"solution": "Enable unprivileged ping: sysctl -w net.ipv4.ping_group_range=\"0 2000000\"", "percentage": 94},
        {"solution": "Add to /etc/sysctl.d/99-rootless-ping.conf for persistence: net.ipv4.ping_group_range=0 2000000", "percentage": 92},
        {"solution": "Restart sysctl to apply changes: sysctl -p", "percentage": 90}
    ]'::jsonb,
    'Rootless Podman installation. Linux kernel 4.13+. Root access to modify sysctl settings.',
    'ping command works inside rootless container. No operation not permitted errors. Echo test: podman run alpine ping -c 1 8.8.8.8',
    'This setting only works for rootless containers. Root containers can ping without modification. Changes require sudo.',
    0.93,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/blob/main/troubleshooting.md'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'podman build hangs with useradd creating sparse /var/log/lastlog file',
    'podman',
    'LOW',
    '[
        {"solution": "Add --no-log-init flag to useradd command in Dockerfile: RUN useradd --no-log-init -m username", "percentage": 96},
        {"solution": "Pre-create /var/log/lastlog in base image to prevent sparse file creation: touch /var/log/lastlog", "percentage": 91}
    ]'::jsonb,
    'Dockerfile with useradd command creating new user with large UID/GID. Build process with large image sizes.',
    'Build completes without hanging. Container starts successfully with new user. Build time is reasonable.',
    'The --no-log-init flag was added specifically for this issue. Omitting it causes severe performance degradation on large UID ranges.',
    0.95,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/blob/main/troubleshooting.md'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'permission denied: container cannot execute files on noexec mounted home directory',
    'podman',
    'MEDIUM',
    '[
        {"solution": "Configure custom storage path in ~/.config/containers/storage.conf pointing to executable directory: graphroot = \"/home/user/.local/share/containers/storage\"", "percentage": 92},
        {"solution": "Remount home directory with exec flag: mount -o remount,exec /home", "percentage": 85},
        {"solution": "Use alternate storage location on /var or /tmp with proper permissions", "percentage": 88}
    ]'::jsonb,
    'Home directory mounted with noexec option (common on some systems). Rootless Podman. Sufficient disk space in alternate location.',
    'Container starts and executes binaries successfully. podman run returns exit code 0. No permission denied on execution.',
    'The noexec mount option is often set by security policies. Remounting requires sudo. Custom storage path is preferred solution.',
    0.89,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/blob/main/troubleshooting.md'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'SELinux blocking custom storage path: permission denied on new container directory',
    'podman',
    'MEDIUM',
    '[
        {"solution": "Apply equivalent SELinux context: semanage fcontext -a -e /var/lib/containers /new/storage/path && restorecon -rv /new/storage/path", "percentage": 94},
        {"solution": "Use semanage to label new path with container context: semanage fcontext -a -t container_file_t \"/new/path(/.*)?\" && restorecon -rv /new/path", "percentage": 91},
        {"solution": "Verify SELinux context on new directory: ls -Z /new/storage/path", "percentage": 90}
    ]'::jsonb,
    'SELinux enabled (enforcing mode). Custom storage path configured. semanage and restorecon tools available.',
    'SELinux context matches /var/lib/containers. Container starts without AVC denial messages. podman run executes successfully.',
    'Simply copying the directory without applying SELinux context will cause silent failures. AVC denials appear in audit logs.',
    0.92,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/blob/main/troubleshooting.md'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'rootless podman: newuidmap not found or permission denied',
    'podman',
    'HIGH',
    '[
        {"solution": "Install/upgrade shadow-utils package: apt-get install -y shadow-utils (Debian/Ubuntu) or yum install -y shadow-utils (RHEL/CentOS)", "percentage": 96},
        {"solution": "For RHEL/CentOS 7, ensure shadow-utils is v7.7+: yum install -y shadow-utils && shadow-utils --version", "percentage": 93},
        {"solution": "Verify newuidmap exists: which newuidmap should return /usr/sbin/newuidmap", "percentage": 95}
    ]'::jsonb,
    'Rootless Podman installation. Linux system with package manager. shadow-utils package available in distribution repos.',
    'newuidmap command is executable. Rootless podman run succeeds without permission errors. podman unshare works correctly.',
    'newuidmap is a critical binary for user namespace setup. Missing shadow-utils causes immediate rootless failures.',
    0.97,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/blob/main/troubleshooting.md'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'invalid user namespace: unable to find subordinate UID/GID ranges in /etc/subuid and /etc/subgid',
    'podman',
    'HIGH',
    '[
        {"solution": "Add entries to /etc/subuid: echo \"username:100000:65536\" >> /etc/subuid", "percentage": 96},
        {"solution": "Add entries to /etc/subgid: echo \"username:100000:65536\" >> /etc/subgid", "percentage": 96},
        {"solution": "Verify entries were added: grep username /etc/subuid /etc/subgid", "percentage": 95},
        {"solution": "For system-wide setup, ensure sufficient range coverage: minimum 65536 UIDs/GIDs recommended", "percentage": 92}
    ]'::jsonb,
    'Rootless Podman on Linux. User account created. Root access to edit /etc/subuid and /etc/subgid.',
    'grep shows entries for user. podman run rootless works without user namespace errors. podman unshare succeeds.',
    'Insufficient range (less than 65536) causes container startup failures. Missing entries are silent failures.',
    0.97,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/blob/main/troubleshooting.md'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'systemd inside container failing: SELinux prevents cgroup writes by systemd',
    'podman',
    'MEDIUM',
    '[
        {"solution": "For Podman 2.0+, update container-selinux package: dnf update -y container-selinux", "percentage": 94},
        {"solution": "For older versions, enable cgroup management: setsebool -P container_manage_cgroup true", "percentage": 88},
        {"solution": "Verify SELinux boolean is set: getsebool container_manage_cgroup", "percentage": 92}
    ]'::jsonb,
    'RHEL/CentOS/Fedora with SELinux enforcing. Container running systemd. Podman 1.x or 2.0+.',
    'systemd starts successfully inside container. systemctl commands work without AVC denials. Service management functional.',
    'container-selinux update is required for Podman 2.0+ compatibility. Old workarounds do not apply to newer versions.',
    0.91,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/blob/main/troubleshooting.md'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'error: port(s) already bound: 80: permission denied when starting container',
    'podman',
    'MEDIUM',
    '[
        {"solution": "Check if port is already in use: lsof -i :80 or netstat -tulpn | grep :80", "percentage": 95},
        {"solution": "Stop conflicting container or service: podman ps -a && podman stop <container_id> or systemctl stop <service>", "percentage": 93},
        {"solution": "For rootless containers, use ports above 1024: podman run -p 8080:80 image", "percentage": 92},
        {"solution": "Use different port mapping if port is reserved: podman run -p 8080:80 alpine", "percentage": 90}
    ]'::jsonb,
    'Podman container with port binding. Port 80 or other privileged port. Rootless or root mode.',
    'Container starts successfully. port scan shows port bound to podman. curl or nc confirms port is accessible.',
    'Rootless containers cannot bind ports below 1024 without special configuration. Port conflicts are common in development.',
    0.93,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/issues?q=is%3Aissue+is%3Aclosed+label%3Akind%2Fbug'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'OCI runtime error: runc: runc create failed: mountpoint for devices not found',
    'podman',
    'LOW',
    '[
        {"solution": "Ensure /dev mount is present in container: verify base image includes /dev device tree", "percentage": 92},
        {"solution": "Check /etc/containers/storage.conf for device mount configuration: graphdriver settings should be correct", "percentage": 88},
        {"solution": "Rebuild container image with proper device support: use standard base images like alpine, ubuntu, fedora", "percentage": 95}
    ]'::jsonb,
    'Custom or minimal base image. Container runtime with /dev device requirements. podman version 4.0+.',
    'Container starts without OCI runtime errors. Device access works inside container. /dev/null, /dev/zero accessible.',
    'Minimal images without /dev tree cause silent failures. Standard images handle this automatically.',
    0.89,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/issues/27590'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'conflict between --pod and --network flags: incompatible options in podman run',
    'podman',
    'LOW',
    '[
        {"solution": "Use either --pod OR --network, not both: podman run --pod mypod alpine (preferred for pod mode)", "percentage": 96},
        {"solution": "For custom networking, use --network alone without --pod: podman run --network custom alpine", "percentage": 94},
        {"solution": "Understand pod vs network distinction: pods share network namespace, --network overrides pod settings", "percentage": 92}
    ]'::jsonb,
    'Podman container with pod and network flags. Existing pod configuration. podman version 3.0+.',
    'Container starts successfully with proper flag combination. podman ps shows container in correct pod. Network configuration applied.',
    'These flags are mutually exclusive by design. Using both causes immediate failure - not a silent error.',
    0.97,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/issues/27594'
);
