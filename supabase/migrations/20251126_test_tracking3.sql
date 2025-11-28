INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES
(
    'error: Merging is not possible because you have unmerged files',
    'git-test',
    'HIGH',
    '[
        {"solution": "Check status with git status to see conflicted files. Edit each file to resolve conflict markers (<<<<<<< HEAD ... ======= ... >>>>>>>) by choosing which version to keep or combining both. Run git add <file> for each resolved file, then git commit to complete the merge.", "percentage": 95},
        {"solution": "Abort the current merge attempt with git merge --abort to reset to pre-merge state, then resolve conflicts in a cleaner approach using git rebase before merging.", "percentage": 85}
    ]'::jsonb,
    'Git repository with ongoing merge attempt containing unresolved conflicts',
    'git status shows no files in "both modified" state. git log --oneline shows the merge commit completed. No "MERGING" indicator in branch name.',
    'Attempting git merge again without resolving conflicts first. Forgetting to stage files with git add after manual resolution. Not understanding conflict markers (<<<<<<, =======, >>>>>>).',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/49590460/git-says-automatic-merge-failed-what-does-it-mean',
    'admin:1764170435'
),
(
    'error: Your local changes to the following files would be overwritten by merge',
    'git-test',
    'HIGH',
    '[
        {"solution": "Stash your local changes with git stash, then pull with git pull origin <branch>. After merge completes, restore your changes with git stash pop. Use git stash -u if you have untracked files.", "percentage": 96},
        {"solution": "Commit your local changes first with git add . && git commit -m ''message'', then run git pull origin <branch>. This preserves your work in history.", "percentage": 90},
        {"solution": "Rebase your changes on top of remote with git pull origin <branch> -r. Warning: this rewrites history so use only if changes haven''t been published yet.", "percentage": 80},
        {"solution": "Discard local changes entirely with git reset --hard, then git pull origin <branch>. Only use if you don''t need your local modifications.", "percentage": 75}
    ]'::jsonb,
    'Git repository with uncommitted local changes that conflict with incoming merge changes',
    'git status shows clean working directory with no modified files. git pull completes without errors. Desired changes are either committed, stashed safely, or intentionally discarded.',
    'Using git reset --hard without backing up important changes. Forgetting git stash -u flag for untracked files. Using rebase on publicly-pushed commits (rewrites history). Attempting force operations that lose work.',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/15745045/how-do-i-resolve-git-saying-quot-error-your-local-changes-to-the-following-files',
    'admin:1764170435'
);
