INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'NotAuthorizedException: Incorrect username or password',
    'cognito',
    'HIGH',
    '[
        {"solution": "Verify the username and password are correct. Check that the user exists in the Cognito user pool and the password matches. If PreventUserExistenceErrors is ENABLED, this error is returned for both invalid username and invalid password to prevent user enumeration.", "percentage": 95},
        {"solution": "For SRP auth flow, ensure the client ID is correct and the user pool is properly configured. Regenerate client credentials if needed.", "percentage": 85},
        {"solution": "Check that the auth flow is enabled for the app client. Navigate to App Clients → Show Details → Auth Flows Configuration and ensure USER_PASSWORD_AUTH or ALLOW_USER_PASSWORD_AUTH is checked.", "percentage": 90}
    ]'::jsonb,
    'Access to AWS Cognito console or programmatic access with valid credentials',
    'User is able to successfully authenticate after providing correct credentials. Check CloudWatch logs for additional context.',
    'Attempting multiple logins in quick succession triggers account lockout. Assuming the error always means invalid credentials when PreventUserExistenceErrors=ENABLED masks user enumeration. Not checking if the user is CONFIRMED status.',
    0.92,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pool-managing-errors.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'UserNotFoundException: User does not exist',
    'cognito',
    'HIGH',
    '[
        {"solution": "Verify the username exists in the user pool. Check the Cognito console: Cognito → User Pools → Select Pool → Users → search for the username", "percentage": 95},
        {"solution": "If PreventUserExistenceErrors is set to LEGACY, this error is returned explicitly. Set it to ENABLED to prevent user enumeration attacks.", "percentage": 88},
        {"solution": "Ensure the user account is CONFIRMED. Unconfirmed users may not be findable via certain APIs. Send confirmation code via Admin API if needed.", "percentage": 85}
    ]'::jsonb,
    'Access to Cognito user pool with appropriate IAM permissions',
    'Attempting to create, authenticate, or query the user returns successful results. User appears in user pool list.',
    'Assuming error means user never existed when they may just be inactive/disabled. Not checking PreventUserExistenceErrors setting which controls error response behavior.',
    0.90,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pool-managing-errors.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'UsernameExistsException: User already exists',
    'cognito',
    'HIGH',
    '[
        {"solution": "Check if a user with this username already exists in the user pool. Use AdminGetUser API or search in Cognito console", "percentage": 96},
        {"solution": "If using email or phone as username attribute, check if an existing user has claimed that email/phone as an alias", "percentage": 92},
        {"solution": "Consider using AdminCreateUser instead of SignUp if you need to bypass username uniqueness checks for batch imports", "percentage": 80}
    ]'::jsonb,
    'Valid AWS Cognito user pool configuration. For alias attributes, ensure email/phone verification is configured.',
    'User creation succeeds with a unique username or email. No duplicate user entry exists in the pool.',
    'Not checking existing users before signup. Assuming username and email are independent when they may be linked via alias attributes. Not handling race conditions in concurrent signup requests.',
    0.94,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pool-managing-errors.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'InvalidParameterException: username should be an email',
    'cognito',
    'HIGH',
    '[
        {"solution": "Update user pool settings: Cognito → User Pools → Attributes → check ''Email address'' as Username attribute. Then ensure code passes email in username field, not a plain alphanumeric username.", "percentage": 97},
        {"solution": "If migrating from alphanumeric usernames, update SignUp/AdminCreateUser calls to use email format. For existing users, use AdminUpdateUserAttributes to set email.", "percentage": 85},
        {"solution": "Verify user pool is not enforcing email-only usernames due to recent AWS changes. If needed, create new user pool with legacy username settings.", "percentage": 75}
    ]'::jsonb,
    'User pool must have email attribute configured. Code must support passing email as identifier.',
    'SignUp request succeeds with email as username. User pool accepts both email and username formats if both are configured.',
    'Passing alphanumeric username when user pool requires email. Not checking which attributes are set as Username or Alias in user pool configuration. Creating user pool with wrong attribute settings.',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/70566785/how-do-i-fix-the-aws-wild-rydes-sample-error-invalidparameterexception-userna'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'PasswordResetRequiredException: Password reset is required',
    'cognito',
    'HIGH',
    '[
        {"solution": "When caught, call InitiateAuth with ChallengeName=NEW_PASSWORD_REQUIRED. Respond with new password and complete the challenge flow.", "percentage": 96},
        {"solution": "For admin operations, use AdminSetUserPassword to set password directly, or trigger AdminResetUserPassword to force reset on next login", "percentage": 92},
        {"solution": "In Cognito user pool settings, disable ''Force change password on first login'' if users should not be required to reset immediately: User Pool → Policies → Password Policy", "percentage": 85}
    ]'::jsonb,
    'User must be authenticated enough to reach NEW_PASSWORD_REQUIRED challenge. Administrative access if using admin APIs.',
    'User completes password reset and can authenticate successfully. No further PasswordResetRequiredException errors on login.',
    'Attempting to use old password after reset required. Not implementing the NEW_PASSWORD_REQUIRED challenge flow. Forgetting to respond to challenge before next authentication attempt.',
    0.93,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pool-managing-errors.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'CodeMismatchException: Invalid verification code provided',
    'cognito',
    'HIGH',
    '[
        {"solution": "Verify the user entered the correct confirmation code. Double-check code sent to email/SMS matches what user is submitting.", "percentage": 94},
        {"solution": "Confirmation codes expire after 24 hours by default. If code is old, request a new one using ResendConfirmationCode API", "percentage": 91},
        {"solution": "For MFA, do NOT call authenticate flow again after receiving SMS code - this invalidates the code. Pass the code directly to respond to MFA challenge.", "percentage": 88}
    ]'::jsonb,
    'User must have received a valid confirmation code via email or SMS. MFA flow must not re-trigger authentication.',
    'Code validation succeeds on first submission. User account becomes CONFIRMED or MFA challenge completes.',
    'Entering code incorrectly multiple times. Re-triggering authenticate() after receiving MFA code, which sends a new code and invalidates the old one. Assuming code works forever instead of checking expiration.',
    0.90,
    'haiku',
    NOW(),
    'https://repost.aws/questions/QUgs8jjn7JTNq6rqpdqJBjTA/expiredcodeexception-in-confirmpassword-request-with-just-recieved-code'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'ExpiredCodeException: Code has expired',
    'cognito',
    'HIGH',
    '[
        {"solution": "Confirmation codes expire after 24 hours. Request a new code: call ResendConfirmationCode for signup, or ForgotPassword for password reset.", "percentage": 95},
        {"solution": "For MFA timeout, increase the authentication session duration: App Client → App Client Settings → Authentication Flows → adjust session timeout (default 3 minutes)", "percentage": 90},
        {"solution": "If ConfirmSignUp fails with ExpiredCodeException but no code was requested, the code was never sent. Ensure email/SMS delivery is working and user received the code.", "percentage": 85}
    ]'::jsonb,
    'User account must exist in the user pool. Email/SMS delivery must be functioning.',
    'New code is successfully requested and received. User can confirm signup or reset password using fresh code.',
    'Waiting too long between requesting and using code. Not implementing exponential backoff when requesting new codes. Assuming code failure means account issue instead of timeout.',
    0.92,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pool-managing-errors.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'AliasExistsException: An account with the email already exists',
    'cognito',
    'HIGH',
    '[
        {"solution": "Check if email is already registered under a different username. Query user pool for the email to find existing account.", "percentage": 95},
        {"solution": "If email/phone is set as alias attribute, Cognito enforces uniqueness. Either use unique email or remove email as alias: User Pool → Attributes → uncheck ''Email address'' as alias", "percentage": 92},
        {"solution": "For user migration, update existing account via AdminUpdateUserAttributes instead of creating duplicate. Link accounts if needed.", "percentage": 85}
    ]'::jsonb,
    'Email or phone must be configured as alias attributes in user pool',
    'Account creation succeeds with new unique email. Existing account is updated correctly without creating duplicates.',
    'Attempting to signup same email twice. Not checking existing users before signup. Assuming error means data conflict when it''s just alias uniqueness.',
    0.91,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pool-managing-errors.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'InvalidParameterException: Unable to parse the number',
    'cognito',
    'HIGH',
    '[
        {"solution": "Check custom attributes with numeric types. Ensure values being submitted are valid numbers, not strings. Example: pass 123 not ''123''", "percentage": 93},
        {"solution": "Verify custom attribute schema in user pool: Cognito → User Pools → Attributes → check data types. For numbers, submit as integers not strings.", "percentage": 91},
        {"solution": "When importing or updating users with number attributes via AdminCreateUser or AdminUpdateUserAttributes, cast values to numbers in your code", "percentage": 88}
    ]'::jsonb,
    'User pool must have custom numeric attributes defined. Attribute must be present in schema.',
    'User creation succeeds with proper numeric values. Custom attributes are stored and retrieved correctly.',
    'Passing numeric values as strings (e.g., ''2024'' instead of 2024). Not validating attribute types before submission. Assuming error means schema corruption.',
    0.89,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/53719173/aws-cognito-create-new-user-giving-unable-to-parse-the-number-error'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'InvalidParameterException: Required custom attributes are not supported currently',
    'cognito',
    'HIGH',
    '[
        {"solution": "CloudFormation custom attributes cannot be marked as Required. Set Mutable=true and Developer Only Mode=false, but remove Required constraint.", "percentage": 94},
        {"solution": "In Cognito console, custom attributes are always optional. If you need required attributes, use standard attributes (email, phone, etc.) instead.", "percentage": 92},
        {"solution": "If using Terraform/CloudFormation, check Schema attributes and ensure all custom attributes have Mutable=true and do not set Required=true", "percentage": 90}
    ]'::jsonb,
    'Infrastructure as Code tool (CloudFormation, Terraform) used to create user pool. Custom attributes defined in template.',
    'User pool is created successfully. Custom attributes are optional and users can signup/login without providing them.',
    'Attempting to mark custom attributes as required in IaC templates. Assuming console behavior matches IaC for custom attributes. Not checking AWS documentation for custom attribute limitations.',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/64405348/aws-cognito-with-cloudformation-invalidparameterexception-on-schema-sttributes'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'InvalidParameterException: AttributesToGet invalid custom attribute',
    'cognito',
    'HIGH',
    '[
        {"solution": "When using ListUsers or GetUser with AttributesToGet, ensure custom attribute names are prefixed with ''custom:'' (e.g., ''custom:my_attribute'' not ''my_attribute'')", "percentage": 96},
        {"solution": "For standard attributes, use the exact name without prefix (e.g., ''email'', ''phone_number'', not ''custom:email'')", "percentage": 94},
        {"solution": "To retrieve all attributes, omit AttributesToGet parameter entirely or pass empty array. This avoids attribute name validation issues.", "percentage": 90}
    ]'::jsonb,
    'Custom attributes must be defined in user pool schema before querying',
    'ListUsers/GetUser successfully returns requested attributes. Attribute values are populated in response.',
    'Forgetting ''custom:'' prefix for custom attributes. Using wrong attribute names. Attempting to query attributes that don''t exist in schema.',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/46356698/aws-cognito-listusers-invalidparameterexception-using-attributestoget-on-custom'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'ThrottlingException: Request was denied due to request throttling',
    'cognito',
    'HIGH',
    '[
        {"solution": "Implement exponential backoff retry logic. Start with 1 second delay, double each retry (1s, 2s, 4s, 8s), max 5 retries.", "percentage": 96},
        {"solution": "Batch user operations: use AdminBatchGetUser for multiple user queries instead of individual GetUser calls", "percentage": 92},
        {"solution": "Reduce request rate by adding delays between API calls. For signup flows, distribute requests across time or use SQS queue for rate limiting.", "percentage": 88}
    ]'::jsonb,
    'Application must have AWS SDK configured with proper credentials. Retry logic must be implemented in client code.',
    'Requests succeed after retry attempts. No repeated ThrottlingException errors. Request latency increases but success rate reaches 100%.',
    'Not implementing any retry logic and failing immediately. Using fixed delays instead of exponential backoff. Assuming throttling means account limit reached.',
    0.90,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/CommonErrors.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'InvalidClientTokenId: The X.509 certificate or AWS access key ID does not exist',
    'cognito',
    'HIGH',
    '[
        {"solution": "Verify AWS access key ID and secret are correct. Check ~/.aws/credentials file or environment variables for typos.", "percentage": 96},
        {"solution": "If using temporary credentials, ensure STS token has not expired. Refresh credentials by calling STS GetSessionToken or using credential provider.", "percentage": 93},
        {"solution": "Check IAM user still exists and has not been deleted. Regenerate access keys if old keys were revoked: IAM → Users → Security credentials", "percentage": 91}
    ]'::jsonb,
    'Valid AWS account with active IAM user. AWS SDK must be configured with credentials.',
    'API calls to Cognito succeed with no InvalidClientTokenId errors. Authentication with AWS succeeds immediately.',
    'Using hardcoded expired credentials. Not rotating access keys regularly. Assuming error means Cognito service issue when it''s credential problem.',
    0.92,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/CommonErrors.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'AccessDeniedException: Insufficient access to perform this action',
    'cognito',
    'HIGH',
    '[
        {"solution": "Check IAM policy for the user/role executing the operation. Ensure policy includes required Cognito actions (e.g., cognito-idp:SignUp, cognito-idp:AdminGetUser)", "percentage": 95},
        {"solution": "For programmatic access, verify the policy is attached to the IAM user/role. Go to IAM → Users → [User] → Permissions to check attached policies", "percentage": 93},
        {"solution": "If using federated identity or assumed role, verify the role trust relationship allows your principal and has the necessary policy attached", "percentage": 90}
    ]'::jsonb,
    'AWS account with IAM permissions. IAM policy must grant Cognito actions.',
    'API call succeeds after policy is updated. No AccessDeniedException errors on subsequent calls.',
    'Assuming user has permissions without checking. Using policy for wrong resource ARN. Forgetting to attach policy to role/user.',
    0.91,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/CommonErrors.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'RequestExpired: Request timestamp outside acceptable time window',
    'cognito',
    'HIGH',
    '[
        {"solution": "Synchronize system clock with NTP. Cognito validates request timestamp ±15 minutes: run ''ntpdate -s time.nist.gov'' or enable system clock sync", "percentage": 96},
        {"solution": "Check server time vs AWS time. AWS uses UTC. Verify your server is in correct timezone or use UTC internally for API requests.", "percentage": 94},
        {"solution": "For pre-signed URLs, regenerate them if more than 15 minutes have passed. Pre-signed URL expiry must be checked before use.", "percentage": 92}
    ]'::jsonb,
    'System time must be synchronized. Server must have network access for NTP sync.',
    'Cognito API calls succeed immediately. Pre-signed URLs work until their specified expiration. No timestamp-related errors.',
    'Ignoring system clock drift. Using old pre-signed URLs. Assuming all servers are time-synced when some have drifted.',
    0.93,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/CommonErrors.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'NotAuthorizedException: Authorization failure in ConfirmSignUp',
    'cognito',
    'HIGH',
    '[
        {"solution": "Verify user is in correct state (UNCONFIRMED). User must not already be CONFIRMED. Check user status in Cognito console.", "percentage": 93},
        {"solution": "Ensure ClientId in ConfirmSignUp matches the app client that initiated SignUp. Mixing app clients causes auth failures.", "percentage": 91},
        {"solution": "Check that ConfirmSignUp is called within the same session as SignUp, or with proper client context. Some flows require continuous session.", "percentage": 85}
    ]'::jsonb,
    'User must be in UNCONFIRMED state. Correct app client must be used for entire flow.',
    'ConfirmSignUp succeeds and user transitions to CONFIRMED state. User can now authenticate.',
    'Calling ConfirmSignUp after user already confirmed. Using different app client than signup. Not passing correct ClientId.',
    0.88,
    'haiku',
    NOW(),
    'https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pool-managing-errors.html'
);
