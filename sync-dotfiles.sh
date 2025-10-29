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
    local copied_files=0
    for dir in "$@"; do
        cp -ruv ./$dir ~/.config/$dir
        ((copied_files++))
    done
	
    echo "Download complete. Total files copied: $copied_files"
}

upload() {
    local copied_files=0
    for dir in "$@"; do
        cp -ruv ~/.config/$dir ./$dir
        ((copied_files++))
    done

	echo "Upload complete. Total files copied: $copied_files"
}

# Ensure an argument was passed
if [ $# -eq 0 ]; then
	echo "Error: No options provided. Use the -h flag for help." >&2
	exit 1
fi

# Directories to watch
directories=("elephant" "hypr" "kitty" "nvim" "uwsm" "walker" "wallpaper" "waybar" "wlogout" "wofi")

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

