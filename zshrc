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
eval "$(pyenv init --path)"

plugins=(
    docker
    git
    vi-mode
    pip
    colored-man-pages
    command-not-found
    extract
    z
    zsh-autosuggestions
)


source $ZSH/oh-my-zsh.sh

bindkey "^K" up-line-or-search
bindkey "^J" down-line-or-search
bindkey '^ ' autosuggest-accept
autoload -U zranger
bindkey -s '^O' 'zranger^M'
alias pdfjoin="pdfjoin --paper a4paper --rotateoversize false"

alias tmux='tmux -u'
alias o='mimeopen'
alias e='emacsclient -nc'
alias ll='ls -lah'

export EDITOR="emacsclient -nc"

# python
export POETRY_VIRTUALENVS_PREFER_ACTIVE_PYTHON=true
export POETRY_VIRTUALENVS_CREATE=false
export PYENV_ROOT=$HOME/.pyenv
export PYTHON_KEYRING_BACKEND=keyring.backends.fail.Keyring
export PATH="$PYENV_ROOT/bin:$PATH"

if [ -n "$(which direnv)" ]; then
  eval "$(direnv hook $(basename $SHELL))"
fi

eval "$(starship init zsh)"

autoload -Uz compinit
zstyle ':completion:*' menu select
fpath+=~/.zfunc
