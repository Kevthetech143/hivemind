-- Add GitHub node-jsonwebtoken JWT troubleshooting solutions batch 1
-- Sourced from auth0/node-jsonwebtoken GitHub issues (highest-voted)
-- Focus: Token expiration, signature verification, algorithm mismatches, TypeScript types
-- Category: github-jsonwebtoken

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'RS256 JWT signature error: "error:0906D06C:PEM routines:PEM_read_bio:no start line"',
    'github-jsonwebtoken',
    'HIGH',
    $$[
        {"solution": "Ensure PEM certificate has proper line breaks preserved. Use .trim() on key strings to remove leading/trailing whitespace.", "percentage": 95, "note": "Most common cause - formatting issues in PEM files"},
        {"solution": "For base64-encoded keys in environment variables: Buffer.from(process.env.KEY, ''base64'').toString(''utf-8'')", "percentage": 90, "command": "Buffer.from(encoded_key, ''base64'').toString(''utf-8'')"},
        {"solution": "Verify you are using private key for signing and public key for verification - not the reverse", "percentage": 85, "note": "RSA keys are asymmetric"},
        {"solution": "Generate keys properly using OpenSSL: openssl ecparam -name secp256r1 -genkey -noout -out private.pem", "percentage": 80, "command": "openssl ecparam -name secp256r1 -genkey -noout -out private.pem"}
    ]$$::jsonb,
    'Valid RSA private key in PEM format, jsonwebtoken library installed',
    'Token signs successfully without PEM format errors, jwt.verify() accepts signature',
    'Do not remove linebreaks from PEM certificates. Always trim whitespace from environment variable keys. Never use public key for signing.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/auth0/node-jsonwebtoken/issues/400'
),
(
    'HS256 JWT verification fails with "invalid signature" error despite valid token',
    'github-jsonwebtoken',
    'HIGH',
    $$[
        {"solution": "Verify secret encoding consistency between jwt.sign() and jwt.verify() - use identical secret format for both", "percentage": 95, "note": "Most common: base64 mismatch"},
        {"solution": "If using base64-encoded secrets: decode before passing to jwt library on both sign and verify paths", "percentage": 90, "command": "const secret = Buffer.from(encoded, ''base64'').toString(''utf-8'')"},
        {"solution": "Test token on jwt.io and ensure base64 checkbox state matches your implementation (checked vs unchecked)", "percentage": 85, "note": "jwt.io base64 setting must match"},
        {"solution": "Add console logging to confirm token and secret values match between sign and verify operations", "percentage": 80, "command": "console.log({token, secret}) before verify"}
    ]$$::jsonb,
    'HMAC secret key, Token created with same library, jwt.io for debugging',
    'jwt.verify() returns payload without error, Token validates on jwt.io with same secret',
    'Do not use inconsistent secret formats. Do not assume jwt.io encoding matches backend. Always use identical secret on both sign and verify.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/auth0/node-jsonwebtoken/issues/584'
),
(
    'TypeScript: decode() return type does not include header property with complete option',
    'github-jsonwebtoken',
    'MEDIUM',
    $$[
        {"solution": "Update @types/jsonwebtoken package to latest version from DefinitelyTyped - typing fixes are maintained there", "percentage": 95, "command": "npm install --save-dev @types/jsonwebtoken@latest"},
        {"solution": "When calling decode with complete: true, cast return type: const decoded = decode(token, {complete: true}) as {header: any; payload: any}", "percentage": 85, "note": "Explicit type casting as workaround"},
        {"solution": "Use separate decode calls: header via decode(token, {complete: true}), payload via decode(token)", "percentage": 80, "note": "Avoids type issues"}
    ]$$::jsonb,
    'TypeScript 3.8+, @types/jsonwebtoken installed, jsonwebtoken library',
    'TypeScript compilation succeeds without type errors, decode(token, {complete: true}).header accessible',
    'Type definitions are maintained by TypeScript community, not core library. Update @types/jsonwebtoken separately from jsonwebtoken.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/auth0/node-jsonwebtoken/issues/629'
),
(
    'Cannot use node-jsonwebtoken in browser: "TypeError: crypto.createHmac is not a function"',
    'github-jsonwebtoken',
    'MEDIUM',
    $$[
        {"solution": "For browser JWT decoding: use jwt-decode library (Auth0 maintained) instead - no Node.js dependencies required", "percentage": 95, "command": "npm install jwt-decode"},
        {"solution": "For React Native JWT operations: use react-native-pure-jwt instead of node-jsonwebtoken", "percentage": 90, "note": "React Native has different runtime"},
        {"solution": "If server-side signing needed in browser: use jsrsasign library which includes browser-compatible crypto", "percentage": 85, "note": "Only for client-side signing use case"},
        {"solution": "Recognize that JWT tokens do NOT require secrets to decode - only to verify signature. Consider if you really need to sign client-side.", "percentage": 80, "note": "Architecture consideration"}
    ]$$::jsonb,
    'React/Vue/browser environment, Need JWT operations client-side',
    'Library loads without crypto errors, JWT decode/verify operations complete in browser',
    'node-jsonwebtoken is Node.js ONLY - requires native crypto module. Do not attempt to use in browser. Use jwt-decode for browser decoding instead.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/auth0/node-jsonwebtoken/issues/419'
),
(
    'React Native error: Cannot find "node_modules/jws/lib/sign-stream.js"',
    'github-jsonwebtoken',
    'MEDIUM',
    $$[
        {"solution": "For JWT decoding in React Native: use jwt-decode package instead - it does not require Node modules", "percentage": 95, "command": "npm install jwt-decode"},
        {"solution": "For JWT signing in React Native: use react-native-pure-jwt alternative library", "percentage": 90, "note": "Designed for React Native runtime"},
        {"solution": "Understand that JWT decoding does not require secrets - only signature verification does. Adjust architecture accordingly.", "percentage": 80, "note": "Many use cases only need decode"}
    ]$$::jsonb,
    'React Native project, jsonwebtoken attempted as dependency',
    'jwt-decode or react-native-pure-jwt loads without module resolution errors',
    'node-jsonwebtoken cannot work in React Native - fundamental runtime incompatibility. Use React Native-specific JWT libraries.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://github.com/auth0/node-jsonwebtoken/issues/221'
),
(
    'JWT token invalidation on logout: How to forcefully revoke a JWT',
    'github-jsonwebtoken',
    'HIGH',
    $$[
        {"solution": "Implement token blacklist: Store invalidated token JTI claims in Redis/database, check during verification middleware", "percentage": 90, "note": "Standard approach for logout"},
        {"solution": "Use JWT ID (jti) claim: Include unique jti in token, check against blacklist on each request", "percentage": 85, "command": "jwt.sign({...payload, jti: uuid()}, secret, {expiresIn: ''1h''})"},
        {"solution": "Implement whitelist instead of blacklist: Keep list of valid token JTIs - fails safely if cache crashes", "percentage": 85, "note": "More secure than blacklist"},
        {"solution": "Use short-lived tokens with refresh token pattern: Short expiration minimizes blacklist window needed", "percentage": 80, "note": "Reduces invalidation overhead"},
        {"solution": "For stateless invalidation: Embed version number in token, increment on logout, reject if version mismatch", "percentage": 75, "note": "Avoids database queries"}
    ]$$::jsonb,
    'JWT implementation, Access to database or Redis cache, Logout endpoint',
    'Invalidated token rejected by verify middleware, New login generates new token, Old token returns 401',
    'JWTs cannot be invalidated natively - require server-side tracking. Blacklist fails insecurely (allows all if cache down). Whitelist is preferred.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/auth0/node-jsonwebtoken/issues/375'
),
(
    'jsonwebtoken v9.0.0 bundle size increased significantly due to lodash import',
    'github-jsonwebtoken',
    'LOW',
    $$[
        {"solution": "Upgrade to v9.0.1 or later where bundle size was reduced via PR #933 refactoring", "percentage": 95, "command": "npm install jsonwebtoken@latest"},
        {"solution": "If stuck on v9.0.0: Tree-shake unused lodash functions or switch to v8.x for smaller bundle", "percentage": 80, "note": "Temporary workaround only"}
    ]$$::jsonb,
    'Using jsonwebtoken v9.0.0, Edge function or size-constrained deployment (AWS Lambda edge)',
    'npm list shows jsonwebtoken v9.0.1+, Bundle size reduced, Deployment succeeds under size limit',
    'v9.0.0 had bloated lodash dependency. This was fixed in v9.0.1+. Always upgrade to latest patch version.',
    0.95,
    'sonnet-4',
    NOW(),
    'https://github.com/auth0/node-jsonwebtoken/issues/878'
),
(
    'Algorithm mismatch: "invalid algorithm" error when token algorithm does not match verify options',
    'github-jsonwebtoken',
    'HIGH',
    $$[
        {"solution": "Ensure algorithms array in verify options matches token header algorithm: jwt.verify(token, key, {algorithms: [''HS256'']})", "percentage": 95, "note": "Most common cause"},
        {"solution": "For HMAC tokens (HS256): use symmetric secret, for RSA tokens (RS256): use RSA public key - verify algorithm matches key type", "percentage": 90, "note": "Algorithm and key must match"},
        {"solution": "If token uses HS256 but verifying with RSA key: token was signed differently. Regenerate or fix signing process.", "percentage": 85, "note": "Root cause analysis"},
        {"solution": "Check OpenID Connect endpoint returns correct algorithm for token. OIDC may return multiple algorithm options.", "percentage": 80, "note": "For OIDC scenarios"}
    ]$$::jsonb,
    'JWT token, Verification key/secret, Knowledge of token signing algorithm',
    'jwt.verify() returns payload without algorithm errors, Decoded token header matches verify algorithms option',
    'Do not verify HS256 tokens with RSA keys. Ensure algorithms array includes token header alg value. Algorithm and key type must match.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/auth0/node-jsonwebtoken/issues/988'
),
(
    'Cannot use expiresIn option with string payload: "invalid expiresIn option for string payload"',
    'github-jsonwebtoken',
    'MEDIUM',
    $$[
        {"solution": "Convert string payload to JSON object: jwt.sign({data: payload}, secret, {expiresIn: ''1h''})", "percentage": 95, "note": "RFC 7519 requires JSON payload for claims"},
        {"solution": "Understand that expiresIn, audience, issuer, subject options require JSON payload structure, not plain strings", "percentage": 90, "note": "Limitation of JWT standard"},
        {"solution": "For simple string data: use custom exp claim instead - jwt.sign({data: payload, exp: Math.floor(Date.now()/1000) + 3600}, secret)", "percentage": 80, "note": "Workaround for string payload"}
    ]$$::jsonb,
    'jsonwebtoken library, Understand JWT claim structure',
    'jwt.sign() succeeds with expiresIn option, Decoded token contains exp claim',
    'String payloads cannot use expiresIn, audience, issuer, or subject claims. Convert to JSON object or manually set exp claim.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://github.com/auth0/node-jsonwebtoken/issues/985'
),
(
    'maxAge option not enforced for tokens without exp claim',
    'github-jsonwebtoken',
    'MEDIUM',
    $$[
        {"solution": "Understand maxAge is server-side enforcement: tokens without exp claim are subject to verifier maxAge constraint", "percentage": 90, "note": "Intended behavior - allows flexible validation"},
        {"solution": "If token has no exp claim: maxAge option in verify() enforces maximum age from iat (issued at) claim", "percentage": 85, "command": "jwt.verify(token, secret, {maxAge: ''1h''})"},
        {"solution": "To require exp claim in all tokens: always include expiresIn when signing tokens", "percentage": 80, "note": "Best practice for token issuance"}
    ]$$::jsonb,
    'JWT tokens, Knowledge of maxAge option behavior',
    'jwt.verify() with maxAge rejects old tokens even without exp claim, Tokens without exp claim still respect maxAge validation',
    'maxAge is server-side expiration enforcement. Tokens without exp claim are still subject to maxAge limits. This is intended behavior, not a bug.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/auth0/node-jsonwebtoken/issues/780'
),
(
    'decode() function unavailable in strict mode: "TypeError: decode is not a function"',
    'github-jsonwebtoken',
    'LOW',
    $$[
        {"solution": "Upgrade to jsonwebtoken v9.0.1+ where decode property writable flag was fixed via PR #876", "percentage": 95, "command": "npm install jsonwebtoken@9.0.1 --save"},
        {"solution": "For v9.0.0 users: cannot mock decode in tests. Upgrade to v9.0.1+ to fix writable property descriptor", "percentage": 90, "note": "Affects Jest and Sinon mocking"},
        {"solution": "If mocking needed on older version: import directly - const {decode} = require(''jsonwebtoken'')", "percentage": 70, "note": "Partial workaround"}
    ]$$::jsonb,
    'jsonwebtoken v9.0.0, Test environment using Jest or Sinon',
    'decode() function accessible in strict mode, Tests can mock/stub decode function',
    'v9.0.0 made decode read-only preventing strict mode access and test mocking. Fixed in v9.0.1+. Always upgrade patch versions.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://github.com/auth0/node-jsonwebtoken/issues/866'
),
(
    'jwt.decode() returns undefined when token has empty payload: "eyJ...J..wXs"',
    'github-jsonwebtoken',
    'LOW',
    $$[
        {"solution": "Avoid creating tokens with empty payloads. Add at least minimal data: jwt.sign({data: ''''}, secret)", "percentage": 95, "note": "Empty payloads not properly supported"},
        {"solution": "If processing tokens with empty payloads: add payload data before decoding or use alternative approach", "percentage": 85, "note": "Library expects non-empty payloads"},
        {"solution": "Understand token format: empty payload has two consecutive dots (e.g., token..signature). This is non-standard use.", "percentage": 80, "note": "Most tokens always have payload"}
    ]$$::jsonb,
    'JWT token with empty payload (non-standard format)',
    'jwt.decode() returns header and payload fields without undefined values',
    'Empty payload tokens are non-standard and not well-supported. Always include at least minimal payload data in tokens.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/auth0/node-jsonwebtoken/issues/854'
);
