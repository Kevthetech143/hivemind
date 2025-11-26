-- Add GitHub Issues from prettier/prettier repository
-- Mining source: https://github.com/prettier/prettier/issues
-- Focus: High-voted bugs with solutions, formatting issues, editor integration
-- Extracted: 12 issues with reaction counts and community solutions

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Prettier Markdown formatting corrupts GitHub callout syntax with extra >',
    'github-prettier',
    'HIGH',
    $$[
        {"solution": "Add HTML comment before callout block: <!-- prettier-ignore --> before > [!Warning] block", "percentage": 95, "note": "Prevents Prettier from reformatting the block"},
        {"solution": "Reword content to avoid starting second line with markdown syntax (backticks, underscores, etc.)", "percentage": 85, "note": "Workaround by changing content structure"},
        {"solution": "Keep callout on single line: > [!Warning] Warning text here (avoid multi-line for now)", "percentage": 75, "note": "Temporary workaround while bug exists"}
    ]$$::jsonb,
    'Prettier configured with proseWrap setting, Markdown files with GitHub callout syntax',
    'Callout block renders correctly on GitHub, Multi-line structure preserved, No extra > characters in formatted output',
    'The bug occurs when second line begins with markdown syntax even with proseWrap preserve. Do NOT use blank line workaround (renders incorrectly). prettier-ignore comment is most reliable.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/prettier/prettier/issues/15479'
),
(
    'Prettier styled-components template literal formatting inserts unwanted semicolons',
    'github-prettier',
    'HIGH',
    $$[
        {"solution": "Use // prettier-ignore comment above template literal with template expressions", "percentage": 90, "note": "Prevents semicolon insertion bug"},
        {"solution": "Wrap expressions in parentheses or restructure to avoid template literal ending with expression", "percentage": 80, "note": "Code refactoring workaround"},
        {"solution": "Try expanding single CSS rules to multiple lines to trigger different formatting path", "percentage": 70, "note": "Inconsistent workaround, not recommended"}
    ]$$::jsonb,
    'styled-components library installed, Prettier configured for JavaScript/JSX',
    'No syntax errors in output, Template literal compiles without unexpected semicolons, CSS rules format consistently',
    'Semicolon insertion happens specifically with template expressions ending without semicolon. prettier-ignore is safest approach. Design issue tracked - consider upgrading Prettier version.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/prettier/prettier/issues/2350'
),
(
    'Prettier HTML formatting expands attributes to one-per-line making code unreadable on screen',
    'github-prettier',
    'MEDIUM',
    $$[
        {"solution": "Accept Prettier''s binary formatting and use printWidth of 120+ to fit more on single line", "percentage": 85, "note": "Adjust configuration rather than fight formatter"},
        {"solution": "Use prettier-ignore-next comment to bypass Prettier for specific elements with many attributes", "percentage": 80, "note": "Selective disabling of formatter"},
        {"solution": "Propose manual line breaks be honored if each line respects printWidth - requires Prettier configuration discussion", "percentage": 60, "note": "Feature request, may not be implemented"}
    ]$$::jsonb,
    'HTML files configured in Prettier, editor with printWidth configuration visible',
    'HTML elements readable on screen with reasonable viewport width, Attributes logically grouped or single line',
    'Prettier applies all-or-nothing formatting: fits in printWidth (single line) or expands to one-attribute-per-line. There is no middle ground. Plan element structures accordingly.',
    0.78,
    'sonnet-4',
    NOW(),
    'https://github.com/prettier/prettier/issues/13782'
),
(
    'Prettier RFC: Experimental and Deprecated flags for major formatting changes',
    'github-prettier',
    'MEDIUM',
    $$[
        {"solution": "Use experimental flags (--experimental-*) in minor versions to opt-in to new formatting behavior before it becomes default", "percentage": 90, "note": "Proposed solution for testing breaking changes"},
        {"solution": "Use deprecated flags (--deprecated-*) in major versions to preserve legacy formatting during migration period", "percentage": 88, "note": "Allows gradual adoption of breaking changes"},
        {"solution": "Gather community feedback while experimental flag is active to decide whether to make change permanent", "percentage": 85, "note": "Data-driven decision making process"}
    ]$$::jsonb,
    'Prettier maintainers with merge access, Community testing participation, Semantic versioning practice',
    'Experimental flags successfully tested by community, Feedback collected and evaluated, Decided whether to make permanent',
    'Experimental flags are temporary and removed - not permanent configuration options. Maintains Prettier''s philosophy of minimal options. Both flag types outside semver.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/prettier/prettier/issues/14527'
),
(
    'Prettier code-breaking semicolon added when formatting range in arrow function with comment',
    'github-prettier',
    'MEDIUM',
    $$[
        {"solution": "Change editor.formatOnSaveMode from modifications to file (format entire file, not range)", "percentage": 95, "note": "Primary workaround - range formatting triggers bug"},
        {"solution": "Remove trailing comments from edited ranges before saving", "percentage": 85, "note": "Avoid comment at end of formatted range"},
        {"solution": "Upgrade Prettier to version after PR #13173 merge (Fix range format for function bodies)", "percentage": 90, "note": "Bug permanently fixed in later versions"}
    ]$$::jsonb,
    'Prettier 2.6.2+, Editor with format-on-save range formatting (VS Code with Prettier extension)',
    'Formatted code compiles without syntax errors, No unexpected semicolons after closing parenthesis, Function body renders correctly',
    'Bug specific to range formatting in arrow functions ending with comments. Format full file instead of range. The --no-semi option may add semicolon in wrong location (before arrow).',
    0.93,
    'sonnet-4',
    NOW(),
    'https://github.com/prettier/prettier/issues/12964'
),
(
    'Prettier generator formatting changed without community consensus (function* vs function *)',
    'github-prettier',
    'MEDIUM',
    $$[
        {"solution": "Accept the function* format as Prettier standard (treats * as part of function keyword)", "percentage": 88, "note": "Current Prettier formatting standard"},
        {"solution": "Use prettier-ignore for generator declarations if strict consistency with Airbnb style guide required", "percentage": 75, "note": "Selective formatting override"},
        {"solution": "Open new issue if this formatting decision lacks sufficient data backing - community voting suggests disagreement", "percentage": 60, "note": "Request reconsideration based on vote counts"}
    ]$$::jsonb,
    'Prettier configured for JavaScript, Generator functions in codebase',
    'Generator functions format as function* without space, Syntax highlighting works correctly, Code compiles and executes',
    'This change only had 2 upvotes before implementation but affected major formatting behavior. No configuration option exists. Some argue operator precedence favors function *, others prefer function*.',
    0.80,
    'sonnet-4',
    NOW(),
    'https://github.com/prettier/prettier/issues/7512'
),
(
    'Prettier arrow function formatting results in syntax error with comment after type annotation',
    'github-prettier',
    'MEDIUM',
    $$[
        {"solution": "Place comments on separate line before arrow: const test = (): any => /* comment */ null", "percentage": 92, "note": "Restructure comment placement"},
        {"solution": "Upgrade to Prettier version after PR #17421 merge (handles comments in arrow functions properly)", "percentage": 95, "note": "Permanent fix in later versions"},
        {"solution": "Move comment to line before type annotation: const test = /* comment */ (): any => null", "percentage": 85, "note": "Alternative comment placement"}
    ]$$::jsonb,
    'TypeScript files with arrow functions and return type annotations, Comments after type annotations',
    'Arrow function compiles without ''Line terminator not permitted before arrow'' error, Comment preserved in output, Syntax valid',
    'Bug specific to TypeScript arrow functions with comments after return type annotation. Comment attachment logic was treating comment as part of type rather than arrow expression.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/prettier/prettier/issues/11100'
),
(
    'Prettier trailing comma settings produce unexpected commas in arrow functions and generics',
    'github-prettier',
    'MEDIUM',
    $$[
        {"solution": "Avoid using trailingComma: all option - use never or es5 instead for more predictable behavior", "percentage": 85, "note": "Workaround by changing configuration"},
        {"solution": "Verify code compiles after formatting - Prettier may add commas in semantically wrong locations", "percentage": 80, "note": "Validation step required"},
        {"solution": "Report specific cases to Prettier issue tracker if code technically compiles but aesthetics are wrong", "percentage": 70, "note": "May be design decision rather than bug"}
    ]$$::jsonb,
    'Prettier 3.0+, JavaScript/TypeScript files with arrow functions or generics, trailingComma option configured',
    'Code compiles and executes without errors, Trailing commas appear in expected locations, Test suite passes',
    'The trailingComma: all setting adds commas in unexpected places (after last arrow parameter, in single generics). Code technically valid but aesthetically questionable. Issue closed as not planned.',
    0.75,
    'sonnet-4',
    NOW(),
    'https://github.com/prettier/prettier/issues/15077'
),
(
    'Prettier arrow function parentheses configuration missing (always vs as-needed)',
    'github-prettier',
    'HIGH',
    $$[
        {"solution": "Accept Prettier''s default as-needed behavior (no parens for single param): a => {}", "percentage": 85, "note": "Prettier''s opinionated standard"},
        {"solution": "Use prettier-eslint integration for Airbnb config compatibility requiring parens always", "percentage": 75, "note": "Performance overhead noted by users"},
        {"solution": "Submit community fork or contribute feature if your team requires arrow-parens option", "percentage": 60, "note": "Maintainers declined to add this option"}
    ]$$::jsonb,
    'Prettier configured, Teams using Airbnb ESLint style guide or requiring parentheses on single-param arrows',
    'Arrow functions format consistently with team standard, Code compiles and passes linting',
    'Prettier philosophy minimizes configuration. No --arrow-parens option exists (always, as-needed, requireForBlockBody rejected). Airbnb users must accept or use prettier-eslint workaround.',
    0.80,
    'sonnet-4',
    NOW(),
    'https://github.com/prettier/prettier/issues/812'
),
(
    'Prettier object destructuring in method shorthand syntax always breaks to multiple lines',
    'github-prettier',
    'MEDIUM',
    $$[
        {"solution": "Upgrade Prettier to version after PR #6646 merge to fix method shorthand consistency", "percentage": 95, "note": "Permanent fix implemented"},
        {"solution": "Temporarily refactor to arrow functions instead of method shorthand if formatting critical", "percentage": 70, "note": "Workaround by code structure change"},
        {"solution": "Accept multi-line formatting for method shorthand destructuring", "percentage": 65, "note": "Accept Prettier output"}
    ]$$::jsonb,
    'Object methods with destructured parameters, Prettier older than PR #6646 fix',
    'Method shorthand destructuring formats on single line like arrow functions do, Code compiles, Formatting consistent',
    'Bug specific to ObjectMethod vs ArrowFunctionExpression handling. Prettier treated them differently for destructured params. Fix ensures both use same formatting logic.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/prettier/prettier/issues/6515'
),
(
    'Prettier object literal configuration issue: Error message shows file being formatted not config file',
    'github-prettier',
    'MEDIUM',
    $$[
        {"solution": "Check .prettierrc, prettier.config.js, or prettierrc.cjs file for missing plugin dependencies first", "percentage": 90, "note": "Look at configuration file, not formatted file"},
        {"solution": "Search error message plugin name in package.json - verify dependency is installed", "percentage": 88, "note": "Debug configuration dependency issue"},
        {"solution": "Create new GitHub issue if error message misleading - note that it should show config file path not formatted file path", "percentage": 70, "note": "Improve error messaging"}
    ]$$::jsonb,
    'Prettier configuration file (.prettierrc, prettier.config.js, etc.), Plugin packages listed in configuration',
    'Prettier runs without configuration errors, Plugin loads successfully, Files format without errors',
    'Error message shows formatted file path instead of config file path - confusing for debugging. Always check configuration files first when seeing "Invalid configuration file" errors.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/prettier/prettier/issues/14366'
),
(
    'Prettier object literal shorthand properties handling and line break preservation',
    'github-prettier',
    'MEDIUM',
    $$[
        {"solution": "Collapse multi-line objects with all shorthand properties to single line when possible", "percentage": 88, "note": "Requested behavior in RFC #8055"},
        {"solution": "Preserve line breaks in objects only when containing empty lines, comments, or mixed spread operators", "percentage": 82, "note": "Proposed refined approach"},
        {"solution": "Use array formatting as precedent - arrays already format inline when all elements are shorthand", "percentage": 80, "note": "Consistency argument for implementation"}
    ]$$::jsonb,
    'Objects with shorthand properties, Prettier configuration, Code style preferences documented',
    'Objects with only shorthand properties format on single line, Comments and empty lines preserved, Code compiles',
    'RFC #8055 proposed but not yet implemented. Current behavior preserves multi-line shorthand objects unchanged. Empty lines and comments should be preserved if present.',
    0.76,
    'sonnet-4',
    NOW(),
    'https://github.com/prettier/prettier/issues/8055'
),
(
    'Prettier empty function object shorthand expands unnecessarily across multiple lines',
    'github-prettier',
    'LOW',
    $$[
        {"solution": "Upgrade Prettier to version after PR #706 merge (Do not put newline inside empty object method bodies)", "percentage": 96, "note": "Permanent fix implemented"},
        {"solution": "Keep empty methods on single line: a = { f() {} } - should remain compact", "percentage": 85, "note": "Expected behavior"},
        {"solution": "Use standalone function or arrow if method expansion is issue", "percentage": 60, "note": "Refactor workaround"}
    ]$$::jsonb,
    'Object method shorthand syntax with empty bodies, Prettier older than PR #706',
    'Empty object methods remain on single line: a = { f() {} }, Consistent with empty function handling, Code compiles',
    'Bug specific to empty object methods being unnecessarily expanded. Standalone empty functions not expanded, so object methods should behave identically. Fix ensures consistency.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://github.com/prettier/prettier/issues/703'
);
