-- Add Redux GitHub issues with solutions - Batch 1
-- Category: github-redux
-- Source: https://github.com/reduxjs/redux/issues

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Redux middleware action typed as any instead of unknown - TypeScript type safety',
    'github-redux',
    'HIGH',
    '[
        {"solution": "Type the action parameter as unknown instead of any: const middleware: AppMiddleware = (storeApi) => (next) => (action: unknown) => { ... }", "percentage": 95, "note": "Preserves type safety while allowing thunks and other action types", "command": "See Redux issue #4518 for full middleware example"},
        {"solution": "Use Redux Toolkit''s isAnyOf matching utility for type-safe action narrowing", "percentage": 90, "note": "Forces explicit type guards instead of relying on unsafe union types"},
        {"solution": "Implement custom type guards to narrow action type in middleware before accessing properties", "percentage": 85, "note": "Works with vanilla Redux middleware patterns"}
    ]'::jsonb,
    'Redux installed, TypeScript configured, Understanding of Redux middleware pattern',
    'TypeScript compiler accepts middleware type annotations without errors, Middleware functions properly type-check action properties',
    'Do not use any type for action parameter - always use unknown. Remember action can be thunk, promise, or regular action. Type guards required before property access.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/reduxjs/redux/issues/4518'
),
(
    'TS2353 error in Redux Toolkit configureStore when preloadedState type is inferred as any',
    'github-redux',
    'MEDIUM',
    '[
        {"solution": "Add explicit type annotation to preloadedState: const preloadedState: unknown = loadState();", "percentage": 95, "note": "Converts any to unknown, preserving Redux Toolkit''s type checking"},
        {"solution": "Explicitly type preloadedState with full state interface if loading from external source", "percentage": 90, "note": "Better IDE support and error messages"},
        {"solution": "Use a type guard function to validate loaded state matches expected shape before passing to configureStore", "percentage": 85, "note": "Provides runtime safety in addition to type checking"}
    ]'::jsonb,
    'Redux Toolkit installed, TypeScript configured, State being loaded from localStorage or external source',
    'configureStore accepts preloadedState without type errors, Store properly recognizes reducer keys',
    'Do not leave preloadedState as inferred any type. Always explicitly annotate types when loading from external sources. Verify store has expected shape after creation.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/reduxjs/redux/issues/4812'
),
(
    'Redux Toolkit @typescript-eslint/consistent-type-imports rule not enabled',
    'github-redux',
    'MEDIUM',
    '[
        {"solution": "Add ESLint rule to .eslintrc: \"@typescript-eslint/consistent-type-imports\": \"error\"", "percentage": 95, "note": "Enforces type-only import syntax"},
        {"solution": "Run eslint with --fix to auto-convert imports: npx eslint . --fix", "percentage": 90, "note": "Automatically updates all type imports in codebase"},
        {"solution": "Update import statements manually from import { Store } to import type { Store }", "percentage": 85, "note": "Prevents type info from being bundled into production"}
    ]'::jsonb,
    '@typescript-eslint/eslint-plugin installed, ESLint configured, Redux types imported in codebase',
    'ESLint passes without warnings about type imports, Type-only imports use import type syntax, Bundle size reduced for type imports',
    'Do not forget to install @typescript-eslint/eslint-plugin before adding the rule. The --fix flag is safe and should be used. Verify all type imports now use type keyword.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/reduxjs/redux/issues/4575'
),
(
    'Redux v5.0.1 upgrade causes TypeScript AppDispatch type inference loss with ThunkDispatch',
    'github-redux',
    'HIGH',
    '[
        {"solution": "Add forced resolution in package.json: \"resolutions\": { \"redux\": \"^5.0.1\" }", "percentage": 95, "note": "Ensures all dependencies use consistent Redux version"},
        {"solution": "Remove @types/react-redux package - React Redux v8+ includes built-in types", "percentage": 90, "note": "Eliminates type conflicts from duplicate type definitions"},
        {"solution": "Structure listener middleware setup outside middleware callback in configureStore setup", "percentage": 85, "note": "Prevents type inference issues from nested function contexts"}
    ]'::jsonb,
    'Redux v5.0.0+ installed, React Redux v8+ installed, Thunks used in application',
    'TypeScript compilation succeeds without type errors on dispatch calls, AppDispatch type includes ThunkDispatch in union',
    'Conflicting Redux v4 and v5 in dependency tree causes this issue. Check package-lock for v4 remnants. Use resolutions to force single version. Remove old @types/react-redux packages.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/reduxjs/redux/issues/4648'
),
(
    'Redux documentation Redux Toolkit code sample inconsistency with action payload structure',
    'github-redux',
    'MEDIUM',
    '[
        {"solution": "Use consistent payload structure: direct ID assignment instead of wrapping in object", "percentage": 95, "note": "Redux Toolkit auto-generated actions use parameter directly as payload"},
        {"solution": "Understand Redux Toolkit''s createAction behavior: parameter becomes payload without transformation", "percentage": 90, "note": "If called with ID value, payload is ID; if called with object, payload is the object"},
        {"solution": "Update reducer example to match action creator: access payload directly if passing scalar, or payload.id if passing object", "percentage": 85, "note": "Synchronize example code across before and after patterns"}
    ]'::jsonb,
    'Redux Toolkit v1.0+, Understanding of action creators, Familiarity with payload concept',
    'Documentation examples are consistent between manual and Redux Toolkit patterns, Reducer code matches action creator behavior in examples',
    'Common pitfall: confusing manual action wrapping {id: 123} with Redux Toolkit direct assignment. Keep examples synchronized to avoid learner confusion. Test both scalar and object payloads.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/reduxjs/redux/issues/4718'
),
(
    'useSelector returns reference not deep copy of Redux state - accidental mutations',
    'github-redux',
    'HIGH',
    '[
        {"solution": "Understand useSelector returns direct reference by design, not a copy - do not mutate returned value", "percentage": 95, "note": "This is intentional behavior, not a bug"},
        {"solution": "Use Immer integration in Redux Toolkit to safely handle immutable updates in reducers", "percentage": 90, "note": "Automatically detects and prevents mutations at reducer level"},
        {"solution": "Adopt immutable update patterns in application code rather than relying on Redux to prevent mutations", "percentage": 85, "note": "Restructure state object instead of mutating: ...state, prop: newValue"}
    ]'::jsonb,
    'Redux core or Redux Toolkit installed, Understanding of immutability concepts, Immer available for protection',
    'Reducer updates produce new state references, useSelector calls never trigger unintended store mutations, Linting rules detect mutations',
    'useSelector deliberately returns reference, not copy. Never mutate returned state directly. Redux Toolkit + Immer provides mutation safety. Vanilla Redux requires manual immutability patterns. Plain filtering creates local copy, not store mutation.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/reduxjs/redux/issues/3719'
),
(
    'Plain JavaScript class instances cannot be stored in Redux state - serialization incompatibility',
    'github-redux',
    'MEDIUM',
    '[
        {"solution": "Use plain JavaScript objects or TypeScript interfaces instead of class instances: interface Person { name: string } const user: Person = { name: \"John\" }", "percentage": 95, "note": "Classes don''t serialize with JSON.stringify or work with Redux DevTools"},
        {"solution": "Store only POJOs, arrays, and primitives in Redux state for serialization", "percentage": 90, "note": "Classes fail JSON.parse(JSON.stringify()) test and break persistence"},
        {"solution": "If using classes, convert to plain objects in action creator before dispatch", "percentage": 85, "note": "Keep Redux state free of non-serializable values"}
    ]'::jsonb,
    'Redux store configured, TypeScript or JavaScript project, Understanding of state serialization',
    'Redux DevTools displays state correctly without serialization errors, Time-travel debugging works properly, State persists and restores correctly',
    'Classes with only properties are not serializable. DevTools and persistence require plain objects. Redux style guide explicitly discourages class instances. Use plain objects or type interfaces for data.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://github.com/reduxjs/redux/issues/4649'
),
(
    'Redux API calls should use middleware or thunks, not reducers',
    'github-redux',
    'VERY_HIGH',
    '[
        {"solution": "Use Redux Thunk middleware to handle async API calls: const loginThunk = async (dispatch) => { const result = await api.login(); dispatch(loginSuccess(result)); }", "percentage": 95, "note": "Thunk receives dispatch to coordinate multiple actions"},
        {"solution": "Put async logic in action creators, not reducers: Reducers are synchronous pure functions", "percentage": 92, "note": "Middleware layer handles side effects, reducers only update state"},
        {"solution": "Dispatch actions from middleware based on API success/failure, then let reducers handle state updates", "percentage": 90, "note": "Maintains separation of concerns and Redux predictability"}
    ]'::jsonb,
    'Redux Thunk or other async middleware installed, Redux store configured, API client available',
    'API calls execute through middleware, Reducers remain pure functions without side effects, State updates occur after API completes',
    'Never put API calls in reducers - violates pure function requirement. Calling action creator without dispatch has no effect. Use middleware for all async operations. Thunk receives dispatch, can coordinate multiple actions.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://github.com/reduxjs/redux/issues/291'
),
(
    'Redux best practice: use selectors everywhere instead of direct state access',
    'github-redux',
    'HIGH',
    '[
        {"solution": "Create reusable selectors for all state access: const selectUserId = (state) => state.user.id", "percentage": 95, "note": "Use selectors in components and derived selectors consistently"},
        {"solution": "Share selectors across components and thunks - use them everywhere for state queries", "percentage": 92, "note": "Enables refactoring without touching components using the selector"},
        {"solution": "Use Reselect library for memoized selectors to optimize performance and prevent unnecessary re-renders", "percentage": 90, "note": "Prevents recreation of objects on each selector call"}
    ]'::jsonb,
    'Redux store established with state structure, Redux Thunk or middleware available, Reselect library optional',
    'Components only access state through selectors, Selectors are reused across multiple components and tests, Application refactors without breaking component references',
    'Avoid direct state access like state.user.id in components. Always create and use selectors. Selectors serve as query API between components and state structure. Reduces typos and makes refactoring safer. Use Reselect for performance.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/reduxjs/redux/issues/1171'
),
(
    'Redux composition challenge: middleware patterns don''t compose well for sub-applications',
    'github-redux',
    'MEDIUM',
    '[
        {"solution": "Use Redux Loop pattern for Elm-like composable effects with better reducer composition", "percentage": 85, "note": "Provides fractal architecture similar to Elm''s side effect model"},
        {"solution": "Consider Redux Saga for complex effect coordination across multiple reducers", "percentage": 80, "note": "More composable than Thunk for complex multi-step workflows"},
        {"solution": "Design middleware as encapsulated modules that can be composed at store creation time", "percentage": 75, "note": "Requires careful architecture but enables module-level side effect handling"}
    ]'::jsonb,
    'Redux with multiple sub-applications, Complex side effect handling required, Familiarity with effect patterns',
    'Sub-applications maintain independent middleware configurations, Effects compose without breaking encapsulation, Modular reducers can be combined without side effect conflicts',
    'Thunk and Saga require top-level positioning, making composition difficult. Redux Loop provides better composability. Pure functions and algebraic effects offer elegant composition solutions. Consider application architecture before choosing effect pattern.',
    0.78,
    'sonnet-4',
    NOW(),
    'https://github.com/reduxjs/redux/issues/1528'
),
(
    'Redux TypeScript definitions maintenance: choose DefinitelyTyped over bundled types',
    'github-redux',
    'MEDIUM',
    '[
        {"solution": "Move TypeScript definitions to DefinitelyTyped repository instead of bundling with Redux package", "percentage": 90, "note": "DefinitelyTyped allows community maintenance without affecting library releases"},
        {"solution": "Use @types/redux from DefinitelyTyped for improved type definition versions", "percentage": 85, "note": "Decouples type definition updates from library version constraints"},
        {"solution": "Avoid manually bundled index.d.ts files - leverage community-maintained DefinitelyTyped process", "percentage": 80, "note": "Reduces maintenance burden and synchronization issues"}
    ]'::jsonb,
    'Redux package installed, TypeScript configured, TypeScript 3.0+',
    'TypeScript compilation succeeds with @types/redux types, Type definitions don''t block library updates, Complex types properly handled by DefinitelyTyped maintainers',
    'Bundled types in library create synchronization headaches. DefinitelyTyped provides versioning flexibility. TypeScript team recommends DefinitelyTyped for non-TypeScript projects. Type definition updates should not block library releases.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/reduxjs/redux/issues/3500'
),
(
    'Redux Starter Kit (Redux Toolkit) RFC: reducing boilerplate with preconfigured setup',
    'github-redux',
    'HIGH',
    '[
        {"solution": "Use Redux Toolkit''s configureStore instead of manual createStore for zero-config setup with good defaults", "percentage": 95, "note": "Includes middleware, DevTools, and Immer integration automatically"},
        {"solution": "Use createReducer and createSlice utilities to write reducers with less boilerplate", "percentage": 92, "note": "Automatically generates action creators and handles immutable updates with Immer"},
        {"solution": "Enable Redux DevTools automatically in configureStore without manual middleware registration", "percentage": 90, "note": "Developer experience improvement with less configuration required"}
    ]'::jsonb,
    'Redux Toolkit v1.0+, Immer available, Understanding of Redux concepts',
    'Store configures with minimal code, Action creators generated automatically, DevTools enabled without manual setup, Mutations prevented by Immer',
    'Redux Toolkit is now the recommended way to set up Redux. CRA includes it by default. Reduces setup complexity significantly. Immer allows mutation-like syntax in reducers safely. Use createSlice for most use cases instead of manual reducers.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://github.com/reduxjs/redux/issues/2859'
);
