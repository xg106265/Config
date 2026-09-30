#!/usr/bin/env bash
# Symlink dotfiles into $HOME, backing up any existing files first.
set -euo pipefail
source "$(dirname "$0")/lib.sh"

BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

# "<path in repo>:<path under \$HOME>"
LINKS=(
  "zsh/.zshrc:.zshrc"
  "zsh/.zshenv:.zshenv"
  "zsh/.zprofile:.zprofile"
  "starship/starship.toml:.config/starship.toml"
)

link() {
  local src="$DOTFILES_DIR/$1" rel="$2" dest="$HOME/$2"
  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    info "ok      ~/$rel"
    return
  fi
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    mkdir -p "$BACKUP_DIR/$(dirname "$rel")"
    mv "$dest" "$BACKUP_DIR/$rel"
    warn "backup  ~/$rel -> $BACKUP_DIR/$rel"
  fi
  mkdir -p "$(dirname "$dest")"
  ln -s "$src" "$dest"
  info "linked  ~/$rel -> $src"
}

for pair in "${LINKS[@]}"; do
  link "${pair%%:*}" "${pair#*:}"
done
