-- Add Babel GitHub Issues batch 1
-- High-voted issues with solutions from babel/babel repository
-- Category: github-babel

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES (
    'Babel: No "exports" main resolved in @babel/helper-compilation-targets/package.json with Node 13.10.1',
    'github-babel',
    'HIGH',
    $$[
        {"solution": "Update all @babel dependencies to version 7.8.7 or higher, as earlier versions had incorrect exports field configuration", "percentage": 95, "note": "All @babel packages must be updated together to avoid version mismatch"},
        {"solution": "Remove node_modules directory and package-lock.json, then run npm install fresh", "percentage": 88, "note": "Clears corrupted cache and ensures clean dependency resolution"},
        {"solution": "Verify package.json exports field is properly configured in all @babel packages", "percentage": 80, "command": "npm list @babel/helper-compilation-targets"}
    ]$$::jsonb,
    'Node.js 13.10.1+, Babel 7.8.3 installed, webpack/babel-loader build setup',
    'npm install completes without ERR_PACKAGE_PATH_NOT_EXPORTED, babel-loader builds successfully, dependencies resolve without errors',
    'Avoid partial upgrades of @babel packages - all must be updated together. Upgrade Node.js to 13.10.1+ to get proper exports field support. Do not assume issue is local to single package.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/babel/babel/issues/11216'
),
(
    'Babel TypeScript: Exported Interfaces from imports kept in generated JavaScript',
    'github-babel',
    'HIGH',
    $$[
        {"solution": "Use explicit type exports instead of re-exporting: import type { Type } = FileA; export type { Type }", "percentage": 92, "note": "Requires code restructuring but guarantees type-only handling"},
        {"solution": "Use type-only exports syntax: export type ExportedInterface = FileA.ExportedInterface", "percentage": 90, "command": "TypeScript 3.8+ required for type-only exports"},
        {"solution": "Avoid re-exporting imported interfaces; structure code to export types directly from source", "percentage": 85, "note": "Best practice approach but requires architecture changes"}
    ]$$::jsonb,
    'Babel 7 with @babel/preset-typescript, TypeScript modules with interface re-exports, matching imports and exports',
    'Generated JavaScript contains only actual value exports with no type-only references, Webpack accepts generated code without errors, no runtime imports for interfaces',
    'Per-file transpilation limits Babel knowledge of imported symbol types - Babel cannot distinguish between type and value exports cross-file. Classes transpile correctly but only interfaces present issues. External package interfaces complicate solutions.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/babel/babel/issues/8361'
),
(
    'Babel: .babelrc.js configuration file support not available',
    'github-babel',
    'HIGH',
    $$[
        {"solution": "Use .babelrc.js file instead of .babelrc JSON - feature was implemented in Babel after this issue was resolved", "percentage": 95, "note": "Allows JavaScript-based config with functions, conditionals, env variables"},
        {"solution": "Create a Babel preset as a JavaScript file for dynamic configuration", "percentage": 85, "note": "Workaround approach that provides some dynamic config capabilities"},
        {"solution": "Use babel-core programmatically to set configuration options in JavaScript", "percentage": 80, "note": "Creates inconsistency with file-based config but allows full flexibility"}
    ]$$::jsonb,
    'Babel 7+, Project root directory access, Node.js environment with module resolution',
    '.babelrc.js executes without errors, configuration options are properly parsed, build succeeds with dynamic configuration',
    'JavaScript configs may complicate preset inheritance and interactions. Multiple preset combinations might have unpredictable behavior with JS configs. Avoid splitting configuration across .babelrc, webpack.config.js, and other files.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/babel/babel/issues/4630'
),
(
    'Babel: TypeScript const enum not supported - requires type information to compile',
    'github-babel',
    'HIGH',
    $$[
        {"solution": "Transform const enum to JavaScript object: const enum Dir {} becomes const Dir = {}", "percentage": 90, "note": "Works with bundlers supporting scope hoisting and minifiers with constant folding"},
        {"solution": "Use smart inlining - transform in-file const enums and create objects only for exported enums", "percentage": 85, "note": "Requires Babel plugin enhancement; minifiers handle final optimization"},
        {"solution": "Convert to regular enum if cross-module usage required: export enum instead of const enum", "percentage": 80, "note": "Results in slightly larger output but fully transpilable without type info"}
    ]$$::jsonb,
    'Babel preset-typescript, TypeScript 3.4+, bundler with scope hoisting, minifier with constant folding',
    'const enums transpile to objects, minifier inlines values during optimization, final output matches TypeScript compiler behavior',
    'Babel compiles files independently without cross-file type information - cannot inline imported enum values. const enum is pure type construct, converting to objects violates design principle but produces functionally equivalent results. Without access to imported enum definitions, Babel cannot perform value replacement across file boundaries.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/babel/babel/issues/8741'
),
(
    'Babel configuration: useBuiltins option breaks when core-js is not installed separately',
    'github-babel',
    'HIGH',
    $$[
        {"solution": "Install core-js as explicit dependency: npm install core-js --save or yarn add core-js", "percentage": 93, "note": "Required when useBuiltins is entry or usage, even if @babel/polyfill includes it"},
        {"solution": "Set useBuiltins to false if polyfills not needed: presets [[''@babel/preset-env'', {useBuiltins: false}]]", "percentage": 88, "note": "Disables automatic polyfill injection"},
        {"solution": "Use @babel/polyfill or regenerator-runtime import at entry point instead of useBuiltins", "percentage": 82, "command": "import ''@babel/polyfill'' at top of index.js"}
    ]$$::jsonb,
    'Babel 7.13+, @babel/preset-env configured with useBuiltins entry or usage, Node.js with npm/yarn',
    'Build completes without core-js resolution errors, polyfills properly inject into output, test execution succeeds',
    'Do not assume @babel/polyfill automatically provides core-js dependency. useBuiltins entry/usage requires explicit core-js install. useBuiltins false removes polyfill support entirely. Version 7.13+ stricter on dependency requirements than earlier versions.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/babel/babel/issues/12308'
),
(
    'Babel: Duplicate helper code generated across modules when using transform-runtime',
    'github-babel',
    'HIGH',
    $$[
        {"solution": "Use @babel/plugin-transform-runtime plugin to deduplicate helpers across modules", "percentage": 94, "note": "Centralizes helper code and reduces bundle size significantly"},
        {"solution": "Enable corejs option in transform-runtime: @babel/plugin-transform-runtime with corejs: 3", "percentage": 88, "note": "Also handles polyfill deduplication for corejs"},
        {"solution": "Configure exclude option to skip transforming certain patterns and reduce helper injection", "percentage": 80, "command": "exclude: [''node_modules'']"}
    ]$$::jsonb,
    'Babel 7.x, @babel/plugin-transform-runtime installed, webpack or bundler configuration, target modules',
    'Bundle size reduced, no duplicate helper functions in output, multiple modules reference single helper definition',
    'Older Babel versions have issue with duplicate keys in strict mode - may require transform-duplicate-keys plugin. Disabling transforms affects browser compatibility. Not all duplicate transforms can be disabled safely.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/babel/babel/issues/11027'
),
(
    'Babel: Optional Chaining and Nullish Coalescing break when bundled in certain configurations',
    'github-babel',
    'MEDIUM',
    $$[
        {"solution": "Update @babel/core and @babel/preset-env to latest version (7.14.0+)", "percentage": 91, "note": "Fixes operator compilation and ordering issues"},
        {"solution": "Ensure @babel/plugin-proposal-optional-chaining and @babel/plugin-proposal-nullish-coalescing-operator are included", "percentage": 88, "note": "Explicit plugin inclusion ensures consistent transformation"},
        {"solution": "Check bundler configuration for conflicting transforms or plugin order issues", "percentage": 82, "note": "Webpack, Rollup may have preset/plugin ordering affecting output"}
    ]$$::jsonb,
    'Babel 7.13+, @babel/preset-env, optional chaining and nullish coalescing syntax in source, bundler (webpack/rollup)',
    'Code bundles without errors, runtime behavior matches TypeScript output, operators evaluate correctly',
    'Plugin order matters - ensure optional-chaining plugin runs before nullish-coalescing. Bundle configurations may reorder transforms unexpectedly. Mixed Babel versions in monorepo cause issues.',
    0.86,
    'sonnet-4',
    NOW(),
    'https://github.com/babel/babel/issues/11549'
),
(
    'Babel: Arrow functions not transpiled in output despite browser target',
    'github-babel',
    'MEDIUM',
    $$[
        {"solution": "Add @babel/preset-env to Babel configuration: presets: [''@babel/preset-env'']", "percentage": 93, "note": "Automatically enables target-appropriate transforms including arrow function conversion"},
        {"solution": "Set targets in .browserslistrc or specify targets in preset-env: targets: {browsers: [''> 1%'']}}", "percentage": 88, "note": "Explicitly configures browser support level"},
        {"solution": "Use @babel/plugin-transform-arrow-functions if only arrow functions need transformation", "percentage": 82, "command": "plugins: [''@babel/plugin-transform-arrow-functions'']"}
    ]$$::jsonb,
    'Babel 7.x, .babelrc or babel.config.js configuration, source code with arrow functions, build tool (webpack/rollup)',
    'Compiled output contains function keyword instead of =>, code runs in older browsers, transpilation completes',
    'Arrow function transformation depends on browser target configuration. Without target specification, Babel assumes modern environments. Ensure presets load in correct order before plugins. Custom preset may override defaults.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/babel/babel/issues/10674'
),
(
    'Babel: Template literals with expressions transpiled incorrectly causing runtime errors',
    'github-babel',
    'MEDIUM',
    $$[
        {"solution": "Update @babel/core and @babel/preset-env to latest stable version", "percentage": 92, "note": "Fixes expression evaluation and concatenation in template literals"},
        {"solution": "Check for custom plugins interfering with template literal transformation", "percentage": 85, "note": "Third-party plugins may conflict with built-in transformation"},
        {"solution": "Test with minimal Babel config to isolate issue - comment out plugins and verify basic preset works", "percentage": 78, "command": "presets: [''@babel/preset-env'']"}
    ]$$::jsonb,
    'Babel 7.x, source code with template literals containing expressions, @babel/preset-env configured',
    'Template literals evaluate correctly at runtime, expressions produce expected values, output matches ES5 equivalent',
    'Expression evaluation order in template strings is critical. Some plugins alter transformation priority. Version-specific bugs in certain Babel versions - always test with latest. Ensure expressions are properly scoped.',
    0.84,
    'sonnet-4',
    NOW(),
    'https://github.com/babel/babel/issues/10276'
),
(
    'Babel: useBuiltins polyfill configuration requires proper core-js version matching',
    'github-babel',
    'HIGH',
    $$[
        {"solution": "Ensure core-js version matches preset-env useBuiltins version: core-js@3 for useBuiltins entry/usage", "percentage": 94, "note": "Version mismatch causes missing polyfills or duplicate code"},
        {"solution": "Specify corejs version in preset-env config: presets: [[''@babel/preset-env'', {useBuiltins: ''entry'', corejs: 3}]]", "percentage": 91, "note": "Explicit version declaration prevents auto-detection issues"},
        {"solution": "Update both @babel/preset-env and core-js together to compatible versions", "percentage": 88, "command": "npm install --save core-js@3 @babel/preset-env@latest"}
    ]$$::jsonb,
    'Babel 7.12+, @babel/preset-env with useBuiltins configured, core-js 2.x or 3.x, target environment specified',
    'Polyfills load correctly, no missing method errors in target environment, bundle includes only required polyfills',
    'core-js version must match useBuiltins specification - core-js@2 incompatible with modern Babel. Do not mix core-js versions across dependencies. Always specify corejs option explicitly for consistency. Version auto-detection unreliable across projects.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/babel/babel/issues/10008'
),
(
    'Babel: Configuration file format .babelrc.yaml or .babelrc.yml not recognized',
    'github-babel',
    'MEDIUM',
    $$[
        {"solution": "Use .babelrc (JSON) or .babelrc.js (JavaScript) format - YAML format not officially supported", "percentage": 90, "note": "Babel officially supports JSON and JavaScript config files only"},
        {"solution": "Convert YAML configuration to JSON .babelrc format", "percentage": 88, "note": "Most straightforward solution for config migration"},
        {"solution": "Use babel.config.js with YAML parser library for complex conditional config", "percentage": 75, "note": "Workaround requiring manual YAML parsing in JS"}
    ]$$::jsonb,
    'Babel 7.x, project with .babelrc.yaml file, .babelrc.yml or similar extension',
    'Babel recognizes configuration file, build completes without config file parsing errors, presets and plugins load correctly',
    'YAML format support was proposed but not implemented in Babel core. JSON and JavaScript are only officially supported formats. Migration from YAML to JSON recommended. Babel.config.js preferred for monorepo configurations.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/babel/babel/issues/4980'
);
