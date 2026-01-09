#!/bin/bash

# Author: Nate Cheney
# Filename: sync-dotfiles.sh
# Description: This script provides two sync methods (upload + download). 
# Usage: ./sync-dotfiles.sh
# Options:
# 	-h, --help Display this message and exit
# 	-d, --download Download config files from this repo to ~/.config
# 	-u, --upload Upload config files from ~/.config to this repo


usage() {
	cat << EOF
Usage: ./sync-dotfiles.sh

Options:
	-h, --help Display this message and exit
	-d, --download Download config files from this repo to ~/.config
	-u, --upload Upload config files from ~/.config to this repo

Examples:
	# Update system config files (download to system)
	./arch-dotfiles.sh -d

	# Update repo config files (upload to repo)
	./arch-dotfiles.sh -u
	
EOF
	exit 0
}

download() {
    for dir in "$@"; do
        rsync -av --delete \
            --exclude='*.cache' \
            --exclude='*.log' \
            --exclude='__pycache__/' \
            --exclude='.git/' \
            "./config/$dir/" "$HOME/.config/$dir/"
    done

    for file in "${files[@]}"; do
        echo "Syncing file: $file"
        rsync -av "./config/$file" "$HOME/.config/$file"
    done
}

upload() {
    for dir in "$@"; do
        rsync -av --delete \
            --exclude='*.cache' \
            --exclude='*.log' \
            --exclude='__pycache__/' \
            --exclude='.git/' \
            "$HOME/.config/$dir/" "./config/$dir/"
    done
    
    for file in "${files[@]}"; do
        echo "Syncing file: $file"
        rsync -av "$HOME/.config/$file" "./config/$file"
    done
}

# Ensure an argument was passed
if [ $# -eq 0 ]; then
	echo "Error: No options provided. Use the -h flag for help." >&2
	exit 1
fi

# Directories to watch
directories=("elephant" "hypr" "kitty" "nvim" "tmux" "uwsm" "walker" "waybar")

# Files to watch 
files=("starship.toml")

# Handle options
while getopts "hdu" opt; do
	case $opt in
		h)
			usage 
		;;
		d)
			download "${directories[@]}"
		;;
		u)
			upload "${directories[@]}"
		;;
		\?)
			echo "Invalid option: $OPTARG" >&2
			exit 1
		;;
	esac
done

