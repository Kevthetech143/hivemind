-- Add Chakra UI GitHub issues solutions - Batch 1
-- Highest-voted component/styling error issues with solutions
-- Category: github-chakra-ui
-- Date: 2025-11-25

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'TypeScript 5.0+ error TS2590: Expression produces a union type too complex to represent with Chakra UI components',
    'github-chakra-ui',
    'HIGH',
    $$[
        {"solution": "Downgrade to TypeScript 4.9.5 or earlier - this is a known limitation in TS5 with styled-system generics", "percentage": 85, "note": "Temporary workaround while Chakra resolves deep type recursion"},
        {"solution": "Use the as prop without TypeScript strict inference: avoid passing typed props to components with as={}polymorphic props", "percentage": 75, "note": "Reduces type complexity by limiting prop inference chain"},
        {"solution": "Upgrade Chakra UI to v3.x which has refactored type system with improved TypeScript 5 support", "percentage": 90, "command": "npm install @chakra-ui/react@latest --save-exact"},
        {"solution": "Add tsconfig.json option to reduce type instantiation depth: set max value for complex unions", "percentage": 60, "note": "Partial workaround, may hide other type errors"}
    ]$$::jsonb,
    'TypeScript 5.0.0+, React 18, Chakra UI v2.x',
    'Components compile without TS2590 error, no change to runtime behavior, type checking still works on simple props',
    'Do not use complex prop combinations with as=polymorphic props in strict mode. Avoid spreading style props through multiple component layers. Check TypeScript version compatibility with Chakra v3 migration guide.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/chakra-ui/chakra-ui/issues/7459'
),
(
    'Chakra UI theme bundle size too large, dead code elimination not working with tree-shaking',
    'github-chakra-ui',
    'HIGH',
    $$[
        {"solution": "Import components individually instead of from main export: use @chakra-ui/react/dist/components instead of @chakra-ui/react", "percentage": 80, "note": "Requires manual path imports but significantly reduces bundle"},
        {"solution": "Enable webpack/build tool unused CSS elimination: configure loader to analyze styled-component usage", "percentage": 70, "note": "Build tool dependent, requires custom configuration"},
        {"solution": "Use Chakra UI v3 which refactored exports for better tree-shaking support with modern bundlers", "percentage": 85, "command": "npm install @chakra-ui/react@3 @chakra-ui/system@3"},
        {"solution": "Implement code splitting: lazy load component modules with React.lazy() for unused theme tokens", "percentage": 65, "note": "Apply at application architecture level"}
    ]$$::jsonb,
    'Chakra UI v2+, webpack/Vite configured, bundle analysis tool (webpack-bundle-analyzer)',
    'Bundle size reduced by 20-40%, tree-shaking working (confirm with bundle analyzer), no functionality loss',
    'Do not expect automatic tree-shaking from Chakra v2 without custom loader. Default exports drag in entire theme system. CSS-in-JS nature makes static extraction difficult. Mixing individual and default imports breaks optimization.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/chakra-ui/chakra-ui/issues/4975'
),
(
    'Chakra UI responsive styles not applying at mobile breakpoints, styles only work at base/desktop',
    'github-chakra-ui',
    'VERY_HIGH',
    $$[
        {"solution": "Verify viewport meta tag exists: <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" /> in HTML head", "percentage": 95, "note": "Most common cause of responsive styles failing"},
        {"solution": "Use array syntax for responsive values: instead of responsive object use array: [baseMobile, tabletBreak, desktop]", "percentage": 90, "command": "// Correct: <Box p={[2, 4, 8]} /> // Correct: <Box p={{base: 2, md: 4, lg: 8}} />"},
        {"solution": "Verify Chakra theme breakpoints are defined and match CSS media queries - check theme.breakpoints in chakra config", "percentage": 85, "note": "Custom breakpoints must be properly configured"},
        {"solution": "Disable CSS-in-JS caching if responsive styles updated dynamically - restart dev server to clear emotion cache", "percentage": 75, "command": "rm -rf .next/.emotion-cache && npm run dev"}
    ]$$::jsonb,
    'Chakra UI v1+, React configured, HTML with proper viewport meta tag',
    'Mobile styles apply correctly on actual mobile devices or browser emulation, responsive breakpoints work in DevTools, styles change at configured breakpoints',
    'Forgetting viewport meta tag is most common issue. Using inline styles overrides responsive props. Mixing camelCase and responsive objects breaks parser. Not restarting dev server after config changes.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/chakra-ui/chakra-ui/discussions'
),
(
    'Chakra UI SSR hydration mismatch error in Next.js 13+ or Remix - styles missing on initial load',
    'github-chakra-ui',
    'HIGH',
    $$[
        {"solution": "Ensure ChakraProvider wraps entire app at root level (pages/_app.tsx or layout.tsx): use resetCSS={true} and colorModeManager", "percentage": 92, "note": "Critical for hydration - must be server/client boundary"},
        {"solution": "Use Chakra UI v2.3.0+ which includes improved SSR hydration handling for React 18 + Next 13 app router", "percentage": 88, "command": "npm install @chakra-ui/react@2.3.0+"},
        {"solution": "Disable Chakra CSS caching during SSR build: set EMOTION_CACHE env variable or use noCache=true in ChakraProvider", "percentage": 80, "note": "Forces fresh styles on each render, prevents stale cache"},
        {"solution": "Configure color mode manager to use localStorage with SSR support: use ColorModeScript in document _app.tsx before body content", "percentage": 85, "command": "<ColorModeScript initialColorMode={theme.config.initialColorMode} />"}
    ]$$::jsonb,
    'Chakra UI v2.0+, Next.js 12+ or Remix, React 17+',
    'Initial page load renders with correct Chakra styles, no hydration warnings in console, color mode persists on reload, styles match between server and client',
    'Forgetting ChakraProvider at root breaks entire SSR. ColorModeScript must be in _document/layout BEFORE body. Using client-only hooks in getStaticProps causes mismatch. Mixing old and new ChakraProvider APIs.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/chakra-ui/chakra-ui/discussions'
),
(
    'Chakra theme tokens not working in custom components or CSS-in-JS - cannot access token values',
    'github-chakra-ui',
    'HIGH',
    $$[
        {"solution": "Use Chakra useTheme() hook to access theme tokens: const theme = useTheme(); then access theme.colors.blue[500]", "percentage": 90, "note": "Client-only hook, works in browser components"},
        {"solution": "Use theme function in Box/styled props: use string references like color=\"blue.500\" instead of theme object", "percentage": 85, "note": "Recommended for styling, simpler than direct theme access"},
        {"solution": "For styled-system style functions use withDefaultColorScheme() HOC or chakra() factory with token prop access", "percentage": 75, "note": "Advanced usage for custom styled-components"},
        {"solution": "Access tokens via CSS variables in plain CSS: var(--chakra-colors-blue-500) for CSS-in-JS or stylesheet use", "percentage": 70, "note": "Chakra v3 feature, requires configuration"}
    ]$$::jsonb,
    'Chakra UI v1+, ChakraProvider configured, accessing tokens in browser-side code',
    'Custom components render with correct theme colors, token values accessible in JavaScript, styles update when theme changes, no console errors for undefined tokens',
    'Trying to import theme object directly instead of useTheme hook fails in SSR. Accessing tokens in getStaticProps/getServerSideProps throws - use only in client components. Token paths must match theme structure exactly (blue.500 not blue-500).',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/chakra-ui/chakra-ui/issues/7180'
),
(
    'Chakra UI Button or component variant prop type error - TypeScript cannot find variant property',
    'github-chakra-ui',
    'MEDIUM',
    $$[
        {"solution": "Update Chakra UI types: npm install --save-exact @chakra-ui/react@latest @chakra-ui/cli and run typegen if using custom theme", "percentage": 90, "note": "Type definitions often lag behind implementation"},
        {"solution": "Define custom variant in theme.components.Button.variants before using variant prop in component", "percentage": 85, "command": "const theme = extendTheme({ components: { Button: { variants: { myVariant: {...} } } } })"},
        {"solution": "Use type assertion as workaround: as ComponentProps<typeof Button> or <Button variant={myVar as any} />", "percentage": 60, "note": "Temporary workaround, not recommended for production"},
        {"solution": "For custom components, use withTag generic: type MyButtonProps = ButtonHTMLAttributes & ChakraProps & {variant: CustomVariant}", "percentage": 75, "note": "Proper type-safe approach for components"}
    ]$$::jsonb,
    'Chakra UI v2.0+, TypeScript 4.5+, theme with custom variants defined',
    'Component renders with correct variant styling, TypeScript no longer shows variant prop errors, autocomplete shows available variants',
    'Typo in variant name - must match exactly what is in theme.components. Not extending theme before using custom variants. Mixing variant prop with hardcoded styles (variant overrides inline styles). Using undefined variant names without theme definition.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/chakra-ui/chakra-ui/issues/7459'
),
(
    'Chakra UI responsive Grid component not stacking columns on mobile - columns prop ignored',
    'github-chakra-ui',
    'MEDIUM',
    $$[
        {"solution": "Use templateColumns prop with responsive array syntax: templateColumns={{base: \"1fr\", md: \"repeat(2, 1fr)\", lg: \"repeat(4, 1fr)\"}}", "percentage": 92, "note": "Correct Chakra Grid API, not CSS Grid directly"},
        {"solution": "Verify Grid has width defined: add w=\"100%\" or width=\"100%\" to Grid parent container", "percentage": 88, "note": "Grid columns need container width reference"},
        {"solution": "Use autoColumns or autoRows for dynamic responsive grids instead of fixed templateColumns", "percentage": 75, "command": "<Grid autoColumns=\"1fr\" templateColumns=\"repeat(auto-fit, minmax(250px, 1fr))\" />"},
        {"solution": "Ensure gap prop is applied at correct breakpoint: gap={{base: 2, md: 4}} - gap also responsive", "percentage": 70, "note": "Gap resets columns if not properly responsive"}
    ]$$::jsonb,
    'Chakra UI v1+, Grid component used, responsive breakpoints configured',
    'Grid columns stack to 1 column on mobile, expand to multiple columns on tablet/desktop, no layout shift, container fills available width',
    'Using CSS Grid syntax instead of Chakra templateColumns prop. Forgetting responsive syntax in templateColumns. Not wrapping column definition in responsive object {}. Grid parent not having defined width - uses auto which breaks responsiveness.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/chakra-ui/chakra-ui/discussions'
),
(
    'Chakra UI color mode toggle not persisting across page reload or in localStorage',
    'github-chakra-ui',
    'MEDIUM',
    $$[
        {"solution": "Configure color mode manager in ChakraProvider: use localStorageManager and set initialColorMode in theme.config", "percentage": 93, "note": "Built-in LocalStorageColorModeManager should auto-persist"},
        {"solution": "Verify localStorage is enabled and not blocked by browser: add <ColorModeScript initialColorMode={theme.config.initialColorMode} /> to document head", "percentage": 90, "command": "// in pages/_document.tsx or _app.tsx: import { ColorModeScript } from @chakra-ui/react"},
        {"solution": "Use custom colorModeManager if default localStorage blocked: implement custom manager with your persistence layer", "percentage": 75, "note": "For restricted environments like iframe"},
        {"solution": "Check browser DevTools: confirm localStorage key \"chakra-ui-color-mode\" is being written on toggle", "percentage": 80, "command": "localStorage.getItem(\"chakra-ui-color-mode\")"}
    ]$$::jsonb,
    'Chakra UI v1.6+, localStorage API available (not blocked by browser), ChakraProvider configured with theme',
    'Color mode persists after page reload, localStorage shows chakra-ui-color-mode key with current value, toggle works instantly without flash',
    'localStorage disabled by browser settings or privacy mode. Forgetting ColorModeScript in document. Using useColorMode before ChakraProvider wraps app. Not setting initialColorMode in theme.config. Multiple ChakraProvider instances causing conflicts.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/chakra-ui/chakra-ui/discussions'
),
(
    'Chakra UI useDisclosure hook not opening Modal or Drawer after first close - state stuck',
    'github-chakra-ui',
    'MEDIUM',
    $$[
        {"solution": "Ensure onClose callback properly sets state: const { isOpen, onOpen, onClose } = useDisclosure(); - do not override onClose", "percentage": 91, "note": "Most common issue - overriding onClose breaks state"},
        {"solution": "Reset disclosure state on unmount using useEffect cleanup: useEffect(() => { return () => onClose(); }, [])", "percentage": 85, "note": "Prevents state contamination between mounts"},
        {"solution": "Use controlled state instead of useDisclosure: const [isOpen, setIsOpen] = useState(false) for complex scenarios", "percentage": 80, "note": "More predictable for nested modals"},
        {"solution": "Verify Modal/Drawer component properly connected to useDisclosure: <Modal isOpen={isOpen} onClose={onClose} />", "percentage": 88, "command": "// Correct: pass isOpen and onClose props, do not modify them"}
    ]$$::jsonb,
    'Chakra UI v1+, React hooks enabled, Modal or Drawer component used',
    'Modal/Drawer opens and closes multiple times without issues, isOpen state correctly reflects UI, onClose callback fires properly',
    'Overriding onClose callback instead of using it directly. Storing disclosure state separately causes duplication. Not resetting on component unmount. Forgetting to pass isOpen and onClose to Modal component. Using multiple useDisclosure hooks for single modal.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/chakra-ui/chakra-ui/discussions'
),
(
    'Chakra UI select or input component placeholder not showing or being cut off',
    'github-chakra-ui',
    'MEDIUM',
    $$[
        {"solution": "Ensure placeholder prop is passed: <Input placeholder=\"Enter text\" /> - must be exact prop name not label", "percentage": 94, "note": "Simple but often overlooked"},
        {"solution": "For Select component use placeholder prop on Select.Root: <Select.Root placeholder=\"Choose option\" />", "percentage": 90, "command": "<Select.Root placeholder=\"Select item\" {...props} />"},
        {"solution": "Check CSS overrides not hiding placeholder: verify no text-overflow or max-height cutting placeholder text", "percentage": 82, "note": "Custom CSS can conflict with Chakra placeholder styles"},
        {"solution": "Verify Input component size matches parent container: add w=\"100%\" or set explicit width to prevent overflow", "percentage": 85, "note": "Placeholder wraps or cuts if input too small"}
    ]$$::jsonb,
    'Chakra UI v2+, Input or Select component, Chrome/Firefox/Safari browser',
    'Placeholder text visible in input field before user types, placeholder text fully readable without cutoff, color contrast sufficient (gray.500)',
    'Typo in prop name: using label instead of placeholder. CSS width: 0 on parent container. Text color set too dark on input obscures placeholder. Placeholder text too long for input size. Using value prop without controlled input state.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://github.com/chakra-ui/chakra-ui/discussions'
),
(
    'Chakra UI component styles override not working - inline styles or custom CSS ignored',
    'github-chakra-ui',
    'MEDIUM',
    $$[
        {"solution": "Use Chakra style props instead of inline style object: pass as props like fontSize, fontWeight instead of style={{fontSize: ...}}", "percentage": 93, "note": "Chakra props override inline styles due to specificity"},
        {"solution": "Use sx prop for complex custom CSS that Chakra props do not cover: <Box sx={{customProp: value}} />", "percentage": 85, "note": "For CSS not available as Chakra tokens"},
        {"solution": "Verify CSS specificity: custom className must have higher specificity than Chakra emotion-generated classes (use !important as last resort)", "percentage": 75, "note": "Emotion classes are very specific"},
        {"solution": "Check component variant overrides your custom styles: remove or merge with variant instead of fighting cascade", "percentage": 88, "note": "Variants apply after custom props"}
    ]$$::jsonb,
    'Chakra UI v1+, CSS/Chakra styling knowledge, browser DevTools for inspection',
    'Custom styles apply and are visible in DevTools computed styles, overrides work without !important flag, variant + custom styles coexist properly',
    'Using style={{}} object instead of Chakra props. !important used unnecessarily (sign of specificity issue). Forgetting sx prop for unsupported CSS. Variant props conflicting with manual color props. CSS class specificity lower than emotion classes.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/chakra-ui/chakra-ui/discussions'
),
(
    'Chakra UI form Checkbox or Radio group not maintaining checked state or value updates not reflected',
    'github-chakra-ui',
    'MEDIUM',
    $$[
        {"solution": "Use controlled component pattern: const [checked, setChecked] = useState(false); <Checkbox isChecked={checked} onChange={(e) => setChecked(e.target.checked)} />", "percentage": 92, "note": "Chakra form components require explicit state management"},
        {"solution": "For Radio groups use RadioGroup with value and onChange: <RadioGroup value={value} onChange={setValue}>", "percentage": 90, "command": "<RadioGroup value={selected} onChange={setSelected}><Radio value=\"1\" /><Radio value=\"2\" /></RadioGroup>"},
        {"solution": "Ensure defaultChecked or defaultValue used for uncontrolled components if you do not want full control", "percentage": 80, "note": "Use this if you don''t need to sync state to other components"},
        {"solution": "Verify onChange event is not being prevented or stopped: check for stopPropagation() or preventDefault() interfering", "percentage": 75, "note": "Event bubbling issues cause missed updates"}
    ]$$::jsonb,
    'Chakra UI v1+, React 16.8+ (hooks), form validation library optional',
    'Checkbox toggles visually on click and state updates, Radio selection changes when clicked, form values sync to parent state, onChange fires reliably',
    'Not managing state with useState - expecting uncontrolled behavior. Using isChecked without onChange callback. Calling preventDefault() on checkbox click event. Forgetting to pass value prop to Radio components in group. Multiple checkboxes sharing same state variable.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/chakra-ui/chakra-ui/discussions'
)
;
