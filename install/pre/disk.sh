#!/bin/bash

# Author: Nate Cheney
# Filename: disk.sh 
# Description: Prerequisite script that gets the name of the to be partitioned disk.
# Usage: ./disk.sh
# Options:
#

get_disk_paths() {
    local disk_name="$1"
    local disk_path="/dev/${disk_name}"

    local separator=""

    # If the disk name ends in a digit (like nvme0n1 or loop0), 
    # partitions need the 'p' (nvme0n1p1)
    if [[ "${disk_name: -1}" =~ [0-9] ]]; then
        separator="p"
    fi

    DISK="$disk_path"
    BOOT_PART="${disk_path}${separator}1"
    ROOT_PART="${disk_path}${separator}2"
}

# Gather disk info
readarray -t drive_list < <(lsblk -dn -o NAME,SIZE)

if [ ${#drive_list[@]} -eq 0 ]; then
    echo "No drives found. Exiting."
    exit 1
fi

# Check unattend.json
if [ -f "unattend.json" ]; then
    unattend_drive=$(jq -r ".drive" unattend.json)
    
    if printf '%s\n' "${drive_list[@]}" | grep -qx "^$unattend_drive "; then
        disk="$unattend_drive"
        echo "Found unattend_drive: $disk"
        get_disk_paths $disk
        ROOT_PART_UUID=$(blkid -s UUID -o value $ROOT_PART)  # UUID for bootloader 
        export DISK
        export BOOT_PART
        export ROOT_PART
        export ROOT_PART_UUID
        return
    fi
fi

# Manual selection 
echo "Select a disk to partition:"
PS3="Enter the number of your choice (or 'q' to quit): "
select choice in "${drive_list[@]}"; do
    if [[ -n "$choice" ]]; then
        disk=$(echo "$choice" | awk '{print $1}')  # Extract just the device name
        
        echo "You selected: $disk"
        read -p "Are you sure? (y/n) " confirm
        
        if [[ $confirm == [Yy]* ]]; then
            get_disk_paths $disk
            ROOT_PART_UUID=$(blkid -s UUID -o value $ROOT_PART)  # UUID for bootloader 
            export DISK
            export BOOT_PART
            export ROOT_PART
            export ROOT_PART_UUID
            break # Exit the select loop
        else
            echo "Selection cancelled. Choose again."
        fi
    elif [[ $REPLY == "q" ]]; then
        echo "Exiting..."
        exit 0
    else
        echo "Invalid selection. Pick a number from the list."
    fi
done

