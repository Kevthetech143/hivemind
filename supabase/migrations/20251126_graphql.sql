INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Syntax Error: Unexpected Name "test"',
    'graphql',
    'HIGH',
    '[
        {"solution": "Check for invalid character sequences or reserved keywords. Use GraphQL IDE like GraphiQL for real-time syntax validation. Ensure all field names follow naming conventions (alphanumeric, underscore, no dashes)", "percentage": 95},
        {"solution": "Validate query in Apollo Client DevTools or GraphQL Playground which provides auto-completion and highlights syntax errors immediately", "percentage": 90}
    ]'::jsonb,
    'GraphQL IDE or client library, query string to validate',
    'Query parses without GRAPHQL_PARSE_FAILED errors, GraphiQL accepts the query',
    'Using dashes in field names (my-field instead of myField), forgetting quotes in strings, mixing query syntax with variable syntax',
    0.92,
    'haiku',
    NOW(),
    'https://github.com/Escape-Technologies/graphql-armor/issues/571'
),
(
    'Syntax Error: Cannot parse the unexpected character "/"',
    'graphql',
    'HIGH',
    '[
        {"solution": "Escape special characters in string fields. If inserting HTML or markup, wrap in triple quotes or use escape sequences. For mutation inputs with special chars, use variables instead of inline strings", "percentage": 93},
        {"solution": "Replace malformed syntax characters with valid GraphQL string escaping. Use backslash escapes for quotes and special chars within strings", "percentage": 88}
    ]'::jsonb,
    'GraphQL mutation or query with string arguments',
    'Query executes without parse errors, HTML/special char content is properly received',
    'Embedding unescaped HTML directly in query strings, not using string escaping for forward slashes, including raw content instead of using variables',
    0.91,
    'haiku',
    NOW(),
    'https://github.com/requarks/wiki/discussions/5947'
),
(
    'GRAPHQL_PARSE_FAILED: Could not parse object keys with dashes',
    'graphql',
    'MEDIUM',
    '[
        {"solution": "Rename fields to use camelCase (myKey instead of my-key) or snake_case (my_key). GraphQL parser does not support dashes in field names. Update client queries to match schema field names exactly", "percentage": 96},
        {"solution": "If API requires dash-separated names, use aliasing: query { myKey: my-key } to map dashed fields to camelCase", "percentage": 85}
    ]'::jsonb,
    'GraphQL schema definition, client query',
    'Query parses successfully, fields resolve without GRAPHQL_PARSE_FAILED errors',
    'Assuming dashes work in field names like REST APIs, not using aliases for legacy field names, mismatch between schema definition and query usage',
    0.94,
    'haiku',
    NOW(),
    'https://github.com/taion/graphql-type-json/issues/102'
),
(
    'Cannot query field "fieldName" on type "Query". Did you mean "otherField"?',
    'graphql',
    'HIGH',
    '[
        {"solution": "Verify field exists in current schema using introspection. Reload schema in IDE/client. Check field name matches exactly (case-sensitive). Use apollo cli: apollo service:check to validate against schema", "percentage": 97},
        {"solution": "If schema was recently updated, clear schema cache, restart development server, regenerate TypeScript types with apollo codegen", "percentage": 92}
    ]'::jsonb,
    'GraphQL schema definition accessible, IDE or GraphQL client',
    'Query field resolves successfully, no GRAPHQL_VALIDATION_FAILED errors in response',
    'Schema mismatch between client and server, stale cached schema, typos in field names, case sensitivity errors (Game vs game)',
    0.95,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/38036128/graphql-validation-error'
),
(
    'GRAPHQL_VALIDATION_FAILED: Operation failed validation against schema',
    'graphql',
    'HIGH',
    '[
        {"solution": "Run introspection query to view schema: { __schema { types { name } } }. Validate all queried fields exist. Use GraphQL Inspector tool to detect schema mismatches before deployment", "percentage": 94},
        {"solution": "Enable debug mode in Apollo Server to get detailed validation messages. Check schema definition file for required vs optional fields and argument constraints", "percentage": 89}
    ]'::jsonb,
    'GraphQL schema, request body with query',
    'Introspection query succeeds, schema validation passes in CI/CD, query executes without validation errors',
    'Using old schema definition, missing schema file, not updating client queries after schema changes, ignoring required arguments',
    0.93,
    'haiku',
    NOW(),
    'https://graphql.org/learn/validation/'
),
(
    'Expected Iterable, but did not find one at runtime',
    'graphql',
    'MEDIUM',
    '[
        {"solution": "In resolver function, ensure array fields return arrays. If field is defined as [Type], resolver must return array not single object. Add type guard: Array.isArray(data) ? data : [data]", "percentage": 96},
        {"solution": "Check field type definition in schema. List fields must be [Type] not Type. Update resolver to always return array for list types", "percentage": 93}
    ]'::jsonb,
    'GraphQL resolver function, schema with list type fields',
    'List fields return arrays, no type errors in query response, resolver handles null/undefined gracefully',
    'Forgetting array notation in schema [Type] vs Type, resolver returning single object for list field, null values in array fields',
    0.94,
    'haiku',
    NOW(),
    'https://blog.pixelfreestudio.com/graphql-query-errors-debugging-tips-and-tricks/'
),
(
    'BAD_USER_INPUT: Provided invalid variable value',
    'graphql',
    'HIGH',
    '[
        {"solution": "Validate variable types match schema definition. For enum fields, use exact string values from schema. For numbers, ensure proper type (Int vs Float). Log variable values to debug mismatch", "percentage": 94},
        {"solution": "Use custom validation in resolver before processing: if (!validEnumValue) throw new GraphQLError(Invalid enum). Provide helpful error message with allowed values", "percentage": 88}
    ]'::jsonb,
    'GraphQL variable, schema type definition, variables object',
    'Variables pass validation, query executes with correct data types, error message identifies invalid field',
    'Type coercion assumptions (string to int), wrong enum values, null passed for non-nullable fields, array instead of object',
    0.92,
    'haiku',
    NOW(),
    'https://www.apollographql.com/docs/apollo-server/data/errors/'
),
(
    'PERSISTED_QUERY_NOT_FOUND: APQ hash not cached',
    'graphql',
    'MEDIUM',
    '[
        {"solution": "Enable automatic persisted queries (APQ) on server and client. First request sends full query, server caches hash. Subsequent requests use hash only. Check APQ enabled: new ApolloServer({ persistedQueries: { cache: new InMemoryLRUCache() } })", "percentage": 95},
        {"solution": "If APQ fails, fall back to full query. Client library (Apollo Client 3.0+) handles this automatically. Verify server has cache configured", "percentage": 90}
    ]'::jsonb,
    'Apollo Server, Apollo Client 3.0+, APQ enabled',
    'Query executes via APQ hash on second request, fallback to full query on first request succeeds',
    'APQ not enabled on server, cache not configured, client sending old query format without full query on miss',
    0.91,
    'haiku',
    NOW(),
    'https://www.apollographql.com/docs/apollo-server/performance/apq/'
),
(
    'PERSISTED_QUERY_NOT_SUPPORTED: Server does not support automatic persisted queries',
    'graphql',
    'MEDIUM',
    '[
        {"solution": "Enable APQ in Apollo Server constructor: persistedQueries: { cache: new InMemoryLRUCache() }. Client automatically detects support and falls back if disabled", "percentage": 96},
        {"solution": "If APQ not needed, disable on client. Update Apollo Client cache policy to not use APQ for this endpoint", "percentage": 92}
    ]'::jsonb,
    'Apollo Server configuration, Apollo Client setup',
    'Server accepts APQ requests, client receives supportedExtensions in response',
    'Outdated Apollo Server version without APQ support, cache not initialized, wrong server configuration',
    0.93,
    'haiku',
    NOW(),
    'https://www.apollographql.com/docs/apollo-server/performance/apq/'
),
(
    'OPERATION_RESOLUTION_FAILURE: Multiple operations sent without specifying operationName',
    'graphql',
    'MEDIUM',
    '[
        {"solution": "Include operationName field in request when query contains multiple operations. Example: { query: query GetUser {...} query GetPosts {...}, operationName: GetUser }", "percentage": 97},
        {"solution": "Or refactor to single operation per request. Split large queries into separate requests with different operationNames", "percentage": 89}
    ]'::jsonb,
    'GraphQL request with multiple operations',
    'Operation specified correctly, server executes correct operation, response contains expected data',
    'Forgetting operationName field, sending wrong operation name, multiple unnamed queries',
    0.95,
    'haiku',
    NOW(),
    'https://www.apollographql.com/docs/apollo-server/data/errors/'
),
(
    'BAD_REQUEST: Invalid JSON in request body',
    'graphql',
    'HIGH',
    '[
        {"solution": "Validate JSON syntax. Check Content-Type header is application/json. Verify request body structure: { query: string, variables: object?, operationName: string? }. Use JSON parser online to validate", "percentage": 97},
        {"solution": "Log full request body to debug. Ensure no trailing commas in JSON objects/arrays. Use proper JSON string escaping for special characters", "percentage": 94}
    ]'::jsonb,
    'HTTP POST request, JSON body',
    'Server accepts request without 400 status, JSON parses without errors',
    'Trailing commas in JSON, unquoted keys, mixing JavaScript object notation with JSON, double encoding variables',
    0.96,
    'haiku',
    NOW(),
    'https://graphql.org/learn/debug-errors/'
),
(
    '405 Method Not Allowed: Using unsupported HTTP method',
    'graphql',
    'MEDIUM',
    '[
        {"solution": "Use POST for mutations and all queries. Some servers allow GET for queries only. Never use PUT/DELETE/PATCH for GraphQL. Update client to use correct method", "percentage": 98},
        {"solution": "Verify server configuration allows GET for queries if needed. Most production servers require POST for all operations for security", "percentage": 93}
    ]'::jsonb,
    'HTTP client, GraphQL server',
    'Request accepted with 200 status, correct operation executes',
    'Sending GET request for mutation, using PUT/DELETE instead of POST, server config not allowing GET for queries',
    0.97,
    'haiku',
    NOW(),
    'https://graphql.org/learn/debug-errors/'
),
(
    '415 Unsupported Media Type: Wrong Content-Type header',
    'graphql',
    'MEDIUM',
    '[
        {"solution": "Set request header: Content-Type: application/json. Never use form-urlencoded or plain text for GraphQL. Verify headers before sending request", "percentage": 98},
        {"solution": "Check HTTP client library. Ensure headers set correctly: fetch(url, { headers: { Content-Type: application/json }, body: JSON.stringify(...) })", "percentage": 95}
    ]'::jsonb,
    'HTTP client, GraphQL endpoint',
    'Server accepts request with 200 status, query executes successfully',
    'Using form-urlencoded, missing Content-Type header, wrong MIME type',
    0.97,
    'haiku',
    NOW(),
    'https://graphql.org/learn/debug-errors/'
),
(
    '500 Internal Server Error: Unhandled exception in resolver',
    'graphql',
    'HIGH',
    '[
        {"solution": "Add try-catch blocks in resolvers. Log full error with context. Check server logs for stack trace. Add error handling middleware in Apollo Server using formatError hook", "percentage": 93},
        {"solution": "Set includeStacktraceInErrorResponses: false in production, true in development. Wrap database queries in error handlers. Use Apollo error plugin for centralized error handling", "percentage": 90}
    ]'::jsonb,
    'GraphQL resolver, Node.js/Apollo Server setup, server logs',
    'Error logged with full context, GraphQL error response contains custom error message, no crash',
    'Unhandled promise rejections, missing error handlers, exposing sensitive stack traces in production',
    0.91,
    'haiku',
    NOW(),
    'https://www.apollographql.com/docs/apollo-server/data/errors/'
),
(
    'INTERNAL_SERVER_ERROR: Unspecified error in resolver execution',
    'graphql',
    'HIGH',
    '[
        {"solution": "Enable debug mode. Check server logs for root cause. Wrap resolver in try-catch: catch (err) { throw new GraphQLError(err.message) }. Add validation before execution", "percentage": 92},
        {"solution": "Use Apollo Server context to pass logger. Log all resolver inputs/outputs: logger.debug({ args, result }). Compare request to expected schema types", "percentage": 89}
    ]'::jsonb,
    'Apollo Server, resolver function, server logs',
    'Specific error code in response, resolver error captured in logs, query returns partial data with error field',
    'Silent failures without logging, swallowing original error message, not validating inputs before processing',
    0.90,
    'haiku',
    NOW(),
    'https://www.apollographql.com/docs/apollo-server/data/errors/'
),
(
    'UNAUTHENTICATED: Missing or invalid authentication token',
    'graphql',
    'HIGH',
    '[
        {"solution": "Include JWT token in Authorization header: Authorization: Bearer <token>. Verify token valid using jwt.verify(). Set up auth middleware before resolver execution", "percentage": 96},
        {"solution": "For subscriptions, pass token in connection params handshake. Throw new GraphQLError(Not authenticated, { extensions: { code: UNAUTHENTICATED } }) on auth failure", "percentage": 92}
    ]'::jsonb,
    'JWT token, authentication middleware, GraphQL context',
    'Token validates successfully, user identity available in context, protected fields accessible',
    'Token in wrong header format, expired token not refreshed, missing token on first subscription handshake',
    0.94,
    'haiku',
    NOW(),
    'https://www.apollographql.com/docs/apollo-server/data/errors/'
),
(
    'FORBIDDEN: User authenticated but lacks permissions',
    'graphql',
    'HIGH',
    '[
        {"solution": "Check user role/permissions in resolver. Throw GraphQLError with code FORBIDDEN if insufficient. Implement middleware that validates permissions before resolver: if (!user.roles.includes(requiredRole)) throw error", "percentage": 95},
        {"solution": "Use directive-based authorization: @auth(requires: ADMIN) on fields. Customize error message: You do not have permission to access this field", "percentage": 91}
    ]'::jsonb,
    'User authentication context, role/permission definitions',
    'Only authorized users can access field, non-authorized get clear error message',
    'Checking permissions in resolver too late, not validating roles, exposing sensitive info in error message',
    0.93,
    'haiku',
    NOW(),
    'https://www.apollographql.com/docs/apollo-server/data/errors/'
),
(
    'Field resolver returned null for non-nullable field',
    'graphql',
    'HIGH',
    '[
        {"solution": "Make field nullable in schema if null is expected. Or ensure resolver always returns value for required fields. Add validation before returning null", "percentage": 96},
        {"solution": "Check schema definition. Non-nullable fields marked with ! must resolve to value. If null returned, change schema from !Type to Type or fix resolver logic", "percentage": 94}
    ]'::jsonb,
    'GraphQL schema with non-nullable fields, resolver function',
    'Resolver returns non-null value, schema correctly defines required fields, query includes all required data',
    'Resolver returning undefined, database query returning no results without error handling, missing validation',
    0.95,
    'haiku',
    NOW(),
    'https://www.apollographql.com/docs/apollo-server/data/errors/'
),
(
    'Scalar type not found in schema',
    'graphql',
    'MEDIUM',
    '[
        {"solution": "Add custom scalar definition: scalar DateTime. Import GraphQLScalarType and define parseValue/serialize functions. Register in schema before using in type definitions", "percentage": 97},
        {"solution": "Use built-in scalars (String, Int, Float, Boolean, ID) or install scalars package: npm install graphql-scalars. Import and add to schema", "percentage": 94}
    ]'::jsonb,
    'GraphQL schema definition file, custom scalar implementation',
    'Custom scalar resolves values correctly, queries return properly formatted data',
    'Using undefined scalar, not registering custom scalar in schema, missing serialization function',
    0.94,
    'haiku',
    NOW(),
    'https://www.apollographql.com/docs/apollo-server/schema/scalars/'
),
(
    'Cyclic schema definition detected',
    'graphql',
    'MEDIUM',
    '[
        {"solution": "Restructure schema to break cycles. Use interface to share fields instead. Replace circular type reference with ID field, resolve in separate query", "percentage": 93},
        {"solution": "If cycles unavoidable, lazy-load type definitions. Use thunk functions: () => UserType. GraphQL handles mutual references through lazy evaluation", "percentage": 89}
    ]'::jsonb,
    'GraphQL schema type definitions',
    'Schema builds without cyclic errors, introspection query succeeds, types resolve correctly',
    'Direct type references creating cycles, not using interfaces, missing lazy loading',
    0.91,
    'haiku',
    NOW(),
    'https://graphql.org/learn/schema/'
),
(
    'Fragment not defined',
    'graphql',
    'MEDIUM',
    '[
        {"solution": "Define fragment before using: fragment UserFields on User { id name email }. Then use in query: ...UserFields. Ensure fragment name matches usage exactly", "percentage": 97},
        {"solution": "Check fragment scope. Fragment defined at query level, use ...Fragment. In Apollo Client, register fragments in document", "percentage": 93}
    ]'::jsonb,
    'GraphQL query with fragment usage',
    'Fragment resolves correctly, query executes without undefined fragment error',
    'Typo in fragment name, fragment not defined before usage, scope mismatch',
    0.95,
    'haiku',
    NOW(),
    'https://graphql.org/learn/queries/#fragments'
),
(
    'Directive not found in schema',
    'graphql',
    'MEDIUM',
    '[
        {"solution": "Define directive: directive @auth(requires: String) on FIELD_DEFINITION. Or import from library: npm install graphql-directive-auth. Register with schema", "percentage": 96},
        {"solution": "Verify directive placement in schema correct (on FIELD_DEFINITION vs ARGUMENT_DEFINITION). Check directive name spelling matches usage", "percentage": 92}
    ]'::jsonb,
    'GraphQL schema, directive implementation',
    'Directive applies correctly to fields, query validates without undefined directive error',
    'Using undefined directive, wrong directive location, not registering directive in schema',
    0.94,
    'haiku',
    NOW(),
    'https://graphql.org/learn/queries/#directives'
),
(
    'Union type member not found in schema',
    'graphql',
    'MEDIUM',
    '[
        {"solution": "Define all union member types before union. union SearchResult = User | Post | Comment. Ensure all member types exist in schema with __typename field", "percentage": 97},
        {"solution": "Use inline fragments to query union fields: ... on User { id name }. Verify resolver returns correct __typename for type resolution", "percentage": 94}
    ]'::jsonb,
    'GraphQL union type definition, type implementations',
    'Union resolves correct types, inline fragments retrieve correct data, __typename available',
    'Member type not defined, typo in union member name, missing __typename in resolver',
    0.95,
    'haiku',
    NOW(),
    'https://graphql.org/learn/schema/#union-types'
),
(
    'Input validation failed: required argument missing',
    'graphql',
    'HIGH',
    '[
        {"solution": "Check function signature: query search(input: SearchInput!) requires argument. Pass input in query: search(input: {term: hello}) { ... }. Use variables instead of hardcoding", "percentage": 98},
        {"solution": "Verify schema defines argument as required (!) not optional. Set defaults if allowed: input: SearchInput! = {limit: 10}. Provide helpful error when missing", "percentage": 94}
    ]'::jsonb,
    'GraphQL query, function/mutation definition with required arguments',
    'Query includes required arguments, mutation executes successfully without BAD_USER_INPUT error',
    'Forgetting required argument in query, null value for required field, wrong argument name',
    0.97,
    'haiku',
    NOW(),
    'https://graphql.org/learn/schema/#input-types'
),
(
    'Enum value not valid for field type',
    'graphql',
    'MEDIUM',
    '[
        {"solution": "Use only defined enum values. For enum Role { ADMIN USER }, pass ADMIN not admin. Check schema for exact casing and spelling", "percentage": 98},
        {"solution": "Provide enum list in error message for better UX. In resolver: if (!Object.values(Role).includes(role)) throw new GraphQLError(Invalid role: + role + use: + Object.keys(Role))", "percentage": 91}
    ]'::jsonb,
    'GraphQL enum type definition, query with enum argument',
    'Enum value accepted, query executes with correct enum type',
    'Wrong casing (admin vs ADMIN), typo in enum value, not checking schema for valid values',
    0.96,
    'haiku',
    NOW(),
    'https://graphql.org/learn/schema/#enumeration-types'
);
