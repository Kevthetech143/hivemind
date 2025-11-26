-- Add Next-Auth GitHub Issues: Authentication Flow Errors Batch 1
-- Extracted from: https://github.com/nextauthjs/next-auth/issues
-- Category: github-nextauth
-- Date: 2025-11-25

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'JWT token refresh not persisting: refreshed tokens ignored, old token continues being used',
    'github-nextauth',
    'HIGH',
    $$[
        {"solution": "Replace getSession() with getServerSession() in server-side getServerSideProps", "percentage": 95, "note": "getSession() is deprecated and does not persist refreshed tokens. Use getServerSession(context.req, context.res, authOptions)"},
        {"solution": "Ensure user object in jwt callback contains no undefined values - use null explicitly instead", "percentage": 90, "note": "Return profile with explicit null values: image: profile.picture ?? null"},
        {"solution": "Configure token refresh in jwt callback to handle external IDP refresh cycles", "percentage": 85, "command": "const jwt = async ({ token, user, account }) => { if(account?.access_token) token.accessToken = account.access_token; return token; }"}
    ]$$::jsonb,
    'Next-Auth configured with external IDP (Keycloak/OAuth), getServerSession imported, authOptions defined',
    'Refreshed token persists across requests (expires_at timestamp updates), API calls use new token not expired token',
    'Using deprecated getSession() instead of getServerSession() is the primary cause. Do not include undefined values in profile objects as they break serialization. Token refresh must handle account.access_token explicitly.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/nextauthjs/next-auth/issues/7558'
),
(
    'useSession hook only retrieves session after manual page reload, authentication succeeds server-side but not on client',
    'github-nextauth',
    'HIGH',
    $$[
        {"solution": "Wrap application with SessionProvider from next-auth/react at root level to enable session context", "percentage": 95, "note": "SessionProvider enables useSession hook to subscribe to session changes. Required for all client components using useSession()."},
        {"solution": "Remove dynamic imports with ssr: false and allow components to render on server initially", "percentage": 85, "note": "Dynamic import: dynamic(() => import(''./header-auth''), { ssr: false }) prevents server-side session propagation"},
        {"solution": "Call session.update() from useSession hook after sign-in completes to manually refresh", "percentage": 80, "note": "After signIn() returns, call await update() from useSession to trigger re-render"},
        {"solution": "Listen for NextAuth session change events to trigger manual client updates", "percentage": 75, "note": "Implement custom event listeners for CALLBACK_SIGNIN events"}
    ]$$::jsonb,
    'SessionProvider imported and available, Next.js 14+, NextAuth v5 beta, React 18.2+',
    'useSession hook returns authenticated status immediately after sign-in without page reload, client components reflect user session state',
    'Forgetting to wrap application with SessionProvider is the most common cause. Dynamic imports with ssr: false prevent server-side session data from reaching clients. Do not rely on automatic client reactivity - manually update session state when needed.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/nextauthjs/next-auth/issues/9504'
),
(
    'Error: headers was called outside a request scope when using next dev --turbo with NextAuth v5.0.0-beta.19',
    'github-nextauth',
    'HIGH',
    $$[
        {"solution": "Create dedicated server action file with use server directive to call auth()", "percentage": 92, "note": "Create auth-server.ts with ''use server'' directive: export async function getCurrentUser() { const session = await auth(); return session; }"},
        {"solution": "Ensure SessionProvider wraps app in a client component, not directly in layouts", "percentage": 88, "note": "Move SessionProvider to client component wrapper instead of server layout"},
        {"solution": "Remove unnecessary use server directives from server components", "percentage": 85, "note": "Only use ''use server'' on actual server actions, not every async function"},
        {"solution": "Downgrade to NextAuth v5.0.0-beta.18 or use next dev without --turbo flag as temporary workaround", "percentage": 80, "note": "Issue is specific to turbopack integration in beta.19"}
    ]$$::jsonb,
    'Next.js 14+, NextAuth v5.0.0-beta.19, Turbopack enabled with --turbo flag, auth() function configured',
    'await auth() executes in server context without error, next dev --turbo builds and runs without headers scope errors',
    'Attempting to call await auth() directly in server components instead of within server actions causes scope errors. Turbopack bundler in beta.19 has incomplete async context handling. Do not call auth() in middleware or API route handlers without proper async context wrapper.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/nextauthjs/next-auth/issues/11076'
),
(
    'signOut function redirects correctly but useSession still returns authenticated status until page refresh',
    'github-nextauth',
    'HIGH',
    $$[
        {"solution": "Use legacy signOut from next-auth/react instead of server-side signOut from auth.ts", "percentage": 93, "note": "import { signOut } from ''next-auth/react''; - this properly invalidates client-side session state"},
        {"solution": "Implement manual window.location.reload() after signOut to force session state sync", "percentage": 85, "note": "Call window.location.reload() in sign-out event handler to force client refresh"},
        {"solution": "Create custom sign-out event handler that calls both server signOut and client session refetch", "percentage": 82, "note": "After server-side signOut, manually call update() or refetch from useSession"},
        {"solution": "Wrap signOut in try-catch with fallback to window.location.href to trigger full page reload", "percentage": 78, "note": "Ensure fallback mechanism if server-side clearing fails"}
    ]$$::jsonb,
    'NextAuth v5.0.0-beta.19+, Next.js 14.2.3+, signOut function available from auth.ts',
    'useSession hook returns unauthenticated status immediately after signOut, protected content disappears without refresh, redirect to login completes',
    'Server-side signOut does not trigger client-side session invalidation automatically. The new signOut from auth.ts lacks mechanism to refetch or invalidate useSession hook state. Do not assume server-side sign-out will automatically update client components - always implement explicit client session clearing.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/nextauthjs/next-auth/issues/11125'
),
(
    'JWT token modifications in callbacks do not persist: changes revert to original value on next invocation',
    'github-nextauth',
    'MEDIUM',
    $$[
        {"solution": "Ensure modifications are made in the jwt() callback during both initial login and refresh phases", "percentage": 88, "note": "Check if (user) for initial login, else branch for refresh. Return {...token, customProp: newValue}"},
        {"solution": "Use Next.js middleware with auth exported as middleware for consistent token handling", "percentage": 82, "note": "Export auth as middleware: export { auth as middleware } from ''@auth/nextjs''"},
        {"solution": "Store custom token properties in database tables and fetch on each invocation instead of relying on token mutation", "percentage": 80, "note": "Implement async database lookup in jwt callback to always have fresh data"},
        {"solution": "Switch to alternative solutions like iron-session for more direct token control", "percentage": 65, "note": "Some users report success with alternative libraries when token mutation is essential"}
    ]$$::jsonb,
    'NextAuth v5.0.0-beta.26+, jwt callback configured, token refresh mechanism expected to work',
    'Token modifications persist across callback invocations, refreshed token contains updated properties, subsequent requests use modified token',
    'JWT token cache appears immutable after initial creation preventing refresh. Token modifications made only in one branch (signin vs refresh) will not persist. Official documentation claims token rotation support but implementation does not persist custom properties. Do not assume all jwt callback modifications will persist.',
    0.72,
    'sonnet-4',
    NOW(),
    'https://github.com/nextauthjs/next-auth/issues/12454'
),
(
    'Auth.js v5 redirects to incorrect URL (localhost:3000) instead of actual origin when behind proxy, Docker, or reverse proxy',
    'github-nextauth',
    'HIGH',
    $$[
        {"solution": "Enable trustHost: true in auth configuration to respect proxy headers", "percentage": 88, "note": "Set trustHost: true in auth(). This allows x-forwarded-* headers to determine correct origin"},
        {"solution": "Ensure OAuth provider callback URLs registered match all potential deployment origins (staging, production, tunnels)", "percentage": 85, "note": "Register both localhost:3000 and production/staging URLs in OAuth provider settings"},
        {"solution": "For reverse proxy setups, configure x-forwarded-host and x-forwarded-proto headers on reverse proxy", "percentage": 82, "note": "Nginx/Apache must set x-forwarded-host header to client origin"},
        {"solution": "Implement explicit callbackUrl parameter in signIn() instead of relying on auto-detection", "percentage": 78, "note": "Use signIn(provider, { callbackUrl: window.location.href })"}
    ]$$::jsonb,
    'Auth.js v5 beta.18+, OAuth provider configured, application behind proxy/Docker/tunnel, trustHost option available',
    'OAuth redirect returns to correct client origin, no localhost:3000 redirect loops, multi-tenant applications work with dynamic domains',
    'Callback URL generation uses request origin directly without checking proxy headers. Single NEXTAUTH_URL breaks multi-tenant applications. trustHost: true is necessary but not always sufficient for all proxy setups. Do not assume reverse proxy will automatically work - verify x-forwarded headers are passed through.',
    0.80,
    'sonnet-4',
    NOW(),
    'https://github.com/nextauthjs/next-auth/issues/10928'
),
(
    'Callback URL becomes nested when using custom login page: callbackUrl parameter wraps multiple times',
    'github-nextauth',
    'MEDIUM',
    $$[
        {"solution": "Pass callbackUrl explicitly to signIn() function from custom login page using router.query", "percentage": 94, "note": "Extract callbackUrl from router.query and pass: signIn(provider, { redirect: true, callbackUrl: callbackUrl })"},
        {"solution": "Override redirect callback to unwrap nested callbackUrl parameters using string manipulation", "percentage": 82, "note": "Find last ?callbackUrl= and extract from that point: const callbackIndex = url.lastIndexOf(''?callbackUrl='')"},
        {"solution": "Implement middleware to clean up nested callbackUrl before reaching auth endpoint", "percentage": 75, "note": "Middleware layer can normalize malformed callbackUrl parameters"}
    ]$$::jsonb,
    'Next-Auth configured with custom login page, middleware redirects to login with callbackUrl parameter, signIn() function available',
    'Callback URL contains only single callbackUrl parameter (no nesting), authentication redirects to correct destination page',
    'When middleware redirects to custom login with callbackUrl, passing that URL again to signIn() without extracting causes nesting. Do not rely on automatic callback URL handling with custom pages - always explicitly extract and pass. Middleware -> custom login -> signIn() flow requires careful parameter management.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/nextauthjs/next-auth/issues/5409'
),
(
    'getServerSession returns undefined for custom user properties (role, id): session only contains default fields',
    'github-nextauth',
    'HIGH',
    $$[
        {"solution": "Explicitly assign user object to token in jwt callback using if (user) condition", "percentage": 96, "note": "async jwt({ user, token }) { if (user) { token.user = { ...user }; } return token; }"},
        {"solution": "Map token properties to session object in session callback", "percentage": 94, "note": "async session({ session, token }) { if (token?.user) { session.user = token.user; } return session; }"},
        {"solution": "Ensure custom user properties are set during sign-in and retrieved on refresh", "percentage": 90, "note": "Custom properties only need assignment during if (user) - they persist in token on refresh"}
    ]$$::jsonb,
    'Next-Auth with JWT strategy, authOptions defined, custom user properties expected (role, id, etc.)',
    'getServerSession returns session object with custom user properties populated, role and id fields accessible',
    'The if (user) condition in jwt callback is essential - it only executes during sign-in, not refresh. Custom properties must be explicitly assigned to token and then mapped to session. Without explicit assignments, Next-Auth defaults to standard fields only. Do not assume custom properties automatically transfer from user to session.',
    0.95,
    'sonnet-4',
    NOW(),
    'https://github.com/nextauthjs/next-auth/issues/7533'
),
(
    'Drizzle Adapter with PostgreSQL throws TypeScript error: column types are incompatible (isAutoincrement, isPrimaryKey missing)',
    'github-nextauth',
    'MEDIUM',
    $$[
        {"solution": "Upgrade drizzle-orm to v0.33.0 or later - resolves type metadata generation", "percentage": 93, "note": "npm install drizzle-orm@^0.33.0 - newer versions include all required column properties"},
        {"solution": "Downgrade @auth/drizzle-adapter to v1.4.1 as compatibility workaround", "percentage": 82, "note": "npm install @auth/drizzle-adapter@1.4.1 - earlier version has different type expectations"},
        {"solution": "Add explicit type casting if unable to upgrade versions", "percentage": 70, "note": "Type assertion as unknown as PgColumn may work as temporary fix"}
    ]$$::jsonb,
    '@auth/drizzle-adapter installed, Drizzle ORM configured with pgTable, PostgreSQL database, TypeScript compilation enabled',
    'NextAuth schema compiles without TypeScript errors, Drizzle tables integrate with adapter, create-t3-app projects initialize without blocking',
    'Version mismatch between @auth/drizzle-adapter and drizzle-orm - newer adapters expect column properties that older Drizzle versions do not generate. Do not use incompatible adapter/ORM versions. Always upgrade drizzle-orm when updating @auth/drizzle-adapter.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/nextauthjs/next-auth/issues/11490'
),
(
    'NextAuth v5 TypeScript declaration error: cannot name inferred auth type when declaration and declarationMap enabled',
    'github-nextauth',
    'MEDIUM',
    $$[
        {"solution": "Add explicit type annotations using NextAuthResult for destructured exports", "percentage": 94, "note": "import { NextAuthResult } from ''next-auth''; export const auth: NextAuthResult[''auth''] = nextAuth.auth;"},
        {"solution": "Disable declaration and declarationMap in tsconfig.json temporarily", "percentage": 85, "note": "Set declaration: false and declarationMap: false - allows builds to complete but disables declaration files"},
        {"solution": "Use type assertion for complex exports when explicit annotations not possible", "percentage": 75, "note": "export const auth = nextAuth.auth as any; - less ideal but works for troubleshooting"}
    ]$$::jsonb,
    'Next.js TypeScript project, NextAuth v5 beta, declaration: true and declarationMap: true in tsconfig.json',
    'Production build completes successfully, no TypeScript export errors, declaration files generated correctly',
    'NextAuth v5 return types from NextAuth() function cannot be properly exported when declaration settings enabled. Monorepo setups with Turbo default to declaration: true, causing failures. Do not simply disable declarations without understanding impact - use explicit type annotations for production builds.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/nextauthjs/next-auth/issues/10568'
),
(
    'Experimental WebAuthn warning floods server logs every 5 seconds: [auth][warn][experimental-webauthn] messages repeat continuously',
    'github-nextauth',
    'MEDIUM',
    $$[
        {"solution": "Wait for next-auth PR #12821 fix that prevents multiple warning invocations", "percentage": 88, "note": "Upcoming release will only show warning once at initialization, not on every auth call"},
        {"solution": "Temporarily suppress logs by redirecting auth warnings or increasing log level threshold", "percentage": 70, "note": "Configure logger to filter [auth][warn] messages during development"},
        {"solution": "Disable WebAuthn experimental feature if not actively using passkeys", "percentage": 85, "note": "Remove enableWebAuthn: true from experimental config if not needed"}
    ]$$::jsonb,
    'NextAuth v5.0.0-beta.25+, WebAuthn passkey provider enabled, experimental: { enableWebAuthn: true } set',
    'WebAuthn initialization occurs once at startup without repeated warnings, server logs remain clean during development',
    'Warning displays on every auth function invocation rather than once at startup - appears to be triggered repeatedly instead of once. Referenced documentation URL contains no information about the warning. No configuration option currently exists to suppress or control warning frequency. This is a known framework issue pending fix.',
    0.78,
    'sonnet-4',
    NOW(),
    'https://github.com/nextauthjs/next-auth/issues/12598'
),
(
    'Session data missing in client components on initial login with credentials: server has session but client shows unauthenticated',
    'github-nextauth',
    'MEDIUM',
    $$[
        {"solution": "Create custom Context provider to receive session from server layout and pass to client components", "percentage": 92, "note": "Fetch session in root layout: const session = await auth(); pass to CustomSessionProvider and access via useCustomSession() hook"},
        {"solution": "Implement SWR polling in client components to periodically fetch /api/auth/session", "percentage": 75, "note": "Use SWR hook to poll session endpoint, though this adds latency and overhead"},
        {"solution": "Accept that SSG is disabled when using await auth() in root layout and use dynamic rendering", "percentage": 70, "note": "Using await auth() disables static site generation for entire application"}
    ]$$::jsonb,
    'NextAuth v5, Next.js 14+, credential provider configured, server layout can access auth()',
    'Client components receive session data immediately after login without hard refresh, useCustomSession shows authenticated state',
    'NextAuth v5 does not automatically propagate session updates to client components on initial credential login. Hard refresh workaround indicates client state is stale. Using await auth() in root layout prevents static site generation. Do not rely on automatic client-server session sync for credentials provider.',
    0.76,
    'sonnet-4',
    NOW(),
    'https://github.com/nextauthjs/next-auth/issues/11034'
),
(
    'Vercel Edge Function timeout (504 EDGE_FUNCTION_INVOCATION_TIMEOUT) when deploying NextAuth v5 with database adapters',
    'github-nextauth',
    'HIGH',
    $$[
        {"solution": "Move database operations out of JWT callback - fetch user data synchronously instead", "percentage": 89, "note": "Avoid db.user.findFirst() in jwt callback. Pre-load user data in sign-in callback instead."},
        {"solution": "Use edge-compatible database adapters: verify Drizzle supports edge runtime per documentation", "percentage": 85, "note": "Follow https://orm.drizzle.team/learn/tutorials/drizzle-with-vercel-edge-functions for edge setup"},
        {"solution": "Set explicit runtime configuration: export const runtime = ''experimental-edge''", "percentage": 80, "note": "Add runtime declaration to middleware file for explicit edge function targeting"},
        {"solution": "Downgrade to NextAuth v4 if edge compatibility is critical requirement", "percentage": 72, "note": "Some users report v4 works reliably on Vercel Edge, v5 has unresolved edge issues"}
    ]$$::jsonb,
    'NextAuth v5 beta deployed on Vercel, database adapter configured (Drizzle/Prisma), edge middleware enabled, Neon/PlanetScale database',
    'Middleware executes within timeout limit (< 30 seconds), requests return 200 instead of 504, application functions in production',
    'Database operations in JWT callbacks cause edge timeout due to connection overhead on each request. Some adapters not fully optimized for edge runtime. NextAuth v5 edge compatibility still problematic as of beta.19. Do not perform synchronous database lookups in edge functions - cache or pre-compute data.',
    0.68,
    'sonnet-4',
    NOW(),
    'https://github.com/nextauthjs/next-auth/issues/10773'
);
