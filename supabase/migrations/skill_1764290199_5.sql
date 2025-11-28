INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Cargo Dependency Management - Managing Cargo.toml dependencies and workspace patterns',
  'claude-code',
  'skill',
  '[{"solution": "Manage dependencies using cargo add and workspace patterns", "cli": {"macos": "cargo add package_name && cargo tree --all-features", "linux": "cargo add package_name && cargo tree --all-features", "windows": "cargo add package_name && cargo tree --all-features"}, "manual": "Use cargo add for managing dependencies instead of manual editing. Check dependency trees with cargo tree --all-features. Organize workspace dependencies efficiently. Pin versions for reproducibility. Use semantic versioning correctly: ^ for compatible changes, ~ for patch changes, exact for critical deps. Check for duplicate dependencies with cargo duplicate. Audit for security issues with cargo audit. Keep transitive dependency count minimal. Review CARGO_TREE output regularly to understand dependency graph. Use workspace root for shared deps.", "note": "Always use cargo add instead of manual Cargo.toml editing. Check dependencies before committing. Run cargo tree to visualize dependency relationships."}]'::jsonb,
  'script',
  'Cargo project with Cargo.toml, cargo CLI installed',
  'Manual Cargo.toml editing without cargo add. Version conflicts between workspace members. Too many transitive dependencies. Using incompatible version specs. Not updating workspace dependencies. Ignoring security warnings from cargo audit. Duplicate dependencies across members. Version pinning without justification.',
  'cargo tree shows clean dependency graph. cargo audit has no vulnerabilities. No duplicate dependencies. Version specifications are semantic. Workspace dependencies resolve correctly. cargo check passes.',
  'Cargo dependency management patterns, workspace organization, and semantic versioning',
  'https://skillsmp.com/skills/hashintel-hash-claude-skills-managing-cargo-dependencies-skill-md',
  'admin:HAIKU_SKILL_1764290199_37706'
);
