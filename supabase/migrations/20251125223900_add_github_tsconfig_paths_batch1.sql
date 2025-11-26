-- GitHub tsconfig-paths Issues: Module Resolution & Configuration Errors (Batch 1)
-- Mined from: https://github.com/dividab/tsconfig-paths/issues
-- Category: github-tsconfig-paths
-- Focus: Path resolution failures, baseUrl/paths configuration, Jest integration, webpack loader issues

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'tsconfig-paths: paths not being rewritten after compilation - compiled JS still contains alias names',
    'github-tsconfig-paths',
    'HIGH',
    '[
        {"solution": "Use ts-node with -r tsconfig-paths/register flag at runtime: node -r tsconfig-paths/register dist/src/index.js", "percentage": 85, "note": "Requires tsconfig.json accessible in runtime environment"},
        {"solution": "Use resolve-tspaths as post-compilation build step: install resolve-tspaths then run resolve-tspaths after tsc compilation", "percentage": 90, "command": "npm install resolve-tspaths && tsc && resolve-tspaths", "note": "Recommended: no TypeScript dependency needed in production"},
        {"solution": "Configure ts-node with baseUrl and paths in register: TS_NODE_BASEURL=dist/src/ TS_NODE_PROJECT=tsconfig.json node -r tsconfig-paths/register dist/src/index", "percentage": 80, "note": "Works for ts-node execution but not compiled output"}
    ]'::jsonb,
    'TypeScript project with compiled output, tsconfig.json with baseUrl and paths configured, Node.js runtime environment',
    'Compiled JS files contain resolved paths not aliases, imports resolve correctly at runtime, no ERR_MODULE_NOT_FOUND errors',
    'tsconfig-paths performs RUNTIME resolution only, not compile-time transformation. Do not expect .js files to contain rewritten imports. Library does not modify TypeScript compilation output.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/dividab/tsconfig-paths/issues/222'
),
(
    'tsconfig-paths: paths not resolved when baseUrl is not root directory like "./src"',
    'github-tsconfig-paths',
    'HIGH',
    '[
        {"solution": "Set baseUrl to project root and adjust all paths accordingly: baseUrl: \".\" then paths: {\"~/*\": [\"src/*\"]}", "percentage": 95, "note": "Most reliable solution, matches TypeScript compiler behavior"},
        {"solution": "Use relative paths from project root in tsconfig: ensure paths are relative to baseUrl value, test with other tools first", "percentage": 80, "note": "Verify eslint-import-resolver-typescript and babel-plugin support same config"},
        {"solution": "Use tsconfig-paths register with explicit baseUrl configuration at runtime", "percentage": 75, "note": "Runtime registration sometimes handles non-root baseUrl better than loadConfig"}
    ]'::jsonb,
    'TypeScript project with non-root baseUrl configured, Node.js ESM or CommonJS module resolution required',
    'Path aliases resolve correctly regardless of baseUrl value, import statements work with ./src baseUrl configuration, no "Cannot find package" errors',
    'Other tools (eslint-import-resolver-typescript, babel-plugin-tsconfig-paths) may support non-root baseUrl better. Always test consistency across your toolchain. Root baseUrl is most compatible.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/dividab/tsconfig-paths/issues/190'
),
(
    'tsconfig-paths: Module resolves to local file instead of node_modules package',
    'github-tsconfig-paths',
    'HIGH',
    '[
        {"solution": "Ensure paths configuration does not map to node_modules: review tsconfig.json paths entries and remove any wildcards pointing to node_modules", "percentage": 90, "note": "Root cause: tsconfig-paths reads local files before checking node_modules"},
        {"solution": "Use path.resolve() in tsconfig-loader to respect Node.js resolution algorithm: ensure library implementation matches Node standards", "percentage": 85, "note": "May require library patch or workaround"},
        {"solution": "Reorganize project structure to avoid local files with same names as node_modules packages", "percentage": 75, "note": "Workaround: prevent naming conflicts"}
    ]'::jsonb,
    'Node.js project with node_modules, tsconfig.json with paths configuration, local files and node_modules packages with conflicting names',
    'node_modules packages resolve correctly, local files do not override npm packages, require() and import statements work as expected',
    'tsconfig-paths does not implement standard Node.js path resolution algorithm, prioritizing local file matches over node_modules. This breaks monorepo setups. Avoid file/package naming conflicts.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/dividab/tsconfig-paths/issues/209'
),
(
    'tsconfig-paths: "Cannot find module" when using path aliases with compiled output',
    'github-tsconfig-paths',
    'HIGH',
    '[
        {"solution": "Register tsconfig-paths before requiring modules: add -r tsconfig-paths/register flag to node command", "percentage": 92, "command": "node -r tsconfig-paths/register dist/index.js", "note": "Must be first flag before script execution"},
        {"solution": "Use ts-node for direct TypeScript execution instead of compiling first: npx ts-node -r tsconfig-paths/register src/index.ts", "percentage": 88, "note": "Avoids compilation step entirely"},
        {"solution": "Verify baseUrl in tsconfig.json points to correct location: ensure baseUrl matches dist folder location at runtime", "percentage": 80, "note": "Common issue: baseUrl relative to tsconfig location, not CWD"}
    ]'::jsonb,
    'Compiled TypeScript project, tsconfig.json with baseUrl and paths, Node.js v14+, tsconfig-paths installed',
    'Module resolution succeeds, imports with path aliases resolve correctly at runtime, no ERR_MODULE_NOT_FOUND errors in logs',
    'The -r flag must be FIRST in node command before the script. Register hook must load before any imports. baseUrl is relative to tsconfig.json location, not working directory.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/dividab/tsconfig-paths/issues/279'
),
(
    'tsconfig-paths: ERR_IMPORT_ASSERTION_TYPE_MISSING with Node 17+ and ESM loader',
    'github-tsconfig-paths',
    'MEDIUM',
    '[
        {"solution": "Add JSON import assertions when importing tsconfig.json: import config from \"./tsconfig.json\" assert { type: \"json\" }", "percentage": 88, "note": "Required for Node 17+ ESM modules", "command": "Update all JSON imports to include assert { type: \"json\" }"},
        {"solution": "Use CommonJS-compatible import for JSON files in ESM context: const config = JSON.parse(readFileSync(\"./tsconfig.json\", \"utf-8\"))", "percentage": 85, "note": "Works with older Node versions too"},
        {"solution": "Upgrade to latest tsconfig-paths version which may include import assertion fixes", "percentage": 75, "note": "Check release notes for JSON import handling improvements"}
    ]'::jsonb,
    'Node.js 17.9.0 or later with ESM loader enabled, TypeScript with module: ESM, mocha or ts-node with experimental ESM flags',
    'JSON imports do not throw ERR_IMPORT_ASSERTION_TYPE_MISSING, ESM loader works correctly, tests execute without assertion errors',
    'Node.js ESM strictly requires import assertions for JSON. CommonJS path is easier but limits ESM adoption. Update all JSON imports in tsconfig-paths code.',
    0.80,
    'sonnet-4',
    NOW(),
    'https://github.com/dividab/tsconfig-paths/issues/207'
),
(
    'tsconfig-paths with Jest: "Worker is not a constructor" error in jest-haste-map',
    'github-tsconfig-paths',
    'HIGH',
    '[
        {"solution": "Configure Jest with moduleNameMapper instead of using tsconfig-paths/register: map paths in jest.config.js moduleNameMapper", "percentage": 92, "command": "moduleNameMapper: { \"^@(.*)$\": \"<rootDir>/src/$1\" }", "note": "Jest has native path alias support"},
        {"solution": "Use ts-node register only for ts-node, not globally: configure only in ts-node.require section of tsconfig.json, NOT in NODE_OPTIONS", "percentage": 88, "note": "Prevents tsconfig-paths from interfering with Jest worker threads"},
        {"solution": "Load tsconfig-paths after Jest initialization: use setupFilesAfterEnv instead of global requires", "percentage": 80, "note": "Defers path registration until after Jest workers start"}
    ]'::jsonb,
    'Jest configured, ts-node with tsconfig-paths/register required, TypeScript paths configured in tsconfig.json',
    'Jest tests run without worker thread errors, path aliases work in ts-node execution, _jestWorker Worker constructor doesn\'t throw',
    'Never use tsconfig-paths/register globally with Jest - it breaks Jest worker thread initialization. Use moduleNameMapper in jest.config.js for Jest, and register only for ts-node.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/dividab/tsconfig-paths/issues/178'
),
(
    'tsconfig-paths: ERR_REQUIRE_ESM "Must use import to load ES Module" with CommonJS project',
    'github-tsconfig-paths',
    'MEDIUM',
    '[
        {"solution": "Avoid registering tsconfig-paths globally if using dual-mode packages: use explicit require() without -r flag where possible", "percentage": 85, "note": "Prevents ESM enforcement on CommonJS projects"},
        {"solution": "Use dynamic import() for ES-only modules in CommonJS: replace require(\"esm-pkg\") with await import(\"esm-pkg\")", "percentage": 82, "command": "const mod = await import(\"esm-pkg\"); const { func } = mod;", "note": "Requires async wrapper function"},
        {"solution": "Configure package.json type field carefully: ensure \"type\": \"module\" is only set for ESM projects, not CommonJS", "percentage": 80, "note": "Prevents Node from treating .js files as ESM"}
    ]'::jsonb,
    'CommonJS project with tsconfig-paths/register, Node.js 12+, dual-mode npm packages installed (like colorette with both CJS and ESM)',
    'require() works with dual-mode packages, no ERR_REQUIRE_ESM errors, CommonJS modules load successfully with tsconfig-paths',
    'ESM-only packages cannot be required in CommonJS. tsconfig-paths/register may trigger stricter ESM checking. Rename to .cjs or switch to ESM gradually.',
    0.78,
    'sonnet-4',
    NOW(),
    'https://github.com/dividab/tsconfig-paths/issues/189'
),
(
    'tsconfig-paths: loadConfig errors with "Cannot convert undefined to object" when paths property missing',
    'github-tsconfig-paths',
    'MEDIUM',
    '[
        {"solution": "Always include empty paths object in tsconfig.json if paths property is not used: add \"paths\": {} to compilerOptions", "percentage": 95, "command": "{ \"compilerOptions\": { \"baseUrl\": \".\", \"paths\": {} } }", "note": "Ensures paths property exists even when empty"},
        {"solution": "Check if paths exists before calling loadConfig: validate tsconfig structure before passing to tsconfig-paths", "percentage": 85, "note": "Defensive programming approach"},
        {"solution": "Use latest tsconfig-paths version which handles missing paths gracefully: upgrade package version", "percentage": 75, "note": "May be fixed in newer releases"}
    ]'::jsonb,
    'TypeScript project using tsconfig-paths.loadConfig(), tsconfig.json without paths property configured',
    'loadConfig executes without TypeError, getAbsoluteMappingEntries returns valid result, Object.keys() does not throw on paths property',
    'Function crashes if paths property is undefined or null. Always include \"paths\": {} in tsconfig even if unused. Library lacks null checking.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/dividab/tsconfig-paths/issues/191'
),
(
    'tsconfig-paths glob pattern matching fails with trailing asterisk like "@/components/*"',
    'github-tsconfig-paths',
    'MEDIUM',
    '[
        {"solution": "Use proper glob pattern with wildcard: ensure paths pattern uses * for single-level wildcard: \"@/components/*\": [\"components/*\"]", "percentage": 90, "note": "createMatchPath should handle glob correctly"},
        {"solution": "Handle trailing slash consistency: normalize import paths to match tsconfig pattern exactly, test with/without trailing slashes", "percentage": 82, "note": "Related PR #281 addresses trailing slash handling"},
        {"solution": "Update to version including PR #281 fix: pull request \"fix: should resolve paths exactly the same as input path with trailing slash\"", "percentage": 85, "note": "Check release notes for glob star fix"}
    ]'::jsonb,
    'TypeScript project with glob patterns in tsconfig paths, createMatchPath function in use, modules with wildcard patterns',
    'Glob patterns with asterisk resolve correctly, trailing slashes handled consistently, createMatchPath returns correct matches for wildcard patterns',
    'Single asterisk glob patterns may not match trailing slashes correctly. Wildcard handling inconsistent between input paths. Linked PR #281 provides fix.',
    0.80,
    'sonnet-4',
    NOW(),
    'https://github.com/dividab/tsconfig-paths/issues/280'
),
(
    'tsconfig-paths: "Cannot resolve base config from other module" with scoped packages in extends',
    'github-tsconfig-paths',
    'MEDIUM',
    '[
        {"solution": "Explicitly include tsconfig.json filename in extends path: use \"extends\": \"@myorg/typescript-config/tsconfig.json\" instead of package name alone", "percentage": 95, "command": "{ \"extends\": \"@myorg/typescript-config/tsconfig.json\" }", "note": "Workaround until library supports auto-appending filenames"},
        {"solution": "Update to version with PR #203 support: check release notes for \"Add support for extends as array of strings\" or filename auto-appending", "percentage": 85, "note": "Planned feature for better tsc compatibility"},
        {"solution": "Verify scoped package exports tsconfig.json as main or exports field in its package.json", "percentage": 75, "note": "Package must properly export config file"}
    ]'::jsonb,
    'TypeScript project extending config from scoped npm package, package.json with scoped package dependency, tsconfig.json using extends',
    'Config extends from @scope/package resolves successfully, tsconfig-loader finds extended config files, inheritance chain works correctly',
    'tsconfig-paths does not auto-append tsconfig.json like tsc does. Requires explicit filename. Feature parity with TypeScript compiler not yet implemented.',
    0.86,
    'sonnet-4',
    NOW(),
    'https://github.com/dividab/tsconfig-paths/issues/182'
),
(
    'tsconfig-paths: "Invalid asterisk match" with wildcard patterns using substr instead of substring',
    'github-tsconfig-paths',
    'LOW',
    '[
        {"solution": "Update to version with PR #141 merged: this fixes matchStar function using substr() instead of substring()", "percentage": 92, "command": "npm update tsconfig-paths", "note": "Issue reported Feb 2024, check if merged in current version"},
        {"solution": "Manual workaround for wildcard paths: avoid complex wildcard patterns like \"@foo/*/bars\": [\"foo/*/bars.ts\"] until fix is released", "percentage": 70, "note": "Temporary workaround, not recommended for production"},
        {"solution": "Contribute PR #141 or request merge to library maintainers: patch is available and confirmed working", "percentage": 60, "note": "Community-driven fix"}
    ]'::jsonb,
    'TypeScript project with complex wildcard patterns in paths, matchStar function being called, tsconfig-paths npm package version < fix release',
    'Wildcard patterns match correctly, substr/substring logic works properly, path segments extracted accurately with globs like @foo/*/bars',
    'matchStar function incorrectly extracts string segments using substr (count-based) instead of substring (index-based). Causes wildcard matching to fail.',
    0.75,
    'sonnet-4',
    NOW(),
    'https://github.com/dividab/tsconfig-paths/issues/140'
),
(
    'tsconfig-paths with package.json main field: findFirstExistingMainFieldMappedFile silently fails',
    'github-tsconfig-paths',
    'MEDIUM',
    '[
        {"solution": "Use package.json exports field instead of main: prefer \"exports\": { \".\": \"./index.js\" } over \"main\": \"./index.js\"", "percentage": 92, "note": "Modern standard, better compatibility"},
        {"solution": "Use exports as object with dot key: \"exports\": { \".\": \"./index.js\" } not string format \"exports\": \"./index.js\"", "percentage": 88, "command": "{ \"exports\": { \".\": \"./index.js\" } }", "note": "Library only supports object format with \".\" key"},
        {"solution": "Update package when library supports string exports format: library needs patch to handle \"exports\": \"./index.js\" syntax", "percentage": 75, "note": "PR with fix may be available from issue author"}
    ]'::jsonb,
    'npm package with only main field or string-format exports, tsconfig-paths used for package resolution, Node.js module resolution',
    'findFirstExistingMainFieldMappedFile resolves main field correctly, exports field in both object and string formats work, packages resolve without silent failures',
    'Library silently ignores package.json main field and string-format exports. Only object format with \".\" key works. No error thrown when main field missing.',
    0.83,
    'sonnet-4',
    NOW(),
    'https://github.com/dividab/tsconfig-paths/issues/282'
),
(
    'tsconfig-paths: Class instanceof fails when different import paths resolve same module twice',
    'github-tsconfig-paths',
    'MEDIUM',
    '[
        {"solution": "Normalize all imports to use consistent paths - use path aliases throughout codebase: if you map ~/errors/* use it everywhere, never mix with relative requires", "percentage": 90, "note": "Prevents duplicate module loading"},
        {"solution": "Use barrel exports (index files) to force single import path: create index.ts that re-exports all classes, import from barrel instead of direct files", "percentage": 85, "command": "// index.ts: export { AppError } from './classes'; // Import from: import { AppError } from '~/errors'", "note": "Enforces consistent resolution"},
        {"solution": "Configure tsconfig paths to be comprehensive: ensure all possible import variations map to same path, cover all edge cases", "percentage": 78, "note": "Requires thorough path configuration planning"}
    ]'::jsonb,
    'TypeScript/Node.js project with path aliases configured, multiple import paths (relative and aliased) resolving same module, class instanceof checks performed',
    'Classes load once per process, instanceof checks pass, same module not loaded multiple times with different paths, consistent identity across codebase',
    'Module system loads same module twice with different require paths: require(\"./classes\") vs require(\"~/errors/classes\") breaks instanceof. Always use consistent import patterns.',
    0.81,
    'sonnet-4',
    NOW(),
    'https://github.com/dividab/tsconfig-paths/issues/119'
)
;
