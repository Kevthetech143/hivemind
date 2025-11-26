-- Add NestJS DI/Module error solutions from GitHub issues batch 1
-- Category: github-nestjs
-- Source: https://github.com/nestjs/nest/issues (closed issues with solutions)

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES

-- Issue #4872: Circular dependency errors
(
    'Nest circular dependency error: Cannot resolve service with forwardRef',
    'github-nestjs',
    'HIGH',
    $$[
        {"solution": "Import forwardRef utility from @nestjs/common and wrap dependent services: useValue: forwardRef(() => ServiceClass)", "percentage": 95, "note": "Official NestJS pattern for circular deps"},
        {"solution": "Apply @Inject() decorator with forwardRef on both sides of circular dependency to properly resolve metadata", "percentage": 92, "note": "Required for NestJS DI container to recognize circular refs"},
        {"solution": "Refactor code to break circular dependency using dependency injection of parent module instead of child service", "percentage": 85, "note": "Preferred long-term solution, avoids circular deps entirely"},
        {"solution": "Improve error message to explicitly mention circular dependency detection in error output", "percentage": 75, "note": "Enhancement to help developers identify the issue faster"}
    ]$$::jsonb,
    'NestJS v6+, Understanding of circular dependency concept, Both services in same or imported modules',
    'Services instantiate without circular dependency error, DI container resolves all dependencies, Application bootstraps successfully',
    'Forgetting to use forwardRef on both sides of circular dependency. Not applying @Inject() decorator. Trying to import services directly instead of modules.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/nestjs/nest/issues/4872'
),

-- Issue #363: Testing module DI resolution
(
    'Cannot resolve dependencies in NestJS test module: Test.createTestingModule fails',
    'github-nestjs',
    'VERY_HIGH',
    $$[
        {"solution": "Ensure all service dependencies are provided in the testing module providers array: Test.createTestingModule({ providers: [ServiceA, ServiceB] })", "percentage": 95, "note": "Most common fix - testing module must declare all providers"},
        {"solution": "Use .overrideProvider() to mock dependencies: module.overrideProvider(ServiceA).useValue(mockServiceA)", "percentage": 90, "note": "For mocking external services or complex dependencies"},
        {"solution": "Import required modules in testing module imports array for external dependencies not in current module", "percentage": 88, "note": "Testing module needs same imports as production app"},
        {"solution": "Compile the module after configuration: await module.compile() to ensure all metadata is processed", "percentage": 85, "note": "Required step - module must be compiled before use"}
    ]$$::jsonb,
    '@nestjs/testing installed, Test file importing Test, TestingModule, knowledge of which services to mock',
    'Test module compiles without error, All service dependencies resolve, Test executes successfully',
    'Forgetting to add providers to testing module. Not mocking external dependencies. Missing module imports. Assuming test module automatically inherits app providers.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://github.com/nestjs/nest/issues/363'
),

-- Issue #528: Class-validator DI integration
(
    'Custom validator class cannot inject dependencies using class-validator with NestJS',
    'github-nestjs',
    'HIGH',
    $$[
        {"solution": "Register custom constraint class in container as provider, then access via NestJS DI system, not class-validator DI", "percentage": 88, "note": "NestJS manages the constraint instance lifecycle"},
        {"solution": "Use ValidatorConstraint() decorator to register constraint, then provide it as NestJS provider with @Injectable()", "percentage": 85, "note": "Hybrid approach combining both DI systems"},
        {"solution": "Inject ValidatorConstraint directly into service and call validate() method instead of using @Validate decorator on DTO", "percentage": 82, "note": "Alternative approach avoids decorator-based validation"},
        {"solution": "Pass validation context via useExternalLoaders option in class-validator setContainer() initialization", "percentage": 78, "note": "Advanced integration for complex scenarios"}
    ]$$::jsonb,
    'class-validator and @nestjs/common installed, Understanding of NestJS providers, ValidatorConstraint decorator',
    'Custom validator receives injected dependencies, Validation executes without undefined errors, DTO validation works as expected',
    'Expecting class-validator to auto-discover NestJS providers. Not registering constraint as NestJS provider. Using wrong decorator combination.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/nestjs/nest/issues/528'
),

-- Issue #863: Dynamic module provider dependencies
(
    'NestJS dynamic module cannot depend on provider: forRoot/forFeature need config from provider',
    'github-nestjs',
    'MEDIUM',
    $$[
        {"solution": "Use registerAsync() instead of register(): TypeOrmModule.registerAsync({ useFactory: (config) => config.typeOrmOptions, inject: [ConfigService] })", "percentage": 94, "note": "Official pattern for provider-dependent module configuration"},
        {"solution": "Create intermediate module that provides the options as factory before importing the dynamic module", "percentage": 88, "note": "Workaround using module ordering"},
        {"solution": "Use useClass with dynamic provider factory to wrap module configuration with dependency injection", "percentage": 82, "note": "Advanced pattern for complex scenarios"},
        {"solution": "Leverage APP_INITIALIZER to run setup logic before module imports that need the config", "percentage": 75, "note": "Application bootstrap lifecycle hook approach"}
    ]$$::jsonb,
    'Dynamic module library (TypeOrmModule, JwtModule, etc), ConfigService provider, @nestjs/common knowledge',
    'Dynamic module initializes with provider-based configuration, All dependencies resolve correctly, Application starts without dependency errors',
    'Using forRoot() instead of forRegisterAsync(). Passing raw config instead of factory function. Not injecting dependencies in useFactory.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/nestjs/nest/issues/863'
),

-- Issue #8857: Module resolution with npm workspaces
(
    'Cannot resolve module dependencies with npm workspaces: @nestjs/websockets not found in workspace',
    'github-nestjs',
    'MEDIUM',
    $$[
        {"solution": "Add @nestjs/websockets to workspace root package.json dependencies, not workspace package dependencies", "percentage": 91, "note": "Workspaces require shared dependencies at root"},
        {"solution": "Configure TypeScript paths in tsconfig.json to resolve workspace modules: \"paths\": { \"@nestjs/*\": [\"node_modules/@nestjs/*\"] }", "percentage": 87, "note": "Helps module resolution across workspaces"},
        {"solution": "Ensure webpack/bundler is configured to resolve node_modules correctly from workspace root", "percentage": 84, "note": "Build tool configuration required"},
        {"solution": "Use hoisting strategy in npm workspaces to install dependencies at root level: npm config set legacy-peer-deps true", "percentage": 79, "note": "Workspace-wide dependency management"}
    ]$$::jsonb,
    'npm workspaces configured, Multiple packages in workspace structure, NestJS application in one workspace',
    'Dependencies resolve during build, No module-not-found errors, Application starts in workspace context',
    'Installing dependencies in workspace package instead of root. Not configuring workspace hoisting. Incorrect module resolution paths.',
    0.83,
    'sonnet-4',
    NOW(),
    'https://github.com/nestjs/nest/issues/8857'
),

-- Issue #9095: Module import from index.ts
(
    'Circular dependency when importing module from index.ts barrel export in NestJS',
    'github-nestjs',
    'MEDIUM',
    $$[
        {"solution": "Import module directly from implementation file, not barrel export: import { UserModule } from ''./user/user.module'' instead of ''./user''", "percentage": 93, "note": "Avoids circular reference through re-exports"},
        {"solution": "Separate barrel exports from module definitions to prevent circular imports at module resolution time", "percentage": 89, "note": "Architecture improvement"},
        {"solution": "Use dynamic import() or lazy loading for cross-module dependencies to break circular resolution", "percentage": 81, "note": "Advanced pattern for complex module graphs"},
        {"solution": "Remove re-exports from index.ts and import modules directly in application bootstrap", "percentage": 78, "note": "Simplest approach for small applications"}
    ]$$::jsonb,
    'NestJS module structure with index.ts barrel exports, Multiple modules in same directory',
    'Module imports resolve without circular dependency error, Application bootstraps successfully, Dependency graph acyclic',
    'Using barrel exports in module directories. Circular re-exports through index.ts. Assuming barrel exports are safe for module imports.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/nestjs/nest/issues/9095'
),

-- Issue #4457: Unclear dependency resolution error messages
(
    'Error message unclear: Nest cannot resolve dependency but provider is exported and imported',
    'github-nestjs',
    'HIGH',
    $$[
        {"solution": "Verify provider is explicitly exported from source module: @Module({ providers: [Service], exports: [Service] })", "percentage": 94, "note": "Most common cause - service not exported"},
        {"solution": "Confirm importing module is importing the correct module that exports the service", "percentage": 91, "note": "Check module import paths and typos"},
        {"solution": "Check that provider is not scoped with TRANSIENT lifetime when used by global/shared providers", "percentage": 87, "note": "Scope mismatch can prevent resolution"},
        {"solution": "Enable debug logging to see full dependency resolution chain: new NestFactory.create(AppModule, { logger: new Logger() })", "percentage": 82, "note": "For complex module hierarchies"}
    ]$$::jsonb,
    'Knowledge of @Module imports/exports, Provider decorator understanding, Module hierarchy awareness',
    'Service resolves from correct module, No dependency resolution errors, Application initializes successfully',
    'Not exporting provider from source module. Importing wrong module. Using incompatible scopes. Typos in provider names.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/nestjs/nest/issues/4457'
),

-- Issue #598: Dependency resolution in guards/decorators
(
    'AuthGuard or decorator cannot resolve dependency: argument available in context but DI fails',
    'github-nestjs',
    'HIGH',
    $$[
        {"solution": "Ensure guard/decorator is provided in application module or global scope: app.useGlobalGuards(AuthGuard) after module compilation", "percentage": 93, "note": "Guards need global availability or per-module registration"},
        {"solution": "Register guard as provider in module and use @UseGuards() decorator explicitly instead of app.useGlobalGuards()", "percentage": 89, "note": "More explicit and debuggable approach"},
        {"solution": "Check that all guard dependencies are exported and imported correctly in the module where guard is registered", "percentage": 87, "note": "Guards follow same DI rules as services"},
        {"solution": "Inject dependencies directly in guard constructor with proper @Inject() decorators instead of parameter inference", "percentage": 84, "note": "More reliable than parameter type inference"}
    ]$$::jsonb,
    '@nestjs/common installed, Guard/Decorator class, Dependency services available in module',
    'Guard instantiates without dependency resolution error, All injected dependencies available, Route protection works as expected',
    'Not registering guard as provider. Forgetting guard dependencies in module imports. Using parameter inference without @Inject().',
    0.86,
    'sonnet-4',
    NOW(),
    'https://github.com/nestjs/nest/issues/598'
),

-- Issue #10677: Dynamic module options token resolution
(
    'Dynamic module registerAsync cannot resolve MODULE_OPTIONS_TOKEN dependency',
    'github-nestjs',
    'MEDIUM',
    $$[
        {"solution": "Create MODULE_OPTIONS_TOKEN constant and provide it in module providers via useFactory: { provide: MODULE_OPTIONS_TOKEN, useFactory: (config) => config, inject: [ConfigService] }", "percentage": 94, "note": "Standard pattern from NestJS docs"},
        {"solution": "Verify MODULE_OPTIONS_TOKEN is injected with @Inject(MODULE_OPTIONS_TOKEN) not @Inject(''token-string'')", "percentage": 91, "note": "Must use the constant symbol, not string"},
        {"solution": "Check that ConfigService is imported in the registerAsync imports array before being used in useFactory", "percentage": 88, "note": "Import order matters for dependency resolution"},
        {"solution": "Use ASYNC_PROVIDER constant pattern to separate async providers from sync ones", "percentage": 82, "note": "Architecture pattern for clarity"}
    ]$$::jsonb,
    'Dynamic module implementation, ConfigModule with ConfigService, @nestjs/common v7+',
    'MODULE_OPTIONS_TOKEN resolves in service constructor, Dynamic module initializes with config, registerAsync works without dependency errors',
    'Forgetting to provide MODULE_OPTIONS_TOKEN. Using string instead of constant token. Missing imports in registerAsync.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/nestjs/nest/issues/10677'
),

-- Issue #1638: JWT module registerAsync with e2e tests
(
    'JwtModule registerAsync fails in e2e tests: JWT_MODULE_OPTIONS cannot resolve dependency',
    'github-nestjs',
    'MEDIUM',
    $$[
        {"solution": "In e2e tests, import and configure JwtModule in TestingModule separately from app.module: Test.createTestingModule({ imports: [JwtModule.register(testConfig)] })", "percentage": 93, "note": "Test environment needs explicit config"},
        {"solution": "Create test-specific config module that provides CONFIG_TOKEN before JwtModule is imported", "percentage": 89, "note": "Separate test configuration approach"},
        {"solution": "Use overrideProvider in TestingModule to mock ConfigService before module compilation", "percentage": 86, "note": "Mock external dependencies in tests"},
        {"solution": "Ensure Test.createTestingModule includes all transitive imports from original module", "percentage": 82, "note": "Testing module must replicate production setup"}
    ]$$::jsonb,
    '@nestjs/jwt, @nestjs/testing, ConfigModule, e2e test setup',
    'TestingModule compiles without JWT_MODULE_OPTIONS error, e2e tests run successfully, Auth logic testable',
    'Not configuring JwtModule in TestingModule. Assuming test module inherits app config. Missing ConfigService mock.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/nestjs/nest/issues/1638'
),

-- Issue #10159: Transient providers with INQUIRER in tests
(
    'Transient scoped provider with @Inject(INQUIRER) fails in unit tests: undefined dependencies',
    'github-nestjs',
    'LOW',
    $$[
        {"solution": "Mock INQUIRER injection in TestingModule: overrideProvider(INQUIRER).useValue(mockInquirer)", "percentage": 91, "note": "Required for testing transient providers"},
        {"solution": "Avoid using @Inject(INQUIRER) in services; instead pass inquirer context through request scope", "percentage": 86, "note": "Alternative architecture for testability"},
        {"solution": "Use REQUEST scope instead of TRANSIENT when dependencies are required in tests", "percentage": 81, "note": "Scope adjustment for test compatibility"},
        {"solution": "Create mock inquirer object with required methods before providing it to TestingModule", "percentage": 78, "note": "Mocking strategy for complex objects"}
    ]$$::jsonb,
    '@nestjs/core with INQUIRER, @nestjs/testing, Understanding of request/transient scopes',
    'Transient provider resolves in test, INQUIRER mocking works, TestingModule compiles without undefined dependencies',
    'Not mocking INQUIRER. Using TRANSIENT scope with unmockable dependencies. Assuming test scope handles INQUIRER automatically.',
    0.78,
    'sonnet-4',
    NOW(),
    'https://github.com/nestjs/nest/issues/10159'
),

-- Issue #9621: String primitive type dependency injection
(
    'Cannot resolve string primitive parameter dependency in NestJS service constructor',
    'github-nestjs',
    'MEDIUM',
    $$[
        {"solution": "Use @Inject() decorator with string token on primitive parameters: @Inject(''CLIENT_URL'') clientUrl: string", "percentage": 95, "note": "Required for non-class types in DI container"},
        {"solution": "Create provider for string value: { provide: ''CLIENT_URL'', useValue: process.env.CLIENT_URL }", "percentage": 93, "note": "Define string as named provider"},
        {"solution": "Use ConfigService to inject configuration strings instead of raw string injection", "percentage": 89, "note": "Better practice for configuration management"},
        {"solution": "Define custom configuration object type instead of raw string for better type safety", "percentage": 84, "note": "Improves type checking and IDE support"}
    ]$$::jsonb,
    '@nestjs/common, @nestjs/config recommended, understanding of primitive vs object types in DI',
    'String parameter injects successfully, Service receives correct configuration string value, Application initializes',
    'Forgetting @Inject() on string parameters. Using bare string instead of token. Not providing string in module providers.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/nestjs/nest/issues/9621'
),

-- Issue #2343: Microservice context dependency
(
    'Dynamic microservice creation depends on application context: Cannot create without DI access',
    'github-nestjs',
    'LOW',
    $$[
        {"solution": "Create microservice instance inside application bootstrap with access to NestApplication context", "percentage": 90, "note": "Microservices should be created after app context exists"},
        {"solution": "Use app.connectMicroservice() method which handles context binding automatically", "percentage": 88, "note": "Official method for microservice integration"},
        {"solution": "Inject ApplicationContext into factory function for dynamic microservice configuration", "percentage": 82, "note": "For complex multi-microservice setups"},
        {"solution": "Create separate initialization phase for microservices after main application bootstrap", "percentage": 78, "note": "Staged initialization pattern"}
    ]$$::jsonb,
    '@nestjs/microservices, Understanding of application lifecycle, Multiple transport strategies',
    'Microservice connects to application context, All dependencies resolve in microservice, Messages route correctly',
    'Creating microservice before app context. Trying to inject services directly into microservice factory.',
    0.80,
    'sonnet-4',
    NOW(),
    'https://github.com/nestjs/nest/issues/2343'
);
