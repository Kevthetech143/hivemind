-- Migration: Add 10 skills from skillsmp (Statistical Hypothesis Testing through Test Automation Framework)
-- Created: 2025-11-28 12:00:00

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email, created_at)
VALUES
-- 1. Statistical Hypothesis Testing
(
  'Statistical Hypothesis Testing',
  'claude-code',
  'skill',
  '[{"solution": "Conduct t-tests, chi-square, ANOVA, and p-value analysis for statistical significance testing", "percentage": 85}, {"solution": "Implement Kaplan-Meier survival curves and Cox proportional hazards models for time-to-event data", "percentage": 80}, {"solution": "Calculate effect sizes, confidence intervals, and power analysis for robust statistical conclusions", "percentage": 75}]',
  'script',
  'NumPy, SciPy, pandas, matplotlib; understanding of null/alternative hypotheses; knowledge of p-values and significance levels',
  'Misinterpreting p-values as probability of hypothesis; multiple testing without correction; ignoring effect sizes; violating test assumptions (independence, normality, homogeneity)',
  'Test results with p-values and test statistics calculated; effect sizes computed (Cohen''s d, eta-squared); distributions visualized; confidence intervals provided; business implications documented',
  'Comprehensive statistical testing framework with t-tests, ANOVA, chi-square, Mann-Whitney U, Kruskal-Wallis, and effect size calculations. Includes visualization, normality testing, power analysis, and bootstrap confidence intervals.',
  'https://skillsmp.com/skills/aj-geddes-useful-ai-prompts-skills-statistical-hypothesis-testing-skill-md',
  'admin:HAIKU_1764340292_29719',
  NOW()
),

-- 2. Stored Procedures & Functions
(
  'Stored Procedures & Functions',
  'claude-code',
  'skill',
  '[{"solution": "Create PostgreSQL and MySQL stored procedures with transaction management and error handling", "percentage": 90}, {"solution": "Implement trigger-based automation for audit trails, timestamps, and validation logic", "percentage": 85}, {"solution": "Design reusable database functions with IMMUTABLE/STABLE/VOLATILE optimization levels", "percentage": 80}]',
  'script',
  'PostgreSQL/MySQL knowledge; PL/pgSQL or MySQL procedural language; transaction management; understanding of triggers and data validation',
  'Putting complex business logic entirely in procedures; ignoring error handling and transactions; creating poorly documented procedures; using procedures as security layer only; incorrect IMMUTABLE designation',
  'Procedures executing without errors; transactions properly managed with rollback on failure; audit trails maintained; triggers updating timestamps; parameter validation preventing invalid data; tests passing',
  'Framework for building stored procedures and functions in PostgreSQL and MySQL with error handling, triggers for audit trails, parameter validation, and performance optimization strategies.',
  'https://skillsmp.com/skills/aj-geddes-useful-ai-prompts-skills-stored-procedures-skill-md',
  'admin:HAIKU_1764340292_29719',
  NOW()
),

-- 3. Stress Testing
(
  'Stress Testing',
  'claude-code',
  'skill',
  '[{"solution": "Implement k6 stress tests with progressive load stages to find breaking points", "percentage": 90}, {"solution": "Develop spike tests, soak/endurance tests, and capacity tests to validate system resilience", "percentage": 85}, {"solution": "Create breaking point analysis using binary search to identify exact capacity limits", "percentage": 75}]',
  'steps',
  'k6, JMeter, or locust installed; understanding of load testing concepts; API/system knowledge; monitoring tools (Prometheus, CloudWatch, DataDog)',
  'Testing in production without safeguards; skipping recovery testing; ignoring warning signs (CPU, memory spikes); testing only happy paths; assuming linear scalability; forgetting database capacity limits',
  'System tested to breaking point with clear capacity limits identified; response times monitored (p95, p99); error rates tracked during stress; auto-scaling behavior validated; memory leaks detected; report generated',
  'Complete stress testing framework with k6 progressive load testing, spike tests, soak tests, JMeter configuration, breaking point analysis with binary search, and auto-scaling validation.',
  'https://skillsmp.com/skills/aj-geddes-useful-ai-prompts-skills-stress-testing-skill-md',
  'admin:HAIKU_1764340292_29719',
  NOW()
),

-- 4. Survival Analysis
(
  'Survival Analysis',
  'claude-code',
  'skill',
  '[{"solution": "Implement Kaplan-Meier survival curves for non-parametric estimation with censored data", "percentage": 90}, {"solution": "Apply Cox proportional hazards model for semi-parametric regression with hazard ratios", "percentage": 85}, {"solution": "Perform log-rank tests and competing risks analysis for group comparisons", "percentage": 80}]',
  'script',
  'lifelines library, pandas, NumPy, matplotlib; understanding of censoring and hazard rates; basic knowledge of time-to-event data; survival probability concepts',
  'Misunderstanding censoring implications; violating proportional hazards assumption; ignoring competing risks; poor handling of tied event times; misinterpreting hazard ratios as odds ratios',
  'Kaplan-Meier curves plotted and median survival calculated; log-rank test p-value computed; Cox model coefficients with concordance index reported; hazard ratios calculated; survival predictions generated; model diagnostics validated',
  'Complete survival analysis implementation with Kaplan-Meier estimation, log-rank tests, Cox proportional hazards regression, competing risks handling, and risk stratification groups.',
  'https://skillsmp.com/skills/aj-geddes-useful-ai-prompts-skills-survival-analysis-skill-md',
  'admin:HAIKU_1764340292_29719',
  NOW()
),

-- 5. Synthetic Monitoring
(
  'Synthetic Monitoring',
  'claude-code',
  'skill',
  '[{"solution": "Create synthetic tests with Playwright to simulate user journeys and API workflows", "percentage": 90}, {"solution": "Implement scheduled monitoring with cron jobs for continuous availability validation", "percentage": 85}, {"solution": "Design end-to-end transaction flow tests for critical business paths", "percentage": 80}]',
  'steps',
  'Playwright or Selenium installed; Node.js/JavaScript or Python; understanding of user workflows; API knowledge; monitoring service setup (DataDog, NewRelic, or custom)',
  'Testing with production data instead of test accounts; reusing same test accounts; hard-coded credentials in tests; ignoring timeout configurations; testing only happy paths; skipping mobile/desktop variations',
  'Synthetic tests executing on schedule without manual intervention; critical user journeys validated automatically; API flows tested end-to-end; alerts triggered on failures; metrics collected and reported; mobile and desktop coverage',
  'Synthetic monitoring framework with Playwright for user journey simulation, API workflow testing, scheduled execution with cron, performance metrics collection, and multi-device testing.',
  'https://skillsmp.com/skills/aj-geddes-useful-ai-prompts-skills-synthetic-monitoring-skill-md',
  'admin:HAIKU_1764340292_29719',
  NOW()
),

-- 6. Technical Debt Assessment
(
  'Technical Debt Assessment',
  'claude-code',
  'skill',
  '[{"solution": "Quantify and prioritize technical debt using impact analysis and ROI calculations", "percentage": 90}, {"solution": "Implement code quality scanning for anti-patterns, code complexity, and coverage gaps", "percentage": 85}, {"solution": "Create technical debt metrics dashboard and track debt over time", "percentage": 75}]',
  'steps',
  'SonarQube, Code Climate, or ESLint for code scanning; understanding of debt categories (code quality, architecture, testing, documentation, security); metrics analysis; TypeScript/Python knowledge for custom scanners',
  'Ignoring technical debt or trying to fix everything at once; making emotional decisions without quantification; skipping impact analysis; underestimating legacy system complexity; not documenting debt rationale',
  'Debt items quantified with effort hours and impact scores; priority rankings calculated by ROI; debt categorized by type (code, architecture, test, documentation, security); reports generated; roadmap includes debt reduction',
  'Framework for assessing and managing technical debt with TypeScript quality scanner, debt prioritization calculator, code metrics collection, and debt tracking dashboard.',
  'https://skillsmp.com/skills/aj-geddes-useful-ai-prompts-skills-technical-debt-assessment-skill-md',
  'admin:HAIKU_1764340292_29719',
  NOW()
),

-- 7. Technical Roadmap Planning
(
  'Technical Roadmap Planning',
  'claude-code',
  'skill',
  '[{"solution": "Create multi-quarter technical roadmaps aligned with business strategy and goals", "percentage": 90}, {"solution": "Map dependencies between initiatives and identify critical path for planning", "percentage": 85}, {"solution": "Evaluate technologies using weighted scoring framework and assess long-term debt impact", "percentage": 80}]',
  'steps',
  'Understanding of technology stack; stakeholder communication skills; knowledge of cloud platforms (AWS, Azure, GCP); project management basics; financial/cost analysis understanding',
  'Pursuing every technology trend without business value; planning at 100% utilization with no buffer; ignoring team capability and training needs; making major changes during peak usage periods; underestimating legacy system work',
  'Roadmap covers 12-24 months with clear quarterly milestones; dependencies mapped and critical path identified; risk assessment completed; team input gathered; quarterly reviews scheduled; technology choices documented with rationale',
  'Technical roadmap planning framework with multi-quarter planning templates, dependency mapping, critical path analysis, technology evaluation matrix, and execution planning guides.',
  'https://skillsmp.com/skills/aj-geddes-useful-ai-prompts-skills-technical-roadmap-planning-skill-md',
  'admin:HAIKU_1764340292_29719',
  NOW()
),

-- 8. Technical Specification
(
  'Technical Specification',
  'claude-code',
  'skill',
  '[{"solution": "Create comprehensive technical specs with requirements, architecture, and API design", "percentage": 90}, {"solution": "Document system design with data models, implementation plans, and testing strategy", "percentage": 85}, {"solution": "Define security considerations, risks, and success criteria for feature delivery", "percentage": 80}]',
  'steps',
  'System design knowledge; API design patterns; database schema design; requirements analysis; security best practices; technical writing; stakeholder communication skills',
  'Being vague about requirements; skipping non-functional requirements (performance, security, scalability); forgetting about security and compliance; ignoring alternatives and tradeoffs; skipping testing strategy; hard-coding specific values',
  'Spec document complete with all sections (background, requirements, architecture, design, testing, security); acceptance criteria clear and measurable; API contracts well-defined; data models documented; implementation timeline realistic',
  'Comprehensive technical specification template with sections for background, functional/non-functional requirements, system architecture, data models, API design, testing strategy, security, and success criteria.',
  'https://skillsmp.com/skills/aj-geddes-useful-ai-prompts-skills-technical-specification-skill-md',
  'admin:HAIKU_1764340292_29719',
  NOW()
),

-- 9. Terraform Infrastructure
(
  'Terraform Infrastructure',
  'claude-code',
  'skill',
  '[{"solution": "Build modular Terraform configurations for AWS/Azure/GCP infrastructure provisioning", "percentage": 90}, {"solution": "Implement remote state management with S3 and DynamoDB locking for team collaboration", "percentage": 85}, {"solution": "Create multi-environment deployments using workspaces and variable files", "percentage": 80}]',
  'script',
  'Terraform CLI; AWS/Azure/GCP account; remote state backend configured; understanding of IaC concepts; cloud platform knowledge; Git for version control',
  'Storing state files in git; using hard-coded values instead of variables; mixing environments in single state; skipping plan review before apply; disabling state locking; storing secrets in code; over-complex root modules',
  'Terraform code formatted and validated (terraform fmt, terraform validate passed); state stored remotely with locking enabled; plan generated and reviewed; apply executed successfully; infrastructure deployed; multi-environment support working',
  'Complete Terraform infrastructure framework with AWS VPC/networking setup, modular organization, remote state configuration, multi-workspace support, security groups, ALB, and automated deployment scripts.',
  'https://skillsmp.com/skills/aj-geddes-useful-ai-prompts-skills-terraform-infrastructure-skill-md',
  'admin:HAIKU_1764340292_29719',
  NOW()
),

-- 10. Test Automation Framework
(
  'Test Automation Framework',
  'claude-code',
  'skill',
  '[{"solution": "Design Page Object Model architecture for scalable UI test automation with Playwright", "percentage": 90}, {"solution": "Implement fixtures, factories, and configuration management for test data and environments", "percentage": 85}, {"solution": "Create custom reporters, utilities, and helpers for maintainable test code", "percentage": 80}]',
  'steps',
  'Playwright/Selenium; TypeScript or Python; test organization best practices; fixture and factory patterns; understanding of POM architecture; CI/CD integration knowledge',
  'Duplicating test logic across tests; using hard-coded waits instead of proper waits; mixing test data with test logic; putting business logic in page objects; skipping error handling; ignoring test flakiness; hard-coding URLs',
  'Framework structured with page objects, fixtures, utilities, and reporters; test suites organized by feature/type; configuration management per environment; custom helpers reducing code duplication; tests running reliably with proper waits',
  'Complete test automation framework with Page Object Model, Playwright/Selenium integration, fixtures, factories, configuration management, custom reporters, and utilities for E2E, API, and integration testing.',
  'https://skillsmp.com/skills/aj-geddes-useful-ai-prompts-skills-test-automation-framework-skill-md',
  'admin:HAIKU_1764340292_29719',
  NOW()
);
