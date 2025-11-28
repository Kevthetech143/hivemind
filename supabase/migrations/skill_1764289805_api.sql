INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'API Design Principles - Master REST and GraphQL API design for scalable APIs',
  'claude-code',
  'skill',
  '[
    {
      "solution": "REST Resource Design",
      "cli": {
        "macos": "# Use curl to test REST endpoints: curl -X GET http://localhost:8000/api/users",
        "linux": "# Use curl to test REST endpoints: curl -X GET http://localhost:8000/api/users",
        "windows": "# Use curl to test REST endpoints: curl -X GET http://localhost:8000/api/users"
      },
      "manual": "Design resources using nouns (users, orders, products). Use HTTP methods: GET (retrieve), POST (create), PUT (replace), PATCH (update), DELETE (remove). Avoid action verbs in URLs.",
      "note": "Resource-oriented architecture promotes consistent, intuitive APIs. Use plural names for collections (/users not /user)"
    },
    {
      "solution": "Implement Pagination and Filtering",
      "cli": {
        "macos": "curl -X GET ''http://localhost:8000/api/users?page=1&page_size=20&status=active&search=john''",
        "linux": "curl -X GET ''http://localhost:8000/api/users?page=1&page_size=20&status=active&search=john''",
        "windows": "curl -X GET \"http://localhost:8000/api/users?page=1&page_size=20&status=active&search=john\""
      },
      "manual": "Add query parameters for pagination (page, page_size), filtering (status, created_after), and searching. Return pagination metadata including total count, current page, and pages total.",
      "note": "Always paginate large collections. Enforce maximum page size (e.g., 100). Include has_next and has_prev for navigation."
    },
    {
      "solution": "Error Handling and Status Codes",
      "cli": {
        "macos": "curl -i -X POST http://localhost:8000/api/users -d ''{}''",
        "linux": "curl -i -X POST http://localhost:8000/api/users -d ''{}''",
        "windows": "curl -i -X POST http://localhost:8000/api/users -d \"{}\""
      },
      "manual": "Use correct HTTP status codes: 200 (OK), 201 (Created), 204 (No Content), 400 (Bad Request), 401 (Unauthorized), 403 (Forbidden), 404 (Not Found), 422 (Unprocessable Entity), 500 (Server Error). Return consistent error format with error code, message, and details.",
      "note": "Always return detailed error messages. Include field-level validation errors for 422 responses. Use proper 401 vs 403 distinction."
    },
    {
      "solution": "GraphQL Schema Design",
      "cli": {
        "macos": "# Query introspection: curl -X POST http://localhost:4000/graphql -H ''Content-Type: application/json'' -d ''{ \"query\": \"{ __schema { types { name } } }\" }''",
        "linux": "# Query introspection: curl -X POST http://localhost:4000/graphql -H ''Content-Type: application/json'' -d ''{ \"query\": \"{ __schema { types { name } } }\" }''",
        "windows": "# Query introspection: curl -X POST http://localhost:4000/graphql -H \"Content-Type: application/json\" -d \"{ \\\"query\\\": \\\"{ __schema { types { name } } }\\\" }\""
      },
      "manual": "Define clear type definitions with proper non-null marking (!). Use interfaces for shared fields. Define queries for reads and mutations for writes. Create input types for mutations and payload types with error handling.",
      "note": "Schema-first development ensures consistency. Use interfaces and unions for polymorphism. Always include error field in mutation payloads."
    },
    {
      "solution": "GraphQL Pagination (Relay Cursor Pattern)",
      "cli": {
        "macos": "# Relay-style pagination query",
        "linux": "# Relay-style pagination query",
        "windows": "# Relay-style pagination query"
      },
      "manual": "Implement cursor-based pagination with UserConnection, UserEdge, and PageInfo types. Encode offsets as cursors. Return hasNextPage, hasPreviousPage, startCursor, and endCursor for navigation.",
      "note": "Cursor-based pagination is superior to offset pagination for real-time data. Prevents issues when data changes between requests."
    },
    {
      "solution": "Prevent N+1 Query Problem",
      "cli": {
        "macos": "# DataLoader batches requests automatically",
        "linux": "# DataLoader batches requests automatically",
        "windows": "# DataLoader batches requests automatically"
      },
      "manual": "Use DataLoaders to batch multiple ID requests into single database queries. Implement batch_load_fn to group and fetch data efficiently. Register loaders in request context for resolver access.",
      "note": "N+1 is common in GraphQL when resolvers independently fetch related data. DataLoaders solve by batching requests within same batch cycle."
    },
    {
      "solution": "Implement Input/Payload Mutation Pattern",
      "cli": {
        "macos": "# GraphQL mutation with input and payload",
        "linux": "# GraphQL mutation with input and payload",
        "windows": "# GraphQL mutation with input and payload"
      },
      "manual": "Create input types with all mutation parameters. Create payload types with optional result object and errors array. Return success indicators and field-level error details.",
      "note": "Input/Payload pattern enables better error reporting. Errors field allows partial successes in batch operations."
    },
    {
      "solution": "API Versioning Strategy",
      "cli": {
        "macos": "curl -H ''Accept: application/vnd.api+json; version=1'' http://localhost:8000/api/users",
        "linux": "curl -H ''Accept: application/vnd.api+json; version=1'' http://localhost:8000/api/users",
        "windows": "curl -H \"Accept: application/vnd.api+json; version=1\" http://localhost:8000/api/users"
      },
      "manual": "Choose versioning strategy: URL (/api/v1), header (Accept header), or query parameter. Document deprecation policy. Plan breaking changes in advance.",
      "note": "URL versioning is most visible and explicit. Header versioning keeps URLs clean. Query parameter versioning is least recommended."
    },
    {
      "solution": "Rate Limiting and Security",
      "cli": {
        "macos": "curl -i http://localhost:8000/api/users | grep ''X-RateLimit''",
        "linux": "curl -i http://localhost:8000/api/users | grep ''X-RateLimit''",
        "windows": "curl -i http://localhost:8000/api/users | findstr \"X-RateLimit\""
      },
      "manual": "Implement rate limiting per endpoint and user. Include X-RateLimit headers in responses. Return 429 status code when limit exceeded. Provide Retry-After header.",
      "note": "Rate limits prevent API abuse. Standard headers enable clients to implement backoff. Monitor for suspicious patterns."
    },
    {
      "solution": "API Documentation (OpenAPI/Swagger)",
      "cli": {
        "macos": "# FastAPI generates OpenAPI automatically at /docs",
        "linux": "# FastAPI generates OpenAPI automatically at /docs",
        "windows": "# FastAPI generates OpenAPI automatically at /docs"
      },
      "manual": "Generate OpenAPI/Swagger spec from API code. Include request/response examples for all endpoints. Document authentication, error codes, and rate limits. Keep docs synchronized with implementation.",
      "note": "Interactive documentation (Swagger UI) improves developer experience. Auto-generated docs reduce maintenance burden."
    }
  ]'::jsonb,
  'script',
  'Python 3.8+, FastAPI or GraphQL-core, understanding of HTTP methods and REST concepts, database knowledge for implementing resolvers',
  'Common mistakes: Using verbs in URLs (POST /api/createUser instead of POST /api/users), inconsistent error formats, missing pagination, ignoring N+1 in GraphQL, returning raw database fields in API responses, not versioning APIs, using wrong HTTP status codes, mixing REST and GraphQL poorly, undocumented APIs, no rate limiting',
  'Successfully test: GET requests return 200 with proper data, POST requests return 201 with created resource, PATCH requests update specific fields, DELETE requests return 204, invalid requests return 400 with error details, pagination works with has_next/has_prev, GraphQL resolvers batch-load with DataLoader, mutations return proper payload structure, rate limit headers present, OpenAPI spec generates correctly',
  'API design skill for REST and GraphQL APIs with pagination, error handling, and best practices',
  'https://skillsmp.com/skills/wshobson-agents-plugins-backend-development-skills-api-design-principles-skill-md',
  'admin:HAIKU_SKILL_1764289805_6883'
);
