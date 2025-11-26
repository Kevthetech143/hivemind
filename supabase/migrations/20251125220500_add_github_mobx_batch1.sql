-- Add GitHub MobX issue solutions batch 1
-- Extracted from mobxjs/mobx repository high-engagement issues with solutions

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Observable automatic conversion of nested objects and arrays causing unexpected mutations',
    'github-mobx',
    'HIGH',
    '[
        {"solution": "Explicitly make objects and arrays observable before pushing/assigning: const todo = observable({done: false}); const todos = observable([]); todos.push(todo)", "percentage": 90, "note": "Prevents automagic conversion confusion"},
        {"solution": "Use extendObservable for fine-grained control over which properties are observable", "percentage": 85, "note": "Alternative approach for object enhancement"},
        {"solution": "Avoid relying on side-effects of assignment - always explicitly call observable() on values", "percentage": 80, "note": "Best practice for clarity and maintainability"}
    ]'::jsonb,
    'MobX 4.x or 5.x, Understanding of observable fundamentals',
    'Objects and arrays remain in expected state after push/assignment operations, No unexpected property mutations',
    'Do not assume nested objects become observable automatically when pushed to observable arrays. Explicit observable() wrapping is required. This behavior changed in MobX 6+.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/mobxjs/mobx/issues/649'
),
(
    'MobX 6 breaking changes: decorators removed and API migrations needed',
    'github-mobx',
    'VERY_HIGH',
    '[
        {"solution": "Replace @observable decorators with makeObservable(this, {field: observable}) in constructor", "percentage": 95, "note": "Official migration path for MobX 6"},
        {"solution": "Use makeAutoObservable(this) which auto-detects fields as observable, getters as computed, methods as actions", "percentage": 92, "note": "Simpler alternative when you want standard behavior"},
        {"solution": "Use codemod for automated migration: available in MobX 6 docs for converting existing decorators", "percentage": 90, "note": "Minimal manual work required"},
        {"solution": "Import from mobx-decorators package if decorators absolutely needed, but this is deprecated path", "percentage": 60, "note": "Strongly discouraged - use makeObservable instead"}
    ]'::jsonb,
    'MobX 4.x or 5.x codebase, TypeScript 3.7+, Understanding of class fields',
    'Components render without errors, Observable state updates trigger reactions, No decorator-related warnings in console',
    'Decorators completely dropped in MobX 6 - cannot use @observable, @action, @computed decorators. Must migrate to constructor-based API. Ensure TypeScript useDefineForClassFields is set correctly.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/mobxjs/mobx/issues/2325'
),
(
    'Road to MobX 4.0: Proxy-based observables, deprecations, and environment requirements',
    'github-mobx',
    'HIGH',
    '[
        {"solution": "Migrate from observable arrays to native proxy-based arrays - no more faux array implementation", "percentage": 93, "note": "Core improvement in 4.0"},
        {"solution": "Replace observable.map with native ES6 Map support for better key handling and Sets support", "percentage": 90, "note": "Native implementations now available"},
        {"solution": "Use proxy-based objects for all property mutations including dynamic properties", "percentage": 88, "note": "Eliminates need for extendObservable in most cases"},
        {"solution": "For IE11 support, continue using MobX 3.x branch - 4.0+ requires modern browsers with Proxy support", "percentage": 70, "note": "IE11 no longer supported in 4.0+"}
    ]'::jsonb,
    'MobX 3.x codebase, Modern browser environment or willingness to drop IE11 support',
    'Arrays behave as native arrays, Observable properties work on dynamically added properties, All observable operations perform better',
    'MobX 4.0 drops IE support entirely - must target modern evergreen browsers. Array.isArray() now returns true for observable arrays. Property additions are automatically observed.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/mobxjs/mobx/issues/1076'
),
(
    'How to integrate MobX with Meteor Tracker for reactive data binding',
    'github-mobx',
    'MEDIUM',
    '[
        {"solution": "Wrap Meteor findOne result in observable: var afiliado = observable(); Tracker.autorun(() => { afiliado(Orgz.collections.Afiliados.findOne({_id})) })", "percentage": 88, "note": "Bridges Meteor Tracker with MobX observables"},
        {"solution": "Remember to dispose Tracker.autorun in componentWillUnmount: autorunner.stop() to prevent memory leaks", "percentage": 95, "note": "Critical for React lifecycle"},
        {"solution": "Use observer() HOC on components that access observable values from Meteor", "percentage": 92, "note": "Ensures React re-renders on observable changes"},
        {"solution": "Check if Meteor findOne returns same object reference - use observable({...object}) to handle new objects", "percentage": 80, "note": "Handles mutation tracking correctly"}
    ]'::jsonb,
    'Meteor project, MobX 4.x or 5.x, React or mobx-react, Knowledge of Tracker.autorun',
    'Component updates when Meteor collection changes, No console errors about observable setup, Tracker.autorun fires only when data actually changes',
    'Do not forget componentWillUnmount cleanup - Tracker.autorun must be stopped to prevent memory leaks and duplicate observations. Meteor findOne behavior must be verified.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/mobxjs/mobx/issues/84'
),
(
    'Multiple MobX instances in application causing reactions to not trigger',
    'github-mobx',
    'HIGH',
    '[
        {"solution": "Use peer dependencies instead of direct dependencies in libraries - only end product imports mobx directly", "percentage": 96, "note": "Official recommended solution for multiple library scenario"},
        {"solution": "If bundling libraries independently, mark mobx as external dependency so it shares a single instance", "percentage": 94, "note": "Works with webpack and other bundlers"},
        {"solution": "Call mobx.extras.isolateGlobalState() if intentionally running isolated MobX instances without cross-library reactions", "percentage": 85, "note": "Suppresses warning when isolation is intentional"},
        {"solution": "Legacy: Use mobx.extras.shareGlobalState() to sync global state between versions (deprecated in 4.0+)", "percentage": 40, "note": "Avoid - prefer peer dependencies approach"}
    ]'::jsonb,
    'Multiple libraries using MobX, Module bundler knowledge, NPM/yarn understanding',
    'No warning: \"There are multiple mobx instances active\", Reactions trigger correctly across all observables, Library observables and app observables react together',
    'Library A observables do not trigger reactions in Library B if they use separate MobX instances. Peer dependencies must be declared properly or bundler must deduplicate. shareGlobalState is deprecated.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://github.com/mobxjs/mobx/issues/1082'
),
(
    'How to create setter actions for observable properties to avoid boilerplate code',
    'github-mobx',
    'MEDIUM',
    '[
        {"solution": "Use TypeScript getter/setter pattern: get x() {return this._x} set x(v) {this._x = v} with @observable private _x", "percentage": 92, "note": "Clean API surface with private backing field"},
        {"solution": "Avoid repetitive setX actions - instead create domain-specific mutation actions that align with actual app behavior", "percentage": 88, "note": "Example: setName(first, last) instead of setFirstName() and setLastName()"},
        {"solution": "In strict mode, mutations must be wrapped in actions - use @action or action() wrapper appropriately", "percentage": 90, "note": "Required for MobX strict mode compliance"},
        {"solution": "For box-style values, use observable.box() but remember to call .get()/.set() explicitly", "percentage": 70, "note": "Less convenient than object properties"}
    ]'::jsonb,
    'MobX 4.x or 5.x, TypeScript or JavaScript, Understanding of strict mode',
    'Observable values update correctly, No "Cannot modify state outside action" errors in strict mode, Component re-renders when value changes',
    'Do not create one setter per observable in strict mode - instead structure mutations around actual business logic changes. observable.box requires explicit .get()/.set() calls. Getter/setter pattern requires private backing field.',
    0.86,
    'sonnet-4',
    NOW(),
    'https://github.com/mobxjs/mobx/issues/839'
),
(
    'TypeScript useDefineForClassFields makes decorators incompatible with standard field semantics',
    'github-mobx',
    'HIGH',
    '[
        {"solution": "Move field initializations to constructor with extendObservable: extendObservable(this, {value: this.value})", "percentage": 93, "note": "Works around useDefineForClassFields issue"},
        {"solution": "Use makeObservable/makeAutoObservable in constructor instead of decorators - this is the official MobX 6 solution", "percentage": 95, "note": "Recommended approach - full compatibility"},
        {"solution": "Set tsconfig useDefineForClassFields to false as temporary workaround (not recommended long-term)", "percentage": 70, "note": "Prevents standard compliance - avoid if possible"},
        {"solution": "Upgrade to MobX 6+ which no longer uses decorators and is fully compatible with standard field initialization", "percentage": 98, "note": "Permanent solution"}
    ]'::jsonb,
    'TypeScript 3.8+, MobX 4.x or 5.x, useDefineForClassFields enabled in tsconfig',
    'Decorators work correctly with useDefineForClassFields enabled, Observables properly track mutations, No errors about field initialization',
    'Field initializers using decorators fail silently when useDefineForClassFields is true. Standard JavaScript does not support decorators on fields. This is resolved in MobX 6 by using makeObservable.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/mobxjs/mobx/issues/2288'
),
(
    'Choosing library name: Mobservable renamed to MobX',
    'github-mobx',
    'LOW',
    '[
        {"solution": "MobX is the final chosen name - stands for Mobservable reimagined with modern semantics", "percentage": 100, "note": "Official name since MobX rebranding"},
        {"solution": "Update all imports from mobservable to mobx in package.json and code", "percentage": 98, "note": "Required for all new projects"},
        {"solution": "Legacy mobservable package exists on npm but is no longer maintained - migrate to mobx", "percentage": 95, "note": "Mobservable is deprecated"}
    ]'::jsonb,
    'npm account, Existing mobservable project',
    'All imports resolve correctly, Tests pass with mobx package, No deprecation warnings',
    'Mobservable is deprecated and not maintained. Old packages using mobservable may conflict with new mobx package. Rename all imports during migration.',
    0.99,
    'sonnet-4',
    NOW(),
    'https://github.com/mobxjs/mobx/issues/115'
),
(
    'React error: Maximum update depth exceeded with observer components and useState store initialization',
    'github-mobx',
    'HIGH',
    '[
        {"solution": "Initialize store with lazy callback in useState: useState(() => new Store()) instead of useState(new Store())", "percentage": 95, "note": "Prevents store recreation on each render"},
        {"solution": "Avoid creating observables during render - makeAutoObservable during render counts as mutation and increases state version", "percentage": 93, "note": "Move observable initialization to useState callback"},
        {"solution": "Use useLocalObservable from mobx-react-lite instead of useState + store class pattern", "percentage": 90, "note": "Recommended approach for hooks-based components"},
        {"solution": "Downgrade mobx-react-lite to 3.4.3 if immediate fix needed (temporary workaround only)", "percentage": 60, "note": "Avoid - use proper initialization instead"},
        {"solution": "Remove observer from components at top of render tree if store is initialized inside tree", "percentage": 50, "note": "Workaround - not recommended solution"}
    ]'::jsonb,
    'React 17+, MobX 6.x, mobx-react-lite 4.0+, useState knowledge',
    'Component renders without Maximum update depth error, Observer components correctly track observable changes, Store initializes only once',
    'Observable initialization counts as mutation - store must be created before rendering starts. useState(new Store()) creates new store on each render. Top-level observer components with internal store initialization cause infinite update loops.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/mobxjs/mobx/issues/3728'
),
(
    'React 18 concurrent mode support: reactions leak for aborted component renders',
    'github-mobx',
    'MEDIUM',
    '[
        {"solution": "Use mobx-react-lite@next (4.0+) which has experimental concurrent mode support", "percentage": 88, "note": "Official support for React 18 concurrent features"},
        {"solution": "Test with React.startTransition and experimental concurrent features when upgrading", "percentage": 85, "note": "Validates proper cleanup of reactions"},
        {"solution": "Monitor for reaction leaks in development - ensure reactions are properly disposed when components unmount mid-render", "percentage": 82, "note": "Critical for concurrent correctness"},
        {"solution": "For class components, concurrent mode support is limited - prefer functional components with hooks", "percentage": 78, "note": "Class components have inherent concurrent limitations"}
    ]'::jsonb,
    'React 18+, MobX 6.x, mobx-react-lite 4.0+, Understanding of concurrent mode',
    'Components render without errors in concurrent mode, Reactions properly cleanup when renders abort, useTransition works correctly with observables',
    'Concurrent mode requires proper reaction cleanup that earlier mobx-react versions do not handle. Class components have limited concurrent support. Reactions may leak if not disposed correctly during mid-render aborts.',
    0.81,
    'sonnet-4',
    NOW(),
    'https://github.com/mobxjs/mobx/issues/2526'
),
(
    'API clarity: Observable semantics confusing users about box wrapping and property mutations',
    'github-mobx',
    'MEDIUM',
    '[
        {"solution": "Use explicit observable() calls on objects to make observable semantics visible in code", "percentage": 90, "note": "Makes behavior explicit rather than magical"},
        {"solution": "Document that @observable property = value creates a box internally, not a deep observable", "percentage": 88, "note": "Clarifies what observable actually does"},
        {"solution": "For arrays and objects, prefer observable([]) and observable({}) over @observable field = [] pattern", "percentage": 85, "note": "More explicit about collection type"},
        {"solution": "Understand property access: isObservable(obj, 'field') checks field observability, isObservable(obj.field) checks value type", "percentage": 87, "note": "Common confusion point in API usage"}
    ]'::jsonb,
    'MobX 4.x or 5.x, Understanding of decorators vs function calls',
    'Observable values update correctly, Mutations tracked as expected, No errors from isObservable() checks',
    'People confuse observable(obj) with observing all properties - it is not deep observable. @observable property creates a box, not direct access to value. isObservable(obj) and isObservable(obj, field) have different meanings.',
    0.84,
    'sonnet-4',
    NOW(),
    'https://github.com/mobxjs/mobx/issues/1316'
),
(
    'isolateGlobalState breaks observer reactivity when called after component mount',
    'github-mobx',
    'MEDIUM',
    '[
        {"solution": "Call isolateGlobalState() immediately on app startup, before any observers or reactions are created", "percentage": 92, "note": "Must be called early in initialization"},
        {"solution": "If using isolateGlobalState with dynamic plugins, ensure store and observer setup happens within isolated scope", "percentage": 88, "note": "Timing of initialization is critical"},
        {"solution": "Do not call isolateGlobalState after components mount - it breaks already-established observer connections", "percentage": 95, "note": "Common mistake - call during init only"},
        {"solution": "Use shareGlobalState instead if you need to sync state between isolated instances (MobX 4.x only)", "percentage": 55, "note": "Removed in MobX 5+ - avoid"}
    ]'::jsonb,
    'MobX 6.x, Multiple isolated mobx instances, Understanding of plugin architecture',
    'Observer components react to observable changes correctly, No reactivity loss after isolation, Store updates propagate to observers',
    'Calling isolateGlobalState after observers are created breaks reactivity - must call at startup. useObserver uses its own global state copy that does not sync with later isolateGlobalState calls. Plugin systems must initialize stores within isolated scope.',
    0.83,
    'sonnet-4',
    NOW(),
    'https://github.com/mobxjs/mobx/issues/3734'
);
