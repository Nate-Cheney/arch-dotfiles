options="App Launcher\nNetwork Manager\nPower Menu\nSound Manager"

num_lines=$(echo -e "$options" | wc -l)

action=$(echo -e "$options" | walker --dmenu -Nn --height "$num_lines")

case $action in
    "App Launcher")
        uwsm-app -- walker
    ;;

    "Network Manager")
        uwsm-app -- kitty -e impala
    ;;
    "Power Menu")
        uwsm-app -- power-menu.sh
    ;;
    "Sound Manager")
        uwsm-app -- kitty -e wiremix
    ;;
esac
