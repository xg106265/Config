#!/usr/bin/env bash
# Clone (or update) the third-party oh-my-zsh plugins listed in omz/plugins.txt.
set -euo pipefail
source "$(dirname "$0")/lib.sh"

PLUGIN_DIR="${ZSH_CUSTOM:-${ZSH:-$HOME/.oh-my-zsh}/custom}/plugins"
mkdir -p "$PLUGIN_DIR"

while read -r name url <&3; do
  [[ -z "$name" || "$name" == \#* ]] && continue
  dest="$PLUGIN_DIR/$name"
  if [ -d "$dest/.git" ]; then
    info "Updating $name"
    git -C "$dest" pull --ff-only --quiet
  else
    info "Cloning $name"
    git clone --depth=1 --quiet "$url" "$dest"
  fi
done 3< "$DOTFILES_DIR/omz/plugins.txt"
