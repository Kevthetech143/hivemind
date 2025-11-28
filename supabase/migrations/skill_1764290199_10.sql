INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Opentrons Integration - Programming automated lab robotics workflows',
  'claude-code',
  'skill',
  '[{"solution": "Write Opentrons protocol scripts for automated liquid handling", "cli": {"macos": "pip install opentrons && opentrons_simulate protocol.py", "linux": "pip install opentrons && opentrons_simulate protocol.py", "windows": "pip install opentrons && opentrons_simulate protocol.py"}, "manual": "Use Opentrons SDK to program OT-2 robot. Import required modules: from opentrons import protocol_api. Define metadata and protocol context. Load labware and pipettes. Define transfer operations. Use air gaps for accuracy. Handle tip tracking. Simulate before running. Set up proper volumetry. Handle liquid typing. Implement pause points. Safety checks and error recovery. Test protocols thoroughly. Document assumptions.", "note": "Always simulate protocols with opentrons_simulate before running on hardware. Verify labware definitions. Check volumes fit in tip capacity."}]'::jsonb,
  'script',
  'Python 3.7+, Opentrons SDK installed, Opentrons OT-2 hardware (for actual runs)',
  'Not simulating before running. Wrong labware definitions. Volume overflow errors. Tip tracking issues. Collisions. Missing pause points. No error recovery. Incorrect pipette selection. Poor documentation. Hardcoded parameters. Race conditions in timing. Inadequate safety checks.',
  'Protocol simulates successfully. No collisions detected. Volumes calculated correctly. Tip tracking works. Pause points hit correctly. Safety checks pass. Simulation matches expected behavior. Code is reproducible.',
  'Opentrons OT-2 robot programming, liquid handling automation, and protocol development',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-opentrons-integration-skill-md',
  'admin:HAIKU_SKILL_1764290199_37706'
);
