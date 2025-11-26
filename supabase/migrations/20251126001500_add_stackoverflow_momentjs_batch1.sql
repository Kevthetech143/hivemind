-- Add Stack Overflow Moment.js solutions batch 1

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES (
    'Moment.js transform to date object - convert moment instance to native JavaScript Date',
    'stackoverflow-momentjs',
    'VERY_HIGH',
    $$[
        {"solution": "Use .toDate() method: moment().toDate() returns native JavaScript Date object", "percentage": 95, "note": "Simplest and most direct approach"},
        {"solution": "For timezone-aware conversion use moment().tz(\"America/New_York\").utc(true).toDate() with moment-timezone", "percentage": 90, "note": "Preserves timezone information in returned Date object"}
    ]$$::jsonb,
    'Moment.js library loaded in project, Basic understanding of JavaScript Date objects, moment-timezone library for timezone-aware conversions',
    'Date object successfully created from moment instance, Timestamp values match expected UTC calculations, Date object displays correctly in target timezone context',
    'Timezone loss when converting to Date - automatically reverts to system local timezone. Using legacy POSIX zones like MST7MDT instead of IANA identifiers like America/Denver. Format incompatibility - Safari does not support YYYY-MM-DD HH:mm:ss; use YYYY-MM-DDTHH:mm:ss instead.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/17987647/moment-js-transform-to-date-object'
),
(
    'Get hours difference between two dates in Moment.js using diff method',
    'stackoverflow-momentjs',
    'VERY_HIGH',
    $$[
        {"solution": "Use .diff() method with unit parameter: moment(date1).diff(moment(date2), \"hours\")", "percentage": 98, "note": "Simplest approach for calculating differences in specific units"},
        {"solution": "For formatted time output use moment.utc(moment(now).diff(moment(then))).format(\"HH:mm:ss\") for durations under 24 hours", "percentage": 85, "note": "For multi-day durations use Math.floor(duration.asHours())"},
        {"solution": "Use moment.duration() to get more granular access to days/hours/minutes/seconds", "percentage": 80, "note": "Provides individual component access for custom formatting"}
    ]$$::jsonb,
    'Moment.js library loaded, Two moment objects or parseable date strings, Understanding of duration formatting',
    'Time difference returns expected numeric value in requested units, No console errors about invalid comparisons, Handles multi-day durations correctly',
    'Passing milliseconds directly to moment() constructor - interprets as Unix epoch timestamp, not as duration. Using moment() on diff result instead of moment.utc(). Confusing .diff() return value (milliseconds by default) with formatted output. Not accounting for timezone differences.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/25150570/get-hours-difference-between-two-dates-in-moment-js'
),
(
    'Moment.js date time comparison - check if one date is after/before another date',
    'stackoverflow-momentjs',
    'VERY_HIGH',
    $$[
        {"solution": "Use .isAfter() method: moment(d).isAfter(compareDate) returns true/false", "percentage": 98, "note": "Primary query function for date comparison"},
        {"solution": "Use .isBefore() method: moment(d).isBefore(compareDate) for inverse comparison", "percentage": 98, "note": "Complements isAfter() for bidirectional comparison"},
        {"solution": "Use .isSame() method: moment(d).isSame(compareDate) to check date equality", "percentage": 95, "note": "Checks if two moments represent the same time"},
        {"solution": "Direct comparison operators work: if (momentDate1 > momentDate2) due to valueOf() override", "percentage": 90, "note": "JavaScript comparison works because moment overrides valueOf()"}
    ]$$::jsonb,
    'Moment.js library loaded, Dates in valid ISO 8601 format like 2014-03-24T01:15:00Z, Understanding of moment objects',
    'Comparison returns expected boolean values, No deprecation warnings in console, Dates parse successfully without fallback to JavaScript Date() constructor',
    'Invalid date formats trigger deprecation warnings and cause comparisons to fail. Using .format() before comparison converts moment to string, breaking logic. Format strings like DD/MM/YYYY when used with comparison operators produce alphabetical rather than chronological ordering. Timezone mismatches using .tz() without moment-timezone library.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/22600856/moment-js-date-time-comparison'
),
(
    'Format date with Moment.js - convert date to custom display format using format method',
    'stackoverflow-momentjs',
    'VERY_HIGH',
    $$[
        {"solution": "Use .format() method with format tokens: moment(testDate).format(\"MM/DD/YYYY\")", "percentage": 98, "note": "Standard approach for all date formatting needs"},
        {"solution": "Use uppercase tokens MM (month), DD (day), YYYY (year) - case sensitive", "percentage": 95, "note": "Incorrect casing produces wrong output or errors"}
    ]$$::jsonb,
    'Moment.js library loaded in project, A date string or date object to format, Understanding of format token casing',
    'Date displays in target format like 04/12/2013, No console errors about missing methods, Output matches desired display pattern',
    'Case sensitivity - lowercase mm means minutes not months. Using second parameter for display instead of parsing input. Format string mismatch - input parsing format must match date string structure exactly. Confusing .format() (output) with constructor second parameter (input parsing).',
    0.96,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/15993913/format-date-with-moment-js'
),
(
    'How to remove time from date with Moment.js - strip time portion leaving only date',
    'stackoverflow-momentjs',
    'HIGH',
    $$[
        {"solution": "Use .startOf(\"day\") method: moment(dateTime).startOf(\"day\") sets time to 00:00:00", "percentage": 95, "note": "Standard approach that modifies the moment object"},
        {"solution": "For non-mutating approach use clone: moment(dateTime).clone().startOf(\"day\")", "percentage": 90, "note": "Prevents modification of original object"},
        {"solution": "For display-only formatting use .format(\"LL\") which returns formatted date string without time", "percentage": 85, "note": "Best if you only need formatted output, not date manipulation"}
    ]$$::jsonb,
    'Moment.js library loaded, A datetime value to process, Awareness of UTC vs local timezone handling',
    'Date displays without time component, No unintended date shifts occur across timezones, Original moment object remains unchanged if cloning',
    'Timezone issues - .startOf(\"day\") can shift dates across timezone boundaries. Use moment.utc().startOf(\"day\") to prevent unwanted conversions. Mutation - method modifies the original object unless cloned. Display vs storage confusion - use .format() for display-only needs.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/15130735/how-can-i-remove-time-from-date-with-moment-js'
),
(
    'How to change the language/locale of Moment.js date formatting',
    'stackoverflow-momentjs',
    'HIGH',
    $$[
        {"solution": "Use moment.locale(\"de\") to set locale globally, then format dates normally", "percentage": 98, "note": "Primary method for changing display language"},
        {"solution": "Include moment-with-locales.min.js instead of moment.min.js to load all locale data", "percentage": 95, "note": "Use correct bundle that includes locale files"},
        {"solution": "For ES6 modules: import moment from \"moment\"; import \"moment/locale/de\";", "percentage": 92, "note": "Modern approach for bundled projects"}
    ]$$::jsonb,
    'Moment.js library loaded, Include moment-with-locales.min.js or import locale files, Import moment/locale/[lang] before setting locale in module environments',
    'Correctly formatted output appears in target language with proper month/day names, Date string displays in expected language (e.g., German month names)',
    'Using moment.min.js which lacks locale data - must use moment-with-locales.min.js. Setting locale after formatting - order matters. Using deprecated moment.lang() instead of moment.locale(). Forgetting to import/load specific locale file in bundlers. Not reloading page after locale configuration changes.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/17493309/how-do-i-change-the-language-of-moment-js'
),
(
    'How to format a date as ISO 8601 in Moment.js',
    'stackoverflow-momentjs',
    'HIGH',
    $$[
        {"solution": "Use .toISOString() method: moment().toISOString() returns YYYY-MM-DDTHH:mm:ss.SSSZ format", "percentage": 98, "note": "Returns ISO 8601 string with milliseconds in UTC"},
        {"solution": "Use .format() without parameters: moment().format() returns default ISO 8601 format without milliseconds", "percentage": 95, "note": "Maintains timezone offset without milliseconds"},
        {"solution": "For custom ISO format use .format(\"YYYY-MM-DD[T]HH:mm:ss.SSS[Z]\") with format tokens", "percentage": 90, "note": "Flexible but toISOString() is simpler for standard ISO 8601"}
    ]$$::jsonb,
    'Moment.js library version 2.7.0 or later, Basic JavaScript knowledge, Understanding of timezone differences between methods',
    'Code successfully returns ISO 8601-compliant timestamp string suitable for APIs and database storage, Format matches YYYY-MM-DDTHH:mm:ss pattern',
    'Attempting moment.ISO_8601 as format parameter - constant is not a format string. Not recognizing timezone differences between toISOString (UTC) and format() (local). Using format() with certain locales may produce non-English characters in output.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/25725019/how-do-i-format-a-date-as-iso-8601-in-moment-js'
),
(
    'Parse string to date with Moment.js - convert date string to moment object',
    'stackoverflow-momentjs',
    'VERY_HIGH',
    $$[
        {"solution": "Use moment() constructor with format: const myMoment = moment(\"2014-02-27T10:00:00\", \"YYYY-MM-DDTHH:mm:ss\")", "percentage": 98, "note": "Standard approach - format must match input string exactly"},
        {"solution": "Convert to native Date object: const myDate = moment(str, \"YYYY-MM-DD\").toDate()", "percentage": 95, "note": "Two-step process for JavaScript Date conversion"},
        {"solution": "For ISO strings without parsing: moment(\"2014-02-27\") auto-parses ISO format", "percentage": 85, "note": "Works for standard ISO format but explicit format is safer"}
    ]$$::jsonb,
    'Moment.js library loaded in project, Understanding of date format tokens (YYYY=year, MM=month, DD=day), Date string to parse',
    'Moment object correctly recognizes input date, .format() produces desired output format, .toDate() successfully converts to native JavaScript Date when needed',
    'Format mismatch - format string must match input string exactly or parsing fails. Timezone issues - different methods handle timezones differently. Legacy browser support - ISO strings fail in IE8 without polyfills. Confusing .format() which returns string, not date object.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/22184747/parse-string-to-date-with-moment-js'
),
(
    'Get time difference between datetimes - calculate duration between two moment objects',
    'stackoverflow-momentjs',
    'HIGH',
    $$[
        {"solution": "Use .diff() with duration and format for durations under 24 hours: moment.utc(moment(now).diff(moment(then))).format(\"HH:mm:ss\")", "percentage": 95, "note": "Works for sub-24 hour durations"},
        {"solution": "For durations spanning multiple days: var ms = moment(now).diff(moment(then)); var d = moment.duration(ms); Math.floor(d.asHours()) + moment.utc(ms).format(\":mm:ss\")", "percentage": 90, "note": "Handles multi-day durations correctly"},
        {"solution": "Use .asHours() for total hours: moment.duration(moment(now).diff(moment(then))).asHours()", "percentage": 85, "note": "Simple for getting total hours as decimal"}
    ]$$::jsonb,
    'Moment.js library loaded, Two datetime strings or moment objects to compare, Understanding of duration formatting',
    'Time difference displays correctly in HH:mm:ss format, Handles multi-day durations properly, Accounts for timezone variations',
    'Timezone issues - using moment() constructor on milliseconds treats them as epoch timestamps. Passing milliseconds to moment() instead of using moment.duration(). Simple formatting resets hours beyond 24 without using asHours(). No native duration format methods in Moment.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/18623783/get-time-difference-between-datetimes'
),
(
    'How to return the current timestamp with Moment.js - get current time in various formats',
    'stackoverflow-momentjs',
    'VERY_HIGH',
    $$[
        {"solution": "For millisecond timestamp use moment().valueOf() - returns numeric value matching new Date().getTime()", "percentage": 98, "note": "Most common use case, direct numeric value"},
        {"solution": "For Unix timestamp (seconds) use moment().unix()", "percentage": 95, "note": "Less precision than valueOf() but standard Unix time format"},
        {"solution": "For ISO 8601 string use moment().format() or moment().toISOString()", "percentage": 92, "note": "Returns formatted string representation"},
        {"solution": "For format string method use .format(\"x\") for milliseconds or .format(\"X\") for Unix seconds", "percentage": 85, "note": "Returns value as string, conversion may be needed"}
    ]$$::jsonb,
    'Moment.js library included in project, Basic understanding of timestamp formats (Unix, milliseconds, ISO 8601)',
    'Timestamp correctly represents current machine time, Format matches application requirements, Conversions between formats work bidirectionally',
    'Confusing .unix() (seconds) with .valueOf() (milliseconds). Using .format() when numeric timestamps are needed for storage/comparison. Forgetting that Moment instances are mutable - always create new instances for different times. Not converting format string results from string to number.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/25734743/how-to-return-the-current-timestamp-with-moment-js'
);
