INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'test-with-spanner - Run unit tests with Spanner emulator for Storj packages',
  'claude-code',
  'skill',
  '[{"solution": "Check Spanner environment", "manual": "Check if SPANNER_EMULATOR_HOST and STORJ_TEST_SPANNER are set using: echo $SPANNER_EMULATOR_HOST and echo $STORJ_TEST_SPANNER"}, {"solution": "Start Spanner emulator if needed", "cli": {"macos": "spanner_emulator --host_port 127.0.0.1:10008", "linux": "spanner_emulator --host_port 127.0.0.1:10008", "windows": "spanner_emulator --host_port 127.0.0.1:10008"}, "note": "Runs in background on port 10008"}, {"solution": "Run tests with environment", "cli": {"macos": "SPANNER_EMULATOR_HOST=localhost:10008 STORJ_TEST_SPANNER=''spanner://127.0.0.1:10008?emulator'' go test -v ./package/path -run TestName", "linux": "SPANNER_EMULATOR_HOST=localhost:10008 STORJ_TEST_SPANNER=''spanner://127.0.0.1:10008?emulator'' go test -v ./package/path -run TestName", "windows": "set SPANNER_EMULATOR_HOST=localhost:10008 && set STORJ_TEST_SPANNER=spanner://127.0.0.1:10008?emulator && go test -v ./package/path -run TestName"}}]'::jsonb,
  'steps',
  'Go installed, Spanner emulator available',
  'Using wrong port (10007 vs 10008), not setting environment variables, not waiting for emulator startup',
  'Tests pass without errors, emulator process is running in background, environment variables are exported',
  'Run Spanner-dependent tests for Storj packages like satellite/metabase, satellite/metainfo, satellite/satellitedb',
  'https://skillsmp.com/skills/storj-storj-claude-skills-test-with-spanner-skill-md',
  'admin:HAIKU_SKILL_1764290169_34218'
);
