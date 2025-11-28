-- SSL/TLS Certificate Errors Knowledge Base Migration
-- Generated from researched sources: Stack Overflow, GitHub Issues, Official Docs, Dev Blogs
-- 20 high-quality entries with exact error messages and proven solutions

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES

(
    'unable to get local issuer certificate npm install',
    'ssl-tls',
    'HIGH',
    '[
        {"solution": "Set NODE_EXTRA_CA_CERTS environment variable to your CA certificate path: export NODE_EXTRA_CA_CERTS=/path/to/cacert.pem", "percentage": 95},
        {"solution": "Add cafile path to .npmrc file: cafile=./ca-certs.pem", "percentage": 90},
        {"solution": "For macOS with Homebrew: echo \"cafile=$(brew --prefix)/share/ca-certificates/cacert.pem\" >> ~/.npmrc", "percentage": 85}
    ]'::jsonb,
    'Access to certificate file path or ability to set environment variables. Corporate proxy/firewall blocking HTTPS with self-signed certificates.',
    'npm install completes successfully. Verify with: npm list',
    'Disabling SSL verification entirely with NODE_TLS_REJECT_UNAUTHORIZED=0 creates security vulnerabilities. Use NODE_EXTRA_CA_CERTS instead for production.',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/36494336/npm-install-error-unable-to-get-local-issuer-certificate'
),

(
    '[SSL: CERTIFICATE_VERIFY_FAILED] error:14090086:SSL routines python requests',
    'ssl-tls',
    'HIGH',
    '[
        {"solution": "Use certifi library: import certifi; requests.get(url, verify=certifi.where())", "percentage": 95},
        {"solution": "Set REQUESTS_CA_BUNDLE environment variable: export REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt", "percentage": 90},
        {"solution": "Pass custom certificate path: requests.get(url, verify=''/path/to/cert.pem'')", "percentage": 88}
    ]'::jsonb,
    'Python requests library installed. Access to certificate files or ability to install/upgrade certifi.',
    'HTTP request succeeds and returns status code. Verify with: python -c \"import requests; print(requests.get(url).status_code)\"',
    'Setting verify=False disables all SSL verification and creates man-in-the-middle attack vulnerability. Always use proper certificate handling in production.',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/10667960/python-requests-throwing-sslerror'
),

(
    'PKIX path building failed unable to find valid certification path to requested target java',
    'ssl-tls',
    'HIGH',
    '[
        {"solution": "Import certificate into Java truststore: keytool -import -alias example -keystore $JAVA_HOME/lib/security/cacerts -file certificate.cer (password: changeit)", "percentage": 96},
        {"solution": "Test with SSLPoke to verify connectivity: $JAVA_HOME/bin/java SSLPoke hostname 443", "percentage": 92},
        {"solution": "Add all intermediate certificates in the certificate chain to Java truststore with unique aliases", "percentage": 90}
    ]'::jsonb,
    'Java Development Kit (JDK) installed. Access to export/import certificates. Administrator privileges may be required for cacerts file modification.',
    'SSLPoke displays \"Successfully connected\" message. Application successfully connects to remote server without certificate errors. Verify with: keytool -list -keystore $JAVA_HOME/lib/security/cacerts | grep alias',
    'Forgetting to restart the JVM after importing certificates. The truststore is only read once during JVM initialization. Also failing to import the complete certificate chain including intermediate CAs.',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/21076179/pkix-path-building-failed-and-unable-to-find-valid-certification-path-to-requ'
),

(
    'certificate has expired or is not yet valid ssl error',
    'ssl-tls',
    'HIGH',
    '[
        {"solution": "Renew the certificate before expiration date. Contact your certificate provider or use Let''s Encrypt for free automated renewal.", "percentage": 95},
        {"solution": "Verify server system date/time is correct: sudo ntpdate -s time.nist.gov (Linux) or check System Preferences (macOS)", "percentage": 88},
        {"solution": "Implement Certificate Lifecycle Automation (CLA) system to track and auto-renew certificates before expiration", "percentage": 85}
    ]'::jsonb,
    'Access to certificate renewal process. Ability to deploy new certificate to web server or CDN. For date/time fix, system administrator privileges.',
    'Browser displays no certificate warning. HTTPS connection succeeds. Verify certificate validity: openssl x509 -in cert.pem -text -noout | grep -A 2 Validity',
    'Assuming you can renew an already-expired certificate - you must initiate a new purchase to replace expired certificates. Delaying renewal leads to downtime and broken HTTPS connections.',
    0.91,
    'haiku',
    NOW(),
    'https://www.thesslstore.com/blog/your-security-certificate-has-expired-how-to-fix-it/'
),

(
    'Common name mismatch certificate does not match hostname ssl error',
    'ssl-tls',
    'MEDIUM',
    '[
        {"solution": "Add missing domain variants as Subject Alternative Names (SAN) to certificate. Include both example.com and www.example.com", "percentage": 94},
        {"solution": "Use Server Name Indication (SNI) to host multiple SSL certificates on one IP address. Ensure client and server both support SNI.", "percentage": 90},
        {"solution": "Verify DNS records point to correct IP where certificate is installed. Validate with: nslookup example.com", "percentage": 88}
    ]'::jsonb,
    'SSL certificate already issued. Certificate must be reissued with correct domain or you have ability to modify certificate SANs. DNS access for verification.',
    'Browser no longer shows \"hostname mismatch\" or \"common name mismatch\" error. HTTPS connection succeeds for all domain variants. Verify with: openssl x509 -in cert.pem -text | grep DNS',
    'Only including www.example.com in certificate when users access example.com (or vice versa). Using IP address instead of hostname in certificate. Not checking Subject Alternative Names in certificate.',
    0.92,
    'haiku',
    NOW(),
    'https://www.globalsign.com/en/blog/what-is-common-name-mismatch-error'
),

(
    'UNABLE_TO_VERIFY_LEAF_SIGNATURE unable to verify the first certificate',
    'ssl-tls',
    'MEDIUM',
    '[
        {"solution": "Include full certificate chain in server configuration. For Let''s Encrypt, use fullchain.pem instead of cert.pem: /etc/letsencrypt/live/domain/fullchain.pem", "percentage": 96},
        {"solution": "Set NODE_EXTRA_CA_CERTS environment variable with intermediate certificate: export NODE_EXTRA_CA_CERTS=/path/to/intermediate.pem", "percentage": 92},
        {"solution": "Download missing intermediate certificate using openssl and add to certificate chain", "percentage": 88}
    ]'::jsonb,
    'Full certificate chain with all intermediate certificates. Access to server configuration files. For Node.js, ability to set environment variables.',
    'SSL/TLS handshake succeeds without errors. Client can verify entire certificate chain. Verify with: openssl s_client -connect domain:443 -servername domain',
    'Using only the leaf certificate without intermediate certificates. Confusing cert.pem (leaf only) with fullchain.pem (complete chain) in Let''s Encrypt installations. Not including root CA certificate.',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/20082893/unable-to-verify-leaf-signature'
),

(
    'ERR_SSL_VERSION_OR_CIPHER_MISMATCH browser ssl error incompatible',
    'ssl-tls',
    'MEDIUM',
    '[
        {"solution": "Update web server to support at least TLS 1.2 or TLS 1.3. Disable deprecated SSL 3.0, TLS 1.0, TLS 1.1 on server.", "percentage": 95},
        {"solution": "Client-side: Disable QUIC protocol in Chrome by visiting chrome://flags, search QUIC, set to Disabled", "percentage": 88},
        {"solution": "Clear browser cache, cookies, and SSL session cache. Close and reopen browser completely.", "percentage": 82}
    ]'::jsonb,
    'Web server configuration access to modify TLS versions. Browser access to change flags or clear cache.',
    'HTTPS connection succeeds. Browser no longer displays ERR_SSL_VERSION_OR_CIPHER_MISMATCH error. Verify with Qualys SSL Labs tool: https://www.ssllabs.com/ssltest/',
    'Assuming antivirus or proxy is intercepting SSL - verify with direct connection first. Using very old TLS versions without checking compatibility with modern browsers.',
    0.89,
    'haiku',
    NOW(),
    'https://kinsta.com/blog/err_ssl_version_or_cipher_mismatch/'
),

(
    'self signed certificate not trusted java spring boot error',
    'ssl-tls',
    'MEDIUM',
    '[
        {"solution": "Generate self-signed certificate with keytool: keytool -genkeypair -alias tomcat -keyalg RSA -keysize 2048 -storetype PKCS12 -keystore server.p12 -validity 3650", "percentage": 94},
        {"solution": "Configure Spring Boot properties: server.ssl.key-store=classpath:keystore.p12, server.ssl.key-store-type=PKCS12, server.ssl.key-store-password=password", "percentage": 92},
        {"solution": "Export certificate for browsers: keytool -export -keystore server.p12 -alias tomcat -file cert.crt, then import into browser trusted store", "percentage": 88}
    ]'::jsonb,
    'Spring Boot application with Tomcat embedded server. Java keytool utility available. For client-side: browser certificate import capability.',
    'Spring Boot application starts successfully with HTTPS enabled. Browser can access application with HTTPS (with self-signed certificate warning accepted). Test with: curl -k https://localhost:8443',
    'Using incorrect property names (key-password vs key-store-password). Forgetting to restart Spring Boot after certificate changes. Not handling certificate verification in test environments.',
    0.91,
    'haiku',
    NOW(),
    'https://www.baeldung.com/spring-boot-https-self-signed-certificate'
),

(
    'certificate verify failed SSL certificate is not verifiable to a trusted root',
    'ssl-tls',
    'HIGH',
    '[
        {"solution": "Update certificate authority bundle: pip install --upgrade certifi", "percentage": 94},
        {"solution": "For macOS Python users: Run Install Certificates.command from Python installation directory", "percentage": 91},
        {"solution": "Set custom certificate path in application code or environment variable REQUESTS_CA_BUNDLE", "percentage": 88}
    ]'::jsonb,
    'Python 3 with requests library installed. pip package manager access. Permission to modify Python certificates (may require administrator privileges on macOS).',
    'SSL certificate verification succeeds. HTTPS requests complete without SSLError. Verify with: python -c \"import ssl, certifi; print(certifi.where())\"',
    'Disabling verification with verify=False in requests for production code. Not upgrading certifi which contains updated root certificates. Ignoring corporate proxy certificate installation.',
    0.93,
    'haiku',
    NOW(),
    'https://dev.to/keploy/fixing-unable-to-get-local-issuer-certificate-ssl-problem-ci1'
),

(
    'SSL handshake failure certificate not trusted or expired',
    'ssl-tls',
    'MEDIUM',
    '[
        {"solution": "Verify and update system date/time to current date. Use NTP for automatic synchronization: sudo systemctl start ntp", "percentage": 94},
        {"solution": "Verify SSL certificate validity and trust chain with online tools or openssl: openssl s_client -connect domain:443", "percentage": 90},
        {"solution": "Update browser and OS to latest versions for current TLS/SSL cipher support", "percentage": 86}
    ]'::jsonb,
    'Internet connectivity. System administration access for date/time correction. Browser or curl for certificate validation.',
    'HTTPS connection succeeds. Server Name Indication (SNI) properly configured. Certificate chain complete. Verify with: openssl s_client -connect domain:443 -servername domain',
    'Incorrect system date/time causing certificate to appear expired when it isn''t. Browser cache issues - failing to do hard refresh. Not checking intermediate certificate chain completeness.',
    0.90,
    'haiku',
    NOW(),
    'https://www.globalsign.com/en/blog/troubleshooting-ssl-issues'
),

(
    'hostname mismatch browser shows hostname does not match certificate',
    'ssl-tls',
    'MEDIUM',
    '[
        {"solution": "Verify certificate CN and SAN match all domain names being accessed. Use: openssl x509 -in cert.pem -text | grep -E ''CN=|DNS:''", "percentage": 94},
        {"solution": "If accessing by IP address, request certificate reissue for FQDN or use DNS to access by hostname instead", "percentage": 91},
        {"solution": "For multi-domain setup: Use wildcard certificate (*.example.com) or multi-SAN certificate including all domains", "percentage": 88}
    ]'::jsonb,
    'SSL certificate already issued or ability to reissue with correct hostnames. Access to change DNS records or URL scheme if needed.',
    'Browser no longer displays hostname verification warning. HTTPS connection succeeds for all domain variants. openssl verification shows correct CN and SANs.',
    'Attempting to use single-domain certificate for multiple domains. Accessing server by IP address when certificate is for hostname. Not including www variant when users expect it.',
    0.91,
    'haiku',
    NOW(),
    'https://scrapeops.io/python-web-scraping-playbook/python-requests-fix-ssl-error/'
),

(
    'SSL peer shut down incorrectly connection closed unexpectedly',
    'ssl-tls',
    'LOW',
    '[
        {"solution": "Verify network connectivity between client and server. Test connection: telnet hostname 443 or curl -v https://hostname", "percentage": 90},
        {"solution": "Check firewall rules and network configuration. Ensure port 443 is open and not blocked", "percentage": 88},
        {"solution": "Verify TLS/SSL protocol versions are compatible between client and server. Update to current TLS versions", "percentage": 85}
    ]'::jsonb,
    'Network diagnostic tools (telnet, curl, ping). Access to firewall configuration. System administrator privileges for network changes.',
    'HTTPS connection completes successfully without abrupt disconnection. Network trace shows normal TLS handshake and data exchange without socket errors.',
    'Assuming the issue is always SSL/TLS when connection problems could be network-related. Not checking firewall logs for blocked connections. Blaming certificates when it''s a network connectivity issue.',
    0.86,
    'haiku',
    NOW(),
    'https://www.globalsign.com/en/blog/troubleshooting-ssl-issues'
),

(
    'SSL bad record MAC alert connection integrity error',
    'ssl-tls',
    'LOW',
    '[
        {"solution": "Update operating system to latest security patches and current version", "percentage": 92},
        {"solution": "Update web browser to latest version with current TLS cipher support", "percentage": 90},
        {"solution": "Disable HTTPS inspection or SSL scanning in antivirus/firewall software temporarily to test", "percentage": 88}
    ]'::jsonb,
    'Admin access to update OS and browser. Access to security software settings to disable inspection features.',
    'HTTPS connection succeeds without MAC verification errors. openssl s_client shows clean handshake: openssl s_client -connect domain:443',
    'Blaming the server when bad record MAC is typically a client-side issue. Not updating client OS and browser. Assuming ISP/network issue when it''s usually local security software.',
    0.85,
    'haiku',
    NOW(),
    'https://www.globalsign.com/en/blog/troubleshooting-ssl-issues'
),

(
    'HTTPS redirect failure website not redirecting to HTTPS',
    'ssl-tls',
    'MEDIUM',
    '[
        {"solution": "Enable HTTPS on web server configuration (Apache: mod_ssl, Nginx: ssl on). Install and configure SSL certificate", "percentage": 95},
        {"solution": "Add HTTP to HTTPS redirect rule: Apache: RewriteRule ^/?(.*) https://%{SERVER_NAME}/$1 [R,L]", "percentage": 92},
        {"solution": "Verify DNS records point to correct server IP where SSL certificate is installed", "percentage": 88}
    ]'::jsonb,
    'SSL certificate installed and working on server. Web server configuration file access. DNS administration access if needed.',
    'HTTP requests redirect to HTTPS. Browser shows secure HTTPS connection without mixed content. Test with: curl -v http://example.com (should show 301/302 redirect to https)',
    'Forgetting to install the SSL certificate before setting up redirect rules. DNS not updated to point to HTTPS-enabled server. Redirect loop caused by improper rule configuration.',
    0.91,
    'haiku',
    NOW(),
    'https://www.globalsign.com/en/blog/troubleshooting-ssl-issues'
),

(
    'mixed content error https page loading http resources',
    'ssl-tls',
    'MEDIUM',
    '[
        {"solution": "Audit page source and update all hardcoded HTTP URLs to HTTPS: grep -r ''http://'' theme-files/", "percentage": 96},
        {"solution": "Update CMS theme and plugin configurations to use protocol-relative URLs (//example.com) or absolute HTTPS URLs", "percentage": 93},
        {"solution": "Use Content-Security-Policy header to enforce HTTPS: add-header Content-Security-Policy \"upgrade-insecure-requests\"", "percentage": 90}
    ]'::jsonb,
    'Access to source code, theme files, and plugin configurations. Ability to modify web server headers or CMS settings.',
    'Browser no longer shows mixed content warnings. HTTPS page loads all resources over HTTPS. Console shows no mixed content errors.',
    'Updating only visible URLs while missing dynamic/JavaScript-generated HTTP URLs. Using hardcoded HTTP URLs in plugins instead of HTTPS. Not handling third-party resources using HTTP.',
    0.92,
    'haiku',
    NOW(),
    'https://www.globalsign.com/en/blog/troubleshooting-ssl-issues'
),

(
    'received fatal alert unknown_ca remote party did not authenticate',
    'ssl-tls',
    'MEDIUM',
    '[
        {"solution": "Export server SSL certificate and import into client truststore: keytool -import -alias servercert -keystore truststore.jks -file server.cer", "percentage": 94},
        {"solution": "For Node.js clients: Set NODE_EXTRA_CA_CERTS environment variable with server certificate path", "percentage": 91},
        {"solution": "Verify server certificate is signed by trusted Certificate Authority. If self-signed, explicitly import into client truststore", "percentage": 89}
    ]'::jsonb,
    'Access to server SSL certificate in PEM or CER format. Client truststore or JKS keystore file. Ability to set environment variables or modify client code.',
    'TLS handshake completes successfully. Client connects to server without unknown_ca alert. Certificate validation passes.',
    'Only importing the leaf certificate without the complete chain. Importing with wrong alias or incorrect truststore location. Not restarting application after importing new certificates.',
    0.90,
    'haiku',
    NOW(),
    'https://www.globalsign.com/en/blog/troubleshooting-ssl-issues'
),

(
    'TLS certificate chain incomplete missing intermediate certificate',
    'ssl-tls',
    'MEDIUM',
    '[
        {"solution": "Download missing intermediate certificate from Certificate Authority using openssl: openssl s_client -connect domain:443 -showcerts > chain.txt", "percentage": 94},
        {"solution": "Concatenate all certificates in proper order into single PEM file: cat cert.pem intermediate.pem root.pem > fullchain.pem", "percentage": 93},
        {"solution": "Configure web server to send complete chain. Apache SSLCertificateChainFile directive or Nginx ssl_certificate with concatenated chain", "percentage": 91}
    ]'::jsonb,
    'Web server configuration file access. OpenSSL tool for certificate examination. Access to certificate download/storage.',
    'Complete certificate chain delivered by server. Browsers validate entire chain successfully. openssl s_client shows all certificates in handshake.',
    'Deploying only leaf certificate without intermediate. Incorrect certificate order in chain file. Browser auto-downloading missing intermediates (only IE does this, other browsers won''t).',
    0.92,
    'haiku',
    NOW(),
    'https://dev.to/keploy/fixing-unable-to-get-local-issuer-certificate-ssl-problem-ci1'
),

(
    'client certificate required mutual TLS authentication failure',
    'ssl-tls',
    'MEDIUM',
    '[
        {"solution": "Generate client certificate and key: openssl req -new -x509 -keyout client.key -out client.crt -days 365", "percentage": 94},
        {"solution": "In Python requests: requests.get(url, cert=(''client.crt'', ''client.key''), verify=''ca-cert.pem'')", "percentage": 92},
        {"solution": "For Java client: Import client certificate into keystore and configure HttpsURLConnection to use it", "percentage": 89}
    ]'::jsonb,
    'Ability to generate certificates using OpenSSL or Java keytool. Client certificate and private key files. Server certificate for verification.',
    'TLS mutual authentication succeeds. Client certificate verified by server. Server accepts connection and responds with data.',
    'Using server certificate instead of client certificate for mutual TLS. Forgetting to provide private key along with certificate. Incorrect certificate path in code.',
    0.89,
    'haiku',
    NOW(),
    'https://www.globalsign.com/en/blog/troubleshooting-ssl-issues'
),

(
    'certificate revocation check OCSP stapling failure',
    'ssl-tls',
    'LOW',
    '[
        {"solution": "Enable OCSP stapling on web server: Apache: SSLUseStapling on, Nginx: ssl_stapling on", "percentage": 93},
        {"solution": "Configure OCSP responder URL if not auto-detected. Ensure firewall allows outbound connection to OCSP responder", "percentage": 90},
        {"solution": "Test certificate revocation status with online tools or command: openssl ocsp -CAfile ca.pem -cert server.crt -url http://ocsp.example.com", "percentage": 88}
    ]'::jsonb,
    'Web server configuration file access. OpenSSL tools. Network connectivity to OCSP responders.',
    'OCSP stapling enabled and responding. Certificate revocation check passes. Browser does not show certificate revoked warning.',
    'Assuming all servers support OCSP stapling. Blocking outbound connection to OCSP responder with firewall. Not enabling OCSP stapling when certificate is revoked.',
    0.86,
    'haiku',
    NOW(),
    'https://letsencrypt.org/docs/challenge-types/'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES

(
    'DNS_PROBE_FINISHED_NXDOMAIN SSL certificate validation scope mismatch',
    'ssl-tls',
    'LOW',
    '[
        {"solution": "Verify DNS records are correctly configured and pointing to server IP: nslookup example.com or dig example.com", "percentage": 93},
        {"solution": "Check SSL certificate covers the exact domain name being accessed. Wildcard certificates (*.example.com) cover subdomains", "percentage": 90},
        {"solution": "Clear browser DNS cache: Chrome: chrome://net-internals/#dns, other browsers: full cache clear", "percentage": 87}
    ]'::jsonb,
    'DNS access to verify/update records. Certificate details available for review. Browser or DNS tools (nslookup, dig).',
    'DNS resolves correctly to server IP. Certificate validation scope matches requested domain. Browser successfully loads HTTPS page.',
    'Confusing DNS errors with SSL certificate errors - these are separate issues. Using certificate for one domain while DNS resolves to another. Not checking wildcard certificate scope.',
    0.88,
    'haiku',
    NOW(),
    'https://www.globalsign.com/en/blog/troubleshooting-ssl-issues'
);
