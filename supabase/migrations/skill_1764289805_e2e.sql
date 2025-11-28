INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'E2E Testing Patterns - Master Playwright and Cypress for reliable end-to-end tests',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Playwright Setup and Configuration",
      "cli": {
        "macos": "npm init playwright@latest && npm run test",
        "linux": "npm init playwright@latest && npm run test",
        "windows": "npm init playwright@latest && npm run test"
      },
      "manual": "Install Playwright, configure playwright.config.ts with baseURL, reporters (html, junit), projects (chromium, firefox, webkit, mobile), and retries for CI",
      "note": "Playwright config enables multi-browser testing, HTML reports, and CI retry handling"
    },
    {
      "solution": "Implement Page Object Model",
      "cli": {
        "macos": "# Create pages/LoginPage.ts with locators and action methods",
        "linux": "# Create pages/LoginPage.ts with locators and action methods",
        "windows": "# Create pages/LoginPage.ts with locators and action methods"
      },
      "manual": "Encapsulate page elements as Locator properties and create methods for user actions (login, fillForm). Separate test logic from page interaction",
      "note": "Page Object Model reduces coupling and improves test maintainability. Reuse page objects across multiple tests"
    },
    {
      "solution": "Use Fixtures for Test Data Setup",
      "cli": {
        "macos": "# Define fixtures in fixtures/test-data.ts with setup/teardown",
        "linux": "# Define fixtures in fixtures/test-data.ts with setup/teardown",
        "windows": "# Define fixtures in fixtures/test-data.ts with setup/teardown"
      },
      "manual": "Create Playwright fixtures for test users, data. Setup before test runs, teardown after. Pass fixtures as function parameters",
      "note": "Fixtures automate test data creation and cleanup. Ensure each test gets fresh, isolated data"
    },
    {
      "solution": "Smart Waiting Strategies",
      "cli": {
        "macos": "await page.waitForLoadState(''networkidle''); // Wait for network idle instead of fixed timeout",
        "linux": "await page.waitForLoadState(''networkidle''); // Wait for network idle instead of fixed timeout",
        "windows": "await page.waitForLoadState(''networkidle''); // Wait for network idle instead of fixed timeout"
      },
      "manual": "Use waitForURL, waitForSelector, waitForResponse instead of fixed timeouts. Prefer assertions that auto-wait (expect().toBeVisible())",
      "note": "Auto-waiting eliminates flaky tests caused by timing issues. Assertions automatically wait up to timeout period"
    },
    {
      "solution": "Network Mocking and Interception",
      "cli": {
        "macos": "await page.route(''**/api/users'', route => route.fulfill(...)); // Mock API responses",
        "linux": "await page.route(''**/api/users'', route => route.fulfill(...)); // Mock API responses",
        "windows": "await page.route(''**/api/users'', route => route.fulfill(...)); // Mock API responses"
      },
      "manual": "Use route() to intercept API calls. Mock responses for error scenarios, slow networks, third-party services without real dependencies",
      "note": "Network mocking speeds up tests and enables testing error handling without real API failures"
    },
    {
      "solution": "Cypress Custom Commands",
      "cli": {
        "macos": "# Define in cypress/support/commands.ts: Cypress.Commands.add(''login'', ...)",
        "linux": "# Define in cypress/support/commands.ts: Cypress.Commands.add(''login'', ...)",
        "windows": "# Define in cypress/support/commands.ts: Cypress.Commands.add(''login'', ...)"
      },
      "manual": "Create custom commands (cy.login, cy.dataCy) to encapsulate repeated test actions. Register TypeScript types for IDE autocomplete",
      "note": "Custom commands reduce test boilerplate and improve readability"
    },
    {
      "solution": "Cypress Intercept for API Mocking",
      "cli": {
        "macos": "cy.intercept(''GET'', ''/api/users'', { statusCode: 200, body: [...] }).as(''getUsers'');",
        "linux": "cy.intercept(''GET'', ''/api/users'', { statusCode: 200, body: [...] }).as(''getUsers'');",
        "windows": "cy.intercept(''GET'', ''/api/users'', { statusCode: 200, body: [...] }).as(''getUsers'');"
      },
      "manual": "Use intercept to mock API responses, simulate slow networks, modify requests. Alias with .as() to wait and validate",
      "note": "Intercept enables testing error states, network delays without real backend. Use cy.wait() to assert API calls"
    },
    {
      "solution": "Visual Regression Testing",
      "cli": {
        "macos": "await expect(page).toHaveScreenshot(''homepage.png'');  // Capture and compare screenshot",
        "linux": "await expect(page).toHaveScreenshot(''homepage.png'');  // Capture and compare screenshot",
        "windows": "await expect(page).toHaveScreenshot(''homepage.png'');  // Capture and compare screenshot"
      },
      "manual": "Use toHaveScreenshot() to capture page or element screenshots. Playwright compares against baseline, fails on visual changes",
      "note": "Visual regression tests catch unintended UI changes. Update baselines intentionally after design changes"
    },
    {
      "solution": "Accessibility Testing with Axe",
      "cli": {
        "macos": "npm install @axe-core/playwright && new AxeBuilder({ page }).analyze()",
        "linux": "npm install @axe-core/playwright && new AxeBuilder({ page }).analyze()",
        "windows": "npm install @axe-core/playwright && new AxeBuilder({ page }).analyze()"
      },
      "manual": "Use Axe accessibility scanner to detect violations. Run on critical pages (forms, navigation). Exclude third-party widgets",
      "note": "Accessibility testing catches keyboard, screen reader issues early. Integrate into CI pipeline"
    },
    {
      "solution": "Use Reliable Selectors",
      "cli": {
        "macos": "# Prefer: getByRole, getByLabel, getByTestId",
        "linux": "# Prefer: getByRole, getByLabel, getByTestId",
        "windows": "# Prefer: getByRole, getByLabel, getByTestId"
      },
      "manual": "Use getByRole (button name), getByLabel (form fields), getByTestId [data-testid], getByText. Avoid CSS classes, nth-child selectors",
      "note": "Semantic selectors survive UI refactoring. data-testid requires marking elements but ensures stability"
    }
  ]'::jsonb,
  'script',
  'Node.js 16+, Playwright or Cypress, understanding of testing concepts, TypeScript optional but recommended, test environment (local or CI)',
  'Common mistakes: Fixed timeouts instead of smart waiting (flaky tests), brittle CSS selectors (tests break on CSS changes), testing implementation details instead of user behavior, coupled tests that depend on each other, no test data cleanup (tests interfere), testing too much with E2E (should use unit/integration tests), no network mocking (slow tests), skipping accessibility testing',
  'Successfully run: Tests pass in parallel, no timing-related flakiness, assertions wait automatically, network calls mocked/intercept working, Page Object locators resolve, custom commands execute, API responses mocked correctly, visual regression detects changes, accessibility scan passes, reliable selectors survive refactoring, tests clean up after themselves',
  'E2E testing skill for Playwright/Cypress with Page Objects, network mocking, and reliable test patterns',
  'https://skillsmp.com/skills/wshobson-agents-plugins-developer-essentials-skills-e2e-testing-patterns-skill-md',
  'admin:HAIKU_SKILL_1764289805_6883'
);
