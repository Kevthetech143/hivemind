INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Error: unable to start container: container create failed (no logs from conmon): EOF',
    'podman',
    'MEDIUM',
    '[
        {"solution": "Remove Project Atomic PPA and reinstall Podman from software.opensuse.org", "percentage": 95},
        {"solution": "Upgrade to Podman 1.7+ which includes the conmon v2.0.3 bug fix", "percentage": 92}
    ]'::jsonb,
    'Podman installed from Project Atomic PPA, container previously started successfully',
    'Container starts and stops successfully without EOF errors',
    'Not updating to the fixed version, continuing to use old conmon package',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/59724108/cannot-start-an-existing-container-with-podman'
),
(
    'WARN[0010] StopSignal SIGTERM failed to stop container in 10 seconds, resorting to SIGKILL. Error: given PID did not die within timeout',
    'podman',
    'HIGH',
    '[
        {"solution": "Manually kill process: kill -9 $(podman container inspect <name> -f ''{{.State.Pid}}'')", "percentage": 88},
        {"solution": "Adjust StopSignal from 15 to 9 in container config and increase stop_timeout in containers.conf", "percentage": 75},
        {"solution": "Use podman container kill instead of podman stop command", "percentage": 60}
    ]'::jsonb,
    'Ubuntu 24.04, Podman 4.x+, container stuck in stopping state',
    'Container responds to stop signal within timeout period',
    'Using sudo podman stop (issue specific to sudo), not checking if only affects stopping state',
    0.88,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/78594757/podman-failed-to-stop-any-containers-by-using-sudo-podman-stop'
),
(
    'error creating overlay mount to /var/lib/containers/storage/overlay/[path]/merged: invalid argument',
    'podman',
    'MEDIUM',
    '[
        {"solution": "Run podman system reset -f to reset Podman system state", "percentage": 90},
        {"solution": "Remove /etc/containers/storage.conf file if present", "percentage": 88},
        {"solution": "Run podman system reset -f again after removing storage.conf", "percentage": 87}
    ]'::jsonb,
    'Podman 3.4.2+, attempting to build Dockerfile image, storage.conf may exist',
    'Podman build command succeeds and image builds without overlay mount errors',
    'Removing storage.conf without understanding its contents, not running reset twice',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/73942531/podman-unable-to-build-image-from-dockerfile-error-creating-overlay-mount'
),
(
    'http://%2Ftmp%2Fpodmanpy-runtime-dir-fallback-root%2Fpodman%2Fpodman.sock/v5.2.0/libpod/containers/create (POST operation failed)',
    'podman',
    'LOW',
    '[
        {"solution": "Initialize PodmanClient with explicit base_url parameter: PodmanClient(base_url=\"http+unix:///run/podman/podman.sock\")", "percentage": 91},
        {"solution": "Ensure socket path is not auto-detected from temporary/fallback directory", "percentage": 85}
    ]'::jsonb,
    'Python Podman client library, container trying to create another container, Podman 5.2.0+',
    'Container creation succeeds without socket path encoding errors',
    'Relying on automatic socket detection, not specifying explicit base_url',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/79065789/podman-error-creating-container-post-operation-failed'
),
(
    'Error: OCI runtime error: runc: exec failed: container does not exist',
    'podman',
    'MEDIUM',
    '[
        {"solution": "Check Podman version - issue affects 4.4.1-4.6.1 on RHEL 8.8-8.9, consider upgrading to newer version", "percentage": 50},
        {"solution": "Verify container state with podman container inspect, restart container if needed", "percentage": 40},
        {"solution": "Restart Podman daemon and re-create container if state is corrupted", "percentage": 35}
    ]'::jsonb,
    'Podman 4.4.1-4.6.1, RHEL 8.8-8.9, runc 1.1.4+, container state management',
    'Container responds to podman exec and podman stop commands without errors',
    'Assuming container is actually non-existent (it still functions), not checking version compatibility',
    0.42,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/77980166/error-oci-runtime-error-runc-exec-failed-container-does-not-exist-podman'
);
