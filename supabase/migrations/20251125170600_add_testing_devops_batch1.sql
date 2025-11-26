-- Testing & DevOps Documentation Mining Batch 1
-- Sources: GitHub Actions, Terraform, Cypress, Playwright, Pytest
-- Mined: 2025-11-25

-- =============================================
-- GITHUB ACTIONS (10 entries)
-- =============================================

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'GitHub Actions workflow syntax error: missing colon after event name',
    'github-actions',
    'HIGH',
    $$[{"solution": "Add colon after event trigger name. Example: on:\n  push:\n    branches: [main]\nNot on push (missing colon). YAML requires colons after mapping keys.", "percentage": 95, "note": "YAML syntax - colons required after all mapping keys"}]$$::jsonb,
    'YAML syntax knowledge, workflow file in .github/workflows/',
    'Workflow file validates without syntax errors, Actions tab shows workflow',
    'Missing colons, incorrect indentation, tabs instead of spaces',
    0.95,
    'sonnet-4',
    NOW(),
    'https://docs.github.com/en/actions/how-tos/troubleshoot-workflows'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'GitHub Actions conflicting branch filters on push and pull_request',
    'github-actions',
    'HIGH',
    $$[{"solution": "Use branches-ignore OR branches, not both. They are mutually exclusive. Example:\non:\n  push:\n    branches:\n      - main\n      - releases/**\nDo NOT combine with branches-ignore in same trigger.", "percentage": 98, "note": "branches and branches-ignore cannot be used together"}]$$::jsonb,
    'Understanding of branch filter syntax',
    'Workflow triggers correctly on specified branches only',
    'Using both branches and branches-ignore, glob pattern mistakes',
    0.98,
    'sonnet-4',
    NOW(),
    'https://docs.github.com/en/actions/how-tos/troubleshoot-workflows'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'GitHub Actions reusable workflow missing required input type specification',
    'github-actions',
    'HIGH',
    $$[{"solution": "Add type field to workflow_call inputs. Required types: boolean, number, string. Example:\non:\n  workflow_call:\n    inputs:\n      username:\n        required: true\n        type: string", "percentage": 99, "note": "type field mandatory for reusable workflow inputs"}]$$::jsonb,
    'Reusable workflow setup with workflow_call trigger',
    'Calling workflow passes inputs without type errors',
    'Omitting type field, using invalid type values',
    0.99,
    'sonnet-4',
    NOW(),
    'https://docs.github.com/en/actions/how-tos/troubleshoot-workflows'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'GitHub Actions invalid job ID: contains invalid characters',
    'github-actions',
    'MEDIUM',
    $$[{"solution": "Job IDs must start with letter or underscore, contain only alphanumeric, hyphen, underscore. Valid: build_job, test-suite, _private. Invalid: 1st-job, job@name, my job (no spaces).", "percentage": 100, "note": "Strict naming rules for job identifiers"}]$$::jsonb,
    'YAML workflow file structure knowledge',
    'Workflow parses without job ID errors',
    'Starting with number, using special characters, spaces in job names',
    1.00,
    'sonnet-4',
    NOW(),
    'https://docs.github.com/en/actions/how-tos/troubleshoot-workflows'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'GitHub Actions secrets not available in forked repository pull requests',
    'github-actions',
    'HIGH',
    $$[{"solution": "Secrets are blocked in fork PRs for security. Options: 1) Use pull_request_target (runs in base repo context with secrets). 2) Require fork owners to add their own secrets. 3) Use environment protection rules for manual approval.", "percentage": 85, "note": "Security feature - secrets never exposed to forks by default"}]$$::jsonb,
    'Understanding fork PR security model',
    'Workflow handles missing secrets gracefully or uses pull_request_target',
    'Expecting secrets in fork PRs, not handling missing secret cases',
    0.85,
    'sonnet-4',
    NOW(),
    'https://docs.github.com/en/actions/how-tos/troubleshoot-workflows'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'GitHub Actions secret exposed in workflow logs',
    'github-actions',
    'MEDIUM',
    $$[{"solution": "Use add-mask command to hide dynamic values: echo \"::add-mask::$DYNAMIC_SECRET\". Secrets from secrets context are auto-masked. For outputs, use environment files: echo \"value=$SECRET\" >> $GITHUB_OUTPUT", "percentage": 90, "note": "Built-in secrets auto-masked, dynamic values need manual masking"}]$$::jsonb,
    'Secret handling, output masking syntax',
    'Logs show *** instead of secret values',
    'Printing secrets directly, not masking computed sensitive values',
    0.90,
    'sonnet-4',
    NOW(),
    'https://docs.github.com/en/actions/how-tos/troubleshoot-workflows'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'GitHub Actions workflow skipped due to [skip ci] in commit message',
    'github-actions',
    'MEDIUM',
    $$[{"solution": "Commit message contains skip keywords: [skip ci], [ci skip], [no ci], [skip actions], or [actions skip]. Remove from commit message or amend commit: git commit --amend -m \"new message\"", "percentage": 100, "note": "Case-insensitive skip keywords in commit title or body"}]$$::jsonb,
    'Git commit message conventions',
    'Workflow runs after removing skip keyword from commit',
    'Accidentally including skip keywords, not checking commit message',
    1.00,
    'sonnet-4',
    NOW(),
    'https://docs.github.com/en/actions/how-tos/troubleshoot-workflows'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'GitHub Actions artifact download fails with digest mismatch',
    'github-actions',
    'MEDIUM',
    $$[{"solution": "Artifact was modified or corrupted during upload. Re-upload with actions/upload-artifact@v4. Ensure no concurrent writes to artifact files. Use unique artifact names per job.", "percentage": 88, "note": "Integrity check failure - artifact contents changed"}]$$::jsonb,
    'Artifact upload/download actions configured',
    'Artifact downloads with matching digest, files intact',
    'Concurrent artifact writes, modifying files during upload, name collisions',
    0.88,
    'sonnet-4',
    NOW(),
    'https://docs.github.com/en/actions/how-tos/troubleshoot-workflows'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'GitHub Actions job cannot be cancelled due to always() condition',
    'github-actions',
    'MEDIUM',
    $$[{"solution": "always() runs even on cancellation. Use: if: always() && !cancelled() to skip on cancel. Or use success() || failure() instead of always() for most cases.", "percentage": 92, "note": "always() includes cancelled state - often not intended"}]$$::jsonb,
    'Understanding job condition expressions',
    'Job respects cancellation when using !cancelled() check',
    'Using always() when success()||failure() intended, not handling cancel state',
    0.92,
    'sonnet-4',
    NOW(),
    'https://docs.github.com/en/actions/how-tos/troubleshoot-workflows'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'GitHub Actions permissions denied: Resource not accessible by integration',
    'github-actions',
    'HIGH',
    $$[{"solution": "Add permissions block to workflow or job. Example:\npermissions:\n  contents: read\n  pull-requests: write\n  issues: write\nOr use permissions: write-all for full access (less secure).", "percentage": 93, "note": "GITHUB_TOKEN has minimal permissions by default since 2023"}]$$::jsonb,
    'Understanding GITHUB_TOKEN permissions model',
    'API calls succeed with proper permissions configured',
    'Not specifying permissions, using read when write needed, forgetting specific permission',
    0.93,
    'sonnet-4',
    NOW(),
    'https://docs.github.com/en/actions/how-tos/troubleshoot-workflows'
);

-- =============================================
-- TERRAFORM (12 entries)
-- =============================================

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Terraform state version mismatch: state created by newer version',
    'terraform',
    'HIGH',
    $$[{"solution": "Upgrade local Terraform to match or exceed state version. Check with: terraform version. Download matching version from releases.hashicorp.com. Or downgrade state (risky): terraform state replace-provider", "percentage": 95, "note": "State format changes between versions - upgrade Terraform binary", "command": "terraform version && brew upgrade terraform"}]$$::jsonb,
    'Terraform CLI installed, access to state file',
    'terraform plan runs without version mismatch error',
    'Running older Terraform on newer state, team version mismatches',
    0.95,
    'sonnet-4',
    NOW(),
    'https://developer.hashicorp.com/terraform/tutorials/configuration-language/troubleshooting-workflow'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Terraform Error acquiring state lock: ConditionalCheckFailedException',
    'terraform',
    'HIGH',
    $$[{"solution": "Another process holds lock. Wait for completion or force unlock: terraform force-unlock LOCK_ID. Check DynamoDB/backend for stale locks. Ensure only one terraform apply runs at a time.", "percentage": 85, "note": "Never force-unlock active operations - data corruption risk", "command": "terraform force-unlock LOCK_ID"}]$$::jsonb,
    'Backend with locking configured (S3+DynamoDB, etc)',
    'Lock acquired, terraform plan/apply proceeds',
    'Force unlocking active operations, concurrent CI runs without locking',
    0.85,
    'sonnet-4',
    NOW(),
    'https://developer.hashicorp.com/terraform/tutorials/configuration-language/troubleshooting-workflow'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Terraform provider initialization failed: registry.terraform.io unreachable',
    'terraform',
    'HIGH',
    $$[{"solution": "Check network/proxy settings. Use provider mirror for air-gapped: terraform providers mirror /path. Or configure explicit provider source in required_providers block. Set TF_CLI_CONFIG_FILE for custom registry.", "percentage": 92, "note": "Network issues or registry outage - use mirrors for reliability", "command": "terraform init -upgrade"}]$$::jsonb,
    'Network access or local provider mirror',
    'terraform init completes, providers downloaded',
    'Corporate proxy blocking registry, no mirror configured for air-gapped',
    0.92,
    'sonnet-4',
    NOW(),
    'https://developer.hashicorp.com/terraform/tutorials/configuration-language/troubleshooting-workflow'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Terraform Error: Missing required argument in provider or resource',
    'terraform',
    'HIGH',
    $$[{"solution": "Check provider/resource documentation for required fields. Add missing argument to configuration. Common: region for AWS, project for GCP, subscription_id for Azure. Use terraform validate to check.", "percentage": 92, "note": "Provider docs list required vs optional arguments", "command": "terraform validate"}]$$::jsonb,
    'Provider documentation access',
    'terraform validate passes, no missing argument errors',
    'Not checking docs for required fields, assuming defaults exist',
    0.92,
    'sonnet-4',
    NOW(),
    'https://developer.hashicorp.com/terraform/tutorials/configuration-language/troubleshooting-workflow'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Terraform module source error: could not download module',
    'terraform',
    'MEDIUM',
    $$[{"solution": "Check module source format: local (./module), registry (hashicorp/consul/aws), git (git::https://...), s3 (s3::https://...). Verify credentials for private sources. Use version constraint for registry modules.", "percentage": 87, "note": "Source format varies by type - check Terraform module docs", "command": "terraform init -upgrade"}]$$::jsonb,
    'Module source accessible, credentials configured',
    'terraform init downloads module successfully',
    'Wrong source format, missing git credentials, version not found',
    0.87,
    'sonnet-4',
    NOW(),
    'https://developer.hashicorp.com/terraform/tutorials/configuration-language/troubleshooting-workflow'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Terraform reference error: Reference to undeclared resource or variable',
    'terraform',
    'HIGH',
    $$[{"solution": "Check spelling of resource/variable name. Ensure resource is declared before reference. Use correct reference syntax: var.name, local.name, resource_type.name.attribute, module.name.output. Run terraform fmt to catch syntax issues.", "percentage": 93, "note": "Case-sensitive names, must be declared before use", "command": "terraform fmt && terraform validate"}]$$::jsonb,
    'Understanding Terraform reference syntax',
    'terraform validate passes, references resolve',
    'Typos in names, referencing before declaration, wrong syntax (var vs local)',
    0.93,
    'sonnet-4',
    NOW(),
    'https://developer.hashicorp.com/terraform/tutorials/configuration-language/troubleshooting-workflow'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Terraform variable validation failed: value does not match constraint',
    'terraform',
    'MEDIUM',
    $$[{"solution": "Check validation block conditions in variable declaration. Fix input value to match constraint. Example validation:\nvariable \"env\" {\n  validation {\n    condition = contains([\"dev\",\"prod\"], var.env)\n    error_message = \"Must be dev or prod\"\n  }\n}", "percentage": 89, "note": "Custom validation blocks enforce input constraints", "command": "Check variable definition for validation block"}]$$::jsonb,
    'Understanding variable validation syntax',
    'Variable passes validation, plan proceeds',
    'Not reading error_message, not checking allowed values in validation',
    0.89,
    'sonnet-4',
    NOW(),
    'https://developer.hashicorp.com/terraform/tutorials/configuration-language/troubleshooting-workflow'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Terraform for_each error: must be a map or set of strings',
    'terraform',
    'MEDIUM',
    $$[{"solution": "Convert list to set: toset(var.list). Or use map with unique keys. for_each requires: map(any) or set(string). Cannot use list directly. Example: for_each = toset([\"a\", \"b\", \"c\"])", "percentage": 86, "note": "for_each needs addressable keys - lists have indices, not keys", "command": "for_each = toset(var.my_list)"}]$$::jsonb,
    'Understanding for_each vs count',
    'for_each iterates correctly, resources created with stable addresses',
    'Using list directly, not converting with toset(), duplicate values in set',
    0.86,
    'sonnet-4',
    NOW(),
    'https://developer.hashicorp.com/terraform/tutorials/configuration-language/troubleshooting-workflow'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Terraform cycle error: Cycle detected in resource dependencies',
    'terraform',
    'MEDIUM',
    $$[{"solution": "Break circular reference by: 1) Using depends_on for explicit ordering, 2) Restructuring resources to remove mutual dependency, 3) Using terraform graph to visualize: terraform graph | dot -Tpng > graph.png", "percentage": 84, "note": "Cycles prevent Terraform from determining apply order", "command": "terraform graph | dot -Tpng > graph.png"}]$$::jsonb,
    'Understanding resource dependencies',
    'terraform plan succeeds without cycle error',
    'Resources referencing each other, implicit dependencies creating loops',
    0.84,
    'sonnet-4',
    NOW(),
    'https://developer.hashicorp.com/terraform/tutorials/configuration-language/troubleshooting-workflow'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Terraform Enterprise error: S3 credentials empty or invalid',
    'terraform',
    'MEDIUM',
    $$[{"solution": "Configure IAM role or access keys for TFE. Set AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY in workspace variables. Or use instance profile with proper IAM role attached to TFE instance.", "percentage": 90, "note": "TFE needs explicit credentials - does not inherit CLI config", "command": "Set workspace variables in TFE UI or API"}]$$::jsonb,
    'Terraform Enterprise workspace access, AWS IAM',
    'TFE runs access S3 backend without credential errors',
    'Expecting CLI credentials to work, not setting workspace variables',
    0.90,
    'sonnet-4',
    NOW(),
    'https://developer.hashicorp.com/terraform/enterprise/deploy/troubleshoot/error-messages'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Terraform Enterprise certificate error: x509 certificate signed by unknown authority',
    'terraform',
    'MEDIUM',
    $$[{"solution": "Add CA certificate to TFE trust store. Configure custom CA bundle path in TFE settings. Or set SSL_CERT_FILE environment variable pointing to CA bundle.", "percentage": 88, "note": "Corporate CAs need explicit trust configuration", "command": "Add CA cert to /etc/ssl/certs/ or set SSL_CERT_FILE"}]$$::jsonb,
    'CA certificate file, TFE admin access',
    'TLS connections succeed without certificate errors',
    'Not adding internal CA, wrong certificate format, expired certificates',
    0.88,
    'sonnet-4',
    NOW(),
    'https://developer.hashicorp.com/terraform/enterprise/deploy/troubleshoot/error-messages'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Terraform binary download failed: permission denied on cache path',
    'terraform',
    'MEDIUM',
    $$[{"solution": "Fix permissions on Terraform plugin cache: chmod -R u+rwX ~/.terraform.d/plugin-cache. Or set TF_PLUGIN_CACHE_DIR to writable location. Create directory if missing: mkdir -p ~/.terraform.d/plugin-cache", "percentage": 87, "note": "Plugin cache needs write access for downloads", "command": "chmod -R u+rwX ~/.terraform.d/plugin-cache"}]$$::jsonb,
    'Filesystem permissions, Terraform cache location',
    'terraform init downloads providers without permission errors',
    'Running as different user, read-only cache directory, missing directory',
    0.87,
    'sonnet-4',
    NOW(),
    'https://developer.hashicorp.com/terraform/enterprise/deploy/troubleshoot/error-messages'
);

-- =============================================
-- CYPRESS (15 entries)
-- =============================================

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Cypress error: Timed out retrying - Expected to find element but never found it',
    'cypress',
    'HIGH',
    $$[{"solution": "Verify selector using browser DevTools. Check for dynamic content loading - use cy.intercept() to wait for API. Increase timeout: cy.get(selector, {timeout: 10000}). Check for iframes requiring cy.iframe() plugin.", "percentage": 85, "note": "Most common cause - element not rendered yet or wrong selector"}]$$::jsonb,
    'Cypress test runner, browser DevTools access',
    'cy.get() finds element within timeout, no timeout errors',
    'Wrong selector, not waiting for async content, element in iframe',
    0.85,
    'sonnet-4',
    NOW(),
    'https://docs.cypress.io/app/references/error-messages'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Cypress error: cy.click() failed because element is covered by another element',
    'cypress',
    'HIGH',
    $$[{"solution": "Use {force: true} to bypass visibility checks (last resort). Better: wait for overlays to close, scroll element into view with cy.scrollIntoView(), or click the covering element first.", "percentage": 80, "note": "force:true masks real UI issues - fix root cause when possible"}]$$::jsonb,
    'Understanding element visibility in Cypress',
    'Click succeeds without force, or force used intentionally',
    'Using force:true without understanding why, not handling modals/overlays',
    0.80,
    'sonnet-4',
    NOW(),
    'https://docs.cypress.io/app/references/error-messages'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Cypress error: cy.type() failed because element is not visible',
    'cypress',
    'HIGH',
    $$[{"solution": "Element must be visible and not covered. Scroll into view: cy.get(input).scrollIntoView().type(text). For hidden inputs use {force:true}. Check element is not display:none or visibility:hidden.", "percentage": 82, "note": "Cypress requires elements to be actionable like real users"}]$$::jsonb,
    'Understanding Cypress actionability checks',
    'Type command succeeds, input receives text',
    'Typing into hidden fields without force, not scrolling into view',
    0.82,
    'sonnet-4',
    NOW(),
    'https://docs.cypress.io/app/references/error-messages'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Cypress error: Page updated during command - element removed from DOM',
    'cypress',
    'HIGH',
    $$[{"solution": "Break command chains after navigation actions. Start new chain: cy.get(btn).click(); cy.get(newElement).should(exist). Never chain across page transitions.", "percentage": 90, "note": "Fundamental pattern - new page = new command chain"}]$$::jsonb,
    'Understanding Cypress command chaining',
    'Commands execute sequentially without stale element errors',
    'Chaining commands across page loads, not starting fresh chains',
    0.90,
    'sonnet-4',
    NOW(),
    'https://docs.cypress.io/app/references/error-messages'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Cypress error: Element is animating - cannot interact',
    'cypress',
    'MEDIUM',
    $$[{"solution": "Configure globally: cypress.config.js: { waitForAnimations: false, animationDistanceThreshold: 20 }. Or per-command: {force: true}. Better: disable animations in test environment.", "percentage": 88, "note": "Configure in cypress.config for consistent behavior"}]$$::jsonb,
    'Cypress config file, understanding animation handling',
    'Commands interact with animating elements, tests pass consistently',
    'Not configuring globally, using force instead of config',
    0.88,
    'sonnet-4',
    NOW(),
    'https://docs.cypress.io/app/references/error-messages'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Cypress error: cy.visit() failed - attempting to visit different origin domain',
    'cypress',
    'HIGH',
    $$[{"solution": "Use cy.origin() for cross-domain (v12+): cy.origin(\"other-domain.com\", () => { cy.get(...) }). For older versions, split into separate tests. Single test = single origin by default.", "percentage": 92, "note": "cy.origin() in v12+ enables multi-domain testing"}]$$::jsonb,
    'Cypress v12+ for cy.origin(), understanding same-origin policy',
    'Cross-domain commands work within cy.origin() block',
    'Not using cy.origin wrapper, outdated Cypress version',
    0.92,
    'sonnet-4',
    NOW(),
    'https://docs.cypress.io/app/references/error-messages'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Cypress error: Cannot execute commands outside a running test',
    'cypress',
    'HIGH',
    $$[{"solution": "All cy.* commands must be inside it() blocks. Use beforeEach() for setup, not bare describe(). Never invoke cy commands at file top-level.", "percentage": 95, "note": "Cypress commands require test execution context"}]$$::jsonb,
    'Understanding Mocha test structure',
    'All cy commands inside it() blocks, no scoping errors',
    'Commands in describe() directly, at file top-level, in before() without it()',
    0.95,
    'sonnet-4',
    NOW(),
    'https://docs.cypress.io/app/references/error-messages'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Cypress error: Test finished but commands still in queue',
    'cypress',
    'MEDIUM',
    $$[{"solution": "Return promises from async code. Use cy.intercept() for network waits, not arbitrary timeouts. Ensure done() not called before cy commands complete.", "percentage": 82, "note": "Race condition - test completes before async operations"}]$$::jsonb,
    'Understanding async handling in Cypress',
    'Test waits for all commands, no queue warnings',
    'Using done() with promises, setTimeout instead of cy.intercept()',
    0.82,
    'sonnet-4',
    NOW(),
    'https://docs.cypress.io/app/references/error-messages'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Cypress error: Browser crashed or exited unexpectedly',
    'cypress',
    'MEDIUM',
    $$[{"solution": "Enable experimentalMemoryManagement: true in config. Reduce numTestsKeptInMemory. Close other applications. Check system resources. Try Electron instead of Chrome.", "percentage": 78, "note": "Resource exhaustion - common in CI with limited memory"}]$$::jsonb,
    'Cypress config, system resource monitoring',
    'Browser stays running through test suite, memory stable',
    'Too many tests without memory management, CI resource limits',
    0.78,
    'sonnet-4',
    NOW(),
    'https://docs.cypress.io/app/references/error-messages'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Cypress error: Cross-origin error on page load',
    'cypress',
    'MEDIUM',
    $$[{"solution": "Test external URLs via cy.request() or href assertions, not navigation. Assert href: cy.get(link).should(have.attr, href, url). Last resort: chromeWebSecurity: false (security risk).", "percentage": 75, "note": "Avoid navigating to external domains - assert or request instead"}]$$::jsonb,
    'Understanding cross-origin limitations',
    'External URLs tested without navigation, no CORS errors',
    'Trying to visit external domains, not using cy.request() for APIs',
    0.75,
    'sonnet-4',
    NOW(),
    'https://docs.cypress.io/app/references/error-messages'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Cypress error: supportFile must be in e2e or component config, not root',
    'cypress',
    'MEDIUM',
    $$[{"solution": "Move supportFile from root to e2e block in cypress.config.js:\nmodule.exports = {\n  e2e: {\n    supportFile: \"cypress/support/e2e.js\"\n  }\n}", "percentage": 93, "note": "v10+ config structure change - supportFile is testing-type specific"}]$$::jsonb,
    'Cypress v10+, understanding config migration',
    'Config loads, supportFile found in correct location',
    'Keeping v9 config structure, supportFile at root level',
    0.93,
    'sonnet-4',
    NOW(),
    'https://docs.cypress.io/app/references/error-messages'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Cypress error: --record flag but no Record Key provided',
    'cypress',
    'HIGH',
    $$[{"solution": "Set CYPRESS_RECORD_KEY env var: export CYPRESS_RECORD_KEY=xxx. Or pass via CLI: cypress run --record --key YOUR_KEY. Get key from Cypress Cloud project settings.", "percentage": 88, "note": "Record key required for Cypress Cloud recording"}]$$::jsonb,
    'Cypress Cloud account, CI environment setup',
    'Tests record to Cypress Cloud without auth errors',
    'Missing env var, typo in variable name, key not exported',
    0.88,
    'sonnet-4',
    NOW(),
    'https://docs.cypress.io/app/references/error-messages'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Cypress error: Cannot parallelize - machines have different environments',
    'cypress',
    'MEDIUM',
    $$[{"solution": "Ensure all parallel machines use: same specs, same OS, same browser version. Use --ci-build-id to group runs. Pin Cypress and dependency versions.", "percentage": 85, "note": "Environment consistency required for parallelization"}]$$::jsonb,
    'CI parallelization setup, Cypress Cloud',
    'Tests parallelize, same run group, no environment errors',
    'Different specs per machine, browser version mismatches, OS differences',
    0.85,
    'sonnet-4',
    NOW(),
    'https://docs.cypress.io/app/references/error-messages'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Cypress error: Uncaught exception from application code',
    'cypress',
    'HIGH',
    $$[{"solution": "Handle in test: Cypress.on(\"uncaught:exception\", (err) => { if (err.message.includes(\"expected\")) return false; }). Or fix application error. Returning false prevents test failure.", "percentage": 80, "note": "Decide which app errors should fail tests"}]$$::jsonb,
    'Understanding exception handling in Cypress',
    'Expected errors suppressed, unexpected errors fail tests',
    'Suppressing all errors, not distinguishing expected vs unexpected',
    0.80,
    'sonnet-4',
    NOW(),
    'https://docs.cypress.io/app/references/error-messages'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Cypress error: Browser automation disconnected',
    'cypress',
    'MEDIUM',
    $$[{"solution": "Check proxy/firewall settings. Corporate policies may block Cypress. Try different browser (Electron). Dont copy Cypress URL to external browser. Disable enterprise proxy temporarily.", "percentage": 76, "note": "Network/policy issue - common in corporate environments"}]$$::jsonb,
    'Network access, browser automation enabled',
    'Browser connects, tests run without proxy errors',
    'Corporate proxy blocking, copying URL to external browser',
    0.76,
    'sonnet-4',
    NOW(),
    'https://docs.cypress.io/app/references/error-messages'
);

-- =============================================
-- PLAYWRIGHT (12 entries)
-- =============================================

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Playwright error: Timeout waiting for element to be visible',
    'playwright',
    'HIGH',
    $$[{"solution": "Increase timeout: await page.locator(sel).click({timeout: 30000}). Use waitFor: await page.locator(sel).waitFor({state: \"visible\"}). Check selector with page.locator(sel).count().", "percentage": 95, "note": "Default 30s timeout - increase for slow pages or check selector", "command": "await page.locator(sel).waitFor({state: \"visible\"})"}]$$::jsonb,
    'Playwright test setup, valid selectors',
    'Element found within timeout, action succeeds',
    'Wrong selector, not waiting for dynamic content, default timeout too short',
    0.95,
    'sonnet-4',
    NOW(),
    'https://playwright.dev/docs/troubleshooting'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Playwright error: Browser launch failed or timed out',
    'playwright',
    'HIGH',
    $$[{"solution": "Install browsers: npx playwright install. For Docker: use playwright Docker image or install deps: npx playwright install-deps. Check disk space and memory.", "percentage": 90, "note": "Common in CI - browsers need explicit installation", "command": "npx playwright install && npx playwright install-deps"}]$$::jsonb,
    'Node.js, system dependencies for browsers',
    'Browser launches successfully, tests run',
    'Missing browser binaries, CI missing dependencies, low resources',
    0.90,
    'sonnet-4',
    NOW(),
    'https://playwright.dev/docs/troubleshooting'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Playwright error: Strict mode violation - locator resolved to multiple elements',
    'playwright',
    'HIGH',
    $$[{"solution": "Make selector more specific. Use .first(), .last(), .nth(n) to select one. Or use filter: page.locator(sel).filter({hasText: \"specific\"}). Check with locator.count().", "percentage": 92, "note": "Strict mode requires single element - be specific", "command": "page.locator(sel).filter({hasText: \"text\"}).first()"}]$$::jsonb,
    'Understanding Playwright strict mode',
    'Locator resolves to exactly one element',
    'Generic selectors matching multiple, not using filter or nth()',
    0.92,
    'sonnet-4',
    NOW(),
    'https://playwright.dev/docs/troubleshooting'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Playwright error: Element not clickable - intercepted by other element',
    'playwright',
    'HIGH',
    $$[{"solution": "Wait for overlay to close. Use force: await locator.click({force: true}). Or click intercepting element first. Check for modals, tooltips, loading overlays.", "percentage": 93, "note": "force:true bypasses actionability - use when overlay is intentional", "command": "await page.locator(sel).click({force: true})"}]$$::jsonb,
    'Understanding actionability checks',
    'Click succeeds, action performed on element',
    'Not handling overlays, using force without understanding why',
    0.93,
    'sonnet-4',
    NOW(),
    'https://playwright.dev/docs/troubleshooting'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Playwright error: Navigation timeout exceeded',
    'playwright',
    'HIGH',
    $$[{"solution": "Increase navigation timeout: await page.goto(url, {timeout: 60000}). Or configure globally in playwright.config.ts: navigationTimeout: 60000. Check network and server response time.", "percentage": 88, "note": "Default 30s - slow servers need longer timeout", "command": "await page.goto(url, {timeout: 60000, waitUntil: \"domcontentloaded\"})"}]$$::jsonb,
    'Network access, server responding',
    'Page loads within timeout, navigation completes',
    'Slow server, default timeout too short, waiting for wrong load state',
    0.88,
    'sonnet-4',
    NOW(),
    'https://playwright.dev/docs/troubleshooting'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Playwright error: Test timeout of 30000ms exceeded',
    'playwright',
    'HIGH',
    $$[{"solution": "Increase test timeout in config: timeout: 60000. Or per-test: test.setTimeout(60000). Check for hanging operations, unresolved promises, infinite loops.", "percentage": 87, "note": "Test timeout includes all operations - not just single action", "command": "test.setTimeout(60000) or config: {timeout: 60000}"}]$$::jsonb,
    'Understanding test vs action timeouts',
    'Test completes within timeout',
    'Confusing test vs action timeout, hanging async operations',
    0.87,
    'sonnet-4',
    NOW(),
    'https://playwright.dev/docs/troubleshooting'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Playwright error: Service worker intercepting network requests',
    'playwright',
    'MEDIUM',
    $$[{"solution": "Unregister service workers in test setup: await context.addInitScript(() => navigator.serviceWorker?.getRegistrations().then(r => r.forEach(sw => sw.unregister()))). Or use fresh context.", "percentage": 88, "note": "Service workers persist and can interfere with network mocking", "command": "context.addInitScript() to unregister service workers"}]$$::jsonb,
    'Understanding service workers impact on testing',
    'Network requests not intercepted by service worker, mocks work',
    'Not clearing service workers, using same context across tests',
    0.88,
    'sonnet-4',
    NOW(),
    'https://playwright.dev/docs/troubleshooting'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Playwright error: Screenshot comparison failed - images differ',
    'playwright',
    'MEDIUM',
    $$[{"solution": "Update snapshots: npx playwright test --update-snapshots. Use threshold for minor differences: expect(page).toHaveScreenshot({threshold: 0.2}). Ensure consistent viewport and fonts.", "percentage": 85, "note": "Visual differences from fonts, rendering - use threshold", "command": "npx playwright test --update-snapshots"}]$$::jsonb,
    'Snapshot testing setup, consistent environment',
    'Snapshots match within threshold, test passes',
    'Different fonts in CI, no threshold for minor differences, viewport inconsistency',
    0.85,
    'sonnet-4',
    NOW(),
    'https://playwright.dev/docs/troubleshooting'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Playwright error: Headed mode not working on Linux',
    'playwright',
    'MEDIUM',
    $$[{"solution": "Install Xvfb for virtual display: apt-get install xvfb. Run with xvfb-run: xvfb-run npx playwright test. Or use headless: true (default).", "percentage": 90, "note": "Linux servers need virtual display for headed mode", "command": "xvfb-run npx playwright test --headed"}]$$::jsonb,
    'Linux server, Xvfb installation',
    'Browser launches in headed mode, display visible',
    'No display server, missing Xvfb, not using xvfb-run',
    0.90,
    'sonnet-4',
    NOW(),
    'https://playwright.dev/docs/troubleshooting'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Playwright error: Download failed or file not found',
    'playwright',
    'MEDIUM',
    $$[{"solution": "Wait for download event: const [download] = await Promise.all([page.waitForEvent(\"download\"), page.click(downloadBtn)]); await download.saveAs(path).", "percentage": 84, "note": "Downloads are async - must wait for download event", "command": "await Promise.all([page.waitForEvent(\"download\"), page.click(btn)])"}]$$::jsonb,
    'Understanding download handling in Playwright',
    'Download completes, file saved to expected path',
    'Not waiting for download event, clicking before setting up wait',
    0.84,
    'sonnet-4',
    NOW(),
    'https://playwright.dev/docs/troubleshooting'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Playwright error: Test hangs - leftover test.step.pause() or page.pause()',
    'playwright',
    'LOW',
    $$[{"solution": "Remove page.pause() and test.step.pause() calls before running in CI. Use PWDEBUG env var for debugging instead: PWDEBUG=1 npx playwright test.", "percentage": 91, "note": "pause() waits for manual interaction - never in CI", "command": "PWDEBUG=1 npx playwright test --debug"}]$$::jsonb,
    'Understanding debug vs CI mode',
    'Tests run without hanging, no pause calls in CI',
    'Leaving pause() in code, using pause() instead of PWDEBUG',
    0.91,
    'sonnet-4',
    NOW(),
    'https://playwright.dev/docs/troubleshooting'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Playwright error: Parallel tests failing with shared state',
    'playwright',
    'MEDIUM',
    $$[{"solution": "Use test.describe.configure({mode: \"serial\"}) for dependent tests. Or isolate state per worker. Each worker gets fresh browser context by default.", "percentage": 87, "note": "Parallel tests share nothing by default - make tests independent", "command": "test.describe.configure({mode: \"serial\"})"}]$$::jsonb,
    'Understanding Playwright parallelization',
    'Tests pass in parallel without state conflicts',
    'Shared database state, dependent tests in parallel, global variables',
    0.87,
    'sonnet-4',
    NOW(),
    'https://playwright.dev/docs/troubleshooting'
);

-- =============================================
-- PYTEST (12 entries)
-- =============================================

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Pytest error: fixture not found',
    'pytest',
    'HIGH',
    $$[{"solution": "Ensure fixture has @pytest.fixture decorator. Place in conftest.py or same module as test. For external fixtures: pytest_plugins = \"package.fixtures\" in conftest.py.", "percentage": 95, "note": "Fixtures auto-discovered from @pytest.fixture in conftest.py", "command": "Move fixture to conftest.py with @pytest.fixture decorator"}]$$::jsonb,
    'Understanding pytest fixture discovery',
    'Fixture found, test runs without fixture error',
    'Missing decorator, wrong file name, fixture in wrong directory',
    0.95,
    'sonnet-4',
    NOW(),
    'https://docs.pytest.org/en/stable/how-to/fixtures.html'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Pytest error: fixture scope mismatch - session cannot use module fixture',
    'pytest',
    'HIGH',
    $$[{"solution": "Scope hierarchy: function < class < module < package < session. Broader scopes can only use fixtures of same or broader scope. Restructure to match hierarchy.", "percentage": 92, "note": "Session fixtures cannot depend on narrower-scoped fixtures", "command": "Change fixture scope to match dependency requirements"}]$$::jsonb,
    'Understanding fixture scope hierarchy',
    'Fixtures resolve without scope errors',
    'Session using function fixtures, wrong scope direction',
    0.92,
    'sonnet-4',
    NOW(),
    'https://docs.pytest.org/en/stable/how-to/fixtures.html'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Pytest error: ModuleNotFoundError during collection',
    'pytest',
    'HIGH',
    $$[{"solution": "Use pytest.importorskip(\"module\") to skip if unavailable. Ensure PYTHONPATH includes project root. Install missing dependencies. Check sys.path.", "percentage": 88, "note": "Gracefully skip tests with missing optional deps", "command": "pytest.importorskip(\"missing_module\") at test start"}]$$::jsonb,
    'PYTHONPATH setup, understanding import resolution',
    'Tests skip gracefully or module imports successfully',
    'Missing project root in path, optional deps not handled',
    0.88,
    'sonnet-4',
    NOW(),
    'https://docs.pytest.org/en/stable/reference.html'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Pytest error: fixture teardown/cleanup not executing',
    'pytest',
    'HIGH',
    $$[{"solution": "Use yield fixtures for guaranteed cleanup:\n@pytest.fixture\ndef resource():\n    setup()\n    yield res\n    cleanup()  # Always runs\nYield ensures cleanup even on test failure.", "percentage": 90, "note": "yield fixtures guarantee cleanup - preferred pattern", "command": "@pytest.fixture with yield and cleanup after"}]$$::jsonb,
    'Understanding fixture lifecycle',
    'Cleanup code runs after test, resources released',
    'Using return instead of yield, cleanup before yield',
    0.90,
    'sonnet-4',
    NOW(),
    'https://docs.pytest.org/en/stable/how-to/fixtures.html'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Pytest error: parametrize not applying or invalid parameter IDs',
    'pytest',
    'MEDIUM',
    $$[{"solution": "@pytest.mark.parametrize(\"param\", [values]) - param name must match function arg exactly (case-sensitive). Use ids= for custom test names. Or pytest.param(val, id=\"name\").", "percentage": 89, "note": "Parameter names case-sensitive, must match function signature", "command": "@pytest.mark.parametrize(\"x,y\", [(1,2)], ids=[\"case1\"])"}]$$::jsonb,
    'Understanding parametrize syntax',
    'Each parameter combination runs as separate test',
    'Parameter name mismatch, ids list wrong length, typos',
    0.89,
    'sonnet-4',
    NOW(),
    'https://docs.pytest.org/en/stable/reference.html'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Pytest error: assertion rewriting not working in helper modules',
    'pytest',
    'MEDIUM',
    $$[{"solution": "Register modules for rewriting in conftest.py BEFORE import: pytest.register_assert_rewrite(\"mymodule\"). Or use --assert=plain flag for raw asserts.", "percentage": 85, "note": "Only test modules get rewriting by default", "command": "pytest.register_assert_rewrite(\"module\") in conftest.py"}]$$::jsonb,
    'Understanding assertion rewriting mechanism',
    'Assertions show detailed introspection in all modules',
    'Not registering before import, wrong module name',
    0.85,
    'sonnet-4',
    NOW(),
    'https://docs.pytest.org/en/stable/how-to/assert.html'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Pytest error: conftest.py not recognized or fixtures not loading',
    'pytest',
    'MEDIUM',
    $$[{"solution": "File must be named exactly conftest.py (case-sensitive). Place in test directory or parent. Pytest discovers conftest.py by walking directories during collection.", "percentage": 91, "note": "Exact filename required, discovered during collection", "command": "Verify filename is exactly conftest.py"}]$$::jsonb,
    'Understanding conftest.py discovery',
    'conftest.py fixtures available to tests in directory',
    'Misspelled filename, wrong directory, file permissions',
    0.91,
    'sonnet-4',
    NOW(),
    'https://docs.pytest.org/en/stable/reference.html'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Pytest error: exit code 5 - no tests were collected',
    'pytest',
    'MEDIUM',
    $$[{"solution": "Check naming: files must be test_*.py or *_test.py, functions must start with test_, classes must start with Test. Use pytest --collect-only to debug.", "percentage": 87, "note": "Strict naming conventions for test discovery", "command": "pytest --collect-only -v"}]$$::jsonb,
    'Understanding pytest naming conventions',
    'Tests collected, exit code 0 or 1 (not 5)',
    'Wrong file naming, wrong function prefix, invalid syntax',
    0.87,
    'sonnet-4',
    NOW(),
    'https://docs.pytest.org/en/6.2.x/usage.html'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Pytest error: -k keyword expression syntax error',
    'pytest',
    'LOW',
    $$[{"solution": "Use Python boolean operators: and, or, not (case-sensitive). Quote expression: pytest -k \"test_name and not slow\". Validate with --collect-only first.", "percentage": 83, "note": "Operators are and/or/not, not &/|/!", "command": "pytest -k \"name and not skip\" --collect-only"}]$$::jsonb,
    'Understanding -k expression syntax',
    'Correct tests selected by keyword expression',
    'Wrong operators, missing quotes, case sensitivity confusion',
    0.83,
    'sonnet-4',
    NOW(),
    'https://docs.pytest.org/en/6.2.x/usage.html'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Pytest assertion output not showing detailed comparison',
    'pytest',
    'HIGH',
    $$[{"solution": "Use assert with message: assert x == y, \"custom message\". Use --tb=long for full traceback. Pytest auto-introspects comparisons for lists, dicts, sets, strings.", "percentage": 92, "note": "Detailed comparison automatic for standard types", "command": "pytest --tb=long for verbose output"}]$$::jsonb,
    'Understanding assertion introspection',
    'Assert output shows detailed expected vs actual',
    'Custom message replacing instead of complementing, wrong --tb flag',
    0.92,
    'sonnet-4',
    NOW(),
    'https://docs.pytest.org/en/stable/how-to/assert.html'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Pytest warning: unraisable exception or unhandled thread exception',
    'pytest',
    'MEDIUM',
    $$[{"solution": "Fix underlying issue: handle exceptions in __del__ methods, join threads in cleanup, use thread-safe patterns. Pytest 6.2+ detects these automatically.", "percentage": 81, "note": "Warnings indicate resource leaks or threading bugs", "command": "Fix __del__ implementations and thread cleanup"}]$$::jsonb,
    'Understanding exception handling, threading',
    'No unraisable/thread exception warnings',
    'Ignoring warnings, incomplete thread cleanup, unsafe __del__',
    0.81,
    'sonnet-4',
    NOW(),
    'https://docs.pytest.org/en/6.2.x/usage.html'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url) VALUES (
    'Pytest error: pytest.main() called twice shows cached imports',
    'pytest',
    'LOW',
    $$[{"solution": "Python caches imports between pytest.main() calls. Use subprocess: subprocess.run([\"pytest\", ...]). Or restart interpreter. pytest-xdist also helps.", "percentage": 88, "note": "Import caching limitation - use subprocess for isolation", "command": "subprocess.run([\"pytest\", \"tests/\"]) for fresh process"}]$$::jsonb,
    'Understanding Python import caching',
    'Test reruns detect file changes',
    'Multiple pytest.main() in same process expecting fresh imports',
    0.88,
    'sonnet-4',
    NOW(),
    'https://docs.pytest.org/en/6.2.x/usage.html'
);
