INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'EdgarTools - Query and analyze SEC filings and financial statements',
  'claude-code',
  'skill',
  '[{"solution": "Use EdgarTools Python API", "cli": {"macos": "python3 -c \"from edgar import set_identity, Company; set_identity(''Name email@com''); c = Company(''AAPL''); print(c.to_context())\"", "linux": "python3 -c \"from edgar import set_identity, Company; set_identity(''Name email@com''); c = Company(''AAPL''); print(c.to_context())\"", "windows": "python -c \"from edgar import set_identity, Company; set_identity(''Name email@com''); c = Company(''AAPL''); print(c.to_context())\""}, "manual": "1. Set identity first: set_identity(''Name email@com'') - SEC requirement\n2. Get company: Company(''TICKER'')\n3. Use .to_context() for token efficiency (~88 tokens vs 200+ for full object)\n4. Get filings: company.get_filings(form=''10-K'')\n5. Get financials via Entity Facts (fast): company.income_statement(periods=3)\n6. Get financials via XBRL (detailed): filing.xbrl().statements.income_statement()\n7. Search filing content: filing.search(''keyword'')\n8. Use .filter() on results for efficient filtering", "note": "Always call .to_context() first - 5-10x more token efficient than full objects"}]'::jsonb,
  'script',
  'Python 3.7+, edgartools package, SEC identity credentials',
  'Forgetting set_identity() call causing errors, not using .to_context() leading to excessive tokens, confusing filing.search() with filing.docs.search(), not filtering nulls before sorting financials',
  'Code executes, returns company data and financial statements with proper error handling',
  'Query SEC filings with EdgarTools using token-efficient API patterns',
  'https://skillsmp.com/skills/dgunning-edgartools-edgar-ai-skills-core-skill-md',
  'admin:HAIKU_SKILL_1764290184_36261'
);
