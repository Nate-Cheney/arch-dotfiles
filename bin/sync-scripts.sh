#!/bin/bash

# Author: Nate Cheney
# Filename: sync-scripts.sh 
# Description: 
#   
# Usage: ./sync-scripts.sh 
# Options:
# 	-h, Display this message and exit
# 	-d, Download config files from this repo to ~/.config
# 	-u, Upload config files from ~/.config to this repo


REPO_BIN_DIR="$HOME/.local/arch-dotfiles/bin/"
LOCAL_BIN_DIR="$HOME/.local/bin/"

usage() {
	cat << EOF
Usage: ./sync-scripts.sh

Options:
	-h, Display this message and exit
	-d, Download bin files from the config repo to ~/.local/bin
	-u, Upload config files from ~/.local/bin to the config repo

Examples:
	# Update system config files (download to system)
	./sync_scripts.sh -d

	# Update repo config files (upload to repo)
	./sync_scripts.sh -u
	
EOF

exit 0
}

sync_scripts() {
    source="$1"
    dest="$2"

    echo "Syncing from $source to $dest..."

    # Ensure destination exists
    mkdir -p "$dest"

    rsync -av --delete "$source" "$dest"
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
		    sync_scripts "$REPO_BIN_DIR" "$LOCAL_BIN_DIR"
		;;
		u)
		    sync_scripts "$LOCAL_BIN_DIR" "$REPO_BIN_DIR"
		;;
		\?)
			echo "Invalid option: $OPTARG" >&2
			exit 1
		;;
	esac
done


