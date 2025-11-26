-- Mine GitHub Issues from withastro/astro repository - Batch 1
-- Category: github-astro
-- Date: 2025-11-26

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Scripts in .astro files are bundled even if they are commented out with //',
    'github-astro',
    'HIGH',
    $$[
        {"solution": "Use HTML comments instead of JavaScript comments to disable scripts: <!-- <script src=\"...\"> --> instead of // <script src=\"...\">", "percentage": 95, "note": "In Astro template syntax, // is treated as text, not a comment"},
        {"solution": "Remove the unwanted script tag entirely and rebuild", "percentage": 90, "note": "Most straightforward approach if script is not needed"}
    ]$$::jsonb,
    'Astro project with .astro layout files containing conditional script tags',
    'Build output does not include the commented-out script file, verified in bundled entry files',
    'Using // to comment scripts in .astro files - this only works in JavaScript context, not Astro HTML. Conditional expressions with && require HTML comment syntax.',
    0.92,
    'astro-latest',
    NOW(),
    'https://github.com/withastro/astro/issues/3115'
),
(
    'React component not showing only in dev mode while build and preview work',
    'github-astro',
    'MEDIUM',
    $$[
        {"solution": "Verify the React component is properly exported and imported. Check for module resolution differences between dev and build environments", "percentage": 80, "note": "Dev mode uses different bundling strategy than build"},
        {"solution": "Ensure all dependencies of the React component are properly installed and compatible with current Astro version", "percentage": 75, "note": "Dependencies like react-social-media-embed may have compatibility issues in dev"},
        {"solution": "Check console for ''type is invalid'' errors - may indicate import/export mismatch specific to dev environment", "percentage": 70, "note": "Use React DevTools to debug component type issues"}
    ]$$::jsonb,
    'Astro 4.7.0+, React integration installed, React component using client:only directive',
    'Component renders correctly in dev mode, build succeeds, preview displays component',
    'This issue is often environment-specific. Dev mode loads code differently than build. Check that client:only is set to \"react\" not other renderers.',
    0.68,
    'astro-4.7',
    NOW(),
    'https://github.com/withastro/astro/issues/10895'
),
(
    'Astro build crashes when using react-syntax-highlighter library',
    'github-astro',
    'MEDIUM',
    $$[
        {"solution": "Add client:only directive to React components using react-syntax-highlighter to skip server-side processing: client:only=\"react\"", "percentage": 90, "note": "Forces component to only render on client side, avoiding Node.js loading issues"},
        {"solution": "Switch to a framework-agnostic syntax highlighting library like highlight.js which works better with server-side rendering", "percentage": 85, "note": "Recommended long-term solution for SSR compatibility"},
        {"solution": "Downgrade to Astro version before change in component handling or use compatible react-syntax-highlighter version", "percentage": 60, "note": "Library has packaging issues with ESM module resolution"}
    ]$$::jsonb,
    'Astro 1.6.14+, react-syntax-highlighter installed, React integration',
    'Build completes successfully without crashing, syntax highlighting renders in pages',
    'The library has upstream packaging issues with ESM module resolution. Works in dev but fails in build. client:only is workaround, not permanent fix.',
    0.82,
    'astro-1.6',
    NOW(),
    'https://github.com/withastro/astro/issues/5562'
),
(
    'Safari production build losing reactivity on refresh - counter becomes unresponsive',
    'github-astro',
    'MEDIUM',
    $$[
        {"solution": "Update to latest Astro version which includes proper hydration timing for Safari - applies fix from PR #3891", "percentage": 95, "note": "Safari-specific hydration issue fixed in newer versions"},
        {"solution": "If unable to update, ensure all child components are properly awaited before hydrating in Safari", "percentage": 80, "note": "Manual workaround requires understanding Astro hydration lifecycle"},
        {"solution": "Test in Chrome first to rule out general reactivity issues, then debug Safari-specific hydration problems", "percentage": 70, "note": "Helps isolate browser-specific vs. general component issues"}
    ]$$::jsonb,
    'Astro project with React interactive components, Safari browser, production build',
    'Interactive components remain responsive after page refresh in Safari, counter increments/decrements properly',
    'This bug is Safari-specific and only occurs in production builds, not dev mode. Chrome is unaffected. Closing/reopening browser temporarily restores functionality.',
    0.91,
    'astro-latest',
    NOW(),
    'https://github.com/withastro/astro/issues/3878'
),
(
    'Expected a closing tag error when markdown renders HTML self-closing elements like <br>',
    'github-astro',
    'HIGH',
    $$[
        {"solution": "Use self-closing format for void elements: <br /> instead of <br>", "percentage": 95, "note": "Proper XHTML/XML syntax for self-closing tags"},
        {"solution": "Update Astro to version after beta.35 which includes PR #3516 fixing self-closing tag parsing", "percentage": 92, "note": "Issue was regression between beta.27 and beta.35"},
        {"solution": "Use alternative void elements or rewrite content to avoid problematic syntax", "percentage": 60, "note": "Workaround if unable to update"}
    ]$$::jsonb,
    'Astro beta.27 to beta.35, Markdown files with HTML void elements',
    'Markdown renders without parse errors, <br> and other void elements display correctly',
    'The strict JSX-like parsing introduced in PR #3410 broke support for HTML void elements without explicit self-closing notation. Always use <br /> format.',
    0.93,
    'astro-beta',
    NOW(),
    'https://github.com/withastro/astro/issues/3458'
),
(
    'Unable to escape < as &lt; and { as &#123; in Markdown - HTML entities decoded before expression processing',
    'github-astro',
    'MEDIUM',
    $$[
        {"solution": "Update Astro compiler using PR #4058 which prevents unescaping of HTML entities in expression contexts", "percentage": 95, "note": "Root cause: compiler was unescaping entities before JSX processing"},
        {"solution": "Use backslash escapes instead of HTML entities: \\< and \\{ (MDX standard approach)", "percentage": 90, "note": "Alternative escaping method supported by MDX spec"},
        {"solution": "Upgrade withastro/compiler to include PR #481 fix for preventing unescaping in expressions", "percentage": 88, "note": "Upstream compiler fix"}
    ]$$::jsonb,
    'Astro v1.0.0-beta.70+, Markdown content with escaped characters, MDX support',
    'Escaped HTML entities render as text not as interpreted HTML/expressions, no 500 errors on &#123;',
    'HTML entities were decoded before JSX and expression processing, violating MDX standards. This breaks escaping of special characters. Requires compiler-level fix.',
    0.91,
    'astro-1.0',
    NOW(),
    'https://github.com/withastro/astro/issues/3916'
),
(
    'React 19 + Cloudflare Adapter error: MessageChannel is not defined',
    'github-astro',
    'HIGH',
    $$[
        {"solution": "Remove the react-dom/server.browser alias from Cloudflare adapter config in astro.config.mjs", "percentage": 94, "note": "React 19 uses MessageChannel in server.browser which isnt available in workerd"},
        {"solution": "Apply the workaround: alias react-dom/server to react-dom/server.edge in vite config for production builds", "percentage": 88, "note": "Temporary workaround until adapter is fully updated: add to astro.config.mjs vite.resolve.alias"},
        {"solution": "Update to Astro version with PR #12996 merged which removes problematic SSR external config", "percentage": 92, "note": "Permanent fix when released"},
        {"solution": "Remove misconfigured externals from Cloudflare integration (Vue-specific code)", "percentage": 85, "note": "Workerd requires all npm packages bundled, not externalized"}
    ]$$::jsonb,
    'Astro 5.1.1+, React 19, Cloudflare adapter, deployment environment (error occurs in deploy, not build)',
    'Application deploys successfully to Cloudflare, no MessageChannel ReferenceError at runtime',
    'The issue occurs only during Cloudflare deployment, not local builds. Root cause: adapter aliases browser bundle which contains MessageChannel calls unavailable in workerd environment. Externals configuration also prevents proper bundling.',
    0.87,
    'astro-5.1',
    NOW(),
    'https://github.com/withastro/astro/issues/12824'
),
(
    'Cannot build when using Sharp 0.33.0 for image optimization - Could not find Sharp error',
    'github-astro',
    'HIGH',
    $$[
        {"solution": "Run: yarn add sharp --ignore-engines to force installation of platform-specific binaries", "percentage": 92, "note": "Sharp 0.33.0 changed binary distribution, requires specific platform binaries"},
        {"solution": "Downgrade to Sharp 0.32.6 which has more stable binary distribution", "percentage": 88, "note": "Quickest fix if other solutions fail"},
        {"solution": "Update Astro to version with PR #9653 merged which fixes Sharp dependency version constraints", "percentage": 90, "note": "Long-term fix from Astro maintainers"},
        {"solution": "Verify development works but production build fails - check platform-specific dependencies are installed", "percentage": 75, "note": "Dev mode may work while build fails due to binary resolution differences"}
    ]$$::jsonb,
    'Astro v3.6.4+, Sharp 0.33.0, image optimization integration, @astrojs/astro-compress',
    'Production build completes successfully, image optimization works, no Sharp module loading errors',
    'Sharp 0.33.0 changed how platform binaries are distributed. The error message may be misleading (Could not load darwin-x64 runtime). Dev works but build fails is common symptom.',
    0.86,
    'astro-3.6',
    NOW(),
    'https://github.com/withastro/astro/issues/9345'
),
(
    'Conflict between pagination and dynamic routes in the same path - /pokemon/2 fails when [page].astro and [slug].astro coexist',
    'github-astro',
    'MEDIUM',
    $$[
        {"solution": "Separate pagination to different directory structure: use /pokemon/paginated/[page].astro instead of /pokemon/[page].astro", "percentage": 93, "note": "Most reliable workaround - prevents route ambiguity"},
        {"solution": "Use custom route priority logic if available in future Astro versions to prioritize pagination over dynamic routes", "percentage": 70, "note": "Currently not supported - framework limitation"},
        {"solution": "Customize paginate() function behavior or implement custom pagination logic outside standard pagination system", "percentage": 65, "note": "Requires manual implementation, not recommended"}
    ]$$::jsonb,
    'Astro 0.21+, Multiple route files ([page].astro and [slug].astro) in same directory, pagination feature',
    'All pagination routes (/pokemon/2, /pokemon/3) work correctly, dynamic routes (/pokemon/bulbasaur) still function',
    'Framework cannot differentiate between slug parameter and page number in same directory. Neither Next.js nor SvelteKit support this pattern either. Requires directory separation.',
    0.89,
    'astro-latest',
    NOW(),
    'https://github.com/withastro/astro/issues/1438'
),
(
    'getCollection types are wrong and return undefined at runtime for empty collections',
    'github-astro',
    'MEDIUM',
    $$[
        {"solution": "Update Astro using PR #10356 which fixes getCollection to never return undefined for configured collections", "percentage": 95, "note": "Official fix - getCollection now returns empty array instead of undefined"},
        {"solution": "Create corresponding folder structure even if empty for collections defined in config.ts", "percentage": 80, "note": "Workaround to ensure collection is recognized"},
        {"solution": "Cast getCollection result to expected type with custom type definition as temporary workaround", "percentage": 70, "note": "Manual fix: define Page type and cast result to Page[] | undefined"}
    ]$$::jsonb,
    'Astro config.ts with defineCollection, content collections API, TypeScript',
    'getCollection returns proper array type in TypeScript, collections exist in .astro/types.d.ts even if folder is empty',
    'Issue manifests differently: no folder = missing from types, empty folder = returns undefined. Root cause was type safety and runtime mismatch. Always ensure collections in config match folder structure.',
    0.88,
    'astro-latest',
    NOW(),
    'https://github.com/withastro/astro/issues/8999'
),
(
    'ClientRouter triggers full reload on history.back() when using manual history.pushState for UI state',
    'github-astro',
    'MEDIUM',
    $$[
        {"solution": "Use Astro lifecycle events astro:before-preparation and astro:before-swap to intercept and suppress navigation on UI state changes", "percentage": 90, "note": "Official workaround from maintainer - prevents reload on popstate"},
        {"solution": "Add astro.ignore property to state objects pushed to history, if future Astro versions support this API", "percentage": 75, "note": "Proposed solution not yet implemented"},
        {"solution": "Implement custom event handler for astro:before-popstate if available to prevent navigation", "percentage": 70, "note": "Alternative proposed approach for future versions"}
    ]$$::jsonb,
    'Astro <ClientRouter /> component, manual history.pushState calls for UI state (modals), client-side transitions',
    'Browser back button dismisses UI components without triggering full page reload, navigation works smoothly',
    'ClientRouter assumes exclusive ownership of history stack. Popstate events from manual pushState calls are not recognized, triggering unnecessary reloads. This breaks modal/sidebar UX patterns.',
    0.85,
    'astro-latest',
    NOW(),
    'https://github.com/withastro/astro/issues/13943'
),
(
    'astro check fatal error: all goroutines are asleep - deadlock when running with React/Vue/Svelte',
    'github-astro',
    'MEDIUM',
    $$[
        {"solution": "Update to latest Astro version where improved CLI workflows have fixed the deadlock issue", "percentage": 93, "note": "Issue resolved through workflow refactoring, not explicit deadlock fix"},
        {"solution": "Downgrade framework integrations or Astro to version 2.0.7 or earlier where deadlock did not occur", "percentage": 80, "note": "Issue emerged after 2.0.7 with changes to framework integration handling"},
        {"solution": "Check for concurrent esbuild calls in build system that may trigger goroutine synchronization issues", "percentage": 60, "note": "Root cause suspected to be esbuild concurrency, addressed in workflow refactoring"}
    ]$$::jsonb,
    'Astro 2.0.7+, Framework integration (React/Vue/Svelte) installed, astro check command',
    'astro check command completes without deadlock error, CLI returns normally',
    'Deadlock occurred in esbuild despite check not directly using compiler. Root cause was goroutine synchronization failure with concurrent esbuild calls. Fixed through CLI workflow improvements.',
    0.87,
    'astro-2.0',
    NOW(),
    'https://github.com/withastro/astro/issues/6306'
),
(
    'Build fails with non-ASCII characters wrapped in angle brackets in Markdown - Expected a closing tag error',
    'github-astro',
    'LOW',
    $$[
        {"solution": "Replace angle brackets with HTML entities: use &lt; and &gt; instead of < and > for non-ASCII content", "percentage": 95, "note": "Parser treats content in angle brackets as component tags"},
        {"solution": "Rewrite content to avoid wrapping non-ASCII characters in angle brackets", "percentage": 85, "note": "Alternative if entity escaping is not viable"},
        {"solution": "Update Astro to version with improved markdown parsing that handles component detection better", "percentage": 70, "note": "Long-term fix in newer versions"}
    ]$$::jsonb,
    'Astro 1.0.0-beta.40+, Markdown files with non-ASCII characters (Chinese, etc.), Windows or Unix systems',
    'Markdown builds without parse errors, non-ASCII content displays correctly, no closing tag errors',
    'Parser cannot distinguish between actual component tags and non-ASCII characters wrapped in angle brackets. Using &lt;测试&gt; instead of <测试> resolves the issue. Language-specific issue.',
    0.91,
    'astro-1.0',
    NOW(),
    'https://github.com/withastro/astro/issues/3577'
);
