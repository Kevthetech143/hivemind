INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Deployment Pipeline Design - Design multi-stage CI/CD pipelines with approval gates and deployment strategies',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Design Standard Pipeline Stages",
      "cli": {
        "macos": "# Typical pipeline: git push → build → test → deploy-staging → approve → deploy-prod",
        "linux": "# Typical pipeline: git push → build → test → deploy-staging → approve → deploy-prod",
        "windows": "# Typical pipeline: git push → build → test → deploy-staging → approve → deploy-prod"
      },
      "manual": "Structure pipeline in stages: Source (code checkout), Build (compile/containerize), Test (unit/integration/security), Staging Deploy (test environment), Integration Tests (E2E), Approval Gate (manual), Production Deploy (canary/blue-green/rolling), Verification (health checks), Rollback (automated)",
      "note": "Each stage should be independent and reusable. Run quick tests early to fail fast."
    },
    {
      "solution": "Implement Approval Gates",
      "cli": {
        "macos": "# GitHub: environment protection rules prevent deployment without approval",
        "linux": "# GitHub: environment protection rules prevent deployment without approval",
        "windows": "# GitHub: environment protection rules prevent deployment without approval"
      },
      "manual": "Add manual approval before production deployment. GitHub Actions uses environment protection rules, GitLab CI uses when:manual, Azure Pipelines uses ManualValidation task. Require specific approvers and document approval criteria.",
      "note": "Approval gates prevent accidental deployments. Can be time-based (wait X minutes), multi-approver, or environment-specific."
    },
    {
      "solution": "Rolling Deployment Strategy",
      "cli": {
        "macos": "kubectl patch deployment my-app -p {spec:{strategy:{type:RollingUpdate}}}",
        "linux": "kubectl patch deployment my-app -p {spec:{strategy:{type:RollingUpdate}}}",
        "windows": "kubectl patch deployment my-app -p {spec:{strategy:{type:RollingUpdate}}}"
      },
      "manual": "Configure rolling updates with maxSurge (new pods to start) and maxUnavailable (old pods to stop). Gradual rollout achieves zero downtime with easy rollback",
      "note": "Rolling deployment is best for most applications. maxSurge=2, maxUnavailable=1 is typical configuration"
    },
    {
      "solution": "Blue-Green Deployment Strategy",
      "cli": {
        "macos": "kubectl apply -f green-deployment.yaml && kubectl label service my-app version=green",
        "linux": "kubectl apply -f green-deployment.yaml && kubectl label service my-app version=green",
        "windows": "kubectl apply -f green-deployment.yaml && kubectl label service my-app version=green"
      },
      "manual": "Deploy new version (green) alongside current (blue), test fully, then switch traffic. Instant switchover with easy rollback by relabeling service",
      "note": "Blue-green requires double infrastructure temporarily. Good for high-risk deployments where fast rollback is critical"
    },
    {
      "solution": "Canary Deployment Strategy",
      "cli": {
        "macos": "kubectl argo rollouts promote my-app  # Advance to next canary step",
        "linux": "kubectl argo rollouts promote my-app  # Advance to next canary step",
        "windows": "kubectl argo rollouts promote my-app  # Advance to next canary step"
      },
      "manual": "Route small percentage (10%) of traffic to new version, pause, monitor, then gradually increase. Mitigates risk through real user testing",
      "note": "Requires Argo Rollouts or service mesh. Gradual steps: 10% (pause) → 25% → 50% → 100%"
    },
    {
      "solution": "Feature Flags for Safe Deployments",
      "cli": {
        "macos": "# Deploy code with feature flag disabled, then enable flag to activate",
        "linux": "# Deploy code with feature flag disabled, then enable flag to activate",
        "windows": "# Deploy code with feature flag disabled, then enable flag to activate"
      },
      "manual": "Use feature flag provider (Flagsmith, LaunchDarkly, etc.) to control code path visibility. Deploy without releasing, enable gradually, instant rollback by disabling flag",
      "note": "Feature flags decouple deployment from release. Enable A/B testing and per-user feature control"
    },
    {
      "solution": "Multi-Stage Pipeline Orchestration",
      "cli": {
        "macos": "git push → GitHub Actions trigger → parallel jobs (build, test) → deploy-staging → integration-tests → approval → deploy-production",
        "linux": "git push → GitHub Actions trigger → parallel jobs (build, test) → deploy-staging → integration-tests → approval → deploy-production",
        "windows": "git push → GitHub Actions trigger → parallel jobs (build, test) → deploy-staging → integration-tests → approval → deploy-production"
      },
      "manual": "Build stages as DAG: build starts immediately, test depends on build (run in parallel if multiple tests), staging depends on test, approval manual gate, production depends on approval. Run independent jobs concurrently",
      "note": "Use needs: job_name in GitHub Actions to define dependencies. Parallel execution reduces total pipeline time"
    },
    {
      "solution": "Automated Rollback on Failure",
      "cli": {
        "macos": "kubectl rollout undo deployment/my-app  # Revert to previous version",
        "linux": "kubectl rollout undo deployment/my-app  # Revert to previous version",
        "windows": "kubectl rollout undo deployment/my-app  # Revert to previous version"
      },
      "manual": "Deploy, then run health checks. If checks fail, automatically rollback using kubectl rollout undo. Monitor error rates post-deployment",
      "note": "Automated rollback prevents cascading failures. Always run health checks before considering deployment successful"
    },
    {
      "solution": "Pipeline Caching and Artifact Management",
      "cli": {
        "macos": "docker build --cache-from myapp:latest -t myapp:new . && docker push myapp:new",
        "linux": "docker build --cache-from myapp:latest -t myapp:new . && docker push myapp:new",
        "windows": "docker build --cache-from myapp:latest -t myapp:new . && docker push myapp:new"
      },
      "manual": "Cache Docker layers, dependencies (npm, pip), and build artifacts between pipeline runs. Store build outputs as artifacts for deployment stage",
      "note": "Caching reduces build time significantly. Use multi-stage Docker builds to minimize final image size"
    },
    {
      "solution": "Pipeline Monitoring and Metrics",
      "cli": {
        "macos": "# Track: deployment frequency, lead time, change failure rate, MTTR",
        "linux": "# Track: deployment frequency, lead time, change failure rate, MTTR",
        "windows": "# Track: deployment frequency, lead time, change failure rate, MTTR"
      },
      "manual": "Monitor key metrics: deployment frequency (how often), lead time (commit to prod), change failure rate (% failed), MTTR (time to recovery). Integrate pipeline with monitoring to check error rates post-deployment",
      "note": "These DORA metrics indicate deployment health. Use Prometheus queries to check application metrics before/after deployment"
    }
  ]'::jsonb,
  'script',
  'CI/CD platform (GitHub Actions, GitLab CI, or Jenkins), Kubernetes/container orchestration, understanding of git workflow, monitoring tools (Prometheus), notification system (Slack)',
  'Common mistakes: Skipping approval gates in production, no automated rollback, inadequate testing before deployment, mixing test and prod environments, no monitoring post-deployment, deploying during high-traffic hours, no health checks, too aggressive canary steps, insufficient artifact retention, no documentation of pipeline stages',
  'Successfully test: Build completes without errors, all tests pass before deployment, approval gate prevents deployment until manual approval, canary deployment starts at 10%, health checks pass post-deployment, rollback succeeds if health check fails, parallel jobs execute concurrently, artifacts persist for rollback, metrics show no spike in error rate post-deployment, team notified of deployment status',
  'CI/CD skill for multi-stage deployment pipelines with approval gates, canary deployments, and automated rollback',
  'https://skillsmp.com/skills/wshobson-agents-plugins-cicd-automation-skills-deployment-pipeline-design-skill-md',
  'admin:HAIKU_SKILL_1764289805_6883'
);
