-- Excel Analysis Skill
INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Excel Analysis - Analyze spreadsheets, create pivot tables, generate charts, and perform data analysis',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Read and explore Excel files",
      "cli": {
        "macos": "python -c \"import pandas as pd; df = pd.read_excel(''data.xlsx''); print(df.head()); print(df.describe())\"",
        "linux": "python -c \"import pandas as pd; df = pd.read_excel(''data.xlsx''); print(df.head()); print(df.describe())\"",
        "windows": "python -c \"import pandas as pd; df = pd.read_excel(''data.xlsx''); print(df.head()); print(df.describe())\""
      },
      "note": "Use head() to preview data, describe() for statistics, info() for column types and nulls"
    },
    {
      "solution": "Process multiple sheets in workbook",
      "manual": "Use ExcelFile to iterate through sheet names. Read each sheet with pd.read_excel(file, sheet_name=name). Handle different structures across sheets with conditional logic. Combine sheets with pd.concat() when consolidating data.",
      "note": "Different sheets may have different column names and structures - inspect each before processing"
    },
    {
      "solution": "Clean and prepare data",
      "manual": "Remove duplicates with drop_duplicates(). Handle nulls with fillna() or dropna(). Strip whitespace from text: df[''col''].str.strip(). Convert types with to_datetime() and to_numeric(). Validate conversions with errors=''coerce'' to convert invalid to NaN.",
      "note": "Data cleaning is 80% of analysis work - validate assumptions about data format and content"
    },
    {
      "solution": "Perform data analysis and aggregation",
      "manual": "Use groupby() for aggregations: df.groupby(''region'')[''sales''].sum(). Filter with boolean indexing: df[df[''sales''] > 10000]. Create calculated columns: df[''margin''] = (df[''revenue''] - df[''cost'']) / df[''revenue'']. Sort with sort_values(). Merge files with pd.merge().",
      "note": "Always validate calculations on small datasets first before applying to entire workbook"
    },
    {
      "solution": "Create pivot tables",
      "manual": "Use pd.pivot_table() with values (column to aggregate), index (rows), columns (columns), aggfunc (sum/mean/count), fill_value for missing data. Save to Excel with to_excel(). Use margins=True to include totals.",
      "note": "Pivot tables excellent for summarizing large datasets - choose appropriate aggregation function"
    },
    {
      "solution": "Generate charts and visualizations",
      "manual": "Use pandas plot() method with kind parameter: bar, line, pie, scatter. Set title, labels with matplotlib. Save with savefig(). For Excel charts, use openpyxl to create embedded charts within workbook.",
      "note": "Always set proper axis labels and titles for clarity - charts without context are misleading"
    },
    {
      "solution": "Write formatted Excel files",
      "manual": "Use pd.ExcelWriter with openpyxl engine for formatting control. Apply fonts, fills, borders after writing data. Auto-adjust column widths by calculating max string length. Apply conditional formatting with PatternFill for visual indicators.",
      "note": "Formatting improves readability and professionalism - bold headers, color-code values, right-align numbers"
    }
  ]'::jsonb,
  'script',
  'Python 3.6+; pandas, openpyxl, matplotlib libraries; Excel files; understanding of basic data concepts',
  'Not validating data types before operations (str vs numeric); forgetting to handle null values causing calculation errors; using wrong aggregation function (sum vs mean vs count); not checking column names for typos; memory issues with very large files (use chunksize parameter); applying formattin before saving causing data loss',
  'Excel file reads successfully, data types correct, aggregations calculate accurately, pivot tables summarize correctly, charts display proper data, output file opens without errors and shows formatting',
  'Analyze Excel spreadsheets with pandas, create pivot tables, generate charts, and perform comprehensive data analysis',
  'https://skillsmp.com/skills/davila7-claude-code-templates-cli-tool-components-skills-enterprise-communication-excel-analysis-skill-md',
  'admin:HAIKU_SKILL_1764290120_31772'
);
