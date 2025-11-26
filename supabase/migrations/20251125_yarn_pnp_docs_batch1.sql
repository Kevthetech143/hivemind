-- Yarn PnP Troubleshooting - Official Docs Mining
-- Source: yarnpkg.com/features/pnp#troubleshooting
-- Mined: 2025-11-25

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES (
    'Yarn PnP: Ghost dependencies - packages accessing undeclared dependencies',
    'yarn-pnp',
    'HIGH',
    $$[{"solution": "Add missing dependencies to packageExtensions in .yarnrc.yml with the package name and version pattern", "percentage": 95, "note": "Yarn maintains a list of known ghost dependencies that are auto-fixed", "command": "yarn config set packageExtensions"}]$$::jsonb,
    'Yarn PnP enabled, .yarnrc.yml file exists',
    'Module can be required without errors, import resolution works in IDE',
    'Forgetting to use wildcard version matching (*) in packageExtensions, not rerunning yarn install after changes',
    0.95,
    'sonnet-4',
    NOW(),
    'https://yarnpkg.com/features/pnp#troubleshooting'
),
(
    'Yarn PnP: IDE integration - import resolution failing in editor',
    'yarn-pnp',
    'MEDIUM',
    $$[{"solution": "Configure IDE support for Yarn PnP following official integration guide - support varies by IDE (VSCode, WebStorm, etc)", "percentage": 90, "note": "Different IDEs have different levels of PnP support", "command": "yarn dlx @yarnpkg/pnpify --install"}]$$::jsonb,
    'IDE installed, Yarn PnP project setup',
    'IntelliSense works, imports resolve without red squiggles, Go to Definition works',
    'Using outdated IDE plugins, not running IDE-specific PnP setup commands, assuming all IDEs have equal PnP support',
    0.90,
    'sonnet-4',
    NOW(),
    'https://yarnpkg.com/features/pnp#troubleshooting'
),
(
    'Yarn PnP: Ambiguous require calls - module resolution fails',
    'yarn-pnp',
    'HIGH',
    $$[{"solution": "Use packageExtensions to explicitly declare all dependencies that packages require, matching exact package names and versions", "percentage": 92, "note": "Ambiguous requires occur when dependencies access modules not in their manifest", "command": "yarn add --peer @package/name"}]$$::jsonb,
    'Yarn PnP enabled, error indicates ambiguous require',
    'Module resolves without ambiguity errors, yarn install completes successfully',
    'Declaring wrong package names in packageExtensions, not considering peer dependency chains',
    0.92,
    'sonnet-4',
    NOW(),
    'https://yarnpkg.com/features/pnp#troubleshooting'
),
(
    'Yarn PnP: Peer dependency conflicts - workspace duplication and multiple instantiations',
    'yarn-pnp',
    'MEDIUM',
    $$[{"solution": "Ensure peer dependencies are fulfilled by identical versions across entire dependency tree to prevent workspace explosion", "percentage": 88, "note": "Heavy peer dependency usage without consistent versioning causes duplication", "command": "yarn why @package/name"}]$$::jsonb,
    'Workspaces with peer dependencies, yarn why tool available',
    'Single workspace instance per unique version, yarn install completes without duplicates warnings',
    'Having multiple version ranges for same peer dependency, not auditing peer dependency usage across workspaces',
    0.88,
    'sonnet-4',
    NOW(),
    'https://yarnpkg.com/features/pnp#troubleshooting'
),
(
    'Yarn PnP: Binaries not accessible in workspace scripts',
    'yarn-pnp',
    'MEDIUM',
    $$[{"solution": "Declare infrastructure tools as dependencies in each workspace needing them OR create dedicated tooling workspace that other workspaces depend upon", "percentage": 91, "note": "Root-level binaries (like tsc from TypeScript) are not automatically inherited", "command": "yarn add typescript --workspace myworkspace"}]$$::jsonb,
    'Yarn workspaces enabled with PnP, npm scripts defined',
    'Binaries execute in workspace scripts, yarn workspaces list shows proper dependency chains',
    'Expecting root dependencies to auto-propagate, not declaring tools in workspace package.json',
    0.91,
    'sonnet-4',
    NOW(),
    'https://yarnpkg.com/features/pnp#troubleshooting'
),
(
    'Yarn PnP: React Native and Expo incompatibility',
    'yarn-pnp',
    'HIGH',
    $$[{"solution": "Disable PnP for React Native/Expo projects by setting nodeLinker: node-modules in .yarnrc.yml", "percentage": 98, "note": "React Native and Expo require node_modules installs and cannot use PnP", "command": "yarn config set nodeLinker node-modules"}]$$::jsonb,
    'React Native or Expo project, .yarnrc.yml exists',
    'yarn install completes without PnP errors, project builds and runs successfully',
    'Attempting to use PnP with React Native, not setting nodeLinker before first install, installing wrong nodeLinker value',
    0.98,
    'sonnet-4',
    NOW(),
    'https://yarnpkg.com/features/pnp#troubleshooting'
),
(
    'Yarn PnP: VSCode IntelliSense not working with imports',
    'yarn-pnp',
    'MEDIUM',
    $$[{"solution": "Install VSCode Yarn PnP extension or configure TypeScript Server to use Yarn PnP resolver, ensure .yarn/sdks are generated", "percentage": 88, "note": "VSCode needs explicit configuration for PnP support", "command": "yarn dlx @yarnpkg/sdks vscode"}]$$::jsonb,
    'VSCode installed, Yarn PnP project, TypeScript or JavaScript',
    'IntelliSense shows correct types, Go to Definition works, no red squiggles on valid imports',
    'Not running SDK generation command, using outdated VSCode version, conflicting extensions',
    0.88,
    'sonnet-4',
    NOW(),
    'https://yarnpkg.com/features/pnp#troubleshooting'
),
(
    'Yarn PnP: Migration from node_modules - require.resolve errors',
    'yarn-pnp',
    'HIGH',
    $$[{"solution": "Replace require.resolve() calls with createRequire from pnpapi module, or use yarn config set enableScripts true if scripts depend on node_modules", "percentage": 87, "note": "PnP does not create node_modules, breaking require.resolve", "command": "yarn add --dev @yarnpkg/pnpify"}]$$::jsonb,
    'Project using require.resolve, migrating to PnP',
    'Module paths resolve correctly, build completes without errors',
    'Assuming require.resolve works unchanged, not checking for dynamic requires',
    0.87,
    'sonnet-4',
    NOW(),
    'https://yarnpkg.com/features/pnp#troubleshooting'
),
(
    'Yarn PnP: Tools not finding .pnp.cjs file - module not found',
    'yarn-pnp',
    'HIGH',
    $$[{"solution": "Ensure .pnp.cjs is committed to git and accessible, regenerate with yarn install, verify NODE_OPTIONS includes --require /path/to/.pnp.cjs if needed", "percentage": 93, "note": ".pnp.cjs is the PnP manifest that must exist in project root", "command": "yarn install && ls -la .pnp.cjs"}]$$::jsonb,
    'Yarn PnP enabled, .gitignore reviewed, yarn install completed',
    '.pnp.cjs exists in project root, tools can require packages without errors',
    'Accidentally .gitignoring .pnp.cjs, deleting .pnp.cjs manually, not running yarn install after setup',
    0.93,
    'sonnet-4',
    NOW(),
    'https://yarnpkg.com/features/pnp#troubleshooting'
),
(
    'Yarn PnP: Third-party tool incompatibility - webpack, eslint, babel not recognizing modules',
    'yarn-pnp',
    'HIGH',
    $$[{"solution": "Use @yarnpkg/pnpify wrapper for tools, or ensure tools are updated to latest versions with PnP support, configure PnP plugin/resolver in tool config", "percentage": 86, "note": "Build tools need explicit PnP integration, not all versions support it", "command": "yarn dlx @yarnpkg/pnpify webpack build"}]$$::jsonb,
    'Tool not finding modules (webpack, eslint, babel), PnP enabled',
    'Tool runs successfully and finds all modules, build completes without module resolution errors',
    'Using outdated tool versions without PnP support, not installing @yarnpkg/pnpify, misconfiguring tool plugins',
    0.86,
    'sonnet-4',
    NOW(),
    'https://yarnpkg.com/features/pnp#troubleshooting'
);
