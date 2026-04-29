# ======== ZSH Configuration ======= 
# editor: jeerasak 
# ==================================

# --------------------------------------------------------------------
# Powerlevel10k Instant Prompt (Should stay at top)
# --------------------------------------------------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# --------------------------------------------------------------------
# Oh-My-Zsh
# --------------------------------------------------------------------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"


# --------------------------------------------------------------------
# Plugins (optimized - fast load)
# --------------------------------------------------------------------
plugins=(
  git
  z
  zsh-autosuggestions
  zsh-syntax-highlighting
  docker
  docker-compose
)

source $ZSH/oh-my-zsh.sh


# --------------------------------------------------------------------
# Path
# --------------------------------------------------------------------
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"


# --------------------------------------------------------------------
# Aliases - System & Navigation
# --------------------------------------------------------------------
alias zshconfig="nano ~/.zshrc"
alias ohmyzsh="nano ~/.oh-my-zsh"
alias update="sudo apt update && sudo apt full-upgrade -y"
alias startunnel="cloudflared tunnel --config /home/game/.cloudflared/config.yml run api-homelab"

# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ~="cd ~"
alias cd..="cd .."
alias lsa="ls -lah"
alias la="ls -lA"
alias ll="ls -lh"

# Quick navigation
alias proj="cd ~/projects"
alias dotfiles="cd ~/.dotfiles"
alias config="cd ~/.config"

# File operations
alias mkdir="mkdir -pv"
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -iv"
alias mkfile="touch"

# Network
alias ping="ping -c 5"
alias ips="hostname -I"
alias ports="netstat -tulpn"

# Disk usage
alias du="du -h"
alias df="df -h"
alias ducks="du -sh * | sort -rh"

# Process management
alias pgrep="pgrep -l"
alias psa="ps aux"

# --------------------------------------------------------------------
# Aliases - Development & Git
# --------------------------------------------------------------------
# Git shortcuts
alias g="git"
alias ga="git add"
alias gaa="git add ."
alias gst="git status"
alias gc="git commit -m"
alias gca="git commit -am"
alias gp="git push"
alias gpl="git pull"
alias gb="git branch"
alias gco="git checkout"
alias gcb="git checkout -b"
alias glog="git log --oneline -n 20"
alias glogp="git log --oneline --graph --all"
alias gd="git diff"
alias gdw="git diff --word-diff"
alias gr="git reset"
alias grh="git reset --hard"
alias grm="git rm"
alias gm="git merge"
alias gf="git fetch"
alias gaa="git add --all"

# Node/NPM
alias ni="npm install"
alias nis="npm install --save"
alias nid="npm install --save-dev"
alias nun="npm uninstall"
alias nir="npm install && npm run"
alias nr="npm run"
alias nrd="npm run dev"
alias nrb="npm run build"
alias nrs="npm run start"
alias nrt="npm run test"
alias nrl="npm run lint"

# Docker
alias d="docker"
alias dc="docker compose"
alias dcup="docker compose up -d"
alias dcdown="docker compose down"
alias dcrm="docker compose rm -f"
alias dclogs="docker compose logs -f"
alias dps="docker ps"
alias dpsa="docker ps -a"
alias drm="docker rm"
alias drmi="docker rmi"

# Python
alias py="python3"
alias pip="pip3"
alias pir="pip install -r requirements.txt"
alias venv="python3 -m venv venv && source venv/bin/activate"

# Editors
alias vi="nvim"
alias vim="nvim"
alias nano="nano -c"

# Quick commands
alias c="clear"
alias h="history"
alias reload="exec zsh"
alias serve="python3 -m http.server 8000"
alias servepy="python3 -m http.server"

# Text processing
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"


# --------------------------------------------------------------------
# Powerlevel10k Config
# --------------------------------------------------------------------
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# --------------------------------------------------------------------
# Utility Functions - Navigation & Files
# --------------------------------------------------------------------
# Create directory and enter it
mkcd() {
  mkdir -pv "$1" && cd "$1"
}

# Find file/folder by name
ff() {
  find . -type f -name "*$1*" 2>/dev/null
}

fd() {
  find . -type d -name "*$1*" 2>/dev/null
}

# Search in files (like grep but easier)
search() {
  grep -r "$1" . --color=auto 2>/dev/null
}

# Quick bookmark - jump to last directory
bd() {
  cd - > /dev/null
}

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
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Quick backup
backup() {
  cp -r "$1" "${1}.backup.$(date +%s)"
}

# Count files in directory
countfiles() {
  find "${1:-.}" -type f | wc -l
}


# --------------------------------------------------------------------
# Utility Functions - Development
# --------------------------------------------------------------------
# Initialize new project
init_project() {
  local name="${1:-.}"
  mkdir -pv "$name"
  cd "$name"
  git init
  echo "# $name" > README.md
  git add README.md
  git commit -m "initial commit"
}

# Git utilities
git_branches_sorted() {
  git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname:short)'
}

git_latest() {
  git log -1 --oneline
}

# NPM/Node utilities
nv() {
  node --version
  npm --version
}

# Check if port is in use
port_check() {
  lsof -i :"$1" 2>/dev/null || echo "Port $1 is free"
}

# Kill process by port
kill_port() {
  lsof -ti:"$1" | xargs kill -9 2>/dev/null && echo "Killed process on port $1" || echo "No process on port $1"
}

# Docker utilities
docker_cleanup() {
  docker system prune -f && echo "Docker cleanup done"
}

docker_logs_tail() {
  docker logs -f --tail=50 "$1"
}

# Build and test
build() {
  if [ -f "Makefile" ]; then
    make
  elif [ -f "package.json" ]; then
    npm run build
  elif [ -f "setup.py" ]; then
    python3 setup.py build
  else
    echo "No build system detected"
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
    echo "No test runner detected"
  fi
}

# Development server
dev() {
  if [ -f "package.json" ]; then
    npm run dev
  elif [ -f "docker-compose.yml" ]; then
    docker compose up -d
  else
    echo "No dev environment detected"
  fi
}


# --------------------------------------------------------------------
# Utility Functions - System
# --------------------------------------------------------------------
# Directory size summary
size() {
  du -sh "${1:-.}" | sort -hr
}

# RAM usage
mem() {
  free -h
}

# CPU info
cpu() {
  lscpu | grep -E "Architecture|CPU op-mode|Byte Order|CPU\(s\)|On-line"
}

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

# Update dotfiles
dotfiles_update() {
  cd ~/.dotfiles
  git add -A
  git commit -m "update: dotfiles $(date +%Y-%m-%d)" || echo "Nothing to commit"
  cd -
}

# Monitor system
watch_system() {
  watch -n 1 'clear; echo "=== CPU ==="; top -bn1 | head -5; echo "=== Memory ==="; free -h'
}


# --------------------------------------------------------------------
# NVM Lazy Load (Fast | No Errors | Safe)
# --------------------------------------------------------------------
export NVM_DIR="$HOME/.nvm"

load_nvm() {
  unset -f node npm npx nvm
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
}

nvm()  { load_nvm; nvm "$@"; }
node() { load_nvm; node "$@"; }
npm()  { load_nvm; npm "$@"; }
npx()  { load_nvm; npx "$@"; }


# --------------------------------------------------------------------
# Pyenv (clean version, no duplicates)
# --------------------------------------------------------------------
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"


# --------------------------------------------------------------------
# Custom ENV Loader
# --------------------------------------------------------------------
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# opencode
export PATH=/home/game/.opencode/bin:$PATH

# Linuxbrew (lazy load for speed)
if [ -d "/home/linuxbrew/.linuxbrew" ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"
fi

# --------------------------------------------------------------------
# Performance Optimizations & Settings
# --------------------------------------------------------------------
# History settings for better recall
export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000
setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY

# Completion settings
setopt MENU_COMPLETE
setopt AUTO_MENU
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END

# Keybindings for better productivity
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
bindkey '^[[3~' delete-char
bindkey '^[^?' backward-delete-word

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Quick directory stack (Alt+Left/Right)
bindkey '^[[1;3C' forward-word
bindkey '^[[1;3D' backward-word
