INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'clojure-review - Review Clojure code for style compliance and quality issues',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Check naming conventions and documentation standards",
      "manual": "Naming: Use descriptive names (no tbl, zs), pure functions as nouns, kebab-case everywhere, side-effect functions end with !, no namespace-alias repetition\nDocumentation: Public vars need docstrings, use Markdown in docstrings, references use [[other-var]] not backticks, TODO comments include author and date: ;; TODO (Name 1/1/25) -- description"
    },
    {
      "solution": "Verify code organization best practices",
      "manual": "1. Mark private functions with ^:private unless used elsewhere\n2. Place public functions near end instead of using declare\n3. Keep functions under 20 lines when possible\n4. No blank lines within definitions (except pairwise constructs in let/cond)\n5. Lines must be 120 characters or less"
    },
    {
      "solution": "Check test structure and organization",
      "manual": "1. Use separate deftest forms for distinct test cases\n2. Mark pure tests with ^:parallel annotation\n3. Test names must end in -test or -test-<number>\n4. Ensure all new functionality has tests"
    },
    {
      "solution": "Verify module and API patterns",
      "manual": "Modules: OSS uses metabase.<module>.*, EE uses metabase-enterprise.<module>.*\nAPI: Endpoints in <module>.api namespaces, public API in <module>.core with Potemkin, routes use singular nouns (/api/dashboard/:id not /dashboards/:id)\nQueries: Query params use kebab-case, body params use snake_case\nSchemas: Response schemas present, detailed Malli schemas, GET has no side effects except analytics"
    },
    {
      "solution": "Flag MBQL, database, and driver compliance issues",
      "manual": "MBQL: No raw manipulation outside lib/lib-be/query-processor modules, use Lib and MBQL 5 not legacy\nDatabase: Model/table names singular, use t2/select-one-fn instead of full row selection for one column\nDrivers: Document new multimethods, pass driver argument (no hardcoded names), minimal logic in read-column-thunk"
    },
    {
      "solution": "Format review feedback correctly",
      "manual": "Only post comments about actual style violations or issues. Do not congratulate on style compliance or trivial changes. Do not comment on missing parentheses (caught by linter). Use clear, specific feedback identifying the issue and suggesting the fix."
    }
  ]'::jsonb,
  'steps',
  'Metabase Clojure style guide, clojure-commands reference, ability to read/grep Clojure code, optional CLOJURE_STYLE_GUIDE.adoc from repo',
  'Not checking for unbalanced parentheses (caught by linter, skip), congratulating on style compliance, posting comments on trivial changes, missing author/date in TODO comments, not using kebab-case consistently, forgetting ^:private on internal functions, functions over 20 lines, API endpoints using plural nouns, snake_case in query parameters',
  'All style guide violations identified, functions properly named and organized, docstrings present for public vars, tests properly structured, modules follow correct patterns, no non-productive comments posted',
  'Code review guide for Clojure/ClojureScript checking style, naming, documentation, organization, tests, APIs, and module patterns',
  'https://skillsmp.com/skills/metabase-metabase-claude-skills-clojure-review-skill-md',
  'admin:HAIKU_SKILL_1764289228_76927'
);
