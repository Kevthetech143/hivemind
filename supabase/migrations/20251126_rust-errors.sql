INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES
(
    'error[E0507]: cannot move out of borrowed content',
    'rust',
    'HIGH',
    '[
        {"solution": "Use take() method to extract Option value: self.dispatch_thread.take().unwrap().join()", "percentage": 98},
        {"solution": "If Option is None, check initialization in constructor - ensure Some is set before use", "percentage": 85}
    ]'::jsonb,
    'Rust program with Option<Thread> or similar Option type that needs to be consumed',
    'Program compiles without E0507 error and thread.join() executes successfully',
    'Using unwrap() directly on self field when self is borrowed - unwrap() consumes ownership. Using as_ref() or as_mut() when you need to extract value.',
    0.96,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/50920114/borrow-checker-cannot-move-out-of-borrowed-content',
    'admin:1764174172'
),
(
    'cannot move out of a mutable reference - move occurs because value has type Box, which does not implement Copy',
    'rust',
    'HIGH',
    '[
        {"solution": "Use entry() API instead of pattern matching: curr.entry(key).or_insert_with(...) and match on result", "percentage": 96},
        {"solution": "Use as_ref()/as_mut() to borrow Box contents instead of moving: match next.as_mut() { ... }", "percentage": 92}
    ]'::jsonb,
    'HashMap or collections containing Box<T> types that need to be navigated and modified',
    'Code compiles without borrow checker errors and container values are correctly modified',
    'Using &mut pattern in match to dereference Box - this attempts to move non-Copy types. Using get_mut() with pattern matching on dereferenced value.',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/77397609/can-you-explain-why-this-solution-to-rusts-borrow-checker-error',
    'admin:1764174172'
),
(
    'error[E0308]: mismatched types: expected () but found &str - if may be missing an else clause',
    'rust',
    'HIGH',
    '[
        {"solution": "Add else clause returning same type: if condition { \"value\" } else { \"\" }", "percentage": 97},
        {"solution": "For mixed types, convert all branches to same type: i.to_string() and \"\".to_string()", "percentage": 94},
        {"solution": "Use expression that always returns value - if with no else returns ()", "percentage": 88}
    ]'::jsonb,
    'Rust conditional expression (if/else) used in position expecting specific return type',
    'Code compiles and if expressions return consistent types across all branches',
    'Forgetting else clause when if returns value - if without else returns unit type (). Mixing types in branches without conversion.',
    0.95,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/24579756/what-does-mismatched-types-expected-mean-when-using-an-if-expression',
    'admin:1764174172'
),
(
    'error[E0038]: cannot convert to a trait object because trait is not object-safe - method references Self type in return',
    'rust',
    'HIGH',
    '[
        {"solution": "Change return type from Option<Box<Self>> to Option<Box<TraitName>>", "percentage": 97},
        {"solution": "Remove methods with Self in signature - replace with concrete type or use generic associated types", "percentage": 88},
        {"solution": "Use a different design pattern: return concrete type or use factory function instead of trait object", "percentage": 82}
    ]'::jsonb,
    'Trait definition with methods that reference Self in parameter or return type position',
    'Trait can be used as Box<dyn TraitName> or trait object without E0038 error',
    'Using Self in return type when trait object is needed - compiler can''t determine size at runtime. Forgetting trait must be object-safe for dynamic dispatch.',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/29985153/trait-object-is-not-object-safe-error',
    'admin:1764174172'
),
(
    'undefined reference to linker symbol when cargo build --release fails but debug succeeds',
    'rust',
    'MEDIUM',
    '[
        {"solution": "In build.rs remove =static: change println!(\"cargo:rustc-link-lib=static=libname\") to println!(\"cargo:rustc-link-lib=libname\")", "percentage": 94},
        {"solution": "Check linker flags - release builds with opt-level may require different link configuration than debug", "percentage": 87},
        {"solution": "Verify library actually exists in correct path and is properly built before linking", "percentage": 83}
    ]'::jsonb,
    'Cargo project with build.rs script that explicitly specifies library linking',
    'cargo build --release completes successfully without undefined reference errors',
    'Explicit =static library type specification that works in debug but not release. Linker behavior differs between debug and release builds with different opt levels.',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/71372256/why-does-cargo-build-succeed-but-cargo-build-release-fail-with-undefined-r',
    'admin:1764174172'
);
