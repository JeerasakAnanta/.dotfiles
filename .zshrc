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
# Aliases
# --------------------------------------------------------------------
alias zshconfig="nano ~/.zshrc"
alias ohmyzsh="nano ~/.oh-my-zsh"
alias update="sudo apt update && sudo apt full-upgrade -y"
alias startunnel="cloudflared tunnel --config /home/game/.cloudflared/config.yml run api-homelab"


# --------------------------------------------------------------------
# Powerlevel10k Config
# --------------------------------------------------------------------
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


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

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"
