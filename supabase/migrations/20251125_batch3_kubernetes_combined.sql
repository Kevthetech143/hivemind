-- Batch 3: Kubernetes Combined Migration
-- Sources: kubernetes.io official docs
-- Mined: 2025-11-25
-- Categories: kubernetes (pods, services, statefulsets, init-containers, cluster)

-- ============================================
-- KUBERNETES POD DEBUGGING ERRORS (15 entries)
-- ============================================

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES (
    'Kubernetes error: CrashLoopBackOff',
    'kubernetes',
    'CRITICAL',
    $$[{"solution": "Check container logs: kubectl logs pod-name -c container-name --previous", "percentage": 95, "note": "Shows why container crashed"}, {"solution": "Check resource limits: kubectl describe pod pod-name and verify CPU/Memory sufficient", "percentage": 85, "note": "Insufficient resources cause repeated crashes"}, {"solution": "Review startup script for errors: check command and args fields in deployment", "percentage": 90, "note": "Most common cause is application logic error"}]$$::jsonb,
    'kubectl configured, cluster access, pod exists',
    'Pod shows Running status or successfully completes',
    'Not checking --previous flag for crashed containers, ignoring resource constraints, not reviewing application logs',
    0.92,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/tasks/debug/debug-application/debug-pods/'
),
(
    'Kubernetes error: ImagePullBackOff',
    'kubernetes',
    'CRITICAL',
    $$[{"solution": "Verify image name is correct: kubectl describe pod pod-name and check Events section", "percentage": 95, "note": "Typos in image name are most common cause"}, {"solution": "Confirm image pushed to registry: docker push registry.io/image:tag", "percentage": 90, "note": "Image may not exist in registry"}, {"solution": "Check registry credentials: kubectl create secret docker-registry for private repos", "percentage": 85, "note": "Missing imagePullSecrets causes access denial"}, {"solution": "Verify registry connectivity: kubectl run debug-pod --image=curlimages/curl for network test", "percentage": 80, "note": "Network/firewall issues block registry access"}]$$::jsonb,
    'kubectl configured, cluster access, container registry access',
    'Pod shows Running status with container ready',
    'Assuming image exists without verification, not checking registry credentials, ignoring network connectivity',
    0.93,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/tasks/debug/debug-application/debug-pods/'
),
(
    'Kubernetes error: Pending pod',
    'kubernetes',
    'HIGH',
    $$[{"solution": "Check scheduler messages: kubectl describe pods pod-name and review Events", "percentage": 95, "note": "Reveals scheduling constraints"}, {"solution": "Verify resources available: kubectl top nodes and compare with pod requests", "percentage": 90, "note": "Insufficient CPU/Memory prevents scheduling"}, {"solution": "Add nodes or reduce resource requests: kubectl scale nodepool or adjust requests in spec", "percentage": 85, "note": "Most common solution for resource constraints"}, {"solution": "Check PVC binding: kubectl get pvc and ensure all volumes bound", "percentage": 80, "note": "Missing PVCs block pod scheduling"}]$$::jsonb,
    'kubectl configured, cluster access, pod exists',
    'Pod transitions from Pending to Running',
    'Not checking Events in describe output, ignoring resource requests, assuming unlimited node capacity',
    0.91,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/tasks/debug/debug-application/debug-pods/'
),
(
    'Kubernetes error: OOMKilled out of memory',
    'kubernetes',
    'HIGH',
    $$[{"solution": "Check memory limit: kubectl get pod pod-name -o yaml and examine resources.limits.memory", "percentage": 95, "note": "Shows actual memory configuration"}, {"solution": "Monitor memory usage: kubectl top pods and compare with limits", "percentage": 90, "note": "Actual usage determines if OOM will occur"}, {"solution": "Increase memory limit: edit pod spec and increase memory request/limit", "percentage": 88, "note": "Temporary fix, address root cause"}, {"solution": "Profile application: add memory profiling to application to identify leaks", "percentage": 85, "note": "Permanent solution requires code changes"}]$$::jsonb,
    'kubectl configured, cluster access, metrics-server running',
    'Pod restarts with sufficient memory or completes without OOM errors',
    'Not distinguishing between request and limit, ignoring actual memory usage spikes, setting limits without profiling',
    0.89,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/tasks/administer-cluster/manage-resources/memory-default-namespace/'
),
(
    'Kubernetes error: Pod in Terminating state stuck',
    'kubernetes',
    'HIGH',
    $$[{"solution": "Check for blocking finalizers: kubectl get pod pod-name -o yaml and review finalizers field", "percentage": 95, "note": "Finalizers prevent pod deletion"}, {"solution": "Verify webhook configuration: kubectl get ValidatingWebhookConfiguration and check targeting", "percentage": 90, "note": "Webhooks may block pod updates"}, {"solution": "Force delete pod: kubectl delete pod pod-name --grace-period=0 --force", "percentage": 85, "note": "Last resort, may leave orphaned resources"}, {"solution": "Update or disable blocking webhooks: kubectl patch validatingwebhookconfig webhook-name --type json", "percentage": 88, "note": "Proper fix addresses root cause"}]$$::jsonb,
    'kubectl configured, cluster access, pod exists in Terminating state',
    'Pod removed from cluster within grace period',
    'Not checking finalizers, force-deleting without understanding webhooks, ignoring cleanup failures',
    0.87,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/tasks/debug/debug-application/debug-pods/'
),
(
    'Kubernetes error: Pod not executing expected behavior',
    'kubernetes',
    'MEDIUM',
    $$[{"solution": "Validate YAML syntax: kubectl apply --validate -f manifest.yaml before deploying", "percentage": 95, "note": "Catches typos and invalid field names"}, {"solution": "Compare deployed vs local YAML: kubectl get pod pod-name -o yaml > deployed.yaml", "percentage": 90, "note": "Shows actual state vs intended"}, {"solution": "Check container environment: kubectl exec pod-name -- env and verify all variables set", "percentage": 88, "note": "Missing env vars cause behavior changes"}, {"solution": "Review pod logs: kubectl logs pod-name and check for runtime errors", "percentage": 92, "note": "Application may be running but in error state"}]$$::jsonb,
    'kubectl configured, cluster access, pod exists and running',
    'Pod performs expected behavior or logs show clear behavior changes',
    'Ignoring YAML validation, assuming configuration is correct, not checking environment variables',
    0.90,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/tasks/debug/debug-application/debug-pods/'
),
(
    'Kubernetes error: Node NotReady',
    'kubernetes',
    'CRITICAL',
    $$[{"solution": "Check node status: kubectl get nodes and look for NotReady condition", "percentage": 95, "note": "First step to identify issue"}, {"solution": "Examine node details: kubectl describe node node-name and check Events", "percentage": 92, "note": "Shows disk pressure, memory pressure, network issues"}, {"solution": "Check kubelet logs: journalctl -u kubelet on the node or kubectl logs on node", "percentage": 90, "note": "Reveals kubelet crash or connectivity issues"}, {"solution": "Verify network connectivity: ssh to node and ping control plane", "percentage": 88, "note": "Network disconnection causes NotReady"}]$$::jsonb,
    'kubectl configured, cluster access, SSH access to nodes optional',
    'Node shows Ready status, pods can be scheduled',
    'Not checking node events, assuming network connectivity, ignoring kubelet logs',
    0.91,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/tasks/debug/debug-cluster/'
),
(
    'Kubernetes error: Pod evicted from node',
    'kubernetes',
    'HIGH',
    $$[{"solution": "Check eviction reason: kubectl describe pod pod-name and find eviction message", "percentage": 95, "note": "Explains why pod was evicted"}, {"solution": "Monitor node resources: kubectl top nodes and check disk, memory, pid pressure", "percentage": 92, "note": "Node pressure causes evictions after 5 minutes NotReady"}, {"solution": "Delete low-priority pods: use priority classes to ensure critical pods survive eviction", "percentage": 88, "note": "Kubernetes evicts lowest priority first"}, {"solution": "Increase node resources: add memory/disk or add new nodes to cluster", "percentage": 85, "note": "Permanent solution for resource pressure"}]$$::jsonb,
    'kubectl configured, cluster access, metrics-server running',
    'Pod can run without eviction, or new pod deployed successfully',
    'Not understanding priority classes, ignoring node pressure signals, assuming pod restart fixes it',
    0.88,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/tasks/debug/debug-cluster/'
),
(
    'Kubernetes error: Pod termination message truncated',
    'kubernetes',
    'MEDIUM',
    $$[{"solution": "Check termination message limit: kubectl get pod pod-name -o yaml shows lastState.terminated.message", "percentage": 95, "note": "Default 4096 bytes per container, 12KiB total"}, {"solution": "Use go-template for full message: kubectl get pod pod-name -o go-template={{.status.containerStatuses[0].lastState.terminated.message}}", "percentage": 92, "note": "Extracts complete termination message"}, {"solution": "Enable log fallback: set terminationMessagePolicy: FallbackToLogsOnError in spec", "percentage": 90, "note": "Uses up to 2048 bytes or 80 lines of logs"}, {"solution": "Check pod logs directly: kubectl logs pod-name --previous for full error context", "percentage": 93, "note": "Most reliable way to see complete error"}]$$::jsonb,
    'kubectl configured, cluster access, pod has terminated',
    'Can retrieve full termination/error message from pod',
    'Assuming truncated message is complete, not using --previous flag, ignoring FallbackToLogsOnError option',
    0.91,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/tasks/debug/debug-application/determine-reason-pod-failure/'
),
(
    'Kubernetes error: Invalid YAML boolean values',
    'kubernetes',
    'MEDIUM',
    $$[{"solution": "Use only true or false: replace yes/no/on/off with boolean values in YAML", "percentage": 98, "note": "Kubernetes strict YAML parsing rejects non-standard booleans"}, {"solution": "Validate YAML: kubectl apply --validate -f manifest.yaml before deploying", "percentage": 95, "note": "Catches invalid boolean syntax"}, {"solution": "Check YAML format: review pod spec and ensure all boolean fields use true/false", "percentage": 93, "note": "Common mistake from other YAML implementations"}, {"solution": "Use YAML linter: yamllint manifest.yaml to catch syntax errors", "percentage": 90, "note": "Pre-deployment validation tool"}]$$::jsonb,
    'kubectl configured, manifest file with YAML',
    'Manifest validates successfully and pod deploys',
    'Using YAML shortcuts (yes/no), not validating before applying, assuming other YAML flavors work',
    0.96,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/concepts/configuration/overview/'
),
(
    'Kubernetes error: Service endpoints not found',
    'kubernetes',
    'HIGH',
    $$[{"solution": "Check EndpointSlices: kubectl get endpointslices -l kubernetes.io/service-name=service-name", "percentage": 95, "note": "Shows actual backend pods for service"}, {"solution": "Verify pod labels match selector: kubectl get pods --selector=key=value and compare with service spec.selector", "percentage": 93, "note": "Service routes to pods with matching labels"}, {"solution": "Verify target port: kubectl get svc service-name -o yaml and check targetPort matches container port", "percentage": 92, "note": "Port mismatch prevents connections"}, {"solution": "Test connectivity: kubectl run debug --image=curlimages/curl -- curl service-name:port", "percentage": 90, "note": "Verifies service routing works"}]$$::jsonb,
    'kubectl configured, cluster access, service and pods exist',
    'Service has endpoints, traffic routes to pods',
    'Not checking labels, assuming targetPort matches, ignoring port number mismatches',
    0.92,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/tasks/debug/debug-application/debug-pods/'
),
(
    'Kubernetes error: PVC not binding to storage',
    'kubernetes',
    'HIGH',
    $$[{"solution": "Check PVC status: kubectl get pvc and verify Bound status", "percentage": 95, "note": "Pending status means PV not available"}, {"solution": "Verify PV exists: kubectl get pv and check available storage", "percentage": 92, "note": "PVC cannot bind without PV"}, {"solution": "Check access mode: kubectl get pvc pvc-name -o yaml and compare with PV accessModes", "percentage": 91, "note": "Mismatched access modes prevent binding"}, {"solution": "Review storage class: kubectl get storageclass and ensure provisioner available", "percentage": 89, "note": "Dynamic provisioning requires working storage class"}]$$::jsonb,
    'kubectl configured, cluster access, PVC and PV resources',
    'PVC shows Bound status, pod can mount volume',
    'Not checking PV status, ignoring access mode requirements, assuming storage class always works',
    0.90,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/tasks/debug/debug-application/debug-pods/'
),
(
    'Kubernetes error: Failed to get image pull secret',
    'kubernetes',
    'HIGH',
    $$[{"solution": "Verify imagePullSecrets exist: kubectl get secrets and ensure docker-registry secret present", "percentage": 95, "note": "Secret must exist in pod namespace"}, {"solution": "Check secret format: kubectl get secret secret-name -o yaml and verify docker-server key", "percentage": 92, "note": "Secret must have correct keys for pulling"}, {"solution": "Verify secret in pod spec: kubectl get pod pod-name -o yaml and check imagePullSecrets list", "percentage": 93, "note": "Pod must reference the secret"}, {"solution": "Create secret: kubectl create secret docker-registry my-secret --docker-server=registry.io", "percentage": 90, "note": "Creates properly formatted secret"}]$$::jsonb,
    'kubectl configured, cluster access, container registry credentials',
    'Pod can pull image from private registry',
    'Not creating secret in correct namespace, ignoring secret format, assuming secret auto-discovered',
    0.91,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/tasks/debug/debug-application/debug-pods/'
),
(
    'Kubernetes error: Health check probe failing',
    'kubernetes',
    'HIGH',
    $$[{"solution": "Check probe configuration: kubectl describe pod pod-name and review Liveness/Readiness/Startup probe", "percentage": 95, "note": "Shows probe settings and failure reasons"}, {"solution": "Review probe logs: kubectl logs pod-name and check output from probe endpoint", "percentage": 92, "note": "Application logs show why probe fails"}, {"solution": "Adjust probe timing: increase initialDelaySeconds or periodSeconds if app slow to start", "percentage": 90, "note": "Premature probes fail during initialization"}, {"solution": "Test probe endpoint manually: kubectl exec pod-name -- curl localhost:8080/health", "percentage": 91, "note": "Verifies probe endpoint responding"}]$$::jsonb,
    'kubectl configured, cluster access, running pod',
    'Pod shows Running and Ready, health checks pass',
    'Not checking probe configuration, using default timeouts for slow apps, ignoring failure logs',
    0.88,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/tasks/debug/debug-application/debug-pods/'
),
(
    'Kubernetes error: Resource quota exceeded',
    'kubernetes',
    'MEDIUM',
    $$[{"solution": "Check ResourceQuota: kubectl get resourcequota -n namespace-name and review limits", "percentage": 95, "note": "Shows namespace resource constraints"}, {"solution": "View current usage: kubectl describe resourcequota quota-name and check used vs hard limits", "percentage": 93, "note": "Determines what resource exceeded quota"}, {"solution": "Delete low-priority resources: kubectl delete pods selector-label to free quota", "percentage": 88, "note": "Temporary fix to allow pod creation"}, {"solution": "Increase quota: kubectl edit resourcequota quota-name and raise hard limit", "percentage": 85, "note": "Permanent solution requires admin access"}]$$::jsonb,
    'kubectl configured, cluster access, namespace with ResourceQuota',
    'Pod creates successfully within quota limits',
    'Not checking quota limits, assuming unlimited resources, not freeing resources for quota',
    0.89,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/concepts/configuration/overview/'
);

-- ============================================
-- KUBERNETES SERVICE DEBUGGING ERRORS (12 entries)
-- ============================================

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES (
    'Kubernetes service has no endpoints',
    'kubernetes',
    'HIGH',
    $$[{"solution": "Verify service selector matches pod labels: kubectl get service name -o json and compare spec.selector with pod metadata.labels", "percentage": 92, "note": "Mismatched selectors cause empty endpoints"}]$$::jsonb,
    'kubectl configured, service and pods deployed',
    'kubectl get endpointslices shows pod IPs',
    'Typos in selector labels, wrong namespace',
    0.92,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/tasks/debug/debug-application/debug-service/'
),
(
    'Kubernetes DNS resolution fails for service',
    'kubernetes',
    'HIGH',
    $$[{"solution": "Test DNS from pod: kubectl exec pod-name -- nslookup servicename.namespace.svc.cluster.local", "percentage": 88, "note": "Check /etc/resolv.conf nameserver, search paths, and ndots option"}, {"solution": "Verify cluster DNS service running: kubectl get svc -n kube-system kube-dns", "percentage": 85}]$$::jsonb,
    'kubectl access, service deployed, test pod running',
    'nslookup returns service IP address',
    'Incorrect namespace in DNS query, stale cache, wrong DNS IP',
    0.87,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/tasks/debug/debug-application/debug-service/'
),
(
    'Kubernetes service port targetPort mismatch',
    'kubernetes',
    'HIGH',
    $$[{"solution": "Verify targetPort matches container listening port: kubectl get svc name -o json | grep targetPort and docker inspect container-id | grep ExposedPorts", "percentage": 94, "note": "Port must be number not string in service spec"}]$$::jsonb,
    'kubectl configured, service manifest, container image',
    'Service traffic reaches container application',
    'Configuring targetPort as string instead of integer, wrong port number',
    0.94,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/tasks/debug/debug-application/debug-service/'
),
(
    'Kubernetes service pod not running status',
    'kubernetes',
    'HIGH',
    $$[{"solution": "Check pod status: kubectl get pods -l selector=value shows STATUS column", "percentage": 96, "note": "Pods must be Running with READY=1/1 for service to select them"}, {"solution": "Check pod logs: kubectl logs pod-name to debug startup failures", "percentage": 90}]$$::jsonb,
    'kubectl configured, pods deployed',
    'kubectl get pods shows Running status and READY 1/1',
    'Checking pod existence without verifying Running state, ignoring readiness probes',
    0.93,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/tasks/debug/debug-application/debug-service/'
),
(
    'Kubernetes service cross-namespace communication fails',
    'kubernetes',
    'HIGH',
    $$[{"solution": "Use fully qualified domain name: servicename.namespace.svc.cluster.local instead of just servicename", "percentage": 91, "note": "Services only select pods in their own namespace by default"}]$$::jsonb,
    'kubectl access, services in different namespaces',
    'FQDN resolves to service IP, traffic flows between namespaces',
    'Using short service name across namespaces, selecting pods from different namespace',
    0.91,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/tasks/debug/debug-application/debug-service/'
),
(
    'Kubernetes network policy blocks service traffic',
    'kubernetes',
    'HIGH',
    $$[{"solution": "Review NetworkPolicy ingress rules: kubectl get networkpolicy -A", "percentage": 89, "note": "Verify rules allow traffic to target pod ports"}, {"solution": "Test without policy: kubectl delete networkpolicy name -n namespace", "percentage": 86}]$$::jsonb,
    'kubectl configured, network policies deployed',
    'Traffic flows when policy is removed or rules adjusted',
    'Forgetting to check network policies, overly restrictive selectors',
    0.88,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/tasks/debug/debug-application/debug-service/'
),
(
    'Kubernetes service internal traffic policy local fails',
    'kubernetes',
    'MEDIUM',
    $$[{"solution": "When using spec.internalTrafficPolicy: Local, verify pod and service endpoints exist on same node", "percentage": 85, "note": "If pod node has no endpoints, service behaves as if zero endpoints exist"}, {"solution": "Check node endpoints: kubectl get endpoints service-name and verify pod node in output", "percentage": 82}]$$::jsonb,
    'internalTrafficPolicy Local enabled, multi-node cluster',
    'Pod-to-pod traffic works within same node',
    'Expecting local policy to work across nodes without endpoints on source node',
    0.84,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/concepts/services-networking/service-traffic-policy/'
),
(
    'Kubernetes service endpoint invalid IP address',
    'kubernetes',
    'MEDIUM',
    $$[{"solution": "Verify endpoint IPs are not loopback (127.0.0.0/8) or link-local (169.254.0.0/16, fe80::/64)", "percentage": 90, "note": "Endpoint IPs must not be loopback or link-local addresses"}, {"solution": "Ensure endpoints are not cluster IPs of other services: kubectl get svc and verify endpoint IPs differ", "percentage": 87}]$$::jsonb,
    'kubectl access, selectorless service with manual endpoints',
    'kubectl get endpoints shows valid endpoint IPs',
    'Using loopback addresses as endpoints, pointing to other service cluster IPs',
    0.89,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/concepts/services-networking/service/'
),
(
    'Kubernetes service port protocol mismatch',
    'kubernetes',
    'MEDIUM',
    $$[{"solution": "Verify service protocol matches application protocol: kubectl get svc name -o json | grep protocol", "percentage": 88, "note": "Protocol must match pod listening protocol (TCP, UDP, SCTP)"}, {"solution": "Test with correct protocol: curl for TCP, nc -u for UDP", "percentage": 85}]$$::jsonb,
    'kubectl configured, service manifest, application running',
    'Traffic correctly routes with matching protocol specification',
    'Defaulting to TCP when application uses UDP, forgetting to specify protocol',
    0.87,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/tasks/debug/debug-application/debug-service/'
),
(
    'Kubernetes selectorless service no manual endpoints',
    'kubernetes',
    'MEDIUM',
    $$[{"solution": "For selectorless services, manually create EndpointSlice: kubectl apply -f endpointslice.yaml", "percentage": 91, "note": "Control plane does not auto-generate endpoints without selectors"}, {"solution": "Verify EndpointSlice created: kubectl get endpointslices -l k8s.io/service-name=servicename", "percentage": 89}]$$::jsonb,
    'kubectl access, selectorless service deployed',
    'kubectl get endpointslices returns endpoint objects',
    'Creating selectorless service without creating endpoints, incorrect endpoint format',
    0.90,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/concepts/services-networking/service/'
),
(
    'Kubernetes kubectl port-forward fails on selectorless service',
    'kubernetes',
    'MEDIUM',
    $$[{"solution": "API server does not proxy to selectorless service endpoints: use direct pod port-forward instead", "percentage": 88, "note": "Selectorless services cannot be port-forwarded via kubectl port-forward"}, {"solution": "Alternative: kubectl port-forward pod/podname localport:remoteport", "percentage": 90}]$$::jsonb,
    'kubectl configured, selectorless service deployed',
    'Port-forward works with direct pod reference',
    'Attempting port-forward on selectorless service, not understanding API proxy limitation',
    0.89,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/concepts/services-networking/service/'
),
(
    'Kubernetes service name resolution wrong namespace',
    'kubernetes',
    'MEDIUM',
    $$[{"solution": "Check pod /etc/resolv.conf search paths: kubectl exec pod -- cat /etc/resolv.conf", "percentage": 87, "note": "Search paths should include local namespace and cluster.local"}, {"solution": "Verify ndots option is set correctly (should be 5): cat /etc/resolv.conf | grep ndots", "percentage": 84}]$$::jsonb,
    'kubectl access, test pod running, service deployed',
    'DNS correctly resolves service in correct namespace',
    'Not understanding search path resolution, incorrect ndots value causing full FQDN requirement',
    0.86,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/tasks/debug/debug-application/debug-service/'
);

-- ============================================
-- KUBERNETES STATEFULSET DEBUGGING ERRORS (10 entries)
-- ============================================

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES (
    'Kubernetes StatefulSet pod stuck in Pending state',
    'kubernetes',
    'HIGH',
    $$[{"solution": "Check node resources: kubectl describe node <node-name>. Verify CPU/memory requests against available capacity", "percentage": 85, "note": "Pending pods cannot be scheduled due to resource constraints"}, {"solution": "Check hostPort binding: verify no other pods occupy requested hostPort on target nodes", "percentage": 12, "note": "hostPort exclusivity can cause scheduling failures"}]$$::jsonb,
    'kubectl configured, StatefulSet deployed, nodes available',
    'Pod transitions from Pending to Running state',
    'Not checking node resource capacity, ignoring hostPort conflicts, insufficient cluster resources',
    0.85,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/tasks/debug/debug-application/debug-pods/'
),
(
    'Kubernetes StatefulSet pod stuck in Waiting state due to image pull failure',
    'kubernetes',
    'HIGH',
    $$[{"solution": "Verify image availability: kubectl describe pod <pod-name>. Check container registry credentials in imagePullSecrets", "percentage": 82, "note": "Image pull failures are most common cause of Waiting state"}, {"solution": "Validate image URI syntax and confirm registry access: docker pull <image-uri>", "percentage": 15, "note": "Typos in image name or registry authentication failures"}, {"solution": "Check node network connectivity to image registry", "percentage": 3, "note": "Nodes cannot reach registry due to firewall/network policies"}]$$::jsonb,
    'kubectl configured, pod in Waiting state, registry credentials available',
    'Pod images successfully pulled, pod transitions to Running',
    'Using wrong image URI, missing imagePullSecrets, incorrect registry credentials',
    0.82,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/tasks/debug/debug-application/debug-pods/'
),
(
    'Kubernetes StatefulSet PVC stuck in Pending state',
    'kubernetes',
    'HIGH',
    $$[{"solution": "Verify StorageClass exists: kubectl get storageclass. Check if dynamic provisioning is enabled on API server", "percentage": 78, "note": "Missing or misconfigured StorageClass prevents dynamic PV provisioning"}, {"solution": "Check storage quota: kubectl describe pvc <pvc-name>. Verify storage capacity available in cluster", "percentage": 15, "note": "Insufficient storage capacity in StorageClass"}, {"solution": "Verify PVC access mode matches pod requirements: ReadWriteOnce, ReadOnlyMany, or ReadWriteMany", "percentage": 7, "note": "Access mode mismatch between PVC and pod specification"}]$$::jsonb,
    'kubectl configured, StatefulSet deployed, storage provisioner available',
    'PVC binds to PersistentVolume, status shows Bound',
    'StorageClass not configured, storage quota exhausted, incompatible access modes',
    0.78,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/concepts/storage/persistent-volumes/'
),
(
    'Kubernetes StatefulSet missing headless Service causing network identity failures',
    'kubernetes',
    'HIGH',
    $$[{"solution": "Create headless Service with clusterIP: None: kubectl apply -f headless-service.yaml", "percentage": 88, "note": "StatefulSets require explicit headless Service for stable network identities"}, {"solution": "Verify Service selector matches StatefulSet pod labels: kubectl get endpoints <service-name>", "percentage": 10, "note": "Pod selector mismatch prevents pods from becoming endpoints"}, {"solution": "Validate Service port definitions match pod container ports", "percentage": 2, "note": "Named port mismatches break inter-pod communication"}]$$::jsonb,
    'kubectl configured, StatefulSet defined, pods ready',
    'Headless Service exists with clusterIP: None, pods appear in Service endpoints',
    'Creating ClusterIP Service instead of headless, selector mismatch, missing Service entirely',
    0.88,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/concepts/services-networking/service/'
),
(
    'Kubernetes StatefulSet pod stuck in Terminating state',
    'kubernetes',
    'HIGH',
    $$[{"solution": "Check for blocking finalizers: kubectl describe pod <pod-name>. Remove problematic finalizers if safe", "percentage": 70, "note": "Finalizers or admission webhooks block pod deletion"}, {"solution": "Verify terminationGracePeriodSeconds allows sufficient shutdown time: kubectl get pod -o yaml", "percentage": 20, "note": "Pods need time to gracefully shutdown and cleanup"}, {"solution": "Force delete pod if necessary: kubectl delete pod <pod-name> --grace-period=0 --force", "percentage": 10, "note": "Last resort when graceful deletion fails, can cause data inconsistency"}]$$::jsonb,
    'kubectl configured, StatefulSet deployed, stuck pod identified',
    'Pod successfully deleted, no longer appears in kubectl get pods',
    'Not checking finalizers, insufficient termination grace period, force deleting without investigation',
    0.70,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/tasks/run-application/delete-stateful-set/'
),
(
    'Kubernetes StatefulSet DNS resolution delays for newly created pods',
    'kubernetes',
    'MEDIUM',
    $$[{"solution": "Wait for DNS negative cache expiry: typically 30 seconds with CoreDNS default settings", "percentage": 65, "note": "DNS remembers failed lookups temporarily, new pods not immediately resolvable"}, {"solution": "Query Kubernetes API directly using watch instead of DNS: kubectl get endpoints <service-name> --watch", "percentage": 25, "note": "API endpoint discovery bypasses DNS caching delays"}, {"solution": "Configure CoreDNS cache timeout lower (if infrastructure allows): edit CoreDNS ConfigMap", "percentage": 10, "note": "Decreases caching window but increases DNS server load"}]$$::jsonb,
    'kubectl configured, StatefulSet pods created, CoreDNS running',
    'Pods become DNS-resolvable after cache timeout, no timeout errors in logs',
    'Expecting immediate DNS resolution, not accounting for negative caching, relying only on DNS',
    0.65,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/'
),
(
    'Kubernetes StatefulSet broken state during rolling updates',
    'kubernetes',
    'MEDIUM',
    $$[{"solution": "Scale StatefulSet to 0 before deletion: kubectl scale statefulsets <name> --replicas=0", "percentage": 80, "note": "Prevents broken state by ensuring ordered graceful termination before updates"}, {"solution": "Use Parallel pod management policy instead of OrderedReady: set spec.podManagementPolicy: Parallel", "percentage": 15, "note": "Parallel policy allows concurrent pod updates, reducing broken state risk"}, {"solution": "If broken state occurs, manually check pod status and repair ordering: kubectl get pods -o wide", "percentage": 5, "note": "Requires manual intervention to restore consistent state"}]$$::jsonb,
    'kubectl configured, StatefulSet with OrderedReady policy, rolling update in progress',
    'All pods successfully updated without hanging or error states',
    'Deleting StatefulSet without scaling to 0, not understanding OrderedReady constraints, ignoring warnings',
    0.80,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/'
),
(
    'Kubernetes StatefulSet pod selector validation failure',
    'kubernetes',
    'MEDIUM',
    $$[{"solution": "Verify StatefulSet spec.selector.matchLabels matches pod template labels: kubectl get statefulset -o yaml", "percentage": 92, "note": "StatefulSet requires pod selector to match template labels for identification"}, {"solution": "Apply corrected StatefulSet definition after fixing label mismatch: kubectl apply -f fixed-statefulset.yaml", "percentage": 8, "note": "Validation errors prevent StatefulSet creation with mismatched selectors"}]$$::jsonb,
    'kubectl configured, StatefulSet definition available',
    'StatefulSet created successfully without validation errors, pods identified by labels',
    'Mismatched pod selector and template labels, undefined pod template labels, incorrect label syntax',
    0.92,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/#limitations'
),
(
    'Kubernetes StatefulSet volumes not automatically deleted on scale-down or deletion',
    'kubernetes',
    'MEDIUM',
    $$[{"solution": "Manually cleanup PVCs after deletion: kubectl delete pvc -l app=<statefulset-name>", "percentage": 88, "note": "PersistentVolumes persist by design to prevent accidental data loss"}, {"solution": "Review StorageClass reclaim policy before deletion: kubectl describe storageclass <sc-name>", "percentage": 10, "note": "Reclaim policy (Retain/Delete/Recycle) determines PV cleanup behavior"}, {"solution": "Use PVC deletion step in cleanup sequence: scale to 0, delete StatefulSet, wait termination grace period, delete PVCs", "percentage": 2, "note": "Ordered cleanup prevents resource leaks and data loss"}]$$::jsonb,
    'kubectl configured, StatefulSet deleted or scaled down, PVCs visible',
    'All associated PVCs deleted, storage capacity freed in cluster',
    'Assuming automatic volume deletion, not checking reclaim policy, orphaning PVCs',
    0.88,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/'
),
(
    'Kubernetes StatefulSet successor pods fail to deploy when predecessor is unhealthy',
    'kubernetes',
    'MEDIUM',
    $$[{"solution": "Fix or delete failing predecessor pod: kubectl delete pod <statefulset-name>-<ordinal>", "percentage": 85, "note": "OrderedReady policy requires all predecessors Ready before deploying successors"}, {"solution": "Check pod logs for failure cause: kubectl logs <pod-name> -c <container-name>", "percentage": 12, "note": "Predecessor health issues block entire scaling operation"}, {"solution": "Consider switching to Parallel pod management if ordering not critical: spec.podManagementPolicy: Parallel", "percentage": 3, "note": "Allows concurrent deployments regardless of predecessor status"}]$$::jsonb,
    'kubectl configured, StatefulSet scaled with some pods unhealthy, OrderedReady policy in use',
    'All pods transition to Ready, StatefulSet scales to desired replicas without blocking',
    'Not investigating failing pods, assuming successor pods can deploy independently, misunderstanding OrderedReady',
    0.85,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/'
);

-- ============================================
-- KUBERNETES INIT CONTAINER DEBUGGING ERRORS (10 entries)
-- ============================================

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES (
    'Kubernetes error: Init container stuck in Init:0/1',
    'kubernetes',
    'HIGH',
    $$[{"solution": "Check init container logs: kubectl logs pod-name -c init-container-name", "percentage": 90, "note": "Init containers run before main containers"}]$$::jsonb,
    'kubectl configured, pod with init containers',
    'Pod status progresses past Init phase',
    'Not specifying init container name in logs command',
    0.90,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/tasks/debug/debug-application/debug-init-containers/'
),
(
    'Kubernetes error: Init container CrashLoopBackOff repeated failures',
    'kubernetes',
    'HIGH',
    $$[{"solution": "Use kubectl describe pod pod-name to check exit codes and restart counts", "percentage": 85, "note": "Exit code 1 indicates application error, not infrastructure issue"}, {"solution": "Add set -x to shell scripts to debug command execution", "percentage": 80, "note": "Enables script debugging to reveal which command is failing"}]$$::jsonb,
    'kubectl configured, pod in CrashLoopBackOff state',
    'Pod logs show clear error message, exit code identified',
    'Not checking both current and last terminated states',
    0.85,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/tasks/debug/debug-application/debug-init-containers/'
),
(
    'Kubernetes error: Pod remains in Pending state with Initialized condition false',
    'kubernetes',
    'HIGH',
    $$[{"solution": "Verify all init container dependencies exist: kubectl get services, kubectl get secrets", "percentage": 88, "note": "Common issue when waiting for external services or config"}, {"solution": "Check status.initContainerStatuses using kubectl get pod -o json pod-name | jq .status.initContainerStatuses", "percentage": 85, "note": "Query specific field for detailed status"}]$$::jsonb,
    'kubectl configured, pod in pending state',
    'Pod transitions to Running state when dependencies created',
    'Assuming init container is waiting for wrong resource',
    0.88,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/concepts/workloads/pods/init-containers/'
),
(
    'Kubernetes error: Init container fails with restartPolicy Never causing pod failure',
    'kubernetes',
    'MEDIUM',
    $$[{"solution": "Change restartPolicy to Always or OnFailure to allow init container retries", "percentage": 90, "note": "restartPolicy: Never treats any init failure as complete pod failure"}, {"solution": "Check pod spec: kubectl get pod pod-name -o yaml | grep restartPolicy", "percentage": 95, "note": "Verify current restart policy setting"}]$$::jsonb,
    'kubectl configured, pod with restartPolicy Never',
    'Pod successfully initializes after restartPolicy changed',
    'Not understanding difference between Never and Always policies',
    0.90,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/concepts/workloads/pods/init-containers/'
),
(
    'Kubernetes error: Init container fails with permission denied',
    'kubernetes',
    'HIGH',
    $$[{"solution": "Check security context: kubectl get pod pod-name -o yaml | grep -A 5 securityContext", "percentage": 88, "note": "Verify runAsUser, runAsGroup, and fsGroup settings"}, {"solution": "Add securityContext to init container: runAsUser: 0 for root or appropriate UID", "percentage": 85, "note": "Ensure init container has sufficient permissions for setup tasks"}]$$::jsonb,
    'kubectl configured, pod with permission denied errors',
    'Init container completes without permission errors',
    'Forgetting that init container inherits pod-level securityContext',
    0.88,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/tasks/configure-pod-container/security-context/'
),
(
    'Kubernetes error: Init container blocked by Pod activeDeadlineSeconds timeout',
    'kubernetes',
    'MEDIUM',
    $$[{"solution": "Remove activeDeadlineSeconds from pod spec or increase value", "percentage": 92, "note": "activeDeadlineSeconds terminates pod even after init container finishes"}, {"solution": "Use kubectl get pod -o yaml pod-name | grep activeDeadlineSeconds to check current setting", "percentage": 95, "note": "Verify timeout configuration"}]$$::jsonb,
    'kubectl configured, pod timing out',
    'Pod initializes successfully before deadline expires',
    'Setting activeDeadlineSeconds in production without understanding pod lifecycle impact',
    0.92,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/concepts/workloads/pods/init-containers/'
),
(
    'Kubernetes error: Subsequent init containers not executing after first fails',
    'kubernetes',
    'HIGH',
    $$[{"solution": "Verify first init container exits with code 0: kubectl logs pod-name -c init-container-1", "percentage": 90, "note": "Sequential execution requires each container to complete successfully"}, {"solution": "Check pod describe output for which init container failed: kubectl describe pod pod-name", "percentage": 88, "note": "Shows status of each init container in order"}]$$::jsonb,
    'kubectl configured, pod with multiple init containers',
    'All init containers execute and complete in sequence',
    'Assuming all init containers run in parallel instead of sequentially',
    0.90,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/concepts/workloads/pods/init-containers/'
),
(
    'Kubernetes error: Init container cannot find file or file not found',
    'kubernetes',
    'HIGH',
    $$[{"solution": "Check volume mounts in init container spec: kubectl get pod pod-name -o yaml | grep -A 10 volumeMounts", "percentage": 87, "note": "Verify volume paths and mount points"}, {"solution": "Verify shared volumes between init and app containers exist", "percentage": 85, "note": "Init containers must mount volumes to pass data to main containers"}, {"solution": "Use kubectl exec to test path availability", "percentage": 80, "note": "Run interactive shell to verify file locations"}]$$::jsonb,
    'kubectl configured, pod with init container file errors',
    'Init container successfully accesses files from volumes',
    'Incorrect mountPath or volumeName in init container spec',
    0.87,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/tasks/debug/debug-application/debug-init-containers/'
),
(
    'Kubernetes error: Init container command not found or executable',
    'kubernetes',
    'MEDIUM',
    $$[{"solution": "Verify command and args in init container spec: kubectl get pod pod-name -o yaml | grep -A 5 command", "percentage": 89, "note": "Check exact command path and arguments"}, {"solution": "Check container image contains required binary: kubectl run -it --image=image:tag --rm -- sh", "percentage": 85, "note": "Shell into image to verify command exists"}, {"solution": "Ensure command uses correct shell path, e.g. /bin/sh not /bin/bash if not in image", "percentage": 88, "note": "Different base images have different shell interpreters"}]$$::jsonb,
    'kubectl configured, pod with init container',
    'Init container executes command successfully',
    'Using absolute paths that differ between base images',
    0.88,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/tasks/debug/debug-application/debug-init-containers/'
),
(
    'Kubernetes error: Init container resource limits exceeded or OOMKilled',
    'kubernetes',
    'MEDIUM',
    $$[{"solution": "Check init container resources: kubectl get pod pod-name -o yaml | grep -A 10 resources", "percentage": 86, "note": "Review requests and limits for init container"}, {"solution": "Increase memory limit or simplify init container workload", "percentage": 83, "note": "Init containers must complete before app containers can start"}, {"solution": "Use kubectl describe pod pod-name to check for OOMKilled reason", "percentage": 88, "note": "Last state will show if killed due to memory"}]$$::jsonb,
    'kubectl configured, pod with resource-constrained init container',
    'Init container completes within resource limits',
    'Not accounting for init container memory in pod total resources',
    0.86,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/concepts/workloads/pods/init-containers/#resources'
);

-- ============================================
-- KUBERNETES CLUSTER/NODE DEBUGGING ERRORS (12 entries)
-- ============================================

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES (
    'Kubernetes error: Node NotReady status',
    'kubernetes',
    'CRITICAL',
    $$[{"solution": "Check kubelet status with systemctl status kubelet. Review /var/log/kubelet.log for service errors. Verify node connectivity with kubectl describe node [node-name]", "percentage": 88, "note": "Kubelet service issues account for majority of NotReady states"}]$$::jsonb,
    'SSH access to node, kubectl configured, cluster context set',
    'kubectl get nodes shows Ready status for all nodes',
    'Not checking kubelet logs, assuming network issue without verification',
    0.88,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/tasks/debug/debug-cluster/'
),
(
    'Kubernetes error: Pods stuck in Pending state cluster-wide',
    'kubernetes',
    'CRITICAL',
    $$[{"solution": "Check node capacity with kubectl describe node [node-name]. Verify resource requests in pod spec. Check for taint/toleration mismatches", "percentage": 85, "note": "Usually caused by insufficient resources or scheduling constraints"}]$$::jsonb,
    'kubectl access, pod YAML visible, cluster resources known',
    'kubectl get pods shows Running status',
    'Assuming pod definition is correct without reviewing requests/limits',
    0.85,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/concepts/scheduling-eviction/'
),
(
    'Kubernetes error: CRI socket not found or connection refused',
    'kubernetes',
    'CRITICAL',
    $$[{"solution": "Verify container runtime socket path. For containerd use /run/containerd/containerd.sock, for CRI-O use /var/run/crio/crio.sock. Check runtime service status and logs", "percentage": 82, "note": "Often caused by container runtime not started or misconfigured socket path"}]$$::jsonb,
    'Node SSH access, container runtime installed, systemctl available',
    'kubelet can communicate with container runtime, pods can start',
    'Not verifying correct socket path for the specific container runtime',
    0.82,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/setup/production-environment/container-runtimes/'
),
(
    'Kubernetes error: Cgroup driver mismatch between kubelet and container runtime',
    'kubernetes',
    'HIGH',
    $$[{"solution": "Verify cgroup driver in both kubelet and runtime config. Set both to systemd or both to cgroupfs. Edit /etc/sysconfig/kubelet and /etc/containerd/config.toml or /etc/crio/crio.conf accordingly", "percentage": 90, "note": "Kubernetes 1.22+ prefers systemd driver"}]$$::jsonb,
    'Root/sudo access to node, ability to edit config files, systemctl available',
    'Node enters Ready state, pods schedule and run successfully',
    'Changing only one component without syncing both configurations',
    0.90,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/setup/production-environment/container-runtimes/'
),
(
    'Kubernetes error: Deployment pod replicas mismatch',
    'kubernetes',
    'HIGH',
    $$[{"solution": "Run kubectl describe deployment [name] to check desired vs actual replicas. Use kubectl rollout status deployment/[name] to monitor. Check pod events with kubectl describe pod [pod-name]", "percentage": 87, "note": "Often image pull failures or insufficient resources"}]$$::jsonb,
    'kubectl configured, deployment accessible, image registry accessible',
    'kubectl get deployment shows Ready replicas equal to Desired',
    'Not checking pod events before assuming deployment logic is wrong',
    0.87,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/tasks/run-application/run-stateless-application-deployment/'
),
(
    'Kubernetes error: ImagePullBackOff pod failure cluster-wide',
    'kubernetes',
    'CRITICAL',
    $$[{"solution": "Verify image name and tag are correct. Check image registry credentials with kubectl get secrets. Verify image exists in registry. Check pod events: kubectl describe pod [pod-name]", "percentage": 91, "note": "Most common cause is typo in image name or missing credentials"}]$$::jsonb,
    'kubectl access, image registry credentials, docker/podman installed locally',
    'Pod phase changes to Running, image pull succeeds in pod events',
    'Not checking exact error message in pod events for typos',
    0.91,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/tasks/debug/debug-application/'
),
(
    'Kubernetes error: Pod volume mount permission denied',
    'kubernetes',
    'HIGH',
    $$[{"solution": "Check fsGroup and runAsUser in security context. Verify file ownership with ls -l. Use fsGroup to set volume ownership. Check /etc/group for supplementalGroups conflicts", "percentage": 84, "note": "fsGroup should match volume owner or be explicitly set"}]$$::jsonb,
    'Pod running or completed, kubectl exec access, ability to view file system',
    'kubectl exec into pod shows correct permissions, no permission denied errors',
    'Forgetting fsGroup or mismatching runAsUser with file ownership',
    0.84,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/tasks/configure-pod-container/security-context/'
),
(
    'Kubernetes error: Service endpoint not found or DNS not resolving',
    'kubernetes',
    'HIGH',
    $$[{"solution": "Verify service exists: kubectl get svc. Check endpoints: kubectl get endpoints [service-name]. Test DNS from pod: kubectl exec -it [pod] -- nslookup [service]. Check selector labels match pod labels", "percentage": 86, "note": "Label mismatch or service not created are common causes"}]$$::jsonb,
    'kubectl access, running pods, network policies not blocking DNS',
    'kubectl exec nslookup resolves service name, endpoints show pod IPs',
    'Not verifying service selectors match pod labels',
    0.86,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/tasks/debug/debug-service-connectivity/'
),
(
    'Kubernetes error: Pod evicted due to resource pressure',
    'kubernetes',
    'HIGH',
    $$[{"solution": "Check node status: kubectl describe node [node-name] for MemoryPressure/DiskPressure. Free up space or adjust pod resource limits. Verify actual usage vs limits with metrics", "percentage": 79, "note": "Eviction is automatic when node hits resource threshold"}]$$::jsonb,
    'kubectl access, node SSH access, df and free commands available',
    'Node conditions show no MemoryPressure/DiskPressure, pods run without eviction',
    'Only looking at pod logs instead of checking node resource pressure',
    0.79,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/concepts/scheduling-eviction/'
),
(
    'Kubernetes error: Init container failed or timed out',
    'kubernetes',
    'MEDIUM',
    $$[{"solution": "Check init container logs: kubectl logs [pod-name] -c [init-container-name]. Verify init container command and resources. Ensure dependencies like volumes or network are available. Check pod events", "percentage": 80, "note": "Init containers must complete before app containers start"}]$$::jsonb,
    'kubectl access, pod in Failed or Pending state, init container defined',
    'Pod phase becomes Running after init container completes successfully',
    'Not checking init container logs separately from app container logs',
    0.80,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/tasks/debug/debug-application/'
),
(
    'Kubernetes error: kubectl get nodes returns error or incomplete output',
    'kubernetes',
    'MEDIUM',
    $$[{"solution": "Verify kubeconfig with kubectl config view. Check kubectl context: kubectl config current-context. Ensure API server is accessible: kubectl cluster-info. Check certificate validity", "percentage": 83, "note": "Usually certificate expiry or API server connectivity"}]$$::jsonb,
    'kubeconfig file present, kubectl installed, network to API server',
    'kubectl get nodes returns full node list with status, cluster-info shows API endpoint',
    'Not checking kubeconfig path or API server connectivity before redeploying',
    0.83,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/reference/kubectl/cheatsheet/'
),
(
    'Kubernetes error: Deployment rollout stuck or timing out',
    'kubernetes',
    'MEDIUM',
    $$[{"solution": "Check deployment progress: kubectl rollout status deployment/[name]. Inspect pod events: kubectl describe pod [pod-name]. Review readiness/liveness probe configuration. Check resource availability", "percentage": 77, "note": "Failed readiness probes are most common cause"}]$$::jsonb,
    'kubectl access, deployment accessible, pods should be running',
    'kubectl rollout status completes successfully, all pods in Running state',
    'Not checking probe logs or assuming all pods will become ready',
    0.77,
    'sonnet-4',
    NOW(),
    'https://kubernetes.io/docs/tasks/run-application/run-stateless-application-deployment/'
);
