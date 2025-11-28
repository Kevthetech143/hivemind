INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES
(
    'fatal error: all goroutines are asleep - deadlock',
    'go-errors',
    'HIGH',
    '[
        {"solution": "Ensure WaitGroup.Add(1) is called before spawning each goroutine, defer WaitGroup.Done() inside the goroutine, and call WaitGroup.Wait() in main to block until all goroutines complete. Close the channel after sending data to signal goroutines to stop.", "percentage": 96},
        {"solution": "Use channels with proper buffering and ensure all goroutine senders and receivers are properly coordinated - if a goroutine blocks forever on channel receive/send, the program deadlocks", "percentage": 85}
    ]'::jsonb,
    'Understanding of Go concurrency primitives: goroutines, channels, and sync.WaitGroup. Basic knowledge of channel blocking behavior.',
    'Program runs to completion without panic. All goroutines successfully complete their work and exit. Verify with: run the program and confirm clean termination without hanging.',
    'Forgetting to call WaitGroup.Add() before spawning goroutines. Not closing channels which leaves goroutines waiting forever. Placing defer statements before error checks. Assuming goroutines clean up automatically without synchronization.',
    0.96,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/26927479/go-language-fatal-error-all-goroutines-are-asleep-deadlock',
    'admin:1764172569'
),
(
    'go: go.mod file not found in current directory or any parent directory',
    'go-errors',
    'HIGH',
    '[
        {"solution": "Run ''go mod init <module-name>'' (e.g., go mod init example.com/myapp) in your project root directory to create go.mod file. This enables module-aware mode which is required by default in Go 1.16+", "percentage": 98},
        {"solution": "If you must use GOPATH mode, run ''go env -w GO111MODULE=off'' to disable modules (not recommended for new projects)", "percentage": 70}
    ]'::jsonb,
    'Go 1.16 or later installed. A project directory with Go source files (*.go). No existing go.mod file in the project or parent directories.',
    'go.mod file is created in project root. ''go run'' or ''go build'' commands work without the error. Verify with: ls -la go.mod should show the file, and go list -m all should show module dependencies.',
    'Working in a subdirectory and not initializing at project root. Not realizing Go switched to module mode by default in 1.16. Setting GO111MODULE=off globally which breaks future projects.',
    0.98,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/66894200/error-message-go-go-mod-file-not-found-in-current-directory-or-any-parent-dire',
    'admin:1764172569'
),
(
    'panic: runtime error: invalid memory address or nil pointer dereference',
    'go-errors',
    'HIGH',
    '[
        {"solution": "Check error returns BEFORE dereferencing pointers. Move defer statements to after error checks: res, err := client.Do(req); if err != nil { return nil, err }; defer res.Body.Close() - this ensures res is not nil before accessing Body.", "percentage": 97},
        {"solution": "Always guard pointer dereferences with nil checks: if ptr != nil { ptr.Method() } to prevent accessing fields/methods on nil values", "percentage": 95}
    ]'::jsonb,
    'Understanding of Go''s error handling model. Knowledge that defer evaluates arguments immediately even if execution is delayed. Awareness that failed function calls return nil values.',
    'Program runs without panic. Pointer fields are safely accessed. Verify with: run the program under normal and error conditions without segfaults. Use nil checks in logs to confirm defensive programming.',
    'Placing defer statements before error checks causing panic on nil. Not checking if pointers are nil before dereferencing. Assuming function returns are always non-nil even on error. Ignoring error return values.',
    0.97,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/16280176/go-panic-runtime-error-invalid-memory-address-or-nil-pointer-dereference',
    'admin:1764172569'
),
(
    'panic: interface conversion: interface {} is string, not float64',
    'go-errors',
    'HIGH',
    '[
        {"solution": "Use comma-ok idiom for safe type assertion: val, ok := data.(float64); if !ok { /* handle string case */ }. Parse strings explicitly with strconv.ParseFloat() when needed.", "percentage": 94},
        {"solution": "Use struct tags during JSON unmarshaling: type Response struct { Price float64 `json:\",string\"` } to automatically convert quoted numeric strings to the correct type", "percentage": 93}
    ]'::jsonb,
    'Understanding of Go''s interface{} type and type assertions. Knowledge of JSON unmarshaling behavior. Familiarity with strconv package for string conversions.',
    'Type assertions succeed without panic. Program handles both numeric and string values correctly. Verify with: run with various input types and confirm graceful handling. Add logging to show actual vs expected types.',
    'Assuming interface{} values are always the expected type without checking. Not knowing that JSON quoted values unmarshal as strings not numbers. Forgetting the comma-ok pattern (val, ok := x.(Type)). Not verifying API response structure before coding.',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/70613644/panic-interface-conversion-interface-is-string-not-float64',
    'admin:1764172569'
),
(
    'fatal error: concurrent map read and map write',
    'go-errors',
    'HIGH',
    '[
        {"solution": "Protect map access with sync.RWMutex: use Lock() for writes, RLock()/RUnlock() for reads. Wrap all map operations with appropriate mutex locks.", "percentage": 96},
        {"solution": "Use sync.Map instead of map[K]V for concurrent access - provides Store/Load/Range operations that are thread-safe. Best for high-concurrency, low-contention workloads.", "percentage": 92}
    ]'::jsonb,
    'Understanding of Go''s race detector. Knowledge of sync package (Mutex, RWMutex, Map). Understanding that maps are not thread-safe by default in Go.',
    'Program runs without panic or race detection errors. Concurrent map operations are serialized. Verify with: run with ''go run -race'' and confirm no race warnings. Test with multiple goroutines accessing map simultaneously.',
    'Forgetting to lock the map entirely. Using only Lock() for reads (should use RLock()). Not unlocking in defer statements causing deadlocks. Thinking maps are implicitly thread-safe. Not testing with -race detector.',
    0.96,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/45585589/golang-fatal-error-concurrent-map-read-and-map-write',
    'admin:1764172569'
);
