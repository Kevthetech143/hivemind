INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'ReasoningBank Intelligence - Implement adaptive learning with ReasoningBank for pattern recognition and strategy optimization',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Initialize ReasoningBank with persistence",
      "manual": "const rb = new ReasoningBank({persist: true, learningRate: 0.1, adapter: ''agentdb''});",
      "note": "Requires agentic-flow v1.5.11+ and AgentDB v1.0.4+"
    },
    {
      "solution": "Record task outcomes for learning",
      "manual": "await rb.recordExperience({task: ''code_review'', approach: ''static_analysis_first'', outcome: {...}, context: {...}});",
      "note": "Include metrics and context for better pattern recognition"
    },
    {
      "solution": "Get optimal strategy recommendations",
      "manual": "const strategy = await rb.recommendStrategy(''code_review'', {language: ''typescript'', complexity: ''high''});",
      "note": "Strategy selection improves over time with more experiences"
    },
    {
      "solution": "Enable continuous auto-learning",
      "manual": "await rb.enableAutoLearning({threshold: 0.7, updateFrequency: 100});",
      "note": "Automatically learns from all tasks meeting confidence threshold"
    }
  ]'::jsonb,
  'steps',
  'agentic-flow v1.5.11+, AgentDB v1.0.4+, Node.js 18+',
  'Not recording outcomes consistently, insufficient training data (need 100+ experiences per task), not providing rich context, poor pattern matching due to missing vector indexing',
  'Patterns learned increase over time, strategy success rate improves, recommendations become more accurate',
  'Adaptive learning system for AI agents with pattern recognition and meta-cognitive capabilities',
  'https://skillsmp.com/skills/ruvnet-claude-flow-claude-skills-reasoningbank-intelligence-skill-md',
  'admin:HAIKU_SKILL_1764290210_38888'
);
