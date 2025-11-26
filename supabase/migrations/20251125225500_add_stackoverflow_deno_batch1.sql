-- Add Stack Overflow Deno runtime questions batch 1 (12 highest-voted questions)

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, last_verified, source_url
) VALUES
(
    'How to use npm module in Deno?',
    'stackoverflow-deno',
    'VERY_HIGH',
    $$[
        {"solution": "Use npm: specifier syntax (Deno 1.25+): import express from \"npm:express\". Run with --unstable flag.", "percentage": 95, "note": "Modern recommended approach, no need for npm install"},
        {"solution": "Use createRequire from std/node/module.ts: import { createRequire } from \"https://deno.land/std/node/module.ts\"; const require = createRequire(import.meta.url);", "percentage": 90, "note": "Works with Node.js dependencies, requires --allow-read and --allow-env"},
        {"solution": "Use CDN providers like esm.sh or jspm.io to convert npm packages to ES modules", "percentage": 85, "note": "Alternative for packages with Node.js specific features"}
    ]$$::jsonb,
    'Deno runtime installed, project with npm dependencies',
    'Module imports without errors, application runs with --unstable flag',
    'npm: specifier requires --unstable flag. Some Node.js APIs may not be fully polyfilled. Not all npm packages are compatible with Deno.',
    0.92,
    NOW(),
    'https://stackoverflow.com/questions/61821038/how-to-use-npm-module-in-deno'
),
(
    'Deno vs ts-node: what is the difference?',
    'stackoverflow-deno',
    'VERY_HIGH',
    $$[
        {"solution": "Understand ts-node is a Node.js module that compiles TypeScript runtime, while Deno is a completely new standalone runtime written in Rust", "percentage": 95, "note": "Key architectural difference"},
        {"solution": "Deno has built-in TypeScript compiler via V8 snapshots with ~28ms startup time vs ts-node ~900ms", "percentage": 90, "note": "Performance is 32x faster for Deno"},
        {"solution": "Deno uses URL-based module imports and requires explicit permissions for file/network access vs ts-node Node.js security model", "percentage": 88, "note": "Fundamental design philosophy differences"}
    ]$$::jsonb,
    'Understanding of Node.js and TypeScript',
    'Can describe architectural differences, startup time comparisons, module system differences',
    'Do not confuse ts-node with Deno - ts-node is just a Node.js transpiler module. Deno is a completely new runtime.',
    0.95,
    NOW(),
    'https://stackoverflow.com/questions/53428120/deno-vs-ts-node-whats-the-difference'
),
(
    'Node.js __dirname & __filename equivalent in Deno',
    'stackoverflow-deno',
    'HIGH',
    $$[
        {"solution": "Use Deno 1.40+ built-in properties: import.meta.dirname and import.meta.filename directly", "percentage": 95, "note": "Simplest modern approach"},
        {"solution": "For older Deno versions, use path.fromFileUrl(import.meta.url) from std/path module for cross-platform compatibility", "percentage": 92, "note": "Works on all Deno versions, handles Windows paths correctly"},
        {"solution": "Alternative legacy approach: const __filename = new URL(\"\", import.meta.url).pathname; const __dirname = new URL(\".\", import.meta.url).pathname;", "percentage": 75, "note": "Unix/macOS only, Windows paths problematic"}
    ]$$::jsonb,
    'Deno 1.40+ for modern approach, or deno/std library access for older versions',
    'Able to reference current file and directory paths in module code',
    'URL constructor approach fails on Windows with path separators. Always prefer std/path for cross-platform code.',
    0.93,
    NOW(),
    'https://stackoverflow.com/questions/61829367/node-js-dirname-filename-equivalent-in-deno'
),
(
    'How can one check if a file or directory exists using Deno?',
    'stackoverflow-deno',
    'HIGH',
    $$[
        {"solution": "Use Deno.stat() with error handling: try { await Deno.stat(filename); return true; } catch (error) { if (error instanceof Deno.errors.NotFound) return false; }", "percentage": 93, "note": "Most reliable modern approach"},
        {"solution": "Use existsSync() from deno.land/std/fs module: import {existsSync} from \"https://deno.land/std/fs/mod.ts\";", "percentage": 90, "note": "Synchronous operation, simpler syntax"},
        {"solution": "Use async exists() with options: import { exists } from \"https://deno.land/std/fs/mod.ts\"; const fileExists = await exists(\"./file\", {isFile: true});", "percentage": 88, "note": "Requires --unstable flag, allows checking file type"}
    ]$$::jsonb,
    'Deno with appropriate --allow-read permissions, file path accessible',
    'Function returns boolean value, no file-not-found errors thrown',
    'exists() deprecated and restored multiple times. Prefer Deno.stat() for reliability. Race conditions possible with exists() due to TOCTOU.',
    0.91,
    NOW(),
    'https://stackoverflow.com/questions/56658114/how-can-one-check-if-a-file-or-directory-exists-using-deno'
),
(
    'How can I avoid the \"an import path cannot end with .ts extension\" error in VSCode?',
    'stackoverflow-deno',
    'HIGH',
    $$[
        {"solution": "Install official Deno VSCode extension and run \"Deno: initialize workspace\" command (Ctrl+Shift+P)", "percentage": 94, "note": "Automatically creates proper .vscode/settings.json"},
        {"solution": "Manually configure .vscode/settings.json with: {\"deno.enable\": true, \"deno.lint\": true}", "percentage": 92, "note": "Direct configuration approach"},
        {"solution": "For non-Deno projects, add \"allowImportingTsExtensions\": true to tsconfig.json as workaround", "percentage": 70, "note": "Only for mixed TypeScript/Deno projects"}
    ]$$::jsonb,
    'Visual Studio Code with TypeScript support, Deno project with .ts imports',
    'No ts(2691) errors in VSCode editor, import statements recognized',
    'Deno extension must be enabled. Default TypeScript language server blocks .ts extensions in imports. Requires workspace reinitialization after extension install.',
    0.94,
    NOW(),
    'https://stackoverflow.com/questions/65115527/how-can-i-avoid-the-an-import-path-cannot-end-with-ts-extension-error-in-vsco'
),
(
    'How do I read a local file in Deno?',
    'stackoverflow-deno',
    'HIGH',
    $$[
        {"solution": "Use Deno.readTextFile() for async text reading: const text = await Deno.readTextFile(\"input.txt\");", "percentage": 95, "note": "Most common modern approach"},
        {"solution": "Use Deno.readFile() for binary data: const bytes = await Deno.readFile(\"file.bin\"); then decode: new TextDecoder().decode(bytes);", "percentage": 92, "note": "For binary files and raw bytes"},
        {"solution": "Use synchronous Deno.readTextFileSync() for simple scripts without async/await", "percentage": 88, "note": "Blocks execution, use only for simple cases"}
    ]$$::jsonb,
    'Deno runtime with --allow-read=<path> permission, file exists and is readable',
    'File contents returned as string or Uint8Array, no permission errors',
    'readFileStr and old deno module methods are obsolete. fetch() with file: URLs does not work. Permissions must include exact file path.',
    0.93,
    NOW(),
    'https://stackoverflow.com/questions/51941064/how-do-i-read-a-local-file-in-deno'
),
(
    'How to debug Deno in VSCode?',
    'stackoverflow-deno',
    'MEDIUM',
    $$[
        {"solution": "Install Deno VSCode extension (v2.3.0+), press F5 to debug active file without configuration", "percentage": 96, "note": "Simplest modern approach since v2.3.0"},
        {"solution": "Create .vscode/launch.json with node type config using Deno.Command with --inspect-brk flag and port 9229", "percentage": 90, "note": "Manual configuration for custom debug setups"},
        {"solution": "Use Ctrl+Shift+D to auto-generate launch.json, select Deno option to create default debug config", "percentage": 92, "note": "Guided configuration approach"}
    ]$$::jsonb,
    'VSCode with Deno extension, Deno script file, debug port available',
    'Debugger connects and hits breakpoints, can inspect variables and call stack',
    'Old --inspect flag does not wait for debugger. Must use --inspect-brk or --inspect-wait (Deno 1.29+). Port 9229 may need adjustment for attachSimplePort.',
    0.92,
    NOW(),
    'https://stackoverflow.com/questions/61853754/how-to-debug-deno-in-vscode'
),
(
    'Where can I see deno downloaded packages?',
    'stackoverflow-deno',
    'MEDIUM',
    $$[
        {"solution": "Run \"deno info\" command to see DENO_DIR cache location, remote modules in deps/ subdirectory, TypeScript cache in gen/", "percentage": 95, "note": "Official recommended method"},
        {"solution": "Default DENO_DIR locations by OS: Linux ($HOME/.cache/deno), Windows (%LOCALAPPDATA%/deno), macOS ($HOME/Library/Caches/deno)", "percentage": 93, "note": "Defaults if DENO_DIR not set"},
        {"solution": "Set DENO_DIR environment variable to use custom cache location for sharing across projects", "percentage": 88, "note": "Centralized OS-level cache enables package reuse"}
    ]$$::jsonb,
    'Deno runtime installed, terminal access, DENO_DIR environment variable (optional)',
    'Able to view cached module files, deno info command shows cache structure',
    'DENO_DIR defaults to system cache dir. Packages are globally cached across all projects. Custom DENO_DIR persists between Deno versions.',
    0.94,
    NOW(),
    'https://stackoverflow.com/questions/61799309/where-can-i-see-deno-downloaded-packages'
),
(
    'How do I run an arbitrary shell command from Deno?',
    'stackoverflow-deno',
    'MEDIUM',
    $$[
        {"solution": "Use Deno.Command API (1.28.0+): new Deno.Command(\"echo\", {args: [\"hello\"]}).output(). Requires --allow-run permission.", "percentage": 95, "note": "Modern recommended API"},
        {"solution": "Legacy Deno.run() API (deprecated): Deno.run({cmd: [\"echo\", \"hello\"], stdout: \"piped\"}).output()", "percentage": 80, "note": "Still works but deprecated"},
        {"solution": "For shell built-ins, wrap in shell: new Deno.Command(\"bash\", {args: [\"-c\", \"your command\"]})", "percentage": 90, "note": "Required for pipes and shell redirects"}
    ]$$::jsonb,
    'Deno runtime with --allow-run permission, command executable in system PATH',
    'Command output captured successfully, process exits with status code',
    'Deno.run() is deprecated, migrate to Deno.Command. Must await output or status. Direct shell commands need bash/pwsh wrapper.',
    0.91,
    NOW(),
    'https://stackoverflow.com/questions/62142699/how-do-i-run-an-arbitrary-shell-command-from-deno'
),
(
    'How to delete runtime import cache in deno?',
    'stackoverflow-deno',
    'MEDIUM',
    $$[
        {"solution": "Run deno clean command (v1.46+) to purge entire global cache: deno clean", "percentage": 96, "note": "Native solution since v1.46"},
        {"solution": "Use --reload flag when running: deno run --reload script.ts to recompile modules without cached versions", "percentage": 92, "note": "Targets specific script, can use --reload=<url> for specific modules"},
        {"solution": "Manual deletion: identify DENO_DIR location with \"deno info\", delete files from deps/ and gen/ subdirectories", "percentage": 85, "note": "Manual approach for older versions"}
    ]$$::jsonb,
    'Deno runtime, write access to DENO_DIR cache directory',
    'Cache cleared successfully, modules redownloaded and recompiled on next run',
    'No runtime equivalent to Node.js delete require.cache[]. Query string parameter workaround may fail with HTTP caching headers. Always use --reload for development changes.',
    0.88,
    NOW(),
    'https://stackoverflow.com/questions/61903993/how-to-delete-runtime-import-cache-in-deno'
),
(
    'Getting values from Deno stdin',
    'stackoverflow-deno',
    'MEDIUM',
    $$[
        {"solution": "Use prompt() function (simplest): const input = prompt(\"Enter input:\"); Number.parseInt(input) for numbers", "percentage": 93, "note": "Interactive input, easiest approach"},
        {"solution": "Use modern ReadableStream API: const input = await new Response(Deno.stdin.readable).text();", "percentage": 90, "note": "Standard web API approach"},
        {"solution": "Read line-by-line: import { readLines } from \"https://deno.land/std/io/mod.ts\"; for await (const line of readLines(Deno.stdin))", "percentage": 88, "note": "For multi-line interactive input"}
    ]$$::jsonb,
    'Deno runtime with stdin available, for prompt() requires interactive terminal',
    'User input successfully captured and available as string or array',
    'Direct buffer reading may not respect UTF-8 boundaries or complete lines. prompt() works best for single values. readLines needs proper EOF handling.',
    0.89,
    NOW(),
    'https://stackoverflow.com/questions/58019572/getting-values-from-deno-stdin'
),
(
    'How to exit in Deno? (analog of process.exit)',
    'stackoverflow-deno',
    'MEDIUM',
    $$[
        {"solution": "Use Deno.exit(code) where code is optional exit status: Deno.exit(1) for error, Deno.exit(0) for success", "percentage": 96, "note": "Direct equivalent to Node.js process.exit()"},
        {"solution": "Exit code defaults to 0 if not specified: Deno.exit() exits with success", "percentage": 94, "note": "Optional parameter"},
        {"solution": "Register unload event listener for cleanup before exit: globalThis.addEventListener(\"unload\", () => { cleanup(); })", "percentage": 85, "note": "Triggered when Deno.exit() called"}
    ]$$::jsonb,
    'Deno runtime, script needs to terminate with status code',
    'Process exits with correct status code, return code visible to shell or parent process',
    'Deno.exit() is the only method for exit codes. globalThis.addEventListener(\"unload\") triggers on exit for cleanup. No process object like Node.js.',
    0.95,
    NOW(),
    'https://stackoverflow.com/questions/53030483/how-to-exit-in-deno-analog-of-process-exit'
);
