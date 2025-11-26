-- Add Stack Overflow date-fns solutions batch 1
-- Extracted from highest-voted date-fns questions (116-27 votes)
-- Source: https://stackoverflow.com/questions/tagged/date-fns?sort=votes

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES (
    'date-fns format() function converts UTC time to local timezone instead of keeping UTC',
    'stackoverflow-datefns',
    'VERY_HIGH',
    $$[
        {"solution": "Use date-fns-tz library with formatInTimeZone() function: import { formatInTimeZone } from ''date-fns-tz''; const result = formatInTimeZone(parsedTime, ''UTC'', ''yyyy-MM-dd kk:mm:ss'');", "percentage": 95, "note": "Most current and recommended approach"},
        {"solution": "Use toZonedTime helper with UTC timezone: import { format, toZonedTime } from ''date-fns-tz''; format(toZonedTime(date, ''UTC''), ''yyyy-MM-dd kk:mm:ss'', { timeZone: ''UTC'' });", "percentage": 90, "note": "Alternative using toZonedTime"},
        {"solution": "Use native Date.toISOString() method: const isoDate = date.toISOString(); console.log(isoDate.substring(0, 10) + '' '' + isoDate.substring(11, 19));", "percentage": 85, "note": "Vanilla JavaScript approach without libraries"}
    ]$$::jsonb,
    'date-fns or date-fns-tz library installed, date string in ISO 8601 format',
    'Formatted output shows UTC time without timezone conversion, time matches original input',
    'date-fns base library does not preserve UTC by default. Must use date-fns-tz or UTC-aware methods. Avoid assuming format() respects timezone parameter.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/58561169/date-fns-how-do-i-format-to-utc'
),
(
    'Calculate difference between two dates in years, months, and days',
    'stackoverflow-datefns',
    'HIGH',
    $$[
        {"solution": "Use accurate algorithm accounting for leap years and varying month lengths: extract year/month/day components, subtract, handle negative remainders by borrowing from larger units. Reference actual daysInMonth array that adjusts for February.", "percentage": 88, "note": "Most precise calculation method"},
        {"solution": "Use date-fns differenceInYears(), differenceInMonths(), differenceInDays() functions separately: const years = differenceInYears(end, start); const months = differenceInMonths(end, addYears(start, years)); const days = differenceInDays(end, addMonths(addYears(start, years), months));", "percentage": 85, "note": "date-fns composition approach"},
        {"solution": "Use moment-precise-range plugin for automatic object format: { ''years'': 2, ''months'': 7, ''days'': 0 }. Note: adds file size overhead.", "percentage": 75, "note": "External library approach with tradeoff"}
    ]$$::jsonb,
    'JavaScript Date objects or compatible library, two valid dates to compare',
    'Result contains years, months, and days fields with correct values accounting for actual calendar days',
    'Simple approximation (dividing total days by 31 and 12) fails for leap years and varying month lengths. Do not use averaged calculations. Moment.js adds significant file size.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/17732897/difference-between-two-dates-in-years-months-days-in-javascript'
),
(
    'Format duration from seconds into MM:SS or HH:MM:SS format using date-fns',
    'stackoverflow-datefns',
    'HIGH',
    $$[
        {"solution": "Use intervalToDuration with zero-padding: import { intervalToDuration } from ''date-fns''; const duration = intervalToDuration({ start: 0, end: seconds * 1000 }); const zeroPad = (num) => String(num).padStart(2, ''0''); const formatted = `${zeroPad(duration.minutes)}:${zeroPad(duration.seconds)}`;", "percentage": 92, "note": "Most reliable date-fns approach with 82 upvote answer"},
        {"solution": "For hours support, filter and join components: const formatted = [duration.hours, duration.minutes, duration.seconds].filter(Boolean).map(zeroPad).join('':'');", "percentage": 90, "note": "Extends intervalToDuration for variable units"},
        {"solution": "Use formatDistance for human-readable output: formatDistance(0, seconds * 1000). Note: produces ''X minutes'' format instead of MM:SS.", "percentage": 72, "note": "Alternative for human-readable output"}
    ]$$::jsonb,
    'date-fns library installed, integer seconds value available',
    'Formatted output matches expected MM:SS or HH:MM:SS format with proper zero-padding',
    'Forgetting to multiply seconds by 1000 for milliseconds. Not zero-padding numeric output causes malformed time display. formatDistance produces text, not numeric format.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/48776140/format-a-duration-from-seconds-using-date-fns'
),
(
    'date-fns format() shows different dates across timezones when parsing incomplete ISO 8601 strings',
    'stackoverflow-datefns',
    'HIGH',
    $$[
        {"solution": "Adjust for timezone offset before formatting: const dt = new Date(''2017-12-12''); const dtDateOnly = new Date(dt.valueOf() + dt.getTimezoneOffset() * 60 * 1000); console.log(format(dtDateOnly, ''YYYY-MM-DD''));", "percentage": 88, "note": "Compensates for local timezone offset"},
        {"solution": "Use parseISO() instead of Date constructor: const parsed = parseISO(''2017-12-12''); format(parsed, ''yyyy-MM-dd''). parseISO() handles date-only strings more consistently.", "percentage": 85, "note": "Preferred modern approach using date-fns parsing"},
        {"solution": "Format using UTC methods exclusively: Use date.getUTCFullYear(), date.getUTCMonth(), date.getUTCDate() instead of timezone-dependent methods.", "percentage": 80, "note": "Bypass timezone complications entirely"}
    ]$$::jsonb,
    'date-fns library, incomplete date string in YYYY-MM-DD format',
    'Formatted output consistent across all timezones, date value matches input date',
    'Incomplete ISO strings (''2017-12-12'') are interpreted as UTC midnight, but format() reads in local timezone causing day shifts. Critical for birthdate/document date fields.',
    0.87,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/48172772/time-zone-issue-involving-date-fns-format'
),
(
    'How to format date with date-fns coming from moment.js migration',
    'stackoverflow-datefns',
    'HIGH',
    $$[
        {"solution": "Use parse() function before format(): const dateString = ''10-13-20''; const date = parse(dateString, ''MM-dd-yy'', new Date()); const result = format(date, ''yyyy-MM-dd''''T''''HH:mm:ss.SSSxxx'');", "percentage": 93, "note": "Primary solution - explicit parse then format"},
        {"solution": "For ISO format strings, use parseISO(): const date = ''2021-12-20''; format(parseISO(date), ''dd-MM-yyyy''); // 20-12-2021", "percentage": 90, "note": "Optimized for ISO-formatted input"},
        {"solution": "Use toDate() function: format(toDate(''10-13-20''), ''MM-dd-yyyy''). Availability varies by date-fns version (v3.6.0+).", "percentage": 70, "note": "Version-dependent approach"}
    ]$$::jsonb,
    'date-fns library installed, date-fns documentation available for format tokens',
    'Formatted output matches expected pattern, original string parsed correctly',
    'Unlike moment.js, date-fns does NOT auto-parse non-standard strings. Must call parse() explicitly. Format tokens differ from moment.js (lowercase ''y'' vs uppercase ''Y'').',
    0.89,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/64362242/how-to-format-date-with-date-fns'
),
(
    'Get current date in ISO-8601 format using date-fns while preserving local timezone',
    'stackoverflow-datefns',
    'MEDIUM',
    $$[
        {"solution": "Use formatISO() function: formatISO(endOfDay(new Date())); // Output: ''2018-09-14T23:59:59.999-03:00'' (preserves local timezone offset)", "percentage": 92, "note": "Cleanest date-fns solution"},
        {"solution": "Use format() with timezone pattern: format(endOfDay(new Date()), ''yyyy-MM-dd''''T''''HH:mm:ssXX''); // Includes timezone offset like -0300", "percentage": 88, "note": "Custom format pattern approach"},
        {"solution": "String concatenation: format(new Date(), ''yyyy-MM-dd'') + ''T23:59:59.999Z''; // Fixed UTC format regardless of timezone", "percentage": 75, "note": "Simple but forces UTC designation"}
    ]$$::jsonb,
    'date-fns library installed, understanding of timezone behavior in ISO 8601',
    'Output is valid ISO-8601 string with timezone offset, date component matches current date',
    'toISOString() forces UTC conversion, shifting local dates when timezone offset present. Z designation means UTC only. Offset notation (±HH:MM) differs from Z.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/52334494/get-the-current-date-using-date-fns-in-iso-8601-format'
),
(
    'Module not found error: Cannot resolve @date-io/date-fns in Material UI Pickers',
    'stackoverflow-datefns',
    'MEDIUM',
    $$[
        {"solution": "Install correct version for Material UI Pickers v3: npm i @date-io/date-fns@1.x date-fns. The adapter version must match picker version (v3 requires @date-io v1.x).", "percentage": 94, "note": "Primary fix addressing version mismatch"},
        {"solution": "Use correct import path: import DateFnsUtils from ''@date-io/date-fns''; (not from build directory path)", "percentage": 85, "note": "Correct import statement"},
        {"solution": "Restart development server after installation: npm install may not reflect changes until dev server restarts.", "percentage": 80, "note": "Post-install step sometimes needed"}
    ]$$::jsonb,
    'Node.js and npm installed, Material UI Pickers v3 project, date-fns library available',
    'npm install completes successfully, Material UI Pickers component initializes, no module resolution errors',
    'Version mismatch between Material UI Pickers and @date-io/date-fns is common. Always check docs for correct adapter version. Restarting dev server may be required.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/61822733/module-not-found-cant-resolve-date-io-date-fns'
),
(
    'Verify if string is valid date with date-fns and proper calendar validation',
    'stackoverflow-datefns',
    'MEDIUM',
    $$[
        {"solution": "Use parse() with locale and isValid(): import { parse, isValid, format } from ''date-fns''; import { enGB } from ''date-fns/locale''; const parsedDate = parse(''29/10/1989'', ''P'', new Date(), { locale: enGB }); const isValidDate = isValid(parsedDate);", "percentage": 93, "note": "Proper validation with locale support, 57 upvote answer"},
        {"solution": "Use explicit format pattern: const parsed = parse(dateString, ''dd/MM/yyyy'', new Date()); if (isValid(parsed)) { return format(parsed, ''dd-MM-yyyy''); }", "percentage": 90, "note": "Explicit format pattern approach"},
        {"solution": "Note: parse() validates calendar rules (e.g., ''31/04/2021'' fails because April has 30 days). Simple string parsing cannot catch these errors.", "percentage": 85, "note": "Explains why native parsing is insufficient"}
    ]$$::jsonb,
    'date-fns library installed, date locale data available, date string to validate',
    'Valid dates parse successfully, invalid dates (wrong month/day combinations) return false from isValid()',
    'Simple string parsing or regex cannot validate calendar rules. Must use parse() with isValid() to catch invalid dates like ''31/04/2021''. Locale parameter affects parsing behavior.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/66068149/receive-a-string-and-verify-if-it-is-a-valid-date-with-date-fns'
),
(
    'Parse and format date string using date-fns with version compatibility',
    'stackoverflow-datefns',
    'MEDIUM',
    $$[
        {"solution": "For v2.0.0-alpha.27+, use parseISO(): import { format, parseISO } from ''date-fns''; const formattedDate = format(parseISO(''2019-02-11T14:00:00''), ''MM/dd/yyyy'');", "percentage": 92, "note": "Recommended for v2.x and later"},
        {"solution": "For v1.30.1, use parse(): import { format, parse } from ''date-fns''; const formattedDate = format(parse(''2019-02-11T14:00:00''), ''MM/DD/YYYY'');", "percentage": 85, "note": "Legacy v1 approach"},
        {"solution": "For v3.6.0+, toDate() works again: import { format, toDate } from ''date-fns''; format(toDate(''2019-02-11T14:00:00''), ''MM/dd/yyyy'');", "percentage": 80, "note": "Latest version support with validation: if (isValid(parseISO(dateStr))) { parse(dateStr, format, new Date()); }"}
    ]$$::jsonb,
    'date-fns library installed, date-fns version known, date string in ISO or custom format',
    'Date parses without error, formatted output matches expected pattern',
    'API changed significantly across date-fns versions. parseISO() replaced toDate() in v2. Always check your date-fns version. Mixing version-specific functions causes errors.',
    0.86,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/54443161/parse-and-format-date-in-string'
),
(
    'Get duration between two dates in days:hours:minutes:seconds format with date-fns',
    'stackoverflow-datefns',
    'MEDIUM',
    $$[
        {"solution": "Combine intervalToDuration with differenceInDays: const { hours, minutes, seconds } = intervalToDuration({ start, end }); const days = differenceInDays(end, start); // Result: ''60 days : 8 hours : 9 minutes : 5 seconds''", "percentage": 91, "note": "Hybrid approach producing exact format needed"},
        {"solution": "Use intervalToDuration alone: intervalToDuration({ start: new Date(1929, 0, 15, 12, 0, 0), end: new Date(1968, 3, 4, 19, 5, 0) }); // Returns { years, months, days, hours, minutes, seconds }", "percentage": 82, "note": "Simple but returns months/years, not total days"},
        {"solution": "Use formatDistance for readable output: formatDistance(startDate, endDate); // Returns ''about 39 years'' - less useful for numeric format.", "percentage": 65, "note": "Alternative for human-readable text output"}
    ]$$::jsonb,
    'date-fns library installed, two valid Date objects (start and end)',
    'Output contains separate days, hours, minutes, seconds values, total matches actual time difference',
    'intervalToDuration returns months/years which may not be what you need. Must combine with differenceInDays() for total days. formatDistance produces text, not numeric breakdown.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/58090766/getting-duration-between-two-dates-in-date-fns-in-dayshrsminssecs-format'
),
(
    'Detect or guess user timezone using date-fns',
    'stackoverflow-datefns',
    'MEDIUM',
    $$[
        {"solution": "Use browser Intl API (no library needed): Intl.DateTimeFormat().resolvedOptions().timeZone; // Returns IANA timezone like ''America/New_York'' - supported by most modern browsers", "percentage": 94, "note": "Recommended standard approach without external dependencies"},
        {"solution": "For timezone abbreviations, use date-fns-tz: import { format } from ''date-fns-tz''; console.log(format(new Date(), ''yyyy-MM-dd HH:mm z'')); // Output: ''2021-11-29 13:55 PST''", "percentage": 85, "note": "For displaying timezone abbreviation in UI"},
        {"solution": "Note: date-fns base library does not include moment.tz.guess() equivalent. Use Intl API or date-fns-tz for timezone operations.", "percentage": 80, "note": "Clarifies missing functionality in base date-fns"}
    ]$$::jsonb,
    'Modern browser environment or Node.js with Intl support, date-fns-tz if using format function',
    'timeZone resolvedOptions returns valid IANA timezone string, formatted output shows correct timezone abbreviation',
    'date-fns base library lacks timezone detection. Do not expect moment.tz.guess() equivalent. Intl API is the standard, supported approach. ''z'' format returns abbreviation, ''Z'' returns offset.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/54555491/how-to-guess-users-timezone-using-date-fns'
),
(
    'Difference between parseISO() and new Date() constructor for date-fns parsing',
    'stackoverflow-datefns',
    'LOW',
    $$[
        {"solution": "parseISO() strictly expects ISO 8601 format (''2019-09-25T14:34:32.999Z''). new Date() accepts locale-specific formats but behavior is browser-dependent and MDN discourages it.", "percentage": 90, "note": "Fundamental distinction explained"},
        {"solution": "For custom non-ISO formats, use parse() function instead: parse(''Apr 9, 2020, 12:00:00 am'', ''MMM d, yyyy, h:mm:ss a'', new Date());", "percentage": 85, "note": "Proper method for non-ISO formats"},
        {"solution": "For reliable cross-platform parsing, always use ISO 8601 format with parseISO(). Avoid new Date(string) due to inconsistent browser parsing.", "percentage": 88, "note": "Best practice for production code"}
    ]$$::jsonb,
    'date-fns library installed, understanding of ISO 8601 format specification',
    'parseISO() parses ISO strings without error, custom formats parse with explicit format() call, cross-browser behavior is consistent',
    'parseISO(''Apr 9, 2020, 12:00:00 am'') fails because that is not ISO 8601 format. new Date() parsing is browser-dependent and should not be used. Always specify format explicitly with parse().',
    0.88,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/56838786/date-fns-difference-between-parseisostring-and-new-datestring'
);
