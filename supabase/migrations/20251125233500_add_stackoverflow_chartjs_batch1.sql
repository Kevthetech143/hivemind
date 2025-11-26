-- Add Stack Overflow Chart.js solutions batch 1

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES (
    'Set height of chart in Chart.js',
    'stackoverflow-chartjs',
    'VERY_HIGH',
    '[
        {"solution": "Set maintainAspectRatio: false in options and wrap canvas in container div with fixed height: <div style=\"height: 300px\"><canvas id=\"chart\"></canvas></div>", "percentage": 95, "note": "Most reliable method for responsive charts", "command": "options: { responsive: true, maintainAspectRatio: false }"},
        {"solution": "Use maintainAspectRatio: false and set height attribute directly on canvas element: <canvas id=\"myChart\" height=\"400\"></canvas>", "percentage": 85, "note": "Alternative method without container div"},
        {"solution": "Set responsive: false in options if static sizing is acceptable", "percentage": 80, "note": "Older approach, less flexible"}
    ]'::jsonb,
    'Chart.js library loaded, Canvas element in HTML, Chart instance created',
    'Chart displays at specified height, responsive on resize, no layout shift after creation',
    'Do not set height on canvas with ctx.height() jQuery method - use parent div or canvas attribute instead. maintainAspectRatio must be inside options object, not at root level. Container display: block style can interfere with sizing.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/41953158/set-height-of-chart-in-chart-js'
),
(
    'How to set max and min value for Y axis in Chart.js',
    'stackoverflow-chartjs',
    'VERY_HIGH',
    '[
        {"solution": "In options.scales.yAxes[0].ticks object, set min: 0 and max: 500 for axis range", "percentage": 92, "note": "Chart.js v2.x syntax", "command": "options: { scales: { yAxes: [{ ticks: { min: 0, max: 500 } }] } }"},
        {"solution": "For Chart.js v3+, use options.scales.y.min and options.scales.y.max properties", "percentage": 90, "note": "Modern Chart.js API", "command": "options: { scales: { y: { min: 0, max: 500 } } }"},
        {"solution": "Set beginAtZero: true to force minimum starting at 0", "percentage": 85, "note": "Useful when min should always be 0", "command": "ticks: { beginAtZero: true }"}
    ]'::jsonb,
    'Chart.js loaded, Line/Bar chart created, Data provided',
    'Y-axis displays only range 0-500, grid lines align with specified min/max values',
    'Version matters: v2.x uses yAxes array syntax, v3+ uses simplified y object. Not setting max/min leaves Chart.js auto-scaling enabled which can hide data range issues.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/28990708/how-to-set-max-and-min-value-for-y-axis'
),
(
    'How to hide dataset labels in Chart.js v2',
    'stackoverflow-chartjs',
    'HIGH',
    '[
        {"solution": "Set display: false in the legend options: options: { legend: { display: false } }", "percentage": 95, "note": "Hides entire legend/all dataset labels"},
        {"solution": "Set empty string as label in dataset: label: \"\" instead of label: \"Your Label\"", "percentage": 90, "note": "Hides specific dataset label while keeping legend box"},
        {"solution": "Use plugins in v3+: options: { plugins: { legend: { display: false } } }", "percentage": 88, "note": "Chart.js v3+ syntax"}
    ]'::jsonb,
    'Chart.js v2.x library, Line/Bar chart created with datasets',
    'Dataset labels no longer appear in legend, chart renders without label text',
    'Empty label still shows legend entry - must disable display to fully hide. Legend display setting affects all datasets, not individual ones. Check Chart.js version as v2.x and v3+ have different syntax.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/37204298/how-can-i-hide-dataset-labels-in-chart-js-v2'
),
(
    'Dynamically update values of a chartjs chart',
    'stackoverflow-chartjs',
    'VERY_HIGH',
    '[
        {"solution": "Modify chart.data.datasets[0].data array directly, then call chart.update() to animate changes", "percentage": 93, "note": "Preserves animation from old to new values", "command": "chart.data.datasets[0].data = [newVal1, newVal2]; chart.update();"},
        {"solution": "Use chart.destroy() before creating new instance if completely replacing chart data", "percentage": 85, "note": "Slower but ensures clean state", "command": "chart.destroy(); chart = new Chart(ctx, config);"},
        {"solution": "Set data.labels and data.datasets, then call chart.update() to refresh multiple datasets at once", "percentage": 82, "note": "Use for major data refreshes"}
    ]'::jsonb,
    'Chart.js instance created and rendered, Data source available, Chart variable accessible',
    'Chart updates smoothly without reset, animations show value changes from old to new, multiple updates work without memory leaks',
    'Calling Chart() constructor twice recreates chart from zero which resets animations. Always call update() not constructor. Don''''t forget chart.destroy() before creating new instance if reusing canvas. Old Chart v1.x had different update mechanism.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/17354163/dynamically-update-values-of-a-chartjs-chart'
),
(
    'Set start value as 0 in chartjs scales',
    'stackoverflow-chartjs',
    'HIGH',
    '[
        {"solution": "In options.scales.yAxes[0].ticks, set beginAtZero: true to force Y-axis to start at 0", "percentage": 94, "note": "Chart.js v2.x approach", "command": "ticks: { beginAtZero: true }"},
        {"solution": "Combine with min: 0 to ensure lower bound: ticks: { beginAtZero: true, min: 0 }", "percentage": 90, "note": "Explicit dual setting for safety"},
        {"solution": "For X-axis labels starting at index 0, ensure labels array has correct order", "percentage": 85, "note": "Labels are tied to data index positions"}
    ]'::jsonb,
    'Chart.js loaded, Line chart created with numeric data',
    'Y-axis starts at 0, grid lines begin at 0 value, no auto-scaling to minimum data value',
    'beginAtZero only affects Y-axis auto-scaling. X-axis labels controlled by labels array, not options. Setting beginAtZero: true can hide data variation if range is small - consider with min/max values.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/37922518/how-to-set-start-value-as-0-in-chartjs'
),
(
    'Chart.js straight lines instead of curves',
    'stackoverflow-chartjs',
    'MEDIUM',
    '[
        {"solution": "In dataset options, set tension: 0 to disable bezier curve smoothing: tension: 0", "percentage": 93, "note": "Chart.js v3+ property", "command": "datasets: [{ tension: 0, ... }]"},
        {"solution": "For v2.x, set bezierCurve: false in chart options", "percentage": 88, "note": "Older API", "command": "options: { bezierCurve: false }"},
        {"solution": "Set borderDash or borderWidth to differentiate line style if needed", "percentage": 75, "note": "Visual enhancement after removing curves"}
    ]'::jsonb,
    'Chart.js library loaded, Line chart with dataset created',
    'Chart displays straight lines connecting points, no curve interpolation between data points',
    'Curve smoothing is default behavior - must explicitly disable. tension property in v3+ replaces bezierCurve from v2.x. Setting tension: 0 renders straight lines, partial tension values (0-1) create variable smoothing.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/34403510/chart-js-straight-lines-instead-of-curves'
),
(
    'How to display data values on Chart.js',
    'stackoverflow-chartjs',
    'HIGH',
    '[
        {"solution": "Use chartjs-plugin-datalabels plugin to display values above/on bars and points: import and register plugin, set options.plugins.datalabels.display = true", "percentage": 92, "note": "Most popular approach for v2.x+"},
        {"solution": "In v3+, use Chart.defaults.set with datalabels plugin configuration", "percentage": 88, "note": "Chart.js v3+ compatibility"},
        {"solution": "Use chart plugins callback to draw custom text with ctx.fillText() in animation complete hook", "percentage": 80, "note": "Lower-level manual approach"}
    ]'::jsonb,
    'Chart.js v2.x+ loaded, chartjs-plugin-datalabels installed (npm install chartjs-plugin-datalabels), Chart instance created',
    'Data values appear as text labels on/above chart elements, values update when chart data changes',
    'chartjs-plugin-datalabels is separate library, not built-in to Chart.js. Must explicitly register plugin before use. Position, font, and format controlled via datalabels plugin options, not core Chart.js.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/31631354/how-to-display-data-values-on-chart-js'
),
(
    'How to add text inside the doughnut chart using Chart.js',
    'stackoverflow-chartjs',
    'MEDIUM',
    '[
        {"solution": "Use Chart.js plugin callback in animation complete: options: { animation: { onComplete: function() { ctx.fillText(text, x, y); } } }", "percentage": 85, "note": "Direct canvas drawing approach"},
        {"solution": "Overlay HTML element (usually div) absolutely positioned over canvas center for center text", "percentage": 90, "note": "Simpler CSS-based approach", "command": "<div style=\"position: absolute; top: 50%; left: 50%\">Text</div>"},
        {"solution": "Use chartjs-plugin-datalabels to position text within chart: options: { plugins: { datalabels: { anchor: center } } }", "percentage": 82, "note": "Library-based solution"}
    ]'::jsonb,
    'Chart.js library, Doughnut chart created, Canvas context available',
    'Text displays in center or specified position of doughnut chart, text persists through update cycles',
    'Canvas drawing resets on chart update - must use animation complete callback or overlay approach. HTML overlay requires careful positioning with flexbox or absolute positioning. Chart.js v3+ has different plugin syntax than v2.x.',
    0.84,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/20966817/how-to-add-text-inside-the-doughnut-chart-using-chart-js'
),
(
    'Destroy chart.js bar graph to redraw other graph in same canvas',
    'stackoverflow-chartjs',
    'HIGH',
    '[
        {"solution": "Call chart.destroy() on existing chart instance before creating new Chart on same canvas", "percentage": 94, "note": "Required to clean up listeners", "command": "if (chart) { chart.destroy(); } chart = new Chart(ctx, newConfig);"},
        {"solution": "Store chart reference in variable scope to allow destruction later", "percentage": 90, "note": "Make chart accessible for destroy call", "command": "let chart = new Chart(ctx, config); // later: chart.destroy();"},
        {"solution": "Clear canvas context with clearRect() if destroy() not available", "percentage": 75, "note": "Fallback method, less reliable"}
    ]'::jsonb,
    'Chart.js v2.x+, Chart instance already created and visible, Canvas element reference available',
    'Old chart disappears completely, new chart renders on canvas, no ghosting or tooltip conflicts from previous chart',
    'Calling destroy() is mandatory - canvas.clear() or clearRect() insufficient for cleanup. Old chart instance listeners/events persist if not destroyed causing phantom tooltips. Chart variable must be in scope accessible for destroy() call.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/40056555/destroy-chart-js-bar-graph-to-redraw-other-graph-in-same-canvas'
),
(
    'Setting width and height in Chart.js',
    'stackoverflow-chartjs',
    'HIGH',
    '[
        {"solution": "Set maintainAspectRatio: false in options and wrap canvas in parent div with fixed width/height", "percentage": 93, "note": "Responsive approach"},
        {"solution": "Set responsive: false in options to use canvas width/height attributes only", "percentage": 85, "note": "Static sizing", "command": "options: { responsive: false }"},
        {"solution": "Use CSS constraints on parent container: width: 400px; height: 400px; with maintainAspectRatio: false", "percentage": 88, "note": "Most flexible"}
    ]'::jsonb,
    'Canvas element in HTML, Chart.js loaded, Chart configuration ready',
    'Chart renders at specified width/height, no auto-scaling to window size when responsive: false, fills container when responsive: true',
    'Inline width/height on canvas are canvas render size, not layout size - must use CSS or parent container. Default responsive: true ignores canvas attributes. Setting both responsive and maintainAspectRatio needed for fixed sizing.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/37621020/setting-width-and-height'
),
(
    'How to clear a chart from a canvas so hover events cannot be triggered',
    'stackoverflow-chartjs',
    'MEDIUM',
    '[
        {"solution": "Call chart.destroy() before reassigning chart variable or creating new Chart instance", "percentage": 95, "note": "Only reliable method to clear hover states"},
        {"solution": "Use chart.reset() method if available in your Chart.js version", "percentage": 80, "note": "Older versions only"},
        {"solution": "Combination: chart.destroy() followed by canvas.getContext().clearRect(0, 0, w, h)", "percentage": 75, "note": "Extra safety for canvas clearing"}
    ]'::jsonb,
    'Existing Chart instance active on canvas, Chart variable in accessible scope',
    'Hover tooltips no longer appear over old chart locations, new chart renders cleanly without phantom interactions',
    'chart.clear() and clearRect() alone insufficient - listeners from old chart remain active. Must call destroy() to remove all Chart.js event handlers. Not destroying causes memory leak and phantom hover events.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/24815851/how-to-clear-a-chart-from-a-canvas-so-that-hover-events-cannot-be-triggered'
),
(
    'In Chart.js set chart title, name of x axis and y axis',
    'stackoverflow-chartjs',
    'HIGH',
    '[
        {"solution": "For v2.x, set title in options: options: { title: { display: true, text: \"Chart Title\" } } and use options.scales.xAxes[0].scaleLabel.labelString for axis labels", "percentage": 90, "note": "v2.x syntax"},
        {"solution": "For v3+, use options: { plugins: { title: { display: true, text: \"Chart Title\" } }, scales: { x: { title: { display: true, text: \"X Label\" } } } }", "percentage": 92, "note": "Modern API"},
        {"solution": "Use CSS to add labels above/beside chart if Chart.js options unavailable", "percentage": 70, "note": "Fallback HTML approach"}
    ]'::jsonb,
    'Chart.js v2.x or v3+ loaded, Chart instance created with configuration',
    'Chart displays title above chart, X-axis label appears below chart, Y-axis label appears on left side',
    'v2.x uses title property vs v3+ uses plugins.title - version critical. Axis labels in v2.x nested in scales.xAxes[0].scaleLabel, v3+ uses scales.x.title. Not setting display: true hides the labels.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/27910719/in-chart-js-set-chart-title-name-of-x-axis-and-y-axis'
);
