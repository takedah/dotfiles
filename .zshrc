# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

alias ll='ls -al'
alias vi='nvim'
alias sudo='sudo -E '
alias python='python3'
alias pip='pip3'

# User Define PATH
export TERM=xterm-256color
export CLICOLOR=1

# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# poety
export PATH="$HOME/.local/bin:$PATH"

# nodejs
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# show git branch name
source ~/.git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
setopt PROMPT_SUBST ; PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)