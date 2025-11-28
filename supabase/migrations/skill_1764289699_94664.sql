-- Skill miners batch insert - 1764289699_94664
-- 4 skills from skillsmp repository

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'ShellCheck Configuration - Master static analysis configuration and usage for shell script quality',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Install ShellCheck",
      "cli": {
        "macos": "brew install shellcheck",
        "linux": "apt-get install shellcheck",
        "windows": "choco install shellcheck"
      },
      "manual": "Visit https://github.com/koalaman/shellcheck for installation instructions"
    },
    {
      "solution": "Create .shellcheckrc configuration file",
      "cli": {
        "macos": "echo shell=bash > .shellcheckrc && echo enable=avoid-nullary-conditions >> .shellcheckrc",
        "linux": "echo shell=bash > .shellcheckrc && echo enable=avoid-nullary-conditions >> .shellcheckrc",
        "windows": "echo shell=bash > .shellcheckrc && echo enable=avoid-nullary-conditions >> .shellcheckrc"
      },
      "manual": "Create .shellcheckrc file in project root with shell=bash directive"
    },
    {
      "solution": "Run ShellCheck on shell scripts",
      "cli": {
        "macos": "shellcheck --shell=bash --format=gcc *.sh",
        "linux": "shellcheck --shell=bash --format=gcc *.sh",
        "windows": "shellcheck --shell=bash --format=gcc *.sh"
      },
      "manual": "Execute shellcheck command against your shell script files to detect issues"
    },
    {
      "solution": "Integrate into CI/CD pipeline",
      "cli": {
        "macos": "find . -type f -name ''*.sh'' -exec shellcheck --shell=bash --format=gcc {} + || exit 1",
        "linux": "find . -type f -name ''*.sh'' -exec shellcheck --shell=bash --format=gcc {} + || exit 1",
        "windows": "for /r . %%f in (*.sh) do shellcheck --shell=bash --format=gcc %%f"
      },
      "manual": "Add ShellCheck to your CI/CD pipeline to automatically lint shell scripts"
    }
  ]'::jsonb,
  'script',
  'ShellCheck installed, shell scripts in project',
  'Forgetting to quote variables, using [ ] instead of [[ ]], mixing shell dialects',
  'ShellCheck runs without errors, all code quality issues identified and documented',
  'Static analysis tool that detects shell script problems across 100+ warning categories',
  'https://skillsmp.com/skills/wshobson-agents-plugins-shell-scripting-skills-shellcheck-configuration-skill-md',
  'admin:HAIKU_SKILL_1764289699_94664'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'SAST Configuration - Configure Static Application Security Testing tools for automated vulnerability detection',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Install Semgrep for security scanning",
      "cli": {
        "macos": "pip install semgrep",
        "linux": "pip install semgrep",
        "windows": "pip install semgrep"
      },
      "manual": "Install Semgrep using pip for pattern-based security analysis"
    },
    {
      "solution": "Run basic Semgrep scan",
      "cli": {
        "macos": "semgrep --config=auto --error .",
        "linux": "semgrep --config=auto --error .",
        "windows": "semgrep --config=auto --error ."
      },
      "manual": "Execute Semgrep with auto-configuration to scan for vulnerabilities"
    },
    {
      "solution": "Create Semgrep configuration file",
      "cli": {
        "macos": "echo rules: > .semgrep.yml && echo ''  - id: hardcoded-secret'' >> .semgrep.yml",
        "linux": "echo rules: > .semgrep.yml && echo ''  - id: hardcoded-secret'' >> .semgrep.yml",
        "windows": "echo rules: > .semgrep.yml && echo   - id: hardcoded-secret >> .semgrep.yml"
      },
      "manual": "Create custom Semgrep configuration with organization-specific security rules"
    },
    {
      "solution": "Integrate Semgrep into GitHub Actions",
      "cli": {
        "macos": "mkdir -p .github/workflows && echo name: Semgrep > .github/workflows/semgrep.yml",
        "linux": "mkdir -p .github/workflows && echo name: Semgrep > .github/workflows/semgrep.yml",
        "windows": "mkdir .github\\workflows && echo name: Semgrep > .github\\workflows\\semgrep.yml"
      },
      "manual": "Add GitHub Actions workflow for automated Semgrep scanning"
    },
    {
      "solution": "Configure quality gates in CI/CD",
      "cli": {
        "macos": "semgrep --config=p/owasp-top-ten --json -o semgrep-results.json",
        "linux": "semgrep --config=p/owasp-top-ten --json -o semgrep-results.json",
        "windows": "semgrep --config=p/owasp-top-ten --json -o semgrep-results.json"
      },
      "manual": "Run Semgrep with OWASP rules and export results in JSON format"
    }
  ]'::jsonb,
  'script',
  'Python 3.6+, pip, Git',
  'Too many false positives, missing custom rules, not excluding test files, misconfigured gates',
  'Semgrep scans complete, vulnerabilities identified and categorized, CI/CD integration working',
  'SAST tooling for identifying security vulnerabilities in application code using pattern matching',
  'https://skillsmp.com/skills/wshobson-agents-plugins-security-scanning-skills-sast-configuration-skill-md',
  'admin:HAIKU_SKILL_1764289699_94664'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Async Python Patterns - Master asyncio concurrent programming and async/await patterns for non-blocking applications',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Create basic async coroutine with asyncio",
      "cli": {
        "macos": "python3 -c ''import asyncio; asyncio.run(asyncio.sleep(1))''",
        "linux": "python3 -c ''import asyncio; asyncio.run(asyncio.sleep(1))''",
        "windows": "python -c \"import asyncio; asyncio.run(asyncio.sleep(1))\""
      },
      "manual": "Write async def functions using await for asynchronous operations"
    },
    {
      "solution": "Use asyncio.gather for concurrent execution",
      "cli": {
        "macos": "python3 -c ''import asyncio; asyncio.run(asyncio.gather(asyncio.sleep(1), asyncio.sleep(1)))''",
        "linux": "python3 -c ''import asyncio; asyncio.run(asyncio.gather(asyncio.sleep(1), asyncio.sleep(1)))''",
        "windows": "python -c \"import asyncio; asyncio.run(asyncio.gather(asyncio.sleep(1)))\""
      },
      "manual": "Create multiple tasks and run them concurrently using asyncio.gather()"
    },
    {
      "solution": "Implement rate limiting with Semaphore",
      "cli": {
        "macos": "python3 -c ''import asyncio; sem=asyncio.Semaphore(5); print(sem)''",
        "linux": "python3 -c ''import asyncio; sem=asyncio.Semaphore(5); print(sem)''",
        "windows": "python -c \"import asyncio; sem=asyncio.Semaphore(5)\""
      },
      "manual": "Use asyncio.Semaphore to limit concurrent operations and implement rate limiting"
    },
    {
      "solution": "Handle timeouts with asyncio.wait_for",
      "cli": {
        "macos": "python3 -c ''import asyncio; asyncio.wait_for(asyncio.sleep(1), timeout=5)''",
        "linux": "python3 -c ''import asyncio; asyncio.wait_for(asyncio.sleep(1), timeout=5)''",
        "windows": "python -c \"import asyncio; asyncio.wait_for(asyncio.sleep(1), timeout=5)\""
      },
      "manual": "Wrap async operations with timeout protection using asyncio.wait_for()"
    },
    {
      "solution": "Create async context managers",
      "cli": {
        "macos": "cat > async_ctx.py << EOFPYTHON",
        "linux": "cat > async_ctx.py << EOFPYTHON",
        "windows": "type NUL > async_ctx.py"
      },
      "manual": "Implement __aenter__ and __aexit__ methods for async context managers"
    }
  ]'::jsonb,
  'script',
  'Python 3.7+, asyncio standard library',
  'Forgetting to await coroutines, blocking event loop, mixing async/sync code, not handling CancelledError',
  'Async code executes non-blocking, concurrent tasks complete faster, timeouts prevent hanging, asyncio.run() works properly',
  'Python asyncio patterns for building high-performance I/O-bound applications with concurrent task execution',
  'https://skillsmp.com/skills/wshobson-agents-plugins-python-development-skills-async-python-patterns-skill-md',
  'admin:HAIKU_SKILL_1764289699_94664'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Terraform Module Library - Build reusable Terraform modules for multi-cloud infrastructure with best practices',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Create Terraform module directory structure",
      "cli": {
        "macos": "mkdir -p terraform-modules/aws/vpc && cd terraform-modules/aws/vpc && touch main.tf variables.tf outputs.tf versions.tf",
        "linux": "mkdir -p terraform-modules/aws/vpc && cd terraform-modules/aws/vpc && touch main.tf variables.tf outputs.tf versions.tf",
        "windows": "mkdir terraform-modules\\aws\\vpc && cd terraform-modules\\aws\\vpc && type NUL > main.tf && type NUL > variables.tf"
      },
      "manual": "Create module directory with standard files: main.tf, variables.tf, outputs.tf, versions.tf"
    },
    {
      "solution": "Initialize Terraform module",
      "cli": {
        "macos": "terraform init",
        "linux": "terraform init",
        "windows": "terraform init"
      },
      "manual": "Run terraform init in module directory to initialize Terraform configuration"
    },
    {
      "solution": "Validate Terraform module syntax",
      "cli": {
        "macos": "terraform validate",
        "linux": "terraform validate",
        "windows": "terraform validate"
      },
      "manual": "Execute terraform validate to check HCL syntax and module configuration"
    },
    {
      "solution": "Format Terraform code",
      "cli": {
        "macos": "terraform fmt -recursive .",
        "linux": "terraform fmt -recursive .",
        "windows": "terraform fmt -recursive ."
      },
      "manual": "Run terraform fmt to standardize HCL formatting across all module files"
    },
    {
      "solution": "Test Terraform module with Terratest",
      "cli": {
        "macos": "cd tests && go test -v",
        "linux": "cd tests && go test -v",
        "windows": "cd tests && go test -v"
      },
      "manual": "Write Go tests using Terratest to validate module functionality and outputs"
    }
  ]'::jsonb,
  'steps',
  'Terraform 0.12+, cloud credentials, Go 1.16+ for testing',
  'Hardcoding values instead of variables, missing input validation, inconsistent tagging, not documenting outputs, not testing modules',
  'Module initializes without errors, terraform validate passes, terraform plan shows expected resources, examples work correctly',
  'Terraform module patterns for building reusable, production-ready infrastructure code across AWS, Azure, and GCP',
  'https://skillsmp.com/skills/wshobson-agents-plugins-cloud-infrastructure-skills-terraform-module-library-skill-md',
  'admin:HAIKU_SKILL_1764289699_94664'
);
