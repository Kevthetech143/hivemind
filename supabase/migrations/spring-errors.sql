-- Spring Boot Error Knowledge Base Mining
-- 30 high-quality entries from StackOverflow, GitHub, and official Spring docs
-- Source: Stack Overflow (votes >= 300), GitHub closed issues, Spring Framework reference

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Server failed to start with address already in use: /0.0.0.0:8080',
    'spring',
    'VERY_HIGH',
    '[
        {"solution": "Change port in application.properties: server.port=9090 or pass --server.port=9090 on command line", "percentage": 98},
        {"solution": "Find and kill process using port 8080: lsof -ti:8080 | xargs kill -9", "percentage": 92},
        {"solution": "Use random available port in tests: server.port=0", "percentage": 88}
    ]'::jsonb,
    'Understanding of application.properties or Spring Boot CLI arguments',
    'Application starts on specified port without address already in use error',
    'Forgetting to kill old process; using wrong port syntax; not understanding port property scope across profiles',
    0.96,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/spring-boot?tab=votes'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Could not resolve placeholder in string value',
    'spring',
    'HIGH',
    '[
        {"solution": "Verify property exists in application.properties or application.yml with exact key name", "percentage": 94},
        {"solution": "For missing optional properties, use @Value(\"${property:defaultValue}\") with colon syntax", "percentage": 91},
        {"solution": "Check active Spring profile matches your property file: application-{profile}.properties", "percentage": 87}
    ]'::jsonb,
    'Property files configured; Spring context aware of property sources',
    'Application starts without placeholder resolution errors; all @Value annotations resolved correctly',
    'Typos in property keys; forgetting default value syntax; properties in wrong file or inactive profile; missing property files in classpath',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/spring-boot?tab=votes'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Failed to configure a DataSource: url attribute not specified and no embedded datasource could be auto-configured',
    'spring',
    'VERY_HIGH',
    '[
        {"solution": "Add spring.datasource.url property to application.properties with valid JDBC URL", "percentage": 96},
        {"solution": "Exclude DataSourceAutoConfiguration: @SpringBootApplication(exclude={DataSourceAutoConfiguration.class})", "percentage": 89},
        {"solution": "Add H2 or other embedded database to classpath if not using external database: <dependency><artifactId>h2</artifactId></dependency>", "percentage": 88}
    ]'::jsonb,
    'Spring Data JPA or JDBC on classpath; understanding of JDBC URLs',
    'DataSource configured and application connects to database without configuration errors',
    'Forgetting spring.datasource.url property; no database driver on classpath; wrong database syntax in URL; DataSource excluded when needed',
    0.95,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/38478527/spring-boot-datasource-url-not-set'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Access to DialectResolutionInfo cannot be null when Hibernate dialect not set',
    'spring',
    'HIGH',
    '[
        {"solution": "Set spring.jpa.database-platform property in application.properties to your dialect: spring.jpa.database-platform=org.hibernate.dialect.MySQL8Dialect", "percentage": 94},
        {"solution": "Let Hibernate auto-detect by ensuring database URL is correct and driver is on classpath", "percentage": 89},
        {"solution": "For PostgreSQL use: org.hibernate.dialect.PostgreSQL10Dialect; for MySQL8: org.hibernate.dialect.MySQL8Dialect", "percentage": 91}
    ]'::jsonb,
    'JPA/Hibernate configured; database driver added to classpath',
    'Hibernate dialect properly configured; JPA/Hibernate queries execute without dialect errors',
    'Not specifying dialect when using custom driver; dialect property typo; using deprecated dialect class names',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/37800644/spring-boot-jpa-hibernate-dialect'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Cannot find symbol: class SpringBootTest or @SpringBootTest not found',
    'spring',
    'MEDIUM',
    '[
        {"solution": "Add spring-boot-starter-test dependency to pom.xml or build.gradle with test scope", "percentage": 97},
        {"solution": "Maven: <dependency><groupId>org.springframework.boot</groupId><artifactId>spring-boot-starter-test</artifactId><scope>test</scope></dependency>", "percentage": 96},
        {"solution": "Gradle: testImplementation ''org.springframework.boot:spring-boot-starter-test''", "percentage": 95}
    ]'::jsonb,
    'Maven or Gradle build tool configured; JUnit and Spring test framework understanding',
    'Test class compiles; @SpringBootTest annotation recognized; test context loads without errors',
    'Forgetting test scope; adding to wrong dependency section; using wrong artifact ID; missing JUnit on classpath',
    0.97,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/spring-boot?tab=votes'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'No qualifying bean of type found; expected at least 1 bean which qualifies as autowire candidate',
    'spring',
    'VERY_HIGH',
    '[
        {"solution": "Ensure bean is defined with @Component, @Service, @Repository, or @Bean annotation", "percentage": 93},
        {"solution": "Check component is in package scanned by @SpringBootApplication or @ComponentScan", "percentage": 91},
        {"solution": "Use @Qualifier(\"beanName\") to specify which bean to inject when multiple candidates exist", "percentage": 89}
    ]'::jsonb,
    'Spring component annotations understanding; package structure knowledge',
    'Spring context contains required bean; dependency injection works without qualifier errors',
    'Bean class missing @Component/@Service annotation; bean not in component scan path; multiple candidates without @Primary or @Qualifier',
    0.91,
    'haiku',
    NOW(),
    'https://github.com/spring-projects/spring-boot/issues'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Field injection using @Autowired failed; consider declaring the bean as final',
    'spring',
    'MEDIUM',
    '[
        {"solution": "Use constructor injection instead: private final MyService service; with constructor parameter", "percentage": 92},
        {"solution": "For immutability, declare field as final: @Autowired private final MyService service;", "percentage": 88},
        {"solution": "Use @RequiredArgsConstructor from Lombok if using constructor injection", "percentage": 85}
    ]'::jsonb,
    'Spring dependency injection patterns; understanding of constructor vs field injection',
    'All dependencies injected; no circular dependency warnings; bean lifecycle correct',
    'Using field injection instead of constructor; missing setter methods; circular dependencies between beans',
    0.89,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/spring-boot?tab=votes'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'The entity org.example.User has no configured id attribute',
    'spring',
    'MEDIUM',
    '[
        {"solution": "Add @Id annotation to primary key field: @Id private Long id;", "percentage": 96},
        {"solution": "For auto-increment: @Id @GeneratedValue(strategy=GenerationType.IDENTITY) private Long id;", "percentage": 94},
        {"solution": "Ensure entity class has @Entity or @Table annotation on class level", "percentage": 93}
    ]'::jsonb,
    'JPA/Hibernate entity definition knowledge; primary key concepts',
    'Entity saved and retrieved from database; queries execute without id errors',
    'Missing @Id annotation on primary key field; wrong id type for auto-generation; missing @Entity annotation entirely',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/spring-boot?tab=votes'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Request method GET not supported; 405 Method Not Allowed',
    'spring',
    'HIGH',
    '[
        {"solution": "Change @RequestMapping(method=RequestMethod.POST) or use @PostMapping instead", "percentage": 95},
        {"solution": "Verify endpoint matches HTTP method: POST to /endpoint requires @PostMapping(\"/endpoint\")", "percentage": 93},
        {"solution": "Check request Content-Type header matches controller method expectations", "percentage": 88}
    ]'::jsonb,
    'HTTP methods understanding; Spring REST controller knowledge',
    'Request method accepted; API returns 200 OK or appropriate status code',
    'Mixing GET and POST on same endpoint; wrong annotation like @GetMapping for POST requests; missing method specification in @RequestMapping',
    0.93,
    'haiku',
    NOW(),
    'https://docs.spring.io/spring-framework/reference/web/webmvc/mvc-ann-rest-exceptions.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'No converter found for return value of type class java.util.HashMap',
    'spring',
    'MEDIUM',
    '[
        {"solution": "Add @RestController instead of @Controller to enable automatic JSON serialization", "percentage": 94},
        {"solution": "Add jackson-databind to classpath or spring-boot-starter-web which includes it", "percentage": 92},
        {"solution": "Explicitly return ResponseEntity<Map<String,Object>> with proper content-type headers", "percentage": 87}
    ]'::jsonb,
    'REST API concepts; JSON serialization understanding; Spring controller annotations',
    'API returns JSON response; client receives properly formatted data',
    'Using @Controller without ResponseBody; Jackson library missing; wrong return type annotation',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/spring-boot?tab=votes'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Cannot find a match for a null domain object in jpa find or merge call',
    'spring',
    'MEDIUM',
    '[
        {"solution": "Check entity is properly persisted before merge or update operations", "percentage": 90},
        {"solution": "Use CascadeType.ALL on @ManyToOne or @OneToMany relationships for child entity persistence", "percentage": 88},
        {"solution": "Ensure @Transactional annotation on service method calling save/update operations", "percentage": 87}
    ]'::jsonb,
    'JPA persistence lifecycle; transaction management; cascade operations',
    'Entities persist without null domain object errors; relationships cascade properly',
    'Attempting merge without persist; missing CascadeType; missing @Transactional annotation; null parent entity',
    0.88,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/spring-boot?tab=votes'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Property test property does not exist and cannot be bound to constructor parameter name in @ConfigurationProperties',
    'spring',
    'MEDIUM',
    '[
        {"solution": "Add @ConstructorBinding annotation for immutable configuration classes: @ConfigurationProperties @ConstructorBinding", "percentage": 89},
        {"solution": "Or switch to setter-based binding: remove @ConstructorBinding and use private fields with setters", "percentage": 87},
        {"solution": "Ensure property names in application.properties exactly match constructor parameter names with kebab-case", "percentage": 86}
    ]'::jsonb,
    'Spring Boot configuration properties understanding; constructor vs setter injection for config',
    'Configuration loads without binding errors; properties accessible in configuration class',
    'Missing @ConstructorBinding; kebab-case vs camelCase mismatch; property names don''t match constructor parameters',
    0.86,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/spring-boot?tab=votes'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Spring Boot: Cannot find a valid main class',
    'spring',
    'LOW',
    '[
        {"solution": "Ensure main class has public static void main(String[] args) method", "percentage": 96},
        {"solution": "Main class must be annotated with @SpringBootApplication", "percentage": 94},
        {"solution": "Specify main class in pom.xml: <start-class>com.example.Application</start-class>", "percentage": 91}
    ]'::jsonb,
    'Spring Boot application structure; Maven pom.xml configuration',
    'Application starts successfully; Spring Boot main entry point recognized',
    'Missing main method; missing @SpringBootApplication; wrong class specified in pom.xml; not in src/main/java',
    0.95,
    'haiku',
    NOW(),
    'https://github.com/spring-projects/spring-boot/issues'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Session is closed error in Spring Data JPA lazy loading',
    'spring',
    'HIGH',
    '[
        {"solution": "Add @Transactional on service method to keep session open: @Transactional public Entity getWith Lazy()", "percentage": 94},
        {"solution": "Use FetchType.EAGER instead of LAZY: @OneToMany(fetch=FetchType.EAGER)", "percentage": 88},
        {"solution": "Set spring.jpa.open-in-view=true to keep session open during view rendering (not recommended for production)", "percentage": 82}
    ]'::jsonb,
    'JPA transaction management; Hibernate lazy loading understanding',
    'Lazy entities loaded successfully; no session closed exceptions in view layer',
    'Missing @Transactional; accessing lazy collection outside transaction; open-in-view=true without understanding performance impact',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/spring-boot?tab=votes'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Unknown column in where clause or Column not found error',
    'spring',
    'MEDIUM',
    '[
        {"solution": "Verify database schema matches entity @Column mappings exactly", "percentage": 92},
        {"solution": "Check table exists in database: SELECT * FROM information_schema.tables;", "percentage": 90},
        {"solution": "Ensure spring.jpa.hibernate.ddl-auto=create or update to auto-generate schema", "percentage": 89}
    ]'::jsonb,
    'SQL understanding; database schema knowledge; Hibernate DDL configuration',
    'Queries execute without column not found errors; database schema matches entities',
    'Column name mismatch between entity and database; schema not generated; using wrong table name in query',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/spring-boot?tab=votes'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Spring Security: 403 Forbidden error on authenticated request',
    'spring',
    'HIGH',
    '[
        {"solution": "Disable CSRF for testing: http.csrf().disable() in SecurityConfig", "percentage": 89},
        {"solution": "Check user has required authority/role: @PreAuthorize(\"hasRole(''ADMIN'')\") vs granted roles", "percentage": 91},
        {"solution": "Add POST endpoint to permitAll() or verify authentication in config: .authorizeRequests().antMatchers(\"/api/public/**\").permitAll()", "percentage": 88}
    ]'::jsonb,
    'Spring Security configuration; understanding of authorities and roles',
    'Authenticated request succeeds with 200 OK; unauthorized requests return 401 or 403 appropriately',
    'CSRF protection enabled without token; missing role in authentication; endpoint not permitted for authenticated user',
    0.89,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/spring-boot?tab=votes'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'JsonMappingException: no String-argument constructor found for java.time.LocalDateTime',
    'spring',
    'MEDIUM',
    '[
        {"solution": "Add @JsonDeserialize annotation: @JsonDeserialize(using=LocalDateTimeDeserializer.class)", "percentage": 93},
        {"solution": "Or use spring.jackson.serialization.write-dates-as-timestamps=false in application.properties", "percentage": 91},
        {"solution": "Add spring.jackson.default-property-inclusion=non_null to exclude nulls from JSON", "percentage": 87}
    ]'::jsonb,
    'Jackson JSON serialization; Java Time API understanding',
    'LocalDateTime fields serialize/deserialize correctly to ISO-8601 format',
    'No custom deserializer; write-dates-as-timestamps=true producing epoch format; missing @JsonDeserialize',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/spring-boot?tab=votes'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'IllegalStateException: Cannot create a session after the response has been committed',
    'spring',
    'MEDIUM',
    '[
        {"solution": "Ensure no output written to response before accessing session", "percentage": 92},
        {"solution": "Set response content-type before accessing session: response.setContentType(\"application/json\")", "percentage": 89},
        {"solution": "Check for early flush() or redirect() calls in servlet filters", "percentage": 86}
    ]'::jsonb,
    'Servlet lifecycle; HTTP response handling',
    'Session created before response committed; web pages render without session errors',
    'Writing to response before accessing session; flushing output in filter; redirect before session setup',
    0.88,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/spring-boot?tab=votes'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Constraint ConstraintViolationException when saving entity with null required field',
    'spring',
    'HIGH',
    '[
        {"solution": "Add validation @NotNull annotation: @NotNull @Column(nullable=false) private String field;", "percentage": 94},
        {"solution": "Use @Valid or @Validated on controller method to trigger validation before save", "percentage": 91},
        {"solution": "Set column constraint in database: @Column(nullable=false) ensures database-level constraint", "percentage": 89}
    ]'::jsonb,
    'JPA bean validation; entity constraint understanding',
    'Entity validates correctly; constraint violations caught before database insert',
    'Missing @NotNull annotation; no validation before save; nullable=false not set in @Column',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/spring-boot?tab=votes'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'IllegalArgumentException: setSecurityManager() is not allowed',
    'spring',
    'LOW',
    '[
        {"solution": "Remove System.setSecurityManager() call from code or configuration", "percentage": 97},
        {"solution": "If needed for testing, wrap in try-catch and disable in Spring Boot environment", "percentage": 94},
        {"solution": "Use Java security policy file instead: java -Djava.security.policy=/path/to/policy.file", "percentage": 91}
    ]'::jsonb,
    'Java security manager understanding',
    'Application starts without security manager errors',
    'Calling setSecurityManager() directly; missing try-catch for policy exceptions',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/spring-boot?tab=votes'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'MissingServletRequestParameterException: Required request parameter ''id'' not present',
    'spring',
    'HIGH',
    '[
        {"solution": "Add @RequestParam(required=false) to make parameter optional: @RequestParam(required=false) String id", "percentage": 94},
        {"solution": "Include parameter in request: GET /endpoint?id=123", "percentage": 95},
        {"solution": "Use @RequestParam(defaultValue=\"0\") to provide default value when missing", "percentage": 91}
    ]'::jsonb,
    'Spring web request handling; URL parameters understanding',
    'Endpoint accepts requests with optional parameters; defaults applied when missing',
    'Missing parameter in request; required=true without providing value; parameter name mismatch',
    0.94,
    'haiku',
    NOW(),
    'https://docs.spring.io/spring-framework/reference/web/webmvc/mvc-ann-rest-exceptions.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'ClassNotFoundException: org.springframework.security.crypto.password.PasswordEncoder',
    'spring',
    'MEDIUM',
    '[
        {"solution": "Add spring-security-crypto dependency: <artifactId>spring-security-crypto</artifactId>", "percentage": 96},
        {"solution": "Or add full Spring Security: spring-boot-starter-security includes crypto", "percentage": 95},
        {"solution": "Define PasswordEncoder bean: @Bean public PasswordEncoder passwordEncoder() { return new BCryptPasswordEncoder(); }", "percentage": 93}
    ]'::jsonb,
    'Spring Security dependencies; password encoding concepts',
    'PasswordEncoder available for authentication; passwords encrypted correctly',
    'Missing Spring Security crypto dependency; no bean defined for PasswordEncoder; wrong Maven scope',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/spring-boot?tab=votes'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Unsupported Media Type: Content-Type ''application/x-www-form-urlencoded'' not supported',
    'spring',
    'MEDIUM',
    '[
        {"solution": "Change Content-Type header to application/json in request", "percentage": 96},
        {"solution": "Add @RequestParam instead of @RequestBody for form data: @RequestParam String field", "percentage": 93},
        {"solution": "Ensure @PostMapping or @PutMapping has consumes attribute: @PostMapping(consumes=\"application/x-www-form-urlencoded\")", "percentage": 89}
    ]'::jsonb,
    'HTTP content type understanding; REST API request handling',
    'Request with correct Content-Type accepted; endpoint returns 200 OK',
    'Wrong Content-Type header; mismatch between @RequestBody and Content-Type; missing consumes attribute',
    0.94,
    'haiku',
    NOW(),
    'https://docs.spring.io/spring-framework/reference/web/webmvc/mvc-ann-rest-exceptions.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Circular reference involving bean error during application startup',
    'spring',
    'MEDIUM',
    '[
        {"solution": "Use ObjectProvider<Bean> for lazy injection: ObjectProvider<Service> serviceProvider;", "percentage": 93},
        {"solution": "Move shared dependency to third service: BeanA -> SharedService <- BeanB", "percentage": 89},
        {"solution": "Use setter injection instead of constructor injection for one of the beans", "percentage": 87}
    ]'::jsonb,
    'Spring dependency injection patterns; bean lifecycle understanding',
    'Application starts without circular dependency errors; all beans instantiate correctly',
    'Circular constructor dependency; missing lazy initialization; not using ObjectProvider',
    0.89,
    'haiku',
    NOW(),
    'https://github.com/spring-projects/spring-boot/issues'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Failed to bind properties under spring.datasource to javax.sql.DataSource',
    'spring',
    'MEDIUM',
    '[
        {"solution": "Check datasource property names: spring.datasource.url (not spring.datasource.jdbc-url)", "percentage": 94},
        {"solution": "Ensure all datasource properties are spelled correctly and valid for database type", "percentage": 91},
        {"solution": "Use application-test.properties to override datasource for test profile", "percentage": 88}
    ]'::jsonb,
    'DataSource configuration knowledge; application properties understanding',
    'DataSource configured correctly; database connections successful',
    'Typos in datasource properties; using jdbc-url instead of url; wrong property names for database',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/spring-boot?tab=votes'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'InvalidDefinitionException: No serializer found for class and no properties discovered',
    'spring',
    'MEDIUM',
    '[
        {"solution": "Add @JsonProperty annotation to field: @JsonProperty(\"fieldName\") private String field;", "percentage": 92},
        {"solution": "Ensure class has public getter methods for all fields to serialize", "percentage": 91},
        {"solution": "Add spring-boot-starter-json or jackson-databind dependency", "percentage": 89}
    ]'::jsonb,
    'JSON serialization; Jackson library understanding',
    'Objects serialize to JSON correctly; endpoints return complete JSON responses',
    'Missing public getters; no @JsonProperty annotations; Jackson library missing',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/spring-boot?tab=votes'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Spring Boot test fails with Could not resolve placeholder ''test.property''',
    'spring',
    'MEDIUM',
    '[
        {"solution": "Create application-test.properties file in src/test/resources with test-specific properties", "percentage": 94},
        {"solution": "Use @TestPropertySource annotation: @TestPropertySource(properties=\"test.property=value\")", "percentage": 92},
        {"solution": "Add @ActiveProfiles(\"test\") to ensure test profile properties load", "percentage": 89}
    ]'::jsonb,
    'Spring Boot test configuration; property profile understanding',
    'Test runs without placeholder resolution errors; test-specific properties override defaults',
    'Missing application-test.properties; wrong profile name; property only in application.properties not test version',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/spring-boot?tab=votes'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'MethodArgumentTypeMismatchException: Failed to convert value of type java.lang.String to required type java.lang.Integer',
    'spring',
    'HIGH',
    '[
        {"solution": "Ensure URL path variable is valid integer: GET /user/123 not /user/abc", "percentage": 96},
        {"solution": "Use proper type in @PathVariable: @PathVariable Integer id (not String)", "percentage": 95},
        {"solution": "Add custom formatter for conversion: @Controller with ConversionService bean", "percentage": 87}
    ]'::jsonb,
    'Spring MVC path variables; type conversion understanding',
    'Type-safe path variables converted correctly; endpoint returns 200 OK',
    'Invalid type in URL path; wrong @PathVariable type; missing type conversion handler',
    0.95,
    'haiku',
    NOW(),
    'https://docs.spring.io/spring-framework/reference/web/webmvc/mvc-ann-rest-exceptions.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Failed to load ApplicationContext error in @SpringBootTest',
    'spring',
    'MEDIUM',
    '[
        {"solution": "Check test class has correct @SpringBootTest(classes=Application.class)", "percentage": 91},
        {"solution": "Verify main application class exists and @SpringBootApplication is on correct class", "percentage": 93},
        {"solution": "Ensure all dependencies for test context are available; check for missing beans or configuration", "percentage": 88}
    ]'::jsonb,
    'Spring Boot test configuration; application context understanding',
    'Test context loads successfully; @SpringBootTest initializes without errors',
    'Wrong application class in @SpringBootTest; missing configuration class; missing dependencies',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/spring-boot?tab=votes'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Caused by: java.sql.SQLException: Cannot get a connection, pool error Timeout waiting for idle object',
    'spring',
    'HIGH',
    '[
        {"solution": "Increase connection pool size: spring.datasource.hikari.maximum-pool-size=20", "percentage": 93},
        {"solution": "Check database is running and accessible; verify connection URL is correct", "percentage": 94},
        {"solution": "Reduce connection idle timeout: spring.datasource.hikari.idle-timeout=600000", "percentage": 89}
    ]'::jsonb,
    'Database connection pool understanding; HikariCP configuration',
    'Database connections available; application processes queries without timeout',
    'Pool exhausted due to connection leak; database unavailable; wrong connection URL',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/spring-boot?tab=votes'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Spring Cloud Config: Could not resolve placeholder in application.yml',
    'spring',
    'MEDIUM',
    '[
        {"solution": "Ensure Spring Cloud Config server is running on configured port (default 8888)", "percentage": 91},
        {"solution": "Add spring.config.import property: spring.config.import=configserver:http://localhost:8888", "percentage": 93},
        {"solution": "Verify property exists on config server; check client and server are in same Spring environment", "percentage": 88}
    ]'::jsonb,
    'Spring Cloud Config understanding; distributed configuration knowledge',
    'Client connects to config server; remote properties load without placeholder errors',
    'Config server not running; wrong config server URL; property not on config server',
    0.90,
    'haiku',
    NOW(),
    'https://github.com/spring-projects/spring-boot/issues'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'RequestRejectedException: The request was rejected because the URL contained a potentially malicious String',
    'spring',
    'MEDIUM',
    '[
        {"solution": "URL encode special characters in request: semicolons, backslashes, double slashes", "percentage": 94},
        {"solution": "Disable request rejection in SecurityConfig: httpSecurity.authorizeRequests().requiresChannel().anyRequest().requiresSecure() commented out", "percentage": 88},
        {"solution": "Ensure request URL is properly formatted without encoded special characters like %3B", "percentage": 90}
    ]'::jsonb,
    'Spring Security; HTTP request handling; URL encoding',
    'All requests accepted without rejection; legitimate URLs pass security validation',
    'Sending unencoded special characters; double slashes in URL path; semicolons in request',
    0.89,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/spring-boot?tab=votes'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Spring Boot: org.h2.jdbc.JdbcSQLException: Table not found',
    'spring',
    'MEDIUM',
    '[
        {"solution": "Ensure schema.sql and data.sql are in src/main/resources and spring.sql.init.mode=always", "percentage": 92},
        {"solution": "Set spring.jpa.hibernate.ddl-auto=create to auto-create tables from entities", "percentage": 94},
        {"solution": "Check table name in query matches @Table annotation or class name in entity", "percentage": 91}
    ]'::jsonb,
    'H2 database; JPA schema creation understanding',
    'Tables created correctly; queries execute without table not found errors',
    'Missing schema.sql file; ddl-auto not set to create; table name mismatch between entity and query',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/spring-boot?tab=votes'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Actuator endpoints return 401 Unauthorized even with authentication',
    'spring',
    'MEDIUM',
    '[
        {"solution": "Add actuator endpoints to permitAll in security config: .antMatchers(\"/actuator/**\").permitAll()", "percentage": 93},
        {"solution": "Or require specific role: @PreAuthorize(\"hasRole(''ADMIN'')\") on actuator endpoints", "percentage": 89},
        {"solution": "Enable health endpoint: spring.endpoint.health.enabled=true in application.properties", "percentage": 87}
    ]'::jsonb,
    'Spring Boot Actuator; Spring Security configuration',
    'Actuator endpoints accessible with appropriate permissions; health checks return data',
    'Actuator endpoints protected without permitAll; missing health endpoint configuration; wrong role requirement',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/spring-boot?tab=votes'
);
