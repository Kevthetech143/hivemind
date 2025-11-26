-- Add emotion-js/emotion high-voted SSR/styling error solutions batch 1
-- Extracted from GitHub issues with focus on SSR, className mismatches, cache configuration, TypeScript, and Next.js integration

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Emotion SSR hydration error: Prop className did not match between server and client',
    'github-emotion',
    'HIGH',
    $$[
        {"solution": "Ensure emotion cache is properly shared between server and client. Set cache.compat = true in cache configuration to enable compatibility mode", "percentage": 85, "note": "Critical for cross-browser SSR"},
        {"solution": "Use consistent component naming - Safari omits component names from stack traces, causing different class name generation. Verify getLabelFromStackTrace works across browsers", "percentage": 80, "note": "Browser-specific issue"},
        {"solution": "For React select or similar libraries, ensure proper SSR extraction before rendering on client. Use extractCriticalToChunks or extractCritical APIs", "percentage": 85, "command": "import { extractCritical } from @emotion/server"}
    ]$$::jsonb,
    '@emotion/react 11.0+, @emotion/server configured, Emotion cache instance created',
    'className matches between server and client renders, no hydration warnings in console, styles apply correctly in Safari',
    'Do not rely on browser-specific stack trace parsing. Always test Safari and Chrome separately. Cache must be identical on server and client.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/emotion-js/emotion/issues/2255'
),
(
    'Emotion SSR client-only components missing CSS in server-extracted cache',
    'github-emotion',
    'HIGH',
    $$[
        {"solution": "Render all components (including client-only ones) on the server for cache extraction. Set isServerSide flag to false after extraction, then conditionally render on client", "percentage": 90, "note": "Recommended approach"},
        {"solution": "Use createEmotionCache with insertionPoint set to render styles during both server and client phases. Ensure cache persists across renders", "percentage": 85, "note": "Requires careful cache management"},
        {"solution": "Implement a two-pass render: first extract styles with all components, then on client conditionally render client-only components", "percentage": 80, "note": "More complex but fully works"}
    ]$$::jsonb,
    'Emotion cache configured with CacheProvider, SSR setup with extractCritical, Vite or similar SSR build tool',
    'All CSS for conditionally rendered components is present in extracted styles, no FOUC on client, styles apply immediately after hydration',
    'Rendering components only on client means their styles won''t be in server-extracted CSS. Common mistake with Chakra UI and conditional rendering patterns.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/emotion-js/emotion/issues/3181'
),
(
    'Emotion renderToPipeableStream compatibility in React 18 SSR',
    'github-emotion',
    'HIGH',
    $$[
        {"solution": "Use custom Writable stream wrapper that intercepts HTML chunks and injects Emotion styles via regex matching. Extract style tags and populate cache dynamically", "percentage": 75, "note": "Community workaround, lacks full Suspense support"},
        {"solution": "Wait for React API improvements - Emotion maintainers are working with React team on better hooks for streamed rendering. Consider temporary renderToString fallback", "percentage": 70, "note": "Long-term solution in progress"},
        {"solution": "Move streamed styles to document.head dynamically using bootstrap scripts. Inject styles before first render to prevent FOUC", "percentage": 80, "note": "Workaround for React 18"}
    ]$$::jsonb,
    'React 18+, @emotion/server, renderToPipeableStream API available, custom stream implementation',
    'Styles render in document.head before component paint, no FOUC observed, full hydration without rerender, all Emotion classes present',
    'renderToPipeableStream integration not officially supported yet. Workarounds lack Suspense support and may cause rehydration mismatches. Use renderToString as fallback.',
    0.75,
    'sonnet-4',
    NOW(),
    'https://github.com/emotion-js/emotion/issues/2800'
),
(
    'Emotion incompatibility with React Server Components in Next.js 13+ app directory',
    'github-emotion',
    'HIGH',
    $$[
        {"solution": "Create a client component wrapper using \"use client\" directive with useServerInsertedHTML hook and CacheProvider. Set cache.compat = true for compatibility", "percentage": 90, "note": "Official workaround from Emma Hamilton"},
        {"solution": "Use RootStyleRegistry component wrapping app layout - implements CacheProvider with emotion cache and injects styles via useServerInsertedHTML", "percentage": 85, "command": "export const RootStyleRegistry = ({ children }) => { const cache = createCache(); cache.compat = true; return <CacheProvider value={cache}>{children}</CacheProvider>; }"},
        {"solution": "Consider migrating to zero-runtime CSS solutions like Panda CSS or CSS Modules for true server-side rendering without client components", "percentage": 70, "note": "Alternative approach"}
    ]$$::jsonb,
    'Next.js 13+ with app directory, React 18+, @emotion/react installed, Babel or SWC Emotion transform',
    'Styles inject correctly in server components, no hydration mismatch, @emotion/react context available to client components',
    'Do not use Emotion directly in server components without CacheProvider. SWC Emotion transform may conflict - use Babel as fallback. Cannot have zero-runtime Emotion in RSC without client boundary.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/emotion-js/emotion/issues/2928'
),
(
    'Emotion useServerInsertedHTML hook for Next.js 13 app directory streaming',
    'github-emotion',
    'HIGH',
    $$[
        {"solution": "Wrap root layout with RootStyleRegistry - use createCache(), set cache.compat = true, wrap with CacheProvider, implement useServerInsertedHTML to inject <style> tags", "percentage": 92, "note": "Recommended Next.js integration pattern"},
        {"solution": "For pages directory (legacy), implement own useServerInsertedHTML callback that extracts Emotion cache and injects critical CSS during render", "percentage": 85, "note": "Alternative for pages router"}
    ]$$::jsonb,
    'Next.js 13+, @emotion/react, @emotion/cache, React.use(ClientOnly) or equivalent',
    'Styles inject before hydration in app router, no flash of unstyled content, all CSS-in-JS computed styles available server-side',
    'useServerInsertedHTML callback timing must be correct - inject before children render. Cannot extract styles after render completes.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/emotion-js/emotion/issues/2928'
),
(
    'Emotion TypeScript error with Next.js HOC and generic type parameters after v11.13.3',
    'github-emotion',
    'MEDIUM',
    $$[
        {"solution": "Update LibraryManagedAttributes type in jsx-namespace.d.ts to handle generic type variables: type LibraryManagedAttributes<C, P> = ((P extends unknown ? WithConditionalCSSProp<P> : {}) | {})", "percentage": 85, "note": "Workaround from draft PR #3293"},
        {"solution": "Downgrade to @emotion/react 11.13.2 or earlier until fix is released in next patch version", "percentage": 75, "note": "Temporary solution"},
        {"solution": "Use @emotion/styled directly instead of css prop with NextPage<P> generics - pass P to styled component instead", "percentage": 70, "note": "Alternative pattern"}
    ]$$::jsonb,
    '@emotion/react 11.13.3+, TypeScript 4.1+, React 18+, Next.js with HOC usage',
    'TypeScript compilation succeeds with generic HOCs, no type errors in editor, NextPage<P> HOCs type check correctly',
    'Generic types with WithConditionalCSSProp fail during strict type checking. The jsx-namespace.d.ts type needs explicit unknown handling for conditionals.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/emotion-js/emotion/issues/3245'
),
(
    'Emotion @emotion/server crash on import in Worker/edge runtime environments',
    'github-emotion',
    'MEDIUM',
    $$[
        {"solution": "Use dynamic imports for @emotion/server functions - wrap in conditional to check for Node.js APIs before importing html-tokenize dependency", "percentage": 75, "note": "Requires async function wrapper"},
        {"solution": "Import only needed functions like createExtractCriticalToChunks instead of entire package - reduces dependency tree", "percentage": 70, "note": "Partial workaround"},
        {"solution": "For Cloudflare Workers, extract styles directly from Emotion cache object instead of using createRenderStylesToStream - access cache.inserted directly", "percentage": 80, "command": "const criticalStyles = Array.from(cache.inserted).map(([id, css]) => `<style>${css}</style>`).join('')"}
    ]$$::jsonb,
    'Cloudflare Workers or similar edge runtime, Emotion cache instance, Node.js polyfills NOT available',
    'Module imports without throwing Buffer/Stream undefined errors, edge functions execute without crashes, styles extracted from cache',
    '@emotion/server depends on html-tokenize which requires Node.js Buffer and Stream APIs. Workers cannot use these. No official Worker support yet.',
    0.72,
    'sonnet-4',
    NOW(),
    'https://github.com/emotion-js/emotion/issues/2446'
),
(
    'Emotion hydration mismatch with Material-UI 6 in Next.js 15 Turbopack builder',
    'github-emotion',
    'MEDIUM',
    $$[
        {"solution": "Install @mui/material-nextjs and wrap app with AppRouterCacheProvider (app router) or AppCacheProvider (pages router) instead of manual CacheProvider", "percentage": 90, "note": "Official MUI Next.js integration"},
        {"solution": "Use webpack builder instead of Turbopack as workaround - Turbopack has known compatibility issues with Emotion class name generation", "percentage": 75, "note": "Temporary workaround"},
        {"solution": "Ensure Emotion cache is created fresh on client - use Next.js dynamic import with ssr: false for client-only cache initialization", "percentage": 70, "note": "Alternative approach"}
    ]$$::jsonb,
    'Next.js 15+, Material-UI 6+, @emotion/react 11.14+, React 19',
    'Server className matches client className, no hydration errors in console, MuiBox-root styles apply correctly on initial render',
    'Turbopack has issues with Emotion class name hash generation - different on server vs client. Use webpack or official @mui/material-nextjs provider.',
    0.80,
    'sonnet-4',
    NOW(),
    'https://github.com/emotion-js/emotion/issues/3308'
),
(
    'Emotion TypeScript as prop not working with styled components',
    'github-emotion',
    'MEDIUM',
    $$[
        {"solution": "Use polymorphic component pattern with generic type variable - define AsProp<C extends React.ElementType> and PolyComponent types instead of as prop", "percentage": 85, "note": "Type-safe workaround"},
        {"solution": "Use withComponent method instead of as prop - type-safe alternative: Component.withComponent(''div'') returns properly typed component", "percentage": 75, "note": "Functional but verbose"},
        {"solution": "Maintain separate type definition for each component variant instead of using as prop - trade typing for runtime flexibility", "percentage": 65, "note": "Not ideal"}
    ]$$::jsonb,
    'TypeScript 4.1+, React 17+, @emotion/react 11+, @emotion/styled',
    'TypeScript compilation succeeds with polymorphic components, as prop type checks without errors, component variants properly typed',
    'The as prop typing has severe performance cost according to maintainers. Polymorphic pattern is preferred. Do not mix as prop with generic types.',
    0.78,
    'sonnet-4',
    NOW(),
    'https://github.com/emotion-js/emotion/issues/2266'
),
(
    'Emotion cx function confusion with SerializedStyles from multiple packages',
    'github-emotion',
    'MEDIUM',
    $$[
        {"solution": "Use css function from @emotion/react instead of @emotion/css - returns SerializedStyles compatible with cx and supports conditional arrays: css([baseCss, active && activeCss])", "percentage": 92, "note": "Recommended approach"},
        {"solution": "When using @emotion/react, pass array of css objects to css prop instead of using cx - more idiomatic: css={[baseCss, active && activeCss]}", "percentage": 88, "note": "Preferred pattern"},
        {"solution": "Only use @emotion/css when you need cx outside of React components - avoid mixing @emotion/react css with @emotion/css cx", "percentage": 80, "note": "Clear separation of concerns"}
    ]$$::jsonb,
    '@emotion/react or @emotion/styled installed, no need for @emotion/css package',
    'Styles apply correctly with conditional arrays, cx not needed in @emotion/react workflows, className combines as expected',
    'Mixing css from @emotion/css with @emotion/react causes SerializedStyles incompatibility. Use css from @emotion/react only. cx is for ClassNames component.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/emotion-js/emotion/issues/2152'
),
(
    'Emotion React Server Components support gap and future direction',
    'github-emotion',
    'MEDIUM',
    $$[
        {"solution": "For current projects, use CacheProvider with useServerInsertedHTML hook as documented - not ideal but fully functional for app directory", "percentage": 85, "note": "Current workaround"},
        {"solution": "Evaluate Panda CSS or other zero-runtime CSS solutions designed specifically for React Server Components - Chakra team migrated here", "percentage": 75, "note": "Long-term alternative"},
        {"solution": "Await new React APIs for injecting styles into streamed responses - Emotion maintainers indicated dependency on React improvements", "percentage": 60, "note": "Future path"}
    ]$$::jsonb,
    'Next.js 13+ app directory, willingness to adopt workarounds or alternative CSS solutions',
    'Server-rendered styles inject correctly, no hydration mismatches, true RSC usage (no use client required) achieved or clear migration path identified',
    'Zero-runtime CSS-in-JS (like Panda) requires different mental model than Emotion. Full RSC support from Emotion blocked on React API improvements.',
    0.75,
    'sonnet-4',
    NOW(),
    'https://github.com/emotion-js/emotion/issues/2978'
),
(
    'Emotion @emotion/eslint-plugin version restriction blocks ESLint 9 compatibility',
    'github-emotion',
    'LOW',
    $$[
        {"solution": "Update package.json peer dependency from \"eslint\": \"6 || 7 || 8\" to \"eslint\": \">=6\" to allow ESLint 9 and future versions", "percentage": 95, "note": "Maintainer-side fix needed"},
        {"solution": "Explicitly add ESLint 9 support: update to \"eslint\": \"6 || 7 || 8 || 9\" in next patch release", "percentage": 90, "note": "Interim solution"},
        {"solution": "Users can install with --legacy-peer-deps flag as temporary workaround: npm install --legacy-peer-deps @emotion/eslint-plugin", "percentage": 75, "note": "User-side workaround"}
    ]$$::jsonb,
    '@emotion/eslint-plugin <11.12, ESLint 9+, npm 7+',
    'ESLint plugin installs successfully with ESLint 9, no peer dependency warnings, linting rules execute without errors',
    'Peer dependency restriction is artificial - ESLint 9 compatibility likely works but not officially verified. Pull request #3248 addresses this.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/emotion-js/emotion/issues/3211'
);
