INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Auth Implementation Patterns - Master JWT, OAuth2, sessions, RBAC for secure scalable access control',
  'claude-code',
  'skill',
  '[
    {"solution": "JWT Token Generation", "manual": "Use jsonwebtoken library. Create access tokens (15m expiry) and refresh tokens (7d expiry). Include userId, email, role in payload. Sign with SECRET key", "note": "Header.Payload.Signature structure"},
    {"solution": "JWT Verification Middleware", "manual": "Extract token from Authorization header (Bearer scheme). Verify with jwt.verify(). Handle TokenExpiredError and JsonWebTokenError separately", "note": "Check expiration and signature"},
    {"solution": "Refresh Token Flow", "manual": "Store refresh tokens in database hashed. Validate refresh token exists and not expired before issuing new access token. Implement logout revocation", "note": "Prevents unlimited token validity"},
    {"solution": "Session-Based Auth", "manual": "Use express-session with Redis store. Set httpOnly, secure, sameSite cookie flags. Store userId and role in session. Implement logout with session.destroy()", "note": "Stateful but simpler setup"},
    {"solution": "OAuth2 with Passport.js", "manual": "Use passport-google-oauth20, passport-github2. Set up callback URLs. Find-or-create user on OAuth callback. Generate JWT tokens on success", "note": "Delegate auth to providers"},
    {"solution": "Role-Based Access Control", "manual": "Define Role enum (USER, MODERATOR, ADMIN). Create rolePermissions mapping. Implement requireRole middleware. Check role hierarchy on each request", "note": "Simple permission model"},
    {"solution": "Permission-Based Access", "manual": "Define Permission enum with granular permissions. Map roles to permissions. Implement requirePermission middleware. Check if user has required permissions", "note": "Fine-grained control"},
    {"solution": "Resource Ownership", "manual": "Check if user owns resource before allowing CRUD. Allow admins to bypass ownership checks. Verify userId matches resource.userId", "note": "Prevent cross-user access"},
    {"solution": "Password Security", "manual": "Use bcrypt with 12 salt rounds. Validate password strength (min 12 chars, uppercase, lowercase, number, special). Store passwordHash, never plain text", "note": "bcrypt slows brute force"},
    {"solution": "Rate Limiting Auth", "cli": {"macos": "npm install express-rate-limit rate-limit-redis", "linux": "npm install express-rate-limit rate-limit-redis", "windows": "npm install express-rate-limit rate-limit-redis"}, "manual": "Limit login attempts to 5 per 15 minutes. Use Redis store for distributed rate limiting. Return 429 Too Many Requests", "note": "Prevent brute force attacks"}
  ]'::jsonb,
  'steps',
  'Node.js/TypeScript, jsonwebtoken, bcrypt, express',
  'JWT in localStorage (use httpOnly cookies), no token expiration, client-side auth only, weak password policies, missing rate limiting, trusting client data, no CSRF protection',
  'Tokens generated and verified correctly, role checks working, permissions enforced, password hashed with bcrypt, rate limits active, OAuth callbacks successful',
  'Build secure authentication with JWT, OAuth2, sessions, RBAC, and authorization patterns',
  'https://skillsmp.com/skills/wshobson-agents-plugins-developer-essentials-skills-auth-implementation-patterns-skill-md',
  'admin:HAIKU_SKILL_1764289790_5412'
);
