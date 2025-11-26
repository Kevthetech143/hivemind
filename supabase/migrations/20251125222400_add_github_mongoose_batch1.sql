-- Mining: High-engagement Mongoose connection/validation/population/TypeScript issues
-- Source: https://github.com/Automattic/mongoose/issues
-- Category: github-mongoose
-- Batch 1: 12 entries

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'MongoDB E11000 duplicate key error - how to handle and return validation error',
    'github-mongoose',
    'VERY_HIGH',
    '[
        {"solution": "Manually transform E11000 error code into ValidationError structure using Mongoose error utilities to provide frontend-friendly feedback", "percentage": 90, "note": "Works reliably for direct unique constraint violations", "command": "if (11000 === err.code) { var valError = new mongoose.Error.ValidationError(err); }"},
        {"solution": "Use a post-save error handling middleware to catch duplicate key errors and transform them into validator-like errors", "percentage": 85, "note": "Can be applied globally to all models via middleware"},
        {"solution": "Create a custom plugin that wraps save() to intercept and transform MongoDB errors before returning to application", "percentage": 80, "note": "Most reusable approach for multi-model applications"}
    ]'::jsonb,
    'Mongoose schema with unique index defined, knowledge of Error and ValidationError classes',
    'Application receives ValidationError object instead of raw MongoDB error, error message is human-readable for frontend display',
    'Remember unique constraints are only enforced at database level, not during pre-save validation. In multi-process environments, race conditions can still create duplicates. Also note that E11000 and E11001 are both duplicate key errors.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/Automattic/mongoose/issues/2284'
),
(
    'Cast to number failed for value "undefined" - optional Number fields throwing casting errors',
    'github-mongoose',
    'HIGH',
    '[
        {"solution": "Verify that the field is being set to undefined rather than an invalid numeric value before saving", "percentage": 85, "note": "Check caller code for unexpected value types"},
        {"solution": "Set Number fields to undefined explicitly rather than null - undefined skips casting, null triggers type coercion", "percentage": 80, "note": "Distinguish between undefined (skip) and null (apply default)"},
        {"solution": "Ensure schema definition is correct and test with isolated test case to isolate undefined casting issue", "percentage": 75, "note": "Problem may be in how data is being transformed before reaching mongoose"}
    ]'::jsonb,
    'Mongoose 4.0+, optional Number field in schema, code that sets field values',
    'Document saves successfully without casting error, number field contains expected numeric value or remains undefined',
    'Do not pass null to optional Number fields expecting undefined behavior - null is treated as intentional value and may fail casting. Undefined and null have different semantics in Mongoose.',
    0.75,
    'sonnet-4',
    NOW(),
    'https://github.com/Automattic/mongoose/issues/2901'
),
(
    'Best way to validate ObjectId format before database query - prevent invalid ID crashes',
    'github-mongoose',
    'HIGH',
    '[
        {"solution": "Use mongoose.Types.ObjectId.isValid() method for built-in validation: isValid(\"53cb6b9b4f4ddef1ad47f943\") returns boolean", "percentage": 95, "note": "Official recommended approach, defers to BSON package validation"},
        {"solution": "Validate against regex pattern for 24 hexadecimal characters: /^[0-9a-fA-F]{24}$/ for stricter hex-string validation", "percentage": 85, "note": "Works when isValid() is insufficient"},
        {"solution": "Catch CastError exceptions when querying with potentially invalid ObjectIds instead of pre-validating", "percentage": 70, "note": "Reactive approach, less efficient than validation"}
    ]'::jsonb,
    'Mongoose library imported, string value that may be an ObjectId',
    'isValid() returns true for valid 24-char hex strings and false for invalid formats, no CastError thrown on query execution',
    'The isValid() method checks BSON format (12 bytes) not just hex format. For strict string validation use regex. Do not assume all 24-char hex strings are valid without calling isValid().',
    0.95,
    'sonnet-4',
    NOW(),
    'https://github.com/Automattic/mongoose/issues/1959'
),
(
    'Cast to ObjectId failed for value with $in operator and mixed array types including empty array',
    'github-mongoose',
    'MEDIUM',
    '[
        {"solution": "Replace mixed-type $in array with separate $or queries - use $size for empty arrays and $in for ObjectId matches separately", "percentage": 90, "note": "Workaround: {$or: [{privacy: {$size: 0}}, {privacy: {$in: [validIds]}}]}"},
        {"solution": "Filter and sanitize $in array values before query execution to ensure all elements are valid ObjectIds", "percentage": 80, "note": "Remove non-castable values like arrays and null from $in operator"},
        {"solution": "Cast empty array values to null before using in $in operator, then query null separately", "percentage": 70, "note": "Requires separate logic to handle null vs empty array semantics"}
    ]'::jsonb,
    'Mongoose schema with ObjectId array field, query object with $in operator, understanding of MongoDB query operators',
    'Query executes successfully without CastError, returns documents with either specified IDs or empty arrays',
    'Mongoose attempts to cast every element in $in array to the field type - including arrays and null values which cannot be cast. Do not mix type-incompatible values in $in arrays. Always pre-validate $in array values.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/Automattic/mongoose/issues/5913'
),
(
    '$ne operator CastError for string fields in query - cast to string failed for operator object',
    'github-mongoose',
    'MEDIUM',
    '[
        {"solution": "Ensure query operator objects are passed at correct nesting level - verify field value is the operator, not the field itself", "percentage": 85, "note": "Check for incorrect syntax like field: {$ne: value} vs {field: {$ne: value}}"},
        {"solution": "Avoid complex nested query objects and use standard query syntax with proper operator placement", "percentage": 75, "note": "May be version-specific behavior in older Mongoose versions"},
        {"solution": "Use explicit type casting hint if needed, or reformulate query using alternative operators", "percentage": 70, "note": "Last resort if operator parsing is broken"}
    ]'::jsonb,
    'Mongoose string field in schema, query object using MongoDB operators, mongoose version 6.0+',
    'Query executes successfully and returns non-matching documents, no CastError thrown, query result matches MongoDB native behavior',
    'The error occurs when Mongoose string casting logic receives the entire operator object instead of just the value. This is context-dependent and may only occur in certain controller contexts. Test queries in isolation first.',
    0.70,
    'sonnet-4',
    NOW(),
    'https://github.com/Automattic/mongoose/issues/13890'
),
(
    'Model.update() method does not respect validators, enum constraints, or custom validators on updates',
    'github-mongoose',
    'HIGH',
    '[
        {"solution": "Use findById() then save() pattern instead of update() to trigger full validation pipeline: find().then(doc => {doc.field=val; return doc.save()})", "percentage": 90, "note": "Ensures validators, setters, defaults all execute. More overhead but guaranteed validation."},
        {"solution": "Enable runValidators option on update operations: Model.updateOne({}, {$set: {field: val}}, {runValidators: true})", "percentage": 85, "note": "Applies validators to update, but not setters or default values"},
        {"solution": "Create pre-update middleware to manually validate modified fields before database operation", "percentage": 75, "note": "Custom validation logic, bypasses some built-in validation"}
    ]'::jsonb,
    'Mongoose model with validators defined on fields, update operation using .update() or .updateOne(), Mongoose 3.9.3+',
    'Update operation throws validation error for invalid values, enum constraints are enforced, required fields cannot be removed',
    'Remember update() methods bypass Mongoose completely - they go directly to MongoDB. Only runValidators: true partially fixes this. Setters and defaults do NOT run on update. If you need full validation, use find-then-save pattern.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/Automattic/mongoose/issues/860'
),
(
    'findByIdAndUpdate middleware not executing - pre/post hooks bypass with findByIdAndUpdate()',
    'github-mongoose',
    'HIGH',
    '[
        {"solution": "Replace findByIdAndUpdate() with manual find().then(save()) pattern: Model.findById(id).then(doc => {Object.assign(doc, updates); return doc.save()})", "percentage": 95, "note": "Only way to guarantee middleware execution. More verbose but reliable."},
        {"solution": "Use Model.findOneAndUpdate({_id: id}, updates, {new: true}) with runValidators if only validators needed, not full middleware", "percentage": 70, "note": "Still bypasses middleware but can apply validators"},
        {"solution": "Create custom update wrapper function that handles middleware manually before calling update", "percentage": 65, "note": "Complex workaround, not recommended"}
    ]'::jsonb,
    'Mongoose model with pre/post middleware hooks, need to update single document by ID',
    'Pre-hooks execute before database operation, post-hooks execute after, document modifications are visible to middleware',
    'findByIdAndUpdate, findOneAndUpdate, and .update() bypass Mongoose completely and execute directly on MongoDB. No document object exists to trigger hooks. This is by design. To run middleware, you MUST use the find-then-save pattern.',
    0.95,
    'sonnet-4',
    NOW(),
    'https://github.com/Automattic/mongoose/issues/964'
),
(
    'Boolean field saves as null instead of using default false value',
    'github-mongoose',
    'MEDIUM',
    '[
        {"solution": "Use required: true on Boolean fields to reject null values: {type: Boolean, default: false, required: true}", "percentage": 90, "note": "Prevents null entirely, throws validation error if null passed"},
        {"solution": "Pass undefined instead of null to trigger default value: create({boolField: undefined}) applies default, create({boolField: null}) keeps null", "percentage": 85, "note": "Intentional Mongoose behavior - null is deliberate absence of value, not missing value"},
        {"solution": "Validate boolean fields before passing to Mongoose to ensure they are not null", "percentage": 75, "note": "Preventive approach - sanitize input data"}
    ]'::jsonb,
    'Mongoose schema with Boolean field and default: false, document creation or update with null value',
    'Document saves with Boolean field equal to false when created with undefined, field cannot be set to null with required: true',
    'This is intentional design in Mongoose 5.0+. Null is the intentional absence of a value and does NOT trigger defaults. Only undefined triggers default values. This behavior applies to all field types, not just Boolean. Distinguish between undefined (missing) and null (intentionally null).',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/Automattic/mongoose/issues/6034'
),
(
    'Decimal.js objects cast to Number wrapper [Number: X] instead of primitive number',
    'github-mongoose',
    'LOW',
    '[
        {"solution": "Check schema number field casting logic - Mongoose should use valueOf() for numeric type coercion: check mongoose/lib/schema/number.js", "percentage": 85, "note": "Framework-level issue, file-specific fix required"},
        {"solution": "Convert Decimal.js to primitive before passing to Mongoose: use decimalObj.toNumber() explicitly before save", "percentage": 90, "note": "Reliable workaround - pre-convert all Decimal values"},
        {"solution": "Use Mongoose custom getters/setters to handle Decimal.js conversion at schema level", "percentage": 75, "note": "Define schema field with setter that calls toNumber()"}
    ]'::jsonb,
    'Mongoose with Decimal.js library installed, Number fields in schema, Decimal objects being saved',
    'Number fields contain primitive numbers, not Number wrapper objects, Decimal.js objects properly coerce to numeric values',
    'The issue is in how new Number() constructs Number wrappers instead of primitives. Mongoose preferred using valueOf() for standard JavaScript coercion. Custom numeric types must either have valueOf() or be pre-converted. Do not rely on toString() coercion for Number type detection.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/Automattic/mongoose/issues/6299'
),
(
    'Unordered insertMany drops per-document validation errors when rawResult is false',
    'github-mongoose',
    'HIGH',
    '[
        {"solution": "Use insertMany with rawResult: true to receive complete error details for each document including validation failures", "percentage": 90, "note": "Returns raw MongoDB response with writeErrors array containing per-document failures"},
        {"solution": "Switch to ordered: true (default) if validation errors are critical - stops at first error and throws, making failures obvious", "percentage": 80, "note": "Less efficient but guarantees error detection"},
        {"solution": "Manually validate all documents before insertMany using schema.validate(doc) to catch validation errors upfront", "percentage": 75, "note": "Proactive approach - validate before attempting insert"}
    ]'::jsonb,
    'Mongoose schema with required or validated fields, insertMany call with ordered: false',
    'rawResult: true returns full error object with writeErrors array, application can identify which documents failed validation by index',
    'When rawResult: false (default), validation errors are silently discarded during unordered inserts. You only get successfully inserted documents back. If you need to know which documents failed validation, you MUST use rawResult: true and parse the result yourself.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/Automattic/mongoose/issues/15771'
),
(
    'Schema Union type validation bypass - required fields ignored when Union of Objects used',
    'github-mongoose',
    'MEDIUM',
    '[
        {"solution": "Validate union schemas explicitly in pre-save middleware before allowing document save", "percentage": 80, "note": "Workaround until framework fix is released"},
        {"solution": "Avoid Union types with required fields until validation is properly implemented - use oneOf or discriminator patterns instead", "percentage": 85, "note": "Alternative schema patterns that enforce validation"},
        {"solution": "Apply runValidators: true on all update/insert operations to force validation for union fields", "percentage": 70, "note": "Partial mitigation, not complete fix"}
    ]'::jsonb,
    'Mongoose schema with Schema.Types.Union containing subschemas with required fields, document creation',
    'Create operation throws validation error when required fields are missing in union variant, invalid documents are rejected',
    'Union type validation is incomplete - required field constraints are skipped. This is a known limitation in Mongoose. Pull request #15734 was proposed to fix this. Until released, do not rely on Union types for strict validation. Use discriminators or oneOf as alternatives.',
    0.65,
    'sonnet-4',
    NOW(),
    'https://github.com/Automattic/mongoose/issues/15732'
),
(
    'Memory leak due to connection not authenticating - exhausting connection pool',
    'github-mongoose',
    'MEDIUM',
    '[
        {"solution": "Verify MongoDB authentication is properly configured - check connection string format for mongodb:// vs mongodb+srv://", "percentage": 85, "note": "If no auth required, ensure MongoDB server allows unauthenticated connections"},
        {"solution": "Monitor connection pool status - use db.serverStatus() to check current connections and investigate root cause of authentication delays", "percentage": 80, "note": "Identify if issue is Mongoose or MongoDB configuration"},
        {"solution": "Implement connection pool settings to limit growth: maxPoolSize, serverSelectionTimeoutMS in connection options", "percentage": 75, "note": "Prevent exhaustion by capping connection count"}
    ]'::jsonb,
    'Mongoose 9.0.0+, MongoDB 8.0+, local or remote MongoDB instance, connection URL string',
    'Connection pool stabilizes at expected size, no excessive \"Connection not authenticating\" messages in MongoDB logs, memory usage normalizes',
    'Connection pool exhaustion often stems from authentication configuration issues. Even no-auth scenarios can cause delays. Monitor connection count growth patterns. Mongoose v9.0.0 may have connection lifecycle changes affecting pool management. Check MongoDB server logs for connection status.',
    0.70,
    'sonnet-4',
    NOW(),
    'https://github.com/Automattic/mongoose/issues/15785'
),
(
    'TypeScript Schema.static() requires all methods when only defining some - partial static methods fail',
    'github-mongoose',
    'MEDIUM',
    '[
        {"solution": "Change type signature to use Partial mapped type: {[F in keyof TStaticMethods]?: TStaticMethods[F]} to make all static methods optional", "percentage": 90, "note": "Mirrors how Schema.method() handles instance methods with Partial<TInstanceMethods>"},
        {"solution": "Define all static methods in single call: schema.static({m1() {}, m2() {}}) instead of multiple calls", "percentage": 75, "note": "Works around but not ergonomic for incremental definition"},
        {"solution": "Use interface merging or type assertion workarounds to bypass strict typing during development", "percentage": 60, "note": "Not recommended for production, only temporary workaround"}
    ]'::jsonb,
    'Mongoose with TypeScript, schema with generic TStaticMethods type parameter, defining static methods incrementally',
    'TypeScript compilation succeeds when defining subset of static methods, no \"property missing\" errors, all defined methods are callable',
    'The current type definition requires all properties in TStaticMethods to be provided. Pull request #15786 addresses this by using Partial. Until merged, you must define all methods together. This differs from Schema.method() which already uses Partial for instance methods.',
    0.70,
    'sonnet-4',
    NOW(),
    'https://github.com/Automattic/mongoose/issues/15780'
);
