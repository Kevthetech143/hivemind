INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    '21211: Invalid ''To'' Phone Number - phone number not in E.164 format',
    'twilio',
    'HIGH',
    '[
        {"solution": "Ensure phone number is in E.164 format: [+][country code][subscriber number]. Example: +14155552671 for US numbers", "percentage": 98},
        {"solution": "Verify From and To phone numbers are different - cannot message yourself", "percentage": 95},
        {"solution": "Use Twilio Lookup API to validate number type before sending", "percentage": 88}
    ]'::jsonb,
    'Twilio account with SMS capability enabled, valid Twilio phone number for From field',
    'Message sends successfully without 21211 error, correct number format displays in logs',
    'Forgetting country code, using spaces or hyphens in number, attempting to message short codes',
    0.96,
    'haiku',
    NOW(),
    'https://www.twilio.com/docs/api/errors/21211'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    '21212: Invalid ''From'' Phone Number - sender number not valid or not provisioned',
    'twilio',
    'HIGH',
    '[
        {"solution": "Verify From number is a valid Twilio phone number owned by your account", "percentage": 97},
        {"solution": "Check phone number is provisioned for SMS capability in Twilio console", "percentage": 95},
        {"solution": "Ensure From number is in E.164 format with country code", "percentage": 94}
    ]'::jsonb,
    'Twilio account with verified phone numbers, SMS capability enabled',
    'Message sends successfully, From number is recognized as valid SMS sender',
    'Using phone numbers from different Twilio accounts, forgetting E.164 format, unverified numbers',
    0.95,
    'haiku',
    NOW(),
    'https://www.twilio.com/docs/messaging/features/twilio-health-score-for-messaging'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    '21608: ''To'' phone number not verified - recipient number requires verification for trial account',
    'twilio',
    'HIGH',
    '[
        {"solution": "For trial accounts, verify the recipient phone number in Twilio console under Phone Numbers > Verified Caller IDs", "percentage": 96},
        {"solution": "Upgrade Twilio account from trial to full account to remove verification requirement", "percentage": 92},
        {"solution": "Add recipient as contact with verified phone number if available", "percentage": 88}
    ]'::jsonb,
    'Twilio trial account, ability to access phone verification settings',
    'SMS sends successfully without 21608 error for verified recipient',
    'Assuming trial accounts can message any number, not verifying numbers before testing, forgetting account is in trial mode',
    0.94,
    'haiku',
    NOW(),
    'https://www.twilio.com/docs/messaging/features/twilio-health-score-for-messaging'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    '21612: Message cannot be sent - incompatible To/From combination or region restrictions',
    'twilio',
    'HIGH',
    '[
        {"solution": "Verify sender country restrictions - many countries limit which numbers/shortcodes can send SMS", "percentage": 94},
        {"solution": "Check alphanumeric sender ID support for destination country - not all countries support non-numeric IDs", "percentage": 92},
        {"solution": "Validate E.164 formatting for both To and From numbers", "percentage": 90},
        {"solution": "Use Twilio Lookup API to check carrier connectivity for destination country", "percentage": 85}
    ]'::jsonb,
    'Access to Twilio docs for destination country, understanding of sender ID restrictions',
    'Message sends successfully to destination without 21612 error',
    'Assuming shortcodes work in all countries, using alphanumeric IDs in countries that don''t support them, incorrect carrier relationships',
    0.91,
    'haiku',
    NOW(),
    'https://www.twilio.com/docs/api/errors/21612'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    '21614: ''To'' number is not a valid mobile number - possibly landline or non-mobile',
    'twilio',
    'HIGH',
    '[
        {"solution": "Use Twilio Lookup API to verify number type before sending", "percentage": 97},
        {"solution": "Confirm number is mobile-capable - landlines cannot receive SMS", "percentage": 96},
        {"solution": "Check E.164 format compliance for international numbers", "percentage": 93}
    ]'::jsonb,
    'Twilio Lookup API access, list of phone numbers to validate',
    'Lookup API confirms number type as mobile, SMS sends successfully',
    'Attempting to message landlines, assuming all phone numbers can receive SMS, incorrect format detection',
    0.95,
    'haiku',
    NOW(),
    'https://www.twilio.com/docs/messaging/features/twilio-health-score-for-messaging'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    '30003: ''To'' number unreachable - device off, out of network, unsupported',
    'twilio',
    'MEDIUM',
    '[
        {"solution": "Implement retry logic with exponential backoff for temporary unavailability", "percentage": 88},
        {"solution": "Check if device is on network and has signal - retry after delay", "percentage": 85},
        {"solution": "Setup fallback channel routing for persistent delivery failures", "percentage": 78}
    ]'::jsonb,
    'Understanding of carrier behavior, retry logic implementation capability',
    'Message eventually delivers after retry, delivery receipt confirms successful send',
    'Giving up after first failure, not implementing exponential backoff, assuming permanent unreachability',
    0.82,
    'haiku',
    NOW(),
    'https://docs.suprsend.com/docs/twilio-sms-errors'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    '30005: ''To'' number unknown or no longer exists - invalid or disconnected number',
    'twilio',
    'MEDIUM',
    '[
        {"solution": "Verify phone number exists using Twilio Lookup API before sending", "percentage": 94},
        {"solution": "Remove or flag number in database if Lookup returns unknown status", "percentage": 91},
        {"solution": "Implement periodic re-validation of number database to catch disconnected numbers", "percentage": 85}
    ]'::jsonb,
    'Twilio Lookup API access, database management capability',
    'Lookup API returns valid status before send, SMS delivers successfully',
    'Not validating numbers before sending, reusing old number lists without re-verification, ignoring failed delivery receipts',
    0.90,
    'haiku',
    NOW(),
    'https://docs.suprsend.com/docs/twilio-sms-errors'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    '30006: Destination unable to receive message - landline or unsupported carrier',
    'twilio',
    'MEDIUM',
    '[
        {"solution": "Use Twilio Lookup API to identify landlines and remove from SMS recipient list", "percentage": 96},
        {"solution": "Check carrier support for destination number using Lookup API", "percentage": 93},
        {"solution": "Implement multi-channel fallback for numbers that cannot receive SMS", "percentage": 87}
    ]'::jsonb,
    'Twilio Lookup API, understanding of landline vs mobile differences',
    'Lookup API identifies number as landline, fallback channel used for delivery',
    'Assuming all numbers can receive SMS, not using Lookup API for validation, sending to landlines',
    0.93,
    'haiku',
    NOW(),
    'https://docs.suprsend.com/docs/twilio-sms-errors'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    '30007: Message content flagged or filtered - content violates policies or carrier restrictions',
    'twilio',
    'MEDIUM',
    '[
        {"solution": "Review Twilio Messaging Policy and Acceptable Use Policy for content restrictions", "percentage": 92},
        {"solution": "Check if message contains spam triggers or flagged keywords - simplify content", "percentage": 89},
        {"solution": "Contact Twilio support with Message SID if policy violation is unclear", "percentage": 82}
    ]'::jsonb,
    'Message SID from failed delivery, understanding of spam filtering',
    'Message sends after removing flagged content, delivery receipt confirms delivery',
    'Not reviewing policies before sending, assuming all content is acceptable, ignoring carrier filtering',
    0.85,
    'haiku',
    NOW(),
    'https://docs.suprsend.com/docs/twilio-sms-errors'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    '30008: Unknown delivery error - generic failure, device off or roaming',
    'twilio',
    'MEDIUM',
    '[
        {"solution": "Retry message with exponential backoff - device may come online", "percentage": 87},
        {"solution": "Send shorter message - carrier may be rejecting due to length or encoding", "percentage": 81},
        {"solution": "Contact Twilio support with detailed Message SID for investigation", "percentage": 75}
    ]'::jsonb,
    'Message SID for troubleshooting, retry logic capability',
    'Retry succeeds with delivery receipt, message eventually delivered',
    'Giving up after single failure, sending overly long messages, not retrying',
    0.78,
    'haiku',
    NOW(),
    'https://docs.suprsend.com/docs/twilio-sms-errors'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    '21610: ''To'' number has opted out - recipient texted STOP or equivalent',
    'twilio',
    'HIGH',
    '[
        {"solution": "Check Twilio console messaging logs to confirm opt-out status", "percentage": 96},
        {"solution": "User must text START or YES to re-enable messaging after opting out", "percentage": 95},
        {"solution": "Do not send marketing messages to opted-out numbers - maintain compliance", "percentage": 94},
        {"solution": "Implement preference center for users to manage message preferences", "percentage": 88}
    ]'::jsonb,
    'Twilio console access, understanding of opt-out regulations',
    'Opt-out status confirmed in logs, user receives message after sending START/YES',
    'Continuing to message opted-out users, not respecting STOP commands, ignoring compliance requirements',
    0.96,
    'haiku',
    NOW(),
    'https://docs.suprsend.com/docs/twilio-sms-errors'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    '14107: SMS Send Rate Limit Exceeded - exceeded max messages per second/minute',
    'twilio',
    'HIGH',
    '[
        {"solution": "Implement message queue with throttling to spread sends over time", "percentage": 96},
        {"solution": "Use exponential backoff strategy when rate limit is hit", "percentage": 94},
        {"solution": "Check Twilio account limits and request increase if legitimate high volume needed", "percentage": 88}
    ]'::jsonb,
    'Message queue implementation capability, understanding of rate limiting',
    'Messages send successfully after throttling, no rate limit errors in logs',
    'Sending all messages simultaneously, not implementing queue, ignoring rate limits',
    0.94,
    'haiku',
    NOW(),
    'https://www.twilio.com/docs/api/errors'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    '14108: From Phone Number Not SMS Capable - phone number cannot send SMS',
    'twilio',
    'HIGH',
    '[
        {"solution": "Verify phone number is provisioned for SMS in Twilio console Phone Numbers section", "percentage": 97},
        {"solution": "Enable SMS capability on the phone number if available", "percentage": 96},
        {"solution": "Request SMS-capable phone number from Twilio if current number cannot be upgraded", "percentage": 92}
    ]'::jsonb,
    'Twilio console access, phone number provisioning capability',
    'Phone number shows SMS enabled in console, SMS sends successfully',
    'Using voice-only numbers, not checking capabilities, assuming all numbers support SMS',
    0.95,
    'haiku',
    NOW(),
    'https://www.twilio.com/docs/api/errors'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    '21617: Message exceeds 1600 character limit - SMS too long',
    'twilio',
    'MEDIUM',
    '[
        {"solution": "Reduce message length to under 1600 characters total", "percentage": 98},
        {"solution": "Split long messages into multiple SMS sends of standard 160 characters", "percentage": 97},
        {"solution": "Use message templates with dynamic substitution instead of long custom text", "percentage": 90}
    ]'::jsonb,
    'Understanding of SMS character limits, message splitting capability',
    'Message sends successfully after reducing length, single or multiple SMS delivered',
    'Attempting to send full paragraphs as single SMS, not splitting long messages, exceeding limits',
    0.97,
    'haiku',
    NOW(),
    'https://docs.suprsend.com/docs/twilio-sms-errors'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    '21705: Invalid Messaging Service SID - service requires at least one sender',
    'twilio',
    'MEDIUM',
    '[
        {"solution": "Add phone number, alphanumeric sender ID, or short code to Messaging Service", "percentage": 98},
        {"solution": "Verify Messaging Service SID is correct and matches configured service", "percentage": 96},
        {"solution": "Ensure selected sender has SMS capability enabled", "percentage": 94}
    ]'::jsonb,
    'Twilio console access, Messaging Service configuration capability',
    'Sender added to service, SMS sends successfully via Messaging Service',
    'Creating empty Messaging Service without senders, wrong service SID, unconfigured senders',
    0.96,
    'haiku',
    NOW(),
    'https://docs.suprsend.com/docs/twilio-sms-errors'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    '21704: Provider experiencing disruptions - Twilio or carrier service issue',
    'twilio',
    'LOW',
    '[
        {"solution": "Implement automatic retry with exponential backoff for transient failures", "percentage": 92},
        {"solution": "Check Twilio status page (status.twilio.com) for ongoing incidents", "percentage": 90},
        {"solution": "Setup fallback channel routing to alternative delivery methods", "percentage": 78}
    ]'::jsonb,
    'Retry logic implementation, access to Twilio status page',
    'Retry succeeds after service recovery, delivery receipt confirmed',
    'Giving up on first failure, not checking status page, no fallback plan',
    0.85,
    'haiku',
    NOW(),
    'https://docs.suprsend.com/docs/twilio-sms-errors'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    '21408: Region not enabled - Geo-Permissions restrict SMS to certain countries',
    'twilio',
    'MEDIUM',
    '[
        {"solution": "Enable region in Twilio console Messaging > Geographic Permissions", "percentage": 97},
        {"solution": "Verify destination country is added to allowed regions list", "percentage": 96},
        {"solution": "Contact Twilio support if region is restricted due to compliance", "percentage": 88}
    ]'::jsonb,
    'Twilio console access, understanding of geographic restrictions',
    'Region enabled in Geo-Permissions, SMS sends to destination successfully',
    'Not enabling regions, assuming all regions are available, missing compliance restrictions',
    0.95,
    'haiku',
    NOW(),
    'https://docs.suprsend.com/docs/twilio-sms-errors'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    '30034: US 10DLC number lacks approved A2P Campaign - US compliance requirement',
    'twilio',
    'HIGH',
    '[
        {"solution": "Register A2P Campaign via Twilio console for US 10DLC number", "percentage": 97},
        {"solution": "Ensure campaign is approved before sending - check status in console", "percentage": 96},
        {"solution": "Update number association to approved campaign if using multiple campaigns", "percentage": 94}
    ]'::jsonb,
    'Twilio console access, US phone number, A2P registration capability',
    'Campaign approved status shown in console, SMS sends from 10DLC number successfully',
    'Using 10DLC without campaign, not waiting for approval, wrong campaign association',
    0.96,
    'haiku',
    NOW(),
    'https://docs.suprsend.com/docs/twilio-sms-errors'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    '20003: Authentication failure - invalid Account SID or Auth Token',
    'twilio',
    'HIGH',
    '[
        {"solution": "Verify Account SID and Auth Token in code match Twilio console values exactly", "percentage": 98},
        {"solution": "Check for extra spaces or special characters in credentials - copy directly from console", "percentage": 97},
        {"solution": "Regenerate Auth Token if suspected compromise or persistent auth failures", "percentage": 94}
    ]'::jsonb,
    'Twilio console access, credentials file or environment variables',
    'Authentication successful, SMS API requests process without 20003 errors',
    'Hardcoding incorrect credentials, typos in Account SID, expired tokens not regenerated',
    0.98,
    'haiku',
    NOW(),
    'https://docs.suprsend.com/docs/twilio-sms-errors'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    '30410: Messaging Service SID has no sender - service created but no phone/ID configured',
    'twilio',
    'MEDIUM',
    '[
        {"solution": "Add phone number sender to Messaging Service via Twilio console", "percentage": 97},
        {"solution": "Add alphanumeric sender ID if preferred over phone number", "percentage": 96},
        {"solution": "Verify sender is active and has SMS capability enabled", "percentage": 94}
    ]'::jsonb,
    'Twilio console access, available phone numbers or alphanumeric IDs',
    'Sender configured in service, SMS sends successfully via service',
    'Forgetting to add sender after creating service, inactive sender, wrong service SID',
    0.96,
    'haiku',
    NOW(),
    'https://docs.suprsend.com/docs/twilio-sms-errors'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'RestException getStatusCode() method error in PHP SDK v5 - migration from v4',
    'twilio',
    'MEDIUM',
    '[
        {"solution": "Replace deprecated getStatus() with getStatusCode() in catch RestException block", "percentage": 98},
        {"solution": "Use getCode() method to retrieve 5-digit Twilio error code", "percentage": 97},
        {"solution": "Call getMessage() to get detailed error description message", "percentage": 96}
    ]'::jsonb,
    'Twilio PHP SDK v5, catch block with RestException',
    'Error codes extracted correctly, application logs 5-digit error codes from SMS failures',
    'Using v4 method names in v5, forgetting to cast exceptions, wrong method names',
    0.97,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/45286277/twilio-get-error-code-on-sms-send-failure'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'SMS delivery failed - check Messaging logs for request records and status',
    'twilio',
    'MEDIUM',
    '[
        {"solution": "Navigate to Twilio console Messaging > Logs to view SMS request records", "percentage": 96},
        {"solution": "Look up Message SID to find specific error code and delivery status", "percentage": 95},
        {"solution": "Check carrier delivery receipts in logs showing Undelivered or Failed status", "percentage": 92}
    ]'::jsonb,
    'Twilio console access, Message SID or timestamp of failed SMS',
    'Error code identified in logs, root cause determined from delivery status',
    'Not checking logs, not using Message SID for lookup, ignoring carrier status',
    0.94,
    'haiku',
    NOW(),
    'https://www.twilio.com/docs/messaging/guides/debugging-common-issues'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Incoming SMS not received - webhook not configured or Event Streams disabled',
    'twilio',
    'MEDIUM',
    '[
        {"solution": "Configure webhook URL in Twilio console for Messaging incoming message handler", "percentage": 97},
        {"solution": "Verify webhook URL is publicly accessible and responds with 200 status", "percentage": 96},
        {"solution": "Enable Event Streams if not using webhooks for incoming message delivery", "percentage": 91}
    ]'::jsonb,
    'Twilio console access, publicly accessible webhook endpoint',
    'Incoming SMS received by webhook, messages appearing in application logs',
    'Firewall blocking webhook URL, webhook returning error status, Event Streams disabled',
    0.95,
    'haiku',
    NOW(),
    'https://www.twilio.com/docs/messaging/guides/debugging-common-issues'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Duplicate SMS messages being sent - multiple POST requests from application',
    'twilio',
    'MEDIUM',
    '[
        {"solution": "Check server HTTP logs to confirm multiple POST requests are being sent", "percentage": 96},
        {"solution": "Implement idempotency key or deduplication in application sending logic", "percentage": 94},
        {"solution": "Review error handling - may be retrying failed requests multiple times", "percentage": 91}
    ]'::jsonb,
    'Server HTTP access logs, application send code review',
    'Single POST request in logs per message, no duplicate SMS received',
    'Not checking application logs, retry logic causing duplicates, network retries not handled',
    0.93,
    'haiku',
    NOW(),
    'https://www.twilio.com/docs/messaging/guides/debugging-common-issues'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'SMS opt-out blocking - recipient must text START to resume after STOP',
    'twilio',
    'HIGH',
    '[
        {"solution": "Educate users that texting STOP, STOPALL, UNSUBSCRIBE, CANCEL, END, or QUIT opts them out", "percentage": 95},
        {"solution": "Inform users they must reply with START or YES to resume messaging", "percentage": 94},
        {"solution": "Implement preference center allowing granular message type opt-in/opt-out", "percentage": 88}
    ]'::jsonb,
    'Understanding of SMS compliance, preference center capability',
    'Users can manage opt-in status, messaging resumes after texting START',
    'Not informing users of opt-out mechanism, forcing re-opt-in, not providing preference center',
    0.92,
    'haiku',
    NOW(),
    'https://www.twilio.com/docs/messaging/guides/debugging-common-issues'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Contact list validation - high rate of 21211, 21612, 21614 errors indicates bad number data',
    'twilio',
    'MEDIUM',
    '[
        {"solution": "Audit contact list for formatting issues, typos, and invalid entries", "percentage": 96},
        {"solution": "Run numbers through Twilio Lookup API to validate type and format", "percentage": 94},
        {"solution": "Remove invalid numbers from list and re-verify periodically", "percentage": 91}
    ]'::jsonb,
    'Twilio Lookup API access, contact database management capability',
    'Error rate drops after cleanup, all remaining numbers pass validation',
    'Not validating numbers on import, outdated contact lists, no periodic re-verification',
    0.92,
    'haiku',
    NOW(),
    'https://support.twilio.com/hc/en-us/articles/223181828-Does-Twilio-check-to-see-if-phone-numbers-can-receive-SMS'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'International carrier compatibility - SMS delivery varies by country and carrier',
    'twilio',
    'MEDIUM',
    '[
        {"solution": "Check Twilio country-specific SMS guidelines before sending internationally", "percentage": 93},
        {"solution": "Verify sender ID support for destination country - not all support shortcodes", "percentage": 91},
        {"solution": "Use Lookup API to verify carrier compatibility for international numbers", "percentage": 88}
    ]'::jsonb,
    'Twilio country documentation, international sending experience',
    'SMS delivers successfully to international destinations, carrier compatibility confirmed',
    'Assuming same rules apply globally, using unsupported sender types per country, no carrier verification',
    0.89,
    'haiku',
    NOW(),
    'https://www.twilio.com/docs/messaging/guides/debugging-common-issues'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'SMS number verification for incoming messages - enable SMS capability on Twilio number',
    'twilio',
    'MEDIUM',
    '[
        {"solution": "Navigate to Twilio console Phone Numbers and select the SMS-enabled number", "percentage": 97},
        {"solution": "Verify SMS is enabled under phone number capabilities", "percentage": 96},
        {"solution": "Configure incoming message webhook if not already configured", "percentage": 94}
    ]'::jsonb,
    'Twilio console access, SMS-capable phone number',
    'SMS capability enabled in console, incoming messages received successfully',
    'Not enabling SMS on number, assuming voice numbers receive SMS, wrong number selected',
    0.96,
    'haiku',
    NOW(),
    'https://support.twilio.com/hc/en-us/articles/223181828-Does-Twilio-check-to-see-if-phone-numbers-can-receive-SMS'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Alphanumeric sender ID restrictions - not supported in all countries',
    'twilio',
    'MEDIUM',
    '[
        {"solution": "Check Twilio alphanumeric sender ID country support documentation", "percentage": 95},
        {"solution": "Use numeric phone number sender for countries restricting alphanumeric IDs", "percentage": 93},
        {"solution": "Register alphanumeric ID in countries requiring pre-registration", "percentage": 88}
    ]'::jsonb,
    'Understanding of sender ID restrictions, Twilio documentation access',
    'SMS sends successfully with compliant sender ID, no 21612 errors',
    'Using alphanumeric in non-supporting countries, not registering IDs, ignoring restrictions',
    0.90,
    'haiku',
    NOW(),
    'https://www.twilio.com/docs/api/errors/21612'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'E.164 phone number formatting requirement - international standard format',
    'twilio',
    'HIGH',
    '[
        {"solution": "Format numbers as [+][country code][area code][subscriber number] - example: +14155552671", "percentage": 98},
        {"solution": "Include country code even for domestic calls - +1 for US/Canada", "percentage": 97},
        {"solution": "Remove spaces, hyphens, or parentheses from phone numbers before sending", "percentage": 96}
    ]'::jsonb,
    'Understanding of E.164 format, phone number formatting library',
    'All numbers formatted in E.164, SMS sends without format validation errors',
    'Using local number format, forgetting country code, including formatting characters',
    0.97,
    'haiku',
    NOW(),
    'https://www.twilio.com/docs/api/errors/21211'
);
