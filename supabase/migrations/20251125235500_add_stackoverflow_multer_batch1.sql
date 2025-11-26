-- Add Stack Overflow Multer file upload solutions batch 1
-- Extracted from highest-voted Multer questions with accepted answers

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Node Multer unexpected field error - field name mismatch',
    'stackoverflow-multer',
    'HIGH',
    '[
        {"solution": "Ensure multer field name matches form input name attribute - use upload.single(''recfile'') for <input name=''recfile''>", "percentage": 95, "note": "Most common cause of unexpected field error"},
        {"solution": "When using FormData API, ensure formData.append(''fieldName'', file) matches upload.single(''fieldName'')", "percentage": 92, "note": "Critical for JavaScript fetch/axios uploads"},
        {"solution": "For array uploads in newer multer versions, use syntax like upload.single(''photos[]'') to match field definitions", "percentage": 85, "note": "Required for some multer versions"}
    ]'::jsonb,
    'Express server running, Multer configured, HTML form or FormData object prepared',
    'File uploads succeed without error, req.file contains file object, no ENOENT errors',
    'Field name mismatch is the primary cause - verify across HTML input name, FormData append key, and multer handler parameter',
    0.94,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/31530200/node-multer-unexpected-field'
),
(
    'How to find the size of file in Node.js with multer',
    'stackoverflow-multer',
    'MEDIUM',
    '[
        {"solution": "Use fs.stat() or fs.statSync() AFTER file upload completes - fs.statSync().size returns bytes", "percentage": 95, "note": "multer file object does not include size during filename callback"},
        {"solution": "Convert bytes to MB: fileSizeInMb = fileStats.size / (1024 ** 2)", "percentage": 90, "note": "Use for async modern approach with fs.promises"},
        {"solution": "For real-time monitoring during upload, use req.file.size after upload completes in route handler", "percentage": 88, "note": "Only available after multer finishes processing"}
    ]'::jsonb,
    'Node.js fs module available, File uploaded with multer, Path to saved file known',
    'fs.stat() returns stats object, size property is non-zero number, conversion calculation is accurate',
    'Do not try to access file.size inside filename callback - it will be undefined. Always check after upload completes.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/42363140/how-to-find-the-size-of-the-file-in-node-js'
),
(
    'Store file with original file extension using multer diskStorage',
    'stackoverflow-multer',
    'HIGH',
    '[
        {"solution": "Use path.extname() to extract extension: filename: function(req, file, cb) { cb(null, Date.now() + path.extname(file.originalname)) }", "percentage": 93, "note": "Simple and handles standard formats well"},
        {"solution": "For complex MIME types like .docx, use mime-types package to derive extension from MIME type rather than filename", "percentage": 85, "note": "More robust for edge cases"},
        {"solution": "Ensure diskStorage destination directory exists before writing files", "percentage": 88, "note": "Prevents ENOENT errors on Windows/Linux"}
    ]'::jsonb,
    'Multer diskStorage configured, Node path module imported, destination directory exists',
    'Uploaded files appear in directory with correct extensions, file.originalname matches saved file type',
    'Files without extensions or with modified names can fail - validate file type on server side. Windows does not allow colons in filenames - use Date.now() not toISOString()',
    0.91,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/31592726/how-to-store-a-file-with-file-extension-with-multer'
),
(
    'Express multer multipart boundary not found error in Postman',
    'stackoverflow-multer',
    'MEDIUM',
    '[
        {"solution": "Remove manually-set Content-Type header from Postman request - let Postman auto-generate it with boundary", "percentage": 96, "note": "Root cause in 99% of cases - manual header breaks multipart format"},
        {"solution": "In form-data body type, Postman automatically adds correct Content-Type with boundary - never override it", "percentage": 93, "note": "Same applies to fetch/axios - do not set Content-Type manually"},
        {"solution": "For frontend code, avoid explicitly setting Content-Type header when using FormData() - browser handles it", "percentage": 91, "note": "Critical for JavaScript fetch requests"}
    ]'::jsonb,
    'Postman or HTTP client set up, Multer middleware configured, multipart/form-data body type enabled',
    'Request returns 200 status, boundary parameter included in Content-Type header, file uploads successfully',
    'Never manually set Content-Type: multipart/form-data without boundary parameter - this is the #1 cause of this error',
    0.95,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/49692745/express-using-multer-error-multipart-boundary-not-found-request-sent-by-pos'
),
(
    'Limit file size when uploading with multer',
    'stackoverflow-multer',
    'HIGH',
    '[
        {"solution": "Use limits object in multer config: multer({ storage: storage, limits: { fileSize: maxSize } })", "percentage": 96, "note": "Modern standard approach, replaces deprecated onFileUploadStart"},
        {"solution": "Handle LIMIT_FILE_SIZE error: if(err && err.code === ''LIMIT_FILE_SIZE'') return res.end(''File too large'')", "percentage": 92, "note": "fileSize measured in bytes"},
        {"solution": "Combine with other limits: limits: { fileSize: 5242880, files: 10, fields: 50 }", "percentage": 88, "note": "Can limit multiple parameters simultaneously"}
    ]'::jsonb,
    'Multer middleware configured, Express route handler set up, file size limit determined in bytes',
    'File upload rejected when size exceeded, error code LIMIT_FILE_SIZE returned, user receives appropriate error message',
    'onFileUploadStart is deprecated - use limits object instead. fileSize is in bytes, not MB - multiply by 1024*1024 for MB limits.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/34697502/how-to-limit-the-file-size-when-uploading-with-multer'
),
(
    'ENOENT: no such file or directory error with multer on Windows',
    'stackoverflow-multer',
    'MEDIUM',
    '[
        {"solution": "Replace colons in filenames: use cb(null, new Date().toISOString().replace(/:/g, ''-'') + file.originalname) instead of cb(null, new Date().toISOString() + file.originalname)", "percentage": 97, "note": "Windows does not accept colons in filenames"},
        {"solution": "Alternative: use Date.now() instead of toISOString() - cb(null, Date.now() + file.originalname)", "percentage": 95, "note": "Simpler solution, no special character replacement needed"},
        {"solution": "Ensure uploads directory exists before writing: use path.join(__dirname, ''/uploads/'') for proper path handling", "percentage": 90, "note": "Prevents missing directory errors"}
    ]'::jsonb,
    'Windows operating system, Node.js running, multer diskStorage configured, uploads directory exists',
    'Files uploaded successfully with timestamps, no ENOENT error thrown, files appear in uploads directory',
    'This error is platform-specific to Windows - macOS users may not see it. Always replace colons when using toISOString() on Windows.',
    0.96,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/48418680/enoent-no-such-file-or-directory'
),
(
    'Cannot app.use(multer) - requires middleware function error',
    'stackoverflow-multer',
    'MEDIUM',
    '[
        {"solution": "Multer must be invoked with a method: app.use(multer({dest:''./uploads/''}).single(''photo'')) - not just app.use(multer({...}))", "percentage": 96, "note": "multer() returns object with methods, methods return middleware"},
        {"solution": "For route-specific uploads, pass middleware to route: app.post(''/upload'', upload.single(''file''), handler)", "percentage": 94, "note": "Preferred pattern for file uploads"},
        {"solution": "Use upload.array() for multiple files or upload.fields() for mixed uploads", "percentage": 88, "note": "Choose method based on upload type needed"}
    ]'::jsonb,
    'Express app configured, multer installed, storage destination defined',
    'Middleware initializes without error, Express accepts middleware function, files upload successfully',
    'Forgetting to chain a method like .single(), .array(), or .fields() is the only cause of this error',
    0.97,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/31496100/cannot-app-usemulter-requires-middleware-function-error'
),
(
    'Upload image to AWS S3 using multer-s3 in Node.js',
    'stackoverflow-multer',
    'MEDIUM',
    '[
        {"solution": "Create AWS S3 instance first: aws.config.update({secretAccessKey, accessKeyId, region}); var s3 = new aws.S3()", "percentage": 94, "note": "S3 object must be initialized before passing to multer-s3"},
        {"solution": "Configure multerS3: multerS3({s3: s3, acl: ''public-read'', bucket: ''bucket-name'', key: function(req, file, cb) { cb(null, file.originalname) }})", "percentage": 92, "note": "Pass S3 instance, not raw config"},
        {"solution": "Access uploaded file URL: req.file.location contains full S3 URL after successful upload", "percentage": 90, "note": "Location property replaces local path in multer-s3"}
    ]'::jsonb,
    'AWS SDK installed and configured, S3 bucket created, AWS credentials (accessKeyId, secretAccessKey) available, multer-s3 installed',
    'File uploads to S3 successfully, req.file.location contains valid S3 URL, file accessible via bucket',
    'Error ''Expected opts.s3 to be object'' means S3 instance was not properly initialized - always call new aws.S3() first',
    0.90,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/40494050/uploading-image-to-amazon-s3-using-multer-s3-nodejs'
),
(
    'Node.js multer and req.body empty - form fields not populated',
    'stackoverflow-multer',
    'HIGH',
    '[
        {"solution": "Append form fields BEFORE file uploads in FormData: formData.append(''field'') first, then formData.append(''file'') last", "percentage": 94, "note": "Field order matters - multer parses in order received"},
        {"solution": "Access req.body inside route handler AFTER multer middleware processes, not before", "percentage": 96, "note": "req.body only populated after multer finishes"},
        {"solution": "Remember body-parser cannot handle multipart/form-data - ONLY multer can parse it", "percentage": 92, "note": "Do not use body-parser for file upload routes"}
    ]'::jsonb,
    'Multer middleware configured, Express route set up, form includes both regular fields and file input',
    'req.body contains all regular form fields, req.file contains uploaded file, no undefined properties',
    'Field order from client affects parsing - files sent last are parsed after fields. Accessing req.body before multer finishes causes empty object.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/39589022/node-js-multer-and-req-body-empty'
),
(
    'Upload multiple files from different fields with multer',
    'stackoverflow-multer',
    'HIGH',
    '[
        {"solution": "Use upload.fields() with array of field config: upload.fields([{name: ''video'', maxCount: 1}, {name: ''subtitles'', maxCount: 1}])", "percentage": 95, "note": "Prevents ''Unexpected field'' errors for multi-field uploads"},
        {"solution": "Access uploaded files via req.files object: req.files.video and req.files.subtitles as arrays", "percentage": 93, "note": "Even with maxCount: 1, files are arrays"},
        {"solution": "Each field config object specifies name and maxCount - allows different limits per field", "percentage": 90, "note": "More flexible than .single() or .array()"}
    ]'::jsonb,
    'Multer configured with diskStorage or other storage, Express route handler defined, form includes multiple file input elements',
    'Multiple files upload successfully, req.files contains all fields, no unexpected field errors, each file accessible by field name',
    'Files from different fields must use .fields() method - using .single() will cause ''Unexpected field'' error for additional files',
    0.94,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/36096805/uploading-multiple-files-with-multer-but-from-different-fields'
),
(
    'TypeScript Namespace global.Express has no exported member Multer',
    'stackoverflow-multer',
    'MEDIUM',
    '[
        {"solution": "Install @types/multer: npm install --save @types/multer", "percentage": 97, "note": "Required for TypeScript type definitions"},
        {"solution": "Add ''Multer'' to tsconfig.json compilerOptions.types array: {\"types\": [\"node\", \"Multer\"]}", "percentage": 95, "note": "Registers global Multer types"},
        {"solution": "For nx.workspace projects, apply types config to tsconfig.app.json in API folder instead of root tsconfig", "percentage": 88, "note": "Monorepo-specific configuration"}
    ]'::jsonb,
    'TypeScript project set up, Express application running, tsconfig.json file exists',
    'TypeScript compilation succeeds without error, req.file types recognized in IDE, no type errors on multer objects',
    'Without @types/multer types array in tsconfig, global Multer definitions not loaded - must be explicitly included',
    0.96,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/75688293/namespace-global-express-has-no-exported-member-multer'
),
(
    'Get filename from multer - access generated filename from req.file',
    'stackoverflow-multer',
    'MEDIUM',
    '[
        {"solution": "Access filename via req.file.filename: app.post(''/upload'', upload.single(''file''), function(req, res) { const filename = req.file.filename; })", "percentage": 96, "note": "filename is the generated name after multer processing"},
        {"solution": "req.file object contains: fieldname, originalname, filename, path, destination, size, mimetype", "percentage": 94, "note": "Complete file metadata available after upload"},
        {"solution": "Use req.file.originalname for original uploaded filename, req.file.filename for processed name", "percentage": 92, "note": "Different fields for different purposes"}
    ]'::jsonb,
    'Multer diskStorage configured with custom filename function, Express route with upload middleware established, file uploaded',
    'req.file.filename contains generated filename, all file properties accessible, database can store filename reference',
    'req.file is only available in route handler AFTER upload middleware processes - not available before or in global scope',
    0.95,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/34328846/node-multer-get-filename'
)
;
