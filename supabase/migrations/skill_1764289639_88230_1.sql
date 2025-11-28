INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Prompt Engineering Patterns - Master advanced prompt engineering techniques for production LLM applications',
  'claude-code',
  'skill',
  '[{"solution": "Few-Shot Learning with semantic similarity", "cli": {"macos": "python -m sentence_transformers", "linux": "python -m sentence_transformers", "windows": "python -m sentence_transformers"}, "note": "Adjust k value based on context window constraints"}, {"solution": "Chain-of-Thought Prompting with zero-shot trigger", "cli": {"macos": "echo \"Let''s think step by step:\" >> prompt.txt", "linux": "echo \"Let''s think step by step:\" >> prompt.txt", "windows": "echo \"Let''s think step by step:\" >> prompt.txt"}, "note": "Works on modern models; older models may need few-shot examples"}, {"solution": "Self-Consistency with temperature=0.7 and majority voting", "cli": {"macos": "python3 -c \"temps=[0.7]*5\"", "linux": "python3 -c \"temps=[0.7]*5\"", "windows": "python3 -c \"temps=[0.7]*5\""}, "note": "Increases latency by 5x but improves accuracy"}, {"solution": "Iterative prompt optimization with A/B testing", "cli": {"macos": "diff prompt_v1.txt prompt_v2.txt", "linux": "diff prompt_v1.txt prompt_v2.txt", "windows": "fc prompt_v1.txt prompt_v2.txt"}, "note": "Track all variations in version control"}]'::jsonb,
  'script',
  'Python 3.8+, sentence-transformers library, API key',
  'Over-engineering before testing simple prompts; using examples that do not match target task; exceeding token limits; ambiguous instructions; not testing edge cases',
  'Consistent results across runs; correct output format; accuracy improves each iteration; token usage within budget',
  'Master few-shot learning, chain-of-thought reasoning, prompt optimization, and template systems',
  'https://skillsmp.com/skills/wshobson-agents-plugins-llm-application-dev-skills-prompt-engineering-patterns-skill-md',
  'admin:HAIKU_SKILL_1764289639_88230'
);
