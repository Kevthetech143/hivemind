-- PDF Processing Pro Skill
INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'PDF Processing Pro - Production-ready PDF workflows with forms, tables, OCR, validation and batch operations',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Install required dependencies",
      "cli": {
        "macos": "pip install pdfplumber pypdf pillow pytesseract pandas && brew install tesseract",
        "linux": "pip install pdfplumber pypdf pillow pytesseract pandas && sudo apt-get install tesseract-ocr",
        "windows": "pip install pdfplumber pypdf pillow pytesseract pandas && Download tesseract from GitHub"
      },
      "note": "Tesseract system package required for OCR features; optional but recommended for full functionality"
    },
    {
      "solution": "Analyze PDF form structure",
      "cli": {
        "macos": "python scripts/analyze_form.py input.pdf --output schema.json",
        "linux": "python scripts/analyze_form.py input.pdf --output schema.json",
        "windows": "python scripts/analyze_form.py input.pdf --output schema.json"
      },
      "note": "Returns JSON with all form fields, types, coordinates, and requirements before filling"
    },
    {
      "solution": "Fill and validate PDF forms",
      "cli": {
        "macos": "python scripts/fill_form.py template.pdf data.json output.pdf --validate",
        "linux": "python scripts/fill_form.py template.pdf data.json output.pdf --validate",
        "windows": "python scripts/fill_form.py template.pdf data.json output.pdf --validate"
      },
      "note": "Includes automatic validation, error reporting, and support for checkboxes, radio buttons, dropdowns"
    },
    {
      "solution": "Extract tables from PDFs",
      "cli": {
        "macos": "python scripts/extract_tables.py report.pdf --output tables.csv --format csv",
        "linux": "python scripts/extract_tables.py report.pdf --output tables.csv --format csv",
        "windows": "python scripts/extract_tables.py report.pdf --output tables.csv --format csv"
      },
      "note": "Supports multi-page tables, merged cells, automatic column detection, export to CSV or Excel"
    },
    {
      "solution": "Process scanned PDFs with OCR",
      "manual": "Use pytesseract with pdf2image: convert PDF to images, preprocess with PIL (grayscale, contrast enhancement, denoising), run OCR with language support, validate output confidence scores",
      "note": "Image preprocessing critical for accuracy; consider multi-language support with lang=''eng+spa+fra''"
    },
    {
      "solution": "Batch process multiple PDFs",
      "manual": "Use glob patterns to iterate over files, process each with subprocess.run, check exit codes for error handling, implement logging for audit trail, cache results to avoid re-processing large batches",
      "note": "Process in chunks (100 PDFs at a time) to avoid memory issues with large batches"
    }
  ]'::jsonb,
  'script',
  'Python 3.7+; PDF files; for OCR: Tesseract system package; basic knowledge of PDF structure',
  'Using wrong port (6543 pooler instead of 5432 direct) causing Tenant errors; forgetting to validate data before filling forms; not checking exit codes in batch automation; memory overload with large PDFs (process page-by-page instead)',
  'Scripts run without errors, generated SQL files created successfully, form fields accurately extracted or filled, table data correctly exported, OCR text readable with proper language detection',
  'Production-ready scripts for PDF analysis, form filling, table extraction, OCR, and batch operations with comprehensive error handling',
  'https://skillsmp.com/skills/davila7-claude-code-templates-cli-tool-components-skills-document-processing-pdf-processing-pro-skill-md',
  'admin:HAIKU_SKILL_1764290120_31772'
);
