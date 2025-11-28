INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'AgentDB Memory Patterns - Implement persistent memory for AI agents with session memory, long-term storage, and pattern learning',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Initialize AgentDB Database",
      "cli": {
        "macos": "npx agentdb@latest init ./agents.db",
        "linux": "npx agentdb@latest init ./agents.db",
        "windows": "npx agentdb@latest init ./agents.db"
      },
      "manual": "1. Ensure Node.js 18+ installed\n2. Run: npx agentdb@latest init ./agents.db\n3. Optional: Use --dimension 768 for custom dimensions\n4. Optional: Use --preset large for preset configurations\n5. For testing: Use --in-memory flag",
      "note": "Default creates persistent vector database. Use in-memory for testing purposes"
    },
    {
      "solution": "Add AgentDB MCP Server to Claude Code",
      "cli": {
        "macos": "claude mcp add agentdb npx agentdb@latest mcp",
        "linux": "claude mcp add agentdb npx agentdb@latest mcp",
        "windows": "claude mcp add agentdb npx agentdb@latest mcp"
      },
      "manual": "1. Run: npx agentdb@latest mcp to start server\n2. Add to Claude Code one-time: claude mcp add agentdb npx agentdb@latest mcp\n3. Verify integration with: mcp__agentdb__* commands",
      "note": "Once added, AgentDB MCP commands become available in Claude Code"
    },
    {
      "solution": "Store and Retrieve Session Memory",
      "cli": {
        "macos": "cat > agent.ts << ''AGENT''\nimport { createAgentDBAdapter } from ''agentic-flow/reasoningbank'';\nconst db = await createAgentDBAdapter({dbPath: ''.agentdb/reasoningbank.db'', enableLearning: true});\nawait db.insertPattern({id: '''', type: ''pattern'', domain: ''conversation'', pattern_data: JSON.stringify({user: ''msg'', assistant: ''response''}), confidence: 0.95});\nAGENT",
        "linux": "cat > agent.ts << ''AGENT''\nimport { createAgentDBAdapter } from ''agentic-flow/reasoningbank'';\nconst db = await createAgentDBAdapter({dbPath: ''.agentdb/reasoningbank.db'', enableLearning: true});\nawait db.insertPattern({id: '''', type: ''pattern'', domain: ''conversation'', pattern_data: JSON.stringify({user: ''msg'', assistant: ''response''}), confidence: 0.95});\nAGENT",
        "windows": "cat > agent.ts << ''AGENT''\nimport { createAgentDBAdapter } from ''agentic-flow/reasoningbank'';\nconst db = await createAgentDBAdapter({dbPath: ''.agentdb/reasoningbank.db'', enableLearning: true});\nawait db.insertPattern({id: '''', type: ''pattern'', domain: ''conversation'', pattern_data: JSON.stringify({user: ''msg'', assistant: ''response''}), confidence: 0.95});\nAGENT"
      },
      "manual": "1. Import createAgentDBAdapter from agentic-flow/reasoningbank\n2. Initialize with dbPath and enableLearning: true\n3. Use insertPattern to store message pairs\n4. Use retrieveWithReasoning to fetch context\n5. Set confidence scores (0-1) for each pattern",
      "note": "Session memory maintains context within current conversation. Enable reasoning for automatic context synthesis"
    },
    {
      "solution": "Create Learning Plugin",
      "cli": {
        "macos": "npx agentdb@latest create-plugin\nnpx agentdb@latest create-plugin -t decision-transformer -n my-agent",
        "linux": "npx agentdb@latest create-plugin\nnpx agentdb@latest create-plugin -t decision-transformer -n my-agent",
        "windows": "npx agentdb@latest create-plugin\nnpx agentdb@latest create-plugin -t decision-transformer -n my-agent"
      },
      "manual": "Choose from 9 learning algorithms:\n- decision-transformer (sequence modeling RL, recommended)\n- q-learning (value-based)\n- sarsa (on-policy TD)\n- actor-critic (policy gradient)\n- curiosity-driven (exploration)\nOthers: active-learning, adversarial, curriculum, federated, multi-task",
      "note": "Decision Transformer recommended for most use cases. Run interactive wizard with: npx agentdb@latest create-plugin"
    },
    {
      "solution": "Query Database with Vector Search",
      "cli": {
        "macos": "npx agentdb@latest query ./agents.db \"[0.1,0.2,0.3,...]\" -k 10 -t 0.75",
        "linux": "npx agentdb@latest query ./agents.db \"[0.1,0.2,0.3,...]\" -k 10 -t 0.75",
        "windows": "npx agentdb@latest query ./agents.db \"[0.1,0.2,0.3,...]\" -k 10 -t 0.75"
      },
      "manual": "1. Prepare vector embedding for query\n2. Run: npx agentdb@latest query <db-path> \"<embedding>\" \n3. Use -k for top-k results (default 10)\n4. Use -t for similarity threshold (0.0-1.0)\n5. Use -f json for JSON formatted output",
      "note": "HNSW indexing provides <100μs search performance. Enable caching for <1ms retrieval"
    },
    {
      "solution": "Export/Import and Backup Data",
      "cli": {
        "macos": "npx agentdb@latest export ./agents.db ./backup.json\nnpx agentdb@latest import ./backup.json ./agents.db",
        "linux": "npx agentdb@latest export ./agents.db ./backup.json\nnpx agentdb@latest import ./backup.json ./agents.db",
        "windows": "npx agentdb@latest export ./agents.db ./backup.json\nnpx agentdb@latest import ./backup.json ./agents.db"
      },
      "manual": "1. Export vectors: npx agentdb@latest export <db-path> <output-file>\n2. Import vectors: npx agentdb@latest import <input-file> <db-path>\n3. Check stats: npx agentdb@latest stats <db-path>\n4. Monitor performance benchmarks: npx agentdb@latest benchmark",
      "note": "Export useful for backup and migration. Stats shows size and performance metrics"
    }
  ]'::jsonb,
  'script',
  'Node.js 18+, AgentDB v1.0.7+, agentic-flow package, understanding of agent architectures',
  'Not enabling quantization (4-32x memory increase), ignoring HNSW indexing, storing embeddings without confidence scores, not batching operations, missing context synthesis',
  'Database initializes successfully, patterns stored with confidence scores, vector search <100μs, context retrieved with reasoning, learning plugins train without errors, 150-12500x performance improvement',
  'Implement persistent memory patterns for AI agents with session storage and pattern learning',
  'https://skillsmp.com/skills/ruvnet-claude-flow-claude-skills-agentdb-memory-patterns-skill-md',
  'admin:HAIKU_SKILL_1764290225_40761'
);
