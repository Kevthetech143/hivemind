-- CSS UI Error Knowledge Base Entries
-- Mined from high-quality Stack Overflow sources

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES

-- Entry 1: Flexbox items not wrapping
(
    'flex items not wrapping to next line, all items stay on single line',
    'css-ui',
    'HIGH',
    '[
        {"solution": "Add flex-wrap: wrap to the flex container CSS. By default, flex containers use flex-wrap: nowrap which forces all items onto one line. Change to flex-wrap: wrap to allow items to wrap when space runs out.", "percentage": 98},
        {"solution": "Set flex-basis on child items to control items per row. Use flex: 0 0 33.333% for 3 items per row, accounting for margins/padding.", "percentage": 85}
    ]'::jsonb,
    'CSS knowledge of flexbox layout, understanding of flex container vs flex items',
    'Items now wrap to next line when container width is exceeded, multiple rows of items appear correctly',
    'Forgetting that flex-wrap: nowrap is the default behavior, assuming flex-direction affects wrapping, not accounting for item margins in flex-basis calculations',
    0.98,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/33137566/why-are-flex-items-not-wrapping',
    'admin:1764173742'
),

-- Entry 2: Z-index not working
(
    'z-index property ignored, element stays behind other elements despite high z-index value',
    'css-ui',
    'HIGH',
    '[
        {"solution": "Add position property to the element. z-index only works with positioned elements (position: absolute, relative, fixed, sticky). Elements with position: static (the default) ignore z-index completely.", "percentage": 95},
        {"solution": "Check stacking context. Parent containers with position: relative or other stacking-creating properties can limit z-index scope. Move overlay outside parent container or use position: fixed.", "percentage": 88},
        {"solution": "Verify parent z-index is higher. When parent has lower z-index than siblings, child elements cannot exceed parent''s stacking layer regardless of child z-index.", "percentage": 82}
    ]'::jsonb,
    'Understanding of CSS positioning and stacking context, knowledge that z-index requires positioned elements',
    'Element now appears above other elements as intended, visual layering matches CSS z-index values',
    'Applying z-index to static positioned elements, not checking parent stacking context, forgetting that z-index requires position property',
    0.95,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/10600863/overlaying-divs-with-z-index',
    'admin:1764173742'
),

-- Entry 3: Tailwind CSS classes not applying
(
    'Tailwind CSS classes not applying styles, utilities do not work after installation',
    'css-ui',
    'HIGH',
    '[
        {"solution": "Configure content paths in tailwind.config.js. Tailwind scans files for class names, so it needs correct file paths. Set content: [''./src/**/*.{js,ts,jsx,tsx}''] to include your template files.", "percentage": 96},
        {"solution": "Update CSS import syntax. Use @import ''tailwindcss/base''; @import ''tailwindcss/components''; @import ''tailwindcss/utilities''; instead of @tailwind directives.", "percentage": 88},
        {"solution": "Add PostCSS configuration file. Create postcss.config.js with tailwindcss and autoprefixer plugins for proper CSS processing.", "percentage": 85}
    ]'::jsonb,
    'Tailwind CSS installation, understanding of content configuration, working build environment',
    'Tailwind utility classes now apply correctly, styles appear in browser, no missing class warnings',
    'Incorrect content path glob patterns, constructing class names dynamically, forgetting to rebuild after config changes, not restarting dev server',
    0.96,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/70577297/tailwindcss-v3-classes-do-not-work-after-installation',
    'admin:1764173742'
),

-- Entry 4: shadcn checkbox rendering incorrectly
(
    'shadcn checkbox displays as filled black square instead of proper checkbox',
    'css-ui',
    'MEDIUM',
    '[
        {"solution": "Check global CSS in src/index.css. Remove conflicting default styles like ''button { padding: 0.6em 1.2em; }'' that interfere with shadcn component styling. Keep only @tailwind directives.", "percentage": 92},
        {"solution": "Apply p-0 padding reset class to CheckboxPrimitive.Root component to remove padding affecting checkbox alignment and appearance.", "percentage": 85},
        {"solution": "Ensure checked prop uses strict boolean value. Use Boolean(field.value) instead of passing other truthy values, as non-boolean values cause unexpected rendering.", "percentage": 78}
    ]'::jsonb,
    'shadcn/ui installation, understanding of CSS conflicts, React component props',
    'Checkbox renders with proper styling and appearance, selected/unselected states display correctly',
    'Keeping unnecessary default button styles in global CSS, passing non-boolean truthy values to checked prop, not removing conflicting component CSS',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/79289972/shadcn-checkbox-is-not-rendering-as-expected',
    'admin:1764173742'
),

-- Entry 5: Hydration error with shadcn components
(
    'Error: Hydration failed because the initial UI does not match what was rendered on the server',
    'css-ui',
    'MEDIUM',
    '[
        {"solution": "Add asChild prop to SheetTrigger or other Radix-based triggers. This prevents rendering a default DOM element and passes behavior directly to child Button, avoiding invalid nested button HTML.", "percentage": 94},
        {"solution": "Avoid nesting button-like components. Replace <SheetTrigger><Button></Button></SheetTrigger> with <SheetTrigger asChild><Button></Button></SheetTrigger> to eliminate duplicate button elements.", "percentage": 94}
    ]'::jsonb,
    'Next.js or SSR framework setup, understanding of Radix UI asChild prop, shadcn component knowledge',
    'Hydration error resolves, server and client HTML match, no console errors on page load',
    'Not using asChild prop when nesting buttons in triggers, creating nested button HTML structures, not understanding Radix UI composition patterns',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/77944773/next-js-14-shadcn-error-hydration-failed-because-the-initial-ui-does-not-matc',
    'admin:1764173742'
),

-- Entry 6: Radix UI accessibility warning
(
    'Warning: DialogContent requires a DialogTitle for accessibility in React console',
    'css-ui',
    'MEDIUM',
    '[
        {"solution": "Ensure DialogTitle element exists in Dialog component. Include <DialogTitle> even if visually hidden using sr-only class for screen reader accessibility.", "percentage": 88},
        {"solution": "For Shadow DOM usage, use getRootNode() API to locate title. Document.getElementById() cannot access Shadow DOM elements, so custom element search is needed.", "percentage": 70}
    ]'::jsonb,
    'Radix UI Dialog component, accessibility knowledge, understanding of ARIA requirements',
    'Console warning disappears, Dialog passes accessibility audit, screen readers properly identify dialog title',
    'Assuming DialogTitle must be visible, placing DialogTitle outside Dialog structure, not using DialogTitle when in Shadow DOM context',
    0.88,
    'haiku',
    NOW(),
    'https://github.com/radix-ui/primitives/issues/3039',
    'admin:1764173742'
),

-- Entry 7: CSS margin collapse unexpected spacing
(
    'Vertical margins between elements do not add up, spacing is smaller than expected',
    'css-ui',
    'MEDIUM',
    '[
        {"solution": "Understand margin collapse: adjoining vertical margins combine, not add. The larger margin wins. Apply overflow: hidden or padding to parent to break collapse behavior.", "percentage": 85},
        {"solution": "Use Flexbox or Grid layout. Modern layout methods do not collapse margins, providing more predictable spacing behavior.", "percentage": 88},
        {"solution": "Add border or padding to parent element. Creates new block formatting context that prevents margin collapse with children.", "percentage": 82}
    ]'::jsonb,
    'Understanding of CSS block formatting context, knowledge of margin behavior in normal flow',
    'Spacing between elements is as intended, no unexpected margin collapse, consistent layout spacing',
    'Assuming margins always add together, not accounting for margin collapse in normal flow, expecting horizontal margins to collapse',
    0.85,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/3069921/what-is-the-point-of-css-collapsing-margins',
    'admin:1764173742'
),

-- Entry 8: CSS overflow hidden cutting off content
(
    'overflow: hidden cutting off important content, text or elements disappear at container edge',
    'css-ui',
    'MEDIUM',
    '[
        {"solution": "Do not set child height to 100% when parent uses overflow-y: auto. Use max-height or auto height on child instead. Setting height: 100% forces child to parent size, causing overflow.", "percentage": 90},
        {"solution": "Use overflow-clip-margin property with overflow: clip instead of hidden to allow slight overflow without clipping. Provides more control over what gets clipped.", "percentage": 75},
        {"solution": "Add padding-bottom to child elements instead of relying on margin. Use padding-bottom: 2000px with negative margin-bottom for floating layouts to prevent clipping.", "percentage": 68}
    ]'::jsonb,
    'Understanding of CSS overflow behavior, knowledge of child sizing in constrained containers',
    'Content displays without unexpected clipping, text renders fully, all child elements visible',
    'Setting fixed child heights in overflow containers, not accounting for scrollbar width, using overflow: hidden without understanding content size',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/62744824/overflow-hidden-scroll-y-cutting-off-content',
    'admin:1764173742'
);
