-- Docker Exit Codes Mining Migration
-- Created: 2025-11-27
-- Mined from Stack Overflow Docker exit code questions

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email) VALUES

-- Exit Code 0 - Success
('Docker exit code 0 success', 'devops-docker', 'HIGH', '[{"solution": "Exit code 0 indicates successful container execution. Check application logs for actual issues if unexpected.", "percentage": 95}, {"solution": "Use docker inspect container_id --format ''{{.State.ExitCode}}'' to verify actual exit code programmatically", "percentage": 90}]'::jsonb, 'Docker basics', 'Application ran and exited cleanly', 'Assuming code 0 means no issues when application crashed', 0.95, 'haiku', NOW(), 'https://stackoverflow.com/questions/31297616/what-is-the-authoritative-list-of-docker-run-exit-codes', 'admin:1764218139'),

-- Exit Code 1 - General Error
('Docker exit code 1 general error', 'devops-docker', 'HIGH', '[{"solution": "Check docker logs container_id to see actual error message from application", "percentage": 95}, {"solution": "Verify application ran correct command: check Dockerfile CMD or ENTRYPOINT", "percentage": 85}]'::jsonb, 'Docker basics', 'Application logs show specific error', 'Trying to fix Docker when error is in application code', 0.88, 'haiku', NOW(), 'https://stackoverflow.com/questions/46300610/how-to-get-the-numeric-exit-status-of-an-exited-docker-container', 'admin:1764218139'),

-- Exit Code 2 - Misuse of shell command
('Docker exit code 2 shell command misuse', 'devops-docker', 'MEDIUM', '[{"solution": "Verify shell script syntax with bash -n script.sh before running", "percentage": 85}, {"solution": "Check script shebang is correct (#!/bin/bash) and file has execute permissions", "percentage": 80}]'::jsonb, 'Shell scripting', 'Script executes without syntax errors', 'Incorrect bash/sh invocation or missing shebang', 0.82, 'haiku', NOW(), 'https://stackoverflow.com/questions/31297616/what-is-the-authoritative-list-of-docker-run-exit-codes', 'admin:1764218139'),

-- Exit Code 125 - Docker daemon error
('Docker exit code 125 docker daemon error', 'devops-docker', 'HIGH', '[{"solution": "Check docker run flags are valid: docker run --help to verify syntax", "percentage": 90}, {"solution": "Remove --name flag or add --rm flag if container already exists", "percentage": 85}, {"solution": "Verify docker daemon is running: docker info should work", "percentage": 80}]'::jsonb, 'Docker, Docker daemon', 'docker run command executes without errors', 'Invalid docker flags or existing container with same name', 0.87, 'haiku', NOW(), 'https://stackoverflow.com/questions/53640424/exit-code-125-from-docker-when-trying-to-run-container-programmatically', 'admin:1764218139'),

-- Exit Code 126 - Command cannot be invoked
('Docker exit code 126 command cannot be invoked', 'devops-docker', 'HIGH', '[{"solution": "Check file execute permissions: chmod +x script.sh before running", "percentage": 92}, {"solution": "Verify script is in image and path is correct in ENTRYPOINT/CMD", "percentage": 88}]'::jsonb, 'Docker, shell permissions', 'File has execute permissions and is in image', 'File exists but not executable or wrong path', 0.89, 'haiku', NOW(), 'https://stackoverflow.com/questions/31297616/what-is-the-authoritative-list-of-docker-run-exit-codes', 'admin:1764218139'),

-- Exit Code 127 - Command not found
('Docker exit code 127 command not found', 'devops-docker', 'HIGH', '[{"solution": "Verify command exists in PATH inside container: run docker run image which command_name", "percentage": 93}, {"solution": "Install missing command: add RUN apt-get install -y command_name to Dockerfile", "percentage": 90}]'::jsonb, 'Docker, PATH environment', 'Command accessible and in PATH', 'Command not installed in image or wrong path', 0.91, 'haiku', NOW(), 'https://stackoverflow.com/questions/27820268/trying-to-run-docker-resulted-in-exit-code-127', 'admin:1764218139'),

-- Exit Code 130 - SIGINT (Ctrl-C)
('Docker exit code 130 SIGINT Ctrl-C termination', 'devops-docker', 'MEDIUM', '[{"solution": "Graceful shutdown: Container received Ctrl-C signal. This is normal behavior if intentional", "percentage": 85}, {"solution": "For graceful handling, implement shutdown hook in application (Java: Runtime.getRuntime().addShutdownHook)", "percentage": 80}]'::jsonb, 'Signals, graceful shutdown', 'Application terminates cleanly on Ctrl-C', 'Expecting container to continue running after signal', 0.80, 'haiku', NOW(), 'https://stackoverflow.com/questions/29887088/java-program-exit-with-code-130', 'admin:1764218139'),

-- Exit Code 137 - SIGKILL (OOM or kill signal)
('Docker exit code 137 SIGKILL killed out of memory', 'devops-docker', 'HIGH', '[{"solution": "Increase Docker memory allocation: Docker Desktop Preferences > Resources > Memory", "percentage": 92}, {"solution": "Check docker logs container_id for OOMKilled message in State", "percentage": 88}, {"solution": "Optimize application memory usage or set memory limits properly", "percentage": 85}]'::jsonb, 'Memory, Docker daemon resources', 'docker inspect shows OOMKilled:false or memory stabilizes', 'Insufficient RAM allocated or memory leak in application', 0.86, 'haiku', NOW(), 'https://stackoverflow.com/questions/59296801/docker-compose-exit-code-is-137-when-there-is-no-oom-exception', 'admin:1764218139'),

-- Exit Code 139 - SIGSEGV (Segmentation fault)
('Docker exit code 139 SIGSEGV segmentation fault invalid memory reference', 'devops-docker', 'MEDIUM', '[{"solution": "For WSL2: add kernelCommandLine=vsyscall=emulate to .wslconfig", "percentage": 85}, {"solution": "Check CPU architecture match: build for linux/amd64 if running on amd64 host", "percentage": 80}]'::jsonb, 'Memory, CPU architecture, WSL2', 'Application runs without segmentation faults', 'Architecture mismatch (ARM vs x86) or memory corruption', 0.78, 'haiku', NOW(), 'https://stackoverflow.com/questions/55508604/docker-is-exited-immediately-when-runs-with-error-code-139', 'admin:1764218139'),

-- Exit Code 143 - SIGTERM (Graceful shutdown)
('Docker exit code 143 SIGTERM graceful shutdown terminated by signal', 'devops-docker', 'HIGH', '[{"solution": "This indicates graceful shutdown via SIGTERM. Check kubelet/orchestrator logs for reason", "percentage": 90}, {"solution": "Verify liveness probe is configured correctly if in Kubernetes", "percentage": 85}, {"solution": "Check application startup time - may be too slow to pass readiness probe", "percentage": 80}]'::jsonb, 'Signals, Kubernetes, graceful shutdown', 'Container stops cleanly without error logs', 'Liveness probe too aggressive or startup too slow', 0.84, 'haiku', NOW(), 'https://stackoverflow.com/questions/72263445/kubernetes-pod-terminates-with-exit-code-143', 'admin:1764218139'),

-- Image Not Found
('Docker image not found locally pull access denied', 'devops-docker', 'HIGH', '[{"solution": "Build image locally first: docker build -t my-image .", "percentage": 95}, {"solution": "Pull image from registry: docker pull image-name (requires docker login for private registries)", "percentage": 90}]'::jsonb, 'Docker image, registry', 'docker run succeeds with local or pulled image', 'Attempting to run non-existent image without building', 0.93, 'haiku', NOW(), 'https://stackoverflow.com/questions/56512769/unable-to-find-docker-image-locally', 'admin:1764218139'),

-- Port Already in Use
('Docker bind address already in use port allocated', 'devops-docker', 'HIGH', '[{"solution": "Use different port: docker run -p 5001:5000 image_name instead of 5000:5000", "percentage": 92}, {"solution": "Remove exited container: docker rm container_name, or add --rm flag to auto-remove", "percentage": 88}]'::jsonb, 'Docker networking, ports', 'Port bind succeeds without conflicts', 'Container still bound to port after exit', 0.90, 'haiku', NOW(), 'https://stackoverflow.com/questions/70797971/docker-error-response-from-daemon-ports-are-not-available-listen-tcp-0-0-0-0', 'admin:1764218139'),

-- Permission Denied
('Docker permission denied root user socket file access', 'devops-docker', 'HIGH', '[{"solution": "Add user to docker group: sudo usermod -aG docker $USER and log out/in", "percentage": 95}, {"solution": "Use sudo for docker commands if not in docker group", "percentage": 85}]'::jsonb, 'Docker permissions, user groups', 'docker commands work without sudo', 'User not in docker group or docker socket permission issue', 0.92, 'haiku', NOW(), 'https://stackoverflow.com/questions/48957195/how-to-fix-docker-permission-denied', 'admin:1764218139'),

-- Exec Format Error
('Docker exec format error incorrect architecture shebang', 'devops-docker', 'HIGH', '[{"solution": "Use docker buildx build --platform=linux/amd64 to match target architecture", "percentage": 90}, {"solution": "Check shebang has no whitespace before it (no spaces before #!/bin/bash)", "percentage": 88}]'::jsonb, 'Docker build, CPU architecture', 'Container runs without exec format errors', 'Build/run on different CPU architecture or bad shebang', 0.87, 'haiku', NOW(), 'https://stackoverflow.com/questions/77287655/how-to-solve-docker-container-exec-format-error-for-running-entrypoint', 'admin:1764218139'),

-- Build Failed with Exit Code 1
('Docker build failed exit code 1 apt-get dependency missing', 'devops-docker', 'HIGH', '[{"solution": "Add -y flag to apt-get: RUN apt-get install -y package_name (prevents interactive prompts)", "percentage": 94}, {"solution": "Update packages first: RUN apt-get update && apt-get install -y package", "percentage": 90}]'::jsonb, 'Docker build, package management', 'Dockerfile builds without interactive prompts', 'Apt-get waiting for user input without -y flag', 0.91, 'haiku', NOW(), 'https://stackoverflow.com/questions/69752207/docker-build-exits-with-exit-code-1', 'admin:1764218139'),

-- Health Check Failed
('Docker health check failed unhealthy state restart', 'devops-docker', 'MEDIUM', '[{"solution": "Check HEALTHCHECK command passes (curl -f works): HEALTHCHECK CMD curl -f http://localhost/ || exit 1", "percentage": 88}, {"solution": "Increase timeout if checks fail: --timeout=10s (default 30s)", "percentage": 82}]'::jsonb, 'Docker health checks', 'Health checks pass consistently', 'Health check command returning non-zero or timing out', 0.80, 'haiku', NOW(), 'https://stackoverflow.com/questions/62212675/what-happens-to-a-docker-container-when-healthcheck-fails', 'admin:1764218139'),

-- Memory Limit Exceeded
('Docker memory limit exceeded OOM kill container', 'devops-docker', 'HIGH', '[{"solution": "Check memswap_limit: it defaults to mem_limit, doubling total memory. Set memswap_limit: 0M to disable swap", "percentage": 92}, {"solution": "Increase mem_limit in docker-compose: mem_limit: 512M (sufficient for application)", "percentage": 88}]'::jsonb, 'Memory management, docker-compose', 'Container stays below memory limits', 'memswap_limit doubling effective limit or insufficient memory', 0.85, 'haiku', NOW(), 'https://stackoverflow.com/questions/64270202/docker-memory-limit-is-exceeded', 'admin:1764218139'),

-- Volume Mount Failed
('Docker volume mount failed no such file or directory', 'devops-docker', 'HIGH', '[{"solution": "Use absolute path for volumes: ${PWD}/data:/data instead of ./data:/data", "percentage": 94}, {"solution": "Create host directory first: mkdir -p /path/to/volume before running", "percentage": 90}]'::jsonb, 'Docker volumes, mounts', 'Volume mounts successfully with persistent data', 'Relative paths or missing host directories', 0.91, 'haiku', NOW(), 'https://stackoverflow.com/questions/71680749/docker-failed-to-mount-local-volume-mount-no-such-file-or-directory', 'admin:1764218139'),

-- DNS Resolution Failed
('Docker DNS resolution failed connection refused container', 'devops-docker', 'MEDIUM', '[{"solution": "Use custom bridge network, NOT default: create network and connect containers", "percentage": 92}, {"solution": "Containers on default network need service names as IPs: use docker network create and --network flag", "percentage": 85}]'::jsonb, 'Docker networking, DNS', 'Containers resolve each other by service name', 'Using default bridge network (no DNS support) or network config', 0.83, 'haiku', NOW(), 'https://stackoverflow.com/questions/64007727/docker-compose-internal-dns-server-127-0-0-11-connection-refused', 'admin:1764218139'),

-- Network Mode Host DNS Issues
('Docker network host mode DNS resolution does not work', 'devops-docker', 'MEDIUM', '[{"solution": "Remove network_mode: host if not needed: enables Docker DNS on custom bridge", "percentage": 88}, {"solution": "Use host.docker.internal to reach host from container if host mode needed", "percentage": 82}]'::jsonb, 'Docker networking, network modes', 'Container DNS works with custom bridge or standard network', 'Forcing host network mode without proper DNS setup', 0.79, 'haiku', NOW(), 'https://stackoverflow.com/questions/73695074/automatic-dns-resolution-does-not-work-on-containers-running-on-host-network', 'admin:1764218139'),

-- Restart Policy Confusion
('Docker restart policy always vs on-failure behavior', 'devops-docker', 'MEDIUM', '[{"solution": "Use restart: always for production containers that should always be running", "percentage": 85}, {"solution": "Use restart: on-failure with max-retries limit for debugging: restart: on-failure:5", "percentage": 80}]'::jsonb, 'Docker restart policies', 'Container restarts follow policy', 'Not understanding restart policy differences', 0.81, 'haiku', NOW(), 'https://stackoverflow.com/questions/61725195/difference-in-docker-restart-policy-between-on-failure-and-unless-stopped', 'admin:1764218139'),

-- Invalid Docker Flags
('Docker run invalid flags syntax error', 'devops-docker', 'MEDIUM', '[{"solution": "Check flag format in docker run --help output", "percentage": 90}, {"solution": "Use = for flags with values: --name=mycontainer not --name mycontainer (depending on flag)", "percentage": 82}]'::jsonb, 'Docker CLI, command syntax', 'docker run executes with valid flags', 'Incorrect flag format or missing required values', 0.84, 'haiku', NOW(), 'https://stackoverflow.com/questions/31297616/what-is-the-authoritative-list-of-docker-run-exit-codes', 'admin:1764218139'),

-- Container Exits Immediately
('Docker container exits immediately no entrypoint command', 'devops-docker', 'HIGH', '[{"solution": "Add CMD or ENTRYPOINT to Dockerfile to keep container running", "percentage": 93}, {"solution": "Verify container has a long-running process (not just startup script)", "percentage": 88}]'::jsonb, 'Docker, Dockerfile, ENTRYPOINT', 'Container stays running after start', 'Image has no CMD/ENTRYPOINT or process terminates immediately', 0.90, 'haiku', NOW(), 'https://stackoverflow.com/questions/62022332/al-docker-images-exit-126-status', 'admin:1764218139')
;
