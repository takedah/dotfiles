#!/bin/bash
set -e
mkdir -p ~/.config/nvim ~/.config/mise ~/.claude ~/.codex ~/.gemini/antigravity-cli ~/.gemini/config ~/.local/bin
ln -sf ~/dotfiles/.bashrc ~/.bashrc
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.profile ~/.profile
ln -sf ~/dotfiles/.bash_profile ~/.bash_profile
ln -sf ~/dotfiles/.zprofile ~/.zprofile
ln -sf ~/dotfiles/.bash_aliases ~/.bash_aliases
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.flake8 ~/.flake8
ln -sf ~/dotfiles/.config/nvim/init.vim ~/.config/nvim/init.vim
ln -sf ~/dotfiles/.config/nvim/coc-settings.json ~/.config/nvim/coc-settings.json
ln -sf ~/dotfiles/.config/mise/config.toml ~/.config/mise/config.toml
git config --global core.excludesfile '~/dotfiles/.config/git/ignore'
ln -sf ~/dotfiles/.default-python-packages ~/.default-python-packages
ln -sf ~/dotfiles/.default-npm-packages ~/.default-npm-packages
ln -sf ~/dotfiles/.editorconfig ~/.editorconfig
ln -sf ~/dotfiles/.git-prompt.sh ~/.git-prompt.sh
ln -sf ~/dotfiles/.claude/settings.json ~/.claude/settings.json
ln -sf ~/dotfiles/.claude/settings-aws.json ~/.claude/settings-aws.json
ln -sf ~/dotfiles/.claude/settings-gh.json ~/.claude/settings-gh.json
ln -sf ~/dotfiles/.claude/CLAUDE.md ~/.claude/CLAUDE.md
ln -sf ~/dotfiles/.local/bin/claude-safe ~/.local/bin/claude-safe
ln -sf ~/dotfiles/.local/bin/claude-aws ~/.local/bin/claude-aws
ln -sf ~/dotfiles/.local/bin/claude-gh ~/.local/bin/claude-gh
ln -sf ~/dotfiles/.codex/AGENTS.md ~/.codex/AGENTS.md
ln -sf ~/dotfiles/.codex/aws.config.toml ~/.codex/aws.config.toml
ln -sf ~/dotfiles/.codex/gh.config.toml ~/.codex/gh.config.toml
ln -sf ~/dotfiles/.local/bin/codex-aws ~/.local/bin/codex-aws
ln -sf ~/dotfiles/.local/bin/codex-gh ~/.local/bin/codex-gh
ln -sf ~/dotfiles/.gemini/antigravity-cli/managed-settings.json ~/.gemini/antigravity-cli/managed-settings.json
ln -sf ~/dotfiles/.gemini/config/AGENTS.md ~/.gemini/config/AGENTS.md
ln -sf ~/dotfiles/.gemini/config/mcp_config.json ~/.gemini/config/mcp_config.json
ln -sf ~/dotfiles/.local/bin/agy-safe ~/.local/bin/agy-safe
