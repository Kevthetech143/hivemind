-- Add Stack Overflow Bcrypt knowledge base entries

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES (
    'What column type/length should I use for storing a Bcrypt hashed password in a Database?',
    'stackoverflow-bcrypt',
    'HIGH',
    $$[
        {"solution": "Use BINARY(60) or CHAR(60) BINARY for database column storage", "percentage": 95, "note": "Most explicit and binary-safe approach for storing 60-character bcrypt hashes"},
        {"solution": "Use VARCHAR(255) for future-proofing against stronger algorithms that may require more space", "percentage": 85, "note": "PHP PASSWORD_DEFAULT may use stronger algorithms requiring more characters"},
        {"solution": "Use BINARY(40) with compressed binary MCF encoding format", "percentage": 70, "note": "Adds complexity with minimal storage savings, not recommended"}
    ]$$::jsonb,
    'Understanding that bcrypt always produces 60-character hashes, Database access to modify column definitions',
    'Column correctly stores 60-character bcrypt hashes without truncation, Password verification queries work correctly',
    'Non-binary CHAR columns may perform case-insensitive comparisons causing false matches. Using VARCHAR without specifying length may truncate hashes. Ignoring collation settings can break password comparisons.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/5881169/what-column-type-length-should-i-use-for-storing-a-bcrypt-hashed-password-in-a-d'
),
(
    'How do you use bcrypt for hashing passwords in PHP?',
    'stackoverflow-bcrypt',
    'VERY_HIGH',
    $$[
        {"solution": "Use PHP 5.5+ native password_hash() with PASSWORD_BCRYPT: password_hash($password, PASSWORD_BCRYPT)", "percentage": 98, "note": "Official recommended approach, requires PHP >= 5.5"},
        {"solution": "Verify passwords with password_verify($password, $hash) function", "percentage": 98, "note": "Automatically handles salt extraction and comparison"},
        {"solution": "For PHP 5.3.7+, use password_compat library providing same API as native functions", "percentage": 90, "note": "Backwards compatibility layer for older PHP versions"},
        {"solution": "Use minimum rounds 9-12 to ensure hashing takes 200-250ms for security", "percentage": 85, "note": "Prevents brute-force attacks while maintaining reasonable performance"}
    ]$$::jsonb,
    'PHP >= 5.5 (or 5.3.7 with compat library), CRYPT_BLOWFISH support enabled, Valid plaintext password',
    'password_hash() returns 60-character string, password_verify() returns boolean true/false, No errors in logs',
    'Do not use custom bcrypt implementations without peer review. Do not use hash(), md5(), or sha1() for passwords. Do not set rounds below 9. Do not attempt manual salt management when functions handle it. Deprecated crypt() implementation - use password_* functions instead.',
    0.95,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/4795385/how-do-you-use-bcrypt-for-hashing-passwords-in-php'
),
(
    'Is Bcrypt used for Hashing or Encryption?',
    'stackoverflow-bcrypt',
    'MEDIUM',
    $$[
        {"solution": "Bcrypt is a hash function (one-way), not encryption (reversible). When storing passwords, use bcrypt hash algorithm specifically.", "percentage": 95, "note": "Hashing is one-way and irreversible, making it more secure than encryption for passwords"},
        {"solution": "Understand that bcrypt refers to two different things: an adaptive hash algorithm for passwords and an unrelated file encryption utility", "percentage": 85, "note": "Name confusion can lead to searching for wrong tool or implementation"},
        {"solution": "Bcrypt is a key derivation function where hashing is one-way, contrasting with encryption that remains reversible via secret key", "percentage": 80, "note": "Architectural difference makes hashing preferable for password storage"}
    ]$$::jsonb,
    'Understanding difference between encryption (reversible) and hashing (one-way), Knowledge of password security principles',
    'Password verification works via comparison not decryption, Stored passwords cannot be recovered from hashes, Bcrypt library used for password operations',
    'Confusing bcrypt hash algorithm with bcrypt file encryption tool. Attempting to decrypt bcrypt hashes. Treating bcrypt as encryption when it is a hash function. Assuming reversibility is required for password storage.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/9035855/is-bcrypt-used-for-hashing-or-encryption-a-bit-of-confusion'
),
(
    'Optimal bcrypt work factor and cost configuration',
    'stackoverflow-bcrypt',
    'HIGH',
    $$[
        {"solution": "Target approximately 250ms per hash computation as the work factor benchmark", "percentage": 95, "note": "Balances security against brute-force with acceptable user experience"},
        {"solution": "Store cost factor in the hash itself and dynamically increment by 1 when computers double in speed (roughly every 2 years)", "percentage": 90, "note": "Allows automatic future-proofing without breaking existing password verification"},
        {"solution": "Use cost factor 10-12 on modern hardware (2023+), where cost 10 takes ~90ms, cost 11 takes ~154ms, cost 12 takes ~334ms", "percentage": 88, "note": "Hardware benchmarks show current performance; adjust based on your server specs"},
        {"solution": "Do not exceed cost factor 13 due to severe user experience degradation and excessive login delays", "percentage": 85, "note": "Factor 13+ causes unacceptable login timeouts for users"}
    ]$$::jsonb,
    'Understanding password hashing fundamentals, Knowledge of brute-force attack dynamics, Server capacity constraints known',
    'Hash computation takes 100-250ms per login attempt, Cost automatically scales with hardware improvements, Passwords remain practically uncrackable for years post-breach, Login remains responsive to users',
    'Using fixed cost factors without periodic review. Ignoring hardware performance improvements over time. Setting costs too high causing poor user experience. Disregarding offline attack timelines when database breaches occur. Setting cost below 10 provides insufficient security margin.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/4443476/optimal-bcrypt-work-factor'
),
(
    'How can bcrypt have built-in salts?',
    'stackoverflow-bcrypt',
    'HIGH',
    $$[
        {"solution": "Bcrypt hash output concatenates three components: algorithm version, cost factor, and salt+ciphertext encoded in modified Base-64", "percentage": 96, "note": "Example: $2a$10$vI8aWBnW3fID.ZQ4/zo1G.q1lRps.9cGLcZEiGDMVr5yUP1KUOYTa contains all needed info"},
        {"solution": "Salt is appended to bcrypt output and can be extracted during authentication; no separate storage required", "percentage": 95, "note": "Bcrypt automatically handles salt extraction during verification"},
        {"solution": "Each password gets unique random salt preventing pre-computed attacks and dictionary tables", "percentage": 93, "note": "Rainbow tables become useless when each hash has random unique salt"}
    ]$$::jsonb,
    'Understanding cryptographic hashing basics, Familiarity with password storage concepts, Knowledge of rainbow table attacks',
    'Salt automatically included in stored bcrypt output, Bcrypt extracts salt during authentication automatically, Each password gets unique random salt, No separate database column needed for salt storage',
    'Assuming salts must remain secret (they should not). Believing rainbow tables are useful with random salts. Thinking bcrypt stores salts separately in database. Attempting to manually remove salt from hash for comparison. Not understanding that salt is plaintext component of hash.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/6832445/how-can-bcrypt-have-built-in-salts'
),
(
    'What are Salt Rounds and how are Salts stored in Bcrypt?',
    'stackoverflow-bcrypt',
    'HIGH',
    $$[
        {"solution": "Salt rounds (cost factor) control computation time; rounds equal 10 means 2^10 = 1024 iterations", "percentage": 96, "note": "Exponential increase: each +1 cost doubles the computation time"},
        {"solution": "Salt is random per hash calculation and differs each time, included in resulting hash-string in readable form", "percentage": 95, "note": "Identical passwords produce different hashes due to unique salt"},
        {"solution": "Bcrypt hash structure: $2b$10$nOUIs5kJ7naTuTFkBy1veuK0kSxUFXfuaOKdOKf9xYT0KKIGSJwFa contains algorithm (2b), cost (10), salt, and hash", "percentage": 92, "note": "Parse structure to understand hash components"}
    ]$$::jsonb,
    'Understanding basic password hashing concepts, Familiarity with bcrypt library usage, Knowledge of password security principles',
    'Understanding that bcrypt automatically handles salt generation and storage, Recognizing 2^10 = 1024 iterations for cost factor 10, Understanding why password verification does not require separate salt retrieval',
    'Assuming identical passwords produce identical hashes (salt prevents this). Thinking salt must be stored separately (embedded in hash). Misunderstanding cost factor as simple iteration count rather than exponential time increase. Confusion about salt rounds vs cost factor terminology.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/46693430/what-are-salt-rounds-and-how-are-salts-stored-in-bcrypt'
),
(
    'How does bcrypt handle passwords longer than 72 characters?',
    'stackoverflow-bcrypt',
    'MEDIUM',
    $$[
        {"solution": "Bcrypt silently truncates passwords at 72 bytes; longer passwords are cut off and only first 72 characters matter", "percentage": 92, "note": "Security risk: passwords differing only after position 72 are treated identically"},
        {"solution": "Pre-hash long passwords using SHA-512 or PBKDF2 before bcrypt to support 72+ character passwords", "percentage": 85, "note": "NIST SP 800-63-3 recommends PBKDF2 for pre-hashing with iteration count making bcrypt take ~100ms"},
        {"solution": "Accept bcrypt''s 72-character limit and inform users this is maximum effective password length", "percentage": 75, "note": "72 characters provide sufficient entropy for security; most users accept this limitation"}
    ]$$::jsonb,
    'Understanding bcrypt''s 72-byte input limitation, Knowledge of password hashing best practices, Familiarity with cryptographic hash functions',
    'No password truncation without user awareness, NIST SP 800-63-3 compliance, Approximately 100ms hashing duration, Proper encoding handling when pre-hashing',
    'Silent truncation without user notification. Pre-hashing reduces available character set for those 72 positions. Using binary SHA output causes null byte issues. Character encoding problems when pre-hashing. Not documenting the 72-character limit to users.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/39175224/bcrypt-longer-passwords'
),
(
    'Why is bcrypt slow for password hashing considered a security feature?',
    'stackoverflow-bcrypt',
    'MEDIUM',
    $$[
        {"solution": "Bcrypt slowness increases time required for brute-force attacks; if hashing takes 100ms, attacker can try 10 passwords/second instead of millions", "percentage": 94, "note": "Converting days of cracking time into years of compute resources"},
        {"solution": "Login delays of 100ms are imperceptible to users but dramatically extend attack timelines from days to years", "percentage": 92, "note": "User experience remains unaffected while attacker effort increases exponentially"},
        {"solution": "Configure cost factor to increase work as hardware improves, maintaining constant ~250ms target over time", "percentage": 88, "note": "Prevents attacks as computers become faster"}
    ]$$::jsonb,
    'Understanding of hash functions vs encryption, Familiarity with brute-force attack methodology, Knowledge of salt implementation in password storage',
    'Adoption of bcrypt, scrypt, or Argon2 for password storage, Implementation of configurable work factors to future-proof against hardware improvements, Verification that login operations remain user-acceptable',
    'Confusing hashing speed with security strength. Overlooking user experience trade-offs. Assuming slowness alone prevents attacks without proper salting. Using fixed cost factors that become obsolete. Attempting to reduce cost factor for faster logins, compromising security.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/15763086/bcrypt-for-password-hashing-because-it-is-slow'
),
(
    'How to decrypt hash stored by bcrypt - password verification approach',
    'stackoverflow-bcrypt',
    'HIGH',
    $$[
        {"solution": "Do not decrypt bcrypt hashes; instead compare user input against stored hash using bcrypt comparison function", "percentage": 96, "note": "Bcrypt is one-way hash function, decryption is cryptographically impossible"},
        {"solution": "Use bcrypt.compare(inputPassword, storedHash) or equivalent library function to verify passwords", "percentage": 95, "note": "Function extracts salt from hash and performs comparison automatically"},
        {"solution": "Understand that password cracking involves checking dictionary passwords against bcrypt hashes using extracted salt, not decryption", "percentage": 90, "note": "Bcrypt''s slowness makes this process intentionally time-consuming"}
    ]$$::jsonb,
    'Understanding that hashing differs from encryption, Knowledge that one-way functions cannot be reversed, Familiarity with password verification through comparison',
    'Recognizing password verification requires comparing hashes, not decryption. Storing complete bcrypt hash (including salt) in database. Using compare function to validate user input against stored hash. Understanding why bcrypt''s slowness enhances security.',
    'Treating hashes as encrypted data requiring decryption. Attempting to reverse rather than verify passwords. Considering encryption as alternative to hashing. Assuming hashes contain encrypted passwords that can be recovered. Overlooking that salting and rounds prevent decryption.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/18084595/how-to-decrypt-hash-stored-by-bcrypt'
),
(
    'How to hash passwords with bcrypt inside async/await functions in Node.js',
    'stackoverflow-bcrypt',
    'MEDIUM',
    $$[
        {"solution": "When no callback provided, bcrypt.hash() automatically returns Promise: const hash = await bcrypt.hash(password, saltRounds)", "percentage": 98, "note": "Modern recommended approach for async/await"},
        {"solution": "If using callback version, wrap in Promise: await new Promise((resolve, reject) => { bcrypt.hash(password, saltRounds, (err, hash) => { if(err) reject(err); resolve(hash); }) })", "percentage": 92, "note": "Enables await on callback-based functions"},
        {"solution": "Use synchronous bcrypt.hashSync() for simple scripts, but avoid in servers as it blocks event loop", "percentage": 70, "note": "Simpler code but causes severe performance issues in production"}
    ]$$::jsonb,
    'Understanding that callbacks do not return Promises, Knowledge of Promise mechanics and async/await syntax, Node.js bcrypt library installed',
    'Hashed password successfully assigned to variable, No undefined values being stored, Password properly saved to database, Async function completes before proceeding',
    'Mixing callbacks with await causes Promise to not be returned. Passing callback function prevents automatic Promise return. Using sync mode blocks event loop in servers. Awaiting non-Promise returns immediately without waiting. Not understanding async/await prevents hash completion.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/48799894/trying-to-hash-a-password-using-bcrypt-inside-an-async-function'
),
(
    'Password hashing workflow with bcrypt in database applications',
    'stackoverflow-bcrypt',
    'MEDIUM',
    $$[
        {"solution": "Hash plaintext password during registration: bcrypt.hash(password, saltRounds) -> store result in database", "percentage": 96, "note": "Never store plaintext passwords"},
        {"solution": "On login, compare input against stored hash: bcrypt.compare(inputPassword, storedHash) returns true/false", "percentage": 95, "note": "Use comparison result to grant/deny access"},
        {"solution": "Ensure hash operation completes before storing in database using async/await or callbacks", "percentage": 93, "note": "Prevents storing undefined values or plaintext passwords"}
    ]$$::jsonb,
    'Plaintext password from user input, Database connection for storing hashes, Bcrypt library with Promise or callback support',
    'Hash stored in database matches stored hash, bcrypt.compare returns true for correct password, bcrypt.compare returns false for incorrect password, Login authentication works correctly',
    'Storing plaintext passwords in database. Hashing password only for comparison without storing result. Attempting to hash already-hashed passwords. Not awaiting hash completion causing undefined storage. Comparing plaintext to plaintext instead of plaintext to hash.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/66502559/password-hashing-with-bcrypt'
);
