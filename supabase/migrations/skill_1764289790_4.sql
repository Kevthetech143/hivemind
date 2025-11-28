INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Stripe Integration - Implement PCI-compliant payment processing with checkout, subscriptions, and webhooks',
  'claude-code',
  'skill',
  '[
    {"solution": "One-Time Payment Checkout", "manual": "Use stripe.checkout.Session.create() with mode=payment. Include line_items with product_data and unit_amount in cents. Set success and cancel URLs. Redirect to session.url", "note": "Fastest implementation, Stripe-hosted"},
    {"solution": "Custom Payment Intent Flow", "manual": "Create PaymentIntent with stripe.PaymentIntent.create(). Return client_secret to frontend. Use Stripe.js with confirmCardPayment(). Handle succeeded or requires_action status", "note": "Full UI control"},
    {"solution": "Subscription Creation", "manual": "Use stripe.Subscription.create() with customer_id and price_id. Set payment_behavior=default_incomplete. Expand latest_invoice for client_secret. Use for recurring charges", "note": "Recurring billing"},
    {"solution": "Customer Portal", "manual": "Call stripe.billing_portal.Session.create() with customer_id. Redirect customer to session.url. Allows self-service subscription management", "note": "Customer control"},
    {"solution": "Webhook Verification", "manual": "Use stripe.Webhook.construct_event() with payload, sig_header, endpoint_secret. Verifies signature and constructs event object. Always verify before processing", "note": "Security critical"},
    {"solution": "Handle Webhook Events", "manual": "Subscribe to events: payment_intent.succeeded, payment_intent.payment_failed, customer.subscription.deleted, charge.refunded. Update database on each event", "note": "Source of truth for payments"},
    {"solution": "Webhook Idempotency", "manual": "Check if event.id already processed before handling. Store processed event IDs in database. Prevent duplicate processing on retries", "note": "Critical for correctness"},
    {"solution": "Customer Management", "manual": "Use stripe.Customer.create() with email, name, metadata. Attach payment methods with attach(). Set default payment method. Store customer_id in database", "note": "Recurring customer data"},
    {"solution": "Refund Handling", "manual": "Use stripe.Refund.create() with payment_intent. Optional: specify amount for partial refund, reason for refund_policy. Handle in webhook", "note": "Process refunds safely"},
    {"solution": "Test Payment Cards", "manual": "Use test mode keys (sk_test_). Test cards: 4242...4242 (success), 4000...0002 (declined), 4000...3155 (3D Secure). Never use real cards in test mode", "note": "Validate flows before production"}
  ]'::jsonb,
  'steps',
  'Python/Node.js, Stripe account, stripe package, HTTPS endpoint',
  'Not verifying webhook signatures, missing idempotent event handling, hardcoding amounts instead of cents, not testing with test cards, missing webhook events, client-side only confirmation, storing raw card data',
  'Checkout sessions created and redirecting, webhooks verifying correctly, payments succeeding in test mode, refunds processing, subscriptions recurring on schedule, portal sessions working',
  'Integrate Stripe for PCI-compliant payments with checkout, subscriptions, customers, and webhooks',
  'https://skillsmp.com/skills/wshobson-agents-plugins-payment-processing-skills-stripe-integration-skill-md',
  'admin:HAIKU_SKILL_1764289790_5412'
);
