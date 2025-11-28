INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Research Skill - Comprehensive research, analysis, and content extraction system',
  'claude-code',
  'skill',
  '[{"solution": "Multi-source parallel research using researcher agents", "note": "Supports Perplexity, Gemini, and Claude researcher types. Use quick (1 agent/type, 2min timeout), standard (3 agents/type, 3min timeout), or extensive (8 agents/type, 10min timeout) modes."}, {"solution": "Intelligent content retrieval with three-layer escalation", "note": "Layer 1: WebFetch/WebSearch (free), Layer 2: BrightData for CAPTCHA (paid), Layer 3: Apify scrapers (paid). Always try simplest approach first."}, {"solution": "Fabric pattern selection from 242+ patterns", "note": "Auto-select patterns for threat modeling, summarization, wisdom extraction, analysis, content creation, and improvement workflows."}, {"solution": "Workflow routing based on user intent", "note": "Auto-route to appropriate workflow: claude-research, perplexity-research, interview-research, retrieve, youtube-extraction, web-scraping, fabric, enhance, extract-knowledge"}]'::jsonb,
  'steps',
  'Optional API keys in ~/.env: PERPLEXITY_API_KEY, GOOGLE_API_KEY, BRIGHTDATA_API_KEY. Works without API keys using built-in WebSearch.',
  'Trying paid services before free alternatives, not following timeout rules (2/3/10 min hard stops), sequential execution instead of parallel launches, not using SINGLE Task message for all agents',
  'Research completed with synthesis report, sources attributed correctly, confidence levels assigned, research metrics calculated (queries, services, output size, confidence %)',
  'Parallel multi-source research with auto-routing to appropriate workflow based on user intent and available researcher agents',
  'https://skillsmp.com/skills/danielmiessler-personal-ai-infrastructure-claude-skills-research-skill-md',
  'admin:HAIKU_SKILL_1764290427_67628'
);
