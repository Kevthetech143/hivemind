INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'XLSX Skill - Comprehensive spreadsheet creation, editing, and analysis with formulas and formatting',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Create Excel files with formulas and formatting using openpyxl",
      "cli": {
        "macos": "pip install openpyxl pandas",
        "linux": "pip install openpyxl pandas",
        "windows": "pip install openpyxl pandas"
      },
      "manual": "Install openpyxl for formula/formatting work and pandas for data analysis. openpyxl is 1-indexed (A1 = row=1, column=1). Always use formulas instead of hardcoding calculated values.",
      "note": "LibreOffice required for formula recalculation via recalc.py script"
    },
    {
      "solution": "Read and analyze spreadsheet data with pandas",
      "manual": "Use pd.read_excel(file) to load data. All sheets: pd.read_excel(file, sheet_name=None). Specify dtypes for accuracy: pd.read_excel(file, dtype={''id'': str}). Use parse_dates for dates, usecols for specific columns. Operations: df.head(), df.info(), df.describe() for analysis.",
      "note": "pandas is best for data analysis and bulk operations"
    },
    {
      "solution": "Create new Excel file with data and formulas",
      "manual": "1. from openpyxl import Workbook\n2. Create workbook: wb = Workbook()\n3. Get active sheet: sheet = wb.active\n4. Add data: sheet[''A1''] = ''value''\n5. Add formulas: sheet[''B2''] = ''=SUM(A1:A10)'' (use formulas, not hardcoded values)\n6. Format cells with Font, PatternFill, Alignment\n7. Set column widths: sheet.column_dimensions[''A''].width = 20\n8. Save: wb.save(''output.xlsx'')\n9. Recalculate: python recalc.py output.xlsx",
      "note": "Always use formulas for calculations. Hardcoding values breaks dynamic updates."
    },
    {
      "solution": "Edit existing Excel files while preserving formulas",
      "manual": "1. from openpyxl import load_workbook\n2. Load file: wb = load_workbook(''existing.xlsx'')\n3. Get sheet: sheet = wb.active OR wb[''SheetName'']\n4. Loop sheets: for sheet_name in wb.sheetnames\n5. Modify: sheet[''A1''] = ''New'', sheet.insert_rows(2), sheet.delete_cols(3)\n6. Add sheet: wb.create_sheet(''NewSheet'')\n7. Save: wb.save(''modified.xlsx'')\n8. Recalculate: python recalc.py modified.xlsx\nWARNING: Never use data_only=True then save (permanently removes formulas)",
      "note": "load_workbook preserves formulas as strings until recalc.py runs"
    },
    {
      "solution": "Recalculate all formulas and detect errors",
      "manual": "Run: python recalc.py <excel_file> [timeout_seconds]\nReturns JSON: {status: ''success'' or ''errors_found'', total_errors, total_formulas, error_summary}\nError types: #REF!, #DIV/0!, #VALUE!, #N/A, #NAME?, #NULL!, #NUM!\nFix errors by correcting cell references (#REF!), checking denominators (#DIV/0!), or formula syntax.",
      "note": "MANDATORY after using formulas. Script auto-configures LibreOffice on first run."
    },
    {
      "solution": "Apply industry-standard color coding for financial models",
      "manual": "Blue (0,0,255): hardcoded inputs, scenario values. Black (0,0,0): formulas and calculations. Green (0,128,0): internal worksheet links. Red (255,0,0): external file links. Yellow background (255,255,0): key assumptions needing attention. Use Font(color=''FF0000'') and PatternFill(''solid'', start_color=''FFFF00'').",
      "note": "Color conventions ensure financial models are clear and maintainable"
    },
    {
      "solution": "Format numbers correctly for financial documents",
      "manual": "Years: text (''2024'' not ''2,024''). Currency: $#,##0 with unit headers (''Revenue ($mm)''). Zeros as dashes: $#,##0;($#,##0);- (shows - for zero). Percentages: 0.0% (one decimal). Multiples: 0.0x format (EV/EBITDA). Negatives: parentheses (123) not -123. Create custom formats via NumberFormat property.",
      "note": "Proper formatting is critical for professional financial models"
    },
    {
      "solution": "Document hardcoded values with source attribution",
      "manual": "For any hardcoded number (revenue, growth rate, multiple), add comment with format: ''Source: [System/Document], [Date], [Specific Reference], [URL if applicable]''. Examples: ''Source: Company 10-K, FY2024, Page 45, Revenue Note, [SEC EDGAR URL]'', ''Source: Bloomberg Terminal, 8/15/2025, AAPL US Equity''",
      "note": "Traceability ensures financial models are auditable and professional"
    },
    {
      "solution": "Verify formulas contain zero errors",
      "manual": "Checklist: Test 2-3 sample cell references first. Confirm column mapping (column 64 = BL). Remember Excel rows 1-indexed (DataFrame row 5 = Excel row 6). Check for NaN values. Verify denominators exist (#DIV/0!). Confirm all cell references point to intended cells (#REF!). Use correct cross-sheet format: Sheet1!A1. Always run recalc.py and verify ''status'': ''success''.",
      "note": "Common pitfall: Far-right columns (FY data in columns 50+), division by zero, wrong references"
    }
  ]'::jsonb,
  'script',
  'Python 3.7+, openpyxl, pandas, LibreOffice (for recalc.py). Access to recalc.py for formula recalculation.',
  'Hardcoding calculated values instead of using formulas (breaks dynamic updates). Using data_only=True then saving (permanently removes formulas). Not running recalc.py after creating formulas (values don''t update). Wrong cell references. Missing formula error checking. Not documenting hardcoded sources.',
  'Excel file opens without errors. All formulas calculate correctly. recalc.py returns status: ''success'' with zero errors. Color-coded appropriately. Numbers formatted per standards. Sources documented for hardcodes.',
  'Create and edit professional Excel spreadsheets with dynamic formulas, correct formatting, and zero errors',
  'https://skillsmp.com/skills/anthropics-skills-document-skills-xlsx-skill-md',
  'admin:HAIKU_SKILL_1764289880_14600'
);
