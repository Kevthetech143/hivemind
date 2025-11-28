INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Fabric Skill - Intelligent pattern selection from 242+ specialized prompts',
  'claude-code',
  'skill',
  '[{"solution": "Auto-select Fabric patterns based on intent", "note": "Threat modeling (create_threat_model, create_stride_threat_model), summarization (summarize, create_5_sentence_summary, youtube_summary), wisdom extraction (extract_wisdom, extract_insights), analysis (analyze_claims, analyze_code, analyze_logs), content creation (create_prd, create_design_document), improvement (improve_writing, review_code)"}, {"solution": "Execute Fabric CLI with selected pattern", "cli": {"macos": "fabric -p [pattern] < input.txt", "linux": "fabric -p [pattern] < input.txt", "windows": "fabric -p [pattern] < input.txt"}, "note": "From URL: fabric -u ''URL'' -p [pattern], From YouTube: fabric -y ''YOUTUBE_URL'' -p [pattern]"}, {"solution": "Pattern repository management", "note": "Requires Fabric repo clone at ~/.claude/skills/fabric/fabric-repo. Check availability and clone if missing."}]'::jsonb,
  'script',
  'Fabric CLI installed (npm install -g fabric-cli), Fabric repository cloned at ~/.claude/skills/fabric/fabric-repo',
  'Selecting wrong pattern for intent, not checking if Fabric repo exists before proceeding, using outdated pattern names, not following proper Fabric syntax (-p for pattern, -u for URL, -y for YouTube)',
  'Pattern selected correctly for stated intent, Fabric CLI executes without errors, output generated matches expected format for pattern type',
  'Pattern selection and execution from 242+ Fabric patterns for threat modeling, analysis, summarization, and content creation',
  'https://skillsmp.com/skills/danielmiessler-personal-ai-infrastructure-claude-skills-fabric-skill-md',
  'admin:HAIKU_SKILL_1764290427_67628'
);
