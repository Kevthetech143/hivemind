-- Email Composer Skill
INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Email Composer - Draft professional emails for business and customer communication',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Choose email type and structure",
      "manual": "Select appropriate email type (request, follow-up, announcement, etc.). Use standard professional format with greeting, opening, body, and closing. Include specific subject line.",
      "note": "Always use clear, specific subject lines and organize body with bullet points for multiple items"
    },
    {
      "solution": "Apply tone guidelines",
      "manual": "Match tone to audience: formal (complete sentences, no contractions, professional language) for executives/clients; casual (contractions acceptable, conversational) for colleagues; urgent (clear deadline, bold key points, direct call to action) for critical communications.",
      "note": "Avoid ALL CAPS, excessive exclamation marks, or marking everything as urgent"
    },
    {
      "solution": "Follow email composition checklist",
      "manual": "Verify: clear subject line, appropriate greeting, upfront purpose statement, organized key points with bullets, clear call to action, appropriate tone, proper proofreading, attachments included if mentioned, correct recipients, professional signature.",
      "note": "Poor subject lines kill email effectiveness - avoid vague titles like ''Update'' or ''Question''"
    }
  ]'::jsonb,
  'steps',
  'Basic understanding of email communication; recipient context (colleague, customer, manager, vendor)',
  'Using vague subject lines like ''Update''; writing in past tense instead of imperative; forgetting to explain WHY in addition to WHAT; over-using urgent markers; mixing unrelated topics in single email',
  'Email is well-organized, uses appropriate tone, has clear subject line, includes specific action items or requests, and follows professional format',
  'Generate professional emails for any business context with clear structure and appropriate tone',
  'https://skillsmp.com/skills/davila7-claude-code-templates-cli-tool-components-skills-enterprise-communication-email-composer-skill-md',
  'admin:HAIKU_SKILL_1764290120_31772'
);
