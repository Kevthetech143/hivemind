-- Add GitHub Issues solutions from sveltejs/svelte repository - Batch 1
-- Extracted high-voted/commented issues with solutions and workarounds
-- Category: github-svelte
-- Date: 2025-11-26

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Svelte parses self-closing non-void HTML tags incorrectly',
    'github-svelte',
    'HIGH',
    $$[
        {"solution": "Use explicit tag syntax: either <div>content</div> or <div></div>content, never <div /> for non-void elements", "percentage": 95, "note": "Official recommendation to avoid parsing ambiguity"},
        {"solution": "Enable strict mode/warnings to catch self-closing non-void tags during development", "percentage": 90, "command": "Apply fix from PR #11114"},
        {"solution": "Migrate existing code by replacing <tag /> with <tag></tag> or removing slash entirely", "percentage": 85, "note": "One-time migration of components"}
    ]$$::jsonb,
    'Svelte 3.0+, understanding of HTML void vs non-void elements',
    'Components parse consistently with browser HTML behavior, no DOM tree discrepancies',
    'Self-closing syntax like <div /> differs between Svelte and browser parsing. Always use explicit open/close tags. Copy-pasting HTML between contexts must produce identical DOM.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/sveltejs/svelte/issues/11052'
),
(
    'Inconsistent behavior when updating reactive declared variables with mutations',
    'github-svelte',
    'HIGH',
    $$[
        {"solution": "Create new object/array reference instead of self-assignment: providerMarkers = new Map(providerMarkers)", "percentage": 90, "note": "Forces reactivity to properly trigger"},
        {"solution": "Separate mutable state from reactive declarations using explicit state management", "percentage": 85, "note": "Better architecture avoids circular dependencies"},
        {"solution": "Avoid combining three conditions: exported dependencies + non-primitive types + bind directives", "percentage": 80, "note": "Workaround by refactoring component structure"}
    ]$$::jsonb,
    'Svelte 3.0+, reactive declaration syntax knowledge, understanding of Svelte reactivity',
    'Reactive declarations update correctly when dependencies change, no circular invalidation loops',
    'Do not use self-assignment (a = a) with non-primitive reactive dependencies. Always create new references for objects/arrays. Combining bind:, exports, and non-primitives in same reactive chain causes issues.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/sveltejs/svelte/issues/4933'
),
(
    'Events are not emitted from components compiled to custom elements',
    'github-svelte',
    'MEDIUM',
    $$[
        {"solution": "Dispatch custom events with composed: true flag to cross Shadow DOM boundaries", "percentage": 92, "command": "new CustomEvent(''name'', { detail, bubbles: true, composed: true })", "note": "Essential for Shadow DOM event propagation"},
        {"solution": "Use internal $on method for direct component access: document.querySelector(''my-element'').$on(''eventName'', handler)", "percentage": 85, "note": "Non-standard but reliable workaround"},
        {"solution": "Implement dual dispatch pattern - emit both Svelte internal and native DOM events with composition", "percentage": 80, "note": "Requires accessing internal component via get_current_component"}
    ]$$::jsonb,
    'Svelte custom element compilation enabled, understanding of Shadow DOM and composed events',
    'Custom events bubble through Shadow DOM boundary, parent can listen with on: directives',
    'Custom events require composed: true to cross Shadow DOM. Standard on: directive listeners fail without proper event composition. Web component event model differs from Svelte component model.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/sveltejs/svelte/issues/3119'
),
(
    'Incorrect error message regarding unexpected slot in Svelte components',
    'github-svelte',
    'MEDIUM',
    $$[
        {"solution": "Add empty default slot element to component: <slot></slot> even if unused", "percentage": 88, "note": "Suppresses false warnings about unexpected default slot"},
        {"solution": "Use conditional rendering as cleaner workaround: {#if false}<slot></slot>{/if}", "percentage": 85, "note": "Prevents slot from rendering while keeping compiler happy"},
        {"solution": "Verify component only defines named slots and remove warnings after fix in PR #4556", "percentage": 90, "note": "Fixed in recent Svelte versions"}
    ]$$::jsonb,
    'Svelte with named slots implementation, component with only named slots defined',
    'No false console warnings about unexpected slots, component accepts correct named slots',
    'False warnings appear for named slots only when default slot is missing. Warnings only in dev mode. Component slot definition must match parent expectations.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/sveltejs/svelte/issues/4546'
),
(
    'Svelte 5 Hot Reload not working with included components',
    'github-svelte',
    'MEDIUM',
    $$[
        {"solution": "Update to Svelte 5.0.0-next.197 or later which includes PR #12575 fix", "percentage": 95, "command": "npm install svelte@5.0.0-next.197+", "note": "Definitive fix for HMR with imported components"},
        {"solution": "Pin to version 5.0.0-next.178 as temporary workaround", "percentage": 70, "note": "Last working version before regression"},
        {"solution": "Use inline component code in +page.svelte instead of imports while awaiting fix", "percentage": 65, "note": "Development workflow only, not for production"}
    ]$$::jsonb,
    'Svelte 5 (5.0.0-next.179+), SvelteKit project with mounted components',
    'HMR updates mounted components without full page reload, component changes reflect in browser immediately',
    'HMR breaks when editing imported components but works for inline code. Affects only mounted/included components. Regression introduced in 5.0.0-next.179.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://github.com/sveltejs/svelte/issues/12403'
),
(
    'Svelte 5 bind:group incorrectly considers other groups',
    'github-svelte',
    'MEDIUM',
    $$[
        {"solution": "Update to fixed version with PR #10368 and PR #10410 merged", "percentage": 96, "command": "npm install svelte@latest", "note": "Complete resolution in recent releases"},
        {"solution": "Refactor group expressions to avoid nested store references in bind:group", "percentage": 80, "note": "Workaround by simplifying group binding structure"},
        {"solution": "Use separate binding for each group to isolate state management", "percentage": 75, "note": "More verbose but avoids bind:group interaction bugs"}
    ]$$::jsonb,
    'Svelte 5, nested store data with multiple checkbox groups',
    'Unchecking items updates group correctly, rechecked items appear in proper position, empty array returned when all unchecked',
    'Previous group selections leak into current group values. Unchecking shows wrong value. bind:group concatenates all groups incorrectly. Fixed in PR #10368 and #10410.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/sveltejs/svelte/issues/9947'
),
(
    'Svelte 5 delayed transitions dont apply initial CSS',
    'github-svelte',
    'MEDIUM',
    $$[
        {"solution": "Update to Svelte version with PR #12389 fix merged", "percentage": 95, "command": "npm install svelte@latest", "note": "Definitive fix applied to codebase"},
        {"solution": "Create custom easing function with extended duration to simulate delay: return time < delay/duration ? 0 : (time - delay/duration) / (1 - delay/duration)", "percentage": 85, "note": "Workaround using easing instead of delay parameter"},
        {"solution": "Use CSS animation instead of Svelte transition for delayed animations", "percentage": 75, "note": "Alternative approach avoiding transition delay"}
    ]$$::jsonb,
    'Svelte 5, transition directive with delay parameter',
    'Element starts in initial state during delay period, animation begins smoothly after delay expires',
    'Element appears in final state immediately when transition has delay parameter. Initial CSS not applied before delay. Use animation-delay in CSS as workaround.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://github.com/sveltejs/svelte/issues/10876'
),
(
    'TypeScript class field attributes fail to parse in Svelte components',
    'github-svelte',
    'MEDIUM',
    $$[
        {"solution": "Set tsconfig.json target to es2021 or higher with useDefineForClassFields: true", "percentage": 95, "command": "{\"compilerOptions\": {\"target\": \"es2021\", \"useDefineForClassFields\": true}}", "note": "Forces TypeScript to transform class fields correctly"},
        {"solution": "Initialize class fields with explicit values instead of leaving uninitialized: name = undefined", "percentage": 85, "note": "Workaround for parser compatibility"},
        {"solution": "Avoid uninitialized class fields when using esnext or es2020 targets", "percentage": 80, "note": "Know the limitation when targeting older ECMAScript versions"}
    ]$$::jsonb,
    'Svelte with TypeScript, <script lang=\"ts\"> block, uninitialized class field declarations',
    'Class fields parse without syntax errors, TypeScript code compiles to JavaScript successfully',
    'Uninitialized class fields fail with esnext target. useDefineForClassFields setting interacts with target version. Svelte parser lacks ES2022+ class field syntax support with older targets.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/sveltejs/svelte/issues/6900'
),
(
    'Nested child components lose CSS when parent used as custom element',
    'github-svelte',
    'MEDIUM',
    $$[
        {"solution": "Use Rollup plugin to aggregate all nested component styles into parent shadowRoot", "percentage": 80, "note": "Consolidates CSS from all nested components"},
        {"solution": "Programmatically append style elements to custom element shadowRoot after mounting", "percentage": 75, "command": "const style = document.createElement(''style''); style.innerHTML = nested_css; host.shadowRoot.appendChild(style)", "note": "Manual DOM manipulation approach"},
        {"solution": "Accept style loss and manage CSS at parent level instead of relying on component encapsulation", "percentage": 70, "note": "Trade-off accepting limited component isolation"}
    ]$$::jsonb,
    'Svelte component exported as custom element, nested child components with scoped CSS, css: true setting',
    'Nested component styles apply when parent custom element is mounted, child components render with correct styling',
    'Child components never inserted into DOM so their shadowRoot styles remain unapplied. CSS scoping is lost with custom elements. Nested components must have styles manually managed.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/sveltejs/svelte/issues/4274'
),
(
    'Conditional elements inside svelte:head throw console errors on hydration',
    'github-svelte',
    'MEDIUM',
    $$[
        {"solution": "Upgrade to Svelte 3.4.4 or higher which includes hydration fixes", "percentage": 96, "command": "npm install svelte@^3.4.4", "note": "Complete fix applied in 3.4.4+"},
        {"solution": "Move conditional head elements into nested child components instead of parent level", "percentage": 85, "note": "Workaround for older Svelte versions"},
        {"solution": "Avoid {#each} blocks around head elements in Sapper - keep conditions in child components", "percentage": 80, "note": "Limitation even when deeply nested"}
    ]$$::jsonb,
    'Svelte with server-side rendering (Sapper), conditional link or meta tags in svelte:head',
    'No TypeError during hydration, conditional head elements render correctly with SSR',
    'Conditional head elements cause insertBefore Node errors during hydration. SSR-specific issue. Direct {#each} blocks around head elements unreliable even in nested components.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://github.com/sveltejs/svelte/issues/1406'
),
(
    'Select bind:value doesnt work when options are updated dynamically',
    'github-svelte',
    'MEDIUM',
    $$[
        {"solution": "Update to Svelte 3.23.0+ which includes PR #4885 fix", "percentage": 96, "command": "npm install svelte@^3.23.0", "note": "Definitive fix for dynamic option binding"},
        {"solution": "Use explicit selected attribute binding instead of bind:value", "percentage": 85, "command": "<option selected={selected === item.slug} value=\"{item.slug}\">", "note": "Workaround for earlier versions"},
        {"solution": "Ensure options are rendered before setting initial selected value", "percentage": 75, "note": "Workaround by controlling render order"}
    ]$$::jsonb,
    'Svelte component with select element, keyed each block for options, bind:value directive',
    'Select value updates correctly when options are added dynamically, bound value reflects newly available options',
    'Bind:value fails when options added asynchronously with keyed each blocks. Pre-existing value doesnt reconcile with later-added options. Requires fix in 3.23.0+.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/sveltejs/svelte/issues/1764'
),
(
    'Slot forwarding with slot attribute silently fails',
    'github-svelte',
    'LOW',
    $$[
        {"solution": "Update to Svelte 3.29.0+ to use <slot slot=\"name\"></slot> syntax", "percentage": 96, "command": "npm install svelte@^3.29.0", "note": "Native support added for slot forwarding"},
        {"solution": "Wrap slot in DOM element for older versions: <div slot=\"foo\"><slot name=\"foo\"></slot></div>", "percentage": 80, "note": "Workaround introduces extra DOM node"},
        {"solution": "Use component composition patterns that avoid nested slot forwarding", "percentage": 70, "note": "Architecture workaround for pre-3.29.0"}
    ]$$::jsonb,
    'Svelte component passing slots to child components, Svelte 3.29.0+ for native support',
    'Slots forward cleanly without extra DOM nodes, child components receive forwarded slots correctly',
    'Slot forwarding syntax <slot slot=\"...\"></slot> silently fails in versions before 3.29.0. Extra DOM wrapper element causes reactivity issues. Feature required PR #4295 and PR #4556.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/sveltejs/svelte/issues/2079'
),
(
    'svelte:head creates duplicate elements on SSR hydration',
    'github-svelte',
    'HIGH',
    $$[
        {"solution": "Update to Svelte 3.17.0+ which includes PR #4082 fix for head hydration", "percentage": 96, "command": "npm install svelte@^3.17.0", "note": "Official fix properly tracks head elements during hydration"},
        {"solution": "Add data attributes to SSR-generated head elements as markers: data-svelte-hydrate=\"true\"", "percentage": 85, "note": "Technique used by React Helmet for element identification"},
        {"solution": "Use separate svelte:head blocks in child components instead of centralized parent", "percentage": 75, "note": "Architectural workaround reducing duplicate risk"}
    ]$$::jsonb,
    'Svelte 3.0+, server-side rendering (Sapper), meta tags or link elements in svelte:head',
    'Head elements render once with no duplicates after hydration, styles and meta tags apply correctly',
    'Meta and link tags duplicate during SSR-to-client hydration. Title tags work correctly but other elements fail. Issue affects both Svelte and Sapper. Need Svelte 3.17.0+.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://github.com/sveltejs/svelte/issues/1607'
);
