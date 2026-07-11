alias ll='ls -al'
alias vi='nvim'
alias sudo='sudo -E '
alias python='python3'
alias pip='pip3'

export TERM=xterm-256color
export CLICOLOR=1

# pyenv
eval "$(pyenv init -)"

# nodejs (nvm)
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# show git branch name
source ~/.git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
setopt PROMPT_SUBST ; PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# mise
echo 'eval "$(mise activate zsh)"'