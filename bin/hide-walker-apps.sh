#!/bin/bash

# Author: Nate Cheney
# Filename: hide-walker-apps.sh
# Description: This script copies desktop files from `/usr/share/applications/` to `~/.local/share/applications/` so that they can be hidden from walker.
# Usage: ./hide-walker-apps.sh
# Options:
#

LOCAL_APPS="$HOME/.local/share/applications/"
USR_APPS="/usr/share/applications/"

if [ ! -d $LOCAL_APPS ]; then
    mkdir -p $LOCAL_APPS
fi
    
APPS=(
    "avahi-discover.desktop"
    "bssh.desktop"
    "bvnc.desktop"
    "electron37.desktop"
    "lstopo.desktop" 
    "qv4l2.desktop"
    "qvidcap.desktop"
    "uuctl.desktop"
    "winetricks.desktop"
    "xgps.desktop" 
    "xgpsspeed.desktop"
)

for app in ${APPS[@]}; do
    src_file="$USR_APPS/$app"
    dest_file="$LOCAL_APPS/$app"

    # Copy apps from usr to .local
    if [ ! -f "$src_file" ]; then
        echo "$app not found in $USR_APPS. Skipping..."

    fi

    if [ ! -f "$dest_file" ]; then
        echo "Copying $app to $LOCAL_APPS..."
        cp "$src_file" "$LOCAL_APPS"
    else
        echo "$app already in $LOCAL_APPS."
    fi

    # Set NoDisplay=true
    if [ ! -f "$dest_file" ]; then
        continue
    fi

    if grep -q "^NoDisplay=true" "$dest_file"; then
        echo "$app is already set as hidden."
    elif grep -q "^NoDisplay=" "$dest_file"; then
        echo "Changing NoDisplay to true for $app..."
        sed -i "s/NoDisplay=.*/NoDisplay=true/g" "$dest_file"
    else
        echo "Setting NoDisplay to true for $app..."
        echo "NoDisplay=true" >> "$dest_file"
    fi
done

echo "Updating desktop databases..."
update-desktop-database "$LOCAL_APPS"

