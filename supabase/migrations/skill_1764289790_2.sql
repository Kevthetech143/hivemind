INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Python Performance Optimization - Profile and optimize Python code using cProfile, memory profilers, and performance best practices',
  'claude-code',
  'skill',
  '[
    {"solution": "cProfile - CPU Profiling", "cli": {"macos": "python -m cProfile -o output.prof script.py", "linux": "python -m cProfile -o output.prof script.py", "windows": "python -m cProfile -o output.prof script.py"}, "manual": "Use cProfile.Profile() to profile code, analyze with pstats.Stats, save with dump_stats. Sort by cumulative time or number of calls", "note": "Built-in tool, no installation needed"},
    {"solution": "line_profiler - Line-by-Line Analysis", "cli": {"macos": "pip install line-profiler && kernprof -l -v script.py", "linux": "pip install line-profiler && kernprof -l -v script.py", "windows": "pip install line-profiler && kernprof -l -v script.py"}, "manual": "Add @profile decorator, use kernprof command to run, get line-by-line execution times", "note": "Decorator syntax available via line_profiler"},
    {"solution": "memory_profiler - Memory Usage", "cli": {"macos": "pip install memory-profiler && python -m memory_profiler script.py", "linux": "pip install memory-profiler && python -m memory_profiler script.py", "windows": "pip install memory-profiler && python -m memory_profiler script.py"}, "manual": "Decorate with @profile, track memory per line, identify leaks", "note": "Shows peak memory usage"},
    {"solution": "py-spy - Production Profiling", "cli": {"macos": "pip install py-spy && py-spy record -o profile.svg -- python script.py", "linux": "pip install py-spy && py-spy record -o profile.svg -- python script.py", "windows": "pip install py-spy && py-spy record -o profile.svg -- python script.py"}, "manual": "Non-invasive profiler for running processes. Generate flamegraphs", "note": "Best for production"},
    {"solution": "List Comprehensions", "manual": "Use [i**2 for i in range(n)] instead of loop-append. 2-3x faster. Use generators for memory efficiency", "note": "Comprehension faster than traditional loops"},
    {"solution": "Dictionary Lookups", "manual": "Use dict/set for O(1) membership testing instead of O(n) list search. 100-1000x faster for large collections", "note": "Hash tables beat linear search"},
    {"solution": "Cache with lru_cache", "cli": {"macos": "python -c \"from functools import lru_cache\"", "linux": "python -c \"from functools import lru_cache\"", "windows": "python -c \"from functools import lru_cache\""}, "manual": "Decorate expensive functions with @lru_cache. Memoization eliminates redundant computation", "note": "Huge speedup for recursion"},
    {"solution": "String join()", "manual": "Use str.join() for concatenation (10-100x faster). Avoid += in loops", "note": "+= creates new string each time"},
    {"solution": "Multiprocessing", "cli": {"macos": "python -m multiprocessing", "linux": "python -m multiprocessing", "windows": "python -m multiprocessing"}, "manual": "Use mp.Pool for parallel CPU-bound work. Speedup ~= cores", "note": "Not for I/O work"},
    {"solution": "Async I/O", "cli": {"macos": "pip install aiohttp", "linux": "pip install aiohttp", "windows": "pip install aiohttp"}, "manual": "Use async/await with asyncio.gather() for concurrent I/O. 4-20x faster", "note": "Single thread for thousands"}
  ]'::jsonb,
  'script',
  'Python 3.7+, pip',
  'Optimizing without profiling, premature optimization, ignoring complexity, wrong data structures, unnecessary copies, not batching DB operations, global variable overhead',
  'cProfile reports generated, memory profiling reviewed, benchmark comparisons showing speedups, cache hits verified, optimizations measurable',
  'Profile and optimize Python with cProfile, memory profilers, and performance patterns',
  'https://skillsmp.com/skills/wshobson-agents-plugins-python-development-skills-python-performance-optimization-skill-md',
  'admin:HAIKU_SKILL_1764289790_5412'
);
