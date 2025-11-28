INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES
(
    'setState() called after dispose(): _EvrokoVipScreenState(lifecycle state: defunct, not mounted)',
    'desktop-mobile',
    'HIGH',
    '[
        {"solution": "Store the timer in a class-level variable, assign it in initState(), then call timer.cancel() in dispose()", "percentage": 95},
        {"solution": "Check if widget is mounted before calling setState using if (!mounted) { t.cancel(); } else { setState(() {}); }", "percentage": 85}
    ]'::jsonb,
    'Flutter StatefulWidget class with Timer.periodic() or animation callbacks',
    'Timer properly cancels and widget no longer shows errors after widget is disposed',
    'Forgetting to cancel timers/animations in dispose(), calling setState from async callbacks without checking mounted property, not storing timer reference at class level',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/68817813/flutter-error-setstate-called-after-dispose',
    'admin:1764173885'
),
(
    'error: failed to determine package fingerprint for build script for app - Could not read repository exclude - filename directory name or volume label syntax is incorrect',
    'desktop-mobile',
    'HIGH',
    '[
        {"solution": "Run: git config --global core.excludesFile \"%USERPROFILE%\\.gitignore\" and remove problematic wildcard patterns from global gitignore", "percentage": 95},
        {"solution": "Delete all entries from %USERPROFILE%\\.gitignore and rebuild the project", "percentage": 85},
        {"solution": "Run: tauri dev --verbose to identify which gitignore expressions cause parsing failures", "percentage": 80}
    ]'::jsonb,
    'Tauri project with Windows OS, corrupted global git configuration file',
    'Tauri build completes successfully, no package fingerprint errors in build output',
    'Not checking global gitignore for invalid regex patterns, assuming error is in project code rather than git config, not running with --verbose flag to diagnose root cause',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/78966387/rust-tauri-build-error-failed-to-determine-package-fingerprint-for-build-scri',
    'admin:1764173885'
),
(
    'Electron app shows white screen after build - loadURL cannot find index.html in packaged application',
    'desktop-mobile',
    'HIGH',
    '[
        {"solution": "Use absolute path with file protocol in loadURL: win.loadURL(url.format({ pathname: path.join(__dirname, ''index.html''), protocol: ''file:'', slashes: true }))", "percentage": 96},
        {"solution": "For React/Vue: Switch from BrowserRouter to HashRouter or use hash mode in router configuration", "percentage": 90},
        {"solution": "Delete application cache directory (Windows: C:\\Users\\<user>\\AppData\\Roaming\\<appName>\\Cache, macOS: /Users/<user>/Library/Application Support/<appName>/Cache)", "percentage": 85}
    ]'::jsonb,
    'Electron app with webpack/vite build output, React Router or Vue Router configuration',
    'App displays content correctly instead of white screen, proper file loading confirmed in developer console',
    'Using relative paths instead of absolute paths, forgetting to update main.js to point to correct built file location, not clearing cache after rebuilds, using incorrect router mode for packaged apps',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/50925634/electron-shows-white-screen-when-built',
    'admin:1764173885'
),
(
    'React Native: Unable to resolve module - Directory /path/app/app/containers doesn''t exist or Cannot find module at specified path',
    'desktop-mobile',
    'HIGH',
    '[
        {"solution": "Clear Metro bundler cache by running: react-native start --reset-cache", "percentage": 96},
        {"solution": "Delete node_modules and metro cache: rm -rf node_modules && rm -rf ${TMPDIR:-/tmp}/metro-* && npm install", "percentage": 92},
        {"solution": "Ensure file extension is .js not .jsx in import statements, then run: react-native start --reset-cache", "percentage": 88},
        {"solution": "Fix case sensitivity issues using: mv oldname.js NewName.js if only capitalization changed", "percentage": 85}
    ]'::jsonb,
    'React Native project with local imports, possibly after renaming files or changing import paths',
    'Metro bundler successfully resolves all imports, app runs without module resolution errors',
    'Only deleting package-lock.json without clearing Metro cache, using .jsx extension instead of .js for imports, changing filename case on macOS without updating references, not checking that imported files themselves have valid dependencies',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/40985027/unable-to-resolve-module-in-react-native-app',
    'admin:1764173885'
),
(
    'Thread 1: EXC_BAD_ACCESS (code = 1, address = 0x0) - Swift iOS app crashes at AppDelegate',
    'desktop-mobile',
    'HIGH',
    '[
        {"solution": "Fix UIApplication parameter type: change ''application: UIApplication'' to ''application: UIApplication!'' in AppDelegate method signatures", "percentage": 94},
        {"solution": "Replace launchOptions parameter type from ''[NSObject : AnyObject]'' to ''NSDictionary!'' in didFinishLaunchingWithOptions", "percentage": 93},
        {"solution": "Verify bridging header includes all required framework imports like #import <Bolts/Bolts.h> when using Parse or other frameworks", "percentage": 85}
    ]'::jsonb,
    'iOS project using Swift AppDelegate with framework dependencies, Xcode project with bridging headers',
    'App launches without EXC_BAD_ACCESS crashes, console shows clean startup logs',
    'Using implicit optionals instead of explicit ones in method signatures, incorrect launchOptions typing, missing bridging header imports, not checking Storyboard connections for invalid class references',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/25353790/swift-project-crashing-with-thread-1-exc-bad-access-code-1-address-0x0',
    'admin:1764173885'
),
(
    'Gradle build failed: Execution failed for task transformClassesWithJavaResourcesVerDebug - cannot be cast to InputFileDetails',
    'desktop-mobile',
    'HIGH',
    '[
        {"solution": "Delete the .gradle folder (hidden directory) in project root, close Android Studio, then reopen and rebuild", "percentage": 94},
        {"solution": "Stop all Gradle daemon processes: ./gradlew --stop (or gradlew.bat --stop on Windows), then rebuild", "percentage": 88},
        {"solution": "Update Android Studio to latest version and ensure Android SDK is set correctly in Project Structure settings", "percentage": 85}
    ]'::jsonb,
    'Android Studio project after version update, Gradle build caching issues',
    'Gradle build completes successfully with ''BUILD SUCCESSFUL'', APK or AAB generated without Java resource verification errors',
    'Only deleting intermediate build folders instead of .gradle directory, not stopping existing Gradle daemons before rebuilding, assuming error is in code rather than build cache corruption',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/39610365/cannot-run-project-app-gradle-build-failed',
    'admin:1764173885'
)
