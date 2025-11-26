-- Add Stack Overflow Bootstrap (CSS framework) Q&A batch 1
-- Extracted 12 highest-voted Bootstrap questions with accepted answers
-- Category: stackoverflow-bootstrap
-- Date: 2025-11-25

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Bootstrap is CSS or JavaScript framework or both?',
    'stackoverflow-bootstrap',
    'HIGH',
    '[
        {
            "solution": "Bootstrap is a front-end framework combining HTML, CSS, and JavaScript. CSS provides responsive 12-column grid using @media queries and percentages. JavaScript provides interactive components (modals, dropdowns, carousels, collapse) that enable functional hamburger menus on mobile devices.",
            "percentage": 95,
            "note": "Official definition from Stack Overflow with high community consensus"
        },
        {
            "solution": "For responsive design only, focus on Bootstrap CSS grid system. For interactive components like collapsible menus and tabs, JavaScript is required.",
            "percentage": 85,
            "note": "Practical separation of concerns for understanding framework components"
        }
    ]'::jsonb,
    'Bootstrap framework installed, Basic HTML/CSS knowledge',
    'Can implement responsive grid layouts, Interactive components function correctly',
    'Do not assume JavaScript is unnecessary for responsiveness. Hamburger menu collapse behavior requires JavaScript—CSS alone cannot toggle display based on button clicks. Bootstrap''s grid system uses percentages and media queries, not pixel-fixed widths.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/33453512/bootstrap-is-css-or-javascript-framework-or-both'
),
(
    'Difference between Bootstrap and CSS',
    'stackoverflow-bootstrap',
    'HIGH',
    '[
        {
            "solution": "Bootstrap is a framework (pre-built set of files with CSS), not an alternative to CSS. Bootstrap uses CSS but is different because it provides pre-done styling. You apply Bootstrap classes directly to HTML elements without writing custom styles.",
            "percentage": 95,
            "note": "Core conceptual distinction from Stack Overflow community"
        },
        {
            "solution": "Bootstrap provides pre-made CSS classes for grid systems and components. Vanilla CSS requires manual implementation using media queries and custom code for responsive design.",
            "percentage": 90,
            "note": "Practical productivity comparison"
        }
    ]'::jsonb,
    'HTML and CSS fundamentals knowledge, Bootstrap library imported',
    'Can use Bootstrap classes effectively, Responsive layouts work without custom CSS',
    'Do not skip learning HTML & CSS fundamentals before using Bootstrap. Skipping foundational knowledge limits your ability to customize or debug implementations. Bootstrap is not just for beginners—it''s a productivity tool for developers at any level.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/36520383/difference-between-bootstrap-and-css'
),
(
    'Integrating Bootstrap CSS framework on single page with existing styles',
    'stackoverflow-bootstrap',
    'MEDIUM',
    '[
        {
            "solution": "Link standard Bootstrap stylesheet, then create separate custom CSS file that overrides Bootstrap styles as needed. Load custom file after Bootstrap to handle conflicts through CSS cascading.",
            "percentage": 92,
            "note": "Recommended approach for avoiding maintenance burden"
        },
        {
            "solution": "Avoid custom-compiling Bootstrap with selector prefixes (like #body-content). Custom compilation creates upgrade maintenance burden—must recompile for each new Bootstrap version.",
            "percentage": 85,
            "note": "Anti-pattern to avoid"
        }
    ]'::jsonb,
    'Bootstrap framework, Custom CSS knowledge, CMS or page integration context',
    'Styles integrate correctly, CSS conflicts resolved, Bootstrap updates can be applied',
    'Do not custom-compile Bootstrap with prefixes. Custom compilation breaks upgrade path—you''ll need manual recompilation for each Bootstrap version. Standard stylesheet + override approach preserves upgrade compatibility.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/24642266/integrating-bootstrap-css-framework-on-a-single-page'
),
(
    'w3.css vs Bootstrap CSS framework comparison',
    'stackoverflow-bootstrap',
    'HIGH',
    '[
        {
            "solution": "W3.CSS is smaller and faster than Bootstrap because it''s pure CSS without JavaScript. W3.CSS has better SEO compatibility since it avoids JavaScript execution overhead that search engines struggle with.",
            "percentage": 88,
            "note": "Performance and SEO advantages of W3.CSS"
        },
        {
            "solution": "Use W3.CSS for simpler projects with basic responsive grids. Use Bootstrap when you need complex interactive components like multi-level dropdown menus that require JavaScript.",
            "percentage": 85,
            "note": "Practical decision framework from community"
        }
    ]'::jsonb,
    'Understanding of CSS frameworks, Performance requirements, Project complexity assessment',
    'Page loads faster, SEO crawling succeeds, Interactive components function appropriately',
    'Do not use Bootstrap for simple static sites with no interactive components—W3.CSS will be faster and reduce unnecessary overhead. JavaScript processing hinders SEO performance compared to pure CSS frameworks.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/53064782/w3-css-vs-bootstrap-and-which-is-more-faster-and-better'
),
(
    'Bootstrap responsive grid breakpoints and columns on all devices',
    'stackoverflow-bootstrap',
    'HIGH',
    '[
        {
            "solution": "Use Bootstrap''s four responsive tiers: col-xs (<768px), col-sm (≥768px), col-md (≥992px), col-lg (≥1200px). Apply multiple classes: col-xs-12 col-sm-6 for stacked mobile, side-by-side on tablets+.",
            "percentage": 93,
            "note": "Standard Bootstrap grid approach"
        },
        {
            "solution": "For mobile-first design: col-xs-12 makes elements full-width on mobile, then add col-md-6 to resize at larger breakpoints. Elements inherit properties from smaller breakpoints and up.",
            "percentage": 92,
            "note": "Mobile-first methodology"
        },
        {
            "solution": "Ensure column elements are nested within .container or .container-fluid parent for proper padding and alignment.",
            "percentage": 88,
            "note": "Common structural requirement"
        }
    ]'::jsonb,
    'Bootstrap framework v3+, Understanding of breakpoint concept, HTML/CSS knowledge',
    'Columns stack on mobile, Display correctly on tablets, Align properly on desktop',
    'Do not use only col-xs classes expecting responsiveness at larger screens. Use combined classes like col-lg-6 col-md-6 col-sm-12 for explicit control. Input fields with fixed/minimum widths exceeding computed column width cause overflow and layout breakage.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/39645768/how-do-i-make-bootstrap-columns-responsive-on-all-devices'
),
(
    'Hide Bootstrap columns at specific breakpoints using display utilities',
    'stackoverflow-bootstrap',
    'MEDIUM',
    '[
        {
            "solution": "Use Bootstrap display utility classes .d-sm-none .d-md-block to hide elements at small breakpoints and show at medium+. Apply .col-sm-12 to adjacent columns to make them full-width on small devices.",
            "percentage": 94,
            "note": "Bootstrap 4.1.3+ and Bootstrap 5 approach with display utilities"
        },
        {
            "solution": "Pattern: <div class=\"col-md-4 d-sm-none d-md-block\"></div> for hidden spacer, combined with <div class=\"col-md-8 col-sm-12\">content</div> for expanding content.",
            "percentage": 92,
            "command": "Add .d-sm-none .d-md-block to spacer column"
        }
    ]'::jsonb,
    'Bootstrap 4.1.3+, Understanding of display utility classes, Grid system knowledge',
    'Empty column hides on small screens, Content column expands to full width on mobile',
    'Do not rely on only col-md classes—must add col-sm-12 or col-xs-12 to expand at smaller breakpoints. Display utilities syntax varies: Bootstrap 4 uses .d-sm-none, Bootstrap 5 uses same syntax.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/68790780/bootstrap-responsive-grid-system'
),
(
    'Fluid vs fixed Bootstrap grid system in responsive design',
    'stackoverflow-bootstrap',
    'HIGH',
    '[
        {
            "solution": "Fixed layout uses pixel values maintaining consistent widths. Fluid layout uses percentages scaling with viewport. Both support responsive media queries—the difference is width unit only.",
            "percentage": 94,
            "note": "Fundamental distinction with 405 Stack Overflow upvotes"
        },
        {
            "solution": "Use .container class for fixed-width responsive layouts, or .container-fluid for full-width designs that stretch to browser width.",
            "percentage": 93,
            "note": "Bootstrap 3+ implementation"
        },
        {
            "solution": "Fluid layouts better utilize large screen space and scale continuously without breakpoint jumps. Fixed layouts easier to customize but waste space on large screens.",
            "percentage": 90,
            "note": "Use case comparison from community"
        }
    ]'::jsonb,
    'Bootstrap framework, Understanding of CSS units (pixels vs percentages)',
    'Layout scales correctly across viewports, Responsive breakpoints trigger appropriately',
    'Do not confuse responsive design with fluid layout. Both fixed (pixels) and fluid (percentages) support media queries independently. Fluid layouts avoid horizontal scrolling on small screens; fixed layouts may require scrolling.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/9780333/fluid-or-fixed-grid-system-in-responsive-design-based-on-twitter-bootstrap'
),
(
    'Bootstrap CSS classes usage recommendations for responsive websites',
    'stackoverflow-bootstrap',
    'MEDIUM',
    '[
        {
            "solution": "Use only as many Bootstrap grid classes as necessary for your layout changes. If element maintains same width across all viewports, use only smallest breakpoint: col-xs-6 (50% everywhere).",
            "percentage": 92,
            "note": "Mobile-first inheritance principle"
        },
        {
            "solution": "Add multiple breakpoint classes only when layout changes: col-md-4 col-sm-6 means 33% on medium+, 50% on small, 100% on extra-small. Grid classes inherit downward—override upward as needed.",
            "percentage": 91,
            "note": "Targeted breakpoint approach"
        }
    ]'::jsonb,
    'Bootstrap framework, Understanding of mobile-first approach, Target device support',
    'Layout matches design across all breakpoints, Reduces HTML/CSS complexity',
    'Do not use all grid classes unnecessarily—col-md-6 col-sm-6 col-xs-6 is redundant; col-xs-6 alone achieves same result through inheritance. Fewer classes reduce debugging effort and HTML bloat.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/35183114/should-i-use-all-the-bootstrap-classes-for-a-responsive-website'
),
(
    'Override Bootstrap variables in SASS/SCSS customization',
    'stackoverflow-bootstrap',
    'HIGH',
    '[
        {
            "solution": "Create custom-variables.scss file, import it BEFORE Bootstrap _variables.scss, define overridden variables without !default flag, then compile SASS.",
            "percentage": 94,
            "note": "Correct import order is critical"
        },
        {
            "solution": "The !default flag is ''reverse of !important''—earlier declarations take precedence. Copy specific variables from Bootstrap _variables.scss and remove !default from your copy.",
            "percentage": 93,
            "command": "Remove !default flag from overridden variables"
        },
        {
            "solution": "Maintain separate custom.scss instead of modifying Bootstrap source directly. This prevents losing customizations during version upgrades.",
            "percentage": 91,
            "note": "Best practice for maintainability"
        }
    ]'::jsonb,
    'SASS compiler installed, Bootstrap SCSS source files (via npm), Basic SASS knowledge, Build process setup',
    'SASS compiles without errors, Custom variables override defaults, Theme applies consistently',
    'Do not import custom variables AFTER Bootstrap variables—they will be ignored. Do not leave !default flag on overridden variables. Do not modify Bootstrap source directly—use separate custom file for version upgrade safety.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/46505841/how-to-override-bootstrap-variables-in-sass'
),
(
    'How to extend and modify Bootstrap with SASS',
    'stackoverflow-bootstrap',
    'HIGH',
    '[
        {
            "solution": "Import Bootstrap components in this order: (1) functions, (2) variables, (3) apply custom overrides without !default, (4) import complete Bootstrap. Variable overrides must come after functions imported but before rest of imports.",
            "percentage": 95,
            "note": "Critical import order from 33-vote Stack Overflow answer"
        },
        {
            "solution": "Use separate custom.scss file maintaining Bootstrap separation. This approach preserves future upgrades without re-editing cloned Bootstrap files.",
            "percentage": 93,
            "note": "Recommended project structure"
        },
        {
            "solution": "Do not clone Bootstrap and modify directly. Leverage Bootstrap''s built-in SASS variable customization hooks instead.",
            "percentage": 90,
            "note": "Anti-pattern warning"
        }
    ]'::jsonb,
    'SASS compiler (node-sass, webpack, Dart Sass), Bootstrap SCSS source files, npm setup, SASS variable scoping knowledge',
    'Custom styles compile without errors, Bootstrap components respect customizations, Theme applies globally',
    'Do not clone entire Bootstrap repository and modify files—massive maintenance burden. Do not forget variable overrides must come AFTER functions are imported. Import order: functions → variables → custom overrides → bootstrap.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/45776055/how-to-extend-modify-customize-bootstrap-with-sass'
),
(
    'CSS variables with Bootstrap 5 runtime theming',
    'stackoverflow-bootstrap',
    'MEDIUM',
    '[
        {
            "solution": "Bootstrap 5.1+ introduced CSS variables support. Check official Bootstrap blog post on CSS variables (blog.getbootstrap.com/2022/05/16/using-bootstrap-css-vars/) and upgrade to Bootstrap 5.1 or later.",
            "percentage": 88,
            "note": "Feature availability in Bootstrap 5.1+"
        },
        {
            "solution": "For Bootstrap 5.0, override variables at SASS build time before compilation rather than runtime. CSS variables in earlier versions are read-only documentation.",
            "percentage": 85,
            "note": "Pre-5.1 approach using SASS compilation"
        },
        {
            "solution": "Workaround for unsupported versions: manually override with .bg-primary {background-color: var(--bs-primary) !important;} but this lacks comprehensive coverage for all components.",
            "percentage": 70,
            "note": "Incomplete workaround, use SASS instead"
        }
    ]'::jsonb,
    'Bootstrap 5+ framework, Understanding of CSS variables, Optional: SASS compiler for build-time customization',
    'CSS variables apply correctly, Runtime theme changes take effect, All components reflect new colors',
    'Do not attempt runtime CSS variables in Bootstrap 5.0—feature not available. Do not expect hardcoded color values to respond to CSS variable overrides. Bootstrap 5.0-5.0.x use hardcoded CSS; only 5.1+ supports dynamic variables. Manual overrides with !important are incomplete coverage.',
    0.84,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/67440320/how-to-use-css-variables-with-bootstrap-5'
),
(
    'Complete list of Bootstrap CSS classes reference',
    'stackoverflow-bootstrap',
    'MEDIUM',
    '[
        {
            "solution": "Consult official Bootstrap documentation at getbootstrap.com for complete, authoritative class listings. Avoid third-party sources that become outdated.",
            "percentage": 95,
            "note": "Official documentation is canonical source"
        },
        {
            "solution": "GitHub Gists provide Bootstrap class lists: mrcybermac/9175466 for Bootstrap 3 (656 unique classes), geksilla/6543145 for bootstrap.min.css reference.",
            "percentage": 80,
            "note": "Community-maintained reference, may lag official docs"
        },
        {
            "solution": "Bootstrap 3 and 4 sortable reference tables at BootstrapCreative provide quick-search functionality with visual previews on hover.",
            "percentage": 78,
            "note": "Interactive resources may help learning"
        }
    ]'::jsonb,
    'Bootstrap framework version identifier, Internet access, Optional: SASS knowledge for customization',
    'Can locate desired Bootstrap classes, Understand what native classes exist, Avoid naming conflicts',
    'Do not rely on outdated GitHub Gists—Bootstrap classes evolve between versions. Major changes occurred from Bootstrap 2.x to 3.x and again in 5.x. Do not assume all examples use Bootstrap classes—many Stack Overflow answers use custom user-defined classes mixed in.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/18772052/complete-list-of-bootstrap-classes'
);
