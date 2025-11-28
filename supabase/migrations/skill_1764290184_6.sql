INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'doc-review - Documentation review for factual accuracy',
  'claude-code',
  'skill',
  '[{"solution": "Review documentation systematically", "manual": "1. Read the documentation thoroughly\n2. Verify all claims about toolhive functionality are accurate\n3. Check all examples for formatting, typos, and accuracy\n4. Validate all links point to existing files with matching content\n5. For flow diagrams, launch @agent-toolhive-expert to verify system works as shown\n6. For command-line examples, launch agent to check arguments and options\n7. For Kubernetes manifests, verify alignment with CRDs\n8. Present findings as todo list without inline change suggestions", "note": "Be proactive in launching agents - when documentation makes claims, have an expert fact-check them"}]'::jsonb,
  'steps',
  'Documentation file to review, access to toolhive codebase',
  'Making inline change suggestions instead of presenting findings, not launching agents for fact-checking diagrams and examples, not validating all links',
  'All claims verified accurate, examples checked for correctness, links validated, findings documented in todo list format',
  'Review toolhive documentation for factual accuracy with systematic fact-checking',
  'https://skillsmp.com/skills/stacklok-toolhive-claude-skills-doc-review-skill-md',
  'admin:HAIKU_SKILL_1764290184_36261'
);
