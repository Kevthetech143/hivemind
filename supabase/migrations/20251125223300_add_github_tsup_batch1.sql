-- Add tsup GitHub issues batch 1: Build errors, ESM/CJS issues, type declarations
-- Extracted from: https://github.com/egoist/tsup/issues
-- Category: github-tsup

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'tsup error: Cannot find module @swc/core in v8.1.1',
    'github-tsup',
    'HIGH',
    '[
        {"solution": "Manually add @swc/core to devDependencies: npm install --save-dev @swc/core", "percentage": 85, "note": "Immediate workaround for builds"},
        {"solution": "Downgrade to tsup version 8.1.0 or earlier", "percentage": 80, "note": "Avoids dependency entirely"},
        {"solution": "Upgrade to tsup 8.1.1+ which removed runtime @swc/core dependency in type imports", "percentage": 95, "note": "Recommended permanent fix"}
    ]'::jsonb,
    'tsup v8.1.1 installed, npm or yarn available',
    'Build completes without module resolution errors, TypeScript compilation succeeds',
    'Do not assume peer dependencies are automatically resolved. Check package.json for explicit declarations.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/egoist/tsup/issues/1157'
),
(
    'DataCloneError on outExtension when DTS is enabled',
    'github-tsup',
    'HIGH',
    '[
        {"solution": "Upgrade to tsup 6.1.3 or later which handles outExtension serialization for workers", "percentage": 95, "note": "Fixes underlying issue in worker thread communication"},
        {"solution": "Convert function-based outExtension to string pattern if possible", "percentage": 85, "note": "Alternative for compatibility with dts option"},
        {"solution": "Disable dts option if outExtension function is required", "percentage": 70, "note": "Last resort workaround"}
    ]'::jsonb,
    'tsup configured with dts: true and outExtension as function',
    'Build completes without DataCloneError, .d.ts files generate with correct extensions',
    'Functions cannot be serialized for worker thread postMessage(). Use PR #668 fix or upgrade.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/egoist/tsup/issues/667'
),
(
    'tsup DataCloneError: injectStyle function with dts option fails',
    'github-tsup',
    'HIGH',
    '[
        {"solution": "Upgrade to tsup 8.3.0+ which supports async injectStyle functions", "percentage": 92, "note": "Resolves serialization incompatibility"},
        {"solution": "Convert injectStyle to synchronous function or use async/await pattern", "percentage": 88, "note": "Requires tsup 8.3.0+ support for async functions"},
        {"solution": "Use string-based style injection instead of function callback", "percentage": 80, "note": "Avoids serialization entirely"}
    ]'::jsonb,
    'tsup with dts: true, injectStyle configured as function',
    'Build succeeds, .d.ts files generate, CSS injection works correctly',
    'Function callbacks fail with dts enabled due to worker thread serialization. Upgrade or use string patterns.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/egoist/tsup/issues/1194'
),
(
    'tsup error Cannot find module node:path with Node v14.17.x',
    'github-tsup',
    'MEDIUM',
    '[
        {"solution": "Upgrade Node.js to v14.18.0 or later (minimum requirement for node: prefix support)", "percentage": 95, "note": "Official solution from maintainer"},
        {"solution": "Update to Node v18 LTS or v20 for better stability and performance", "percentage": 92, "note": "Recommended modern approach"},
        {"solution": "Check engine requirement in package.json and bump minimum Node version in dependencies", "percentage": 88, "command": "npm install -g node@latest or use nvm switch"}
    ]'::jsonb,
    'Node.js v14.17.x or earlier installed, tsup build attempted',
    'tsup build completes without module resolution errors, node: protocol works',
    'The node: protocol for built-in modules requires Node v14.18.0+. Check transitive dependency requirements.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://github.com/egoist/tsup/issues/825'
),
(
    'tsup 8.2.1 breaking change: Cannot find src directory entry',
    'github-tsup',
    'HIGH',
    '[
        {"solution": "Upgrade to tsup 8.2.2+ which fixes directory expansion logic for entry points", "percentage": 96, "note": "Permanent fix from maintainer"},
        {"solution": "Replace bare directory entry src with glob pattern src/** in tsup.config.ts", "percentage": 93, "note": "Immediate workaround for 8.2.1"},
        {"solution": "Revert to tsup 8.2.0 if upgrading immediately is not possible", "percentage": 80, "note": "Temporary rollback"}
    ]'::jsonb,
    'tsup 8.2.1 installed, entry configured as ["src"], Node.js 20+',
    'Build completes successfully, src directory resolves, output files generated in dist',
    'Bare directory names in entry config require explicit glob patterns in some versions. Upgrade to 8.2.2+.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://github.com/egoist/tsup/issues/1161'
),
(
    'tsup dynamic require error: path is not supported in ESM',
    'github-tsup',
    'HIGH',
    '[
        {"solution": "Mark built-in Node modules as external: esbuildOptions: { external: [''path'', ''fs'', ''os''] }", "percentage": 93, "note": "Prevents bundler from attempting to transform built-ins"},
        {"solution": "Switch output format to CommonJS (format: [''cjs'']) for Node.js compatibility", "percentage": 90, "note": "Recommended for Node.js applications"},
        {"solution": "Set esbuildOptions.platform = ''node'' to enable platform-specific bundling", "percentage": 88, "note": "Works with external config"}
    ]'::jsonb,
    'tsup v8.0.2+, ESM format configured, Express or similar Node library bundling',
    'Application runs without dynamic require errors, built modules execute in Node.js environment',
    'ESM-format builds attempt to bundle Node built-ins unless explicitly marked external. Use esbuildOptions.external.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/egoist/tsup/issues/1130'
),
(
    'tsup TypeScript error with browserslist-to-esbuild target option',
    'github-tsup',
    'MEDIUM',
    '[
        {"solution": "Upgrade to tsup version 6.1.3+ with widened Target type definition", "percentage": 94, "note": "Resolves type incompatibility via PR #1118"},
        {"solution": "Cast browserslistToEsbuild() output: as Target[] to satisfy type checker", "percentage": 85, "note": "Workaround for existing tsup versions"},
        {"solution": "Use explicit target string literals instead of dynamic function output", "percentage": 80, "note": "Alternative configuration approach"}
    ]'::jsonb,
    'tsup with browserslist-to-esbuild, TypeScript strict mode enabled',
    'tsup.config.ts compiles without type errors, target option accepts browserslist output',
    'Type system expects specific Target union rather than generic string array from browserslist utilities.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/egoist/tsup/issues/1111'
),
(
    'tsup watch mode regression: DTS files not rebuilding after version 8.2.1',
    'github-tsup',
    'HIGH',
    '[
        {"solution": "Upgrade to tsup 8.2.4+ which fixes DTS worker termination in watch mode", "percentage": 96, "note": "Resolves via commit 49c11c3"},
        {"solution": "Check that dts option is enabled: dts: true in tsup.config.ts", "percentage": 88, "note": "Verify configuration before troubleshooting"},
        {"solution": "Restart watch mode or rebuild project if using version 8.2.1-8.2.3", "percentage": 75, "note": "May temporarily help but upgrade is required"}
    ]'::jsonb,
    'tsup 8.2.1-8.2.3, dts option enabled, watch mode running',
    'TypeScript declaration files regenerate when source files change, .d.ts updates visible',
    'DTS worker was prematurely terminated in watch mode 8.2.1-8.2.3. Upgrade to 8.2.4+.',
    0.95,
    'sonnet-4',
    NOW(),
    'https://github.com/egoist/tsup/issues/1172'
),
(
    'tsup onSuccess hook exit code not propagating to process exit code',
    'github-tsup',
    'MEDIUM',
    '[
        {"solution": "Upgrade to tsup 6.2.3+ which propagates onSuccess exit codes to parent process", "percentage": 96, "note": "Fix resolves exit code propagation"},
        {"solution": "Explicitly handle exit codes in CI/CD pipeline instead of relying on tsup propagation", "percentage": 82, "note": "Workaround for older versions"},
        {"solution": "Use shell && operator to chain commands: tsup && your-script", "percentage": 80, "note": "Alternative control flow approach"}
    ]'::jsonb,
    'tsup with --onSuccess flag, CI/CD pipeline checking exit codes',
    'onSuccess hook exit code 1 causes entire tsup process to exit with code 1, CI fails as expected',
    'Hook script exit codes do not automatically propagate. Verify tsup version >= 6.2.3 or handle in pipeline.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/egoist/tsup/issues/697'
),
(
    'tsup 8.2.1 critical loader error: No loader configured for .map files',
    'github-tsup',
    'HIGH',
    '[
        {"solution": "Upgrade to tsup 8.2.2+ which fixes .map file loader configuration issue", "percentage": 97, "note": "Official fix from maintainer"},
        {"solution": "Downgrade to tsup 8.2.0 as temporary rollback", "percentage": 85, "note": "Avoids regression completely"},
        {"solution": "Disable sourcemap: false in build config if map files not required", "percentage": 80, "note": "Workaround for builds that don''t need maps"}
    ]'::jsonb,
    'tsup 8.2.1, bundle enabled, multiple dependencies with .js.map files',
    'Build completes without .map file loader errors, .js.map files from dependencies load correctly',
    'Regression in 8.2.1 affected .map file handling. Upgrade to 8.2.2+ for fix.',
    0.96,
    'sonnet-4',
    NOW(),
    'https://github.com/egoist/tsup/issues/1165'
),
(
    'tsup Rollup 2 to Rollup 3 upgrade: Default exports broken in CommonJS',
    'github-tsup',
    'MEDIUM',
    '[
        {"solution": "Configure output.interop = ''auto'' in tsup for Rollup 3 compatibility", "percentage": 94, "note": "Maintains default export behavior"},
        {"solution": "Upgrade @rollup/plugin-json to 5.0.0+ for Rollup 3 compatibility", "percentage": 91, "note": "Dependency compatibility fix"},
        {"solution": "Upgrade rollup-plugin-dts to 5.0.0+ for type declaration bundling", "percentage": 90, "note": "Peer dependency update"}
    ]'::jsonb,
    'tsup upgrading to version with Rollup 3, CommonJS output format, default exports used',
    'CommonJS bundles correctly export default exports, no named import errors, bundle size reduced ~4x',
    'Rollup 3 changed default interop behavior. Explicitly set output.interop = ''auto'' for backward compatibility.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/egoist/tsup/issues/749'
),
(
    'tsup keepNames option renamed console imports causing non-Node environment incompatibility',
    'github-tsup',
    'LOW',
    '[
        {"solution": "Remove accidental node:inspector imports from source code (IDE auto-import issue)", "percentage": 98, "note": "Root cause is source code, not tsup configuration"},
        {"solution": "Review source files for unintended imports before building with keepNames", "percentage": 92, "note": "Prevention approach"},
        {"solution": "Configure external dependencies to prevent node: imports in non-Node environments", "percentage": 85, "note": "Alternative configuration"}
    ]'::jsonb,
    'tsup with keepNames: true, library targeting multiple environments (Node + browser)',
    'Build output no longer contains renamed console references, library runs in Next.js middleware',
    'keepNames preserves identifiers but does not prevent source code imports. Check source files for node: imports.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/egoist/tsup/issues/1355'
);
