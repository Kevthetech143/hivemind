INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Slack GIF Creator - Knowledge and utilities for creating animated GIFs optimized for Slack',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Setup GIFBuilder for creating animated frames",
      "cli": {
        "macos": "pip install pillow imageio numpy",
        "linux": "pip install pillow imageio numpy",
        "windows": "pip install pillow imageio numpy"
      },
      "manual": "Install required dependencies: Pillow (image manipulation), imageio (GIF creation), NumPy (numerical operations)",
      "note": "Core dependencies for GIF creation and animation"
    },
    {
      "solution": "Create basic animated GIF using GIFBuilder",
      "manual": "1. Import GIFBuilder from core.gif_builder\n2. Create builder with dimensions (128x128 for emoji, 480x480 for messages) and fps (10-30)\n3. Generate frames using PIL ImageDraw for shapes\n4. Add frames to builder\n5. Save with num_colors=48 for optimization\n6. Use optimize_for_emoji=True for emoji GIFs",
      "note": "GIFBuilder assembles frames and optimizes for Slack''s requirements"
    },
    {
      "solution": "Draw graphics using PIL primitives",
      "manual": "Use ImageDraw for shapes: ellipse() for circles, polygon() for complex shapes, line() for lines, rectangle() for boxes. Always use width>=2 for visible outlines. Combine shapes for complexity (e.g., star with inner star for depth).",
      "note": "Don''t use emoji fonts - unreliable across platforms. Draw everything with PIL primitives."
    },
    {
      "solution": "Implement animation concepts",
      "manual": "Shake: Use math.sin() with frame index for oscillation. Pulse: Use math.sin(t * frequency * 2 * pi) for scaling. Bounce: Use easing=''bounce_out''. Spin: Use image.rotate(). Fade: Adjust alpha channel. Slide: Move from off-screen with easing=''ease_out''. Zoom: Scale and crop center. Explode: Generate particles with velocity and gravity.",
      "note": "Combine multiple concepts for complex animations"
    },
    {
      "solution": "Validate GIF meets Slack requirements",
      "manual": "Import validators from core.validators. Call validate_gif(filepath, is_emoji=True, verbose=True) for detailed validation. Use is_slack_ready(filepath) for quick checks. Emoji GIFs should be 128x128, message GIFs 480x480.",
      "note": "Keep file size under constraints: fewer frames, fewer colors, or smaller dimensions"
    },
    {
      "solution": "Use color palettes for professional appearance",
      "manual": "Import from core.color_palettes: get_palette() for named palettes (vibrant, pastel, dark, neon, professional, warm, cool, monochrome). Use get_text_color_for_background() for readable text. Use get_complementary_color() for accent colors. Blend colors with blend_colors().",
      "note": "Professional palettes make GIFs look polished instead of random"
    },
    {
      "solution": "Apply easing functions for smooth motion",
      "manual": "Import from core.easing: interpolate(start, end, t, easing=''ease_out'') to smoothly animate values. Available easing: linear, ease_in, ease_out, ease_in_out, bounce_out, elastic_out, back_out. Use with frame progress (t = i / num_frames).",
      "note": "Easing prevents jerky, mechanical-looking animations"
    }
  ]'::jsonb,
  'script',
  'Python 3.7+, Pillow, imageio, NumPy. Access to core.gif_builder, core.validators, core.easing, core.color_palettes modules.',
  'Using emoji fonts (unreliable), assuming pre-packaged graphics exist, thin lines (width=1), not using easing functions, forgetting to optimize colors for file size, basic unpolished graphics.',
  'GIF plays smoothly in Slack, file size under limits (128KB for emoji), validation passes, colors look professional and intentional, animations are smooth not jerky.',
  'Create Slack-optimized animated GIFs with Python PIL, easing functions, and color palettes for polished animations',
  'https://skillsmp.com/skills/anthropics-skills-slack-gif-creator-skill-md',
  'admin:HAIKU_SKILL_1764289880_14600'
);
