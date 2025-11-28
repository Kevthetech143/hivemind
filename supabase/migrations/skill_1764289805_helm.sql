INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Helm Chart Scaffolding - Design and manage Helm charts for Kubernetes applications',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Initialize Chart Structure",
      "cli": {
        "macos": "helm create my-app",
        "linux": "helm create my-app",
        "windows": "helm create my-app"
      },
      "manual": "Run helm create <chart-name> to generate standard chart structure with all required directories",
      "note": "Creates Chart.yaml, values.yaml, templates/ directory and helper files"
    },
    {
      "solution": "Configure Chart.yaml Metadata",
      "cli": {
        "macos": "cat > Chart.yaml << ''YAML'' && apiVersion: v2 && name: my-app && description: A Helm chart && version: 1.0.0 && appVersion: \"2.1.0\" && YAML",
        "linux": "cat > Chart.yaml << ''YAML'' && apiVersion: v2 && name: my-app && description: A Helm chart && version: 1.0.0 && appVersion: \"2.1.0\" && YAML",
        "windows": "echo apiVersion: v2 > Chart.yaml && echo name: my-app >> Chart.yaml"
      },
      "manual": "Edit Chart.yaml with chart metadata: name, version, appVersion, description, keywords, maintainers, sources, and dependencies",
      "note": "Chart version and appVersion follow semantic versioning"
    },
    {
      "solution": "Design values.yaml Structure",
      "cli": {
        "macos": "helm show values ./my-app > values-output.yaml",
        "linux": "helm show values ./my-app > values-output.yaml",
        "windows": "helm show values ./my-app > values-output.yaml"
      },
      "manual": "Organize values hierarchically for image, replicas, service, ingress, resources, autoscaling, env vars, and dependencies",
      "note": "Use comments to document all values and their purposes"
    },
    {
      "solution": "Create Template Files",
      "cli": {
        "macos": "helm template test-release ./my-app --dry-run",
        "linux": "helm template test-release ./my-app --dry-run",
        "windows": "helm template test-release ./my-app --dry-run"
      },
      "manual": "Create deployment.yaml, service.yaml, ingress.yaml, configmap.yaml using Go templating with {{ }} syntax",
      "note": "Use template helpers from _helpers.tpl for consistent naming and labels"
    },
    {
      "solution": "Create Template Helpers",
      "cli": {
        "macos": "cat > templates/_helpers.tpl << ''TPL'' && {{- define \"my-app.fullname\" -}} ... {{- end }} && TPL",
        "linux": "cat > templates/_helpers.tpl << ''TPL'' && {{- define \"my-app.fullname\" -}} ... {{- end }} && TPL",
        "windows": "echo {{- define \"my-app.fullname\" -}} > templates/_helpers.tpl"
      },
      "manual": "Define reusable template functions: fullname, labels, selectorLabels, chart, image",
      "note": "Helpers reduce duplication and ensure consistency across all templates"
    },
    {
      "solution": "Manage Dependencies",
      "cli": {
        "macos": "helm dependency update",
        "linux": "helm dependency update",
        "windows": "helm dependency update"
      },
      "manual": "Add dependencies in Chart.yaml with name, version, repository URL, and conditions",
      "note": "Use conditions like postgresql.enabled to make dependencies optional"
    },
    {
      "solution": "Test and Validate Charts",
      "cli": {
        "macos": "helm lint my-app/ && helm template my-app ./my-app --dry-run --debug",
        "linux": "helm lint my-app/ && helm template my-app ./my-app --dry-run --debug",
        "windows": "helm lint my-app/ && helm template my-app ./my-app --dry-run --debug"
      },
      "manual": "Validate chart syntax, template rendering, values, and dependencies before installation",
      "note": "Use --dry-run to preview manifest output before actual deployment"
    },
    {
      "solution": "Package and Distribute",
      "cli": {
        "macos": "helm package my-app/ && helm repo index .",
        "linux": "helm package my-app/ && helm repo index .",
        "windows": "helm package my-app/ && helm repo index ."
      },
      "manual": "Create chart package (tgz) and generate index.yaml for repository distribution",
      "note": "Upload to S3 or chart registry for sharing charts with teams"
    },
    {
      "solution": "Multi-Environment Configuration",
      "cli": {
        "macos": "helm install my-app ./my-app -f values-prod.yaml --namespace production",
        "linux": "helm install my-app ./my-app -f values-prod.yaml --namespace production",
        "windows": "helm install my-app ./my-app -f values-prod.yaml --namespace production"
      },
      "manual": "Create environment-specific values files: values-dev.yaml, values-staging.yaml, values-prod.yaml",
      "note": "Override defaults with -f flag to use environment-specific configurations"
    },
    {
      "solution": "Implement Hooks and Tests",
      "cli": {
        "macos": "helm test my-release --logs",
        "linux": "helm test my-release --logs",
        "windows": "helm test my-release --logs"
      },
      "manual": "Create pre/post-install hooks and test pods in templates/tests/ directory",
      "note": "Use helm.sh/hook annotations to control execution timing"
    }
  ]'::jsonb,
  'script',
  'Helm 3.0+, kubectl, Kubernetes cluster (for installation testing), basic understanding of Go templating syntax',
  'Common mistakes: Using template syntax in values.yaml (only works in templates), not quoting string values in templates, mixing chart version with app version, hardcoding environment-specific values in defaults, not using conditions for optional dependencies, incorrect template indentation breaking YAML',
  'Successfully run: helm lint with no errors, helm template produces valid YAML, helm install --dry-run shows correct resource configuration, templates use helpers consistently, dependencies resolve correctly with helm dependency update, chart packages successfully, values override correctly with -f flag, charts deploy to multiple environments without modification',
  'Helm skill for creating production-ready Kubernetes charts with templating, dependency management, and multi-environment support',
  'https://skillsmp.com/skills/wshobson-agents-plugins-kubernetes-operations-skills-helm-chart-scaffolding-skill-md',
  'admin:HAIKU_SKILL_1764289805_6883'
);
