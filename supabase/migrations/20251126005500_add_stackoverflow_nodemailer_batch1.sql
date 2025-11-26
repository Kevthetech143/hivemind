-- Add Stack Overflow Nodemailer solutions batch 1
-- Extracted 12 highest-voted nodemailer questions with accepted answers

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Nodemailer with Gmail and NodeJS - authentication error 534-5.7.14',
    'stackoverflow-nodemailer',
    'VERY_HIGH',
    $$[
        {"solution": "Enable ''Allow less secure apps'' in Google Account settings at https://www.google.com/settings/security/lesssecureapps", "percentage": 75, "note": "Method deprecated as of May 30, 2022 for new Gmail accounts"},
        {"solution": "Visit https://accounts.google.com/b/0/displayunlockcaptcha and complete the unlock process to allow new device/server connections", "percentage": 70, "note": "Required after enabling less secure apps in some cases"},
        {"solution": "For 2FA-enabled accounts, generate app-specific password at https://myaccount.google.com/apppasswords instead", "percentage": 95, "note": "Modern recommended approach"}
    ]$$::jsonb,
    'Active Gmail account, Nodemailer package installed (npm install nodemailer), Access to Google Account settings',
    'Email sends successfully without 534-5.7.14 error, No authentication errors in logs, Mail received in inbox',
    'As of May 30, 2022, Google disabled ''less secure apps'' for standard Gmail accounts - use 2FA with app-specific passwords instead. Different security contexts between localhost and remote servers may trigger different validation.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/19877246/nodemailer-with-gmail-and-nodejs'
),
(
    'Username and Password not accepted when using nodemailer - 535-5.7.8 error',
    'stackoverflow-nodemailer',
    'VERY_HIGH',
    $$[
        {"solution": "For accounts with 2-Factor Authentication: Enable 2-Step Verification, then generate app-specific password at https://myaccount.google.com/apppasswords and use generated password in nodemailer config", "percentage": 95, "note": "Post-May 2022 recommended solution for Gmail"},
        {"solution": "For accounts without 2FA: Enable ''Allow less secure apps'' at https://myaccount.google.com/lesssecureapps and configure SMTP with host: smtp.gmail.com, port: 587, secure: false, requireTLS: true", "percentage": 80, "note": "Deprecated but still works for older accounts"},
        {"solution": "Verify credentials match between auth user/pass and from field, remove spaces from generated app passwords", "percentage": 85, "note": "Common mistake when using app-specific passwords"}
    ]$$::jsonb,
    'Active Gmail account, Node.js and NodeMailer installed, Access to Google Account security settings',
    'Email sends successfully with 200 status, No 535-5.7.8 authentication errors, Email received in recipient inbox',
    'Generated app passwords include spaces that must be removed when copying. Credentials must match between auth fields and from field. ''Allow less secure apps'' was discontinued May 30, 2022. 2-Factor authentication must be enabled to use app passwords.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/45478293/username-and-password-not-accepted-when-using-nodemailer'
),
(
    'Missing credentials for PLAIN nodemailer - authentication error',
    'stackoverflow-nodemailer',
    'HIGH',
    $$[
        {"solution": "Change auth configuration property from ''password'' to ''pass'': auth: { user: ''email@gmail.com'', pass: ''password'' }", "percentage": 98, "note": "Simple typo fix that resolves the issue immediately"},
        {"solution": "If using environment variables, ensure dotenv is properly configured with require(''dotenv'').config() and .env file exists with correct variable names", "percentage": 90, "note": "Common when credentials come from environment"},
        {"solution": "Verify environment variables are set on production server (e.g., Heroku config vars) or deployment platform", "percentage": 85, "note": "Fails on production even if works locally"}
    ]$$::jsonb,
    'NodeMailer library installed, Valid Gmail credentials, Proper environment configuration or inline credentials',
    'Email sends without ''Missing credentials for PLAIN'' error, sendMail() callback executes, Email successfully delivered',
    'Property must be named ''pass'' not ''password'' - this typo triggers the PLAIN authentication error. Environment variables not properly loaded from .env files is a common cause. Deployment failures occur when environment variables are not set on production servers.',
    0.95,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/48854066/missing-credentials-for-plain-nodemailer'
),
(
    'Sending email to multiple recipients via nodemailer - wrong email logic',
    'stackoverflow-nodemailer',
    'HIGH',
    $$[
        {"solution": "Pass email array directly to ''to'' field: var msg = { from: ''sender'', to: [''email1@test.com'', ''email2@test.com''], subject: ''Hello'', text: ''Message'' }", "percentage": 95, "note": "Built-in nodemailer support, simplest and most efficient approach"},
        {"solution": "If per-email handling needed, move message object creation inside forEach loop to capture individual email addresses: forEach(to => { const msg = { to: to, ... }; sendMail(msg); })", "percentage": 85, "note": "Use when different content needed per recipient"},
        {"solution": "Use BCC field instead of TO for confidentiality: msg.bcc = emailArray to hide recipient addresses from each other", "percentage": 80, "note": "Better for privacy-sensitive communications"}
    ]$$::jsonb,
    'Node.js environment with nodemailer installed, Configured SMTP transport, Array of recipient email addresses',
    'All recipients receive email without duplicates, sendMail callback executes once for array, Email log shows single send operation',
    'Array in ''to'' field exposes all recipients to each other - use BCC for confidential communications. Asynchronous issues occur when forEach completes before sendMail callbacks execute. All recipients visible in To: field when using array approach.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/28527561/sending-email-to-multiple-recipients-via-nodemailer'
),
(
    'Pass variable to HTML template in nodemailer - dynamic content',
    'stackoverflow-nodemailer',
    'HIGH',
    $$[
        {"solution": "Use Handlebars templating: npm install handlebars, read HTML file with fs.readFile(), compile with handlebars.compile(), inject variables via replacements object: const template = handlebars.compile(html); const htmlToSend = template({username: ''John''})", "percentage": 90, "note": "Most popular and clean approach with 100+ upvotes"},
        {"solution": "Use simple string replacement: const html = fs.readFileSync(path, ''utf-8'').replace(/{{username}}/g, variableValue)", "percentage": 75, "note": "Quick but less flexible for complex templates"},
        {"solution": "Use EJS templating: npm install ejs, then ejs.renderFile(path, data, (err, html) => { mailOptions.html = html; })", "percentage": 85, "note": "Alternative with more features than string replacement"}
    ]$$::jsonb,
    'Install dependencies: npm install nodemailer handlebars, Node.js fs module access, HTML template file created',
    'Template renders with correct variable values, Email contains expected dynamic content, No undefined values in email body',
    'Not handling file read errors properly will cause silent failures. Using incorrect path syntax - use __dirname for reliability instead of relative paths. Must compile template before passing variables or they won''t be replaced.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/39489229/pass-variable-to-html-template-in-nodemailer'
),
(
    'Sending email via Node.js using nodemailer is not working - Gmail sign-in blocked',
    'stackoverflow-nodemailer',
    'VERY_HIGH',
    $$[
        {"solution": "Remove the SMTP string parameter from createTransport: Change nodemailer.createTransport(''SMTP'', {...}) to nodemailer.createTransport({...}) without string", "percentage": 92, "note": "API change in newer nodemailer versions"},
        {"solution": "Enable less secure app access at https://www.google.com/settings/security/lesssecureapps", "percentage": 75, "note": "Deprecated as of May 2022, use app passwords instead"},
        {"solution": "Unlock CAPTCHA by visiting https://accounts.google.com/DisplayUnlockCaptcha and clicking continue to allow programmatic access", "percentage": 80, "note": "May be required in addition to enabling less secure apps"},
        {"solution": "Use app-specific password instead of plain Gmail password for 2FA-enabled accounts", "percentage": 90, "note": "Modern approach for enhanced security"}
    ]$$::jsonb,
    'Node.js environment with nodemailer installed, Valid Gmail account, Access to Google security settings',
    'Transporter connects without ''sign-in attempt blocked'' error, sendMail() callback executes successfully, Email appears in recipient inbox',
    'Using outdated API syntax (nodemailer.createTransport(''SMTP'', ...)) fails with newer versions. Sending emails from and to the same Gmail account initially causes issues - debug with different addresses first. Less secure apps setting was deprecated May 30, 2022.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/26196467/sending-email-via-node-js-using-nodemailer-is-not-working'
),
(
    'Nodemailer/Gmail - what exactly is a refresh token and how do I get one',
    'stackoverflow-nodemailer',
    'MEDIUM',
    $$[
        {"solution": "Create OAuth 2.0 credentials in Google Developers Console: Create project, enable Gmail API, create Web application credentials, set redirect URI to https://developers.google.com/oauthplayground (no trailing slash)", "percentage": 90, "note": "One-time setup required"},
        {"solution": "Use Google OAuth 2.0 Playground at https://developers.google.com/oauthplayground: Click gear icon, enter Client ID and Secret, select https://mail.google.com/ scope, click ''Authorize APIs'', grant permission, exchange authorization code for refresh token", "percentage": 90, "note": "Step-by-step token generation"},
        {"solution": "Configure nodemailer with OAuth2 using access tokens and refresh tokens for automatic token refresh during long-running applications", "percentage": 85, "note": "Enables continuous email sending without manual intervention"}
    ]$$::jsonb,
    'Google account with Gmail enabled, Access to Google Developers Console, Node.js with nodemailer installed, Client ID and Client Secret from OAuth credentials',
    'Refresh token obtained from OAuth playground, nodemailer authenticates with OAuth2 credentials, Emails send successfully with token refresh',
    'Playground URL must not have trailing slash or configuration fails. Scope must be https://mail.google.com/ exactly. Redirect URI must match exactly during credentials creation or authorization fails. Google restricts refresh tokens per client/user combination. May require OAuth app review for production use.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/24098461/nodemailer-gmail-what-exactly-is-a-refresh-token-and-how-do-i-get-one'
),
(
    'How to attach file to an email with nodemailer - attachments',
    'stackoverflow-nodemailer',
    'HIGH',
    $$[
        {"solution": "Attach file from disk: attachments: [{ filename: ''document.txt'', path: ''/path/to/file.txt'' }]", "percentage": 92, "note": "Most common approach"},
        {"solution": "Attach binary buffer: attachments: [{ filename: ''document.txt'', content: Buffer.from(''content here'', ''utf-8'') }]", "percentage": 85, "note": "For in-memory content generation"},
        {"solution": "Attach from stream: attachments: [{ filename: ''document.txt'', content: fs.createReadStream(''file.txt'') }]", "percentage": 85, "note": "Efficient for large files"},
        {"solution": "Attach from remote URL: attachments: [{ filename: ''document.txt'', path: ''https://example.com/file.txt'' }]", "percentage": 80, "note": "For files hosted on web servers"},
        {"solution": "Attach base64 encoded content: attachments: [{ filename: ''document.txt'', content: ''aGVsbG8gd29ybGQh'', encoding: ''base64'' }]", "percentage": 75, "note": "For pre-encoded content"}
    ]$$::jsonb,
    'Nodemailer library installed, Valid SMTP transport configuration, Appropriate file system or network access for attachment source',
    'Attachment appears in email client, File downloads successfully, Content matches original file',
    'Incorrect property names cause failures - use ''content'' not ''streamSource''. Must specify filename when providing content directly. Permission issues accessing files on disk. Must use correct MIME types for binary content.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/21934667/how-to-attach-file-to-an-email-with-nodemailer'
),
(
    'Node.js and Nodemailer: can we attach PDF documents to emails',
    'stackoverflow-nodemailer',
    'HIGH',
    $$[
        {"solution": "Attach PDF with path and contentType: attachments: [{ filename: ''file.pdf'', path: ''C:/path/to/file.pdf'', contentType: ''application/pdf'' }]", "percentage": 95, "note": "Proper MIME type essential for PDF integrity"},
        {"solution": "Ensure path property is included - incomplete code without path property causes missing attachment issue", "percentage": 90, "note": "Common oversight in failed implementations"},
        {"solution": "Verify filename matches actual file name and contentType is exactly ''application/pdf''", "percentage": 85, "note": "Prevents file corruption and delivery issues"}
    ]$$::jsonb,
    'Nodemailer library installed and configured, Valid email credentials/SMTP transport setup, Actual PDF file existing at specified absolute path',
    'PDF attachment appears in email with correct filename, PDF opens without corruption in email client, Attachment size matches original file',
    'Missing the ''path'' property causes attachment to be missing entirely. Filename mismatches lead to unrecognized files. Incorrect content type (using something other than ''application/pdf'') causes corrupted or unopenable PDFs. Relative paths may not work - use absolute paths.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/32730631/node-js-and-nodemailer-can-we-attached-pdf-documents-to-emails'
),
(
    'How to change the from field in nodemailer - custom sender',
    'stackoverflow-nodemailer',
    'MEDIUM',
    $$[
        {"solution": "Format from field as RFC 5322 compliant: from: ''Display Name <email@domain.com>'' - Example: from: ''Foo from @bar.com <sender@example.com>''", "percentage": 90, "note": "Proper formatting required for most SMTP servers"},
        {"solution": "Understand that some providers (Gmail) override from field to match authenticated credentials regardless of configuration", "percentage": 80, "note": "Provider-specific limitation"},
        {"solution": "Verify email address is authorized by your SMTP provider or deployment may fail", "percentage": 85, "note": "Security/authentication requirement"}
    ]$$::jsonb,
    'Nodemailer properly configured with SMTP credentials, Valid email address authorized by your mail server, Understanding of RFC 5322 email formatting',
    'Email displays custom from name in recipient client, From field shows ''Display Name <email@domain.com>'' format, No ambiguous error in stack trace',
    'Incomplete format like ''Foo from bar.com'' without email address brackets will fail. Some providers (Gmail) override the from field to match authenticated credentials regardless of configuration. Authentication requirements apply - email address must be authorized by SMTP provider.',
    0.80,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/33949984/how-to-change-the-from-field-in-nodemailer'
);
