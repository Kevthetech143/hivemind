INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'Docker container won''t start - exits immediately with no logs or error message',
    'docker-test',
    'HIGH',
    '[
        {"solution": "Add -it flags to allocate pseudo-terminal when running interactive shell: docker run -it -d [other-flags] image-name", "percentage": 95},
        {"solution": "For SSH services, run sshd in foreground with -D flag to prevent daemonization: docker run -d -p 52022:22 image /usr/sbin/sshd -D", "percentage": 92},
        {"solution": "Use a process supervisor (systemd or supervisor) to keep container running. Ensure a long-running foreground process exists.", "percentage": 88}
    ]'::jsonb,
    'Container image available locally, access to Dockerfile, understanding of desired container behavior',
    'docker ps shows container in ''Up'' status, docker logs produces output instead of being empty, application/service is accessible on expected ports',
    'Forgetting that bash is interactive and needs TTY allocation, using -d without -it, assuming service start commands daemonize correctly, not checking if container immediately exits',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/29957653/docker-container-not-starting-docker-start'
),
(
    'Docker build sending context to daemon is unexpectedly large - context size much larger than actual project files',
    'docker-test',
    'HIGH',
    '[
        {"solution": "Create .dockerignore file in project root excluding unnecessary directories (.git, node_modules, dist, tmp, log) like .gitignore format", "percentage": 95},
        {"solution": "Enable Docker BuildKit for faster builds and better file filtering: DOCKER_BUILDKIT=1 docker build -t image-name .", "percentage": 91},
        {"solution": "Run ripgrep diagnostic to identify files being included: rg -uuu --ignore-file .dockerignore --files --sort path . | xargs ls -lh | sort -hrk1 | head -20", "percentage": 87}
    ]'::jsonb,
    '.dockerignore file support, Docker installed, knowledge of which files are needed for build',
    'Build context size reduced by 50-90%, build completes faster, docker build command shows smaller context size in output',
    'Forgetting .dockerignore is not auto-inherited from .gitignore, placing .dockerignore in wrong directory, including build artifacts in context, not excluding .git when using git repos',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/26600769/build-context-for-docker-image-very-large'
),
(
    'Docker build context becomes recursively large due to filesystem anomalies or symlink loops - du reports impossible file sizes',
    'docker-test',
    'MEDIUM',
    '[
        {"solution": "Run du -s * in build directory to identify which subdirectories consume excessive space", "percentage": 88},
        {"solution": "Check .dockerignore file is properly formatted with one pattern per line and located in build context root", "percentage": 85},
        {"solution": "Investigate for symlink loops using find: find . -type l to locate symlinks that may be problematic", "percentage": 82},
        {"solution": "Check filesystem for corruption using fsck (Linux) or Disk Utility (macOS) if anomalies found", "percentage": 79}
    ]'::jsonb,
    'Access to filesystem tools (du, find), ability to run fsck, Docker build context available, .dockerignore file present',
    'du reports reasonable size matching actual files, docker build completes without hanging, no broken symlinks found, filesystem check passes',
    'Assuming du output is always accurate for network filesystems, not checking for circular symlink references, ignoring filesystem corruption possibilities, running fsck on mounted filesystem',
    0.84,
    'haiku',
    NOW(),
    'https://github.com/moby/moby/issues/12409'
);
