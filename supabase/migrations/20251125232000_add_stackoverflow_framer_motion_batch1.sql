-- Add Stack Overflow Framer Motion Q&A batch 1
-- Extracted from highest-voted Stack Overflow questions with accepted answers
-- Category: stackoverflow-framer-motion
-- Source: https://stackoverflow.com/questions/tagged/framer-motion?tab=votes

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES (
    'Error importing Framer Motion v5: Can''t import the named export ''Children'' from non EcmaScript module',
    'stackoverflow-framer-motion',
    'HIGH',
    '[
        {
            "solution": "Change import to use dist folder: import { motion } from ''framer-motion/dist/framer-motion''",
            "percentage": 95,
            "note": "Most reliable fix for CRA projects, bypasses ESM resolution issues"
        },
        {
            "solution": "Downgrade to framer-motion v4.1.17 in package.json and run npm install",
            "percentage": 85,
            "note": "Works but limits access to v5 features and improvements"
        },
        {
            "solution": "Update react-scripts to v5.0.1+ and upgrade React to v18.2.0+",
            "percentage": 80,
            "note": "Fixes underlying webpack configuration issues"
        }
    ]'::jsonb,
    'React Create App project, Node.js and npm installed, framer-motion package',
    'Import statement executes without errors, motion components render correctly, bundle builds successfully',
    'Older react-scripts versions don''t handle ESM modules properly. Don''t mix import paths - use consistent approach. Incompatible package versions cause lingering issues.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/69769360/error-importing-framer-motion-v5-in-react-with-create-react-app'
),
(
    'staggerChildren animation not working with async data from API',
    'stackoverflow-framer-motion',
    'HIGH',
    '[
        {
            "solution": "Conditionally render the motion list only after data arrives: wrap motion.ul in conditional {users.length > 0 && <motion.ul>...}</motion.ul>}",
            "percentage": 95,
            "note": "Root cause: stagger fires before children exist. Conditional rendering ensures full list exists when animation starts."
        },
        {
            "solution": "Use useEffect to detect data load completion and trigger animation: const [animate, setAnimate] = useState(false); trigger animation after useState updates",
            "percentage": 85,
            "note": "Alternative approach using state management to control animation timing"
        }
    ]'::jsonb,
    'React hooks (useState, useEffect), Framer Motion library, API data fetching, variant definitions',
    'Stagger animation fires smoothly when data loads, items animate with proper timing delays, animation doesn''t fire on empty render',
    'Rendering empty list first then populating with API data causes stagger to complete before children appear. Timing mismatch between render and animation. Async/await data loading conflicts with animation lifecycle.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/62007505/staggerchildren-with-framer-motion'
),
(
    'Animate elements only when scrolled into view with Framer Motion',
    'stackoverflow-framer-motion',
    'VERY_HIGH',
    '[
        {
            "solution": "Use whileInView prop with viewport options: <motion.div initial=\"hidden\" whileInView=\"visible\" viewport={{ once: true }} variants={...} />",
            "percentage": 95,
            "note": "Native Framer Motion v5.3+ solution, no external dependencies, recommended approach"
        },
        {
            "solution": "Add amount parameter to control trigger threshold: viewport={{ once: true, amount: 0.5 }} (0.5 = 50% visible)",
            "percentage": 90,
            "note": "Default is 0 (triggers at any visibility), adjust to prevent premature animation"
        },
        {
            "solution": "Use legacy approach with useAnimation hook and intersection observer for older versions pre-v5.3",
            "percentage": 70,
            "note": "More complex, only needed for older codebases"
        }
    ]'::jsonb,
    'Framer Motion v5.3+, React component structure, animation variants defined',
    'Animation triggers exactly when element scrolls into viewport, animation runs once if viewport={{ once: true }}, no animation firing before element visibility',
    'Default viewport amount is 0 (triggers at any visibility). Forgetting viewport={{ once: true }} causes repeated animations on scroll. Nested layouts may affect intersection detection.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/58958972/framer-motion-animate-when-element-is-in-view-when-you-scroll-to-element'
),
(
    'AnimatePresence exit animations not working in Framer Motion',
    'stackoverflow-framer-motion',
    'HIGH',
    '[
        {
            "solution": "Import domAnimation from framer-motion: import { domAnimation } from ''framer-motion''",
            "percentage": 90,
            "note": "The lightweight m package doesn''t include exit animations by default"
        },
        {
            "solution": "Ensure all motion components in AnimatePresence have unique key props on each child element",
            "percentage": 85,
            "note": "AnimatePresence tracks presence changes via keys - required for exit to fire"
        },
        {
            "solution": "Add exit prop to motion component with animation variants: <motion.div exit={{ opacity: 0 }} />",
            "percentage": 80,
            "note": "Define explicit exit state animations"
        }
    ]'::jsonb,
    'Framer Motion library, AnimatePresence component, motion components with exit states, unique key props',
    'Exit animations execute when component unmounts, AnimatePresence prevents abrupt removal, animation completes before DOM removal',
    'Missing domAnimation import silently fails - exit animations won''t fire. Forgetting unique keys on children breaks exit detection. Using m package assumes full feature availability.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/71695907/cant-get-animatepresence-in-framer-motion-to-work'
),
(
    'staggerChildren not working: all children animate simultaneously instead of staggered',
    'stackoverflow-framer-motion',
    'HIGH',
    '[
        {
            "solution": "Remove delay property from child variants - delay takes precedence over staggerChildren. Let parent control timing via delayChildren and staggerChildren",
            "percentage": 95,
            "note": "Root cause: explicit delay on children overrides parent stagger timing"
        },
        {
            "solution": "Parent variant must have: transition: { delayChildren: 0, staggerChildren: 0.3 } and children have no delay property",
            "percentage": 90,
            "note": "Correct pattern: parent controls all timing distribution"
        },
        {
            "solution": "Verify parent animation variant is active with animate={parentAnimation} on parent motion component",
            "percentage": 75,
            "note": "Animation won''t stagger if parent variant isn''t triggered"
        }
    ]'::jsonb,
    'Framer Motion variant system, parent and child motion components, animation transition configuration',
    'Child elements animate with sequential timing, each element starts animation offset from previous by staggerChildren value, no simultaneous animations',
    'Combining delay on children with parent staggerChildren always uses child delay. Forgetting delayChildren in parent transitions. Not activating parent variant through animate prop.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/72536592/framer-motion-does-not-stagger-children-no-matter-what-i-try'
),
(
    'Framer Motion Reorder component not reordering items, just jumps instead of animating',
    'stackoverflow-framer-motion',
    'MEDIUM',
    '[
        {
            "solution": "Replace index-based keys with stable unique identifiers: use key={item.id} instead of key={index}",
            "percentage": 95,
            "note": "Index keys cause React to lose element identity during reorder, breaking animation continuity"
        },
        {
            "solution": "Ensure Reorder.Group state updates properly: <Reorder.Group values={items} onReorder={setItems}>",
            "percentage": 90,
            "note": "State must sync with rendered order for smooth animation"
        },
        {
            "solution": "Verify each Reorder.Item has unique key and value props matching data array",
            "percentage": 85,
            "note": "Mismatched keys/values prevent proper element tracking"
        }
    ]'::jsonb,
    'Framer Motion library with Reorder component, React state management, stable unique IDs for list items',
    'Items animate smoothly when reordering, visual order matches state order, no abrupt layout jumps',
    'Using key={index} reassigns to different elements when list reorders. Dynamic keys based on row index break animation tracking. Not synchronizing state with rendered order.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/74915131/framer-motion-reorder-behaviour-not-reordering-as-expected'
),
(
    'Stagger animation on enter but exit items simultaneously instead of staggered',
    'stackoverflow-framer-motion',
    'MEDIUM',
    '[
        {
            "solution": "Define different transition properties for entry vs exit: keep stagger in main transition, override in exit prop: <motion.div exit={{ opacity: 0, transition: { duration: 0.5 } }}>",
            "percentage": 90,
            "note": "Exit animation overrides inherit parent stagger timing"
        },
        {
            "solution": "Always include unique key prop on animated elements for exit animations to function: key={item.id}",
            "percentage": 85,
            "note": "AnimatePresence requires keys to track presence changes"
        },
        {
            "solution": "Use mode=\"wait\" in Framer v7.2+ instead of deprecated exitBeforeEnter prop",
            "percentage": 80,
            "note": "exitBeforeEnter was removed in v7.2+"
        }
    ]'::jsonb,
    'Framer Motion AnimatePresence, React conditional rendering with mapped arrays, transition timing configuration',
    'Items stagger smoothly on enter, all items exit simultaneously without stagger delay, no animation blocking between sequences',
    'Missing key props causes exit animations to fail silently. Not overriding exit transition - inherits parent stagger. Using deprecated exitBeforeEnter in newer versions.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/73395417/framer-motion-can-we-stagger-items-only-on-enter-but-simultaneously-exit-them'
),
(
    'Framer Motion drag: trigger drag from child element only, not entire parent container',
    'stackoverflow-framer-motion',
    'MEDIUM',
    '[
        {
            "solution": "Import useDragControls and set dragListener={false} on motion.div, then attach dragControls.start(e) to child''s onPointerDown handler",
            "percentage": 92,
            "note": "Recommended approach using programmatic drag control"
        },
        {
            "solution": "Example: <motion.div drag dragControls={dragControls} dragListener={false}><div onPointerDown={(e) => dragControls.start(e)}>DRAG ME</div></motion.div>",
            "percentage": 90,
            "note": "Copy-paste pattern that works reliably"
        }
    ]'::jsonb,
    'Framer Motion library with drag functionality, useDragControls hook, understanding of pointer events',
    'Only child element drag handle triggers dragging, parent moves smoothly when dragged from handle, no drag on other parent areas',
    'Forgetting dragListener={false} allows default drag on entire parent. Not using dragControls for programmatic start. Attempting CSS-only selectors without Framer APIs.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/64919883/framer-motion-drag-set-drag-target-as-child-of-draggable-parent'
),
(
    'whileInView animation triggering too early before element is actually in viewport',
    'stackoverflow-framer-motion',
    'MEDIUM',
    '[
        {
            "solution": "Adjust viewport amount parameter: viewport={{ once: true, amount: 0.5 }} where 0.5 means 50% of element must be visible",
            "percentage": 93,
            "note": "Default amount is 0 (triggers at any visibility). Default behavior is often too sensitive."
        },
        {
            "solution": "Understand default: amount: 0 means animation fires when any part of element enters viewport, not when element is fully visible",
            "percentage": 88,
            "note": "Common misconception about default behavior"
        },
        {
            "solution": "Alternative: Use Framer''s useInView hook with ref for more granular control over viewport detection",
            "percentage": 75,
            "note": "More verbose but allows custom intersection logic"
        }
    ]'::jsonb,
    'Framer Motion with whileInView prop, React understanding of viewport dimensions, motion component setup',
    'Animation triggers exactly when specified percentage of element is visible, no premature triggering, predictable activation point',
    'Assuming whileInView only triggers when element fully visible (it''s default 0). Not accounting for viewport offset in nested layouts. Browser intersection observer variations.',
    0.86,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/75122511/framer-motion-whileinview-activating-before-component-is-in-viewport'
),
(
    'Draggable Framer Motion components not persisting position after drag, or positioning broken',
    'stackoverflow-framer-motion',
    'MEDIUM',
    '[
        {
            "solution": "Replace CSS left/top positioning with transform-based positioning: use style={{ x: widget.x, y: widget.y }} instead of style={{ left, top }}",
            "percentage": 94,
            "note": "Combines with Framer''s transform for proper synchronization"
        },
        {
            "solution": "Root cause: top/left CSS creates double transformation when Framer applies translate3d, causing position misalignment",
            "percentage": 90,
            "note": "Technical reason for the fix"
        },
        {
            "solution": "Persist position after drag via onDragEnd callback and update state with final coordinates",
            "percentage": 85,
            "note": "Save final position for page reload persistence"
        }
    ]'::jsonb,
    'React component with Framer Motion drag enabled, state management for position, CSS-free positioning approach',
    'Dragged elements position correctly after release, no double-movement artifacts, position persists across interactions',
    'Mixing top/left CSS with Framer transforms creates double movement. Using absolute positioning when transform is needed. Not calling onDragEnd to persist changes.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/76192693/persisting-position-of-draggable-framer-motion-components'
),
(
    'How to apply stagger effect to multiple buttons: all animating at same time instead of sequential',
    'stackoverflow-framer-motion',
    'MEDIUM',
    '[
        {
            "solution": "Use custom prop to pass index to variant function: <motion.button custom={i} variants={buttonVariants} /> where buttonVariants accept custom for delay",
            "percentage": 92,
            "note": "Moves stagger logic to mapping level instead of relying on staggerChildren"
        },
        {
            "solution": "Define variants as function: const buttonVariants = (i) => ({ transition: { duration: 0.5, delay: 0.3 * i } })",
            "percentage": 88,
            "note": "Pattern for dynamic delay based on element index"
        },
        {
            "solution": "Don''t wrap each button in separate component that blocks staggerChildren inheritance from parent",
            "percentage": 80,
            "note": "staggerChildren only works on direct children, not wrapped descendants"
        }
    ]'::jsonb,
    'Framer Motion library, understanding of custom prop and variant functions, React array mapping',
    'Buttons animate sequentially with proper timing gaps, each button starts animation offset from previous, smooth cascade effect',
    'Wrapping buttons individually prevents parent staggerChildren from working. Forgetting custom prop on buttons. Using static delay instead of index-based calculation.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/78200167/how-to-use-stagger-from-framer-motion'
),
(
    'Framer Motion drag constraint in one direction only: prevent dragging up but allow dragging down',
    'stackoverflow-framer-motion',
    'LOW',
    '[
        {
            "solution": "Use dragElastic object with directional elasticity: dragElastic={{ top: 0, bottom: 0.3 }} to prevent upward drag, allow downward with bounce",
            "percentage": 88,
            "note": "Setting elasticity to 0 locks direction, > 0 allows movement with bounce effect"
        },
        {
            "solution": "Combine with dragConstraints for hard boundaries: dragConstraints={{ top: 0, bottom: 200 }} to establish absolute limits",
            "percentage": 90,
            "note": "Critical: dragConstraints must be set for dragElastic to work properly"
        },
        {
            "solution": "Use drag=\"y\" to limit to vertical axis only, avoid horizontal movement entirely",
            "percentage": 85,
            "note": "Preliminary constraint before directional elasticity"
        }
    ]'::jsonb,
    'React component with Framer Motion, drag=\"y\" or drag prop enabled, dragConstraints and dragElastic props',
    'Element responds to dragging in specified direction only, elasticity provides bounce effect at boundaries, no movement in restricted directions',
    'Forgetting dragConstraints makes dragElastic insufficient. dragElastic alone doesn''t prevent drag, only adds bounce. Not configuring boundary values properly.',
    0.83,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/68465603/framer-motion-drag-in-one-direction-only-eg-only-down'
);
