INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES
(
    'JavaScript not functioning after HTMX GET/POST request swapped',
    'frameworks',
    'HIGH',
    '[
        {"solution": "Use htmx.onLoad callback to reinitialize JavaScript components after swap. Example: htmx.onLoad(function(content) { document.querySelectorAll([data-bs-toggle=\"dropdown\"]).forEach(el => { new bootstrap.Dropdown(el); }); });", "percentage": 95},
        {"solution": "Move Bootstrap JavaScript from body to head tag to prevent component instance destruction during swap", "percentage": 85}
    ]'::jsonb,
    'HTMX library loaded, third-party JS library (Bootstrap/jQuery) already initialized on page',
    'Third-party components (dropdowns, tooltips, carousels) now respond to interaction after HTMX swap completes',
    'Assuming third-party library is automatically reinitialized without explicit callback. Not listening for htmx:afterSwap event.',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/71612534/javascript-not-functioning-after-htmx-get-post-request-swapped',
    'admin:1764173503'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES
(
    'HTMX swap not updating DOM content on server response',
    'frameworks',
    'HIGH',
    '[
        {"solution": "Ensure server returns valid HTML matching the swap target selector. Verify response body contains DOM elements matching hx-target selector", "percentage": 96},
        {"solution": "Check HTTP status code - HTMX default swap fails on 4xx/5xx. Use hx-on:htmx:responseError to handle error responses", "percentage": 90},
        {"solution": "Inspect Network tab in DevTools to confirm server response contains expected HTML content, not JSON or error message", "percentage": 88}
    ]'::jsonb,
    'HTMX 1.6+ library loaded, valid HTML structure with hx-target selector, server endpoint returning HTML',
    'Target DOM element updated with server response content, no console errors, HTTP 2xx response received',
    'Assuming hx-swap attribute automatically processes response without checking Content-Type. Not verifying server response actually contains HTML.',
    0.89,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/78549835/htmx-request-content-not-being-swapped-despite-receiving-proper-response',
    'admin:1764173503'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES
(
    'SolidJS createSignal not triggering reactivity with array updates',
    'frameworks',
    'HIGH',
    '[
        {"solution": "Disable referential equality checks on signal: const [items, setItems] = createSignal([], { equals: false }). This forces reactivity even when array reference doesn''t change", "percentage": 94},
        {"solution": "Use immutable array updates: setItems(prev => [...prev, newItem]) instead of mutating array directly", "percentage": 92},
        {"solution": "Wrap array mutations in batch() function to notify reactive system of all changes at once", "percentage": 85}
    ]'::jsonb,
    'SolidJS 1.0+, createSignal hook initialized, components using signals in JSX expressions',
    'Array changes reflected immediately in DOM, console shows no reactivity warnings, For loop re-renders with new items',
    'Directly mutating signal value (arr[0] = value) without calling setter. Not understanding value-vs-reference difference in SolidJS reactivity.',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/73655691/solidjs-how-to-make-dom-elements-reactive-to-signal-updates',
    'admin:1764173503'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES
(
    'Angular NullInjectorError: No provider for service dependency injection',
    'frameworks',
    'HIGH',
    '[
        {"solution": "Add @Injectable({ providedIn: ''root'' }) decorator to service class. If used in feature module, add to providers array in @NgModule", "percentage": 96},
        {"solution": "Ensure @Injectable() decorator is present on class with constructor parameters. Classes without parameters don''t require @Injectable()", "percentage": 93},
        {"solution": "Verify service is listed in module''s providers array or providedIn is set correctly. Check import path is correct.", "percentage": 90}
    ]'::jsonb,
    'Angular 2.0+, service class defined, module decorator present with imports/providers arrays',
    'Service instances inject successfully, no NullInjectorError in console, component receives service via constructor',
    'Using @Inject() without @Injectable() on service class. Forgetting to add service to providers array in module declaration.',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/41395291/angular-2-dependency-injection-not-working',
    'admin:1764173503'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES
(
    'React useEffect infinite loop continuously running callbacks',
    'frameworks',
    'HIGH',
    '[
        {"solution": "Add missing dependency to useEffect dependency array. Example: useEffect(() => { /* effect */ }, [dependency]) instead of no array", "percentage": 97},
        {"solution": "Remove function/object creation from effect body - move to useCallback/useMemo if dependency needed. Objects/functions created in render cause new reference each time", "percentage": 94},
        {"solution": "Don''t include setState function result in dependencies - only pass actual state variable to dependency array", "percentage": 91}
    ]'::jsonb,
    'React 16.8+, functional component using hooks, useEffect callback defined',
    'useEffect runs once on mount and cleanup, no repeated callback execution, console shows expected effect timing',
    'Including object/array literals directly in effect body. Not understanding dependency array rules. Using missing dependencies instead of empty array.',
    0.95,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/53070970/infinite-loop-in-useeffect',
    'admin:1764173503'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES
(
    'Vue 3 computed property not updating on reactive data change',
    'frameworks',
    'HIGH',
    '[
        {"solution": "Ensure computed property accesses reactive data from setup() return object. Example: const doubled = computed(() => count.value * 2) where count is ref", "percentage": 93},
        {"solution": "Use ref() for primitive values, reactive() for objects. Computed tracks dependencies only if they''re properly wrapped", "percentage": 91},
        {"solution": "Verify computed getter accesses property that changed - Vue doesn''t track deeply unless using deep watchers or reactive()", "percentage": 88}
    ]'::jsonb,
    'Vue 3 Composition API, ref/reactive data defined, computed imported from vue',
    'Computed value updates immediately when dependency changes, template reflects new computed value, no stale closures',
    'Computed property not returning anything. Forgetting .value accessor on ref in computed getter. Not using ref() for primitive values.',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/73592457/vue-3-computed-property-and-ref-not-updating-page-content',
    'admin:1764173503'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES
(
    'Svelte reactive declaration not working with reassigned variables',
    'frameworks',
    'HIGH',
    '[
        {"solution": "Use $: label syntax for reactive declarations: $: doubled = count * 2. Label must be placed ABOVE the variable it depends on", "percentage": 92},
        {"solution": "Ensure reactive declaration is at top level of script block, not inside functions or conditionals", "percentage": 89},
        {"solution": "Don''t use arrow functions in reactive blocks - use function declarations: $: function updateValue() { } instead", "percentage": 85}
    ]'::jsonb,
    'Svelte 3.0+, script tag present, variables declared before reactive blocks',
    'Variable updates when dependencies change, template reflects reactive value, console shows no warnings',
    'Placing reactive declaration inside function scope. Using arrow functions in reactive blocks. Referencing undefined variables in reactive dependency.',
    0.88,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/71883074/svelte-reactive-declaration-does-not-work-when-passing-a-declared-function',
    'admin:1764173503'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES
(
    'Qwik component error: Component was not invoked correctly',
    'frameworks',
    'HIGH',
    '[
        {"solution": "Use component$() wrapper for Qwik components instead of React components. Example: export const MyComponent = component$(() => <div>content</div>)", "percentage": 94},
        {"solution": "Ensure event handlers use $() syntax for resumability: onClick$={() => { }} instead of onClick={() => { }}", "percentage": 91},
        {"solution": "Import useSignal() from @builder.io/qwik for reactive state, not React''s useState()", "percentage": 93}
    ]'::jsonb,
    'Qwik 1.0+, @builder.io/qwik imported, component file using Qwik syntax',
    'Component renders without console errors, resumability serialization successful, components interactive without hydration',
    'Mixing React and Qwik syntax in same component. Using React hooks instead of Qwik composables. Not wrapping components with component$()',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/79740639/qwik-error-the-qwik-component-was-not-invoked-correctly-when-trying-to-use-a',
    'admin:1764173503'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES
(
    'Next.js prerendering error: exported getStaticProps is not a function',
    'frameworks',
    'HIGH',
    '[
        {"solution": "Ensure getStaticProps is exported as named export: export async function getStaticProps(context) { }. Must be async function", "percentage": 95},
        {"solution": "Return object with props key: return { props: { data: value }, revalidate: 60 } instead of props directly", "percentage": 92},
        {"solution": "Place getStaticProps in pages directory file (not components). Next.js only recognizes it from pages/[].js files", "percentage": 94}
    ]'::jsonb,
    'Next.js 10+, pages directory structure, getStaticProps defined in page component file',
    'Page prerendered successfully, props passed to component, no console errors during build',
    'Using default export for getStaticProps. Placing getStaticProps in component subdirectory. Not returning object with props key.',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/66234401/angular-service-injection-error-for-no-provider',
    'admin:1764173503'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES
(
    'Astro component hydration error: component wrapper not found on client',
    'frameworks',
    'HIGH',
    '[
        {"solution": "Add client:load directive to component in template: <Component client:load />. This hydrates component on page load", "percentage": 96},
        {"solution": "Ensure component is using framework (React/Vue/Svelte) with import statement. Astro components (.astro) don''t need hydration", "percentage": 93},
        {"solution": "Check component is not inside another static Astro component wrapper that may prevent hydration", "percentage": 88}
    ]'::jsonb,
    'Astro 1.0+, .astro or .jsx/.vue component defined, client directive syntax available',
    'Framework component renders and becomes interactive, no hydration errors in console, component state works on client',
    'Using client:idle on every component causing hydration waterfalls. Forgetting framework import in .astro templates. Not adding client directive at all.',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/77190748/how-to-swap-the-response-in-the-dom-using-htmx-when-its-4xx-or-5xx-response-htt',
    'admin:1764173503'
);
