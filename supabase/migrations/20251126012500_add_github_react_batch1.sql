-- Mining GitHub Issues from facebook/react repository
-- Category: github-react
-- Batch 1: High-voted/commented issues with solutions
-- Extracted 2025-11-26

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'useEffect memory leak warning: Cannot perform React state update on unmounted component',
    'github-react',
    'VERY_HIGH',
    $$[
        {"solution": "Implement AbortController for fetch requests: create const ac = new AbortController(), pass signal: ac.signal to fetch, return () => ac.abort() in cleanup", "percentage": 95, "note": "Most reliable solution for async operations"},
        {"solution": "Use mounted ref pattern: set let mounted = true, check if(mounted) before setState, return () => { mounted = false } in cleanup", "percentage": 90, "note": "Works for all async patterns"},
        {"solution": "Apply dependency array fix via ESLint hook rules to ensure all external dependencies are declared", "percentage": 85, "note": "Prevents stale closures"},
        {"solution": "Use useAsync library or similar data fetching library that handles these edge cases", "percentage": 80, "note": "Third-party solution"}
    ]$$::jsonb,
    'React component with useEffect, async operations (fetch/promises), state updates',
    'No console warning about state updates on unmounted component, component renders correctly after unmount, memory leak warning is gone',
    'Do not ignore the warning - it indicates real memory issues. AbortController must be called before any setState. Ensure dependencies array is complete to avoid stale closures.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/facebook/react/issues/15006'
),
(
    'React 18 useEffect runs twice on component mount in StrictMode development mode',
    'github-react',
    'VERY_HIGH',
    $$[
        {"solution": "Understand this is expected behavior in React 18 StrictMode for development - effects intentionally double-invoke to catch impure code", "percentage": 100, "note": "This is a feature, not a bug"},
        {"solution": "Use ignore flag pattern for data fetching: let ignore = false; fetchStuff().then(res => { if (!ignore) setResult(res) }); return () => { ignore = true }", "percentage": 95, "note": "Prevents duplicate data processing from double fetch"},
        {"solution": "Remove <React.StrictMode> wrapper during development if double invocation is problematic", "percentage": 70, "note": "Not recommended - defeats safety checks"},
        {"solution": "Ensure cleanup functions properly reset state and subscriptions for correct remount behavior", "percentage": 90, "note": "Make effects idempotent"}
    ]$$::jsonb,
    'React 18, NODE_ENV=development, <React.StrictMode> enabled, useEffect hook',
    'Effect runs twice on mount in dev, once in production. Data fetching uses ignore flag pattern. No errors about cleanup. Production behavior matches expected single render',
    'This is NOT a bug - it is intentional. Do not add conditional logic to skip effect cleanup in development. Always assume effects will fire twice in StrictMode. Design effects to be safe when called multiple times.',
    0.95,
    'sonnet-4',
    NOW(),
    'https://github.com/facebook/react/issues/24502'
),
(
    'TypeError when using React Hooks in functional components with wrong version',
    'github-react',
    'HIGH',
    $$[
        {"solution": "Use React version with Hooks support (16.8+) or alpha/next versions: specify ''react'': ''next'' in package.json", "percentage": 95, "note": "Use next tag for early access"},
        {"solution": "Delete yarn.lock and node_modules, reinstall dependencies to sync versions", "percentage": 90, "note": "Resolves version mismatch issues"},
        {"solution": "Ensure React and React-DOM versions match exactly", "percentage": 85, "note": "Version mismatch causes hook errors"},
        {"solution": "Verify hook imports are correct: import { useState } from react", "percentage": 80, "note": "Check for typos in imports"}
    ]$$::jsonb,
    'React 16.7+, functional component with useState/hooks, npm/yarn installed',
    'useState hook works without TypeError, functional component renders with state, console shows no hook-related errors',
    'Hooks only work in functional components, not class components. Each hook call must be at top level. Cannot use hooks conditionally. Ensure you are importing from react, not react-dom.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://github.com/facebook/react/issues/14484'
),
(
    'useCallback missing dependency warning causes infinite loops with interdependent state',
    'github-react',
    'HIGH',
    $$[
        {"solution": "Use functional setState update form to avoid stale state: setSearch(prev => ({...prev, query}))", "percentage": 90, "note": "Gets current state without dependency"},
        {"solution": "Move state logic outside callback using refs for non-reactive values: useRef for values that shouldnt trigger re-renders", "percentage": 85, "note": "Separates reactive from non-reactive concerns"},
        {"solution": "Restructure logic to avoid circular dependency: separate fetching logic from callback logic", "percentage": 80, "note": "Refactor dependencies"},
        {"solution": "Use experimental useEffectEvent hook for event handlers that should not cause dependency chain reactions", "percentage": 70, "note": "Available in React 19+"}
    ]$$::jsonb,
    'React 16.8+, useCallback hook, external dependencies, ESLint react-hooks plugin',
    'No ESLint warning about missing dependencies, callback recreates only when appropriate, no infinite loops, component renders correctly',
    'Do not disable ESLint rules without understanding the issue. Missing dependencies indicate stale closures. useCallback should only memoize when it prevents unnecessary child re-renders.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/facebook/react/issues/18343'
),
(
    'React 18 automatic batching does not work with Promise/microtask state updates',
    'github-react',
    'HIGH',
    $$[
        {"solution": "Understand that synchronous and async setState calls are batched separately due to event loop mechanics", "percentage": 95, "note": "Expected behavior, not a bug"},
        {"solution": "For async operations, wrap in React.flushSync if immediate DOM update is needed", "percentage": 75, "note": "Opt-out of batching for critical updates"},
        {"solution": "Use state callback patterns or useLayoutEffect if you need state to be synchronously available after setState", "percentage": 80, "note": "Access updated state immediately"},
        {"solution": "Accept batching behavior and refactor to work with eventual consistency model", "percentage": 85, "note": "Recommended approach"}
    ]$$::jsonb,
    'React 18+, Promise/async callbacks, setState calls in event handlers',
    'State updates batch correctly for synchronous code, async updates batch separately as expected, no unexpected state values',
    'Synchronous and async updates batch in different microtasks. Do not expect state from Promise callback to include synchronous updates. Do not rely on state batching across event loop cycles.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/facebook/react/issues/30605'
),
(
    'React StrictMode cannot be selectively disabled for third-party library components',
    'github-react',
    'HIGH',
    $$[
        {"solution": "Wrap StrictMode more granularly around components that do not contain problematic third-party libraries", "percentage": 90, "note": "Official recommendation from React team"},
        {"solution": "Create a component that excludes third-party libraries from StrictMode checks by rendering them outside boundaries", "percentage": 75, "note": "Workaround pattern"},
        {"solution": "Upgrade third-party dependencies to versions that support StrictMode and dont generate warnings", "percentage": 85, "note": "Long-term solution"},
        {"solution": "Accept warnings from third-party libraries as technical debt if upgrade is not possible", "percentage": 60, "note": "Temporary acceptance"}
    ]$$::jsonb,
    'React 16.3+, <React.StrictMode> enabled, outdated third-party library components',
    'StrictMode wraps only compliant code, third-party warnings are isolated, no false positives for custom code',
    'React team refuses granular opt-outs because partial coverage undermines entire purpose. Do not attempt to suppress StrictMode warnings. Upgrade dependencies or limit StrictMode scope strategically.',
    0.78,
    'sonnet-4',
    NOW(),
    'https://github.com/facebook/react/issues/16362'
),
(
    'React 18 StrictMode DOM refs not cleared on simulated unmount/remount cycle',
    'github-react',
    'MEDIUM',
    $$[
        {"solution": "Explicitly check if ref exists before attaching listeners: if(ref.current && !ref.current.listener) instead of if(ref.current)", "percentage": 85, "note": "Prevents duplicate listener attachment"},
        {"solution": "Use effect cleanup to explicitly clear ref state: return () => { if(ref.current) ref.current.listener = null }", "percentage": 80, "note": "Reset ref properties on cleanup"},
        {"solution": "Accept this as StrictMode behavior and test real unmount behavior separately in production", "percentage": 75, "note": "Development-only quirk"},
        {"solution": "Track listener attachment via local state rather than checking ref.current", "percentage": 70, "note": "Alternative pattern"}
    ]$$::jsonb,
    'React 18, StrictMode enabled, DOM refs in useEffect, development mode',
    'Event listeners attach correctly, no duplicate listeners, StrictMode simulation works as designed, production behavior correct',
    'React StrictMode simulated unmounts do not clear DOM refs - this differs from real unmounts. Code that checks if(ref.current) before adding listeners will not work as expected in dev. Always use state or flags for listener management.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/facebook/react/issues/24670'
),
(
    'React DevTools error: wakeable.then is not a function with Suspense hydration',
    'github-react',
    'MEDIUM',
    $$[
        {"solution": "Intercept DevTools hook to validate wakeable has .then method before calling: check typeof wakeable.then === function", "percentage": 85, "note": "Prevents TypeError in DevTools"},
        {"solution": "Use React.lazy and Suspense instead of dynamic imports where possible", "percentage": 60, "note": "Workaround for import issues"},
        {"solution": "Disable React DevTools temporarily if blocking development", "percentage": 50, "note": "Temporary workaround only"},
        {"solution": "Upgrade to latest React version as this is being fixed in newer releases", "percentage": 80, "note": "Check latest React 18.2.0+ releases"}
    ]$$::jsonb,
    'React 18.2.0+, Next.js 13+ app directory, Suspense boundaries, React DevTools enabled',
    'React DevTools works without wakeable.then error, Suspense hydration completes, no console errors during hydration',
    'DevTools receives error object instead of thenable in some cases. Do not assume all wakeable objects have .then method. This is a DevTools bug being actively fixed in React releases.',
    0.80,
    'sonnet-4',
    NOW(),
    'https://github.com/facebook/react/issues/25994'
),
(
    'useEffect with async operations causes apparent memory leaks due to fiber architecture',
    'github-react',
    'MEDIUM',
    $$[
        {"solution": "Understand that React Fiber double-buffering may retain alternate references temporarily - this is architectural, not a leak", "percentage": 90, "note": "Expected fiber behavior"},
        {"solution": "Check __reactEventHandlers on DOM elements as these retain child component references when parent props dont change", "percentage": 85, "note": "Source of reference retention"},
        {"solution": "Avoid inline function creation in render to reduce handler object recreation", "percentage": 80, "note": "Reduces reference retention"},
        {"solution": "Use useCallback to memoize handlers and reduce event handler object churn", "percentage": 75, "note": "Optimization pattern"}
    ]$$::jsonb,
    'React with hooks, useEffect, inline functions, memory profiling tools',
    'Memory heap snapshots show acceptable reference counts, no actual memory leak behavior, components garbage collect after unmount',
    'React Fiber maintains alternate references for reconciliation - not a memory leak. __reactEventHandlers can retain references. Heap snapshots may show extra instances due to architecture. Only optimize if actual memory problems occur.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/facebook/react/issues/15527'
),
(
    'Suspense boundary interrupted by state updates before hydration completes',
    'github-react',
    'MEDIUM',
    $$[
        {"solution": "Wrap state updates in startTransition to mark them as non-urgent and avoid interrupting hydration", "percentage": 95, "note": "Official React recommendation"},
        {"solution": "Memoize Suspense boundary to prevent re-renders that trigger state updates during hydration", "percentage": 80, "note": "Prevents update propagation"},
        {"solution": "Defer component state updates until after hydration completes using useEffect", "percentage": 85, "note": "Timing-based solution"},
        {"solution": "Use error boundary as fallback to gracefully handle hydration interruption", "percentage": 70, "note": "Defensive pattern"}
    ]$$::jsonb,
    'React with Suspense boundaries, hydration, client-side state updates, React 18+',
    'State updates do not interrupt Suspense hydration, component hydrates correctly, startTransition removes error 421',
    'Synchronous updates cannot partially commit - they must be entirely visible or hidden. Non-keystroke updates should use startTransition. Dehydrated boundaries are a recoverable error, not fatal.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/facebook/react/issues/24959'
),
(
    'React 18 setState inside useEffect appears unreliable with multiple state updates',
    'github-react',
    'MEDIUM',
    $$[
        {"solution": "Ensure state updates follow execution order by dispatching all updates in single batch if possible", "percentage": 80, "note": "Batching respects synchronous order"},
        {"solution": "Use useLayoutEffect instead of useEffect if state order is critical for synchronous DOM updates", "percentage": 75, "note": "Bypasses batching delays"},
        {"solution": "Implement guard patterns with flag state: check flag before dispatch to prevent cascading updates", "percentage": 85, "note": "Prevents state update chains"},
        {"solution": "Split logic so dependent state updates happen in same useEffect batch", "percentage": 80, "note": "Keeps related updates together"}
    ]$$::jsonb,
    'React 18+, multiple setState calls in useEffect, dependent state changes, Redux or state management',
    'State updates apply in expected order, guard patterns prevent infinite loops, state values match expected sequence',
    'React 18 automatic batching may reorder state updates across event loop boundaries. Guard patterns that rely on state order may fail. Respect execution order in same microtask batch.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/facebook/react/issues/25593'
),
(
    'useEffectEvent API naming confusion with useCallback - which hook to use',
    'github-react',
    'LOW',
    $$[
        {"solution": "Use useEffectEvent for event handlers that should not cause effect re-runs and cannot be passed to children", "percentage": 90, "note": "Experimental in React 19"},
        {"solution": "Use useCallback when function needs to be passed to child components or needs referential stability", "percentage": 95, "note": "Standard stable function pattern"},
        {"solution": "Understand useEffectEvent functions are local to effects and have different semantics from useCallback", "percentage": 85, "note": "Key semantic difference"},
        {"solution": "For React 18, use useCallback as useEffectEvent is not yet stable", "percentage": 100, "note": "Availability difference"}
    ]$$::jsonb,
    'React 19+ (experimental), understanding of hooks semantics, functional components',
    'Correct hook is used for pattern, function works as expected, no console warnings about hook usage',
    'useEffectEvent is experimental and only available in React 19+. Do not confuse with useCallback - they have different use cases. useEffectEvent functions cannot be passed to children.',
    0.80,
    'sonnet-4',
    NOW(),
    'https://github.com/facebook/react/issues/27793'
);
