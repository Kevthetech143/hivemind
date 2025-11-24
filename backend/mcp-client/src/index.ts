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
    version: '2.0.0',
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
          'Search the clauderepo knowledge base for troubleshooting solutions, error fixes, and best practices. ' +
          'Returns ranked solutions with success rates, prerequisites, validation steps, and related patterns. ' +
          'Covers MCP servers, Playwright automation, security patterns, and more.',
        inputSchema: {
          type: 'object',
          properties: {
            query: {
              type: 'string',
              description:
                'Error message, problem description, or technology to search for. ' +
                'Examples: "MCP connection refused", "playwright timeout", "API key leak prevention"',
            },
          },
          required: ['query'],
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
          'Extract the solution_query from the most recent search result you showed them.',
        inputSchema: {
          type: 'object',
          properties: {
            solution_query: {
              type: 'string',
              description: 'The exact query/problem title of the solution they tried (from the search results you just showed)',
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
          required: ['solution_query', 'outcome'],
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
          'Resolve a troubleshooting ticket and auto-contribute the solution to the knowledge base. ' +
          'Call this when the problem is solved. The solution will be automatically added to clauderepo.',
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
    if (!query) {
      throw new McpError(ErrorCode.InvalidParams, 'query parameter is required');
    }

    try {
      const result = await callEdgeFunction('search', { query });

      // Format response for Claude Code
      let formattedText = `# Search Results: "${query}"\n\n`;

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

        return {
          content: [
            {
              type: 'text',
              text: formattedText,
            },
          ],
        };
      }

      const { primary_solution, confidence, related_solutions, environment_checks, validation_steps, community_stats } = result;

      // Primary solution
      formattedText += `## 🎯 Primary Solution (${(confidence * 100).toFixed(0)}% confidence)\n\n`;
      formattedText += `**Problem**: ${primary_solution.query}\n`;
      formattedText += `**Category**: ${primary_solution.category}\n`;
      formattedText += `**Community Data**: ${community_stats.total_hits} users hit this (${(community_stats.success_rate * 100).toFixed(0)}% success rate)\n\n`;

      formattedText += `### 💡 Solutions (ranked by success rate):\n\n`;
      primary_solution.solutions.forEach((sol: any, idx: number) => {
        formattedText += `**${idx + 1}. ${sol.solution}** (${sol.percentage}% of users)\n`;
        if (sol.command) formattedText += `   \`\`\`bash\n   ${sol.command}\n   \`\`\`\n`;
        if (sol.example) formattedText += `   *Example*: ${sol.example}\n`;
        if (sol.note) formattedText += `   *Note*: ${sol.note}\n`;
        formattedText += '\n';
      });

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
      formattedText += `   This helps improve rankings for the community.\n`;

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

    if (!args.solution_query || !args.outcome) {
      throw new McpError(ErrorCode.InvalidParams, 'solution_query and outcome are required');
    }

    try {
      const trackingCalls: Promise<any>[] = [];

      // Track thumbs up/down
      if (args.outcome === 'success') {
        trackingCalls.push(
          callEdgeFunction('track', {
            event_type: 'solution_success',
            solution_query: args.solution_query
          })
        );
      } else if (args.outcome === 'failure') {
        trackingCalls.push(
          callEdgeFunction('track', {
            event_type: 'solution_failure',
            solution_query: args.solution_query
          })
        );
        // Also track repeat search for failures
        trackingCalls.push(
          callEdgeFunction('track', {
            event_type: 'repeat_search',
            solution_query: args.solution_query
          })
        );
      }

      // Track command copy if specified
      if (args.copied_command) {
        trackingCalls.push(
          callEdgeFunction('track', {
            event_type: 'command_copy',
            solution_query: args.solution_query
          })
        );
      }

      // Execute tracking calls
      await Promise.all(trackingCalls);

      const outcomeEmoji = args.outcome === 'success' ? '✅' : '❌';
      const outcomeMessage = args.outcome === 'success'
        ? 'Thanks for confirming this solution worked!'
        : 'Sorry this didn\'t work. We\'ve noted this to improve our rankings.';

      const formattedText = `# Feedback Recorded ${outcomeEmoji}\n\n` +
        `**Solution**: ${args.solution_query}\n` +
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

      const formattedText = `# 🎉 Ticket Resolved & Solution Added!\n\n` +
        `**Ticket**: ${args.ticket_id}\n` +
        `**Knowledge Entry ID**: ${result.knowledge_id}\n\n` +
        `${result.message}\n\n` +
        `---\n\n` +
        `✅ This solution is now searchable in clauderepo\n` +
        `✅ Future users with this problem will find your solution\n` +
        `✅ No moderation needed - ticket-based solutions are auto-approved\n\n` +
        `Thank you for helping grow the knowledge base! 🙏`;

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
