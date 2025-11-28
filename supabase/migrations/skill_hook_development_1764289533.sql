INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Financial Statement Analysis - Calculate and interpret financial ratios for investment analysis',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Step 1: Prepare financial statement data",
      "manual": "Gather income statement, balance sheet, and cash flow data. Format as CSV, JSON, text, or Excel files with line items like revenue, net income, total assets, shareholders equity, and market data",
      "note": "Validate data completeness before calculations - missing values should be handled with industry averages or exclusions"
    },
    {
      "solution": "Step 2: Run the ratio calculator",
      "cli": {
        "macos": "python3 calculate_ratios.py",
        "linux": "python3 calculate_ratios.py",
        "windows": "python calculate_ratios.py"
      },
      "note": "FinancialRatioCalculator class initializes with financial_data dictionary containing income_statement, balance_sheet, cash_flow, and market_data"
    },
    {
      "solution": "Step 3: Calculate specific ratio categories",
      "cli": {
        "macos": "python3 -c \"from calculate_ratios import FinancialRatioCalculator; calc = FinancialRatioCalculator(data); calc.calculate_profitability_ratios()\"",
        "linux": "python3 -c \"from calculate_ratios import FinancialRatioCalculator; calc = FinancialRatioCalculator(data); calc.calculate_profitability_ratios()\"",
        "windows": "python -c \"from calculate_ratios import FinancialRatioCalculator; calc = FinancialRatioCalculator(data); calc.calculate_profitability_ratios()\""
      },
      "note": "Available ratio methods: calculate_profitability_ratios(), calculate_liquidity_ratios(), calculate_leverage_ratios(), calculate_efficiency_ratios(), calculate_valuation_ratios()"
    },
    {
      "solution": "Step 4: Interpret results and compare benchmarks",
      "cli": {
        "macos": "python3 interpret_ratios.py",
        "linux": "python3 interpret_ratios.py",
        "windows": "python interpret_ratios.py"
      },
      "note": "Provides industry benchmark comparisons, trend analysis across periods, and flagging of unusual or concerning ratios"
    }
  ]'::jsonb,
  'script',
  'Python 3.7+, understanding of financial statements and accounting basics, access to company financial data (10-K filings, quarterly reports, or financial databases)',
  'Using incomplete or inaccurate financial data, ignoring industry context when interpreting ratios, forgetting to validate data completeness, assuming historical patterns guarantee future performance, applying ratios without considering if they apply to the specific industry',
  'Calculated ratios match expected values for test cases, ratio values are within industry benchmarks or flagged appropriately, interpretation matches financial analysis standards, Excel report generated with formatted results',
  'Python module for calculating 30+ financial ratios from income statements, balance sheets, and cash flow data',
  'https://skillsmp.com/skills/anthropics-claude-cookbooks-skills-custom-skills-analyzing-financial-statements-skill-md',
  'admin:HAIKU_SKILL_1764289578_83128'
);
