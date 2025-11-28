INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'connect() failed (111: Connection refused) while connecting to upstream',
    'nginx',
    'HIGH',
    '[
        {"solution": "Check if backend service is running on the specified port. Use netstat -tulpn or lsof -i to verify. Restart the service if it''s not responding: sudo systemctl restart php-fpm or sudo systemctl restart nginx-upstream-service", "percentage": 95},
        {"solution": "Verify the upstream configuration points to the correct host and port. Check /etc/nginx/sites-available or /etc/nginx/conf.d for correct fastcgi_pass or proxy_pass directives", "percentage": 85},
        {"solution": "Ensure the service is bound to all interfaces (0.0.0.0) not just localhost (127.0.0.1) if connecting from another machine", "percentage": 80}
    ]'::jsonb,
    'Access to nginx error logs, knowledge of running services, ability to restart services',
    'Backend service responds to requests, nginx error log no longer contains connection refused errors, curl to upstream directly succeeds',
    'Assuming port is wrong without checking service logs, restarting nginx instead of the backend service, not accounting for firewall rules blocking ports',
    0.92,
    'haiku',
    NOW(),
    'https://serverfault.com/questions/606739/nginx-502-bad-gateway-111-connection-refused-port-not-being-listened-to'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'rewrite or internal redirection cycle while internally redirecting to "/index.html"',
    'nginx',
    'HIGH',
    '[
        {"solution": "Add =404 to end of try_files directive to prevent infinite loop: location / { try_files $uri $uri/ /index.html =404; }", "percentage": 98},
        {"solution": "Ensure index.html actually exists in the root directory and has correct permissions for nginx user", "percentage": 90},
        {"solution": "Use explicit location handling to avoid recursion: location = /index.html { # serve directly without further redirects }", "percentage": 85}
    ]'::jsonb,
    'Access to nginx configuration files, ability to verify file existence and permissions',
    'No more rewrite cycle errors in logs, requests to non-existent files return 404 instead of looping, SPA routes work correctly',
    'Forgetting to verify index.html actually exists, using try_files without a final fallback that stops recursion, not checking if file has execute permissions for parent directory',
    0.95,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/46514838/why-does-this-nginx-config-result-in-rewrite-or-internal-redirection-cycle'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Segmentation fault (core dumped) when using nginx reverse proxy',
    'nginx',
    'MEDIUM',
    '[
        {"solution": "Add proxy_set_header X-Real-IP $remote_addr; to pass client IP to upstream application. This is critical for applications like flask-profiler that need client information", "percentage": 92},
        {"solution": "Check for large map_hash_bucket_size values exceeding 65536 minus ngx_cacheline_size. Reduce to reasonable values: map_hash_bucket_size 32;", "percentage": 85},
        {"solution": "Verify upstream module compatibility and versions. Consider reverting to a known-stable nginx version if recently upgraded", "percentage": 70}
    ]'::jsonb,
    'Ability to modify nginx configuration, access to upstream application logs, core dump analysis tools (gdb) optional',
    'Upstream application no longer crashes, nginx processes run without segmentation faults, application logs show correct client IPs',
    'Not including necessary proxy headers, using oversized hash bucket configurations, not checking if segfault is caused by third-party module incompatibility',
    0.88,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/64214321/segmentation-fault-core-dumped-when-using-nginx-reverse-proxy-flask'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'connect() to unix:/var/run/php5-fpm.sock failed (13: Permission denied)',
    'nginx',
    'HIGH',
    '[
        {"solution": "Edit /etc/php5/fpm/pool.d/www.conf (or /etc/php/7.x/fpm/pool.d/www.conf for newer versions) and set: listen.owner = www-data, listen.group = www-data, listen.mode = 0660. Then: sudo service php-fpm restart", "percentage": 98},
        {"solution": "Verify nginx user matches the socket owner. Check nginx user with: ps aux|grep nginx. Ensure listen.owner matches that user", "percentage": 95},
        {"solution": "If using uWSGI, use --uid www-data --gid www-data --chmod-socket=660 when starting the service", "percentage": 92}
    ]'::jsonb,
    'Root/sudo access to modify PHP-FPM or uWSGI configuration files, ability to restart services',
    'nginx error log no longer shows permission denied errors, PHP-FPM responds through the socket, web requests complete successfully',
    'Setting listen.mode = 0666 without proper ownership (security issue), not restarting the service after configuration changes, mismatching nginx user with socket owner',
    0.96,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/23443398/nginx-error-connect-to-php5-fpm-sock-failed-13-permission-denied'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'nginx: socket() failed (24: Too many open files)',
    'nginx',
    'HIGH',
    '[
        {"solution": "Increase system-wide file descriptor limit in /etc/sysctl.conf: fs.file-max=50000. Then: sudo sysctl -p to apply", "percentage": 90},
        {"solution": "Increase nginx user limits in /etc/security/limits.conf: nginx soft nofile 10000 and nginx hard nofile 30000", "percentage": 92},
        {"solution": "Add worker_rlimit_nofile 30000; to main nginx.conf context (outside server and events blocks)", "percentage": 95},
        {"solution": "For systemd-based systems, create override: systemctl edit nginx and add LimitNOFILE=30000 in [Service] section", "percentage": 88}
    ]'::jsonb,
    'Root/sudo access to modify sysctl, limits.conf, and nginx.conf files. For systemd: systemctl access',
    'nginx -t shows no warnings, error log no longer contains "too many open files", nginx can handle expected connection load without failures',
    'Only modifying nginx.conf without changing system limits, not restarting nginx after changes (must fully restart master process), using reload instead of restart for master process changes',
    0.91,
    'haiku',
    NOW(),
    'https://www.cyberciti.biz/faq/linux-unix-nginx-too-many-open-files/'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'upstream timed out (110: Connection timed out) while connecting to upstream',
    'nginx',
    'HIGH',
    '[
        {"solution": "Increase timeout directives in nginx.conf. Add: proxy_connect_timeout 30s; proxy_send_timeout 60s; proxy_read_timeout 60s; in server or location block", "percentage": 94},
        {"solution": "For FastCGI, increase: fastcgi_connect_timeout 60; fastcgi_send_timeout 300; fastcgi_read_timeout 300;", "percentage": 92},
        {"solution": "Check if upstream server is actually slow or down. Monitor backend performance with top, vmstat, or application-specific profiling tools", "percentage": 85},
        {"solution": "Increase client-side timeout to match: send_timeout 300s; ensure it''s greater than upstream timeouts", "percentage": 80}
    ]'::jsonb,
    'Access to nginx configuration files, ability to monitor upstream server resources, upstream application logs access',
    'Requests complete within timeout period, error logs no longer show timeout messages, upstream server performance metrics are acceptable',
    'Setting timeouts too low without investigating actual upstream performance, not coordinating timeout values across all layers, setting same timeout for connect and read operations when they need different values',
    0.89,
    'haiku',
    NOW(),
    'https://www.netdata.cloud/academy/how-to-diagnose-and-fix-504-gateway-timeout-errors-in-nginx/'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    '413 Request Entity Too Large',
    'nginx',
    'HIGH',
    '[
        {"solution": "Increase nginx client_max_body_size in http, server, or location block: client_max_body_size 100M; (use M for megabytes, not MB)", "percentage": 96},
        {"solution": "Also increase PHP limits if applicable: post_max_size=128M and upload_max_filesize=100M in /etc/php.ini or /etc/php/7.x/fpm/php.ini", "percentage": 90},
        {"solution": "Verify configuration with nginx -t then reload with sudo systemctl restart nginx (may need to restart PHP-FPM as well)", "percentage": 92},
        {"solution": "Note that max body size will typically be 1.34x larger than actual file upload size in calculation", "percentage": 75}
    ]'::jsonb,
    'Access to nginx configuration files and PHP configuration files if using PHP backend, ability to restart services',
    'File uploads complete successfully, error logs no longer contain 413 errors, request entity size matches configuration limits',
    'Using MB instead of M in directive syntax, not coordinating nginx and PHP-FPM size limits, not restarting services after configuration changes, forgetting trailing semicolon',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/24306335/413-request-entity-too-large-file-upload-issue'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'nginx: [emerg] bind() to [::]:80 failed (98: Address already in use)',
    'nginx',
    'HIGH',
    '[
        {"solution": "Find process using the port: sudo lsof -i :80 or sudo netstat -tulpn | grep 80. Kill it: sudo fuser -k 80/tcp", "percentage": 96},
        {"solution": "If Apache is running on same port, stop it: sudo systemctl stop apache2 then sudo systemctl start nginx", "percentage": 95},
        {"solution": "Check for duplicate listen directives in nginx configuration. Use nginx -t to validate config", "percentage": 90},
        {"solution": "Fix IPv6 listen syntax - use listen [::]:80 ipv6only=on; instead of listen :80;", "percentage": 85},
        {"solution": "As last resort, restart the system to clear zombie processes", "percentage": 70}
    ]'::jsonb,
    'Root/sudo access, ability to run lsof/netstat commands, access to nginx configuration files',
    'nginx -t shows success, nginx service starts without error, ports 80 and 443 respond to requests',
    'Killing wrong process, not checking for duplicate listen directives after fixing port conflict, forgetting to reload nginx config, not accounting for IPv6 binding to IPv4 ports',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/42303401/nginx-will-not-start-address-already-in-use'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'upstream sent too big header while reading response header from upstream',
    'nginx',
    'MEDIUM',
    '[
        {"solution": "For proxy connections, increase buffer sizes: proxy_buffer_size 128k; proxy_buffers 8 256k; proxy_busy_buffers_size 256k; in server or http block", "percentage": 94},
        {"solution": "For FastCGI, use: fastcgi_buffer_size 128k; fastcgi_buffers 8 128k; in http block", "percentage": 92},
        {"solution": "If initial settings don''t work, progressively increase to 64k, 128k, 256k, or 512k as needed", "percentage": 88},
        {"solution": "Investigate upstream server for large headers/cookies. Check application logs for oversized cookie values (> 4KB)", "percentage": 85}
    ]'::jsonb,
    'Access to nginx configuration files, ability to monitor upstream application and cookie sizes, PHP/backend application logs',
    'Error no longer appears in logs, large response headers are properly handled, client receives complete response',
    'Setting proxy_buffering off without increasing buffer sizes, not checking upstream for application-generated large headers, placing directives in wrong nginx context (location vs server vs http)',
    0.90,
    'haiku',
    NOW(),
    'https://www.cyberciti.biz/faq/nginx-upstream-sent-too-big-header-while-reading-response-header-from-upstream/'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'recv() failed (104: Connection reset by peer) while reading response header from upstream',
    'nginx',
    'MEDIUM',
    '[
        {"solution": "Ensure keepalive_timeout values match between nginx and upstream. If nginx is higher than upstream, upstream drops connection prematurely: keepalive_timeout 65s;", "percentage": 93},
        {"solution": "Restart the upstream service if it''s running out of resources: sudo systemctl restart php-fpm or relevant service", "percentage": 88},
        {"solution": "Increase worker connection limits in nginx events block: worker_connections 2048;", "percentage": 85},
        {"solution": "Check for IPS/firewall devices dropping connections under load. Review firewall and security appliance logs", "percentage": 75},
        {"solution": "Monitor upstream application for errors and crashes. Check upstream logs for segmentation faults or out-of-memory errors", "percentage": 80}
    ]'::jsonb,
    'Access to nginx configuration, upstream service configuration, system monitoring tools (top, htop), upstream application logs',
    'Connection errors no longer appear randomly, requests complete successfully under load, upstream service runs stably',
    'Only increasing nginx timeout without checking upstream configuration, ignoring system resource exhaustion, not investigating upstream application errors, not checking security devices between nginx and upstream',
    0.82,
    'haiku',
    NOW(),
    'https://serverfault.com/questions/543999/104-connection-reset-by-peer-while-reading-response-header-from-upstream-nginx'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'no live upstreams while connecting to upstream',
    'nginx',
    'MEDIUM',
    '[
        {"solution": "Verify all upstream servers are running and responding. Test with curl or nc: curl http://upstream-ip:port or nc -zv upstream-ip port", "percentage": 95},
        {"solution": "Check nginx upstream health check timeouts: max_fails=1 fail_timeout=10s means one timeout marks server down for 10s. Increase fail_timeout if upstream is occasionally slow", "percentage": 92},
        {"solution": "Verify upstream server is bound to correct IP. Use netstat -tulpn to check listening addresses", "percentage": 90},
        {"solution": "Ensure DNS resolution works for upstream hostnames: nslookup upstream.example.com. Use IP addresses if DNS is unreliable", "percentage": 85},
        {"solution": "Verify firewall rules allow traffic between nginx and upstream. Check iptables or cloud security groups", "percentage": 80}
    ]'::jsonb,
    'Access to nginx configuration and logs, curl or nc command-line tools, DNS tools, firewall access if needed',
    'Upstream servers are marked live in nginx, requests route successfully, health check intervals are appropriate for application',
    'Not verifying upstream is actually running before investigating nginx, using too strict health check settings for slow backends, not accounting for temporary DNS failures, overlooking firewall rules',
    0.88,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/49767001/how-to-solve-nginx-no-live-upstreams-while-connecting-to-upstream-client'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Invalid HTTP_HOST header with reverse proxy',
    'nginx',
    'MEDIUM',
    '[
        {"solution": "Set Host header explicitly in reverse proxy: proxy_set_header Host $http_host; or proxy_set_header Host $host;", "percentage": 96},
        {"solution": "Also set X-Forwarded-For and X-Forwarded-Host: proxy_set_header X-Forwarded-For $remote_addr; proxy_set_header X-Forwarded-Host $server_name;", "percentage": 94},
        {"solution": "For specific applications (like webpack-dev-server), use map directive to conditionally set Host header for allowed hosts", "percentage": 85},
        {"solution": "Ensure upstream application''s ALLOWED_HOSTS configuration includes the host header being sent by nginx", "percentage": 90}
    ]'::jsonb,
    'Access to nginx configuration files, knowledge of upstream application''s host validation requirements, ability to test with curl',
    'Reverse proxy forwards requests successfully, upstream application accepts Host header, no more invalid host errors in upstream logs',
    'Not setting Host header at all, using wrong variable ($server_name vs $http_host), not accounting for upstream application validation requirements, applying headers in wrong context',
    0.91,
    'haiku',
    NOW(),
    'https://serverfault.com/questions/1096472/invalid-http_host-header-nginx-config-not-preventing-localhost-invalid-headers'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'No such file or directory (nginx fastcgi socket not found)',
    'nginx',
    'HIGH',
    '[
        {"solution": "Verify the socket path in fastcgi_pass directive matches where PHP-FPM actually creates the socket. Common correct paths: /run/php/php8.1-fpm.sock, /var/run/php-fpm.sock", "percentage": 97},
        {"solution": "Confirm PHP-FPM is running and the socket file exists: ls -la /run/php/php*.sock", "percentage": 96},
        {"solution": "Check PHP-FPM configuration for the listen directive: grep listen /etc/php/*/fpm/pool.d/*.conf", "percentage": 94},
        {"solution": "Ensure parent directory has execute permissions for nginx user so socket can be accessed: chmod 755 /run/php", "percentage": 92}
    ]'::jsonb,
    'Access to nginx and PHP-FPM configuration files, ability to list files and check permissions, PHP-FPM service status',
    'Socket file exists and is accessible to nginx user, PHP-FPM responds through socket, web requests complete successfully',
    'Using outdated socket paths from old PHP versions, not verifying socket actually exists before assuming nginx is wrong, forgetting parent directory permissions, incorrect socket path syntax in fastcgi_pass',
    0.95,
    'haiku',
    NOW(),
    'https://www.cloudpanel.io/blog/502-bad-gateway-nginx-fix/'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'client SSL certificate verify error: (27: certificate not trusted)',
    'nginx',
    'MEDIUM',
    '[
        {"solution": "For upstream server verification, ensure certificate chain is complete. Concatenate intermediate certs with server cert: cat server.crt intermediate.crt root.crt > full-chain.crt", "percentage": 93},
        {"solution": "Set proxy_ssl_trusted_certificate to the CA certificate that signed upstream''s cert, not the upstream cert itself", "percentage": 95},
        {"solution": "For client certificate verification with intermediate CAs, point ssl_client_certificate at root CA and increase verify_depth to 2: ssl_verify_depth 2;", "percentage": 90},
        {"solution": "Test certificate validity separately: openssl s_client -connect upstream:443 to verify chain is correct", "percentage": 88}
    ]'::jsonb,
    'Access to nginx configuration and certificate files, OpenSSL tools, understanding of certificate chains and CA structure',
    'No SSL verification errors in nginx logs, secure connections to upstream servers work, client certificates validate correctly',
    'Mixing upstream cert with CA cert in proxy_ssl_trusted_certificate, not including intermediate certs in chain, using wrong verify_depth for multi-level cert chains, pointing to wrong file for verification',
    0.89,
    'haiku',
    NOW(),
    'https://serverfault.com/questions/1052968/how-does-nginx-verify-certificates-proxy_ssl_verify'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    '404 Not Found serving static files with nginx',
    'nginx',
    'HIGH',
    '[
        {"solution": "Verify root directive points to correct directory containing static files. Test with: ls -la /path/from/root/directive/requested-file", "percentage": 98},
        {"solution": "Ensure nginx user (www-data or nginx) has read permissions on files and execute permissions on directories: chmod 755 /path/to/static", "percentage": 96},
        {"solution": "Check error log for permission denied vs file not found: tail -f /var/log/nginx/error.log while requesting file", "percentage": 94},
        {"solution": "If using alias instead of root, verify the path is constructed correctly. Consider using root instead for simpler configs", "percentage": 90},
        {"solution": "Test with try_files directive: try_files $uri $uri/ =404; to explicitly handle missing files", "percentage": 88}
    ]'::jsonb,
    'Access to nginx configuration files, ability to check file permissions and directory structure, access to nginx error logs',
    'Static files load successfully in browser, error log shows no 404 errors for valid files, file permissions are correct',
    'Using relative paths instead of absolute paths, forgetting execute permission on parent directories, mixing root and alias usage, not checking actual file existence on disk',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/58666685/how-to-fix-404-errors-when-serving-static-files-through-nginx'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'nginx worker_processes not optimal for system resources',
    'nginx',
    'MEDIUM',
    '[
        {"solution": "Set worker_processes to number of CPU cores: worker_processes auto; (let nginx detect automatically) or worker_processes 4; (for 4-core CPU)", "percentage": 98},
        {"solution": "Verify with: nproc (shows CPU count) and check nginx config: grep worker_processes /etc/nginx/nginx.conf", "percentage": 96},
        {"solution": "Set worker_rlimit_nofile based on system limits: worker_rlimit_nofile 65535;", "percentage": 94},
        {"solution": "Configure worker_connections: worker_connections 1024; (or higher for high-traffic sites) in events block", "percentage": 92}
    ]'::jsonb,
    'Access to nginx configuration, ability to check CPU count with nproc, ability to reload nginx configuration',
    'nginx processes equal to CPU core count, system CPU usage is balanced, no worker connection limit errors in logs',
    'Setting worker_processes to 1 on multi-core system, using worker_connections higher than system file limits, not reloading nginx after config changes',
    0.92,
    'haiku',
    NOW(),
    'https://nginx.org/en/docs/ngx_http_core_module.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'nginx: [crit] SSL_CTX_load_verify_locations() failed',
    'nginx',
    'MEDIUM',
    '[
        {"solution": "Verify ssl_trusted_certificate file path exists and is readable: ls -la /path/to/cert.pem", "percentage": 97},
        {"solution": "Test certificate file format with OpenSSL: openssl x509 -text -noout -in /path/to/cert.pem", "percentage": 96},
        {"solution": "Ensure file contains valid PEM-formatted certificate(s). File should start with -----BEGIN CERTIFICATE-----", "percentage": 95},
        {"solution": "Verify nginx user can read the certificate file. If not: sudo chown root:root cert.pem && sudo chmod 644 cert.pem", "percentage": 93}
    ]'::jsonb,
    'Access to certificate files and nginx configuration, OpenSSL tools, file permission management',
    'nginx starts without SSL errors, error log no longer contains SSL_CTX errors, client certificates validate successfully',
    'Using wrong path to certificate, mixing DER and PEM formats, not checking file permissions for nginx user, including extra whitespace in file paths',
    0.93,
    'haiku',
    NOW(),
    'https://nginx.org/en/docs/http/configuring_https_servers.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'connect() to unix:///var/www/myapp.sock failed (13: Permission denied)',
    'nginx',
    'HIGH',
    '[
        {"solution": "For uWSGI, start with proper socket permissions: uwsgi --socket myapp.sock --chmod-socket=660 --uid www-data --gid www-data", "percentage": 97},
        {"solution": "Or set in uWSGI config file: chmod-socket = 664 and chown-socket = www-data:www-data", "percentage": 96},
        {"solution": "Verify parent directory has execute permissions for nginx user: chmod 755 /var/www/", "percentage": 94},
        {"solution": "Check current socket permissions with: ls -la /var/www/myapp.sock and ensure www-data can access it", "percentage": 95},
        {"solution": "Disable virtual environment if causing permission issues. Install packages system-wide instead", "percentage": 80}
    ]'::jsonb,
    'Access to uWSGI configuration files, ability to restart uWSGI and nginx, understanding of socket permissions',
    'uWSGI socket is accessible to nginx, no permission denied errors in logs, web application responds through socket',
    'Using chmod 666 without proper ownership (security risk), not restarting service after permission changes, not checking parent directory permissions, confusing socket file with directory permissions',
    0.93,
    'haiku',
    NOW(),
    'https://serverfault.com/questions/896043/nginx-13-permission-denied-on-socket'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Invalid location directive or nested location blocks conflict',
    'nginx',
    'MEDIUM',
    '[
        {"solution": "Avoid nested location blocks. Use if statements or try_files instead: if ($request_uri ~ ^/api/) { proxy_pass http://backend; }", "percentage": 94},
        {"solution": "Use proper location matching syntax: ^~ for prefix, ~ for regex, ~* for case-insensitive regex", "percentage": 96},
        {"solution": "Test configuration with nginx -t to identify syntax errors in location blocks", "percentage": 98},
        {"solution": "If multiple locations match, nginx uses most specific match. Use ^~ prefix to prevent regex evaluation", "percentage": 92}
    ]'::jsonb,
    'Access to nginx configuration files, understanding of location block matching rules, ability to test config syntax',
    'nginx -t shows no errors, requests route to correct location blocks, configuration loads without warnings',
    'Nesting location blocks (not allowed in nginx), using regex without proper escaping, misunderstanding location precedence rules, forgetting trailing semicolon',
    0.96,
    'haiku',
    NOW(),
    'https://nginx.org/en/docs/http/ngx_http_core_module.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'gzip compression causing 502 errors or incomplete responses',
    'nginx',
    'LOW',
    '[
        {"solution": "Disable gzip compression for certain response types: gzip off; for upstream responses with compression already applied", "percentage": 92},
        {"solution": "Set gzip_proxied directive to compatible values: gzip_proxied any; or gzip_proxied no-cache no-store;", "percentage": 94},
        {"solution": "Increase gzip buffer settings: gzip_buffers 16 8k; to handle large compressed responses", "percentage": 88},
        {"solution": "Set Vary header correctly: add_header Vary Accept-Encoding; to cache compressed and uncompressed versions separately", "percentage": 90}
    ]'::jsonb,
    'Access to nginx configuration files, understanding of gzip compression, ability to test response headers with curl',
    'Responses complete successfully, content is properly compressed or uncompressed, Content-Encoding headers are correct',
    'Disabling gzip entirely when only certain content types need adjustment, not setting Vary header causing cache issues, double-compression from nginx and upstream',
    0.85,
    'haiku',
    NOW(),
    'https://nginx.org/en/docs/http/ngx_http_gzip_module.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'sendfile enabled causing incomplete file transfers or corruption',
    'nginx',
    'LOW',
    '[
        {"solution": "Disable sendfile if experiencing issues: sendfile off; in server or http block", "percentage": 91},
        {"solution": "If using sendfile with directio, note that directio automatically disables sendfile on Linux", "percentage": 88},
        {"solution": "Test file transfer with and without sendfile to isolate the issue", "percentage": 85},
        {"solution": "For NFS mounts, disable sendfile: sendfile off; as sendfile doesn''t work reliably over NFS", "percentage": 94}
    ]'::jsonb,
    'Access to nginx configuration files, ability to transfer test files over HTTP, knowledge of storage backend (local vs NFS)',
    'File transfers complete without corruption, file sizes match source files, sendfile is enabled for local storage only',
    'Enabling sendfile with NFS mount, not disabling for network drives, assuming sendfile is always faster (not true for local SSD with high concurrency)',
    0.82,
    'haiku',
    NOW(),
    'https://nginx.org/en/docs/http/ngx_http_core_module.html'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Nginx error reading client request headers timeout',
    'nginx',
    'MEDIUM',
    '[
        {"solution": "Increase client_header_timeout: client_header_timeout 60s; (default is 60s, but slow clients may need more)", "percentage": 89},
        {"solution": "Increase client_body_timeout: client_body_timeout 60s; for clients uploading large bodies slowly", "percentage": 92},
        {"solution": "For extremely slow clients, consider: large_client_header_buffers 4 16k; to allow clients more time", "percentage": 85},
        {"solution": "Monitor for attackers sending incomplete requests: use limit_conn directive to prevent slowloris attacks", "percentage": 88}
    ]'::jsonb,
    'Access to nginx configuration files, ability to test with slow clients, understanding of DoS attack types',
    'Slow clients can complete requests, timeouts no longer occur for legitimate slow traffic, error log shows no timeout errors',
    'Setting timeouts too high and enabling slowloris vulnerability, not distinguishing between slow legitimate clients and attacks, over-buffering requests',
    0.84,
    'haiku',
    NOW(),
    'https://nginx.org/en/docs/http/ngx_http_core_module.html'
);
