#!/usr/bin/env bash
# Install RVM and Ruby
set -euo pipefail

echo "==> Checking RVM..."

if ! command -v rvm &>/dev/null; then
  echo "==> Installing RVM..."
  curl -sSL https://get.rvm.io | bash -s stable

  # Source RVM
  source "$HOME/.rvm/scripts/rvm"
else
  echo "==> RVM already installed."
fi

echo "==> Installing Ruby 3.4 (latest stable)..."
rvm install 3.4 --default || echo "Ruby 3.4 may already be installed."

echo "==> RVM setup complete."
echo "   Installed rubies:"
rvm list
