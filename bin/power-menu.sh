options="Shutdown\nReboot\nLock\nLogout"

num_lines=$(echo -e "$options" | wc -l)

action=$(echo -e "$options" | walker --dmenu -Nn --height "$num_lines")

case $action in
    "Shutdown")
        systemctl poweroff
    ;;

    "Reboot")
        systemctl reboot
    ;;

    "Lock")
        uwsm-app -- hyprlock
    ;;

    "Logout")
        hyprctl dispatch exit
    ;;
esac

