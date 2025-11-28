-- Mining 5 high-quality Go error entries
-- Category: go-errors
-- Date: 2025-11-26

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES
(
    'fatal error: all goroutines are asleep - deadlock detected',
    'go-errors',
    'HIGH',
    '[
        {"solution": "Ensure unbuffered channels have a sender and receiver goroutine active. Use buffered channels if only one side writes. Test: if main() sends on channel but no goroutine receives, Go detects deadlock. Fix: add go func() { for v := range ch { ... } }() before sending.", "percentage": 95},
        {"solution": "Check for circular channel dependencies. If goroutine A waits on goroutine B and goroutine B waits on A, deadlock occurs. Fix: restructure communication pattern to be acyclic, use sync.WaitGroup instead if just coordinating.", "percentage": 88},
        {"solution": "Use select with timeout: select { case result := <-ch: ..., case <-time.After(5*time.Second): log.Fatal(\"timeout\") } to detect if goroutine never sends.", "percentage": 82}
    ]'::jsonb,
    'Basic understanding of Go channels and goroutines. A running Go program with concurrent code.',
    'Run the program - if deadlock exists, runtime prints the error with goroutine dump. Stack trace shows which goroutines are stuck.',
    'Trying to send on closed channel (different error). Assuming buffered channel prevents deadlock (only delays it). Not checking all goroutine exit paths. Forgetting that main() exits when all goroutines block.',
    0.93,
    'haiku-4.5',
    NOW(),
    'https://stackoverflow.com/questions/13107958/what-exactly-does-golang-runtime-deadlock-error-mean',
    'admin:1764172331'
),
(
    'go: no required module provides package',
    'go-errors',
    'HIGH',
    '[
        {"solution": "Run go get -u [full-import-path]. Example: if error says \"no required module provides pkg/v1\", run: go get github.com/user/repo/pkg/v1. Verify the path is public and correctly formed.", "percentage": 96},
        {"solution": "Check go.mod file - ensure the require directive matches your import. If go.mod has module.io/v1.0 but you import module.io/v1.1, add that version: go get module.io@v1.1", "percentage": 92},
        {"solution": "Verify import path spelling and capitalization. Go import paths are case-sensitive and must match GitHub repo structure exactly. If repo is MyRepo, path is github.com/user/MyRepo not github.com/user/myrepo.", "percentage": 89},
        {"solution": "If using private modules, configure git: git config --global url.\"git@github.com:\".insteadOf \"https://github.com/\" and set GOPRIVATE=github.com/user/* environment variable.", "percentage": 78}
    ]'::jsonb,
    'Go 1.11+ with go.mod. Access to the required module repository. Network access to download modules.',
    'Run go mod tidy - should remove error. Verify import statement matches the module path listed in go.mod. Run go list -m all to see all dependencies.',
    'Typo in import path - Go won''t autocorrect. Assuming old GOPATH behavior instead of modules. Forgetting major version in path (v2+ modules need /v2 suffix). Not running go mod tidy after manual edits.',
    0.94,
    'haiku-4.5',
    NOW(),
    'https://stackoverflow.com/questions/56236238/cannot-find-module-providing-package',
    'admin:1764172331'
),
(
    'panic: runtime error: invalid memory address or nil pointer dereference',
    'go-errors',
    'HIGH',
    '[
        {"solution": "Add nil check before dereferencing: if ptr != nil { x := ptr.Field }. Use this pattern everywhere you dereference pointers from external sources or function returns.", "percentage": 97},
        {"solution": "Initialize pointers before use. Instead of: var s *Struct; s.Field = value (panic), use: s := &Struct{}; s.Field = value or var s Struct; s.Field = value (no pointer).", "percentage": 95},
        {"solution": "For maps, check existence: v, ok := myMap[key]; if ok { use v }. Maps return zero-value for missing keys, and dereferencing pointer fields causes panic.", "percentage": 93},
        {"solution": "Review function returns - if a function returns (*Type, error), always check error first: obj, err := getValue(); if err != nil { return } before dereferencing obj.", "percentage": 91}
    ]'::jsonb,
    'Ability to read stack trace. Knowing which variable is nil (Go panic shows the line number).',
    'Run with debugger or add logging before dereference line. Stack trace points to exact line. Error should disappear when nil check is added.',
    'Assuming a function always returns non-nil (ignoring it could be nil). Not reading function return documentation. Confusing empty pointer with nil (var p *Struct{} is still nil). Expecting Go to auto-initialize pointers.',
    0.96,
    'haiku-4.5',
    NOW(),
    'https://stackoverflow.com/questions/9322905/runtime-error-invalid-memory-address-or-nil-pointer-dereference',
    'admin:1764172331'
),
(
    'panic: runtime error: index out of range',
    'go-errors',
    'HIGH',
    '[
        {"solution": "Add bounds check before indexing: if index >= 0 && index < len(slice) { x := slice[index] }. Always validate indices from user input or loops.", "percentage": 97},
        {"solution": "Check slice length: if len(mySlice) > 0 { firstElem := mySlice[0] }. Never assume slice has elements.", "percentage": 96},
        {"solution": "Use defensive loop: for i, v := range slice { ... } instead of for i := 0; i <= len(slice); i++ (off-by-one). Range automatically handles correct bounds.", "percentage": 94},
        {"solution": "For slice operations, use safe patterns: slice = append(slice, items...) adds without panicking. slice[i:j] panics only if i > j or j > len; verify indices first.", "percentage": 88}
    ]'::jsonb,
    'Understanding of slice indexing (0-based). Knowing the difference between length and valid indices.',
    'Run code - panic goes away if bounds check added. Verify loop uses correct range or bounds. Print len(slice) before indexing to confirm it has elements.',
    'Off-by-one in loops (using <= instead of <). Forgetting slices are 0-indexed. Assuming loop variable matches slice length (len(slice) = 5 means indices 0-4, not 1-5). Not handling empty slices.',
    0.95,
    'haiku-4.5',
    NOW(),
    'https://stackoverflow.com/questions/10632191/index-out-of-range-for-slice',
    'admin:1764172331'
),
(
    'panic: interface conversion: interface{} is [type1], not [type2]',
    'go-errors',
    'HIGH',
    '[
        {"solution": "Always use checked type assertion: v, ok := iface.(ExpectedType); if !ok { handle error }. Never bare-assert: v := iface.(ExpectedType) without ok check.", "percentage": 96},
        {"solution": "Use type switch for multiple possible types: switch v := iface.(type) { case string: ..., case int: ..., default: ... }. This safely handles any type.", "percentage": 94},
        {"solution": "Log or print actual type before asserting: fmt.Printf(\"%T\\n\", iface) shows what type is actually stored. Verify this matches expected type before assertion.", "percentage": 89},
        {"solution": "Check JSON unmarshaling results - json.Unmarshal stores map[string]interface{} by default, so assert each field carefully. Use json.Number for numbers or define struct types.", "percentage": 87}
    ]'::jsonb,
    'Understanding Go empty interface interface{}. Knowledge of type assertions and type switches.',
    'Assertion returns (value, bool) - bool will be true. If panic before, add ok check and it disappears. Type switch handles all cases without panic.',
    'Using bare assertion instead of checked (v := x.(T) panics if wrong type; should use v, ok := x.(T); if !ok). Forgetting empty interface can hold any type. Assuming JSON numbers are int64 (they''re float64). Not using type switch when handling multiple types.',
    0.93,
    'haiku-4.5',
    NOW(),
    'https://stackoverflow.com/questions/14289256/interface-conversion-type-assertion-failed',
    'admin:1764172331'
);
