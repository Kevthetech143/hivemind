INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'LabArchive Integration - Connecting to LabArchive ELN API for scientific data',
  'claude-code',
  'skill',
  '[{"solution": "Authenticate with LabArchive API and manage experiments", "cli": {"macos": "pip install labarchive-api && python -c \"from labarchive import Client\"", "linux": "pip install labarchive-api && python -c \"from labarchive import Client\"", "windows": "pip install labarchive-api && python -c \"from labarchive import Client\""}, "manual": "Use LabArchive API to manage electronic lab notebooks. Authenticate with API credentials. Create and retrieve experiments. Manage samples and data files. Upload attachments. Query experiment metadata. Handle pagination for large result sets. Implement retry logic for network calls. Cache authentication tokens. Manage rate limits. Handle errors gracefully. Maintain audit trail for compliance.", "note": "Always use environment variables for API credentials. Implement proper error handling for network failures. Test API connectivity before operations."}]'::jsonb,
  'script',
  'Python 3.7+, LabArchive API client installed, API credentials',
  'Hardcoding API credentials. No error handling for API failures. Ignoring rate limits. No retry logic. Poor pagination handling. Broken authentication token refresh. No audit logging. Missing request/response validation. Inadequate error messages. Not handling network timeouts.',
  'API authentication succeeds. Experiments retrieved/created successfully. Pagination works correctly. Errors handled gracefully. Rate limits respected. Tokens refresh properly. Audit trail maintained.',
  'LabArchive electronic lab notebook API integration and data management',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-labarchive-integration-skill-md',
  'admin:HAIKU_SKILL_1764290199_37706'
);
