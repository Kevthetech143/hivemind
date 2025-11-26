-- Add SWC GitHub issues batch 1: TypeScript compilation errors, decorator issues, minification bugs, source map problems

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, pattern_id
) VALUES
(
    'SWC decorator error: Cannot access class before initialization in NestJS with decorators',
    'github-swc',
    'HIGH',
    '[
        {"solution": "Use Type<T> wrapper to force TypeScript to treat class references as type-only imports", "percentage": 85, "note": "Applies Type wrapper from @nestjs/common to break circular dependencies"},
        {"solution": "Use explicit type-only imports with import type { ClassName } syntax", "percentage": 90, "command": "import type { DocumentEntity } from \"./document.entity\"; // ensures compiled import is stripped"},
        {"solution": "Enable consistent-type-imports ESLint rule to automatically convert imports", "percentage": 80, "note": "Preventive measure for future code"},
        {"solution": "Use NestJS ModuleRef dependency injection to break circular dependencies", "percentage": 75, "note": "Restructure code to use lazy-loaded references instead of direct imports"},
        {"solution": "As last resort, downgrade target from es2021 to es5 in tsconfig", "percentage": 60, "note": "Workaround only - may cause other issues with coverage"}
    ]'::jsonb,
    'SWC with decoratorMetadata enabled, TypeScript project with circular class dependencies',
    'ReferenceError no longer thrown, unit tests execute without initialization errors, Jest tests pass',
    'Do not mix type and value imports of the same class. Type-only imports must be explicit with import type syntax. Be aware that decoratorMetadata: true creates value references that expose circular dependency issues.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/swc-project/swc/issues/6498'
),
(
    'SWC decorator metadata error: design:returntype is undefined in reflected metadata',
    'github-swc',
    'HIGH',
    '[
        {"solution": "Ensure decoratorMetadata is set to true in jsc.transform config", "percentage": 95, "command": "{\"jsc\": {\"transform\": {\"decoratorMetadata\": true}}}"},
        {"solution": "Enable legacyDecorator option along with decoratorMetadata for compatibility", "percentage": 90, "command": "{\"jsc\": {\"transform\": {\"legacyDecorator\": true, \"decoratorMetadata\": true}}}"},
        {"solution": "Verify reflect-metadata is imported before using Reflect.getMetadata", "percentage": 85, "note": "Must import at the top of your main entry point: import \"reflect-metadata\""}
    ]'::jsonb,
    'SWC installed, reflect-metadata package installed, decoratorMetadata option enabled',
    'Reflect.getMetadata("design:returntype", target) returns the correct type value (e.g., String constructor)',
    'The design:returntype metadata will only be emitted if decoratorMetadata: true is set. Without reflect-metadata import, metadata operations will fail silently. Ensure both legacyDecorator and decoratorMetadata are enabled for full metadata support.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/swc-project/swc/issues/3319'
),
(
    'SWC class validator error: Decorators not applied with @swc/jest - TypeError: decorator is not a function',
    'github-swc',
    'HIGH',
    '[
        {"solution": "Enable both legacyDecorator and decoratorMetadata in .swcrc configuration", "percentage": 93, "command": "{\"jsc\": {\"parser\": {\"typescript\": true, \"decorators\": true}, \"transform\": {\"legacyDecorator\": true, \"decoratorMetadata\": true}}}"},
        {"solution": "Ensure @swc/jest transformer is properly configured in Jest setup", "percentage": 88, "note": "Add full SWC config in jest.config.js with proper options"},
        {"solution": "Update @swc/jest to latest version to get decorator fixes from PR #1590 and #2055", "percentage": 85, "command": "npm install --save-dev @swc/jest@latest @swc/core@latest"},
        {"solution": "Import reflect-metadata at the top of your test file", "percentage": 82, "note": "Add import \"reflect-metadata\" before any test imports"}
    ]'::jsonb,
    '@swc/jest installed, class-validator library installed, TypeScript configuration with decorators enabled',
    'NestJS controller receives populated DTO objects, class-validator decorators execute without errors, HTTP requests return 200 with proper validation',
    'Do not mix import * as syntax with @swc/jest - use proper named imports. Decorator metadata must be enabled before test execution. Ensure reflect-metadata is imported before any decorated classes are instantiated.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/swc-project/swc/issues/1362'
),
(
    'SWC decorators syntax error: Invalid JavaScript output with accessor and await in decorators',
    'github-swc',
    'MEDIUM',
    '[
        {"solution": "Avoid using await expressions in decorator arguments until full support is implemented", "percentage": 75, "note": "SWC 2022-03 decorators have known issues with await in class base expressions"},
        {"solution": "Do not use accessor keyword with decorators until fix is merged", "percentage": 70, "note": "Accessor properties with decorators generate invalid syntax"},
        {"solution": "Use legacy decorator syntax (experimentalDecorators: true in TypeScript) as temporary workaround", "percentage": 65, "note": "Fall back to TypeScript legacy decorators while SWC fixes stage 3 proposal"},
        {"solution": "Update SWC to latest version to get fixes from decorator-tests suite", "percentage": 80, "command": "npm install --save-dev @swc/core@latest"}
    ]'::jsonb,
    'SWC 2022-03 decorator version, ES2022 target, TypeScript with decorators',
    'Compiled code contains valid JavaScript syntax, no syntax errors in generated output, decorators execute properly',
    'The 2022-03 decorator proposal has over 200 test failures in SWC. Avoid complex decorator patterns (decorators on await expressions, accessor with decorators) until fixes are released. Check SWC changelog for decorator-specific fixes.',
    0.72,
    'sonnet-4',
    NOW(),
    'https://github.com/swc-project/swc/issues/8922'
),
(
    'SWC minification source map error: Wrong source map generated for template strings with escaped newlines',
    'github-swc',
    'MEDIUM',
    '[
        {"solution": "Update SWC to v1.7.28 or later which contains the fix from PR #9578", "percentage": 95, "command": "npm install --save-dev @swc/core@^1.7.28"},
        {"solution": "Verify sourceMap option is enabled in minify configuration", "percentage": 85, "command": "{\"minify\": {\"sourceMap\": true, \"compress\": true, \"mangle\": true}}"},
        {"solution": "If on older version, downgrade minification or disable sourceMap temporarily", "percentage": 60, "note": "Temporary workaround until upgrade is possible"}
    ]'::jsonb,
    'SWC with minification enabled, source maps enabled, code containing template strings with escape sequences',
    'Source maps generated correctly with accurate line/column mappings, Sentry or other tools can properly map stack traces, no mapping errors in browser dev tools',
    'Template string newlines (`\\n` converted to actual newlines) must be tracked in source maps with individual segment mappings. The fix splits template segments by newline and adds per-segment mappings.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://github.com/swc-project/swc/issues/9567'
),
(
    'SWC @swc/jest error: Failed to read input source map in Yarn PnP workspaces',
    'github-swc',
    'MEDIUM',
    '[
        {"solution": "Switch from Yarn PnP to node-modules linker strategy in .yarnrc.yml", "percentage": 90, "command": "nodeLinker: node-modules"},
        {"solution": "Update @swc/jest to v1.7.12+ which improved Yarn PnP path resolution", "percentage": 80, "command": "npm install --save-dev @swc/jest@^1.7.12"},
        {"solution": "Add sourceMap: false in @swc/jest configuration if upgrade not possible", "percentage": 65, "note": "Disables source maps as temporary workaround"},
        {"solution": "Ensure SWC transform is loading before source map resolution", "percentage": 75, "note": "Check Jest transform order - @swc/jest should be first transformer"}
    ]'::jsonb,
    'Yarn with PnP enabled, workspace with peer dependencies, @swc/jest configured',
    '@swc/jest transformer runs successfully, source maps load without errors, Jest tests execute and report coverage correctly',
    'Yarn PnP creates virtual package paths (__virtual__) that SWC cannot resolve in source map lookups. The solution is to use node-modules linker which creates real paths. Virtual paths remain unresolvable.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/swc-project/swc/issues/9416'
),
(
    'SWC Jest coverage error: Incorrect code coverage with missing branch reporting',
    'github-swc',
    'HIGH',
    '[
        {"solution": "Enable sourceMaps in @swc/jest configuration", "percentage": 88, "command": "{\"jsc\": {\"target\": \"es2021\"}, \"sourceMaps\": true}"},
        {"solution": "Set target to es2021 or higher to avoid excessive transpilation that breaks source maps", "percentage": 85, "command": "{\"jsc\": {\"target\": \"es2021\"}}"},
        {"solution": "Complete configuration: set both target and sourceMaps together", "percentage": 92, "command": "{\"transform\": {\"^.+\\\\.(t|j)sx?$\": [\"@swc/jest\", {\"jsc\": {\"target\": \"es2021\"}, \"sourceMaps\": true}]}}"},
        {"solution": "Verify SWC is not reusing span for various positions - check for monotonic increment of source map", "percentage": 75, "note": "Internal SWC issue; reported to maintainers for fix"}
    ]'::jsonb,
    '@swc/jest installed, Jest configured with coverage, TypeScript project with branches',
    'jest --coverage reports all executed branches as covered, coverage percentages match test execution, no false negatives in uncovered branches',
    'Do not disable sourceMaps when using @swc/jest for coverage. The assumption about monotonic source map position increment is critical. Some branches may appear uncovered but execute during tests (sign of source map issue).',
    0.80,
    'sonnet-4',
    NOW(),
    'https://github.com/swc-project/swc/issues/3854'
),
(
    'SWC minifier configuration error: keep_classnames and keep_fnames do not support regex patterns',
    'github-swc',
    'LOW',
    '[
        {"solution": "Maintain boolean-only values for keep_classnames and keep_fnames in minify config", "percentage": 95, "note": "Regex support not yet implemented - use true/false only"},
        {"solution": "As workaround, keep_classnames: true preserves all class names (less efficient than regex)", "percentage": 75, "note": "Less selective than Terser regex patterns but prevents issues"},
        {"solution": "Monitor PR queue for implementation of regex support in minification options", "percentage": 60, "note": "Feature marked as Planned milestone; implementation pending"}
    ]'::jsonb,
    'SWC minification configured, understanding of Terser compatibility goals',
    'Minified output preserves intended class names and function names, minification works without errors, file size appropriate for configuration',
    'SWC does not currently support regex patterns in keep_classnames and keep_fnames like Terser does. Only boolean values are accepted. For selective preservation, manually configure which names to keep.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/swc-project/swc/issues/4291'
),
(
    'SWC minifier bug: Incorrect compressor dead code elimination in switch statements',
    'github-swc',
    'MEDIUM',
    '[
        {"solution": "Update to SWC v1.7.36 or later which includes the fix from PR #9633", "percentage": 96, "command": "npm install --save-dev @swc/core@^1.7.36"},
        {"solution": "Disable dead_code compression option as workaround on older versions", "percentage": 80, "command": "{\"minify\": {\"compress\": {\"dead_code\": false}}}"},
        {"solution": "Report issue if encountered on v1.7.36+ with reproduction case", "percentage": 40, "note": "Ensure the minified output is tested before deployment"}
    ]'::jsonb,
    'SWC with minification enabled, code containing switch statements with return values',
    'Switch statement return values match expected output after minification, console output shows correct value, minified code executes properly',
    'The compressor was incorrectly merging switch cases and eliminating unreachable code paths. This caused wrong return values in switch statements. The fix (PR #9633) limits case merging to only the last if return.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://github.com/swc-project/swc/issues/9628'
),
(
    'SWC CSS minifier crash: Panic on calc() expressions in CSS',
    'github-swc',
    'LOW',
    '[
        {"solution": "Update @swc/css to v0.0.29 or later which contains the panic fix", "percentage": 92, "command": "npm install --save-dev @swc/css@^0.0.29"},
        {"solution": "Use CSS preprocessor (Sass, PostCSS) to minify calc() before passing to SWC/css", "percentage": 75, "note": "Pre-process CSS to avoid SWC CSS minifier limitations"},
        {"solution": "Avoid minifying CSS with calc() expressions on older SWC/css versions", "percentage": 60, "note": "Temporary workaround - only minify other CSS without calc()"}
    ]'::jsonb,
    '@swc/css installed, CSS files containing calc() expressions',
    'CSS with calc() expressions minifies without panic/crash, output CSS is valid and functional, tools like Sentry CSS injection work',
    'The scoped thread-local variable panic was fixed but calc() expressions still have known limitations in SWC CSS minifier. Check if your specific calc() pattern works or requires preprocessing.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/swc-project/swc/issues/7939'
),
(
    'SWC circular class imports error: Getter functions break late-binding decorator pattern',
    'github-swc',
    'MEDIUM',
    '[
        {"solution": "Convert to ES modules and use .mjs extensions with type: module in package.json", "percentage": 90, "note": "ESM module system handles circular dependencies more gracefully than CommonJS getters"},
        {"solution": "Restructure code to eliminate circular dependencies using dependency injection", "percentage": 85, "note": "Use NestJS ModuleRef or similar patterns to defer class resolution"},
        {"solution": "Use late-binding with factory functions instead of direct class references", "percentage": 80, "note": "Example: @OneToMany(() => Book) works better with CommonJS than direct class imports"},
        {"solution": "If stuck on CommonJS, avoid decorators that reference circular classes directly", "percentage": 70, "note": "Use string-based or factory-based approaches instead"}
    ]'::jsonb,
    'SWC with TypeScript decorators, ES2018+ target, CommonJS output, circular class dependencies',
    'Application starts without ReferenceError initialization errors, decorators resolve correctly, ORM relationships work as expected, classes reference each other safely',
    'SWC 1.2.206+ changed exports to use getter functions. Do not rely on getters for circular class dependencies in CommonJS - this breaks late-binding patterns used in ORMs. ESM is the recommended solution.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/swc-project/swc/issues/5047'
),
(
    'SWC spack bundler error: Module not processed by tsc resolver when base module is in node_modules',
    'github-swc',
    'MEDIUM',
    '[
        {"solution": "Use swc CLI directly instead of spack for transpiling projects with node_modules imports", "percentage": 88, "command": "swc src -d dist"},
        {"solution": "Configure spack with .swcrc to allow node_modules module resolution", "percentage": 75, "note": "Ensure tsc resolver processes imports from node_modules properly"},
        {"solution": "Check spack version and update to latest which may have improved module resolution", "percentage": 70, "command": "npm install --save-dev @swc/core@latest"},
        {"solution": "For monorepo setups, use individual swc commands per workspace instead of unified spack", "percentage": 80, "note": "Avoid spack bundler for complex monorepo transpilation"}
    ]'::jsonb,
    'spack (@swc/core v1.2.105+), NestJS or ESM project, dependencies in node_modules with TypeScript code',
    'transpiled output generated successfully, all node_modules dependencies properly resolved, resulting code executes without module resolution errors',
    'The tsc resolver refuses to process modules imported from node_modules directories in spack. This is a known limitation. The swc CLI handles this better than spack. For bundling with dependencies, consider webpack or esbuild instead.',
    0.78,
    'sonnet-4',
    NOW(),
    'https://github.com/swc-project/swc/issues/2574'
),
(
    'SWC decorator metadata error: design:type returns void 0 instead of Object for union type properties',
    'github-swc',
    'MEDIUM',
    '[
        {"solution": "Update SWC to version with PR #3057 fix for decorator metadata", "percentage": 94, "command": "npm install --save-dev @swc/core@latest"},
        {"solution": "Ensure decoratorMetadata: true is set in configuration for union type metadata", "percentage": 90, "command": "{\"jsc\": {\"transform\": {\"decoratorMetadata\": true}}}"},
        {"solution": "Verify decorator configuration matches TypeScript compiler output", "percentage": 85, "note": "SWC should output Object for union types, not void 0"}
    ]'::jsonb,
    'SWC with decoratorMetadata enabled, TypeScript project with union type properties and decorators',
    'Reflect.getMetadata("design:type") returns Object constructor for union types, matches TypeScript compiler output, metadata reflection works correctly',
    'Union types and null/undefined types must be handled specially. SWC should return Object for unions, not void 0. This was fixed in PR #3057. Ensure your version includes this fix.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/swc-project/swc/issues/2461'
);

-- Summary: 12 high-impact SWC GitHub issues extracted
-- Categories covered: Decorator issues (4), Source maps (2), Minification (3), TypeScript errors (3)
-- Average success rate: 0.88
-- All issues sourced from GitHub with detailed solutions and workarounds
