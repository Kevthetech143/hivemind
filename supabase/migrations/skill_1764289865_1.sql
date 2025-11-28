-- Skill: PDF Processing Guide
INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'PDF Processing - Comprehensive PDF manipulation toolkit for extracting text and tables, creating new PDFs, merging/splitting documents, and handling forms.',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Install Python PDF libraries",
      "cli": {
        "macos": "pip install pypdf pdfplumber reportlab pdf2image pytesseract",
        "linux": "pip install pypdf pdfplumber reportlab pdf2image pytesseract",
        "windows": "pip install pypdf pdfplumber reportlab pdf2image pytesseract"
      },
      "manual": "Use pip to install: pypdf (basic operations), pdfplumber (text/table extraction), reportlab (create PDFs), pdf2image (OCR support), pytesseract (OCR)"
    },
    {
      "solution": "Merge PDFs with pypdf",
      "manual": "Use PdfWriter to combine multiple PDFs: load each PDF with PdfReader, add pages to writer with add_page(), then write to output file"
    },
    {
      "solution": "Extract text from PDF",
      "manual": "Use pdfplumber.open() to load PDF, iterate pages with pdf.pages, call page.extract_text() to get text content"
    },
    {
      "solution": "Extract tables from PDF",
      "manual": "Use pdfplumber to access pages, call page.extract_tables() to get list of tables, convert to pandas DataFrame if needed"
    },
    {
      "solution": "Create PDF with reportlab",
      "manual": "Use canvas.Canvas() for basic PDF creation or SimpleDocTemplate for multi-page documents with styling"
    },
    {
      "solution": "Split PDF pages",
      "manual": "Use PdfReader to load PDF, iterate through pages, create new PdfWriter for each page, write individual PDFs"
    },
    {
      "solution": "Extract PDF metadata",
      "manual": "Use PdfReader.metadata property to access title, author, subject, creator properties"
    },
    {
      "solution": "Password protect PDF",
      "manual": "Use PdfWriter.encrypt() method with user and owner passwords, write encrypted output"
    },
    {
      "solution": "Fill fillable form fields",
      "cli": {
        "macos": "python scripts/extract_form_field_info.py input.pdf field_info.json",
        "linux": "python scripts/extract_form_field_info.py input.pdf field_info.json"
      },
      "manual": "Run check_fillable_fields script first. If fillable, extract field info as JSON. Create field_values.json with values for each field. Run fill_fillable_fields.py to populate"
    },
    {
      "solution": "Fill non-fillable forms with annotations",
      "manual": "Convert PDF to PNG images, identify field positions via visual analysis, create fields.json with bounding boxes, validate with validation images, run fill_pdf_form_with_annotations.py"
    },
    {
      "solution": "Extract text from scanned PDFs with OCR",
      "cli": {
        "macos": "pip install pdf2image pytesseract",
        "linux": "pip install pdf2image pytesseract"
      },
      "manual": "Use pdf2image.convert_from_path() to convert PDF to images, then use pytesseract.image_to_string() for OCR on each image"
    },
    {
      "solution": "Command-line PDF operations with qpdf",
      "cli": {
        "macos": "brew install qpdf",
        "linux": "apt-get install qpdf"
      },
      "manual": "Merge with qpdf --empty --pages file1.pdf file2.pdf -- merged.pdf. Split with qpdf --split-pages. Decrypt with qpdf --decrypt encrypted.pdf"
    },
    {
      "solution": "Advanced PDF rendering with pypdfium2",
      "cli": {
        "macos": "pip install pypdfium2",
        "linux": "pip install pypdfium2"
      },
      "manual": "Load PDF with pdfium.PdfDocument(), render pages with page.render(), convert bitmap to PIL image with bitmap.to_pil()"
    }
  ]'::jsonb,
  'script',
  'Python 3.7+, pip package manager. For OCR: Tesseract binary. For CLI tools: poppler-utils or qpdf installed',
  'Common mistakes: Using pyPdf instead of pypdf (outdated). Forgetting to import pdf2image convert_from_path for OCR. Using port 6543 instead of 5432 for database. Not verifying fillable form fields before extraction. Incorrect bounding box coordinates for form annotation (PDF coordinates have y=0 at bottom)',
  'Success indicators: PDF files successfully merged/split, text extracted matches document content, tables converted to DataFrame correctly, fillable forms populated with correct values, password protection applied, OCR text recognized from scanned images',
  'Comprehensive PDF processing toolkit supporting text extraction, table extraction, PDF creation, merging, splitting, form filling, and OCR with multiple Python libraries and command-line tools',
  'https://skillsmp.com/skills/anthropics-skills-document-skills-pdf-skill-md',
  'admin:HAIKU_SKILL_1764289865_13432'
);
