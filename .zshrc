# ======== ZSH Configuration (Optimized for Productivity) =======
# editor: jeerasak
# ==================================

# ============================================================
# 1. INIT - Powerlevel10k Instant Prompt
# ============================================================
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ============================================================
# 2. OH-MY-ZSH SETUP
# ============================================================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(
  git
  z
  zsh-autosuggestions
  zsh-syntax-highlighting
  docker
  docker-compose
)
source $ZSH/oh-my-zsh.sh

# ============================================================
# 3. PATH CONFIGURATION
# ============================================================
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
export PATH="/home/game/.local/bin:$PATH"
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
export EDITOR="nvim"
export VISUAL="nvim"

# ============================================================
# 4. ALIASES - SYSTEM & NAVIGATION (PRODUCTIVITY)
# ============================================================
# Config
alias zshconfig="nvim ~/.zshrc"
alias zshreload="exec zsh"
alias update="sudo apt update && sudo apt full-upgrade -y"

# Navigation - Fast movement
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ~="cd ~"
alias back="cd -"
alias home="cd ~"

# Listing - Enhanced with exa/bat if available
if command -v exa &> /dev/null; then
  alias ls="exa --group-directories-first"
  alias la="exa -lah --group-directories-first"
  alias ll="exa -lh --group-directories-first"
  alias lsd="exa -lh --sort=size --reverse --group-directories-first"
else
  alias la="ls -lah"
  alias ll="ls -lh"
fi

# File operations with safety
alias mkdir="mkdir -pv"
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -iv"
alias mkfile="touch"

# Network & System
alias ping="ping -c 5"
alias ips="hostname -I"
alias ports="netstat -tulpn"
alias diskuse="du -sh * | sort -rh"
alias memuse="free -h"
alias cpuinfo="lscpu | head -20"

# Quick commands
alias c="clear"
alias h="history"
alias serve="python3 -m http.server 8000"
alias servepy="python3 -m http.server"

# Text processing
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"

# ============================================================
# 5. ALIASES - DEVELOPMENT & GIT
# ============================================================
# Git shortcuts - Pro level
alias g="git"
alias ga="git add"
alias gaa="git add -A"
alias gs="git status"
alias gc="git commit -m"
alias gca="git commit -am"
alias gp="git push"
alias gpl="git pull"
alias gb="git branch"
alias gba="git branch -a"
alias gco="git checkout"
alias gcb="git checkout -b"
alias gd="git diff"
alias gdw="git diff --word-diff"
alias glog="git log --oneline -n 20"
alias gloga="git log --oneline --graph --all"
alias gr="git reset"
alias grh="git reset --hard"
alias gm="git merge"
alias gf="git fetch"
alias gt="git tag"
alias gst="git stash"
alias gstp="git stash pop"

# Git functions
gclone() { git clone "$1" && cd "$(basename "$1" .git)"; }
glast() { git log -1 --stat; }
gblast() { git branch -v | head -5; }

# Node/NPM/PNPM
alias ni="npm install"
alias nis="npm install --save"
alias nid="npm install --save-dev"
alias nun="npm uninstall"
alias nr="npm run"
alias nrd="npm run dev"
alias nrb="npm run build"
alias nrs="npm run start"
alias nrt="npm run test"
alias nrl="npm run lint"
alias pr="pnpm run"
alias prd="pnpm run dev"
alias prb="pnpm run build"

# Docker
alias d="docker"
alias dc="docker compose"
alias dcup="docker compose up -d"
alias dcdown="docker compose down"
alias dclogs="docker compose logs -f"
alias dps="docker ps"
alias dpsa="docker ps -a"
alias drm="docker rm"
alias drmi="docker rmi"
alias dprune="docker system prune -f"

# Python
alias py="python3"
alias pip="pip3"
alias pir="pip install -r requirements.txt"
alias venv="python3 -m venv venv && source venv/bin/activate"
alias venvdeactivate="deactivate"

# Editors (vim = classic vim with ~/.vimrc, nvim = neovim)
unalias vim vi 2>/dev/null
alias v="vim"
alias vi="nvim"
alias nano="nano -c"

# Vim shortcuts
alias vimrc="vim ~/.vimrc"
alias nvimrc="nvim ~/.config/nvim/init.lua"
alias zshrc="nvim ~/.zshrc"
alias plug-install="vim +PlugInstall +qa"
alias plug-update="vim +PlugUpdate +qa"
alias plug-clean="vim +PlugClean +qa"

# ============================================================
# 6. FUNCTIONS - NAVIGATION & FILES
# ============================================================
# Create and enter directory
mkcd() { mkdir -pv "$1" && cd "$1"; }

# Fast directory search and jump
cdl() {
  local dir=$(find ~ -type d -name "$1" 2>/dev/null | head -1)
  if [ -n "$dir" ]; then
    cd "$dir"
  else
    echo "Directory '$1' not found"
  fi
}

# Find file/folder by name
ff() { find . -type f -name "*$1*" 2>/dev/null; }
fd() { find . -type d -name "*$1*" 2>/dev/null; }

# Search in files (ripgrep if available)
if command -v rg &> /dev/null; then
  search() { rg --color=auto "$1" . 2>/dev/null; }
else
  search() { grep -r "$1" . --color=auto 2>/dev/null; }
fi

# Extract archives
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
      *.Z)         uncompress "$1";;
      *.7z)        7z x "$1"      ;;
      *)           echo "'$1' cannot be extracted" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Quick backup
backup() { cp -r "$1" "${1}.backup.$(date +%s)" && echo "Backed up: ${1}.backup.$(date +%s)"; }

# Directory stats
lstats() {
  echo "📁 Files: $(find . -type f | wc -l) | 📂 Dirs: $(find . -type d | wc -l) | 📦 Size: $(du -sh . | cut -f1)"
}

# File counter
countfiles() { find "${1:-.}" -type f | wc -l; }

# ============================================================
# 7. FUNCTIONS - DEVELOPMENT & BUILD
# ============================================================
# Initialize new project
init_project() {
  local name="${1:-.}"
  mkdir -pv "$name"
  cd "$name"
  git init
  echo "# $name" > README.md
  git add README.md
  git commit -m "initial commit"
  echo "✅ Project initialized: $name"
}

# Git utilities
git_branches_sorted() { git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname:short)'; }
git_commits_today() { git log --since="00:00" --until="23:59" --oneline; }
git_stash_show() { git stash show -p $(git stash list | head -1 | cut -d: -f1); }

# Port utilities
port_check() { lsof -i :"$1" 2>/dev/null || echo "✅ Port $1 is free"; }
kill_port() { lsof -ti:"$1" | xargs kill -9 2>/dev/null && echo "✅ Killed process on port $1" || echo "No process on port $1"; }

# Docker utilities
docker_cleanup() { docker system prune -f && echo "✅ Docker cleanup done"; }
docker_logs_tail() { docker logs -f --tail=50 "$1"; }

# Build/Test/Dev commands
build() {
  if [ -f "Makefile" ]; then
    make
  elif [ -f "package.json" ]; then
    npm run build
  elif [ -f "setup.py" ]; then
    python3 setup.py build
  else
    echo "❌ No build system detected"
  fi
}

test() {
  if [ -f "package.json" ]; then
    npm test
  elif [ -f "pytest.ini" ] || [ -f "setup.py" ]; then
    pytest
  elif [ -f "go.mod" ]; then
    go test ./...
  else
    echo "❌ No test runner detected"
  fi
}

dev() {
  if [ -f "package.json" ]; then
    npm run dev
  elif [ -f "docker-compose.yml" ]; then
    docker compose up -d
  else
    echo "❌ No dev environment detected"
  fi
}

# Environment checker
envcheck() {
  echo "🔍 Environment Check:"
  echo "  Node:   $(node -v 2>/dev/null || echo '❌')"
  echo "  NPM:    $(npm -v 2>/dev/null || echo '❌')"
  echo "  Python: $(python3 -v 2>&1 | head -1 || echo '❌')"
  echo "  Git:    $(git -v 2>/dev/null || echo '❌')"
  echo "  Docker: $(docker -v 2>/dev/null || echo '❌')"
}

# ============================================================
# 8. FUNCTIONS - SYSTEM & MONITORING
# ============================================================
# Directory size
size() { du -sh "${1:-.}" 2>/dev/null | sort -hr; }

# Memory usage
mem() { free -h; }

# CPU info
cpu() { lscpu | grep -E "Architecture|CPU op-mode|Byte Order|CPU\(s\)|On-line"; }

# System info
sysinfo() {
  echo "=== System Information ==="
  uname -a
  echo ""
  echo "=== CPU ==="
  lscpu | head -8
  echo ""
  echo "=== Memory ==="
  free -h
  echo ""
  echo "=== Disk ==="
  df -h | grep -v "tmpfs"
}

# Monitor system
watch_system() { watch -n 1 'clear; echo "=== CPU ==="; top -bn1 | head -5; echo "=== Memory ==="; free -h'; }

# ============================================================
# 9. FUNCTIONS - TODO & NOTES
# ============================================================
# Quick todo
todo() { echo "$(date '+%Y-%m-%d %H:%M') - $*" >> ~/.todo.txt && echo "✅ Added: $*"; }
showtodo() { cat ~/.todo.txt 2>/dev/null || echo "📝 No todos yet"; }
cleartodo() { rm ~/.todo.txt && echo "✅ Todos cleared"; }

# Quick notes
note() { echo "$(date '+%Y-%m-%d %H:%M') - $*" >> ~/.notes.txt && echo "✅ Note saved"; }
shownotes() { cat ~/.notes.txt 2>/dev/null || echo "📝 No notes yet"; }

# ============================================================
# 10. FUNCTIONS - BULK OPERATIONS
# ============================================================
# Bulk rename
bulk_rename() {
  if [ $# -lt 2 ]; then
    echo "Usage: bulk_rename <pattern> <replacement>"
    return 1
  fi
  for f in *"$1"*; do
    [ -e "$f" ] && mv "$f" "${f//$1/$2}"
  done
  echo "✅ Renamed files: $1 → $2"
}

# Bulk change extension
change_ext() {
  if [ $# -lt 2 ]; then
    echo "Usage: change_ext <old_ext> <new_ext>"
    return 1
  fi
  for f in *."$1"; do
    [ -e "$f" ] && mv "$f" "${f%."$1"}.$2"
  done
  echo "✅ Changed extension: .$1 → .$2"
}

# ============================================================
# 11. FUNCTIONS - QUICK SEARCH & JUMP
# ============================================================
# Jump to recent git repo
jgit() {
  local dir=$(find ~ -name ".git" -type d 2>/dev/null | sed 's/.git$//' | sort -r | head -1)
  [ -n "$dir" ] && cd "$dir" && git status
}

# All repos status
allstatus() {
  find ~ -maxdepth 3 -name ".git" -type d 2>/dev/null | xargs -I {} sh -c 'echo "=== {} ===" && git -C {} status -s'
}

# ============================================================
# 12. POWERLEVEL10K CONFIG
# ============================================================
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ============================================================
# 13. FZF INTEGRATION (FUZZY FINDER)
# ============================================================
if [ -f "$HOME/.fzf.zsh" ]; then
  source "$HOME/.fzf.zsh"
  export FZF_DEFAULT_OPTS="--height 40% --reverse --border"
  export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"

  # Ctrl+R - History search
  # Ctrl+T - File search
  # Alt+C - Directory search
fi

# ============================================================
# 14. CUSTOM ENV LOADER
# ============================================================
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

# ============================================================
# 15. THIRD-PARTY INTEGRATIONS
# ============================================================
# OpenCode
export PATH=/home/game/.opencode/bin:$PATH

# Linuxbrew (lazy load)
if [ -d "/home/linuxbrew/.linuxbrew" ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"
fi

# Google Cloud SDK
if [ -f '/home/game/google-cloud-sdk/path.zsh.inc' ]; then
  . '/home/game/google-cloud-sdk/path.zsh.inc'
fi
if [ -f '/home/game/google-cloud-sdk/completion.zsh.inc' ]; then
  . '/home/game/google-cloud-sdk/completion.zsh.inc'
fi

# PNPM
export PNPM_HOME="/home/game/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# PM2 Completion
###-begin-pm2-completion-###
COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}
COMP_WORDBREAKS=${COMP_WORDBREAKS/@/}
export COMP_WORDBREAKS

if type complete &>/dev/null; then
  _pm2_completion () {
    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$COMP_CWORD" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           pm2 completion -- "${COMP_WORDS[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -o default -F _pm2_completion pm2
elif type compctl &>/dev/null; then
  _pm2_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       pm2 completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _pm2_completion + -f + pm2
fi
###-end-pm2-completion-###

# ============================================================
# 16. ZSHELL HISTORY SETTINGS
# ============================================================
export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000
setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_SPACE

# ============================================================
# 17. COMPLETION SETTINGS
# ============================================================
setopt MENU_COMPLETE
setopt AUTO_MENU
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:docker:*' option-stacking yes

# ============================================================
# 18. KEYBINDINGS
# ============================================================
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
bindkey '^[[3~' delete-char
bindkey '^[^?' backward-delete-word
bindkey '^[[1;3C' forward-word
bindkey '^[[1;3D' backward-word

# ============================================================
# 19. MISC SETTINGS & OPTIMIZATIONS
# ============================================================
# Disable auto-correct
unsetopt correct
unsetopt correct_all

# Enable extended globbing
setopt extendedglob

# Notify immediately when background jobs change
setopt NOTIFY


# AsyncAPI CLI Autocomplete

ASYNCAPI_AC_ZSH_SETUP_PATH=/home/game/.cache/@asyncapi/cli/autocomplete/zsh_setup; [[ -f $ASYNCAPI_AC_ZSH_SETUP_PATH ]] && source $ASYNCAPI_AC_ZSH_SETUP_PATH # asyncapi autocomplete setup


export PATH=$HOME/.local/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"

# bun completions
[ -s "/home/game/.bun/_bun" ] && source "/home/game/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# strix
export PATH=/home/game/.strix/bin:$PATH

. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"
export PATH="$HOME/.local/bin:$PATH"
