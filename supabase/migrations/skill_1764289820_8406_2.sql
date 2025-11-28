INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'TypeScript Advanced Types - Master generics, conditional types, mapped types, template literals, and utility types for type-safe applications.',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Generics & Type Parameters",
      "manual": "Create reusable generic functions and classes with type parameters. Use generic constraints (extends keyword) to limit acceptable types. Implement multiple type parameters with proper variance. Extract type information with infer keyword for return types, parameters, and promise resolution."
    },
    {
      "solution": "Conditional Types",
      "manual": "Build type logic with ternary conditional syntax: T extends U ? X : Y. Implement distributive conditional types for union types. Use nested conditions for complex type discrimination. Apply to extract types from functions, promises, and complex structures."
    },
    {
      "solution": "Mapped Types & Key Remapping",
      "manual": "Transform properties with [K in keyof T]: Create property modifiers (readonly, optional). Implement key remapping with ''as'' clauses for getter/setter patterns. Filter properties by type with conditional mapped types. Build property transformers (Readonly, Partial, Record)."
    },
    {
      "solution": "Template Literal Types",
      "manual": "Create string-based types with Capitalize, Uppercase, Lowercase transforms. Build path types for nested object access. Implement event handler naming patterns. Match string patterns for compile-time validation of string literals."
    },
    {
      "solution": "Type-Safe Patterns",
      "manual": "Implement type-safe event emitters with discriminated event maps. Build type-safe API clients with endpoint-specific types. Create builder patterns with completion detection. Use discriminated unions for state machines. Implement deep readonly/partial for immutable configs."
    },
    {
      "solution": "Type Inference & Testing",
      "manual": "Use ''infer'' keyword to extract types from functions, arrays, and promises. Implement type guards with ''is'' keyword. Create assertion functions for type narrowing. Write type tests with AssertEqual to verify type behavior. Use typeof and instanceof for runtime narrowing."
    }
  ]'::jsonb,
  'steps',
  'Intermediate TypeScript knowledge, understanding of function signatures and object types, familiarity with union/intersection types',
  'Over-complicating types; ignoring strict null checks; using ''any'' to bypass type checking; circular type references; deeply nested conditional types impacting compilation; forgetting readonly modifiers; not handling edge cases like null/undefined',
  'Compiled code has zero type errors; complex types resolve quickly (< 1s compilation); type tests pass showing correct inference; API clients accept only valid endpoint/method combinations; form validators catch all invalid inputs at compile time; circular dependencies are resolved',
  'Create type-safe libraries and frameworks using generics, mapped types, conditional types, and template literals for compile-time validation.',
  'https://skillsmp.com/skills/wshobson-agents-plugins-javascript-typescript-skills-typescript-advanced-types-skill-md',
  'admin:HAIKU_SKILL_1764289820_8406'
);
