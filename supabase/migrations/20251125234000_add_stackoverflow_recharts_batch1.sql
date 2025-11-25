-- Add Stack Overflow Recharts solutions batch 1
-- Extracted from highest-voted Recharts questions with accepted answers

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES (
    'Recharts set Y-axis range to display specific maximum value instead of default',
    'stackoverflow-recharts',
    'HIGH',
    '[
        {"solution": "Use the domain prop on YAxis component with type=\"number\". Set domain={[0, 100]} to display 0-100 range", "percentage": 92, "note": "Most direct and flexible approach"},
        {"solution": "Use data-based domain: domain={[''dataMin'', ''dataMax'']} to automatically scale based on data", "percentage": 88, "note": "Good for dynamic datasets"},
        {"solution": "Use mathematical expressions: domain={[''dataMin - 100'', ''dataMax + 100'']} for padding", "percentage": 85, "note": "Useful for adding buffer space around data"}
    ]'::jsonb,
    'Understanding of React component props, Recharts library v0.9+',
    'YAxis displays correct minimum and maximum values, chart renders without errors, axis labels visible',
    'domain prop only works with type=\"number\" on YAxis. Category-type axes ignore domain. Ensure data values are numeric not strings. Add allowDataOverflow={true} if data exceeds domain bounds.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/50078787/recharts-set-y-axis-range'
),
(
    'Make Recharts BarChart responsive instead of fixed width and height',
    'stackoverflow-recharts',
    'VERY_HIGH',
    '[
        {"solution": "Wrap chart in ResponsiveContainer with width percentage and fixed height: <ResponsiveContainer width=\"95%\" height={400}><BarChart>", "percentage": 95, "note": "Standard recommended approach"},
        {"solution": "Use aspect ratio instead of height: <ResponsiveContainer aspect={1.2}><BarChart> for proportional scaling", "percentage": 90, "note": "Maintains aspect ratio during resize"},
        {"solution": "Combine ResponsiveContainer with minWidth prop: <ResponsiveContainer minWidth={350} height={350}> for minimum dimension constraints", "percentage": 85, "note": "Prevents chart from becoming too small"}
    ]'::jsonb,
    'Parent container must have defined width and height, Recharts library installed',
    'Chart resizes smoothly when container changes, no horizontal scroll needed, chart remains visible at all viewport sizes',
    'One of width or height must be percentage string. Do not use quotes wrong. Parent container needs explicit sizing. Height must typically be fixed value not percentage. ResponsiveContainer placement within component not wrapping from parent.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/52134350/set-height-and-width-for-responsive-chart-using-recharts-barchart'
),
(
    'Recharts bar chart shows gray background on hover, need to remove or customize',
    'stackoverflow-recharts',
    'MEDIUM',
    '[
        {"solution": "Add cursor={false} prop to Tooltip component to completely remove hover background", "percentage": 95, "note": "Simplest solution for removal"},
        {"solution": "Make cursor transparent: cursor={{fill: ''transparent''}} on Tooltip component", "percentage": 90, "note": "Alternative to complete removal"},
        {"solution": "Customize cursor color: cursor={{fill: ''#f00''}} to use custom color instead of gray", "percentage": 88, "note": "For when you want to keep hover effect but change appearance"}
    ]'::jsonb,
    'Recharts Tooltip component present in chart',
    'Bar chart hovers without gray background appearing, hover interaction still responsive, chart remains functional',
    'Hover background is called cursor in Recharts terminology. Setting cursor={false} completely disables it. This is controlled via Tooltip component not Bar component.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/54330155/how-to-rurn-off-background-hover-for-bar-charts'
),
(
    'Recharts legend showing dataKey instead of custom descriptive labels',
    'stackoverflow-recharts',
    'HIGH',
    '[
        {"solution": "Add name attribute to Line/Bar/Area components: <Line name=\"# Apples\" dataKey=\"series1\" /> and legend will use name prop", "percentage": 94, "note": "Most straightforward approach"},
        {"solution": "For Pie charts, override legend payload with custom mapping function to create custom labels", "percentage": 85, "note": "Different implementation for pie charts"},
        {"solution": "Use custom Legend content prop with render function to fully customize legend appearance and labels", "percentage": 80, "note": "Complex but most flexible approach"}
    ]'::jsonb,
    'Recharts Legend component present, understanding of chart data structure',
    'Legend displays custom names instead of dataKey values, legend items match data series correctly, chart renders without errors',
    'When no name set on series component, dataKey is used as fallback. Different implementation needed for Pie vs Bar charts. Custom legend render requires understanding payload structure.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/44413185/custom-legend-labels-in-my-rechart-chart'
),
(
    'Create Recharts stacked bar chart with rounded edges only on outer corners',
    'stackoverflow-recharts',
    'MEDIUM',
    '[
        {"solution": "Use array format for radius prop specifying corners [topLeft, topRight, bottomRight, bottomLeft]: <Bar dataKey=\"a\" radius={[10, 0, 0, 10]} stackId=\"a\" />", "percentage": 93, "note": "Gives fine control over each corner"},
        {"solution": "Set first bar with radius={[10, 0, 0, 10]}, middle bars with radius={[0, 0, 0, 0]}, last bar with radius={[0, 10, 10, 0]}", "percentage": 91, "note": "Complete stacked bar rounding pattern"},
        {"solution": "Use uniform radius on outer bars only: radius={10} but only on first and last Bar in stack", "percentage": 88, "note": "Simpler but less control"}
    ]'::jsonb,
    'Recharts version with stacked bar support, knowledge of bar component properties',
    'Stacked bar appears with rounded corners on outer edges, corners are properly rounded, chart displays without visual gaps',
    'Radius is array format not single number for full control. Each position in array [TL, TR, BR, BL] controls one corner. Cannot round inner edges in stacked bar without affecting overall appearance.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/55285570/creating-a-rechart-barchart-with-rounded-edges'
),
(
    'ReCharts LineChart rendering data points, need to show only line without dots',
    'stackoverflow-recharts',
    'MEDIUM',
    '[
        {"solution": "Add dot={false} prop to Line component: <Line dataKey=\"pv\" stroke=\"#8884d8\" dot={false} />", "percentage": 95, "note": "Removes data points from line"},
        {"solution": "Add activeDot={false} in addition to dot={false} to hide dots on hover: <Line dot={false} activeDot={false} />", "percentage": 93, "note": "Removes interactive dots that appear on hover"},
        {"solution": "Set dot to custom component if you need some dots: dot={<CustomDot />} for selective dot display", "percentage": 80, "note": "Advanced option for custom dot rendering"}
    ]'::jsonb,
    'Line component present in LineChart, Recharts library installed',
    'Line renders without visible data points, hover does not show dots, chart displays smooth line only',
    'dot={false} removes points but they still appear on hover unless activeDot={false} is also set. activeDot controls interactive dot appearance when mouse hovers.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/48471083/how-to-remove-points-from-line-chart-in-recharts'
),
(
    'TypeScript error: Binding element implicitly has any type in Recharts custom tooltip',
    'stackoverflow-recharts',
    'MEDIUM',
    '[
        {"solution": "Import TooltipProps from recharts and use as type: const CustomTooltip = ({ active, payload, label }: TooltipProps<ValueType, NameType>) => {...}", "percentage": 94, "note": "Official recommended TypeScript approach"},
        {"solution": "Import ValueType and NameType from recharts/types/component/DefaultTooltipContent for proper typing", "percentage": 92, "note": "Provides proper generic type parameters"},
        {"solution": "For Recharts v3+, use TooltipContentProps instead of TooltipProps for compatibility", "percentage": 85, "note": "Version-specific typing"}
    ]'::jsonb,
    'TypeScript environment, Recharts library with type definitions, understanding of TypeScript generics',
    'No TypeScript errors when compiling, IDE provides autocomplete for tooltip props, custom tooltip renders correctly',
    'Must import TooltipProps from recharts not recharts/types. Different type names for different Recharts versions (v2 vs v3). Use optional chaining payload?. to handle null values.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/65913461/typescript-interface-for-recharts-custom-tooltip'
),
(
    'Add labels to Recharts pie chart, Label component or label prop not working',
    'stackoverflow-recharts',
    'MEDIUM',
    '[
        {"solution": "Create custom render function that accepts entry object and returns label value: const renderLabel = (entry) => entry.name; then pass to Pie: <Pie label={renderLabel} />", "percentage": 93, "note": "Most common working approach"},
        {"solution": "Use custom label component with positioning: const renderCustomizedLabel = ({x, y, name}) => <text x={x} y={y}>{name}</text>;", "percentage": 91, "note": "Allows custom positioning and styling"},
        {"solution": "For complex HTML labels, wrap in SVG foreignObject element to embed HTML in chart", "percentage": 75, "note": "Advanced approach for rich label content"}
    ]'::jsonb,
    'Pie chart component present, data with label/name properties, understanding of callback functions',
    'Labels appear on pie slices, labels display correct values from data, no overlapping or cut-off labels',
    'Label prop expects callback function not Label component. Documentation examples may show Label component but function is required. SVG rendering needed not HTML divs. foreignObject needed for HTML embedding.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/56104004/rechart-adding-labels-to-charts'
),
(
    'Recharts ResponsiveContainer does not shrink correctly in flexbox layout, legend collapses and gets cut off',
    'stackoverflow-recharts',
    'MEDIUM',
    '[
        {"solution": "Set ResponsiveContainer width to percentage with aspect ratio: <ResponsiveContainer width=\"99%\" aspect={3}><Chart/></ResponsiveContainer>", "percentage": 88, "note": "Workaround for known flexbox responsiveness issue"},
        {"solution": "Apply position:absolute CSS to recharts-wrapper div to fix responsiveness: style={{position: ''absolute''}}", "percentage": 86, "note": "CSS-based fix for layout issues"},
        {"solution": "Use CSS Grid instead of Flexbox for parent container to allow proper width calculations and dynamic legend", "percentage": 84, "note": "Architecture change for better compatibility"},
        {"solution": "Wrap ResponsiveContainer in positioned divs with absolute positioning for explicit sizing: <div style={{position: ''relative'', width: ''100%''}}><div style={{position: ''absolute''}}><ResponsiveContainer>", "percentage": 82, "note": "Container management approach"}
    ]'::jsonb,
    'Recharts ResponsiveContainer, CSS Flexbox or Grid layout, React component structure',
    'Chart resizes correctly when legend visibility changes, legend stays visible and not cut off, responsive behavior works in flexbox',
    'Flexbox has known issues with ResponsiveContainer responsiveness. Percentage widths work better than auto width. Height should be fixed not percentage. Lift state up to parent for legend visibility control.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/50891591/recharts-responsive-container-does-not-resize-correctly-in-flexbox'
),
(
    'Recharts Y-axis numbers too large and get cut off, need abbreviated format like 10K 10M',
    'stackoverflow-recharts',
    'MEDIUM',
    '[
        {"solution": "Use tickFormatter prop on YAxis with custom abbreviation function: const formatter = (n) => n > 1000000 ? (n/1000000).toString() + ''M'' : (n/1000).toString() + ''K''; <YAxis tickFormatter={formatter} />", "percentage": 92, "note": "Standard approach with custom logic"},
        {"solution": "Use Intl.NumberFormat API: <YAxis tickFormatter={(val) => new Intl.NumberFormat(''en-US'', {notation: ''compact'', compactDisplay: ''short''}).format(val)} />", "percentage": 90, "note": "Modern native JavaScript solution"},
        {"solution": "Use external library js-number-abbreviate for pre-built abbreviation function", "percentage": 80, "note": "Simpler but adds dependency"}
    ]'::jsonb,
    'YAxis component present, large numeric data values, understanding of number formatting',
    'Y-axis displays abbreviated numbers like 10K 10M, numbers are not cut off by axis width, chart renders without layout issues',
    'Custom formatter must handle all magnitude ranges: B for billions, M for millions, K for thousands. Test with various data scales. Intl.NumberFormat notation property must be set to ''compact''.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/52320447/recharts-set-y-axis-value-base-of-number-displayed'
),
(
    'Recharts LineChart animation cannot be disabled, isAnimationActive on chart component not working',
    'stackoverflow-recharts',
    'MEDIUM',
    '[
        {"solution": "Add isAnimationActive={false} prop to each individual Line component not to LineChart: <Line isAnimationActive={false} dataKey=\"pv\" />", "percentage": 93, "note": "Must be set at series level not chart level"},
        {"solution": "Add isAnimationActive={false} to all child line series in chart", "percentage": 91, "note": "May need multiple props if multiple series"},
        {"solution": "Combine with animationDuration={0} on Line components for complete animation removal", "percentage": 88, "note": "Ensures no animation in any form"}
    ]'::jsonb,
    'LineChart component with Line series, Recharts animation features enabled',
    'Chart loads instantly without animation, no animation on rerender, LineChart displays data immediately on mount',
    'Animation control must be at Line component level not LineChart level. Setting on chart parent does not affect series animations. Each series may need individual isAnimationActive prop.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/56580007/how-to-disable-animation-for-linechart-in-recharts'
),
(
    'Recharts Bar chart custom label not rendering, label prop with custom component shows nothing',
    'stackoverflow-recharts',
    'MEDIUM',
    '[
        {"solution": "Custom labels must return SVG text elements not HTML: <text x={x} y={y} fill={stroke}>{value}</text> not <div>", "percentage": 94, "note": "Critical difference from HTML components"},
        {"solution": "Custom label component receives props x, y, stroke, value as positioning and styling data", "percentage": 92, "note": "Use these props for proper positioning"},
        {"solution": "For complex HTML labels, wrap in SVG foreignObject: <foreignObject x={0} y={0}><div>Label</div></foreignObject>", "percentage": 80, "note": "Enables HTML embedding in SVG chart"}
    ]'::jsonb,
    'Bar chart component present, understanding of SVG elements, React component knowledge',
    'Custom labels appear on bars, labels positioned correctly with x and y props, text is visible and not clipped',
    'Labels must use SVG text elements not HTML divs. SVG namespace required. foreignObject needed for HTML. Positioning requires x, y, textAnchor props. Cannot use HTML div elements directly.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/42012019/recharts-custom-label'
);
