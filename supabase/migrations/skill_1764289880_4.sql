INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Frontend Design - Create distinctive, production-grade frontend interfaces with high design quality',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Understand design context before coding",
      "manual": "Analyze four key dimensions: (1) Purpose - What problem does this interface solve? Who uses it? (2) Tone - Pick an extreme aesthetic direction (brutally minimal, maximalist, retro-futuristic, organic, luxury, playful, editorial, brutalist, art deco, soft/pastel, industrial). (3) Constraints - Technical requirements (framework, performance, accessibility). (4) Differentiation - What''s unforgettable? What''s the one thing someone will remember? CRITICAL: Choose clear conceptual direction and execute with precision. Both bold maximalism and refined minimalism work - the key is intentionality.",
      "note": "Design thinking first, coding second. Intentionality is more important than intensity."
    },
    {
      "solution": "Select and implement distinctive typography",
      "manual": "Typography is critical. Choose fonts that are beautiful, unique, interesting. AVOID generic fonts (Arial, Inter, system fonts). Opt for distinctive, unexpected, characterful choices that elevate aesthetics. Pair distinctive display font with refined body font. Typography is often the first thing that signals quality. Avoid convergence on common choices (Space Grotesk) across generations. Make unexpected font choices.",
      "note": "Typography elevates production quality more than any other single element"
    },
    {
      "solution": "Create cohesive color and theme strategy",
      "manual": "Commit to cohesive aesthetic. Use CSS variables for consistency across all colors. Dominant colors with sharp accents outperform timid, evenly-distributed palettes. Never use generic AI color schemes: avoid overused purple gradients on white backgrounds, cliched colors, predictable palettes. Match color strategy to aesthetic direction. Light vs dark themes. VARY between different aesthetics across projects.",
      "note": "Dominant + accents strategy is more impactful than balanced color distribution"
    },
    {
      "solution": "Implement motion with high-impact moments",
      "manual": "Use animations for effects and micro-interactions. For HTML: prioritize CSS-only solutions. For React: use Motion library when available. Focus on high-impact moments: one well-orchestrated page load with staggered reveals (animation-delay) creates more delight than scattered micro-interactions. Implement scroll-triggering and hover states that surprise. Match motion style to aesthetic direction.",
      "note": "One memorable entrance beats dozens of small interactions"
    },
    {
      "solution": "Design spatial composition beyond grid defaults",
      "manual": "Use unexpected layouts: asymmetry, overlap, diagonal flow, grid-breaking elements, generous negative space OR controlled density (matching aesthetic). Avoid predictable, cookie-cutter layouts. Create atmosphere and depth. Add contextual effects and textures matching overall aesthetic: gradient meshes, noise textures, geometric patterns, layered transparencies, dramatic shadows, decorative borders, custom cursors, grain overlays. Spatial composition should reinforce aesthetic direction.",
      "note": "Asymmetry and unexpected layouts signal intentional design"
    },
    {
      "solution": "Develop visual details that create atmosphere",
      "manual": "Create backgrounds and visual effects that build atmosphere and depth, not just solid colors. Implement creative forms: gradient meshes, noise textures, geometric patterns, layered transparencies. Add dramatic shadows and decorative borders. Custom cursors add polish. Grain overlays add texture. Apply effects contextually - match visual details to aesthetic direction. Every detail should feel intentional, not decorative.",
      "note": "Atmosphere and context-specific character differentiate from generic AI aesthetics"
    },
    {
      "solution": "Avoid generic AI-generated aesthetics",
      "manual": "NEVER use: Generic font families (Inter, Roboto, Arial), overused color schemes (purple gradients), predictable layouts/component patterns, cookie-cutter design lacking context. NEVER converge on common choices across projects. Interpret requirements creatively and make unexpected choices. Match implementation complexity to vision: maximalist designs need elaborate code with animations/effects, minimalist designs need restraint, precision, careful spacing/typography. Elegance comes from executing vision well.",
      "note": "Generic aesthetics immediately signal AI-generated content - be intentional instead"
    },
    {
      "solution": "Implement production-grade, functional code",
      "manual": "Create working code (HTML/CSS/JS, React, Vue, etc.) that is: (1) Production-grade and functional, (2) Visually striking and memorable, (3) Cohesive with clear aesthetic point-of-view, (4) Meticulously refined in every detail. Match complexity to vision - elaborate maximalist designs need extensive animations/effects, refined designs need restraint and precision. Test functionality across browsers and devices. Code should execute vision without shortcuts.",
      "note": "Code quality must match design quality for true production-grade results"
    }
  ]'::jsonb,
  'steps',
  'Framework knowledge (HTML/CSS/JS, React, Vue, etc.), understanding of design principles, access to distinctive font sources (Google Fonts, font foundries)',
  'Using generic fonts (Inter, Arial, Roboto, system fonts). Timid color palettes with evenly-distributed colors. Predictable layouts and component patterns. Scattered micro-interactions instead of orchestrated moments. Default solid backgrounds without atmosphere. Convergence on common aesthetic choices across projects. Implementing without clear aesthetic direction. Code quality mismatch with design quality.',
  'Visual design is striking and memorable. Typography is distinctive and refined. Color scheme is cohesive with dominant colors and sharp accents. Layout shows intentional asymmetry or organization. Motion moments feel orchestrated and purposeful. Visual details create atmosphere matching aesthetic. Code is production-grade and fully functional. Design feels intentional, not generic.',
  'Build distinctive, production-grade web interfaces with bold aesthetic direction and meticulous attention to detail',
  'https://skillsmp.com/skills/anthropics-skills-frontend-design-skill-md',
  'admin:HAIKU_SKILL_1764289880_14600'
);
