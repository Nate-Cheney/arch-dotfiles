#!/bin/bash

# Author: Nate Cheney
# Filename: configure-git.sh
# Description: Configures git globally 
# Usage: ./configure-git.sh
# Options:
#

# Set user info
git config --global user.name "Nate Cheney"
git config --global user.email natecheney@proton.me

# Set default editor
git config --global core.editor nvim

# Set autocorrect to automatically run commands
git config --global help.autocorrect 1

# Set rebase to false
git config --global pull.rebase false

