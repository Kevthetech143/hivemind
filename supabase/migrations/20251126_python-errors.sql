INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES
(
    'pyenv: python: command not found',
    'python',
    'HIGH',
    '[
        {"solution": "Run pyenv global <version> to set global Python version explicitly", "percentage": 95},
        {"solution": "Add pyenv initialization to shell config: eval \"$(pyenv init -)\" in ~/.bashrc or ~/.zshrc", "percentage": 92},
        {"solution": "Run pyenv rehash to regenerate shims after installation", "percentage": 85}
    ]'::jsonb,
    'Python version installed via pyenv, shell config file access',
    'python --version shows the correct version, pyenv which python returns expected path',
    'Not setting global version, incomplete shell initialization, stale shims',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/51863225/pyenv-python-command-not-found',
    'admin:1764173170'
),
(
    'Response to preflight request doesn''t pass access control check',
    'python',
    'HIGH',
    '[
        {"solution": "Install flask-cors: pip install -U flask-cors and use @cross_origin() decorator on routes", "percentage": 96},
        {"solution": "Ensure API endpoint URL matches exactly (trailing slash consistency)", "percentage": 90},
        {"solution": "When using blueprints, wrap with CORS(blueprint) after blueprint creation", "percentage": 88}
    ]'::jsonb,
    'Flask application, browser making CORS requests from different origin',
    'Browser request succeeds without CORS error, preflight OPTIONS request returns 200',
    'Forgetting to apply CORS to blueprints, inconsistent URL paths with trailing slashes',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/61955973/issue-with-flask-cors-blocked-by-cors-policy-response-to-preflight-request-do',
    'admin:1764173170'
),
(
    'Django admin site not loading CSS styles',
    'python',
    'HIGH',
    '[
        {"solution": "Set DEBUG = True in settings.py to enable static file serving in development", "percentage": 97},
        {"solution": "Run python manage.py collectstatic to collect admin static files", "percentage": 93},
        {"solution": "Verify django.contrib.staticfiles is in INSTALLED_APPS", "percentage": 91}
    ]'::jsonb,
    'Django project with admin interface, static files configured',
    'Admin pages display with CSS styling applied, no 404 errors for CSS files',
    'Forgetting DEBUG=True in development, not running collectstatic, missing staticfiles app',
    0.95,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/4420378/why-does-my-django-admin-site-not-have-styles-css-loading',
    'admin:1764173170'
),
(
    'OSError: [Errno 13] Permission denied when pip install',
    'python',
    'HIGH',
    '[
        {"solution": "Use virtual environment: virtualenv .venv && source .venv/bin/activate", "percentage": 98},
        {"solution": "Install with --user flag: pip install --user package_name", "percentage": 92},
        {"solution": "Never use sudo pip - creates security risk, avoid chown on system directories", "percentage": 95}
    ]'::jsonb,
    'pip and Python installed, user account without system admin privileges',
    'Package installs successfully, pip list shows newly installed package',
    'Running sudo pip install (security vulnerability), attempting chown recursively on /usr/local',
    0.96,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/31512422/pip-install-failing-with-oserror-errno-13-permission-denied-on-directory',
    'admin:1764173170'
),
(
    'ImportError: No module named <module_name>',
    'python',
    'HIGH',
    '[
        {"solution": "Ensure __init__.py exists in package directory (exact filename, not __init__.py.bin)", "percentage": 94},
        {"solution": "Set PYTHONPATH: export PYTHONPATH=.:/usr/local/lib/python", "percentage": 88},
        {"solution": "Use matching Python versions: if pip3 installed, use python3 to run scripts", "percentage": 91}
    ]'::jsonb,
    'Python project with package imports, pip packages installed',
    'Module imports successfully, python script runs without ImportError',
    'Wrong Python version mix (pip3 install + python command), missing __init__.py, IDE not marking source root',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/338768/python-error-importerror-no-module-named',
    'admin:1764173170'
),
(
    'ModuleNotFoundError: No module named when running from subdirectory',
    'python',
    'HIGH',
    '[
        {"solution": "Run as module from project root: python -m src.main instead of python src/main.py", "percentage": 96},
        {"solution": "Move main.py to project root alongside package directories", "percentage": 89},
        {"solution": "Install project as editable package: pip install -e . with setup.py", "percentage": 87}
    ]'::jsonb,
    'Python project with nested source structure, PYTHONPATH not configured',
    'Script imports sibling packages successfully, no ModuleNotFoundError on startup',
    'Running script from subdirectory, not using -m flag, incorrect relative imports',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/61532337/python-modulenotfounderror-no-module-named',
    'admin:1764173170'
),
(
    'IndentationError: unexpected indent',
    'python',
    'HIGH',
    '[
        {"solution": "Use Python-aware editor (VS Code, PyCharm) that auto-manages indentation", "percentage": 93},
        {"solution": "Convert all tabs to spaces (PEP 8 recommends 4 spaces per indent level)", "percentage": 94},
        {"solution": "Run python -tt yourfile.py to detect tab/space inconsistencies", "percentage": 85}
    ]'::jsonb,
    'Python source code with multiple indentation levels',
    'Code runs without IndentationError, linter shows clean indentation',
    'Mixed tabs and spaces, copy-pasting code from web, incomplete code blocks without colons',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/1016814/what-should-i-do-with-unexpected-indent-in-python',
    'admin:1764173170'
),
(
    'TypeError: unsupported operand type(s) for -: ''str'' and ''int''',
    'python',
    'HIGH',
    '[
        {"solution": "Convert string to int immediately: num = int(input(\"prompt\"))", "percentage": 97},
        {"solution": "Use type annotations to catch type errors: def func(n: int) -> int", "percentage": 85},
        {"solution": "Replace while loop with for loop: for i in range(n) instead of manual iteration", "percentage": 80}
    ]'::jsonb,
    'Python script with input() or arithmetic operations',
    'Numeric operations complete without TypeError, values compute correctly',
    'Forgetting input() returns string, mixing str and int in arithmetic without conversion',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/2376464/typeerror-unsupported-operand-types-for-str-and-int',
    'admin:1764173170'
),
(
    'IndexError: list index out of range',
    'python',
    'HIGH',
    '[
        {"solution": "Check list length before access: verify index < len(list)", "percentage": 96},
        {"solution": "Use defensive programming: add if index < len(list) check before accessing", "percentage": 92},
        {"solution": "Use list slicing or get() pattern to safely access elements", "percentage": 85}
    ]'::jsonb,
    'Python list operations, loop iteration over lists',
    'List elements accessed successfully, no IndexError raised, correct values retrieved',
    'Off-by-one errors in loops, accessing hardcoded indices without bounds checking',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/16005707/index-error-list-index-out-of-range-python',
    'admin:1764173170'
),
(
    'KeyError: dictionary key doesn''t exist',
    'python',
    'HIGH',
    '[
        {"solution": "Use dict.get() method with default: meta_entry.get(''path'', None)", "percentage": 97},
        {"solution": "Check if key exists first: if ''path'' in meta_entry: before accessing", "percentage": 93},
        {"solution": "Use try-except: try: value = dict[key] except KeyError: handle_error()", "percentage": 88}
    ]'::jsonb,
    'Python dictionary operations with potentially missing keys',
    'Code handles missing keys gracefully, no KeyError exceptions on execution',
    'Direct key access without checking, forgetting to use .get() for optional keys',
    0.95,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/10116518/im-getting-key-error-in-python',
    'admin:1764173170'
),
(
    'ValueError: invalid literal for int() with base 10',
    'python',
    'HIGH',
    '[
        {"solution": "Check for empty strings before conversion: if data: int(data)", "percentage": 94},
        {"solution": "Use try-except for invalid inputs: try: int(data) except ValueError: handle()", "percentage": 91},
        {"solution": "Convert via float first for decimal strings: int(float(''5.0''))", "percentage": 87}
    ]'::jsonb,
    'Python code converting user input or strings to integers',
    'String-to-int conversion succeeds, numeric operations complete without ValueError',
    'Empty strings, decimal points in strings, non-numeric characters in input',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/1841565/valueerror-invalid-literal-for-int-with-base-10',
    'admin:1764173170'
),
(
    'AttributeError: ''NoneType'' object has no attribute',
    'python',
    'HIGH',
    '[
        {"solution": "Check if variable is not None before accessing: if var is not None:", "percentage": 96},
        {"solution": "Ensure functions return values explicitly, don''t rely on implicit None return", "percentage": 94},
        {"solution": "Use is/is not for None comparison, never use == which can trigger __eq__", "percentage": 91}
    ]'::jsonb,
    'Python functions returning optional values, attribute access on potentially None objects',
    'Code executes without AttributeError, None checks pass, attribute access succeeds',
    'Missing return statements in functions, accessing attributes on .sort() results, wrong None comparison',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/8949252/why-do-i-get-attributeerror-nonetype-object-has-no-attribute-something',
    'admin:1764173170'
);
