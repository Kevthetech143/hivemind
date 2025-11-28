INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Artifacts Builder - Create elaborate React/Tailwind artifacts with shadcn/ui components',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Initialize new React artifact project",
      "cli": {
        "macos": "bash scripts/init-artifact.sh my-artifact && cd my-artifact",
        "linux": "bash scripts/init-artifact.sh my-artifact && cd my-artifact",
        "windows": "bash scripts/init-artifact.sh my-artifact && cd my-artifact"
      },
      "manual": "Run init-artifact.sh script with project name. Automatically creates React+TypeScript project with Vite, Tailwind CSS 3.4.1, shadcn/ui components (40+ pre-installed), Radix UI dependencies, and path aliases configured.",
      "note": "Requires Node.js 18+ and pnpm. Script auto-detects Node version and pins Vite accordingly."
    },
    {
      "solution": "Bundle React artifact to single HTML file",
      "cli": {
        "macos": "bash scripts/bundle-artifact.sh",
        "linux": "bash scripts/bundle-artifact.sh",
        "windows": "bash scripts/bundle-artifact.sh"
      },
      "manual": "Run bundle-artifact.sh from project root after development. Installs Parcel and inlines all JavaScript, CSS, and dependencies into single self-contained bundle.html file ready for Claude artifact display.",
      "note": "Requires index.html in project root. Bundles with no source maps for production use."
    },
    {
      "solution": "Use shadcn/ui components in React artifact",
      "cli": {
        "macos": "cat > src/App.tsx << ''COMPONENT''\nimport { Button } from ''@/components/ui/button''\nimport { Card, CardHeader, CardTitle, CardContent } from ''@/components/ui/card''\nimport { Dialog, DialogContent, DialogTrigger } from ''@/components/ui/dialog''\n\nexport default function App() {\n  return (\n    <Card>\n      <CardHeader>\n        <CardTitle>My Artifact</CardTitle>\n      </CardHeader>\n      <CardContent>\n        <Button>Click me</Button>\n      </CardContent>\n    </Card>\n  )\n}\nCOMPONENT",
        "linux": "cat > src/App.tsx << ''COMPONENT''\nimport { Button } from ''@/components/ui/button''\nimport { Card, CardHeader, CardTitle, CardContent } from ''@/components/ui/card''\nimport { Dialog, DialogContent, DialogTrigger } from ''@/components/ui/dialog''\n\nexport default function App() {\n  return (\n    <Card>\n      <CardHeader>\n        <CardTitle>My Artifact</CardTitle>\n      </CardHeader>\n      <CardContent>\n        <Button>Click me</Button>\n      </CardContent>\n    </Card>\n  )\n}\nCOMPONENT",
        "windows": "echo. > src/App.tsx"
      },
      "manual": "Import components from ''@/components/ui/component-name''. Available components: accordion, alert, avatar, badge, button, card, carousel, checkbox, dialog, dropdown-menu, form, input, label, select, tabs, toast, toggle, tooltip, and 20+ more.",
      "note": "All Radix UI dependencies and styling already installed. Use Tailwind classes with shadcn theme CSS variables."
    },
    {
      "solution": "Configure path aliases for imports",
      "cli": {
        "macos": "node -e \"const fs = require(''fs''); const cfg = JSON.parse(fs.readFileSync(''tsconfig.json'', ''utf8'')); cfg.compilerOptions.baseUrl = ''.''; cfg.compilerOptions.paths = {''@/*'': [''./src/*'']}; fs.writeFileSync(''tsconfig.json'', JSON.stringify(cfg, null, 2));\"",
        "linux": "node -e \"const fs = require(''fs''); const cfg = JSON.parse(fs.readFileSync(''tsconfig.json'', ''utf8'')); cfg.compilerOptions.baseUrl = ''.''; cfg.compilerOptions.paths = {''@/*'': [''./src/*'']}; fs.writeFileSync(''tsconfig.json'', JSON.stringify(cfg, null, 2));\"",
        "windows": "echo update tsconfig.json"
      },
      "manual": "Update tsconfig.json with baseUrl and paths configuration for ''@/'' import aliases. init-artifact.sh handles this automatically.",
      "note": "Also configure in vite.config.ts using path.resolve plugin"
    }
  ]'::jsonb,
  'script',
  'Node.js 18+, pnpm, Vite, React 18, TypeScript',
  'Using excessive centered layouts or purple gradients (AI slop); forgetting to run bundle-artifact.sh before sharing; not updating tsconfig.json paths; importing non-existent component names; bundling without index.html',
  'Project initialized with Vite and all dependencies installed; shadcn components import correctly with @/ paths; bundle.html generated as single file; artifact displays with proper Tailwind styling and component interactivity',
  'React skill for building elaborate artifacts with Tailwind CSS and shadcn/ui components, bundled to single HTML file',
  'https://skillsmp.com/skills/davila7-claude-code-templates-cli-tool-components-skills-development-artifacts-builder-skill-md',
  'admin:HAIKU_SKILL_1764290135_32431'
);
