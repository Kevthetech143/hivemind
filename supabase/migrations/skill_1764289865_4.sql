-- Skill: Anthropic Brand Guidelines
INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Anthropic Brand Guidelines - Apply Anthropic''s official brand colors, typography, and visual identity to artifacts like presentations, documents, and design assets.',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Apply Anthropic brand colors",
      "manual": "Main colors: Dark #141413 (primary text/dark backgrounds), Light #faf9f5 (light backgrounds/text on dark), Mid Gray #b0aea5 (secondary elements), Light Gray #e8e6dc (subtle backgrounds)"
    },
    {
      "solution": "Use accent colors",
      "manual": "Orange #d97757 (primary accent), Blue #6a9bcc (secondary accent), Green #788c5d (tertiary accent). Apply to non-text shapes and visual elements. Cycle through accents for variety"
    },
    {
      "solution": "Apply Anthropic typography",
      "manual": "Headings (24pt+): Use Poppins font (Arial fallback). Body text: Use Lora font (Georgia fallback). Maintains visual hierarchy and readability"
    },
    {
      "solution": "Check font availability",
      "manual": "Poppins and Lora fonts should be pre-installed for best results. System will automatically fall back to Arial (headings) and Georgia (body) if custom fonts unavailable"
    },
    {
      "solution": "Apply smart font selection",
      "manual": "Detect text size: if 24pt or larger, apply Poppins (heading font). If smaller, apply Lora (body font). Check system font availability and apply fallbacks if needed"
    },
    {
      "solution": "Apply text styling",
      "manual": "Use Poppins font for headings. Use Lora font for body text. Select appropriate Anthropic brand colors based on background. Preserve text hierarchy and formatting"
    },
    {
      "solution": "Apply shape and accent styling",
      "manual": "Non-text shapes use accent colors. Cycle through orange, blue, and green accents. Maintains visual interest while staying on-brand"
    },
    {
      "solution": "Ensure color accuracy",
      "manual": "Use RGB color values for precise brand matching: Dark (20, 20, 19), Light (250, 249, 245), Mid Gray (176, 174, 165), Light Gray (232, 230, 220). Orange (217, 119, 87), Blue (106, 155, 204), Green (120, 140, 93)"
    },
    {
      "solution": "Optimize for readability",
      "manual": "Select text colors based on background. Light text on dark backgrounds. Dark text on light backgrounds. Maintain sufficient contrast for accessibility"
    },
    {
      "solution": "Apply to presentations",
      "manual": "Apply Anthropic brand colors and fonts to PowerPoint slides. Update background colors to match brand palette. Apply Poppins to slide titles, Lora to body text"
    },
    {
      "solution": "Apply to documents",
      "manual": "Apply Anthropic brand styling to PDF or Word documents. Use brand colors for headers and accents. Apply correct typography for headings and body"
    },
    {
      "solution": "Apply to design assets",
      "manual": "Use Anthropic brand colors for any design elements. Apply accent colors to shapes and visual elements. Maintain consistent brand identity across assets"
    },
    {
      "solution": "Fallback font management",
      "manual": "If Poppins unavailable for headings, use Arial. If Lora unavailable for body, use Georgia. Ensures compatibility across systems without font installation"
    },
    {
      "solution": "Verify brand consistency",
      "manual": "Check all headings use Poppins or Arial. Check all body text uses Lora or Georgia. Verify colors match Anthropic brand hex values. Ensure color contrast and readability"
    }
  ]'::jsonb,
  'steps',
  'Artifact to style (presentation, document, design asset) using Anthropic brand identity. Optional: pre-installed Poppins and Lora fonts for optimal results',
  'Common mistakes: Using wrong color hex values instead of exact Anthropic brand colors. Applying Lora font to headings instead of Poppins. Not verifying font availability and fallbacks. Applying dark text on dark background (low contrast). Mixing accent colors inconsistently. Not preserving text hierarchy when applying fonts',
  'Success indicators: All headings use Poppins font (or Arial fallback) at 24pt+. All body text uses Lora font (or Georgia fallback). All colors match Anthropic brand hex codes. Text contrast meets accessibility standards. Accent colors applied consistently to shapes. Visual identity clearly reflects Anthropic branding',
  'Official Anthropic brand styling toolkit with color palette, typography standards, and visual identity guidelines for presentations, documents, and design assets',
  'https://skillsmp.com/skills/anthropics-skills-brand-guidelines-skill-md',
  'admin:HAIKU_SKILL_1764289865_13432'
);
