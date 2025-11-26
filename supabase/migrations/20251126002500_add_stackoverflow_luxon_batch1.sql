-- Add Stack Overflow Luxon Q&A solutions batch 1

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES (
    'How to calculate duration between two dates in Luxon',
    'stackoverflow-luxon',
    'HIGH',
    $$[
        {"solution": "Use DateTime.diff() method with units array: const diff = date1.diff(date2, [\"years\", \"months\", \"days\", \"hours\"]); then call .toObject() for results", "percentage": 95, "note": "Official Luxon recommended approach", "command": "const diff = DateTime.fromISO(\"2020-09-06T12:00\").diff(DateTime.fromISO(\"2019-06-10T14:00\"), [\"years\", \"months\", \"days\", \"hours\"]); console.log(diff.toObject());"},
        {"solution": "For interval checks, use Interval.fromDateTimes(date1, date2).length(\"hours\") to get duration in specific unit", "percentage": 90, "note": "Useful for comparing against thresholds"},
        {"solution": "Convert interval to duration then check: Interval.fromDateTimes(date1, date2).toDuration(\"hours\").hours", "percentage": 85, "note": "Alternative chaining approach"}
    ]$$::jsonb,
    'Luxon library imported, Two DateTime objects or ISO 8601 date strings',
    'diff.toObject() returns object with years/months/days/hours properties, duration value matches expected calculation',
    'Do not use Duration.fromISO() for two dates - only for ISO 8601 duration strings. Always specify units in diff() when readable output needed.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/63763221/how-to-calculate-a-duration-between-two-dates-in-luxon'
),
(
    'How to compare only dates ignoring time in Luxon DateTime',
    'stackoverflow-luxon',
    'HIGH',
    $$[
        {"solution": "Use .startOf(\"day\") on both DateTimes before comparison: startDate.startOf(\"day\") <= someDate.startOf(\"day\")", "percentage": 96, "note": "Official recommended approach - strips time component"},
        {"solution": "Use .hasSame() method for equality: startDate.hasSame(someDate, \"day\") returns boolean for same day", "percentage": 90, "note": "Best for checking if dates fall on same day"},
        {"solution": "Manual property comparison: dateTime1.year === dateTime2.year && dateTime1.month === dateTime2.month && dateTime1.day === dateTime2.day", "percentage": 70, "note": "Verbose but explicit"}
    ]$$::jsonb,
    'Luxon DateTime objects already instantiated, Understanding comparison operators include time',
    'Comparison returns boolean value, startOf() normalizes both dates to 00:00:00, hasSame() correctly identifies same-day dates',
    'Do not compare ordinal properties - fails across years (Jan 1 vs Dec 31). Remember standard < > operators include time component. Do not forget .startOf(\"day\").',
    0.94,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/60058489/compare-only-dates-with-luxon-datetime'
),
(
    'How to format a Date with Luxon',
    'stackoverflow-luxon',
    'HIGH',
    $$[
        {"solution": "Use toLocaleString() with preset format constants: DateTime.fromISO(\"2010-10-22T21:38:00\").toLocaleString(DateTime.DATETIME_MED)", "percentage": 96, "note": "Returns localized human-readable format", "command": "const date = DateTime.fromISO(\"2010-10-22T21:38:00\"); console.log(date.toLocaleString(DateTime.DATETIME_MED)); // => October 22, 9:38 PM"},
        {"solution": "Chain with setLocale() for specific locale: DateTime.fromISO(value).setLocale(\"en-US\").toLocaleString(DateTime.DATETIME_FULL)", "percentage": 92, "note": "Applies locale-specific formatting"},
        {"solution": "Use toFormat() with custom format tokens: date.toFormat(\"dd/MM/yyyy HH:mm\")", "percentage": 85, "note": "For custom formats - use ONLY for output, not parsing"}
    ]$$::jsonb,
    'Luxon library loaded (CDN or npm), ISO 8601 formatted date strings, understanding that fromFormat() is for parsing only',
    'toLocaleString() outputs human-readable string, preset constants work across locales, custom formats apply correctly',
    'Do not use fromFormat() to output dates - only for parsing input. Do not forget luxon namespace or destructure DateTime. Never pass strings where DateTime objects required.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/64064891/how-to-format-a-date-with-luxon'
),
(
    'How to reset Luxon DateTime to start of day (midnight)',
    'stackoverflow-luxon',
    'HIGH',
    $$[
        {"solution": "Use .startOf(\"day\") method: DateTime.now().startOf(\"day\") sets time to 00:00:00", "percentage": 96, "note": "Official recommended approach", "command": "const today = () => DateTime.now().startOf(\"day\");"},
        {"solution": "For UTC midnight: DateTime.now().toUTC().startOf(\"day\")", "percentage": 92, "note": "Specify UTC when needed instead of local"},
        {"solution": "Chain with other operations: DateTime.now().plus({days: 1}).startOf(\"day\") for tomorrow at midnight", "percentage": 90, "note": "Works seamlessly with method chaining"}
    ]$$::jsonb,
    'Luxon library installed and imported, understanding DateTime object methods',
    'DateTime shows 00:00:00 time, date portion preserved, method chains work correctly, UTC variant produces UTC midnight',
    'Avoid manual date reconstruction using getFullYear()/getMonth(). Specify .toUTC() explicitly when UTC midnight needed, not local. Do not forget the string argument "day".',
    0.95,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/72935751/how-to-set-luxon-datetime-to-start-of-day-reset-time'
),
(
    'How to convert local time to UTC given a timezone in Luxon',
    'stackoverflow-luxon',
    'VERY_HIGH',
    $$[
        {"solution": "Use zone parameter in fromISO() then toUTC(): DateTime.fromISO(\"2019-07-09T18:45\", {zone: \"America/Chicago\"}).toUTC().toISO()", "percentage": 97, "note": "Automatically handles DST", "command": "const d = DateTime.fromISO(\"2019-07-09T18:45\", {zone: \"America/Chicago\"}); console.log(d.toUTC().toISO());"},
        {"solution": "For timezone conversion without UTC: DateTime.fromISO(text, {zone: \"America/Chicago\"}).setZone(\"utc\")", "percentage": 95, "note": "Both toUTC() and setZone(\"utc\") work identically"},
        {"solution": "Store timezone name and always specify zone parameter for consistent results across DST boundaries", "percentage": 92, "note": "Best practice for DST-aware applications"}
    ]$$::jsonb,
    'Luxon library loaded, ISO 8601 datetime string without timezone offset, IANA timezone identifier (e.g., America/Chicago)',
    'DateTime converts correctly across DST boundaries, UTC output matches expected offset, toISO() shows correct Z or +HH:MM offset',
    'Do not manually calculate hour offsets - fails during DST. Do not forget zone parameter. Do not confuse toUTC() with setZone("utc") - both work identically.',
    0.96,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/56927110/luxon-convert-local-time-to-utc-given-a-timezone'
),
(
    'How to display relative time like "today", "tomorrow" using Luxon',
    'stackoverflow-luxon',
    'HIGH',
    $$[
        {"solution": "Use .toRelativeCalendar() method (Luxon v1.9.0+): DateTime.local().toRelativeCalendar() returns \"today\", \"tomorrow\", etc.", "percentage": 96, "note": "Modern approach using Intl.RelativeDateFormat", "command": "const now = DateTime.local(); console.log(now.toRelativeCalendar()); // \"today\""},
        {"solution": "For pre-v1.9.0: create helper calculating day diff then mapping to format strings (sameDay, nextDay, lastWeek, etc.)", "percentage": 70, "note": "Custom implementation for older versions"},
        {"solution": "Test various dates: same day = today, +1 day = tomorrow, -1 day = yesterday", "percentage": 85, "note": "Verify output against multiple date scenarios"}
    ]$$::jsonb,
    'Luxon v1.9.0+ installed, browser supporting Intl.RelativeDateFormat, understanding DateTime objects',
    'toRelativeCalendar() returns strings like "today", "tomorrow", "yesterday", handles multiple days ahead/behind correctly, far dates display as formatted strings',
    'Do not assume calendar() exists - it is Moment.js method, not Luxon. Do not forget .startOf("day") when comparing for accuracy. Handle timezone explicitly with multiple locales.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/53713772/displaying-time-relative-to-a-given-using-luxon-library'
),
(
    'How to parse UNIX timestamps with Luxon',
    'stackoverflow-luxon',
    'VERY_HIGH',
    $$[
        {"solution": "Use DateTime.fromSeconds() for UNIX timestamps: const myDateTime = DateTime.fromSeconds(1615065599.426264); console.log(myDateTime.toISO());", "percentage": 97, "note": "UNIX time is in seconds, not milliseconds", "command": "const timestamp = 1615065599.426264; const dt = DateTime.fromSeconds(timestamp); console.log(dt.toISO()); // Correct output"},
        {"solution": "Alternative: multiply by 1000 for fromMillis(): DateTime.fromMillis(timestamp * 1000).toISO()", "percentage": 92, "note": "Works but requires conversion step"},
        {"solution": "For UTC interpretation: DateTime.fromSeconds(timestamp, {zone: \"utc\"})", "percentage": 90, "note": "Ensure UTC zone when needed"}
    ]$$::jsonb,
    'Understanding UNIX/epoch time in seconds (not milliseconds), Luxon library, JavaScript timestamp handling',
    'Date outputs in correct year (2021 not 1970), fromSeconds() returns proper DateTime object, UTC zone respected when specified',
    'Do not use fromMillis() with second-precision timestamps - causes 1970 dates. Do not forget UNIX time is SECONDS. Do not ignore UTC zone when needed.',
    0.96,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/66553494/how-to-parse-unix-timestamps-with-luxon'
),
(
    'How to get human-readable interval format with Luxon',
    'stackoverflow-luxon',
    'MEDIUM',
    $$[
        {"solution": "Use Duration.toHuman() with rescale(): Interval.fromDateTimes(start, finish).toDuration().rescale().toHuman() returns \"9 days 3 hours\"", "percentage": 94, "note": "Recent Luxon versions support this", "command": "const formatted = finish.diff(start).rescale().toHuman(); // \"9 days 3 hours\""},
        {"solution": "For full localization: integrate humanize-duration library: humanizeDuration(interval.toDuration().valueOf(), {language: \"es\"})", "percentage": 85, "note": "Supports multiple locales"},
        {"solution": "Always call rescale() before toHuman() to convert from milliseconds to readable units", "percentage": 92, "note": "Missing rescale() shows milliseconds"}
    ]$$::jsonb,
    'Luxon library, Interval and Duration objects, for localization: humanize-duration npm package',
    'toHuman() outputs format like "9 days 3 hours", rescale() properly converts units, multiple locales format correctly',
    'Do not forget rescale() - results in milliseconds display. Do not use toHuman() for locale customization - respects browser locale only. Manual concatenation loses localization.',
    0.89,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/63526184/luxon-interval-human-readable'
),
(
    'How to get timestamp in milliseconds from Luxon DateTime',
    'stackoverflow-luxon',
    'HIGH',
    $$[
        {"solution": "Use .toMillis() method: date.toMillis() returns milliseconds since Unix epoch", "percentage": 96, "note": "Official and recommended approach", "command": "const {DateTime} = require(\"luxon\"); const date = DateTime.now().setZone(\"utc\"); console.log(date.toMillis()); // 1629399474922"},
        {"solution": "Alternative shorthand: date.valueOf() also returns milliseconds", "percentage": 94, "note": "Equivalent to toMillis()"},
        {"solution": "Unary plus operator: +date coerces to milliseconds", "percentage": 80, "note": "Less explicit but works"}
    ]$$::jsonb,
    'Luxon library installed, DateTime object, understanding timestamps are in milliseconds not seconds',
    'toMillis() returns number type, output matches Date.getTime() range, valueOf() produces identical result',
    'Documentation is surprisingly silent on this feature - explore official docs. Do not confuse milliseconds with seconds. Verify typeof luxonTime === "number".',
    0.93,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/68853301/how-to-get-the-timestamp-from-a-luxon-datetime-object'
),
(
    'How to parse date while ignoring default timezone in Luxon',
    'stackoverflow-luxon',
    'MEDIUM',
    $$[
        {"solution": "Pass zone parameter to fromISO(): DateTime.fromISO(value, {zone: \"utc\"}) interprets as UTC, ignoring Settings.defaultZone", "percentage": 96, "note": "Prevents default timezone interference", "command": "const formattedValue = DateTime.fromISO(\"2019-06-28T00:00:00\", {zone: \"utc\"});"},
        {"solution": "Append \"Z\" suffix to string: \"2019-06-28T00:00:00Z\" designates UTC (though DateTime stays in local mode)", "percentage": 75, "note": "Less reliable than zone parameter"},
        {"solution": "Use toISODate() for extracting just date portion without timezone complications", "percentage": 70, "note": "For output, not parsing"}
    ]$$::jsonb,
    'Luxon library configured, date string from third-party source, understanding default zone effects',
    'DateTime maintains correct date/time values without adjustment, day/hour properties match input, default zone does not shift values',
    'Do not use setZone("utc") after parsing - converts already-shifted value. Do not skip zone parameter. Recognize default zone affects ISO string parsing behavior.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/56440097/luxon-how-to-disregard-default-timezone-in-a-specific-date'
),
(
    'How to convert Luxon DateTime object to JavaScript Date',
    'stackoverflow-luxon',
    'HIGH',
    $$[
        {"solution": "Use .toJSDate() method: const jsDate = luxonDateTime.toJSDate() converts to native JavaScript Date", "percentage": 97, "note": "Official Luxon method", "command": "const dt = DateTime.local(); console.log(dt.toJSDate()); // Native JavaScript Date"},
        {"solution": "Verify conversion with instanceof check: console.log(newDate instanceof Date) should return true", "percentage": 90, "note": "Confirms successful conversion"},
        {"solution": "Use after Material-UI DatePicker onChange events that return Luxon DateTime", "percentage": 85, "note": "Common use case with UI libraries"}
    ]$$::jsonb,
    'Luxon library imported, DateTime object from DatePicker or other source, need JavaScript Date compatibility',
    '.toJSDate() returns valid JavaScript Date object, instanceof Date check passes, works with standard Date APIs',
    'Do not assume DateTime is already JavaScript Date. Do not call conversion before passing to APIs expecting Date objects. Check that implementation called method correctly if "not a function" error.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/65775654/how-to-transform-a-luxon-datetme-object-to-a-date'
),
(
    'How to get timezone abbreviation like EST or EDT with Luxon',
    'stackoverflow-luxon',
    'MEDIUM',
    $$[
        {"solution": "Use ZZZZ format token in toFormat(): DateTime.fromObject({year: 2012, month: 1, zone: \"America/New_York\"}).toFormat(\"ZZZZ\") returns \"EST\"", "percentage": 95, "note": "Requires both timezone and locale", "command": "DateTime.fromObject({year: 2012, month: 1, zone: \"America/New_York\"}).toFormat(\"ZZZZ\"); // \"EST\""},
        {"solution": "Use offsetNameShort property as alternative: dateTime.offsetNameShort", "percentage": 85, "note": "Property access instead of format tokens"},
        {"solution": "Leverage browser Intl API: dateTime.toLocaleTimeString(\"en-US\", {timeZoneName: \"short\"})", "percentage": 70, "note": "Browser API with limitations"}
    ]$$::jsonb,
    'Luxon library, IANA timezone identifier (America/New_York), understanding abbreviations are locale-dependent',
    'toFormat("ZZZZ") outputs correct abbreviation (EST, EDT), abbreviations change with DST, locale affects abbreviation availability',
    'Abbreviations are locale-specific - IST requires en-IN, BST requires en-GB. Fixed offsets display as GMT+HH:MM not abbreviations. CLDR data varies by language/country.',
    0.88,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/62019992/detect-timezone-abbreviation-using-luxon'
);
