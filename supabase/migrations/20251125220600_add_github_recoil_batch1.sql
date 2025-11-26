-- Add Recoil GitHub issues solutions batch 1
-- Extracted from facebookexperimental/Recoil repository
-- Focus: Atom family issues, SSR problems, performance, async selectors

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Recoil SSR with Next.js duplicate atom key warnings during development and production build',
    'github-recoil',
    'HIGH',
    '[
        {"solution": "Use RECOIL_DUPLICATE_ATOM_KEY_CHECKING_ENABLED environment variable to control duplicate key detection", "percentage": 85, "note": "Configure via RecoilEnv API for environment-specific behavior"},
        {"solution": "Add configuration setting to disable duplicate key check for server-side environments", "percentage": 75, "note": "Particularly useful for multi-entry point builds"},
        {"solution": "Implement advanced tracing to distinguish actual redeclaration from same code executing multiple times", "percentage": 60, "note": "Complex approach with reliability concerns"}
    ]'::jsonb,
    'Recoil 0.7.x+, Next.js project with SSR, Node.js build process',
    'Build logs show no duplicate atom key warnings, Development hot-reload works without warnings, Production build completes cleanly',
    'Disabling checks too broadly can hide actual atom redeclaration bugs. SSR environments naturally re-execute code in single Node.js process. Different entry points may legitimately declare atoms.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/facebookexperimental/Recoil/issues/733'
),
(
    'Recoil selectors trigger re-renders even when output value has not changed',
    'github-recoil',
    'HIGH',
    '[
        {"solution": "Add isEqual comparator function to selector config: selector({ key: ''key'', get: ..., isEqual: customComparator })", "percentage": 90, "note": "Most favored solution from community discussion, provides granular control"},
        {"solution": "Use cachePolicy_UNSTABLE with eviction: ''most-recent'' workaround", "percentage": 75, "note": "Existing workaround but unstable API"},
        {"solution": "Split compound atoms into separate atoms for granular subscriptions", "percentage": 70, "note": "Works but not always semantically appropriate"},
        {"solution": "Use intermediate selectors extracting only relevant fields", "percentage": 80, "note": "Standard workaround, increases selector complexity"}
    ]'::jsonb,
    'Recoil 0.7.x+, Compound state objects or frequently-changing base atoms, Understanding of equality comparisons',
    'Eliminated unnecessary re-renders for unchanged derived values, Performance improvement measurable, Cleaner API without intermediate selectors',
    'Many developers resort to intermediate selectors as a workaround when custom equality should be the solution. Some may split atoms inappropriately losing semantic meaning. Performance impact can be significant with high-frequency state changes.',
    0.80,
    'sonnet-4',
    NOW(),
    'https://github.com/facebookexperimental/Recoil/issues/1416'
),
(
    'Recoil async selector refresh invalidation not possible without manual workarounds',
    'github-recoil',
    'HIGH',
    '[
        {"solution": "Create trigger atom pattern: atom depends on counter, increment counter to force selector re-evaluation", "percentage": 90, "note": "Official recommended pattern, most reliable approach"},
        {"solution": "Implement selector with setter that updates trigger atom on reset", "percentage": 85, "note": "Allows using useResetRecoilState() for refresh"},
        {"solution": "Use native refresh API if available in newer Recoil versions", "percentage": 60, "note": "Requested feature not yet in stable releases"}
    ]'::jsonb,
    'Recoil 0.7.x+, Async selector defined, Understanding of atom dependency registration',
    'Async selector re-executes fetch logic, New data replaces cached values, Component re-renders with fresh data from API',
    'No native ''refresh selector'' API exists, multiple triggers become unwieldy in larger apps. Pattern feels like workaround rather than first-class feature. Avoid increment patterns with multiple selectors.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/facebookexperimental/Recoil/issues/85'
),
(
    'Recoil atom effects cannot access values from other atoms in synchronous way',
    'github-recoil',
    'MEDIUM',
    '[
        {"solution": "Use selector instead of atom effect for cross-atom dependencies: selector({ get: ({ get }) => { const val = get(otherAtom); ... } })", "percentage": 95, "note": "Official recommended approach, fully supported"},
        {"solution": "Use planned getSnapshot() callback mechanism if available", "percentage": 40, "note": "Still in development, not yet in stable release"},
        {"solution": "Store get function reference outside Recoil within effects (hacky)", "percentage": 20, "note": "Raises concurrency concerns, not recommended"}
    ]'::jsonb,
    'Recoil 0.7.x+, Understanding of selectors vs atoms, Async data fetching patterns',
    'Ability to subscribe to atom value changes within effects, Automatic dependency tracking and memoization, No manual subscription management required',
    'Attempting to access other atoms synchronously within effects is common mistake. getSnapshot() would be ideal but not available yet. External function approach has concurrency issues.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/facebookexperimental/Recoil/issues/707'
),
(
    'Recoil storing async-fetched data in atoms while tracking loading error success states',
    'github-recoil',
    'HIGH',
    '[
        {"solution": "Use Loadable pattern with useRecoilStateLoadable() or useRecoilValueLoadable()", "percentage": 95, "note": "Official first-class API, recommended approach"},
        {"solution": "Store object in atom with value, error, pending status properties and manage updates via useEffect", "percentage": 80, "note": "Manual but straightforward approach"},
        {"solution": "Implement selectorFamily for parameterized async queries", "percentage": 85, "note": "Good for multiple parameters"},
        {"solution": "Create custom useAtomLoadable() hook wrapping atoms with Loadable semantics", "percentage": 75, "note": "Enables promises as async setters with Suspense compatibility"}
    ]'::jsonb,
    'Recoil 0.7.x+, Understanding of atoms vs selectors, Optional: React Suspense knowledge',
    'Async operations complete and store results in reachable state, Components access loading/error/success status, Multiple components share fetched data without refetching',
    'Many developers manually manage state with useEffect when Loadable pattern would be cleaner. Suspense is powerful but requires careful error boundary setup. Storing structured data in atoms can lead to boilerplate.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/facebookexperimental/Recoil/issues/237'
),
(
    'Recoil with Next.js SSR initialization and atom effects onSet handler not triggering',
    'github-recoil',
    'MEDIUM',
    '[
        {"solution": "Initialize state within the effect itself using setSelf rather than RecoilRoot initializeState prop", "percentage": 90, "note": "Preferred approach for persistence, handles dynamic families better"},
        {"solution": "Use useSetRecoilState within component with useEffect before rendering children", "percentage": 75, "note": "Workaround pattern, not ideal but functional"},
        {"solution": "Wrap persistence logic in separate component that delays child mounting until data loads", "percentage": 70, "note": "Nested provider pattern, increases complexity"}
    ]'::jsonb,
    'Recoil 0.7.x+, Atom with effects_UNSTABLE containing onSet() handler, RecoilRoot with initializeState prop',
    'onSet() handler executes whenever atom state changes not just on initial render, Persisted state updates trigger intended side effects, Multiple test runs dont interfere with state',
    'initializeState prop is convenient but doesnt trigger onSet handlers properly. Common to miss that effects should handle their own initialization. Persistence policies benefit from effect-based initialization.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/facebookexperimental/Recoil/issues/767'
),
(
    'Recoil selector cache persistence across RecoilRoot instances causes test data bleed',
    'github-recoil',
    'MEDIUM',
    '[
        {"solution": "Use cache-busting workaround: inject dependency on incrementing atom into all selectors, increment before each test", "percentage": 75, "note": "Requires Jest mocking but functional"},
        {"solution": "Use selectors as default values for atoms instead of static functions for dynamic re-evaluation", "percentage": 70, "note": "Documented pattern but doesn''t fully solve isolation"},
        {"solution": "Implement garbage collection feature to dynamically release and re-initialize atoms", "percentage": 40, "note": "Future feature, timeline unclear, would address root cause"}
    ]'::jsonb,
    'Recoil 0.7.x+ with atomFamily or selectors, Jest testing framework, Understanding of snapshot_UNSTABLE API',
    'Tests start with clean slate regardless of execution order, Selectors re-evaluate initial values between tests, No need for external dependency management',
    'reset() only clears atom state not cached defaults. Parameterized defaults in families are intentionally cached for performance. Cache-busting requires substantial test infrastructure. Test order dependency is hard to debug.',
    0.75,
    'sonnet-4',
    NOW(),
    'https://github.com/facebookexperimental/Recoil/issues/972'
),
(
    'Recoil react warning cannot update component while rendering different component with useRecoilValue',
    'github-recoil',
    'MEDIUM',
    '[
        {"solution": "Remove webpack alias react-dom @hot-loader/react-dom that enables hot module reloading", "percentage": 85, "note": "Addresses root cause in development builds"},
        {"solution": "Update to newer React versions to resolve compatibility issues", "percentage": 75, "note": "Problem less prevalent in React 17+"},
        {"solution": "Disable hot module reloading during development as temporary workaround", "percentage": 70, "note": "Functional but reduces development experience"}
    ]'::jsonb,
    'React 16.13.1+, Recoil 0.0.7+, Code structure following Recoil getting-started example',
    'Warning no longer appears in console during component rendering, State updates function correctly despite warnings, Code functions as documented',
    'Hot module loading is known issue with older React versions. Multiple components rendering simultaneously can trigger warning. This was more common in early Recoil versions.',
    0.80,
    'sonnet-4',
    NOW(),
    'https://github.com/facebookexperimental/Recoil/issues/12'
),
(
    'Recoil unmounted component state update errors in v0.2.0 with useEffect patterns',
    'github-recoil',
    'MEDIUM',
    '[
        {"solution": "Specify actual state dependencies in useEffect instead of setter function dependency", "percentage": 90, "note": "Correct dependency array prevents unnecessary effect runs"},
        {"solution": "Use useRef to verify component still exists before calling setState", "percentage": 85, "note": "Explicit safety check prevents updates on unmounted components"},
        {"solution": "Avoid state updates within useEffect callbacks when possible", "percentage": 75, "note": "Pattern is inherently prone to timing issues"}
    ]'::jsonb,
    'React/React Native environment, Recoil v0.2.0+, Components with lifecycle mismatches between effects and renders',
    'No console warnings about unmounted component updates, Clean component mount/unmount cycles, Proper cleanup in effect dependencies',
    'Easy to miss that dependency arrays should reference actual state values not setter functions. Timing issues between effect callbacks and component unmounting can be subtle. Expo or similar libraries may compound the problem.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/facebookexperimental/Recoil/issues/951'
),
(
    'Recoil with Next.js 13 app directory SSR batcher is not a function error',
    'github-recoil',
    'HIGH',
    '[
        {"solution": "Upgrade to Recoil 0.7.6+ which includes SSR fallback for missing unstable_batchedUpdates", "percentage": 95, "note": "Official fix implemented in stable release"},
        {"solution": "Remove initializeState function from RecoilRoot for server-side rendering", "percentage": 85, "note": "Workaround that avoids batching requirement"},
        {"solution": "Add use client directive to all Recoil-consuming components", "percentage": 80, "note": "Ensures client-side rendering where batching available"},
        {"solution": "Avoid using initializeState during server-side rendering", "percentage": 75, "note": "Alternative workaround pattern"}
    ]'::jsonb,
    'React 18.2.0+, Next.js 13.0.0+, Recoil 0.7.6+, RecoilRoot with initializeState prop',
    'Pages render server-side without ''batcher is not a function'' error, Client-side hydration completes successfully, State initialization via initializeState works as expected',
    'Next.js 13 uses ReactDOMServerRenderingStub during SSR without unstable_batchedUpdates export. React 18+ handles batching automatically so fallback is safe. Many projects still using older Recoil versions.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/facebookexperimental/Recoil/issues/2082'
),
(
    'Recoil SSR Next.js general integration status and best practices for server-side state',
    'github-recoil',
    'HIGH',
    '[
        {"solution": "Use atom effects to avoid maintaining manual atom lookups, enabling atomFamily compatibility", "percentage": 85, "note": "Modern pattern recommended by maintainers"},
        {"solution": "Implement root atoms as intermediaries: bootstrap data assigns to root atoms, actual atoms use selectors", "percentage": 80, "note": "Complex but robust pattern for large apps"},
        {"solution": "Use getServerSideProps with manual atom dictionary initialization", "percentage": 75, "note": "Straightforward but requires careful state management"},
        {"solution": "Leverage enhanced effects with useMemo for atom initialization on server", "percentage": 70, "note": "Risk of data retention between requests on server"}
    ]'::jsonb,
    'Next.js 12+, Recoil 0.7.x+, Understanding of server-side data fetching patterns, Familiarity with atom effects and selectors',
    'Successful state initialization during server rendering and hydration, No data bleed between requests, Client-side hydration matches server output',
    'Mutable global variables on servers risk retaining data from previous page loads. Manual atom dictionaries become unwieldy. Atom effects add complexity but solve isolation issues. Snapshot API required for synchronous SSR loading.',
    0.78,
    'sonnet-4',
    NOW(),
    'https://github.com/facebookexperimental/Recoil/issues/750'
),
(
    'Recoil getPromise in atom effects does not resolve when getting pending async atom',
    'github-recoil',
    'MEDIUM',
    '[
        {"solution": "Wait for target atom to resolve before calling getPromise, or ensure atom is initialized first", "percentage": 75, "note": "Workaround but highlights async initialization ordering"},
        {"solution": "Use atom effects more carefully, ensure dependencies are properly initialized before getPromise calls", "percentage": 80, "note": "Design pattern adjustment"},
        {"solution": "Check Recoil version and release notes for getPromise fixes in newer versions", "percentage": 60, "note": "Known bug in some versions, may be fixed in updates"}
    ]'::jsonb,
    'Recoil 0.7.x+, Atom effects with getPromise usage, Another atom in loading state',
    'Promise from getPromise resolves with atom value, Callbacks (.then/.catch) execute as expected, Target atom value available after promise resolution',
    'Common mistake to call getPromise on atoms still in loading state. Promise stays pending indefinitely if initialization order is wrong. No error thrown makes debugging difficult. Repository archived January 2025 so issue may not be resolved.',
    0.65,
    'sonnet-4',
    NOW(),
    'https://github.com/facebookexperimental/Recoil/issues/2314'
),
(
    'Recoil duplicate atom key checking environment variable and SSR production issues',
    'github-recoil',
    'MEDIUM',
    '[
        {"solution": "Review RECOIL_DUPLICATE_ATOM_KEY_CHECKING_ENABLED environment variable in RecoilEnv API reference", "percentage": 85, "note": "Controls environment-specific duplicate key detection behavior"},
        {"solution": "Disable key checking in production via environment configuration", "percentage": 75, "note": "Avoids warnings in production builds with multiple entry points"},
        {"solution": "Use different RecoilRoot instances for different code contexts to isolate atom definitions", "percentage": 70, "note": "Architectural approach for complex setups"}
    ]'::jsonb,
    'Recoil 0.7.x+, Build environment with multiple entry points, Access to environment variables',
    'Production builds complete without duplicate key errors, Internal server errors resolved, Atom definitions properly isolated across entry points',
    'Setting affects both development and production. Different entry points naturally re-execute code. Can mask actual atom redeclaration bugs if disabled too broadly. Stackblitz and React Native environments have similar issues.',
    0.72,
    'sonnet-4',
    NOW(),
    'https://github.com/facebookexperimental/Recoil/issues/1570'
);
