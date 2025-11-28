INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'neo4j-cypher-guide - Comprehensive guide for writing modern Neo4j Cypher read queries',
  'claude-code',
  'skill',
  '[{"solution": "Use modern Cypher syntax patterns", "manual": "1. Avoid deprecated features: id() function, implicit grouping, pattern expressions for lists, repeated relationship variables, automatic list coercion\n2. Replace id() with elementId() which returns a string\n3. Use explicit WITH clauses instead of implicit grouping\n4. Filter NULL values before sorting with IS NOT NULL or NULLS LAST\n5. Use modern patterns: QPP for complex traversals, CALL subqueries for reads, COUNT{} instead of size()\n6. For variable-length paths, consider Quantified Path Patterns (QPP)\n7. Use COLLECT{}, COUNT{}, EXISTS{} subqueries for aggregations", "note": "Always filter NULL values when sorting to avoid unexpected results"}]'::jsonb,
  'steps',
  'Neo4j database connection',
  'Using id() instead of elementId(), implicit grouping without WITH, not filtering nulls before sorting, mixing aggregating and non-aggregating expressions, repeated relationship variables',
  'Queries execute without deprecated syntax errors, return expected results with proper NULL handling',
  'Modern Cypher query patterns avoiding deprecated syntax with QPP and subqueries',
  'https://skillsmp.com/skills/tomasonjo-blogs-claude-skills-neo4j-cypher-guide-neo4j-cypher-guide-skill-md',
  'admin:HAIKU_SKILL_1764290184_36261'
);
