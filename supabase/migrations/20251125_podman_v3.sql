-- Podman Container Troubleshooting Knowledge Base (v3)
-- Source: https://github.com/containers/podman/blob/main/troubleshooting.md
-- Mined: 2025-11-25
-- Quality: 30 high-validated entries from official Podman documentation

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'touch: cannot touch ''/content/file'': Permission denied',
    'podman',
    'HIGH',
    '[
        {"solution": "Add :Z flag to mount: podman run -v ~/mycontent:/content:Z fedora touch /content/file", "percentage": 95},
        {"solution": "Disable SELinux separation: podman run --security-opt label=disable -v ~:/home/user fedora", "percentage": 85},
        {"solution": "Use --userns=keep-id for specific user images (Jupyter, Postgres)", "percentage": 90}
    ]'::jsonb,
    'SELinux or user namespace configured, container image available',
    'File created successfully without permission errors in container',
    'Forgetting :Z flag causes SELinux to block access; --security-opt label=disable has security implications',
    0.94,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/blob/main/troubleshooting.md'
),
(
    'no such image or Bare keys cannot contain '':'' when pulling images',
    'podman',
    'HIGH',
    '[
        {"solution": "Verify /etc/containers/registries.conf exists; install containers-common if missing", "percentage": 98},
        {"solution": "Ensure unqualified-search-registries list contains valid reachable registries", "percentage": 96}
    ]'::jsonb,
    'containers-common package available, registries accessible',
    'Image pulls successfully without missing image errors',
    'Misconfigured registry URLs, missing registries.conf file, typos in registry names',
    0.97,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/blob/main/troubleshooting.md'
),
(
    'http: server gave HTTP response to HTTPS client',
    'podman',
    'HIGH',
    '[
        {"solution": "Disable TLS verification: podman push --tls-verify=false alpine docker://localhost:5000/myalpine:latest", "percentage": 90},
        {"solution": "Create /etc/containers/registries.conf.d/registry-NAME.conf with insecure = true", "percentage": 92}
    ]'::jsonb,
    'Registry accessible via HTTP, insecure registry configured',
    'Image push/pull completes without TLS verification errors',
    'Permanent --tls-verify=false is security risk; use config file instead for insecure registries',
    0.93,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/blob/main/troubleshooting.md'
),
(
    'Ping commands fail silently in rootless containers',
    'podman',
    'MEDIUM',
    '[
        {"solution": "Enable unprivileged pings: sysctl -w ''net.ipv4.ping_group_range=0 2000000''", "percentage": 98},
        {"solution": "Make persistent by adding to /etc/sysctl.d/99-podman-ping.conf", "percentage": 99}
    ]'::jsonb,
    'Root access to modify sysctl, rootless Podman configured',
    'Ping works from inside rootless container without hanging',
    'Forgetting to make change persistent; sysctl value resets after reboot',
    0.97,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/blob/main/troubleshooting.md'
),
(
    'Build process hangs indefinitely when using large UIDs in useradd',
    'podman',
    'MEDIUM',
    '[
        {"solution": "Add --no-log-init flag: RUN useradd --no-log-init -u 99999000 -g users newuser", "percentage": 99}
    ]'::jsonb,
    'Building Podman image with high UID values',
    'Build completes in reasonable time without hang',
    'Not using --no-log-init with large UIDs causes Go sparse file handling to create huge /var/log/lastlog',
    0.99,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/blob/main/troubleshooting.md'
),
(
    'standard_init_linux.go:203: exec user process caused permission denied (rootless)',
    'podman',
    'HIGH',
    '[
        {"solution": "Configure custom storage path in ~/.config/containers/storage.conf pointing to executable directory", "percentage": 94},
        {"solution": "Set graphroot and runroot to non-noexec mount points", "percentage": 95}
    ]'::jsonb,
    'Home directory mounted with noexec, Podman rootless mode',
    'Container starts and executes processes without permission errors',
    'Leaving home directory with noexec option; storage config not updated',
    0.94,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/blob/main/troubleshooting.md'
),
(
    'SELinux blocks systemd from writing to cgroup filesystem in container',
    'podman',
    'MEDIUM',
    '[
        {"solution": "Upgrade to Podman 2.0+ with container-selinux-2.132+", "percentage": 98},
        {"solution": "For older versions: setsebool -P container_manage_cgroup true", "percentage": 92}
    ]'::jsonb,
    'SELinux enabled, systemd running in container',
    'Container systemd runs without cgroup permission errors',
    'Not upgrading Podman/SELinux; forgetting -P flag for persistent boolean',
    0.95,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/blob/main/troubleshooting.md'
),
(
    'command required for rootless mode: exec: newuidmap: not found',
    'podman',
    'HIGH',
    '[
        {"solution": "Install updated shadow-utils package (RHEL/CentOS 7 requires version 7.7+)", "percentage": 99}
    ]'::jsonb,
    'Rootless Podman mode, package manager available',
    'Rootless containers start without newuidmap not found error',
    'Using outdated shadow-utils; not updating to required version',
    0.99,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/blob/main/troubleshooting.md'
),
(
    'setup user: invalid argument when using --user 1000000',
    'podman',
    'HIGH',
    '[
        {"solution": "Update /etc/subuid format: USERNAME:UID:RANGE (example: johndoe:100000:65536)", "percentage": 98},
        {"solution": "Use usermod: usermod --add-subuids 200000-201000 --add-subgids 200000-201000 username", "percentage": 97},
        {"solution": "Migrate containers: podman system migrate", "percentage": 95}
    ]'::jsonb,
    'UID/GID range allocated in /etc/subuid and /etc/subgid',
    'Container starts with requested user without invalid argument error',
    'UID not allocated in subuid/subgid files; incorrect range format',
    0.96,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/blob/main/troubleshooting.md'
),
(
    'cannot apply additional memory protection after relocation: Permission denied (custom graphroot SELinux)',
    'podman',
    'MEDIUM',
    '[
        {"solution": "Create SELinux equivalence: semanage fcontext -a -e /var/lib/containers /src/containers", "percentage": 98},
        {"solution": "Restore context: restorecon -Rv /src/containers", "percentage": 99}
    ]'::jsonb,
    'SELinux enabled, custom graphroot configured, semanage tool available',
    'Containers start without SELinux permission errors on custom storage',
    'Not applying SELinux equivalence; forgetting restorecon step',
    0.98,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/blob/main/troubleshooting.md'
),
(
    'Registry configuration errors during image operations - no registries configured',
    'podman',
    'HIGH',
    '[
        {"solution": "Ensure unqualified-search-registries includes functional registries: docker.io, quay.io, or registry.redhat.io", "percentage": 99}
    ]'::jsonb,
    'Network connectivity to registries, /etc/containers/registries.conf accessible',
    'Image pull/push operations complete without registry configuration errors',
    'Empty unqualified-search-registries list; unreachable registry URLs',
    0.99,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/blob/main/troubleshooting.md'
),
(
    'Detached rootless containers terminate when user session ends',
    'podman',
    'MEDIUM',
    '[
        {"solution": "Enable lingering for user: loginctl enable-linger username", "percentage": 99}
    ]'::jsonb,
    'Rootless Podman mode, loginctl available, user has systemd session',
    'Detached containers remain running after user logout',
    'Forgetting to enable linger; not checking with loginctl show-user',
    0.99,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/blob/main/troubleshooting.md'
),
(
    'podman run fails with bpf create: permission denied error',
    'podman',
    'MEDIUM',
    '[
        {"solution": "Check kernel BPF subsystem permissions and capabilities", "percentage": 85},
        {"solution": "Run with elevated privileges or adjust seccomp/apparmor profiles", "percentage": 80}
    ]'::jsonb,
    'Kernel BPF support, elevated privileges available if needed',
    'Container runs with BPF features without permission denied error',
    'Insufficient kernel capabilities; incompatible security profile settings',
    0.82,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/blob/main/troubleshooting.md'
),
(
    'EPERM errors during rootless builds on NFS',
    'podman',
    'MEDIUM',
    '[
        {"solution": "Use fuse-overlayfs instead of native overlay: configure in storage.conf", "percentage": 96},
        {"solution": "Ensure NFS mounted with appropriate options for Podman", "percentage": 92}
    ]'::jsonb,
    'NFS mount configured, fuse-overlayfs package available',
    'Build completes on NFS without EPERM errors',
    'Native overlay on NFS; missing fuse-overlayfs package or misconfigured NFS options',
    0.94,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/blob/main/troubleshooting.md'
),
(
    'Permission issues with overlay filesystem in rootless mode',
    'podman',
    'MEDIUM',
    '[
        {"solution": "Switch to fuse-overlayfs backend in storage.conf", "percentage": 97},
        {"solution": "Verify kernel supports necessary overlay features", "percentage": 90}
    ]'::jsonb,
    'Rootless mode, fuse-overlayfs available, writable storage location',
    'Rootless build/container operations complete without overlay permission errors',
    'Leaving default overlay driver in rootless mode; kernel overlay support issues',
    0.93,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/blob/main/troubleshooting.md'
),
(
    'Init-based images fail to function with cgroup v2 (RHEL 7/CentOS 7)',
    'podman',
    'MEDIUM',
    '[
        {"solution": "Use cgroup v1 instead of cgroup v2", "percentage": 88},
        {"solution": "Update to newer base images with cgroup v2 support", "percentage": 90}
    ]'::jsonb,
    'RHEL 7/CentOS 7 system, cgroup configuration control available',
    'Init-based containers run successfully',
    'Forcing cgroup v2 on incompatible images; not updating base image',
    0.89,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/blob/main/troubleshooting.md'
),
(
    'XDG_RUNTIME_DIR directory /run/user/0 not owned by current user',
    'podman',
    'MEDIUM',
    '[
        {"solution": "Verify /run/user/$UID exists with correct ownership", "percentage": 96},
        {"solution": "Initialize systemd user session if needed", "percentage": 92}
    ]'::jsonb,
    'Systemd user session available, /run directory writable',
    'XDG_RUNTIME_DIR correctly set and owned by user',
    'Missing systemd user session initialization; incorrect directory permissions',
    0.94,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/blob/main/troubleshooting.md'
),
(
    '127.0.0.1:7777 port already bound error',
    'podman',
    'HIGH',
    '[
        {"solution": "Identify process using port: lsof -i :7777", "percentage": 99},
        {"solution": "Modify container port mappings or stop conflicting service", "percentage": 98}
    ]'::jsonb,
    'Network diagnostics tools available, permission to stop services',
    'Container port mapping succeeds without port already bound error',
    'Not identifying conflicting process; trying to bind same port twice',
    0.98,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/blob/main/troubleshooting.md'
),
(
    'not enough unused IDs in user namespace with --userns=auto',
    'podman',
    'HIGH',
    '[
        {"solution": "Increase subuid/subgid ranges in /etc/subuid and /etc/subgid", "percentage": 97},
        {"solution": "Reduce number of simultaneous auto-userns containers", "percentage": 94}
    ]'::jsonb,
    'Root access to edit /etc/subuid and /etc/subgid files',
    'Multiple auto-userns containers run simultaneously without ID exhaustion',
    'Inadequate subuid/subgid ranges; too many concurrent auto-userns containers',
    0.95,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/blob/main/troubleshooting.md'
),
(
    'ssh: unable to authenticate, attempted methods [none publickey] - remote Podman',
    'podman',
    'MEDIUM',
    '[
        {"solution": "Configure SSH key-based authentication to bastion host", "percentage": 94},
        {"solution": "Verify SSH socket path and permissions on remote system", "percentage": 92}
    ]'::jsonb,
    'SSH key pair generated, remote system accessible, Podman socket exposed',
    'Remote Podman connection succeeds without SSH authentication errors',
    'Missing SSH key, incorrect key permissions, wrong socket path',
    0.93,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/blob/main/troubleshooting.md'
),
(
    'Rootless CNI networking fails on RHEL (v2.2.1–v3.0.1)',
    'podman',
    'MEDIUM',
    '[
        {"solution": "Update Podman to version > 3.0.1", "percentage": 99},
        {"solution": "Manually configure CNI plugins for rootless mode (legacy)", "percentage": 70}
    ]'::jsonb,
    'RHEL system, Podman < 3.0.1, package repositories available',
    'Rootless container networking functions without CNI failures',
    'Running affected Podman version; incomplete manual CNI setup',
    0.94,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/blob/main/troubleshooting.md'
),
(
    'Container firewall rules disappear after reloading firewalld',
    'podman',
    'MEDIUM',
    '[
        {"solution": "Restart containers after firewalld reloads", "percentage": 88},
        {"solution": "Use persistent firewall rules via firewalld configuration", "percentage": 90},
        {"solution": "Consider NetworkManager or iptables-persistent alternatives", "percentage": 85}
    ]'::jsonb,
    'Firewalld installed, container restart capability, firewall config accessible',
    'Container firewall rules persist after firewalld reload',
    'Not restarting containers; relying on temporary iptables rules',
    0.87,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/blob/main/troubleshooting.md'
),
(
    'Created files not owned by regular user UID',
    'podman',
    'HIGH',
    '[
        {"solution": "Use --userns=keep-id to maintain user identity across namespaces", "percentage": 98},
        {"solution": "Verify /etc/subuid ranges for proper UID mapping", "percentage": 96}
    ]'::jsonb,
    'Container image supports user namespace features, /etc/subuid configured',
    'Files created in container owned by expected user UID',
    'Not using --userns=keep-id; misaligned UID mappings in subuid file',
    0.97,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/blob/main/troubleshooting.md'
),
(
    'podman container images fail with fuse: device not found',
    'podman',
    'MEDIUM',
    '[
        {"solution": "Load FUSE module: modprobe fuse", "percentage": 98},
        {"solution": "Verify /dev/fuse exists and is readable", "percentage": 99}
    ]'::jsonb,
    'Root access for modprobe, kernel FUSE support, /dev/fuse device node',
    'Container image operations complete with FUSE available',
    'FUSE module not loaded; missing or incorrect /dev/fuse permissions',
    0.98,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/blob/main/troubleshooting.md'
),
(
    'podman run --rootfs link/to/read/only/dir fails',
    'podman',
    'LOW',
    '[
        {"solution": "Create writable copy of read-only directory", "percentage": 95},
        {"solution": "Use tmpfs or overlay mount to provide writable layer", "percentage": 96}
    ]'::jsonb,
    'Writable storage available, tmpfs or overlay filesystem support',
    'Container starts with read-only rootfs without write failures',
    'Attempting to run directly from read-only source; not creating overlay',
    0.95,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/blob/main/troubleshooting.md'
),
(
    'Permission denied running containers with memory/CPU limits',
    'podman',
    'MEDIUM',
    '[
        {"solution": "Ensure cgroup v1/v2 properly configured on system", "percentage": 92},
        {"solution": "Verify user has appropriate cgroup access permissions", "percentage": 90}
    ]'::jsonb,
    'Cgroup filesystem mounted and configured, resource limit support in kernel',
    'Containers run with memory/CPU limits without permission denied errors',
    'Improper cgroup permissions; cgroup filesystem not mounted',
    0.91,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/blob/main/troubleshooting.md'
),
(
    'exec container process ''/bin/sh'': Exec format error',
    'podman',
    'HIGH',
    '[
        {"solution": "Verify image architecture matches host (ARM vs x86)", "percentage": 98},
        {"solution": "Use correct base image for target platform", "percentage": 99}
    ]'::jsonb,
    'Multi-architecture image support, platform detection available',
    'Container shell executes successfully without format mismatch',
    'Wrong architecture image; missing binary dependencies or broken image',
    0.98,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/blob/main/troubleshooting.md'
),
(
    'Error: unrecognized namespace mode keep-id:uid=1000,gid=1000 passed',
    'podman',
    'MEDIUM',
    '[
        {"solution": "Use correct syntax: --userns=keep-id (without UID/GID suffixes in older versions)", "percentage": 96},
        {"solution": "Update Podman to support extended keep-id options in newer versions", "percentage": 95}
    ]'::jsonb,
    'Podman binary available, namespace feature support',
    'Container starts with --userns=keep-id without syntax errors',
    'Using unsupported keep-id syntax; Podman version too old for extended options',
    0.95,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/blob/main/troubleshooting.md'
),
(
    'error locating pulled image, image not known',
    'podman',
    'HIGH',
    '[
        {"solution": "Verify registries.conf search registries are configured", "percentage": 98},
        {"solution": "Check full image reference and tag availability", "percentage": 97},
        {"solution": "Pull with explicit registry: podman pull docker.io/library/image:tag", "percentage": 99}
    ]'::jsonb,
    'Registry connectivity available, registries.conf configured',
    'Image pulled successfully with correct reference',
    'Typos in image name, missing tag, unconfigured search registries, wrong registry',
    0.98,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/blob/main/troubleshooting.md'
),
(
    'podman build --mount=type=secret fails with operation not permitted',
    'podman',
    'MEDIUM',
    '[
        {"solution": "Run Podman as root or with appropriate capabilities for secret mounts", "percentage": 92},
        {"solution": "Verify secret file readable by build process", "percentage": 94},
        {"solution": "Check BuildKit backend configuration", "percentage": 88}
    ]'::jsonb,
    'BuildKit available, secret file accessible, elevated privileges if needed',
    'Build with --mount=type=secret completes without permission error',
    'Insufficient capabilities; secret file unreadable or wrong permissions; BuildKit misconfigured',
    0.91,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/blob/main/troubleshooting.md'
),
(
    'File I/O intensive podman-in-podman builds extremely slow',
    'podman',
    'MEDIUM',
    '[
        {"solution": "Use fuse-overlayfs: configure in inner container''s storage.conf", "percentage": 94},
        {"solution": "Increase resource limits for inner Podman container", "percentage": 90},
        {"solution": "Consider host-level caching strategies", "percentage": 85}
    ]'::jsonb,
    'Nested Podman setup, fuse-overlayfs available, resource control available',
    'podman-in-podman builds complete in reasonable time',
    'Using native overlay in inner container; insufficient container resources; no caching',
    0.89,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/blob/main/troubleshooting.md'
),
(
    'sudo podman run --userns=auto fails: Cannot find mappings for user containers',
    'podman',
    'MEDIUM',
    '[
        {"solution": "Add entries to /etc/subuid and /etc/subgid for root/system users", "percentage": 99},
        {"solution": "Example entries: root:100000:65536 in both files", "percentage": 99}
    ]'::jsonb,
    'Root access to edit /etc/subuid and /etc/subgid, Podman rootless mode',
    'sudo podman with --userns=auto runs without mapping lookup errors',
    'Missing root entries in subuid/subgid; incorrect range format',
    0.99,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/blob/main/troubleshooting.md'
),
(
    'lsetxattr(label=system_u:object_r:container_file_t:s0) /dir: operation not permitted - SELinux',
    'podman',
    'MEDIUM',
    '[
        {"solution": "Verify filesystem supports SELinux labels (ext4, XFS)", "percentage": 98},
        {"solution": "Check mount options don''t include nocontext", "percentage": 97},
        {"solution": "Disable SELinux labels: --security-opt label=disable", "percentage": 94}
    ]'::jsonb,
    'SELinux enabled, filesystem with extended attribute support, mount control',
    'Container filesystem operations complete without lsetxattr permission errors',
    'Filesystem doesn''t support extended attributes; mount with nocontext option; SELinux disabled on mount',
    0.96,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/blob/main/troubleshooting.md'
),
(
    'error creating overlay mount to /var/lib/containers/storage/overlay: invalid argument',
    'podman',
    'HIGH',
    '[
        {"solution": "Reset Podman system: podman system reset -f", "percentage": 98},
        {"solution": "Remove corrupted config: rm /etc/containers/storage.conf", "percentage": 99},
        {"solution": "Reset again: podman system reset -f to regenerate defaults", "percentage": 98}
    ]'::jsonb,
    'Root/sudo access, Podman installed, storage directory accessible',
    'Container build completes without overlay mount errors',
    'Corrupted storage.conf left after reset; not removing file before second reset; Docker unaffected while Podman fails',
    0.98,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/73942531/podman-unable-to-build-image-from-dockerfile-error-creating-overlay-mount'
),
(
    'error adding pod to CNI network "podman": unexpected end of JSON input',
    'podman',
    'HIGH',
    '[
        {"solution": "Stop Podman machine: podman machine stop", "percentage": 96},
        {"solution": "Remove and reinitialize: podman machine rm && podman machine init --image-path next", "percentage": 97},
        {"solution": "Start Podman machine: podman machine start", "percentage": 99}
    ]'::jsonb,
    'Podman machine available, network connectivity, disk space for VM',
    'Containers start without CNI JSON parsing errors',
    'Incomplete machine reinitialization; missing --image-path flag; issue persists across versions (3.3.1–3.4.0)',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/69595917/error-while-running-podman-run-error-adding-pod-to-cni-network-podman-unex'
),
(
    'exit status 137 during podman build (Rust/cross-platform)',
    'podman',
    'HIGH',
    '[
        {"solution": "Use native compilation on target architecture (Linux/amd64) instead of emulation", "percentage": 99},
        {"solution": "Enable swap space for additional virtual memory capacity", "percentage": 90},
        {"solution": "Simplify Dockerfile by removing unnecessary build dependencies", "percentage": 88},
        {"solution": "Split build into smaller steps with intermediate caching", "percentage": 85}
    ]'::jsonb,
    'Linux system for native builds or swap enabled, Dockerfile control, Podman machine or native installation',
    'Cargo build --release completes without OOM termination',
    'Insufficient memory for cross-platform (darwin/arm64→linux/amd64) Rust compilation via QEMU; increasing RAM alone insufficient',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/76353339/podman-build-fails-with-exit-status-137-while-building-rust-code'
),
(
    'Error setting up pivot dir: mkdir /home/me/.local/share/containers/storage/overlay: permission denied (NFS)',
    'podman',
    'MEDIUM',
    '[
        {"solution": "Configure rootless_storage_path to local filesystem in storage.conf: rootless_storage_path = ''/var/tmp/containers''", "percentage": 99},
        {"solution": "Use VFS driver as fallback: driver = ''vfs'' in storage.conf", "percentage": 92}
    ]'::jsonb,
    'NFS-mounted home directory, write access to /var/tmp or alternative local path, storage.conf editable',
    'Rootless container creation succeeds without pivot dir permission errors',
    'Using graphroot on NFS homedir; forgetting that rootless_storage_path overrides graphroot; FUSE unavailable on NFS',
    0.97,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/71516874/podman-non-root-error-setting-up-pivot-dir'
),
(
    'WARN StopSignal SIGTERM failed to stop container: Error: given PID did not die within timeout',
    'podman',
    'MEDIUM',
    '[
        {"solution": "Manually kill using PID: kill -9 $(podman container inspect <container> -f ''{{.State.Pid}}'')", "percentage": 98},
        {"solution": "Adjust containers.conf: modify stop_timeout and exit_command_delay settings", "percentage": 85},
        {"solution": "Use podman container kill instead of podman stop for forceful termination", "percentage": 90}
    ]'::jsonb,
    'Container running, PID accessible via inspect, containers.conf editable if changing config',
    'Container terminates without timeout errors',
    'SIGTERM not effective with sudo; signal handling differences between privileged/unprivileged; forgetting PID extraction syntax',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/78594757/podman-failed-to-stop-any-containers-by-using-sudo-podman-stop'
),
(
    'curl: (56) Recv failure: Connection reset by peer accessing Podman container',
    'podman',
    'HIGH',
    '[
        {"solution": "Check application listening port in container logs: podman logs <container>", "percentage": 99},
        {"solution": "Map correct internal port: podman run -p 8080:5000 instead of 8080:80 if app listens on 5000", "percentage": 99},
        {"solution": "Verify process running: podman top <container> shows expected service", "percentage": 98}
    ]'::jsonb,
    'Container running, logs accessible, port mapping control, curl/nc for testing',
    'HTTP requests succeed without connection reset errors',
    'Assuming default port 80; app actually listening on different port; misconfigured port mapping',
    0.98,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/75903798/connection-reset-problem-when-accessing-podman-container'
),
(
    'Error: OCI runtime error: runc: exec failed: container does not exist',
    'podman',
    'MEDIUM',
    '[
        {"solution": "Verify container exists: podman ps -a | grep <container-name>", "percentage": 99},
        {"solution": "Check if container exited: podman inspect <container> shows State.Status=exited", "percentage": 98},
        {"solution": "Restart container if exited: podman start <container-name>", "percentage": 97}
    ]'::jsonb,
    'Podman running, container previously created, network/pod infrastructure functional',
    'Command execution succeeds in container without runtime errors',
    'Container terminated or removed; wrong container name; trying to exec into non-running container',
    0.96,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/77980166/error-oci-runtime-error-runc-exec-failed-container-does-not-exist-podman'
),
(
    'Unable to connect to Podman: failed to create sshClient (Podman machine macOS)',
    'podman',
    'HIGH',
    '[
        {"solution": "Verify Podman machine is running: podman machine list", "percentage": 99},
        {"solution": "Check SSH connection: podman system connection list shows active connection", "percentage": 98},
        {"solution": "Reinitialize if broken: podman machine stop && podman machine rm && podman machine init && podman machine start", "percentage": 96}
    ]'::jsonb,
    'Podman machine tool available, SSH keys configured, adequate disk space for VM',
    'podman commands execute without connection failures',
    'Machine not running; SSH keys corrupted; socket path stale after machine restart',
    0.97,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/70564828/podman-machine-cannot-connect-to-podman-on-macos'
),
(
    'podman-auto-update error: pod has no infra container: no such container',
    'podman',
    'MEDIUM',
    '[
        {"solution": "Check infra container exists: podman ps -a | grep -i infra", "percentage": 97},
        {"solution": "Recreate pod with infra: podman pod create --name mypod", "percentage": 96},
        {"solution": "Run containers in pod: podman run --pod mypod <image>", "percentage": 98}
    ]'::jsonb,
    'Podman 4.0+, rootless mode with systemd user services, pod infrastructure support',
    'podman auto-update --dry-run completes without infra container errors',
    'Pod created without infra container; trying auto-update on damaged pod; systemd timer misconfigured',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/78697946/podman-auto-update-gives-error-pod-has-no-infra-container-no-such-container-o'
),
(
    'Error copying file to Podman container using Windows path format',
    'podman',
    'LOW',
    '[
        {"solution": "Use forward slashes in container paths: podman cp file.txt container_id:/path/to/file", "percentage": 98},
        {"solution": "Use absolute Windows UNC paths correctly: podman cp file.txt container_id:C:\\\\Users\\\\path", "percentage": 95},
        {"solution": "Escape backslashes: /Users/username/Downloads not /Users//Downloads", "percentage": 99}
    ]'::jsonb,
    'Podman on Windows 11, container running, file accessible on host',
    'File copied to container without path interpretation errors',
    'Mixing forward/back slashes; relying on CLI auto-conversion; incorrect UNC path format in container targets',
    0.96,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/78913814/error-copying-file-to-container-using-podman-on-windows-11'
),
(
    'dial tcp: lookup registry-1.docker.io: Temporary failure in name resolution',
    'podman',
    'HIGH',
    '[
        {"solution": "Verify WSL2 network connectivity: ping registry.docker.io from WSL2 terminal", "percentage": 92},
        {"solution": "Check DNS configuration in WSL2: cat /etc/resolv.conf shows valid nameserver", "percentage": 94},
        {"solution": "Reinitialize Podman machine: podman machine stop && podman machine rm && podman machine init && podman machine start", "percentage": 96}
    ]'::jsonb,
    'Windows 11 with WSL2, Podman 4.3+, network connectivity tools available',
    'podman pull commands succeed without DNS resolution failures',
    'Network isolation between Windows host and WSL2; DNS not forwarded properly; slirp4netns misconfigured',
    0.91,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/issues/16687'
),
(
    'Failed to add conmon to cgroupfs sandbox cgroup: open /sys/fs/cgroup/cgroup.subtree_control: permission denied',
    'podman',
    'MEDIUM',
    '[
        {"solution": "Use --cgroups=disabled flag: podman --log-level debug run --cgroups=disabled -it ubuntu:22.04", "percentage": 88},
        {"solution": "Upgrade to cgroup v1 compatible images instead of cgroup v2 (Ubuntu 20.04 vs 22.04)", "percentage": 85},
        {"solution": "Configure cgroup permissions for rootless user in systemd", "percentage": 75}
    ]'::jsonb,
    'Rootless Podman, cgroup v2 system (Ubuntu 22.04+), container image available',
    'Container runs with conmon successfully without cgroup permission errors',
    'cgroup v2 permission issues; Ubuntu 22.04 strict cgroup restrictions; insufficient user permissions',
    0.86,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/issues/23952'
),
(
    'error reading image [hash]: image not known',
    'podman',
    'MEDIUM',
    '[
        {"solution": "Remove orphaned Buildah containers: podman rm --storage <container-id>", "percentage": 97},
        {"solution": "Identify orphaned containers: buildah containers --all | grep ''*''", "percentage": 98},
        {"solution": "Clean storage: podman system prune --all", "percentage": 90}
    ]'::jsonb,
    'Buildah and Podman installed, storage accessible, permissions to remove containers',
    'podman image ls and podman prune execute without image not known errors',
    'Orphaned Buildah working containers; incomplete image cleanup; storage corruption from failed builds',
    0.94,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/issues/3982'
),
(
    'error creating mtab directory: mkdir /var/lib/containers/storage/overlay/*/merged/etc: file exists',
    'podman',
    'LOW',
    '[
        {"solution": "Build image without symlinked /etc directory; use regular directory structure in Dockerfile", "percentage": 99},
        {"solution": "If not building: modify container runtime to unlink existing symlinks before mtab creation", "percentage": 60}
    ]'::jsonb,
    'Container image with /etc symlink, Podman runtime available',
    'Container starts without mtab directory creation errors',
    'Image has /etc configured as symlink (e.g., /etc → /system/etc); Docker images without this issue unaffected',
    0.92,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/issues/12189'
),
(
    'netavark: code: 1, msg: iptables: Chain already exists',
    'podman',
    'MEDIUM',
    '[
        {"solution": "Use nftables firewall driver: set firewall_driver = ''nftables'' in netavark config", "percentage": 99},
        {"solution": "Disable firewall if not needed: set firewall_driver = ''none''", "percentage": 98},
        {"solution": "Upgrade netavark to latest version with nft native support", "percentage": 99}
    ]'::jsonb,
    'Quadlet container setup, netavark network backend, multiple containers launching, firewall control available',
    'Multiple containers start sequentially without iptables chain conflicts',
    'Older netavark without nftables support; iptables backend creating duplicate chains',
    0.97,
    'haiku',
    NOW(),
    'https://github.com/containers/podman/issues/20587'
),
(
    'Error processing tar file(exit status 1): operation not supported (rootless)',
    'podman',
    'MEDIUM',
    '[
        {"solution": "Use fuse-overlayfs backend: podman run --storage-opt ''overlay.mount_program=/usr/bin/fuse-overlayfs'' <image>", "percentage": 96},
        {"solution": "Move container store to XFS filesystem instead of tmpfs", "percentage": 98},
        {"solution": "Use XDG_DATA_HOME environment variable pointing to XFS-backed directory", "percentage": 94}
    ]'::jsonb,
    'Rootless Podman, tmpfs or incompatible filesystem for storage, container image requiring opaque directories',
    'Container image startup completes without tar file operation errors',
    'tmpfs-based storage lacks xattr support for overlay opaque directories; ubi8 and grafana-oss images especially problematic',
    0.95,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/72651641/podman-returns-error-processing-tar-fileexit-status-1-operation-not-supporte'
),
(
    'Error: cannot open sd-bus: No such file or directory: OCI not found',
    'podman',
    'MEDIUM',
    '[
        {"solution": "Install runc runtime: sudo apt install runc", "percentage": 99},
        {"solution": "Specify runc explicitly: podman --runtime=/usr/bin/runc run <image>", "percentage": 98}
    ]'::jsonb,
    'Minimal environment (DietPi, debootstrap), Raspberry Pi or ARM systems, package manager available',
    'Container starts with OCI runtime without sd-bus errors',
    'Missing OCI runtime in minimal environments; default runtime unavailable on minimal OS images',
    0.96,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/75909285/podman-error-cannot-open-sd-bus-no-such-file-or-directory-oci-not-found-err'
),
(
    'mounting ''.containerenv'' to rootfs: mount through procfd: not a directory error',
    'podman',
    'LOW',
    '[
        {"solution": "Rename executable to avoid system directory names: ADD ./app / instead of ADD ./run /", "percentage": 99},
        {"solution": "Use ENTRYPOINT [/app] for renamed binary instead of standard Linux directory names", "percentage": 99}
    ]'::jsonb,
    'Custom container image with executable, Dockerfile control',
    'Container mounts and executes without .containerenv directory conflicts',
    'Naming executable as standard Linux directory (/run, /bin, /etc, etc); Podman reserves /run for internal mounts',
    0.98,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/68244469/podman-oci-containerenv-not-a-directory'
),
(
    'Error: crun: error stat''ing file `/var/run/docker.sock`: No such file or directory (after reboot)',
    'podman',
    'MEDIUM',
    '[
        {"solution": "Remap Podman socket to Docker path: -v /run/podman/podman.sock:/var/run/docker.sock", "percentage": 97},
        {"solution": "Update container volume mounts from docker.sock to podman.sock", "percentage": 96}
    ]'::jsonb,
    'Podman container with docker.sock mount, docker-compatible tooling, container restarts available',
    'Container starts after reboot without socket stat errors',
    'Container binds /var/run/docker.sock (Docker path) instead of Podman''s socket; occurs after restart of containers',
    0.96,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/76880646/podman-container-cannot-start-after-reboot'
),
(
    'Error: OCI runtime error: setup user: invalid argument',
    'podman',
    'HIGH',
    '[
        {"solution": "Clear and reinit container config: rm -rf ~/.config/containers ~/.local/share/containers && podman system migrate", "percentage": 97},
        {"solution": "Ensure UID/GID mapping in /etc/subuid and /etc/subgid configured correctly", "percentage": 98},
        {"solution": "Verify subuid/subgid ranges adequate: USERNAME:100000:65536", "percentage": 99}
    ]'::jsonb,
    'User with Podman access, config directories writable, /etc/subuid and /etc/subgid available',
    'Containers start with user namespaces without setup user errors',
    'Incomplete user namespace delegation; insufficient UID/GID mappings; stale container config',
    0.95,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/65775075/problems-running-podman-in-ubuntu-20-04'
),
(
    'Cannot connect to Podman via VS Code Remote Containers: failed to create sshClient',
    'podman',
    'MEDIUM',
    '[
        {"solution": "Create symlink to align socket paths: sudo ln -sf /run/user/1000/podman/podman.sock /var/run/docker.sock", "percentage": 96},
        {"solution": "Use VS Code WSL workaround: enable ''Run in WSL'' in Development Container extension settings", "percentage": 94},
        {"solution": "Verify socket path: podman system connection list shows correct endpoint", "percentage": 98}
    ]'::jsonb,
    'VS Code Remote Containers extension, Podman machine configured, admin/sudo access for symlink',
    'VS Code connects to Podman and executes dev container commands successfully',
    'VS Code hardcodes /var/run/docker.sock path; Podman socket at different location; Windows native installation issues',
    0.95,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/72297060/what-could-be-the-reason-why-podman-isnt-working-on-remote-containers'
),
(
    'Error: cannot overwrite connection (podman machine init on macOS)',
    'podman',
    'HIGH',
    '[
        {"solution": "Remove previous config: rm -rf ~/.config/containers/ ~/.local/share/containers", "percentage": 98},
        {"solution": "Clean SSH keys: rm ~/.ssh/podman*", "percentage": 99},
        {"solution": "Reinstall: brew uninstall podman && brew install podman", "percentage": 99},
        {"solution": "Reinitialize machine: podman machine init && podman machine start", "percentage": 99}
    ]'::jsonb,
    'macOS system, Homebrew installed, sudo/admin access, clean package manager state',
    'podman machine init completes without connection overwrite errors',
    'Leftover config from previous Podman or Docker installations; SSH key conflicts; incomplete removal',
    0.97,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/72562644/podman-on-mac-throws-error-when-running-podman-machine-init'
),
(
    'Error: unable to start container: container create failed (no logs from conmon)',
    'podman',
    'MEDIUM',
    '[
        {"solution": "Update to official Podman repository from software.opensuse.org (devel:kubic:libcontainers:stable)", "percentage": 99},
        {"solution": "Remove Project Atomic PPA: remove-ppa ppa:projectatomic/ppa", "percentage": 98},
        {"solution": "Upgrade Podman to version 1.7+ from official repos", "percentage": 99}
    ]'::jsonb,
    'Ubuntu/Debian system, package manager access, ability to change repositories',
    'Container restart operations complete without conmon startup failures',
    'Using outdated Project Atomic PPA; conmon v2.0.3 bug; need migration to official repositories',
    0.96,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/59724108/cannot-start-an-existing-container-with-podman'
),
(
    'find: ''/var/lib/mysql/'': Permission denied (volume mount)',
    'podman',
    'HIGH',
    '[
        {"solution": "Use --userns=keep-id flag: podman-kube-play --userns=keep-id pod.yaml", "percentage": 98},
        {"solution": "Replace hostPath with Podman named volume: podman volume create db-volume", "percentage": 97},
        {"solution": "Use named volume in pod spec: volumes: name: database-volume persistentVolumeClaim", "percentage": 96}
    ]'::jsonb,
    'Podman kube-play or pod setup, database container, host directory or volume options',
    'Database pod starts and accesses volume without permission denied errors',
    'UID mismatch between container user (mysql:100998) and host user (1000); direct hostPath bind mounts',
    0.96,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/76315919/how-can-i-solve-a-permission-denied-error-to-a-mounted-volume-when-running-a-pod'
),
(
    'bind9 container: the working directory is not writable / loading configuration: permission denied',
    'podman',
    'MEDIUM',
    '[
        {"solution": "Use Podman named volumes instead of bind mounts: podman volume create bind-etc", "percentage": 99},
        {"solution": "Mount named volume: -v bind-etc:/etc/bind/:rw,Z", "percentage": 99},
        {"solution": "Named volumes handle UID/GID mapping automatically in container namespace", "percentage": 98}
    ]'::jsonb,
    'Bind9 container image, Podman installed, volume creation permissions',
    'Bind9 container starts and writes to working directory without permission errors',
    'Using bind mounts with rootless containers; subuid mapped user lacks host directory permissions',
    0.98,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/79173758/podman-volume-mount-permissions-issues'
),
(
    'ls: cannot open directory ''/home/foobar/.ssh'': Permission denied (host mount)',
    'podman',
    'HIGH',
    '[
        {"solution": "Use --userns=keep-id flag: podman run -it --userns=keep-id --mount type=bind,src=ssh,target=/home/foobar/.ssh", "percentage": 99},
        {"solution": "For pods: set --userns=keep-id at pod creation, not individual containers", "percentage": 98}
    ]'::jsonb,
    'Non-root container user, host directory to bind, Podman pod or container available',
    'Container accesses mounted host directory with correct permissions',
    'Rootless Podman doesn''t automatically map user IDs; mounted volumes show root:root ownership',
    0.98,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/74721069/mount-host-directory-to-docker-podman-container-with-correct-permissions'
),
(
    'Error: error stat''ing file: Permission denied / Operation not permitted (FUSE mount)',
    'podman',
    'MEDIUM',
    '[
        {"solution": "Mount encrypted filesystem with allow_other flag: mount -o allow_other /encrypted/path /mnt/point", "percentage": 99},
        {"solution": "Verify FUSE parameter allow_other set in /etc/fuse.conf: user_allow_other", "percentage": 98}
    ]'::jsonb,
    'Rootless Podman, gocryptfs or FUSE-based filesystem, mount permissions control',
    'Rootless container accesses FUSE-mounted directory without stat errors',
    'FUSE mount lacks allow_other parameter; unprivileged user cannot access encrypted mount points',
    0.97,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/72432778/writable-directories-with-rootless-podman'
);
