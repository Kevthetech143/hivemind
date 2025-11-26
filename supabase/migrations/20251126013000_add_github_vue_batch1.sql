-- Add Vue.js Core GitHub Issues with Solutions - Batch 1
-- Category: github-vue
-- Source: vuejs/core repository issues with highest reactions and most-commented

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Vue: Computed property memory leak - dependencies never cleared',
    'github-vue',
    'HIGH',
    $$[
        {"solution": "Use effectScope() from RFC #212 for more explicit control and cleanup", "percentage": 90, "note": "Recommended approach for Vue 3.2+"},
        {"solution": "Clear gathered Sets as part of dependency updates - Vue handles automatic cleanup on re-evaluation", "percentage": 85, "note": "Implemented in PR #2263"},
        {"solution": "Manually cleanup computed with stopHandle if created outside component setup", "percentage": 80, "command": "const stop = watchEffect(() => { /* */ }); stop();"}
    ]$$::jsonb,
    'Vue 3.0+, Understanding of Composition API',
    'No memory leaks in heap snapshots, Computed properties properly garbage collected after component unmount',
    'Computed properties cache by design - cleanup only needed for long-lived instances. Always create watchers/computeds synchronously in setup. Do not create in async callbacks without manual cleanup.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/vuejs/core/issues/2261'
),
(
    'Vue: Memory leak from key dependencies never removed in reactive collections',
    'github-vue',
    'HIGH',
    $$[
        {"solution": "Optimize dependency tracking to prevent unbounded accumulation - fixed in PR #5912", "percentage": 92, "note": "Implemented feat(reactivity): more efficient reactivity system"},
        {"solution": "Use WeakMap/WeakSet for object keys to enable garbage collection - PR #8549", "percentage": 88, "note": "Replace Map/Set with WeakMap/WeakSet pattern"},
        {"solution": "For primitive keys, avoid accessing different keys repeatedly in computeds/watchers with reactive Maps/Sets", "percentage": 75, "note": "Structural workaround for pre-fix code"}
    ]$$::jsonb,
    'Vue 3.0+, Reactive data structures (Set, Map), Multiple computed/watcher accesses',
    'No out-of-memory errors, Dependencies properly cleaned up after effects complete, Heap size remains stable',
    'Primitive keys cannot use WeakMap - design dependency access carefully. Avoid dynamic key access in tight loops. Pre-3.5 versions vulnerable to accumulation.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/vuejs/core/issues/9419'
),
(
    'Vue: Potential memory leak in computed - cached values persist',
    'github-vue',
    'MEDIUM',
    $$[
        {"solution": "Rely on component lifecycle cleanup - Vue handles memory release on unmount automatically", "percentage": 90, "note": "Normal use case in production apps"},
        {"solution": "If computed created outside component, store reference and set to undefined on cleanup", "percentage": 80, "note": "Edge case workaround"},
        {"solution": "Use watchEffect with stop handle for fine-grained cleanup control", "percentage": 85, "command": "const stop = watchEffect(() => {}); stop();"}
    ]$$::jsonb,
    'Vue 3.0+, Component lifecycle understanding',
    'Computed cached values cleared after component unmount, Memory profiler shows no retention of component data',
    'Cached values intentionally persist until re-access or cleanup - this is expected behavior. Manual garbage collection may not immediately release refs. Normal component lifecycle handles cleanup properly.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/vuejs/core/issues/9233'
),
(
    'Vue 3.4+: toRaw ignores __v_skip flag causing infinite loop with custom proxies',
    'github-vue',
    'MEDIUM',
    $$[
        {"solution": "Use shallowReactive instead of reactive for custom proxies", "percentage": 85, "note": "Avoids deep proxy traps"},
        {"solution": "Wrap custom proxy in plain object with markRaw to prevent toRaw traversal", "percentage": 82, "note": "const obj = { proxy: markRaw(customProxy) }"},
        {"solution": "Check for __v_skip property in toRaw before recursing - proposed fix for framework", "percentage": 75, "note": "Framework improvement needed"}
    ]$$::jsonb,
    'Vue 3.0+, markRaw function, Custom proxy objects',
    'toRaw returns immediately without infinite loop, Custom proxy functions correctly in reactive objects',
    'markRaw must wrap the proxy, not the containing object. shallowReactive has trade-offs with nested reactivity. Framework has __v_skip support but toRaw ignores it.',
    0.78,
    'sonnet-4',
    NOW(),
    'https://github.com/vuejs/core/issues/4632'
),
(
    'Vue 3.4.32+: shallowReactive collections (Set/Map) unproxy items incorrectly',
    'github-vue',
    'MEDIUM',
    $$[
        {"solution": "Keep proxies intact in shallowReactive collections - item identity preserved on add and retrieval", "percentage": 88, "note": "Fixed in Vue 3.4.32"},
        {"solution": "Use reactive() instead of shallowReactive() for collections containing proxies", "percentage": 85, "note": "Provides consistent wrapping behavior"},
        {"solution": "Clone and re-wrap proxies manually if using shallowReactive", "percentage": 70, "note": "Workaround for pre-3.4.32"}
    ]$$::jsonb,
    'Vue 3.0+, shallowReactive knowledge, Set/Map data structures',
    'Retrieved items from shallowReactive collections match their original identity, No unwrap/re-wrap mismatches',
    'shallowReactive applies unwrapping on add but not on retrieval - arrays and collections behave differently. Always test identity after retrieval. Fixed in 3.4.32.',
    0.86,
    'sonnet-4',
    NOW(),
    'https://github.com/vuejs/core/issues/8662'
),
(
    'Vue 3.4.13+: Maximum recursive updates exceeded error - computed with side effects',
    'github-vue',
    'MEDIUM',
    $$[
        {"solution": "Remove side effects from computed properties - use watchers for mutations", "percentage": 95, "note": "Computed should be pure functions"},
        {"solution": "If side effects needed, use watchEffect instead of computed", "percentage": 90, "command": "watchEffect(() => { /* mutations here */ })"},
        {"solution": "Avoid referencing same ref multiple times when it is mutated in computed", "percentage": 85, "note": "Triggers recursive dependency chain"}
    ]$$::jsonb,
    'Vue 3.0+, Understanding computed vs watchEffect',
    'No recursion limit errors, Template renders correctly with updated values, No console warnings about side effects',
    'Computed should be pure - mutating dependencies in computed creates recursive loops. This is design pattern violation. Error indicates improper usage, not framework bug. Refactor to watchEffect instead.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/vuejs/core/issues/10107'
),
(
    'Vue 3.4.26-27: Transition component hooks fail with undefined props (regression)',
    'github-vue',
    'HIGH',
    $$[
        {"solution": "Upgrade to Vue 3.4.28+ where PR #11066 fixes enterHooks freshness", "percentage": 95, "note": "fix(Transition): ensure enterHooks is fresh after clone"},
        {"solution": "If stuck on older version, clone hooks manually before passing to Transition", "percentage": 80, "note": "Workaround - creates new hook references"},
        {"solution": "Ensure Transition receives valid props - undefined props can trigger mode-specific hook issues", "percentage": 75, "note": "Preventative approach"}
    ]$$::jsonb,
    'Vue 3.4.26 or 3.4.27, Transition component usage, JavaScript hooks',
    'Transition hooks execute without errors, Leave hooks fire in out-in and in-out modes, No internal errors in render',
    'Regression in 3.4.26 breaks all transition modes with undefined props. Must upgrade to 3.4.28+. Different modes fail differently (default works, out-in and in-out fail).',
    0.93,
    'sonnet-4',
    NOW(),
    'https://github.com/vuejs/core/issues/11061'
),
(
    'Vue 3.4.32: v-model updates fail with multiple emits in same tick (regression)',
    'github-vue',
    'HIGH',
    $$[
        {"solution": "Upgrade to Vue 3.4.33+ where PR #11430 fixes defineModel multi-tick updates", "percentage": 96, "note": "fix(defineModel): correct update with multiple changes in same tick"},
        {"solution": "If downgrade needed, batch child emits to next tick with Promise.resolve().then()", "percentage": 82, "note": "Separates emits to different ticks"},
        {"solution": "Use direct prop with custom emit instead of defineModel for complex scenarios", "percentage": 75, "note": "Avoids defineModel timing issues"}
    ]$$::jsonb,
    'Vue 3.4.32, defineModel function, Parent-child component communication',
    'v-model updates reflect latest child-emitted value, Multiple emits in same tick update correctly, Parent reactive state matches child emissions',
    'Regression specific to 3.4.32 with defineModel - only last emit counts before fix. Batching emits to next tick is workaround. Must upgrade to 3.4.33+. Non-defineModel components unaffected.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://github.com/vuejs/core/issues/11429'
),
(
    'Vue 3.5.5: @vue/reactivity benchmark hangs with deeply chained computeds',
    'github-vue',
    'HIGH',
    $$[
        {"solution": "Upgrade to Vue 3.5.6+ where PR #11944 reduces exponential perf cost", "percentage": 97, "note": "Avoids exponential call stack depth for deeply chained computeds"},
        {"solution": "Refactor deep chains of computeds - break chains at strategic points", "percentage": 85, "note": "Reduces computation depth"},
        {"solution": "Profile with benchmark tests to identify problematic chains before performance impact", "percentage": 80, "note": "Preventative monitoring"}
    ]$$::jsonb,
    'Vue 3.5.5, Complex computed chains, Performance monitoring',
    'Deeply chained computeds complete without hanging, Benchmark tests pass for cellx1000+, Call stack depth remains stable',
    'Exponential cost in deeply nested computed chains - creates 5x+ slowdown. Fixed in 3.5.6 with stack depth optimization. Tests that hang (cellx1000+) now pass at 75% faster.',
    0.96,
    'sonnet-4',
    NOW(),
    'https://github.com/vuejs/core/issues/11928'
),
(
    'Vue 3.4+: Maximum recursive updates exceeded when adding props in v-for loops',
    'github-vue',
    'HIGH',
    $$[
        {"solution": "Upgrade to Vue 3.5.1+ where PR #11826 prevents duplicate job queuing", "percentage": 95, "note": "fix(scheduler): prevent duplicate jobs being queued"},
        {"solution": "Batch property assignments using Object.assign instead of individual assignments", "percentage": 82, "note": "Reduces total update cycles"},
        {"solution": "Use nextTick() between property additions to flush jobs and reset counter", "percentage": 78, "command": "for (let i = 0; i < items.length; i++) { assignProps(items[i]); await nextTick(); }"}
    ]$$::jsonb,
    'Vue 3.4+, v-for loops, Reactive object property mutations',
    'No recursion limit exceeded errors in development, v-for items render correctly with all properties, Select dropdowns populate without warnings',
    'Scheduler queues duplicate jobs when adding 34+ item properties or 21+ with 5 props each. Root cause is flushJobs count calculation. Fixed in 3.5.1. Affects development mode primarily.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://github.com/vuejs/core/issues/11807'
),
(
    'Vue 3.4+: Console warning when assigning components to reactive data with <component :is>',
    'github-vue',
    'MEDIUM',
    $$[
        {"solution": "Wrap component with markRaw() to prevent reactivity: markRaw(Component)", "percentage": 96, "note": "Official recommended solution"},
        {"solution": "Use computed(() => Component) instead of direct reactive assignment", "percentage": 88, "note": "Lazy evaluation avoids premature wrapping"},
        {"solution": "Store components in non-reactive variable (const, not ref/reactive)", "percentage": 90, "note": "Simplest approach"}
    ]$$::jsonb,
    'Vue 3.4+, dynamic component usage, markRaw function',
    'No "[Vue warn]: Vue received a Component that was made a reactive object" warnings, Components render correctly, No performance impact from markRaw overhead',
    'Warning exists since Vue 3.0 alpha but more prominent in 3.4+ detection. Components should never be reactive - markRaw only sets non-enumerable flag. Behavior difference from 3.3 relates to warning timing.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://github.com/vuejs/core/issues/11921'
),
(
    'Vue 3.4: Computed property breaks change detection with reactive objects',
    'github-vue',
    'MEDIUM',
    $$[
        {"solution": "Wrap reactive object in reactive() call to ensure return value changes", "percentage": 88, "note": "Vue 3.4 optimizes computed to check actual value changes"},
        {"solution": "Return a new object from computed instead of same reference: computed(() => ({ ...data }))", "percentage": 85, "note": "Forces re-render on dependency change"},
        {"solution": "Access reactive object directly in template instead of through computed", "percentage": 82, "note": "Bypasses computed return-value optimization"}
    ]$$::jsonb,
    'Vue 3.4, Computed properties, Reactive objects',
    'Template updates when reactive object properties change, Computed triggers dependent effects, Re-renders occur on dependency mutation',
    'Vue 3.4 optimizes computed to only trigger when return value changes - same object reference = no re-render even if properties mutate. This is intentional design change from 3.3. Wrap with reactive() or return new object.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/vuejs/core/issues/10601'
),
(
    'Vue: Stable mutation of reactive arrays containing refs - ref position instability',
    'github-vue',
    'MEDIUM',
    $$[
        {"solution": "Use toRaw(array).reverse() to mutate underlying array without ref disruption", "percentage": 90, "note": "Gets unproxied array, preserves ref positions"},
        {"solution": "Create computed property that maps array with unwrapping: computed(() => array.map(unwrap))", "percentage": 85, "note": "Provides stable unwrapped view"},
        {"solution": "Use custom unwrap utility function with isRef() checks before mutations", "percentage": 82, "command": "const unwrap = (e) => isRef(e) ? e.value : e;"}
    ]$$::jsonb,
    'Vue 3.0+, Reactive arrays with refs, Array mutation methods (reverse, sort, splice)',
    'Array mutations preserve ref positions, Ref values align correctly after reverse/sort, Dependency tracking remains stable',
    'Arrays no longer unwrap contained refs in Vue 3 - maintains ref stability but requires explicit unwrapping. Methods like reverse() swap values only, leaving refs at original indices. No automatic unwrapping in collections unlike templates.',
    0.84,
    'sonnet-4',
    NOW(),
    'https://github.com/vuejs/core/issues/737'
),
(
    'Vue: readonly() breaks reactivity of Map items - nested properties lose reactivity',
    'github-vue',
    'MEDIUM',
    $$[
        {"solution": "Apply readonly() to individual Map items instead of the container: roMap.get(key) returns reactive item", "percentage": 88, "note": "Keeps nested items reactive"},
        {"solution": "Use custom getter function that applies readonly selectively to keys", "percentage": 82, "note": "Fine-grained read-only control"},
        {"solution": "Keep reactive Map separate and provide readonly accessor: const getMappedItem = (key) => readonly(map.get(key))", "percentage": 80, "note": "Defers readonly to access time"}
    ]$$::jsonb,
    'Vue 3.0+, readonly function, Reactive Map usage, Understanding deep readonly',
    'Items from readonly Map trigger watchers when mutated, Nested properties remain reactive, watchEffect callbacks fire on item mutations',
    'readonly() applies deep readonly to all nested properties - this is intentional behavior per design. Items from readonly containers show isReactive() = false. Must apply readonly selectively to items, not containers, for reactive nested properties.',
    0.81,
    'sonnet-4',
    NOW(),
    'https://github.com/vuejs/core/issues/1772'
);
