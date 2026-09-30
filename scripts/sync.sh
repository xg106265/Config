#!/usr/bin/env bash
# Pull remote changes, then commit & push local edits.
# Usage: scripts/sync.sh [commit message]
set -euo pipefail
source "$(dirname "$0")/lib.sh"
cd "$DOTFILES_DIR"

info "Pulling remote changes"
git pull --rebase --autostash --quiet

if [ -z "$(git status --porcelain)" ]; then
  info "Nothing to push, already up to date"
  exit 0
fi

git add -A
git commit --quiet -m "${1:-sync from $(hostname -s) at $(date '+%Y-%m-%d %H:%M')}"
git push --quiet
info "Pushed local changes"
