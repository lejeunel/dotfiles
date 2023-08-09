export PATH=$HOME/.local/bin:$HOME/bin:/usr/local/bin:$HOME/.bin:$HOME/.emacs.d/elpa/rtags-20180619.823/rtags-2.18/bin:$PATH
export FPATH=$HOME/.zsh_custom:$FPATH
export PYTHON_CONFIGURE_OPTS="--enable-shared"
export ZSH_DISABLE_COMPFIX=true
export DISABLE_AUTO_UPDATE="true"
export ZSH_CUSTOM=~/.zsh_custom/

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh


plugins=(
    docker
    git
    vi-mode
    pip
    colored-man-pages
    command-not-found
    extract
    z
    pyenv
    zsh-autosuggestions
)


source $ZSH/oh-my-zsh.sh

bindkey "^K" up-line-or-search
bindkey "^J" down-line-or-search
autoload -U zranger
bindkey -s '^O' 'zranger^M'
alias pdfjoin="pdfjoin --paper a4paper --rotateoversize false"

alias tmux='tmux -u'
alias o='mimeopen'
alias e='emacsclient -nc'
alias ll='ls -lah'

export EDITOR="vim"
export POETRY_VIRTUALENVS_PREFER_ACTIVE_PYTHON=true
export POETRY_VIRTUALENVS_CREATE=false

export PYENV_ROOT=$HOME/.pyenv
export PATH="$PYENV_ROOT/bin:$PATH"

if [ -n "$(which pyenv)" ]; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
  export PYENV_VIRTUALENV_DISABLE_PROMPT=1
fi

if [ -n "$(which direnv)" ]; then
  eval "$(direnv hook $(basename $SHELL))"
  # export DIRENV_WARN_TIMEOUT=100s
fi

eval "$(starship init zsh)"
