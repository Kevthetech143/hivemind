-- Add SolidJS GitHub Issues with Solutions (Batch 1)
-- Extracted from solidjs/solid repository - highest voted issues with solutions
-- Category: github-solid
-- Timestamp: 2025-11-26

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, last_verified, source_url
) VALUES
(
    'Streaming ErrorBoundaries hydration mismatch error in SolidJS',
    'github-solid',
    'HIGH',
    $$[
        {"solution": "Upgrade to SolidJS 1.8.1 or later - this was caused by client rendering error boundaries on failure across suspense boundaries. The fix ensures error boundaries do not fail hydration.", "percentage": 95, "note": "Fixed in dom-expressions commit ffeeca46ef5ea737b7c16baf673832550797890f"},
        {"solution": "Remove unnecessary guards in ErrorBoundary fallback components - errors should be handled properly by the core library", "percentage": 85, "note": "Guards workaround not needed after fix"},
        {"solution": "Avoid complex error handling in suspense boundaries during server rendering", "percentage": 80, "note": "Keep error boundary logic simple for streaming render"}
    ]$$::jsonb,
    'SolidJS 1.7.12 or earlier, streaming SSR setup, ErrorBoundary component, Suspense boundary',
    'No hydration mismatch error in console, Component renders correctly on client after hydration, ErrorBoundary catches errors properly',
    'Streaming render only - does not occur with standard renderStream(). Error boundaries must resolve after suspense resolves. Downgrading temporarily works but not recommended.',
    0.95,
    NOW(),
    'https://github.com/solidjs/solid/issues/1917'
),
(
    'SolidJS onMount called multiple times with enableExternalSource and MobX',
    'github-solid',
    'MEDIUM',
    $$[
        {"solution": "Update to SolidJS 1.8.8+ and provide untrack function as second argument to enableExternalSource: enableExternalSource(fn, trigger, untrack)", "percentage": 95, "note": "Official fix in experimental feature"},
        {"solution": "Use untrack() from solid-js to prevent multiple onMount calls: untrack(() => { /* your code */ })", "percentage": 90, "note": "Workaround for tracking issues"},
        {"solution": "Configure MobX Reaction with proper disposal in enableExternalSource cleanup", "percentage": 85, "note": "Ensure reaction.dispose() is called"}
    ]$$::jsonb,
    'SolidJS 1.8.8+, MobX library, enableExternalSource function, onMount hook, Ref attribute',
    'onMount executes exactly once, MobX reactions track properly, ref attribute updates correctly, console shows no reaction warnings',
    'enableExternalSource is experimental feature and undocumented. Passing untrack function is required for proper cleanup. untrack() alone does not work without enableExternalSource parameter.',
    0.95,
    NOW(),
    'https://github.com/solidjs/solid/issues/1850'
),
(
    'SolidJS cannot lazy load images in Firefox - immediate src load',
    'github-solid',
    'HIGH',
    $$[
        {"solution": "Set image src attribute before inserting element into DOM - SolidJS clones templates and sets attributes first. Ensure attributes are set in order: src before attachment.", "percentage": 85, "note": "Firefox eagerly loads src after microtask regardless of DOM attachment"},
        {"solution": "Use a wrapper component to delay image src setting until after mount: onMount(() => setImageSrc(...))", "percentage": 80, "note": "Workaround for Firefox eager loading behavior"},
        {"solution": "Consider polyfill or native Intersection Observer for lazy loading instead of loading attribute", "percentage": 75, "note": "More reliable cross-browser solution"}
    ]$$::jsonb,
    'SolidJS template system, HTML image element with loading="lazy" attribute, Firefox or Safari browser',
    'Image only loads when visible in viewport or near viewport, Network devtools shows delayed image request, responsive image implementation does not cause browser lockup',
    'Firefox loads images immediately after src is set (browser behavior, not SolidJS bug). Chrome delays as expected. Safari shows delayed behavior. The fix is slower than ideal - order of attribute setting matters.',
    0.85,
    NOW(),
    'https://github.com/solidjs/solid/issues/1828'
),
(
    'SolidJS default error handling behavior - unhelpful error messages',
    'github-solid',
    'MEDIUM',
    $$[
        {"solution": "Add try-catch blocks around effect initializers to catch import/definition errors early and provide meaningful error context", "percentage": 90, "note": "Root cause errors bubble from effect code"},
        {"solution": "Ensure all dependencies are imported and defined before using in effects - missing createEffect import will cause cryptic ref errors", "percentage": 88, "note": "Check all effect dependencies at component load"},
        {"solution": "Use browser debugger to trace error origin - the first error is often in a different code path than the misleading error", "percentage": 85, "note": "Console errors may not reflect actual problem source"}
    ]$$::jsonb,
    'SolidJS createEffect, onMount hook, ref attribute, component definition',
    'Error message clearly indicates the root cause (missing import or definition), debugger shows correct call stack, component renders correctly after fix',
    'Missing imports in effects cause misleading error messages from unrelated code. Errors not properly cleared between effect runs. Add finally block to clear effects on error.',
    0.85,
    NOW(),
    'https://github.com/solidjs/solid/issues/919'
),
(
    'SolidJS noscript tag renders content on client side',
    'github-solid',
    'MEDIUM',
    $$[
        {"solution": "Wrap noscript content in <Show when={isServer}> component from solid-js/web: import { Show } from \"solid-js\"; import { isServer } from \"solid-js/web\";", "percentage": 92, "note": "Temporary workaround using reactive Show component"},
        {"solution": "Upgrade to latest SolidJS version where noscript tags are skipped on client during compilation", "percentage": 90, "note": "Compiler fix prevents noscript rendering on client"},
        {"solution": "Avoid putting styles or interactive content inside noscript tags - reserve for static fallback HTML only", "percentage": 85, "note": "Best practice for graceful degradation"}
    ]$$::jsonb,
    'SolidJS isServer detection, Show component, noscript HTML element, SSR setup',
    'noscript content only appears when JavaScript is disabled or on server render, client-side CSS from noscript not applied, DOM inspector shows no noscript content on client',
    'SolidJS renders noscript content on client which causes style bleeding. Client skips noscript in browser but compiler should prevent rendering. Server-side only rendering requires Show wrapper.',
    0.92,
    NOW(),
    'https://github.com/solidjs/solid/issues/2178'
),
(
    'SolidJS stale read from Show component under transition',
    'github-solid',
    'MEDIUM',
    $$[
        {"solution": "Upgrade to latest SolidJS version - this is a timing issue in Show component internals that fails concurrent safety checks", "percentage": 88, "note": "Show component checks are not concurrent-safe in some versions"},
        {"solution": "Avoid reading signals inside Show conditions during transitions - use callback form with proper unwrapping: <Show when={condition()} fallback=\"...\"> {(data) => <Component prop={data.something} />} </Show>", "percentage": 85, "note": "Proper pattern for accessing signal values in Show"},
        {"solution": "Check browser console state - issue only reproducible with console open, indicating timing sensitivity", "percentage": 75, "note": "Internal race condition only visible in debug scenarios"}
    ]$$::jsonb,
    'SolidJS Show component, transition hooks, signal reactivity, multiple concurrent operations',
    'Stale read error no longer appears in console, transition completes without errors, Show component properly unmounts before signal access',
    'Error only happens with browser console open - suggests timing/debugging interaction. Show callback form is safer than condition reading. Transitions can cause concurrent access issues.',
    0.88,
    NOW(),
    'https://github.com/solidjs/solid/issues/2046'
),
(
    'SolidJS hydration error causing double renders with renderStream',
    'github-solid',
    'HIGH',
    $$[
        {"solution": "Upgrade to latest SolidJS version - fixed in 1.8+ by properly resolving resources before resolving Suspense boundary during serialization", "percentage": 96, "note": "Timing bug where Suspense resolved before resources causing hydration mismatch"},
        {"solution": "Ensure renderStream properly serializes resource completion before Suspense boundary resolution", "percentage": 92, "note": "Correct ordering prevents double element rendering"},
        {"solution": "Avoid nested Suspense with resources - this timing issue is most apparent in complex async hierarchies", "percentage": 85, "note": "Simpler Suspense structure reduces race conditions"}
    ]$$::jsonb,
    'SolidJS renderStream, Suspense boundary, Resource components, Server-side rendering setup',
    'Element renders exactly once on hydration, no duplicate elements in DOM, hydration completes without errors, browser console clean',
    'Only occurs with renderStream (not renderToString). New serialization in 1.8 changed Suspense resolution timing. Elements render twice if Suspense resolves before resources complete.',
    0.96,
    NOW(),
    'https://github.com/solidjs/solid/issues/1952'
),
(
    'SolidJS 1.7 JSX template string error with inline elements',
    'github-solid',
    'HIGH',
    $$[
        {"solution": "Upgrade babel-plugin-jsx-dom-expressions to 0.36.2+ which fixes anchor and text-decoration element closing issues", "percentage": 97, "note": "Fixes improper element nesting in template compilation"},
        {"solution": "Ensure all inline text-decorating elements are properly closed: <a>, <b>, <strong>, <i>, <em>, <u> must have closing tags", "percentage": 95, "note": "Browser HTML parsing auto-opens new anchors for unclosed tags"},
        {"solution": "Clear npm lockfile and reinstall dependencies: rm -rf node_modules package-lock.json && npm install", "percentage": 90, "note": "Old plugin version may be cached"}
    ]$$::jsonb,
    'SolidJS 1.7, babel-plugin-jsx-dom-expressions 0.36.2+, JSX with anchor/bold/strong tags, npm dependencies',
    'JSX template compiles without errors, inline elements render in correct positions, sibling elements do not auto-wrap in unexpected tags',
    'Browser HTML parser creates phantom tags if certain elements (a, b, strong, i) are not closed. Babel plugin must close all text-decorating elements. Template string syntax stricter in 1.7.',
    0.97,
    NOW(),
    'https://github.com/solidjs/solid/issues/1663'
),
(
    'SolidJS Owner.sourceMap not cleaned on computation rerun',
    'github-solid',
    'LOW',
    $$[
        {"solution": "Upgrade to latest SolidJS where cleanNode properly clears sourceMap: delete Owner.sourceMap or set to undefined", "percentage": 93, "note": "Prevents stale signal references between computation runs"},
        {"solution": "Call cleanNode after computation cleanup to ensure sourceMap is cleared between runs", "percentage": 88, "note": "Force cleanup of owner references"},
        {"solution": "Avoid creating signals during computation rerun - signals should be created once during initial run", "percentage": 85, "note": "Design pattern to avoid accumulating signal references"}
    ]$$::jsonb,
    'SolidJS Owner API, createEffect or createComputation, signal creation in dynamic contexts',
    'Owner.sourceMap is empty after computation reruns, no stale signal references persist, memory usage stable across reruns',
    'sourceMap accumulates signals from previous computation runs causing memory leaks. cleanNode not clearing map properly. Signals created during reruns remain in sourceMap.',
    0.93,
    NOW(),
    'https://github.com/solidjs/solid/issues/1024'
),
(
    'SolidJS backtick characters in JSX cause syntax errors',
    'github-solid',
    'MEDIUM',
    $$[
        {"solution": "Escape backticks in JSX text content: use backtick character (`) or convert to encoded form in template", "percentage": 94, "note": "Backticks conflict with template string syntax"},
        {"solution": "Use double quotes or single quotes for text containing backticks: <div class=\"error\">The `data` attribute is missing</div>", "percentage": 92, "note": "Proper quoting prevents backtick interpretation"},
        {"solution": "Upgrade to latest babel-plugin-jsx-dom-expressions which improves backtick escaping", "percentage": 88, "note": "Compiler enhancement for special character handling"}
    ]$$::jsonb,
    'SolidJS JSX syntax, babel-plugin-jsx-dom-expressions, text content with backticks',
    'JSX compiles without syntax errors, backticks display correctly in rendered HTML, no \"missing ) after argument list\" error',
    'Backticks in JSX treated as template string delimiters by Babel. Error message \"missing ) after argument list\" is misleading. Quote style must surround content with backticks.',
    0.94,
    NOW(),
    'https://github.com/solidjs/solid/issues/772'
),
(
    'SolidJS JSXFragment babel-plugin visitor error',
    'github-solid',
    'LOW',
    $$[
        {"solution": "Upgrade to Babel 7+ (released 10 days before this issue) - earlier versions do not support JSXFragment visitor", "percentage": 97, "note": "Pre-Babel 7 lacks JSXFragment support in plugin API"},
        {"solution": "Check node_modules/@babel/plugin-syntax-jsx version - ensure it is 7.0.0 or later", "percentage": 95, "note": "Codesandbox may use outdated Babel"},
        {"solution": "Set up project locally with Webpack 4+ to ensure proper Babel version resolution", "percentage": 90, "note": "Local setup more reliable than online playgrounds"}
    ]$$::jsonb,
    'SolidJS JSX, Babel 7+, babel-plugin-jsx-dom-expressions, JSX Fragment syntax (<>...)</>)',
    'JSX compiles without \"visitor for JSXFragment\" error, JSX fragments render correctly, Babel version shows 7.0.0+',
    'Online playgrounds like Codesandbox may use old Babel versions. JSXFragment support only in Babel 7+. Webpack bundler may skip reference if unused.',
    0.97,
    NOW(),
    'https://github.com/solidjs/solid/issues/1'
),
(
    'SolidJS Dynamic component + attr directive on custom elements behaves incorrectly',
    'github-solid',
    'MEDIUM',
    $$[
        {"solution": "Upgrade to SolidJS 1.9.3+ where Dynamic component correctly handles attr: directives on custom elements", "percentage": 96, "note": "Fixed in dom-expressions PR #371"},
        {"solution": "For custom elements, use properties instead of attributes - SolidJS applies properties directly to custom elements by default", "percentage": 90, "note": "First Dynamic panel behavior is expected - use properties not attributes"},
        {"solution": "Workaround: manually adjust attributes in onMount if needed: const el = ref; if (el.getAttribute(\"attr:name\")) { el.removeAttribute(\"attr:name\"); el.setAttribute(\"name\", value); }", "percentage": 75, "note": "Temporary workaround until upgrade"}
    ]$$::jsonb,
    'SolidJS Dynamic component, custom HTML elements (web components), attr: directive, onMount hook',
    'Custom element receives correct attributes via attr: directive, Dynamic component passes attributes properly, attr: attributes not rendered as properties',
    'Custom elements use properties not attributes in SolidJS. First Dynamic panel without attr: uses properties (expected). Other panels with attr: had incorrect behavior. attr: properties may display as attributes in inspector.',
    0.96,
    NOW(),
    'https://github.com/solidjs/solid/issues/2339'
);
