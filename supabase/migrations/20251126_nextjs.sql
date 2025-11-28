INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Hydration failed because the initial UI does not match what was rendered on the server',
    'nextjs',
    'HIGH',
    '[
        {"solution": "Check for invalid HTML nesting like <p><div>Content</div></p>. Use semantic elements correctly. Replace nested <p> with <span> or div wrappers.", "percentage": 95},
        {"solution": "Wrap browser-only content in useEffect: const [isMounted, setIsMounted] = useState(false); useEffect(() => setIsMounted(true), []); if (!isMounted) return null;", "percentage": 90},
        {"solution": "Use dynamic import with ssr: false for problematic components: import dynamic from ''next/dynamic''; const NoSSR = dynamic(() => import(''../Component''), { ssr: false });", "percentage": 88}
    ]'::jsonb,
    'React component knowledge, understanding of SSR vs CSR',
    'Component renders without hydration warnings in browser console',
    'Mismatched HTML structures between server and client, timezone/date differences, browser extension interference',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/73162551/how-to-solve-react-hydration-error-in-nextjs'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'window is not defined',
    'nextjs',
    'HIGH',
    '[
        {"solution": "Wrap browser API access in useEffect hook: useEffect(() => { window.localStorage.foo = ''bar''; }, []);", "percentage": 98},
        {"solution": "Check typeof window !== ''undefined'' pattern inside useEffect, not at render time", "percentage": 95},
        {"solution": "Use dynamic import with ssr: false for third-party libraries requiring window object", "percentage": 90}
    ]'::jsonb,
    'React hooks knowledge, understanding of SSR lifecycle',
    'Component accesses window/document without errors during build and runtime',
    'Accessing window/document at module level or render time, forgetting SSR runs on Node.js',
    0.96,
    'haiku',
    NOW(),
    'https://blog.sentry.io/common-errors-in-next-js-and-how-to-resolve-them/'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'document is not defined',
    'nextjs',
    'HIGH',
    '[
        {"solution": "Defer document access to useEffect: useEffect(() => { const el = document.getElementById(''id''); }, []);", "percentage": 98},
        {"solution": "Use conditional rendering: const [domLoaded, setDomLoaded] = useState(false); useEffect(() => setDomLoaded(true), []); return domLoaded && <Component />;", "percentage": 92}
    ]'::jsonb,
    'React component lifecycle, useEffect pattern',
    'DOM elements are accessed and manipulated without build-time errors',
    'Accessing document at module or render level, not using useEffect wrapper',
    0.95,
    'haiku',
    NOW(),
    'https://blog.logrocket.com/common-next-js-errors/'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Module not found: Can''t resolve ''fs''',
    'nextjs',
    'HIGH',
    '[
        {"solution": "Move fs usage into getServerSideProps or getStaticProps (server-side data fetching)", "percentage": 97},
        {"solution": "Configure webpack fallback in next.config.js: webpack: (config, { isServer }) => { if (!isServer) { config.resolve.fallback = { fs: false }; } return config; }", "percentage": 85},
        {"solution": "For API routes, use Node.js modules in /pages/api/* endpoints which run server-side only", "percentage": 90}
    ]'::jsonb,
    'Understanding Next.js server-side vs client-side execution, webpack knowledge',
    'Module loads successfully, no resolution errors in build or runtime',
    'Importing Node.js modules in client components, not using data-fetching functions',
    0.93,
    'haiku',
    NOW(),
    'https://blog.logrocket.com/common-next-js-errors/'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'ENOENT: no such file or directory, open ''.next/BUILD_ID''',
    'nextjs',
    'HIGH',
    '[
        {"solution": "Run ''npm run build'' before ''npm run start'' to generate BUILD_ID and .next directory", "percentage": 99},
        {"solution": "Do not mix ''next dev'' and ''next start'' in same session - use one or the other", "percentage": 98},
        {"solution": "In Docker/CI, ensure build step completes before start step in deployment pipeline", "percentage": 95}
    ]'::jsonb,
    'Next.js build and deploy process understanding',
    'Application starts successfully with ''npm run start'' after build, no ENOENT errors',
    'Running ''next start'' without prior ''npm run build'', mixing dev and start commands',
    0.99,
    'haiku',
    NOW(),
    'https://github.com/vercel/next.js/discussions/57066'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'ENOENT: no such file or directory, open ''.next/cache/images''',
    'nextjs',
    'MEDIUM',
    '[
        {"solution": "Delete .next folder and rebuild: rm -rf .next && npm run build", "percentage": 85},
        {"solution": "Clear npm cache: npm cache clean --force && npm install && npm run dev", "percentage": 80},
        {"solution": "Downgrade Next.js to 12.0.9 if using 12.0.10+ (known image caching race condition)", "percentage": 92}
    ]'::jsonb,
    'Next.js image optimization knowledge, cache management',
    'Image optimization works without ENOENT errors, images load successfully',
    'Not clearing cache when changing image paths, using versions with image cache bugs',
    0.86,
    'haiku',
    NOW(),
    'https://github.com/vercel/next.js/issues/33860'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Access to fetch has been blocked by CORS policy',
    'nextjs',
    'HIGH',
    '[
        {"solution": "Install cors package: npm install cors", "percentage": 90},
        {"solution": "Add CORS middleware to API routes: import Cors from ''cors''; const cors = Cors({ methods: [''POST'', ''GET'', ''HEAD''] });", "percentage": 92},
        {"solution": "Wrap cors in middleware function and call in handler: await runMiddleware(req, res, cors);", "percentage": 88}
    ]'::jsonb,
    'CORS concepts, API route handling, middleware patterns',
    'Cross-origin API requests succeed without CORS blocking errors',
    'Not configuring CORS in API routes, assuming client-side CORS handling works',
    0.89,
    'haiku',
    NOW(),
    'https://blog.logrocket.com/common-next-js-errors/'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'TypeError: getStaticPaths is not a function',
    'nextjs',
    'MEDIUM',
    '[
        {"solution": "Export getStaticPaths function from dynamic route component: export async function getStaticPaths() { return { paths: [], fallback: false }; }", "percentage": 98},
        {"solution": "Fetch dynamic route parameters: const res = await fetch(''http://api/items''); const items = await res.json(); return { paths: items.map(i => ({ params: { slug: i.slug } })), fallback: false };", "percentage": 95}
    ]'::jsonb,
    'Next.js Pages Router, dynamic routes, static generation',
    'Dynamic routes build successfully without missing getStaticPaths errors',
    'Forgetting getStaticPaths in dynamic routes, using fallback: false with incomplete paths',
    0.96,
    'haiku',
    NOW(),
    'https://blog.sentry.io/common-errors-in-next-js-and-how-to-resolve-them/'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'TypeError: Invalid URL',
    'nextjs',
    'MEDIUM',
    '[
        {"solution": "In Nx projects, add hostname to project.json serve options: { ''hostname'': ''localhost'', ''port'': 4200 }", "percentage": 90},
        {"solution": "Ensure middleware.js (not _middleware.js) exists in root directory", "percentage": 95},
        {"solution": "Verify custom server setup includes explicit hostname configuration", "percentage": 88}
    ]'::jsonb,
    'Next.js middleware setup, custom server configuration',
    'Middleware loads and executes without Invalid URL errors',
    'Using _middleware.js in pages directory, missing hostname in monorepo setup',
    0.91,
    'haiku',
    NOW(),
    'https://blog.sentry.io/common-errors-in-next-js-and-how-to-resolve-them/'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'getServerSideProps is not supported in app/',
    'nextjs',
    'MEDIUM',
    '[
        {"solution": "Use fetch or API route handlers instead in app directory (Next.js 13+ App Router)", "percentage": 98},
        {"solution": "For SSR, use async Server Components directly: export default async function Page() { const data = await fetch(''...''); }", "percentage": 97}
    ]'::jsonb,
    'Next.js App Router vs Pages Router knowledge',
    'Server-side rendering works in App Router without getServerSideProps errors',
    'Using Pages Router patterns in App Router, confusing function names',
    0.97,
    'haiku',
    NOW(),
    'https://github.com/vercel/next.js/issues/52914'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Error: ENOENT: no such file or directory, scandir ''node_modules/sharp''',
    'nextjs',
    'MEDIUM',
    '[
        {"solution": "Install sharp package: npm install sharp", "percentage": 99},
        {"solution": "If already installed, delete node_modules and reinstall: rm -rf node_modules && npm install", "percentage": 95},
        {"solution": "In serverless environments, ensure sharp is included in deployment package", "percentage": 90}
    ]'::jsonb,
    'Next.js image optimization, package management',
    'Image optimization works, sharp module loads successfully',
    'Not installing sharp, incomplete npm install, serverless deployment without dependencies',
    0.96,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/70992824/how-to-fix-nextjs-enoent'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Text content does not match server-rendered HTML',
    'nextjs',
    'HIGH',
    '[
        {"solution": "Check for date/time formatting that differs between server and client timezones", "percentage": 90},
        {"solution": "Verify localStorage access - move to useEffect or client-only component", "percentage": 92},
        {"solution": "Check for random value generation - ensure server and client generate identical output", "percentage": 88}
    ]'::jsonb,
    'Understanding hydration mismatch causes',
    'Server and client render identical HTML, hydration succeeds without mismatches',
    'Date formatting in render output, random values in render, timezone assumptions',
    0.90,
    'haiku',
    NOW(),
    'https://github.com/vercel/next.js/discussions/35773'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Expected server HTML to contain a matching [element]',
    'nextjs',
    'HIGH',
    '[
        {"solution": "Add suppressHydrationWarning to element with unavoidable mismatch: <div suppressHydrationWarning>content</div>", "percentage": 85},
        {"solution": "Ensure valid HTML nesting - no divs in paragraphs, no list items not in lists", "percentage": 95},
        {"solution": "Test in incognito mode to exclude browser extension interference (Grammarly, McAfee, etc)", "percentage": 80}
    ]'::jsonb,
    'React hydration concepts, HTML structure knowledge',
    'Element renders without hydration mismatch warnings, content displays correctly',
    'Adding suppressHydrationWarning to root element, invalid HTML nesting, browser extensions',
    0.89,
    'haiku',
    NOW(),
    'https://nextjs.org/docs/messages/react-hydration-error'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Cannot use .map() on undefined or null',
    'nextjs',
    'MEDIUM',
    '[
        {"solution": "Add null check before mapping: {data && data.map(item => ...)} or {data?.map(item => ...)}", "percentage": 98},
        {"solution": "Provide default value in destructuring: const { items = [] } = props;", "percentage": 95},
        {"solution": "In getServerSideProps, ensure props always returns defined objects", "percentage": 92}
    ]'::jsonb,
    'JavaScript array methods, prop handling',
    'Array mapping works without undefined/null errors, data renders correctly',
    'Not checking data before mapping, assuming props are always defined',
    0.97,
    'haiku',
    NOW(),
    'https://blog.logrocket.com/common-next-js-errors/'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'use client directive not working in App Router',
    'nextjs',
    'MEDIUM',
    '[
        {"solution": "Place ''use client'' at top of file before any imports: ''use client''; import { useState } from ''react'';", "percentage": 98},
        {"solution": "Keep ''use client'' at component tree edges - only wrap components needing interactivity", "percentage": 95},
        {"solution": "Remember components imported into ''use client'' files become client components too", "percentage": 93}
    ]'::jsonb,
    'Next.js 13+ App Router, Server/Client Component boundaries',
    'Client components render with state/hooks working, hydration succeeds',
    'Placing ''use client'' mid-file, turning entire tree into client components unnecessarily',
    0.96,
    'haiku',
    NOW(),
    'https://dev.to/azeem_shafeeq/all-29-nextjs-mistakes-beginners-make-56nj'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Redirect function called inside try-catch block',
    'nextjs',
    'MEDIUM',
    '[
        {"solution": "Move redirect() call outside try-catch: if (condition) redirect(''/path''); try { ... } catch (e) { ... }", "percentage": 99},
        {"solution": "Remember: redirect() throws an error intentionally for control flow - do not catch it", "percentage": 98}
    ]'::jsonb,
    'Next.js redirect behavior, control flow patterns',
    'Redirect executes without being caught, user navigates to correct page',
    'Wrapping redirect() in try-catch, treating it like a normal function',
    0.99,
    'haiku',
    NOW(),
    'https://dev.to/azeem_shafeeq/all-29-nextjs-mistakes-beginners-make-56nj'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Waterfall data fetching causing slow page loads',
    'nextjs',
    'MEDIUM',
    '[
        {"solution": "Use Promise.all() to fetch data in parallel: Promise.all([fetch(url1), fetch(url2)])", "percentage": 97},
        {"solution": "In App Router, declare multiple async operations at component level", "percentage": 95},
        {"solution": "Combine getServerSideProps calls into single function with parallel fetches", "percentage": 90}
    ]'::jsonb,
    'JavaScript Promises, data fetching patterns',
    'Page loads quickly, multiple data sources fetched simultaneously',
    'Sequential await statements, fetching data inside components without parallelization',
    0.94,
    'haiku',
    NOW(),
    'https://dev.to/azeem_shafeeq/all-29-nextjs-mistakes-beginners-make-56nj'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Cannot find module when importing with wrong casing',
    'nextjs',
    'MEDIUM',
    '[
        {"solution": "Verify file path casing matches exactly: import Component from ''./MyComponent'' (if file is MyComponent.js)", "percentage": 99},
        {"solution": "On case-sensitive filesystems (Linux, Mac), ''mycomponent'' != ''MyComponent''", "percentage": 98},
        {"solution": "Use IDE features to auto-import files to avoid casing errors", "percentage": 95}
    ]'::jsonb,
    'File system knowledge, import syntax',
    'Modules import successfully, no module resolution errors',
    'Assuming case-insensitive file paths, manual path typos',
    0.99,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/71433951/module-not-found-cant-resolve-next-js-typescript'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Image not lazy loading after client-side navigation',
    'nextjs',
    'LOW',
    '[
        {"solution": "Install sharp package for proper image optimization: npm install sharp", "percentage": 90},
        {"solution": "Use priority={true} prop for above-the-fold images, not loading=''eager''", "percentage": 88},
        {"solution": "Verify images are within viewport when router.push occurs", "percentage": 80}
    ]'::jsonb,
    'Next.js Image component knowledge, intersection observer concepts',
    'Images load lazily, only when entering viewport after navigation',
    'Not installing sharp, using eager loading for all images, incorrect priority usage',
    0.82,
    'haiku',
    NOW(),
    'https://github.com/vercel/next.js/issues/56540'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'State management (Redux, Zustand, Context) not working in Server Components',
    'nextjs',
    'MEDIUM',
    '[
        {"solution": "Move state management to client components with ''use client'' directive", "percentage": 99},
        {"solution": "Create separate client component wrapper for state providers", "percentage": 98},
        {"solution": "Remember Context API, Redux, Zustand only work on client - not in Server Components", "percentage": 99}
    ]'::jsonb,
    'Next.js App Router, React state management',
    'State updates work, context values accessible in client components',
    'Using state libraries in Server Components, forgetting App Router limitations',
    0.99,
    'haiku',
    NOW(),
    'https://dev.to/azeem_shafeeq/all-29-nextjs-mistakes-beginners-make-56nj'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'revalidatePath() not busting cache',
    'nextjs',
    'MEDIUM',
    '[
        {"solution": "Call revalidatePath() with exact path after mutation: revalidatePath(''/dashboard'')", "percentage": 95},
        {"solution": "For dynamic routes, use revalidatePath() with slug: revalidatePath(''[slug]'')", "percentage": 88},
        {"solution": "Ensure revalidatePath is imported from ''next/cache'' not ''next/navigation''", "percentage": 92}
    ]'::jsonb,
    'Next.js caching, revalidation patterns',
    'Data refreshes after mutations, cache is properly busted',
    'Not calling revalidatePath after mutations, using wrong import path',
    0.91,
    'haiku',
    NOW(),
    'https://dev.to/azeem_shafeeq/all-29-nextjs-mistakes-beginners-make-56nj'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Hardcoded secrets in source code exposing API keys',
    'nextjs',
    'MEDIUM',
    '[
        {"solution": "Move all secrets to .env.local file: API_KEY=secret_value", "percentage": 99},
        {"solution": "Client-visible variables only: NEXT_PUBLIC_API_URL (exposed to browser)", "percentage": 98},
        {"solution": "Add .env.local to .gitignore to prevent accidental commits", "percentage": 99}
    ]'::jsonb,
    'Environment variables, security best practices',
    'Secrets inaccessible in client-side code, only NEXT_PUBLIC_* exposed',
    'Committing .env.local to git, using hardcoded secrets, not prefixing public vars',
    0.99,
    'haiku',
    NOW(),
    'https://dev.to/azeem_shafeeq/all-29-nextjs-mistakes-beginners-make-56nj'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Next/Image component rendering incorrectly with layout shift',
    'nextjs',
    'MEDIUM',
    '[
        {"solution": "Add width and height props to Image component: <Image width={400} height={300} src=''...'' />", "percentage": 96},
        {"solution": "Use fill prop with parent position: relative for responsive images: <Image fill src=''...'' />", "percentage": 94},
        {"solution": "Set aspect ratio in CSS for smooth rendering: aspect-ratio: 4/3;", "percentage": 92}
    ]'::jsonb,
    'Next.js Image API, CSS layout knowledge',
    'Image loads without layout shift, proper dimensions displayed',
    'Missing width/height, incorrect fill prop usage, missing parent positioning',
    0.94,
    'haiku',
    NOW(),
    'https://nextjs.org/docs/14/app/building-your-application/optimizing/images'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Cannot access process.env in browser code',
    'nextjs',
    'MEDIUM',
    '[
        {"solution": "Only NEXT_PUBLIC_ prefixed variables accessible in browser: NEXT_PUBLIC_API_URL", "percentage": 99},
        {"solution": "Use regular process.env in getServerSideProps and Server Components", "percentage": 98},
        {"solution": "Client components cannot access unprefixed env vars - pass as props from server", "percentage": 97}
    ]'::jsonb,
    'Next.js environment variable scoping, server vs client boundaries',
    'Correct env variables accessible in respective environments',
    'Using unprefixed env vars in client code, forgetting NEXT_PUBLIC_ prefix',
    0.98,
    'haiku',
    NOW(),
    'https://blog.sentry.io/common-errors-in-next-js-and-how-to-resolve-them/'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Syntax Error: Unexpected token ''<'' in JSON',
    'nextjs',
    'LOW',
    '[
        {"solution": "Check API route is returning JSON, not HTML: res.json() not res.send()", "percentage": 96},
        {"solution": "Verify fetch URL points to /api/route not /pages/route", "percentage": 94},
        {"solution": "Check Content-Type header is application/json in API response", "percentage": 92}
    ]'::jsonb,
    'API routes, JSON parsing knowledge',
    'API returns valid JSON, fetch/axios parses successfully',
    'Returning HTML from API route, incorrect endpoint paths, wrong headers',
    0.94,
    'haiku',
    NOW(),
    'https://blog.logrocket.com/common-next-js-errors/'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'ReferenceError: __NEXT_DATA__ is not defined',
    'nextjs',
    'LOW',
    '[
        {"solution": "Wrap script accessing __NEXT_DATA__ in typeof window check: if (typeof window !== ''undefined'') { ... }", "percentage": 92},
        {"solution": "Use getInitialProps or getServerSideProps instead of accessing __NEXT_DATA__ directly", "percentage": 95},
        {"solution": "Only access __NEXT_DATA__ in client-side code, not during SSR", "percentage": 94}
    ]'::jsonb,
    'Next.js internals, SSR knowledge',
    'Data accessed correctly in client-side context without reference errors',
    'Accessing __NEXT_DATA__ during SSR, not checking window object',
    0.93,
    'haiku',
    NOW(),
    'https://www.zipy.ai/blog/next-js-errors'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Promise rejection: Cannot POST to API route',
    'nextjs',
    'MEDIUM',
    '[
        {"solution": "Verify HTTP method matches: check if using POST but route expects GET", "percentage": 96},
        {"solution": "Ensure API route file is in /pages/api/ or /app/api/ directory", "percentage": 97},
        {"solution": "Check route name matches: /pages/api/users.js accessible as /api/users", "percentage": 98}
    ]'::jsonb,
    'API routes, HTTP methods, Next.js file structure',
    'API requests succeed with correct method and endpoint',
    'Wrong HTTP method, incorrect file paths, API route in wrong directory',
    0.97,
    'haiku',
    NOW(),
    'https://www.zipy.ai/blog/next-js-errors'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Unhandled Promise rejection from async operation',
    'nextjs',
    'MEDIUM',
    '[
        {"solution": "Add .catch() to Promise chain: fetch(url).catch(err => console.error(err))", "percentage": 95},
        {"solution": "Use try-catch in async functions: try { await fetch(url); } catch (e) { ... }", "percentage": 96},
        {"solution": "Implement error boundary for component-level promise rejections", "percentage": 88}
    ]'::jsonb,
    'JavaScript Promises, async/await patterns',
    'Promise rejections handled gracefully with error logging',
    'Not catching Promise rejections, missing .catch() handlers',
    0.95,
    'haiku',
    NOW(),
    'https://www.zipy.ai/blog/next-js-errors'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'TypeError: Cannot read property of undefined in component',
    'nextjs',
    'MEDIUM',
    '[
        {"solution": "Add optional chaining: obj?.property or use nullish coalescing: obj ?? defaultValue", "percentage": 98},
        {"solution": "Validate data before rendering: {data && <Component data={data} />}", "percentage": 96},
        {"solution": "Provide default values in destructuring: const { prop = defaultValue } = obj", "percentage": 95}
    ]'::jsonb,
    'JavaScript object handling, null safety patterns',
    'Component renders without type errors, data displays when available',
    'Not checking for undefined, assuming data shape is always correct',
    0.96,
    'haiku',
    NOW(),
    'https://www.zipy.ai/blog/next-js-errors'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Invalid dynamic route with special characters in path',
    'nextjs',
    'LOW',
    '[
        {"solution": "Remove quotes and special characters from dynamic paths: [slug] not [''slug'']", "percentage": 98},
        {"solution": "Use only alphanumeric characters and underscores in bracket notation", "percentage": 99},
        {"solution": "Verify dynamic path matches data source keys without special characters", "percentage": 95}
    ]'::jsonb,
    'Next.js dynamic routing, file naming conventions',
    'Dynamic routes build successfully, parameters extract correctly',
    'Using quotes in bracket notation, special characters in dynamic paths',
    0.98,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/70992824/how-to-fix-nextjs-enoent'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Build fails with NODE_OPTIONS memory error ENOMEM',
    'nextjs',
    'LOW',
    '[
        {"solution": "Increase Node memory: NODE_OPTIONS=--max_old_space_size=4096 npm run build", "percentage": 94},
        {"solution": "Use 8192 for large projects: NODE_OPTIONS=--max_old_space_size=8192", "percentage": 92},
        {"solution": "In CI/CD, set memory environment variable before build step", "percentage": 90}
    ]'::jsonb,
    'Node.js memory management, build optimization',
    'Build completes without ENOMEM errors, large projects build successfully',
    'Not allocating sufficient Node memory, using default heap size for large apps',
    0.91,
    'haiku',
    NOW(),
    'https://github.com/vercel/next.js/discussions/57066'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Router.push() not navigating without full page reload',
    'nextjs',
    'MEDIUM',
    '[
        {"solution": "Ensure router is imported from ''next/router'' (Pages Router) or ''next/navigation'' (App Router)", "percentage": 98},
        {"solution": "Use router.push() for client-side navigation: import { useRouter } from ''next/router'';", "percentage": 97},
        {"solution": "In App Router, use ''next/link'' or ''useRouter'' for client navigation", "percentage": 96}
    ]'::jsonb,
    'Next.js routing, client-side navigation patterns',
    'Navigation works without full page reload, smooth transitions occur',
    'Using wrong router import, mixing Pages and App Router navigation',
    0.97,
    'haiku',
    NOW(),
    'https://blog.logrocket.com/common-next-js-errors/'
);
