-- Skill: Web Application Testing
INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Web Application Testing - Toolkit for interacting with and testing local web applications using Playwright with support for frontend verification, debugging UI, screenshots, and browser logs.',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Install Playwright",
      "cli": {
        "macos": "pip install playwright && playwright install",
        "linux": "pip install playwright && playwright install",
        "windows": "pip install playwright && playwright install"
      },
      "manual": "Install playwright package with pip, then run playwright install to download browser binaries"
    },
    {
      "solution": "Use with_server.py helper to manage server lifecycle",
      "cli": {
        "macos": "python scripts/with_server.py --server \"npm run dev\" --port 5173 -- python automation.py",
        "linux": "python scripts/with_server.py --server \"npm run dev\" --port 5173 -- python automation.py"
      },
      "manual": "Run with_server.py with --help first. Use --server with command and --port with port number. Supports multiple servers by repeating --server and --port"
    },
    {
      "solution": "Start multiple servers with with_server.py",
      "cli": {
        "macos": "python scripts/with_server.py --server \"cd backend && python server.py\" --port 3000 --server \"cd frontend && npm run dev\" --port 5173 -- python test.py"
      },
      "manual": "Provide multiple --server and --port pairs in order. The helper waits for all servers to be ready before running the command"
    },
    {
      "solution": "Write Playwright automation script",
      "manual": "Use sync_playwright context manager. Launch chromium in headless mode. Navigate to localhost URL. Wait for networkidle. Use page.locator() to find elements with text=, role=, or CSS selectors. Execute actions like click(), fill(), etc."
    },
    {
      "solution": "Wait for dynamic content to load",
      "manual": "Always call page.wait_for_load_state(''networkidle'') after navigation before inspecting DOM or taking actions. This ensures JavaScript execution is complete"
    },
    {
      "solution": "Take screenshots for debugging",
      "manual": "Use page.screenshot(path=''screenshot.png'', full_page=True) to capture full page or specific area. Take screenshots before and after actions to verify state changes"
    },
    {
      "solution": "Inspect DOM and discover elements",
      "manual": "After wait_for_load_state, use page.locator() to find elements. Call .all() to get list of matching elements. Use .inner_text() to get visible text, .get_attribute() for attributes"
    },
    {
      "solution": "Capture console logs",
      "manual": "Define function handle_console_message(msg). Use page.on(''console'', handle_console_message). Save captured logs to file for analysis"
    },
    {
      "solution": "Interact with static HTML files",
      "manual": "Convert file path to file:// URL. Use page.goto(file_url) to navigate. Interact with elements same as remote URL"
    },
    {
      "solution": "Test buttons and links",
      "manual": "Use page.locator(''button'').all() to discover all buttons. Use text= selector for text-based matching: page.click(''text=Click Me''). Use role= for semantic selectors"
    },
    {
      "solution": "Fill form inputs",
      "manual": "Use page.fill(selector, value) to enter text. Use page.click() to select checkboxes or radio buttons. Use page.select_option() for dropdowns"
    },
    {
      "solution": "Wait for elements and state changes",
      "manual": "Use page.wait_for_selector() to wait for specific element. Use page.wait_for_timeout() for fixed delay. Use page.wait_for_load_state() for network idle"
    }
  ]'::jsonb,
  'script',
  'Python 3.7+, pip package manager, Node.js for running dev servers. Browser installation handled by playwright install',
  'Common mistakes: Not waiting for networkidle before inspecting DOM on dynamic apps, causing selector mismatches. Not closing browser. Using hardcoded delays instead of proper waits. Not running with_server.py --help before using it. Forgetting to launch chromium in headless mode. Trying to read helper script source instead of using as black box',
  'Success indicators: Playwright scripts execute without timeout errors. Screenshots capture expected UI state. Elements are discovered with correct selectors. Form inputs populated correctly. Console logs captured and saved. Multiple servers started and coordinated properly',
  'Playwright-based automation toolkit for testing local web applications with server lifecycle management, screenshot capture, console logging, and element discovery patterns',
  'https://skillsmp.com/skills/anthropics-skills-webapp-testing-skill-md',
  'admin:HAIKU_SKILL_1764289865_13432'
);
