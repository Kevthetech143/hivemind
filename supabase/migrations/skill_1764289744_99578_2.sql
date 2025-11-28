INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Microservices Patterns - Design distributed systems with service boundaries, event-driven communication, and resilience',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Decompose monoliths by business capability or DDD bounded contexts",
      "manual": "Organize services around business functions (OrderService, PaymentService, InventoryService). Each service owns its domain and database. Use Strangler Fig pattern to gradually extract from monolith. Implement API Gateway for central routing.",
      "note": "Avoid distributed monolith by ensuring loose coupling and avoiding chatty inter-service calls"
    },
    {
      "solution": "Implement synchronous REST communication with HTTP clients",
      "cli": {
        "macos": "pip install httpx tenacity",
        "linux": "pip install httpx tenacity",
        "windows": "pip install httpx tenacity"
      },
      "manual": "Use httpx.AsyncClient with timeout/limits configuration. Implement retries with exponential backoff using tenacity @retry decorator. Set max_keepalive_connections=20, timeout=5.0 seconds.",
      "note": "Always set connection timeouts to prevent hanging requests. Use exponential backoff (min=2, max=10) to avoid thundering herd"
    },
    {
      "solution": "Design asynchronous event-driven communication with Kafka",
      "cli": {
        "macos": "pip install aiokafka",
        "linux": "pip install aiokafka",
        "windows": "pip install aiokafka"
      },
      "manual": "Use AIOKafkaProducer for publishing domain events with event_id, event_type, aggregate_id, occurred_at, and data. Use AIOKafkaConsumer with group_id for subscribing to topics. Serialize/deserialize events as JSON.",
      "note": "Events allow eventual consistency and decouple services. Use topic names matching event types (OrderCreated, PaymentCompleted)"
    },
    {
      "solution": "Implement Saga pattern for distributed transactions",
      "cli": {
        "macos": "pip install dataclasses-json",
        "linux": "pip install dataclasses-json",
        "windows": "pip install dataclasses-json"
      },
      "manual": "Create SagaStep objects with action and compensation functions. Execute steps sequentially and collect completed steps. On failure, run compensations in reverse order (cascading rollback). Track SagaStatus (PENDING, COMPLETED, COMPENSATING, FAILED).",
      "note": "Each step must have corresponding compensation logic. Example: create_order paired with cancel_order. Handle compensation failures gracefully with logging"
    },
    {
      "solution": "Protect against cascade failures with Circuit Breaker pattern",
      "cli": {
        "macos": "pip install pybreaker",
        "linux": "pip install pybreaker",
        "windows": "pip install pybreaker"
      },
      "manual": "Implement CircuitBreaker with states: CLOSED (normal), OPEN (failing, reject requests), HALF_OPEN (testing recovery). Track failure_count and reset after recovery_timeout. Transition to OPEN after N failures, to HALF_OPEN after timeout, back to CLOSED after success_threshold successes.",
      "note": "Default thresholds: failure_threshold=5, recovery_timeout=30s, success_threshold=2. Raise CircuitBreakerOpenError when open"
    }
  ]'::jsonb,
  'script',
  'Python 3.7+, async/await support, understanding of distributed systems',
  'Distributed monolith (tight coupling), chatty services (N+1 calls), shared databases, ignoring network failures, no compensation logic, premature microservices extraction',
  'Services operate independently with clear boundaries, event-driven communication works without cascade failures, sagas complete with proper compensation, circuit breaker rejects calls when service fails',
  'Microservices architecture patterns including decomposition, synchronous/asynchronous communication, sagas, and circuit breakers',
  'https://skillsmp.com/skills/wshobson-agents-plugins-backend-development-skills-microservices-patterns-skill-md',
  'admin:HAIKU_SKILL_1764289744_99578'
);
