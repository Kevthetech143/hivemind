INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Rust Code Documentation - Writing doc comments following rustdoc conventions',
  'claude-code',
  'skill',
  '[{"solution": "Document functions with summary, description, errors, and examples", "cli": {"macos": "cargo doc --no-deps --all-features", "linux": "cargo doc --no-deps --all-features", "windows": "cargo doc --no-deps --all-features"}, "manual": "Write doc comments for all public APIs. Begin with single-line summary. Include detailed description. Use intra-doc links with backticks: [`Type`], [`function`]. Document errors with # Errors section. Link error variants: [`NotFound`]: ErrorType::NotFound. Include # Examples with compilable code. Hide setup with # prefix. Describe return values inline. Use # Arguments for 3+ parameters. Inline parameters for simpler functions. Skip docs for obvious getters/setters and standard trait implementations. Test with cargo doc --no-deps.", "note": "Follow Anthropic best practices: document contracts and guarantees, not obviousness. Prefer intra-doc links. Use `//!` for module docs. Validate with cargo doc."}]'::jsonb,
  'script',
  'Rust project with Cargo.toml and valid source files',
  'Documenting standard trait implementations. Using plain text instead of intra-doc links. Missing # Errors for Result-returning functions. Forgetting to compile examples. Using separate # Returns sections. Over-documenting obvious fields. Not linking error variants. Nested code examples without proper syntax highlighting.',
  'cargo doc builds without warnings. All public APIs have doc comments. Intra-doc links resolve properly. Examples compile. Error documentation complete. No broken links.',
  'Rust documentation best practices with rustdoc, intra-doc links, examples, and error sections',
  'https://skillsmp.com/skills/hashintel-hash-claude-skills-documenting-rust-code-skill-md',
  'admin:HAIKU_SKILL_1764290199_37706'
);
