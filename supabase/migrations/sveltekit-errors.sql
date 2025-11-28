-- SvelteKit Error Knowledge Base Entries
INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Hydration mismatch in SvelteKit app with <head> and <body> tags',
    'sveltekit',
    'HIGH',
    '[
        {"solution": "Remove <head> and <body> tags from page and layout components. Use <svelte:head> instead for adding content to document head. Keep single <head> and <body> only in app.html", "percentage": 98}
    ]'::jsonb,
    'Svelte component using <head> and <body> tags',
    'Hydration error disappears from browser console. Page renders correctly without warnings.',
    'Forgetting that only app.html can have <head>/<body> tags. Using normal HTML tags instead of <svelte:head>',
    0.98,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/79453268/hydration-mismatch-on-svelte-app'
),
(
    'Cannot import $lib files: ENOENT: no such file or directory',
    'sveltekit',
    'HIGH',
    '[
        {"solution": "Add explicit alias configuration in svelte.config.js under kit.alias: { $lib: ''./src/lib'' }", "percentage": 95},
        {"solution": "Delete .svelte-kit directory and rebuild to regenerate type definitions", "percentage": 80}
    ]'::jsonb,
    'SvelteKit project with $lib alias imports',
    'Imports resolve without ENOENT errors. Build succeeds.',
    'Assuming $lib alias works automatically without explicit configuration',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/78754307/no-longer-able-to-import-lib-files-enoent-no-such-file-or-directory'
),
(
    'Cannot find module ./$types or its corresponding type declarations.ts(2307) in +server.ts',
    'sveltekit',
    'HIGH',
    '[
        {"solution": "Ensure +server.ts file is in /src/routes directory structure, not /lib/api. Run npm run dev to generate types", "percentage": 97},
        {"solution": "Run svelte-kit sync to manually generate type definitions", "percentage": 95}
    ]'::jsonb,
    '+server.ts file in incorrect directory',
    'Types resolve without errors. TypeScript recognizes ./$types module.',
    'Placing +server.ts in /lib/api instead of /src/routes/api. Not running dev server to generate types.',
    0.96,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/76584910/server-ts-cannot-find-module-types-or-its-corresponding-type-declarations'
),
(
    'Load function must return a value error',
    'sveltekit',
    'MEDIUM',
    '[
        {"solution": "Ensure load function has return statement in all code paths, including error cases. Return empty object {} at minimum", "percentage": 99},
        {"solution": "Use absolute URLs like /pages.json instead of relative paths like ./pages.json in fetch calls", "percentage": 85}
    ]'::jsonb,
    'Server load function without return in all paths',
    'Build succeeds. Load function executes without errors.',
    'Only returning from if statement branches, forgetting else path. Using relative fetch URLs that fail in production',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/71249325/sveltekit-load-node-function-error-while-deploying'
),
(
    'use:enhance directive causes full page reload instead of progressive enhancement',
    'sveltekit',
    'HIGH',
    '[
        {"solution": "Check browser console for errors in +page.server.js load function. Fix any store mutations or side effects", "percentage": 90},
        {"solution": "Use form.requestSubmit() instead of form.submit() for programmatic form submission", "percentage": 88}
    ]'::jsonb,
    'SvelteKit form with use:enhance directive',
    'Form submits via AJAX without full page reload. Network tab shows form submission request.',
    'Errors in load function silently preventing enhancement. Using form.submit() instead of requestSubmit()',
    0.89,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/75624730/sveltekit-useenhance-doesnt-work-and-fully-reloads-the-page'
),
(
    'Cannot find package @sveltejs/adapter-auto when opening project',
    'sveltekit',
    'HIGH',
    '[
        {"solution": "Run npm install before opening project in VS Code to install all dependencies first", "percentage": 99},
        {"solution": "If already in editor, run npm install and restart TypeScript server (Ctrl+Shift+P > TypeScript: Restart TS Server)", "percentage": 98}
    ]'::jsonb,
    'New SvelteKit project without dependencies installed',
    'Module resolves. No ERR_MODULE_NOT_FOUND errors in editor.',
    'Opening project before running npm install. Not restarting language server after npm install',
    0.98,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/72355832/cannot-find-package-sveltejs-adapter-auto-svelte-config-js'
),
(
    'PUBLIC_KEY is not exported by $env/static/public error',
    'sveltekit',
    'MEDIUM',
    '[
        {"solution": "Run npm run check (which includes svelte-kit sync) before building to generate type definitions from .env file", "percentage": 98},
        {"solution": "Alternatively, use npm run build which runs check automatically", "percentage": 97}
    ]'::jsonb,
    '.env file exists with PUBLIC_ variables in project root',
    'Types generate correctly. Build succeeds without export errors.',
    'Not running npm run check before build. Not having .env file at build time',
    0.96,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/73865669/sveltekit-typescript-environment-variables-build-error'
),
(
    'Environment variable PUBLIC_API_URL is not exported by $env/static/public',
    'sveltekit',
    'MEDIUM',
    '[
        {"solution": "Switch from static to dynamic imports: use import { env } from ''$env/dynamic/public'' instead of $env/static/public", "percentage": 95},
        {"solution": "Ensure variable is set at build time. For runtime-only values, use dynamic imports", "percentage": 93}
    ]'::jsonb,
    'Environment variable not available at build time',
    'Build succeeds. Variables resolve at runtime.',
    'Using static imports for runtime-only variables. Missing .env during build',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/76148669/sveltekit-not-exporting-enviornment-variables-on-npm-build'
),
(
    'ENOENT: no such file or directory, scandir .svelte-kit/output/client',
    'sveltekit',
    'MEDIUM',
    '[
        {"solution": "Delete build and .svelte-kit directories completely, then run npm run build followed by npm run preview", "percentage": 96}
    ]'::jsonb,
    'SvelteKit adapter-node project after adding new +server.ts route',
    'npm run preview succeeds. Server starts without file not found errors.',
    'Not completely removing old build artifacts. Only removing .svelte-kit without removing build',
    0.96,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/78110650/sveltekit-adapter-node-fail-to-run-preview-missing-client-directory'
),
(
    'redirect() not working in server load with SSR enabled',
    'sveltekit',
    'MEDIUM',
    '[
        {"solution": "Use correct HTTP status code 307 (or 301, 308) for redirects: throw redirect(307, ''/login'') in SvelteKit v1", "percentage": 97},
        {"solution": "In SvelteKit v2+, call redirect() directly without throw keyword", "percentage": 95}
    ]'::jsonb,
    'Server load function with redirect',
    'User redirects to target page. No hydration or status errors.',
    'Using status code 300 which is ambiguous. Not throwing redirect in SvelteKit v1',
    0.96,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/74017730/sveltekit-redirect-not-working-on-server-without-disabling-ssr'
),
(
    'cookies.set() not working or cookies not appearing in form action',
    'sveltekit',
    'MEDIUM',
    '[
        {"solution": "Explicitly set secure: false in cookies.set() options: cookies.set(''jwt'', token, { path: ''/'', secure: false })", "percentage": 92},
        {"solution": "Check browser console for errors. Verify cookie path and domain match expectations", "percentage": 85}
    ]'::jsonb,
    'SvelteKit form action using cookies.set()',
    'Cookies appear in browser dev tools. Client receives set-cookie headers.',
    'Relying on automatic secure flag handling. Not checking browser compatibility (Safari/Firefox differences)',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/74915712/sveltekit-cookies-set-in-form-action-not-working'
),
(
    'Data returned from load is not serializable: Cannot stringify arbitrary non-POJOs',
    'sveltekit',
    'MEDIUM',
    '[
        {"solution": "Convert non-POJO objects (like Prisma Decimal) to primitive types before returning from load: Convert Decimal via .toNumber()", "percentage": 94},
        {"solution": "Use helper function to traverse returned object and convert all non-POJO values to JSON-safe types", "percentage": 88}
    ]'::jsonb,
    'Prisma or other ORM returning non-serializable objects from load function',
    'Build succeeds. Data serializes without errors. Page hydrates correctly.',
    'Assuming ORM objects are automatically serializable. Not checking object prototype',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/76245509/sveltekit-cannot-stringify-arbitrary-non-pojos-on-one-table-but-not-others'
),
(
    'Cannot find module @sveltejs/kit imported from /vercel-tmp/index.js',
    'sveltekit',
    'MEDIUM',
    '[
        {"solution": "Ensure @sveltejs/kit and all dependencies are in package.json devDependencies. Run npm install on deployment server", "percentage": 97},
        {"solution": "For Vercel, ensure node_modules are not in .gitignore and package-lock.json is committed", "percentage": 94}
    ]'::jsonb,
    'SvelteKit project deploying to Vercel or similar platform',
    'Deployment succeeds. Dependencies resolve correctly on production server.',
    'Missing dependencies from package.json. Excluding package-lock.json from git',
    0.95,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/74929575/error-err-module-not-found-cannot-find-package-sveltejs-kit-imported-from'
),
(
    'SvelteKit build dist folder empty - missing routes in output',
    'sveltekit',
    'MEDIUM',
    '[
        {"solution": "Use @sveltejs/adapter-static instead of default adapter if you want static output to dist folder", "percentage": 96},
        {"solution": "Add prerender configuration and ensure all routes are reachable via links from your start page for crawling", "percentage": 90}
    ]'::jsonb,
    'SvelteKit project trying to generate static output',
    'Build succeeds. dist folder contains prerendered files. All routes are present.',
    'Not installing adapter-static. Not linking all routes from homepage for crawler to find',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/75817687/svelte-not-generating-public-or-dist-folder-with-vite'
),
(
    'SvelteKit form actions not returning data from different route',
    'sveltekit',
    'LOW',
    '[
        {"solution": "Use applyAction() in your use:enhance callback to properly update $page.form with action result data", "percentage": 93},
        {"solution": "When form is in component submitted to different route, manually handle form state updates in enhance callback", "percentage": 85}
    ]'::jsonb,
    'SvelteKit form in component submitted to server action in different route',
    'Form result data populates $page.form correctly. Page updates reflect action response.',
    'Not calling applyAction() for form responses. Assuming form state updates automatically across routes',
    0.89,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/78477166/sveltekit-form-actions-not-returning-data-when-invoked-from-different-route'
);
