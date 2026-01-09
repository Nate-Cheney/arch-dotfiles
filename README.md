Originally a simple repository to store my system's dotfiles.

## Goals

I want a lean, reproducible system, that just works.

I also want to learn; I switched to Linux specifially for that reason. Documenting and scripting the install process has been a phenomenal way to deepen my understanding of my own systems and Linux in general. 

## Overview

### Config

The config directory contains my system's dotfiles which can be synced using the `sync-dotfiles.sh` script. The sync script requires either the `-u` (upload) or `-d` (download) flag to be passed.

### Bin

The bin directory is currently in limbo between containing all of my system's scripts and old install scripts. I need to clean this directory up and add the remaining scripts to `~/.local/bin`.

### Install

The install directory contains the scripts for the entire install process. This process is ran by a master script (`install.sh`). See [docs/install.md](https://github.com/Nate-Cheney/arch-dotfiles/blob/main/docs/install.md) for more info.

## To Do

This repository is a work in progress. The following to-do list is not all encompassing.

*Install process*
- [ ] Improve the handling hardware differences
- [ ] Test on multiple systems

*Configuration*
- [ ] Move all custom scripts to `~/.local/bin` and update their references.
- [ ] Find a better solution for display management. 
- [ ] Find a better solution for wallpaper management.

