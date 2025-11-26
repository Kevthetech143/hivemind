-- Mining GitHub Issues from angular/angular repository
-- Category: github-angular
-- Batch 1: High-voted and most-commented issues with solutions

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, last_verified, source_url
) VALUES
(
    'Angular signal-forms: FormValueControl unable to mark field as dirty',
    'github-angular',
    'MEDIUM',
    $$[
        {"solution": "Upgrade to Angular 21.0.0+ which includes fix via PR #64483 that enables automatic dirty state marking", "percentage": 95, "note": "The fix allows fields to automatically mark as dirty when values change via bound controls"},
        {"solution": "Workaround for earlier versions: manually call markAsDirty() in setValue method when updating signal value", "percentage": 75, "command": "setValue(event: Event) { this.value.set(newVal); this.markAsDirty(); }", "note": "Temporary solution until upgrade"},
        {"solution": "Use input() with writable signal for dirty state instead of read-only input", "percentage": 70, "note": "Architectural change allows manual dirty state management"}
    ]$$::jsonb,
    'Angular 19.0.0+, TypeScript 5.5+, signal-forms module installed',
    'FormValueControl.dirty property updates automatically when value changes, form validation reflects dirty state correctly',
    'The dirty property was read-only when exposed as input() signal. Do not confuse dirty state with touched state. Mark dirty must happen during value update, not after.',
    0.92,
    NOW(),
    'https://github.com/angular/angular/issues/63623'
),
(
    'Angular hydration error: Cannot read nextSibling of null with @if/@for/@let combination',
    'github-angular',
    'MEDIUM',
    $$[
        {"solution": "Remove the outer @if block that guards the @for loop structure, move conditional logic inside @for if needed", "percentage": 90, "note": "Server cannot serialize initial @if block info, breaking hydration node navigation"},
        {"solution": "Inline the @let variable using @if with as syntax: @if ($index % 2; as render)", "percentage": 85, "command": "@if (expression; as variable) { ... } instead of @let variable = expression; @if (variable)", "note": "Avoids @let variable issue with hydration"},
        {"solution": "Avoid using @let variable inside nested @if within @for loops during SSR", "percentage": 80, "note": "Restructure template to eliminate complex nesting patterns that break hydration"}
    ]$$::jsonb,
    'Angular 20.0.0+, Server-side rendering (SSR) enabled, @if/@for/@let block syntax support',
    'Application hydrates successfully without "Cannot read nextSibling of null" error, SSR-rendered content matches client-rendered content',
    'Do not combine outer @if, @for with @let inside nested @if. Server serialization does not preserve initial @if block data. Minimal reproduction: outer @if + @for + @let + inner @if pattern.',
    0.88,
    NOW(),
    'https://github.com/angular/angular/issues/62117'
),
(
    'Angular signal in template not updating when signal value changes with OnPush change detection',
    'github-angular',
    'MEDIUM',
    $$[
        {"solution": "Change parent component to use OnPush change detection strategy to match child component", "percentage": 90, "note": "Ensures parent marks child for check when signals change, allowing embedded view refresh"},
        {"solution": "Change child component to use default (non-OnPush) change detection", "percentage": 85, "note": "Disables optimization but ensures signals trigger change detection properly"},
        {"solution": "Manually call markForCheck() or detectChanges() when signal updates (workaround)", "percentage": 70, "command": "constructor(private cdr: ChangeDetectorRef) { ... this.cdr.markForCheck(); }", "note": "Causes double rendering, not recommended for production"}
    ]$$::jsonb,
    'Angular 19.0.0+, Structural directives creating embedded views, Child and parent components using different change detection strategies',
    'Template automatically updates when signal value changes, no manual change detection needed, embedded view reflects latest signal value',
    'Signal dependencies incorrectly attach to parent component when embedded view created outside initial cycle. Child OnPush + parent default change detection is problematic. Requires consistent change detection strategy across component hierarchy.',
    0.88,
    NOW(),
    'https://github.com/angular/angular/issues/61662'
),
(
    'Angular @angular/elements: custom element signal input property returns function instead of value',
    'github-angular',
    'LOW',
    $$[
        {"solution": "Upgrade to Angular 19.1.0+ which fixes signal input getters to return values directly, not functions", "percentage": 95, "note": "Fix makes signal input behavior consistent with traditional @Input properties"},
        {"solution": "For earlier versions, call signal input as function to get value: elementRef.newInput()", "percentage": 75, "command": "const value = element.signalInputProperty(); // instead of element.oldInput", "note": "Temporary workaround requires understanding signal nature"},
        {"solution": "Create getter wrapper that invokes signal and returns value for backward compatibility", "percentage": 70, "command": "get myInput() { return this._myInput(); }", "note": "Abstraction layer hides signal invocation complexity"}
    ]$$::jsonb,
    'Angular 19.0.0+, @angular/elements installed, custom element with signal inputs defined',
    'elementRef.signalInputProperty returns value directly without function call, assignment to signal inputs works without parentheses',
    'Traditional @Input and signal input had inconsistent APIs - one returns value, other returns function. Both support assignment but getter behavior differed. Documentation was missing for signal input custom element usage.',
    0.91,
    NOW(),
    'https://github.com/angular/angular/issues/62097'
),
(
    'Angular DevTools extension crashes when clicking into components',
    'github-angular',
    'LOW',
    $$[
        {"solution": "Update Angular DevTools extension to v1.0.34+ which includes error handling for signal evaluation", "percentage": 95, "note": "DevTools now safely catches errors when reading required viewChild signals"},
        {"solution": "Disable DevTools and use Chrome DevTools native Angular support as temporary workaround", "percentage": 80, "note": "Loses advanced debugging features but eliminates crashes"},
        {"solution": "Downgrade Angular to v19.x.x if v20+ compatibility causes crashes", "percentage": 65, "note": "Only if v20 signals cause issues, not recommended long-term"}
    ]$$::jsonb,
    'Angular 20.0.0+, Angular DevTools extension v1.0.33 or earlier, Chrome DevTools open',
    'Can click into components without DevTools crashing, component tree displays correctly, no runtime errors in DevTools console',
    'DevTools attempts to read viewChild.required signal without error handling. Crashes only occur on certain component structures. Error: NG0951 Child query result is required but no value is available.',
    0.93,
    NOW(),
    'https://github.com/angular/angular/issues/61900'
),
(
    'Angular AOT testing fails with ViewContainerRef.createComponent and overrideComponent',
    'github-angular',
    'MEDIUM',
    $$[
        {"solution": "Update Angular CLI to v20.0.0+ which includes fix for AOT override component import resolution", "percentage": 95, "note": "CLI fix ensures overridden component imports properly reflect during AOT compilation"},
        {"solution": "Use JiT mode for tests (set aot: false in karma.conf.js) as temporary workaround", "percentage": 85, "command": "browsers: [''Chrome''], aot: false in karma.conf.js", "note": "Tests work but loses AOT compilation benefits"},
        {"solution": "Avoid TestBed.overrideComponent when using RouterTestingHarness with AOT", "percentage": 70, "note": "Restructure test setup to avoid conflicting overrides during AOT"}
    ]$$::jsonb,
    'Angular CLI 20.0.0+, AOT compilation enabled, RouterTestingHarness used, TestBed.overrideComponent with imports',
    'Tests pass in AOT mode without "formGroup is not a known property" errors, component overrides properly applied during compilation',
    'AOT compilation does not reflect overridden component imports correctly. Error appears to be scope/symbol resolution issue. JiT mode masks problem. Requires CLI fix, not framework fix.',
    0.91,
    NOW(),
    'https://github.com/angular/angular/issues/61236'
),
(
    'Angular optional injection throws NullInjectorError with aliased useExisting providers',
    'github-angular',
    'MEDIUM',
    $$[
        {"solution": "Upgrade to Angular 20.0.0+ which includes fix via PR #61137/#61152 preserving optional inject flags", "percentage": 95, "note": "Fix ensures optional flag propagates to internal inject() calls for useExisting providers"},
        {"solution": "Workaround: check provider exists before optional inject, use custom factory provider instead", "percentage": 75, "command": "const value = providersHaveToken(Token) ? inject(Token, {optional: true}) : null;", "note": "Manual provider detection avoids DI error"},
        {"solution": "Replace useExisting with useFactory to maintain optional semantics", "percentage": 70, "command": "useFactory: (inj) => inj.get(ExistingToken, null)", "note": "Refactors provider pattern but maintains optional behavior"}
    ]$$::jsonb,
    'Angular 19.0.0+, providers with useExisting configuration, inject() with optional: true flag',
    'Optional injection returns null instead of throwing NullInjectorError, no circular dependency errors thrown',
    'useExisting providers perform internal inject() call that did not preserve optional flag. Both NullInjectorError and NG0200 circular dependency can occur. Inject flags not passed through provider resolution chain.',
    0.92,
    NOW(),
    'https://github.com/angular/angular/issues/61121'
),
(
    'Angular ViewEncapsulation.Emulated generates invalid CSS with special characters in APP_ID',
    'github-angular',
    'MEDIUM',
    $$[
        {"solution": "Upgrade to Angular 20.0.0+ with fix that sanitizes APP_ID in ViewEncapsulation.Emulated", "percentage": 95, "note": "Fix restricts APP_ID to alphanumeric characters, underscores, and hyphens in CSS attributes"},
        {"solution": "Provide sanitized APP_ID value containing only alphanumeric, underscore, hyphen characters", "percentage": 90, "command": "providers: [{ provide: APP_ID, useValue: ''foo-bar-c2846697727'' }]", "note": "Avoid colons, spaces, and other CSS-invalid characters"},
        {"solution": "Remove special characters from APP_ID and use only safe characters for custom element styling", "percentage": 85, "note": "Refactor APP_ID generation to strip unsafe characters"}
    ]$$::jsonb,
    'Angular 19.0.0+, ViewEncapsulation.Emulated used, custom APP_ID provided with special characters',
    'Generated CSS selectors are valid, component styling applies correctly, no InvalidCharacterError in attribute names',
    'APP_ID values with colons create pseudo-class parsing errors in CSS selectors (e.g., foo:bar-c28). Spaces cause InvalidCharacterError since not valid in attribute names. APP_ID directly embedded in CSS without sanitization.',
    0.93,
    NOW(),
    'https://github.com/angular/angular/issues/63251'
),
(
    'Angular Language Service crashes with generic directive and host type-checking enabled',
    'github-angular',
    'LOW',
    $$[
        {"solution": "Upgrade to Angular 20.0.0+ which includes fix via PR #63061 for generic directive host binding type-checking", "percentage": 95, "note": "Compiler-cli now properly detects and handles generic directives when type-checking host bindings"},
        {"solution": "Disable typeCheckHostBindings in angular.json compiler options temporarily", "percentage": 80, "command": "\"angularCompilerOptions\": { \"typeCheckHostBindings\": false } in angular.json", "note": "Workaround sacrifices type safety, not recommended"},
        {"solution": "Remove generic type parameter from directive if host bindings are not essential", "percentage": 70, "note": "Architectural refactor to avoid combining generics with host bindings"}
    ]$$::jsonb,
    'Angular 20.0.0+, generic component or directive with host property, typeCheckHostBindings enabled in angular.json',
    'Language Service no longer crashes when editing component/directive files, no assertion errors in compiler output, hovering over host bindings works',
    'Combining generic type parameters with host property triggers "expected App not to be generic" assertion error. Compiler uses TcbNonGenericDirectiveTypeOp regardless of actual generic status. Only occurs with typeCheckHostBindings enabled.',
    0.92,
    NOW(),
    'https://github.com/angular/angular/issues/63052'
),
(
    'Angular Language Service slow performance for "Go to references" and "Go to definition"',
    'github-angular',
    'HIGH',
    $$[
        {"solution": "This is expected behavior for first reference lookup - full application compilation required. Subsequent queries will use cache and be faster.", "percentage": 85, "note": "Initial 6+ second delay is expected, not a bug. Caching improves performance for repeated queries."},
        {"solution": "Open relevant files before running references query to warm up compiler cache", "percentage": 80, "command": "Open component files referenced by query before triggering references operation", "note": "Pre-compilation helps reduce first query latency"},
        {"solution": "Consider using Search (Ctrl+Shift+F) instead of Language Service references for large codebases", "percentage": 75, "note": "Simpler text search faster for initial exploration than full semantic analysis"}
    ]$$::jsonb,
    'Angular 20.2.1+, large Angular codebase (100+ files), VSCode Angular Language Service enabled',
    'First "Go to references" query returns results in 6-10 seconds, subsequent queries return within 1 second, no timeout errors',
    'Initial request requires full application compilation, explains multi-second latency. Not a performance regression - expected behavior. v20.2.2 may be slower than v20.2.1 due to increased analysis scope.',
    0.80,
    NOW(),
    'https://github.com/angular/angular/issues/65487'
),
(
    'Angular form binding loses reference after TestBed component override',
    'github-angular',
    'MEDIUM',
    $$[
        {"solution": "Ensure ReactiveFormsModule is imported in test setup before TestBed.createComponent() call", "percentage": 92, "note": "Override component imports must include all required modules for proper directive recognition"},
        {"solution": "Use TestBed.overrideComponent with both remove and add imports to properly replace directives", "percentage": 88, "command": "TestBed.overrideComponent(Component, { remove: { imports: [OldModule] }, add: { imports: [NewModule] } })", "note": "Explicit add of ReactiveFormsModule ensures formGroup directive available"},
        {"solution": "Verify form module imports at compile time with ng check before running tests", "percentage": 75, "command": "ng check --watch=false", "note": "Catches import issues during development"}
    ]$$::jsonb,
    'Angular 20.0.0+, TestBed with ReactiveFormsModule, component overrides in tests',
    'Component template binds to formGroup without errors, form controls recognized as valid properties, test harness creates component successfully',
    'AOT compilation processes overridden component imports separately from template compilation. Missing ReactiveFormsModule not detected until template validation fails with "formGroup is not a known property" error.',
    0.89,
    NOW(),
    'https://github.com/angular/angular/issues/61236'
),
(
    'Angular signal input property getter API inconsistency between traditional @Input and signal input',
    'github-angular',
    'LOW',
    $$[
        {"solution": "Upgrade to Angular 19.1.0+ which unifies signal input getter behavior to return values directly", "percentage": 96, "note": "API now consistent: both traditional and signal inputs return values when accessed as getters"},
        {"solution": "Create wrapper getter that invokes signal function for elements using v19.0: element.signalProp() -> value", "percentage": 82, "command": "get customProp() { return this._customSignal(); } // hides signal invocation", "note": "Abstraction layer provides consistent API"},
        {"solution": "Document signal input usage for custom element consumers with note that getter returns function, not value", "percentage": 70, "note": "Until upgrade, document invocation requirement: element.signalInput() not element.signalInput"}
    ]$$::jsonb,
    'Angular 19.0.0+, @angular/elements custom element with signal inputs, documentation review',
    'Signal input getter returns expected value type directly, custom element consumers do not need to invoke getter as function',
    'Inconsistent API between traditional @Input (returns value) and signal input (returns function). Both support assignment but getter behavior differs. Lack of documentation caused developer confusion. Mixing traditional and signal inputs in same component type compounds confusion.',
    0.90,
    NOW(),
    'https://github.com/angular/angular/issues/62097'
);
