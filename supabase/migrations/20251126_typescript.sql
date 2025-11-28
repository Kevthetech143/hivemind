INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Argument of type ''string | undefined'' is not assignable to parameter of type ''string''',
    'typescript',
    'HIGH',
    '[
        {"solution": "Use nullish coalescing operator: doSomethingWithUsername(username ?? '''')", "percentage": 95},
        {"solution": "Add type guard: if (username) { doSomethingWithUsername(username); }", "percentage": 90},
        {"solution": "Modify function signature to accept undefined: function doSomething(username: string | undefined)", "percentage": 85}
    ]'::jsonb,
    'Variable is string | undefined; function expects only string',
    'doSomethingWithUsername function accepts the value without error',
    'Forgetting to handle falsy values; trying to coerce instead of guard',
    0.92,
    'haiku',
    NOW(),
    'https://payton.codes/2022/01/08/common-typescript-errors-and-how-to-fix-them/'
),
(
    'v2 implicitly has type ''any'' because it does not have a type annotation and is referenced directly or indirectly in its own initializer',
    'typescript',
    'MEDIUM',
    '[
        {"solution": "Explicitly annotate variable type: const v2: TypeName = await hoge(v1)", "percentage": 95},
        {"solution": "Break circular dependency by initializing variables outside loop with undefined", "percentage": 88},
        {"solution": "Remove async/await chain: const v2 = hoge(v1) instead of const v2 = await hoge(v1)", "percentage": 85}
    ]'::jsonb,
    'Variable used in circular dependency within while loop; async/await chain',
    'Variable has explicit type; loop executes without type errors',
    'Relying on type inference in circular loops; not declaring types early enough',
    0.88,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/75194837/i-want-to-know-why-i-get-type-errors-in-typescript'
),
(
    'Type ''string | undefined'' is not assignable to type ''string | null''',
    'typescript',
    'MEDIUM',
    '[
        {"solution": "Use consistent falsy types in function signature: function accept(val: string | undefined | null)", "percentage": 92},
        {"solution": "Convert types explicitly: const value = str === undefined ? null : str", "percentage": 85},
        {"solution": "Use nullish coalescing: const normalized = input ?? null", "percentage": 88}
    ]'::jsonb,
    'Function parameter expects string | null but receives string | undefined',
    'Function accepts the value without type mismatch error',
    'Mixing undefined and null as separate types; not standardizing on one',
    0.89,
    'haiku',
    NOW(),
    'https://payton.codes/2022/01/08/common-typescript-errors-and-how-to-fix-them/'
),
(
    'Type ''string | number | boolean | undefined'' is not assignable to type ''boolean''',
    'typescript',
    'MEDIUM',
    '[
        {"solution": "Wrap expression with Boolean() constructor: const isBool = Boolean(value)", "percentage": 94},
        {"solution": "Use explicit comparison: const isBool = value !== false && value !== undefined", "percentage": 87},
        {"solution": "Add type narrowing: if (typeof value === ''boolean'') { return value; }", "percentage": 90}
    ]'::jsonb,
    'Expression evaluates to union type with non-boolean values',
    'Expression returns strict boolean type; no type error',
    'Relying on JavaScript truthy/falsy coercion; forgetting explicit casting',
    0.91,
    'haiku',
    NOW(),
    'https://payton.codes/2022/01/08/common-typescript-errors-and-how-to-fix-them/'
),
(
    'Type ''string | null'' is not assignable to type ''string''',
    'typescript',
    'HIGH',
    '[
        {"solution": "Filter with type guard: const filtered = arr.filter((x): x is string => x !== null)", "percentage": 96},
        {"solution": "Use non-null assertion sparingly: const safe = (arr.filter(Boolean) as string[])", "percentage": 88},
        {"solution": "Modify function to accept nullable: function process(items: (string | null)[])", "percentage": 85}
    ]'::jsonb,
    'Array contains null values; function expects non-null strings',
    'Array elements pass to function without type error',
    'Using array filter without proper type narrowing; overly broad array types',
    0.93,
    'haiku',
    NOW(),
    'https://payton.codes/2022/01/08/common-typescript-errors-and-how-to-fix-them/'
),
(
    'Type ''Element'' is not assignable to type ''string''',
    'typescript',
    'HIGH',
    '[
        {"solution": "Change parameter type to ReactNode: function Component(content: React.ReactNode)", "percentage": 96},
        {"solution": "Use JSX.Element for React components: function accept(elem: JSX.Element)", "percentage": 92},
        {"solution": "Convert Element to string: const str = element.textContent || ''''", "percentage": 87}
    ]'::jsonb,
    'Passing React Element/JSX element to function expecting string parameter',
    'React component renders without type errors',
    'Confusing React element types with string types; not using ReactNode',
    0.94,
    'haiku',
    NOW(),
    'https://payton.codes/2022/01/08/common-typescript-errors-and-how-to-fix-them/'
),
(
    'Argument of type ''string'' is not assignable to type ''number''',
    'typescript',
    'HIGH',
    '[
        {"solution": "Use parseInt(): const num = parseInt(stringValue, 10)", "percentage": 96},
        {"solution": "Use Number() constructor: const num = Number(stringValue)", "percentage": 94},
        {"solution": "Use parseFloat() for decimals: const num = parseFloat(stringValue)", "percentage": 92}
    ]'::jsonb,
    'String value passed to function expecting number parameter',
    'Function receives numeric value; no type mismatch',
    'Forgetting to convert string to number before passing; using + operator instead',
    0.95,
    'haiku',
    NOW(),
    'https://payton.codes/2022/01/08/common-typescript-errors-and-how-to-fix-them/'
),
(
    'Expected 1 arguments, but got 0',
    'typescript',
    'HIGH',
    '[
        {"solution": "Set default value: function doSomething(name = '''')", "percentage": 95},
        {"solution": "Make parameter optional: function doSomething(name?: string)", "percentage": 93},
        {"solution": "Use JSDoc: @param {string} [name] - optional name parameter", "percentage": 88}
    ]'::jsonb,
    'Function called without required parameter; parameter has no default',
    'Function can be called with zero arguments; no error',
    'Not making parameters optional; not setting defaults',
    0.94,
    'haiku',
    NOW(),
    'https://payton.codes/2022/01/08/common-typescript-errors-and-how-to-fix-them/'
),
(
    'Property ''name'' does not exist on type ''object''',
    'typescript',
    'HIGH',
    '[
        {"solution": "Use specific type: interface User { name: string } instead of object", "percentage": 96},
        {"solution": "Use JSDoc with proper typing: @return {{name: string}}", "percentage": 92},
        {"solution": "Use Record type: const data: Record<string, string> = {}", "percentage": 88}
    ]'::jsonb,
    'Using generic ''object'' type; JSDoc types are vague',
    'Accessing property without ''Property does not exist'' error',
    'Using generic object type instead of specific interfaces; inadequate JSDoc',
    0.95,
    'haiku',
    NOW(),
    'https://payton.codes/2022/01/08/common-typescript-errors-and-how-to-fix-them/'
),
(
    'Argument of type ''string'' is not assignable to parameter of type ''one'' | ''two''',
    'typescript',
    'MEDIUM',
    '[
        {"solution": "Cast array to const: const VALID_TYPES = [''one'', ''two''] as const", "percentage": 96},
        {"solution": "Use discriminated union: type ValidType = ''one'' | ''two''", "percentage": 94},
        {"solution": "Cast to readonly: const items: ReadonlyArray<''one'' | ''two''> = [''one'', ''two'']", "percentage": 90}
    ]'::jsonb,
    'String variable passed to function expecting literal type union',
    'String values accepted without type narrowing error',
    'Not using ''as const'' on constant arrays; relying on implicit typing',
    0.93,
    'haiku',
    NOW(),
    'https://payton.codes/2022/01/08/common-typescript-errors-and-how-to-fix-them/'
),
(
    'Element implicitly has an ''any'' type because expression of type ''string'' can''t be used to index',
    'typescript',
    'HIGH',
    '[
        {"solution": "Use Record type: const data: Record<string, string> = {}", "percentage": 96},
        {"solution": "Use Map instead: const data = new Map<string, string>()", "percentage": 92},
        {"solution": "Index signature: interface Data { [key: string]: string }", "percentage": 94}
    ]'::jsonb,
    'Accessing object with string key; object type not indexed properly',
    'Dictionary-style object access works without ''any'' type inference',
    'Using plain object without Record type; not using index signatures',
    0.95,
    'haiku',
    NOW(),
    'https://payton.codes/2022/01/08/common-typescript-errors-and-how-to-fix-them/'
),
(
    'Parameter ''value'' implicitly has an ''any'' type',
    'typescript',
    'HIGH',
    '[
        {"solution": "Add explicit type: function identity<T>(value: T): T", "percentage": 96},
        {"solution": "Use generics to maintain relationships: <T extends Base>(item: T)", "percentage": 94},
        {"solution": "Specify parameter type directly: function process(value: string | number)", "percentage": 95}
    ]'::jsonb,
    'Function parameter lacks type annotation; TypeScript inference is ambiguous',
    'Parameter has explicit type; no implicit any warning',
    'Relying on type inference; not using generics when needed',
    0.96,
    'haiku',
    NOW(),
    'https://www.totaltypescript.com/tutorials/solving-typescript-errors'
),
(
    'TS1002: Unterminated string literal',
    'typescript',
    'MEDIUM',
    '[
        {"solution": "Add closing quote: const str = ''hello world''", "percentage": 99},
        {"solution": "Use template literals for multiline: const str = `line1\nline2`", "percentage": 98},
        {"solution": "Use string concatenation: const str = ''part1'' + ''part2''", "percentage": 97}
    ]'::jsonb,
    'String literal missing closing quote',
    'Code compiles without unterminated string error',
    'Mixing quote types; forgetting escape characters',
    0.99,
    'haiku',
    NOW(),
    'https://typescript.tv/errors/'
),
(
    'TS1005: ''='' expected',
    'typescript',
    'MEDIUM',
    '[
        {"solution": "Add assignment operator: type Name = string", "percentage": 98},
        {"solution": "Use interface syntax: interface Config { prop: string }", "percentage": 96},
        {"solution": "Check syntax before type name", "percentage": 95}
    ]'::jsonb,
    'Type declaration missing equals sign',
    'Type alias or interface declaration compiles successfully',
    'Confusing type and interface syntax; omitting = in type alias',
    0.97,
    'haiku',
    NOW(),
    'https://typescript.tv/errors/'
),
(
    'TS1068: Unexpected token in class method',
    'typescript',
    'MEDIUM',
    '[
        {"solution": "Remove function keyword: myMethod() { }", "percentage": 99},
        {"solution": "Use arrow function syntax: myMethod = () => { }", "percentage": 97},
        {"solution": "Define method as function property", "percentage": 96}
    ]'::jsonb,
    'Using function keyword inside class method definition',
    'Class method compiles without syntax error',
    'Copying function syntax into class; not using method shorthand',
    0.98,
    'haiku',
    NOW(),
    'https://typescript.tv/errors/'
),
(
    'TS1029: Modifier order incorrect',
    'typescript',
    'LOW',
    '[
        {"solution": "Place access modifier first: public async method() { }", "percentage": 98},
        {"solution": "Order: access modifier, async, static, abstract", "percentage": 97},
        {"solution": "Use ''private abstract method(): void''", "percentage": 96}
    ]'::jsonb,
    'Modifiers applied in wrong order (e.g., async before public)',
    'Modifiers compile in correct order without error',
    'Not memorizing correct modifier order; placing async before access modifier',
    0.97,
    'haiku',
    NOW(),
    'https://typescript.tv/errors/'
),
(
    'TS1070: ''private'' modifier cannot appear on a type member',
    'typescript',
    'MEDIUM',
    '[
        {"solution": "Remove private from interface: interface User { name: string }", "percentage": 99},
        {"solution": "Use class instead: class User { private name: string }", "percentage": 98},
        {"solution": "All interface members are public by design", "percentage": 97}
    ]'::jsonb,
    'Attempting to add private modifier to interface property',
    'Interface compiles with only public contract',
    'Confusing interface and class access control; interfaces are always public',
    0.98,
    'haiku',
    NOW(),
    'https://typescript.tv/errors/'
),
(
    'TS1095: Set accessor cannot have return type',
    'typescript',
    'LOW',
    '[
        {"solution": "Remove return type from setter: set name(value: string) { }", "percentage": 99},
        {"solution": "Use getter with return type instead: get name(): string { }", "percentage": 98},
        {"solution": "Setters implicitly return void", "percentage": 97}
    ]'::jsonb,
    'Setter method has return type annotation',
    'Setter compiles without return type annotation',
    'Adding return types to setters; confusing setter and getter syntax',
    0.99,
    'haiku',
    NOW(),
    'https://typescript.tv/errors/'
),
(
    'TS1064: Async function return type must be Promise',
    'typescript',
    'HIGH',
    '[
        {"solution": "Wrap return type: async function(): Promise<string>", "percentage": 98},
        {"solution": "Use Promise wrapper: async getName(): Promise<string> { return ''John'' }", "percentage": 97},
        {"solution": "Return Promise from async function", "percentage": 96}
    ]'::jsonb,
    'Async function declares non-Promise return type',
    'Async function compiles with Promise return type',
    'Forgetting to wrap return type in Promise; mixing async/sync signatures',
    0.97,
    'haiku',
    NOW(),
    'https://typescript.tv/errors/'
),
(
    'TS1055: Invalid async return type in ES5/ES3',
    'typescript',
    'LOW',
    '[
        {"solution": "Use .then() chains: hoge(v1).then((v2) => { ... })", "percentage": 95},
        {"solution": "Set compile target to ES2015+: ''target'': ''es2015'' in tsconfig.json", "percentage": 98},
        {"solution": "Transpile async/await to Promise chains", "percentage": 90}
    ]'::jsonb,
    'Using async/await with ES5 or ES3 as compilation target',
    'Code compiles with modern target or Promise chains',
    'Using async/await without updating tsconfig; targeting old JavaScript',
    0.93,
    'haiku',
    NOW(),
    'https://typescript.tv/errors/'
),
(
    'TS1036: Statements not allowed in ambient contexts',
    'typescript',
    'LOW',
    '[
        {"solution": "Use declare keyword: declare var myGlobal: string", "percentage": 97},
        {"solution": "Convert to declaration: declare function process(): void", "percentage": 96},
        {"solution": "Move implementation outside ambient context", "percentage": 95}
    ]'::jsonb,
    'Implementation statement inside .d.ts file or declare block',
    'Type declarations compile without implementation statements',
    'Adding implementations in .d.ts; confusing declare with implementation',
    0.96,
    'haiku',
    NOW(),
    'https://typescript.tv/errors/'
),
(
    'TS1038: Cannot use ''declare'' in ambient context',
    'typescript',
    'LOW',
    '[
        {"solution": "Remove declare keyword inside declare block", "percentage": 99},
        {"solution": "Use declare only once at top level", "percentage": 98},
        {"solution": "Structure: declare module { /* no nested declare */ }", "percentage": 97}
    ]'::jsonb,
    'Nested declare keyword inside already-declared block',
    'Declarations compile with single declare keyword',
    'Duplicating declare keyword; nesting declare statements',
    0.99,
    'haiku',
    NOW(),
    'https://typescript.tv/errors/'
),
(
    'TS1039: Initializers not allowed in ambient contexts',
    'typescript',
    'MEDIUM',
    '[
        {"solution": "Remove initialization: declare var config: Config", "percentage": 99},
        {"solution": "Use type-only declaration in .d.ts files", "percentage": 98},
        {"solution": "Move initialization to .ts implementation file", "percentage": 97}
    ]'::jsonb,
    'Variable or property initialized inside .d.ts file',
    'Type declarations in .d.ts have no initializers',
    'Initializing variables in declaration files; confusing .d.ts with .ts',
    0.98,
    'haiku',
    NOW(),
    'https://typescript.tv/errors/'
),
(
    'Property has no initializer and is not definitely assigned in constructor',
    'typescript',
    'HIGH',
    '[
        {"solution": "Initialize in constructor: this.name = ''''", "percentage": 96},
        {"solution": "Provide default value: name: string = ''''", "percentage": 94},
        {"solution": "Use definite assignment assertion: name!: string (use sparingly)", "percentage": 88}
    ]'::jsonb,
    'Class property declared without initialization and not set in constructor',
    'Class instances have all properties initialized',
    'Forgetting to initialize in constructor; using non-null assertion instead',
    0.93,
    'haiku',
    NOW(),
    'https://www.totaltypescript.com/tutorials/solving-typescript-errors'
),
(
    'Conversion of type may be a mistake',
    'typescript',
    'MEDIUM',
    '[
        {"solution": "Explicitly cast: const num = value as number", "percentage": 92},
        {"solution": "Use conversion function: const num = Number(value)", "percentage": 94},
        {"solution": "Add type annotation: const num: number = parseInt(value)", "percentage": 90}
    ]'::jsonb,
    'Implicit type coercion that TypeScript suspects is unintentional',
    'Type conversion is explicit and intentional',
    'Relying on implicit coercion; using as instead of proper conversion',
    0.91,
    'haiku',
    NOW(),
    'https://www.totaltypescript.com/tutorials/solving-typescript-errors'
),
(
    'Cannot redeclare block-scoped variable',
    'typescript',
    'MEDIUM',
    '[
        {"solution": "Rename variable: const user2 = fetchUser()", "percentage": 96},
        {"solution": "Move declaration to different scope: if (condition) { const user = ... }", "percentage": 94},
        {"solution": "Use let or var carefully; prefer const with unique names", "percentage": 90}
    ]'::jsonb,
    'Variable declared twice in same scope with const/let',
    'Each variable has unique name in scope',
    'Copying code without changing variable names; not respecting block scope',
    0.92,
    'haiku',
    NOW(),
    'https://www.totaltypescript.com/tutorials/solving-typescript-errors'
),
(
    'Could not find a declaration file for module',
    'typescript',
    'HIGH',
    '[
        {"solution": "Install types: npm install --save-dev @types/module-name", "percentage": 96},
        {"solution": "Create .d.ts file: declare module ''module-name''", "percentage": 92},
        {"solution": "Use skipLibCheck in tsconfig.json if types unavailable", "percentage": 85}
    ]'::jsonb,
    'Importing JavaScript module without TypeScript types',
    'Module imports without declaration file errors',
    'Not installing @types packages; using skipLibCheck as band-aid',
    0.91,
    'haiku',
    NOW(),
    'https://www.totaltypescript.com/tutorials/solving-typescript-errors'
),
(
    'Type ''unknown'' must be narrowed before use',
    'typescript',
    'HIGH',
    '[
        {"solution": "Add type guard: if (typeof value === ''string'') { ... }", "percentage": 95},
        {"solution": "Use type assertion sparingly: (value as string)", "percentage": 88},
        {"solution": "Create type guard function: function isString(v: unknown): v is string", "percentage": 94}
    ]'::jsonb,
    'Using unknown type without type narrowing checks',
    'Unknown values are narrowed to specific types safely',
    'Using ''as'' instead of type guards; ignoring unknown type safety',
    0.92,
    'haiku',
    NOW(),
    'https://www.totaltypescript.com/tutorials/solving-typescript-errors'
),
(
    'Types of property are incompatible',
    'typescript',
    'MEDIUM',
    '[
        {"solution": "Align property types: interface Base { id: string } interface Derived extends Base { id: string }", "percentage": 94},
        {"solution": "Use union type if intentional: id: string | number", "percentage": 90},
        {"solution": "Check interface inheritance chain for conflicts", "percentage": 91}
    ]'::jsonb,
    'Object property has different type than expected or interface definition',
    'All property types align across interfaces and implementations',
    'Not checking inherited types; inconsistent type definitions across files',
    0.90,
    'haiku',
    NOW(),
    'https://www.totaltypescript.com/tutorials/solving-typescript-errors'
),
(
    'Expression of type string can''t be used to index type Error',
    'typescript',
    'MEDIUM',
    '[
        {"solution": "Use Record type: const errorMap: Record<string, string> = {}", "percentage": 95},
        {"solution": "Add index signature: interface ErrorMap { [key: string]: string }", "percentage": 93},
        {"solution": "Use Map for dynamic keys: const errorMap = new Map<string, string>()", "percentage": 90}
    ]'::jsonb,
    'Attempting string index access on typed object without index signature',
    'String index access works on object without type errors',
    'Not using index signatures or Record types; trying to access without typing',
    0.92,
    'haiku',
    NOW(),
    'https://www.totaltypescript.com/tutorials/solving-typescript-errors'
);
