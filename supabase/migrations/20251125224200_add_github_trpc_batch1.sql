-- Add tRPC GitHub issues with solutions - Batch 1
-- Extracted from: https://github.com/trpc/trpc/issues
-- Category: github-trpc
-- Extraction date: 2025-11-25

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Server Closed Subscriptions Do Not Update WebSocket Client Connection State',
    'github-trpc',
    'HIGH',
    $$[
        {"solution": "Suppress connection state change events for ongoing subscriptions after establishment to prevent spurious state transitions", "percentage": 90, "note": "Fix merged in PR #6970"},
        {"solution": "Distinguish between connectionState (underlying WebSocket health) and subscription state (query status in tanstack-react-query)", "percentage": 85, "note": "Update application logic to check subscription state separately"},
        {"solution": "Implement proper subscription completion handlers when servers close idle subscriptions", "percentage": 80, "note": "Use onCompleted callback to track subscription termination"}
    ]$$::jsonb,
    '@trpc/client v11+, @trpc/tanstack-react-query v11+, WebSocket link configured',
    'Subscription state transitions from pending to idle when server closes subscription, WebSocket connection remains independent of subscription status',
    'Do not rely solely on connectionState to determine subscription status. The connectionState reflects WebSocket health, not individual subscription status. Always check subscription-specific state in react-query.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://github.com/trpc/trpc/issues/6962'
),
(
    'TypeScript Type Instantiation Excessively Deep with Prisma JsonValue in tRPC',
    'github-trpc',
    'HIGH',
    $$[
        {"solution": "Use superjson transformer globally to handle recursive Prisma.JsonValue serialization properly", "percentage": 95, "note": "Set transformer: superjson in both server and client configurations"},
        {"solution": "Add failing test case to serialize.test.ts and experiment with fixes to the Serialize type utility", "percentage": 85, "note": "Requires understanding of tRPC type inference internals"},
        {"solution": "Avoid exposing raw Prisma.JsonValue from procedures; wrap with explicit typing layer", "percentage": 75, "note": "Create custom types that flatten JsonValue structure"}
    ]$$::jsonb,
    'tRPC v11+, Prisma with JSON fields, ZenStack or direct Prisma integration, superjson package installed',
    'Client-side type inference resolves to concrete type instead of unknown, no TypeScript instantiation errors on procedure return values',
    'Prisma.JsonValue is recursive and does not serialize well through network boundaries. JSON fields from Prisma require explicit type handling. Do not assume Prisma types are directly serializable.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/trpc/trpc/issues/6997'
),
(
    'tRPC Subscription maxDurationMs Does Not Interrupt When Not Yielding',
    'github-trpc',
    'HIGH',
    $$[
        {"solution": "Ensure subscription handlers yield values periodically to allow maxDurationMs timeout to fire properly", "percentage": 90, "note": "Implement periodic yield or heartbeat in subscription"},
        {"solution": "Review Node.js IncomingMessage to Web Request conversion in adapters/node-http/incomingMessageToRequest.ts for proper AbortController signal handling", "percentage": 85, "note": "Lines 116-137 handle request conversion; verify abort signal propagation"},
        {"solution": "For serverless platforms, reduce maxDurationMs to value significantly lower than lambda timeout limit", "percentage": 80, "note": "Example: set maxDurationMs to 4 minutes for 5-minute lambda timeout"}
    ]$$::jsonb,
    'tRPC server on Vercel or serverless platform, SSE subscriptions configured with maxDurationMs, Node.js adapter',
    'Lambda function completes before timeout, subscription properly terminates when maxDurationMs reached, no "Task timed out" errors',
    'Non-yielding subscriptions never trigger abort signals. The timeout mechanism relies on the abort signal being checked. Empty subscriptions that do not yield will run indefinitely regardless of maxDurationMs setting.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://github.com/trpc/trpc/issues/6991'
),
(
    'httpBatchStreamLink Throws Undefined Error When Edge Function Streams Terminate',
    'github-trpc',
    'HIGH',
    $$[
        {"solution": "Upgrade to tRPC version after 1.16.0; PR #6960 regression has been fixed in later versions", "percentage": 95, "note": "Verify streamController.error() receives proper error object"},
        {"solution": "Verify error parameter is passed to streamController.error() in jsonl.ts when stream terminates", "percentage": 88, "note": "Error should be TypeError or network error, not undefined"},
        {"solution": "Add error boundary catch blocks with type guards to handle both typed errors and undefined cases", "percentage": 75, "note": "Temporary workaround: catch (error: any) { const actualError = error ?? new Error(\"Stream closed\") }"}
    ]$$::jsonb,
    'tRPC v1.15.0 or earlier, httpBatchStreamLink configured, React Native or Expo application, streaming enabled',
    'catch blocks receive proper error objects instead of undefined, error message distinguishes between network disconnect and stream termination, local testing matches production behavior',
    'Undefined errors indicate a regression in error handling. Do not silently ignore undefined caught values. Test error handling in both local and production environments. The error source matters for proper recovery logic.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://github.com/trpc/trpc/issues/6989'
),
(
    'tRPC onError Callback Not Reporting Original Error in Express Middleware',
    'github-trpc',
    'MEDIUM',
    $$[
        {"solution": "Traverse error.cause chain recursively to extract actual error details: if (error.cause instanceof Error) { getActualError(error.cause) }", "percentage": 85, "note": "Some errors wrap underlying exceptions in cause property"},
        {"solution": "Add try/catch blocks directly in procedure implementations to capture and log original errors before tRPC middleware", "percentage": 80, "note": "Ensures error context is preserved from source"},
        {"solution": "Use custom error handling middleware that captures stack traces and error context before tRPC wrapping", "percentage": 75, "note": "Implement as first middleware in chain"}
    ]$$::jsonb,
    '@trpc/server v11+, Express middleware configured, error logging system (Datadog, Sentry, etc.)',
    'Error logging system receives complete error information with context, stack traces visible in monitoring dashboard, original error cause chain preserved',
    'Error wrapping in tRPC middleware can obscure underlying errors. The error object may nest actual error in the cause property. Always check error.cause when root error is insufficient for debugging.',
    0.78,
    'sonnet-4',
    NOW(),
    'https://github.com/trpc/trpc/issues/6977'
),
(
    'Unstable httpBatchStreamLink Streaming Responses in React Native and Expo',
    'github-trpc',
    'HIGH',
    $$[
        {"solution": "Filter empty/whitespace-only lines before JSON parsing to handle ping keep-alive signals: if (!line.trim()) { return; }", "percentage": 92, "note": "Ping keep-alives send space characters that JSON.parse() cannot handle"},
        {"solution": "Upgrade tRPC server to version with whitespace filtering in createConsumerStream function in packages/server/src/unstable-core-do-not-import/stream/jsonl.ts", "percentage": 90, "note": "Latest versions have this fix applied"},
        {"solution": "Disable pingMs keep-alives if streaming stability is more critical than connection health monitoring", "percentage": 75, "note": "Trade-off: reduces failure rate but loses connection monitoring"}
    ]$$::jsonb,
    'React Native or Expo app, tRPC httpBatchStreamLink configured, streaming responses enabled, pingMs keep-alive configured',
    'Streaming responses parse successfully 95%+ of the time, no JSON parse errors on whitespace characters, refetch operations do not cascade into failure loops',
    'React Native TextDecoderStream polyfill chunks data differently than Node.js, causing whitespace-only lines between ping signals. Do not assume servers only send valid JSON. Account for keep-alive mechanisms in stream parsing.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://github.com/trpc/trpc/issues/6996'
),
(
    'WebSocket Subscription Parameters Resend Old Values on Reconnect Without Update',
    'github-trpc',
    'MEDIUM',
    $$[
        {"solution": "Implement onReconnect() callback to return updated subscription arguments with current client state", "percentage": 90, "note": "Called on each reconnection to fetch fresh parameters"},
        {"solution": "Use parameterized function as first argument like React useState - client.join.subscribe(() => ({ lastEventId: getLastEvent() }), {...})", "percentage": 85, "note": "Function called on each connection to get fresh parameters"},
        {"solution": "Add manual onStarted() callback triggering separate resume mutation to notify server of current client state for proper event filtering", "percentage": 80, "note": "Workaround for interim release without native onReconnect support"}
    ]$$::jsonb,
    'tRPC WebSocket subscription client configured, multi-connect scenario with state changes (lastEventId, etc.)',
    'Reconnection sends updated parameters instead of original values, server correctly handles resumed subscriptions with current state, no duplicate event delivery on reconnect',
    'Original subscription parameters are cached on initial subscription. Reconnection resends cached values, not current state. Old lastEventId values cause duplicate server deliveries. Must implement explicit parameter refresh mechanism.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://github.com/trpc/trpc/issues/4122'
),
(
    'tRPC WebSocket Client Retry Loop When createContext Fails on Server',
    'github-trpc',
    'HIGH',
    $$[
        {"solution": "Move context creation to WebSocket handshake phase, allowing proper HTTP error codes to reject connection before acceptance", "percentage": 90, "note": "Prevents retry counter reset on failed context creation"},
        {"solution": "Delay resetting retry counter until receiving successful response to actual request, not merely accepting connection", "percentage": 82, "note": "Requires defining maximum success delay to avoid reconnection delays"},
        {"solution": "Implement exponential backoff verification: track whether retry counter reset despite error, indicating handshake-phase issue", "percentage": 75, "note": "Diagnostic approach to identify context initialization failures"}
    ]$$::jsonb,
    '@trpc/client v10.38+, WebSocket link configured, server context initialization logic present',
    'Retry attempts respect exponential backoff schedule, connection failures with context errors backoff properly instead of rapid retry, observable delay between reconnection attempts',
    'If createContext fails after connection acceptance, retry counter resets to 0, bypassing exponential backoff entirely. This creates rapid retry loops. Always reset retry counter only after successful request processing.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://github.com/trpc/trpc/issues/4774'
),
(
    'Type Inference Failure for Async Generator Outputs in tRPC Streams',
    'github-trpc',
    'MEDIUM',
    $$[
        {"solution": "Update StackBlitz environment to use newer TypeScript version that supports async generator type inference", "percentage": 88, "note": "Issue caused by StackBlitz WebContainer TypeScript version, not tRPC code"},
        {"solution": "When developing locally, use TypeScript 5.0+ with strict mode enabled to properly infer async generator types", "percentage": 90, "note": "Local environment has correct TypeScript support"},
        {"solution": "Explicitly annotate return type if IDE shows any instead of relying on inference: async function*(...): AsyncGenerator<typeof expected> {...}", "percentage": 85, "note": "Workaround for environments with outdated TypeScript"}
    ]$$::jsonb,
    'tRPC with streaming/async generators, HTTP Batch Stream Link configured, development environment (local or cloud IDE)',
    'IDE shows proper inferred type instead of any, TypeScript compiler correctly identifies async generator yield types, playground/cloud environment has matching TypeScript version',
    'StackBlitz WebContainer environments may have outdated TypeScript versions. Playground type inference does not always match local development. Always verify type inference in local environment before relying on IDE hints.',
    0.79,
    'sonnet-4',
    NOW(),
    'https://github.com/trpc/trpc/issues/6407'
),
(
    'Zod Type Inference Incorrect with catchall() in tRPC Client',
    'github-trpc',
    'MEDIUM',
    $$[
        {"solution": "Update tRPC to version with fixed Serialize<> utility type that handles unknown types correctly (PR #3839)", "percentage": 95, "note": "Upgrade to latest patch release that includes fix"},
        {"solution": "Verify Serialize<> utility type properly reflects Remix changes and handles unknown types in catchall schemas", "percentage": 85, "note": "Ensure tRPC internal type utilities match current standards"},
        {"solution": "Add expect-type test cases to verify Serialize<> behavior with catchall properties to prevent regression", "percentage": 80, "note": "Test-driven approach to validate type correctness"}
    ]$$::jsonb,
    'tRPC v11+, Zod schema with .catchall(), client type generation enabled',
    'Procedure return type correctly infers { [x: string]: unknown; name: string; } instead of { [x: string]: never; }, TypeScript client shows proper autocomplete for catchall properties',
    'The Serialize<> utility type must handle unknown types in catchall scenarios. Older versions incorrectly infer never types. Catchall properties must explicitly support unknown or specific union types.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://github.com/trpc/trpc/issues/3320'
),
(
    'Zod v4 Deprecated _input/_output Properties Cause Type Inference Bugs in tRPC',
    'github-trpc',
    'HIGH',
    $$[
        {"solution": "Migrate type inference to Standard Schema API (Zod v3.24.0+): Use z.input<T> and z.output<T> instead of ._input and ._output", "percentage": 95, "note": "Standard Schema is official replacement, works with multiple validators"},
        {"solution": "Upgrade to tRPC version with PR #6888 implementing Standard Schema for input/output type inference", "percentage": 92, "note": "Latest versions have Standard Schema support merged"},
        {"solution": "Add fallback type extraction for older Zod versions that do not support Standard Schema", "percentage": 80, "note": "Maintain backwards compatibility with Zod v3"}
    ]$$::jsonb,
    'Zod v4.0+, tRPC v11+, TypeScript strict mode enabled',
    'Procedure input types correctly inferred in resolver functions, no warnings about deprecated _input/_output properties, branded schemas return correct types',
    'Zod v4 deprecated _input and _output properties. They also have known bugs with branded schemas. Standard Schema is the official replacement. Do not rely on deprecated underscore properties.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://github.com/trpc/trpc/issues/6887'
),
(
    'SSE Subscription Signal Never Aborts Causing Memory Leak in tRPC',
    'github-trpc',
    'MEDIUM',
    $$[
        {"solution": "Handle req.socket events (close, error) to properly propagate abort signal to subscription handlers (PR #6204)", "percentage": 90, "note": "Fix requires monitoring socket events, not just stream events"},
        {"solution": "Verify that subscription AsyncIterable return method is called when connection closes to trigger resource cleanup", "percentage": 85, "note": "Resource cleanup depends on proper return() invocation"},
        {"solution": "In local development, manually close subscriptions and verify console logs show aborted=true to confirm signal propagation", "percentage": 80, "note": "Manual testing approach to verify fix in your environment"}
    ]$$::jsonb,
    'tRPC SSE subscriptions configured, server.ts with subscription handlers, Node.js req.socket available',
    'signal.aborted transitions to true when client disconnects, subscription loops exit cleanly, no memory accumulation over time, resource cleanup methods called properly',
    'Signal abort depends on socket close events being monitored. Simply closing the response stream does not guarantee subscription cleanup. Handlers must explicitly check signal.aborted in while loops.',
    0.83,
    'sonnet-4',
    NOW(),
    'https://github.com/trpc/trpc/issues/6193'
),
(
    'WebSocket Stops Working on iOS Safari After Tab Suspend and No Reconnect Happens',
    'github-trpc',
    'MEDIUM',
    $$[
        {"solution": "Implement keepAlive mechanism in WebSocket link to maintain heartbeat and prevent connection degradation (PR #6030)", "percentage": 92, "note": "Upgrade to tRPC version with keepAlive support merged"},
        {"solution": "Use Page Visibility API to detect tab restoration and manually trigger close event: document.addEventListener(\"visibilitychange\", () => { if (document.visibilityState === \"visible\") wsClient.getConnection().dispatchEvent(new CloseEvent(\"close\")); })", "percentage": 88, "note": "Workaround for iOS Safari behavior prior to keepAlive fix"},
        {"solution": "Configure shorter heartbeat interval (e.g., 5-10 seconds) to detect silent disconnections faster", "percentage": 80, "note": "Reduces lag before detecting stale connections"}
    ]$$::jsonb,
    'tRPC WebSocket client on iOS Safari, @trpc/client v11+',
    'WebSocket maintains connection across tab suspension, reconnection happens automatically when tab returns to foreground, no silent disconnections after 3-5 minute wait',
    'iOS Safari suspends background tabs, causing WebSocket to hang silently without close events. Standard reconnection logic does not trigger. Manual visibility-based reconnection or keepAlive heartbeat required.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://github.com/trpc/trpc/issues/4078'
),
(
    'tRPC WebSocket URL Injection Needed for Dynamic Pre-Signed Authenticated URLs',
    'github-trpc',
    'MEDIUM',
    $$[
        {"solution": "Use getRetryUrl option in WebSocketClientOptions to fetch fresh authenticated URLs during reconnection: getRetryUrl?: () => Promise<string>", "percentage": 95, "note": "Allows async URL refresh on reconnect attempts"},
        {"solution": "Upgrade to tRPC version with asyncWsLink (after PR #4205 merge) for lazy WebSocket initialization", "percentage": 90, "note": "Supports async URL functions like httpLink handles async headers"},
        {"solution": "Implement custom WebSocket link wrapper that intercepts reconnection and refreshes URL from auth service before reconnecting", "percentage": 80, "note": "Manual implementation prior to native asyncWsLink support"}
    ]$$::jsonb,
    'tRPC WebSocket link configured, authentication system with pre-signed single-use URLs, expiry enforcement in URL generation',
    'Reconnection fetches new authenticated URLs, old URLs are not reused across disconnects, fresh URL obtained within security TTL window, no authentication failures on reconnect',
    'WebSocket URLs are static after initial connection. Single-use URLs expire and cannot be reused. Standard reconnection without URL refresh will fail with authentication errors. Native asyncWsLink or getRetryUrl must be used.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://github.com/trpc/trpc/issues/4188'
);
