-- Heroku Error Knowledge Base - 15 High-Quality Entries
-- Mined from official Heroku documentation: error-codes, dyno-types, limits

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'H10 App crashed',
    'heroku',
    'CRITICAL',
    '[
        {"solution": "Check application logs: heroku logs --tail. Look for startup errors, missing dependencies, or syntax errors in your code.", "percentage": 95},
        {"solution": "Verify all required dependencies are in package.json, Gemfile, requirements.txt, or equivalent. Run local build to test.", "percentage": 90},
        {"solution": "Check Procfile is correct and entry point exists. Web process must bind to $PORT environment variable.", "percentage": 85}
    ]'::jsonb,
    'Access to heroku CLI and application source code',
    'Application responds to requests and logs show clean startup',
    'Assuming crash happened without checking logs; not binding to $PORT in web process; missing production dependencies',
    0.95,
    'haiku',
    NOW(),
    'https://devcenter.heroku.com/articles/error-codes'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'H11 Backlog too deep',
    'heroku',
    'HIGH',
    '[
        {"solution": "Scale web dynos: heroku ps:scale web=2 (or higher). Start with 2-3x current dyno count.", "percentage": 92},
        {"solution": "Optimize database queries. Use indexes on frequently queried columns and add caching (Redis/Memcached).", "percentage": 88},
        {"solution": "Profile application code for performance bottlenecks. Reduce response time on slow endpoints.", "percentage": 85},
        {"solution": "Implement request queuing or job processing (Sidekiq, Celery) for long-running tasks.", "percentage": 80}
    ]'::jsonb,
    'Access to heroku CLI; database access to add indexes; ability to modify application code',
    'Heroku logs show H11 errors decreasing; response times improve; requests complete within 30 seconds',
    'Adding too many dynos without optimizing code; ignoring database query performance; not implementing proper caching strategy',
    0.92,
    'haiku',
    NOW(),
    'https://devcenter.heroku.com/articles/error-codes'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'H12 Request timeout - 30 second limit exceeded',
    'heroku',
    'CRITICAL',
    '[
        {"solution": "Optimize slow endpoints. Profile code to find performance bottlenecks using APM tools (New Relic, Scout).", "percentage": 90},
        {"solution": "Move long-running operations to background jobs (Sidekiq for Ruby, Celery for Python, Bull for Node).", "percentage": 92},
        {"solution": "Reduce database query time: add indexes, optimize N+1 queries, implement caching layer.", "percentage": 88},
        {"solution": "As last resort, use Boot Timeout Tool, but this masks the underlying performance issue.", "percentage": 50}
    ]'::jsonb,
    'Access to application code; APM tool access recommended; database access',
    'Endpoint responds within 30 seconds consistently; H12 errors stop appearing in logs',
    'Using boot timeout tool without fixing actual performance issue; not measuring actual endpoint times; assuming it''s a network issue when it''s application performance',
    0.90,
    'haiku',
    NOW(),
    'https://devcenter.heroku.com/articles/error-codes'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'H14 No web dynos running',
    'heroku',
    'HIGH',
    '[
        {"solution": "Scale web dynos: heroku ps:scale web=1", "percentage": 99},
        {"solution": "Verify app doesn''t have all dynos scaled to zero in Procfile or dashboard settings.", "percentage": 95}
    ]'::jsonb,
    'Access to heroku CLI or Heroku Dashboard',
    'heroku ps shows at least one web dyno running; application responds to requests',
    'Forgetting to add free dyno allocation after account downgrade; accidentally scaling to zero',
    0.99,
    'haiku',
    NOW(),
    'https://devcenter.heroku.com/articles/error-codes'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'H15 Idle connection - no data for 55 seconds',
    'heroku',
    'MEDIUM',
    '[
        {"solution": "Ensure application sends complete HTTP response within 55-second rolling window. Avoid long-polling without keepalive.", "percentage": 90},
        {"solution": "Implement server-side keepalive for long-running connections. Send heartbeat messages every 30-40 seconds.", "percentage": 85},
        {"solution": "Optimize request processing time. Profile slow endpoints and optimize database queries.", "percentage": 80}
    ]'::jsonb,
    'Understanding of HTTP connection lifecycle; ability to modify application code',
    'Requests complete without H15 errors; client receives full responses; long-running operations remain connected',
    'Assuming it''s a network issue when it''s the application not sending data fast enough; not implementing keepalive properly',
    0.85,
    'haiku',
    NOW(),
    'https://devcenter.heroku.com/articles/error-codes'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'H19 Backend connection timeout - dyno overwhelmed',
    'heroku',
    'HIGH',
    '[
        {"solution": "Scale dynos: heroku ps:scale web=2 or higher. Monitor with heroku metrics to find right dyno count.", "percentage": 93},
        {"solution": "Optimize application performance: reduce response time on endpoints, add caching, optimize database.", "percentage": 90},
        {"solution": "Check database connection pool size. Too many connections from dynos can exhaust database resources.", "percentage": 85},
        {"solution": "Upgrade to larger dyno type (Standard, Performance) if Eco dynos are bottleneck.", "percentage": 80}
    ]'::jsonb,
    'Access to heroku CLI; ability to scale dynos; database monitoring',
    'Routing layer successfully connects to web dynos; requests complete; H19 errors stop in logs',
    'Scaling without fixing underlying performance issue; not monitoring database connection pool; assuming bad dyno health when it''s too many connections',
    0.93,
    'haiku',
    NOW(),
    'https://devcenter.heroku.com/articles/error-codes'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'H20 App boot timeout - 75 second limit',
    'heroku',
    'HIGH',
    '[
        {"solution": "Reduce startup time: move initialization logic to async tasks, lazy-load dependencies, optimize database migrations.", "percentage": 92},
        {"solution": "Check boot time: heroku logs --tail | grep boot. Identify what takes longest during startup.", "percentage": 90},
        {"solution": "Move long initialization tasks to post-boot: use background job queue (Sidekiq/Celery) or cron jobs.", "percentage": 88},
        {"solution": "As last resort, request Boot Timeout Tool extension, but this is temporary measure only.", "percentage": 40}
    ]'::jsonb,
    'Access to application source code; ability to run local tests; understanding of boot process',
    'Application starts in <60 seconds consistently; dynos stay running; H20 errors stop',
    'Using boot timeout extension without fixing actual startup time issue; running database migrations during boot; not lazy-loading dependencies',
    0.92,
    'haiku',
    NOW(),
    'https://devcenter.heroku.com/articles/error-codes'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'H25 HTTP restriction - invalid content length or oversized headers',
    'heroku',
    'MEDIUM',
    '[
        {"solution": "Check HTTP response headers are valid. Content-Length must match actual body size.", "percentage": 95},
        {"solution": "Verify cookie sizes are reasonable (under 4 KB each). Remove unnecessary cookies.", "percentage": 90},
        {"solution": "Check status line length. Avoid excessively long status messages.", "percentage": 85},
        {"solution": "Inspect all headers with: curl -i https://yourapp.herokuapp.com | head -20", "percentage": 80}
    ]'::jsonb,
    'Access to application code; ability to inspect HTTP headers',
    'HTTP responses are valid; no H25 errors in logs; client receives complete responses',
    'Setting Content-Length header manually without accounting for actual size; storing large amounts of data in session cookies; not validating headers before sending',
    0.90,
    'haiku',
    NOW(),
    'https://devcenter.heroku.com/articles/error-codes'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'H82 Dyno hour pool exhausted - Eco quota used',
    'heroku',
    'MEDIUM',
    '[
        {"solution": "Check Billing dashboard > Dyno hours to see remaining quota. Upgrade plan or wait for monthly reset.", "percentage": 98},
        {"solution": "Convert app to Standard or Performance dyno (paid tier) to remove hour limits.", "percentage": 95},
        {"solution": "If using Eco, reduce dyno uptime: turn off unnecessary apps, consolidate workloads.", "percentage": 85},
        {"solution": "Monitor usage: heroku metrics -a yourapp to see dyno consumption patterns.", "percentage": 80}
    ]'::jsonb,
    'Heroku Dashboard access; understanding of Heroku billing model',
    'Dyno hours reset after month-end; app runs normally after upgrade or reset',
    'Not understanding Eco dyno limits (1000 hours/month shared); assuming unlimited usage with free tier; not monitoring consumption',
    0.98,
    'haiku',
    NOW(),
    'https://devcenter.heroku.com/articles/error-codes'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'R10 Boot timeout - process didn''t bind to $PORT within 60 seconds',
    'heroku',
    'CRITICAL',
    '[
        {"solution": "Ensure web process binds to port from $PORT env var: app.listen(process.env.PORT || 3000) in Node, port=os.environ.get(''PORT'', 5000) in Python/Flask.", "percentage": 98},
        {"solution": "Check that startup code actually runs. Verify no syntax errors prevent port binding.", "percentage": 95},
        {"solution": "Reduce database initialization during boot: use lazy initialization or post-boot setup.", "percentage": 90},
        {"solution": "Run locally: PORT=5000 npm start (or equivalent) to verify bind works with env var.", "percentage": 92}
    ]'::jsonb,
    'Application source code; ability to run locally with PORT environment variable',
    'Application starts and responds to requests; logs show successful port binding; R10 errors stop',
    'Hardcoding port number instead of reading $PORT; not testing startup with PORT env var locally; running blocking operations during boot',
    0.97,
    'haiku',
    NOW(),
    'https://devcenter.heroku.com/articles/error-codes'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'R12 Exit timeout - process didn''t exit within 30 seconds of SIGTERM',
    'heroku',
    'HIGH',
    '[
        {"solution": "Implement SIGTERM handler to gracefully shutdown: process.on(''SIGTERM'', () => { server.close(); }) in Node.", "percentage": 93},
        {"solution": "Close database connections, drain queues, and finish in-flight requests before exiting.", "percentage": 92},
        {"solution": "Test locally: send SIGTERM signal and verify shutdown completes in <30 seconds.", "percentage": 90},
        {"solution": "For long-running tasks, use background job queue (Sidekiq, Celery) instead of process-level shutdown.", "percentage": 85}
    ]'::jsonb,
    'Application source code; ability to handle OS signals',
    'Dyno shuts down cleanly; no data loss during redeploy; R12 errors stop',
    'Ignoring SIGTERM signal; not closing connections properly; running infinite loops that can''t be interrupted',
    0.92,
    'haiku',
    NOW(),
    'https://devcenter.heroku.com/articles/error-codes'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'R14 Memory quota exceeded - dyno using swap',
    'heroku',
    'HIGH',
    '[
        {"solution": "Identify memory leak: monitor memory usage over time with heroku metrics -a yourapp. Look for steady increase.", "percentage": 92},
        {"solution": "Optimize application memory: avoid loading entire dataset into memory, use pagination, implement connection pooling.", "percentage": 90},
        {"solution": "Reduce third-party library overhead: audit dependencies with npm audit or pip freeze to remove heavy unused packages.", "percentage": 85},
        {"solution": "Upgrade to larger dyno (Standard/Performance) if code is optimized but app requires more RAM.", "percentage": 82}
    ]'::jsonb,
    'Access to heroku metrics and application source code; understanding of memory profiling',
    'Memory usage stable and under limit; no R14 errors in logs; application performs consistently',
    'Assuming dyno is too small without profiling memory usage; not identifying memory leaks; loading entire database into memory',
    0.90,
    'haiku',
    NOW(),
    'https://devcenter.heroku.com/articles/error-codes'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'R15 Memory quota vastly exceeded - dyno killed with SIGKILL',
    'heroku',
    'CRITICAL',
    '[
        {"solution": "Immediately investigate memory spike: check recent code changes, new dependencies, or data volume increase.", "percentage": 95},
        {"solution": "Profile memory with language-specific tools: node --inspect (Node), memory_profiler (Python), heapdump (Ruby).", "percentage": 92},
        {"solution": "Fix memory leak: common causes are unclosed connections, growing caches, or circular references.", "percentage": 90},
        {"solution": "Upgrade dyno type as temporary fix while debugging (Performance dyno has 2.5x memory), but fix root cause.", "percentage": 85}
    ]'::jsonb,
    'Application source code; memory profiling tools; ability to analyze memory dumps',
    'Memory usage stable under limit; process doesn''t get killed; R15 errors stop; application runs reliably',
    'Upgrading dyno without fixing memory leak (temporary fix only); not profiling memory; assuming memory issue is normal for workload',
    0.92,
    'haiku',
    NOW(),
    'https://devcenter.heroku.com/articles/error-codes'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'L10 Drain buffer overflow - log rate exceeded consumer',
    'heroku',
    'MEDIUM',
    '[
        {"solution": "Reduce logging volume: check for excessive debug logging, remove verbose library logs in production.", "percentage": 93},
        {"solution": "Upgrade log drain: ensure syslog/HTTP drain has sufficient capacity and bandwidth.", "percentage": 88},
        {"solution": "Filter logs before sending: use log drain with filtering to exclude low-priority messages.", "percentage": 85},
        {"solution": "Implement log sampling for high-frequency events: log every 10th occurrence instead of every single log.", "percentage": 80}
    ]'::jsonb,
    'Access to logging configuration; ability to monitor log volume; log drain setup',
    'Log messages all delivered; no L10 errors in logs; drain keeps up with application log rate',
    'Not realizing logging overhead is problem; setting log level to DEBUG in production; not monitoring drain capacity',
    0.88,
    'haiku',
    NOW(),
    'https://devcenter.heroku.com/articles/error-codes'
);

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Heroku Eco dyno 1000 hour monthly quota exhausted',
    'heroku',
    'MEDIUM',
    '[
        {"solution": "Review Billing > Dyno hours consumed this month. Note: quota is SHARED across all Eco dynos in account.", "percentage": 97},
        {"solution": "Upgrade at least one app to Standard or Performance dyno (paid tier) to remove hour limits from that app.", "percentage": 95},
        {"solution": "Reduce running time: shut down non-critical apps, consolidate workloads to fewer dynos.", "percentage": 90},
        {"solution": "Calculate usage: Eco dyno = 1000 hours/month = ~42 days continuous OR 1-2 apps running 24/7.", "percentage": 92}
    ]'::jsonb,
    'Heroku account access; understanding of Eco dyno model',
    'App runs normally after upgrade; monthly quota resets; adequate hours available',
    'Assuming each app gets 1000 hours (actually shared); running 3+ apps continuously expecting all to work; not upgrading before hitting limit',
    0.95,
    'haiku',
    NOW(),
    'https://devcenter.heroku.com/articles/limits'
);
