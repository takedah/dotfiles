# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# mise (python, node)
# shims so non-interactive login shells resolve runtimes too;
# .zshrc runs `mise activate` for interactive shells.
export PATH="$HOME/.local/share/mise/shims:$PATH"

# uv tool install / poetry
export PATH="$HOME/.local/bin:$PATH"
