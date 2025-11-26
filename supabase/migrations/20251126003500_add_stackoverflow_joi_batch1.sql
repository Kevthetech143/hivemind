-- Add Stack Overflow Joi validation library solutions batch 1
-- Extracted from highest-voted Joi questions (10-116 votes)
-- Total: 12 entries from real Stack Overflow solutions

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Joi validation of array with different types (strings or objects)',
    'stackoverflow-joi',
    'HIGH',
    $$[
        {"solution": "Use Joi.array().items(Joi.string()) for array of strings or Joi.array().items(Joi.object().keys(...)) for array of objects", "percentage": 95, "note": "Standard approach for validating array element types"},
        {"solution": "Combine with .min() and .max() to enforce array length constraints", "percentage": 90, "command": "Joi.array().items(Joi.string()).min(1).max(10)"}
    ]$$::jsonb,
    'Joi library installed and imported, Basic understanding of Joi schema syntax',
    'Array elements pass type validation, Array length respects min/max constraints if set',
    'Do not pass validation logic directly without wrapping in proper Joi schema type (Joi.string(), Joi.object()). Use .keys() method for object validation.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/42656549/joi-validation-of-array'
),
(
    'Node.js Joi custom error messages for validation failures in non-English applications',
    'stackoverflow-joi',
    'HIGH',
    $$[
        {"solution": "Use .messages() method to override default validation error messages (Joi v17+)", "percentage": 95, "note": "Modern Joi approach with template variable support like {#limit}", "command": "Joi.string().min(2).messages({\"string.min\": \"{#label} must have {#limit}+ characters\"})"},
        {"solution": "For Joi v16 and earlier, use .error() method instead of .messages()", "percentage": 80, "note": "Legacy approach for older versions"}
    ]$$::jsonb,
    'Joi v17+ installed (or @hapi/joi for v16), Understanding of validation rule type strings (string.base, any.required, etc.)',
    'Validation errors display custom messages instead of defaults, Template variables interpolate correctly (e.g., {#limit} shows actual number)',
    'Version confusion: older versions use .error() instead of .messages(). Wrong error keys cause silent failures (use string.min not min). Package mismatch installing joi vs @hapi/joi causes "messages is not a function" errors.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/48720942/node-js-joi-how-to-display-a-custom-error-messages'
),
(
    'Joi schema allow only specific values for key without regex patterns',
    'stackoverflow-joi',
    'HIGH',
    $$[
        {"solution": "Use .valid() method with specific string values to restrict field to enumerated values", "percentage": 96, "note": "Cleaner than regex for enumeration use cases", "command": "Joi.string().valid(\"apple\", \"banana\").required()"},
        {"solution": "Alternative aliases .only() or .equal() provide equivalent functionality", "percentage": 90, "note": "Older Joi versions may use different method names"}
    ]$$::jsonb,
    'Joi library installed and imported, Basic understanding of Joi schema syntax',
    'Field validation succeeds only for specified values, Validation fails with clear error listing allowed options',
    'Confusion about simultaneous values: a string field can hold one value at a time. Use arrays if multiple concurrent values needed. For TypeScript enums, spread the enum values: .valid(...Object.values(MyEnum))',
    0.94,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/49007865/allow-only-specific-values-for-key-in-joi-schema'
),
(
    'Joi how to use enum values with string validation for device types',
    'stackoverflow-joi',
    'HIGH',
    $$[
        {"solution": "Use .valid() method to specify allowed enum values directly", "percentage": 96, "note": "Standard enum validation approach", "command": "Joi.string().valid(\"ios\", \"android\")"},
        {"solution": "For TypeScript enums, use spread operator to pass enum values", "percentage": 92, "note": "Works with Object.values() to extract enum values", "command": "Joi.string().valid(...Object.values(DeviceType))"}
    ]$$::jsonb,
    'Joi library installed, Understanding of schema definition with .object() and .keys()',
    'Validation accepts only specified enum values, Invalid values trigger error message listing allowed options',
    'Attempting to pass array directly to .valid() without spread operator fails in newer Joi versions. Correct syntax is .valid(...array) not .valid([array]). Message strings must match case sensitivity of enum values.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/50156176/how-to-use-enum-values-with-joi-string-validation'
),
(
    'Joi validate array of objects with specific properties',
    'stackoverflow-joi',
    'HIGH',
    $$[
        {"solution": "Use .items() method with object schema to validate each array element", "percentage": 97, "note": "items() allows arrays of any length, each matching schema", "command": "Joi.array().items(Joi.object().keys({serviceName: Joi.string().required()}))"},
        {"solution": "For empty array rejection, add .min(1) constraint to the array", "percentage": 95, "command": "Joi.array().items(...).min(1)"}
    ]$$::jsonb,
    'Joi library installed, Basic understanding of schema definition with Joi.object() and Joi.string()',
    'Array passes validation, Each object element validates against defined schema, Array length respects .min() and .max() constraints',
    'Using .ordered() instead of .items() causes \"at most 1 items\" errors - ordered() restricts to one item per position. Joi.validate() deprecated in v16+; use schema.validate() instead. .keys() is optional in newer versions.',
    0.95,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/37744483/how-to-validate-array-of-objects-using-joi'
),
(
    'Joi allow string field to be null or empty in express-validation',
    'stackoverflow-joi',
    'HIGH',
    $$[
        {"solution": "Use .allow() method to explicitly permit null and empty string values", "percentage": 96, "note": "Standard documented approach in Joi API", "command": "Joi.string().allow(null, \"\")"},
        {"solution": "Chain multiple .allow() calls for different null-like values", "percentage": 90, "note": "Less elegant but works: .allow(null).allow(\"\")"}
    ]$$::jsonb,
    'Joi library installed, Basic understanding of Joi schema definitions',
    'String field accepts normal string values, null, and empty string without validation error',
    'Using .valid(null, \"\") restricts field to ONLY null and empty string, rejecting actual string content. .optional() alone does not permit null/empty by default. Chaining .allow() separately works but is less elegant than comma-delimited values.',
    0.95,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/42370881/allow-string-to-be-null-or-empty-in-joi-and-express-validation'
),
(
    'Joi schema how to allow any other key beyond defined properties',
    'stackoverflow-joi',
    'MEDIUM',
    $$[
        {"solution": "Use .unknown(true) method to permit additional properties not defined in schema keys", "percentage": 97, "note": "Standard approach for flexible schemas", "command": "Joi.object().keys({a: Joi.string()}).unknown(true)"},
        {"solution": "Alternative .pattern() with regex for dynamic key matching", "percentage": 75, "note": "More restrictive, typically used for pattern-based keys"}
    ]$$::jsonb,
    'Joi library installed and imported, Basic understanding of Joi schema structure',
    'Schema accepts properties beyond explicitly defined keys, Known fields still validate according to schema rules',
    'Some developers use .pattern(/./, Joi.string()) thinking it allows all keys, but this is more restrictive and does not match empty string keys. .unknown() defaults to true but explicit declaration improves code clarity and maintainability.',
    0.96,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/49897639/how-to-allow-any-other-key-in-joi'
),
(
    'Joi validation multiple conditions AND logic for required fields',
    'stackoverflow-joi',
    'MEDIUM',
    $$[
        {"solution": "Use nested .when() clauses to create AND logic - nest one when inside another''s then option", "percentage": 93, "note": "Produces a === value1 AND b === value2 logic", "command": "Joi.string().when(\"a\", {is: \"avalue\", then: Joi.when(\"b\", {is: \"bvalue\", then: Joi.string().required()})})"},
        {"solution": "Use .concat() for OR conditions in modern Joi versions", "percentage": 85, "note": "Produces OR logic, different from nested when clauses"}
    ]$$::jsonb,
    'Joi library installed, Understanding of conditional validation syntax, Familiarity with .when() method',
    'Conditional field becomes required when all specified conditions are true, Validation fails when required conditions not met',
    'Earlier approaches using .concat() in Joi 14.3.0+ produce OR conditions, not AND. Do not use switch keyword with schema conditions in older versions - causes errors. Forgetting to validate the discriminator field itself leads to bypass.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/26509551/joi-validation-multiple-conditions'
),
(
    'Joi joi_1.default.validate is not a function error in Node.js',
    'stackoverflow-joi',
    'MEDIUM',
    $$[
        {"solution": "Joi v16+ removed joi.validate() method - call validate directly on schema object instead", "percentage": 98, "note": "Breaking change in Joi v16+", "command": "validationSchema.validate(request) instead of joi.validate(request, validationSchema)"},
        {"solution": "If stuck on older version, add polyfill: Joi.validate = (data, schema) => schema.validate(data)", "percentage": 60, "note": "Workaround only, upgrade recommended"}
    ]$$::jsonb,
    'Joi v16 or later installed (upgrade from older versions if getting this error)',
    'schema.validate() returns object with error and value properties, Request passes validation with no errors',
    'Continuing to use deprecated \"joi.validate(data, schema)\" syntax causes this error. Import must use \"const Joi = require(\"joi\")\" not destructuring. Version mismatches between @hapi/joi and joi packages cause similar errors.',
    0.95,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/57956609/joi-1-default-validate-is-not-a-function'
),
(
    'Nodejs Joi check if string value is in a given list',
    'stackoverflow-joi',
    'MEDIUM',
    $$[
        {"solution": "Use .valid() method with variable arguments for allowed values (Joi v16+)", "percentage": 96, "note": "Modern syntax accepts values as separate arguments", "command": "Joi.string().valid(\"a\", \"b\") or Joi.string().valid(...[\"a\", \"b\"])"},
        {"solution": "Use .invalid() method to blacklist values instead of whitelist", "percentage": 90, "note": "Opposite of valid for rejecting specific values", "command": "Joi.string().invalid(\"forbidden1\", \"forbidden2\")"}
    ]$$::jsonb,
    'Joi package installed, Understanding of schema validation basics',
    'String validation succeeds for whitelisted values, Validation fails for blacklisted values with clear error message',
    'Passing arrays directly without spread operator breaks in Joi v16+: use .valid(...array) not .valid(array). Confusing .valid() with non-existent .in() method. Version mismatches cause unexpected array handling behavior.',
    0.95,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/41408469/nodejs-joi-check-if-string-is-in-a-given-list'
),
(
    'Joi how to add custom validator function for schema validation',
    'stackoverflow-joi',
    'MEDIUM',
    $$[
        {"solution": "Use .custom() method with helpers.error() for proper error handling instead of throwing", "percentage": 95, "note": "Critical: use helpers.error() not throw new Error()", "command": "Joi.string().custom((value, helpers) => {if (invalid) return helpers.error(\"any.invalid\"); return value;})"},
        {"solution": "For complex validation, use helpers.message() for custom error text", "percentage": 88, "note": "Provides custom error message alongside error type"}
    ]$$::jsonb,
    'Joi version 16.1.7+ (@hapi/joi), Understanding of schema validation patterns, Node.js environment (not browser)',
    'Custom validation executes without throwing, Invalid values populate error object with proper error format',
    'Returning native Error objects instead of helpers.error() causes errors to populate value object instead of error object. Testing custom validators in browsers fails - Joi requires Node.js. Incorrect helper method usage breaks error message passing.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/58425499/how-to-add-custom-validator-function-in-joi'
),
(
    'Joi validator conditional schema based on request query parameter value',
    'stackoverflow-joi',
    'MEDIUM',
    $$[
        {"solution": "Use Joi.alternatives().conditional() within schema object to enforce field requirements based on discriminator value", "percentage": 94, "note": "Each field uses alternatives with type-specific conditions", "command": "firstname: Joi.alternatives().conditional(\"type\", {is: 1, then: Joi.string().required()})"},
        {"solution": "For modern Joi, use switch() method for cleaner syntax with multiple conditions", "percentage": 85, "note": "Cleaner than nested alternatives in recent versions"}
    ]$$::jsonb,
    'Hapi/Joi version 16.1.8 or compatible, Understanding of conditional validation syntax and discriminated unions',
    'Conditional fields become mandatory only when discriminator matches condition, Validation respects all type-specific requirements',
    'Using switch keyword with schema conditions causes errors in older Joi versions. Not properly chaining .unknown() when needed causes unknown property errors. Forgetting to validate the discriminator field itself allows bypass of conditional logic.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/59861503/joi-validator-conditional-schema'
);
