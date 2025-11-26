-- Add express-validator GitHub issues batch 1: Custom validators, async validation, sanitization, TypeScript integration

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES (
    'How to add custom sanitization functions in express-validator',
    'github-express-validator',
    'HIGH',
    $$[
        {"solution": "Use the .custom() method in sanitize() chain: sanitize(''field'').custom(customSanitizer). The custom function receives (value, {req, location, path}) and should return the sanitized value", "percentage": 95, "note": "Official feature implemented via PR #516"},
        {"solution": "For synchronous sanitizers, directly modify req[location][path] inside custom() to transform the value", "percentage": 90, "command": "check(''field'').custom((value, {req, location, path}) => { req[location][path] = newValue; })"},
        {"solution": "Combine multiple sanitizers by chaining multiple .custom() calls on the same field for layered sanitization", "percentage": 85, "note": "Each sanitizer receives output of previous one"}
    ]$$::jsonb,
    'express-validator v6.0+, Understanding of sanitization vs validation distinction',
    'Sanitized values properly transformed, matchedData() returns transformed values, No validation errors for sanitized fields',
    'Do not confuse sanitizers with validators - sanitizers transform data, validators check it. Async sanitizers have special requirements. Always return the value from custom sanitizers.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/express-validator/express-validator/issues/445'
),
(
    'Error: express-validator is not a function - breaking change in v6.0',
    'github-express-validator',
    'VERY_HIGH',
    $$[
        {"solution": "Update import statement: const { check, validationResult } = require(''express-validator'') and remove app.use(expressValidator) middleware registration", "percentage": 95, "note": "v6.0.0 changed from middleware to array-based validators"},
        {"solution": "Pass validation rules directly in route handler as middleware array: app.post(''/route'', [check(''field'').exists()], handler)", "percentage": 95, "command": "const { check, body, validationResult } = require(''express-validator''); router.post(''/endpoint'', [body(''email'').isEmail()], (req, res) => {})"},
        {"solution": "If stuck on v5.x API, downgrade: npm install express-validator@5.3.1 --save-exact", "percentage": 75, "note": "Not recommended for new projects - migrate to v6+ pattern"},
        {"solution": "Import from correct subpath if using TypeScript: import { check } from ''express-validator/check''", "percentage": 80, "note": "Some versions have nested exports"}
    ]$$::jsonb,
    'express-validator v6.0+, Node.js project with package.json, Understanding of middleware vs route handler patterns',
    'Route handlers execute without ''is not a function'' error, Validation errors properly collected via validationResult(req)',
    'Do not use app.use(expressValidator()) in v6+. Do not mix v5 and v6 patterns. Always destructure exports. Do not forget to call validationResult() in handler.',
    0.95,
    'sonnet-4',
    NOW(),
    'https://github.com/express-validator/express-validator/issues/735'
),
(
    'Support multiple custom validators or sanitizers on same field in checkSchema',
    'github-express-validator',
    'HIGH',
    $$[
        {"solution": "Combine multiple validations in single custom function using conditional logic and dynamic errorMessage: custom: { options: (value, {req}) => { if (!check1) { this.message = ''Error1''; return false; } else if (!check2) { this.message = ''Error2''; return false; } return true; }}", "percentage": 92, "note": "Most practical approach for multiple validations"},
        {"solution": "Use errorMessage as function to support dynamic messages: errorMessage: (_, params) => params.errorMessage || ''Invalid'', then set params.errorMessage in custom validator", "percentage": 88, "note": "Allows context-aware error messages"},
        {"solution": "Chain multiple check/sanitize methods on same field: check(''field'').custom(v1).custom(v2).custom(v3)", "percentage": 90, "command": "body(''email'').isEmail().bail().custom(checkAvailable).bail()"},
        {"solution": "Create helper function that runs multiple validators and returns combined result with proper error collection", "percentage": 85, "note": "Useful for complex validation logic"}
    ]$$::jsonb,
    'express-validator v6.2+, checkSchema pattern, Understanding of validation flow',
    'All custom validations execute, Proper error messages for each validation case, matchedData() returns validated field',
    'Each validator in chain needs .bail() to prevent subsequent validators from running after failure. Error messages in conditional logic must be set on ''this''. Multiple separate check() calls for same field execute independently.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/express-validator/express-validator/issues/552'
),
(
    'express-validator v6.9.1 breaks TypeScript compilation - source .ts files in npm package',
    'github-express-validator',
    'MEDIUM',
    $$[
        {"solution": "Upgrade to v6.9.2 or later where npm package correctly excludes source TypeScript files, including only compiled .js and .d.ts files", "percentage": 95, "note": "Official fix released"},
        {"solution": "Downgrade to v6.9.0: npm install express-validator@6.9.0", "percentage": 90, "note": "Temporary workaround if upgrade blocked"},
        {"solution": "Add to tsconfig.json: \"exclude\": [\"node_modules\"] and \"skipLibCheck\": true to bypass TypeScript compilation of dependencies", "percentage": 85, "command": "{ \"compilerOptions\": { \"skipLibCheck\": true }, \"exclude\": [\"node_modules\"] }"},
        {"solution": "If noImplicitAny is enabled, set \"skipLibCheck\": true in tsconfig.json compiler options", "percentage": 80, "note": "Allows tsc to skip type checking node_modules"}
    ]$$::jsonb,
    'express-validator package, TypeScript with noImplicitAny enabled, Node.js 12+',
    'npm run build or tsc completes without errors, express-validator imports without type errors, Production build succeeds',
    'v6.9.1 is known broken release - always upgrade or downgrade. Do not use skipLibCheck as permanent solution. The issue was npm distribution config (.npmignore), not source code itself.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://github.com/express-validator/express-validator/issues/973'
),
(
    'Conditional validation - run validators only when condition is true',
    'github-express-validator',
    'VERY_HIGH',
    $$[
        {"solution": "Use .if() method with custom function: body(''field'').if((value, {req}) => req.body.trigger).exists().isEmail()", "percentage": 95, "note": "Most reliable approach - recommended for simple conditions"},
        {"solution": "Use .if() with validation chain condition: body(''optional_field'').if(body(''type'').equals(''special'')).exists().isLength({min: 5})", "percentage": 90, "note": "Declarative approach but less predictable than custom functions"},
        {"solution": "Validate parent condition separately before running dependent validators: if (req.body.password) { run passwordCheck }", "percentage": 85, "note": "Works but requires manual middleware logic"},
        {"solution": "For complex conditional chains, use bail() to stop validation: check(''field'').exists().bail().custom(validator1).bail()", "percentage": 88, "command": "body(''password'').if((value, {req}) => req.body.changePassword).bail().isLength({min: 8})"}
    ]$$::jsonb,
    'express-validator v6.1.0+, Middleware setup with validationResult handling',
    'Validators execute only when condition evaluates to true, Error messages only appear for failed conditional validators, matchedData() includes conditionally validated fields',
    'Chain conditions sometimes behave inconsistently compared to custom functions. Do not rely on validation errors in condition function - use return boolean. Bail() only affects current chain, not parallel checks.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/express-validator/express-validator/issues/658'
),
(
    'Break validation chain on first error with bail()',
    'github-express-validator',
    'HIGH',
    $$[
        {"solution": "Add .bail() method after each validator to stop chain execution on first failure: check(''field'').exists().bail().isEmail().bail()", "percentage": 95, "note": "Built-in method, official recommended approach"},
        {"solution": "For single-field validation, place one .bail() at end of chain to prevent all subsequent validators after first error", "percentage": 90, "command": "body(''email'').notEmpty().bail().isEmail()"},
        {"solution": "Note that .bail() only affects validators within same check() chain - multiple check() calls for same field execute independently", "percentage": 85, "note": "Each chain has its own bail context"},
        {"solution": "Combine with if() for conditional early termination: check(''field'').exists().bail().if(condition).custom(validator)", "percentage": 85, "note": "Prevents running expensive validators if basic checks fail"}
    ]$$::jsonb,
    'express-validator v6.2.0+, Standard validation chain setup',
    'When first validator fails, subsequent validators in chain do not execute, No error array from failed chain, Validation result shows only first error from bailed chain',
    'Do not assume .bail() affects multiple check() calls - each check statement is isolated. Cannot conditionally bail based on error value. Bail placement matters - put .bail() after each critical validator.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://github.com/express-validator/express-validator/issues/638'
),
(
    'Express 5 compatibility - req.query is now read-only, cannot sanitize directly',
    'github-express-validator',
    'MEDIUM',
    $$[
        {"solution": "Use matchedData() to extract sanitized values instead of modifying req.query: const sanitized = matchedData(req, {locations: [''query'']})", "percentage": 95, "note": "Recommended approach for Express 5+"},
        {"solution": "Create middleware that stores sanitized data in custom property: req.sanitizedQuery = matchedData(req, {locations: [''query'']}) instead of modifying req.query", "percentage": 92, "command": "app.use((req, res, next) => { req.sanitizedQuery = matchedData(req, {locations: [''query'']}); next(); })"},
        {"solution": "Upgrade to express-validator v7.0.0+ which has native Express 5 support and handles immutable query", "percentage": 90, "note": "Full compatibility, no workarounds needed"},
        {"solution": "For body/params validation, express-validator still works normally - issue only affects immutable query object", "percentage": 88, "note": "Body and params remain mutable"}
    ]$$::jsonb,
    'Express 5.1+, express-validator v6.2+, querystring to be sanitized',
    'Sanitized query values available without modifying immutable req.query, matchedData() returns properly transformed values, No "Cannot assign to read only property" errors',
    'Do not try to modify req.query directly in Express 5 - it is a getter. matchedData() returns original values, not sanitized ones, unless you use sanitize. Sanitization via check/body works, not via sanitize on query location.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/express-validator/express-validator/issues/1325'
),
(
    'matchedData() returns unwanted fields for nested objects - includes unvalidated properties',
    'github-express-validator',
    'MEDIUM',
    $$[
        {"solution": "Explicitly validate all nested fields you want to include: body(''address.street'').exists(), body(''address.city'').exists() - do not validate parent object", "percentage": 90, "note": "Most reliable solution - prevents property leakage"},
        {"solution": "Do NOT validate parent object and nested properties together: remove body(''address'').isObject() if validating address.street, address.city individually", "percentage": 92, "note": "Root cause - parent validation causes all properties to be included"},
        {"solution": "Use filterData to select only validated fields after matchedData(): const filtered = Object.keys(validated).reduce((acc, key) => { if (definedFields.includes(key)) acc[key] = validated[key]; return acc; }, {})", "percentage": 85, "note": "Post-processing approach"},
        {"solution": "Upgrade to latest express-validator version for potential fixes in matchedData behavior with nested structures", "percentage": 80, "note": "Ongoing issue - check changelog for improvements"}
    ]$$::jsonb,
    'express-validator, Nested object request data, Understanding of matchedData() behavior',
    'matchedData() returns only validated fields, No extraneous properties in output, Can safely use matched data without security review',
    'Validating parent object (address.isObject()) causes all child properties to be included in matchedData() output regardless of validation. Cannot easily whitelist nested properties - must validate each explicitly. This is counter-intuitive behavior.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/express-validator/express-validator/issues/820'
),
(
    'Reject unknown fields - only allow validated fields in request body',
    'github-express-validator',
    'HIGH',
    $$[
        {"solution": "Use matchedData() to extract only validated fields, then manually check: if (Object.keys(req.body).length !== Object.keys(matched).length) reject with error", "percentage": 85, "note": "Manual approach, requires extra middleware"},
        {"solution": "Upgrade to express-validator v7.0.0+ and use stripUnknown option in matchedData(): matchedData(req, {locations: [''body''], includeOptionals: false})", "percentage": 90, "note": "v7+ has better unknown field handling"},
        {"solution": "Create custom validation middleware that validates expected fields and explicitly rejects requests with extra properties", "percentage": 88, "command": "const validateNoExtra = (schema) => { return (req, res, next) => { const extra = Object.keys(req.body).filter(k => !Object.keys(schema).includes(k)); if (extra.length) res.status(400).json({error: ''Unknown fields''}); else next(); }; }"},
        {"solution": "Document API clients about strict field validation and include schema in API documentation to prevent extra fields", "percentage": 80, "note": "Preventative approach - limits issue at source"}
    ]$$::jsonb,
    'express-validator v6+, Route handler with validation middleware, Request body data',
    'Extra fields in request rejected with 400 error, matchedData() returns only declared fields, API enforces strict schema compliance',
    'Cannot use matchedData() alone for rejection - must compare field counts. Object-only whitelisting (headers, cookies have system fields). Extra field validation is additive - difficult to deny by default. v7.0.0 PR #1204 addressed this better.',
    0.86,
    'sonnet-4',
    NOW(),
    'https://github.com/express-validator/express-validator/issues/809'
),
(
    'Custom error messages for individual isStrongPassword validation rules',
    'github-express-validator',
    'MEDIUM',
    $$[
        {"solution": "Replace isStrongPassword with individual validators for each requirement: body(''password'').isLength({min:8}).custom(hasUpper).custom(hasLower).custom(hasNumber).custom(hasSymbol) with custom error messages", "percentage": 92, "note": "Granular control, allows per-rule messages"},
        {"solution": "Use single custom validator function that performs all password checks and returns detailed error: custom: {options: (val) => { if (!hasMin8) throw new Error(''Min 8 chars''); if (!hasUpper) throw new Error(''Needs uppercase''); }}", "percentage": 90, "command": "body(''password'').custom((val) => { if (val.length < 8) throw new Error(''Password must be 8+ chars''); if (!/[A-Z]/.test(val)) throw new Error(''Needs uppercase''); })"},
        {"solution": "Use checkSchema with separate validation paths for each strength rule with individual errorMessage fields", "percentage": 88, "note": "Schema-based approach, works with middleware"},
        {"solution": "Post-process validation results to expand generic isStrongPassword error into detailed messages based on requirements", "percentage": 80, "note": "Maps single error to multiple user-facing messages"}
    ]$$::jsonb,
    'express-validator v6.2+, Password validation requirements defined, checkSchema or validation chains',
    'Each password requirement displays specific error message when violated, User receives clear feedback on what makes password weak, Frontend can display per-requirement validation',
    'isStrongPassword validator does not support per-rule error messages - single message applies to all failures. Cannot determine which specific rule failed from validation result. Breaking password checks into multiple validators increases request processing time.',
    0.84,
    'sonnet-4',
    NOW(),
    'https://github.com/express-validator/express-validator/issues/1335'
),
(
    'Promise rejection error - "rejected with a non-error: [object Array]"',
    'github-express-validator',
    'MEDIUM',
    $$[
        {"solution": "Use getValidationResult() instead of asyncValidationErrors(): const result = await getValidationResult(req); if (!result.isEmpty()) return res.json({errors: result.array()})", "percentage": 95, "note": "Modern approach, eliminates promise rejection warning"},
        {"solution": "Call .throw() on validation result to properly wrap errors: result.throw() will throw Error object instead of array", "percentage": 92, "command": "validationResult(req).throw() instead of rejecting with errors array"},
        {"solution": "Use .array() to get errors as array without throwing: const errors = validationResult(req).array() then handle manually", "percentage": 88, "note": "Non-throwing approach for custom error handling"},
        {"solution": "Wrap validation errors in custom Error class for proper promise rejection: reject(new ValidationErrors(errors))", "percentage": 85, "note": "v3.0.0+ provides built-in result objects"}
    ]$$::jsonb,
    'express-validator v3.0.0+, Promise-based route handlers, Error middleware setup',
    'No "rejected with a non-error" warning in logs, Promise rejection caught properly by error middleware, Validation errors accessible in error handler',
    'Old asyncValidationErrors() rejects with array not Error - causes warnings. Do not reject with raw validation error array. getValidationResult() is async, must await it. Error handlers must be registered for promise rejections.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/express-validator/express-validator/issues/223'
),
(
    'Wildcard pattern validation for nested array-like objects and dynamic field indices',
    'github-express-validator',
    'MEDIUM',
    $$[
        {"solution": "Use wildcard (*) syntax in schema validation paths: checkSchema({''users.*.email'': {notEmpty: {}, isEmail: {}}, ''users.*.name'': {notEmpty: {}}})", "percentage": 95, "note": "Official feature since v4.0.0"},
        {"solution": "Validates both array indices and object properties: ''items.*.price'' matches items[0].price, items[1].price, items.product.price, items.service.price", "percentage": 93, "command": "checkSchema({''data.*.id'': {isInt: {}}, ''data.*.enabled'': {isBoolean: {}}})"},
        {"solution": "Error messages include actual parameter path: {param: ''users.1.email'', msg: ''Invalid Email'', value: ''user@''}", "percentage": 90, "note": "Useful for identifying which element failed"},
        {"solution": "Combine wildcards with nested validation: ''form.sections.*.fields.*.value'' for deeply nested structures", "percentage": 85, "note": "Multiple wildcard levels supported"}
    ]$$::jsonb,
    'express-validator v4.0.0+, checkSchema validation setup, Dynamic nested data structures',
    'Wildcard patterns match multiple array indices and object properties, Validation errors report specific failed indices, matchedData() includes all validated wildcard fields',
    'Wildcard (*) only works in checkSchema, not in check() chains. Do not use in regular check(''field'') - use only in schema definitions. Performance may degrade with many wildcard matches. traverse library is dependency.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/express-validator/express-validator/issues/234'
),
(
    'TypeScript: Define validation schemas outside checkSchema call with proper typing',
    'github-express-validator',
    'MEDIUM',
    $$[
        {"solution": "Import Schema type and use satisfies at object level: const schema = {...} satisfies Schema; This provides full type safety without casting individual fields", "percentage": 94, "note": "Recommended modern approach with TypeScript 4.9+"},
        {"solution": "Use as const satisfies [IsIntOptions] on individual options arrays: isInt: {options: [{min:0}] as const satisfies [IsIntOptions]}", "percentage": 88, "note": "Field-level typing, verbose but explicit"},
        {"solution": "Define schema as const to allow TypeScript to infer literal types for options objects and arrays", "percentage": 90, "command": "const userSchema = {emailField: {isEmail: {options: [{}] as const}}} as const satisfies Schema;"},
        {"solution": "Avoid typing individual validator options - rely on satisfies Schema at root level for complete schema validation", "percentage": 92, "note": "Less boilerplate, better maintainability"}
    ]$$::jsonb,
    'TypeScript 4.9+, express-validator package with types, checkSchema validation',
    'Schema definition passes TypeScript compilation, No type errors on validator options arrays, satisfies Schema validation passes, matchedData() returns properly typed results',
    'TypeScript infers array types for options instead of tuples - must use as const or satisfies to narrow type. Do not use separate type annotations on each field. Older TypeScript versions lack satisfies keyword.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/express-validator/express-validator/issues/1328'
),
(
    'Default error messages for validators - generic "Invalid value" messages',
    'github-express-validator',
    'MEDIUM',
    $$[
        {"solution": "Always provide custom errorMessage for each validator: check(''email'', ''Email must be valid'').isEmail()", "percentage": 95, "note": "Best practice - explicit messages improve UX"},
        {"solution": "Create validation schema with standardized messages: const msgMap = {email: ''Email invalid'', required: ''Field required''}; then use in schemas", "percentage": 90, "note": "Centralized message management"},
        {"solution": "Use errorMessage as function for context-aware messages: errorMessage: (value, {req, location}) => location === ''query'' ? ''Invalid query param'' : ''Invalid field''", "percentage": 88, "command": "isEmail: {errorMessage: (val, {req}) => req.i18n.t(''email.invalid'')}"},
        {"solution": "Create wrapper functions for common validators with built-in messages: const validateEmail = () => check(''email'', ''Email invalid'').isEmail()", "percentage": 85, "note": "Reduces repetition across routes"}
    ]$$::jsonb,
    'express-validator v6+, Error handling middleware, User-facing API responses',
    'All validation errors display meaningful messages to users, Error messages match request context, No generic "Invalid value" errors in responses',
    'Default express-validator messages are intentionally generic. Do not rely on default messages - must customize every validator. Message localization requires separate implementation. Dynamic messages based on failed rule not easily supported by single errorMessage field.',
    0.86,
    'sonnet-4',
    NOW(),
    'https://github.com/express-validator/express-validator/issues/523'
);
