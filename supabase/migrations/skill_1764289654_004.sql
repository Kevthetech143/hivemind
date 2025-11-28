INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'GitHub Actions Templates - Create production-ready GitHub Actions workflows for automated testing, building, and deploying applications',
  'claude-code',
  'skill',
  '[
    {"solution": "Test Workflow Pattern", "cli": {"macos": "cp assets/test-workflow.yml .github/workflows/test.yml && gh workflow enable test", "linux": "cp assets/test-workflow.yml .github/workflows/test.yml && gh workflow enable test", "windows": "copy assets\\test-workflow.yml .github\\workflows\\test.yml && gh workflow enable test"}, "manual": "Set up testing on push/PR with matrix builds for multiple node versions. Use actions/checkout@v4, actions/setup-node@v4 with caching. Run linter and tests, upload coverage to codecov."},
    {"solution": "Build and Push Docker Image", "cli": {"macos": "docker build -t ghcr.io/org/repo:latest . && docker push ghcr.io/org/repo:latest", "linux": "docker build -t ghcr.io/org/repo:latest . && docker push ghcr.io/org/repo:latest", "windows": "docker build -t ghcr.io/org/repo:latest . && docker push ghcr.io/org/repo:latest"}, "manual": "Use docker/login-action@v3, docker/metadata-action@v5, docker/build-push-action@v5. Configure registry authentication with GITHUB_TOKEN. Add semantic versioning and branch tags."},
    {"solution": "Deploy to Kubernetes", "cli": {"macos": "aws eks update-kubeconfig --name cluster-name && kubectl apply -f k8s/ && kubectl rollout status deployment/app", "linux": "aws eks update-kubeconfig --name cluster-name && kubectl apply -f k8s/ && kubectl rollout status deployment/app", "windows": "aws eks update-kubeconfig --name cluster-name && kubectl apply -f k8s/ && kubectl rollout status deployment/app"}, "manual": "Configure AWS credentials using aws-actions/configure-aws-credentials@v4. Update kubeconfig, apply manifests, verify rollout status. Add deployment verification and pod checks."},
    {"solution": "Matrix Build for Multiple Environments", "manual": "Use strategy.matrix to test across OS (ubuntu, macos, windows) and language versions (Python 3.9-3.12, Node 18/20). Cache dependencies to speed builds. Run full test suite for each combination."},
    {"solution": "Reusable Workflows", "manual": "Create .github/workflows/reusable-*.yml with workflow_call trigger. Define inputs (required fields with types) and secrets. Reference from other workflows using: uses: ./.github/workflows/reusable-*.yml with: node-version: 20.x secrets: inherit"},
    {"solution": "Security Scanning and Deployment Approvals", "manual": "Use aquasecurity/trivy-action for vulnerability scanning, snyk/actions for dependency checks. Implement environment approvals with environment: production. Add Slack notifications on success/failure using slackapi/slack-github-action@v1."}
  ]'::jsonb,
  'script',
  'Git/GitHub knowledge, understanding of CI/CD concepts, Docker and Kubernetes basics, AWS credentials setup',
  'Using @latest instead of specific versions, not caching dependencies, exposing secrets in logs, inadequate error handling, missing approval gates for production, inconsistent matrix configurations, not setting appropriate permissions',
  'Workflows execute on push and PR, tests pass on all matrix combinations, Docker images push successfully with correct tags, Kubernetes deployments rollout without errors, security scans complete, approvals required for production',
  'Production-ready GitHub Actions workflow templates for testing, Docker builds, Kubernetes deployment, and security scanning with reusable workflow patterns',
  'https://skillsmp.com/skills/wshobson-agents-plugins-cicd-automation-skills-github-actions-templates-skill-md',
  'admin:HAIKU_SKILL_1764289654_89802'
);
