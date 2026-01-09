#!/bin/bash

# Author: Nate Cheney
# Filename: install-neovim.sh
# Description: This script installs neovim 
# Usage: sudo ./install-neovim.sh
# Options:
#

package="neovim"


if ! pacman -Q $package &> /dev/null; then
    echo "Installing $package..."
    sudo pacman -S --noconfirm --needed $package
else 
    echo "$package is already installed."
fi

# -- Configure Neovim after install
PACKER_DIR="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"

# 1. Install packer.nvim if it doesn't exist
if [ ! -d "$PACKER_DIR" ]; then
  echo "Installing packer.nvim..."
  git clone --depth 1 https://github.com/wbthomason/packer.nvim "$PACKER_DIR"
  sleep 2
fi

# 2. Install neovim dotfiles if they don't exist
if [ ! -d "$HOME/Dev/neovim-dotfiles" ]; then
  echo "Cloning Neovim configuration..."
  git clone https://github.com/Nate-Cheney/neovim-dotfiles.git "$HOME/Dev/neovim-dotfiles"
  sleep 2
fi

# 3. Rsync dotfiles to .config/nvim
cd $HOME/Dev/neovim-dotfiles
./sync-dotfiles -d
sleep 2

# 4. Install and compile plugins (single pass)
echo "Installing plugins..."
nvim --headless --noplugin \
  -c 'packadd packer.nvim' \
  -c 'luafile ~/.config/nvim/lua/plugins.lua' \
  -c 'autocmd User PackerComplete quitall' \
  -c 'PackerSync' 2>/dev/null || true
sleep 3

echo "Setup complete."
