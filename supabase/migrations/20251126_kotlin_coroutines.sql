INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Coroutines may randomly hang in heavy workload',
    'backend',
    'HIGH',
    '[
        {"solution": "Replace suspendCoroutine with suspendCancellableCoroutine to properly handle cancellation requests during suspension", "percentage": 92},
        {"solution": "Verify all suspending operations resume continuations properly and avoid blocking inside synchronized blocks", "percentage": 85},
        {"solution": "Audit MDCContext usage with kotlinx-coroutines-slf4j as it may interact unexpectedly with heavy concurrent loads", "percentage": 78}
    ]'::jsonb,
    'Coroutines that suspend during heavy workloads, suspendCoroutine usage in codebase',
    'Coroutines complete instead of hanging indefinitely, dispatcher threads process continuations normally',
    'Using suspendCoroutine instead of suspendCancellableCoroutine is a common bug that only manifests under heavy load',
    0.91,
    'haiku',
    NOW(),
    'https://github.com/Kotlin/kotlinx.coroutines/issues/4531'
),
(
    'Thrown exceptions incorrectly wrapped in a new instance of the same class',
    'backend',
    'MEDIUM',
    '[
        {"solution": "Disable stacktrace recovery using kotlinx.coroutines configuration to preserve original exception instance", "percentage": 90},
        {"solution": "Accept that stacktrace recovery cannot preserve exception identity and handle exception copies appropriately in test code", "percentage": 85}
    ]'::jsonb,
    'Exceptions with constructors accepting Throwable parameter, test context using kotlinx.coroutines.rx3.rxSingle.await()',
    'Original exception type is preserved without nested wrapping, exception message is correct',
    'Stacktrace recovery mechanism cannot preserve exception identity - it must make copies of exceptions',
    0.88,
    'haiku',
    NOW(),
    'https://github.com/Kotlin/kotlinx.coroutines/issues/4558'
),
(
    'Module with the Main dispatcher is missing. Add dependency providing the Main dispatcher',
    'backend',
    'HIGH',
    '[
        {"solution": "Remove problematic ProGuard rules: -dontoptimize, -keep class kotlinx.coroutines.internal.MainDispatcherFactory, -keep class kotlinx.coroutines.internal.MainDispatcherLoader", "percentage": 95},
        {"solution": "Ensure kotlinx-coroutines-android dependency is included for Android projects", "percentage": 88},
        {"solution": "Allow R8 optimization to function with built-in kotlinx.coroutines configuration rules by removing overriding keep directives", "percentage": 92}
    ]'::jsonb,
    'Android project with R8 optimization, ProGuard configuration in place',
    'Main dispatcher initializes correctly, coroutines execute on Main thread without initialization errors',
    'Custom ProGuard rules that override library defaults prevent ServiceLoader optimization from working correctly',
    0.93,
    'haiku',
    NOW(),
    'https://github.com/Kotlin/kotlinx.coroutines/issues/4533'
),
(
    'NullPointerException when enum class implements CoroutineContext.Element with companion object as key',
    'backend',
    'MEDIUM',
    '[
        {"solution": "Use object declaration instead of enum class when implementing CoroutineContext.Element, or delay key initialization until after enum constants are fully created", "percentage": 88},
        {"solution": "Escalate to Kotlin compiler team as this is a language-level initialization ordering issue (KT-80848), not a coroutines library bug", "percentage": 65}
    ]'::jsonb,
    'Enum class implementing CoroutineContext.Element with companion object Key, async or launch calls using the enum',
    'No NullPointerException when accessing key property, async/launch operations complete successfully',
    'Kotlin initializes enum constants before companion objects, making the key null during enum creation',
    0.82,
    'haiku',
    NOW(),
    'https://github.com/Kotlin/kotlinx.coroutines/issues/4500'
),
(
    'ClassCastException: String cannot be cast to ParentJob in Kotlin/JS coroutines',
    'backend',
    'LOW',
    '[
        {"solution": "Wrap JavaScript library calls in try-catch blocks and ensure only Throwable objects are thrown from coroutines", "percentage": 85},
        {"solution": "Use supervisor jobs to contain errors from misbehaving JavaScript libraries and prevent propagation up the scope", "percentage": 80},
        {"solution": "Acknowledge this is a Kotlin/JS platform limitation where non-Throwable values thrown from JS crash the coroutine (escalate to Kotlin team)", "percentage": 55}
    ]'::jsonb,
    'Kotlin/JS coroutines calling external JavaScript libraries that may throw non-Throwable values',
    'Coroutines handle exceptions gracefully, supervisor jobs prevent app crashes',
    'JavaScript allows throwing strings or other non-Throwable values, which breaks createCauseException() assumption in JobSupport.kt',
    0.76,
    'haiku',
    NOW(),
    'https://github.com/Kotlin/kotlinx.coroutines/issues/4290'
),
(
    'App crashes when unhandled exception occurs in coroutine on iOS with handleCoroutineException',
    'backend',
    'HIGH',
    '[
        {"solution": "Provide CoroutineExceptionHandler to all custom CoroutineScope instances: CoroutineScope(dispatcher + CoroutineExceptionHandler { _, e -> /* handle */ })", "percentage": 94},
        {"solution": "Use structured concurrency patterns and launch coroutines within proper scopes instead of GlobalScope", "percentage": 90},
        {"solution": "Review coroutine launch patterns to ensure all coroutines are launched within a managed scope with proper exception handling", "percentage": 88}
    ]'::jsonb,
    'iOS application with coroutines, unhandled exceptions in launched coroutines, custom CoroutineScope usage',
    'App handles exceptions gracefully without crashing, exceptions are logged or processed appropriately',
    'Launching coroutines outside structured concurrency or without CoroutineExceptionHandler causes app termination on iOS',
    0.92,
    'haiku',
    NOW(),
    'https://github.com/Kotlin/kotlinx.coroutines/issues/4419'
),
(
    'CancellationException stacktrace calculation causes significant performance degradation',
    'backend',
    'MEDIUM',
    '[
        {"solution": "Pass pre-created CancellationException instances to cancel() and withTimeout*() functions to avoid generating stacktraces for expected cancellations", "percentage": 87},
        {"solution": "Use CoroutineContextElement to signal that expected cancellations should skip stacktrace generation in suspendCancellableContinuation", "percentage": 82},
        {"solution": "Profile long-running coroutines to identify if frequent short-lived cancellations are impacting performance", "percentage": 75}
    ]'::jsonb,
    'Android Compose gesture handling or racing multiple coroutines where cancellation is expected behavior',
    'Coroutine cancellation completes quickly without significant stacktrace overhead, performance metrics improve',
    'The system generates full stacktraces for every CancellationException even when immediately discarded, wasting CPU cycles',
    0.85,
    'haiku',
    NOW(),
    'https://github.com/Kotlin/kotlinx.coroutines/issues/4535'
),
(
    'runCatching hides CancellationException and does not re-throw it in coroutines',
    'backend',
    'HIGH',
    '[
        {"solution": "Create and use runSuspendCatching() instead of runCatching() in suspend functions: catches exceptions but re-throws CancellationException", "percentage": 96},
        {"solution": "Replace runCatching blocks with try-catch that explicitly re-throws CancellationException: try { block() } catch (c: CancellationException) throw c catch (e: Throwable) Result.failure(e)", "percentage": 94},
        {"solution": "Use Result.runCatching only in non-coroutine contexts and handle cancellation separately in coroutine code", "percentage": 88}
    ]'::jsonb,
    'Kotlin standard library runCatching usage inside coroutine blocks, suspend functions using runCatching',
    'Coroutines respect cancellation signals, code does not execute after scope cancellation is requested',
    'runCatching suppresses CancellationException without re-throwing, breaking structured concurrency semantics',
    0.94,
    'haiku',
    NOW(),
    'https://github.com/Kotlin/kotlinx.coroutines/issues/1814'
),
(
    'Flow.zip fails asymmetrically with CancellationException wrapping',
    'backend',
    'MEDIUM',
    '[
        {"solution": "Ensure both flows in Flow.zip handle cancellation identically to avoid asymmetric behavior with AbortFlowException", "percentage": 85},
        {"solution": "Check the job cancellation cause rather than exception instance identity in zip operator implementation", "percentage": 78},
        {"solution": "Wrap custom exceptions around CancellationException consistently in both flows to maintain symmetric behavior", "percentage": 82}
    ]'::jsonb,
    'Flow.zip usage with multiple flows that catch and rethrow CancellationException or custom exceptions',
    'Flow.zip completes successfully regardless of which flow catches and rethrows the exception',
    'zip operator relies on user code propagating the exact same AbortFlowException instance, causing asymmetric failures',
    0.80,
    'haiku',
    NOW(),
    'https://github.com/Kotlin/kotlinx.coroutines/issues/4507'
),
(
    'Suspend function should be called only from a coroutine or another suspend function',
    'backend',
    'HIGH',
    '[
        {"solution": "Launch a coroutine scope before calling suspend functions: lifecycleScope.launch { callGetApi() } instead of calling directly", "percentage": 97},
        {"solution": "Convert the calling function to a suspend function: suspend fun onCreate() { callGetApi() }", "percentage": 90},
        {"solution": "Use async to wrap suspend function calls and retrieve result with await: lifecycleScope.async { callGetApi() }.await()", "percentage": 88}
    ]'::jsonb,
    'Suspend function call from non-coroutine context like Activity.onCreate() or callback methods',
    'Suspend function executes successfully within proper coroutine context, no compilation or runtime error',
    'Suspend functions create compiler constraint that prevents calling from regular function contexts',
    0.98,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/50410202/suspend-function-should-be-called-only-from-a-coroutine'
),
(
    'Cannot invoke setValue on a background thread when updating MutableLiveData from coroutine',
    'backend',
    'HIGH',
    '[
        {"solution": "Switch to Main dispatcher before updating LiveData: withContext(Dispatchers.Main) { liveData.value = newValue }", "percentage": 96},
        {"solution": "Use MainScope or viewModelScope which default to Main dispatcher for LiveData updates", "percentage": 94},
        {"solution": "Launch LiveData updates using Dispatchers.Main.immediate for synchronous execution if already on main thread", "percentage": 88}
    ]'::jsonb,
    'Coroutine launched on IO or Default dispatcher attempting to update MutableLiveData',
    'MutableLiveData updates execute successfully without threading violations, UI reflects new values',
    'Background coroutines directly call setValue on LiveData without switching to Main dispatcher thread',
    0.95,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/45648319/cannot-invoke-setvalue-on-a-background-thread'
),
(
    'withContext executes code in wrong context due to UNDISPATCHED start mode',
    'backend',
    'MEDIUM',
    '[
        {"solution": "Call yield() before withContext to force proper dispatching: yield(); withContext(Dispatchers.Default) { ... }", "percentage": 91},
        {"solution": "Call yield() inside the withContext block to correct thread context: withContext(Dispatchers.Default) { yield(); /* code */ }", "percentage": 88},
        {"solution": "Avoid CoroutineStart.UNDISPATCHED when you need specific dispatcher guarantees for downstream withContext calls", "percentage": 82}
    ]'::jsonb,
    'Coroutine with CoroutineStart.UNDISPATCHED or coroutines created without proper thread interception',
    'withContext executes on correct dispatcher thread, Thread.currentThread() returns expected dispatcher thread',
    'withContext relies on coroutineContext field to track actual thread execution, which becomes inaccurate with UNDISPATCHED',
    0.87,
    'haiku',
    NOW(),
    'https://github.com/Kotlin/kotlinx.coroutines/issues/4193'
),
(
    'Dispatcher failures leave coroutines uncompleted in hung state',
    'backend',
    'MEDIUM',
    '[
        {"solution": "Ensure custom dispatcher never throws in dispatch() method, catch exceptions and handle them gracefully", "percentage": 89},
        {"solution": "Implement fallback dispatcher for critical dispatch operations to prevent complete failure", "percentage": 81},
        {"solution": "Use handleCoroutineException to capture dispatcher failures and attempt recovery or cleanup", "percentage": 76}
    ]'::jsonb,
    'Custom CoroutineDispatcher implementation, dispatcher becomes unavailable after coroutine suspends',
    'Coroutines complete normally even if dispatcher fails, suspended coroutines eventually resume or timeout',
    'When dispatcher.dispatch() throws, coroutine suspends indefinitely because no recovery mechanism exists',
    0.84,
    'haiku',
    NOW(),
    'https://github.com/Kotlin/kotlinx.coroutines/issues/4209'
),
(
    'InterruptedException thrown by runBlocking when calling thread is interrupted',
    'backend',
    'MEDIUM',
    '[
        {"solution": "Wrap runBlocking in try-catch for InterruptedException if backwards compatibility requires ignoring thread interruption", "percentage": 83},
        {"solution": "Use CompletableDeferred pattern with dispatcher reuse to create uninterruptible runBlocking alternative", "percentage": 79},
        {"solution": "Review if thread interruption should actually terminate the blocking operation instead of suppressing the exception", "percentage": 72}
    ]'::jsonb,
    'Library migrated to coroutines maintaining blocking API surface, caller thread may be interrupted',
    'runBlocking completes or throws consistently regardless of thread interruption status, backwards compatible behavior',
    'runBlocking changed behavior to throw InterruptedException on thread interruption, breaking library migrations that expected ignorance',
    0.81,
    'haiku',
    NOW(),
    'https://github.com/Kotlin/kotlinx.coroutines/issues/4384'
),
(
    'Inappropriate blocking method call warning when using blocking libraries inside coroutines',
    'backend',
    'HIGH',
    '[
        {"solution": "Launch blocking calls on Dispatchers.IO instead of default dispatcher: withContext(Dispatchers.IO) { blockingCall() }", "percentage": 96},
        {"solution": "Use runBlocking inside IO dispatcher to explicitly signal synchronous operation: Dispatchers.IO { runBlocking { blockingCall() } }", "percentage": 88},
        {"solution": "Migrate to async libraries that provide suspend versions instead of wrapping blocking calls", "percentage": 82}
    ]'::jsonb,
    'OkHttp, Moshi, or other blocking library calls inside coroutine blocks',
    'Blocking calls complete without warnings, no performance degradation from thread starvation',
    'Using blocking libraries directly on Default dispatcher prevents other coroutines from executing',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/kotlin-coroutines?tab=Votes'
),
(
    'launch vs async - when to use join() vs await()',
    'backend',
    'HIGH',
    '[
        {"solution": "Use launch with join() when you don''t need a result: val job = launch { work() }; job.join()", "percentage": 95},
        {"solution": "Use async with await() when you need the coroutine result: val deferred = async { getData() }; val result = deferred.await()", "percentage": 96},
        {"solution": "launch throws exceptions automatically, async requires await() to propagate them - choose based on exception handling needs", "percentage": 91}
    ]'::jsonb,
    'Starting coroutines with launch or async, needing to wait for completion or results',
    'Coroutines complete and propagate results or exceptions appropriately for the pattern chosen',
    'Using launch when you need results causes missed data, using async when you don''t need results wastes memory',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/kotlin-coroutines?tab=Votes'
),
(
    'GlobalScope usage causes unstructured concurrency and difficult cancellation',
    'backend',
    'HIGH',
    '[
        {"solution": "Replace GlobalScope.launch with lifecycleScope.launch (Android) or viewModelScope.launch for lifecycle-aware cancellation", "percentage": 97},
        {"solution": "Create custom CoroutineScope with appropriate dispatcher and exception handler instead of using GlobalScope", "percentage": 95},
        {"solution": "Use structured concurrency patterns where coroutine lifetime is tied to object lifecycle for automatic cleanup", "percentage": 93}
    ]'::jsonb,
    'GlobalScope.launch or GlobalScope.async usage in production code, lifecycle management requirements',
    'Coroutines cancel appropriately with scope lifecycle, no memory leaks, exception handling works correctly',
    'GlobalScope creates fire-and-forget coroutines that cannot be cancelled and leak resources',
    0.96,
    'haiku',
    NOW(),
    'https://kotlinlang.org/docs/coroutines-guide.html'
),
(
    'CoroutineExceptionHandler only applies to root coroutines, child exceptions propagate upward',
    'backend',
    'HIGH',
    '[
        {"solution": "Use SupervisorJob or supervisorScope to prevent child exceptions from cancelling parent: val scope = CoroutineScope(SupervisorJob() + exceptionHandler)", "percentage": 94},
        {"solution": "Handle exceptions in child coroutines individually before they propagate: launch { try { work() } catch(e) { handle(e) } }", "percentage": 91},
        {"solution": "Apply CoroutineExceptionHandler to the scope creation, not to individual child coroutines", "percentage": 88}
    ]'::jsonb,
    'Coroutine exception handling with parent-child coroutine hierarchies, supervised vs standard jobs',
    'Parent coroutines continue executing when children fail, exceptions are handled without cascading cancellation',
    'Child coroutine exceptions immediately cancel parent unless using SupervisorJob or local exception handling',
    0.92,
    'haiku',
    NOW(),
    'https://kotlinlang.org/docs/exception-handling.html'
),
(
    'Timeout operation creates new CancellationException instead of signalling timeout specifically',
    'backend',
    'MEDIUM',
    '[
        {"solution": "Catch TimeoutCancellationException specifically: try { withTimeout(1000) { } } catch (e: TimeoutCancellationException) { }", "percentage": 88},
        {"solution": "Use withTimeoutOrNull() to return null instead of throwing exception when timeout occurs", "percentage": 90},
        {"solution": "Implement custom timeout handling by checking elapsed time and cancelling explicitly with typed exception", "percentage": 76}
    ]'::jsonb,
    'withTimeout() or withTimeoutOrNull() usage, need to distinguish timeout vs cancellation exceptions',
    'Timeout scenarios handled correctly, code distinguishes between timeout and normal cancellation',
    'CancellationException from timeout cannot be distinguished from normal cancellation without exception type checking',
    0.86,
    'haiku',
    NOW(),
    'https://kotlinlang.org/docs/coroutines-guide.html'
),
(
    'withContext vs async-await - dispatching and context switching differences',
    'backend',
    'HIGH',
    '[
        {"solution": "Use withContext for switching dispatcher without creating new coroutine: withContext(Dispatchers.IO) { blockingOp() }", "percentage": 97},
        {"solution": "Use async-await when you need parallel execution: val result1 = async { op1() }; val result2 = async { op2() }; result1.await() + result2.await()", "percentage": 96},
        {"solution": "withContext waits for completion before returning, async returns immediately with Deferred handle", "percentage": 94}
    ]'::jsonb,
    'Thread dispatcher switching, parallel vs sequential execution requirements, context propagation',
    'Correct dispatcher used for each operation, context inherits from parent correctly, execution order matches expectations',
    'Using async when sequential execution required causes race conditions, using withContext for parallel work is inefficient',
    0.95,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/kotlin-coroutines?tab=Votes'
);
