#!/usr/bin/env bash
# Install Homebrew (if missing) and the CLI tools listed in Brewfile.
set -euo pipefail
source "$(dirname "$0")/lib.sh"

if ! command -v brew >/dev/null 2>&1; then
  info "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  for b in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    [ -x "$b" ] && eval "$("$b" shellenv)" && break
  done
fi

info "Installing Brewfile packages"
brew bundle --file="$DOTFILES_DIR/Brewfile"
