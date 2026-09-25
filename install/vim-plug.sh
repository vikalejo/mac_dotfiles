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

# coc.nvim needs Node.js; extensions are installed separately from plugins.
if command -v node >/dev/null 2>&1; then
  echo "==> Installing coc.nvim extensions (TS/JS, ESLint, Prettier, Tailwind)..."
  vim +'CocInstall -sync coc-tsserver coc-eslint coc-prettier coc-tailwindcss coc-json coc-css coc-html' +qall \
    2>/dev/null || echo "Run :CocInstall manually in Vim if this failed."
else
  echo "==> Skipping coc extensions: Node.js not found (install Node, then run :CocInstall in Vim)."
fi

echo "==> Vim setup complete."
