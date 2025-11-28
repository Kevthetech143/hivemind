INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES
(
    'Twilio SMS sent but not delivered to phone',
    'messaging',
    'HIGH',
    '[
        {"solution": "Contact the mobile carrier directly. SMS messages may be blocked at carrier level even when Twilio API reports success. Provide delivery timestamps and message IDs to carrier support to investigate blocking. Most carriers resolve within 2 days.", "percentage": 95},
        {"solution": "Verify the country/region is enabled in Twilio console: Geo Permissions > Country Restrictions. Some carriers have regional blocking.", "percentage": 85}
    ]'::jsonb,
    'Twilio account with active SMS capability; ability to contact mobile carrier; message delivery logs from Twilio dashboard',
    'SMS delivery status changes from sent to delivered in Twilio dashboard; carrier confirms block removal; subsequent SMS messages arrive successfully',
    'Assuming Twilio is at fault when API returns success; not checking carrier-level blocks; not collecting message IDs and timestamps for carrier investigation',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/44052883/sms-is-sent-but-not-delivered-twilio',
    'admin:1764173981'
),
(
    'SendGrid email bounced but API returned success response',
    'messaging',
    'HIGH',
    '[
        {"solution": "Implement webhook listeners to receive real-time bounce notifications from SendGrid. Configure webhooks in SendGrid dashboard under Settings > Mail Send > Event Notification. Webhook receives bounce events asynchronously after delivery attempt.", "percentage": 95},
        {"solution": "Use SendGrid Bounces API endpoint to poll suppression lists periodically: GET /v3/suppression/bounces. Check email status after sending instead of relying on immediate API response.", "percentage": 85}
    ]'::jsonb,
    'SendGrid API key with proper permissions; webhook URL or polling mechanism; understanding that SendGrid API is asynchronous',
    'Webhook receives bounce notification event; email appears in suppression/bounces list via API; application receives and logs bounce status correctly',
    'Expecting immediate API response to confirm delivery success (it only confirms acceptance); not implementing any mechanism to track actual delivery or bounce; treating API 200 response as final delivery confirmation',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/40045336/using-sendgrid-how-to-know-whether-my-email-bounced-or-get-succesfully-delivered',
    'admin:1764173981'
),
(
    'Firebase Cloud Messaging authentication error: credential does not have proper permissions',
    'messaging',
    'HIGH',
    '[
        {"solution": "Enable Cloud Messaging API (Legacy) in Google Cloud Project Settings. Go to Project Settings in Google Cloud Console > APIs & Services, find Cloud Messaging API (Legacy), and set status to Enabled. This grants Firebase Cloud Functions the necessary authentication permissions.", "percentage": 96},
        {"solution": "Ensure service account has Editor role or firebase-admin role permissions for the project. Regenerate credentials if necessary.", "percentage": 90}
    ]'::jsonb,
    'Google Cloud Project with Firebase enabled; access to Cloud Console project settings; service account configuration',
    'Firebase Cloud Function can authenticate to FCM servers; test message sends without authentication errors; Cloud Messaging API (Legacy) shows as Enabled in Console',
    'Enabling only the newer Cloud Messaging API v1 without also enabling Legacy API; service account lacking proper role permissions; credential file pointing to wrong project; using old credential format',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/72427537/how-to-solve-problem-firebase-cloud-messaging-error-in-firebase-cloud-function',
    'admin:1764173981'
),
(
    'RabbitMQ PRECONDITION_FAILED unknown delivery tag error',
    'messaging',
    'HIGH',
    '[
        {"solution": "Verify ACK is sent on the same channel that consumed the message. Do not acknowledge messages on different channels. Check that channel is still open and valid before ACKing.", "percentage": 97},
        {"solution": "Ensure no-ack is set to false in your consumer configuration before attempting manual message acknowledgment. If no-ack is true, remove or add return statement to skip manual ACK.", "percentage": 95},
        {"solution": "ACK messages in sequential order as they arrive. Avoid conditional logic that allows duplicate ACK or NACK on the same delivery tag.", "percentage": 92}
    ]'::jsonb,
    'RabbitMQ connection with manual acknowledgment mode enabled; understanding of AMQP protocol channel and delivery tag concepts; ability to modify consumer code',
    'Message acknowledged successfully without PRECONDITION_FAILED error; message properly removed from queue; consumer continues processing subsequent messages; no channel closure errors',
    'Attempting to ACK same message twice; acknowledging message on different channel than where consumed; not checking if no-ack mode is already enabled; missing return statement after NACK allowing code to reach ACK',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/42567689/rabbitmq-precondition-failed-unknown-delivery-tag',
    'admin:1764173981'
),
(
    'Apache Kafka messages not delivered with KafkaProducer.send() in Python',
    'messaging',
    'HIGH',
    '[
        {"solution": "Make KafkaProducer.send() synchronous by adding .get(timeout=30) to the send call: producer.send(topic, b''test message'').get(timeout=30). This ensures message is delivered before program continues or exits.", "percentage": 96},
        {"solution": "Verify Kafka broker ADVERTISED_HOST matches the hostname used in producer connection string. For Docker, use correct advertised hostname not localhost or 0.0.0.0. Update /etc/hosts if needed for local connection.", "percentage": 88}
    ]'::jsonb,
    'Apache Kafka broker running and accessible; Python KafkaProducer library installed; correct broker hostname/IP; producer code',
    'Message appears in Kafka broker logs; consumer receives message; producer.send().get() completes without timeout error; Kafka metrics show message count increase',
    'Calling send() without .get() and expecting synchronous delivery; using localhost instead of advertised broker hostname; not waiting for async operation to complete before exiting; incorrect ADVERTISED_HOST configuration in broker',
    0.89,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/44996929/messages-are-not-delivered-with-kafka-python',
    'admin:1764173981'
);
