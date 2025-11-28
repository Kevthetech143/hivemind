INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Slack GIF Creator - Create optimized animated GIFs with validators and animation primitives',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Create message GIF optimized for Slack",
      "cli": {
        "macos": "python3 << ''SCRIPT''\nfrom core.gif_builder import GIFBuilder\nfrom core.validators import check_slack_size\nfrom core.frame_composer import create_gradient_background, draw_emoji_enhanced\nimport math\n\nbuilder = GIFBuilder(480, 480, 20)\nfor i in range(20):\n    frame = create_gradient_background(480, 480, (240, 248, 255), (200, 230, 255))\n    scale = 1.0 + math.sin(i * 0.314) * 0.15\n    size = int(80 * scale)\n    draw_emoji_enhanced(frame, ''🎉'', (240, 240), size)\n    builder.add_frame(frame)\n\nbuilder.save(''message.gif'', num_colors=128)\ncheck_slack_size(''message.gif'', is_emoji=False)\nSCRIPT",
        "linux": "python3 << ''SCRIPT''\nfrom core.gif_builder import GIFBuilder\nfrom core.validators import check_slack_size\nfrom core.frame_composer import create_gradient_background, draw_emoji_enhanced\nimport math\n\nbuilder = GIFBuilder(480, 480, 20)\nfor i in range(20):\n    frame = create_gradient_background(480, 480, (240, 248, 255), (200, 230, 255))\n    scale = 1.0 + math.sin(i * 0.314) * 0.15\n    size = int(80 * scale)\n    draw_emoji_enhanced(frame, ''🎉'', (240, 240), size)\n    builder.add_frame(frame)\n\nbuilder.save(''message.gif'', num_colors=128)\ncheck_slack_size(''message.gif'', is_emoji=False)\nSCRIPT",
        "windows": "python << ''SCRIPT''\nfrom core.gif_builder import GIFBuilder\nfrom core.validators import check_slack_size\nfrom core.frame_composer import create_gradient_background, draw_emoji_enhanced\nimport math\n\nbuilder = GIFBuilder(480, 480, 20)\nfor i in range(20):\n    frame = create_gradient_background(480, 480, (240, 248, 255), (200, 230, 255))\n    scale = 1.0 + math.sin(i * 0.314) * 0.15\n    size = int(80 * scale)\n    draw_emoji_enhanced(frame, ''🎉'', (240, 240), size)\n    builder.add_frame(frame)\n\nbuilder.save(''message.gif'', num_colors=128)\ncheck_slack_size(''message.gif'', is_emoji=False)\nSCRIPT"
      },
      "manual": "Create GIFBuilder with 480x480 dimensions and 15-20 FPS. Add animation frames using core.frame_composer utilities. Save with 128 colors. Validate with check_slack_size() - message GIFs max 2MB.",
      "note": "Message GIFs support: max 2MB, optimal 480x480, 15-20 FPS, 128-256 colors, 2-5s duration"
    },
    {
      "solution": "Create emoji GIF with strict size optimization",
      "cli": {
        "macos": "python3 << ''SCRIPT''\nfrom core.gif_builder import GIFBuilder\nfrom core.validators import check_slack_size\nfrom templates.pulse import create_attention_pulse\n\nframes = create_attention_pulse(''❤️'', num_frames=12)\nbuilder = GIFBuilder(128, 128, 10)\nfor frame in frames:\n    builder.add_frame(frame)\n\nbuilder.save(''emoji.gif'', num_colors=32, optimize_for_emoji=True)\ncheck_slack_size(''emoji.gif'', is_emoji=True)\nSCRIPT",
        "linux": "python3 << ''SCRIPT''\nfrom core.gif_builder import GIFBuilder\nfrom core.validators import check_slack_size\nfrom templates.pulse import create_attention_pulse\n\nframes = create_attention_pulse(''❤️'', num_frames=12)\nbuilder = GIFBuilder(128, 128, 10)\nfor frame in frames:\n    builder.add_frame(frame)\n\nbuilder.save(''emoji.gif'', num_colors=32, optimize_for_emoji=True)\ncheck_slack_size(''emoji.gif'', is_emoji=True)\nSCRIPT",
        "windows": "python << ''SCRIPT''\nfrom core.gif_builder import GIFBuilder\nfrom core.validators import check_slack_size\nfrom templates.pulse import create_attention_pulse\n\nframes = create_attention_pulse(''❤️'', num_frames=12)\nbuilder = GIFBuilder(128, 128, 10)\nfor frame in frames:\n    builder.add_frame(frame)\n\nbuilder.save(''emoji.gif'', num_colors=32, optimize_for_emoji=True)\ncheck_slack_size(''emoji.gif'', is_emoji=True)\nSCRIPT"
      },
      "manual": "Create GIFBuilder with 128x128 dimensions and 10-12 FPS. Limit to 10-15 frames total. Use 32-40 colors maximum. Save with optimize_for_emoji=True. Validate with check_slack_size(is_emoji=True) - strict 64KB limit.",
      "note": "Emoji GIFs: max 64KB (strict), 128x128 optimal, 10-12 FPS, 32-48 colors, 1-2s duration. Use solid colors instead of gradients."
    },
    {
      "solution": "Apply bounce animation primitive",
      "cli": {
        "macos": "python3 << ''SCRIPT''\nfrom templates.bounce import create_bounce_animation\nfrom core.gif_builder import GIFBuilder\n\nframes = create_bounce_animation(\n    object_type=''emoji'',\n    object_data={''emoji'': ''⚽'', ''size'': 60},\n    num_frames=30,\n    bounce_height=150\n)\n\nbuilder = GIFBuilder(480, 480, 20)\nfor frame in frames:\n    builder.add_frame(frame)\nbuilder.save(''bounce.gif'')\nSCRIPT",
        "linux": "python3 << ''SCRIPT''\nfrom templates.bounce import create_bounce_animation\nfrom core.gif_builder import GIFBuilder\n\nframes = create_bounce_animation(\n    object_type=''emoji'',\n    object_data={''emoji'': ''⚽'', ''size'': 60},\n    num_frames=30,\n    bounce_height=150\n)\n\nbuilder = GIFBuilder(480, 480, 20)\nfor frame in frames:\n    builder.add_frame(frame)\nbuilder.save(''bounce.gif'')\nSCRIPT",
        "windows": "python << ''SCRIPT''\nfrom templates.bounce import create_bounce_animation\nfrom core.gif_builder import GIFBuilder\n\nframes = create_bounce_animation(\n    object_type=''emoji'',\n    object_data={''emoji'': ''⚽'', ''size'': 60},\n    num_frames=30,\n    bounce_height=150\n)\n\nbuilder = GIFBuilder(480, 480, 20)\nfor frame in frames:\n    builder.add_frame(frame)\nbuilder.save(''bounce.gif'')\nSCRIPT"
      },
      "manual": "Import create_bounce_animation from templates.bounce. Pass object_type, object_data (emoji and size), num_frames, and bounce_height. Returns list of frames ready for GIFBuilder.",
      "note": "All animation primitives return frame lists that can be freely combined"
    },
    {
      "solution": "Use animation primitives: shake, spin, pulse, move, explode",
      "cli": {
        "macos": "python3 << ''SCRIPT''\nfrom templates.shake import create_shake_animation\nfrom templates.spin import create_spin_animation\nfrom templates.pulse import create_pulse_animation\nfrom templates.move import create_move_animation\nfrom templates.explode import create_explode_animation\n\n# Each returns frame list\nshake_frames = create_shake_animation(num_frames=20, shake_intensity=15)\nspin_frames = create_spin_animation(object_type=''emoji'', rotation_type=''clockwise'')\npulse_frames = create_pulse_animation(pulse_type=''heartbeat'', num_frames=24)\nmove_frames = create_move_animation(start_pos=(50, 240), end_pos=(430, 240))\nexplode_frames = create_explode_animation(explode_type=''burst'', num_pieces=25)\nSCRIPT",
        "linux": "python3 << ''SCRIPT''\nfrom templates.shake import create_shake_animation\nfrom templates.spin import create_spin_animation\nfrom templates.pulse import create_pulse_animation\nfrom templates.move import create_move_animation\nfrom templates.explode import create_explode_animation\n\n# Each returns frame list\nshake_frames = create_shake_animation(num_frames=20, shake_intensity=15)\nspin_frames = create_spin_animation(object_type=''emoji'', rotation_type=''clockwise'')\npulse_frames = create_pulse_animation(pulse_type=''heartbeat'', num_frames=24)\nmove_frames = create_move_animation(start_pos=(50, 240), end_pos=(430, 240))\nexplode_frames = create_explode_animation(explode_type=''burst'', num_pieces=25)\nSCRIPT",
        "windows": "echo Available primitives"
      },
      "manual": "Available animation primitives: shake (vibration), spin (rotation), pulse (scale), move (motion), explode (particles), wiggle (jello), slide (entrance), flip (between objects), morph (transform), fade (transparency), zoom (scale emphasis), kaleidoscope (symmetry effects).",
      "note": "Primitives are composable - combine multiple in same GIF for complex animations"
    },
    {
      "solution": "Validate GIF meets Slack constraints",
      "cli": {
        "macos": "python3 << ''SCRIPT''\nfrom core.validators import validate_gif, check_slack_size, is_slack_ready\n\n# Check if emoji GIF is valid\nvalid, results = validate_gif(''emoji.gif'', is_emoji=True)\nprint(f''Valid: {valid}'')\nprint(f''Results: {results}'')\n\n# Or quick check\nif is_slack_ready(''emoji.gif'', is_emoji=True):\n    print(''Ready to upload!'')\nelse:\n    # Get size info\n    passes, info = check_slack_size(''emoji.gif'', is_emoji=True)\n    print(f''Size: {info[\\\"size_kb\\\"]}KB (limit: 64KB)'')\nSCRIPT",
        "linux": "python3 << ''SCRIPT''\nfrom core.validators import validate_gif, check_slack_size, is_slack_ready\n\n# Check if emoji GIF is valid\nvalid, results = validate_gif(''emoji.gif'', is_emoji=True)\nprint(f''Valid: {valid}'')\nprint(f''Results: {results}'')\n\n# Or quick check\nif is_slack_ready(''emoji.gif'', is_emoji=True):\n    print(''Ready to upload!'')\nelse:\n    # Get size info\n    passes, info = check_slack_size(''emoji.gif'', is_emoji=True)\n    print(f''Size: {info[\\\"size_kb\\\"]}KB (limit: 64KB)'')\nSCRIPT",
        "windows": "python << validation"
      },
      "manual": "Use validate_gif() for complete validation. Use check_slack_size() for just size. Use is_slack_ready() for quick boolean check. All accept is_emoji parameter to check emoji vs message constraints.",
      "note": "Emoji GIFs have strict 64KB limit - may require reducing frames, colors, or dimensions if validation fails"
    }
  ]'::jsonb,
  'script',
  'Python 3.8+, PIL/Pillow, core toolkit modules (gif_builder, validators, frame_composer, templates)',
  'Forgetting optimize_for_emoji=True when saving emoji GIFs; using gradients in emoji GIFs (poor compression); exceeding 15 frames in emoji GIFs; using 128+ colors in emoji GIFs; not validating file size before sharing; assuming message GIF constraints apply to emojis',
  'GIF validates against Slack size limits; Message GIF under 2MB at 480x480; Emoji GIF under 64KB at 128x128; Animation displays smoothly at specified FPS; is_slack_ready() returns True',
  'Python skill for creating Slack-optimized animated GIFs with composable animation primitives and strict size validators',
  'https://skillsmp.com/skills/davila7-claude-code-templates-cli-tool-components-skills-creative-design-slack-gif-creator-skill-md',
  'admin:HAIKU_SKILL_1764290135_32431'
);
