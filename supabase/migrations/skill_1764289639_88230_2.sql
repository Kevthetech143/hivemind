INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Debugging Strategies - Master systematic debugging techniques and profiling tools to efficiently track down bugs',
  'claude-code',
  'skill',
  '[{"solution": "Implement scientific method debugging: observe, hypothesize, experiment, analyze, repeat", "cli": {"macos": "echo \"Observation:\"", "linux": "echo \"Observation:\"", "windows": "echo \"Observation:\""}, "note": "Document each hypothesis and test result systematically"}, {"solution": "Set up VS Code JavaScript debugging with launch.json configuration", "cli": {"macos": "code .vscode/launch.json", "linux": "code .vscode/launch.json", "windows": "code .vscode/launch.json"}, "note": "Use breakpoints, conditional debugging, and integrated terminal"}, {"solution": "Python debugging with breakpoint() and pdb modules", "cli": {"macos": "python3 -m pdb script.py", "linux": "python3 -m pdb script.py", "windows": "python3 -m pdb script.py"}, "note": "Use ipdb for better interface than standard pdb"}, {"solution": "Binary search debugging with git bisect for finding regressions", "cli": {"macos": "git bisect start && git bisect bad && git bisect good v1.0.0", "linux": "git bisect start && git bisect bad && git bisect good v1.0.0", "windows": "git bisect start && git bisect bad && git bisect good v1.0.0"}, "note": "Narrows down breaking commit efficiently"}, {"solution": "Performance profiling with Chrome DevTools or Node.js CLI", "cli": {"macos": "node --prof app.js && node --prof-process isolate-*.log", "linux": "node --prof app.js && node --prof-process isolate-*.log", "windows": "node --prof app.js && node --prof-process isolate-*.log"}, "note": "Identify bottlenecks before optimizing"}]'::jsonb,
  'script',
  'Development environment, debugger tools (Chrome DevTools/VS Code/pdb), git, profiling tools',
  'Making multiple changes simultaneously instead of one at a time; ignoring error messages and stack traces; assuming problems are complex when usually simple; leaving debug logging in production; not testing fixes; giving up too soon',
  'Bug reproduced consistently; root cause identified and documented; fix applied and verified; performance metrics improved; no regressions in tests',
  'Master systematic debugging using scientific method, profiling tools, and binary search techniques across any technology stack',
  'https://skillsmp.com/skills/wshobson-agents-plugins-developer-essentials-skills-debugging-strategies-skill-md',
  'admin:HAIKU_SKILL_1764289639_88230'
);
