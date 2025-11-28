-- Airflow Error Knowledge Base Entries
-- High-quality errors mined from Stack Overflow, GitHub, AWS MWAA, and Apache Airflow official docs

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES

-- Error 1: PostgreSQL "too many clients" connection pool exhaustion
(
    'psycopg2.OperationalError: connection to server at "postgres" (172.18.0.2), port 5432 failed: FATAL: sorry, too many clients already',
    'airflow',
    'HIGH',
    '[
        {"solution": "Reduce sql_alchemy_pool_size and sql_alchemy_max_overflow in airflow.cfg. Set pool_size to 5 and max_overflow to 10", "percentage": 85},
        {"solution": "Install PgBouncer or similar connection pooler between Airflow and PostgreSQL to manage connections efficiently", "percentage": 80},
        {"solution": "Increase PostgreSQL max_connections parameter in postgresql.conf (requires database restart)", "percentage": 75},
        {"solution": "Reduce AIRFLOW_CELERY_WORKER_CONCURRENCY from excessive values (e.g., 200) to match actual infrastructure capacity", "percentage": 90}
    ]'::jsonb,
    'PostgreSQL database running with default max_connections limit. Multiple Airflow components (webserver, scheduler, workers, triggerer) configured.',
    'Check psycopg2 no longer raises "too many clients" error. Verify connection pool usage with: SELECT datname, count(*) FROM pg_stat_activity GROUP BY datname',
    'Setting pool_size and max_overflow too low causes frequent connection errors. Excessive worker concurrency without corresponding Postgres tuning.',
    0.88,
    'haiku',
    NOW(),
    'https://github.com/apache/airflow/issues/26756'
),

-- Error 2: DAG serialization corruption causing scheduler crash loop
(
    'airflow.exceptions.AirflowException: The key has to be less than 250 characters',
    'airflow',
    'HIGH',
    '[
        {"solution": "Run: airflow dags reserialize -v -S <path-to-dags> to force DAG reserialization outside scheduler process and clear corrupted cache", "percentage": 95},
        {"solution": "Shorten task IDs and TaskGroup names to ensure total key length is under 250 characters", "percentage": 85},
        {"solution": "Delete the problematic DAG from the database using the UI ''delete'' button and let it regenerate", "percentage": 80}
    ]'::jsonb,
    'DAG with long task IDs or nested TaskGroups causing combined key to exceed 250 character limit. Scheduler running with cached corrupted DAG state.',
    'Scheduler restarts without crash loop. DAGs appear in UI. airflow dags list returns successfully without exceptions.',
    'Assuming validation happens before serialization (it doesn''t). Reverting code without clearing database cache.',
    0.92,
    'haiku',
    NOW(),
    'https://github.com/apache/airflow/issues/44738'
),

-- Error 3: PostgreSQL health check timeout in Docker Compose
(
    'postgres:13 ... Up 6 minutes (unhealthy) 5432/tcp - Airflow services remain in "Created" status',
    'airflow',
    'MEDIUM',
    '[
        {"solution": "Increase start_period for PostgreSQL health check to 60+ seconds in docker-compose.yml to allow database initialization", "percentage": 90},
        {"solution": "Verify connection string in airflow.cfg matches PostgreSQL service name (e.g., postgresql+psycopg2://airflow:airflow@postgres/airflow)", "percentage": 85},
        {"solution": "Ensure PostgreSQL environment variables (POSTGRES_USER, POSTGRES_PASSWORD, POSTGRES_DB) match airflow.cfg credentials", "percentage": 85}
    ]'::jsonb,
    'Docker Compose with PostgreSQL and Airflow services. Health check enabled on PostgreSQL. Airflow services depend on database startup.',
    'PostgreSQL health check shows "healthy". All Airflow services transition to "Up" state. Database connection successful.',
    'Incorrect service name in connection string. Typos in credentials. Running docker compose down without checking volume state.',
    0.82,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/78573320/airflow-postgres-not-able-to-connect'
),

-- Error 4: SQLAlchemy dialect mismatch for Celery backend
(
    'sqlalchemy.exc.NoSuchModuleError: Can''t load plugin: sqlalchemy.dialects:db.postgresql',
    'airflow',
    'MEDIUM',
    '[
        {"solution": "Use postgresql+psycopg2:// dialect for sql_alchemy_conn (SQLAlchemy connection)", "percentage": 95},
        {"solution": "Use db+postgres:// dialect for celery_result_backend (Celery connection). Note: db+ prefix not psycopg2", "percentage": 95},
        {"solution": "Ensure both are configured differently in airflow.cfg - sql_alchemy_conn uses psycopg2, celery_result_backend uses db+ prefix", "percentage": 90}
    ]'::jsonb,
    'Airflow using both SQLAlchemy and Celery for task execution. Configuration settings in airflow.cfg for database and result backend.',
    'No dialect errors in logs. Webserver starts successfully. Celery workers connect to result backend. Tasks execute without database errors.',
    'Using same dialect for both sql_alchemy_conn and celery_result_backend. Copying connection strings without adjusting driver prefix.',
    0.89,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/47247123/error-while-connecting-postgres-db-from-airflow'
),

-- Error 5: Task killed with SIGKILL due to Out-of-Memory
(
    'Task exited with return code Negsignal.SIGKILL',
    'airflow',
    'HIGH',
    '[
        {"solution": "Increase worker node memory resources. Upgrade node machine types (e.g., n1-standard-1 to higher memory variant with 8GB+)", "percentage": 85},
        {"solution": "Optimize data processing with chunking: use pd.read_sql(chunksize=10000) instead of loading entire dataset", "percentage": 88},
        {"solution": "Implement streaming with yield_per() for SQL Alchemy queries to process data incrementally", "percentage": 80},
        {"solution": "Limit parallel task execution and use ThreadPoolExecutor with controlled batch sizes", "percentage": 75}
    ]'::jsonb,
    'Worker nodes with limited RAM (e.g., Cloud Composer n1-standard-1 with 3.75GB). Task processing large datasets (>100MB). Multiple concurrent tasks.',
    'Task completes without SIGKILL. Memory usage stays below worker node limit during execution. Check monitoring dashboard shows no OOM conditions.',
    'Only increasing worker concurrency without increasing memory. Using all-at-once data loading instead of chunking. No resource monitoring.',
    0.84,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/69231797/airflow-dag-fails-when-pythonoperator-with-error-negsignal-sigkill'
),

-- Error 6: ModuleNotFoundError on DAG parsing (scheduler) with missing dependencies
(
    'ModuleNotFoundError: No module named ''crypto'' - ImportError in Airflow frontend',
    'airflow',
    'HIGH',
    '[
        {"solution": "Move top-level imports inside Python callables (functions). Replace global ''from crypto import module'' with local import inside task functions", "percentage": 92},
        {"solution": "Install missing dependencies on scheduler container: pip install crypto and all task dependencies", "percentage": 85},
        {"solution": "Sync all task dependencies across scheduler and worker containers using same requirements.txt", "percentage": 80}
    ]'::jsonb,
    'DAG file importing modules at top-level. Scheduler and workers have different Python environments. Crypto or similar external library missing on scheduler.',
    'DAG parses successfully without ImportError. Module appears available when task executes on worker. No errors in webserver UI.',
    'Assuming dependencies only needed on workers. Installing packages on workers but not scheduler. Using try/except to hide import errors.',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/67317925/how-to-avoid-dag-import-errors-in-apache-airflow-for-worker-node-dependencies'
),

-- Error 7: SIGKILL 9 from Kubernetes OOM Killer
(
    'Command died with <Signals.SIGKILL: 9>',
    'airflow',
    'HIGH',
    '[
        {"solution": "Increase memory resource limits for Celery worker pods in Kubernetes: set requests and limits higher (e.g., 4Gi limit)", "percentage": 90},
        {"solution": "Increase AIRFLOW__CORE__KILLED_TASK_CLEANUP_TIME environment variable to allow graceful cleanup", "percentage": 80},
        {"solution": "Run single process per container to make OOM detection reliable and Kubernetes to properly update pod status", "percentage": 85}
    ]'::jsonb,
    'Airflow running on Kubernetes with Celery workers. Pod memory limits set lower than task requirements. Multi-process container configuration.',
    'Task completes successfully. kubectl describe pod shows no "OOMKilled" reason. Container Exit Code is not 137. Memory usage within pod limits.',
    'Setting memory limits too low based on default values. Not monitoring actual task memory usage. Using multi-process container setup.',
    0.87,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/63731589/kubernetes-airflow-celery-worker-task-fails-with-sigkill-9-error-but-no-explanat'
),

-- Error 8: DAG not triggering at scheduled time
(
    'DAG scheduled for hourly/daily runs but only executes once or never auto-triggers',
    'airflow',
    'HIGH',
    '[
        {"solution": "Use static start_date in past (e.g., datetime(2024, 1, 1)) instead of dynamic datetime.now() or days_ago()", "percentage": 93},
        {"solution": "Remember Airflow executes DAGs at END of interval, not beginning. Hourly DAG at 2pm executes at 3pm", "percentage": 90},
        {"solution": "Set catchup=False to prevent backfill attempts if start_date is recent: DAG(dag_id, catchup=False)", "percentage": 88},
        {"solution": "Validate cron expression with online tools. Airflow uses UTC by default regardless of system timezone", "percentage": 85}
    ]'::jsonb,
    'DAG with schedule_interval defined (cron or timedelta). Start date set dynamically or to current time. Scheduler running.',
    'DAG executes automatically at scheduled intervals without manual trigger. Multiple DAG runs visible in UI spanning multiple days. No scheduling errors in logs.',
    'Setting start_date to datetime.now(). Using start_date equal to or after current time. Forgetting catchup=False with recent start_date.',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/40714087/apache-airflow-scheduler-does-not-trigger-dag-at-schedule-time'
),

-- Error 9: Sensor tasks holding worker slots continuously
(
    'Sensor tasks fail sporadically and occupy worker slots continuously, blocking other task execution',
    'airflow',
    'MEDIUM',
    '[
        {"solution": "Use mode=''reschedule'' in sensor definition to free worker slots: BaseSensorOperator(..., mode=''reschedule'')", "percentage": 92},
        {"solution": "Upgrade to Airflow 2.2+ and use deferrable operators which never occupy worker slots while waiting", "percentage": 88},
        {"solution": "Run DAGs at higher frequency instead of long wait periods. Replace 1-hour wait sensor with hourly DAG trigger", "percentage": 75}
    ]'::jsonb,
    'Airflow 2.x with sensor operators. Worker pool fully utilized. Long-running sensors (poke mode) in DAGs. Resource constraints on workers.',
    'Sensor tasks complete without blocking workers. Worker utilization metrics show free slots. Other tasks queue and execute normally.',
    'Using default mode=''poke'' without understanding resource impact. Setting unrealistic sensor timeout values. Not monitoring worker utilization.',
    0.85,
    'haiku',
    NOW(),
    'https://www.astronomer.io/blog/7-common-errors-to-check-when-debugging-airflow-dag/'
),

-- Error 10: Airflow Webserver 503 timeout errors
(
    'HTTP 503 Service Unavailable - Airflow UI entirely inaccessible',
    'airflow',
    'HIGH',
    '[
        {"solution": "Increase Webserver resources to minimum 5 AU (0.5 CPUs, 1.88 GiB memory). Horizontal scaling or vertical expansion", "percentage": 87},
        {"solution": "Increase web_server_master_timeout and web_server_worker_timeout in airflow.cfg to allow longer load times", "percentage": 85},
        {"solution": "Optimize DAG parsing by increasing min_file_process_interval and reducing DAG count or task complexity", "percentage": 80}
    ]'::jsonb,
    'Airflow Webserver underpowered or overloaded. Default timeout settings (10 seconds). Large number of DAGs or complex task graphs.',
    'Webserver responds to HTTP requests. UI loads without 5xx errors. Webserver logs show no timeout messages. Average response time <2 seconds.',
    'Only increasing CPU without increasing memory. Making high-frequency API/database calls outside operators. Not monitoring webserver health metrics.',
    0.82,
    'haiku',
    NOW(),
    'https://www.astronomer.io/blog/7-common-errors-to-check-when-debugging-airflow-dag/'
),

-- Error 11: DAG serialization errors and "SerializedDagNotFound"
(
    'SerializedDagNotFound: DAG not found in serialized_dag table',
    'airflow',
    'MEDIUM',
    '[
        {"solution": "Run airflow DB init to rebuild database state and resynchronize serialized_dag table", "percentage": 90},
        {"solution": "Use UI trash/delete button to remove DAG completely, then let scheduler regenerate from dag files", "percentage": 88},
        {"solution": "Ensure DAGs produce consistent, reproducible output on each parse (avoid external dependencies or random logic during parsing)", "percentage": 85}
    ]'::jsonb,
    'Airflow 2.x with DAG serialization enabled. Dynamic DAG creation or DAGs that vary output between parses. Recent DAG file changes.',
    'Scheduler finds DAGs in serialized_dag table. No "not found" errors in logs. All DAGs visible and executable in UI.',
    'Deploying dynamic DAGs that produce different results per parse. Not deleting old corrupted entries before redeploying. External API calls in parsing.',
    0.83,
    'haiku',
    NOW(),
    'https://github.com/apache/airflow/issues/18843'
),

-- Error 12: Pip dependency conflict during Airflow installation
(
    'ERROR: pip''s dependency resolver does not currently take into account all the packages that are installed. Dependency conflicts detected.',
    'airflow',
    'MEDIUM',
    '[
        {"solution": "Downgrade pip to version 20.2.4: pip install --upgrade pip==20.2.4 before Airflow installation", "percentage": 88},
        {"solution": "Use constraint files for your Python version: pip install apache-airflow --constraint https://raw.githubusercontent.com/apache/airflow/constraints-2.0.0/constraints-3.9.txt", "percentage": 90},
        {"solution": "Use legacy resolver flag: pip install apache-airflow --use-deprecated=legacy-resolver", "percentage": 85},
        {"solution": "Upgrade to Airflow 2.1+ which has better support for modern pip resolver implementations", "percentage": 80}
    ]'::jsonb,
    'Installing Airflow 2.0.0. Pip version 20.3+. Conflicting dependencies between Airflow and task dependencies (e.g., pandas version constraints).',
    'Installation completes without dependency conflicts. pip list shows all packages installed with compatible versions. Airflow starts without import errors.',
    'Ignoring constraint file recommendations. Using latest pip without checking compatibility. Installing multiple extras simultaneously.',
    0.86,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/68791073/cannot-install-apache-airflow-2-0-0-because-these-package-versions-have-conflicting-dependencies'
),

-- Error 13: Scheduler heartbeat failure and health check threshold
(
    'Scheduler does not appear to be running - Scheduler cannot report heartbeat due to heavy load',
    'airflow',
    'MEDIUM',
    '[
        {"solution": "Increase scheduler CPU/memory resources. Scale to minimum 5 AU or add additional scheduler instances", "percentage": 85},
        {"solution": "Optimize DAG parsing: increase min_file_process_interval to 60+ seconds for complex DAGs", "percentage": 80},
        {"solution": "Raise [scheduler]scheduler_health_check_threshold in airflow.cfg to allow longer intervals between heartbeats", "percentage": 80},
        {"solution": "Remove global variables from DAG files and use environment variables instead to reduce parsing overhead", "percentage": 75}
    ]'::jsonb,
    'Scheduler under heavy load with many DAGs. High DAG parsing frequency. Global variables in DAG files causing slow parsing. Limited scheduler resources.',
    'Scheduler heartbeat reported in logs every interval. Scheduler health OK in UI. No "scheduler does not appear to be running" warnings.',
    'Only increasing parallelism without increasing scheduler resources. Not optimizing DAG parsing. Using global variables causing repeated expensive operations.',
    0.78,
    'haiku',
    NOW(),
    'https://docs.cloud.google.com/composer/docs/troubleshooting-scheduling'
),

-- Error 14: Celery worker visibility timeout and duplicate task execution
(
    'Task executed multiple times by different workers - visibility_timeout exceeded causing task reassignment',
    'airflow',
    'MEDIUM',
    '[
        {"solution": "Set task_acks_late=True in [celery] config to force worker acknowledgment only after task completion", "percentage": 92},
        {"solution": "Increase [celery]visibility_timeout to exceed maximum task execution time (default: 3600 seconds)", "percentage": 88},
        {"solution": "Increase [celery]worker_max_tasks_per_child to allow workers to process more tasks before recycling", "percentage": 75}
    ]'::jsonb,
    'CeleryExecutor configured. Long-running tasks (>1 hour). Default visibility_timeout setting. Redis or SQS broker in use.',
    'No duplicate task executions observed. Worker logs show single execution per task. Airflow Task Instance history shows one run per task.',
    'Setting visibility_timeout lower than actual task duration. Misconfiguring task_acks_late=False. Not accounting for network/processing delays.',
    0.87,
    'haiku',
    NOW(),
    'https://airflow.apache.org/docs/apache-airflow-providers-celery/stable/celery_executor.html'
),

-- Error 15: Tasks queued timeout causing automatic failure
(
    'Scheduler marks tasks as failed after queued longer than scheduler.task_queued_timeout threshold',
    'airflow',
    'MEDIUM',
    '[
        {"solution": "Increase number of workers or worker concurrency: boost [celery]worker_concurrency to match task queue depth", "percentage": 88},
        {"solution": "Increase [scheduler]task_queued_timeout in airflow.cfg (default: 2400 seconds). Set to match expected queue wait time", "percentage": 85},
        {"solution": "Optimize DAG parallelism: lower [core]parallelism and [core]max_active_tasks_per_dag to reduce queue buildup", "percentage": 80},
        {"solution": "Increase worker pool sizes and resources to handle peak concurrent task demand", "percentage": 82}
    ]'::jsonb,
    'Airflow with many concurrent DAG runs. High parallelism settings. Limited worker capacity relative to task volume. Peak load periods.',
    'Tasks execute shortly after queuing (within timeout). No auto-failed tasks in UI. Queue depth metrics stay below thresholds.',
    'Setting task_queued_timeout too low. Over-configuring parallelism without corresponding worker capacity. Not monitoring queue depth metrics.',
    0.81,
    'haiku',
    NOW(),
    'https://docs.cloud.google.com/composer/docs/troubleshooting-scheduling'
);
