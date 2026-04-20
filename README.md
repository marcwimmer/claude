# marc-defaults — Personal Claude Code Plugin

Marc Wimmer's personal Claude Code defaults, packaged as a plugin + marketplace.

Ships:
- A global `CLAUDE.md` with personal preferences, Odoo/zodoo cheatsheet, shell defaults.
- `/marc-defaults:setup` — slash command that deploys `CLAUDE.md` to `~/.claude/CLAUDE.md`.
- Self-referencing marketplace so a single `/plugin marketplace add` makes the plugin installable.

## Install (per host, one-time)

Inside Claude Code:

```
/plugin marketplace add marcwimmer/claude
/plugin install marc-defaults@marc-defaults
/marc-defaults:setup
```

The `setup` command runs [install.sh](install.sh), which backs up any existing `~/.claude/CLAUDE.md` to `~/.claude/CLAUDE.md.bak.<timestamp>` before overwriting. If the content already matches, it is a no-op.

Restart Claude Code (or `/clear`) so the new global `CLAUDE.md` is picked up.

### Bootstrap without Claude Code

If Claude Code isn't installed yet on a new box, you can still install the defaults via the shell:

```bash
curl -fsSL https://raw.githubusercontent.com/marcwimmer/claude/main/install.sh | bash
```

## Team / project auto-install

To have a project automatically pull this marketplace + enable the plugin for all collaborators, commit the following to `.claude/settings.json` in that project:

```json
{
  "extraKnownMarketplaces": {
    "marc-defaults": {
      "source": { "source": "github", "repo": "marcwimmer/claude" }
    }
  },
  "enabledPlugins": {
    "marc-defaults@marc-defaults": true
  }
}
```

After cloning and accepting the trust prompt, Claude Code registers the marketplace and enables the plugin automatically — no `/plugin install` needed per user.

## Layout

```
.
├── .claude-plugin/
│   ├── plugin.json          # plugin manifest
│   └── marketplace.json     # marketplace manifest (self-referencing)
├── commands/
│   └── setup.md             # /marc-defaults:setup
├── CLAUDE.md                # the actual defaults, deployed by setup
├── install.sh               # idempotent installer (used by setup + curl bootstrap)
└── README.md
```

## Updating the defaults

1. Edit `CLAUDE.md` in this repo.
2. Commit + push.
3. On each host: `/plugin update marc-defaults@marc-defaults` then `/marc-defaults:setup` again.
