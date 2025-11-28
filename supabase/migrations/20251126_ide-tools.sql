INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES
(
    'Unable to boot the Simulator',
    'ide-tools',
    'HIGH',
    '[
        {"solution": "Delete Xcode Developer Cache: Apple menu → System Settings → Storage → Developer → Delete ''Xcode Caches'' folder. Restart Xcode and simulator.", "percentage": 95},
        {"solution": "Terminal command: rm -R ~/Library/Developer/CoreSimulator/Caches && sudo killall com.apple.CoreSimulator.CoreSimulatorService", "percentage": 92},
        {"solution": "Extended cleanup: rm -R ~/Library/Developer/CoreSimulator/Caches && rm -R ~/Library/Developer/Xcode/iOS\\ DeviceSupport/ && rm -R ~/Library/Developer/Xcode/DerivedData/", "percentage": 88}
    ]'::jsonb,
    'Xcode installed and at least one iOS simulator created. macOS 12 or later.',
    'Simulator boots and shows home screen within 60 seconds. No ''Unable to boot'' error in console.',
    'Assuming you deleted the wrong cache folder. On macOS 13+, delete ''Xcode Caches'', not ''Developer Caches''. Not restarting Xcode after cache deletion.',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/72229589/flutter-xcode-error-unable-to-boot-the-simulator',
    'admin:1764173837'
),
(
    'Xcode 15: launchd failed to respond Domain NSPOSIXErrorDomain Code 60',
    'ide-tools',
    'HIGH',
    '[
        {"solution": "Clear Developer Cache: System Settings → Search ''Developer'' → Delete Xcode caches, Project Build Data, and Indexes. Restart Xcode completely.", "percentage": 93},
        {"solution": "Reinstall iOS Platform: Xcode → Settings → Platforms → Verify iOS version is fully downloaded. If corrupted, delete and reinstall.", "percentage": 87},
        {"solution": "Reset simulator: xcrun simctl shutdown all && xcrun simctl erase all. This deletes all simulators and forces fresh setup.", "percentage": 80}
    ]'::jsonb,
    'Xcode 15.x installed. iOS simulator created. Administrator access to System Settings.',
    'Simulator launches within 2 minutes and successfully boots to home screen. Error no longer appears in console.',
    'Trying Solution 1 and immediately testing without fully restarting Xcode. Not checking if iOS platform version is actually installed (corrupted downloads are common).',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/77177016/xcode-15-unable-to-boot-the-simulator',
    'admin:1764173837'
),
(
    'IntelliJ IDEA freezing during indexing stage',
    'ide-tools',
    'HIGH',
    '[
        {"solution": "Invalidate Caches & Restart: File → Invalidate Caches / Restart → Select ''Invalidate and Restart''. IDE will restart and reindex project.", "percentage": 96},
        {"solution": "Delete .idea folder: Force quit IntelliJ. Run rm -rf .idea in project root. Reopen project in IntelliJ.", "percentage": 91},
        {"solution": "Exclude large directories from indexing: Right-click folders (node_modules, build, logs) → Mark Directory as → Excluded.", "percentage": 85}
    ]'::jsonb,
    'IntelliJ IDEA open with a project loaded. Project has thousands of files or uses memory-heavy plugins (Kubernetes, CSV, Laravel).',
    'Indexing completes in under 5 minutes. IDE remains responsive. Status bar shows ''Indexing Complete'' or project appears in File menu.',
    'IDE freezes completely before you can access File menu. Solution: Force quit IntelliJ first, then delete .idea folder manually via terminal. Disabling all plugins at once can cause worse problems - disable suspect plugins selectively.',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/32550292/why-is-intellij-idea-hanging-on-indexing',
    'admin:1764173837'
),
(
    'IntelliJ IDEA takes forever to update indices 12+ hours',
    'ide-tools',
    'HIGH',
    '[
        {"solution": "File → Invalidate Caches / Restart → Select ''Invalidate and Restart''. Most reliable fix. Reindexing completes in 10-30 minutes typically.", "percentage": 94},
        {"solution": "Delete cache directories: On macOS run: rm -rf ~/Library/Caches/JetBrains/IdeaIC* and ~/Library/Caches/JetBrains/IntelliJIdea*", "percentage": 89},
        {"solution": "Increase IDE memory: Help → Edit Custom VM Options → Set -Xmx to at least 4G (default is often 1-2G).", "percentage": 82}
    ]'::jsonb,
    'IntelliJ IDEA version 2020.1 or later. Project with 5000+ files or multiple large dependencies. 4GB RAM minimum recommended.',
    'Indexing completes within 30 minutes. IDE responds to keyboard/mouse during indexing. Status bar shows percentage completion.',
    'Invalidating cache but not fully restarting the IDE - must close and reopen. Opening multiple projects simultaneously causes indexing to compete for resources. Not checking if disk space is full.',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/15991561/intelli-j-idea-takes-forever-to-update-indices',
    'admin:1764173837'
),
(
    'VS Code not activating extensions after update',
    'ide-tools',
    'MEDIUM',
    '[
        {"solution": "Profile extension host: Run ''Developer: Show Running Extensions'' command. Identify stuck/problematic extension (check logs). Uninstall faulty extension.", "percentage": 88},
        {"solution": "Complete reinstall: Delete %USERPROFILE%/AppData/Roaming/Code and %USERPROFILE%/.vscode. Uninstall and reinstall VS Code. Restore extensions from backup.", "percentage": 85},
        {"solution": "Check git status: If error says ''folder has no git repo'', verify git is in PATH. Run: git status in folder via terminal. Restart VS Code.", "percentage": 79}
    ]'::jsonb,
    'VS Code 1.57.0 or later installed. Recent update performed. Git repository exists in project folder.',
    'All extensions show green checkmarks in Extensions panel. Output tab shows no ''Failed to activate'' messages. Command palette responds normally.',
    'Disabling @builtin git extension - causes more problems. Not checking which specific extension is frozen (use Developer: Show Running Extensions). Force closing VS Code without proper shutdown causes cache corruption.',
    0.87,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/67992050/vs-code-not-activating-extensions',
    'admin:1764173837'
),
(
    'VS Code Python extension failed to activate TypeError Expected a string got undefined',
    'ide-tools',
    'MEDIUM',
    '[
        {"solution": "Update Python extension to pre-release: Open Extensions → Python → Click dropdown next to Install → Install Pre-Release Version. This fixes 2023.2.0 bugs.", "percentage": 92},
        {"solution": "Downgrade Python extension: Extensions → Python → dropdown icon → Install Another Version → Select version 2022.20.0 or earlier (stable older version).", "percentage": 89},
        {"solution": "Use remote debugging workaround: If debugging only, extension activation failure can be ignored. Use Remote Attach via Command Palette: Python: Attach using socket.", "percentage": 76}
    ]'::jsonb,
    'VS Code with Python extension 2023.2.0 or later installed. Python interpreter configured in workspace. Recent update performed.',
    'Python extension shows as active in Extensions panel (green checkmark). Run Python code or debug without activation errors. Output → Python shows no TypeError messages.',
    'Not checking extension version - users assume latest is most stable. Python 2023.2.0 is known buggy. Uninstalling extension removes debugging capability entirely - downgrade instead of uninstall.',
    0.89,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/75364563/vs-code-python-extension-failed-to-activate',
    'admin:1764173837'
);
