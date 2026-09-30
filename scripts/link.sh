#!/usr/bin/env bash
# Symlink the files listed in links.txt into $HOME, backing up existing files first.
set -euo pipefail
source "$(dirname "$0")/lib.sh"

BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

link() {
  local src="$DOTFILES_DIR/$1" rel="$2" dest="$HOME/$2"
  if [ ! -e "$src" ]; then
    warn "missing $1 in repo, skipped"
    return
  fi
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

while read -r src dest <&3; do
  [[ -z "$src" || "$src" == \#* ]] && continue
  link "$src" "$dest"
done 3< "$DOTFILES_DIR/links.txt"
