# =============================================
# Environment Exports (non-secret)
# =============================================

# Language
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# History
export HISTSIZE=50000
export SAVEHIST=50000
export HISTFILE=~/.zsh_history
setopt HIST_IGNORE_ALL_DUPS     # Remove older duplicate entries
setopt HIST_FIND_NO_DUPS        # Do not display duplicates when searching
setopt HIST_REDUCE_BLANKS       # Remove superfluous blanks
setopt SHARE_HISTORY            # Share history between sessions
setopt INC_APPEND_HISTORY       # Write to history immediately

# Homebrew
export HOMEBREW_NO_ANALYTICS=1

# PostgreSQL
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"

# Local bin
export PATH="$HOME/.local/bin:$PATH"
