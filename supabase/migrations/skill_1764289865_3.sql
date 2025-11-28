-- Skill: Theme Factory
INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Theme Factory - Toolkit for styling artifacts with professional themes including pre-set color palettes and font pairings for slides, docs, reports, and HTML landing pages.',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Display theme showcase",
      "manual": "Show the theme-showcase.pdf file to users to see all 10 available themes visually. Do not modify it. This helps users choose their preferred theme"
    },
    {
      "solution": "View available themes",
      "manual": "10 pre-set themes available: Ocean Depths, Sunset Boulevard, Forest Canopy, Modern Minimalist, Golden Hour, Arctic Frost, Desert Rose, Tech Innovation, Botanical Garden, Midnight Galaxy. Each has specific color palette and font pairings"
    },
    {
      "solution": "Get user theme selection",
      "manual": "Ask user which theme they prefer after showing the showcase. Wait for explicit confirmation of their chosen theme before proceeding"
    },
    {
      "solution": "Apply selected theme to artifact",
      "manual": "Read corresponding theme file from themes/ directory. Apply specified colors and fonts consistently throughout the artifact. Ensure proper contrast and readability. Maintain visual identity"
    },
    {
      "solution": "Create custom theme",
      "manual": "For cases where existing themes don''t fit: collect user description/inputs. Generate custom theme with similar name describing font/color combinations. Show for review and verification before applying"
    },
    {
      "solution": "Theme application process",
      "manual": "1. Read theme file from themes/ directory. 2. Extract color hex codes. 3. Extract font pairings (headers and body). 4. Apply consistently across all elements. 5. Verify contrast and readability"
    },
    {
      "solution": "Verify theme consistency",
      "manual": "Check that all headings use theme header font. Check that body text uses theme body font. Verify all colors use theme hex codes. Ensure color contrast meets accessibility standards"
    },
    {
      "solution": "Ocean Depths theme details",
      "manual": "Professional and calming maritime theme. Use theme file from themes/ocean-depths.json for specific color codes and font pairings"
    },
    {
      "solution": "Sunset Boulevard theme details",
      "manual": "Warm and vibrant sunset colors. Use theme file from themes/sunset-boulevard.json for specific color codes and font pairings"
    },
    {
      "solution": "Forest Canopy theme details",
      "manual": "Natural and grounded earth tones. Use theme file from themes/forest-canopy.json for specific color codes and font pairings"
    },
    {
      "solution": "Modern Minimalist theme details",
      "manual": "Clean and contemporary grayscale theme. Use theme file from themes/modern-minimalist.json for specific color codes and font pairings"
    },
    {
      "solution": "Golden Hour theme details",
      "manual": "Rich and warm autumnal palette. Use theme file from themes/golden-hour.json for specific color codes and font pairings"
    },
    {
      "solution": "Arctic Frost theme details",
      "manual": "Cool and crisp winter-inspired theme. Use theme file from themes/arctic-frost.json for specific color codes and font pairings"
    },
    {
      "solution": "Desert Rose theme details",
      "manual": "Soft and sophisticated dusty tones. Use theme file from themes/desert-rose.json for specific color codes and font pairings"
    },
    {
      "solution": "Tech Innovation theme details",
      "manual": "Bold and modern tech aesthetic. Use theme file from themes/tech-innovation.json for specific color codes and font pairings"
    },
    {
      "solution": "Botanical Garden theme details",
      "manual": "Fresh and organic garden colors. Use theme file from themes/botanical-garden.json for specific color codes and font pairings"
    },
    {
      "solution": "Midnight Galaxy theme details",
      "manual": "Dramatic and cosmic deep tones. Use theme file from themes/midnight-galaxy.json for specific color codes and font pairings"
    }
  ]'::jsonb,
  'steps',
  'Artifact to style (slides, docs, HTML), selected theme or theme preferences for custom generation. Optional: access to theme files in themes/ directory',
  'Common mistakes: Not showing showcase PDF to user before asking for selection. Modifying the showcase PDF instead of just displaying it. Not waiting for explicit theme confirmation. Applying theme inconsistently across artifact. Choosing colors without verifying contrast for accessibility. Not following user''s theme preference choice',
  'Success indicators: Showcase PDF displayed correctly to user. User selects preferred theme from 10 options or provides description for custom. Theme colors applied consistently throughout artifact. Font pairings used correctly for headers and body. Color contrast verified for readability. User confirms styling looks professional',
  'Professional theme styling toolkit with 10 pre-set color and font combinations for slides, documents, reports, and web pages, plus custom theme generation',
  'https://skillsmp.com/skills/anthropics-skills-theme-factory-skill-md',
  'admin:HAIKU_SKILL_1764289865_13432'
);
