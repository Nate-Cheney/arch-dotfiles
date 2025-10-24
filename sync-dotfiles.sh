#!/bin/bash
#
# Author: Nate Cheney
# Filename: sync-dotfiles.sh
# Description: This script provides two sync methods (upload + download). 
# Usage: ./sync-dotfiles.sh
# Options:
# 	-h, --help Display this message and exit
# 	-d, --download Download config files from this repo to ~/.config
# 	-u, --upload Upload config files from ~/.config to this repo
#

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
	local copied_files
	copied_files=$( {
		# Hyprland
		cp -ruv ./config/hypr ~/.config/

		# Kitty
		cp -ruv ./config/kitty ~/.config/

		# Neovim
		cp -ruv ./config/nvim ~/.config/

		# Waybar
		cp -ruv ./config/waybar ~/.config/

		# WLogout
		cp -ruv ./config/wlogout ~/.config/

		# Wofi
		cp -ruv ./config/wofi ~/.config/
	} | tee /dev/tty | wc -l )
	echo "Download complete. Total files copied: $copied_files"
}

upload() {
	local copied_files
	copied_files=$( {
		# Hyprland
		cp -ruv ~/.config/hypr ./config/

		# Kitty
		cp -ruv ~/.config/kitty ./config/

		# Neovim
		cp -ruv ~/.config/nvim ./config/

		# Waybar
		cp -ruv ~/.config/waybar ./config/

		# WLogout
		cp -ruv ~/.config/wlogout ./config/

		# Wofi
		cp -ruv ~/.config/wofi ./config/
	} | tee /dev/tty | wc -l)
	echo "Download complete. Total files copied: $copied_files"
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
			download
		;;
		u)
			upload
		;;
		\?)
			echo "Invalid option: $OPTARG" >&2
			exit 1
		;;
	esac
done

