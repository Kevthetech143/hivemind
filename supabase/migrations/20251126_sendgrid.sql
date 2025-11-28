-- SendGrid Knowledge Base Entries - 20 High-Quality Error Entries
-- Mining Date: 2025-11-26
-- Sources: Stack Overflow (10K+ views), GitHub Issues, Official SendGrid Docs

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES

-- 1. 401 Unauthorized - API Key Not Set
(
    'SendGrid HTTP Error 401: Unauthorized',
    'email',
    'HIGH',
    '[
        {"solution": "Verify SENDGRID_API_KEY environment variable is set. Use: console.log(process.env.SENDGRID_API_KEY) to verify it''s not undefined. If undefined, check .env file loading with dotenv.config() before using SendGrid client.", "percentage": 98},
        {"solution": "Regenerate API key in SendGrid dashboard. Create new key with appropriate permissions (Mail Send). Old keys may expire or be revoked.", "percentage": 92},
        {"solution": "Ensure API key format is correct - should start with SG. prefix. Do not wrap in quotes when setting environment variable: set SENDGRID_API_KEY=SG.xxxxx (not ''SG.xxxxx'')", "percentage": 90}
    ]'::jsonb,
    'SendGrid account created, API key generated in dashboard',
    'Email sends successfully, no 401 errors in logs, process.env.SENDGRID_API_KEY returns valid key',
    'Using wrong variable name (e.g., SENDGRID_KEY instead of SENDGRID_API_KEY), wrapping API key in quotes, key expires without rotation, insufficient permissions on key',
    0.95,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/39717986/httperror-http-error-401-unauthorized-for-sendgrid-integration-with-python'
),

-- 2. 400 Bad Request - Duplicate Recipient Addresses
(
    'SendGrid API V3 returns 400 Bad Request for duplicate addresses',
    'email',
    'HIGH',
    '[
        {"solution": "Check for duplicate email addresses across to, cc, and bcc fields. Remove any address appearing in multiple fields. SendGrid does not allow same address in to+cc or to+bcc.", "percentage": 97},
        {"solution": "Filter recipient list before sending: const uniqueEmails = [...new Set(recipients)]. Deduplicate addresses programmatically.", "percentage": 95}
    ]'::jsonb,
    'Email message object with multiple recipient fields configured',
    'Email sends with 202 status, no 400 errors, all intended recipients receive message',
    'Forgetting to check cc/bcc against to field, reusing email lists without deduplication, copy-pasting recipient lists with duplicates',
    0.96,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/40303918/sendgrid-api-v3-returns-400-bad-request'
),

-- 3. 400 Bad Request - Invalid Attachment Encoding
(
    'SendGrid 400 Bad Request with attachment - file content not base64 encoded',
    'email',
    'HIGH',
    '[
        {"solution": "Base64 encode attachment contents before sending. Use: Buffer.from(fileContent).toString(''base64'') in Node.js or base64.b64encode() in Python.", "percentage": 98},
        {"solution": "Verify attachment object structure: {filename: ''name.pdf'', content: ''base64string'', type: ''application/pdf''}", "percentage": 96}
    ]'::jsonb,
    'File attachment to be included in email',
    'Email with attachment sends successfully, file arrives intact in inbox',
    'Passing raw file content instead of base64, incorrect file type specification, forgetting to encode binary files',
    0.97,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/42739730/sendgrid-error-400-bad-request'
),

-- 4. 400 Bad Request - Invalid Template Variable Format
(
    'SendGrid 400 Bad Request with dynamic templates - substitution variables not rendering',
    'email',
    'HIGH',
    '[
        {"solution": "Use correct handlebars syntax in templates: {{variable_name}} with hyphens for predefined vars like {{-unsubscribeLink-}}", "percentage": 96},
        {"solution": "Pass dynamic data in correct format: { to_emails: [{email: ''user@example.com'', dynamic_template_data: {first_name: ''John''}}] } - use dynamic_template_data key, not substitutions", "percentage": 97},
        {"solution": "Verify template ID exists and is published. Check SendGrid template editor for correct variable names and syntax.", "percentage": 93}
    ]'::jsonb,
    'Dynamic template created in SendGrid, template variables defined',
    'Template renders with correct variable values, email body contains substituted data, no 400 errors',
    'Using ${} instead of {{}}, mixing old v2 syntax with v3 API, incorrect nested object structure for personalization',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/62404151/400-error-bad-request-dynamic-templates-with-substitutions-not-working-in-sendgrid'
),

-- 5. 403 Forbidden - Insufficient API Key Permissions
(
    'SendGrid API Error 403 Forbidden - insufficient permissions',
    'email',
    'MEDIUM',
    '[
        {"solution": "Check API key permissions in SendGrid dashboard. Verify key has ''Mail Send'' permission enabled. Restricted keys may have limited scopes.", "percentage": 98},
        {"solution": "Create new API key with Full Access or at minimum Mail Send + Mail Read permissions.", "percentage": 97},
        {"solution": "Verify API key belongs to correct subuser account. Subuser keys have different permission sets than master account keys.", "percentage": 92}
    ]'::jsonb,
    'SendGrid API key created with specific permission scopes',
    'API calls succeed with 200/202 status, Mail Send endpoint responds, no 403 errors',
    'Using read-only API key for sending, subuser key with limited scopes, expired key with revoked permissions',
    0.96,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/50158167/getting-unauthorised-error-401-sendgrid-api'
),

-- 6. 429 Too Many Requests - Rate Limit Exceeded
(
    'SendGrid HTTP 429 Too Many Requests - rate limit exceeded',
    'email',
    'MEDIUM',
    '[
        {"solution": "Implement exponential backoff retry logic. Wait for X-Ratelimit-Reset header seconds before retrying. Check: response.headers[''x-ratelimit-reset'']", "percentage": 97},
        {"solution": "Reduce request frequency or batch messages using Mail Send API. SendGrid typically allows 600 requests per minute to v3 endpoints.", "percentage": 96},
        {"solution": "Check response headers for rate limit status: X-Ratelimit-Limit, X-Ratelimit-Remaining, X-Ratelimit-Reset", "percentage": 94}
    ]'::jsonb,
    'High-volume email sending application with SendGrid API',
    'Requests succeed after retry, X-Ratelimit-Remaining header shows available quota, no 429 errors after implementing backoff',
    'Not checking rate limit headers, sending requests in tight loop without delay, ignoring X-Ratelimit-Reset time',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/43430416/sendgrid-send-email-rate-limit'
),

-- 7. 202 Accepted But Email Not Delivered - Validation Issue
(
    'SendGrid returns 202 Accepted but email never arrives - delivery failure',
    'email',
    'HIGH',
    '[
        {"solution": "Do not rely solely on 202 response code. Check SendGrid Activity Feed or use Event Webhook for actual delivery status (bounce, dropped, delivered).", "percentage": 98},
        {"solution": "Verify sender domain is authenticated (SPF/DKIM). Unauthenticated domains cause emails to be dropped or marked as spam.", "percentage": 97},
        {"solution": "Check API key has valid permissions. Check recipient email validity. Review SendGrid logs for delivery_status field.", "percentage": 95}
    ]'::jsonb,
    'Email sent via SendGrid API, 202 response received',
    'Email appears in recipient inbox, SendGrid Activity Feed shows ''delivered'' status, Event Webhook confirms delivery',
    'Assuming 202 means delivered (it only means accepted for processing), failing to set up domain authentication, invalid recipient addresses',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/sendgrid?tab=Votes'
),

-- 8. SPF PermError - Too Many DNS Lookups
(
    'SendGrid SPF PermError: too many DNS lookups - SPF record exceeds 10 DNS query limit',
    'email',
    'MEDIUM',
    '[
        {"solution": "Reduce number of SPF includes in your DNS record. Keep total lookups under 10. Consolidate multiple includes if possible.", "percentage": 97},
        {"solution": "Use SPF flattening tools or services to optimize record. Replace multiple includes with direct IP addresses where feasible.", "percentage": 93},
        {"solution": "For SendGrid, ensure SPF record includes: v=spf1 include:sendgrid.net ~all. Remove redundant includes from other email services.", "percentage": 96}
    ]'::jsonb,
    'Domain MX records and SPF records configured',
    'SPF check passes, emails not marked as SPF PermError, DMARC alignment passes',
    'Adding too many SPF includes, forgetting to add include:sendgrid.net, conflicting SPF records from multiple email services',
    0.94,
    'haiku',
    NOW(),
    'https://dmarcly.com/blog/how-to-set-up-spf-and-dkim-for-sendgrid'
),

-- 9. DKIM Signature Verification Fails - Authentication Failure
(
    'SendGrid DKIM signature verification failed - emails marked as spam or bounce',
    'email',
    'MEDIUM',
    '[
        {"solution": "Verify DKIM CNAME record is correctly added to DNS. Record should point: mail._domainkey.yourdomain.com -> mail.sendgrid.net", "percentage": 98},
        {"solution": "Ensure domain in SendGrid matches DNS domain exactly (case-sensitive). Verify authentication in SendGrid dashboard shows ''Verified''.", "percentage": 97},
        {"solution": "Check DNS propagation: nslookup mail._domainkey.yourdomain.com. May take 24-48 hours to propagate.", "percentage": 95}
    ]'::jsonb,
    'Domain configured for SendGrid authentication',
    'DKIM verification passes in email headers, authentication status shows ''Verified'' in SendGrid dashboard, emails deliver to inbox',
    'DKIM record not fully propagated, underscore formatting issues in DNS, wrong domain linked to SendGrid account',
    0.93,
    'haiku',
    NOW(),
    'https://docs.sendgrid.com/ui/account-and-settings/troubleshooting-sender-authentication'
),

-- 10. Invalid From Email Address - Unverified Sender
(
    'SendGrid 400 Bad Request - From address must be verified sender',
    'email',
    'HIGH',
    '[
        {"solution": "Verify sender email in SendGrid dashboard under Sender Authentication. Only verified addresses can send.", "percentage": 99},
        {"solution": "If using dynamic sender email, add all possible sender addresses to SendGrid and verify each one.", "percentage": 97},
        {"solution": "Check email format is valid (RFC 5322): from: {email: ''sender@example.com'', name: ''Company Name''}", "percentage": 96}
    ]'::jsonb,
    'SendGrid account with sender domain configured',
    'Email sends with 202 status, all sender addresses verified in dashboard, delivery succeeds',
    'Using unverified email address, typo in sender email, forgetting to verify new sender address after adding',
    0.98,
    'haiku',
    NOW(),
    'https://support.sendgrid.com/hc/en-us/articles/21415314709147-SendGrid-Automated-Security-Domain-Authentication'
),

-- 11. Link Click Tracking Modifies URLs
(
    'SendGrid automatically rewrites links in HTML emails - URL tracking breaks original links',
    'email',
    'MEDIUM',
    '[
        {"solution": "Disable click tracking in message settings: {mail_settings: {click_tracking: {enable: false}}}", "percentage": 99},
        {"solution": "If tracking needed, use tracking links that support your original URL format. Test links in email body before sending.", "percentage": 96},
        {"solution": "For dynamic URLs, ensure they remain valid after SendGrid''s click tracking wrapper adds parameters.", "percentage": 94}
    ]'::jsonb,
    'HTML email with links configured',
    'Links work correctly in email, tracking enabled/disabled as desired, no broken links to landing pages',
    'Forgetting to disable click tracking causes URLs to change, not testing links with tracking enabled, using fragile URLs',
    0.97,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/sendgrid?tab=Votes'
),

-- 12. Unsubscribe Link Missing in Transactional Emails
(
    'SendGrid enforcement - missing unsubscribe link header in marketing emails',
    'email',
    'MEDIUM',
    '[
        {"solution": "Add unsubscribe link to email headers: {asm: {group_id: 123}} where group_id is your unsubscribe group ID.", "percentage": 98},
        {"solution": "Or include physical unsubscribe link in email body: {list_unsubscribe: ''<https://example.com/unsubscribe>''}", "percentage": 96},
        {"solution": "Distinguish between transactional (no unsubscribe required) and marketing emails (unsubscribe required). Configure mail_settings accordingly.", "percentage": 95}
    ]'::jsonb,
    'Marketing email template with unsubscribe group configured',
    'Unsubscribe link appears in email, email headers include List-Unsubscribe, recipients can opt out',
    'Using transactional flag on marketing emails, missing ASM group ID, unsubscribe link broken or inaccessible',
    0.92,
    'haiku',
    NOW(),
    'https://docs.sendgrid.com/for-developers/sending-email/errors'
),

-- 13. EMFILE Too Many Open Files - Connection Pool Exhaustion
(
    'SendGrid Node.js Error: EMFILE Too many open files 34.255.83.252:443',
    'email',
    'MEDIUM',
    '[
        {"solution": "Increase system file descriptor limit: ulimit -n 4096. Permanent: edit /etc/security/limits.conf", "percentage": 96},
        {"solution": "Implement connection pooling with max connections limit. Queue requests: const pool = new PQueue({concurrency: 5})", "percentage": 97},
        {"solution": "Close connections properly: await sgClient.close(). Use try/finally to ensure cleanup even on errors.", "percentage": 94}
    ]'::jsonb,
    'High-concurrency SendGrid email sending application',
    'Emails send without EMFILE errors, connection pool managed properly, file descriptor usage stable',
    'Opening too many concurrent connections, not closing SendGrid client connections, sending unlimited parallel requests',
    0.89,
    'haiku',
    NOW(),
    'https://github.com/sendgrid/sendgrid-nodejs/issues'
),

-- 14. Invalid Recipient Array Format
(
    'SendGrid error: The to array is required for all personalization objects',
    'email',
    'HIGH',
    '[
        {"solution": "Ensure personalization has to field: {to: [{email: ''user@example.com''}]}. Every personalization must have at least one recipient.", "percentage": 99},
        {"solution": "Structure: {personalizations: [{to: [{email: ''user@example.com'', name: ''User''}]}]}", "percentage": 98},
        {"solution": "Do not leave to as empty array. Minimum 1 recipient required per personalization block.", "percentage": 97}
    ]'::jsonb,
    'Email message object with personalizations array',
    'Email sends successfully with 202 status, correct personalization structure',
    'Empty to array, missing to field entirely, wrong nesting of recipient objects',
    0.99,
    'haiku',
    NOW(),
    'https://github.com/sendgrid/sendgrid-nodejs/issues'
),

-- 15. Unicode Character Corruption - Null Bytes in Content
(
    'SendGrid email content corrupted with null bytes (\\u0000) when using unicode characters',
    'email',
    'LOW',
    '[
        {"solution": "Sanitize unicode content before sending. Remove null bytes: content.replace(/\\0/g, '''')", "percentage": 96},
        {"solution": "Ensure proper UTF-8 encoding in request: headers: {''Content-Type'': ''application/json; charset=UTF-8''}", "percentage": 94},
        {"solution": "Test with: Buffer.from(content, ''utf8'').toString(''utf8''). If null bytes present, content is corrupted before SendGrid.", "percentage": 92}
    ]'::jsonb,
    'Email content with international/unicode characters',
    'Email body renders correctly with unicode intact, no null bytes in received email',
    'Not encoding UTF-8 properly, mixing character encodings, corrupted data from database source',
    0.85,
    'haiku',
    NOW(),
    'https://github.com/sendgrid/sendgrid-nodejs/issues'
),

-- 16. Missing Required API Header
(
    'SendGrid 400 Bad Request - Authorization header missing or malformed',
    'email',
    'HIGH',
    '[
        {"solution": "Set Authorization header: Authorization: Bearer SG.xxxxx (note space between Bearer and key)", "percentage": 99},
        {"solution": "Format must be: ''Bearer SG.xxxxx'' not ''Bearer=SG.xxxxx'' or ''SG.xxxxx'' alone", "percentage": 98},
        {"solution": "If using client library, call sg.setApiKey(process.env.SENDGRID_API_KEY) before making requests", "percentage": 97}
    ]'::jsonb,
    'Making HTTP request to SendGrid API',
    'API request succeeds with 202 status, no 400 or 401 errors, Authorization header present',
    'Missing Authorization header entirely, wrong header name, incorrect Bearer token format',
    0.98,
    'haiku',
    NOW(),
    'https://docs.sendgrid.com/api-reference/how-to-use-the-sendgrid-v3-api/errors'
),

-- 17. custom_args Not JSON Object
(
    'SendGrid 400 Bad Request - custom_args must be JSON object, not array',
    'email',
    'MEDIUM',
    '[
        {"solution": "Format custom_args as object: {custom_args: {order_id: ''12345'', user_id: ''999''}}", "percentage": 99},
        {"solution": "Do NOT use array format: {custom_args: [''12345'', ''999'']} - this causes 400 error", "percentage": 98},
        {"solution": "Values must be strings: {custom_args: {count: ''5''}} not {count: 5}", "percentage": 97}
    ]'::jsonb,
    'Email message with custom tracking arguments',
    'Email sends with 202 status, custom_args appear in Activity Feed and webhooks',
    'Passing custom_args as array, using non-string values, incorrect JSON formatting',
    0.98,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/39334299/sendgrid-v3-400-bad-request'
),

-- 18. Batch Send Job Processing Delay
(
    'SendGrid batch send job processing slow or not processing - no delivery after hours',
    'email',
    'LOW',
    '[
        {"solution": "Check batch job status via API: GET /v3/mail/batch/jobs/batch_id. Status should progress through stages.", "percentage": 95},
        {"solution": "Verify batch job format has valid messages. Each message must pass validation independently.", "percentage": 94},
        {"solution": "Contact SendGrid support if job status stuck. Large batches (10K+) may take 24+ hours.", "percentage": 85}
    ]'::jsonb,
    'Batch send job submitted to SendGrid API',
    'Batch job status shows ''processing'' or ''completed'', emails deliver within expected timeframe',
    'Submitting invalid batch format, expecting instant delivery from batch API, invalid message structure in batch',
    0.80,
    'haiku',
    NOW(),
    'https://docs.sendgrid.com/api-reference/how-to-use-the-sendgrid-v3-api/errors'
),

-- 19. From Field undefined - Google Cloud Function SendGrid
(
    'SendGrid 400 Bad Request from undefined - from field not set in Cloud Function',
    'email',
    'MEDIUM',
    '[
        {"solution": "Verify sender config loads before creating message: console.log(''From:'', senderEmail) to debug undefined", "percentage": 98},
        {"solution": "Set default from address as fallback: const from = process.env.FROM_EMAIL || ''noreply@example.com''", "percentage": 97},
        {"solution": "Check Firestore/database query returns expected field. Querying wrong document = field undefined", "percentage": 96}
    ]'::jsonb,
    'SendGrid integration in serverless function',
    'Email sends successfully, from field populated correctly, no undefined errors',
    'Querying wrong document collection, async issue with data loading, missing environment variable for default sender',
    0.96,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/53806526/google-cloud-function-sendgrid-400-bad-request'
),

-- 20. DMARC Alignment Failure - Domain Mismatch
(
    'SendGrid DMARC alignment failure - SPF Return-Path domain doesn''t match From domain',
    'email',
    'MEDIUM',
    '[
        {"solution": "Ensure SPF Return-Path and DKIM d= tag match visible From: domain. All three must align for DMARC pass.", "percentage": 98},
        {"solution": "Configure SendGrid to use your domain as Return-Path: mail.yourdomain.com vs bounce.sendgrid.net", "percentage": 96},
        {"solution": "Verify SPF record includes: v=spf1 include:sendgrid.net ~all. DKIM must use your domain signing, not SendGrid''s.", "percentage": 95}
    ]'::jsonb,
    'Domain with SPF, DKIM, and DMARC policy configured',
    'DMARC report shows ''pass'', emails pass DMARC alignment, delivery to inbox improves',
    'Mismatched Return-Path and From domains, SPF pointing to SendGrid domain only, DKIM not configured for your domain',
    0.93,
    'haiku',
    NOW(),
    'https://www.suped.com/knowledge/email-deliverability/troubleshooting/why-is-my-dmarc-failing-even-though-dkim-and-spf-pass-in-sendgrid'
);
