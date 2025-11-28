INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'DOCX Word Document Creation and Editing - Professional document workflows with tracked changes',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Text Extraction - Convert documents to markdown or access raw XML",
      "cli": {
        "macos": "pandoc --track-changes=all path-to-file.docx -o output.md",
        "linux": "pandoc --track-changes=all path-to-file.docx -o output.md",
        "windows": "pandoc --track-changes=all path-to-file.docx -o output.md"
      },
      "manual": "For text extraction with tracked changes: use pandoc with --track-changes=all|accept|reject options. For raw XML access (comments, complex formatting, metadata): unpack using ''python ooxml/scripts/unpack.py <office_file> <output_directory>''. Key XML files: word/document.xml (main content), word/comments.xml (comments), word/media/ (embedded images), tracked changes use <w:ins> (insertions) and <w:del> (deletions) tags",
      "note": "DOCX is a ZIP archive with XML contents. Unpacking allows direct access to all document elements including structure, metadata, and tracked changes"
    },
    {
      "solution": "Create New Documents - Build Word documents from JavaScript/TypeScript",
      "cli": {
        "macos": "npm install -g docx && node create-document.js",
        "linux": "npm install -g docx && node create-document.js",
        "windows": "npm install -g docx && node create-document.js"
      },
      "manual": "READ docx-js.md COMPLETELY before starting. Use docx-js library with Document, Paragraph, TextRun components. Create JavaScript/TypeScript file defining document structure with components. Export as .docx using Packer.toBuffer(). Example structure: Document contains Sections, Sections contain Paragraphs, Paragraphs contain TextRuns. Dependencies include docx npm package (assumed pre-installed). For detailed syntax and formatting rules, see docx-js.md reference file",
      "note": "docx-js provides full control over document structure, formatting, styles, tables, headers/footers, and page layout. Must read docx-js.md COMPLETELY before starting document creation"
    },
    {
      "solution": "Edit Existing Documents - Modify Word documents using Python OOXML library",
      "cli": {
        "macos": "python ooxml/scripts/unpack.py <file.docx> <output_dir> && python edit-script.py && python ooxml/scripts/pack.py <output_dir> <file.docx>",
        "linux": "python ooxml/scripts/unpack.py <file.docx> <output_dir> && python edit-script.py && python ooxml/scripts/pack.py <output_dir> <file.docx>",
        "windows": "python ooxml/scripts/unpack.py <file.docx> <output_dir> && python edit-script.py && python ooxml/scripts/pack.py <output_dir> <file.docx>"
      },
      "manual": "MANDATORY: READ ooxml.md COMPLETELY before editing. Workflow: (1) Unpack document to XML files, (2) Create Python script using Document library (provides high-level methods and direct DOM access), (3) Run script using doc.get_node() to find nodes and modify, (4) Save with doc.save(), (5) Pack directory back to .docx. Document library handles all OOXML infrastructure automatically. For complex scenarios, access underlying DOM directly. See ooxml.md for Document library API and XML patterns",
      "note": "Document library provides both high-level methods for common operations and direct DOM access for complex changes. Always unpack before editing to access full document structure"
    },
    {
      "solution": "Tracked Changes Workflow - Implement professional document review with full change tracking",
      "cli": {
        "macos": "pandoc --track-changes=all document.docx -o current.md && python ooxml/scripts/unpack.py document.docx unpacked && python batch-changes.py && python ooxml/scripts/pack.py unpacked reviewed-document.docx",
        "linux": "pandoc --track-changes=all document.docx -o current.md && python ooxml/scripts/unpack.py document.docx unpacked && python batch-changes.py && python ooxml/scripts/pack.py unpacked reviewed-document.docx",
        "windows": "pandoc --track-changes=all document.docx -o current.md && python ooxml/scripts/unpack.py document.docx unpacked && python batch-changes.py && python ooxml/scripts/pack.py unpacked reviewed-document.docx"
      },
      "manual": "CRITICAL: Must implement ALL changes systematically. (1) Get markdown representation with tracked changes: ''pandoc --track-changes=all file.docx -o current.md''. (2) Identify ALL changes needed and organize into logical batches (3-10 changes per batch by section, type, or proximity). (3) MANDATORY: Read ooxml.md COMPLETELY, pay attention to ''Document Library'' and ''Tracked Change Patterns'' sections. (4) Unpack: ''python ooxml/scripts/unpack.py file.docx dir''. Note suggested RSID. (5) For each batch: grep word/document.xml for text to verify XML structure, create Python script using Document library with get_node() to find nodes, implement changes with <w:ins>/<w:del> tags, run script, doc.save(). (6) Pack: ''python ooxml/scripts/pack.py unpacked reviewed-document.docx''. (7) Verify: ''pandoc --track-changes=all reviewed-document.docx -o verification.md'' and grep for phrases. PRINCIPLE: Mark only text that changes, preserve unchanged text with original <w:r> elements including RSID attributes",
      "note": "Minimal precise edits preserve professionalism - break replacements into [unchanged]+[deletion]+[insertion]+[unchanged]. Always grep document.xml immediately before writing script to get current line numbers. Batch processing makes debugging easier and allows incremental progress. Test each batch before moving to next"
    },
    {
      "solution": "Redlining Best Practices - Professional change documentation and review",
      "cli": {
        "macos": "grep -n pattern unpacked/word/document.xml | head -5",
        "linux": "grep -n pattern unpacked/word/document.xml | head -5",
        "windows": "findstr /N pattern unpacked\\word\\document.xml | head -5"
      },
      "manual": "Location methods for finding changes: (1) Section/heading numbers (e.g., ''Section 3.2'', ''Article IV''), (2) Paragraph identifiers if numbered, (3) Grep patterns with unique surrounding text, (4) Document structure (e.g., ''first paragraph'', ''signature block''). NEVER use markdown line numbers - they don''t map to XML. Group changes logically: by section (''Section 3 changes''), by type (''Date corrections''), by proximity (''Pages 1-3 changes''), or by complexity (simple text first, complex structural later). Example of GOOD precise editing: for ''30 days'' to ''60 days'' in sentence, preserve ''The term is '' and '' days.'' with original <w:r> elements, only mark ''30''->''60'' as deletion/insertion",
      "note": "Professional documents require precise tracking of exactly what changed. Repeating unchanged text appears unprofessional. Always preserve original RSID from unchanged runs to maintain document structure integrity"
    },
    {
      "solution": "Document Visualization - Convert documents to images for analysis",
      "cli": {
        "macos": "soffice --headless --convert-to pdf document.docx && pdftoppm -jpeg -r 150 document.pdf page",
        "linux": "soffice --headless --convert-to pdf document.docx && pdftoppm -jpeg -r 150 document.pdf page",
        "windows": "soffice --headless --convert-to pdf document.docx && pdftoppm -jpeg -r 150 document.pdf page"
      },
      "manual": "Two-step process: (1) Convert DOCX to PDF: ''soffice --headless --convert-to pdf document.docx''. (2) Convert PDF to JPEG images: ''pdftoppm -jpeg -r 150 document.pdf page''. Creates files like page-1.jpg, page-2.jpg, etc. Options: -r 150 (150 DPI resolution, adjust for quality/size), -jpeg (JPEG format, use -png for PNG), -f N (first page), -l N (last page), prefix (output filename prefix). Example for specific range: ''pdftoppm -jpeg -r 150 -f 2 -l 5 document.pdf page'' converts only pages 2-5",
      "note": "Resolution -r 150 provides good balance between quality and file size. LibreOffice and Poppler (pdftoppm) must be installed. Useful for visual inspection before and after edits"
    }
  ]'::jsonb,
  'script',
  'Python 3.x, Node.js, npm package manager, pandoc, docx npm library, LibreOffice, Poppler (pdftoppm), defusedxml Python library',
  'Not reading ooxml.md COMPLETELY before editing - critical information on Document library patterns and RSID handling. Using markdown line numbers to locate changes instead of document structure/grep patterns - doesn''t map to XML. Repeating unchanged text in tracked changes - appears unprofessional and makes reviews harder. Not batching changes - making large changes at once causes debugging difficulties. Forgetting to note suggested RSID from unpack script before implementing changes. Not grepping word/document.xml immediately before writing script - line numbers change after each modification',
  'Successfully converted document to markdown with tracked changes. Unpacked DOCX to XML files. Document library methods executed without errors. Changes applied with minimal, precise edits using <w:ins>/<w:del> tags. Document repacked successfully. Final verification shows all intended changes applied correctly. Code is concise without verbose variable names or unnecessary print statements',
  'Master DOCX workflows: text extraction with tracked changes, programmatic document creation with docx-js, editing with Document library, professional redlining with precise change tracking, document visualization',
  'https://skillsmp.com/skills/anthropics-skills-document-skills-docx-skill-md',
  'admin:HAIKU_SKILL_1764289850_11700'
);
