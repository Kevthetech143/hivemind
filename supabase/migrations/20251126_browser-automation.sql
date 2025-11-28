INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES
(
    'selenium.common.exceptions.WebDriverException: session not created exception from unknown error: Runtime.executionContextCreated has invalid context',
    'browser-automation',
    'HIGH',
    '[
        {"solution": "Update ChromeDriver to a version that matches your Chrome browser version. Download from http://chromedriver.storage.googleapis.com/index.html", "percentage": 95},
        {"solution": "Set environment variable: import os; os.environ[\"LANG\"] = \"en_US.UTF-8\" before creating WebDriver", "percentage": 85}
    ]'::jsonb,
    'ChromeDriver installed, Chrome browser installed, Python Selenium library',
    'WebDriver session is created successfully without exceptions, page loads without errors',
    'Mismatched ChromeDriver and Chrome versions (e.g., ChromeDriver 2.23 with Chrome 54.0). Using outdated ChromeDriver versions. Incorrect LANG environment variable settings.',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/40373801/python-selenium-webdriver-session-not-created-exception-when-opening-chrome',
    'admin:1764173933'
),
(
    'org.openqa.selenium.SessionNotCreatedException: Could not start a new session. Response code 500. Message: session not created: Chrome failed to start: exited normally',
    'browser-automation',
    'HIGH',
    '[
        {"solution": "Verify ChromeDriver version matches your Chrome browser version exactly", "percentage": 90},
        {"solution": "Use Selenium Manager for automatic driver management instead of manual configuration", "percentage": 85},
        {"solution": "Close any existing Chrome instances before launching WebDriver", "percentage": 88}
    ]'::jsonb,
    'ChromeDriver executable in system PATH, Chrome browser installed, Java Selenium library',
    'Session is created without Response code 500 errors, WebDriver initializes successfully',
    'Running multiple ChromeDriver instances simultaneously. Not checking Chrome version compatibility. Attempting to launch while Chrome is already running.',
    0.88,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/77981951/session-not-created-exception-when-starting-chromedriver',
    'admin:1764173933'
),
(
    'playwright._impl._api_types.TimeoutError: Timeout 30000ms exceeded while waiting for event',
    'browser-automation',
    'HIGH',
    '[
        {"solution": "Increase test timeout using test.setTimeout(150000) before waitForTimeout calls", "percentage": 96},
        {"solution": "Configure global timeout in playwright.config.ts: timeout: 120000", "percentage": 92},
        {"solution": "Use page.waitForTimeout() with appropriate millisecond value matching test.setTimeout()", "percentage": 90}
    ]'::jsonb,
    'Playwright test framework installed, browser launched with Playwright, test function defined',
    'Test completes without timeout errors, long-running operations complete successfully',
    'Using default 30 second timeout for operations requiring more time. Not setting timeout before waitForTimeout(). Forgetting to configure timeout in both test and config file.',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/77035874/prevent-playwright-test-from-timing-out-after-30-seconds',
    'admin:1764173933'
),
(
    'unknown error: Element click intercepted: Element is not clickable at point (x, y). Other element would receive the click',
    'browser-automation',
    'CRITICAL',
    '[
        {"solution": "Use JavaScript executor to bypass element interception: driver.execute_script(''arguments[0].click()'', element)", "percentage": 96},
        {"solution": "Wait for element clickability: WebDriverWait(driver, 20).until(EC.element_to_be_clickable((By.XPATH, xpath))).click()", "percentage": 92},
        {"solution": "Scroll element into view before clicking: driver.execute_script(\"arguments[0].scrollIntoView(true);\", element)", "percentage": 90},
        {"solution": "Resize browser window to ensure element is visible: driver.set_window_size(1750, 800)", "percentage": 85}
    ]'::jsonb,
    'Selenium WebDriver initialized, element located via XPath or CSS selector, page fully loaded',
    'Element is clicked successfully without interception errors, page transitions to expected state',
    'Attempting to click without waiting for element readiness. Not accounting for overlays or headers covering the element. Using standard click instead of JavaScript execution when element is obscured.',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/62590059/selenium-element-is-not-clickable-at-point-issue-python',
    'admin:1764173933'
),
(
    'Puppeteer page crashes due to out of memory error after processing multiple pages',
    'browser-automation',
    'CRITICAL',
    '[
        {"solution": "Launch browser with --disable-dev-shm-usage flag: puppeteer.launch({ args: [''--disable-dev-shm-usage''] })", "percentage": 94},
        {"solution": "Close and recreate page for each iteration instead of reusing single page: await page.close(); const newPage = await browser.newPage();", "percentage": 96},
        {"solution": "Implement proper async/await to prevent parallel task execution: Always use ''await'' on asynchronous operations", "percentage": 88}
    ]'::jsonb,
    'Puppeteer installed, Node.js runtime, sufficient system RAM available, browser launched',
    'Page processing completes without out-of-memory crashes, memory usage stays below 500MB for sustained operations',
    'Reusing the same page instance across multiple operations without cleanup. Creating multiple browser instances instead of multiple pages. Not using async/await properly causing uncontrolled parallel execution.',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/54910886/puppeteer-headless-browser-crashes-after-running-out-of-memory',
    'admin:1764173933'
);
