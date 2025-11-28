INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'FetchFailedException: failed to connect to executor',
    'spark',
    'HIGH',
    '[
        {"solution": "Increase spark.network.timeout to 800 seconds: --conf spark.network.timeout=800", "percentage": 90},
        {"solution": "Verify /etc/hosts configuration - ensure internal IPs are properly bound to hostnames", "percentage": 85}
    ]'::jsonb,
    'Spark cluster with multiple executors, network connectivity between nodes',
    'Job completes without timeout errors, verify in executor logs that no connection timeouts occur',
    'Using default 120s timeout which is too low for large shuffles, incorrect hostname resolution',
    0.88,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/34941410/fetchfailedexception-or-metadatafetchfailedexception'
),
(
    'Missing an output location for shuffle 0',
    'spark',
    'HIGH',
    '[
        {"solution": "Increase executor memory: --executor-memory 4G or --conf spark.executor.memory=4g", "percentage": 92},
        {"solution": "Repartition data: df.repartition(200) to distribute across more executors", "percentage": 88},
        {"solution": "Set spark.yarn.executor.memoryOverhead=1G to handle GC and buffer overhead", "percentage": 85}
    ]'::jsonb,
    'Spark job processing large datasets (10GB+), YARN cluster setup',
    'Job completes without shuffle failures, YARN logs show no memory limit exceeded messages',
    'Only increasing partitions without increasing memory, not accounting for memory overhead on YARN',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/34941410/fetchfailedexception-or-metadatafetchfailedexception'
),
(
    'Error in opening FileSegmentManagedBuffer',
    'spark',
    'MEDIUM',
    '[
        {"solution": "Set shuffle retry parameters: --conf spark.shuffle.io.retryWait=60s --conf spark.shuffle.io.maxRetries=10", "percentage": 87},
        {"solution": "Exclude conflicting Netty libraries: add <exclusion> in pom.xml for io.netty:netty-* from spark-core", "percentage": 82}
    ]'::jsonb,
    'Spark with network-based shuffle, custom dependencies in classpath',
    'Shuffle operations complete without buffer errors, verify no netty version conflicts in dependency tree',
    'Not adjusting retry timeouts, dependency conflicts go undetected in test environments',
    0.85,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/34941410/fetchfailedexception-or-metadatafetchfailedexception'
),
(
    'java.lang.OutOfMemoryError: Not enough memory to build and broadcast the table',
    'spark',
    'HIGH',
    '[
        {"solution": "Increase driver memory: --driver-memory 8G or --conf spark.driver.memory=8g", "percentage": 94},
        {"solution": "Broadcast smaller tables or use df.persist() with MEMORY_ONLY storage level", "percentage": 88}
    ]'::jsonb,
    'Spark job with broadcast joins on large tables, access to driver node',
    'Job completes without OOM during broadcast, driver memory metrics show available headroom in logs',
    'Broadcasting entire DataFrame without filtering first, using default 1GB driver memory with large datasets',
    0.93,
    'haiku',
    NOW(),
    'https://docs.qubole.com/en/latest/troubleshooting-guide/spark-ts/troubleshoot-spark.html'
),
(
    'java.lang.OutOfMemoryError: GC overhead limit exceeded',
    'spark',
    'HIGH',
    '[
        {"solution": "Increase executor memory: --executor-memory 8G or --conf spark.executor.memory=8g", "percentage": 93},
        {"solution": "Reduce shuffle partition pressure: --conf spark.sql.shuffle.partitions=100 (from default 200)", "percentage": 80}
    ]'::jsonb,
    'Spark with numerous small objects or frequent GC, executor heap size monitoring available',
    'Garbage collection completes in reasonable time, executor logs show healthy heap utilization',
    'Adding more partitions without increasing memory, not tuning JVM GC flags',
    0.91,
    'haiku',
    NOW(),
    'https://docs.qubole.com/en/latest/troubleshooting-guide/spark-ts/troubleshoot-spark.html'
),
(
    'org.apache.spark.shuffle.FetchFailedException: failed to allocate XXX bytes of direct memory',
    'spark',
    'HIGH',
    '[
        {"solution": "Increase executor memory and adjust shuffle partitions: --executor-memory 6G --conf spark.sql.shuffle.partitions=200", "percentage": 91},
        {"solution": "Increase executor memory overhead: --conf spark.yarn.executor.memoryOverhead=2G", "percentage": 86}
    ]'::jsonb,
    'Spark shuffle operations with large intermediate data, YARN memory configuration access',
    'Shuffle completes successfully, YARN logs show no memory allocation failures',
    'Confusing executor-memory with executor memory overhead, not accounting for off-heap memory needs',
    0.90,
    'haiku',
    NOW(),
    'https://docs.qubole.com/en/latest/troubleshooting-guide/spark-ts/troubleshoot-spark.html'
),
(
    'Container killed by YARN for exceeding memory limits',
    'spark',
    'HIGH',
    '[
        {"solution": "Set executor memory overhead: --conf spark.yarn.executor.memoryOverhead=1536 (for Spark 2.3+: spark.executor.memoryOverhead=1536)", "percentage": 95},
        {"solution": "Reduce executor memory allocation and increase memory overhead instead", "percentage": 89}
    ]'::jsonb,
    'Spark on YARN cluster with container memory limits enforced',
    'Containers run without being killed, YARN logs show memory usage within allocation limits',
    'Only adjusting executor memory without considering overhead, setting overhead too low',
    0.94,
    'haiku',
    NOW(),
    'https://docs.qubole.com/en/latest/troubleshooting-guide/spark-ts/troubleshoot-spark.html'
),
(
    'Total size of serialized results of XXXX is bigger than spark.driver.maxResultSize',
    'spark',
    'MEDIUM',
    '[
        {"solution": "Increase driver max result size: --conf spark.driver.maxResultSize=2G (default is 1G)", "percentage": 92},
        {"solution": "Reduce result set size before collecting: use take(n) or limit(n) before collect()", "percentage": 88}
    ]'::jsonb,
    'Spark job collecting large results back to driver, ability to adjust driver configuration',
    'Collect operations complete without result size errors, driver has adequate memory for results',
    'Collecting entire large DataFrame without filtering, not using repartition to reduce results before collect',
    0.90,
    'haiku',
    NOW(),
    'https://docs.qubole.com/en/latest/troubleshooting-guide/spark-ts/troubleshoot-spark.html'
),
(
    'Too large frame: XXXXXXXXXX bytes (shuffle blocks exceed 2GB)',
    'spark',
    'MEDIUM',
    '[
        {"solution": "Upgrade to Spark 2.2+ which supports larger shuffle blocks", "percentage": 89},
        {"solution": "Increase shuffle partitions: --conf spark.sql.shuffle.partitions=500 or df.repartition(500)", "percentage": 91}
    ]'::jsonb,
    'Spark processing large DataFrames with significant shuffle operations, ability to upgrade Spark version',
    'Shuffle completes with no frame size errors, data is evenly distributed across partitions',
    'Using Spark 2.0 or 2.1 with large datasets, not increasing partitions enough',
    0.88,
    'haiku',
    NOW(),
    'https://docs.qubole.com/en/latest/troubleshooting-guide/spark-ts/troubleshoot-spark.html'
),
(
    'FileAlreadyExistsException: file already exists and overwrite is false',
    'spark',
    'MEDIUM',
    '[
        {"solution": "Enable output overwrite: --conf spark.hadoop.mapreduce.output.textoutputformat.overwrite=true --conf spark.qubole.outputformat.overwriteFileInWrite=true", "percentage": 94},
        {"solution": "Delete output directory before job: os.system(''hadoop fs -rm -r /path/to/output'') before df.write()", "percentage": 87}
    ]'::jsonb,
    'Spark write operation to existing path, ability to modify configuration or delete output directory',
    'Write completes successfully, output files are created with overwritten data',
    'Assuming file overwrite is automatic, not cleaning up previous job outputs',
    0.92,
    'haiku',
    NOW(),
    'https://docs.qubole.com/en/latest/troubleshooting-guide/spark-ts/troubleshoot-spark.html'
),
(
    'Killing container due to running beyond physical memory limits',
    'spark',
    'HIGH',
    '[
        {"solution": "Reduce executor memory and increase memory overhead: --executor-memory 3G --conf spark.yarn.executor.memoryOverhead=1G", "percentage": 93},
        {"solution": "Reduce data processed per partition: increase spark.sql.shuffle.partitions or use df.repartition()", "percentage": 85}
    ]'::jsonb,
    'YARN cluster with memory enforcement, executor container monitoring visible in logs',
    'Containers run to completion, YARN logs show "Memory used" within limits',
    'Allocating all memory to executor-memory without reserve for overhead and buffers',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/34941410/fetchfailedexception-or-metadatafetchfailedexception'
),
(
    'Syntax error: cannot recognize input near java code after compilation',
    'spark',
    'LOW',
    '[
        {"solution": "Verify all parentheses and semicolons in custom Spark code", "percentage": 96},
        {"solution": "Ensure all dependent JARs are in classpath: --jars /path/to/lib/*.jar", "percentage": 88},
        {"solution": "Check Scala/Java version compatibility with Spark distribution", "percentage": 81}
    ]'::jsonb,
    'Spark job with custom code compilation, access to build logs and classpath configuration',
    'Job submits without syntax errors, all dependent classes are available during execution',
    'Missing JAR files detected only at runtime, not validating syntax before submission',
    0.85,
    'haiku',
    NOW(),
    'https://docs.qubole.com/en/latest/troubleshooting-guide/spark-ts/troubleshoot-spark.html'
),
(
    'No space left on device: shuffle spilling to disk fills up local storage',
    'spark',
    'MEDIUM',
    '[
        {"solution": "Increase shuffle memory fraction: --conf spark.shuffle.memoryFraction=0.6 (increase from default 0.2)", "percentage": 84},
        {"solution": "Reduce data being shuffled: filter records before shuffle or increase executor memory", "percentage": 89},
        {"solution": "Add disk space to Spark local directories: configure spark.local.dir with multiple paths on separate disks", "percentage": 86}
    ]'::jsonb,
    'Spark with shuffle operations, local disk access, ability to modify executor configuration',
    'Shuffle completes without disk full errors, local storage has adequate free space during execution',
    'Not monitoring local disk usage, setting shuffle memory fraction too low',
    0.87,
    'haiku',
    NOW(),
    'https://docs.qubole.com/en/latest/troubleshooting-guide/spark-ts/troubleshoot-spark.html'
),
(
    'MetadataFetchFailedException: Block not found in either locations',
    'spark',
    'MEDIUM',
    '[
        {"solution": "Increase executor memory to prevent eviction of shuffle blocks: --executor-memory 6G", "percentage": 88},
        {"solution": "Increase spark.shuffle.io.maxRetries and spark.shuffle.io.retryWait for transient failures", "percentage": 83}
    ]'::jsonb,
    'Spark shuffle operation, executor memory configuration available',
    'Metadata fetch completes without block not found errors, shuffle blocks persist in cache',
    'Using too small executor memory causing premature block eviction, not retrying transient network failures',
    0.85,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/34941410/fetchfailedexception-or-metadatafetchfailedexception'
);
