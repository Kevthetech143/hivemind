INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'PCI Compliance - Implement PCI DSS compliance for secure payment card data handling and payment processing systems',
  'claude-code',
  'skill',
  '[{"solution":"Understand PCI DSS 12 core requirements","manual":"Study: Build secure network, protect cardholder data, maintain vulnerability management, implement access control, monitor networks, maintain security policy","note":"Different compliance levels based on transaction volume"},{"solution":"Implement data minimization","manual":"Never store CVV, PIN, or magnetic stripe data. Mask card numbers in logs. Store only allowed data (PAN, expiration, cardholder name).","note":"Data minimization is first line of defense"},{"solution":"Implement tokenization","manual":"Use payment processor tokens (Stripe, Square, PayPal). Client generates token from card data. Server processes token only, never sees card details.","note":"Reduces PCI scope significantly"},{"solution":"Encrypt data at rest and in transit","manual":"Use AES-256-GCM for encryption. Enforce TLS 1.2+ for transit. Use HTTPS only.","note":"Keys must be 256-bit (32 bytes)"},{"solution":"Implement access controls","manual":"Create PCI access roles. Restrict access by business need-to-know. Require multi-factor authentication for payment systems.","note":"Use decorators/middleware to enforce access"},{"solution":"Setup audit logging","manual":"Log all access to cardholder data with timestamp, user, action, result. Store logs securely and append-only. Review logs regularly.","note":"Audit trails required for compliance"}]'::jsonb,
  'steps',
  'Knowledge of payment systems, Python/Node.js, encryption, database security, HTTPS/TLS',
  'Storing prohibited data (CVV, PIN); Not encrypting sensitive data; Using weak encryption; No access controls; Missing audit logs; Unencrypted network transmission; Default passwords; Inadequate security testing',
  'All prohibited data removed from systems; Tokenization working with payment processor; Encryption keys secure and rotated; Access logs comprehensive; Audit logs immutable; PCI SAQ completed; Regular penetration testing performed',
  'Master PCI DSS compliance for secure payment processing with data minimization, tokenization, and encryption',
  'https://skillsmp.com/skills/wshobson-agents-plugins-payment-processing-skills-pci-compliance-skill-md',
  'admin:HAIKU_SKILL_1764289759_1793'
);
