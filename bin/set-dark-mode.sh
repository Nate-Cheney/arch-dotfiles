#!/bin/bash

# Author: Nate Cheney
# Filename: set-dark-mode.sh
# Description: Sets system to dark mode 
# Usage: ./set-dark-mode.sh
# Options:
#

gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
