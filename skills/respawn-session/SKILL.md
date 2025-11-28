# Respawn Claude Session Skill

## Purpose
Spawn a fresh Claude instance in a new tmux session with reloaded MCP servers and clean context.

## Prerequisites
- tmux installed (`which tmux`)
- Claude CLI available in PATH
- User can access terminal

## Execution Steps

### Step 1: Verify tmux is available
```bash
which tmux
tmux -V
```

### Step 2: Create new tmux session with Claude
```bash
SESSION_NAME="clauderespawn-$(date +%s)"
tmux new-session -d -s "$SESSION_NAME" && \
tmux send-keys -t "$SESSION_NAME" "claude --dangerously-skip-permissions --continue" Enter
```

### Step 3: Confirm session created
```bash
tmux list-sessions | grep clauderespawn
```

### Step 4: User attaches to session
User runs in their terminal:
```bash
tmux attach -t $SESSION_NAME
```

Replace `$SESSION_NAME` with the actual session name (e.g., `clauderespawn-1732814083`)

## Success Indicators
- ✅ tmux session appears in `tmux list-sessions`
- ✅ Session name echoed to user with attach instructions
- ✅ User can run `tmux attach -t <session>` to connect
- ✅ Fresh Claude instance loads with clean MCP state

## Common Pitfalls
- ❌ Using `claude --continue` without `--dangerously-skip-permissions` (permission check blocks respawn)
- ❌ Not echoing session name to user (they won't know which session to attach to)
- ❌ Trying to respawn in same tmux window (use new session instead)
- ❌ Assuming user will automatically see the session (must tell them how to attach)

## Notes
- Each respawn gets unique session name (using timestamp) to avoid conflicts
- The `--dangerously-skip-permissions` flag is intentional for respawn use case
- User must manually attach with `tmux attach -t <session>`
- To kill unwanted sessions: `tmux kill-session -t <session>`
