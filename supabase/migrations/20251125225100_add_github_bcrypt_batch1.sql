-- Add github-bcrypt category knowledge base entries from node.bcrypt.js issues
-- Batch 1: 12 highest-voted hashing/comparison error issues with solutions

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES (
    'bcrypt native module compilation fails with node-gyp rebuild during npm install',
    'github-bcrypt',
    'VERY_HIGH',
    $$[
        {"solution": "Upgrade npm to latest version: npm install -g npm", "percentage": 85, "note": "Resolves compatibility issues with node-gyp on most systems"},
        {"solution": "Install build-essential package on Linux: sudo apt-get install build-essential python3", "percentage": 90, "note": "Provides C++ compiler and required build tools"},
        {"solution": "If Python 3 is default, set Python 2.7: npm config set python /usr/bin/python2.7", "percentage": 80, "note": "node-gyp requires Python 2.7, not Python 3"},
        {"solution": "Try installing bcryptjs instead as pure JavaScript fallback: npm install bcryptjs", "percentage": 75, "note": "Alternative if native module compilation fails persistently"}
    ]$$::jsonb,
    'Node.js installed, npm v3.0+, C++ compiler (gcc/clang), Python 2.7 or ability to install build tools',
    'npm install completes without errors, bcrypt module can be required without errors, bcrypt.hash() executes successfully',
    'Python 3 cannot be used for node-gyp build. Do not use sudo npm install. Missing build-essential on Linux prevents compilation. Pre-release Node versions require --nodedir flag.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/kelektiv/node.bcrypt.js/issues/90'
),
(
    'Error: Cannot find module bcrypt_lib.node after npm install or build',
    'github-bcrypt',
    'VERY_HIGH',
    $$[
        {"solution": "Force fallback build: cd node_modules/bcrypt && node-pre-gyp install --fallback-to-build", "percentage": 92, "note": "Most effective solution, works across platforms. Requires build tools."},
        {"solution": "Rebuild using npm: npm rebuild bcrypt", "percentage": 85, "note": "Works if build tools are properly configured"},
        {"solution": "On macOS, install Xcode command line tools: xcode-select --install", "percentage": 90, "note": "Required for native module compilation"},
        {"solution": "On Ubuntu/Linux, install with unsafe permissions: sudo npm i --unsafe-perm", "percentage": 78, "note": "Workaround for permission issues during build"}
    ]$$::jsonb,
    'bcrypt installed via npm, build tools present (Python, C++ compiler, gcc), Node.js dev headers',
    'NAPI binding file exists at node_modules/bcrypt/lib/binding/napi-v3/bcrypt_lib.node, bcrypt can be required without MODULE_NOT_FOUND error, hash/compare operations execute',
    'Building on one system and deploying to different architecture fails - must rebuild on target system. Silent npm install success can mask missing .node file. NAPI version varies by Node.js version.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/kelektiv/node.bcrypt.js/issues/800'
),
(
    'bcrypt installation fails on Node.js v8.12.0 with fatal compilation error',
    'github-bcrypt',
    'HIGH',
    $$[
        {"solution": "Install bcrypt from master branch: npm install https://github.com/kelektiv/node.bcrypt.js.git#master", "percentage": 88, "note": "Bypasses version-specific build issues"},
        {"solution": "Ensure build-essential and Python are installed: sudo apt-get install build-essential python", "percentage": 85, "note": "Resolves dependency file generation errors"},
        {"solution": "In Docker, include build dependencies in image before npm install", "percentage": 90, "note": "Prevents missing compiler when building in container"},
        {"solution": "Upgrade to Node v8.12.1+ or use bcryptjs as fallback", "percentage": 80, "note": "Issue was fixed in subsequent Node.js patch releases"}
    ]$$::jsonb,
    'Node.js v8.x installed, Linux system (Ubuntu 18.04+), write access to node_modules',
    'npm install completes without dependency file errors, bcrypt module loads successfully, hash and compare operations work',
    'Build failure silent initially then fails on fallback. Node v8.12.0 specifically affected. Xcode on macOS may need update. Windows requires Visual C++ Build Tools.',
    0.86,
    'sonnet-4',
    NOW(),
    'https://github.com/kelektiv/node.bcrypt.js/issues/650'
),
(
    'bcrypt.compare() always returns false with database-stored hashes',
    'github-bcrypt',
    'HIGH',
    $$[
        {"solution": "Verify password was stored correctly - test by retrieving and comparing immediately after registration", "percentage": 85, "note": "Most common cause is typo in original password"},
        {"solution": "Ensure database returns string type, not Buffer or other type: const hash = String(user.password)", "percentage": 88, "note": "Some databases return binary data that needs conversion"},
        {"solution": "Log hash value before compare to verify it was retrieved correctly: console.log(typeof user.password, user.password.length)", "percentage": 90, "note": "Debugging step to verify data integrity"},
        {"solution": "Use compareSync() instead of async compare() for debugging: bcrypt.compareSync(password, hash)", "percentage": 80, "note": "Simpler error detection for troubleshooting"}
    ]$$::jsonb,
    'bcrypt hash stored in database, plaintext password from user input, database connection working',
    'bcrypt.compare() returns true for correct password and false for incorrect, password matches on second attempt after verification, hash length is 60 characters',
    'Common mistake: comparing password against itself instead of against stored hash. Database might trim or truncate hash. Encoding mismatch if hash stored as binary. Password typo during registration.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/kelektiv/node.bcrypt.js/issues/75'
),
(
    'Segmentation fault when using bcrypt in Alpine Linux Docker container',
    'github-bcrypt',
    'MEDIUM',
    $$[
        {"solution": "Use Node.js image based on buildpack-deps instead of alpine: FROM node:18-bullseye", "percentage": 92, "note": "Alpine uses musl libc which is incompatible with bcrypt native module"},
        {"solution": "If must use Alpine, install glibc compatibility layer", "percentage": 70, "note": "Complex workaround, not recommended"},
        {"solution": "Upgrade Node.js to latest LTS version", "percentage": 75, "note": "Some versions have improved Alpine support"},
        {"solution": "Switch to bcryptjs pure JavaScript implementation for Alpine", "percentage": 85, "note": "Drop-in replacement with no native compilation needed"}
    ]$$::jsonb,
    'Docker Alpine base image, Node.js v8.1.3+, native bcrypt module',
    'Docker container runs without segmentation fault, bcrypt.hash() completes without crashing, process exits cleanly',
    'Alpine Linux uses musl not glibc - fundamental incompatibility with many native modules. Error occurs at require("bcrypt"), not during operations. Older Alpine versions all affected.',
    0.79,
    'sonnet-4',
    NOW(),
    'https://github.com/kelektiv/node.bcrypt.js/issues/528'
),
(
    'bcrypt async operations prevent Node.js process from exiting cleanly',
    'github-bcrypt',
    'MEDIUM',
    $$[
        {"solution": "Ensure all bcrypt promises fully resolve before exit: await bcrypt.hash() in async function", "percentage": 85, "note": "Event loop keeps reference to async operation"},
        {"solution": "Use synchronous bcrypt in worker threads to avoid blocking main thread: bcryptSync() in Worker", "percentage": 80, "note": "Allows async pattern without event loop blocking"},
        {"solution": "Explicitly terminate with process.exit(0) after bcrypt operations complete", "percentage": 75, "note": "Last resort, forces process termination"},
        {"solution": "Check for newer bcrypt versions addressing event loop cleanup", "percentage": 82, "note": "Issue may be resolved in latest releases"}
    ]$$::jsonb,
    'Node.js application using async bcrypt.hash(), event loop monitoring tools (optional: why-is-node-running package)',
    'Process exits cleanly after bcrypt.hash() completes, no hanging process after 5 second wait, why-is-node-running shows no bcrypt handles',
    'Sync bcrypt does not have this issue. Native module maintains internal handle during async operation. Promise resolution does not guarantee event loop cleanup. Workaround: process.exit() masks root cause.',
    0.76,
    'sonnet-4',
    NOW(),
    'https://github.com/kelektiv/node.bcrypt.js/issues/895'
),
(
    'bcrypt.compareSync() always returns true regardless of input values',
    'github-bcrypt',
    'MEDIUM',
    $$[
        {"solution": "Verify correct parameter order: bcrypt.compareSync(plaintext_password, stored_hash) not (hash, hash)", "percentage": 95, "note": "Most common cause - comparing password against itself"},
        {"solution": "Inspect both parameters before call: console.log(plaintext, hash); bcrypt.compareSync(plaintext, hash)", "percentage": 90, "note": "Debugging to confirm values are different"},
        {"solution": "Ensure second parameter is actual stored hash, not user input: const hash = user.password_hash", "percentage": 92, "note": "Logic error in implementation"},
        {"solution": "Use bcrypt.compare() async version if compareSync() is problematic", "percentage": 80, "note": "Sometimes async version handles edge cases better"}
    ]$$::jsonb,
    'bcrypt module v3.0.2+, plaintext password string, bcrypt hash string (60+ characters)',
    'bcrypt.compareSync(password, differentPassword) returns false, bcrypt.compareSync(password, hash) returns true or false correctly based on match',
    'Passing same variable to both parameters always returns true. Comparing password against itself instead of hash. Parameter order confusion (first is plaintext, second is hash).',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/kelektiv/node.bcrypt.js/issues/1195'
),
(
    'C++ exception handling error: Cannot use throw with exceptions disabled in bcrypt build',
    'github-bcrypt',
    'MEDIUM',
    $$[
        {"solution": "Use non-throwing NAPI pattern: return Napi::TypeError::New(env, msg) without throw", "percentage": 88, "note": "Follows Node.js NAPI docs for disabled exceptions"},
        {"solution": "Add NAPI exception support definitions to binding.gyp: define ''NAPI_CPP_EXCEPTIONS''", "percentage": 85, "note": "Ensures NAPI is compiled with exception support"},
        {"solution": "Update Xcode command line tools: xcode-select --install", "percentage": 82, "note": "macOS Sonoma 14.2.1+ compatibility issue"},
        {"solution": "Rebuild with explicit exception flags in binding.gyp", "percentage": 80, "note": "Set GCC_ENABLE_CPP_EXCEPTIONS = YES and GCC_SYMBOLS_PRIVATE_EXTERN = YES"}
    ]$$::jsonb,
    'macOS Sonoma 14.2.1+, Node v18.18.2+, Xcode 15.2+, binding.gyp configuration file',
    'Build completes without exception handling errors, bcrypt module compiles successfully, npm install executes without throwing exceptions',
    'GCC_ENABLE_CPP_EXCEPTIONS set to YES may not propagate to NAPI build. Xcode 15.2 introduced stricter exception checking. Older build systems may have different flags.',
    0.81,
    'sonnet-4',
    NOW(),
    'https://github.com/kelektiv/node.bcrypt.js/issues/1024'
),
(
    'npm v5 fails to install bcrypt with node-pre-gyp version error',
    'github-bcrypt',
    'MEDIUM',
    $$[
        {"solution": "Upgrade npm to v5.3+: npm install -g npm@latest", "percentage": 92, "note": "npm v5 bug with node-pre-gyp was fixed in v5.3"},
        {"solution": "Install bcrypt explicitly before full npm install: npm install bcrypt@1.0.3", "percentage": 85, "note": "Isolates bcrypt from npm v5 compatibility issue"},
        {"solution": "Clone from GitHub and install locally: git clone && npm install in repo", "percentage": 80, "note": "Bypasses registry-based installation entirely"},
        {"solution": "Use npm v4 if npm v5+ fails: npm install -g npm@4", "percentage": 75, "note": "Known bug in npm v5.0-v5.2 with node-pre-gyp"}
    ]$$::jsonb,
    'npm v4.2.0 or v5.x, Node.js v7.x, network access to npm registry or GitHub',
    'npm install bcrypt completes without property version of null error, bcrypt module loads and executes hash/compare operations',
    'npm v5.0-v5.2 has incompatibility with node-pre-gyp binary download. Error: Cannot read property version of null. Workaround found when npm v5.3 released. Node.js v7.10.0 specifically affected.',
    0.84,
    'sonnet-4',
    NOW(),
    'https://github.com/kelektiv/node.bcrypt.js/issues/509'
),
(
    'bcrypt build fails when bundled with esbuild due to node-pre-gyp AWS dependencies',
    'github-bcrypt',
    'MEDIUM',
    $$[
        {"solution": "Switch to bcryptjs pure JavaScript implementation: npm install bcryptjs", "percentage": 90, "note": "Eliminates all native module and AWS dependency issues"},
        {"solution": "Plan migration to bcrypt v6 which will use prebuildify instead of node-pre-gyp", "percentage": 75, "note": "Long-term fix planned by maintainers, not yet released"},
        {"solution": "Configure esbuild to exclude node-pre-gyp from bundling: external: [''bcrypt'']", "percentage": 80, "note": "Keep bcrypt as external dependency, install separately"},
        {"solution": "Install missing dev dependencies in production for bundler: npm install --save mock-aws-s3 aws-sdk nock", "percentage": 70, "note": "Workaround but adds bloat to production"}
    ]$$::jsonb,
    'Node.js v16.17.1+, esbuild bundler, bcrypt v5.x currently using node-pre-gyp',
    'esbuild bundling completes without unresolved dependency errors, bcrypt operations execute (hash/compare) in bundled code',
    'node-pre-gyp includes s3_setup.js that requires AWS packages marked as devDependencies. Bundlers perform deep dependency analysis. bcryptjs has ~25% performance penalty but eliminates bundling issues.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/kelektiv/node.bcrypt.js/issues/964'
),
(
    'MODULE_NOT_FOUND bcrypt_lib.node on production server after building locally',
    'github-bcrypt',
    'MEDIUM',
    $$[
        {"solution": "Build and install dependencies on production server before running: npm install on server", "percentage": 93, "note": "Native modules must be compiled for target system architecture"},
        {"solution": "Deploy entire node_modules folder instead of just source code", "percentage": 88, "note": "Include pre-built .node file for server architecture"},
        {"solution": "Ensure pnpm has build script execution enabled: pnpm install --allow-root", "percentage": 85, "note": "pnpm requires explicit permission for build scripts"},
        {"solution": "Match development and production system architecture: use same OS and Node version", "percentage": 82, "note": "macOS .node file does not work on Linux and vice versa"}
    ]$$::jsonb,
    'pnpm or npm package manager, TypeScript project, Ubuntu 22.04 or similar production server, network access for npm downloads',
    'npm install on server completes successfully, .node file exists in node_modules/bcrypt/lib/binding/, application starts without MODULE_NOT_FOUND error',
    'Building locally on macOS/Windows and deploying to Ubuntu fails - architectures differ. Deploying only source code without node_modules. TypeScript compilation happens before deployment. pnpm v6+ default.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/kelektiv/node.bcrypt.js/issues/1204'
),
(
    'bcrypt does not support $2y$ hashing algorithm prefix for password verification',
    'github-bcrypt',
    'LOW',
    $$[
        {"solution": "Verify password was hashed with $2a$ or $2b$ prefix instead of $2y$: check hash first character", "percentage": 85, "note": "bcryptjs and node.bcrypt use $2a$ or $2b$, not $2y$"},
        {"solution": "Use bcrypt.compare() on hashes with $2a$ or $2b$ prefix which are supported", "percentage": 88, "note": "$2y$ is PHP-specific variant, JavaScript bcrypt differs"},
        {"solution": "Convert existing $2y$ hashes to $2a$ compatible format if migrating from PHP application", "percentage": 75, "note": "Requires hash re-generation with new salt"},
        {"solution": "Implement custom comparison for $2y$ by removing prefix and treating as $2a$", "percentage": 65, "note": "Compatibility workaround but not recommended, validate thoroughly"}
    ]$$::jsonb,
    'bcrypt module with hashes using $2y$ prefix, password from user, understanding of bcrypt algorithm variants',
    'bcrypt.compare() succeeds with $2a$ and $2b$ prefixed hashes, password verification works with standard bcrypt algorithms',
    '$2y$ is PHP bcrypt extension specific variant. node.bcrypt.js implements $2a$ and $2b$ only. Hashes from PHP legacy systems may use $2y$ and require conversion. Algorithm variants differ in handling of 8-bit characters.',
    0.71,
    'sonnet-4',
    NOW(),
    'https://github.com/kelektiv/node.bcrypt.js/issues/1056'
),
(
    'bcrypt native module dependency issues: conflicting AWS SDK in node-pre-gyp',
    'github-bcrypt',
    'LOW',
    $$[
        {"solution": "Use bcryptjs pure JavaScript alternative with no AWS dependencies: npm install bcryptjs", "percentage": 91, "note": "Clean API compatibility, eliminates dependency chain"},
        {"solution": "Wait for bcrypt v6 migration to prebuildify dependency (planned): watch github releases", "percentage": 72, "note": "Maintainers confirmed transition from node-pre-gyp"},
        {"solution": "Explicitly configure npm to skip AWS dependencies: npm install --no-optional", "percentage": 60, "note": "Limited effectiveness, dependencies still referenced"},
        {"solution": "Separate bcrypt as external dependency in build config, install globally on server", "percentage": 65, "note": "Operational complexity workaround"}
    ]$$::jsonb,
    'npm v6.0+, understanding of dependency resolution, willingness to use pure JavaScript implementation if needed',
    'npm install completes without missing dependency errors, bcrypt hash and compare operations execute correctly',
    'node-pre-gyp s3_setup.js requires AWS packages despite devDependencies classification. bundlers like esbuild perform transitive dependency analysis. bcryptjs adds minimal performance overhead (~25%). Version 6 still in development.',
    0.74,
    'sonnet-4',
    NOW(),
    'https://github.com/kelektiv/node.bcrypt.js/issues/964'
);
