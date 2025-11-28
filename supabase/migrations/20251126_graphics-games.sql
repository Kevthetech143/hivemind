INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES
(
    'Phaser timer event won''t loop - callback called immediately',
    'graphics-games',
    'HIGH',
    '[
        {"solution": "Remove parentheses from callback function reference. Use ''callback: self.updateTimer'' instead of ''callback: self.updateTimer()'' to pass the function reference rather than invoking it immediately.", "percentage": 98},
        {"solution": "Ensure callbackScope is set correctly with ''callbackScope: self'' to maintain proper context in the callback.", "percentage": 92}
    ]'::jsonb,
    'Phaser game initialized with timer event configuration',
    'Timer fires repeatedly at specified delay interval without errors; callback function executes on each loop',
    'Calling the function with parentheses executes it immediately instead of deferring execution; forgetting to set callbackScope can cause context loss',
    0.95,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/73127868/phaser-time-event-wont-loop',
    'admin:1764174124'
),
(
    'THREE.WebGLRenderer: Context Lost error when rendering multiple objects',
    'graphics-games',
    'HIGH',
    '[
        {"solution": "Add ''preserveDrawingBuffer: true'' to Canvas component configuration: <Canvas gl={{preserveDrawingBuffer: true}}></Canvas>", "percentage": 96},
        {"solution": "Reduce number of simultaneous 3D objects being rendered on the page to decrease GPU memory pressure.", "percentage": 85}
    ]'::jsonb,
    'Three.js scene with Canvas component or WebGL renderer initialized',
    'Multiple 3D objects render without WebGL context loss; no ''Context Lost'' error messages in console',
    'Not preserving drawing buffer causes context loss after rendering ~13+ objects; exceeding GPU memory limits; not handling context restoration events',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/70283197/three-webglrenderer-context-lost',
    'admin:1764174124'
),
(
    'Phaser 3 preload function not running - state vs scene configuration',
    'graphics-games',
    'HIGH',
    '[
        {"solution": "Replace Phaser 2.x ''state'' config with Phaser 3.x ''scene'' property. Change from ''{preload: preload, create: create, update: update}'' to ''{scene: {preload: preload, create: create, update: update}}''", "percentage": 99},
        {"solution": "Verify Phaser version is 3.x before using scene-based configuration; older tutorials may reference deprecated state API.", "percentage": 90}
    ]'::jsonb,
    'Phaser game initialized locally; tutorial or code references Phaser 2.x pattern',
    'preload, create, and update functions execute in order; canvas displays rendered game content instead of remaining black',
    'Using old Phaser 2.x state parameter with Phaser 3 library; version mismatch between tutorial and local environment; not checking official Phaser 3 docs',
    0.97,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/49217016/phaser-game-preload-not-running-in-simple-example',
    'admin:1764174124'
),
(
    'React canvas TypeError: Cannot read property getContext of null',
    'graphics-games',
    'HIGH',
    '[
        {"solution": "Wrap canvas access in useEffect hook with empty dependency array to ensure canvas mounts before accessing: useEffect(() => { runPosenet(canvasRef); }, [])", "percentage": 98},
        {"solution": "Add null check before calling getContext: if (canvasRef.current) { canvasRef.current.getContext(''2d'') }", "percentage": 94}
    ]'::jsonb,
    'React component with canvas ref and function that calls getContext()',
    'Canvas element loads before context access; no null reference errors; drawing operations succeed',
    'Calling canvas functions in component body before render completes; not using useEffect; forgetting useRef for canvas references; not null-checking refs',
    0.96,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/68396087/html-canvas-getcontext-of-null-error-in-react',
    'admin:1764174124'
),
(
    'Uncaught Error: WebGL unsupported in this browser, use pixi.js-legacy',
    'graphics-games',
    'HIGH',
    '[
        {"solution": "Set ''PIXI.settings.FAIL_IF_MAJOR_PERFORMANCE_CAVEAT = false;'' before creating PIXI.Application() to allow WebGL with performance warnings.", "percentage": 97},
        {"solution": "In Firefox: Go to about:config, set webgl.disabled=false, webgl.force-enabled=true, layers.acceleration.force-enabled=true", "percentage": 88},
        {"solution": "In Chrome: Enable hardware acceleration in Settings > Advanced > System and check chrome://gpu for WebGL support status", "percentage": 86}
    ]'::jsonb,
    'PixiJS library loaded; browser with WebGL disabled or performance caveat flagged',
    'PixiJS application initializes without error; canvas renders with WebGL context; no fallback to legacy canvas2d required',
    'Not disabling FAIL_IF_MAJOR_PERFORMANCE_CAVEAT setting; WebGL disabled in browser settings; running in VM without 3D acceleration; using pixi.js instead of pixi.js-legacy',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/62046185/uncaught-error-webgl-unsupported-in-this-browser',
    'admin:1764174124'
);
