# =============================================
# Aliases
# =============================================

# ---- Rails / Ruby ----
alias be="bundle exec"
alias espec="bundle exec rspec"
alias rserver="bundle exec rails server"
alias rconsole="bundle exec rails console"
alias rmigrate="bundle exec rails db:migrate"
alias rrollback="bundle exec rails db:rollback"
alias rroutes="bundle exec rails routes"
alias rgen="bundle exec rails generate"

# ---- Docker ----
alias dc="docker compose"
alias dcup="docker compose up"
alias dcdown="docker compose down"
alias dcbuild="docker compose build"
alias dcrun="docker compose run --rm"
alias dockerc="docker compose run"
alias despec="docker compose run --rm api bundle exec rspec"
alias drconsole="docker compose exec api bin/rails console"
alias dstoprconsole="docker compose run --rm api bin/rails console"

# ---- Git (supplements oh-my-zsh git plugin) ----
alias gs="git status -sb"
alias gc="git commit"
alias gca="git commit --amend"
alias gcm="git commit -m"
alias gco="git checkout"
alias gd="git diff"
alias gds="git diff --staged"
alias gl="git log --oneline --graph --decorate -20"
alias gla="git log --oneline --graph --decorate --all"
alias gp="git pull"
alias gps="git push"
alias gpf="git push --force-with-lease"
alias gwip="git add -A && git commit -m 'WIP'"

# ---- Search ----
alias pep="grep -Hri -A 2 -B 2"

# ---- Processes ----
alias kill3k="lsof -ti:3000 | xargs kill -9 2>/dev/null || true"
alias kill8k="lsof -ti:8000 | xargs kill -9 2>/dev/null || true"

# ---- Navigation ----
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias proj="cd ~/Projects"

# ---- Better defaults ----
command -v eza &>/dev/null && alias ls="eza --icons --group-directories-first"
command -v eza &>/dev/null && alias ll="eza -la --icons --group-directories-first"
command -v eza &>/dev/null && alias lt="eza --tree --level=2 --icons"
command -v bat &>/dev/null && alias cat="bat --paging=never"

# ---- Misc ----
alias reload="source ~/.zshrc"
alias dotfiles="cd ~/.dotfiles"
alias vim="vim"
alias v="vim"
alias c="clear"
