INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Web Artifacts Builder - Create elaborate HTML artifacts with React, TypeScript, Vite, Tailwind CSS, and shadcn/ui',
  'claude-code',
  'skill',
  '[{"solution": "Initialize artifact project", "cli": {"macos": "bash scripts/init-artifact.sh <project-name>", "linux": "bash scripts/init-artifact.sh <project-name>", "windows": "bash scripts/init-artifact.sh <project-name>"}, "note": "Creates React + TypeScript project with Vite, Tailwind CSS 3.4.1, and 40+ pre-installed shadcn/ui components"}, {"solution": "Develop artifact components", "manual": "Edit generated files using React + TypeScript. Import shadcn/ui components from @/components/ui/. Use Tailwind classes for styling. Avoid excessive centered layouts, purple gradients, uniform rounded corners, and Inter font to prevent AI slop.", "note": "Stack: React 18 + TypeScript + Vite + Parcel + Tailwind CSS + shadcn/ui"}, {"solution": "Bundle to single HTML", "cli": {"macos": "bash scripts/bundle-artifact.sh", "linux": "bash scripts/bundle-artifact.sh", "windows": "bash scripts/bundle-artifact.sh"}, "note": "Creates bundle.html with all JavaScript, CSS, and dependencies inlined. Script handles Parcel installation, .parcelrc configuration, and asset inlining"}, {"solution": "Share artifact with user", "manual": "Display the bundled HTML file in conversation with the user as an artifact for viewing"}, {"solution": "Test artifact (optional)", "manual": "Use available tools like Playwright or Puppeteer to test/visualize the artifact. Skip upfront testing to avoid latency - test later if issues arise or if requested"}]'::jsonb,
  'script',
  'Node.js 18+, pnpm package manager, existing scripts directory with init-artifact.sh and bundle-artifact.sh',
  'Using excessive centered layouts, purple gradients, uniform rounded corners, or Inter font; forgetting to run npm install before bundling; not checking for index.html before bundling; testing artifact upfront adds unnecessary latency',
  'bundle.html file created successfully; all JavaScript, CSS, and dependencies inlined into single file; artifact displays correctly in claude.ai',
  'Multi-component HTML artifact builder for Claude using React, Vite, Tailwind CSS, and shadcn/ui components',
  'https://skillsmp.com/skills/anthropics-skills-web-artifacts-builder-skill-md',
  'admin:HAIKU_SKILL_1764289895_16090'
);
