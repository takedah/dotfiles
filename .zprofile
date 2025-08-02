# include .profile if it exists
#if [ -f ~/.profile ]; then
#    . ~/.profile
#fi

# include .zshrc if it exists
if [ -f ~/.zshrc ]; then
  . ~/.zshrc
fi