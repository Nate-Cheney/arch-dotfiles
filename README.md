These are the dotfiles for some apps and services on my Arch Linux (btw) system.

## Login and Session Management

I use [SDDM](https://wiki.archlinux.org/title/SDDM) as a graphical login manager and [UWSM](https://wiki.archlinux.org/title/Universal_Wayland_Session_Manager) as a session manager.

The following session entry should be added to `/usr/share/wayland-sessions/hyprland-uwsm.desktop`.

``` /usr/share/wayland-sessions/hyprland-uwsm.desktop 
[Desktop Entry]
Name=Hyprland (uwsm-managed)
Comment=A UWSM-managed Hyprland session
TryExec=uwsm
Exec=uwsm start -- hyprland.desktop
DesktopNames=Hyprland
Type=Application
```

