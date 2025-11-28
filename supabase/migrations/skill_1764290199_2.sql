INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Rust Error Handling - HASH error-stack crate patterns',
  'claude-code',
  'skill',
  '[{"solution": "Define custom errors using error-stack and derive_more", "cli": {"macos": "cargo add error-stack derive_more", "linux": "cargo add error-stack derive_more", "windows": "cargo add error-stack derive_more"}, "manual": "Use error-stack crate exclusively for error handling in Rust. Define error types with #[derive(Debug, derive_more::Display)]. Import Error from core::error, not std::error. Use Report<MyError> for all error types. Propagate errors with .change_context() to convert types and .attach() to add context. For async, use FutureExt trait. Test all documented error variants. Example: fn process() -> Result<(), Report<ProcessError>> { operation().change_context(ProcessError::Failed)? }", "note": "Never use anyhow, eyre, Box<dyn Error>, or thiserror - HASH uses error-stack exclusively"}]'::jsonb,
  'script',
  'Rust project with Cargo.toml, error-stack and derive_more crates installed',
  'Using anyhow or eyre instead of error-stack. Using Box<dyn Error>. Using thiserror instead of derive_more. Forgetting to import ResultExt or FutureExt. Not documenting error variants with #[display()] attributes. Not testing all error conditions. Importing Error from std instead of core.',
  'Error types display correct messages. Error chains build properly with .change_context() and .attach(). All error variants tested. Async errors propagate correctly. Intra-doc links work for error documentation.',
  'HASH error handling patterns using error-stack crate for Result types and error propagation',
  'https://skillsmp.com/skills/hashintel-hash-claude-skills-handling-rust-errors-skill-md',
  'admin:HAIKU_SKILL_1764290199_37706'
);
