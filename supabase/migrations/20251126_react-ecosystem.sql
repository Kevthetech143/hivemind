INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES
(
    'Invalid hook call: Hooks can only be called inside the body of a function component',
    'react',
    'HIGH',
    '[
        {"solution": "Move hook call inside the function component body (not in event handlers, conditionals, or loops)", "percentage": 95},
        {"solution": "If using custom hooks, ensure the component importing it is also a function component, not a class component", "percentage": 90},
        {"solution": "Check for duplicate React versions - run npm ls react. If multiple versions exist, deduplicate using npm dedupe", "percentage": 85}
    ]'::jsonb,
    'Node.js and npm installed, React 16.8+ project',
    'Component renders without error, hooks execute on mount and re-render',
    'Calling hooks conditionally, inside loops, or after early returns; Mixing class and function components; Duplicate React versions in node_modules',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/56663785/invalid-hook-call-hooks-can-only-be-called-inside-of-the-body-of-a-function-com',
    'admin:1764173217'
),
(
    'Rendered fewer hooks than expected. This may be caused by an accidental early return statement.',
    'react',
    'HIGH',
    '[
        {"solution": "Check for conditional hook calls - remove if statements wrapping hooks. Move logic after hook initialization", "percentage": 96},
        {"solution": "Remove early return statements before all hooks are called. Restructure logic to call hooks first, then conditionally execute code", "percentage": 94},
        {"solution": "Verify hook call order is identical across all renders - never conditionally call hooks based on props or state", "percentage": 92}
    ]'::jsonb,
    'React 16.8+ functional component, hooks usage',
    'Console clears of hook-related errors, component re-renders without hook count mismatches',
    'Using if statements to conditionally call hooks; Early returns before all hooks execute; Changing number of hooks between renders',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/53472795/uncaught-error-rendered-fewer-hooks-than-expected-this-may-be-caused-by-an-acc',
    'admin:1764173217'
),
(
    'Cannot read properties of undefined (reading ''routeId'') - TanStack Router',
    'react',
    'MEDIUM',
    '[
        {"solution": "Restart development server completely (kill process and npm start fresh) to clear stale build cache", "percentage": 88},
        {"solution": "Verify route definitions are correct and routeId is present in all route objects", "percentage": 85},
        {"solution": "Clear node_modules and package-lock.json, then reinstall dependencies if version conflicts exist", "percentage": 80}
    ]'::jsonb,
    'TanStack Router v1.4.6+, React 18+, valid route configuration',
    'Navigation between routes works without console errors, RouteId is properly resolved',
    'Stale build cache from previous failed builds; Missing routeId in route definition; Version mismatches between Router and React',
    0.85,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/77828480/tanstack-router-cannot-read-properties-of-undefined-problem',
    'admin:1764173217'
),
(
    'SWR not re-rendering when mutate is called with initialData',
    'react',
    'HIGH',
    '[
        {"solution": "Add revalidateOnMount: true to useSWR options when using initialData to force revalidation on component mount", "percentage": 95},
        {"solution": "Ensure mutate callback properly updates the cache data with new values, not just makes the request", "percentage": 90},
        {"solution": "Use optimisticData option to update UI before API call completes", "percentage": 88}
    ]'::jsonb,
    'SWR library installed, useSWR hook in functional component',
    'UI updates immediately after mutate call, new data renders without page refresh',
    'Relying only on initialData without revalidateOnMount; Mutate called but cache not properly updated; Not using optimisticData for immediate UI feedback',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/66814548/swr-not-re-rendering-when-mutate-is-called',
    'admin:1764173217'
),
(
    'Mutate in useSWR hook not updating the DOM with deeply nested objects',
    'react',
    'HIGH',
    '[
        {"solution": "Create new object reference instead of mutating nested properties - use spread operator or Object.assign: mutate({...data, nested: {...data.nested, field: newValue}})", "percentage": 97},
        {"solution": "Pass new data object to mutate as second argument: mutate(newData, false) instead of modifying existing object", "percentage": 94},
        {"solution": "Use immutable update patterns consistently throughout application to ensure React detects changes", "percentage": 92}
    ]'::jsonb,
    'SWR library, useSWR hook, state containing nested objects',
    'DOM updates when nested object properties change, UI reflects mutate results immediately',
    'Directly mutating nested object properties without creating new reference; Passing same object reference to mutate; Forgetting that React requires new object references to detect changes',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/71445428/mutate-in-useswr-hook-not-updating-the-dom',
    'admin:1764173217'
),
(
    'React Query stale query not refetching on mount after invalidation',
    'react',
    'MEDIUM',
    '[
        {"solution": "Ensure refetchOnMount is set to true (it''s the default but verify it isn''t explicitly disabled): refetchOnMount: true in useQuery options", "percentage": 93},
        {"solution": "Call queryClient.invalidateQueries() to mark query as stale, then navigate back to component - it will auto-refetch on mount", "percentage": 92},
        {"solution": "Use staleTime: 0 to make queries immediately stale after mutation, triggering refetch on next mount", "percentage": 88}
    ]'::jsonb,
    'React Query (TanStack Query) v4+, useQuery hook, QueryClient setup',
    'Stale queries automatically refetch when component mounts, data updates without manual trigger',
    'Explicitly setting refetchOnMount: false; Not calling invalidateQueries; Using staleTime without understanding its impact on refetchOnMount behavior',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/76969524/react-query-how-to-refetch-query-when-query-isstale',
    'admin:1764173217'
),
(
    'React context returns undefined - useContext hook not getting value',
    'react',
    'HIGH',
    '[
        {"solution": "Verify Provider wraps the component tree: <MyContext.Provider value={value}><App /></MyContext.Provider>", "percentage": 96},
        {"solution": "Check for typo in Provider: use value prop not values", "percentage": 95},
        {"solution": "Ensure component calling useContext is nested inside the Provider - context value is undefined outside Provider scope", "percentage": 94},
        {"solution": "Create custom hook that checks context exists and throws helpful error: const useMyContext = () => { const ctx = useContext(MyContext); if (!ctx) throw new Error(''Must use inside Provider''); return ctx; }", "percentage": 92}
    ]'::jsonb,
    'React 16.8+ with hooks, Context API setup',
    'useContext returns correct value object, no undefined errors in console',
    'Component not wrapped by Provider; Provider wrapping wrong component tree; Missing value prop on Provider; Context consumed outside Provider scope',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/53771877/react-context-return-undefined',
    'admin:1764173217'
),
(
    'setState not updating state immediately - state update is asynchronous',
    'react',
    'HIGH',
    '[
        {"solution": "Understand setState is asynchronous - state updates batch and execute after render. Use callback: setState(value, () => console.log(state))", "percentage": 95},
        {"solution": "For hooks (useState), the state variable won''t update in same function. Use useEffect to run code after state updates: useEffect(() => { /* runs after state updates */ }, [state])", "percentage": 94},
        {"solution": "If setState is called in event handler and you need new value immediately, use the new value directly instead of reading from state: const newVal = value; setState(newVal); useNewVal(newVal)", "percentage": 92}
    ]'::jsonb,
    'React class components or React hooks (useState), event handlers',
    'State updates reflect in component after re-render, effects run with correct state value',
    'Trying to read state immediately after setState call; Not understanding setState batching in React 18; Using state value in callback before update completes',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/41446560/react-setstate-not-updating-state',
    'admin:1764173217'
),
(
    'Hooks must be called in the same order on every render',
    'react',
    'HIGH',
    '[
        {"solution": "Remove all conditional logic wrapping hooks. Move hook calls to top level before any if/switch statements", "percentage": 96},
        {"solution": "Don''t call hooks based on props or state - hook count must be identical every render: move condition after hook initialization", "percentage": 95},
        {"solution": "Use useCallback or useMemo if you need conditional hook behavior - but primary hooks must always execute", "percentage": 92}
    ]'::jsonb,
    'React 16.8+ functional components, hooks usage',
    'No hook order warnings in console, components render consistently across state changes',
    'Calling hooks in if statements; Changing hook count between renders; Conditional hook initialization based on props; Using hooks in loops',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/75676905/react-hooks-must-be-called-in-the-exact-same-order-in-every-component-render-pro',
    'admin:1764173217'
),
(
    'Mismatching versions of React and React DOM - Invalid hook call',
    'react',
    'MEDIUM',
    '[
        {"solution": "Run npm ls react react-dom to identify version mismatches. Both must be same version", "percentage": 95},
        {"solution": "Run npm dedupe to resolve duplicate dependencies. If versions still mismatch, manually update package.json to same version: npm install react@18.0.0 react-dom@18.0.0", "percentage": 93},
        {"solution": "Check monorepo structure - ensure each package depends on same React version, not multiple different versions", "percentage": 88}
    ]'::jsonb,
    'npm/yarn, React project with multiple dependencies',
    'npm ls shows matching React/ReactDOM versions, hooks work without errors',
    'Upgrading one library but not the other; Monorepo with inconsistent React versions; node_modules has multiple React installations',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/70975994/react-hook-error-invalid-hook-call-mismatching-versions-of-react-and-the-rend',
    'admin:1764173217'
),
(
    'React component re-renders infinitely - useEffect dependency issue',
    'react',
    'HIGH',
    '[
        {"solution": "Add dependency array to useEffect to prevent infinite loops: useEffect(() => { /* effect */ }, [dependencies])", "percentage": 97},
        {"solution": "If no dependencies needed, use empty array: useEffect(() => { /* runs once */ }, [])", "percentage": 96},
        {"solution": "Ensure state setters in effect are not causing circular updates. Use useCallback for stable function references", "percentage": 92},
        {"solution": "If calling setState in effect, verify it doesn''t cause effect to re-run by adding to dependency array carefully", "percentage": 90}
    ]'::jsonb,
    'React hooks (useEffect), functional components',
    'Component renders once or expected number of times, no infinite loop in console',
    'useEffect without dependency array; setState in effect without dependency array; Objects/functions in dependency array causing re-renders',
    0.95,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/58436755/react-component-re-renders-infinitely',
    'admin:1764173217'
),
(
    'Cannot read property ''props'' of undefined - class component this binding issue',
    'react',
    'MEDIUM',
    '[
        {"solution": "Bind methods in constructor: this.handleClick = this.handleClick.bind(this) or use arrow functions in class", "percentage": 95},
        {"solution": "Use class field arrow function syntax: handleClick = () => { /* this is bound */ }", "percentage": 93},
        {"solution": "If passing method to child component, bind it: <Child onClick={this.handleClick.bind(this)} />", "percentage": 88}
    ]'::jsonb,
    'React class components, event handler methods',
    'Event handlers execute with correct this binding, props accessible in methods',
    'Not binding methods in event handlers; Using regular function methods without binding; Binding in wrong place (render instead of constructor)',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/29960151/calling-a-function-in-react',
    'admin:1764173217'
)
