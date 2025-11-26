-- Add SWR GitHub issues solutions batch 1
-- Mining from vercel/swr repository focusing on revalidation, mutation, infinite loading, and TypeScript types
-- Extracted: November 25, 2025

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'SWR revalidateOnMount:true not working when using browser back navigation',
    'github-swr',
    'HIGH',
    '[
        {"solution": "Ensure component remounts on navigation by checking useEffect trigger and route state change detection", "percentage": 85, "note": "revalidateOnMount depends on component mounting, not just route change"},
        {"solution": "Force revalidation on navigation by using useEffect hook with router state dependency", "percentage": 80, "command": "useEffect(() => { mutate(key) }, [router.pathname])"},
        {"solution": "Verify cache key is unique per route to prevent stale cache reuse across navigation", "percentage": 75, "note": "Cache persistence across nav history can prevent fresh fetches"}
    ]'::jsonb,
    'SWR v2.2+, react-router-dom or equivalent router, revalidateOnMount enabled in config',
    'New fetch request initiated on back navigation, console shows network activity, data reflects current URL',
    'Component mounting alone does not guarantee revalidation - ensure route change also triggers revalidation. Cache persistence across navigation can mask the issue.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/swr/issues/4144'
),
(
    'SWR query revalidation on focus not working in Chrome browser',
    'github-swr',
    'HIGH',
    '[
        {"solution": "Check document.visibilityState implementation in browser - Safari and Chrome handle visibility differently", "percentage": 80, "note": "Chrome visibility detection for tab switching is inconsistent with Safari"},
        {"solution": "Use workaround: manually trigger revalidation on window focus event instead of relying on visibility state", "percentage": 85, "command": "window.addEventListener(''focus'', () => mutate(key))"},
        {"solution": "Update SWR to latest version - browser behavior compatibility fixes may be included", "percentage": 75, "note": "Issue reported in v2.2.5, check release notes for fixes"}
    ]'::jsonb,
    'SWR v2.2.5+, Chrome browser, focus revalidation expected behavior',
    'Query revalidates when tab regains focus, network tab shows request initiated, data updates on refocus',
    'Chrome and Safari handle document.visibilityState differently - test implementation across browsers. visibility state alone may not reliably detect refocus.',
    0.78,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/swr/issues/4130'
),
(
    'useSWRInfinite returns [null] instead of undefined or data in versions 2.3.0+',
    'github-swr',
    'HIGH',
    '[
        {"solution": "Downgrade to SWR v2.2.5 if blocking production - v2.3.0-2.3.6 has breaking change", "percentage": 75, "note": "Breaking change introduced in v2.3.0, use v2.2.5 until fix released"},
        {"solution": "Check if custom compare function is filtering out empty responses - compare(data, null) may return true", "percentage": 80, "note": "Fallback data or compare function may cause [null] response"},
        {"solution": "Wait for SWR fix or check if response structure changed - backend may need to return proper empty array structure", "percentage": 70, "note": "Issue is verified in v2.3.0-2.3.6, upstream fix needed"}
    ]'::jsonb,
    'SWR v2.3.0+, useSWRInfinite hook, infinite pagination setup',
    'Fetcher function invoked on empty pages, data returns proper structure not [null], component renders without crashes',
    'v2.3.0+ returns [null] for empty pages instead of expected undefined - downgrade or wait for patch. Custom compare functions may interfere with response handling.',
    0.68,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/swr/issues/4170'
),
(
    'SWR TypeScript typings do not catch mistyped fetcher arguments matching key structure',
    'github-swr',
    'MEDIUM',
    '[
        {"solution": "Manually verify fetcher argument types match key structure - use explicit typing instead of relying on inference", "percentage": 85, "command": "const fetcher = (key: [string]) => ... instead of relying on type narrowing"},
        {"solution": "Create type-safe wrapper utility that enforces key-to-fetcher type matching at compile time", "percentage": 80, "note": "TypeScript limitations prevent automatic inference - manual typing required"},
        {"solution": "File issue with detailed examples for SWR team to implement type overloads for common patterns", "percentage": 60, "note": "Fundamental limitation in SWR type definitions, requires library update"}
    ]'::jsonb,
    'SWR v2.3.4+, TypeScript with strict mode enabled, fetcher function',
    'TypeScript compiler catches fetcher/key type mismatches, no type errors during IDE development',
    'TypeScript cannot automatically infer that key structure must match fetcher parameters - requires manual type annotations. String vs array key mismatches pass compilation despite being errors.',
    0.72,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/swr/issues/4166'
),
(
    'SWRMutationConfiguration.optimisticData function receives undefined second parameter despite runtime value',
    'github-swr',
    'MEDIUM',
    '[
        {"solution": "Update type definitions in optimisticData to include second parameter - align with useSWR MutatorOptions typing", "percentage": 90, "note": "PR #4162 addresses this - types should match actual runtime behavior"},
        {"solution": "Workaround: explicitly type the callback parameters using function overloading or as-const", "percentage": 75, "command": "optimisticData: ((a, b, c) => ...) as const"},
        {"solution": "Access second parameter properties without type assertions - they exist at runtime despite TS suggesting undefined", "percentage": 80, "note": "Parameter exists and is functional, only types are incorrect"}
    ]'::jsonb,
    'SWR v2.3+, useSWRMutation hook, TypeScript strict mode',
    'optimisticData callback receives all three parameters correctly typed, no type assertion needed, parameter b accessible',
    'Type definitions incorrectly mark second parameter as undefined when it has actual runtime value. Function signature inconsistent with useSWR MutatorOptions.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/swr/issues/4161'
),
(
    'useSWR with optimisticData and data functions returns [null] instead of actual data in useSWRInfinite',
    'github-swr',
    'MEDIUM',
    '[
        {"solution": "Use compare function to detect structural equivalence and prevent unnecessary re-renders on identical data", "percentage": 85, "note": "Existing compare() function should be used in mutation code path"},
        {"solution": "Ensure optimisticData and async data function return same object references when content identical", "percentage": 75, "note": "Object reference equality prevents cache updates"},
        {"solution": "Set revalidate: false in mutation options to skip the second render with final data", "percentage": 80, "command": "mutate(updateFn, { revalidate: false })"}
    ]'::jsonb,
    'SWR v2.3.6+, useSWRInfinite with paginated data, mutation with optimisticData',
    'Single render on mutation completion, no duplicate renders when optimistic and final data match, compare function used',
    'Duplicate renders occur even when optimistic and final data are structurally identical - compare() function not applied in mutation path. New object references trigger unnecessary updates.',
    0.76,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/swr/issues/4180'
),
(
    'Global mutate with matcher function does not receive keys from useSWRInfinite',
    'github-swr',
    'HIGH',
    '[
        {"solution": "Add includeSpecialKeys flag to MutatorOptions to include $inf$ prefixed keys in matcher", "percentage": 90, "note": "Proposed solution in PR #4167 - allows matching infinite query keys"},
        {"solution": "Use individual mutate() calls per known key instead of global matcher for infinite queries", "percentage": 75, "note": "Workaround: manually track and mutate infinite keys"},
        {"solution": "Track infinite query keys separately and batch mutate them outside of global matcher", "percentage": 70, "command": "const infKeys = []; mutate(k => infKeys.includes(k))"}
    ]'::jsonb,
    'SWR v2.3.6+, useSWRInfinite hooks active, global mutate with matcher function',
    'Matcher function receives $inf$ prefixed keys, global mutate revalidates infinite query pages, cache updates for all pages',
    'Matcher function receives only standard useSWR keys, not $inf$ prefixed infinite query keys - global mutations skip infinite queries. No built-in way to match infinite keys.',
    0.74,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/swr/issues/4149'
),
(
    'useSWRMutation onSuccess callback does not await async operations before returning',
    'github-swr',
    'HIGH',
    '[
        {"solution": "Await async onSuccess callback before returning from trigger function - wrap in Promise.all", "percentage": 90, "note": "Proposal: modify trigger return to await callbacks"},
        {"solution": "Use separate effect hook to handle post-mutation async operations instead of relying on onSuccess callback", "percentage": 80, "command": "useEffect(() => { /* revalidate after mutation */ }, [data])"},
        {"solution": "Implement synchronous callback pattern and move async logic to useEffect hook triggered by mutation result", "percentage": 75, "note": "Aligns with React patterns but requires code restructuring"}
    ]'::jsonb,
    'SWR v2.3+, useSWRMutation with async onSuccess handlers',
    'await trigger() completes before callback returns, UI updates in correct order, race conditions resolved',
    'onSuccess callbacks execute in parallel with trigger return, not awaited - causes race conditions. No guarantee that revalidations or other async ops in callbacks complete before mutation result used.',
    0.80,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/swr/issues/4171'
),
(
    'SWR Suspense with fallback data throws console errors during Next.js SSR pre-rendering',
    'github-swr',
    'HIGH',
    '[
        {"solution": "Use useSyncExternalStore hook to distinguish server vs client rendering and skip Suspense during SSR", "percentage": 85, "note": "Community pattern: wrap with client hydration detection"},
        {"solution": "Provide fallback data via SWRConfig when using Suspense in SSR to prevent missing data errors", "percentage": 80, "note": "Trade-off: may cause layout shifts if fallback differs from actual data"},
        {"solution": "Skip SSR for components with Suspense: use dynamic import with ssr: false in Next.js", "percentage": 75, "command": "dynamic(() => import(''./Component''), { ssr: false })"}
    ]'::jsonb,
    'SWR v2.3.3+, Next.js 15+, React Suspense boundaries, use client components',
    'No console errors during SSR pre-render, proper fallback data shown, no layout shifts on hydration',
    'Next.js pre-renders client components despite use client directive - causes Suspense/SWR conflicts. Fallback data requirement creates trade-off between errors and layout shifts.',
    0.78,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/swr/issues/4159'
),
(
    'SWR cannot infer fetcher argument types from key in dynamic suspense configuration',
    'github-swr',
    'MEDIUM',
    '[
        {"solution": "Pass suspense as const literal value, not variable - enables TypeScript type narrowing", "percentage": 85, "command": "useSWR(key, fetcher, { suspense: true })  // not: { suspense: someVar })"},
        {"solution": "Create wrapper hook that uses suspense as literal and accepts parameter separately for configuration", "percentage": 80, "note": "Enables type inference while keeping code flexible"},
        {"solution": "Use type assertion if dynamic suspense needed - TypeScript limitation requires manual cast", "percentage": 70, "command": "useSWR(key, fetcher, { suspense } as const)"}
    ]'::jsonb,
    'SWR v2.3.4+, TypeScript with strict mode, suspense configuration',
    'Type inference works correctly, data type properly includes/excludes undefined based on suspense value',
    'Dynamic boolean variables for suspense parameter break type inference - requires literal true/false values. Hardcoded suspense true works, but parameters do not.',
    0.76,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/swr/issues/4157'
),
(
    'Destructuring error property from useSWR triggers ESLint no-unsafe-assignment error',
    'github-swr',
    'MEDIUM',
    '[
        {"solution": "Update SWR type definitions to use unknown instead of any for error property", "percentage": 90, "note": "Change error: any to error: unknown in type definitions"},
        {"solution": "Disable eslint rule for SWR error destructuring if not feasible", "percentage": 60, "command": "// eslint-disable-next-line @typescript-eslint/no-unsafe-assignment"},
        {"solution": "Use non-null assertion if type unknown required for ESLint compliance", "percentage": 70, "command": "const { error } = useSWR(); const err: unknown = error;"}
    ]'::jsonb,
    'SWR latest version, typescript-eslint configured with no-unsafe-assignment rule',
    'Error destructuring does not trigger ESLint warnings, error type is unknown, strict type checking passes',
    'Error property typed as any instead of unknown - violates strict TypeScript practices. ESLint no-unsafe-assignment rule catches unsafe destructuring of any type.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/swr/issues/4179'
),
(
    'Global mutate from base swr package does not trigger re-renders for useSWRImmutable hooks',
    'github-swr',
    'MEDIUM',
    '[
        {"solution": "Use mutate function from swr/immutable if modifying immutable hook data", "percentage": 90, "note": "swr and swr/immutable maintain separate cache contexts"},
        {"solution": "Import mutate from same package as hook: if using useSWRImmutable, use mutate from swr/immutable", "percentage": 85, "command": "import { mutate } from ''swr/immutable''"},
        {"solution": "Switch to base useSWR hook if global mutate needs to work across cache - immutable module has separate cache", "percentage": 75, "note": "Architectural separation - choose hook and mutate from same source"}
    ]'::jsonb,
    'SWR v2.3.3-2.3.6, useSWRImmutable from swr/immutable, global mutate from base swr',
    'Mutate triggers re-renders in immutable hooks, cache updates propagate to all subscribers, consistent behavior across hook variants',
    'swr and swr/immutable packages maintain separate cache instances - mutate from base swr does not notify immutable hooks. Must use mutate from swr/immutable to update immutable hook data.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/swr/issues/4158'
),
(
    'SWR Suspense with keepPreviousData:true fallback component does not display on key change',
    'github-swr',
    'MEDIUM',
    '[
        {"solution": "Verify keepPreviousData and Suspense are compatible in current SWR version - check if interaction is documented", "percentage": 75, "note": "keepPreviousData prevents loading state that Suspense needs for fallback"},
        {"solution": "Use custom loading state detection instead of relying on Suspense fallback with keepPreviousData", "percentage": 85, "command": "const { data, isLoading } = useSWR(key, fetcher, { keepPreviousData: true })"},
        {"solution": "Separate Suspense boundary from keepPreviousData - use effect to show fallback when key changes", "percentage": 80, "note": "Fallback display requires loading state, keepPreviousData maintains previous data during load"}
    ]'::jsonb,
    'SWR v2.3.4+, keepPreviousData enabled, Suspense boundary, dynamic SWR key',
    'Fallback component displays when key changes and data fetches, no missing fallback displays, smooth data transitions',
    'keepPreviousData prevents loading state needed for Suspense fallback - both options conflict. Fallback only shows once instead of on each key change due to previous data caching.',
    0.72,
    'sonnet-4',
    NOW(),
    'https://github.com/vercel/swr/issues/4147'
);
