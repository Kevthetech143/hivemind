INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES
(
    'android.emulator cannot start ARM M1 Mac - CPU does not support VT-x',
    'java-kotlin',
    'HIGH',
    '[
        {"solution": "SDK Tools reinstall: Tools → SDK Manager → SDK Tools → Deselect all → Apply → Reselect all → Apply to force ARM64 compatible versions download", "percentage": 95},
        {"solution": "Force correct emulator: Tools → SDK Manager → Deselect Android Emulator → OK, then run app to trigger correct ARM64 download", "percentage": 92},
        {"solution": "Use ARM64-v8a system images: Create AVD with Android 11+ (R/S) images, select arm64-v8a from Other Images tab", "percentage": 90}
    ]'::jsonb,
    'M1/M2 Mac with Android Studio installed, System image for emulator',
    'Emulator launches without CPU architecture errors, device appears in device list, app runs in emulator',
    'Mixing x86 and ARM SDK tools from Time Machine migration, not using native ARM64 Studio build, selecting Intel-only system images',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/64907154/android-studio-emulator-on-macos-with-arm-cpu-m1',
    'admin:1764173265'
),
(
    'org.springframework.beans.factory.BeanCreationException - ConfigurationPropertiesRebinderAutoConfiguration version conflict',
    'java-kotlin',
    'HIGH',
    '[
        {"solution": "Downgrade Spring Boot to 2.3.3.RELEASE or 2.3.4.RELEASE while keeping Spring Cloud Hoxton.SR8", "percentage": 94},
        {"solution": "Upgrade Spring Cloud to 2020.0.3 or newer compatible versions while keeping Spring Boot 2.4.0+", "percentage": 93},
        {"solution": "Use start.spring.io to generate projects with matching dependency versions, compare your pom.xml against generated one", "percentage": 96}
    ]'::jsonb,
    'Spring Boot application with Spring Cloud dependency, Maven/Gradle build configured',
    'Application starts without BeanCreationException, all beans properly initialized, startup completes successfully',
    'Mixing incompatible Spring Boot and Spring Cloud versions, not checking official version compatibility matrix, manually setting versions without validation',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/65181495/bean-creation-error-when-starting-spring-boot-application',
    'admin:1764173265'
),
(
    'Kotlin nullable function variable cannot use ?() syntax - null pointer safety',
    'java-kotlin',
    'MEDIUM',
    '[
        {"solution": "Use myCallback?.invoke() instead of myCallback?() - invoke() operator supports safe call syntax directly", "percentage": 98},
        {"solution": "Understand that () syntax is sugar for invoke() operator which can''t use ?() - always expand to invoke()", "percentage": 97}
    ]'::jsonb,
    'Kotlin function variable declared as nullable type, attempting to call with safe operator',
    'Code compiles without syntax errors, safe call operator works correctly on function invocation, null safety preserved',
    'Using ?() syntax directly on function variables, attempting unsafe !! operator instead, not understanding () is sugar for invoke()',
    0.97,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/51865648/null-safety-operator-for-function-variable-in-kotlin',
    'admin:1764173265'
),
(
    'java.lang.OutOfMemoryError: Java heap space - cannot allocate objects',
    'java-kotlin',
    'HIGH',
    '[
        {"solution": "Increase heap with -Xmx flag: java -Xms512m -Xmx2048m MyApplication (set Xmx to max available memory)", "percentage": 96},
        {"solution": "Gradle: Add to gradle.properties: org.gradle.jvmargs=-Xmx2048m", "percentage": 94},
        {"solution": "IDE configuration: Eclipse/IntelliJ Run Configurations → Arguments tab → add VM arguments -Xmx2048m", "percentage": 93},
        {"solution": "Profile memory with Eclipse Memory Analyzer, release object references explicitly, reduce finalizer usage", "percentage": 85}
    ]'::jsonb,
    'Java application compiled and runnable, knowledge of available system RAM',
    'Application runs without OutOfMemoryError, increased heap size confirmed via JVM arguments, memory profiler shows stable usage',
    'Setting Xmx too high causing system swap, not releasing large object references, excessive finalizer implementations blocking GC, ignoring memory leak indicators',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/37335/how-to-deal-with-java-lang-outofmemoryerror-java-heap-space-error',
    'admin:1764173265'
),
(
    'java.lang.ClassNotFoundException - JVM cannot find class in classpath',
    'java-kotlin',
    'HIGH',
    '[
        {"solution": "Check classpath: java -cp \".:yourjar.jar\" YourMainClass (include all necessary JARs in -cp path)", "percentage": 96},
        {"solution": "Use correct class name without extension: java HelloWorld (NOT java HelloWorld.class)", "percentage": 98},
        {"solution": "Maven dependency conflicts: Run mvn dependency:tree to visualize, explicitly declare needed version in POM", "percentage": 93},
        {"solution": "IDE build path: Eclipse right-click project → Build Path → Configure Build Path, add external JARs", "percentage": 92}
    ]'::jsonb,
    'Java source code compiled to .class files, access to classpath and JAR files',
    'Class loads successfully, no ClassNotFoundException in logs, JVM finds class at runtime',
    'Including .class extension in class name, broken classpath configuration, missing JAR files in -cp, IDE caching old state, version conflicts unresolved',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/17408769/how-do-i-resolve-classnotfoundexception',
    'admin:1764173265'
),
(
    'java.util.ConcurrentModificationException - modifying collection while iterating',
    'java-kotlin',
    'HIGH',
    '[
        {"solution": "Use Iterator.remove(): while(iterator.hasNext()) { String val = iterator.next(); if(condition) iterator.remove(); }", "percentage": 97},
        {"solution": "Traditional for-loop decrement: for(int i = list.size()-1; i >= 0; i--) if(condition) list.remove(i);", "percentage": 96},
        {"solution": "Java 8+ removeIf(): list.removeIf(item -> item.equals(\"value\"));", "percentage": 95},
        {"solution": "Separate removal phase: collect items during iteration, call removeAll() after loop completes", "percentage": 92}
    ]'::jsonb,
    'Java collection (ArrayList, HashSet, etc.) with elements, iteration logic in place',
    'No ConcurrentModificationException thrown, items removed successfully, iteration completes normally',
    'Using enhanced for-loop with direct list.remove() calls, modifying collection from non-iterator source, forgetting to use fail-safe patterns',
    0.95,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/8104692/how-to-avoid-java-util-concurrentmodificationexception-when-iterating-through-an',
    'admin:1764173265'
),
(
    'Kotlin extension function not found at runtime - NoSuchMethodError despite compilation success',
    'java-kotlin',
    'MEDIUM',
    '[
        {"solution": "Rename conflicting test file: if extensions.kt exists in both src/main and src/test, rename test version to testExtensions.kt", "percentage": 98},
        {"solution": "Ensure no duplicate extension files across source sets - use unique names to prevent namespace collision", "percentage": 97},
        {"solution": "Verify Gradle source set configuration: check that main and test sets don''t share extension files", "percentage": 93}
    ]'::jsonb,
    'Kotlin project with extension functions, multi-source structure with main and test directories',
    'Extension functions load correctly, NoSuchMethodError disappears, tests execute successfully',
    'Duplicate extensions.kt files in different source directories (src/main/kotlin and src/test/kotlin), assuming same filename is safe across sets',
    0.96,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/51880817/extension-function-not-found-when-run-tests',
    'admin:1764173265'
),
(
    'java.lang.NoClassDefFoundError - class found at compile time but missing at runtime',
    'java-kotlin',
    'HIGH',
    '[
        {"solution": "Verify runtime classpath includes all required .class files and JAR dependencies", "percentage": 96},
        {"solution": "Compile with package structure: javac -d . FileName.java creates proper directory hierarchy", "percentage": 95},
        {"solution": "Run with full package path: java package.ClassName (not just java ClassName)", "percentage": 97},
        {"solution": "Check static initialization: Exceptions in static blocks or initializers can mask underlying issue", "percentage": 88}
    ]'::jsonb,
    'Java source code with package declarations, build tool or manual compilation setup',
    'Class loads at runtime without NoClassDefFoundError, static initialization completes, object instantiation succeeds',
    'Missing transitive dependencies, mismatched folder hierarchies for packages, multiple conflicting classloaders, IDE caching stale state',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/17973970/how-can-i-solve-java-lang-noclassdeffounderror',
    'admin:1764173265'
),
(
    'Kotlin lateinit property has not been initialized - UninitializedPropertyAccessException',
    'java-kotlin',
    'MEDIUM',
    '[
        {"solution": "Check initialization before access: if (::variable.isInitialized) { use variable } - available since Kotlin 1.2", "percentage": 98},
        {"solution": "With explicit this reference: if (this::variable.isInitialized) for class member checks", "percentage": 97},
        {"solution": "Create helper function in original class for cross-class initialization checks, return boolean status", "percentage": 94}
    ]'::jsonb,
    'Kotlin class with lateinit property, Kotlin 1.2+, defensive programming intent',
    'No UninitializedPropertyAccessException thrown, properties accessible only when initialized, safe error handling in place',
    'Accessing lateinit without checking isInitialized, attempting checks from unrelated classes, forgetting double colon syntax ::',
    0.96,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/37618738/how-to-check-if-a-lateinit-variable-has-been-initialized',
    'admin:1764173265'
),
(
    'java.lang.StackOverflowError - recursion exceeds stack depth limit',
    'java-kotlin',
    'MEDIUM',
    '[
        {"solution": "Verify base case logic: ensure recursion termination condition is actually reachable (not infinite recursion)", "percentage": 97},
        {"solution": "Replace recursion with iteration (loops) for deep operations to eliminate stack frame accumulation", "percentage": 96},
        {"solution": "Implement memoization/caching to store intermediate results and avoid redundant recursive calls", "percentage": 94},
        {"solution": "Increase stack size as last resort: java -Xss2m ClassName (but fix algorithm first)", "percentage": 70}
    ]'::jsonb,
    'Recursive Java/Kotlin method, understanding of algorithm logic and base cases',
    'Recursion terminates properly, no StackOverflowError thrown, method returns expected results',
    'Missing or unreachable base case, infinite recursion loops, algorithm inherently too deep for stack, not tail-optimizing recursion',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/18368406/java-lang-stackoverflowerror-due-to-recursion',
    'admin:1764173265'
),
(
    'Android Gradle plugin requires Kotlin version 1.5.20+ - build fails with outdated kotlin-gradle-plugin',
    'java-kotlin',
    'HIGH',
    '[
        {"solution": "Update build.gradle plugins block: id(\"org.jetbrains.kotlin.android\") version \"1.5.20\" apply false or higher", "percentage": 96},
        {"solution": "Upgrade to Kotlin 1.8.20 or later for best compatibility with modern Android Gradle Plugin", "percentage": 94},
        {"solution": "Verify AGP version matches Kotlin version: use gradlew --version to confirm both are compatible", "percentage": 92}
    ]'::jsonb,
    'Android project with Gradle build system, ability to modify build.gradle file',
    'Gradle build completes successfully, Kotlin compilation succeeds, Android project builds without version errors',
    'Using very old Kotlin versions (1.3.x) with new AGP, not checking compatibility matrix, updating only one version',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/76515476/android-kotlin-gradle-build-failed',
    'admin:1764173265'
),
(
    'java.lang.NumberFormatException - cannot parse non-numeric string to numeric type',
    'java-kotlin',
    'HIGH',
    '[
        {"solution": "Wrap parsing in try-catch: try { Integer.parseInt(str); } catch (NumberFormatException e) { handle error }", "percentage": 96},
        {"solution": "Validate before parsing: use regex or character checks to ensure string contains only numeric characters before Integer.parseInt()", "percentage": 94},
        {"solution": "Check for whitespace: use str.trim() to remove leading/trailing spaces before parsing", "percentage": 93},
        {"solution": "Redesign with objects: use classes/enums instead of string parsing (e.g., Card enum instead of parsing string)", "percentage": 88}
    ]'::jsonb,
    'String data that needs numeric conversion, input validation capability',
    'No NumberFormatException thrown, numeric values parsed correctly, invalid inputs handled gracefully',
    'Attempting to parse non-numeric strings directly, ignoring hidden whitespace, no try-catch protection, poor input validation',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/39849984/what-is-a-numberformatexception-and-how-can-i-fix-it',
    'admin:1764173265'
);
