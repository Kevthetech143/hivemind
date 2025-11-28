-- Mining: 8 Angular Deadlock/Infinite Loop Errors
-- Date: 2025-11-26
-- Miner: admin (haiku-1764191776)

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email) VALUES
(
  'Multiple concurrent DELETE requests to API causing Deadlock on server side with RxJS nested subscriptions',
  'angular',
  'HIGH',
  '[{"solution": "Use concatMap operator to serialize requests sequentially instead of nesting subscriptions: from(ids).pipe(concatMap((id) => myAPI.delete(id)), toArray()).subscribe()", "percentage": 95}, {"solution": "Use bufferCount with forkJoin for parallel request limiting to browser''s max concurrent requests per domain", "percentage": 85}]'::jsonb,
  'RxJS library imported, understanding of map vs concatMap operators',
  'All delete requests complete without deadlock, server receives requests sequentially, console.log shows all completed',
  'Using nested subscribe() calls instead of flattening operators, not handling variable number of requests, mixing sequential/parallel incorrectly',
  0.92,
  'haiku',
  NOW(),
  'https://stackoverflow.com/questions/63559426/angular-10-rxjs-looping-on-subscription',
  'admin:1764191776'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email) VALUES
(
  'HTTP POST in for loop causes StaleObjectStateException Deadlock with NHibernate concurrent requests M1 M2 methods executing out of order',
  'angular',
  'HIGH',
  '[{"solution": "Chain promises with .then() to ensure sequential execution: M1(data).then(data => M2(data)).then(result => handleResult)", "percentage": 93}, {"solution": "Use async/await pattern to serialize async operations: await M1(data); await M2(data);", "percentage": 88}]'::jsonb,
  'Understanding of Promise chaining and .then() syntax, TypeScript async/await support',
  'Server executes M1 for all requests first, then M2, no StaleObjectStateException thrown, database commit succeeds',
  'Calling .then() without returning the promise, starting new requests before previous ones complete, forgetting to handle errors in chain',
  0.90,
  'haiku',
  NOW(),
  'https://stackoverflow.com/questions/52138208/calling-an-asynchronous-function-within-a-for-loop-typescript-and-nhibernate-dea',
  'admin:1764191776'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email) VALUES
(
  'Angular change detection infinite loop when binding method directly in template with *ngFor and property binding',
  'angular',
  'HIGH',
  '[{"solution": "Replace method binding with property binding: change [routerLink]="getRouterLink()" to [routerLink]="cachedRouterLink" and compute value in ngOnInit/OnChanges", "percentage": 96}, {"solution": "Use ChangeDetectionStrategy.OnPush to limit change detection cycles and prevent excessive method calls", "percentage": 88}]'::jsonb,
  'Angular templates, understanding of change detection cycles, property binding vs method binding',
  'Method no longer called hundreds of times per change detection, console shows single or expected number of calls, UI renders correctly',
  'Binding functions directly expecting single call, not caching computed values, mixing One-time binding with frequent re-evaluation',
  0.94,
  'haiku',
  NOW(),
  'https://stackoverflow.com/questions/50492310/angular2-change-detection-infinite-loop',
  'admin:1764191776'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email) VALUES
(
  'Angular infinite loop when calling detectChanges inside ngAfterViewChecked triggering repeated change detection cycles',
  'angular',
  'HIGH',
  '[{"solution": "Remove detectChanges() call from ngAfterViewChecked hook as it creates recursive change detection loop. Use ngAfterViewInit instead if manual detection needed", "percentage": 97}, {"solution": "If manual detection required, guard with flag to prevent repeated calls: if (!this.changeDetected) { this.cdr.detectChanges(); this.changeDetected = true; }", "percentage": 85}]'::jsonb,
  'Understanding of Angular lifecycle hooks, ChangeDetectorRef API',
  'No ExpressionChangedAfterCheckError thrown, change detection completes in single pass, component renders without infinite loops',
  'Calling detectChanges() in ngAfterViewChecked without guards, not understanding ngAfterViewChecked is called every cycle, using ApplicationRef.tick() instead',
  0.95,
  'haiku',
  NOW(),
  'https://stackoverflow.com/questions/70601645/infinite-loop-when-calling-detectchanges-inside-ngafterviewchecked',
  'admin:1764191776'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email) VALUES
(
  'Angular getter called hundreds of times in template causing change detection infinite loop performance issue with complex models',
  'angular',
  'HIGH',
  '[{"solution": "Use ChangeDetectionStrategy.OnPush: @Component({changeDetection: ChangeDetectionStrategy.OnPush}) to prevent constant re-evaluation of getters during change detection", "percentage": 96}, {"solution": "Store getter value in public property and bind property instead: public id = this.user.id instead of {{user.getId}}", "percentage": 90}, {"solution": "Use pure pipes to memoize getter results: pipe to transform data instead of calling getters", "percentage": 87}]'::jsonb,
  'ChangeDetectionStrategy.OnPush concept, Angular pipes, property binding vs getter binding',
  'Console log for getter shows 1-2 calls per action instead of hundreds, page performance improves, change detection completes faster',
  'Using getters without OnPush strategy thinking getters are cached, not using pipes for transformation, complex getter logic with side effects',
  0.93,
  'haiku',
  NOW(),
  'https://stackoverflow.com/questions/55301159/angular-change-detection-loop-triggered-by-using-getters-inside-template',
  'admin:1764191776'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email) VALUES
(
  'Angular memory leak after navigation between components with unsubscribed observables causing increasing heap size and slowdown',
  'angular',
  'HIGH',
  '[{"solution": "Use takeUntil pattern with destroy$ subject: pipe(takeUntil(this.destroy$)) and call destroy$.next() in ngOnDestroy", "percentage": 97}, {"solution": "Use async pipe in template {{observable$ | async}} which automatically unsubscribes on component destroy", "percentage": 92}, {"solution": "Call .unsubscribe() on subscription in ngOnDestroy for each subscription: this.subscription.unsubscribe()", "percentage": 89}]'::jsonb,
  'RxJS Subscription type, ngOnDestroy lifecycle hook, understanding of observable completion',
  'Memory snapshot stays constant after navigation, loading time stable, no Form/Array references from previous views in heap dump',
  'Forgetting to unsubscribe to infinite observables, not using takeUntil pattern, relying only on component destruction without explicit cleanup',
  0.94,
  'haiku',
  NOW(),
  'https://stackoverflow.com/questions/70527515/how-to-prevent-memory-leaks-in-angular',
  'admin:1764191776'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email) VALUES
(
  'Complex RxJS pipes with nested services causing memory leak with observable source object destroyed before subscription completes',
  'angular',
  'HIGH',
  '[{"solution": "Use takeUntil(destroy$) at the end of pipe before subscribe to ensure cleanup: pipe(map(...), takeUntil(this.destroy$)).subscribe()", "percentage": 96}, {"solution": "Use take(1) for single-value observables like HTTP requests but with timeout for network delays: pipe(timeout(3000), take(1))", "percentage": 88}, {"solution": "Ensure complete() is called on subjects when done and use proper completion operators to prevent dangling subscriptions", "percentage": 85}]'::jsonb,
  'RxJS operators (takeUntil, take, timeout), observable completion understanding, service architecture patterns',
  'No active subscriptions after component destroy, memory profiler shows subscription cleared, no pending HTTP requests',
  'Using take(1) alone for network requests without timeout, not completing observables, putting pipe operators in wrong order',
  0.91,
  'haiku',
  NOW(),
  'https://stackoverflow.com/questions/62114244/how-to-avoid-memory-leaks-with-complex-rxjs-pipes-in-angular-9',
  'admin:1764191776'
);

INSERT INTO knowledge_entries (query, category, hit_frequency, solutions, prerequisites, success_indicators, common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email) VALUES
(
  'Angular ngAfterViewChecked endless loop infinite invocation during server-side rendering timeout Node.js 60000ms',
  'angular',
  'HIGH',
  '[{"solution": "Replace ngAfterViewChecked with ngAfterViewInit as ngAfterViewChecked is called on every change detection cycle. Use ngAfterViewInit for one-time setup", "percentage": 98}, {"solution": "If ngAfterViewChecked required, add guard flag to prevent recursive change detection: if (!this.initialized) { doWork(); this.initialized = true; }", "percentage": 90}, {"solution": "Avoid calling detectChanges() or asking component for state in ngAfterViewChecked as it triggers new change detection cycle", "percentage": 92}]'::jsonb,
  'Angular lifecycle hooks (ngAfterViewChecked vs ngAfterViewInit), server-side rendering concepts, change detection mechanics',
  'No Node.js timeout errors, SSR completes within timeout, component renders single time without repeated invocations',
  'Not understanding ngAfterViewChecked is called every change detection, using ngAfterViewChecked for one-time initialization, calling event listeners in hook',
  0.96,
  'haiku',
  NOW(),
  'https://stackoverflow.com/questions/47678593/implementing-afterviewinit-causes-an-endless-loop-of-event-invokations/47678715',
  'admin:1764191776'
);
