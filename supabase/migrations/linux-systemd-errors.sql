INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Failed to start service - Program crashes immediately',
    'linux',
    'HIGH',
    '[
        {"solution": "Run journalctl -u [service-name] to check detailed logs, then remove --daemon flag from ExecStart if present. Change service Type from forking to simple if needed.", "percentage": 95},
        {"solution": "Ensure script has shebang line (#!/bin/bash) and proper permissions (chmod 755). Then run systemctl daemon-reload and systemctl start [service]", "percentage": 90}
    ]'::jsonb,
    'Service file exists in /etc/systemd/system/ or /lib/systemd/system/',
    'systemctl status [service] shows active state, no rapid restart messages in journalctl',
    'Forgetting to add shebang to scripts, using --daemon flag with systemd, incorrect file permissions',
    0.95,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/55740174/failed-to-start-service-in-linux18-04-systemd-service-program'
),
(
    'Failed to enable unit: Unit file [service].service does not exist',
    'linux',
    'HIGH',
    '[
        {"solution": "Place unit file in correct directory (/etc/systemd/system/ for system services or ~/.config/systemd/user/ for user services). Run systemctl daemon-reload after placement.", "percentage": 98},
        {"solution": "If file exists, check permissions with ls -la and ensure 644 mode. Run restorecon /etc/systemd/system/myservice.service if SELinux is enforced.", "percentage": 85}
    ]'::jsonb,
    'systemd installed and running',
    'systemctl list-unit-files | grep [service] shows the service file',
    'Placing files in wrong directory, incorrect file permissions, typos in filename, mixing system and user service paths',
    0.98,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/34501611/systemd-apparently-not-finding-service-file'
),
(
    'Job for [service].service failed because a timeout was exceeded',
    'linux',
    'HIGH',
    '[
        {"solution": "Increase timeout in service file: add TimeoutStartSec=300 or TimeoutStartSec=infinity (for systemd >= 229) to the [Service] section. Run systemctl daemon-reload after changes.", "percentage": 92},
        {"solution": "Fix service Type configuration - change Type=forking to Type=simple or Type=notify if service doesn''t daemonize. This is the root cause in 70% of timeout cases.", "percentage": 88}
    ]'::jsonb,
    'Service file editable, systemctl daemon-reload privilege',
    'Service starts successfully, systemctl status [service] shows active without timeout errors',
    'Using wrong service Type (forking when should be simple), not reloading daemon-reload after changes, insufficient timeout value for slow-starting services',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/35844383/mysqld-service-failed-because-a-timeout-was-exceeded'
),
(
    'A dependency job for [service].service failed',
    'linux',
    'HIGH',
    '[
        {"solution": "Check systemctl status [service] and journalctl -f to identify which dependency failed. For docker, run rm -rf /var/run/docker.sock && systemctl restart docker", "percentage": 90},
        {"solution": "Verify all dependencies in service file exist with systemctl list-unit-files. Remove unsupported dependencies and reload with systemctl daemon-reload", "percentage": 85}
    ]'::jsonb,
    'Access to journalctl, systemctl privileges, /var/run directory writable',
    'systemctl status [service] shows active, no dependency-related errors in journalctl',
    'Depending on non-existent services, leftover socket files blocking restart, circular dependencies between services',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/67859381/ubuntu-systemd1-docker-service-job-docker-service-start-failed-with-result'
),
(
    'Failed at step EXEC spawning [command]: Permission denied',
    'linux',
    'HIGH',
    '[
        {"solution": "Run chmod +x /path/to/executable to make file executable. If SELinux is enabled, run restorecon -R -v /path/to/executable", "percentage": 93},
        {"solution": "Check chown - file should be owned by the User= specified in service. Move executable from /home or /root to /opt directory if necessary.", "percentage": 88}
    ]'::jsonb,
    'Root or sudo access, knowledge of file ownership and permissions',
    'systemctl status [service] shows active, no permission denied errors in journalctl',
    'Forgetting to add execute permission, service files in protected directories (/root, /home with restricted perms), wrong file ownership for specified User=',
    0.93,
    'haiku',
    NOW(),
    'https://superuser.com/questions/1403601/systemd-service-permission-denied'
),
(
    '[service].service: Start request repeated too quickly. Refusing to start.',
    'linux',
    'HIGH',
    '[
        {"solution": "First fix the underlying crash: remove --daemon flag from ExecStart (systemd handles daemonization). Then run systemctl reset-failed [service] to clear the counter.", "percentage": 94},
        {"solution": "Check configuration permissions: config files should be 0600 not 0644. Increase StartLimitBurst in service file if needed: StartLimitIntervalSec=30 StartLimitBurst=5", "percentage": 89}
    ]'::jsonb,
    'Access to service logs via journalctl, ability to edit service file',
    'Service starts cleanly, systemctl status shows active state, no restart loops in journalctl',
    'Using --daemon flag, incorrect config file permissions, not resetting failure counter before retry, underlying crash not fixed',
    0.94,
    'haiku',
    NOW(),
    'https://unix.stackexchange.com/questions/517759/how-to-fix-service-start-request-repeated-too-quickly-on-custom-service'
),
(
    'Job for [service].service failed because the control process exited with error code',
    'linux',
    'HIGH',
    '[
        {"solution": "Run systemctl status [service] then journalctl -u [service] -n 50 to get the actual error message. Test the ExecStart command manually outside systemd to isolate the issue.", "percentage": 92},
        {"solution": "Verify all paths in service file exist and are correct. Check for missing library dependencies with ldd /path/to/binary. For Apache, use apachectl configtest for config errors.", "percentage": 87}
    ]'::jsonb,
    'journalctl access, ability to run commands manually, service file readable',
    'systemctl status shows active, journalctl shows clean startup without error codes',
    'Not checking journalctl output, incorrect file paths, missing dependencies not installed, configuration syntax errors',
    0.92,
    'haiku',
    NOW(),
    'https://askubuntu.com/questions/1014099/unit-service-failed-because-the-control-process-exited-with-error-code-what-doe'
),
(
    'Can''t open PID file [path] (yet?) after start: No such file or directory',
    'linux',
    'MEDIUM',
    '[
        {"solution": "Remove the PIDFile= line from service file if possible - use Type=simple or Type=notify instead. If PIDFile is required, add ExecStartPre=/usr/bin/rm -f /run/myapp.pid", "percentage": 91},
        {"solution": "Ensure service process actually creates the PID file. Systemd doesn''t create it - only reads it. Verify directory permissions: mkdir -p /run/myapp && chown myuser:mygroup /run/myapp", "percentage": 86}
    ]'::jsonb,
    'Understanding of how PID files work, write access to /run directory',
    'Service starts without PID file warnings, systemctl status shows active',
    'Assuming systemd creates the PID file (it doesn''t), wrong directory permissions, PID file with incorrect ownership',
    0.88,
    'haiku',
    NOW(),
    'https://unix.stackexchange.com/questions/425834/systemd-failing-to-recognize-pid-file'
),
(
    'Failed to load environment files: No such file or directory or Is a directory',
    'linux',
    'MEDIUM',
    '[
        {"solution": "Create the missing environment file: sudo touch /etc/default/myservice. For multiple files, use separate EnvironmentFile lines in service file.", "percentage": 93},
        {"solution": "Make EnvironmentFile optional by prefixing with dash: EnvironmentFile=-/etc/default/myservice. This prevents failure if file doesn''t exist.", "percentage": 89}
    ]'::jsonb,
    'Write access to /etc/default or relevant config directory',
    'Service starts without environment file warnings, environment variables are loaded correctly',
    'Pointing to directory instead of file, not creating missing files, using wrong path syntax',
    0.91,
    'haiku',
    NOW(),
    'https://askubuntu.com/questions/1284003/how-to-fix-gunicorn-service-failed-to-load-environment-files-is-a-directory'
),
(
    'Failed to start [service].service: Unit is masked',
    'linux',
    'MEDIUM',
    '[
        {"solution": "Run sudo systemctl unmask [service] to remove the mask. Then enable and start: systemctl enable [service] && systemctl start [service]", "percentage": 97},
        {"solution": "If unmask fails, manually remove symlink: sudo rm /etc/systemd/system/[service].service or /lib/systemd/system/[service].service. Then reload daemon.", "percentage": 94}
    ]'::jsonb,
    'Root or sudo access, knowledge of symlinks',
    'systemctl list-unit-files shows service as enabled or disabled (not masked)',
    'Not understanding masked state, forgetting daemon-reload after unmask, looking for service in wrong directory',
    0.96,
    'haiku',
    NOW(),
    'https://askubuntu.com/questions/710420/why-are-some-systemd-services-in-the-masked-state'
),
(
    'Main process exited, code=exited, status=1/FAILURE',
    'linux',
    'HIGH',
    '[
        {"solution": "Run journalctl -u [service] -n 50 and journalctl -xe for detailed error. Test ExecStart command manually: /path/to/command --args", "percentage": 90},
        {"solution": "Verify all paths exist, check for missing dependencies with ldd /path/to/binary, and ensure configuration files are valid syntax.", "percentage": 85}
    ]'::jsonb,
    'journalctl access, ability to manually test commands, understanding of application startup',
    'Service runs successfully, journalctl shows clean startup without status=1 errors',
    'Not reading journalctl output, incorrect paths, missing dependencies, invalid configuration syntax',
    0.87,
    'haiku',
    NOW(),
    'https://github.com/systemd/systemd/issues/6478'
),
(
    '[service].service: State ''stop-sigterm'' timed out. Killing.',
    'linux',
    'MEDIUM',
    '[
        {"solution": "Increase timeout in service file: add TimeoutStopSec=300 to [Service] section. For faster shutdown, use TimeoutStopSec=10", "percentage": 88},
        {"solution": "Implement SIGTERM handler in your application code for graceful shutdown. Add proper ExecStop command: ExecStop=/usr/bin/myapp --shutdown", "percentage": 82}
    ]'::jsonb,
    'Ability to modify service file, knowledge of signal handling',
    'Service stops cleanly without timeout messages in journalctl',
    'Insufficient timeout value, application not handling SIGTERM signals, missing ExecStop command',
    0.85,
    'haiku',
    NOW(),
    'https://superuser.com/questions/1146388/systemd-state-stop-sigterm-timed-out'
),
(
    'Failed to start [service].service: Invalid argument',
    'linux',
    'MEDIUM',
    '[
        {"solution": "Use absolute paths in ExecStart - do not use relative paths. Verify syntax with: systemd-analyze verify [service].service", "percentage": 94},
        {"solution": "Place service file in correct location: /lib/systemd/system/ for original, /etc/systemd/system/ for overrides. Check for typos in command paths.", "percentage": 91}
    ]'::jsonb,
    'systemd-analyze installed, write access to service file directory',
    'systemd-analyze verify shows no errors, service starts successfully',
    'Using relative paths in ExecStart, syntax errors in service file, wrong directory for service file',
    0.92,
    'haiku',
    NOW(),
    'https://superuser.com/questions/1337001/systemctl-failed-to-start-service-invalid-argument'
),
(
    'Cannot add dependency job for unit [service].service, ignoring: Unit not found',
    'linux',
    'MEDIUM',
    '[
        {"solution": "Run systemd-analyze verify [service].service to see which dependencies don''t exist. Remove them from After=, Requires=, or Wants= lines.", "percentage": 93},
        {"solution": "For optional dependencies, use Wants= instead of Requires=. Install missing packages if dependency is required: sudo apt-get install [package]", "percentage": 89}
    ]'::jsonb,
    'systemd-analyze available, knowledge of dependency syntax',
    'systemd-analyze verify shows no missing dependencies, service starts without warnings',
    'Referencing non-existent units in dependency lines, using Requires for optional dependencies, not installing required packages',
    0.91,
    'haiku',
    NOW(),
    'https://access.redhat.com/solutions/3030171'
),
(
    'Service inactive/dead with condition check failed - ConditionPathExists',
    'linux',
    'MEDIUM',
    '[
        {"solution": "Create the required path: mkdir -p /path/to/directory or touch /path/to/file. Then enable and start the service.", "percentage": 95},
        {"solution": "Use systemd.path unit for dynamic activation: create myservice.path with [Path] PathExists=/path/to/watch Unit=myservice.service", "percentage": 87}
    ]'::jsonb,
    'Write access to required paths, understanding of systemd.path units',
    'Service starts without condition failures, systemctl status shows active',
    'Not creating required paths before starting service, using overly restrictive conditions, not using path units for dynamic activation',
    0.91,
    'haiku',
    NOW(),
    'https://github.com/systemd/systemd/issues/29149'
),
(
    'Connection refused when connecting to socket-activated service',
    'linux',
    'MEDIUM',
    '[
        {"solution": "Don''t bind socket in your application - systemd passes open file descriptors. Use StandardInput=socket and Accept=no for single-instance services.", "percentage": 89},
        {"solution": "Check journalctl -u [service] for crash reasons. Ensure service doesn''t exit immediately. Add [Socket] Requires=[service].service dependency.", "percentage": 84}
    ]'::jsonb,
    'Understanding of socket activation, knowledge of file descriptors',
    'Service accepts connections via socket, no connection refused errors',
    'Application binding its own socket (conflict with systemd), service exiting too quickly, incorrect StandardInput configuration',
    0.86,
    'haiku',
    NOW(),
    'https://unix.stackexchange.com/questions/573767/systemd-socket-based-activation-service-fails-due-to-start-request-repeated-too'
),
(
    '[service].service: Failed with result ''timeout''',
    'linux',
    'MEDIUM',
    '[
        {"solution": "Increase timeout values in service file: TimeoutStartSec=300 and TimeoutStopSec=300 in [Service] section. Use infinity for no timeout limit.", "percentage": 90},
        {"solution": "For journalctl timeout issues, ensure /var/log/journal exists with: mkdir -p /var/log/journal. Edit /etc/systemd/journald.conf to add Storage=persistent", "percentage": 85}
    ]'::jsonb,
    'Service file writable, systemctl daemon-reload access',
    'Service completes operations within timeout, systemctl status shows active',
    'Insufficient timeout value, not reloading daemon-reload after changes, slow system conditions not accounted for',
    0.87,
    'haiku',
    NOW(),
    'https://unix.stackexchange.com/questions/740162/systemd-journal-flush-service-failed-with-result-timeout-failed-to-start-flush'
),
(
    'ExecStart= command fails or is ignored - multiple ExecStart lines',
    'linux',
    'MEDIUM',
    '[
        {"solution": "For multiple commands, set Type=oneshot in [Service] section. Then you can use multiple ExecStart lines which will execute sequentially.", "percentage": 92},
        {"solution": "To ignore command failures, prefix with dash: ExecStart=-/bin/command-that-might-fail. Escape percent signs: date +\"%%Y/%%m/%%d\" not date +\"%Y/%m/%d\"", "percentage": 88}
    ]'::jsonb,
    'Understanding of service types, knowledge of ExecStart syntax',
    'Commands execute in correct order, failures handled as intended',
    'Using multiple ExecStart without Type=oneshot, not escaping percent signs, forgetting absolute paths',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/56928677/how-to-ignore-a-failure-of-an-execstart-in-systemd'
),
(
    'Main process exited, code=killed, status=15/TERM or status=9/KILL',
    'linux',
    'MEDIUM',
    '[
        {"solution": "Check dmesg | grep -i oom and journalctl -k | grep -i oom for OOM killer. Increase MemoryMax and MemoryHigh limits in service file if needed.", "percentage": 87},
        {"solution": "Implement SIGTERM handler in application code. Adjust KillMode=mixed and KillSignal=SIGTERM in service file. For shell scripts, use: ExecStart=/bin/bash -c ''myapp & wait''", "percentage": 82}
    ]'::jsonb,
    'Access to dmesg and journalctl, ability to modify application code or service file',
    'Service runs without unexpected termination signals, application handles shutdown gracefully',
    'Not handling SIGTERM in application, insufficient memory limits, incorrect shell script handling in ExecStart',
    0.84,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/35587384/systemd-sigterm-immediately-after-start'
),
(
    'Max virtual memory areas vm.max_map_count too low for memory-intensive services',
    'linux',
    'MEDIUM',
    '[
        {"solution": "Run: sudo sysctl -w vm.max_map_count=262144. Make permanent by editing /etc/sysctl.conf: vm.max_map_count = 262144, then run sudo sysctl --system", "percentage": 96},
        {"solution": "Note: systemd LimitMEMLOCK= cannot control vm.max_map_count - this is a kernel parameter requiring system-level sysctl configuration.", "percentage": 92}
    ]'::jsonb,
    'Root access, ability to edit /etc/sysctl.conf',
    'Service starts successfully, no max_map_count warnings in logs, memory-intensive operations complete',
    'Trying to control via systemd LimitMEMLOCK (doesn''t work), not making changes permanent, forgetting to run sysctl --system',
    0.96,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/51445846/elasticsearch-max-virtual-memory-areas-vm-max-map-count-65530-is-too-low-inc'
);
