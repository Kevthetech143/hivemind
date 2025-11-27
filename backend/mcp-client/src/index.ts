#!/usr/bin/env node
/**
 * Claude Code Knowledge Base - MCP Server (Supabase Edition)
 *
 * Connects Claude Code to the Supabase-hosted knowledge base
 * Requires: SUPABASE_URL and SUPABASE_ANON_KEY environment variables
 */

import { Server } from '@modelcontextprotocol/sdk/server/index.js';
import { StdioServerTransport } from '@modelcontextprotocol/sdk/server/stdio.js';
import {
  CallToolRequestSchema,
  ErrorCode,
  ListToolsRequestSchema,
  McpError,
} from '@modelcontextprotocol/sdk/types.js';

// ============================================================================
// Configuration
// ============================================================================

const SUPABASE_URL = 'https://ksethrexopllfhyrxlrb.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtzZXRocmV4b3BsbGZoeXJ4bHJiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjM3NDU4ODksImV4cCI6MjA3OTMyMTg4OX0.SDJulNaemJ66EaFl77-1IJLTAleihU5PvEChNaO5osI';
const CURRENT_VERSION = '2.2.0';
const NPM_PACKAGE_NAME = 'clauderepo-mcp';

// Session ID - unique per MCP server instance (persists for session lifetime)
const SESSION_ID = `session_${Date.now()}_${Math.random().toString(36).substring(2, 8)}`;

// ============================================================================
// Version Checking (1 hour cache)
// ============================================================================

let latestVersionCache: { version: string | null; timestamp: number } = {
  version: null,
  timestamp: 0,
};

function isNewerVersion(latest: string, current: string): boolean {
  const latestParts = latest.split('.').map(Number);
  const currentParts = current.split('.').map(Number);

  for (let i = 0; i < 3; i++) {
    if ((latestParts[i] || 0) > (currentParts[i] || 0)) return true;
    if ((latestParts[i] || 0) < (currentParts[i] || 0)) return false;
  }
  return false;
}

async function checkForUpdates(): Promise<string | null> {
  const ONE_HOUR = 60 * 60 * 1000;
  const now = Date.now();

  // Return cached result if less than 1 hour old
  if (latestVersionCache.version && (now - latestVersionCache.timestamp) < ONE_HOUR) {
    return latestVersionCache.version;
  }

  try {
    const response = await fetch(`https://registry.npmjs.org/${NPM_PACKAGE_NAME}/latest`, {
      headers: { 'Accept': 'application/json' },
    });

    if (response.ok) {
      const data = await response.json();
      const latestVersion = data.version;

      // Update cache
      latestVersionCache = {
        version: latestVersion,
        timestamp: now,
      };

      // Compare versions (only notify if npm is newer)
      if (isNewerVersion(latestVersion, CURRENT_VERSION)) {
        return latestVersion;
      }
    }
  } catch (error) {
    // Silently fail - don't interrupt user experience
    console.error('Version check failed:', error);
  }

  return null;
}

function getUpdateMessage(latestVersion: string): string {
  return `\n\n---\n\n📢 **Update Available**: v${latestVersion} (you have v${CURRENT_VERSION})\n` +
         `Run: \`npm update -g ${NPM_PACKAGE_NAME}\`\n`;
}

// ============================================================================
// API Client
// ============================================================================

async function callEdgeFunction(functionName: string, body: any): Promise<any> {
  const response = await fetch(`${SUPABASE_URL}/functions/v1/${functionName}`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${SUPABASE_ANON_KEY}`,
    },
    body: JSON.stringify(body),
  });

  if (!response.ok) {
    const error = await response.json().catch(() => ({ error: response.statusText }));
    throw new McpError(
      ErrorCode.InternalError,
      `API Error: ${error.error || error.message || response.statusText}`
    );
  }

  return response.json();
}

// ============================================================================
// MCP Server Setup
// ============================================================================

const server = new Server(
  {
    name: 'clauderepo',
    version: '2.2.0',
  },
  {
    capabilities: {
      tools: {},
    },
  }
);

// ============================================================================
// Tool Definitions
// ============================================================================

server.setRequestHandler(ListToolsRequestSchema, async () => {
  return {
    tools: [
      {
        name: 'search_kb',
        description:
          'Search the hivemind knowledge base for troubleshooting solutions, error fixes, and how-to flows. ' +
          'Returns ranked solutions with success rates, prerequisites, validation steps, and related patterns. ' +
          'Covers MCP servers, Playwright automation, security patterns, and more.',
        inputSchema: {
          type: 'object',
          properties: {
            query: {
              type: 'string',
              description:
                'Error message, problem description, or technology to search for. ' +
                'Examples: "MCP connection refused", "playwright timeout", "how to respawn claude"',
            },
            type: {
              type: 'string',
              enum: ['fix', 'flow'],
              description:
                'Optional: Force search to return only fixes or only flows. ' +
                'If not specified, type is auto-detected from query (error keywords → fix, how-to phrases → flow)',
            },
          },
          required: ['query'],
        },
      },
      {
        name: 'list_flows',
        description:
          'Browse all available flows (how-to instructions) in the knowledge base. ' +
          'Flows are step-by-step guides that any AI can execute. ' +
          'Use this to discover what flows are available or filter by category.',
        inputSchema: {
          type: 'object',
          properties: {
            category: {
              type: 'string',
              description: 'Optional: Filter flows by category (e.g., "claude-code", "web-automation")',
            },
          },
          required: [],
        },
      },
      {
        name: 'get_flow',
        description:
          'Get a specific flow by ID. Returns full step-by-step instructions. ' +
          'Use list_flows first to browse available flows and get their IDs.',
        inputSchema: {
          type: 'object',
          properties: {
            flow_id: {
              type: 'number',
              description: 'The flow ID (from list_flows results)',
            },
          },
          required: ['flow_id'],
        },
      },
      {
        name: 'list_skills',
        description:
          'Browse all available skills in the knowledge base. ' +
          'Skills are reusable AI capabilities with cross-platform support (CLI commands + manual instructions). ' +
          'Use this to discover skills or filter by category.',
        inputSchema: {
          type: 'object',
          properties: {
            category: {
              type: 'string',
              description: 'Optional: Filter skills by category (e.g., "claude-code", "web-automation")',
            },
          },
          required: [],
        },
      },
      {
        name: 'get_skill',
        description:
          'Get a specific skill by ID. Returns raw JSON with full execution details including: ' +
          'cli commands (macos/linux/windows), manual instructions for web AIs, prerequisites, and pitfalls. ' +
          'Use list_skills first to browse available skills and get their IDs.',
        inputSchema: {
          type: 'object',
          properties: {
            skill_id: {
              type: 'number',
              description: 'The skill ID (from list_skills results)',
            },
          },
          required: ['skill_id'],
        },
      },
      {
        name: 'contribute_solution',
        description:
          'Submit a new solution to the clauderepo knowledge base. ' +
          'Share solutions you\'ve discovered to help the community. ' +
          'Submissions are reviewed before being added to the database (typically within 24-48 hours).',
        inputSchema: {
          type: 'object',
          properties: {
            query: {
              type: 'string',
              description: 'The error message or problem this solution solves',
            },
            category: {
              type: 'string',
              description: 'Category: mcp-troubleshooting, web-automation, security, performance, etc',
            },
            solutions: {
              type: 'array',
              description: 'Array of solution objects with: solution, percentage, command (optional), note (optional)',
              items: {
                type: 'object',
                properties: {
                  solution: { type: 'string' },
                  percentage: { type: 'number' },
                  command: { type: 'string' },
                  note: { type: 'string' }
                },
                required: ['solution', 'percentage']
              }
            },
            prerequisites: {
              type: 'string',
              description: 'Comma-separated list of requirements needed before applying solutions',
            },
            success_indicators: {
              type: 'string',
              description: 'How to verify the solution worked',
            },
            common_pitfalls: {
              type: 'string',
              description: 'Optional: Common mistakes users make',
            },
          },
          required: ['query', 'category', 'solutions', 'prerequisites', 'success_indicators'],
        },
      },
      {
        name: 'report_solution_outcome',
        description:
          'Report solution feedback to improve rankings and quality. ' +
          'TRIGGER WORDS: When the user says "clauderepo: worked" or "clauderepo: failed", call this tool IMMEDIATELY. ' +
          'Also call when user says "that worked", "it worked", "that fixed it", "didn\'t work", "still broken", etc. ' +
          'Use pending_id if from a just-resolved ticket, solution_id from search results, or solution_query as fallback.',
        inputSchema: {
          type: 'object',
          properties: {
            pending_id: {
              type: 'number',
              description: 'The pending solution ID (from resolve_ticket response). Use this to approve a just-resolved ticket solution.',
            },
            solution_id: {
              type: 'number',
              description: 'The numeric ID of the solution (from primary_solution.id in search results). Preferred over solution_query.',
            },
            solution_query: {
              type: 'string',
              description: 'Fallback: The exact query/problem title of the solution (use solution_id or pending_id instead if available)',
            },
            outcome: {
              type: 'string',
              enum: ['success', 'failure'],
              description: 'Did the solution work? "success" if it solved the problem, "failure" if it didn\'t',
            },
            copied_command: {
              type: 'boolean',
              description: 'Optional: Did you copy and run a command from the solution?',
            },
          },
          required: ['outcome'],
        },
      },
      {
        name: 'update_ticket_steps',
        description:
          'Update a troubleshooting ticket with steps tried. ' +
          'Call this as you work through the ticket checklist to track progress and debugging steps.',
        inputSchema: {
          type: 'object',
          properties: {
            ticket_id: {
              type: 'string',
              description: 'The ticket ID (e.g., TICKET_000001)',
            },
            step: {
              type: 'string',
              description: 'The troubleshooting step that was tried',
            },
            result: {
              type: 'string',
              description: 'The result/outcome of trying this step',
            },
          },
          required: ['ticket_id', 'step', 'result'],
        },
      },
      {
        name: 'resolve_ticket',
        description:
          'Resolve a troubleshooting ticket and queue the solution for verification. ' +
          'Call this when the problem is solved. Solution goes to pending queue until verified.',
        inputSchema: {
          type: 'object',
          properties: {
            ticket_id: {
              type: 'string',
              description: 'The ticket ID to resolve',
            },
            solution_data: {
              type: 'object',
              description: 'Solution data object',
              properties: {
                solution: {
                  type: 'string',
                  description: 'Brief description of the solution'
                },
                solutions: {
                  type: 'array',
                  description: 'Array of solution objects',
                  items: {
                    type: 'object',
                    properties: {
                      solution: { type: 'string' },
                      percentage: { type: 'number' },
                      command: { type: 'string' },
                      note: { type: 'string' }
                    }
                  }
                },
                prerequisites: {
                  type: 'string',
                  description: 'What needs to be checked before applying'
                },
                success_indicators: {
                  type: 'string',
                  description: 'How to verify it worked'
                },
                common_pitfalls: {
                  type: 'string',
                  description: 'Common mistakes to avoid'
                },
                success_rate: {
                  type: 'number',
                  description: 'Estimated success rate (0.0-1.0)'
                }
              },
              required: ['solutions']
            },
          },
          required: ['ticket_id', 'solution_data'],
        },
      },
      // ADMIN TOOLS REMOVED FROM PUBLIC NPM PACKAGE
      // Use index-admin.ts locally for admin functions:
      // - list_pending_solutions
      // - approve_pending_solution
    ],
  };
});

// ============================================================================
// Tool Handlers
// ============================================================================

server.setRequestHandler(CallToolRequestSchema, async (request) => {
  const toolName = request.params.name;

  // Handle search_kb tool
  if (toolName === 'search_kb') {
    const query = String(request.params.arguments?.query);
    const typeFilter = request.params.arguments?.type as string | undefined;
    if (!query) {
      throw new McpError(ErrorCode.InvalidParams, 'query parameter is required');
    }

    try {
      // Check for updates (async, non-blocking)
      const updateCheckPromise = checkForUpdates();

      const searchParams: any = { query, session_id: SESSION_ID };
      if (typeFilter) {
        searchParams.type = typeFilter;
      }
      const result = await callEdgeFunction('search', searchParams);

      // Format response for Claude Code
      let formattedText = `# Search Results: "${query}"\n\n`;

      // Handle multi-category response for ambiguous queries
      if (result.search_mode === 'multi_category' && result.category_results) {
        const CAT_EMOJI: Record<string, string> = {
          'python': '🐍', 'rust': '🦀', 'javascript': '📜', 'typescript': '📘',
          'go': '🔵', 'golang': '🔵', 'docker': '🐳', 'kubernetes': '☸️',
          'postgres': '🐘', 'postgresql': '🐘', 'supabase': '⚡',
          'mcp-troubleshooting': '🔌', 'web-automation': '🎭', 'playwright': '🎭',
          'react': '⚛️', 'vue': '💚', 'svelte': '🔶', 'angular': '🅰️',
          'node': '💚', 'nodejs': '💚', 'java': '☕', 'swift': '🍎',
          'kotlin': '🟣', 'flutter': '💙', 'dart': '🎯',
          'aws': '☁️', 'gcp': '🌐', 'azure': '🔷',
          'security': '🔒', 'performance': '⚡', 'database': '🗄️',
          'frontend': '🖥️', 'backend': '⚙️', 'general': '📦'
        };

        formattedText += `## 🎯 Multiple Contexts Found\n\n`;
        formattedText += `Your query matches **${result.category_count} categories**. Here's the top result from each:\n\n`;

        for (const cat of result.category_results) {
          const catLower = cat.category.toLowerCase();
          const emoji = CAT_EMOJI[catLower] || '📦';
          formattedText += `### ${emoji} ${cat.category.toUpperCase()}\n`;
          formattedText += `**${cat.query}**\n\n`;

          const solutions = cat.solutions || [];
          solutions.slice(0, 2).forEach((sol: any, idx: number) => {
            formattedText += `${idx + 1}. ${sol.solution}`;
            if (sol.command) formattedText += `\n   \`${sol.command}\``;
            if (sol.note) formattedText += `\n   *${sol.note}*`;
            formattedText += '\n';
          });
          formattedText += '\n';
        }

        formattedText += `---\n`;
        formattedText += `💡 **Tip**: ${result.tip}\n\n`;
        formattedText += `*Search completed in ${result.query_metadata.search_time_ms.toFixed(1)}ms using ${result.query_metadata.search_method}*\n`;

        // Add update notification if available
        const latestVersion = await updateCheckPromise;
        if (latestVersion) {
          formattedText += getUpdateMessage(latestVersion);
        }

        return {
          content: [{ type: 'text', text: formattedText }],
        };
      }

      if (!result.primary_solution) {
        // Check if ticket was auto-created
        if (result.ticket) {
          formattedText += `## 🎫 Troubleshooting Ticket Opened\n\n`;
          formattedText += `${result.ticket.message}\n\n`;
          formattedText += `**Ticket ID**: ${result.ticket.ticket_id}\n`;
          formattedText += `**Category**: ${result.ticket.category}\n`;
          formattedText += `**Status**: ${result.ticket.status}\n\n`;
          formattedText += `### 📋 Systematic Checklist:\n\n`;

          const checklist = result.ticket.checklist;
          if (Array.isArray(checklist)) {
            checklist.forEach((item: string, idx: number) => {
              formattedText += `${idx + 1}. ${item}\n`;
            });
          }

          formattedText += `\n---\n\n`;
          formattedText += `**Next Steps**:\n`;
          formattedText += `1. Work through the checklist above\n`;
          formattedText += `2. I'll track progress using update_ticket_steps\n`;
          formattedText += `3. When solved, I'll call resolve_ticket to auto-add solution to clauderepo\n\n`;
          formattedText += `Let's start with step 1. What do you see when you try it?`;
        } else {
          formattedText += '❌ No solutions found for this query.\n\n';
          formattedText += '💡 Try:\n';
          formattedText += '- Rephrasing your query\n';
          formattedText += '- Using error message keywords\n';
          formattedText += '- Searching for technology name (e.g., "playwright", "MCP")\n';
        }

        // Add update notification if available (await the promise)
        const latestVersion = await updateCheckPromise;
        if (latestVersion) {
          formattedText += getUpdateMessage(latestVersion);
        }

        return {
          content: [
            {
              type: 'text',
              text: formattedText,
            },
          ],
        };
      }

      const { primary_solution, confidence, related_solutions, environment_checks, validation_steps, detected_type } = result;
      const entryType = primary_solution.type || 'fix';

      // Different rendering for fixes vs flows
      if (entryType === 'flow') {
        // FLOW: How-to instructions
        formattedText += `## 📘 Flow: ${primary_solution.query}\n\n`;
        formattedText += `**Category**: ${primary_solution.category}\n\n`;

        formattedText += `### 📋 Steps:\n\n`;
        primary_solution.solutions.forEach((step: any, idx: number) => {
          formattedText += `**Step ${idx + 1}: ${step.solution}**\n`;
          if (step.command) formattedText += `\`\`\`bash\n${step.command}\n\`\`\`\n`;
          if (step.note) formattedText += `*Note*: ${step.note}\n`;
          formattedText += '\n';
        });
      } else {
        // FIX: Error solution (existing format)
        formattedText += `## 🎯 Primary Solution\n\n`;
        formattedText += `**Solution ID**: ${primary_solution.id}\n`;
        formattedText += `**Problem**: ${primary_solution.query}\n`;
        formattedText += `**Category**: ${primary_solution.category}\n\n`;

        // Pattern info
        if (primary_solution.pattern) {
          formattedText += `### 🔍 Pattern: ${primary_solution.pattern.display_name}\n\n`;
          formattedText += `**Why this happens**: ${primary_solution.pattern.root_cause}\n\n`;
          formattedText += `**How to recognize**: ${primary_solution.pattern.detection_signals}\n\n`;
          formattedText += `**General approach**: ${primary_solution.pattern.solution_template}\n\n`;
        }

        formattedText += `### 💡 Solutions:\n\n`;
        primary_solution.solutions.forEach((sol: any, idx: number) => {
          formattedText += `**${idx + 1}. ${sol.solution}**\n`;
          if (sol.command) formattedText += `   \`\`\`bash\n   ${sol.command}\n   \`\`\`\n`;
          if (sol.example) formattedText += `   *Example*: ${sol.example}\n`;
          if (sol.note) formattedText += `   *Note*: ${sol.note}\n`;
          formattedText += '\n';
        });
      }

      // Prerequisites
      if (environment_checks.length > 0) {
        formattedText += `### ⚙️ Prerequisites:\n`;
        environment_checks.forEach((check: any) => {
          formattedText += `- ${check.prerequisite}\n`;
        });
        formattedText += '\n';
      }

      // Validation
      if (validation_steps.length > 0) {
        formattedText += `### ✅ Success Validation:\n`;
        validation_steps.forEach((step: string) => {
          formattedText += `- ${step}\n`;
        });
        formattedText += '\n';
      }

      // Common pitfalls
      if (primary_solution.common_pitfalls) {
        formattedText += `### ⚠️ Common Pitfalls:\n${primary_solution.common_pitfalls}\n\n`;
      }

      // Related solutions
      if (related_solutions.length > 0) {
        formattedText += `### 🔗 Related Solutions:\n`;
        related_solutions.forEach((rel: any, idx: number) => {
          const similarity = (rel.similarity_score * 100).toFixed(0);
          formattedText += `${idx + 1}. ${rel.entry.query} (${similarity}% similar)\n`;
        });
        formattedText += '\n';
      }

      // Metadata
      formattedText += `---\n`;
      formattedText += `*Search completed in ${result.query_metadata.search_time_ms.toFixed(1)}ms using ${result.query_metadata.search_method}*\n\n`;
      formattedText += `💬 **After trying a solution, tell me:** "clauderepo: worked" or "clauderepo: failed"\n`;
      formattedText += `   *(Use solution_id: ${primary_solution.id} for feedback)*\n`;

      // Add update notification if available (await the promise)
      const latestVersion = await updateCheckPromise;
      if (latestVersion) {
        formattedText += getUpdateMessage(latestVersion);
      }

      return {
        content: [
          {
            type: 'text',
            text: formattedText,
          },
        ],
      };
    } catch (error) {
      if (error instanceof McpError) {
        throw error;
      }
      throw new McpError(
        ErrorCode.InternalError,
        `Search failed: ${error instanceof Error ? error.message : String(error)}`
      );
    }
  }

  // Handle list_flows tool
  if (toolName === 'list_flows') {
    const category = request.params.arguments?.category as string | undefined;

    try {
      const result = await callEdgeFunction('flows', { action: 'list', category });

      let formattedText = `# 📘 Available Flows\n\n`;

      if (result.flows.length === 0) {
        formattedText += `No flows found${category ? ` in category "${category}"` : ''}.\n\n`;
        formattedText += `Flows are step-by-step how-to guides. Currently the knowledge base has mostly fixes (error solutions).\n`;
      } else {
        formattedText += `**Total**: ${result.total_count} flow(s)`;
        if (category) {
          formattedText += ` in category "${category}"`;
        }
        formattedText += `\n\n`;

        if (result.categories.length > 0) {
          formattedText += `**Categories**: ${result.categories.join(', ')}\n\n`;
        }

        formattedText += `---\n\n`;

        result.flows.forEach((flow: any) => {
          const stepCount = flow.solutions?.length || 0;
          formattedText += `### ${flow.query}\n`;
          formattedText += `- **ID**: ${flow.id}\n`;
          formattedText += `- **Category**: ${flow.category}\n`;
          formattedText += `- **Steps**: ${stepCount}\n\n`;
        });
      }

      formattedText += `---\n`;
      formattedText += `*Use \`get_flow(flow_id)\` to see full instructions for a specific flow*\n`;

      return {
        content: [{ type: 'text', text: formattedText }],
      };
    } catch (error) {
      throw new McpError(
        ErrorCode.InternalError,
        `Failed to list flows: ${error instanceof Error ? error.message : String(error)}`
      );
    }
  }

  // Handle get_flow tool
  if (toolName === 'get_flow') {
    const flowId = request.params.arguments?.flow_id as number;
    if (!flowId) {
      throw new McpError(ErrorCode.InvalidParams, 'flow_id is required');
    }

    try {
      const result = await callEdgeFunction('flows', { action: 'get', flow_id: flowId });

      if (!result.flow) {
        return {
          content: [{ type: 'text', text: `❌ Flow not found with ID: ${flowId}` }],
        };
      }

      const flow = result.flow;
      let formattedText = `## 📘 Flow: ${flow.query}\n\n`;
      formattedText += `**ID**: ${flow.id}\n`;
      formattedText += `**Category**: ${flow.category}\n\n`;

      formattedText += `### 📋 Steps:\n\n`;
      flow.solutions.forEach((step: any, idx: number) => {
        formattedText += `**Step ${idx + 1}: ${step.solution}**\n`;
        if (step.command) formattedText += `\`\`\`bash\n${step.command}\n\`\`\`\n`;
        if (step.note) formattedText += `*Note*: ${step.note}\n`;
        formattedText += '\n';
      });

      if (flow.common_pitfalls) {
        formattedText += `### ⚠️ Common Pitfalls:\n${flow.common_pitfalls}\n\n`;
      }

      return {
        content: [{ type: 'text', text: formattedText }],
      };
    } catch (error) {
      throw new McpError(
        ErrorCode.InternalError,
        `Failed to get flow: ${error instanceof Error ? error.message : String(error)}`
      );
    }
  }

  // Handle list_skills tool
  if (toolName === 'list_skills') {
    const category = request.params.arguments?.category as string | undefined;

    try {
      const result = await callEdgeFunction('flows', {
        action: 'list',
        category: category || null,
        type: 'skill'
      });

      if (!result.flows || result.flows.length === 0) {
        return {
          content: [{ type: 'text', text: category
            ? `No skills found in category: ${category}`
            : 'No skills found in the knowledge base yet.'
          }],
        };
      }

      let formattedText = `## 🛠️ Available Skills${category ? ` (${category})` : ''}\n\n`;
      formattedText += `Found ${result.flows.length} skill(s):\n\n`;

      result.flows.forEach((skill: any) => {
        formattedText += `- **${skill.query}** (ID: ${skill.id}) - ${skill.category}\n`;
      });

      formattedText += `\n*Use \`get_skill(skill_id)\` to get full execution details for a specific skill*\n`;

      return {
        content: [{ type: 'text', text: formattedText }],
      };
    } catch (error) {
      throw new McpError(
        ErrorCode.InternalError,
        `Failed to list skills: ${error instanceof Error ? error.message : String(error)}`
      );
    }
  }

  // Handle get_skill tool - returns raw JSON for AI execution
  if (toolName === 'get_skill') {
    const skillId = request.params.arguments?.skill_id as number;
    if (!skillId) {
      throw new McpError(ErrorCode.InvalidParams, 'skill_id is required');
    }

    try {
      const result = await callEdgeFunction('flows', { action: 'get', flow_id: skillId, type: 'skill' });

      if (!result.flow) {
        return {
          content: [{ type: 'text', text: `❌ Skill not found with ID: ${skillId}` }],
        };
      }

      const skill = result.flow;

      // Return raw JSON for AI consumption
      const skillData: any = {
        id: skill.id,
        name: skill.query,
        category: skill.category,
        type: 'skill',
        executable_type: skill.executable_type || 'steps',
        steps: skill.solutions,
        prerequisites: skill.prerequisites || null,
        common_pitfalls: skill.common_pitfalls || null,
        success_indicators: skill.success_indicators || null,
      };

      // Include executable scripts if present
      if (skill.executable) {
        skillData.executable = skill.executable;
        skillData.preview_summary = skill.preview_summary || null;
      }

      let output = `## 🛠️ Skill: ${skill.query}\n\n`;

      // If this is an executable script skill, show confirmation prompt
      if (skill.executable_type === 'script' && skill.executable) {
        output += `### ⚡ Executable Skill\n\n`;
        output += `**What this does:**\n${skill.preview_summary || 'Runs a script on your system'}\n\n`;
        output += `**Platforms available:** ${Object.keys(skill.executable).join(', ')}\n\n`;
        output += `---\n\n`;
        output += `**🔒 Confirmation Required**\n\n`;
        output += `Before running, ask the user: **"Run this skill? (yes / show script / no)"**\n\n`;
        output += `- **yes** → Execute the script for their platform\n`;
        output += `- **show script** → Display the full script code below, then ask again\n`;
        output += `- **no** → Don't run it\n\n`;
        output += `---\n\n`;
      }

      output += `**Execution Data (JSON):**\n\`\`\`json\n${JSON.stringify(skillData, null, 2)}\n\`\`\`\n\n`;

      if (skill.executable_type !== 'script') {
        output += `### How to use this skill:\n`;
        output += `- **CLI AIs** (Claude Code, Cursor, etc.): Use the \`cli\` commands for your platform (macos/linux/windows)\n`;
        output += `- **Web AIs** (ChatGPT, Gemini, etc.): Follow the \`manual\` instructions and guide the user\n`;
      }

      return {
        content: [{ type: 'text', text: output }],
      };
    } catch (error) {
      throw new McpError(
        ErrorCode.InternalError,
        `Failed to get skill: ${error instanceof Error ? error.message : String(error)}`
      );
    }
  }

  // Handle contribute_solution tool
  if (toolName === 'contribute_solution') {
    const args = request.params.arguments as any;

    // Validate required fields
    const required = ['query', 'category', 'solutions', 'prerequisites', 'success_indicators'];
    for (const field of required) {
      if (!args[field]) {
        throw new McpError(ErrorCode.InvalidParams, `${field} is required`);
      }
    }

    try {
      const result = await callEdgeFunction('contribute', args);

      const formattedText = `# Contribution Submitted ✅\n\n` +
        `**Status**: ${result.status}\n` +
        `**Contribution ID**: ${result.contribution_id}\n` +
        `**Estimated Review Time**: ${result.estimated_review_time}\n\n` +
        `${result.message}\n\n` +
        `---\n` +
        `Thank you for helping the clauderepo community! 🎉`;

      return {
        content: [
          {
            type: 'text',
            text: formattedText,
          },
        ],
      };
    } catch (error) {
      if (error instanceof McpError) {
        throw error;
      }
      throw new McpError(
        ErrorCode.InternalError,
        `Contribution failed: ${error instanceof Error ? error.message : String(error)}`
      );
    }
  }

  // Handle report_solution_outcome tool
  if (toolName === 'report_solution_outcome') {
    const args = request.params.arguments as any;

    if (!args.outcome) {
      throw new McpError(ErrorCode.InvalidParams, 'outcome is required');
    }

    if (!args.solution_id && !args.solution_query && !args.pending_id) {
      throw new McpError(ErrorCode.InvalidParams, 'solution_id, solution_query, or pending_id is required');
    }

    try {
      const trackingCalls: Promise<any>[] = [];

      // Build tracking payload - prefer pending_id > solution_id > solution_query
      const trackPayload: any = {};
      if (args.pending_id) {
        trackPayload.pending_id = args.pending_id;
      } else if (args.solution_id) {
        trackPayload.solution_id = args.solution_id;
      } else {
        trackPayload.solution_query = args.solution_query;
      }

      // Track thumbs up/down
      if (args.outcome === 'success') {
        trackingCalls.push(
          callEdgeFunction('track', {
            event_type: 'solution_success',
            ...trackPayload
          })
        );
      } else if (args.outcome === 'failure') {
        trackingCalls.push(
          callEdgeFunction('track', {
            event_type: 'solution_failure',
            ...trackPayload
          })
        );
        // Also track repeat search for failures
        trackingCalls.push(
          callEdgeFunction('track', {
            event_type: 'repeat_search',
            ...trackPayload
          })
        );
      }

      // Track command copy if specified
      if (args.copied_command) {
        trackingCalls.push(
          callEdgeFunction('track', {
            event_type: 'command_copy',
            ...trackPayload
          })
        );
      }

      // Execute tracking calls
      const results = await Promise.all(trackingCalls);

      const outcomeEmoji = args.outcome === 'success' ? '✅' : '❌';

      // Check if pending solution was approved
      const pendingApproved = results.some(r => r?.pending_approved);
      const kbEntryId = results.find(r => r?.knowledge_entry_id)?.knowledge_entry_id;

      let outcomeMessage: string;
      let solutionRef: string;

      if (args.pending_id && args.outcome === 'success') {
        outcomeMessage = pendingApproved
          ? `Solution approved and added to knowledge base! (Entry #${kbEntryId})`
          : 'Pending solution confirmation recorded.';
        solutionRef = `Pending #${args.pending_id}`;
      } else if (args.outcome === 'success') {
        outcomeMessage = 'Thanks for confirming this solution worked!';
        solutionRef = args.solution_id ? `ID #${args.solution_id}` : args.solution_query;
      } else {
        outcomeMessage = 'Sorry this didn\'t work. We\'ve noted this to improve our rankings.';
        solutionRef = args.solution_id ? `ID #${args.solution_id}` : (args.solution_query || `Pending #${args.pending_id}`);
      }

      const formattedText = `# Feedback Recorded ${outcomeEmoji}\n\n` +
        `**Solution**: ${solutionRef}\n` +
        `**Outcome**: ${args.outcome}\n\n` +
        `${outcomeMessage}\n\n` +
        `This feedback helps improve solution quality for the community. 🙏`;

      return {
        content: [
          {
            type: 'text',
            text: formattedText,
          },
        ],
      };
    } catch (error) {
      throw new McpError(
        ErrorCode.InternalError,
        `Feedback tracking failed: ${error instanceof Error ? error.message : String(error)}`
      );
    }
  }

  // Handle update_ticket_steps tool
  if (toolName === 'update_ticket_steps') {
    const args = request.params.arguments as any;

    if (!args.ticket_id || !args.step || !args.result) {
      throw new McpError(ErrorCode.InvalidParams, 'ticket_id, step, and result are required');
    }

    try {
      await callEdgeFunction('ticket', {
        action: 'update',
        ticket_id: args.ticket_id,
        step: args.step,
        result: args.result
      });

      const formattedText = `# Step Recorded ✅\n\n` +
        `**Ticket**: ${args.ticket_id}\n` +
        `**Step**: ${args.step}\n` +
        `**Result**: ${args.result}\n\n` +
        `Progress tracked. Let's continue with the next step.`;

      return {
        content: [
          {
            type: 'text',
            text: formattedText,
          },
        ],
      };
    } catch (error) {
      if (error instanceof McpError) {
        throw error;
      }
      throw new McpError(
        ErrorCode.InternalError,
        `Failed to update ticket: ${error instanceof Error ? error.message : String(error)}`
      );
    }
  }

  // Handle resolve_ticket tool
  if (toolName === 'resolve_ticket') {
    const args = request.params.arguments as any;

    if (!args.ticket_id || !args.solution_data) {
      throw new McpError(ErrorCode.InvalidParams, 'ticket_id and solution_data are required');
    }

    try {
      const result = await callEdgeFunction('ticket', {
        action: 'resolve',
        ticket_id: args.ticket_id,
        solution_data: args.solution_data
      });

      const formattedText = `# 🎫 Ticket Resolved - Solution Queued for Verification\n\n` +
        `**Ticket**: ${args.ticket_id}\n` +
        `**Pending ID**: ${result.pending_id}\n\n` +
        `${result.message}\n\n` +
        `---\n\n` +
        `### Next Steps:\n` +
        `1. **Test the fix** - Make sure it actually works\n` +
        `2. **Say "clauderepo: worked"** - This verifies the solution\n` +
        `3. **Or wait for admin review** - We'll review pending solutions\n\n` +
        `Once verified, the solution will be added to the main knowledge base.\n\n` +
        `*Why verification?* This ensures we only add proven solutions. 🔒`;

      return {
        content: [
          {
            type: 'text',
            text: formattedText,
          },
        ],
      };
    } catch (error) {
      if (error instanceof McpError) {
        throw error;
      }
      throw new McpError(
        ErrorCode.InternalError,
        `Failed to resolve ticket: ${error instanceof Error ? error.message : String(error)}`
      );
    }
  }

  // ADMIN TOOL HANDLERS REMOVED FROM PUBLIC NPM PACKAGE
  // list_pending_solutions and approve_pending_solution are in index-admin.ts

  // Unknown tool
  throw new McpError(
    ErrorCode.MethodNotFound,
    `Unknown tool: ${toolName}`
  );
});

// ============================================================================
// Start Server
// ============================================================================

async function main() {
  const transport = new StdioServerTransport();
  await server.connect(transport);
  console.error('✅ clauderepo MCP server running (Supabase edition)');
  console.error(`📡 Connected to: ${SUPABASE_URL}`);
}

main().catch((error) => {
  console.error('❌ Server error:', error);
  process.exit(1);
});
