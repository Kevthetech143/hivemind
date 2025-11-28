INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES
(
    'fatal error: all goroutines are asleep - deadlock',
    'golang',
    'HIGH',
    '[
        {"solution": "Use sync.WaitGroup to block main until all goroutines complete. Declare var wg sync.WaitGroup globally, call wg.Add(1) before launching each goroutine, add defer wg.Done() inside each goroutine function, and call wg.Wait() in main before return", "percentage": 95},
        {"solution": "Use channels with select/case to wait for goroutine completion instead of WaitGroup", "percentage": 80}
    ]'::jsonb,
    'Understanding of goroutines and synchronization primitives in Go. Basic knowledge of sync package.',
    'Program completes successfully without deadlock error. All goroutines finish execution before main returns. No hanging processes.',
    'Placing defer wg.Done() outside the goroutine function. Forgetting to call wg.Wait() in main. Not calling wg.Add() before launching goroutines.',
    0.95,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/26927479/go-language-fatal-error-all-goroutines-are-asleep-deadlock',
    'admin:1764174220'
),
(
    'go: go.mod file not found in current directory or any parent directory; see ''go help modules''',
    'golang',
    'HIGH',
    '[
        {"solution": "Run go mod init <project-name> in your project root to create go.mod file. Then run go mod tidy to fetch dependencies", "percentage": 98},
        {"solution": "Alternatively, disable module mode with go env -w GO111MODULE=off to revert to legacy GOPATH behavior (not recommended)", "percentage": 70}
    ]'::jsonb,
    'Go 1.16+ installed. Project directory structure in place. Access to initialize modules.',
    'go.mod file exists in project root. ''go build'' and other commands execute without module-not-found errors. Dependencies properly resolved.',
    'Working in subdirectories instead of project root when running go mod init. Setting GO111MODULE=off on new projects instead of embracing modules. Not running go mod tidy after initialization.',
    0.98,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/66894200/error-message-go-go-mod-file-not-found-in-current-directory-or-any-parent-dire',
    'admin:1764174220'
),
(
    'panic: runtime error: invalid memory address or nil pointer dereference',
    'golang',
    'CRITICAL',
    '[
        {"solution": "Check error BEFORE deferring cleanup. Move error check before defer statements. Example: res, err := client.Do(req); if err != nil { return nil, err }; defer res.Body.Close()", "percentage": 92},
        {"solution": "Add nil checks before accessing pointer fields and methods. Use guard clauses to verify pointer is not nil before dereference", "percentage": 90},
        {"solution": "Use a linter like staticcheck or go vet to catch nil pointer dereferences at compile time", "percentage": 75}
    ]'::jsonb,
    'Understanding of Go pointers and error handling. Knowledge of defer semantics.',
    'Code runs without panic. No segmentation violations. All pointer dereferences occur on valid (non-nil) pointers.',
    'Using defer before checking errors. Not verifying nil before dereferencing. Assuming function return values are always valid. Forgetting that defer executes immediately, not actually deferred in Go.',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/16280176/go-panic-runtime-error-invalid-memory-address-or-nil-pointer-dereference',
    'admin:1764174220'
),
(
    'context.Canceled error in goroutines and microservices',
    'golang',
    'HIGH',
    '[
        {"solution": "Check if context is canceled before operations: if ctx.Err() != nil { return ctx.Err() }. Use errors.Is(err, context.Canceled) to check specific error type", "percentage": 88},
        {"solution": "For background operations, use context.Background() instead of inheriting parent context to prevent premature cancellation when parent goroutine finishes", "percentage": 85},
        {"solution": "Use context.WithTimeout() for explicit timeout control and handle context.DeadlineExceeded separately from context.Canceled", "percentage": 82}
    ]'::jsonb,
    'Understanding of Go context package and goroutine lifecycle. Knowledge of timeout and cancellation patterns.',
    'Goroutines handle cancellation gracefully. Appropriate errors returned when context is canceled. Background operations complete without unexpected termination.',
    'Passing parent context to background operations without creating new context. Not distinguishing between cancellation and timeout. Ignoring context.Err() before operations. Not using errors.Is() for proper error type checking.',
    0.88,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/62381063/handling-context-cancelled-errors',
    'admin:1764174220'
),
(
    'WARNING: DATA RACE condition detected in goroutines with shared memory access',
    'golang',
    'HIGH',
    '[
        {"solution": "Protect shared state with sync.Mutex. Lock before reading/writing shared fields: mu.Lock(); defer mu.Unlock(); followed by field access", "percentage": 94},
        {"solution": "Use channels instead of shared memory for inter-goroutine communication. Send values through channels rather than accessing shared variables directly", "percentage": 92},
        {"solution": "Run go test -race to detect race conditions during testing. Fix all reported data races before production deployment", "percentage": 96}
    ]'::jsonb,
    'Understanding of concurrent programming in Go. Knowledge of sync.Mutex and channels. Ability to run tests with race detector.',
    'go test -race passes without detecting data races. Concurrent goroutines safely access shared data. No segmentation faults or undefined behavior in production.',
    'Accessing shared state without mutex protection. Forgetting to hold locks during entire critical section. Not using channels for concurrent communication. Running tests without -race flag before deployment.',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/70751685/golang-race-condition-using-go-routine',
    'admin:1764174220'
);
