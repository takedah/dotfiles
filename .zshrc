alias ll='ls -al'
alias vi='nvim'
alias sudo='sudo -E '
alias python='python3'
alias pip='pip3'

export CLICOLOR=1

# show git branch name
source ~/.git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
setopt PROMPT_SUBST ; PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# mise
eval "$(mise activate zsh)"