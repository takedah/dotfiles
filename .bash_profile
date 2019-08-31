# include .bashrc if it exists
if [ -f "$HOME/.bashrc" ]; then
  . "$HOME/.bashrc"
fi

# include .bashrc if it exists
if [ -f "$HOME/.bash_aliases" ]; then
  . "$HOME/.bash_aliases"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi

# User Define PATH
export TERM=xterm-256color
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
