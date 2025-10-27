#!/usr/bin/zsh

# Set the XDG env variables
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

export GTK_THEME="Tokyonight-Dark"
export XCURSOR_THEME="BreezeX-RosePine-Linux"

export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.local/bin/scripts:$PATH

# Set the history file and settings
export HISTFILE=${ZDOTDIR}/zhistory
export HISTSIZE=10000
export SAVEHIST=10000

setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS

# start wayland session manager on login
if uwsm check may-start && uwsm select; then
  exec uwsm start default
fi

# Initialization of Powerlevel10k prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# Completion options
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no 
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
alias ff='clear && fastfetch'
alias vi='nvim'
alias fvpn='sudo openfortivpn -c /etc/openfortivpn/config'
alias jup='jupyter notebook > /dev/null 2>&1 &'
alias clisp='clisp -q'
alias cd='z'

# Shell Integrations
eval "$(fzf --zsh)"

# Keybinds
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Set the directory for zinit and plugins to go
ANTIDOTE="${ZDOTDIR:-${HOME}/.config/zsh}/.antidote"

# Download Antidote if it's not already there and source plugins
if [ ! -d "$ANTIDOTE" ]; then
  mkdir -p "$(dirname $ANTIDOTE)"
  git clone --depth=1 https://github.com/mattmc3/antidote.git "$ANTIDOTE"
fi

zsh_plugins=${ZDOTDIR:-$HOME}/.zsh_plugins
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
  (
    source "${ANTIDOTE}/antidote.zsh"
    antidote bundle <${zsh_plugins}.txt >${zsh_plugins}.zsh
  )  
fi
source ${zsh_plugins}.zsh

# Activate pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"


# Load completions. IDK why this has to be last but it doesn't work otherwise
autoload -U compinit && compinit

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh


eval "$(zoxide init zsh)"
