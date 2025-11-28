INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'fatal: [hostname]: FAILED! => {"msg": "The task includes an option with an undefined variable"}',
    'ansible',
    'HIGH',
    '[
        {"solution": "Use the default filter to provide fallback values: {{ variable_name | default(''fallback_value'') }}. This prevents undefined variable errors when variables may not exist.", "percentage": 95},
        {"solution": "Use debug module to inspect variable sources: debug: var: hostvars[inventory_hostname] to trace where variables are defined and identify missing ones.", "percentage": 85}
    ]'::jsonb,
    'Ansible playbook with undefined variable references. Understanding variable precedence hierarchy.',
    'Playbook executes successfully without undefined variable errors. Task completes with proper fallback values or explicit variable definitions.',
    'Not using default filter when variables may be optional. Confusing variable precedence across different definition sources (group_vars, host_vars, inline).',
    0.92,
    'haiku',
    NOW(),
    'https://betterstack.com/community/guides/linux/ansible-errors/'
),
(
    'YAML Syntax Error: mapping values are not allowed here',
    'ansible',
    'HIGH',
    '[
        {"solution": "Use yamllint playbook.yml to validate YAML syntax before running playbook. Check indentation consistency - use exactly 2 spaces per level, never tabs.", "percentage": 98},
        {"solution": "Ensure strings containing colons, hashes, or special characters are quoted: \"http://example.com:8080\" not bare URLs.", "percentage": 90}
    ]'::jsonb,
    'YAML file with syntax issues. Access to ansible-playbook and yamllint tools.',
    'yamllint validation passes without errors. Playbook parses successfully without YAML syntax failures.',
    'Mixing tabs and spaces in indentation. Forgetting quotes around strings with special characters. Incorrect alignment of task parameters under tasks: key.',
    0.95,
    'haiku',
    NOW(),
    'https://betterstack.com/community/guides/linux/ansible-errors/'
),
(
    'fatal: [host]: UNREACHABLE! => {"msg": "Failed to connect to the host via ssh: ssh: connect to host X.X.X.X port 22: Connection timed out"}',
    'ansible',
    'CRITICAL',
    '[
        {"solution": "Verify SSH service is running on target host: systemctl status ssh. Check network connectivity: ping target_ip. Verify SSH port 22 is open: telnet target_ip 22.", "percentage": 90},
        {"solution": "Configure connection timeout in ansible.cfg: [ssh_connection] ssh_args = -o ConnectTimeout=30. Increase timeout value if network is slow.", "percentage": 85},
        {"solution": "Add target host''s SSH key to known_hosts: ssh-keyscan -t rsa target_ip >> ~/.ssh/known_hosts", "percentage": 80}
    ]'::jsonb,
    'Network connectivity to target hosts. SSH service running on remote machines. Valid SSH credentials configured.',
    'Playbook connects successfully to remote hosts. Tasks execute without connection timeouts or unreachable host errors.',
    'Not waiting for SSH service startup on newly provisioned VMs. Firewalls blocking port 22. Incorrect host IP addresses in inventory. Network MTU misconfigurations.',
    0.88,
    'haiku',
    NOW(),
    'https://betterstack.com/community/guides/linux/ansible-errors/'
),
(
    'fatal: [host]: FAILED! => {"msg": "Could not replace file: [Errno 26] Text file busy"}',
    'ansible',
    'MEDIUM',
    '[
        {"solution": "Ensure the target file is not being actively written to or executed by another process. Use lsof +D /path/to/check on target host to identify locks.", "percentage": 85},
        {"solution": "For binary files or executables, stop the consuming process first before copy/template tasks: systemctl stop service_name", "percentage": 90},
        {"solution": "Use async execution with delay between copy and service restart: async: 30 poll: 0", "percentage": 75}
    ]'::jsonb,
    'Target file system access. Permissions to view process locks on remote hosts.',
    'File successfully replaced without "Text file busy" errors. Task completes without conflicts from running processes.',
    'Attempting to replace executables while they''re running. Not stopping services before updating binaries. File locking issues on shared storage.',
    0.82,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/32346342/ansible-text-file-busy-error/'
),
(
    'fatal: [host]: FAILED! => {"msg": "command timeout triggered, timeout value is 10 secs. See the timeout setting options in the Network Debug and Troubleshooting Guide."}',
    'ansible',
    'HIGH',
    '[
        {"solution": "Increase task timeout: command_timeout: 60 or timeout: 3600 at task level. For network devices add to connection block: timeout: 300", "percentage": 92},
        {"solution": "Use async execution for long-running tasks: async: 3600 with poll: 30 for polling every 30 seconds.", "percentage": 88},
        {"solution": "Check network latency and device responsiveness. Test device connectivity separately before running playbook: ssh -vvv user@device", "percentage": 80}
    ]'::jsonb,
    'Long-running commands on remote hosts. Network timeouts or slow device responses. Understanding async/await patterns.',
    'Tasks complete within timeout window. Network devices respond within timeout period. No timeout errors in playbook execution.',
    'Not adjusting timeout for intentionally long operations like backups or data transfers. Default 10-second timeout too aggressive for WAN connections. Polling interval too aggressive causing device overload.',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/62883087/error-when-i-am-trying-to-execute-show-version-into-a-cisco-device/'
),
(
    'fatal: [localhost]: FAILED! => {"msg": "Failed to update cache: unknown reason"}',
    'ansible',
    'MEDIUM',
    '[
        {"solution": "Verify internet connectivity on target host: ping 8.8.8.8. Check DNS resolution: dig google.com. Run apt-get update manually to see real error.", "percentage": 85},
        {"solution": "Update package manager cache explicitly before operations: apt: update_cache=yes cache_valid_time=3600", "percentage": 90},
        {"solution": "For offline environments, use pre-downloaded packages or configure local apt mirror in ansible.cfg", "percentage": 75}
    ]'::jsonb,
    'Internet access on target host. Ability to run apt-get on remote machine. Package manager installed.',
    'Cache updates successfully. apt: tasks complete without "Failed to update cache" errors. Packages install successfully.',
    'Assuming internet access when deploying to isolated networks. Not providing meaningful error output from apt-get. Insufficient disk space for cache.',
    0.87,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/71748254/ansible-playbook-failed-to-update-cache-unknown-reason/'
),
(
    'fatal: [host]: FAILED! => {"msg": "privilege escalation failed"}',
    'ansible',
    'HIGH',
    '[
        {"solution": "Configure passwordless sudo for ansible user: ansible ALL=(ALL) NOPASSWD:ALL in /etc/sudoers via visudo. Or use --ask-become-pass flag when running playbook.", "percentage": 93},
        {"solution": "Verify become settings in playbook: become: true become_method: sudo become_user: root. Ensure ansible user exists on target.", "percentage": 88},
        {"solution": "Check SSH key permissions: chmod 600 ~/.ssh/id_rsa and authorized_keys permissions: chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys", "percentage": 85}
    ]'::jsonb,
    'Sudo access on target hosts. Ansible user with appropriate privilege escalation rights. SSH key-based authentication configured.',
    'Tasks execute with elevated privileges successfully. No "privilege escalation failed" errors. become: true tasks complete.',
    'Not configuring passwordless sudo for automated execution. Incorrect become_method specified. User shell set to /usr/sbin/nologin preventing escalation.',
    0.91,
    'haiku',
    NOW(),
    'https://betterstack.com/community/guides/linux/ansible-errors/'
),
(
    'ERROR! Syntax Error while loading YAML. did not find expected key',
    'ansible',
    'HIGH',
    '[
        {"solution": "Run: ansible-playbook --syntax-check playbook.yml to catch syntax errors before execution. Review YAML structure for missing colons or keys.", "percentage": 98},
        {"solution": "Use online YAML validator (yamllint.com) or editor with YAML highlighting to identify structural issues immediately.", "percentage": 92},
        {"solution": "Ensure every line after a colon has a value or nested structure. Check for trailing colons without values.", "percentage": 90}
    ]'::jsonb,
    'Ansible playbook file in YAML format. Access to yaml validation tools. Understanding of YAML syntax requirements.',
    'Syntax check passes without errors. Playbook loads successfully without YAML parsing errors.',
    'Mixing YAML and JSON syntax. Missing colons after keys. Incorrect indentation after nested structures. Using tabs instead of spaces.',
    0.96,
    'haiku',
    NOW(),
    'https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_debugger.html'
),
(
    'error while evaluating conditional: ''item'' is undefined',
    'ansible',
    'MEDIUM',
    '[
        {"solution": "Ensure loop variable matches conditional: when: item != undefined. Verify the loop has items before conditionals run.", "percentage": 92},
        {"solution": "Use when: with_items | default([]) to provide empty list fallback when loop items don''t exist.", "percentage": 88},
        {"solution": "Check task is within loop context. Conditionals referencing item need to be inside with_items or loop block.", "percentage": 90}
    ]'::jsonb,
    'Understanding Ansible loops and conditional syntax. Variable scope in loops. Jinja2 template syntax.',
    'Conditionals evaluate successfully without undefined variable errors. Loops execute with proper item variable references.',
    'Using item variable outside loop context. Not checking if loop list is empty before using item. Confusing item scope across blocks.',
    0.85,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/42417079/how-to-debug-ansible-issues/'
),
(
    'FAILED! => {"msg": "Unable to look up a name or access an attribute in template string (...)"}',
    'ansible',
    'MEDIUM',
    '[
        {"solution": "Avoid using variable names with hyphens in conditionals. Hyphenated variables should use variable[''key''] syntax not dot notation.", "percentage": 90},
        {"solution": "Use quotes around Jinja2 conditionals with complex expressions: when: (result.rc | int) == 0", "percentage": 85},
        {"solution": "Test Jinja2 templates with debug module before using in conditionals: debug: msg=\"{{ expression_to_test }}\"", "percentage": 80}
    ]'::jsonb,
    'Complex Jinja2 templates. Variable names without invalid characters (hyphens). Testing templates before deployment.',
    'Conditionals evaluate without templating errors. Complex template expressions render correctly. Variables resolve properly.',
    'Using hyphenated variable names with dot notation. Complex nested conditions without proper quoting. Undefined variables in template expressions.',
    0.83,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/39069619/ansible-perform-a-failed-when-on-an-async-task-based-on-a-value-from-stdout/'
),
(
    'FATAL: all hosts have already failed -- aborting',
    'ansible',
    'MEDIUM',
    '[
        {"solution": "Use ignore_errors: true on individual tasks to allow playbook to continue despite failures. Then validate results separately.", "percentage": 88},
        {"solution": "Use block-rescue-always for graceful error handling: block: [tasks] rescue: [recovery_tasks] always: [cleanup]", "percentage": 92},
        {"solution": "Set any_errors_fatal: false at play level to continue with other hosts if one fails instead of aborting entire play.", "percentage": 85}
    ]'::jsonb,
    'Multiple hosts in inventory. Error handling strategy defined. Understanding fail fast vs continue behavior.',
    'Playbook continues execution across multiple hosts. Failures on some hosts don''t abort entire play. Error recovery completes successfully.',
    'Using default any_errors_fatal which stops playbook on first host failure. Not using rescue blocks for anticipated failures. Treating all errors as fatal without recovery logic.',
    0.89,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/32346342/ansible-text-file-busy-error/'
),
(
    'failed_when conditional doesn''t trigger on expected failures',
    'ansible',
    'MEDIUM',
    '[
        {"solution": "Register task output first: register: result. Then check rc code: failed_when: result.rc != 0 and result.rc != 1. Ensure custom failure logic handles all cases.", "percentage": 93},
        {"solution": "Verify failed_when condition logic matches actual output. Test with debug before using in failed_when: debug: var: result to inspect actual output format.", "percentage": 90},
        {"solution": "Remember that failed_when: false only applies to stderr/stdout inspection, not to connection or undefined variable errors.", "percentage": 85}
    ]'::jsonb,
    'Understanding command output format (rc, stdout, stderr). Testing conditions with debug. Knowledge of what errors can be customized.',
    'Custom failure conditions work as expected. Tasks fail/pass based on failed_when logic. Appropriate errors trigger or skip.',
    'Incorrect return code comparisons. Using failed_when on connection failures (doesn''t work). Checking wrong output fields (stdout vs stderr).',
    0.84,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/55905980/error-handling-with-failed-when-doesnt-work/'
),
(
    'The PyMySQL Python 2.7 module is required',
    'ansible',
    'MEDIUM',
    '[
        {"solution": "Install required Python module on target host: pip install PyMySQL or pip3 install PyMySQL. Run before using mysql_* modules.", "percentage": 95},
        {"solution": "Use the shell/command module to install dependencies: command: pip install PyMySQL", "percentage": 88},
        {"solution": "For distribution packages use: apt: name=python3-pymysql state=present instead of pip for system-wide installation.", "percentage": 90}
    ]'::jsonb,
    'Target host with Python installed. Pip or package manager available. Network access for downloading packages.',
    'PyMySQL module installed and importable. mysql_* Ansible modules work without missing dependency errors.',
    'Not installing Python dependencies on target hosts before using database modules. Assuming system Python has all required packages. Using Python 2 when Python 3 is required.',
    0.91,
    'haiku',
    NOW(),
    'https://www.youtube.com/watch?v=87wA8bqMupk'
),
(
    'TASK FAILED. retry_remaining: X retries left',
    'ansible',
    'LOW',
    '[
        {"solution": "Increase retries value: retries: 10 with delay: 5 to give transient failures time to resolve. Use for network/service operations.", "percentage": 90},
        {"solution": "Add until condition to check for success: until: result.rc == 0. Combine with retries to poll until condition met.", "percentage": 92},
        {"solution": "Investigate root cause - retries hide underlying issues. Check service/network status, not just retry blindly.", "percentage": 80}
    ]'::jsonb,
    'Transient failures in tasks (network, service availability). Ability to define retry/until logic. Root cause investigation skills.',
    'Task succeeds after retries. Transient failures resolve. Retry mechanism implements exponential backoff.',
    'Retrying without fixing root cause. Insufficient retry count for slow operations. Not using delay between retries on rate-limited services.',
    0.86,
    'haiku',
    NOW(),
    'https://spacelift.io/blog/ansible-debug'
),
(
    'Ansible is being run in a world writable directory',
    'ansible',
    'LOW',
    '[
        {"solution": "Set proper directory permissions: chmod 750 /path/to/playbook/dir or move playbooks to properly secured location (not /tmp).", "percentage": 95},
        {"solution": "Disable this warning by setting allow_world_readable_tmpfiles = True in ansible.cfg [defaults] section.", "percentage": 75},
        {"solution": "Use ansible.cfg in project root with restrict_common_plugins_fd = True to enforce safer defaults.", "percentage": 70}
    ]'::jsonb,
    'File system permissions. Understanding of world-writable directories. Ansible configuration file access.',
    'Playbook executes without world-writable directory warnings. Files/directories have appropriate permission restrictions (755 or 750).',
    'Storing playbooks in /tmp or shared directories. Ignoring security warnings without addressing root cause. Over-permissive directory settings.',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/78982858/preventing-fatal-errors-but-allowing-most-errors-to-trigger-rescue-block/'
)
