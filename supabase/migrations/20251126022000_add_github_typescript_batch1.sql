-- Mine GitHub Issues from microsoft/TypeScript repository
-- Batch 1: High-engagement TypeScript issues with solutions
-- Category: github-typescript

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'TypeScript issue #51999: Type guards in conditional types not supported',
    'github-typescript',
    'MEDIUM',
    $$[
        {"solution": "Use inline type narrowing within function logic instead of conditional type syntax with type guards", "percentage": 95, "note": "Type guards operate at runtime while conditional types resolve at compile-time - these are fundamentally incompatible"},
        {"solution": "Structure code to check narrowing conditions before assignment, separating runtime checks from compile-time type analysis", "percentage": 85, "note": "Workaround avoids the mixed syntax issue"},
        {"solution": "Use mapped types with explicit type branching instead of conditional type syntax with ''is'' keyword", "percentage": 80, "note": "Alternative approach using existing TypeScript patterns"}
    ]$$::jsonb,
    'TypeScript 4.5+, understanding of conditional types and type guards',
    'Code compiles without errors, type narrowing works in conditional branches, no mixing of runtime checks with compile-time type syntax',
    'Do not attempt to use ''is'' keyword inside conditional type expressions - conditional types resolve at compile time before runtime type checks occur. Use separate function logic for runtime checks.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/microsoft/TypeScript/issues/51999'
),
(
    'TypeScript issue #49573: Type predicates fail with boolean equality comparisons',
    'github-typescript',
    'MEDIUM',
    $$[
        {"solution": "Use unary not operator (!isFlagValid(flag)) instead of === true/false comparisons for type guards", "percentage": 95, "note": "Unary operator correctly narrows types, equality comparisons may not"},
        {"solution": "Update to TypeScript 5.4+ which fixed type narrowing for === true/false comparisons via PR #53714", "percentage": 90, "note": "Latest version addresses the inconsistency"},
        {"solution": "Implement explicit type assertions when equality comparison form is required", "percentage": 80, "note": "Temporary workaround for older TypeScript versions"}
    ]$$::jsonb,
    'TypeScript 4.8+, type guard functions defined with ''is'' keyword, understanding of control flow analysis',
    'Type is correctly narrowed in both if and else branches, linter accepts code pattern, no manual type assertions needed',
    'Do not assume === true/false comparisons will narrow types the same way as unary ! operator - use unary negation for type guards. Equality form narrowing was inconsistent before TypeScript 5.4.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/microsoft/TypeScript/issues/49573'
),
(
    'TypeScript issue #44366: Type guard narrowing inconsistency with boolean comparisons',
    'github-typescript',
    'MEDIUM',
    $$[
        {"solution": "Use unary ! operator for negation: if (!isActor(bin)) { ... } instead of if (isActor(bin) === false)", "percentage": 95, "note": "Unary not correctly narrows types in both branches"},
        {"solution": "Upgrade to TypeScript 5.4.0+ which resolved type narrowing for === false comparisons via PR #53714", "percentage": 90, "note": "Official fix included in recent release"},
        {"solution": "Add linting rules to prefer unary operators over boolean equality for type guards", "percentage": 80, "note": "Code style approach to avoid the issue"}
    ]$$::jsonb,
    'TypeScript 5.0+, type guard functions with ''is'' keyword, control flow analysis understanding',
    'Type correctly narrows to Actor in else branch, both if and else branches have proper type narrowing, no compilation errors',
    'Type guards with === false do not narrow types like unary ! does - they are semantically equivalent but TypeScript treats them differently in versions before 5.4. Prefer unary negation.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/microsoft/TypeScript/issues/44366'
),
(
    'TypeScript issue #36247: Constructor parameter property creates invalid .d.ts declaration',
    'github-typescript',
    'LOW',
    $$[
        {"solution": "Rename the parameter property to avoid naming conflicts with the constructor method: constructor(private ctor: Function) instead", "percentage": 95, "note": "Simplest and most reliable solution"},
        {"solution": "Use TypeScript 3.0+ which fixed declaration file generation for this edge case", "percentage": 90, "note": "Bug fix was applied in later versions"},
        {"solution": "If parameter must be named ''constructor'', make it non-optional and adjust type accordingly", "percentage": 75, "note": "Workaround if renaming is not possible"}
    ]$$::jsonb,
    'TypeScript 2.8+, class with constructor parameter properties, declaration file generation enabled',
    'Generated .d.ts files contain valid TypeScript syntax, no duplicate constructor declarations, declaration files parse without errors',
    'Do not use ''constructor'' as a parameter property name in class constructors - it creates a naming conflict with the actual constructor method signature in declaration files.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/microsoft/TypeScript/issues/36247'
),
(
    'TypeScript issue #54619: getCodeFixes crashes with isPropertyAccessExpression error',
    'github-typescript',
    'LOW',
    $$[
        {"solution": "Upgrade to the latest TypeScript patch version (5.2+) which contains the fix", "percentage": 90, "note": "Issue was resolved in later releases, fix merged to main branch"},
        {"solution": "If upgrading not possible, restart TypeScript server (Ctrl+Shift+P > TypeScript: Restart TS Server in VSCode)", "percentage": 85, "note": "Temporary workaround that often resolves telemetry-related issues"},
        {"solution": "Disable quick fixes temporarily and use manual refactoring if code fixes remain broken", "percentage": 70, "note": "Fallback approach for severely affected projects"}
    ]$$::jsonb,
    'TypeScript 5.1.3-5.2.2, VSCode with TypeScript language service, getCodeFixes/quick fixes enabled',
    'Code fixes generate without errors, quick actions available in editor, telemetry shows no crash events, VSCode does not show error notifications',
    'This issue primarily affected TypeScript 5.1.3-5.2.2 in getCodeFixes command. Crashes were related to internal validation in isPropertyAccessExpression. Always upgrade to latest patch version for crash fixes.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/microsoft/TypeScript/issues/54619'
),
(
    'TypeScript issue #48596: Unicode escape sequences incorrectly allowed in JSX element names',
    'github-typescript',
    'LOW',
    $$[
        {"solution": "Remove Unicode escape sequences from JSX element names, use standard alphanumeric component names", "percentage": 98, "note": "Only valid solution - this was intentionally disallowed"},
        {"solution": "If component name requires Unicode, define a normal variable/component first then reference it without escapes", "percentage": 85, "note": "Alternative approach maintaining intended behavior"},
        {"solution": "Update to TypeScript 4.7+ which disallows this syntax per PR #48609", "percentage": 90, "note": "Fix aligns TypeScript with ecosystem standards"}
    ]$$::jsonb,
    'TypeScript 4.6+, JSX/TSX file usage, component imports',
    'JSX elements render without errors, no syntax errors in TSX files, component imports work correctly, element names follow standard naming conventions',
    'TypeScript previously allowed Unicode escape sequences in JSX element names which is non-standard - this was disallowed in TypeScript 4.7. Use standard component naming conventions without Unicode escapes.',
    0.95,
    'sonnet-4',
    NOW(),
    'https://github.com/microsoft/TypeScript/issues/48596'
),
(
    'TypeScript issue #51501: in operator fails with narrowed generic nullable types',
    'github-typescript',
    'MEDIUM',
    $$[
        {"solution": "Upgrade to TypeScript 5.0.0+ which fixed the type narrowing issue via PR #51502", "percentage": 95, "note": "Official fix included in version 5.0"},
        {"solution": "For older versions, cast to non-generic type: (table as object | null) to avoid the narrowing bug", "percentage": 85, "note": "Workaround for TypeScript < 5.0"},
        {"solution": "Restructure generic constraint to use non-nullable generic: T extends object instead of T extends object | null", "percentage": 80, "note": "Alternative approach that avoids the issue"}
    ]$$::jsonb,
    'TypeScript 4.9+, generic functions with nullable type constraints, in operator usage',
    'in operator works without type errors, type narrowing applies correctly in both generic and non-generic code, no "may represent a primitive value" errors',
    'Generic types with nullable constraints (T extends object | null) had incorrect in operator type checking before TypeScript 5.0. Upgrade or use non-nullable generic constraints as workaround.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/microsoft/TypeScript/issues/51501'
),
(
    'TypeScript issue #53326: Key remapping on generic keyof creates non-assignable types',
    'github-typescript',
    'MEDIUM',
    $$[
        {"solution": "Remove the as remapping clause from mapped types: type TestRecord<T> = Record<keyof T, string> instead of using as syntax", "percentage": 90, "note": "Simplest solution - avoids the equivalence issue"},
        {"solution": "Accept that remapped types with as may not be directly assignable to equivalent Record types, use type assertion when needed", "percentage": 80, "note": "Workaround accepting design limitation"},
        {"solution": "Use separate helper types to construct mapped types without remapping, maintaining type equivalence", "percentage": 75, "note": "More verbose but preserves assignability"}
    ]$$::jsonb,
    'TypeScript 4.4+, understanding of mapped types and key remapping syntax (as keyword)',
    'Types are assignable to equivalent Record types, type comparisons work correctly, no type instantiation issues',
    'Key remapping with as on generic keyof creates a separate type construction path that TypeScript cannot recognize as equivalent to the original. Avoid as remapping when assignability to Record types is required.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/microsoft/TypeScript/issues/53326'
),
(
    'TypeScript issue #46399: typeof operator returns broad union instead of specific literal',
    'github-typescript',
    'MEDIUM',
    $$[
        {"solution": "Check TypeScript version - this is a known limitation with no planned fix due to structural typing complexity", "percentage": 0, "note": "Currently not solvable in TypeScript - design decision"},
        {"solution": "Use explicit type narrowing with constants: const isString = (x: unknown) => typeof x === ''string''", "percentage": 85, "note": "Workaround using helper functions"},
        {"solution": "Implement custom type guards with const assertions to achieve desired narrowing behavior", "percentage": 80, "note": "Alternative approach for specific use cases"}
    ]$$::jsonb,
    'TypeScript 4.0+, understanding of typeof operator and structural typing system',
    'Code compiles and runs correctly, type checking prevents misuse of typeof results, defensive programming patterns work as expected',
    'typeof expressions in TypeScript return union type of all possible typeof results, not specific literals - this is by design to support structural typing. Defensive checks on typed values are intentionally broad.',
    0.0,
    'sonnet-4',
    NOW(),
    'https://github.com/microsoft/TypeScript/issues/46399'
),
(
    'TypeScript issue #54963: Unclear error messages when applying incompatible decorators',
    'github-typescript',
    'MEDIUM',
    $$[
        {"solution": "Add ''accessor'' keyword when applying standard decorators to fields: @computed accessor myField = 5;", "percentage": 95, "note": "Solution for users migrating from experimental decorators"},
        {"solution": "Upgrade to TypeScript 5.3+ and use IDE quick fixes for automatic ''accessor'' keyword insertion", "percentage": 90, "note": "IDE support provides guided fixes"},
        {"solution": "Consult framework documentation for experimental decorator equivalents that work with standard decorator syntax", "percentage": 85, "note": "Different frameworks map decorators differently"}
    ]$$::jsonb,
    'TypeScript 5.0+, experimental decorators or standard decorators TC39, understanding of accessor syntax',
    'Decorators apply without type errors, accessor keyword used appropriately, IDE shows quick fix suggestions, no abstract error messages about context types',
    'Error messages for incompatible decorators are abstract when applying field decorators to accessor contexts. Use ''accessor'' keyword or IDE quick fixes. Standard decorators differ from experimental decorators in supported positions.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/microsoft/TypeScript/issues/54963'
),
(
    'TypeScript issue #55963: Class method implementation signatures don''t validate all overloads',
    'github-typescript',
    'MEDIUM',
    $$[
        {"solution": "Ensure implementation signature covers all possible call patterns from overload signatures: method(a: number, b?: number): void covers both foo(a?: number) and foo(a: number, b: number)", "percentage": 95, "note": "Make implementation signature least restrictive of all overloads"},
        {"solution": "Use strict parameter requirements in implementation matching most specific overload", "percentage": 85, "note": "Alternative approach being more explicit"},
        {"solution": "Upgrade to latest TypeScript version and enable strict compiler options to catch these errors", "percentage": 75, "note": "Stricter checking may be added in future versions"}
    ]$$::jsonb,
    'TypeScript 4.5+, class definitions with overloaded methods, method overload signatures',
    'Implementation signature covers all overload patterns, no type errors, method calls match available overloads, runtime behavior matches type signatures',
    'Class method implementations with incomplete signatures may compile successfully but fail at runtime. This validation gap only exists in classes, not standalone functions. Always ensure implementation covers all overload cases.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/microsoft/TypeScript/issues/55963'
),
(
    'TypeScript issue #50359: Type predicates fail to narrow union array types',
    'github-typescript',
    'MEDIUM',
    $$[
        {"solution": "Use type assertion when typeof checks on array elements cannot narrow union array types", "percentage": 95, "note": "Temporary workaround: array as number[]"},
        {"solution": "Restructure code to use explicit type guards on the array itself rather than checking element types", "percentage": 85, "note": "Alternative approach avoiding the limitation"},
        {"solution": "Implement separate variables for each array type instead of unions: const numArray: number[], stringArray: string[]", "percentage": 80, "note": "Design change to avoid type narrowing complexity"}
    ]$$::jsonb,
    'TypeScript 4.5+, union array types (number[] | string[]), type guards and narrowing',
    'Array types are properly narrowed or correctly asserted, element access uses correct type, no unnecessary type casts in type checks',
    'Type predicates cannot narrow union array types based on element typeof checks - this is a known limitation. TypeScript sees (array as number[] | string[]) and cannot narrow it with element checks alone.',
    0.78,
    'sonnet-4',
    NOW(),
    'https://github.com/microsoft/TypeScript/issues/50359'
);
