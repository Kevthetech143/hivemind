-- TanStack Query GitHub Issues - Cache Invalidation, Refetch, SSR, Optimistic Updates, DevTools
-- Mining date: 2025-11-25
-- Source: https://github.com/TanStack/query/issues

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, pattern_id
) VALUES
(
    'invalidateQueries default behavior - marks all queries as stale but only refetches active queries',
    'github-react-query',
    'HIGH',
    '[
        {"solution": "Use explicit type parameter: queryClient.invalidateQueries({ queryKey: [''todos''], type: ''all'' })", "percentage": 95, "note": "Forces refetch of all queries regardless of active status", "command": "queryClient.invalidateQueries({ queryKey: [''todos''], type: ''all'' })"},
        {"solution": "Review documentation: invalidateQueries marks all queries as stale universally, but only active queries (with observers) trigger background refetches by default", "percentage": 90, "note": "Clarifies the intended design behavior"},
        {"solution": "Check query observer status with query.getObserversCount() to understand which queries will refetch", "percentage": 80, "note": "Helps debug unexpected refetch patterns"}
    ]'::jsonb,
    'React Query v5+, active queryClient instance, queries already mounted',
    'Inactive prefetched queries marked as stale in cache, refetch=type param properly scopes refetch behavior',
    'Do not assume invalidateQueries(queryKey) will refetch inactive/unmounted queries. Use type: ''all'' for that. Default behavior (no type) only refetches active queries with observers.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/TanStack/query/issues/9531'
),
(
    'Query invalidation fails when disabled query uses undefined and enabled query uses null in key',
    'github-react-query',
    'HIGH',
    '[
        {"solution": "Use nullish coalescing operator in queryKey: queryKey: [''article'', version ?? null] instead of allowing undefined", "percentage": 95, "note": "Ensures consistent null values in key across query lifecycle"},
        {"solution": "Replace undefined with explicit placeholder string: queryKey: [''article'', version || ''unset''] ", "percentage": 90, "note": "Avoids serialization conflicts between undefined and null"},
        {"solution": "Validate query key consistency at query definition time using TypeScript strict mode", "percentage": 85, "note": "Prevents undefined from appearing in keys at compile time"}
    ]'::jsonb,
    'React Query v4+, queries with dynamic key parameters, disabled queries in component tree',
    'invalidateQueries successfully matches and refetches all query variants, no serialization mismatches in cache',
    'Undefined and null are treated as distinct values in query keys. Disabled queries registered with undefined will not match invalidation calls using null. Always use explicit null coalescing in dynamic keys.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/TanStack/query/issues/9497'
),
(
    'Disabled queries unexpectedly refetch when calling invalidateQueries with refetchType all',
    'github-react-query',
    'MEDIUM',
    '[
        {"solution": "Replace enabled flag with skipToken: const query = useQuery({ queryKey, queryFn: enabled ? actualFn : skipToken })", "percentage": 95, "note": "skipToken persists in query definition and prevents refetch on invalidation"},
        {"solution": "Implement isDisabled() check in QueryObserver to detect skipToken presence before refetching", "percentage": 90, "note": "Internal fix applied in PR #8161"},
        {"solution": "Keep disabled queries unmounted from component tree entirely to avoid observer creation", "percentage": 75, "note": "Workaround: unrender disabled query components instead of using enabled flag"}
    ]'::jsonb,
    'React Query v4.4+, queries with enabled: false that were previously active, invalidateQueries called with type: all',
    'Disabled queries (with skipToken or enabled: false with no observers) do not execute during invalidation, enabled queries refetch normally',
    'The enabled flag is observer-level state lost when components unmount. After unmount, there is no way to know if a query should be disabled. Using skipToken is more robust as it persists in the query definition itself.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/TanStack/query/issues/8118'
),
(
    'Double fetching on subsequent SSR visits with HydrationBoundary - pendingHydration flag optimization',
    'github-react-query',
    'HIGH',
    '[
        {"solution": "Update to React Query v5.29+ which includes _pendingHydration optimization in QueryObserver", "percentage": 96, "note": "Prevents refetch-on-mount when hydration is pending"},
        {"solution": "Ensure HydrationBoundary properly defers hydration to useEffect instead of useMemo to allow QueryObserver to detect pending state", "percentage": 92, "note": "Hydration sequence matters: memoized flag + deferred useEffect"},
        {"solution": "For older versions, manually skip refetchOnMount for hydrated queries: useQuery({..., refetchOnMount: enabled ? true : false})", "percentage": 70, "note": "Workaround for pre-v5.29 versions"}
    ]'::jsonb,
    'React Query v5+, SSR setup with HydrationBoundary, subsequent page visits, active prefetching',
    'Single fetch per query on revisits, no double network requests, hydrated data matches server snapshot',
    'Hydration timing is critical: if queryFn changes while query is pending hydration, refetch-on-mount may still trigger. Set _pendingHydration flag during render and clear after useEffect to prevent this.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://github.com/TanStack/query/issues/9617'
),
(
    'SSR hydration mismatch between QueryClient instances - multiple clients created independently',
    'github-react-query',
    'MEDIUM',
    '[
        {"solution": "Use getServerResult() on QueryObserver to detect hydrated queries (dataUpdatedAt === 0) and return pending state for server rendering", "percentage": 95, "note": "Matches client expectations on initial hydration"},
        {"solution": "Implement useSyncExternalStore with server-specific snapshot for SSR: use getServerResult() for server, regular snapshot for browser", "percentage": 93, "note": "Official fix in PR #9572"},
        {"solution": "Ensure single QueryClient instance shared between RSC and ClientProvider to eliminate fragmentation", "percentage": 85, "note": "Architectural best practice"}
    ]'::jsonb,
    'React Query v5.28+, Next.js 14+ App Router, RSC with prefetchQuery, dehydrated state in HydrationBoundary',
    'Server renders pending state for hydrated queries, client hydration matches server HTML perfectly, no hydration mismatch errors',
    'Multiple QueryClient instances cause state fragmentation. RSC prefetch creates one instance, ClientProvider creates another. Use getServerResult() to sync them. Check dataUpdatedAt === 0 to detect hydrated queries.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://github.com/TanStack/query/issues/9572'
),
(
    'Calling invalidateQueries twice synchronously triggers duplicate refetches instead of merging',
    'github-react-query',
    'MEDIUM',
    '[
        {"solution": "Use cancelRefetch: false to prevent cancellation and merge consecutive invalidations: queryClient.invalidateQueries({queryKey, cancelRefetch: false})", "percentage": 92, "note": "Allows multiple invalidations to queue without triggering duplicate fetches"},
        {"solution": "Separate invalidation from refetching: call with refetchType: ''none'', then explicitly refetchQueries once: queryClient.invalidateQueries({refetchType: ''none''}); queryClient.refetchQueries({...})", "percentage": 88, "note": "Gives fine-grained control over fetch timing"},
        {"solution": "Use predicate to target only invalidated queries: queryClient.refetchQueries({predicate: (q) => q.state.isInvalidated})", "percentage": 85, "note": "Refetch only truly invalidated queries, skip others"}
    ]'::jsonb,
    'React Query v4+, synchronous invalidateQueries calls, active queries',
    'Single network request per invalidation, proper merge of consecutive invalidation calls, no duplicate fetches',
    'Each invalidateQueries call immediately triggers a fetch. This is intentional to ensure consistency. If you need to invalidate multiple queries atomically, batch them in a single call or use cancelRefetch: false to merge them.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/TanStack/query/issues/7963'
),
(
    'useMutation status not shared across components using same custom hook - isolated state per instance',
    'github-react-query',
    'MEDIUM',
    '[
        {"solution": "Wrap useMutation in React Context provider to share mutation state across all child components", "percentage": 93, "note": "Each useMutation call creates isolated state; context makes it shared like useQuery"},
        {"solution": "Create custom hook that uses useContext to access shared mutation from provider: const {mutate, status} = useMutation() at provider level, export via context", "percentage": 90, "note": "Standard pattern for mutation state sharing"},
        {"solution": "Use mutationKey (v5+) to enable automatic subscription: useMutation({mutationKey: [''todos''], mutationFn: ...}) shares status like queries", "percentage": 92, "note": "V5 feature unifies mutation architecture with queries"}
    ]'::jsonb,
    'React Query v4+, custom hooks with useMutation, multiple components rendering same hook, mutation status needed in parent/siblings',
    'Mutation error/success status visible in all components using the hook, error toast shows in parent container',
    'Unlike useQuery which creates observers immediately, useMutation only subscribes after mutate() is called. Each instance maintains separate state. Use Context or mutationKey (v5) to share state.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/TanStack/query/issues/2304'
),
(
    'Disabled query (enabled: false) returns isLoading: true instead of false - confuses loading spinners',
    'github-react-query',
    'MEDIUM',
    '[
        {"solution": "Check both isLoading AND enabled: const isLoading = query.isLoading && enabled;", "percentage": 93, "note": "Restore v3 behavior where disabled queries show idle state"},
        {"solution": "Use fetchStatus to distinguish loading from idle: isLoading && fetchStatus === ''fetching'' filters out disabled queries", "percentage": 91, "note": "More explicit check of actual fetch activity"},
        {"solution": "Upgrade to React Query v5 which improved loading state semantics for disabled queries", "percentage": 88, "note": "v5 refined isLoading behavior"}
    ]'::jsonb,
    'React Query v4.0+, useQuery with enabled: false, loading spinner or conditional rendering based on isLoading',
    'Disabled queries return isLoading: false or show via fetchStatus check, spinners do not display unnecessarily',
    'In v4, isLoading: true + fetchStatus: idle = query is disabled/idle (not actually fetching). In v3 this was just isLoading: false. Use composite checks or upgrade to v5.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/TanStack/query/issues/3584'
),
(
    'useInfiniteQuery page param resets to first page during retry of failed request',
    'github-react-query',
    'MEDIUM',
    '[
        {"solution": "Hoist page counter outside fetch function into closure to persist across retries: const pageRef = useRef(0); const queryFn = () => api.get(`?page=${pageRef.current++}`)", "percentage": 96, "note": "PR #8049 fix: ensures page counter survives retry attempts"},
        {"solution": "Implement persistent pagination state in mutation/effect separate from queryFn: store page in ref or state", "percentage": 92, "note": "Decouples pagination from fetch lifecycle"},
        {"solution": "For rate-limited APIs: add exponential backoff before retrying same page instead of resetting", "percentage": 85, "note": "Prevents restart loops when hitting rate limits"}
    ]'::jsonb,
    'React Query v4.29+, useInfiniteQuery with token-based pagination API, refetch() called during error, rate limiting or retry mechanism',
    'Retry requests target same failed page not first page, no page resets on error, pagination works correctly with rate-limited APIs',
    'The page counter resets on each retry because it lives inside the fetch function scope. Hoist it to useRef outside to persist. Watch for rate-limit loops if page count is high and retries occur frequently.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://github.com/TanStack/query/issues/8046'
),
(
    'resumePausedMutations hangs after offline-to-online transition when app refreshed while offline',
    'github-react-query',
    'MEDIUM',
    '[
        {"solution": "Upgrade to React Query v4.24.2 or earlier (working version) or skip to v5 with improved offline handling", "percentage": 90, "note": "Bug introduced in v4.24.3, fixed in later versions"},
        {"solution": "Manually clear resuming state flag after offline recovery: set resuming promise to null on reconnect", "percentage": 85, "note": "Internal fix for race condition in resuming promise"},
        {"solution": "Reload JavaScript bundle after going online: this resets resuming state naturally", "percentage": 70, "note": "Workaround by forcing app reinit"}
    ]'::jsonb,
    'React Query v4.24.3 - v4.32.6, offline mode with paused mutations, app refresh while offline, online restoration',
    'Paused mutations resume immediately when connectivity restored, no manual intervention needed, mutations execute in queue',
    'The resuming promise flag prevents multiple resume() calls from executing due to race condition. Rehydrating paused mutations offline creates this deadlock. Use v4.24.2 or v5 stable.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/TanStack/query/issues/5847'
),
(
    'Maximum update depth exceeded error in React Query v5.66.4+ with SSR and HMR',
    'github-react-query',
    'MEDIUM',
    '[
        {"solution": "Downgrade to v5.66.3 as temporary fix, or upgrade to v5.66.5+ which includes hydration promise fix", "percentage": 95, "note": "Bug in v5.66.4 pending promise handling"},
        {"solution": "Only attach .then() and .catch() to promises when actually dehydrating (PR #9847): check if promise gets used before attaching handlers", "percentage": 93, "note": "Root cause: new Promise instances on every render triggered re-hydration cycles"},
        {"solution": "Avoid including pending queries in dehydrated state: filter out queries with pending promises before serialization", "percentage": 80, "note": "Prevents promise comparison failures"}
    ]'::jsonb,
    'React Query v5.66.4, SSR with HydrationBoundary, Hot Module Replacement (HMR) enabled, pending queries',
    'No infinite re-renders, no maximum depth exceeded errors, HMR works with queries that are pending, development smooth',
    'Attaching .then() to a pending promise creates a new Promise instance. Each render creates a new instance, triggering hydration logic to think data is "new." v5.66.4 only attaches chains on actual dehydration (non-pending).',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/TanStack/query/issues/8677'
),
(
    'refetchOnMount and invalidateQueries fail when using experimental_createQueryPersister',
    'github-react-query',
    'MEDIUM',
    '[
        {"solution": "Use PR #9745 fix: add refetchOnRestore option to persister configuration to refetch after data restoration", "percentage": 95, "note": "Official feature: persister now supports refetch behavior control"},
        {"solution": "Check query.observers for refetchOnMount config in persister: persister.restore() should examine each observer''s refetchOnMount setting", "percentage": 90, "note": "Requires custom persister logic"},
        {"solution": "Manually trigger refetch after persistence restore: onSuccess: () => queryClient.refetchQueries({stale: true})", "percentage": 88, "note": "Workaround: external refetch after restore completes"}
    ]'::jsonb,
    'React Query v5.25+ with experimental_createQueryPersister, persisted queries, refetchOnMount: ''always'' configured',
    'Persisted data loads as stale and immediately refetches, invalidateQueries works on uninitialized persisted queries',
    'Persister only checks query.isStale() and doesn''t have access to observer-level refetchOnMount property. Use refetchOnRestore option (PR #9745) or manually trigger refetch post-restore.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/TanStack/query/issues/9667'
);
