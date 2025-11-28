INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Git Advanced Workflows - Master rebasing, cherry-picking, bisect, worktrees, and reflog for clean history and recovery',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Interactive Rebase",
      "cli": {
        "macos": "git rebase -i HEAD~5",
        "linux": "git rebase -i HEAD~5",
        "windows": "git rebase -i HEAD~5"
      },
      "manual": "Use rebase -i to edit commits: pick (keep), reword (message), edit (amend), squash (combine), fixup (combine, discard message), drop (remove). Common: rebase before PR, squash fixups, reorder commits logically."
    },
    {
      "solution": "Cherry-Picking",
      "cli": {
        "macos": "git cherry-pick abc123 && git cherry-pick abc123..def456",
        "linux": "git cherry-pick abc123 && git cherry-pick abc123..def456",
        "windows": "git cherry-pick abc123 && git cherry-pick abc123..def456"
      },
      "manual": "Apply specific commits across branches: single commit, range, without committing (-n), with edit (-e). Useful for backporting hotfixes or applying changes to multiple releases."
    },
    {
      "solution": "Binary Search Debugging with Bisect",
      "cli": {
        "macos": "git bisect start && git bisect bad && git bisect good v1.0.0",
        "linux": "git bisect start && git bisect bad && git bisect good v1.0.0",
        "windows": "git bisect start && git bisect bad && git bisect good v1.0.0"
      },
      "manual": "Find bugs by binary search: start bisect, mark HEAD as bad, mark known-good commit, test checkouts, mark good/bad. Auto version: git bisect run ./test.sh. Reset when done."
    },
    {
      "solution": "Multi-Branch Worktrees",
      "cli": {
        "macos": "git worktree add ../project-feature feature/new && git worktree list",
        "linux": "git worktree add ../project-feature feature/new && git worktree list",
        "windows": "git worktree add ..\\project-feature feature\\new && git worktree list"
      },
      "manual": "Work on multiple branches simultaneously: add worktree for existing/new branch, list active worktrees, remove when done, prune stale. Eliminates switching/stashing context."
    },
    {
      "solution": "Reflog Safety Net",
      "cli": {
        "macos": "git reflog && git reflog show feature/branch",
        "linux": "git reflog && git reflog show feature/branch",
        "windows": "git reflog && git reflog show feature/branch"
      },
      "manual": "Track all ref movements for 90 days: recover deleted commits/branches, undo resets. View reflog, find hash, checkout or create branch from it. Ultimate safety mechanism."
    },
    {
      "solution": "Clean History Workflow",
      "manual": "Before PR: checkout feature, interactive rebase onto main (squash typos, reword messages, reorder), force push with lease. Handles conflicts during rebase, test after changes."
    },
    {
      "solution": "Hotfix Distribution",
      "manual": "Create fix on main, cherry-pick abc123 to release branches (1.9, 2.0). Handles conflicts with --continue or --abort. Applies hotfix across versions efficiently."
    },
    {
      "solution": "Autosquash Workflow",
      "cli": {
        "macos": "git commit --fixup HEAD && git rebase -i --autosquash main",
        "linux": "git commit --fixup HEAD && git rebase -i --autosquash main",
        "windows": "git commit --fixup HEAD && git rebase -i --autosquash main"
      },
      "manual": "Auto-squash fixup commits: git commit --fixup (or --fixup abc123), then rebase with --autosquash. Git marks fixups automatically during rebase."
    },
    {
      "solution": "Recovery Commands",
      "cli": {
        "macos": "git rebase --abort && git reset --hard HEAD^ && git restore --source=abc123 file.txt",
        "linux": "git rebase --abort && git reset --hard HEAD^ && git restore --source=abc123 file.txt",
        "windows": "git rebase --abort && git reset --hard HEAD^ && git restore --source=abc123 file.txt"
      },
      "manual": "Abort in-progress operations, undo commits (soft/hard), restore files from specific commits. Create backup branch before risky rebase."
    }
  ]'::jsonb,
  'script',
  'Git installed, understanding of branches and commits, familiarity with command line',
  'Rebasing public branches (shared with others), force pushing without lease (overwrites teammate work), losing work during rebase conflicts, forgetting worktree cleanup, not backing up before risky ops',
  'Clean linear commit history after rebase, hotfixes applied to multiple releases successfully, bug-introducing commit identified via bisect, multiple worktrees active without context switching',
  'Advanced Git techniques including interactive rebase, cherry-picking, bisect debugging, worktrees for parallel work, and reflog recovery',
  'https://skillsmp.com/skills/wshobson-agents-plugins-developer-essentials-skills-git-advanced-workflows-skill-md',
  'admin:HAIKU_SKILL_1764289774_3721'
);
