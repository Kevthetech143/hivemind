INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Performance Analysis Skill - Comprehensive bottleneck detection, performance profiling, and optimization recommendations for Claude Flow swarms',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Detect performance bottlenecks",
      "cli": {
        "macos": "npx claude-flow bottleneck detect",
        "linux": "npx claude-flow bottleneck detect",
        "windows": "npx claude-flow bottleneck detect"
      },
      "note": "Analyzes communication, processing, memory, and network bottlenecks"
    },
    {
      "solution": "Generate performance report",
      "cli": {
        "macos": "npx claude-flow analysis performance-report --format html --include-metrics",
        "linux": "npx claude-flow analysis performance-report --format html --include-metrics",
        "windows": "npx claude-flow analysis performance-report --format html --include-metrics"
      },
      "note": "Available formats: json, html, markdown"
    },
    {
      "solution": "Analyze with automatic fixes",
      "cli": {
        "macos": "npx claude-flow bottleneck detect --fix --threshold 15",
        "linux": "npx claude-flow bottleneck detect --fix --threshold 15",
        "windows": "npx claude-flow bottleneck detect --fix --threshold 15"
      },
      "note": "Applies topology optimization, caching enhancement, concurrency tuning, priority adjustment, and resource optimization"
    },
    {
      "solution": "Monitor performance in real-time",
      "cli": {
        "macos": "npx claude-flow swarm monitor --interval 5",
        "linux": "npx claude-flow swarm monitor --interval 5",
        "windows": "npx claude-flow swarm monitor --interval 5"
      },
      "note": "Continuously monitors swarm operations and alerts on critical issues"
    }
  ]'::jsonb,
  'script',
  'Node.js with claude-flow CLI installed',
  'Starting with threshold too high (default 20%), not analyzing sufficient time range, not providing context when reporting, not reviewing automatic fixes before applying, ignoring cache hit rate metrics',
  'Bottleneck detection identifies critical issues (>20% impact), performance report shows improvement trends, auto-fixes apply successfully without errors, metrics show 25-45% total performance improvement',
  'Identify performance bottlenecks, generate detailed reports, apply optimization recommendations for Claude Flow swarms',
  'https://skillsmp.com/skills/ruvnet-claude-flow-claude-skills-performance-analysis-skill-md',
  'admin:HAIKU_SKILL_1764290210_38888'
);
