#!/usr/bin/env bash
# Create symlinks from dotfiles to home directory
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "==> Creating symlinks..."

# Helper: backup existing file and create symlink
link_file() {
  local src="$1"
  local dest="$2"

  if [ -L "$dest" ]; then
    # Already a symlink, remove it
    rm "$dest"
  elif [ -f "$dest" ] || [ -d "$dest" ]; then
    # Existing file/dir, back it up
    echo "   Backing up existing $dest -> ${dest}.backup"
    mv "$dest" "${dest}.backup"
  fi

  ln -s "$src" "$dest"
  echo "   Linked $dest -> $src"
}

# Dotfiles directory itself
link_file "$DOTFILES_DIR" "$HOME/.dotfiles"

# Zsh
link_file "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"

# Vim
link_file "$DOTFILES_DIR/vim/.vimrc" "$HOME/.vimrc"

# Git
link_file "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"

# Tmux
link_file "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"

# Gitignore global
link_file "$DOTFILES_DIR/git/.gitignore_global" "$HOME/.gitignore_global"

echo "==> Symlinks created."
