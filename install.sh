#!/usr/bin/env bash
#
# Install / update personal CLAUDE.md defaults on this host.
#
# Usage (one-shot, on any new server):
#   curl -fsSL https://raw.githubusercontent.com/marcwimmer/claude/main/install.sh | bash
#
# Or after cloning:
#   ./install.sh
#

set -euo pipefail

REPO_RAW="https://raw.githubusercontent.com/marcwimmer/claude/main"
CLAUDE_DIR="${CLAUDE_DIR:-$HOME/.claude}"
TARGET="$CLAUDE_DIR/CLAUDE.md"

mkdir -p "$CLAUDE_DIR"

# Source resolution: prefer local file (when run from clone), fall back to GitHub raw.
if [[ -f "$(dirname "$0")/CLAUDE.md" ]]; then
    SOURCE_FILE="$(dirname "$0")/CLAUDE.md"
    echo "→ Source: local file ($SOURCE_FILE)"
    NEW_CONTENT="$(cat "$SOURCE_FILE")"
else
    echo "→ Source: $REPO_RAW/CLAUDE.md"
    NEW_CONTENT="$(curl -fsSL "$REPO_RAW/CLAUDE.md")"
fi

# Backup if existing file differs.
if [[ -f "$TARGET" ]]; then
    if ! diff -q <(printf '%s' "$NEW_CONTENT") "$TARGET" >/dev/null 2>&1; then
        BACKUP="$TARGET.bak.$(date +%Y%m%d-%H%M%S)"
        cp "$TARGET" "$BACKUP"
        echo "→ Existing CLAUDE.md backed up to $BACKUP"
    else
        echo "✓ CLAUDE.md already up to date — nothing to do."
        exit 0
    fi
fi

printf '%s' "$NEW_CONTENT" > "$TARGET"
echo "✓ Installed CLAUDE.md → $TARGET"