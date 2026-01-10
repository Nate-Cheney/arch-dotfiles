#!/bin/bash

# Author: Nate Cheney
# Filename: sync-dotfiles.sh
# Description: This script provides two sync methods (upload + download). 
# Usage: ./sync-dotfiles.sh
# Options:
# 	-h, Display this message and exit
# 	-d, Download config files from this repo to ~/.config
# 	-u, Upload config files from ~/.config to this repo

# Directories and Files to watch
DIRECTORIES=("elephant" "hypr" "kitty" "nvim" "tmux" "uwsm" "walker" "waybar")
FILES=("starship.toml")

# Config directory paths
HOME_CONFIG_DIR="$HOME/.config" 
REPO_CONFIG_DIR="$HOME/.local/arch-dotfiles/config"

usage() {
	cat << EOF
Usage: ./sync-dotfiles.sh

Options:
	-h, Display this message and exit
	-d, Download config files from this repo to ~/.config
	-u, Upload config files from ~/.config to this repo

Examples:
	# Update system config files (download to system)
	./arch-dotfiles.sh -d

	# Update repo config files (upload to repo)
	./arch-dotfiles.sh -u
	
EOF
	exit 0
}

sync_dotfiles() {
    source="$1"
    dest="$2"

    for dir in "${DIRECTORIES[@]}"; do
        rsync -av --delete \
            --exclude='*.cache' \
            --exclude='*.log' \
            --exclude='__pycache__/' \
            --exclude='.git/' \
            "$source/$dir/" "$dest/$dir/"
    done

    for file in "${FILES[@]}"; do
        rsync -av --delete "$source/$file" "$dest/$file"
    done
}

# Ensure an argument was passed
if [ $# -eq 0 ]; then
	echo "Error: No options provided. Use the -h flag for help." >&2
	exit 1
fi

# Handle options
while getopts "hdu" opt; do
	case $opt in
		h)
			usage 
		;;
		d)
			sync_dotfiles "$REPO_CONFIG_DIR" "$HOME_CONFIG_DIR"
		;;
		u)
			sync_dotfiles "$HOME_CONFIG_DIR" "$REPO_CONFIG_DIR" 
		;;
		\?)
			echo "Invalid option: $OPTARG" >&2
			exit 1
		;;
	esac
done

