INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'PPTX Presentation Creation and Editing - Working with PowerPoint files',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Text Extraction - Convert presentations to markdown or access raw XML",
      "cli": {
        "macos": "python -m markitdown path-to-file.pptx",
        "linux": "python -m markitdown path-to-file.pptx",
        "windows": "python -m markitdown path-to-file.pptx"
      },
      "manual": "For simple text extraction: use markitdown to convert .pptx to markdown. For complex features (comments, speaker notes, animations, layouts): unpack the presentation using ''python ooxml/scripts/unpack.py <office_file> <output_dir>'' to access raw XML. Key XML files: ppt/presentation.xml (metadata), ppt/slides/slide{N}.xml (content), ppt/notesSlides/notesSlide{N}.xml (speaker notes), ppt/comments/modernComment_*.xml (comments), ppt/slideLayouts/ (layout templates), ppt/slideMasters/ (master slides), ppt/theme/ (styling), ppt/media/ (images)",
      "note": "PPTX is a ZIP archive containing XML files. Unpacking allows direct access to all presentation elements including design data, comments, and speaker notes"
    },
    {
      "solution": "Create New Presentations - Generate PowerPoint files programmatically",
      "cli": {
        "macos": "npm install -g pptxgenjs html2pptx playwright react-icons sharp",
        "linux": "npm install -g pptxgenjs html2pptx playwright react-icons sharp",
        "windows": "npm install -g pptxgenjs html2pptx playwright react-icons sharp"
      },
      "manual": "Use pptxgenjs to create new presentations from Node.js. Alternatively: create HTML/CSS templates and convert to PPTX using html2pptx (requires Playwright and React Icons). For SVG to raster conversion use sharp. Dependencies: markitdown (pip install markitdown[pptx]), pptxgenjs (npm install -g pptxgenjs), playwright (npm install -g playwright), react-icons (npm install -g react-icons react react-dom), sharp (npm install -g sharp), LibreOffice (for PDF conversion), Poppler (for PDF to image conversion), defusedxml (pip install defusedxml)",
      "note": "pptxgenjs is the recommended approach for programmatic creation. html2pptx allows web-based design workflows"
    },
    {
      "solution": "Edit Slide Content - Replace text while preserving formatting",
      "cli": {
        "macos": "python ooxml/scripts/replace.py <pptx_file> <inventory_json> <replacement_json>",
        "linux": "python ooxml/scripts/replace.py <pptx_file> <inventory_json> <replacement_json>",
        "windows": "python ooxml/scripts/replace.py <pptx_file> <inventory_json> <replacement_json>"
      },
      "manual": "Unpack presentation, analyze XML to understand shape IDs and structure. Create inventory JSON listing all text shapes. Create replacement JSON with new text for specific shapes, including paragraph properties for bullets, alignment, fonts, and colors. Run replace.py which will: extract all text shapes, validate shapes exist, clear text from all shapes, apply new text with formatting, preserve paragraph properties, handle overflow detection. Script validates that all shapes in replacement JSON exist in inventory before applying changes",
      "note": "Replacement script preserves complex formatting (bullets, alignment, fonts, colors) automatically. Always validate shape IDs match inventory before replacing. Script detects and reports text overflow issues"
    },
    {
      "solution": "Typography and Color Analysis - Extract design patterns from existing presentations",
      "cli": {
        "macos": "grep -r a:srgbClr ppt/slides/ && cat ppt/theme/theme1.xml",
        "linux": "grep -r a:srgbClr ppt/slides/ && cat ppt/theme/theme1.xml",
        "windows": "findstr /R a:srgbClr ppt\\slides\\*.xml && type ppt\\theme\\theme1.xml"
      },
      "manual": "When emulating a design: (1) Read ppt/theme/theme1.xml to find color scheme (a:clrScheme) and fonts (a:fontScheme). (2) Examine ppt/slides/slide1.xml to see actual font usage (a:rPr elements) and colors applied. (3) Search across all XML files for color references (a:solidFill, a:srgbClr) and font references (a:rPr) to identify patterns. Document all colors (RGB or theme-based) and fonts (name, size, style) found",
      "note": "Theme colors are defined centrally in theme1.xml. Individual slides override theme colors using srgbClr (RGB) or theme color references. Extract both theme colors and slide-specific overrides"
    },
    {
      "solution": "Create Thumbnail Grids - Generate visual overview of presentation slides",
      "cli": {
        "macos": "python scripts/thumbnail.py template.pptx [output_prefix] [--cols N]",
        "linux": "python scripts/thumbnail.py template.pptx [output_prefix] [--cols N]",
        "windows": "python scripts/thumbnail.py template.pptx [output_prefix] [--cols N]"
      },
      "manual": "Generate visual thumbnail grids for quick analysis. Default: 5 columns, max 30 slides per grid (5×6). Options: --cols N (range 3-6, affects slides per grid). Grid limits: 3 cols = 12 slides/grid, 4 cols = 20, 5 cols = 30, 6 cols = 42. Slides are zero-indexed. Output prefix can include path (e.g., workspace/my-grid). For large decks creates multiple files (thumbnails-1.jpg, thumbnails-2.jpg, etc)",
      "note": "Use thumbnails for template analysis (understand layouts), content review (visual overview), navigation (find slides visually), quality checks (verify formatting). Include path in prefix to output to specific directory"
    },
    {
      "solution": "Convert Slides to Images - Extract slides as visual JPEGs for analysis",
      "cli": {
        "macos": "soffice --headless --convert-to pdf template.pptx && pdftoppm -jpeg -r 150 template.pdf slide",
        "linux": "soffice --headless --convert-to pdf template.pptx && pdftoppm -jpeg -r 150 template.pdf slide",
        "windows": "soffice --headless --convert-to pdf template.pptx && pdftoppm -jpeg -r 150 template.pdf slide"
      },
      "manual": "Two-step process: (1) Convert PPTX to PDF using soffice (LibreOffice). (2) Convert PDF pages to JPEG using pdftoppm with options: -jpeg (output format), -r 150 (150 DPI resolution), -f N (first page), -l N (last page), prefix (output file prefix). Example: pdftoppm -jpeg -r 150 -f 2 -l 5 template.pdf slide converts pages 2-5 to slide-2.jpg, slide-3.jpg, etc. Requires: LibreOffice (apt-get install libreoffice) and Poppler (apt-get install poppler-utils)",
      "note": "Resolution -r 150 provides good balance between quality and file size. Use -f and -l flags to convert specific page ranges instead of entire presentation"
    }
  ]'::jsonb,
  'script',
  'Python 3.x, pip package manager, Node.js and npm, LibreOffice, Poppler (pdftoppm), markitdown library, pptxgenjs, playwright, sharp, defusedxml',
  'Trying to access comments or speaker notes without unpacking XML - must use unpack.py for complex features. Not validating shape IDs before running replace.py - script will fail if shapes don''t exist. Using thread-unsafe XML parsing - always use defusedxml for secure parsing. Not considering theme colors vs slide overrides when analyzing typography. Forgetting to include path in thumbnail output prefix when writing to specific directory',
  'Successfully extracted text from presentation using markitdown or XML. Shape IDs validated before replacement. Typography analysis documents both theme colors and slide-specific overrides. Thumbnail grids generated with correct dimensions. PDF conversion to JPEG successful with readable slide content. All XML parsing uses defusedxml library',
  'Master PPTX workflows: text extraction via markdown/XML, programmatic creation with pptxgenjs, editing with preserved formatting, design analysis, thumbnail generation, slide visualization',
  'https://skillsmp.com/skills/anthropics-skills-document-skills-pptx-skill-md',
  'admin:HAIKU_SKILL_1764289850_11700'
);
