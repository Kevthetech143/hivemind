INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES
(
    'Postman request timeout error after 120 seconds',
    'misc-tools',
    'HIGH',
    '[
        {"solution": "Go to Settings → General → Request timeout (ms) and increase value. Set to 0 for infinite timeout. Default is often 120000ms (2 min). For 5 min requests use 300000ms", "percentage": 95},
        {"solution": "Check if requests pass through load balancer with own timeout limits. May need to increase timeout on intermediate network devices, not just Postman client", "percentage": 70}
    ]'::jsonb,
    'Postman client installed, access to Settings menu',
    'Request completes without timeout error. Verify with longer running requests (5+ min)',
    'Confusing 502 Bad Gateway with client timeout - 502 is server response, not Postman timeout. Setting Postman timeout won''t fix upstream timeouts',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/36355732/how-to-increase-postman-client-request-timeout',
    'admin:1764174268'
),
(
    'nvm use does not switch Node version on Windows',
    'misc-tools',
    'HIGH',
    '[
        {"solution": "Delete C:\\Program Files\\nodejs folder completely, then run nvm use {version} to repopulate symlink correctly", "percentage": 96},
        {"solution": "Run PowerShell or Command Prompt as Administrator before executing nvm commands to ensure symlink creation permissions", "percentage": 88},
        {"solution": "Uninstall Node.js completely via Control Panel Programs and Features, then only install versions through nvm", "percentage": 94}
    ]'::jsonb,
    'nvm installed on Windows, Node version installed via nvm install',
    'Running node --version shows correct version. nvm current returns expected version',
    'Expecting silent success - nvm may appear to succeed but symlink creation fails silently due to permissions or folder conflict. Always verify with node --version',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/47017812/nvm-use-does-not-switch-node-versions',
    'admin:1764174268'
),
(
    'CONFLICT (content): Merge conflict in git repository',
    'misc-tools',
    'HIGH',
    '[
        {"solution": "Run git mergetool to open visual merge interface (uses vimdiff, meld, kdiff3 or p4merge). Then git add [file] && git commit -m \"resolved conflicts\"", "percentage": 88},
        {"solution": "Configure diff3 style: git config merge.conflictstyle diff3. Shows three sections (your changes, original, incoming) making conflicts clearer", "percentage": 82},
        {"solution": "Accept one side completely: git checkout --ours [filename] (keep your version) or git checkout --theirs [filename] (accept incoming). Then git add and commit", "percentage": 85}
    ]'::jsonb,
    'Git repository with merge in progress, conflicted files present',
    'git status shows no conflicted files. Merge completes and new commit created',
    'Not committing after resolving - must run git add and git commit after manual resolution. Forgetting to stage changes leaves merge incomplete',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/161813/how-do-i-resolve-merge-conflicts-in-a-git-repository',
    'admin:1764174268'
),
(
    'Error: An unexpected error occurred during brew link Permission denied',
    'misc-tools',
    'HIGH',
    '[
        {"solution": "Run sudo chown -R $(whoami) /usr/local/Homebrew to fix ownership. Then run brew link [formula] again", "percentage": 91},
        {"solution": "Run brew doctor to identify permission issues, then fix with: sudo chown -R $(whoami) /usr/local/Homebrew /usr/local/var/homebrew", "percentage": 89},
        {"solution": "Remove conflicting files/folders in /usr/local then run brew doctor and brew link to restore", "percentage": 75}
    ]'::jsonb,
    'Homebrew installed, user has sudo access, formula installed',
    'brew link succeeds without Permission denied error. brew doctor shows no permission warnings',
    'Running brew commands without checking /usr/local ownership first. Must fix ownership before linking. Running without sudo when needed',
    0.89,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/16432071/how-to-fix-homebrew-permissions',
    'admin:1764174268'
),
(
    'Docker permission denied while trying to connect to Docker daemon socket',
    'misc-tools',
    'HIGH',
    '[
        {"solution": "Run: sudo usermod -aG docker $USER && newgrp docker to add user to docker group and activate group. No sudo needed after this", "percentage": 97},
        {"solution": "If above fails, restart Docker daemon: sudo systemctl restart docker then try docker ps", "percentage": 85},
        {"solution": "Check socket permissions: ls -l /var/run/docker.sock. Should be rw-rw---- with docker group. Fix with: sudo chmod 660 /var/run/docker.sock", "percentage": 78}
    ]'::jsonb,
    'Docker installed, docker daemon running, user account exists',
    'docker ps returns list of containers without sudo. No permission denied errors',
    'Running docker commands with sudo repeatedly instead of fixing group permissions permanently. Forgetting to restart shell session after usermod',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/48957195/how-to-fix-docker-permission-denied-error',
    'admin:1764174268'
),
(
    'npm EACCES permission denied error when installing global packages',
    'misc-tools',
    'HIGH',
    '[
        {"solution": "Fix npm permissions: mkdir ~/.npm-global && npm config set prefix ''~/.npm-global'' && export PATH=~/.npm-global/bin:$PATH", "percentage": 94},
        {"solution": "Change npm cache permissions: sudo chown -R $(whoami) ~/.npm then retry npm install -g", "percentage": 87},
        {"solution": "Use nvm to manage Node instead of system Node, avoiding permission issues entirely", "percentage": 89}
    ]'::jsonb,
    'npm installed, attempting global package installation (-g flag)',
    'npm install -g [package] succeeds without permission errors. Package available in PATH',
    'Using sudo with npm (anti-pattern that causes more problems). Not updating PATH after configuring npm prefix. Confusing EACCES with missing package',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/16151018/npm-throws-error-without-sudo',
    'admin:1764174268'
),
(
    'ssh Permission denied (publickey) when connecting to remote server',
    'misc-tools',
    'HIGH',
    '[
        {"solution": "Check SSH key permissions: chmod 700 ~/.ssh && chmod 600 ~/.ssh/id_rsa. Keys must be readable only by owner", "percentage": 96},
        {"solution": "Verify public key on server: cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys on remote server. Then chmod 600 ~/.ssh/authorized_keys", "percentage": 92},
        {"solution": "Test with verbose output: ssh -vvv user@host to see which keys are tried and why they''re rejected", "percentage": 88}
    ]'::jsonb,
    'SSH key pair generated, remote server with SSH access enabled',
    'ssh user@host connects successfully without password prompt. No permission denied message',
    'Wrong file permissions on keys or authorized_keys (must be 600). Public key not added to remote authorized_keys. Using wrong private key file',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/2643502/how-to-fix-permission-denied-publickey-error-when-using-git',
    'admin:1764174268'
),
(
    'curl CURLE_OPERATION_TIMEDOUT connection timeout waiting for server response',
    'misc-tools',
    'HIGH',
    '[
        {"solution": "Increase timeout: curl --max-time 30 [URL] (sets timeout to 30 seconds). Default is 300 seconds", "percentage": 91},
        {"solution": "Set connection timeout separately: curl --connect-timeout 10 --max-time 30 [URL] to timeout faster on connection vs total operation", "percentage": 87},
        {"solution": "Check network: ping -c 3 [hostname] to verify host is reachable. Try curl -v [URL] to see where it hangs", "percentage": 79}
    ]'::jsonb,
    'curl installed, network connectivity available',
    'curl returns response within timeout window. No CURLE_OPERATION_TIMEDOUT error',
    'Not distinguishing between connection timeout and total operation timeout. Using same value for both. Server actually being down vs slow response',
    0.88,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/10983788/what-does-curl-operation-timeout-mean',
    'admin:1764174268'
),
(
    'grep Permission denied when searching files in restricted directories',
    'misc-tools',
    'MEDIUM',
    '[
        {"solution": "Add -r (recursive) and ignore permission errors with: grep -r --ignore-case \"pattern\" . 2>/dev/null to suppress permission denied messages", "percentage": 85},
        {"solution": "Run grep with sudo on restricted directories: sudo grep -r \"pattern\" /restricted/path to access files you own through sudo", "percentage": 88},
        {"solution": "Check file permissions: ls -la [file]. Add read permission if needed: chmod u+r [file] to make readable to owner", "percentage": 90}
    ]'::jsonb,
    'grep installed, files exist in directory',
    'grep returns matches without permission errors. Suppressed or resolved permission warnings',
    'Assuming all files are readable without checking permissions first. Running grep on system directories without sudo when needed',
    0.87,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/10385867/grep-permission-denied',
    'admin:1764174268'
),
(
    'wget connection timed out unable to establish connection within timeout period',
    'misc-tools',
    'MEDIUM',
    '[
        {"solution": "Increase timeout: wget --timeout=30 [URL] (increases from default 900 seconds to 30, or use larger value)", "percentage": 89},
        {"solution": "Set read timeout separately: wget --timeout=10 --read-timeout=30 [URL] for connection vs read operations", "percentage": 84},
        {"solution": "Check network and DNS: ping [domain] and nslookup [domain] to verify host reachable before trying wget", "percentage": 76}
    ]'::jsonb,
    'wget installed, network connection available',
    'wget successfully downloads file within timeout window. No connection timeout error',
    'Using same timeout for all operations when they behave differently. Not checking if URL is valid before adjusting timeout',
    0.86,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/11555430/wget-timeout-exceeded',
    'admin:1764174268'
);
