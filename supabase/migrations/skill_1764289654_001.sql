INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'React Modernization - Upgrade React applications to latest versions, migrate from class components to hooks, and adopt concurrent features',
  'claude-code',
  'skill',
  '[
    {"solution": "Version Upgrade Path: React 16 → 17 → 18", "manual": "Follow incremental upgrade path. React 17 introduces event delegation changes and JSX transform. React 18 adds automatic batching, concurrent rendering, and new root API. Review breaking changes in release notes before upgrading."},
    {"solution": "Class to Hooks Migration", "manual": "Convert state to useState, lifecycle methods to useEffect, context consumers to useContext. Start with leaf components. Test thoroughly at each step. Use custom hooks to extract logic."},
    {"solution": "React 18 Concurrent Features", "manual": "Adopt useTransition for non-urgent updates, Suspense for data fetching, and automatic batching. Use flushSync to opt out of batching when needed. Test with StrictMode to catch double invocation issues."},
    {"solution": "Codemods for Automation", "cli": {"macos": "npx react-codeshift --parser=tsx --transform=react-codeshift/transforms/new-jsx-transform.js src/", "linux": "npx react-codeshift --parser=tsx --transform=react-codeshift/transforms/new-jsx-transform.js src/", "windows": "npx react-codeshift --parser=tsx --transform=react-codeshift/transforms/new-jsx-transform.js src/"}, "manual": "Install jscodeshift globally. Run React codemods to automate repetitive transformations. Create custom codemods for project-specific patterns."},
    {"solution": "Performance Optimization", "manual": "Use useMemo for expensive calculations, useCallback for stable callbacks, React.memo for component memoization, and code splitting with lazy/Suspense. Measure performance before and after optimizations."},
    {"solution": "TypeScript Migration", "manual": "Add interfaces for component props, use React.ReactNode for children, create generic components with proper type parameters. Update @types/react when upgrading."}
  ]'::jsonb,
  'steps',
  'React knowledge, JavaScript fundamentals, familiarity with class components and lifecycle methods',
  'Forgetting useEffect dependencies, over-using useMemo/useCallback, not handling cleanup in useEffect, mixing class and functional patterns, ignoring StrictMode warnings, breaking change assumptions',
  'All components successfully migrated to functional hooks, tests pass, no console warnings, performance metrics maintained or improved, React 18 features adopted',
  'Systematic approach to modernizing React codebases through version upgrades, class-to-hooks migration, and adoption of concurrent features',
  'https://skillsmp.com/skills/wshobson-agents-plugins-framework-migration-skills-react-modernization-skill-md',
  'admin:HAIKU_SKILL_1764289654_89802'
);
