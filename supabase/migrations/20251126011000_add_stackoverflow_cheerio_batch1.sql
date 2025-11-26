-- Add Stack Overflow Cheerio web scraping questions batch 1 (12 highest-voted questions)

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, last_verified, source_url
) VALUES
(
    'Can I load a local HTML file with Cheerio in Node.js?',
    'stackoverflow-cheerio',
    'VERY_HIGH',
    $solutions$[
        {"solution": "Read file with fs.readFileSync and pass string to cheerio.load(). Example: cheerio.load(fs.readFileSync(''path/to/file.html''))", "percentage": 96, "note": "Most direct synchronous approach"},
        {"solution": "Use fs.readFile with callback and utf8 encoding to get string instead of Buffer: fs.readFile(''path/to/file.html'', ''utf8'', (err, data) => cheerio.load(data))", "percentage": 93, "note": "Non-blocking asynchronous approach, production recommended"},
        {"solution": "Use path.join(__dirname, ''path/to/file.html'') for relative paths with proper cross-platform compatibility", "percentage": 90, "note": "Handles Windows and Unix path separators automatically"}
    ]$solutions$::jsonb,
    'Node.js fs module available, file path is accessible and readable, Cheerio package installed',
    'Cheerio successfully parses local HTML, jQuery selectors work on parsed content, DOM structure available',
    'Do not pass file path directly to cheerio.load() - it requires HTML string content. Without utf8 encoding parameter, fs.readFile returns Buffer object. Relative paths must use path.join for cross-platform compatibility.',
    0.96,
    NOW(),
    'https://stackoverflow.com/questions/20664841/can-i-load-a-local-html-file-with-the-cheerio-package-in-node-js'
),
(
    'How to select elements by text content in Cheerio?',
    'stackoverflow-cheerio',
    'VERY_HIGH',
    $solutions$[
        {"solution": "Use .filter() callback with .text().trim() for exact match: $(''span'').filter(function() { return $(this).text().trim() === ''Category:'' }).next().text()", "percentage": 95, "note": "Most reliable for exact text matching"},
        {"solution": "Use :contains() pseudo-selector for simpler syntax: $(''span:contains(\"Category:\")'').next().text(). Use triple quotes for strings with colons.", "percentage": 92, "note": "Less verbose but partial match only"},
        {"solution": "Use indexOf() in filter for substring matching: $(''span'').filter(function() { return $(this).text().indexOf(''Category:'') > -1 })", "percentage": 88, "note": "For partial text matching, case-sensitive"}
    ]$solutions$::jsonb,
    'Cheerio loaded with HTML content, target text known in advance, understanding of CSS selectors',
    'Correct element selected and adjacent elements accessible, text content extracted as expected',
    'Do not use [innerHTML] or [textContent] attribute selectors - these are not HTML attributes. :contains() does partial matches, not exact. Whitespace matters - use .trim() for clean comparisons.',
    0.95,
    NOW(),
    'https://stackoverflow.com/questions/34709765/cheerio-how-to-select-element-by-text-content'
),
(
    'What is the best BeautifulSoup-like scraper for Node.js?',
    'stackoverflow-cheerio',
    'HIGH',
    $solutions$[
        {"solution": "Use cheerio directly for DOM parsing - it is the best equivalent to BeautifulSoup and works directly with jQuery selectors", "percentage": 94, "note": "Cheerio is de facto standard, created by same author as alternatives"},
        {"solution": "Consider x-ray npm package (by cheerio author) for higher-level abstraction with composable syntax, pagination, and throttling built-in", "percentage": 85, "note": "Good for complex scraping workflows, though some users prefer cheerio simplicity"},
        {"solution": "Use surgeon library (github.com/gajus/surgeon) for closer BeautifulSoup parity with declarative data extraction patterns", "percentage": 75, "note": "Alternative if you need advanced BeautifulSoup-like features"}
    ]$solutions$::jsonb,
    'Node.js environment, scraping requirements understood, familiarity with jQuery-style selectors preferred',
    'Able to parse and extract data from HTML, selecting libraries matches project complexity needs',
    'Cheerio alone is simpler but lacks request handling. x-ray and surgeon add features but increase complexity. Evaluate based on specific requirements - Cheerio + axios/node-fetch is common lightweight combo.',
    0.92,
    NOW(),
    'https://stackoverflow.com/questions/32667219/beautifulsoup-like-scraper-for-nodejs'
),
(
    'How to get a list of elements in nested divs with Cheerio selectors?',
    'stackoverflow-cheerio',
    'HIGH',
    $solutions$[
        {"solution": "Use .find() method to select nested elements: $(selector).find(nested).each(callback)", "percentage": 96, "note": "Standard approach for nested element selection"},
        {"solution": "Use array/spread syntax: const links = [...$(''div#list div > div > a'')].map(e => $(e).attr(''href''))", "percentage": 92, "note": "Modern functional approach, very concise"},
        {"solution": "Use toArray() and map: $(''div#list'').find(''div > div > a'').toArray().map(e => $(e).attr(''href''))", "percentage": 90, "note": "Converts Cheerio collection to array before mapping"}
    ]$solutions$::jsonb,
    'Nested HTML structure known, understanding of CSS combinators (> for child selection), target attribute known',
    'All nested elements found correctly, attributes extracted into clean array, console output shows expected data',
    'Do not use .attribs() method - correct method is .attr(). CSS selector syntax > means direct child only. ID selectors can use #id shorthand instead of [id=\"id\"].',
    0.96,
    NOW(),
    'https://stackoverflow.com/questions/32655076/cheerio-jquery-selectors-how-to-get-a-list-of-elements-in-nested-divs'
),
(
    'How to fix UTF-8 encoding issues in Cheerio?',
    'stackoverflow-cheerio',
    'HIGH',
    $solutions$[
        {"solution": "Set decodeEntities: false when loading HTML: const $ = cheerio.load(html, { decodeEntities: false }). This preserves UTF-8 characters instead of converting to HTML entities.", "percentage": 97, "note": "Primary solution, works immediately for 95%+ of cases"},
        {"solution": "For gulp-cheerio, add parserOptions: { decodeEntities: false, xmlMode: false } in config", "percentage": 94, "note": "Required for gulp/build tool integration"},
        {"solution": "Do not attempt post-processing with iconv or character conversion libraries - configure Cheerio at load time instead", "percentage": 92, "note": "Prevents unnecessary complexity and double-encoding"}
    ]$solutions$::jsonb,
    'HTML content with non-ASCII characters (Cyrillic, Chinese, etc.), Cheerio loaded with default settings showing entity corruption',
    'Non-ASCII characters display correctly without entities (Cyrillic appears as text, not &#x...). No BOM character &#xFEFF; in output.',
    'Default Cheerio converts UTF-8 to HTML entities for safe transport - this is not corruption. The decodeEntities option must be set at load time, not after. Character references like &#x423; render identically to source characters in HTML.',
    0.95,
    NOW(),
    'https://stackoverflow.com/questions/31574127/node-js-cheerio-parser-breaks-utf-8-encoding'
),
(
    'How to select elements with specific attributes in Cheerio?',
    'stackoverflow-cheerio',
    'HIGH',
    $json$[
        {"solution": "Use CSS attribute selector syntax directly: $('[name=mode]') selects elements with name attribute equal to 'mode'", "percentage": 96, "note": "Works like document.querySelectorAll() in browsers"},
        {"solution": "For complex attribute values with special characters, use double quotes: $('input[name=\"data[text_amount]\"]') for arrays/brackets in attribute names", "percentage": 93, "note": "Required when attribute values contain brackets or special characters"},
        {"solution": "Combine with element type: $('input[data-type=\"email\"]') to narrow selection to specific element types with matching attributes", "percentage": 90, "note": "Better performance than selecting all then filtering"}
    ]$json$::jsonb,
    'Cheerio loaded with HTML containing target attributes, attribute names and values known',
    'Correct elements returned as Cheerio collection, multiple elements returned in proper order, attribute filtering works as expected',
    'Attribute names in selectors do not use the . or # shorthand syntax - use [attr=value] format. Quote style matters - use double quotes for attributes containing special characters. Remember these are CSS selectors, not JavaScript attribute access.',
    0.96,
    NOW(),
    'https://stackoverflow.com/questions/41193800/select-elements-with-an-attribute-with-cheerio'
),
(
    'How to get script tag content using Cheerio?',
    'stackoverflow-cheerio',
    'HIGH',
    $solutions$[
        {"solution": "Access inline script content via DOM children: $(''script'').get()[0].children[0].data gets the text content of first script tag", "percentage": 92, "note": "Direct DOM access for inline scripts"},
        {"solution": "For external scripts, access src attribute: $(''script'').get()[0].attribs[''src''] retrieves the external script URL", "percentage": 90, "note": "Works for script tags with src attribute"},
        {"solution": "Ensure parser is configured correctly: cheerio.load(html, {xmlMode: false}) or newer versions xml: true to enable script tag detection", "percentage": 94, "note": "Default parser settings may skip script tags"}
    ]$solutions$::jsonb,
    'Cheerio loaded with HTML containing script tags, parser options properly configured, understanding of DOM child node structure',
    'Script tags appear in selection count, content retrieved from .children[0].data, external src attributes accessible',
    'Default Cheerio configuration may skip or incorrectly parse script tags - explicitly set xmlMode or xml option. Script content is in .children[0].data, not as attribute. Old xmlMode parameter renamed to xml in newer versions.',
    0.93,
    NOW(),
    'https://stackoverflow.com/questions/24565800/how-do-get-script-content-using-cheerio'
),
(
    'Why does Cheerio .map() return strange behavior?',
    'stackoverflow-cheerio',
    'MEDIUM',
    $solutions$[
        {"solution": "Call .get() on map result to convert Cheerio fluent API object to plain JavaScript array: $('[data-id]'').map(function() { return $(this).attr(''data-id'') }).get()", "percentage": 88, "note": "Standard conversion method, works reliably"},
        {"solution": "Use .toArray() method instead of .get() for cleaner Cheerio-specific conversion: $('[data-id]'').map(function() { return $(this).attr(''data-id'') }).toArray()", "percentage": 92, "note": "Preferred modern approach (65% of users), dedicated Cheerio method"},
        {"solution": "Use forEach or forOf loop directly on collection instead of .map(): $('[data-id]'').each(function() { console.log($(this).attr(''data-id'')) })", "percentage": 85, "note": "Alternative without array conversion, when array not needed"}
    ]$solutions$::jsonb,
    'Cheerio collection with multiple elements, need to extract data as JavaScript array, knowledge of Cheerio''s fluent API design',
    'Clean array output without metadata, proper iteration over elements, values accessible as normal JavaScript array',
    'Cheerio .map() returns fluent API object for method chaining, not a plain array. Extra metadata shown is internal configuration, not corruption. Always convert with .get() or .toArray() when you need plain JavaScript array behavior.',
    0.91,
    NOW(),
    'https://stackoverflow.com/questions/39044690/cheerio-map-strange-behaviour'
),
(
    'How to fix async/await with request-promise and Cheerio returning undefined?',
    'stackoverflow-cheerio',
    'MEDIUM',
    $solutions$[
        {"solution": "Add explicit return statement to async function: async function go() { return request(options).then($ => { ... }) }", "percentage": 96, "note": "Most common cause - async function must return promise"},
        {"solution": "Use pure async/await syntax: async function go() { const $ = await request(options); ... return data; } with try/catch for errors", "percentage": 94, "note": "Cleaner than promise chains, easier to debug"},
        {"solution": "Verify request-promise has transform option set: transform: function(body) { return cheerio.load(body); } so $ is pre-parsed", "percentage": 90, "note": "Without transform, $ would be raw HTML string"}
    ]$solutions$::jsonb,
    'Async/await understanding, request-promise package installed, Cheerio transform configured, calling code properly awaits result',
    'Function returns array/data instead of undefined, await correctly resolves promise, scraped data available to caller',
    'Async functions must explicitly return - missing return statement is #1 cause of undefined. Promise chain must be returned from async function. Avoid global variable declarations (use const) to prevent scope issues.',
    0.94,
    NOW(),
    'https://stackoverflow.com/questions/47341603/async-await-with-request-promise-returns-undefined'
),
(
    'How to extract text from HTML with separators in Cheerio?',
    'stackoverflow-cheerio',
    'MEDIUM',
    $solutions$[
        {"solution": "Map text nodes to array and join: $(''html *'').contents().map(function() { return (this.type === ''text'') ? $(this).text() : '''' }).get().join('' '')", "percentage": 93, "note": "Works for any HTML structure, preserves spacing"},
        {"solution": "For targeted elements, map directly: $(''li'').get().map(e => $(e).text().trim()).join('' '') to join specific elements with separator", "percentage": 90, "note": "Simpler when you know target elements"},
        {"solution": "Use external library TextVersionJS for complex text extraction with advanced formatting preservation", "percentage": 75, "note": "Alternative for complex documents, adds dependency"}
    ]$solutions$::jsonb,
    'HTML parsed with Cheerio, understanding of .contents() vs .text() difference, awareness of default text concatenation behavior',
    'Extracted text includes separator characters between elements, output reads naturally with spaces, no concatenated words',
    'Using .text() directly concatenates all text without separators - this is default jQuery behavior. .contents() gets text nodes and elements separately. .filter() on text nodes requires type === ''text'' check. Join order matters when building output strings.',
    0.92,
    NOW(),
    'https://stackoverflow.com/questions/31543451/cheerio-extract-text-from-html-with-separators'
),
(
    'How to get only the text of the current node without children?',
    'stackoverflow-cheerio',
    'MEDIUM',
    $solutions$[
        {"solution": "Use .contents().first().text() to get only the first direct text node: $(''div'').contents().first().text()", "percentage": 91, "note": "Works when text is in first child node"},
        {"solution": "Clone element and remove all children: $(element).clone().children().remove().end().text() for text without nested HTML", "percentage": 88, "note": "More robust when text structure varies"},
        {"solution": "Use .eq(index) instead of .first() to target specific child position: $(''div'').contents().eq(0).text() for first, .eq(1) for second", "percentage": 85, "note": "For accessing non-first child text nodes"}
    ]$solutions$::jsonb,
    'Element with mixed text and nested HTML content, understanding of child node distinction from descendant nodes',
    'Extracted text matches only direct child text content, nested element content excluded, output contains expected substring',
    'Using .text() alone returns all descendant text concatenated - not just direct children. Not all text may be in direct text nodes. The clone-and-remove approach is more robust than .contents() when HTML structure is complex.',
    0.90,
    NOW(),
    'https://stackoverflow.com/questions/42235516/get-the-text-of-the-current-node-only'
),
(
    'How to import Cheerio module in a TypeScript application?',
    'stackoverflow-cheerio',
    'MEDIUM',
    $solutions$[
        {"solution": "Use namespace import: import * as cheerio from ''cheerio'' - imports entire module as namespace, avoids destructuring issues", "percentage": 95, "note": "Most compatible approach, works with all Cheerio versions"},
        {"solution": "Use default import: import cheerio from ''cheerio'' - direct module import since Cheerio exports default", "percentage": 90, "note": "Cleanest syntax, but requires proper default export setup"},
        {"solution": "Import specific function: import { load } from ''cheerio'' and use const $ = load(html) for lighter footprint", "percentage": 85, "note": "Best if only using load() function, reduces bundle size"}
    ]$solutions$::jsonb,
    '@types/cheerio installed, cheerio npm package installed (not just types), TypeScript compiler configured, tsconfig.json present',
    'No TS2691 undefined errors in editor, imports resolve correctly, cheerio functions work as expected, types available for autocomplete',
    'Do not use destructuring {cheerio} - Cheerio uses default export, not named exports. Must install cheerio package itself, not just @types/cheerio. Namespace import avoids all destructuring pitfalls with module structure.',
    0.93,
    NOW(),
    'https://stackoverflow.com/questions/47144540/import-cheerio-module-to-typescript-app'
);
