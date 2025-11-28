INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Angular Migration - Migrate AngularJS to Angular with hybrid mode, component conversion, and routing updates',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Set up hybrid AngularJS/Angular app with ngUpgrade",
      "cli": {
        "macos": "npm install @angular/upgrade @angular/core @angular/platform-browser-dynamic",
        "linux": "npm install @angular/upgrade @angular/core @angular/platform-browser-dynamic",
        "windows": "npm install @angular/upgrade @angular/core @angular/platform-browser-dynamic"
      },
      "manual": "Create AppModule with UpgradeModule import. In main.ts, bootstrap Angular module, then call upgrade.bootstrap() for AngularJS with strictDi: true. Implement ngDoBootstrap() with no content (bootstrapped manually). This allows both AngularJS and Angular running side-by-side.",
      "note": "ngUpgrade.bootstrap must be called AFTER Angular bootstrap. strictDi: true prevents implicit annotations"
    },
    {
      "solution": "Migrate AngularJS controllers to Angular components",
      "manual": "Convert $scope properties to @Input/@Output properties. Replace $scope.$watch with ngOnInit/ngOnChanges. Convert promises to Observables. Extract inline template to @Component template string. Move controller logic into component methods. Example: $scope.user becomes user: any; property.",
      "note": "Components are simpler than controllers - no $scope manipulation needed. Use dependency injection via constructor parameters"
    },
    {
      "solution": "Convert AngularJS directives to Angular components",
      "manual": "AngularJS restrict:E directives map directly to Angular components. Convert scope bindings: ''='' becomes @Input, ''&'' becomes @Output EventEmitter. Replace directive template with @Component template. Convert link/controller logic to component class methods. Use property binding [user] and event binding (delete)=''handleDelete()''",
      "note": "Most AngularJS directives can become simple Angular components. This is the core of incremental migration"
    },
    {
      "solution": "Migrate AngularJS services to Angular services",
      "cli": {
        "macos": "npm install rxjs",
        "linux": "npm install rxjs",
        "windows": "npm install rxjs"
      },
      "manual": "Convert $http.get() to HttpClient.get() returning Observable. Replace factory return object with @Injectable class with providedIn: ''root''. Convert promise chains (.then) to observable subscriptions (.subscribe). Use typed responses with interfaces. Services become cleaner with proper dependency injection.",
      "note": "Replace $http with HttpClient from @angular/common/http. Always use providedIn: ''root'' for tree-shaking"
    },
    {
      "solution": "Enable AngularJS services in Angular via downgradeInjectable",
      "cli": {
        "macos": "import { downgradeInjectable } from ''@angular/upgrade/static''",
        "linux": "import { downgradeInjectable } from ''@angular/upgrade/static''",
        "windows": "import { downgradeInjectable } from ''@angular/upgrade/static''"
      },
      "manual": "Wrap Angular service with downgradeInjectable(): angular.module(''myApp'').factory(''serviceName'', downgradeInjectable(AngularService)). Now AngularJS code can inject this service. Use when Angular components exist but AngularJS components need access.",
      "note": "downgradeInjectable bridges Angular services into AngularJS DI. Opposite is upgradeInjectable for AngularJS services"
    },
    {
      "solution": "Use AngularJS services in Angular via upgradeInjectable",
      "manual": "Create InjectionToken for the AngularJS service. Provide it in module using useFactory: (i: any) => i.get(''serviceName''), deps: [''$injector'']. Inject with @Inject(TOKEN) in Angular components. This bridges AngularJS services to Angular code during hybrid phase.",
      "note": "This allows Angular components to use legacy AngularJS services. Remove once service is migrated to Angular"
    },
    {
      "solution": "Migrate AngularJS routing to Angular Router",
      "manual": "Convert $routeProvider.when() to Routes array with path and component properties. Create AppRoutingModule with RouterModule.forRoot(routes). Replace ng-view with <router-outlet>. Convert route parameters: :id becomes :id in Angular too. Implement resolve guards for data loading.",
      "note": "Angular Router uses a different paradigm but route definition is straightforward. Always use lazy loading for feature modules"
    },
    {
      "solution": "Execute phased migration: services → components → remove ngUpgrade",
      "manual": "Phase 1 (1-2 weeks): Setup hybrid app, configure build. Phase 2 (2-4 weeks): Migrate services and routing. Phase 3 (varies): Feature-by-feature component migration. Phase 4 (1-2 weeks): Remove AngularJS, remove ngUpgrade, optimize bundle. Test thoroughly at each phase. Deploy incrementally.",
      "note": "Feature-by-feature migration reduces risk. Keep AngularJS running during development to support existing features. Only remove when fully migrated"
    }
  ]'::jsonb,
  'steps',
  'AngularJS 1.x app, Node.js/npm, TypeScript knowledge, understanding of Observables',
  'Migrating UI before services, improper hybrid bootstrap (ngUpgrade order), not handling change detection differences, mixing AngularJS and Angular patterns, ignoring scope vs component property differences, big-bang migration approach',
  'Hybrid app runs with both AngularJS and Angular components, migrated services work in both frameworks, routing functions across framework boundary, incremental migration allows continuous deployment',
  'AngularJS to Angular migration using hybrid mode, component conversion, service refactoring, and incremental deployment strategy',
  'https://skillsmp.com/skills/wshobson-agents-plugins-framework-migration-skills-angular-migration-skill-md',
  'admin:HAIKU_SKILL_1764289744_99578'
);
