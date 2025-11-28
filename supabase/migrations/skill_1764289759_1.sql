INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'JavaScript Testing Patterns - Comprehensive testing strategies for JavaScript/TypeScript using Jest, Vitest, Testing Library',
  'claude-code',
  'skill',
  '[{"solution":"Install testing framework","cli":{"macos":"npm install --save-dev vitest","linux":"npm install --save-dev vitest","windows":"npm install --save-dev vitest"},"manual":"Install Vitest or Jest for your project","note":"Choose Vitest for Vite projects, Jest for broader compatibility"},{"solution":"Setup test configuration","manual":"Create vitest.config.ts with test configuration including globals and environment settings","note":"Configure coverage thresholds and test environment"},{"solution":"Write unit tests with AAA pattern","manual":"Create test files with .test.ts or .spec.ts suffix. Use describe/it blocks. Follow Arrange-Act-Assert pattern.","note":"Keep tests focused, one assertion per test when possible"},{"solution":"Mock external dependencies","manual":"Use vi.mock() for modules, vi.fn() for functions. Implement dependency injection for better testability.","note":"Mock at boundaries: external APIs, file system, databases"},{"solution":"Test async operations","manual":"Use async/await in tests. Test both success and error cases. Mock fetch/API calls.","note":"Always handle promise rejections in tests"},{"solution":"Run tests and coverage","cli":{"macos":"npm run test:coverage","linux":"npm run test:coverage","windows":"npm run test:coverage"},"manual":"Execute test suite and generate coverage reports","note":"Aim for 80%+ code coverage"}]'::jsonb,
  'script',
  'Node.js, npm, TypeScript knowledge, modern JavaScript',
  'Testing implementation details instead of behavior; Not mocking external dependencies; Flaky tests due to timing issues; Inadequate coverage of edge cases; Over-testing simple code',
  'All tests pass; Coverage reports show 80%+ coverage; Snapshot tests match expected output; Integration tests verify API behavior; Mock assertions validate correct calls',
  'Master Jest/Vitest for unit, integration, and E2E testing with mocking, fixtures, and TDD workflows',
  'https://skillsmp.com/skills/wshobson-agents-plugins-javascript-typescript-skills-javascript-testing-patterns-skill-md',
  'admin:HAIKU_SKILL_1764289759_1793'
);
