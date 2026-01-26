# =============================================
# Victor's Dotfiles - .zshrc
# =============================================

# Homebrew
export PATH="/opt/homebrew/bin:$PATH"

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(
  git
  rails
  ruby
  bundler
  docker
  docker-compose
  fzf
  zoxide
  z
)

source $ZSH/oh-my-zsh.sh

# ---- Editor ----
export EDITOR='vim'
export VISUAL='vim'

# ---- Source modular configs ----
for file in ~/.dotfiles/zsh/{aliases,exports,functions}.zsh; do
  [ -f "$file" ] && source "$file"
done

# ---- Machine-specific / secrets (not tracked in git) ----
[ -f ~/.env.local ] && source ~/.env.local

# ---- RVM (must be last PATH change) ----
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# ---- NVM ----
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# ---- FZF ----
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# ---- zoxide (smarter cd) ----
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"
