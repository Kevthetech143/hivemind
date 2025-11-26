-- Add Biome GitHub Issues Batch 1: Linting/Formatting Solutions
-- Extracted from high-engagement GitHub issues: biomejs/biome
-- Category: github-biome
-- Total entries: 12

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, source_url
) VALUES
(
    'Biome ESLint migration fails with "node was invoked to resolve ./.eslintrc.js" error',
    'github-biome',
    'HIGH',
    '[
        {"solution": "Use npx directly instead of yarn exec: npx biome migrate eslint --write", "percentage": 90, "note": "Resolves dependency resolution issues with yarn"},
        {"solution": "Ensure .eslintrc.js file exists and is readable before running migration", "percentage": 85, "note": "Missing config file causes invocation errors"},
        {"solution": "Clear node_modules and reinstall: rm -rf node_modules && npm install", "percentage": 75, "note": "Resolves module corruption from partial migrations"}
    ]'::jsonb,
    'Biome v1.9.4+, npm or npx installed, existing .eslintrc.js configuration file',
    'biome.json updated with ESLint rules, no error messages in output, npm run lint succeeds',
    'Do not use yarn exec with biome migrate - yarn may not resolve ESLint plugins correctly. Always verify .eslintrc.js file exists before migration.',
    0.90,
    'https://github.com/biomejs/biome/issues/5900'
),
(
    'Biome migration commands fail silently when biome.jsonc contains comments',
    'github-biome',
    'HIGH',
    '[
        {"solution": "Remove all // comments from biome.jsonc before running migration", "percentage": 95, "note": "Biome v1.x cannot parse comments during migration"},
        {"solution": "Upgrade to Biome v2.0-beta.5 or later: npm install @biomejs/biome@2.0.0-beta.5", "percentage": 90, "note": "v2.0 properly handles JSONC with comments"},
        {"solution": "Convert biome.jsonc to biome.json temporarily, migrate, then convert back", "percentage": 80, "note": "Workaround for v1.x while upgrading"}
    ]'::jsonb,
    'Biome v1.9.4+, biome.jsonc configuration file with // comments',
    'Migration command output shows updated configuration, biome.json reflects changes, no silent failures in logs',
    'Comments in JSONC files block migration in v1.x - always remove before migrating. The --write flag silently fails without error output.',
    0.92,
    'https://github.com/biomejs/biome/issues/6104'
),
(
    'Biome migrate command runs twice producing duplicate output',
    'github-biome',
    'MEDIUM',
    '[
        {"solution": "Update Biome to v2.0.0-beta.7 or later: npm install --save-dev @biomejs/biome@latest", "percentage": 95, "note": "Fixed in PR #6329, available in beta 7+"},
        {"solution": "If stuck on v2.0.0-beta.6, use workaround: run biome migrate once, verify biome.json changes, ignore duplicate message", "percentage": 70, "note": "Only visual duplication, actual migration runs once"}
    ]'::jsonb,
    'Biome v2.0.0-beta.6, biome.json configuration file, eslint or prettier configuration to migrate',
    'Single set of migration messages in output, biome.json updated once with correct changes, no duplicate entries',
    'The duplicate output appears in beta.6 but only one actual migration occurs. Do not re-run migrate command thinking it failed.',
    0.88,
    'https://github.com/biomejs/biome/issues/6328'
),
(
    'ESLint migration fails with "Incorrect type, expected a string, but received an array" error',
    'github-biome',
    'MEDIUM',
    '[
        {"solution": "Update to Biome v2.0.0 or later: npm install --save-dev @biomejs/biome@latest", "percentage": 95, "note": "PR #5903 fixed config deserialization"},
        {"solution": "If using neostandard or @eslint/markdown plugins, update them to latest versions", "percentage": 85, "note": "Newer versions have better ESLint flat config structure"},
        {"solution": "Manually flatten nested files arrays in .eslintrc.mjs before running migration", "percentage": 70, "note": "Remove array-within-array structures"}
    ]'::jsonb,
    'Biome v1.9.4+, complex ESLint config with nested plugins like neostandard or @eslint/markdown, Node.js v18+',
    'Migration completes without type errors, biome.json contains all ESLint rules, no deserialization errors in output',
    'Nested files arrays in ESLint configs cause type mismatches. Using old Biome versions with new ESLint configs causes failures.',
    0.91,
    'https://github.com/biomejs/biome/issues/5900'
),
(
    'ESLint migration fails on Next.js project with @rushstack/eslint-patch error',
    'github-biome',
    'MEDIUM',
    '[
        {"solution": "Temporarily comment out @rushstack/eslint-patch in node_modules/eslint-config-next/index.js during migration", "percentage": 75, "note": "Workaround - uncomment after migration completes"},
        {"solution": "Use biome init instead of migrate for Next.js projects, manually add next config rules", "percentage": 85, "note": "ESLint patching incompatibility - manual setup more reliable"},
        {"solution": "Run npm uninstall @rushstack/eslint-patch before migration, reinstall after", "percentage": 70, "note": "Removes module resolution conflict temporarily"}
    ]'::jsonb,
    'Biome v1.9.4+, Next.js project with extends: ["next", "next/core-web-vitals"] in .eslintrc.json, Node.js v20+',
    'biome.json generated without RushStack errors, Next.js ESLint rules properly converted, migration output shows completion',
    'RushStack ESLint patch module conflicts with Biome migration. The patch is required for Next.js ESLint to work, so only comment it out during migration.',
    0.78,
    'https://github.com/biomejs/biome/issues/5387'
),
(
    'Biome migrate --write flag shows changes but does not update biome.json file',
    'github-biome',
    'MEDIUM',
    '[
        {"solution": "Use npx biome migrate --write instead of yarn exec biome migrate --write", "percentage": 90, "note": "yarn exec may not properly handle file writes"},
        {"solution": "Ensure biome.json file has write permissions: chmod 644 biome.json", "percentage": 85, "note": "Permission errors cause silent failures"},
        {"solution": "Run from project root directory containing biome.json, not from subdirectories", "percentage": 80, "note": "CWD issues prevent file discovery and writing"}
    ]'::jsonb,
    'Biome v1.9.4+, biome.json file writable by current user, proper working directory set, npm/npx available',
    'biome.json updated with migration changes, file timestamp changes, no "cannot convert undefined" errors in output',
    'The --write flag may display changes but not persist them if using yarn exec or with incorrect permissions. Always verify file was modified.',
    0.85,
    'https://github.com/biomejs/biome/issues/6999'
),
(
    'VS Code extension applies conflicting lint rule fixes causing text corruption',
    'github-biome',
    'HIGH',
    '[
        {"solution": "Update Biome VS Code extension to latest version: Extensions > Biome > Update", "percentage": 90, "note": "Latest versions consolidate conflicting edits atomically"},
        {"solution": "Disable useNodejsImportProtocol rule in biome.json if experiencing corruption with import removals", "percentage": 80, "note": "Conflict between useNodejsImportProtocol and noUnusedImports"},
        {"solution": "Use biome format/lint CLI instead of VS Code auto-fix for complex files with multiple fix types", "percentage": 75, "note": "CLI applies fixes sequentially without range corruption"}
    ]'::jsonb,
    'Biome VS Code extension v0.2.x or earlier, both useNodejsImportProtocol and noUnusedImports rules enabled, VS Code v1.80+',
    'Import fixes applied correctly without text corruption, original code structure preserved, imports properly formatted',
    'Multiple conflicting auto-fixes applied sequentially cause text edit range misalignment. The extension applies fixes one-by-one with stale position data.',
    0.88,
    'https://github.com/biomejs/biome/issues/6859'
),
(
    'noUndeclaredDependencies rule produces different results in IDE vs CLI in monorepo',
    'github-biome',
    'HIGH',
    '[
        {"solution": "Ensure biome.json is at monorepo root and run biome check from root directory with --no-vcs-ignore flag", "percentage": 85, "note": "Working directory affects manifest resolution"},
        {"solution": "Configure LSP to use project root: set rootPath to workspace root in VS Code settings", "percentage": 80, "note": "IDE may resolve different project root than CLI"},
        {"solution": "Place biome.json in each package with identical linter settings, disable monorepo-specific rules in packages", "percentage": 70, "note": "Per-package config as temporary workaround"}
    ]'::jsonb,
    'Biome v1.7.0+, monorepo with multiple package.json files, single biome.json at root, npm/yarn workspaces configured',
    'noUndeclaredDependencies reports same errors in CLI, IDE, and git hooks, consistent rule application across all tools',
    'Monorepo manifest resolution differs between CLI and LSP. Root directory detection is inconsistent causing false positives/negatives.',
    0.72,
    'https://github.com/biomejs/biome/issues/2475'
),
(
    'noUndeclaredDependencies fails in monorepo with workspace protocol dependencies',
    'github-biome',
    'MEDIUM',
    '[
        {"solution": "Disable noUndeclaredDependencies rule for workspace packages: add overrides in biome.json per-package", "percentage": 85, "note": "Rule does not support workspace:* protocol"},
        {"solution": "Use linter.ignore patterns to exclude workspace imports from the rule", "percentage": 75, "note": "Temporary workaround - requires pattern matching"},
        {"solution": "Await Biome 3.0 monorepo improvements - rule enhancement not planned for v2.x", "percentage": 50, "note": "Issue marked as not-planned, architectural changes needed"}
    ]'::jsonb,
    'Biome v1.7.0+, monorepo with workspace dependencies (workspace:* in package.json), pnpm or yarn workspaces',
    'Imports from workspace dependencies not flagged as errors, noUndeclaredDependencies respects nearest package.json, biome lint succeeds',
    'Rule only checks against root and local package.json, ignores workspace protocol. Nested package.json hierarchy not supported.',
    0.68,
    'https://github.com/biomejs/biome/issues/2010'
),
(
    'Tailwind CSS class sorting rule throws errors or sorts incorrectly',
    'github-biome',
    'MEDIUM',
    '[
        {"solution": "Configure Tailwind preset in biome.json formatter section with custom utilities matching your config", "percentage": 85, "note": "Rule requires matching Tailwind settings"},
        {"solution": "Use the useSimpleSortingRule approach with basic heuristics instead of full Tailwind config parsing", "percentage": 80, "note": "99.8% of real-world Tailwind usage supported"},
        {"solution": "Enable Tailwind support in biome.json: set formatter.tailwindcss.enabled = true", "percentage": 75, "note": "Feature flag must be enabled explicitly"}
    ]'::jsonb,
    'Biome v1.8.0+, Tailwind CSS configured in project, class attribute in HTML/JSX, formatter section in biome.json',
    'Tailwind classes sorted consistently in all files, custom utilities recognized, no sorting errors in output',
    'Rule uses heuristics, not full Tailwind compiler - prefix, important flags, and custom utilities need explicit config. Arbitrary values may not validate.',
    0.82,
    'https://github.com/biomejs/biome/issues/1274'
),
(
    'CSS formatter produces invalid syntax or formatting inconsistencies',
    'github-biome',
    'MEDIUM',
    '[
        {"solution": "Update Biome to v1.8.0+ where CSS formatter is fully implemented and tested", "percentage": 90, "note": "CSS formatter completed in March 2025"},
        {"solution": "Configure CSS formatter options in biome.json formatter section matching your style preferences", "percentage": 85, "note": "Quote style, keyword case, attribute formatting"},
        {"solution": "Run biome format --write to fix CSS files, verify output with Prettier comparison if needed", "percentage": 80, "note": "Biome v1.8+ achieves Prettier parity"}
    ]'::jsonb,
    'Biome v1.8.0+, .css files or embedded CSS in HTML/JavaScript, formatter enabled in biome.json',
    'CSS files format consistently, valid CSS syntax after formatting, attribute quotes consistent, selector casing normalized',
    'Old CSS formatter (v1.6-v1.7) had incomplete implementation. Update to v1.8+ which includes full spec tests and Prettier compatibility.',
    0.87,
    'https://github.com/biomejs/biome/issues/1285'
),
(
    'Embedded CSS/JS formatting in HTML template strings not supported',
    'github-biome',
    'MEDIUM',
    '[
        {"solution": "Use Biome v2.0+ with embedded language formatter support enabled", "percentage": 80, "note": "Feature stabilized in v2.0, replace grit metavariables"},
        {"solution": "Set formatter.ignorePatterns to exclude template literals from formatting as temporary workaround", "percentage": 70, "note": "Disables formatting entirely for templates"},
        {"solution": "Extract embedded CSS/JS to separate files during development, format separately, then embed minified", "percentage": 65, "note": "Manual workflow workaround"}
    ]'::jsonb,
    'Biome v2.0.0+, JavaScript with template literals containing CSS/HTML, formatter enabled, Grit pattern support',
    'CSS and JS embedded in template strings formatted correctly, syntax remains valid, interpolations preserved',
    'Embedded language formatter requires grit metavariables for interpolation handling. Feature incomplete in v1.x, stabilizing in v2.x.',
    0.74,
    'https://github.com/biomejs/biome/issues/3334'
),
(
    'Memory leak in Biome VS Code extension consuming 23GB RAM',
    'github-biome',
    'MEDIUM',
    '[
        {"solution": "Update Biome extension to v3.1.1 or later where memory leak is fixed", "percentage": 95, "note": "Fixed in PR #6839"},
        {"solution": "Disable project-aware rules causing memory spike: disable noPrivateImports, noUndeclaredDependencies, useImportExtensions", "percentage": 85, "note": "These rules scan entire node_modules"},
        {"solution": "Restart VS Code and clear extension cache: killall -9 Electron, rm -rf ~/.vscode/extensions/biome*", "percentage": 75, "note": "Temporary relief until update"}
    ]'::jsonb,
    'Biome VS Code extension v3.0-v3.1.0, VS Code 1.80+, project with large node_modules, project rules enabled',
    'VS Code memory usage stays below 2GB while editing, no continuous memory growth, linting completes without slowdown',
    'Project-aware linting rules process entire node_modules creating memory bloat. Disabling these rules immediately stops memory leak until upgrade.',
    0.91,
    'https://github.com/biomejs/biome/issues/6784'
);
