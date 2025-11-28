INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'MCP Server Development Guide - Creating high-quality Model Context Protocol servers',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Phase 1: Deep Research and Planning - Understand MCP design principles",
      "cli": {
        "macos": "open https://modelcontextprotocol.io/sitemap.xml",
        "linux": "curl https://modelcontextprotocol.io/sitemap.xml",
        "windows": "start https://modelcontextprotocol.io/sitemap.xml"
      },
      "manual": "Study MCP specification at https://modelcontextprotocol.io/. Key topics: API coverage vs workflow tools, tool naming conventions, context management, error handling. For TypeScript: fetch https://raw.githubusercontent.com/modelcontextprotocol/typescript-sdk/main/README.md. For Python: fetch https://raw.githubusercontent.com/modelcontextprotocol/python-sdk/main/README.md",
      "note": "Balance comprehensive API endpoint coverage with specialized workflow tools. Use consistent prefixes like github_create_issue, github_list_repos"
    },
    {
      "solution": "Phase 2: Implementation - Set up project and implement core infrastructure",
      "cli": {
        "macos": "npm init && npm install --save-dev typescript zod",
        "linux": "npm init && npm install --save-dev typescript zod",
        "windows": "npm init && npm install --save-dev typescript zod"
      },
      "manual": "Create project structure with: API client with authentication, error handling helpers, response formatting (JSON/Markdown), pagination support. For each tool implement: input schema (Zod for TS, Pydantic for Python), output schema with structuredContent, proper async/await error handling, pagination support. Add annotations: readOnlyHint, destructiveHint, idempotentHint, openWorldHint",
      "note": "TypeScript is recommended over Python for better SDK support and AI code generation compatibility"
    },
    {
      "solution": "Phase 3: Review and Test - Build and verify implementation",
      "cli": {
        "macos": "npm run build && npx @modelcontextprotocol/inspector",
        "linux": "npm run build && npx @modelcontextprotocol/inspector",
        "windows": "npm run build && npx @modelcontextprotocol/inspector"
      },
      "manual": "For TypeScript: Run npm run build to verify compilation. For Python: Run python -m py_compile your_server.py. Test with MCP Inspector tool. Review for: no duplicated code, consistent error handling, full type coverage, clear tool descriptions. Verify all tools have proper input/output schemas and docstrings.",
      "note": "MCP Inspector allows testing tools before deploying. Use to validate schemas and descriptions"
    },
    {
      "solution": "Phase 4: Create Evaluations - Test LLM effectiveness with complex questions",
      "cli": {
        "macos": "npx @modelcontextprotocol/inspector",
        "linux": "npx @modelcontextprotocol/inspector",
        "windows": "npx @modelcontextprotocol/inspector"
      },
      "manual": "Create 10 READ-ONLY evaluation questions that: (1) are independent of each other, (2) require multiple tool calls, (3) test deep exploration, (4) stress-test tool return values, (5) reflect real human use cases, (6) have stable answers that won''t change. Format output as XML with qa_pair elements containing question and answer tags. Answers must be single verifiable values (names, IDs, numbers, booleans)",
      "note": "Questions should NOT be solvable with straightforward keyword search. Require multiple searches, analyzing related items, extracting context, then deriving answer. Answers should mostly be human-readable (names, datetimes) rather than opaque IDs"
    }
  ]'::jsonb,
  'steps',
  'Understanding of MCP protocol, Node.js/Python installed, npm or pip package manager, familiarity with API documentation reading',
  'Choosing workflow tools over comprehensive API coverage - prioritize complete endpoint coverage for maximum agent flexibility. Not following the 4-phase workflow leads to poor MCP server quality. Underestimating evaluation complexity - evaluations must truly test if LLMs can accomplish real tasks using only the MCP tools',
  'Successfully created MCP server with clear tool naming conventions, proper input/output schemas, and comprehensive API coverage. Evaluations demonstrate LLM can use server to answer complex realistic questions requiring multiple tool calls. Code passes npm run build with no errors. MCP Inspector confirms all tools are properly registered and documented',
  'Complete 4-phase process for building MCP servers: research protocol design, implement infrastructure and tools with proper schemas, review and test with inspector, create 10 complex read-only evaluation questions',
  'https://skillsmp.com/skills/anthropics-skills-mcp-builder-skill-md',
  'admin:HAIKU_SKILL_1764289850_11700'
);
