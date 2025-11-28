INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'PDF Processing - Extract text, tables, fill forms, merge documents',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Extract text from PDF using pdfplumber",
      "cli": {
        "macos": "python3 -c \"import pdfplumber; pdf = pdfplumber.open(\\\"document.pdf\\\"); print(pdf.pages[0].extract_text())\"",
        "linux": "python3 -c \"import pdfplumber; pdf = pdfplumber.open(\\\"document.pdf\\\"); print(pdf.pages[0].extract_text())\"",
        "windows": "python -c \"import pdfplumber; pdf = pdfplumber.open(\\\"document.pdf\\\"); print(pdf.pages[0].extract_text())\""
      },
      "manual": "Install pdfplumber: pip install pdfplumber. Use pdfplumber.open(\\\"file.pdf\\\") context manager to load PDF. Call extract_text() on pages to get text content.",
      "note": "pdfplumber is recommended for text and table extraction"
    },
    {
      "solution": "Extract tables from PDF",
      "cli": {
        "macos": "python3 << ''SCRIPT''\nimport pdfplumber\nwith pdfplumber.open(\\\"report.pdf\\\") as pdf:\n    tables = pdf.pages[0].extract_tables()\n    for table in tables:\n        for row in table:\n            print(row)\nSCRIPT",
        "linux": "python3 << ''SCRIPT''\nimport pdfplumber\nwith pdfplumber.open(\\\"report.pdf\\\") as pdf:\n    tables = pdf.pages[0].extract_tables()\n    for table in tables:\n        for row in table:\n            print(row)\nSCRIPT",
        "windows": "python << ''SCRIPT''\nimport pdfplumber\nwith pdfplumber.open(\\\"report.pdf\\\") as pdf:\n    tables = pdf.pages[0].extract_tables()\n    for table in tables:\n        for row in table:\n            print(row)\nSCRIPT"
      },
      "manual": "Use extract_tables() method on PDF pages for automatic table detection. Returns list of tables with rows and columns.",
      "note": "Automatic detection works best with well-structured tables"
    },
    {
      "solution": "Fill PDF forms programmatically",
      "cli": {
        "macos": "python3 << ''SCRIPT''\nfrom pypdf import PdfReader, PdfWriter\nreader = PdfReader(\\\"form.pdf\\\")\nwriter = PdfWriter()\nwriter.append_pages_from_reader(reader)\nwriter.update_page_form_field_values(writer.pages[0], {\\\"name\\\": \\\"John Doe\\\", \\\"email\\\": \\\"john@example.com\\\"})\nwith open(\\\"filled_form.pdf\\\", \\\"wb\\\") as f:\n    writer.write(f)\nSCRIPT",
        "linux": "python3 << ''SCRIPT''\nfrom pypdf import PdfReader, PdfWriter\nreader = PdfReader(\\\"form.pdf\\\")\nwriter = PdfWriter()\nwriter.append_pages_from_reader(reader)\nwriter.update_page_form_field_values(writer.pages[0], {\\\"name\\\": \\\"John Doe\\\", \\\"email\\\": \\\"john@example.com\\\"})\nwith open(\\\"filled_form.pdf\\\", \\\"wb\\\") as f:\n    writer.write(f)\nSCRIPT",
        "windows": "python << ''SCRIPT''\nfrom pypdf import PdfReader, PdfWriter\nreader = PdfReader(\\\"form.pdf\\\")\nwriter = PdfWriter()\nwriter.append_pages_from_reader(reader)\nwriter.update_page_form_field_values(writer.pages[0], {\\\"name\\\": \\\"John Doe\\\", \\\"email\\\": \\\"john@example.com\\\"})\nwith open(\\\"filled_form.pdf\\\", \\\"wb\\\") as f:\n    writer.write(f)\nSCRIPT"
      },
      "manual": "Use PyPDF library to read PDF, create writer, append pages, then call update_page_form_field_values() with dictionary of field names and values. Write output file.",
      "note": "Always validate field names - they are case-sensitive"
    },
    {
      "solution": "Merge multiple PDF files",
      "cli": {
        "macos": "python3 << ''SCRIPT''\nfrom pypdf import PdfMerger\nmerger = PdfMerger()\nfor pdf in [\\\"file1.pdf\\\", \\\"file2.pdf\\\", \\\"file3.pdf\\\"]:\n    merger.append(pdf)\nmerger.write(\\\"merged.pdf\\\")\nmerger.close()\nSCRIPT",
        "linux": "python3 << ''SCRIPT''\nfrom pypdf import PdfMerger\nmerger = PdfMerger()\nfor pdf in [\\\"file1.pdf\\\", \\\"file2.pdf\\\", \\\"file3.pdf\\\"]:\n    merger.append(pdf)\nmerger.write(\\\"merged.pdf\\\")\nmerger.close()\nSCRIPT",
        "windows": "python << ''SCRIPT''\nfrom pypdf import PdfMerger\nmerger = PdfMerger()\nfor pdf in [\\\"file1.pdf\\\", \\\"file2.pdf\\\", \\\"file3.pdf\\\"]:\n    merger.append(pdf)\nmerger.write(\\\"merged.pdf\\\")\nmerger.close()\nSCRIPT"
      },
      "manual": "Use PdfMerger from pypdf library. Create merger instance, append PDF files, write to output file, then close.",
      "note": "Order of append() calls determines the order in final merged PDF"
    }
  ]'::jsonb,
  'script',
  'Python 3.8+, pdfplumber library, pypdf library',
  'Forgot to close PDF objects after use; assumed field names without verification; tried to fill non-existent form fields; not validating data before filling',
  'Extracted text appears correctly; tables returned as list of rows; form fields filled with correct values; merged PDF contains all pages in order',
  'Python skill for extracting text and tables from PDFs, filling forms, and merging documents',
  'https://skillsmp.com/skills/davila7-claude-code-templates-cli-tool-components-skills-document-processing-pdf-processing-skill-md',
  'admin:HAIKU_SKILL_1764290135_32431'
);
