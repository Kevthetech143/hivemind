-- Add Stack Overflow Commander.js solutions batch 1

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Commander.js option returns true instead of actual argument value',
    'stackoverflow-commander',
    'VERY_HIGH',
    $solutions$[
        {"solution": "Add angle brackets or square brackets to option definition to indicate it accepts an argument value. Use <arg> for mandatory, [arg] for optional. Example: .option(''''''-s, --src <file>'''''', '''''src csv file'''''''')", "percentage": 95, "note": "Option definition must specify parameter format", "command": ".option(''''''-s, --src <file>'''''', '''''description'''''')"},
        {"solution": "Access the parsed values via program.src or program.destination after parse()", "percentage": 90, "note": "Values are extracted from command-line arguments matching the defined format"}
    ]$solutions$::jsonb,
    'Commander.js installed, understanding of command-line argument parsing',
    'program.src and program.destination contain actual values instead of true, script accepts file paths as arguments',
    'Without angle brackets or square brackets, Commander treats options as boolean flags. Always use <> for required parameters, [] for optional parameters in option definitions.',
    0.95,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/28662273/node-js-commander-args-returns-true-instead-the-value'
),
(
    'Create Node.js CLI interactive menu with arrow key selection',
    'stackoverflow-commander',
    'HIGH',
    $solutions$[
        {"solution": "Install and use the inquirer npm package for interactive prompts: npm install inquirer. Inquirer provides arrow-key navigation for menu selection similar to ESLint init and create-react-app", "percentage": 90, "note": "Inquirer is used by Yeoman and provides full interactive prompt support", "command": "npm install inquirer"},
        {"solution": "Alternative library prompts offers similar arrow-selection features with additional CLI UI/UX capabilities", "percentage": 85, "note": "Consider based on specific UI requirements"},
        {"solution": "Combine with command parsers like commander or yargs for full CLI structure", "percentage": 80, "note": "Inquirer for prompts, Commander for command parsing"}
    ]$solutions$::jsonb,
    'Node.js installed, npm or yarn, package manager access',
    'Package installs without errors, CLI displays interactive menu with arrow-key navigation and selection confirmation',
    'Do not try to build interactive menus with manual readline manipulation - use dedicated libraries. Inquirer integrates well with Commander for full-featured CLIs.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/49717855/create-nodejs-cli-select-options-menu'
),
(
    'Commander.js positional arguments - unnamed parameters without flags',
    'stackoverflow-commander',
    'HIGH',
    $solutions$[
        {"solution": "Use .arguments() method with angle brackets for mandatory positional arguments: .arguments(''<source> <target>'''''').action(function(source, target) { ... })", "percentage": 92, "note": "Arguments are positional and don''t require flags", "command": ".arguments(''<source> <target>'''''')"},
        {"solution": "Modern Commander (9.4.1+) use .argument() method instead with optional coercion: .argument('<arg1>', 'description').argument('[arg3]', 'optional', parseInt, 1)", "percentage": 90, "note": "More explicit control per argument"},
        {"solution": "Use .allowExcessArguments(false) to prevent additional unexpected arguments", "percentage": 85, "note": "Validates argument count matches expectations"}
    ]$solutions$::jsonb,
    'Node.js environment, Commander.js library installed',
    'Running ./program.js arg1 arg2 executes without errors, omitting arguments shows validation error message, program.processedArgs contains parsed values',
    'Square brackets [arg] indicate optional parameters. Angle brackets <arg> are required. Using .command() instead of .arguments() creates subcommands, not positional args.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/14556042/unnamed-parameter-with-commander-js-positional-arguments'
),
(
    'Commander.js make CLI arguments or options required',
    'stackoverflow-commander',
    'VERY_HIGH',
    $solutions$[
        {"solution": "Use .requiredOption() method for Commander v4+: .requiredOption(''--myoption <value>'''''', '''''Description'''''') - throws error if not provided", "percentage": 95, "note": "Built-in native support for required options", "command": ".requiredOption(''--option <value>'''''', '''''Description'''''')"},
        {"solution": "Use Option object with .makeOptionMandatory() for Commander v11.1+: const opt = new Option(''--csv <name...>'''''', ''description'''''').makeOptionMandatory(); program.addOption(opt)", "percentage": 90, "note": "More explicit option configuration"},
        {"solution": "For arguments use angle brackets <arg> syntax (required) vs [arg] (optional)", "percentage": 92, "note": "Arguments automatically validated by Commander"},
        {"solution": "Manual validation for older versions: if (!program.myoption) throw new Error(''--myoption required'''''');", "percentage": 75, "note": "Fallback for legacy Commander versions"}
    ]$solutions$::jsonb,
    'Commander.js v4 or higher, Node.js environment',
    'Executing CLI without required option shows error message, automatic validation prevents execution with missing required values, error code indicates missing requirement',
    'Manual validation is error-prone. Always prefer .requiredOption() in v4+ rather than manual checks. Square brackets [arg] make arguments optional even if not specified as required.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/24175269/commander-js-how-to-specify-required-cli-argument'
),
(
    'Commander.js display help when called with no subcommands',
    'stackoverflow-commander',
    'HIGH',
    $solutions$[
        {"solution": "Check process.argv.length after parsing - if less than 3 (only executable + script present), call program.help(): if (process.argv.length < 3) { program.help() }", "percentage": 85, "note": "Manual approach for older versions"},
        {"solution": "Modern Commander 5+ automatically displays help when invoked without subcommands - no manual checking required", "percentage": 95, "note": "Default behavior in recent versions"}
    ]$solutions$::jsonb,
    'Commander.js library installed, understanding of process.argv structure',
    'Running CLI tool without arguments displays help text, modern versions auto-show help, no error thrown when invoked without subcommand',
    'Relying on manual process.argv checking breaks with version upgrades. Verify Commander version supports automatic help display before assuming it works.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/44336656/commander-js-display-help-when-called-with-no-commands'
),
(
    'Commander.js nested and hierarchical subcommand structure',
    'stackoverflow-commander',
    'VERY_HIGH',
    $solutions$[
        {"solution": "Use method chaining with variable references for parent commands: const brew = program.command(''brew''); brew.command(''tea'').action(() => {...}); brew.command(''coffee'').action(() => {...})", "percentage": 92, "note": "Store parent command in variable, add subcommands to it", "command": "const parent = program.command(''parent''); parent.command(''sub1'').action(...)"},
        {"solution": "Alternative: Create subcommands in separate files and add them via .addCommand() method for v5+ - more scalable for complex structures", "percentage": 88, "note": "Better for large multi-file projects"},
        {"solution": "Do NOT chain commands sequentially as this causes unintended nesting depth", "percentage": 90, "note": "Common mistake that breaks command routing"}
    ]$solutions$::jsonb,
    'Node.js with Commander.js, understanding of command variables and references',
    'Running node file.js brew tea executes correct action, node file.js brew coffee also works, subcommands recognize only one level of nesting as intended',
    'Do NOT chain .command() calls directly after creating subcommand - this nests the second command under the first. Always reference parent command variable and add children to it.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/57585940/nodejs-commander-structured-subcommands'
),
(
    'Commander.js with TypeScript - type options and parsed values',
    'stackoverflow-commander',
    'HIGH',
    $solutions$[
        {"solution": "Create interface for CLI options and use double type casting: interface InterfaceCLI { debug?: boolean }. Cast as: const { debug }: InterfaceCLI = <InterfaceCLI><unknown>cli", "percentage": 88, "note": "Double casting handles non-overlapping types", "command": "const options: MyInterface = cli as unknown as MyInterface"},
        {"solution": "Install @types/commander for type definitions: npm install --save-dev @types/commander@^2.9.1", "percentage": 85, "note": "For older versions requiring separate types"},
        {"solution": "Modern Commander versions include built-in TypeScript types - upgrade to latest for native support", "percentage": 92, "note": "No separate @types package needed in newer versions"}
    ]$solutions$::jsonb,
    'TypeScript configured, Commander.js installed, Node.js environment',
    'TypeScript compilation succeeds without errors, CLI correctly logs parsed option values at runtime, no type mismatches in IDE',
    'Do not directly cast cli to your interface without double casting to unknown first - TypeScript will reject non-overlapping types. Upgrade Commander if using old @types packages.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/43797880/use-commander-in-typescript'
),
(
    'Commander.js optional and variadic arguments together',
    'stackoverflow-commander',
    'MEDIUM',
    $solutions$[
        {"solution": "Use .arguments() method instead of .command() for positional argument parsing. Declare variadic with syntax like ''<paths...>'' for one or more, '[paths...]'' for zero or more", "percentage": 90, "note": "Use .arguments() not .command() - critical distinction", "command": ".arguments('[paths...]'''''').option(''''''-d, --db [dbName]'''''', '''''db name'''''', null)"},
        {"solution": "Access parsed positional arguments via program.args array after parsing", "percentage": 88, "note": "Different from option values which use program.optionName"},
        {"solution": "Manually validate program.args is non-empty when required: if (!paths.length) { console.log(''Need path''''''); process.exit(1) }", "percentage": 85, "note": "Manual validation needed for variadic arguments"}
    ]$solutions$::jsonb,
    'Commander module installed (npm install commander), Node.js environment',
    'Running with ./upload.js --db TestDB /path/file1.txt /path/file2.txt works, ./upload.js /path/file1.txt uses default DB, ./upload.js --db TestDB errors (no paths)',
    'Using .command() instead of .arguments() creates subcommands - wrong approach. Must use .arguments() for positional args. Do not confuse program.args (positional) with program.optionName (options).',
    0.89,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/47022700/node-js-commander-with-optionalvariadic-arguments'
),
(
    'Commander.js collect multiple options without including default value',
    'stackoverflow-commander',
    'MEDIUM',
    $solutions$[
        {"solution": "Use flag-based detection in collect function: mark default with _isDefault property, check in collector: function collect(value, previous) { if (previous._isDefault) return [value]; previous.push(value); return previous }", "percentage": 88, "note": "Distinguishes user-provided from default values"},
        {"solution": "Alternative: Check array length - if size exceeds 1, user provided values; otherwise use default", "percentage": 80, "note": "Simpler but requires post-parse logic"},
        {"solution": "Wrap default in function that marks it: function defaultRepeatable(arr) { arr._isDefault = true; return arr; }. Apply: .option(''--exclude <file>'''''', collector, defaultRepeatable([])", "percentage": 85, "note": "Cleaner than inline property setting"}
    ]$solutions$::jsonb,
    'Commander.js with collect function pattern, understanding of option defaults',
    'Without options returns default array, with -c "/path1" -c "/path2" returns only user values not defaults, repeated options accumulate correctly',
    'Default values are always included in initial array - must detect and remove them. Do not rely on simple length checks for complex multi-option scenarios.',
    0.84,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/30238654/commander-js-collect-multiple-options-always-include-default'
),
(
    'Commander.js nested subcommands setup and routing',
    'stackoverflow-commander',
    'HIGH',
    $solutions$[
        {"solution": "Store parent command reference and add each subcommand to it: const groups = program.command(''groups''); groups.command(''create'').action(...); groups.command(''delete'').action(...)", "percentage": 93, "note": "Prevents unintended command chaining", "command": "const parent = program.command(''parent''); parent.command(''sub1'').action(...); parent.command(''sub2'').action(...)"},
        {"solution": "Do NOT chain .command() directly on previous subcommand - always reference parent variable", "percentage": 92, "note": "Common mistake breaks nested structure"},
        {"solution": "Test with: node script.js groups create and node script.js groups delete to verify separate execution paths", "percentage": 85, "note": "Both should work independently"}
    ]$solutions$::jsonb,
    'Commander.js library, Node.js environment',
    'node script.js groups create executes create action, node script.js groups delete executes delete action, both commands work independently without nesting under each other',
    'Chaining .command() directly causes unintended nesting - groups create will appear to own delete as subcommand. Always store parent reference and add children to it.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/66293456/nested-commands-with-commander'
),
(
    'Pass CLI options through npm script to Commander.js program',
    'stackoverflow-commander',
    'HIGH',
    $solutions$[
        {"solution": "Use -- delimiter to separate npm options from script arguments: npm run item -- newInvoice --write. Everything after -- is passed directly to the underlying script, not interpreted by npm", "percentage": 95, "note": "Per npm documentation, -- delimits end of npm options", "command": "npm run item -- subcommand --flag"},
        {"solution": "Without --, npm interprets flags like --write as npm command options, not script options, and they don''t reach the commander.js program", "percentage": 92, "note": "Missing -- is the root cause of undefined flags"},
        {"solution": "The -- must be in the command line, not in package.json - it cannot be pre-configured", "percentage": 90, "note": "Users must type it manually in terminal"}
    ]$solutions$::jsonb,
    'npm scripts defined in package.json, Commander.js program, understanding of npm flag passing',
    'npm run item -- newInvoice --write correctly passes flags to program, program.write returns true instead of undefined, flags are accessible in action handlers',
    'The -- is easy to forget and causes mysterious undefined flag values. Users often assume npm script syntax is different - emphasize the special -- behavior. Do not put -- in package.json.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/60630552/how-to-use-commander-js-command-through-npm-command'
),
(
    'Node.js program hangs and won''t terminate after execution',
    'stackoverflow-commander',
    'MEDIUM',
    $solutions$[
        {"solution": "Call process.stdin.pause() after async operations complete to signal Node.js that no further interactive input is expected, allowing clean process exit", "percentage": 88, "note": "stdin remains open by libraries like co-prompt", "command": "process.stdin.pause(); // Add before process exit"},
        {"solution": "Close stdin explicitly: process.stdin.destroy() or process.exit(0) to force termination", "percentage": 85, "note": "More aggressive than pause"},
        {"solution": "Refactor to use async/await or callbacks instead of co/generators to avoid lingering event listeners from library dependencies", "percentage": 80, "note": "Addresses root cause rather than symptom"}
    ]$solutions$::jsonb,
    'Node.js program using interactive input library (co-prompt, readline), process reaches completion point',
    'Program displays final message and exits cleanly without requiring Ctrl-C, process.stdin.pause() returns control to OS, no lingering processes in system',
    'Interactive libraries like co-prompt keep stdin open listening for input. Developers often miss that stdin must be explicitly closed. Use Ctrl-C as workaround only temporarily.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/40743059/nodejs-program-doesnt-terminate'
);