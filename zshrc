export PATH=$HOME/.local/bin:$HOME/bin:$HOME/.bin:/usr/bin/vendor_perl:$PATH
export FPATH=$HOME/.zsh_custom:$FPATH
export PYTHON_CONFIGURE_OPTS="--enable-shared"
export DISABLE_AUTO_UPDATE="true"

# zsh
export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$ZSH/custom
export ZSH_DISABLE_COMPFIX=true

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export VI_MODE_SET_CURSOR=true

plugins=(
    vi-mode
    zsh-autosuggestions
    fzf
)

source $ZSH/oh-my-zsh.sh

bindkey "^K" up-line-or-search
bindkey "^J" down-line-or-search
bindkey '^ ' autosuggest-accept
autoload -U zranger
bindkey -s '^O' 'lf^M'
alias pdfjoin="pdfjoin --paper a4paper --rotateoversize false"
alias cat="bat"
alias ls="eza"
alias ll="eza -lG --git"

alias tmux='tmux -u'
alias o='mimeopen'
alias e='emacsclient -nc'
alias ll='ls -lah'
alias go="grc go"
alias vim="nvim"

export EDITOR="emacsclient -nc"

# python
export POETRY_VIRTUALENVS_PREFER_ACTIVE_PYTHON=true
export POETRY_VIRTUALENVS_CREATE=false
export PYENV_ROOT=$HOME/.pyenv
export PYTHON_KEYRING_BACKEND=keyring.backends.fail.Keyring
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv virtualenv-init -)"
export GOPATH=~/Documents/go/


if [ -n "$(which direnv)" ]; then
  eval "$(direnv hook $(basename $SHELL))"
fi

eval "$(starship init zsh)"

autoload -Uz compinit
zstyle ':completion:*' menu select
fpath+=~/.zfunc
