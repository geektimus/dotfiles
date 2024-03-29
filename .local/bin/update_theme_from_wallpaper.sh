#!/bin/env bash

current_window_manager="$DESKTOP_SESSION"

ICON="dialog-information"

reload_polybar() {

	# Update config colors
	$HOME/.local/bin/update_polybar_pywal.sh
	echo "Polybar color updated"

	# Terminate already running bar instances
	pkill polybar
	sleep 5

	# Wait until the processes have been shut down
	echo "Waiting for polybar to shutdown"
	# while pgrep -u $UID -x polybar >/dev/null; echo "Waiting..."; do sleep 1; done

	STATUS=$(/usr/bin/pgrep -u $UID -x polybar | wc -l)
	while [ $STATUS -eq 1 ]; do
		echo "Waiting..."
		sleep 1
		STATUS=$(/usr/bin/pgrep -u $UID -x polybar | wc -l)
	done
	
	# Launch new instance
	$HOME/.config/polybar/launch.sh --shapes > ~/.config/polybar/logs/polybar.log 2>&1 &
	echo "New instance launched"
}

reload_dunst() {
	$HOME/.local/bin/update_dunst_pywal.sh
	pidof dunst > /dev/null && killall dunst
	/usr/bin/dunst > /dev/null 2>&1 &
}

reload_bspwm() {
	bspc wm -r
}

reload_xmobar() {
	 $HOME/.local/bin/update_xmobar_pywal.sh
	 $HOME/.local/bin/update_dmenu_pywal.sh
}

reload_xmonad() {
	xmonad --recompile && xmonad --restart
}

reload_qtile() {
	qtile cmd-obj -o cmd -f reload_config
	# qtile cmd-obj -o cmd -f restart
}

reload_window_manager() {

	if [[ "$current_window_manager" = "bspwm" ]]; then
		reload_polybar
		reload_bspwm
	elif [[ "$current_window_manager" = "xmonad" ]]; then
		reload_xmobar
		reload_xmonad
	elif [[ "$current_window_manager" = "qtile" ]]; then
        reload_qtile
	else
		echo "Warning: No window manager detected"
	fi

	reload_dunst
	show_notification $current_window_manager
}

show_notification() {
	notify-send -t 4000 -i "$ICON" "Status" "Update finished for $1"
}

wal -i $(cat $HOME/.config/variety/wallpaper/wallpaper.jpg.txt)
$HOME/.local/bin/update_sublime_pywal.py
reload_window_manager

