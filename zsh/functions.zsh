# =============================================
# Shell Functions
# =============================================

# Create directory and cd into it
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Find and kill process on a given port
killport() {
  local port="${1:?Usage: killport <port>}"
  lsof -ti:"$port" | xargs kill -9 2>/dev/null && echo "Killed process on port $port" || echo "No process found on port $port"
}

# Quick git add, commit, push
gacp() {
  git add -A && git commit -m "${1:?Usage: gacp \"commit message\"}" && git push
}

# Extract any archive
extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2)   tar xjf "$1"   ;;
      *.tar.gz)    tar xzf "$1"   ;;
      *.bz2)       bunzip2 "$1"   ;;
      *.rar)       unrar x "$1"   ;;
      *.gz)        gunzip "$1"    ;;
      *.tar)       tar xf "$1"    ;;
      *.tbz2)      tar xjf "$1"   ;;
      *.tgz)       tar xzf "$1"   ;;
      *.zip)       unzip "$1"     ;;
      *.Z)         uncompress "$1" ;;
      *.7z)        7z x "$1"      ;;
      *)           echo "'$1' cannot be extracted" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Show top 10 most used commands
topcmd() {
  history | awk '{CMD[$2]++;count++} END { for (a in CMD) print CMD[a] " " CMD[a]/count*100 "% " a }' | sort -rn | head -10
}

# Docker compose exec shorthand
dce() {
  docker compose exec "$@"
}

# Rails routes grep
rgrep() {
  bundle exec rails routes | grep -i "${1:?Usage: rgrep <pattern>}"
}
