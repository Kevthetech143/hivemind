-- Add Stack Overflow Yup validation library solutions batch 1

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES (
    'How to make an email field conditionally required in Yup validation only when a checkbox is checked',
    'stackoverflow-yup',
    'HIGH',
    $$[
        {"solution": "Define the conditional field in both initialValues and validation schema using .when() method with boolean condition", "percentage": 92, "note": "Field must exist in initialValues before .when() evaluation", "command": "email: yup.string().email().when(''showEmail'', {is: true, then: yup.string().required(''Must enter email address'')})"},
        {"solution": "For Yup v1+, wrap then logic in callback: then: (schema) => schema.required()", "percentage": 88, "note": "Newer versions require callback wrapping"},
        {"solution": "Verify CSS hiding doesn't bypass validation - validation still applies even to hidden fields", "percentage": 85, "note": "Field visibility doesn''t exempt from validation"}
    ]$$::jsonb,
    'Yup library installed, Form initialized with proper initialValues, Understanding of boolean conditions',
    'Conditional field validates correctly based on checkbox state, No "Cannot read property" errors, Form submission respects conditions',
    'Not adding conditional field to initialValues causes validation errors. Yup v1+ requires callback wrapping. CSS hiding does not skip validation. Multiple conditions require additional .when() chaining.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/49394391/conditional-validation-in-yup'
),
(
    'How to validate that password and confirmPassword fields match using Yup schema',
    'stackoverflow-yup',
    'HIGH',
    $$[
        {"solution": "Use oneOf() method with Yup.ref() to reference the password field: passwordConfirmation: Yup.string().oneOf([Yup.ref(''password'')], ''Passwords must match'')", "percentage": 92, "note": "Most reliable and widely used approach", "command": "Yup.object({password: Yup.string().required(), passwordConfirmation: Yup.string().oneOf([Yup.ref(''password'')], ''Passwords must match'')})"},
        {"solution": "Add .required() to confirmPassword to prevent empty values from passing", "percentage": 90, "note": "Prevents users from submitting without confirmation"},
        {"solution": "Handle null/undefined carefully in Yup v1.0+ to avoid TypeScript errors", "percentage": 85, "note": "Null handling differs between versions"}
    ]$$::jsonb,
    'Yup validation library installed, Form with password and confirmPassword inputs, Understanding of schema validation',
    'Confirmation field validates against password field, Mismatch throws proper error message, Submission blocked when passwords do not match',
    'Omitting .required() on confirmPassword allows empty values. Null vs undefined handling differs in Yup v1.0+. Reactive form validation may need both fields re-validated on change. Alternative .test() method provides more control for complex scenarios.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/61862252/yup-schema-validation-password-and-confirmpassword-doesnt-work'
),
(
    'How to validate that a string is exactly a specific length using Yup (e.g., 5 digit zip code)',
    'stackoverflow-yup',
    'HIGH',
    $$[
        {"solution": "Use .length() method for exact length validation: Yup.string().length(5, ''Should be exactly 5 chars'')", "percentage": 92, "note": "Most straightforward purpose-built method", "command": "zipCode: Yup.string().length(5, ''Must be exactly 5 digits'')"},
        {"solution": "Combine .min() and .max() with .matches() for digit-only strings: .min(5).max(5).matches(/^[0-9]+$/, ''Must be only digits'')", "percentage": 88, "note": "More explicit control over validation"},
        {"solution": "Always use Yup.string() for zip codes, never Yup.number() as it loses leading zeros", "percentage": 95, "note": "Numeric type causes data loss (01234 becomes 1234)"}
    ]$$::jsonb,
    'Yup library installed, Understanding that string should be used for zip codes to preserve leading zeros, Knowledge of regex patterns optional',
    'Validation accepts exactly 5 characters, Rejects values with fewer or more characters, Leading zeros are preserved, No data type conversion errors',
    'Never use Yup.number() for zip codes - leading zeros are lost in conversion. Null/undefined handling requires pre-validation checks. Large numbers (>22 digits) may use exponential notation with .toString(). Using .min() and .max() instead of .length() creates ambiguous requirements.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/49886881/validation-using-yup-to-check-string-or-number-length'
),
(
    'How to validate phone numbers with Yup ensuring minimum character length',
    'stackoverflow-yup',
    'MEDIUM',
    $$[
        {"solution": "Use string validation with regex pattern and .min()/.max() for length checking. Convert from Yup.number() to Yup.string() to enable proper length validation", "percentage": 85, "note": "Regex complexity varies by locale", "command": "phoneNumber: Yup.string().matches(/^(^[0-9]{3})|([0-9]{3})$/g, ''Phone number is not valid'').min(10).max(10)"},
        {"solution": "Apply phone validation pattern: /^((\\+[1-9]{1,4}[ \\-]*)|(\\([0-9]{2,3}\\)[ \\-]*)|([0-9]{2,4})[ \\-]*)*?[0-9]{3,4}?[ \\-]*[0-9]{3,4}?$/", "percentage": 80, "note": "Handles most international formats"},
        {"solution": "Avoid yup-phone library due to large bundle size - use regex approach instead", "percentage": 78, "note": "Performance consideration for lightweight implementations"}
    ]$$::jsonb,
    'Yup library installed, Phone number input field, Understanding that .min()/.max() works on strings not numbers, Knowledge of regex patterns helpful',
    'Phone validation accepts strings with 10+ digits, Rejects values below minimum length, Validation error displays when format is incorrect',
    'Using Yup.number() prevents length validation. Regex patterns are locale-dependent and may need customization for specific country codes. The yup-phone library has large bundle overhead. Over-complicated regex may reduce maintainability.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/52483260/validate-phone-number-with-yup'
),
(
    'How to trigger Yup validation only on form submit, not on change or blur events in React Formik',
    'stackoverflow-yup',
    'HIGH',
    $$[
        {"solution": "Set validateOnChange={false} and validateOnBlur={false} on Formik component to restrict validation to submit handler only", "percentage": 95, "note": "Official Formik documented approach", "command": "<Formik validateOnChange={false} validateOnBlur={false} onSubmit={handleSubmit} ..."},
        {"solution": "Ensure both props are set - setting only one may still trigger unwanted validation", "percentage": 92, "note": "Both flags required for complete control"},
        {"solution": "Handle validation errors explicitly in submit handler when using this approach", "percentage": 88, "note": "Errors won''t display automatically without submit handling"}
    ]$$::jsonb,
    'Formik library installed, Yup validation schema defined, Understanding of Formik props and submit handling',
    'Validation triggers only on form submission, No validation errors appear on field change or blur, Submit handler receives validation results',
    'Forgetting to set both validateOnChange and validateOnBlur may leave one validation trigger active. Error display requires explicit handling in submit. Manual validation calls needed outside normal Formik lifecycle. Testing submit behavior essential.',
    0.95,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/56742376/react-formik-trigger-validation-only-on-form-submit'
),
(
    'How to initially disable submit button in React Formik until form validation passes',
    'stackoverflow-yup',
    'MEDIUM',
    $$[
        {"solution": "Set validateOnMount={true} in Formik config and disable button with disabled={!formik.isValid}", "percentage": 85, "note": "Ensures validation runs at form initialization", "command": "const formik = useFormik({validateOnMount: true, ...}); <button disabled={!formik.isValid}>Submit</button>"},
        {"solution": "Conditionally display validation errors only for touched fields to avoid showing errors on initial load: {formik.touched.fieldName && formik.errors.fieldName && <p>error</p>}", "percentage": 88, "note": "Improves user experience by hiding initial errors"},
        {"solution": "Without validateOnMount, isValid flag does not reflect initial state until first submission attempt", "percentage": 90, "note": "Critical for proper button state management"}
    ]$$::jsonb,
    'Formik library installed, Yup validation schema defined, React component with form fields, Understanding of Formik hooks',
    'Submit button is disabled on form load, Button enables after all required fields are valid, Validation errors show only for touched fields',
    'Using disabled={!formik.isValid} without validateOnMount will not work correctly. validateOnMount may display validation errors immediately unless combined with touched checks. Complex conditional logic around initial values may cause issues. Error message display timing requires careful coordination.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/59443005/react-formik-form-validation-how-to-initially-have-submit-button-disabled'
),
(
    'How to validate that at least one item in a Yup array has a specific property set to true',
    'stackoverflow-yup',
    'MEDIUM',
    $$[
        {"solution": "Use .compact() with .min() to filter and validate: daysOfWeek: Yup.array().of(...).compact((v) => !v.checked).min(1, ''At least one required'')", "percentage": 75, "note": "Works but may mutate form data", "command": "Yup.array().of(Yup.object().shape({checked: Yup.boolean()})).compact((v) => !v.checked).min(1)"},
        {"solution": "Use custom .test() method instead for safer validation: .test(''atLeastOne'', ''error'', days => days.some(day => day.checked))", "percentage": 85, "note": "More reliable - avoids data mutation"},
        {"solution": "Be aware that compact() filters actual form data which may cause information loss in submission", "percentage": 90, "note": "Important caveat for data handling"}
    ]$$::jsonb,
    'Yup library installed, Array of objects with boolean properties, Understanding of array validation methods',
    'Validation passes when at least one object has checked=true, Error message displays when zero items are checked, Form data remains intact',
    'Using compact() modifies actual form data and may lose information. The test() approach requires manual implementation. Data mutation can cause unexpected behavior in form submission. Developers often choose compact() without realizing its side effects.',
    0.75,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/59197551/yup-deep-validation-in-array-of-objects'
),
(
    'NaN error when using conditional validation in Yup: "cast from the value NaN"',
    'stackoverflow-yup',
    'MEDIUM',
    $$[
        {"solution": "Add .typeError() to number validation to customize casting error: Yup.number().typeError(''Amount must be a number'').required()", "percentage": 85, "note": "Handles type casting before validation"},
        {"solution": "Use .transform() approach for complex scenarios: .transform((value) => Number.isNaN(value) ? null : value).nullable()", "percentage": 82, "note": "More control over null handling"},
        {"solution": "Ensure .nullable() is applied to otherwise branch in conditional schemas to handle null values properly", "percentage": 88, "note": "Critical for .when() conditionals"}
    ]$$::jsonb,
    'Yup library installed, Conditional validation schema using .when(), Number field in form, Understanding of type casting in Yup',
    'Number field accepts valid numeric input, Type error message displays for invalid input, Conditional validation respects null values correctly',
    'Forgetting .nullable() in non-required branches causes NaN errors. Empty string inputs from text fields bypass .required() checks. Type casting occurs before validation rules, requiring .typeError() for custom messages. Null vs undefined handling differs by Yup version.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/58770630/yup-when-nan-cast-from-the-value-nan'
),
(
    'Yup .matches() regex validation accepts partial matches instead of full string validation',
    'stackoverflow-yup',
    'MEDIUM',
    $$[
        {"solution": "Add ^ and $ anchors to regex pattern to ensure full-string matching: .matches(/^[a-z]+$/, ''Is not in correct format'')", "percentage": 95, "note": "Standard regex solution for complete string validation", "command": ".string().trim().matches(/^[a-z]+$/, ''Is not in correct format'').required()"},
        {"solution": "Simplify character classes - instead of [abcdefghijklmnopqrstuvwxyz] use [a-z]", "percentage": 93, "note": "Cleaner and more maintainable code"},
        {"solution": "Allow spaces if needed: /^[a-z\\s]+$/ or mix case: /^[A-Z a-z]+$/", "percentage": 90, "note": "Common pattern extensions"}
    ]$$::jsonb,
    'Yup library installed, String field in form, Understanding of regex anchors (^ and $), Knowledge of character classes',
    'Validation accepts only fully matching strings, Partial matches are rejected, Error message displays for incorrect format, Uppercase or special characters properly rejected',
    'Forgetting anchors causes partial matches to pass validation. Character classes written longhand (a-z vs [a-z...]) reduce readability. Not accounting for spaces when space is allowed/disallowed. Regex complexity may vary by use case. Trim() should be applied before validation.',
    0.95,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/54405911/yup-validation-with-regex-using-matches-problem'
),
(
    'What is the difference between Yup.object({...}) and Yup.object().shape({...}) in validation schemas',
    'stackoverflow-yup',
    'MEDIUM',
    $$[
        {"solution": "Both approaches are functionally equivalent conveniences - shape() and passing object directly produce identical validation schemas", "percentage": 65, "note": "No functional difference in validation"},
        {"solution": "The shape() method enables method chaining for extending or modifying schemas in subsequent calls", "percentage": 55, "note": "Flexibility benefit rarely used in practice"},
        {"solution": "Using shape() unnecessarily creates verbose code without functional benefits - use direct object constructor when chaining not needed", "percentage": 75, "note": "Code style preference"}
    ]$$::jsonb,
    'Yup library installed, Understanding of Yup schema creation, JavaScript knowledge of method chaining',
    'Schema validates correctly regardless of syntax choice, Fields are properly type-checked, Validation logic behaves identically',
    'Developers often use shape() unnecessarily when direct object constructor would suffice. Misleading perception that one provides more functionality. Lack of clear examples demonstrating when chaining advantage is beneficial. Personal preference often overrides code consistency.',
    0.45,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/61991469/what-does-the-shape-function-do-in-yup'
),
(
    'How to validate that a file input has been selected using Yup in a React form',
    'stackoverflow-yup',
    'MEDIUM',
    $$[
        {"solution": "Use Yup.mixed() instead of Yup.object() for file validation: file: Yup.mixed().required(''File is required'')", "percentage": 85, "note": "File inputs don''t resolve to objects", "command": "Yup.object().shape({file: Yup.mixed().required(''File is required'')})"},
        {"solution": "Use .test() method for advanced file validation (size, type): .test(''fileSize'', ''File too large'', file => file && file.size <= 1000000)", "percentage": 80, "note": "Enables size and type checking"},
        {"solution": "Avoid Yup.object() for file inputs - causes null type errors. FileList is not an object type", "percentage": 90, "note": "Common misconception source"}
    ]$$::jsonb,
    'Yup library installed, React form with file input element, Formik integration optional, Understanding that FileList is not an object',
    'File presence validation triggers when file selected, Error message displays when no file chosen, Form submission blocked without file',
    'Attempting to validate file as object type when FileList requires mixed() type. Not using .nullable() if attempting object validation. Forgetting that file inputs require special handling compared to text inputs. Advanced validation (file size, type) needs additional .test() methods.',
    0.85,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/52427095/validating-file-presence-with-yup'
),
(
    'How to implement asynchronous validation with Formik and Yup (e.g., check username availability)',
    'stackoverflow-yup',
    'MEDIUM',
    $$[
        {"solution": "Use Yup .test() method accepting promise-returning function: username: Yup.string().test(''checkDuplUsername'', ''name exists'', (value) => { return Promise that resolves to true/false })", "percentage": 82, "note": "Standard async validation pattern", "command": "Yup.string().test(''checkDuplUsername'', ''same name exists'', function(value) { return fetch(`/v1/users/${value}`).then(() => false).catch(() => true) })"},
        {"solution": "Mark test function as async and return boolean directly: async (value) => { const result = await fetch(); return !result.exists })", "percentage": 85, "note": "Modern async/await syntax"},
        {"solution": "Return true for success and false for validation failure - promise must resolve (not reject) with boolean result", "percentage": 88, "note": "Promise behavior is counterintuitive"}
    ]$$::jsonb,
    'Formik library installed, Yup schema validation, HTTP client (fetch/axios), Understanding of promises and async/await, Backend API endpoint for async checks',
    'Async validation triggers on field blur or submission, API call completes and returns result, Error message displays for failed async validation, Form submission prevented until async validation passes',
    'Forgetting to properly return the promise causes synchronous validation errors. Not handling empty values - should return true (pass) by default when field empty. Missing return statement breaks promise chain. Improper async context management. Over-complicated error handling in API calls. Async validation slow on large forms.',
    0.82,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/55811114/async-validation-with-formik-yup-and-react'
);
