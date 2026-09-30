#!/usr/bin/env bash
# Bootstrap a new machine: Homebrew tools -> oh-my-zsh -> plugins -> symlinks.
set -euo pipefail
cd "$(dirname "$0")"

scripts/brew.sh
scripts/omz.sh
scripts/plugins.sh
scripts/link.sh

echo
echo "Done. Open a new terminal or run: exec zsh"
