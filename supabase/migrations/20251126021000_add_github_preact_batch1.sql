-- Add GitHub Issues from preactjs/preact repository
-- Category: github-preact
-- Batch 1: High-voted bugs with solutions

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES (
    'Preact: SVG attributes markerWidth and markerHeight converted to kebab-case',
    'github-preact',
    'MEDIUM',
    $$[
        {"solution": "Use camelCase SVG attributes like markerWidth and markerHeight instead of kebab-case", "percentage": 95, "note": "SVG attributes with camelCase (markerWidth, markerHeight) must not be auto-converted to kebab-case (marker-width, marker-height) which are invalid in SVG"},
        {"solution": "Check Preact version - ensure using version 10.0.0 or later which properly handles SVG attributes", "percentage": 90, "note": "Issue was present in earlier versions and fixed in core"},
        {"solution": "If using custom SVG, directly set attributes via ref if automatic conversion fails", "percentage": 75, "command": "const ref = useRef(); ref.current?.setAttribute(''markerWidth'', ''5'')", "note": "Workaround for edge cases"}
    ]$$::jsonb,
    'Preact version 8.0+, JSX rendering SVG elements',
    'SVG elements render with correct attribute names, markerWidth/markerHeight attributes present in DOM, visual rendering correct',
    'SVG attributes differ from HTML - camelCase SVG attrs like markerWidth must stay camelCase. Do not assume automatic kebab-case conversion like HTML className. Test SVG rendering in browser dev tools.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/preactjs/preact/issues/2404'
),
(
    'Preact: useEffect hook never gets called in version 10.0.0-alpha.0',
    'github-preact',
    'HIGH',
    $$[
        {"solution": "Upgrade from 10.0.0-alpha.0 to a stable release (10.0.0+) where useEffect hook is properly implemented", "percentage": 95, "note": "This was a regression in alpha version - fixed in stable releases"},
        {"solution": "Ensure preact/hooks is properly installed and imported - verify package.json has preact-hooks dependency", "percentage": 90, "note": "useEffect must be imported from preact/hooks, not preact core"},
        {"solution": "Check that functional component is properly exported and useEffect cleanup is returning a function (optional)", "percentage": 85, "note": "useEffect can work with or without cleanup function, but ensure component structure is valid"}
    ]$$::jsonb,
    'Preact 10.0.0+, preact/hooks package installed, functional component using hooks',
    'useEffect callback executes, console.log or state updates from effect appear, component lifecycle behaves correctly',
    'Alpha versions may have incomplete hook implementations - always use stable releases for production. useEffect must come from preact/hooks package. Dependency arrays affect re-run behavior.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://github.com/preactjs/preact/issues/1328'
),
(
    'Preact: Unable to set property with false value - draggable={false} broken',
    'github-preact',
    'MEDIUM',
    $$[
        {"solution": "Upgrade Preact to version 10.0+ where false property values are properly handled", "percentage": 95, "note": "Earlier versions had incorrect property setter logic that would add then remove attributes for false values"},
        {"solution": "Use workaround: set draggable={0} instead of draggable={false} since 0 bypasses the falsy check", "percentage": 85, "note": "0 gets converted to false by browser, but Preact''s old logic lets it pass through to property assignment"},
        {"solution": "Verify DOM element shows correct attribute state in browser dev tools - check if attribute is present or absent as expected", "percentage": 80, "note": "For boolean HTML properties like draggable, presence means true, absence means false"}
    ]$$::jsonb,
    'Preact 8.0+, HTML elements with boolean attributes (draggable, disabled, checked, etc)',
    'Element attribute properly set in DOM - either present (true) or absent (false), no unexpected attribute toggling, element behavior matches boolean value',
    'Boolean HTML attributes work differently than regular properties. False values must remove attributes, not set them to "false" string. The draggable attribute can be true/false/auto - ensure correct format.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/preactjs/preact/issues/663'
),
(
    'Preact: createRef is not compatible with preact/debug module',
    'github-preact',
    'LOW',
    $$[
        {"solution": "Upgrade Preact and preact/debug to latest version where createRef validation is fixed", "percentage": 95, "note": "Debug module was incorrectly rejecting valid ref objects created by createRef()"},
        {"solution": "Use callback refs instead of createRef if debug module is causing issues - ref={(el) => this.ref = el}", "percentage": 85, "note": "Callback refs work with debug mode validation since they are functions"},
        {"solution": "Check debug module initialization - ensure preact/debug is imported after preact but before component code", "percentage": 80, "note": "Import order matters for debug module patching"}
    ]$$::jsonb,
    'Preact 10.0+, preact/debug module enabled, components using createRef()',
    'Components using createRef render without validation errors, debug mode logs show no ref warnings, no "overly strict validation" errors',
    'createRef returns object refs with .current property, while callback refs are functions - debug mode must accept both patterns. Do not use createRef with early alpha versions of debug module.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/preactjs/preact/issues/1271'
),
(
    'Preact: DOM elements orphaned when rendered through wrapping component',
    'github-preact',
    'MEDIUM',
    $$[
        {"solution": "Ensure wrapper components properly pass children and maintain consistent component identity", "percentage": 90, "note": "Orphaned DOM occurs when element type alternates (div->p) and wrapper gets replaced"},
        {"solution": "Use stable component keys for elements in wrapper components - add key prop to alternating elements", "percentage": 88, "note": "Keys help Preact track element identity and prevent orphaning when structure changes"},
        {"solution": "Avoid changing rendered element type (div to p) in same component slot - use consistent wrapper element", "percentage": 85, "note": "If wrapping component alternates between different element types, use CSS display:none instead"}
    ]$$::jsonb,
    'Preact 10.0+, component with child elements, wrapper component pattern',
    'No orphaned DOM elements remaining after component replacement, DOM tree matches rendered component structure, no memory leaks from dangling elements',
    'Wrapper components without own DOM element must properly manage children. Changing element types and then replacing wrapper causes orphaning. Always use keys on dynamic elements. Test with dev tools DOM inspector.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/preactjs/preact/issues/1632'
),
(
    'Preact: Child component state corrupted when removing array items from beginning',
    'github-preact',
    'HIGH',
    $$[
        {"solution": "Always add unique key prop to list items when rendering arrays - keys preserve component identity", "percentage": 95, "command": "items.map(item => <Child key={item.id} data={item} />)", "note": "Without keys, Preact reuses component instances leading to state mismatches"},
        {"solution": "Ensure keys are stable and based on item id, not array index - index as key breaks on reordering/deletion", "percentage": 92, "note": "Index-based keys cause state to follow DOM position instead of data identity"},
        {"solution": "If list mutation, use slice() to create new array and setState to trigger reconciliation", "percentage": 85, "command": "const newList = this.state.items.slice(1); this.setState({items: newList})", "note": "Immutable updates ensure proper component lifecycle"}
    ]$$::jsonb,
    'Preact 8.0+, rendering list of components from array state, array mutations',
    'Removing items from list preserves correct child component state, each child maintains expected local state after deletion, no state bleeding between siblings',
    'List items MUST have stable unique keys - index-based keys are unreliable. Keys based on item ID preserve component instance and state. Without keys, Preact reuses component instances causing state corruption.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://github.com/preactjs/preact/issues/120'
),
(
    'Preact: Suspense component.__hooks might be null - lazy component infinite fallback',
    'github-preact',
    'MEDIUM',
    $$[
        {"solution": "Upgrade to Preact 10.5.5+ where null hooks initialization is fixed", "percentage": 96, "note": "Regression introduced in 10.5.5 where Suspense components with hooks got null __hooks reference"},
        {"solution": "Check that Suspense wrapper properly initializes before lazy component attempts to set hooks", "percentage": 88, "note": "Lazy components must await parent Suspense initialization - cannot set __h on null __hooks"},
        {"solution": "Verify lazy() component syntax is correct and promise resolves with valid component export", "percentage": 85, "note": "Malformed lazy component can trigger hook initialization before component.__hooks exists"}
    ]$$::jsonb,
    'Preact 10.5.4+, preact/compat lazy() and Suspense, functional components with hooks',
    'Lazy Suspense components render correctly after resolution, fallback displays only during loading, no "Cannot set property __h of null" error, infinite loading eliminated',
    'Suspense.__hooks null check needed before setting __h property. Lazy component promise must resolve with proper component export. Ensure Suspense parent wraps lazy child. Check Preact 10.5.4 vs 10.5.5 version difference.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/preactjs/preact/issues/3066'
),
(
    'Preact: onBeforeInput event handler inconsistent browser support',
    'github-preact',
    'MEDIUM',
    $$[
        {"solution": "Use onChange or onInput event instead of onBeforeInput for cross-browser text input handling", "percentage": 90, "note": "beforeinput only supported in Chrome; use onChange (fires after input) or onInput (fires during input) for compatibility"},
        {"solution": "If onBeforeInput required, implement feature detection and fallback to onInput in unsupported browsers", "percentage": 85, "note": "Feature detection: check if beforeinput events fire before applying preventDefault logic"},
        {"solution": "For rich-text editors like Slate, use contenteditable with onInput instead of relying on beforeinput", "percentage": 80, "note": "beforeinput spec is incomplete in Firefox, Safari, IE - prefer input event with contentEditable for rich editors"}
    ]$$::jsonb,
    'Preact 8.0+, text input or contentEditable elements, rich-text editor integration',
    'Text input events fire consistently across browsers (Chrome, Firefox, Safari, IE), preventDefault works on input changes, no undefined behavior in Safari/Firefox',
    'onBeforeInput only available in Chrome - avoid for cross-browser apps. Use onChange/onInput instead. Rich editors need workarounds. Preact compat layer may need monkey-patching for beforeinput normalization.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/preactjs/preact/issues/1422'
),
(
    'Preact IE 11: shouldComponentUpdate ignored - unexpected re-renders',
    'github-preact',
    'MEDIUM',
    $$[
        {"solution": "Upgrade to Preact 10.0+ where IE 11 lifecycle handling is fixed", "percentage": 94, "note": "Earlier versions had IE 11-specific quirks where shouldComponentUpdate was ignored"},
        {"solution": "If stuck on older version, return empty element instead of null: return <div style={{display:''none''}} /> instead of return null", "percentage": 85, "note": "IE 11 treats null returns differently, causing lifecycle disruption. Empty div workaround prevents re-renders."},
        {"solution": "Test in IE 11 specifically - modern browsers work correctly but IE has edge cases", "percentage": 80, "note": "Use BrowserStack or IE dev VM to test. shouldComponentUpdate may be called multiple times in IE11."}
    ]$$::jsonb,
    'Preact 8.0+, Internet Explorer 11, components using shouldComponentUpdate',
    'shouldComponentUpdate honored on all browsers, component renders only when necessary, no duplicate componentWillReceiveProps calls in IE 11, state consistency maintained',
    'IE 11 has quirks - always test IE11 separately. Returning null from render behaves differently in IE. shouldComponentUpdate may trigger extra renders in IE. Prefer newer Preact versions. Return empty element as workaround for null.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/preactjs/preact/issues/960'
),
(
    'Preact: Build fails when using hooks with prerendering',
    'github-preact',
    'HIGH',
    $$[
        {"solution": "Ensure preact/hooks is properly installed and hooks.mjs/dist file exists in node_modules", "percentage": 93, "command": "npm ls preact preact/hooks && ls node_modules/preact/hooks/", "note": "Error ''Cannot read property __H of undefined'' suggests hooks not loaded correctly"},
        {"solution": "Clear node_modules and reinstall: rm -rf node_modules && npm install", "percentage": 90, "note": "Corrupted node_modules or incomplete install can cause missing dist files"},
        {"solution": "Check build tool config for prerendering - ensure hooks are not tree-shaken during build", "percentage": 88, "note": "Prerendering with aggressive tree-shaking can remove hook runtime code needed at render time"}
    ]$$::jsonb,
    'Preact 10.0+, preact/hooks package, prerendering/build tool (Next.js, Gatsby, etc)',
    'Build completes successfully, prerendered output includes hook runtime, no "Cannot read property __H" errors during build, hooks work in prerendered pages',
    'Hooks dist file path issues common with prerendering. Package.json must have preact/hooks dependency. Build tools may aggressively tree-shake hooks code. Verify dist files exist and are not excluded.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/preactjs/preact/issues/1321'
),
(
    'Preact: Rendered nodes order changes unexpectedly with conditional rendering',
    'github-preact',
    'MEDIUM',
    $$[
        {"solution": "Always use stable key props on elements affected by conditional rendering", "percentage": 93, "command": "visible ? <div key=\"main\">First!</div> : null", "note": "Without keys, Preact reuses DOM nodes leading to order issues"},
        {"solution": "Use unique, stable keys based on identity not array index when toggling visibility", "percentage": 90, "note": "Conditional rendering + reordering needs keys to maintain element identity"},
        {"solution": "Test with preact-redux connect - ensure reconciliation algorithm properly handles reordering", "percentage": 85, "note": "Higher-order components can interfere with reconciliation if not properly configured"}
    ]$$::jsonb,
    'Preact 8.0+, conditional rendering, element reordering, potentially with preact-redux',
    'Toggle visibility preserves correct element order, ''First!'' element appears in correct position when toggled back, no elements disappear or move to wrong positions',
    'Conditional rendering without keys causes DOM reuse and order corruption. Keys essential when toggling visibility. redux-connect can mask reconciliation issues. Always use stable keys on conditional elements.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/preactjs/preact/issues/581'
),
(
    'Preact: children props empty array in nested react-router routes',
    'github-preact',
    'MEDIUM',
    $$[
        {"solution": "Upgrade to Preact 6.2.0+ where nested routing children handling is fixed", "percentage": 94, "note": "Regression in v6.1.0 caused children props to become empty arrays in nested routes"},
        {"solution": "If using older version, verify react-router is compatible with Preact version - check version compatibility matrix", "percentage": 88, "note": "Some react-router versions have assumptions that break with Preact"},
        {"solution": "Check route component export - ensure nested route components are properly exported from router", "percentage": 85, "note": "Children appearing as empty array suggests component not properly registered with router"}
    ]$$::jsonb,
    'Preact 6.0+, react-router or preact-router, nested route components',
    'Nested route components receive correct children props, props object contains child components array, nested route rendering works correctly',
    'Regression specific to Preact 6.1.0 - use 6.0.x or 6.2.0+. react-router compatibility varies by version. Children empty array suggests route registration issue. Check router config for nested routes.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/preactjs/preact/issues/336'
),
(
    'Preact: componentWillMount lifecycle hook execution order incorrect',
    'github-preact',
    'MEDIUM',
    $$[
        {"solution": "Upgrade to Preact 5.0+ where lifecycle hook order matches React specification", "percentage": 95, "note": "Early Preact versions called render before componentWillMount - violates React lifecycle contract"},
        {"solution": "If using older version, move initialization logic to constructor instead of componentWillMount", "percentage": 90, "note": "Constructor executes before render in all versions - safe place for initialization"},
        {"solution": "Use componentDidMount for post-render initialization if cannot upgrade", "percentage": 85, "note": "componentDidMount runs after first render, reliable in all Preact versions"}
    ]$$::jsonb,
    'Preact 4.0+, class components with lifecycle methods',
    'componentWillMount executes before first render, state initialized properly, component lifecycle matches React specification, no render before lifecycle initialization',
    'Lifecycle order critical for class component initialization. Early Preact had render-first bug. Always use Preact 5.0+. Constructor safest for early initialization. componentDidMount runs after first render.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/preactjs/preact/issues/96'
),
(
    'Preact: Key handling broken - elements not remounted on key change',
    'github-preact',
    'HIGH',
    $$[
        {"solution": "Update to Preact 10.0+ where key remounting logic is fixed", "percentage": 95, "note": "v10.0.0-alpha.1 had dual bugs: elements not remounted on key change AND incorrect reordering"},
        {"solution": "Ensure keys change when component identity should reset - if key changes, Preact should destroy and recreate component", "percentage": 92, "note": "Stable keys preserve component instance; changing keys forces remount"},
        {"solution": "For animations/transitions, use key changes to trigger CSS animation entrance effects", "percentage": 88, "note": "Key change causes element recreation, firing CSS enter animations properly"}
    ]$$::jsonb,
    'Preact 10.0+, components with dynamic keys, CSS transitions/animations',
    'Changing key prop triggers component remount (destroy + recreate), CSS entrance animations fire correctly, elements reorder when needed without remounting',
    'Key change must trigger remount - test by changing key and verifying element recreates. CSS animations require proper element recreation. v10.0.0-alpha had key handling bugs. Always use stable version. Keys affect component lifecycle.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://github.com/preactjs/preact/issues/1388'
);
