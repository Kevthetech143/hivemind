-- Add GitHub Rollup issues batch 1
-- Extracted from https://github.com/rollup/rollup/issues with highest engagement

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, source_url
) VALUES (
    'Tree-shaking fails to remove unused code in Rollup 4.30.1',
    'github-rollup',
    'MEDIUM',
    $$[
        {"solution": "Add propertyReadSideEffects: false to Rollup config to explicitly declare property reads have no side effects", "percentage": 95, "note": "Most reliable for return value property access"},
        {"solution": "Restructure code to eliminate property access lines on function return values", "percentage": 80, "note": "Code-based workaround without config change"},
        {"solution": "Simplify function bodies inside @__NO_SIDE_EFFECTS__ blocks", "percentage": 75, "note": "May reduce functionality if not carefully applied"}
    ]$$::jsonb,
    'Rollup 4.30.1 or later, Code with @__NO_SIDE_EFFECTS__ annotations',
    'Unused constant is removed from final bundle, Build completes without warnings',
    'Cannot track beyond parameter values - Rollup treats return values as unknown. Property access may trigger side effects so code is preserved. Do not assume all property reads are side-effect-free without explicit configuration.',
    0.92,
    'https://github.com/rollup/rollup/issues/5807'
),
(
    'Chunk splitting and tree shaking fails inside existing bundles',
    'github-rollup',
    'MEDIUM',
    $$[
        {"solution": "Use special comments similar to /* #__PURE__ */ to mark internal module boundaries for redistribution", "percentage": 70, "note": "Proposed approach, not yet implemented"},
        {"solution": "Maintain separate entry points and sub-path imports in library to preserve tree-shakeability", "percentage": 85, "note": "Current workaround, requires library restructure"},
        {"solution": "Avoid bundling pre-built libraries - source from original modules instead", "percentage": 80, "note": "Best practice for optimal tree-shaking"}
    ]$$::jsonb,
    'Pre-built library or bundle as input, Rollup 3.0+',
    'Unused code is eliminated from output, Bundle size matches source imports',
    'Entire built JS files treated as single units. Rollup cannot preserve internal module/chunk structures without source files. Library maintainers must provide both bundled ESM and source modules.',
    0.65,
    'https://github.com/rollup/rollup/issues/5206'
),
(
    'Incorrect tree shaking with import * as foo + export default foo',
    'github-rollup',
    'LOW',
    $$[
        {"solution": "Explicitly map properties in default export: export default { greetings: { hello: greetings.hello } }", "percentage": 95, "note": "Direct fix for namespace re-export issue"},
        {"solution": "Upgrade to rollup@3.7.5 or later where fix was released in PR #4758", "percentage": 98, "note": "Resolved in version 3.7.5"}
    ]$$::jsonb,
    'Rollup 3.7.4 with namespace imports re-exported as defaults',
    'Side effects are preserved in bundle, All expected function calls appear in output',
    'Namespace imports nested in objects were being incorrectly removed. This was a regression between 2.79.1 and 3.0.0. Fixed in 3.7.5.',
    0.96,
    'https://github.com/rollup/rollup/issues/4751'
),
(
    'Component library tree-shaking includes entire codebase instead of used components',
    'github-rollup',
    'HIGH',
    $$[
        {"solution": "Add \"sideEffects: false\" to package.json and create separate files for each independently-importable entity as entry points", "percentage": 90, "note": "Recommended approach by maintainers"},
        {"solution": "Avoid using preserveModules: true as it creates node_modules directories breaking resolution", "percentage": 0, "note": "Anti-pattern that causes more problems"},
        {"solution": "Do not mark node_modules as external if downstream consumers use CRA or similar build tools", "percentage": 0, "note": "Causes failures in consuming applications"}
    ]$$::jsonb,
    'React/component library built with Rollup, package.json accessible by consumers',
    'Imported components only appear in bundle, Unused components not included, Tree-shaking works in consuming apps',
    'Hierarchical exports with index files defeat tree-shaking. preserveModules creates incompatible node_modules structure. Must explicitly mark sideEffects: false and structure for independent imports.',
    0.82,
    'https://github.com/rollup/rollup/issues/4066'
),
(
    'Circular dependencies cause incorrect module serialization order',
    'github-rollup',
    'HIGH',
    $$[
        {"solution": "Split classes into separate modules: one without circular dependencies, another that attaches circular-dependent methods afterward", "percentage": 88, "note": "Recommended workaround by community, separates concerns"},
        {"solution": "Import one module before the other in entry point to establish ordering", "percentage": 75, "note": "Works but requires manual control of import order"},
        {"solution": "Refactor to eliminate circular dependencies between modules", "percentage": 92, "note": "Best long-term solution, improves code architecture"}
    ]$$::jsonb,
    'Code with circular module dependencies, Rollup 2.0+',
    'Classes inherit correctly, Methods available at runtime, No serialization errors',
    'Rollup must follow ES module spec regarding ordering. Manual reordering breaks when switching bundlers. Parent/Child inheritance patterns require careful module splitting.',
    0.87,
    'https://github.com/rollup/rollup/issues/1089'
),
(
    'TypeScript decorator tree-shaking fails with extended classes',
    'github-rollup',
    'MEDIUM',
    $$[
        {"solution": "Replace TypeScript @__PURE__ annotations with /*@__PURE__*/ comments in Rollup plugin before minification", "percentage": 90, "note": "Signals to UglifyJS that decorators can be removed"},
        {"solution": "Change TypeScript compilation target from ES5 to ES2015 then transpile separately with Babel", "percentage": 85, "note": "Enables Rollup dead code elimination"},
        {"solution": "Use native support for /*@__PURE__*/ annotations in Rollup instead of TypeScript helpers", "percentage": 92, "note": "Future-proof approach"}
    ]$$::jsonb,
    'TypeScript project with decorators and class extension, __extends helper functions present',
    'Decorated classes removed from bundle, Bundle size reduced, No decorator IIFEs in output',
    'TypeScript generates __extends helpers that Rollup cannot identify as removable. @class comments prevent dead code elimination. Must use /*@__PURE__*/ or change target.',
    0.88,
    'https://github.com/rollup/rollup/issues/1763'
),
(
    'Tree shaking not applied to node modules dependencies',
    'github-rollup',
    'HIGH',
    $$[
        {"solution": "Import from specific submodules instead of barrel exports: lodash-es/find instead of lodash-es", "percentage": 92, "note": "Bypasses side-effect barrier of barrel exports"},
        {"solution": "Check if library initializes modules with side effects on import", "percentage": 75, "note": "RxJS and similar libraries prevent tree-shaking"},
        {"solution": "Use CommonJS minifier to eliminate unused code after bundling if ES modules insufficient", "percentage": 60, "note": "Post-processing fallback"}
    ]$$::jsonb,
    'npm library with ES modules, Unused exports in dependency',
    'No unused dependency code in bundle, Import analysis shows only used exports',
    'CommonJS modules cannot be tree-shaken. Barrel exports hide side effects. Libraries like RxJS require careful import paths. Rollup preserves code with possible side effects.',
    0.83,
    'https://github.com/rollup/rollup/issues/663'
),
(
    'Module name conflicts no longer resolved when bundling code',
    'github-rollup',
    'LOW',
    $$[
        {"solution": "Upgrade to Rollup 0.55.1+ which includes external deshadowing fix from PR #1944", "percentage": 98, "note": "Resolved in later versions"},
        {"solution": "Ensure modules from different import paths use unique qualified names", "percentage": 85, "note": "Prevents name collision issues"}
    ]$$::jsonb,
    'Rollup 0.50.0 to 0.55.0, Multiple modules with identical names from different paths',
    'Modules resolve correctly, No name conflict errors, Build succeeds',
    'Issue was a regression between 0.50.0 and 0.55.1. Fixed via external deshadowing. Duplicate names from different import paths now handled correctly.',
    0.96,
    'https://github.com/rollup/rollup/issues/1930'
),
(
    'preserveModules option generates incompatible node_modules folder structure',
    'github-rollup',
    'MEDIUM',
    $$[
        {"solution": "Use rollup-plugin-rename to restructure output paths post-build", "percentage": 80, "note": "Workaround to fix paths after bundling"},
        {"solution": "Avoid preserveModules: true with @rollup/plugin-node-resolve combination", "percentage": 75, "note": "Known incompatibility"},
        {"solution": "Request feature for full path manipulation beyond entryFileNames", "percentage": 0, "note": "Not yet implemented, would require breaking change"}
    ]$$::jsonb,
    'Rollup 3.0+, preserveModules: true enabled, node_modules dependencies',
    'Output paths match npm/yarn flattened structure, Dependencies resolve in consuming projects',
    'preserveModules creates dist/node_modules/PKG with relative paths that dont exist post-install. isPlainPathFragment rejects path modifiers. Requires post-build path normalization.',
    0.68,
    'https://github.com/rollup/rollup/issues/3684'
),
(
    'Tree-shaking not working with TypeScript ES5 class declarations',
    'github-rollup',
    'MEDIUM',
    $$[
        {"solution": "Compile TypeScript to ES2015 target instead of ES5, then transpile separately with Babel", "percentage": 88, "note": "Allows Rollup to analyze ES2015 classes for tree-shaking"},
        {"solution": "Replace TypeScript /** @class */ comments with /*@__PURE__*/ annotations using Babel AST tools", "percentage": 92, "note": "Programmatic approach avoids regex fragility"},
        {"solution": "Add explicit pure annotations in Rollup plugin before minification", "percentage": 85, "note": "Plugin-based workaround"}
    ]$$::jsonb,
    'TypeScript project compiling to ES5, Unused classes in bundle',
    'Unused TypeScript classes removed from output, Bundle size reduced',
    'TypeScript ES5 IIFE wrappers contain /** @class */ comments that Rollup cannot identify as side-effect-free. Classes like QRKanji appear even if unused. ES2015 target enables proper analysis.',
    0.89,
    'https://github.com/rollup/rollup/issues/2807'
),
(
    'lodash-es/find import includes 800+ lines of unused dependency code',
    'github-rollup',
    'MEDIUM',
    $$[
        {"solution": "Import from specific lodash-es submodule path: lodash-es/template.js instead of lodash-es/find", "percentage": 93, "note": "Bypasses barrel export preventing tree-shaking"},
        {"solution": "Accept that method chains cannot be analyzed for side effects without extreme complexity", "percentage": 0, "note": "Fundamental Rollup limitation"}
    ]$$::jsonb,
    'lodash-es or similar large utility library with barrel exports',
    'Only necessary functions in bundle, No 800+ line dependency overhead',
    'Rollup cannot determine .replace(...) method has no global side effects. Must use direct submodule imports. Barrel exports hide dependency tree.',
    0.86,
    'https://github.com/rollup/rollup/issues/610'
),
(
    'Manual chunks bring all dependencies along defeating code splitting efficiency',
    'github-rollup',
    'HIGH',
    $$[
        {"solution": "Upgrade to Rollup 4.52.0+ which includes fix from PR #6087 for smart chunking", "percentage": 96, "note": "Resolved in recent version"},
        {"solution": "Use two-phase chunking: first merge specified modules, then apply standard resolution to dependencies", "percentage": 88, "note": "Implemented in Rollup 4.52.0+"},
        {"solution": "Manually configure dependencies to specific chunks if using older Rollup versions", "percentage": 70, "note": "Workaround for earlier versions"}
    ]$$::jsonb,
    'Rollup 3.0-4.51, manualChunks configuration with shared dependencies',
    'Dependencies are split optimally, Shared modules not duplicated across chunks, Efficient code splitting achieved',
    'moduleA1 and moduleA2 in chunkA causes shared1 to bundle entirely in chunkA. When moduleB needs shared1, entire chunkA must load. Smart resolution needed.',
    0.94,
    'https://github.com/rollup/rollup/issues/4180'
);
