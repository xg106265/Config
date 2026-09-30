#!/usr/bin/env bash
# Install oh-my-zsh core (skipped if already present).
set -euo pipefail
source "$(dirname "$0")/lib.sh"

ZSH_DIR="${ZSH:-$HOME/.oh-my-zsh}"
if [ -d "$ZSH_DIR" ]; then
  info "oh-my-zsh already installed at $ZSH_DIR"
else
  info "Cloning oh-my-zsh into $ZSH_DIR"
  git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$ZSH_DIR"
fi
