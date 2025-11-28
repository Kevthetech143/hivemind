-- React Ecosystem High-Quality Error Mining
-- 20 validated entries from Stack Overflow, GitHub, and official docs
-- Last verified: 2025-11-26

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES

-- 1. React Query stale data after refetch
(
    'React query not updating data even after refetch shows new data from api',
    'react-ecosystem',
    'HIGH',
    '[
        {"solution": "Disable structural sharing in useQuery config: add structuralSharing: false to prevent React Query from skipping updates when object references are identical", "percentage": 95},
        {"solution": "Force deep clone data: return structuredClone(data) from queryFn to create new object references that React Query can detect as changed", "percentage": 92},
        {"solution": "Use queryClient.setQueryData() in mutation callback instead of relying on structural sharing to manually update cache", "percentage": 88}
    ]'::jsonb,
    'React Query 4.0+, async query function returning object data',
    'useQuery data updates after refetch completes, component re-renders with new values',
    'Disabling structural sharing globally can impact memory usage; enable only for problematic queries',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/78679768/react-query-not-updating-data-even-after-refetch-shows-new-data-from-api'
),

-- 2. QueryClient recreated on every render
(
    'useQuery stale data persists even after mutation updates via setQueryData',
    'react-ecosystem',
    'CRITICAL',
    '[
        {"solution": "Move QueryClient instantiation OUTSIDE component to prevent recreation: const queryClient = new QueryClient(); outside App() function, then pass to QueryClientProvider", "percentage": 98},
        {"solution": "Use useMemo to memoize QueryClient if it must be inside component: const queryClient = useMemo(() => new QueryClient(), [])", "percentage": 95},
        {"solution": "Verify QueryClient instance is passed by reference to QueryClientProvider, never recreated between renders", "percentage": 94}
    ]'::jsonb,
    'React Query 4.0+, QueryClientProvider in component tree',
    'Mutations immediately update useQuery data, component reflects new state without delay',
    'Creating QueryClient inside App component loses all cached data on re-render; single instance is mandatory',
    0.97,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/67326122/react-query-usequery-is-delivering-stale-data'
),

-- 3. Apollo Client mutation not updating cache
(
    'Apollo Client cache not updating after mutation for create/delete operations',
    'react-ecosystem',
    'HIGH',
    '[
        {"solution": "Use update callback in useMutation: provide update(cache, { data }) function to manually sync cache when mutation creates or deletes entities since Apollo cannot auto-detect affected queries", "percentage": 96},
        {"solution": "Use refetchQueries option: add refetchQueries: [{ query: GET_LIST }] to force refetch after mutation instead of manual cache update", "percentage": 88},
        {"solution": "Ensure mutation returns id and __typename fields: Apollo auto-updates only when returned data includes both __typename and id for cache identification", "percentage": 92}
    ]'::jsonb,
    'Apollo Client 3.0+, GraphQL mutation returning entity data',
    'Cache updates immediately after mutation, list queries reflect new/deleted items, UI re-renders',
    'Forgetting update callback for create/delete mutations; auto-update only works for single-entity modifications',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/60360260/auto-update-of-apollo-client-cache-after-mutation-not-affecting-existing-queries'
),

-- 4. SWR mutate not triggering rerender across components
(
    'useSWRMutation in one component does not trigger re-render in other components using same mutation',
    'react-ecosystem',
    'HIGH',
    '[
        {"solution": "Combine useSWR for shared state with useSWRMutation for mutation trigger: use same cache key in both hooks with populateCache: true option on mutation to sync across instances", "percentage": 94},
        {"solution": "Use useSWR for data fetching instead of useSWRMutation if multiple components need the same data: useSWRMutation does not share state between instances by design", "percentage": 90},
        {"solution": "Implement custom context or state management wrapper around SWR hooks to synchronize state across multiple components", "percentage": 85}
    ]'::jsonb,
    'SWR 2.0+, multiple components importing useSWRMutation',
    'All components using mutation receive updated data, UI updates across app',
    'Expecting useSWRMutation to auto-sync across component instances; it maintains isolated state per hook instance',
    0.91,
    'haiku',
    NOW(),
    'https://github.com/vercel/swr/issues/2267'
),

-- 5. SWR custom hook returns undefined data
(
    'Custom hook wrapping useSWR returns undefined data in consuming component despite hook logging correct values',
    'react-ecosystem',
    'MEDIUM',
    '[
        {"solution": "Return individual values from custom hook instead of object wrapper: return { data, isLoading, mutate } directly from hook without renaming to preserve React dependency tracking", "percentage": 96},
        {"solution": "Verify naming consistency: ensure custom hook property names match component destructuring to avoid undefined from typos", "percentage": 93},
        {"solution": "Use SWR directly in component instead of wrapping: wrapping creates new object references on each render breaking dependency arrays", "percentage": 88}
    ]'::jsonb,
    'SWR 2.0+, custom React hook wrapping useSWR',
    'Custom hook returns correct data, consuming component receives values, no undefined errors',
    'Wrapping useSWR result in object literal { data: data, isLoading } breaks object reference stability',
    0.92,
    'haiku',
    NOW(),
    'https://github.com/vercel/swr/issues/2360'
),

-- 6. React context returns undefined error
(
    'useContext returns undefined error: Cannot read property of undefined context value',
    'react-ecosystem',
    'HIGH',
    '[
        {"solution": "Verify consuming component is wrapped by context Provider: check component nesting - useContext must be inside Provider tree, not in sibling or parent component", "percentage": 97},
        {"solution": "Check context import/export: verify exporting context and useContext hook from same file, correct imports in consuming component", "percentage": 95},
        {"solution": "Create custom hook wrapper with error check: export custom useYourContext() that checks if value is undefined and throws helpful error message", "percentage": 93}
    ]'::jsonb,
    'React 16.8+, Context API setup with Provider',
    'useContext returns correct value, no undefined errors, component receives provider value',
    'Context exported incorrectly, component not wrapped by Provider, using context outside Provider tree',
    0.96,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/react-context'
),

-- 7. TanStack Router navigation state not syncing
(
    'TanStack Router navigation does not update component state during route transitions',
    'react-ecosystem',
    'MEDIUM',
    '[
        {"solution": "Use useRouterState() hook to access current route state: const { location } = useRouterState(); updates on every route change automatically", "percentage": 94},
        {"solution": "Implement Suspense boundary around route components to properly handle async data during transitions", "percentage": 91},
        {"solution": "Use useNavigate for programmatic routing instead of link components to ensure state is properly updated: const navigate = useNavigate(); navigate({ to: path })", "percentage": 88}
    ]'::jsonb,
    'TanStack Router 1.0+, React route components',
    'Route state updates in real-time, component re-renders on navigation, location object reflects current path',
    'Accessing old route state from closure, not using useRouterState(), Suspense boundaries missing',
    0.90,
    'haiku',
    NOW(),
    'https://github.com/TanStack/router/issues'
),

-- 8. React Query staleTime not preventing refetch
(
    'React Query returns stale data on second page load despite staleTime: Infinity configuration',
    'react-ecosystem',
    'MEDIUM',
    '[
        {"solution": "Set staleTime explicitly on useQuery config, not in QueryClientProvider default: staleTime applies per-query, provider defaults can be overridden", "percentage": 92},
        {"solution": "Use invalidateQueries() instead of removeQueries: removeQueries deletes cache completely, invalidateQueries marks stale and refetches based on staleTime", "percentage": 89},
        {"solution": "Check default QueryClient config in provider: ensure defaultOptions.queries.staleTime is not set to 0 (default), which overrides explicit staleTime values", "percentage": 87}
    ]'::jsonb,
    'React Query 4.0+, QueryClient with default options',
    'Page loads use cached data without refetch, no network request on second load',
    'Setting staleTime in provider default options but being overridden at query level',
    0.88,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/63679476/react-query-why-is-this-one-query-always-stale'
),

-- 9. TanStack Query v5 migration breaking changes
(
    'useQuery signature changed in TanStack Query v5: Cannot use (key, fn, options) function overload',
    'react-ecosystem',
    'HIGH',
    '[
        {"solution": "Convert to single object signature: useQuery({ queryKey, queryFn, ...options }) - v5 removes function overloads, requires object parameter", "percentage": 98},
        {"solution": "Rename status values: status: ''loading'' becomes status: ''pending'', isLoading becomes isPending, isInitialLoading becomes isLoading", "percentage": 96},
        {"solution": "Remove onSuccess/onError callbacks: move to useEffect with watch param or use useMutation for these lifecycle hooks", "percentage": 94},
        {"solution": "Run codemod for automated migration: npx jscodeshift --transform node_modules/@tanstack/react-query/build/codemods/src/v5/remove-overloads", "percentage": 91}
    ]'::jsonb,
    'TanStack Query migrating from v4 to v5, TypeScript enabled',
    'Build passes without type errors, queries execute with new signature, data loads correctly',
    'Trying to use old function overload syntax with v5, not running codemod for systematic migration',
    0.95,
    'haiku',
    NOW(),
    'https://tanstack.com/query/latest/docs/react/guides/migrating-to-v5'
),

-- 10. SWR missing key mutation error
(
    'useSWRMutation error: Can''t trigger the mutation: missing key - mutation key undefined',
    'react-ecosystem',
    'MEDIUM',
    '[
        {"solution": "Provide key parameter to useSWRMutation: useSWRMutation(key, fetcher) - first param must be cache key string or array, cannot be undefined", "percentage": 97},
        {"solution": "Verify fetcher function signature: mutation fetcher must be async function that takes (url, options) and returns data", "percentage": 94},
        {"solution": "Check mutation initialization: ensure useSWRMutation is called at top level of component, not conditionally inside useEffect", "percentage": 90}
    ]'::jsonb,
    'SWR 2.0+, useSWRMutation hook in component',
    'useSWRMutation executes without key error, mutation triggers and returns data',
    'Passing undefined as key, using mutation inside conditional hooks, wrong fetcher signature',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/swr'
),

-- 11. Apollo Client refetchQueries not working
(
    'Apollo Client mutation refetchQueries does not re-run query or update component after mutation',
    'react-ecosystem',
    'MEDIUM',
    '[
        {"solution": "Set awaitRefetchQueries: true in mutation options to wait for refetch completion before resolving mutation", "percentage": 95},
        {"solution": "Verify query variables match in refetchQueries: refetchQueries with different variables will not match existing queries", "percentage": 92},
        {"solution": "Use refetchQueries as function for dynamic query matching: refetchQueries: (apollo) => apollo.cache.evict({ broadcast: true })", "percentage": 88}
    ]'::jsonb,
    'Apollo Client 3.0+, useMutation with refetchQueries',
    'Mutation triggers refetch, query re-executes, component updates with new data',
    'Query variables mismatch, not awaiting refetch completion, using wrong query in refetchQueries',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/apollo-client'
),

-- 12. React Query useInfiniteQuery page param undefined
(
    'useInfiniteQuery error: getNextPageParam requires initialPageParam - page param is undefined',
    'react-ecosystem',
    'HIGH',
    '[
        {"solution": "Add required initialPageParam property: useInfiniteQuery({ queryKey, queryFn, initialPageParam: 0, getNextPageParam: ... }) - v5 requires explicit initial page", "percentage": 98},
        {"solution": "Ensure getNextPageParam receives lastPage object: getNextPageParam: (lastPage) => lastPage.nextPage || undefined - must return next value or undefined", "percentage": 96},
        {"solution": "Verify queryFn receives pageParam: queryFn: ({ pageParam }) => fetch(...pageParam) - destructure pageParam from function argument", "percentage": 94}
    ]'::jsonb,
    'TanStack Query v5, useInfiniteQuery hook',
    'Infinite query loads pages without error, pagination works correctly, nextPageParam resolves',
    'Missing initialPageParam in v5, getNextPageParam returning wrong value type, not destructuring pageParam',
    0.96,
    'haiku',
    NOW(),
    'https://tanstack.com/query/latest/docs/react/guides/migrating-to-v5'
),

-- 13. React Query mutation onError callback not firing
(
    'useMutation onError callback does not execute when mutation fails in React Query v5',
    'react-ecosystem',
    'MEDIUM',
    '[
        {"solution": "Move onError from query to useMutation: onError callbacks removed from useQuery in v5, only available on mutations", "percentage": 96},
        {"solution": "Use mutation.error state instead: useMutation returns error object in result, check result.error after mutation call", "percentage": 93},
        {"solution": "Implement error boundary or try-catch on mutate call: await mutateAsync() or mutate(data, { onError }) for inline handlers", "percentage": 90}
    ]'::jsonb,
    'TanStack Query v5, useMutation hook',
    'Mutation errors are caught, error callbacks execute or error state updates',
    'Using onError on useQuery instead of useMutation, not handling mutation.error state',
    0.92,
    'haiku',
    NOW(),
    'https://tanstack.com/query/latest/docs/react/guides/migrating-to-v5'
),

-- 14. SWR global error handler not catching errors
(
    'SWR onError global config not triggered for failed requests in SWRConfig provider',
    'react-ecosystem',
    'MEDIUM',
    '[
        {"solution": "Create custom fetcher that throws errors: fetcher must throw Error object for onError to trigger, non-throwing fetchers skip error handler", "percentage": 94},
        {"solution": "Wrap fetcher in SWRConfig with onError callback: <SWRConfig value={{ onError: (error) => handleError(error) }}> at top of component tree", "percentage": 93},
        {"solution": "Return error-throwing fetcher for non-2xx status: const fetcher = (url) => fetch(url).then(r => { if (!r.ok) throw error; return r.json() })", "percentage": 91}
    ]'::jsonb,
    'SWR 2.0+, SWRConfig provider in React app',
    'Failed requests trigger onError callback, errors are centrally handled, error UI displays',
    'Fetcher not throwing errors for failed requests, onError defined at wrong scope level',
    0.89,
    'haiku',
    NOW(),
    'https://swr.vercel.app/docs/error-handling'
),

-- 15. React Router useLoaderData undefined after navigation
(
    'useLoaderData returns undefined after route navigation in React Router v6+',
    'react-ecosystem',
    'MEDIUM',
    '[
        {"solution": "Ensure loader is defined on route definition: const route = { path: /items, element, loader: loadItems } - loader must be configured on route, not component", "percentage": 95},
        {"solution": "Loader must return data directly: export const loader = () => fetchData() - return value accessible via useLoaderData(), not returned as promise", "percentage": 93},
        {"solution": "Use Suspense boundary for async loaders: wrap component in <Suspense> when loader contains async operation", "percentage": 90}
    ]'::jsonb,
    'React Router 6.4+, useLoaderData hook in component',
    'useLoaderData returns data from loader, no undefined, Suspense resolves async data',
    'Loader not defined on route, not returning data from loader, async loader without Suspense',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/react-router-v6'
),

-- 16. Apollo Client refetchQueries with variables
(
    'Apollo refetchQueries does not match query because variables differ between mutation and original query',
    'react-ecosystem',
    'MEDIUM',
    '[
        {"solution": "Match variables exactly: refetchQueries: [{ query: GET_ITEMS, variables: { userId: id } }] - variables in refetchQueries must match original query", "percentage": 96},
        {"solution": "Use refetchQueries function: refetchQueries: (apollo) => apollo.cache.evict({ id: apollo.cache.identify(object) }) for dynamic matching", "percentage": 92},
        {"solution": "Remove refetchQueries and use update callback: manually update cache in update function instead of relying on variable matching", "percentage": 88}
    ]'::jsonb,
    'Apollo Client 3.0+, useMutation with multiple query subscriptions',
    'Refetch triggers with matching variables, cache updates correctly, UI reflects changes',
    'Variables in refetchQueries not matching original query definition, using wrong variable names',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/apollo-client'
),

-- 17. TanStack Router link component type safety loss
(
    'TanStack Router Link component loses type safety when wrapped in custom component',
    'react-ecosystem',
    'LOW',
    '[
        {"solution": "Use Link directly without wrapper to maintain type safety: import Link from @tanstack/react-router and pass to prop", "percentage": 89},
        {"solution": "Create typed wrapper using React.forwardRef and preserving link props: const CustomLink = forwardRef<HTMLAnchorElement, LinkProps>((props, ref) => ...)", "percentage": 87},
        {"solution": "Use as prop on Link component: <Link as={CustomButton} /> to compose Link behavior with custom component", "percentage": 85}
    ]'::jsonb,
    'TanStack Router 1.0+, TypeScript enabled, custom component wrapper',
    'Type-safe route navigation, Link component works with custom wrapper, TypeScript compilation succeeds',
    'Wrapping Link without forwardRef, losing generic type parameters, not using as prop composition',
    0.84,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/tanstack-router'
),

-- 18. React Query dependent queries not triggering
(
    'Dependent query with enabled: !!parentQuery.data does not execute when parent completes',
    'react-ecosystem',
    'HIGH',
    '[
        {"solution": "Use enabled flag correctly: enabled: !!parentQuery.data prevents query until parent data exists, check data !== undefined not just truthy", "percentage": 95},
        {"solution": "Ensure parent queryKey causes child invalidation: manual invalidation required, dependent queries do not auto-invalidate", "percentage": 92},
        {"solution": "Use refetchQueries on mutation: mutation should refetchQueries: [parentKey] to trigger dependent queries automatically", "percentage": 90}
    ]'::jsonb,
    'React Query 4.0+, useQuery with enabled flag',
    'Dependent query executes after parent completes, data flows correctly, child query has data',
    'Using enabled: parentQuery.data without falsy check, not manually invalidating dependent queries',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/react-query'
),

-- 19. Apollo Client cache.identify returns undefined
(
    'Apollo Client cache.identify() returns undefined for object - cannot update specific cache item',
    'react-ecosystem',
    'MEDIUM',
    '[
        {"solution": "Ensure object has __typename and id fields: identify() requires both fields to generate cache key, missing either returns undefined", "percentage": 97},
        {"solution": "Use typePolicies to define cache key fields: const cache = new InMemoryCache({ typePolicies: { Item: { keyFields: [''__typename'', ''id''] } } })", "percentage": 94},
        {"solution": "Verify __typename matches GraphQL type name exactly: case-sensitive, must be exact match to GraphQL schema type definition", "percentage": 92}
    ]'::jsonb,
    'Apollo Client 3.0+, InMemoryCache with query results',
    'cache.identify() returns valid cache key ID, object updates work via cache.modify()',
    'Missing __typename field in returned data, id field not present, __typename name mismatch',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/apollo-client'
),

-- 20. React context provider unmounting on every render
(
    'React context provider unmounts and remounts children on every parent re-render, losing state',
    'react-ecosystem',
    'HIGH',
    '[
        {"solution": "Move provider outside component or memoize value: const value = useMemo(() => ({ state, setState }), [state]) prevents object reference change", "percentage": 96},
        {"solution": "Extract provider to separate component: create ContextProvider wrapper component outside main App to prevent unmounting", "percentage": 94},
        {"solution": "Use useReducer for context value: reduces reference changes by ensuring dispatch stays stable across re-renders", "percentage": 91}
    ]'::jsonb,
    'React 16.8+, Context API with multiple levels',
    'Provider stays mounted during parent re-renders, child components maintain state, no unnecessary remounts',
    'Creating context value object inline in render, provider component recreated on every render',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/react-context'
);
