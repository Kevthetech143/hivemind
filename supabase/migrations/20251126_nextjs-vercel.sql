INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES
(
    'ERR_MIDDLEWARE_INFINITE_REDIRECT: localhost redirected you too many times',
    'nextjs',
    'HIGH',
    '[
        {"solution": "Add pathname check in middleware to prevent redirecting to the same route: if (isUserLoggedIn && !request.nextUrl.pathname.startsWith(''/user'')) { return NextResponse.redirect(...) }", "percentage": 95},
        {"solution": "Configure middleware matcher to exclude already-redirected paths: export const config = { matcher: [''/((?!login|user).*)'' ] }", "percentage": 88}
    ]'::jsonb,
    'Next.js project with middleware.ts/js configured for authentication redirects',
    'After fix, navigating between auth-protected routes no longer triggers ''too many redirects'' error in browser console',
    'Forgetting to check if already on target route before redirecting; applying redirect condition globally without path exclusions',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/74970875/nextjs-middleware-causing-localhost-redirected-you-too-many-times-error',
    'admin:1764173550'
),
(
    'ImageError: Unable to optimize image and unable to fallback to upstream image statusCode 400',
    'nextjs',
    'HIGH',
    '[
        {"solution": "Exclude _next/image routes from middleware matcher: export const config = { matcher: [''/((?!api|_next/static|_next/image|images|favicon.ico).*)''] }", "percentage": 96},
        {"solution": "Import images directly instead of using src attribute: import Logo from ''@/public/logo.webp''; <Image src={Logo} width={...} height={...} alt={...} />", "percentage": 91}
    ]'::jsonb,
    'Next.js app with Image component and middleware configured',
    'Images load without 400 errors; Image optimization works correctly in dev and production',
    'Middleware matcher intercepting _next/image routes; using external image URLs without proper middleware configuration',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/76286726/nextjs-imageerror-unable-to-optimize-image-and-unable-to-fallback-to-upstream-i',
    'admin:1764173550'
),
(
    'Internal Server Error 500 when calling Next.js API route with fetch without error handling',
    'nextjs',
    'HIGH',
    '[
        {"solution": "Wrap fetch operations in try-catch block: try { const response = await fetch(...); return new Response(JSON.stringify(data), { status: 200 }); } catch (error) { console.log(''error'', error); return new Response(error.message, { status: 500 }); }", "percentage": 97},
        {"solution": "Enable verbose error logging to identify external API failures: console.log(''error inside route'', error) before returning 500 response", "percentage": 89}
    ]'::jsonb,
    'Next.js app directory with API route (app/api/route.ts) calling external API',
    'API route returns 200 with valid response; errors logged to console with meaningful messages',
    'Missing try-catch blocks; not logging the actual error; returning generic 500 without investigating root cause',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/76248449/why-the-request-to-nextjs-api-route-inside-app-directory-gives-500-response-code',
    'admin:1764173550'
),
(
    'Warning: Expected server HTML to contain a matching element - React hydration mismatch',
    'nextjs',
    'CRITICAL',
    '[
        {"solution": "Use isMounted pattern to prevent server/client mismatch: const [isMounted, setIsMounted] = useState(false); useEffect(() => setIsMounted(true), []); if (!isMounted) return null;", "percentage": 94},
        {"solution": "Move state-dependent rendering logic into useEffect to ensure server and client render identically", "percentage": 92},
        {"solution": "Fix invalid HTML nesting - replace nested block elements: replace <p> inside <p> with <span> or <div>", "percentage": 89},
        {"solution": "For dangerouslySetInnerHTML content, use <div> wrapper instead of <p> to avoid semantic nesting issues", "percentage": 87}
    ]'::jsonb,
    'Next.js app using Server and Client components with conditional rendering or dynamic content',
    'No console warnings about hydration mismatch; server-rendered HTML matches client-rendered output',
    'Using browser extensions that inject DOM (Grammarly, McAfee); nesting invalid HTML elements; rendering different content on server vs client',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/73162551/how-to-solve-react-hydration-error-in-nextjs',
    'admin:1764173550'
),
(
    'ReferenceError: window is not defined with dynamic import and Leaflet in Next.js production build',
    'nextjs',
    'HIGH',
    '[
        {"solution": "Import browser-only modules inside useEffect instead of at module level: useEffect(async () => { const L = await import(''leaflet''); const provider = new OpenStreetMapProvider(); }, [])", "percentage": 95},
        {"solution": "Use next/dynamic with ssr: false for component wrapping library: const Map = dynamic(() => import(''./MapComponent''), { ssr: false })", "percentage": 91}
    ]'::jsonb,
    'Next.js app using geospatial libraries like Leaflet with dynamic imports',
    'Production build completes without window is not defined errors; app runs correctly in browser',
    'Importing window-dependent code at module level instead of in useEffect; missing ssr: false on dynamic imports; top-level imports of browser APIs evaluated at build time',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/72133970/next-js-dynamic-import-with-server-side-rendering-turned-off-not-working-on-prod',
    'admin:1764173550'
),
(
    'Module not found: Can''t resolve ''fs'' in Next.js client-side code',
    'nextjs',
    'HIGH',
    '[
        {"solution": "Move fs usage into getServerSideProps or getStaticProps: export async function getServerSideProps() { const fs = require(''fs''); const data = fs.readFileSync(''./data.json''); return { props: { data } } }", "percentage": 96},
        {"solution": "Add ''use server'' directive for Next.js 13+ Server Functions: ''use server''; import { promises as fs } from ''fs'';", "percentage": 93},
        {"solution": "Configure Webpack fallback in next.config.js: webpack: (config) => { config.resolve.fallback = { fs: false }; return config; }", "percentage": 85}
    ]'::jsonb,
    'Next.js app attempting to use Node.js filesystem APIs',
    'Build completes successfully; fs operations work without errors; proper separation of server and client code',
    'Using fs in client components; importing fs at module level without scope guards; not using ''use server'' directive for server functions',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/64926174/module-not-found-cant-resolve-fs-in-next-js-application',
    'admin:1764173550'
),
(
    'process.env environment variables are undefined in Next.js - NEXT_PUBLIC prefix required',
    'nextjs',
    'HIGH',
    '[
        {"solution": "Use NEXT_PUBLIC_ prefix for client-side variables: NEXT_PUBLIC_DB_HOST=localhost in .env.local, access with process.env.NEXT_PUBLIC_DB_HOST", "percentage": 98},
        {"solution": "Place .env.local at project root (same level as package.json), not in subdirectories", "percentage": 96},
        {"solution": "Restart development server after modifying .env.local file: stop npm run dev and restart", "percentage": 95},
        {"solution": "For production, ensure NEXT_PUBLIC_ variables are set before running npm run build", "percentage": 92}
    ]'::jsonb,
    'Next.js 9.4+ project with .env.local configuration file',
    'Environment variables accessible via process.env; console logs show correct values; variables available in browser and server code',
    'Forgetting NEXT_PUBLIC_ prefix for client-side variables; not restarting dev server after env changes; using wrong file format (colon instead of equals sign)',
    0.96,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/66137368/next-js-environment-variables-are-undefined-next-js-10-0-5',
    'admin:1764173550'
),
(
    'sharp is required to be installed in standalone mode - Docker Alpine image missing dependencies',
    'nextjs',
    'HIGH',
    '[
        {"solution": "Switch base image from node:16-alpine to node:16-slim in Dockerfile runner stage (contains required system binaries)", "percentage": 97},
        {"solution": "Rebuild Sharp for Alpine: npm install && npm rebuild --arch=x64 --platform=linux --libc=musl sharp", "percentage": 93},
        {"solution": "Set musl environment variable during install: RUN npm_config_libc=musl npm ci", "percentage": 91}
    ]'::jsonb,
    'Next.js project with Image optimization using Docker multi-stage build with Alpine Linux',
    'Docker image builds successfully; next start command runs without sharp errors; images optimize correctly in container',
    'Using Alpine without musl configuration; removing NEXT_SHARP_PATH without fixing binaries; not rebuilding sharp after base image change',
    0.95,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/71426665/how-run-next-js-with-node-sharp-for-docker',
    'admin:1764173550'
),
(
    'getStaticProps revalidate not working - ISR (Incremental Static Regeneration) requires server process',
    'nextjs',
    'HIGH',
    '[
        {"solution": "Use next start instead of next export to enable ISR: Run ''next build && next start'' instead of ''next export''", "percentage": 98},
        {"solution": "Deploy to platform with persistent Node.js server (Vercel, Railway, etc.) that can handle background revalidation tasks", "percentage": 96},
        {"solution": "Verify revalidate seconds value is correctly set: export async function getStaticProps() { return { props: {...}, revalidate: 60 } }", "percentage": 89}
    ]'::jsonb,
    'Next.js app with getStaticProps and revalidate property set for ISR',
    'Static pages update after revalidate interval without manual rebuild; cache is refreshed on schedule; new data appears after waiting and refreshing page',
    'Using next export (static-only) instead of next start (server required); deploying without persistent Node.js server; ISR expecting to work in serverless functions',
    0.97,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/66165707/nextjs-getstaticprops-revalidate-not-working',
    'admin:1764173550'
),
(
    'Next.js middleware causing infinite redirect loop with authentication checks - path exclusion required',
    'nextjs',
    'HIGH',
    '[
        {"solution": "Add path check before redirecting unauthenticated users: if (!session && path !== ''/login'') { return NextResponse.redirect(new URL(''/login'', req.url)) }", "percentage": 97},
        {"solution": "Configure middleware matcher to specific routes only: export const config = { matcher: [''/'', ''/login'', ''/dashboard''] }", "percentage": 94},
        {"solution": "Ensure matcher excludes API routes and static assets: matcher: [''/((?!api|_next/static|favicon.ico).*)'']", "percentage": 91}
    ]'::jsonb,
    'Next.js app with NextAuth or custom authentication using middleware for protected routes',
    'Users can sign out without ''too many redirects'' error; navigation between protected routes works smoothly; login/logout flow completes successfully',
    'Applying redirect logic globally without path checks; matching all routes including API calls; not excluding static assets and API endpoints from middleware',
    0.95,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/78482594/how-to-prevent-infinite-loop-when-redirecting-using-middleware-in-next-js',
    'admin:1764173550'
);
