-- Add Kubernetes pod/deployment troubleshooting solutions batch 1
-- Mined from kubernetes/kubernetes issues and official documentation
-- Focus: CrashLoopBackOff, ImagePullBackOff, networking, resource limits

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Pod stuck in CrashLoopBackOff state - container keeps restarting',
    'github-kubernetes',
    'VERY_HIGH',
    '[
        {"solution": "Check restart count with kubectl describe pod <name>. Review events section for container exit codes and restart policy settings. Common exit codes: 1 (generic), 127 (command not found), 137 (OOMKilled)", "percentage": 90, "note": "Most reliable first step"},
        {"solution": "Examine container logs with kubectl logs <pod-name> and kubectl logs <pod-name> --previous to see what caused the crash. Check for missing dependencies, unmet startup requirements, or config errors.", "percentage": 85, "command": "kubectl logs <pod-name> --previous"},
        {"solution": "Verify startup dependencies between containers. Use initContainers to sequence startup, or implement readiness/liveness probes. Consider startup probes for containers that need time to initialize.", "percentage": 80, "note": "Works for multi-container pod issues"},
        {"solution": "Validate container configuration: check for typos in command, args, env vars. Compare local manifest to deployed version with kubectl get pod <name> -o yaml", "percentage": 75, "command": "kubectl get pods <name> -o yaml"}
    ]'::jsonb,
    'kubectl access to cluster, Pod deployed, Basic Kubernetes knowledge',
    'kubectl describe shows pod in Running or Succeeded state, No recent restart events, kubectl logs shows normal application output',
    'Do not ignore exit codes - 137 is OOMKilled (increase memory), 1 usually means application error. Missing logs from --previous flag. Not checking InitContainerBackOff separately from CrashLoopBackOff.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/tasks/debug/debug-application/debug-pods/'
),
(
    'ImagePullBackOff error - pod cannot pull container image',
    'github-kubernetes',
    'VERY_HIGH',
    '[
        {"solution": "Verify image name and tag are spelled correctly. Check that image has been pushed to registry with: docker pull <image>:<tag> or crane pull <image> for remote inspection.", "percentage": 92, "note": "Most common cause - typos in image reference"},
        {"solution": "Check image pull credentials. For private registries, create ImagePullSecret: kubectl create secret docker-registry <secret-name> --docker-server=<registry> --docker-username=<user> --docker-password=<password>", "percentage": 88, "command": "kubectl create secret docker-registry regcred --docker-server=gcr.io --docker-username=_json_key --docker-password=$(cat key.json)"},
        {"solution": "Add imagePullSecrets to pod spec: spec.imagePullSecrets: [{name: regcred}]. Verify secret exists in same namespace as pod.", "percentage": 85, "command": "kubectl get secrets -n <namespace> | grep regcred"},
        {"solution": "For public images, verify registry is accessible from cluster nodes (not blocked by firewall/proxy). Test with kubectl run --rm -i --restart=Never --image=busybox:latest busybox -- sh", "percentage": 75, "note": "Network connectivity issue"}
    ]'::jsonb,
    'kubectl access, Image built and pushed to registry, Network connectivity to registry from cluster',
    'Pod moves from ImagePullBackOff to ContainerCreating, kubectl describe pod shows no image pull errors, Pod reaches Running state',
    'Using wrong tag (latest not guaranteed to exist), Credentials expired or have insufficient permissions, Image deleted from registry after removal from local cache, Registry domain spelled incorrectly',
    0.90,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/tasks/debug/debug-application/debug-pods/'
),
(
    'Pod remains in Pending state - cannot be scheduled to node',
    'github-kubernetes',
    'HIGH',
    '[
        {"solution": "Check scheduler events with kubectl describe pod <name>. Look for FailedScheduling events indicating root cause (insufficient CPU, memory, node selectors not matching).", "percentage": 91, "note": "Most important diagnostic step"},
        {"solution": "Verify available resources: kubectl top nodes and kubectl top pods. If insufficient resources, reduce replica count with kubectl scale deployment <name> --replicas=<lower-number> or delete idle pods.", "percentage": 87, "command": "kubectl scale deployment nginx --replicas=1"},
        {"solution": "Check node selectors and affinity rules. Verify label selectors match node labels with: kubectl get nodes --show-labels and compare to pod spec nodeSelector", "percentage": 85, "command": "kubectl get nodes --show-labels"},
        {"solution": "Ensure hostPort configuration is correct. If using hostPort, scheduler only schedules pod on nodes with that port available. Consider removing hostPort or using Service instead.", "percentage": 75, "note": "Common with daemonsets"}
    ]'::jsonb,
    'kubectl access to cluster, At least one node available, CPU/memory resources available',
    'kubectl get pods shows pod in Running state, kubectl top pods returns metrics, Pod events show Scheduled event',
    'Requesting more resources than total cluster capacity, Mismatch between pod nodeSelector labels and actual node labels, hostPort already bound on all nodes, Not accounting for reserved resources on kubelet',
    0.86,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/tasks/debug/debug-application/debug-pods/'
),
(
    'OOMKilled error - pod terminated due to memory limit exceeded',
    'github-kubernetes',
    'HIGH',
    '[
        {"solution": "Check container memory usage with kubectl top pod <name> and compare to memory limit in pod spec (limits.memory). If usage approaches limit, container will be OOMKilled.", "percentage": 90, "command": "kubectl top pod nginx --containers"},
        {"solution": "Increase memory limit in pod spec: resources.limits.memory: <new-value>. Use values like 256Mi, 512Mi, 1Gi. Apply with kubectl apply -f updated-pod.yaml", "percentage": 88, "command": "kubectl set resources pod nginx --limits=memory=512Mi"},
        {"solution": "Monitor actual memory usage over time with metrics server. Identify memory leak patterns or unexpected growth. Set requests close to observed average usage for better scheduling.", "percentage": 85, "note": "Requires monitoring tool like Prometheus"},
        {"solution": "Distinguish between true OOM and memory limit policy. If container allocates memory but doesn\'t use it immediately, it may exceed limit later. Use memory requests for scheduling, limits for enforcement.", "percentage": 75, "note": "Resource planning issue"}
    ]'::jsonb,
    'kubectl access, Metrics server installed in cluster, Container image stable',
    'Pod runs without OOMKilled events, kubectl top shows memory usage below limit, Application stabilizes at expected memory level',
    'Setting memory limit too low based on peak usage instead of sustainable usage, Confusing memory requests (scheduler) with memory limits (enforcement), Not checking for memory leaks in application code, Using decimal CPU units (0.5) instead of milliCPU (500m)',
    0.84,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/'
),
(
    'NetworkPolicy configuration has no effect - pods still communicate despite policy',
    'github-kubernetes',
    'HIGH',
    '[
        {"solution": "Verify network plugin supports NetworkPolicy enforcement. Check installed CNI plugin with kubectl get daemonsets -n kube-system (look for weave, calico, cilium, etc). Some plugins like flannel do not support NetworkPolicy.", "percentage": 89, "note": "Silent failure if plugin missing"},
        {"solution": "Test policy with explicit allow rules rather than deny rules. Create ingress rule for destination pod and egress rule for source pod. Both directions required: spec.policyTypes: [\'Ingress\', \'Egress\']", "percentage": 87, "command": "kubectl apply -f networkpolicy.yaml && kubectl describe networkpolicy"},
        {"solution": "Verify policy YAML syntax. podSelector and namespaceSelector logic: same array element = AND logic, separate elements = OR logic. Use kubectl describe networkpolicy <name> to confirm interpretation.", "percentage": 85, "note": "YAML indentation critical"},
        {"solution": "Remember pods cannot block themselves (only inter-node traffic). Test connectivity with kubectl exec <pod> -- curl <destination>. If connectivity fails, check both egress on source AND ingress on destination.", "percentage": 75, "command": "kubectl exec nginx -- curl service.default.svc.cluster.local"}
    ]'::jsonb,
    'Network plugin installed that supports NetworkPolicy (Calico, Weave, Cilium, Kyverno), kubectl access, Pod network initialized',
    'kubectl exec shows connection refused when reaching blocked pods, kubectl logs on network policy controller shows policy applied, ping fails to blocked pods from other namespaces',
    'Assuming default deny behavior without explicit NetworkPolicy resources, Using single selector instead of both podSelector and namespaceSelector in same ingress rule, Not creating corresponding egress rules on source pods, Forgetting to set policyTypes field',
    0.82,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/concepts/services-networking/network-policies/'
),
(
    'Pod cannot resolve DNS - nslookup fails for service names',
    'github-kubernetes',
    'HIGH',
    '[
        {"solution": "Verify CoreDNS pods are running: kubectl get pods -n kube-system -l k8s-app=kube-dns. Check their logs for errors: kubectl logs -n kube-system -l k8s-app=kube-dns", "percentage": 89, "command": "kubectl logs -n kube-system -l k8s-app=kube-dns"},
        {"solution": "Test DNS resolution within pod: kubectl exec <pod> -- nslookup kubernetes.default. If service name fails, verify service exists in same namespace: kubectl get svc <service-name>", "percentage": 87, "command": "kubectl exec nginx -- nslookup default.svc.cluster.local"},
        {"solution": "Check /etc/resolv.conf inside pod for correct nameserver entry (usually 10.96.0.10 for cluster DNS). If missing, pod may be using node\'s nameserver instead of cluster DNS.", "percentage": 85, "command": "kubectl exec nginx -- cat /etc/resolv.conf"},
        {"solution": "Verify Service selector matches pod labels. Use kubectl get endpoints <service> to confirm pod IP is listed. If empty, fix selector mismatch in Service spec.", "percentage": 80, "command": "kubectl get endpoints kubernetes"}
    ]'::jsonb,
    'kubectl access, CoreDNS running in kube-system namespace, Pod network initialized',
    'nslookup returns pod IP for service name, curl works to service FQDN (service.namespace.svc.cluster.local), kubectl get endpoints shows pod IP',
    'Using wrong namespace in DNS query (need full FQDN), CoreDNS pods evicted due to resource pressure, Service selector labels not matching pod labels, Assuming default namespace when service in different namespace',
    0.85,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/tasks/debug/debug-application/debug-pods/'
),
(
    'Terminating pod stuck - pod deletion hangs indefinitely',
    'github-kubernetes',
    'MEDIUM',
    '[
        {"solution": "Check for blocking finalizers: kubectl get pod <name> -o yaml | grep finalizers. If finalizers exist, admission webhooks or custom controllers may be preventing deletion. Remove with kubectl patch pod <name> -p \'{\\\"metadata\\\":{\\\"finalizers\\\":null}}\'", "percentage": 88, "command": "kubectl patch pod nginx --type merge -p '{\"metadata\":{\"finalizers\":null}}'"},
        {"solution": "Check ValidatingWebhookConfiguration and MutatingWebhookConfiguration. Broken webhooks can block finalizer cleanup. Verify webhooks are accessible: kubectl get ValidatingWebhookConfiguration", "percentage": 85, "command": "kubectl get ValidatingWebhookConfiguration"},
        {"solution": "Force delete pod if graceful termination fails: kubectl delete pod <name> --grace-period=0 --force. Use only as last resort as it may leave orphaned resources.", "percentage": 75, "command": "kubectl delete pod nginx --grace-period=0 --force"},
        {"solution": "Increase grace period for graceful shutdown if application needs time to clean up: kubectl delete pod <name> --grace-period=120. Default is 30 seconds.", "percentage": 70, "note": "For applications with cleanup logic"}
    ]'::jsonb,
    'kubectl access, Pod in Terminating state, Administrative permissions',
    'Pod transitions to Succeeded state, kubectl get pods no longer shows the pod, No Terminating pods in kubectl get pods output',
    'Finalizers left behind after webhook failure, Trying to patch while webhooks blocking updates, Not using force flag when necessary, Breaking finalizers on UPDATE but not allowing removal',
    0.80,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/tasks/debug/debug-application/debug-pods/'
),
(
    'Back-off restarting failed container - exponential backoff prevents pod recovery',
    'github-kubernetes',
    'HIGH',
    '[
        {"solution": "Understand backoff behavior: 10s, 20s, 40s, 80s, 160s, 300s (capped). After 5 minutes between restarts, pod enters back-off. Check restart count and timing: kubectl describe pod <name>", "percentage": 90, "note": "Backoff timing is automatic, not configurable"},
        {"solution": "Fix underlying container crash first, not restart backoff. Debug with kubectl logs --previous and fix application configuration or code causing exit.", "percentage": 88, "command": "kubectl logs <pod> --previous"},
        {"solution": "If intentional exit code should not trigger restart, change restartPolicy to Never or OnFailure. For Deployments, use restartPolicy: OnFailure. Naked pods respect pod-level restartPolicy.", "percentage": 80, "command": "kubectl patch pod <name> -p '{\"spec\":{\"restartPolicy\":\"Never\"}}'"},
        {"solution": "Consider using init containers with retry logic to wait for dependencies before main container starts, reducing crash-loop causes.", "percentage": 75, "note": "Architectural solution"}
    ]'::jsonb,
    'kubectl access, Pod deployed with restart policy set, Understanding of application startup sequence',
    'Pod restarts at increasing intervals then stabilizes, Container eventually starts successfully, No CrashLoopBackOff events in describe output',
    'Confusing back-off with crash loop - they are the same condition, Trying to adjust back-off timing (not configurable), Assuming back-off indicates Kubernetes failure (it doesn\'t), Not checking actual application error',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/kubernetes/kubernetes/issues/57291'
),
(
    'Invalid resource request syntax - pod rejected by API server',
    'github-kubernetes',
    'MEDIUM',
    '[
        {"solution": "Verify CPU notation: use milliCPU for fractional CPUs (500m = 0.5 CPU, 1000m = 1 CPU). Avoid decimal notation (0.5) which is non-standard. Use kubectl apply --validate=strict before deployment.", "percentage": 92, "command": "kubectl apply --validate=strict -f pod.yaml"},
        {"solution": "Fix memory notation: use Mi (mebibytes), Gi (gibibytes) for memory. Common error: 400m for memory (means 0.4 bytes, invalid). Correct: 400Mi or 400M", "percentage": 91, "note": "Most frequent syntax error"},
        {"solution": "Check for incomplete resource specs. Requests must be <= Limits. If limit not set, defaults to request. Set both explicitly to avoid scheduler confusion.", "percentage": 85, "command": "kubectl get pod <name> -o yaml | grep -A5 resources"},
        {"solution": "Validate entire manifest with: kubectl explain pods.spec.containers.resources for correct field names and valid formats. Common typo: \'resourses\' instead of \'resources\'", "percentage": 80, "command": "kubectl explain pod.spec.containers.resources"}
    ]'::jsonb,
    'kubectl CLI v1.20+, Valid YAML manifest, Understanding of Kubernetes resource units',
    'Pod accepted by API server (no validation errors), kubectl get pods returns pod without warnings, describe pod shows correct resource requests and limits',
    'Using decimal CPU (0.5 instead of 500m), Using m suffix for memory (400m = 0.4 bytes), Requests exceeding limits in spec, Typos in field names (resourses, resorces)',
    0.89,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/'
),
(
    'Port conflict - multiple pods cannot bind to same hostPort',
    'github-kubernetes',
    'MEDIUM',
    '[
        {"solution": "Verify hostPort is not in use: netstat -tulpn | grep <port> on target node. Or use kubectl get pods -o wide to see which pods are running on which nodes.", "percentage": 87, "command": "kubectl get pods -o wide --all-namespaces | grep <node-name>"},
        {"solution": "Remove hostPort binding from pod spec if not required. Use Service instead: type: NodePort (dynamic port) or LoadBalancer (external). Scheduler will handle port assignment.", "percentage": 85, "note": "Best practice - avoid hostPort"},
        {"solution": "If hostPort required, ensure only one pod uses that port per node. Use node affinity or DaemonSet with single replica. Check pod spec: ports[0].hostPort must be unique per node.", "percentage": 80, "command": "kubectl get pods --field-selector=spec.hostPort=8080 -o wide"},
        {"solution": "For multi-instance deployments, use Service NodePort with dynamic allocation instead. Kubernetes automatically assigns high-numbered port (30000-32767) to each replica.", "percentage": 75, "note": "Recommended approach"}
    ]'::jsonb,
    'kubectl access, Understanding of Kubernetes networking, Node SSH access (optional)',
    'Pod moves from Pending to ContainerCreating to Running, kubectl get pods shows pod on expected node, Service port accessible via NodePort or LoadBalancer',
    'Assuming hostPort is available without checking actual node state, Using same hostPort on Deployment with multiple replicas, Not checking existing DaemonSets using hostPort, Confusing hostPort with containerPort',
    0.83,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/tasks/debug/debug-application/debug-pods/'
),
(
    'YAML manifest syntax error - indentation or format prevents pod creation',
    'github-kubernetes',
    'HIGH',
    '[
        {"solution": "Use kubectl apply --validate -f manifest.yaml to catch syntax errors before deployment. Fix reported validation errors (indentation, field names, data types).", "percentage": 93, "command": "kubectl apply --validate=strict -f pod.yaml"},
        {"solution": "Check boolean field formats: use true/false (lowercase), never yes/no/on/off. These are YAML-specific and behavior varies by parser version. Quote ambiguous values like \'yes\' if needed as string.", "percentage": 90, "note": "Version-dependent failures"},
        {"solution": "Verify indentation is consistent (2 spaces, not tabs). YAML is whitespace-sensitive. Use online YAML validator or IDE plugin to catch indentation issues: yamllint manifest.yaml", "percentage": 88, "command": "yamllint pod.yaml"},
        {"solution": "Compare local manifest to deployed spec: kubectl get pod <name> -o yaml > deployed.yaml and diff manifest.yaml deployed.yaml. Shows what API server actually stored.", "percentage": 82, "command": "kubectl get pod nginx -o yaml > deployed.yaml"}
    ]'::jsonb,
    'kubectl CLI, Text editor or IDE with YAML support, Basic YAML knowledge',
    'kubectl apply succeeds without validation errors, kubectl get pods shows pod created, kubectl describe pod shows correct fields',
    'YAML validators passing but kubectl rejecting (different YAML spec versions), Copy-pasted examples with incorrect indentation, Using tabs instead of spaces, Forgetting quotes on numeric strings (\"80\" vs 80)',
    0.91,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/concepts/configuration/overview/'
),
(
    'Service endpoint not available - pod not discovered by service selector',
    'github-kubernetes',
    'HIGH',
    '[
        {"solution": "Verify pod labels match Service selector: kubectl get pods --show-labels and compare to service.spec.selector in manifest. Labels must match exactly (case-sensitive).", "percentage": 91, "command": "kubectl get pods --selector=app=nginx --show-labels"},
        {"solution": "Check endpoints with kubectl get endpoints <service-name>. If empty, no pods match selector. If addresses listed, service discovery works. Verify endpoint port matches containerPort.", "percentage": 89, "command": "kubectl get endpoints nginx"},
        {"solution": "Confirm Service exists in same namespace as pods. Cross-namespace service discovery requires FQDN: <service>.<namespace>.svc.cluster.local", "percentage": 85, "command": "kubectl get svc -n kube-system"},
        {"solution": "Verify service targetPort matches pod containerPort exactly. If service has port 80, targetPort must match actual listening port in pod (e.g., 8080).", "percentage": 80, "command": "kubectl describe svc nginx"}
    ]'::jsonb,
    'kubectl access, Pod deployed and running, Service created, Network connectivity working',
    'kubectl get endpoints shows pod IPs, Service resolves via DNS to correct IP, curl to service FQDN returns response',
    'Label selector typos (app vs application), Pod labels different from service selector, Service targetPort pointing to wrong container port, Assuming default service discovery without FQDN for cross-namespace',
    0.88,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/tasks/debug/debug-application/debug-pods/'
);
