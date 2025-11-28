INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'pyenv: version command not found',
    'python',
    'HIGH',
    '[
        {"solution": "Run `eval \"$(pyenv init -)\"` in your shell and add to .zshrc/.bashrc: export PYENV_ROOT=\"$HOME/.pyenv\" and export PATH=\"$PYENV_ROOT/bin:$PATH\"", "percentage": 95},
        {"solution": "Ensure pyenv is in PATH: type pyenv should return the pyenv executable path, not a function", "percentage": 85}
    ]'::jsonb,
    'pyenv installed and Python version already installed',
    'Running `pyenv which python` returns the path to the Python executable',
    'Forgetting to add pyenv init to shell configuration files; using wrong shell init file (.bashrc vs .zshrc)',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/51863225/pyenv-python-command-not-found'
),
(
    'pyenv: version X.Y.Z not installed',
    'python',
    'HIGH',
    '[
        {"solution": "Install the version: run `pyenv install X.Y.Z` where X.Y.Z is your desired version", "percentage": 98},
        {"solution": "List available versions: `pyenv versions` shows installed versions; `pyenv install --list` shows available", "percentage": 90}
    ]'::jsonb,
    'pyenv installed',
    'After running `pyenv install X.Y.Z`, the version appears in `pyenv versions` output',
    'Trying to use system Python that pyenv can''t find; confusing pyenv version names with different naming schemes',
    0.95,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/36356778/how-to-let-pyenv-to-find-installed-python-versions'
),
(
    'Response to preflight request doesn''t pass access control check: It does not have HTTP ok status',
    'python',
    'HIGH',
    '[
        {"solution": "Ensure flask-cors is properly initialized: use CORS(app) or CORS(resources={r\"/*\": {\"origins\": \"*\"}}) at application startup", "percentage": 92},
        {"solution": "Handle OPTIONS requests: add `@app.before_request` to return 200 OK for OPTIONS preflight requests", "percentage": 88},
        {"solution": "Ensure your 404 handler also returns CORS headers: wrap the 404 error handler with @cross_origin() or return proper headers", "percentage": 85}
    ]'::jsonb,
    'Flask application with flask-cors installed',
    'Browser XHR requests complete successfully without CORS policy errors; preflight OPTIONS request returns 200 status code',
    'Forgetting to initialize CORS on the Flask app; not handling OPTIONS method for routes; having 404 handlers that don''t pass CORS preflight checks',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/61955973/issue-with-flask-cors-blocked-by-cors-policy-response-to-preflight-request-do'
),
(
    'Django admin site CSS not loading - static files return 404',
    'python',
    'HIGH',
    '[
        {"solution": "Add to urls.py: from django.conf import settings; from django.conf.urls.static import static; then append `+ static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)` to urlpatterns", "percentage": 94},
        {"solution": "Ensure DEBUG=True in development (in production, use collectstatic and serve with nginx/apache)", "percentage": 92},
        {"solution": "Verify STATIC_URL = \"/static/\" and STATIC_ROOT = BASE_DIR / \"static\" are set in settings.py", "percentage": 90}
    ]'::jsonb,
    'Django project with admin app installed, DEBUG=True in development',
    'Django admin page loads with CSS styling applied, /static/admin/css/login.css returns 200 (not 404)',
    'Running in production with DEBUG=False without proper static file serving; incorrect STATIC_ROOT path; forgetting to add static() to urlpatterns',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/4420378/why-does-my-django-admin-site-not-have-styles-css-loading'
),
(
    'Django makemigrations detects no changes',
    'python',
    'HIGH',
    '[
        {"solution": "Verify model changes are saved in models.py file", "percentage": 90},
        {"solution": "Check that the app is in INSTALLED_APPS in settings.py", "percentage": 95},
        {"solution": "Run `python manage.py makemigrations app_name` explicitly (specify app), not just `makemigrations`", "percentage": 85},
        {"solution": "Ensure migrations folder exists with __init__.py file in the app directory", "percentage": 88}
    ]'::jsonb,
    'Django project with apps in INSTALLED_APPS, model changes made',
    'Running `python manage.py makemigrations` creates new migration files in migrations/ directory',
    'Modifying models but not saving the file; app not in INSTALLED_APPS; trying to makemigrations without specifying app name when multiple apps exist',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/django'
),
(
    'pip install permission denied: [Errno 13] Permission denied',
    'python',
    'HIGH',
    '[
        {"solution": "Use --user flag: `pip install --user package_name` to install in user directory", "percentage": 96},
        {"solution": "Use a virtual environment: `python -m venv venv` then activate with `source venv/bin/activate` then `pip install package_name`", "percentage": 98},
        {"solution": "As last resort, use sudo: `sudo python -m pip install package_name` (not recommended, use venv instead)", "percentage": 70}
    ]'::jsonb,
    'pip installed, Python 2.7+ or 3.6+',
    'Package successfully installed; `pip show package_name` shows the installed package; import works in Python',
    'Using sudo with pip can cause permission issues; not using virtual environments; mixing user and system packages',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/31172719/pip-install-access-denied-on-windows'
),
(
    'Flask 404 Not Found: The requested URL was not found on the server',
    'python',
    'HIGH',
    '[
        {"solution": "Verify route is defined with @app.route() decorator; check for typos in the URL path", "percentage": 95},
        {"solution": "Check trailing slashes: if route is @app.route(\"/path\"), don''t call /path/ - Flask is strict about this", "percentage": 92},
        {"solution": "Ensure the Flask app is actually running the code with the route defined (not a different instance)", "percentage": 88},
        {"solution": "For base URL 404, define a catch-all root route: @app.route(\"/\") or @app.route()", "percentage": 90}
    ]'::jsonb,
    'Flask application running, route defined with @app.route',
    'Accessing the route URL returns the expected response (200 status), not 404',
    'Trailing slash mismatch between route definition and URL access; route defined in different app instance; typos in route path; root URL not defined when accessing app root',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/24437248/unexplainable-flask-404-errors'
),
(
    'pip permission denied: /usr/local/lib/python3.x/site-packages',
    'python',
    'HIGH',
    '[
        {"solution": "Fix file permissions: `sudo chown -R $USER /usr/local/lib/python3.x/site-packages`", "percentage": 85},
        {"solution": "Use virtual environment instead: `python3 -m venv venv` then `source venv/bin/activate` then `pip install`", "percentage": 98},
        {"solution": "Use --user install: `pip install --user package_name` installs to ~/.local/lib/python3.x", "percentage": 94}
    ]'::jsonb,
    'pip installed, write access issue to site-packages',
    'Package installed successfully; import works without errors; pip show displays package info',
    'Trying to use sudo with pip (creates root-owned packages); not using virtual environments; mixing Apple Python with Homebrew Python',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/31512422/pip-install-failing-with-oserror-errno-13-permission-denied-on-directory'
),
(
    'pandas MemoryError: Unable to allocate X.XX GiB for large CSV file',
    'python',
    'HIGH',
    '[
        {"solution": "Read file in chunks: pd.read_csv(\"file.csv\", chunksize=10000) and process each chunk", "percentage": 95},
        {"solution": "Use specific data types: pd.read_csv(\"file.csv\", dtype={\"col\": \"int32\"}) to reduce memory usage", "percentage": 90},
        {"solution": "Use only needed columns: pd.read_csv(\"file.csv\", usecols=[\"col1\", \"col2\"]) to skip unnecessary columns", "percentage": 92},
        {"solution": "Use parquet or HDF5 instead of CSV: more efficient formats for large data", "percentage": 88}
    ]'::jsonb,
    'pandas installed, large CSV file, limited system RAM',
    'Data loaded successfully; no MemoryError; script completes without crashing',
    'Loading entire large file at once; using default object dtype for all columns; loading unnecessary columns; not using compression',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/pandas'
),
(
    'ModuleNotFoundError: No module named X after pip install',
    'python',
    'HIGH',
    '[
        {"solution": "Verify you''re using the correct Python interpreter: which python should match the pip you used", "percentage": 93},
        {"solution": "Activate virtual environment if using one: source venv/bin/activate before importing", "percentage": 96},
        {"solution": "Verify package is installed: pip list | grep package_name", "percentage": 94},
        {"solution": "Restart your Python interpreter or IDE after pip install to reload module paths", "percentage": 85}
    ]'::jsonb,
    'pip install completed successfully without errors',
    'Importing module works without ModuleNotFoundError; pip list shows the package',
    'Using wrong Python interpreter (system vs venv); not activating virtual environment; installing to one Python but running another; IDE caching old imports',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/python'
),
(
    'TypeError: string indices must be integers, not str - accessing dict with wrong key type',
    'python',
    'HIGH',
    '[
        {"solution": "Check variable is a dict, not a string: use type(var) in debugger to verify", "percentage": 94},
        {"solution": "Ensure you''re accessing with correct key: dict[key] not dict.key if key is a string", "percentage": 92},
        {"solution": "Verify the variable contains expected data structure from API/JSON parse: print(json.dumps(var, indent=2))", "percentage": 90}
    ]'::jsonb,
    'Python 3.6+, dict variable expected',
    'Code runs without TypeError; accessing dictionary values returns expected results',
    'Accidentally treating string as dict; confusing bracket notation dict[key] with dot notation dict.key; API returning string instead of JSON object',
    0.88,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/python'
),
(
    'Django migration circular dependency detected',
    'python',
    'MEDIUM',
    '[
        {"solution": "Remove circular imports: ensure models.py doesn''t import from views.py or vice versa", "percentage": 92},
        {"solution": "Use string references for ForeignKey: ForeignKey(\"AppName.ModelName\") instead of importing the model", "percentage": 94},
        {"solution": "Use app_label if using models outside standard location: ForeignKey(\"app.Model\", app_label=\"myapp\")", "percentage": 85}
    ]'::jsonb,
    'Django project with multiple apps and models',
    'Migrations run successfully; python manage.py migrate completes without circular dependency error',
    'Importing models in __init__.py causing circular imports; ForeignKey pointing to another app with reverse import; not using string references for forward references',
    0.89,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/django'
),
(
    'Flask ImportError: cannot import name from flask',
    'python',
    'MEDIUM',
    '[
        {"solution": "Check Flask version: some imports were moved between versions; verify from flask docs which version you have", "percentage": 90},
        {"solution": "Ensure you''re importing from flask not from external package: from flask import render_template not from some_lib", "percentage": 94},
        {"solution": "Check for naming conflicts: don''t name your file flask.py as it shadows the package", "percentage": 96}
    ]'::jsonb,
    'Flask installed and importable',
    'Imports work correctly; from flask import X succeeds; script runs without ImportError',
    'Naming your script flask.py (shadows the real package); using old import syntax from old Flask versions; installing wrong package name (typo)',
    0.87,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/flask'
),
(
    'Python FileNotFoundError: [Errno 2] No such file or directory',
    'python',
    'HIGH',
    '[
        {"solution": "Verify file path is correct: use absolute path or ensure relative path from current working directory", "percentage": 96},
        {"solution": "Check if file exists: os.path.exists(file_path) before opening", "percentage": 95},
        {"solution": "Verify current directory: print(os.getcwd()) to see where Python is looking for relative paths", "percentage": 94},
        {"solution": "Use pathlib for cross-platform paths: Path(\"data\") / \"file.csv\" instead of \"data/file.csv\"", "percentage": 88}
    ]'::jsonb,
    'Python 3.6+, file expected to exist',
    'File opens successfully; data loaded without FileNotFoundError',
    'Using relative path without checking working directory; path has typos; moving script to different directory without updating paths; Windows vs Unix path separators',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/python'
),
(
    'RuntimeError: No application found. Either work inside view function or push an application context',
    'python',
    'MEDIUM',
    '[
        {"solution": "Use Flask app context: with app.app_context(): ... for code outside request", "percentage": 97},
        {"solution": "Use Flask request context: with app.test_request_context(): ... for testing views", "percentage": 95},
        {"solution": "For CLI commands, use @app.shell_context_processor to provide app context", "percentage": 88}
    ]'::jsonb,
    'Flask application, code accessing flask.current_app outside request',
    'Code runs without RuntimeError; current_app is accessible; app context properly established',
    'Accessing current_app outside any context; running Flask code in separate thread without context; Flask shell without proper context setup',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/flask'
),
(
    'Django.core.exceptions.ImproperlyConfigured: Requested setting DEBUG with no settings module',
    'python',
    'MEDIUM',
    '[
        {"solution": "Set DJANGO_SETTINGS_MODULE: export DJANGO_SETTINGS_MODULE=myproject.settings before running", "percentage": 98},
        {"solution": "Run Django code from manage.py scripts or within Django shell: python manage.py shell", "percentage": 96},
        {"solution": "Use django.setup() in standalone scripts: import django; django.setup() after setting DJANGO_SETTINGS_MODULE env var", "percentage": 94}
    ]'::jsonb,
    'Django project with settings.py configured',
    'Django commands run successfully; settings module is loaded; no ImproperlyConfigured error',
    'Running Django code outside manage.py without proper setup; forgetting to set DJANGO_SETTINGS_MODULE; running from wrong directory',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/django'
),
(
    'IndentationError: expected an indented block after function definition',
    'python',
    'HIGH',
    '[
        {"solution": "Ensure first line after function definition (or if/for/class) is indented: must be 4 spaces or 1 tab", "percentage": 98},
        {"solution": "Use pass statement if function body is empty: def func(): pass", "percentage": 97},
        {"solution": "Check for mixed tabs and spaces: Python is strict about consistent indentation", "percentage": 94}
    ]'::jsonb,
    'Python 3.6+, file with functions or control structures',
    'Script parses and runs without IndentationError; functions execute correctly',
    'Mixing tabs and spaces; forgetting to indent code block; empty function without pass statement; copy-pasted code with different indentation',
    0.97,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/python'
),
(
    'UnicodeDecodeError: ''utf-8'' codec can''t decode byte in position X',
    'python',
    'MEDIUM',
    '[
        {"solution": "Specify encoding when opening file: open(\"file.txt\", encoding=\"utf-8\") or encoding=\"latin-1\"", "percentage": 96},
        {"solution": "Try alternative encodings: latin-1, cp1252, or iso-8859-1 for legacy files", "percentage": 92},
        {"solution": "Use errors parameter: open(\"file.txt\", encoding=\"utf-8\", errors=\"ignore\") to skip bad characters", "percentage": 88}
    ]'::jsonb,
    'Python file reading with non-UTF8 encoded files',
    'File reads successfully without UnicodeDecodeError; text content accessible',
    'Assuming all files are UTF-8 encoded; not specifying encoding for non-ASCII files; mixing encodings in same file',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/python'
),
(
    'KeyError: key not found in dictionary - accessing non-existent dict key',
    'python',
    'HIGH',
    '[
        {"solution": "Use .get() method with default: dict.get(\"key\", default_value) instead of dict[\"key\"]", "percentage": 98},
        {"solution": "Check if key exists first: if \"key\" in dict: then access dict[\"key\"]", "percentage": 96},
        {"solution": "For nested dicts, use: dict.get(\"level1\", {}).get(\"level2\", None)", "percentage": 94}
    ]'::jsonb,
    'Python 3.6+, dictionary access',
    'No KeyError raised; code handles missing keys gracefully; default values returned as expected',
    'Not checking if key exists before accessing; assuming API response has all keys; not using get() for optional dict values',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/python'
),
(
    'AttributeError: ''module'' object has no attribute - missing attribute on imported module',
    'python',
    'MEDIUM',
    '[
        {"solution": "Verify correct import name: ensure module exports the attribute; check docs or use dir(module)", "percentage": 94},
        {"solution": "Use correct import syntax: from module import submodule not import module.submodule (for some packages)", "percentage": 92},
        {"solution": "Check module version: attribute may not exist in older versions; upgrade package with pip install --upgrade", "percentage": 88}
    ]'::jsonb,
    'Python 3.6+, installed module',
    'Attribute access succeeds; module attribute is available; import works as expected',
    'Typo in attribute name; importing wrong module version; using private attributes (_name); API changed between versions',
    0.89,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/python'
),
(
    'ValueError: too many values to unpack - unpacking wrong number of variables',
    'python',
    'MEDIUM',
    '[
        {"solution": "Match variable count to iterable length: a, b = [1, 2] not a, b, c = [1, 2]", "percentage": 97},
        {"solution": "Use * to collect remaining values: a, *rest = [1, 2, 3, 4]", "percentage": 95},
        {"solution": "Check function return values: ensure function returns tuple with expected number of values", "percentage": 92}
    ]'::jsonb,
    'Python 3.6+, tuple/list unpacking',
    'Unpacking works correctly; variables assigned expected values; no ValueError',
    'Assuming function returns single value when it returns tuple; list length mismatch; unpacking dict instead of items()',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/python'
);
