# include .profile if it exists
if [ -f ~/.profile ]; then
    . ~/.profile
fi

# include .bashrc if it exists
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi
