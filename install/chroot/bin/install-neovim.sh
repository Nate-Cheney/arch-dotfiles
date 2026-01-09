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
# 1. Install packer.nvim if it doesn't exist
PACKER_DIR="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
if [ ! -d "$PACKER_DIR" ]; then
  echo "Installing packer.nvim..."
  git clone --depth 1 https://github.com/wbthomason/packer.nvim "$PACKER_DIR"
  sleep 2
fi

# 2. Install neovim dotfiles if they don't exist
NVIM_TMP_DIR="/tmp/neovim-dotfiles"
if [ ! -d "$HOME/.config/nvim" ]; then
  echo "Cloning Neovim configuration..."
  git clone https://github.com/Nate-Cheney/neovim-dotfiles.git "$NVIM_TMP_DIR"
  sleep 2

  echo "Syncing Neovim dotfiles..."
  (cd $NVIM_TMP_DIR && ./sync-dotfiles.sh -d)
  sleep 2 

  echo "Cleaning Neovim tmp dir..."
  rm -rf $NVIM_TMP_DIR 
fi

# 3. Install and compile plugins
echo "Installing plugins..."

# First pass: Insall plugins via Packer
nvim --headless --noplugin \
  -c 'packadd packer.nvim' \
  -c 'luafile ~/.config/nvim/lua/plugins.lua' \
  -c 'autocmd User PackerComplete quitall' \
  -c 'PackerSync' 2>/dev/null || true

# Second pass: Compile Treesitter parsers
#echo "Compiling Treesitter parsers..."
#nvim --headless \
#  -c 'TSUpdateSync' \
#  -c 'q'

sleep 3
