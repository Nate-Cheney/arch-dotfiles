#!/bin/bash

# Author: Nate Cheney
# Filename: run-install-scripts.sh
# Description: This is the masters install script that will run all install-<pkg>.sh scripts. 
# Usage: ./run-install-scripts.sh
# Options:
#

sudo -v

for file in bin/install-*.sh; do
    if [ -f "$file" ]; then
        echo "Running: $file"
        bash "$file"
        
    fi
done

