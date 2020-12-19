selected=$(systemctl list-unit-files --no-pager --type=service --no-legend | env --unset=LD_PRELOAD LOCALE_ARCHIVE=$(env --unset=LD_PRELOAD nix-build '<nixpkgs>' -A glibcLocales)/lib/locale/locale-archive rofi -dmenu | awk '{print $1;}')

selected=$(echo $selected | awk '{print $1;}')

action=$(echo -e "start\nstop\nrestart" | env --unset=LD_PRELOAD LOCALE_ARCHIVE=$(env --unset=LD_PRELOAD nix-build '<nixpkgs>' -A glibcLocales)/lib/locale/locale-archive rofi -dmenu)

case "$action" in
    "start")
        sudo systemctl start $selected
        ;;
    "stop")
        sudo systemctl stop $selected
        ;;
    "restart")
        sudo systemctl restart $selected
        ;;
esac
