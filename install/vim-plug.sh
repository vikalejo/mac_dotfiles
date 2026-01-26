#!/usr/bin/env bash
# Install vim-plug and Vim plugins
set -euo pipefail

echo "==> Checking vim-plug..."

PLUG_FILE="$HOME/.vim/autoload/plug.vim"

if [ ! -f "$PLUG_FILE" ]; then
  echo "==> Installing vim-plug..."
  curl -fLo "$PLUG_FILE" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
  echo "==> vim-plug already installed."
fi

# Create undodir for persistent undo
mkdir -p "$HOME/.vim/undodir"

# Create vim-ai config directory
mkdir -p "$HOME/.vim_ai_config"

echo "==> Installing Vim plugins..."
vim +PlugInstall +qall 2>/dev/null || echo "Run :PlugInstall manually in Vim if this failed."

echo "==> Vim setup complete."
