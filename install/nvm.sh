#!/usr/bin/env bash
# Install NVM and Node.js
set -euo pipefail

echo "==> Checking NVM..."

export NVM_DIR="$HOME/.nvm"

if [ ! -d "$NVM_DIR" ]; then
  echo "==> Installing NVM..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
fi

# Source NVM
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

echo "==> Installing latest LTS Node.js..."
nvm install --lts
nvm alias default 'lts/*'

echo "==> Installing global npm packages..."
npm install -g yarn pnpm typescript

echo "==> NVM + Node setup complete."
echo "   Node: $(node -v)"
echo "   npm: $(npm -v)"
