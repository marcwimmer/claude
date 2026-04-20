---
description: Install Marc's CLAUDE.md defaults globally to ~/.claude/CLAUDE.md (with backup of any existing file).
---

Run the bundled installer that deploys this plugin's `CLAUDE.md` to the user's global Claude config at `~/.claude/CLAUDE.md`.

The plugin root is exposed as `${CLAUDE_PLUGIN_ROOT}`. The installer is idempotent: it backs up any existing `~/.claude/CLAUDE.md` to `~/.claude/CLAUDE.md.bak.<timestamp>` before overwriting, and exits as a no-op if the content already matches.

Execute exactly this command via Bash and report the output back to the user:

```bash
bash "${CLAUDE_PLUGIN_ROOT}/install.sh"
```

Do not read, diff, or modify files yourself — delegate entirely to the installer script. Afterwards, tell the user to restart Claude Code (or run `/clear`) so the new global `CLAUDE.md` is picked up.
