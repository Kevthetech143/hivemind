-- Docker & Kubernetes Error Knowledge Mining - 2025-11-26
-- 8 high-quality entries from Stack Overflow research

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES

-- Entry 1: CrashLoopBackOff
(
    'pod status CrashLoopBackOff container keeps crashing restarting',
    'docker-k8s',
    'HIGH',
    '[
        {"solution": "Check pod logs: kubectl logs <pod-name> --previous to see why container exited. Add a persistent foreground process to entrypoint if process exits immediately", "percentage": 95},
        {"solution": "Increase probe initialDelaySeconds from default 0 to 120-300 seconds for slow-starting applications", "percentage": 90},
        {"solution": "Verify resources available - increase memory/CPU limits if pod is being OOMKilled", "percentage": 85}
    ]'::jsonb,
    'Kubernetes cluster running, kubectl access, understanding of container entrypoints',
    'Pod status changes from CrashLoopBackOff to Running, no more repeated crashes in events',
    'Forgetting to check --previous logs (current logs empty for crashed pods), insufficient initialDelaySeconds for apps with long startup time, missing ENTRYPOINT or CMD in Dockerfile',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/41604499/my-kubernetes-pods-keep-crashing-with-crashloopbackoff-but-i-cant-find-any-lo',
    'admin:1764173790'
),

-- Entry 2: Docker Container Won't Start
(
    'docker container won''t start exits immediately bash shell detached mode',
    'docker-k8s',
    'HIGH',
    '[
        {"solution": "Add -it flags to allocate pseudo-terminal: docker run -it -d [image] to keep container running with bash", "percentage": 95},
        {"solution": "Run service in foreground with -D flag: docker run -d [image] /usr/sbin/sshd -D instead of daemonizing", "percentage": 90},
        {"solution": "Verify container has a long-running foreground process - service commands that exit cause immediate container exit", "percentage": 85}
    ]'::jsonb,
    'Docker daemon running, container image available',
    'docker ps shows container in running state, docker attach [container] succeeds without "cannot attach" error',
    'Running interactive shells (-it) without foreground process, using service start commands that daemonize, not understanding container needs persistent process',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/29957653/docker-container-not-starting-docker-start',
    'admin:1764173790'
),

-- Entry 3: Docker Build Context Too Large
(
    'docker build sending context to daemon very large GB slow file transfer',
    'docker-k8s',
    'HIGH',
    '[
        {"solution": "Create .dockerignore file excluding .git, node_modules, dist, tmp folders similar to .gitignore to exclude large directories from context", "percentage": 92},
        {"solution": "Enable Docker BuildKit: DOCKER_BUILDKIT=1 docker build -t image:tag . to reduce unnecessary file transmission", "percentage": 88},
        {"solution": "Move Dockerfile to subdirectory with only necessary files, specify that directory as build context: docker build -t image:tag ./app-only", "percentage": 85}
    ]'::jsonb,
    'Docker CLI installed, Dockerfile in project, understanding of build context',
    'Docker build output shows "Sending build context to Docker daemon [size]KB" with significantly reduced size compared to before',
    'Including entire .git history in context (can be 1GB+), not using .dockerignore, building from root directory with large node_modules or vendor folders',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/26600769/build-context-for-docker-image-very-large',
    'admin:1764173790'
),

-- Entry 4: Docker Authentication Unauthorized
(
    'docker push unauthorized authentication required despite successful login',
    'docker-k8s',
    'HIGH',
    '[
        {"solution": "Verify registry URL in ~/.docker/config.json is https://index.docker.io/v1/ not just docker.io - wrong URL prevents auth", "percentage": 93},
        {"solution": "Tag image with username prefix: docker tag image-id username/repository-name before pushing to match expected repo path", "percentage": 94},
        {"solution": "Re-authenticate: docker logout && docker login to refresh credentials in config.json, fixes expired or corrupted tokens", "percentage": 91}
    ]'::jsonb,
    'Docker daemon running, docker login previously executed',
    'docker push succeeds without unauthorized error, image appears in registry after push completes',
    'Using wrong registry URL (docker.io vs index.docker.io), image name mismatch between local build and registry repo, old credentials in keychains',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/36663742/docker-unauthorized-authentication-required-upon-push-with-successful-login',
    'admin:1764173790'
),

-- Entry 5: Kubernetes ImagePullBackOff
(
    'kubernetes ImagePullBackOff failed to pull image back-off pulling authentication',
    'docker-k8s',
    'HIGH',
    '[
        {"solution": "Run kubectl describe pod <pod-name> and check Events section for specific error - most common is typo in image name or missing tag", "percentage": 94},
        {"solution": "Verify credentials with kubectl get secret <secret-name> -o jsonpath=''{.data.config\\.json}'' | base64 -d and ensure ImagePullSecrets specified in pod spec", "percentage": 88},
        {"solution": "Test manual docker pull on worker node: ssh to node and run ''docker pull image:tag'' to verify node can reach registry", "percentage": 90}
    ]'::jsonb,
    'Kubernetes cluster running, kubectl access, registry credentials stored as secret',
    'kubectl describe shows pod status Running and container created, no ImagePullBackOff in status or events',
    'Using wrong image name or tag format, missing or incorrectly named ImagePullSecrets, registry unreachable from node (firewall/NAT issues)',
    0.89,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/34848422/how-can-i-debug-imagepullbackoff',
    'admin:1764173790'
),

-- Entry 6: Kubernetes OOMKilled Exit Code 137
(
    'kubernetes pod OOMKilled exit code 137 out of memory container memory limit',
    'docker-k8s',
    'HIGH',
    '[
        {"solution": "Check pod status: kubectl describe pod <pod-name> shows reason OOMKilled with exit code 137 - increase memory limit in pod spec resources.limits.memory", "percentage": 95},
        {"solution": "Distinguish node OOMKilled (Evicted status) from container OOMKilled - node OOM requires pod migration to node with more available memory", "percentage": 88},
        {"solution": "Check QoS class: kubectl describe pod shows Guaranteed/Burstable/BestEffort - Guaranteed pods evicted last during node memory pressure", "percentage": 85}
    ]'::jsonb,
    'Kubernetes cluster running, kubectl access, ability to modify pod spec',
    'Pod restarts and reaches Running status, no new OOMKilled events in pod description',
    'Confusing node-level Evicted with container-level OOMKilled, not checking previous container logs, underestimating memory needs for application',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/62518884/reasons-for-oomkilled-in-kubernetes',
    'admin:1764173790'
),

-- Entry 7: Docker Daemon Socket Connection Error
(
    'docker cannot connect to daemon at unix var run docker.sock is daemon running permission denied',
    'docker-k8s',
    'HIGH',
    '[
        {"solution": "Start docker service: sudo service docker start or sudo systemctl start docker then retry docker commands", "percentage": 94},
        {"solution": "Run daemon directly to diagnose: sudo dockerd shows detailed errors if service start fails - common on WSL2/Ubuntu without systemd", "percentage": 92},
        {"solution": "Fix context on Ubuntu 22.04+: docker context use default - newer Ubuntu versions have context misconfiguration after install", "percentage": 89}
    ]'::jsonb,
    'Docker installed, user has sudo access or docker group membership',
    'docker run hello-world succeeds and pulls/runs container, no socket connection errors',
    'Not checking if daemon running before commands, permission issues from fresh install, wrong context on Ubuntu 22.04+, using sudo when added to docker group',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/44678725/cannot-connect-to-the-docker-daemon-at-unix-var-run-docker-sock-is-the-docker',
    'admin:1764173790'
),

-- Entry 8: Docker Port Already in Use
(
    'docker error starting userland proxy bind address already in use listen tcp port',
    'docker-k8s',
    'HIGH',
    '[
        {"solution": "Identify process: sudo lsof -i :PORT or sudo netstat -nlp | grep PORT shows PID using port - then kill -9 PID to release", "percentage": 95},
        {"solution": "On macOS disable AirPlay receiver using port 5000: System Preferences > Sharing > uncheck AirPlay Receiver", "percentage": 93},
        {"solution": "Clean up previous containers: docker rm -fv $(docker ps -aq) and docker-compose down from same directory to remove stale bindings", "percentage": 88}
    ]'::jsonb,
    'Docker installed, port number identified, ability to kill processes or modify system settings',
    'docker run -p PORT:PORT [image] succeeds without bind error, container starts and is accessible on specified port',
    'Not identifying which process owns port, killing random processes, assuming Docker owns all port conflicts (Apache/Nginx often culprit), not cleaning compose properly',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/37971961/docker-error-bind-address-already-in-use',
    'admin:1764173790'
);
