#!/usr/bin/env bash
# =============================================
# Victor's Dotfiles - Setup Script
# Run this on a fresh Mac to get everything configured.
#
# Usage:
#   git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
#   cd ~/dotfiles
#   ./setup.sh
# =============================================

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo ""
echo "============================================="
echo "  Victor's Mac Setup"
echo "============================================="
echo ""
echo "Dotfiles directory: $DOTFILES_DIR"
echo ""

# ---- Xcode Command Line Tools ----
echo "==> Checking Xcode Command Line Tools..."
if ! xcode-select -p &>/dev/null; then
  echo "==> Installing Xcode Command Line Tools..."
  xcode-select --install
  echo "   Press any key after the installation is complete..."
  read -n 1 -s
else
  echo "==> Xcode CLT already installed."
fi

# ---- Homebrew + Packages ----
source "$DOTFILES_DIR/install/brew.sh"

# ---- Oh My Zsh ----
source "$DOTFILES_DIR/install/ohmyzsh.sh"

# ---- Symlinks (before RVM/NVM so .zshrc is in place) ----
source "$DOTFILES_DIR/install/symlinks.sh"

# ---- RVM + Ruby ----
source "$DOTFILES_DIR/install/rvm.sh"

# ---- NVM + Node ----
source "$DOTFILES_DIR/install/nvm.sh"

# ---- Vim Plugins ----
source "$DOTFILES_DIR/install/vim-plug.sh"

# ---- macOS Defaults ----
read -p "Apply macOS system preferences? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  source "$DOTFILES_DIR/macos/defaults.sh"
fi

# ---- Machine-specific env file ----
if [ ! -f "$HOME/.env.local" ]; then
  echo ""
  echo "==> Creating ~/.env.local from template..."
  cp "$DOTFILES_DIR/zsh/.env.local.example" "$HOME/.env.local"
  echo "   Edit ~/.env.local with your machine-specific secrets."
fi

echo ""
echo "============================================="
echo "  Setup Complete!"
echo "============================================="
echo ""
echo "Next steps:"
echo "  1. Edit ~/.env.local with your secrets (AWS, Sidekiq, etc.)"
echo "  2. Set your git identity:"
echo "     git config --file ~/.gitconfig.local user.name \"Your Name\""
echo "     git config --file ~/.gitconfig.local user.email \"you@email.com\""
echo "  3. Restart your terminal or run: source ~/.zshrc"
echo "  4. In Vim, run :PlugInstall if plugins weren't installed"
echo ""
