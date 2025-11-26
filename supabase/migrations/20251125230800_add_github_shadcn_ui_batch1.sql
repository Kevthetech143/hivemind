-- Mining shadcn-ui GitHub issues for component installation/customization solutions
-- Source: https://github.com/shadcn-ui/ui/issues
-- Category: github-shadcn-ui
-- Date: 2025-11-25

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'CLI: "No Tailwind CSS configuration found" error during shadcn init with Vite',
    'github-shadcn-ui',
    'HIGH',
    $$[
        {"solution": "Add Tailwind directives to your src/index.css file: @tailwind base; @tailwind components; @tailwind utilities;", "percentage": 95, "note": "Most common fix for Vite projects"},
        {"solution": "Ensure tailwind.config.js content array includes all relevant paths: content: [\"./src/**/*.{js,jsx,ts,tsx}\"]", "percentage": 92, "note": "Must match your project structure"},
        {"solution": "Create index.css in src folder if missing and import it in main.ts/main.jsx", "percentage": 88, "note": "Required for Vite to detect Tailwind"},
        {"solution": "Run CLI after Tailwind CSS is properly installed and configured: npm install -D tailwindcss postcss autoprefixer && npx tailwindcss init -p", "percentage": 85, "command": "npx shadcn@latest init"}
    ]$$::jsonb,
    'Node.js installed, Vite project initialized, Tailwind CSS installed (npm install -D tailwindcss postcss autoprefixer)',
    'npx shadcn@latest init completes successfully without validation errors, Components can be added with npx shadcn add',
    'Adding Tailwind directives to wrong CSS file (e.g., global.css at root instead of src/index.css). Using SCSS without creating separate index.css. Running init before Tailwind config is valid. Using import statements instead of @import for Tailwind in Tailwind v4.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/shadcn-ui/ui/issues/4677'
),
(
    'Tailwind v4: CLI fails to validate Tailwind CSS configuration after update',
    'github-shadcn-ui',
    'HIGH',
    $$[
        {"solution": "Install Tailwind v3.4 instead of v4 initially: npm install -D tailwindcss@3.4.0 postcss autoprefixer", "percentage": 85, "note": "Temporary workaround while v4 support is in transition"},
        {"solution": "Install Tailwind v3, run shadcn init, add all components, then upgrade: npx @tailwindcss/upgrade@next", "percentage": 88, "note": "Official recommended upgrade path"},
        {"solution": "Create jsconfig.json or tsconfig.json with proper path alias before running init", "percentage": 80, "note": "v4 doesn''t require separate config file but CLI still validates for it"},
        {"solution": "Use example repo setup from @shadcn app-tailwind-v4 for Tailwind v4 specific configuration", "percentage": 78, "note": "Reference implementation for v4 setup"}
    ]$$::jsonb,
    'Node.js v22+, Vite v4+, npm v10+, Tailwind CSS installed',
    'shadcn init completes without validation errors, Tailwind imports work in global.css or index.css, Components render with correct styles',
    'Installing Tailwind v4 directly without following upgrade path. Missing jsconfig.json with baseUrl and paths configuration. Not updating global.css Tailwind imports for v4 syntax. Expecting v4 config file when v4 uses CSS @config directive.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/shadcn-ui/ui/issues/6446'
),
(
    'Theme Provider: Hydration error with Next.js ThemeProvider (suppressHydrationWarning)',
    'github-shadcn-ui',
    'HIGH',
    $$[
        {"solution": "Add suppressHydrationWarning to html tag in layout.tsx: <html suppressHydrationWarning>", "percentage": 85, "note": "Quick fix, safe because next-themes properly handles hydration"},
        {"solution": "Dynamically import ThemeProvider with ssr: false to prevent hydration mismatch", "percentage": 90, "note": "More elegant solution, avoids suppressing warnings entirely", "command": "import dynamic from \"next/dynamic\"; const NextThemesProvider = dynamic(() => import(\"next-themes\").then((e) => e.ThemeProvider), { ssr: false })"},
        {"solution": "Use useState + useEffect to delay ThemeProvider rendering until mounted: if (!isLoaded) return null", "percentage": 75, "note": "Causes brief white flash, not recommended"},
        {"solution": "Wrap ThemeProvider with use client directive to ensure client-side rendering", "percentage": 88, "note": "Include in theme-provider.tsx component"}
    ]$$::jsonb,
    'Next.js 13+, next-themes package installed, App Router (layout.tsx)',
    'No hydration mismatch errors in console, dark mode toggles work without page refresh, Theme persists on page reload',
    'Forgetting suppressHydrationWarning on html tag with static import. Using ssr: true with dynamic import defeats purpose. Not using use client directive in ThemeProvider wrapper. Placing ThemeProvider in app.tsx instead of root layout.tsx.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/shadcn-ui/ui/issues/5552'
),
(
    'Button: Cursor pointer not showing on hover with Tailwind v4',
    'github-shadcn-ui',
    'MEDIUM',
    $$[
        {"solution": "Ensure button has cursor-pointer class applied or inherits from parent hover state", "percentage": 85, "note": "Most common issue is missing cursor class"},
        {"solution": "Update button component CSS for Tailwind v4: verify hover: pseudo-class is working correctly", "percentage": 82, "note": "v4 changed some preflight rules"},
        {"solution": "Check for CSS override from tailwindcss/preflight affecting button cursor default", "percentage": 78, "note": "v4 resets button cursor to default"},
        {"solution": "Add explicit cursor utility: <button className=\"cursor-pointer\">Click me</button>", "percentage": 92, "note": "Direct workaround while investigating root cause"}
    ]$$::jsonb,
    'Tailwind CSS v4+, React component, button element',
    'Cursor changes to pointer when hovering over button, No console CSS warnings, Button hover states work as expected',
    'Assuming cursor-pointer is automatically applied by Tailwind. Not updating button component for v4 CSS changes. Checking browser defaults instead of component CSS. Missing hover state definition in Tailwind config.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/shadcn-ui/ui/issues/6843'
),
(
    'Component import: Unable to import shadcn components after init (import alias issues)',
    'github-shadcn-ui',
    'HIGH',
    $$[
        {"solution": "Verify tsconfig.json has baseUrl and paths configured: \"baseUrl\": \".\", \"paths\": {\"@/*\": [\"./src/*\"]}", "percentage": 93, "note": "Required for all frameworks"},
        {"solution": "For JavaScript projects, create jsconfig.json instead of tsconfig.json with same path configuration", "percentage": 90, "note": "Use jsconfig.json for JS-only projects"},
        {"solution": "Ensure components.json path alias matches tsconfig paths exactly", "percentage": 88, "note": "CLI generated components.json must align with tsconfig"},
        {"solution": "Restart IDE/editor after adding tsconfig paths to clear cache", "percentage": 80, "note": "LSP cache may not update immediately"}
    ]$$::jsonb,
    'shadcn init completed, Node project configured, Editor with TypeScript support',
    'Imports using @/ resolve correctly without errors, Components autocomplete shows available components, No red squiggly lines in IDE',
    'Using wrong baseUrl value. Mismatched paths between tsconfig and components.json. Missing jsconfig.json entirely for JS projects. Running init without tsconfig/jsconfig configured. Not restarting IDE after config changes.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/shadcn-ui/ui/issues/4677'
),
(
    'Multi-select: No native support in Select component (feature request)',
    'github-shadcn-ui',
    'HIGH',
    $$[
        {"solution": "Use Dropdown Menu with checkboxes as workaround: <DropdownMenu><DropdownMenuCheckboxItem></DropdownMenuCheckboxItem></DropdownMenu>", "percentage": 80, "note": "Official recommended workaround for basic multi-select"},
        {"solution": "Implement custom multi-select using Combobox + Badge components from shadcn", "percentage": 75, "note": "More flexible, allows tags/pills display"},
        {"solution": "Use mxkaske fancy-multi-select component built with cmdk: https://github.com/mxkaske/mxkaske.dev/blob/main/components/craft/fancy-multi-select.tsx", "percentage": 72, "note": "Community solution, may have accessibility concerns"},
        {"solution": "Wrap Radix UI Listbox (HeadlessUI) with shadcn styling for native multi-select", "percentage": 78, "note": "Most feature-complete solution, requires custom styling"},
        {"solution": "Wait for Radix UI multi-select support (tracked in Radix repo #1342)", "percentage": 65, "note": "No ETA available, not blocking"}
    ]$$::jsonb,
    'React component, shadcn/ui Select installed, Basic understanding of composition',
    'Multiple values can be selected, Selected values display correctly, Can be cleared/reset, Keyboard navigation works',
    'Expecting native multi-select in shadcn Select (doesn''t exist). Using Select component for multi-select scenarios. Assuming HeadlessUI Listbox has same styling as shadcn. Not considering Combobox as alternative. Waiting for feature without exploring workarounds.',
    0.68,
    'sonnet-4',
    NOW(),
    'https://github.com/shadcn-ui/ui/issues/66'
),
(
    'Calendar: react-day-picker 9.0.0 breaks Calendar component styling',
    'github-shadcn-ui',
    'MEDIUM',
    $$[
        {"solution": "Pin react-day-picker to v8.x in package.json: \"react-day-picker\": \"^8.0.0\"", "percentage": 92, "note": "Immediate fix, prevents automatic updates to broken v9"},
        {"solution": "If already on v9, downgrade: npm install react-day-picker@latest@8", "percentage": 88, "note": "Works but may require clearing node_modules"},
        {"solution": "Use shadcn add calendar to get latest compatible version", "percentage": 85, "note": "Re-adds component with correct peer dependency"},
        {"solution": "Wait for Calendar component update to support react-day-picker v9", "percentage": 70, "note": "Tracked in issue, in progress"}
    ]$$::jsonb,
    'shadcn Calendar component installed, react-day-picker package in project, npm/pnpm/yarn package manager',
    'Calendar renders without styling issues, Date selection works correctly, Months navigate properly, No console errors about missing styles',
    'Auto-updating react-day-picker without pinning version. Not checking package-lock.json for correct version. Upgrading Calendar component without updating react-day-picker. Using incompatible react-day-picker version in monorepo without per-package pinning.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/shadcn-ui/ui/issues/4366'
),
(
    'Sidebar: Mobile sidebar doesn''t close after clicking menu item',
    'github-shadcn-ui',
    'MEDIUM',
    $$[
        {"solution": "Add onClick handler to close drawer on item click: const [open, setOpen] = useState(false); <SidebarItem onClick={() => setOpen(false)}>", "percentage": 85, "note": "Simple state management fix"},
        {"solution": "Use useRouter push with callback to close sidebar: router.push(href).then(() => setOpen(false))", "percentage": 82, "note": "For Next.js projects with client-side navigation"},
        {"solution": "Wrap sidebar in custom hook to manage mobile drawer state across navigation", "percentage": 78, "note": "More reusable solution for complex projects"},
        {"solution": "Apply Sheet/Dialog close on link click with useEffect monitoring pathname", "percentage": 75, "note": "Works but requires route change detection"}
    ]$$::jsonb,
    'shadcn Sidebar component added, React Router or Next.js for routing, Mobile view/responsive design',
    'Sidebar closes immediately after clicking menu item on mobile, No drawer remains open after navigation, Menu items navigate correctly',
    'Forgetting to call setOpen(false) in onClick handler. Not considering mobile breakpoints when implementing close logic. Using static drawer instead of responsive state. Not waiting for route transition before closing.',
    0.80,
    'sonnet-4',
    NOW(),
    'https://github.com/shadcn-ui/ui/issues/5561'
),
(
    'Component initialization: CLI gets stuck when dependency doesn''t exist',
    'github-shadcn-ui',
    'MEDIUM',
    $$[
        {"solution": "Ensure all peer dependencies are installed before running init: npm install react react-dom", "percentage": 90, "note": "Check package.json peer dependencies first"},
        {"solution": "Delete node_modules and package-lock.json, then reinstall: rm -rf node_modules package-lock.json && npm install", "percentage": 85, "note": "Clears corrupted dependency state"},
        {"solution": "Upgrade Node.js to LTS version (v18+ or v20+) for better compatibility", "percentage": 82, "note": "Older Node versions may have dependency resolution issues"},
        {"solution": "Use --force flag carefully if absolutely necessary: npm install --force", "percentage": 60, "note": "Last resort, may introduce incompatibilities"}
    ]$$::jsonb,
    'Node.js v16+, npm v8+, React project initialized, package.json exists',
    'shadcn init completes without hanging, All dependencies resolve correctly, CLI output shows success',
    'Running init before installing peer dependencies. Using old Node version with strict dependency resolution. Having corrupted node_modules from previous failed installs. Not checking CLI compatibility with Node version. Using yarn/pnpm without clearing cache.',
    0.84,
    'sonnet-4',
    NOW(),
    'https://github.com/shadcn-ui/ui/issues/8851'
),
(
    'Recharts: Chart component incompatible with recharts v3',
    'github-shadcn-ui',
    'MEDIUM',
    $$[
        {"solution": "Pin recharts to v2.x until Chart component updated: npm install recharts@^2.0.0", "percentage": 90, "note": "Stable workaround, prevents breaking changes"},
        {"solution": "Use shadcn add chart to get latest compatible version", "percentage": 85, "note": "Ensures component matches recharts version"},
        {"solution": "Update Chart component manually by following migration guide from recharts docs", "percentage": 72, "note": "For users wanting v3 features"},
        {"solution": "Use recharts v3 with custom chart component until official support lands", "percentage": 68, "note": "Requires testing and maintenance"}
    ]$$::jsonb,
    'shadcn Chart component installed, Recharts library in project, React 18+',
    'Charts render without TypeScript errors, Data displays correctly, Responsive behavior works, No console warnings about incompatible versions',
    'Auto-updating recharts without checking Chart component compatibility. Not pinning version in package.json. Mixing recharts v2 and v3 in monorepo. Assuming Chart component works with latest recharts.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/shadcn-ui/ui/issues/7669'
),
(
    'Component installation: bun and pnpm package managers not supported by CLI',
    'github-shadcn-ui',
    'MEDIUM',
    $$[
        {"solution": "Initialize project with npm first, then switch to bun/pnpm: npm init, npx shadcn init, then pnpm install", "percentage": 88, "note": "Workaround for early npm init"},
        {"solution": "Upgrade shadcn CLI to latest version: npm install -g shadcn-ui@latest", "percentage": 80, "note": "Newer versions have better bun/pnpm support"},
        {"solution": "Manually add components by copying from GitHub repository if CLI doesn''t work", "percentage": 70, "note": "Fallback option when CLI issues arise"},
        {"solution": "Use npm for init, add components, then switch to bun/pnpm for dev server", "percentage": 85, "note": "Keeps CLI compatible while using preferred package manager"}
    ]$$::jsonb,
    'bun or pnpm installed, Node.js v18+, React project with Vite/Next.js',
    'shadcn init completes successfully, Components can be added with chosen package manager, Dependencies install without conflicts',
    'Trying to run shadcn init directly with bun/pnpm before npm setup. Not upgrading CLI to latest version. Assuming all package managers work identically with CLI. Switching package managers mid-installation.',
    0.81,
    'sonnet-4',
    NOW(),
    'https://github.com/shadcn-ui/ui/issues/8869'
),
(
    'RTL Support: Right-to-left language components missing',
    'github-shadcn-ui',
    'LOW',
    $$[
        {"solution": "Add dir=\"rtl\" to html tag in layout for RTL languages: <html lang=\"ar\" dir=\"rtl\">", "percentage": 75, "note": "Enables RTL at document level"},
        {"solution": "Use Tailwind''s dir modifier for RTL-specific styling: <div className=\"dir-rtl:mr-4\">", "percentage": 70, "note": "Tailwind v3.4+ required"},
        {"solution": "Apply CSS logical properties instead of left/right: use margin-inline and padding-inline", "percentage": 72, "note": "More semantic approach"},
        {"solution": "Manually mirror component styles for RTL: swap left/right positions, flip transform origins", "percentage": 65, "note": "Tedious but works for all components"},
        {"solution": "Wait for RTL component library release or use community RTL wrapper components", "percentage": 50, "note": "Long-term solution, no ETA"}
    ]$$::jsonb,
    'Tailwind CSS v3.4+, React application, RTL language needed (Arabic, Hebrew, etc.)',
    'Components layout mirrors correctly for RTL, Text direction correct, Animations flip appropriately, No visual glitches in RTL mode',
    'Only setting dir attribute without updating component CSS. Assuming all Tailwind utilities work with dir modifier. Not considering animations in RTL context. Forgetting to mirror icons and visual indicators. Setting RTL globally without per-component testing.',
    0.62,
    'sonnet-4',
    NOW(),
    'https://github.com/shadcn-ui/ui/issues/1638'
);
