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

setup_gpu_config() {
    config_file="$HOME/.config/uwsm/env-hyprland"

    # Safe Globbing for cards
    shopt -s nullglob
    cards=(/dev/dri/card*)
    shopt -u nullglob

    if [ ${#cards[@]} -eq 0 ]; then
        echo "Warning: No DRM devices found in /dev/dri/."
        return
    fi

    device_string=$(IFS=: ; echo "${cards[*]}")
    export_string="export AQ_DRM_DEVICES=\"$device_string\""

    if grep -q "^export AQ_DRM_DEVICES" $config_file 2>/dev/null; then
        sed -i "s|^export AQ_DRM_DEVICES=\".*\"|$export_string|" $config_file 
        echo "Updated GPU config in $config_file."
    else 
        echo $export_string >> $config_file
        echo "Added GPU config to $config_file."
    fi
}

sync_dotfiles() {
    source="$1"
    dest="$2"

    RSYNC_ARGS=(
        -av --delete 
        --exclude "*.bak*"
        --exclude "*.cache"
        --exclude "*.log"
        --exclude "__pycache__/"
        --exclude ".git/"
        --exclude "*env-hyprland"
    )

    for dir in "${DIRECTORIES[@]}"; do
        rsync "${RSYNC_ARGS[@]}" "$source/$dir/" "$dest/$dir/"
    done

    for file in "${FILES[@]}"; do
        rsync -av --delete "$source/$file" "$dest/$file"
    done

    if [ "$dest" == "$HOME_CONFIG_DIR" ]; then     
        # If downloading, update uwsm/env-hyprland
        echo "Running setup_gpu_config..."
        setup_gpu_config
    fi
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

