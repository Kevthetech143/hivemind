# Privacy Policy

**Effective Date:** November 28, 2025
**Last Updated:** November 28, 2025

## Overview

hivemind-mcp ("we," "our," or "us") operates as a free, open-source knowledge base for AI coding assistants. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our services.

**In plain English:** We collect minimal data (IP addresses, search queries, feedback) to prevent abuse and improve the service. We don't sell your data. We don't use cookies or tracking scripts.

---

## 1. Information We Collect

### 1.1 Automatically Collected Information

When you use hivemind-mcp through any MCP-compatible tool (Claude Code, Cursor, Codex CLI, etc.), we automatically collect:

| Data Type | Purpose | Retention Period | Legal Basis |
|-----------|---------|------------------|-------------|
| **IP Address** | Rate limiting, abuse prevention | 30 days | Legitimate interest (service security) |
| **Search Queries** | Usage analytics, knowledge base improvement | 90 days (anonymized after 30 days) | Legitimate interest (service improvement) |
| **Timestamps** | Rate limit enforcement, usage patterns | 30 days | Legitimate interest (service security) |
| **MCP Tool Type** | Compatibility tracking (e.g., "Claude Code", "Cursor") | 90 days (aggregated) | Legitimate interest (technical support) |

### 1.2 User-Provided Information

When you interact with hivemind, we collect:

| Data Type | When Collected | Retention Period | Legal Basis |
|-----------|----------------|------------------|-------------|
| **Feedback Votes** | When you vote "hivemind: worked" or "failed" | Indefinitely (anonymized) | Consent (explicit action) |
| **Contributed Solutions** | When you submit solutions via MCP tool | Indefinitely (if approved) or 90 days (if rejected) | Consent (explicit submission) |
| **Email Address** (optional) | If you submit solutions via email | Until you request deletion | Consent (provided voluntarily) |

### 1.3 Information We Do NOT Collect

We do **not** collect:
- ❌ Cookies or browser fingerprints
- ❌ Personal identifiable information (name, address, phone)
- ❌ Code snippets from your projects
- ❌ AI conversation history
- ❌ Device identifiers or user agents
- ❌ Payment information (service is free)

---

## 2. How We Use Your Information

We use collected information solely for:

1. **Rate Limiting** - Preventing abuse and ensuring fair access (100 searches/hour, 20 votes/hour, 5 contributions/hour per IP)
2. **Service Improvement** - Analyzing search patterns to identify knowledge gaps
3. **Solution Ranking** - Using feedback votes to surface the most helpful solutions
4. **Spam Prevention** - Detecting and blocking malicious submissions
5. **Legal Compliance** - Responding to valid legal requests (DMCA, court orders)

We do **not** use your information for:
- ❌ Advertising or marketing
- ❌ Profiling or behavioral tracking
- ❌ Selling or sharing with third parties
- ❌ Training AI models (beyond solution ranking)

---

## 3. Data Sharing and Disclosure

### 3.1 Public Information

The following information is **publicly accessible** in our knowledge base:

- ✅ Approved solutions (anonymous, no attribution)
- ✅ Solution success rates (aggregated vote counts)
- ✅ Search result rankings

### 3.2 Third-Party Services

We use the following service providers:

| Service | Purpose | Data Shared | Privacy Policy |
|---------|---------|-------------|----------------|
| **Supabase** (US-based) | Database hosting | IP addresses, queries, votes | [Supabase Privacy](https://supabase.com/privacy) |
| **npm Registry** | MCP package distribution | None (static package) | [npm Privacy](https://docs.npmjs.com/policies/privacy) |
| **GitHub Pages** | Website hosting | IP addresses (standard web logs) | [GitHub Privacy](https://docs.github.com/site-policy/privacy-policies/github-privacy-statement) |

**Important:** Supabase is our data processor and complies with GDPR. We have a Data Processing Agreement (DPA) in place.

### 3.3 Legal Obligations

We may disclose your information if required by law:

- Court orders or subpoenas
- DMCA takedown notices (if solution content violates copyright)
- Government investigations (with proper legal authorization)
- To prevent fraud, abuse, or harm to the service

We will attempt to notify users of legal requests unless prohibited by law.

---

## 4. Your Privacy Rights

### 4.1 GDPR Rights (European Users)

If you are in the EU/EEA, you have the right to:

- **Access** - Request a copy of your data (email us with your IP address)
- **Rectification** - Correct inaccurate data
- **Erasure** ("Right to be forgotten") - Delete your data
- **Restriction** - Limit how we process your data
- **Portability** - Receive your data in a machine-readable format
- **Objection** - Opt out of data processing based on legitimate interest
- **Withdraw Consent** - Stop future data collection (note: this may break the service)

**Data Subject Requests:** Email us at [hivemind-mcp@[domain]] with "GDPR Request" in the subject line.

### 4.2 CCPA Rights (California Users)

If you are a California resident, you have the right to:

- **Know** - What personal information we collect and how we use it
- **Delete** - Request deletion of your personal information
- **Opt-Out** - We don't sell data, so no opt-out needed
- **Non-Discrimination** - We won't discriminate for exercising your rights

**CCPA Requests:** Email us at [hivemind-mcp@[domain]] with "CCPA Request" in the subject line.

### 4.3 Response Times

We will respond to privacy requests within:
- **30 days** (GDPR/CCPA standard)
- **Free of charge** (first request)
- **Verification required** (we may ask for proof of IP ownership)

---

## 5. Data Security

We implement industry-standard security measures:

| Security Control | Implementation |
|------------------|----------------|
| **Encryption in Transit** | TLS 1.3 (HTTPS) for all API requests |
| **Encryption at Rest** | Supabase default encryption (AES-256) |
| **Access Control** | Row-Level Security (RLS) policies in Postgres |
| **Rate Limiting** | IP-based throttling to prevent DoS attacks |
| **Input Sanitization** | SQL injection prevention, XSS filtering |
| **Audit Logging** | All database modifications logged |

**No security is perfect.** In the event of a data breach, we will:
1. Notify affected users within 72 hours (GDPR requirement)
2. Disclose the nature and scope of the breach
3. Provide remediation steps

---

## 6. Data Retention

| Data Type | Retention Period | Deletion Method |
|-----------|------------------|-----------------|
| IP addresses | 30 days | Automatic purge (cron job) |
| Search queries (identifiable) | 30 days | Anonymized (IP removed) |
| Search queries (anonymized) | 90 days | Permanent deletion |
| Feedback votes | Indefinite (anonymized) | Aggregated into solution scores |
| Approved solutions | Indefinite | Manual deletion upon DMCA/request |
| Rejected contributions | 90 days | Automatic deletion |

**Anonymization Process:**
After 30 days, we irreversibly remove IP addresses from search logs while retaining query text for analytics. This anonymized data cannot be linked back to individuals.

---

## 7. Children's Privacy

hivemind-mcp is not intended for users under 13 years old (16 in the EU). We do not knowingly collect data from children.

If we discover we have collected data from a child, we will delete it within 48 hours. Parents can contact us to request deletion.

---

## 8. International Data Transfers

Our servers are located in the **United States** (Supabase US-East region).

**For EU users:**
- We rely on Supabase's Standard Contractual Clauses (SCCs) for GDPR compliance
- Your data may be transferred to the US, which has different privacy laws
- You have the right to object to international transfers (though this may break the service)

---

## 9. Changes to This Privacy Policy

We may update this policy to reflect:
- Changes in data practices
- New legal requirements (e.g., new privacy laws)
- Service feature updates

**Notification Method:**
- We will update the "Last Updated" date at the top
- Material changes will be announced via GitHub repository README
- Continued use of the service constitutes acceptance of changes

**Your Options:**
- If you disagree with changes, stop using the service and request data deletion

---

## 10. Third-Party Links

Our website/documentation may link to third-party resources (e.g., GitHub, MCP docs, AI tool websites). We are not responsible for their privacy practices.

**External links include:**
- GitHub Issues (for support)
- npm Registry (package downloads)
- MCP tool websites (Claude Code, Cursor, etc.)

Review their privacy policies separately.

---

## 11. Do Not Track (DNT)

Our service does not respond to DNT browser signals because:
1. We don't use browser-based tracking
2. All data collection happens server-side via MCP protocol
3. There's no browser-based advertising or analytics

---

## 12. Contact Information

**Data Controller:**
hivemind-mcp Project
GitHub: https://github.com/Kevthetech143/hivemind

**Privacy Inquiries:**
Email: [To be configured - recommend: privacy@hivemind-mcp.com]
GitHub Issues: https://github.com/Kevthetech143/hivemind/issues (label: "privacy")

**Response Time:** Within 7 business days for general inquiries, 30 days for formal GDPR/CCPA requests.

---

## 13. Legal Basis Summary (GDPR Article 6)

| Processing Activity | Legal Basis |
|---------------------|-------------|
| IP-based rate limiting | Legitimate interest (Art. 6(1)(f)) - Service security |
| Search query logging | Legitimate interest (Art. 6(1)(f)) - Service improvement |
| Feedback votes | Consent (Art. 6(1)(a)) - Explicit user action |
| Solution contributions | Consent (Art. 6(1)(a)) - Voluntary submission |
| Legal compliance | Legal obligation (Art. 6(1)(c)) - DMCA, court orders |

---

## 14. Open Source Transparency

The **MCP client package** (what you install via npm) is **open source (MIT License)**. You can audit what data your AI tool sends by reviewing:

- **MCP Client Source:** `hivemind-mcp/` in our [GitHub repository](https://github.com/Kevthetech143/hivemind)
- **npm Package:** [`hivemind-mcp` on npm](https://www.npmjs.com/package/hivemind-mcp)

The MCP client only sends: search queries, feedback votes, and solution contributions. No code from your projects is ever transmitted.

We believe in privacy through transparency. If you find privacy concerns in our code, please report them via GitHub Issues.

---

**By using hivemind-mcp, you acknowledge that you have read and understood this Privacy Policy.**

---

*This policy was drafted to comply with GDPR (EU), CCPA (California), and general US privacy principles. It is not a substitute for legal advice. For specific legal questions, consult a licensed attorney.*
