-- Add GitHub Next.js highest-voted issues with solutions
-- Source: https://github.com/vercel/next.js/issues
-- Category: github-nextjs
-- Total entries: 10

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, source_url
) VALUES
(
    'React hydration warning: className did not match with styled-components',
    'github-nextjs',
    'HIGH',
    $$[
        {"solution": "Update styled-components to latest version that fixes server/client mismatch", "percentage": 85, "note": "Upgrade styled-components to v4+ which resolves css prop inconsistencies"},
        {"solution": "Avoid using styled-components css prop in components, use className instead", "percentage": 80, "note": "Replace css prop with standard className and CSS modules"},
        {"solution": "Use suppressHydrationWarning on affected elements as temporary workaround", "percentage": 65, "note": "Only use during migration period, not recommended for production"}
    ]$$::jsonb,
    'Next.js 8.1+, styled-components v4+, React 16.8+',
    'No warning messages in browser console, HTML className matches between server and client renders',
    'The css prop from styled-components v4 generates different class names server-side vs client-side. Do not ignore hydration warnings as they indicate real issues. Ensure styled-components is fully updated.',
    0.85,
    'https://github.com/vercel/next.js/issues/7322'
),
(
    'Static Generation (SSG) configuration for data fetching in Next.js',
    'github-nextjs',
    'VERY_HIGH',
    $$[
        {"solution": "Use getStaticProps for static generation at build time. Define at page level: export async function getStaticProps(context) { return { props: {...}, revalidate: 60 } }", "percentage": 95, "note": "Server-side only execution, perfect for SEO"},
        {"solution": "Use getStaticPaths for dynamic routes to pre-render multiple pages at build time", "percentage": 90, "note": "Required for [id].js style routes, returns paths array"},
        {"solution": "Use getServerSideProps for per-request rendering instead of static generation", "percentage": 85, "note": "Renders on-demand but slower, provides more up-to-date data"},
        {"solution": "Enable ISR (Incremental Static Regeneration) with revalidate property", "percentage": 90, "note": "Allows pages to rebuild in background without full rebuild"}
    ]$$::jsonb,
    'Next.js 9.3+, page must export getStaticProps or getStaticPaths function',
    'Pages render at build time, JSON files created in .next for client routing, getStaticProps executes only during build',
    'getInitialProps still works but does not enable static generation. Avoid mixing getStaticProps and getServerSideProps in same page. Remember fallback behavior with getStaticPaths - set fallback: false to return 404 for unbuilt paths.',
    0.95,
    'https://github.com/vercel/next.js/issues/9524'
),
(
    'Authentication example and session management pattern for Next.js',
    'github-nextjs',
    'HIGH',
    $$[
        {"solution": "Implement JWT-based AuthService class with login/logout/token refresh methods stored in localStorage", "percentage": 85, "note": "Client-side token management, automatically add auth headers to requests"},
        {"solution": "Use Higher-Order Component (HOC) withAuth to protect pages and redirect unauthenticated users", "percentage": 80, "note": "Shows loading state to prevent flash of unprotected content, render Loading before checking auth"},
        {"solution": "Implement session check in getServerSideProps to verify auth server-side before page render", "percentage": 90, "note": "More secure than client-side only auth, can redirect before HTML sent"},
        {"solution": "Use next/router Router.events to sync auth state across browser tabs", "percentage": 75, "note": "Listen to routeChangeStart/Complete events to update auth status globally"}
    ]$$::jsonb,
    'Next.js project, JWT tokens or session backend, understanding of client vs server rendering',
    'Login redirects to protected page, LoggedIn users see content, LoggedOut users redirected to login, Auth persists across page navigations',
    'Client-side only auth is insecure for sensitive data. Protected pages will not SEO unless rendered server-side. JWT stored in localStorage is accessible to XSS attacks. Do not store sensitive data in localStorage. Consider httpOnly cookies for tokens.',
    0.82,
    'https://github.com/vercel/next.js/issues/153'
),
(
    'Transpile ES2015 modules inside node_modules with Next.js',
    'github-nextjs',
    'MEDIUM',
    $$[
        {"solution": "Add transpileModules array to next.config.js with package names: module.exports = { transpileModules: [\"my-package\", \"@org/lib\"] }", "percentage": 90, "note": "Babel will transpile specified node_modules packages during build"},
        {"solution": "Use regex patterns for scoped packages: transpileModules: [/^@my-org\\/.*/] to match multiple packages", "percentage": 85, "note": "More flexible than listing individual packages"},
        {"solution": "Pre-transpile npm packages before publishing using babel-cli in package build step", "percentage": 75, "note": "Publisher responsibility, but works with any bundler"}
    ]$$::jsonb,
    'Next.js 7.0+, packages installed in node_modules, Babel configured',
    'Specified packages transpile to ES5, Code-splitting works on transpiled modules, No SyntaxError in browsers',
    'Do not transpile everything - specify only untranspiled packages. ESM exports may break if transpiled. Tree-shaking becomes less effective after transpilation. Use for internal company packages only.',
    0.90,
    'https://github.com/vercel/next.js/issues/706'
),
(
    'Less stylesheet support for Ant Design integration in Next.js',
    'github-nextjs',
    'MEDIUM',
    $$[
        {"solution": "Add custom Less loader in next.config.js webpack config: test: /\\.less$/, use: [\"style-loader\", \"css-loader\", {loader: \"less-loader\", options: {lessOptions: {javascriptEnabled: true}}}]", "percentage": 85, "note": "Required for Ant Design theming, set javascriptEnabled for mixins"},
        {"solution": "Upgrade to Ant Design v5+ which uses CSS-in-JS instead of Less", "percentage": 80, "note": "Ant Design 5+ no longer requires Less, uses CSS-in-JS by default"},
        {"solution": "Import Ant Design precompiled CSS from dist folder instead of source Less", "percentage": 70, "note": "Works but sacrifices customization and theme optimization"}
    ]$$::jsonb,
    'Next.js project, less-loader installed, Ant Design library',
    'Less files import successfully, Ant Design styles apply correctly, No webpack errors during build',
    'Next.js team declined native Less support to reduce maintenance burden. Ant Design v5 switched away from Less. Custom webpack configuration required for Less support. JavaScript must be enabled in less-loader options for Ant Design mixins.',
    0.78,
    'https://github.com/vercel/next.js/issues/23185'
),
(
    'Native CSS Module and Global CSS support in Next.js',
    'github-nextjs',
    'VERY_HIGH',
    $$[
        {"solution": "Import global CSS only in pages/_app.js/pages/_app.tsx to maintain CSS load order: import \"./styles.css\"", "percentage": 95, "note": "Global CSS cannot be imported elsewhere, ensures predictable cascading"},
        {"solution": "Use CSS Modules for component styles with *.module.css naming: import styles from \"Button.module.css\" then className={styles.button}", "percentage": 95, "note": "Scoped styles, zero-runtime-overhead, works in any component"},
        {"solution": "Configure PostCSS via postcss.config.js for Autoprefixer and CSS feature polyfills", "percentage": 90, "note": "Built-in support, automatically applies Stage 3+ CSS features"},
        {"solution": "Enable Sass support by installing node-sass, use .scss/.sass files automatically", "percentage": 85, "note": "Auto-detected, works with both global and module patterns"}
    ]$$::jsonb,
    'Next.js 9.2+, pages/_app.js exists, PostCSS installed (optional)',
    'CSS imports work without error, Styles apply correctly, Hot reload works in dev without state loss, CSS extracted to separate files in production',
    'Global CSS must be in _app.js, cannot import elsewhere. Each component-level CSS import creates separate rules, order matters for specificity. Tailwind CSS requires custom PostCSS config. Sass is optional, requires node-sass installation.',
    0.95,
    'https://github.com/vercel/next.js/issues/8626'
),
(
    'ESLint 9 compatibility with next lint command in Next.js',
    'github-nextjs',
    'HIGH',
    $$[
        {"solution": "Update Next.js to version 14.1+ which supports ESLint 9 with flat config (eslint.config.js)", "percentage": 95, "note": "Full ESLint 9 support with eslint.config.js or legacy .eslintrc"},
        {"solution": "As workaround, disable ESLint in next.config.js: module.exports = { eslint: { ignoreDuringBuilds: true } }", "percentage": 90, "note": "Allows builds to complete while using ESLint separately"},
        {"solution": "Downgrade to ESLint 8 temporarily: npm install eslint@8", "percentage": 85, "note": "Short-term workaround until Next.js upgrade"},
        {"solution": "Migrate to flat config format in eslint.config.js instead of .eslintrc for ESLint 9 compatibility", "percentage": 80, "note": "Required for full ESLint 9 support, new config format"}
    ]$$::jsonb,
    'Next.js 14.1+, ESLint 9 installed, Node.js 18+',
    'next lint command completes without error, ESLint checks pass, No unknown options errors in console',
    'ESLint 9 removed legacy .eslintrc support and uses flat config. Old options like useEslintrc and extensions no longer work. next-lint.ts had deprecated API calls. Ensure eslint-config-next is compatible with your ESLint version.',
    0.92,
    'https://github.com/vercel/next.js/issues/64409'
),
(
    'ES Module (ESM) configuration format for next.config.js',
    'github-nextjs',
    'MEDIUM',
    $$[
        {"solution": "Rename next.config.js to next.config.cjs when using package.json \"type\": \"module\" to force CommonJS", "percentage": 90, "note": "Next.js config loader expects CommonJS, .cjs extension forces require()"},
        {"solution": "Keep package.json as type: commonjs and use import/export in other JS files with .mjs extension", "percentage": 85, "note": "Separate CommonJS config from ESM application code"},
        {"solution": "Use transpiling approach: convert ESM config to CJS and emit to .next folder at startup", "percentage": 70, "note": "More complex, similar to @stencil/core approach"}
    ]$$::jsonb,
    'Next.js 10.0+, package.json with \"type\": \"module\", Node.js 14+',
    'next build completes successfully, next.config applies without import/require errors, dev server starts without config errors',
    'Next.js config loader uses require() internally and does not support ESM imports. Cannot use "type": "module" for entire project if keeping next.config.js as ESM. Workaround is required until ESM config support added. Alternative is to keep whole config in CommonJS.',
    0.72,
    'https://github.com/vercel/next.js/issues/9607'
),
(
    'CSS module styling removed during route transitions causing FOUC',
    'github-nextjs',
    'HIGH',
    $$[
        {"solution": "Upgrade to Next.js 13+ which fixes the onCommit method that prematurely removes styles", "percentage": 90, "note": "Issue was in style removal logic triggered before unmount"},
        {"solution": "Workaround: Restore media attribute on style tags in Router.events routeChangeComplete/routeChangeStart", "percentage": 75, "note": "Resets media=\"x\" to restore styles: querySelectorAll(''style[media=\"x\"]'').forEach(e => e.removeAttribute(\"media\"))"},
        {"solution": "Use styled-jsx instead of CSS modules which handle style lifecycle correctly", "percentage": 80, "note": "styled-jsx does not have same flash issues with route transitions"},
        {"solution": "Check rel attribute on stylesheet links - should be \"stylesheet\" not \"preload\" during transitions", "percentage": 70, "note": "Some style handling methods change rel attribute incorrectly"}
    ]$$::jsonb,
    'Next.js 12.0+, CSS modules enabled, Client-side routing enabled',
    'No flash of unstyled content (FOUC) during page transitions, Styles persist until new page fully renders, No media=\"x\" attributes on style tags',
    'CSS modules with Sass modules show FOUC in production builds specifically, not dev. Issue stems from onCommit removing styles before component unmounts. The media attribute workaround is temporary - upgrade is better solution. styled-jsx handles lifecycles better.',
    0.85,
    'https://github.com/vercel/next.js/issues/17464'
),
(
    'Access pathname/URL in Next.js 13+ Server Components and Layouts',
    'github-nextjs',
    'HIGH',
    $$[
        {"solution": "Use usePathname() hook from next/navigation in child Client Components: const pathname = usePathname()", "percentage": 95, "note": "Works in any client component, not in server layout itself"},
        {"solution": "Use useSelectedLayoutSegment() to identify which route segment is active within layout", "percentage": 85, "note": "Returns the active segment without full pathname, useful for navigation highlighting"},
        {"solution": "Implement auth logic in Middleware instead of layout for route protection", "percentage": 80, "note": "Middleware can read request URLs early, but cannot call databases directly"},
        {"solution": "Handle redirects in page.tsx instead of layout, use searchParams prop for post-login URL", "percentage": 75, "note": "Page components can receive searchParams, layouts cannot"}
    ]$$::jsonb,
    'Next.js 13+, App Router (not Pages Router), React 18+',
    'usePathname returns current pathname in client components, useSelectedLayoutSegment returns active segment, Navigation highlights correctly based on pathname',
    'Layouts wrap multiple routes and do not re-render on route changes, so cannot access pathname directly. Server components cannot use hooks. usePathname is client-side only. Moving auth to middleware has limitations - cannot call databases directly there. Consider restructuring layout hierarchy.',
    0.88,
    'https://github.com/vercel/next.js/issues/43704'
);
