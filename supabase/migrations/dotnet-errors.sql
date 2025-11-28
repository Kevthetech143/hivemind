INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'NullReferenceException: Object reference not set to an instance of an object',
    'dotnet',
    'HIGH',
    '[
        {"solution": "Add null checks using the null-conditional operator (?.) before accessing members: var value = obj?.Property; or use null-coalescing operator (??): var value = obj?.Property ?? defaultValue;", "percentage": 95},
        {"solution": "Use nullable reference types feature in C# 8.0+. Enable in project file with <Nullable>enable</Nullable> to catch null issues at compile time instead of runtime", "percentage": 90},
        {"solution": "Initialize objects with ''new'' keyword before using them: MyClass obj = new MyClass();", "percentage": 85},
        {"solution": "Set breakpoint in Visual Studio locals window to identify which variable is null and trace back the logic", "percentage": 80}
    ]'::jsonb,
    'Understanding reference types, awareness of null values, Visual Studio debugger knowledge',
    'No more NullReferenceException thrown at this line. Object successfully accesses properties or methods without null errors.',
    'Forgetting to initialize objects, not checking method return values for null, accessing nested properties without checking intermediate nulls (user.Address.City without checking Address first)',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/4660142/what-is-a-nullreferenceexception-and-how-do-i-fix-it'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'InvalidOperationException: Collection was modified; enumeration operation may not execute',
    'dotnet',
    'HIGH',
    '[
        {"solution": "Create a copy of the collection before iterating: foreach(var item in list.ToList()) { list.Remove(item); }", "percentage": 95},
        {"solution": "Use a for loop with explicit index instead of foreach to avoid enumeration: for(int i = list.Count - 1; i >= 0; i--) { if(condition) list.RemoveAt(i); }", "percentage": 90},
        {"solution": "Collect items to remove in a separate list first, then remove them after iteration: var toRemove = list.Where(x => condition).ToList(); foreach(var item in toRemove) list.Remove(item);", "percentage": 85}
    ]'::jsonb,
    'Understanding LINQ iteration behavior, knowledge of collection modification patterns',
    'Loop completes successfully without InvalidOperationException. All intended items added or removed from collection.',
    'Modifying collection size during foreach iteration, adding/removing items while iterating over original collection, not considering iterator state',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/16636374/why-is-this-code-throwing-an-invalidoperationexception'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'System.ArgumentException: Parameter is not valid',
    'dotnet',
    'HIGH',
    '[
        {"solution": "Validate arguments before use. Example: if(string.IsNullOrEmpty(param)) throw new ArgumentException(nameof(param)); Check parameter values match expected ranges and formats.", "percentage": 90},
        {"solution": "Use ArgumentNullException for null checks and ArgumentOutOfRangeException for bounds: if(index < 0 || index >= array.Length) throw new ArgumentOutOfRangeException(nameof(index));", "percentage": 88}
    ]'::jsonb,
    'Parameter validation patterns, understanding argument exception types',
    'Method accepts only valid parameters and processes successfully. Invalid parameters rejected with clear error messages.',
    'Not validating parameters at method entry, using generic Exception instead of specific exception types, providing unhelpful error messages',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/774104/what-exceptions-should-be-thrown-for-invalid-or-unexpected-parameters-in-net'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'IndexOutOfRangeException: Index was outside the bounds of the array',
    'dotnet',
    'HIGH',
    '[
        {"solution": "Check array length before accessing: if(index >= 0 && index < array.Length) { var item = array[index]; } or use TryGetValue/ElementAtOrDefault for collections", "percentage": 95},
        {"solution": "Use foreach loop instead of manual indexing to avoid off-by-one errors: foreach(var item in array) { Process(item); }", "percentage": 92},
        {"solution": "Fix loop condition to use < instead of <=: for(int i = 0; i < array.Length; i++) instead of for(int i = 0; i <= array.Length; i++)", "percentage": 90}
    ]'::jsonb,
    'Array/collection indexing knowledge, loop control structures',
    'Loop iterates through all valid array indices without throwing IndexOutOfRangeException. Correct number of elements processed.',
    'Off-by-one errors in loops (using <= instead of <), forgetting arrays are zero-indexed, not checking bounds before access, manual index tracking errors',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/20940979/what-is-an-indexoutofrangeexception-argumentoutofrangeexception-and-how-do-i-f'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'System.FormatException: Input string was not in a correct format',
    'dotnet',
    'HIGH',
    '[
        {"solution": "Use TryParse instead of Parse to avoid exceptions: if(int.TryParse(input, out int result)) { /* use result */ } else { /* handle error */ }", "percentage": 95},
        {"solution": "Validate input format before parsing. Check for null/empty: if(!string.IsNullOrEmpty(input) && int.TryParse(input, out int num))", "percentage": 92},
        {"solution": "Use ParseExact for DateTime/Guid with specific format: DateTime.ParseExact(dateString, \"yyyy-MM-dd\", CultureInfo.InvariantCulture)", "percentage": 88},
        {"solution": "Consider culture-specific formats (e.g., decimal separator). Use CultureInfo.InvariantCulture for consistent behavior", "percentage": 85}
    ]'::jsonb,
    'TryParse pattern knowledge, understanding data type constraints, culture-aware formatting',
    'String parsed successfully without exceptions. Numeric/datetime values converted correctly. Invalid input handled gracefully.',
    'Using Parse instead of TryParse, not checking for null/empty strings, ignoring cultural format differences, early validation before user input complete',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/12269254/how-to-resolve-input-string-was-not-in-a-correct-format-error'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'System.IO.FileNotFoundException: The file does not exist',
    'dotnet',
    'HIGH',
    '[
        {"solution": "Use File.Exists() before accessing: if(File.Exists(path)) { /* read file */ } else { /* handle missing file */ }", "percentage": 95},
        {"solution": "Check file path using Directory.GetFiles() to debug path issues: var files = Directory.GetFiles(directory); Debug actual file names with odd characters", "percentage": 88},
        {"solution": "Use absolute paths instead of relative paths to avoid working directory issues: var fullPath = Path.GetFullPath(relativePath);", "percentage": 85},
        {"solution": "Wrap file operations in try-catch and use FileName property for better diagnostics: catch(FileNotFoundException ex) { var missingFile = ex.FileName; }", "percentage": 80}
    ]'::jsonb,
    'File system operations, path handling, exception properties knowledge',
    'File opened and read successfully. FileNotFoundException no longer thrown. File exists check passes.',
    'Using relative paths that depend on working directory, typos in file names (case-sensitive on Linux), not verifying path exists, file deleted between check and use',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/1350076/file-not-found-exception-but-its-there'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'System.InvalidCastException: Cannot cast object of type to type',
    'dotnet',
    'HIGH',
    '[
        {"solution": "Use ''as'' operator for safe casting: var typed = obj as MyType; if(typed != null) { /* use typed */ }", "percentage": 95},
        {"solution": "Check type with ''is'' operator before casting: if(obj is MyType myType) { /* use myType */ }", "percentage": 94},
        {"solution": "Use GetType() to verify actual runtime type before casting: if(obj.GetType() == typeof(MyType))", "percentage": 88}
    ]'::jsonb,
    'Type system understanding, polymorphism knowledge, boxing/unboxing behavior',
    'Object cast successfully without InvalidCastException. Type-checked before casting. Proper type conversions work.',
    'Not checking type before casting, attempting to cast unrelated types, unboxing null values or incompatible boxed types, assuming object inherits from expected type',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/14327071/how-do-i-solve-an-invalidcastexception'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'System.TimeoutException: The operation timed out',
    'dotnet',
    'HIGH',
    '[
        {"solution": "Increase timeout for SQL connections: var connectionString = \"... ;Connection Timeout=60;\"; or SqlConnection.ConnectionTimeout property", "percentage": 90},
        {"solution": "For HttpClient timeouts, catch TaskCanceledException with TimeoutException inner: catch(TaskCanceledException ex) when (ex.InnerException is TimeoutException) { }", "percentage": 88},
        {"solution": "Implement retry logic with exponential backoff: attempt connection multiple times with increasing delays before failing", "percentage": 85},
        {"solution": "Check SQL exception number -2: if(sqlEx.Number == -2) { /* timeout */ } for SQL Server specific timeouts", "percentage": 80}
    ]'::jsonb,
    'Connection handling, async/await patterns, retry pattern implementation',
    'Operation completes within timeout window. No timeout exceptions thrown. Connection/request succeeds or fails with clear diagnostics.',
    'Using default timeouts that are too short for slow operations, not retrying on timeout, connection pool exhaustion, not handling timeout in async chain',
    0.88,
    'haiku',
    NOW(),
    'https://blog.elmah.io/debugging-system-outofmemoryexception-using-net-tools/'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'System.StackOverflowException: Stack overflow from too many recursive calls',
    'dotnet',
    'HIGH',
    '[
        {"solution": "Add base case to recursion: method must have stopping condition that breaks infinite loop", "percentage": 95},
        {"solution": "Implement maximum recursion depth counter: static int depth = 0; if(++depth > MAX) throw new InvalidOperationException();", "percentage": 92},
        {"solution": "Replace recursion with iteration using loops or stacks instead of method calls", "percentage": 90},
        {"solution": "Use visited set for graph/tree traversal to avoid revisiting nodes causing infinite loops", "percentage": 88}
    ]'::jsonb,
    'Recursion patterns, base case design, iterative alternatives knowledge',
    'Recursive method terminates successfully. Stack doesn''t overflow. Correct results computed without stack exhaustion.',
    'Missing base case in recursion, not checking visited nodes in graph traversal, forgetting C# doesn''t optimize tail recursion, infinite mutual recursion between methods',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/12574548/solve-infinite-recursion-in-c-sharp'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'System.OutOfMemoryException: Out of memory despite free system memory',
    'dotnet',
    'HIGH',
    '[
        {"solution": "Replace string concatenation with StringBuilder: var sb = new StringBuilder(); sb.Append(str1); sb.Append(str2); avoids many allocations", "percentage": 90},
        {"solution": "Dispose unmanaged resources properly: using(var connection = new SqlConnection()) { /* use */ } ensures cleanup", "percentage": 92},
        {"solution": "Reduce resident memory by processing data in batches/segments instead of loading everything at once", "percentage": 85},
        {"solution": "For large objects (>85KB), enable LOH compaction in .NET 4.5+: <gcAllowVeryLargeObjects>true</gcAllowVeryLargeObjects> in config", "percentage": 80}
    ]'::jsonb,
    'Memory management patterns, StringBuilder knowledge, IDisposable pattern, resource lifecycle',
    'Application runs without OutOfMemoryException. Memory usage remains reasonable. Large operations complete successfully.',
    'String concatenation in loops, not disposing database connections/file handles, holding references to large objects unnecessarily, memory leaks from singleton with transient dependencies',
    0.87,
    'haiku',
    NOW(),
    'https://learn.microsoft.com/en-us/troubleshoot/developer/webapps/aspnet/performance/troubleshoot-outofmemoryexception'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'System.AggregateException: One or more errors occurred with async/await',
    'dotnet',
    'HIGH',
    '[
        {"solution": "With Task.WhenAll(), access all exceptions via Task.Exception.InnerExceptions: var masterTask = Task.WhenAll(tasks); try { await masterTask; } catch { foreach(var ex in masterTask.Exception.InnerExceptions) { /* handle */ } }", "percentage": 92},
        {"solution": "Use await to get only first exception (usually what you want): try { await task; } catch(Exception ex) { }", "percentage": 90},
        {"solution": "Flatten aggregate exceptions: var flatEx = aggEx.Flatten(); to handle nested aggregates", "percentage": 85}
    ]'::jsonb,
    'Task Parallel Library knowledge, exception handling in parallel code, async/await patterns',
    'Multiple async operations handled correctly. All exceptions accessible and processed. Error handling works for parallel scenarios.',
    'Only checking first exception from AggregateException, missing inner exceptions, not flattening nested AggregateExceptions, assuming await unwraps all exceptions',
    0.89,
    'haiku',
    NOW(),
    'https://learn.microsoft.com/en-us/dotnet/standard/parallel-programming/exception-handling-task-parallel-library'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'System.Net.Http.HttpRequestException: Error while copying content to a stream',
    'dotnet',
    'HIGH',
    '[
        {"solution": "Catch HttpRequestException for network errors: try { var response = await client.GetAsync(url); } catch(HttpRequestException ex) { /* handle network error */ }", "percentage": 92},
        {"solution": "Check InnerException for root cause details: if(ex.InnerException != null) { Console.WriteLine(ex.InnerException.Message); }", "percentage": 88},
        {"solution": "In .NET 5+, check StatusCode property: if(ex.StatusCode == HttpStatusCode.NotFound) { } for HTTP-specific errors", "percentage": 85},
        {"solution": "Catch TaskCanceledException separately for timeout: catch(TaskCanceledException ex) when (ex.InnerException is TimeoutException) { }", "percentage": 82}
    ]'::jsonb,
    'HttpClient usage, exception handling, network error understanding',
    'HTTP requests handled gracefully. Network errors caught and processed. Response status codes checked appropriately.',
    'Catching generic Exception instead of HttpRequestException, ignoring InnerException details, not distinguishing timeout vs network errors, not using using statement for HttpClient',
    0.89,
    'haiku',
    NOW(),
    'https://learn.microsoft.com/en-us/dotnet/api/system.net.http.httprequestexception'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'ASP.NET Core: InvalidOperationException Unable to resolve service for type in dependency injection',
    'dotnet',
    'HIGH',
    '[
        {"solution": "Register service in Program.cs: builder.Services.AddScoped<IUserService, UserService>(); or appropriate lifetime (Singleton/Transient)", "percentage": 95},
        {"solution": "Inject interface, not implementation, in constructor: public Controller(IUserService service) not public Controller(UserService service)", "percentage": 93},
        {"solution": "For DbContext: builder.Services.AddDbContext<AppDbContext>(options => options.UseSqlServer(connectionString));", "percentage": 90},
        {"solution": "Check service lifetime matches usage: use Scoped for web requests, Singleton for stateless services, Transient for new instance per use", "percentage": 88}
    ]'::jsonb,
    'ASP.NET Core dependency injection, service registration patterns, service lifetimes',
    'Service resolved successfully from DI container. Constructor injection works. DbContext available when needed.',
    'Forgetting to register service, requesting concrete class instead of interface, lifetime mismatch (singleton containing transient), DbContext not registered',
    0.93,
    'haiku',
    NOW(),
    'https://code-maze.com/dotnet-how-to-solve-unable-to-resolve-service-for-a-type/'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Entity Framework Core: Unable to resolve service for type DbContextOptions',
    'dotnet',
    'HIGH',
    '[
        {"solution": "Register DbContext in Program.cs with connection string: builder.Services.AddDbContext<MyDbContext>(opts => opts.UseSqlServer(connString));", "percentage": 93},
        {"solution": "Implement IDesignTimeDbContextFactory for design-time EF commands: public class MyContextFactory : IDesignTimeDbContextFactory<MyDbContext> { public MyDbContext CreateDbContext(string[] args) { /* configure here */ } }", "percentage": 90},
        {"solution": "Ensure DbContext constructor accepts DbContextOptions: public MyDbContext(DbContextOptions<MyDbContext> options) : base(options) { }", "percentage": 88},
        {"solution": "For migrations, specify both --project and --startup-project if using multiple projects", "percentage": 85}
    ]'::jsonb,
    'Entity Framework Core configuration, DbContext lifetime, design-time context creation',
    'DbContext created successfully. Migrations execute without errors. Database operations work with proper configuration.',
    'Missing DbContext registration in DI, incorrect constructor signature in DbContext, EF tools unable to find correct startup project, missing connection string',
    0.91,
    'haiku',
    NOW(),
    'https://learn.microsoft.com/en-us/ef/core/dbcontext-configuration/'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'ASP.NET Core CORS policy error: The CORS protocol does not allow specifying a wildcard and credentials',
    'dotnet',
    'HIGH',
    '[
        {"solution": "Remove wildcard when using credentials. Instead of AllowAnyOrigin(), specify explicit origins: .AllowAnyOrigin() or .WithOrigins(\"https://example.com\")", "percentage": 95},
        {"solution": "Configure CORS policy correctly in Program.cs: builder.Services.AddCors(opts => opts.AddPolicy(\"AllowAll\", policy => policy.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader()));", "percentage": 92},
        {"solution": "Place UseCors AFTER UseRouting but BEFORE UseAuthorization middleware: app.UseRouting(); app.UseCors(); app.UseAuthorization();", "percentage": 93},
        {"solution": "For IIS, ensure OPTIONS verb not blocked and set anonymousAuthentication=true in web.config", "percentage": 85}
    ]'::jsonb,
    'CORS configuration, ASP.NET Core middleware ordering, HTTP request methods',
    'CORS preflight requests succeed. Cross-origin requests work correctly. No CORS errors in browser console.',
    'Using wildcard with credentials, wrong middleware order, IIS blocking OPTIONS requests, not understanding CORS preflight flow, protocol/domain mismatch (http vs https)',
    0.90,
    'haiku',
    NOW(),
    'https://learn.microsoft.com/en-us/aspnet/core/security/cors'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'System.Text.Json JsonException: The property name must be JSON serializable',
    'dotnet',
    'HIGH',
    '[
        {"solution": "Enable case-insensitive deserialization: var opts = new JsonSerializerOptions { PropertyNameCaseInsensitive = true }; JsonSerializer.Deserialize<T>(json, opts);", "percentage": 93},
        {"solution": "Ensure constructor parameter names match JSON property names exactly or use [JsonPropertyName(\"jsonPropName\")] attribute", "percentage": 91},
        {"solution": "Handle unmapped properties: var opts = new JsonSerializerOptions { UnmappedMemberHandling = JsonUnmappedMemberHandling.Skip };", "percentage": 88},
        {"solution": "Mark required properties with [JsonRequired] attribute to enforce presence in JSON payload", "percentage": 85}
    ]'::jsonb,
    'System.Text.Json usage, JSON property naming conventions, serialization attributes',
    'JSON deserializes successfully into objects. Property names match correctly. Required fields validated.',
    'Case sensitivity mismatches (JSON has different casing than C# property), constructor parameters named differently than JSON properties, unmapped properties causing errors',
    0.89,
    'haiku',
    NOW(),
    'https://learn.microsoft.com/en-us/dotnet/standard/serialization/system-text-json/required-properties'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'ASP.NET Core validation error: The value is invalid for model property',
    'dotnet',
    'HIGH',
    '[
        {"solution": "With nullable reference types enabled, non-nullable properties are implicitly [Required]. Use nullable type (string?) to allow null: public string? OptionalProp { get; set; }", "percentage": 92},
        {"solution": "Add [Required] attribute explicitly: [Required] public string RequiredField { get; set; }", "percentage": 90},
        {"solution": "Check ModelState.IsValid in controller: if(!ModelState.IsValid) { return BadRequest(ModelState); }", "percentage": 88},
        {"solution": "Use [BindRequired] to require field specifically from request, not default values", "percentage": 82}
    ]'::jsonb,
    'ASP.NET Core model binding, nullable reference types, validation attributes',
    'Model validation passes for valid inputs. Invalid/missing required fields rejected with 400 response. ModelState reflects errors.',
    'Forgetting <Nullable>enable</Nullable> makes all reference types implicitly nullable, not understanding implicit [Required] behavior, confusing nullable properties with optional',
    0.90,
    'haiku',
    NOW(),
    'https://learn.microsoft.com/en-us/aspnet/core/mvc/models/validation'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'C# async deadlock: Application hangs when blocking on async code',
    'dotnet',
    'HIGH',
    '[
        {"solution": "Use async all the way: if calling async code, make your method async too. Never block with .Result or .Wait(): var result = await asyncMethod(); not var result = asyncMethod().Result;", "percentage": 95},
        {"solution": "Use ConfigureAwait(false) in library code on every await: await task.ConfigureAwait(false); to avoid deadlock potential", "percentage": 90},
        {"solution": "Never mix sync and async: don''t call blocking code from async methods or vice versa", "percentage": 93}
    ]'::jsonb,
    'Async/await patterns, synchronization context understanding, threading concepts',
    'Async code completes without deadlock. Application remains responsive. Task results available without blocking.',
    'Blocking on async code with .Result or .Wait(), not using ConfigureAwait(false) in libraries, mixing synchronous and asynchronous calls, forgetting to propagate async up the call stack',
    0.92,
    'haiku',
    NOW(),
    'https://blog.stephencleary.com/2012/07/dont-block-on-async-code.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'System.NotImplementedException: Method or property is not implemented',
    'dotnet',
    'HIGH',
    '[
        {"solution": "Declare method as abstract instead of throwing NotImplementedException: public abstract void MyMethod(); forces derived classes to implement", "percentage": 95},
        {"solution": "Actually implement the method body instead of just throwing exception", "percentage": 94},
        {"solution": "Use interfaces for abstract contracts when no implementation needed", "percentage": 88}
    ]'::jsonb,
    'Object-oriented design patterns, abstract class vs interface understanding',
    'All abstract methods implemented in derived classes. No NotImplementedException thrown at runtime. Methods provide working implementations.',
    'Using NotImplementedException as permanent solution instead of implementing, forgetting to mark methods as abstract, wrong inheritance hierarchy causing missing implementations',
    0.93,
    'haiku',
    NOW(),
    'https://learn.microsoft.com/en-us/dotnet/fundamentals/runtime-libraries/system-notimplementedexception'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Entity Framework Core: The provider for database '' has not been registered',
    'dotnet',
    'HIGH',
    '[
        {"solution": "Register database provider in DbContext.OnConfiguring() or Program.cs: optionsBuilder.UseSqlServer(connectionString) or services.AddDbContext(opts => opts.UseSqlServer(...))", "percentage": 94},
        {"solution": "Install correct provider NuGet package: Microsoft.EntityFrameworkCore.SqlServer for SQL Server, Microsoft.EntityFrameworkCore.Sqlite for SQLite, etc.", "percentage": 92},
        {"solution": "Ensure connection string is properly provided to UseSqlServer or other provider method", "percentage": 89}
    ]'::jsonb,
    'Entity Framework Core provider registration, NuGet package management, DbContext configuration',
    'DbContext initializes with correct provider. Database operations execute successfully. Correct database type used.',
    'Not installing provider NuGet package, registering wrong provider, not configuring OnConfiguring, missing connection string in appsettings.json',
    0.92,
    'haiku',
    NOW(),
    'https://learn.microsoft.com/en-us/ef/core/cli/dbcontext-creation'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'ASP.NET Core: The value ''null'' is not valid for parameter',
    'dotnet',
    'HIGH',
    '[
        {"solution": "Provide non-null value for parameter or make parameter nullable: public void Method(string? param) { }", "percentage": 92},
        {"solution": "Add null check at method entry: if(string.IsNullOrEmpty(param)) return;", "percentage": 88},
        {"solution": "Use [Required] attribute on controller parameters to validate: public IActionResult Action([Required] string param)", "percentage": 85}
    ]'::jsonb,
    'ASP.NET Core parameter binding, nullable reference types, validation',
    'Parameters accept valid non-null values. Null values handled appropriately. Method executes without null-related errors.',
    'Passing null to non-nullable parameter, not checking for null in method, not marking parameter as nullable when null is acceptable',
    0.89,
    'haiku',
    NOW(),
    'https://learn.microsoft.com/en-us/aspnet/core/fundamentals/error-handling'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'C# LINQ FirstOrDefault on empty sequence returns null',
    'dotnet',
    'MEDIUM',
    '[
        {"solution": "Check result for null before using: var first = list.FirstOrDefault(); if(first != null) { /* use first */ }", "percentage": 92},
        {"solution": "Use null coalescing operator for default value: var first = list.FirstOrDefault() ?? defaultValue;", "percentage": 90},
        {"solution": "Use First only if you know sequence has elements, otherwise catch InvalidOperationException", "percentage": 85}
    ]'::jsonb,
    'LINQ method understanding, null handling patterns',
    'Empty sequence handled correctly without NullReferenceException. Default values applied when sequence is empty.',
    'Forgetting FirstOrDefault returns null on empty sequence, using First without checking sequence has elements, not providing null coalescing fallback',
    0.90,
    'haiku',
    NOW(),
    'https://learn.microsoft.com/en-us/dotnet/api/system.linq.enumerable.firstordefault'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'ASP.NET Core JSON serialization circular reference error',
    'dotnet',
    'MEDIUM',
    '[
        {"solution": "Configure JsonSerializerOptions to handle cycles: var opts = new JsonSerializerOptions { ReferenceHandler = ReferenceHandler.Preserve }; in .NET 6+", "percentage": 90},
        {"solution": "Use [JsonIgnore] attribute on circular navigation properties: [JsonIgnore] public virtual Parent Parent { get; set; }", "percentage": 88},
        {"solution": "Configure Newtonsoft.Json: services.AddControllers().AddNewtonsoftJson(opts => opts.SerializerSettings.ReferenceLoopHandling = ReferenceLoopHandling.Ignore);", "percentage": 85}
    ]'::jsonb,
    'JSON serialization, Entity Framework relationships, JSON configuration',
    'Objects with circular references serialize successfully. JSON output is valid. No recursion errors during serialization.',
    'Not handling circular references in navigation properties, using default serializer options with circular data, ignoring one direction of bidirectional relationships',
    0.87,
    'haiku',
    NOW(),
    'https://learn.microsoft.com/en-us/dotnet/standard/serialization/system-text-json/'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'C# operator overloading: Operator ''operator'' cannot be used in lambda expressions',
    'dotnet',
    'MEDIUM',
    '[
        {"solution": "Convert to method call or use expression trees with visitor pattern if needed: var result = items.Where(x => x.CompareTo(value) > 0);", "percentage": 88},
        {"solution": "Use LINQ to Objects for in-memory operations instead of trying to translate custom operators to SQL", "percentage": 85}
    ]'::jsonb,
    'Operator overloading, LINQ expression tree translation, IQueryable vs IEnumerable',
    'Lambda expressions compile successfully. Where clauses execute correctly. Comparison logic works as expected.',
    'Trying to use custom overloaded operators in LINQ queries targeting databases, forgetting not all custom operators translate to SQL',
    0.80,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/c%23'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'C# readonly field not initialized: ''Field must be fully assigned before control leaves the constructor''',
    'dotnet',
    'MEDIUM',
    '[
        {"solution": "Initialize readonly field in constructor or at declaration: private readonly string field = \"init\"; or in ctor: this.field = \"init\";", "percentage": 94},
        {"solution": "For optional readonly fields, use nullable: private readonly string? field; or initialize before use in constructor", "percentage": 90}
    ]'::jsonb,
    'Field initialization rules, readonly semantics, constructor patterns',
    'Readonly fields initialize successfully. Compiler allows object creation. Fields are immutable after construction.',
    'Forgetting to initialize readonly fields, trying to initialize readonly fields outside constructor, conditionally initializing readonly fields without all paths covered',
    0.92,
    'haiku',
    NOW(),
    'https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/readonly'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'C# property backing field: Cannot assign to readonly property',
    'dotnet',
    'MEDIUM',
    '[
        {"solution": "Add setter to property: public string Prop { get; set; } or public string Prop { get; private set; } for internal-only writes", "percentage": 95},
        {"solution": "Use auto-property with private setter if only constructor should set value: public string Prop { get; private set; }", "percentage": 93}
    ]'::jsonb,
    'Property accessors, encapsulation patterns, auto-properties',
    'Properties accept assignments correctly. Write access works as intended. Encapsulation rules enforced.',
    'Read-only properties defined with only getter, forgetting to add setter when property needs modification, not using private setter for controlled assignment',
    0.94,
    'haiku',
    NOW(),
    'https://learn.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/properties'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'C# ref/out parameter: Compiler error with ref/out in anonymous functions or iterators',
    'dotnet',
    'MEDIUM',
    '[
        {"solution": "Avoid using ref/out parameters in lambda or iterator methods: capture value in local variable instead: var local = value; Action a = () => UseLocal(local);", "percentage": 90},
        {"solution": "Use regular parameters and return values instead of ref/out in async/iterator contexts", "percentage": 88}
    ]'::jsonb,
    'Reference parameters, closure semantics, lambda/iterator constraints',
    'Code compiles successfully. Lambda expressions work correctly. Parameters pass by value without ref/out complications.',
    'Using ref/out in lambda expressions or iterators, forgetting ref/out restrictions with async/await, not understanding closure scope with ref parameters',
    0.85,
    'haiku',
    NOW(),
    'https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/ref'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'C# unsafe code error: Cannot use pointer operator outside unsafe context',
    'dotnet',
    'MEDIUM',
    '[
        {"solution": "Wrap pointer operations in unsafe block: unsafe { var ptr = &variable; }", "percentage": 94},
        {"solution": "Mark method as unsafe: unsafe public void MethodName() { /* use pointers */ }", "percentage": 92},
        {"solution": "For unsafe project setting, enable in .csproj: <AllowUnsafeBlocks>true</AllowUnsafeBlocks>", "percentage": 88}
    ]'::jsonb,
    'Unsafe code blocks, pointer operations, interop with unmanaged code',
    'Unsafe code compiles successfully. Pointers used correctly. Unmanaged interop works without errors.',
    'Using pointers without unsafe block, forgetting to enable AllowUnsafeBlocks in project, not marking methods as unsafe that use pointers',
    0.90,
    'haiku',
    NOW(),
    'https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/unsafe'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'ASP.NET Core routing error: No route matched the request path',
    'dotnet',
    'MEDIUM',
    '[
        {"solution": "Check route patterns match request URL: [HttpGet(\"api/items/{id}\")] public IActionResult GetItem(int id) { }", "percentage": 92},
        {"solution": "Verify controller has [ApiController] attribute and methods have [HttpGet/Post/etc] attributes", "percentage": 90},
        {"solution": "For attribute routing, ensure endpoints configured in Program.cs: app.MapControllers();", "percentage": 88},
        {"solution": "Check parameter names in route match method parameters: {id} in route must match int id parameter", "percentage": 85}
    ]'::jsonb,
    'ASP.NET Core routing, attribute routing, controller/action conventions',
    'Requests route correctly to intended endpoints. 404 errors gone. Proper HTTP method and URL matching work.',
    'Route pattern mismatch with actual URL, missing [ApiController] or [HttpGet/Post] attributes, parameter names different between route and method signature, wrong HTTP method',
    0.89,
    'haiku',
    NOW(),
    'https://learn.microsoft.com/en-us/aspnet/core/fundamentals/routing'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'C# struct boxing/unboxing performance: Unexpected boxing causing performance issues',
    'dotnet',
    'MEDIUM',
    '[
        {"solution": "Avoid boxing structs: don''t use struct as object or in collections of object: use List<T> instead of List<object>", "percentage": 93},
        {"solution": "Use constraints to prevent boxing: public class Container<T> where T : struct { }", "percentage": 88},
        {"solution": "Prefer classes for complex objects, reserve structs for small value types (int, double, etc)", "percentage": 85}
    ]'::jsonb,
    'Value types vs reference types, boxing/unboxing semantics, generic constraints',
    'No unexpected boxing occurs. Performance is optimal. Generic collections use appropriate type constraints.',
    'Storing structs in object-typed variables or collections, not using generic collections causing struct boxing, using structs for large data causing performance problems',
    0.86,
    'haiku',
    NOW(),
    'https://learn.microsoft.com/en-us/dotnet/csharp/fundamentals/types/boxing-and-unboxing'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'C# generic constraint error: Cannot create instance of type parameter ''T''',
    'dotnet',
    'MEDIUM',
    '[
        {"solution": "Add new() constraint if you need default constructor: public class Container<T> where T : new() { T instance = new T(); }", "percentage": 95},
        {"solution": "Use factory pattern if default constructor doesn''t work: provide Func<T> to constructor", "percentage": 90}
    ]'::jsonb,
    'Generic constraints, parameterless constructors, factory patterns',
    'Generic type constraints work correctly. Type parameter instances create successfully. Generic code compiles.',
    'Trying to instantiate type parameter without new() constraint, forgetting generic type might not have parameterless constructor, not understanding constraint limitations',
    0.92,
    'haiku',
    NOW(),
    'https://learn.microsoft.com/en-us/dotnet/csharp/fundamentals/generics/constraints'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'ASP.NET Core middleware ordering error: Authentication/Authorization in wrong order',
    'dotnet',
    'MEDIUM',
    '[
        {"solution": "Correct middleware order in Program.cs: app.UseRouting(); app.UseAuthentication(); app.UseAuthorization(); app.UseEndpoints(...);", "percentage": 96},
        {"solution": "Authentication must come before Authorization: Auth identifies user, AuthZ checks permissions", "percentage": 94}
    ]'::jsonb,
    'ASP.NET Core middleware pipeline, authentication vs authorization, middleware ordering rules',
    'Authentication and authorization work correctly. Protected endpoints require credentials. Users authorized properly.',
    'Authorization middleware before authentication, UseCors in wrong position, missing UseRouting, incorrect middleware order preventing proper request processing',
    0.95,
    'haiku',
    NOW(),
    'https://learn.microsoft.com/en-us/aspnet/core/fundamentals/middleware'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Entity Framework Core N+1 query problem: Excessive database calls',
    'dotnet',
    'MEDIUM',
    '[
        {"solution": "Use Include() to eager load related data: var items = dbContext.Items.Include(x => x.RelatedItems).ToList();", "percentage": 95},
        {"solution": "Use Select() projection to load only needed properties: var items = dbContext.Items.Select(x => new { x.Id, x.Name }).ToList();", "percentage": 92},
        {"solution": "Use ThenInclude() for nested relationships: .Include(x => x.Category).ThenInclude(c => c.Parent)", "percentage": 90}
    ]'::jsonb,
    'Entity Framework Core query patterns, LINQ to Entities, query optimization',
    'Single query fetches all needed data. No N+1 queries in profiler. Database roundtrips minimized.',
    'Forgetting to use Include for related entities, accessing navigation properties after materialization, not projecting unnecessary data, iterating collections causing multiple queries',
    0.93,
    'haiku',
    NOW(),
    'https://learn.microsoft.com/en-us/ef/core/querying/related-data/'
);
