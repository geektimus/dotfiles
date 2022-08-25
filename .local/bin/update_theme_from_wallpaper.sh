#!/bin/env bash

current_window_manager="$DESKTOP_SESSION"

echo $DESKTOP_SESSION

reload_polybar() {

	# Update config colors
	$HOME/.local/bin/update_polybar_pywal.sh

	# Terminate already running bar instances
	pkill polybar 

	# Wait until the processes have been shut down
	while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
	
	# Launch new instance
	$HOME/.config/polybar/launch.sh --shapes > ~/.config/polybar/logs/polybar.log 2>&1 &
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

reload_window_manager() {

	if [[ "$current_window_manager" = "bspwm" ]]; then
		reload_polybar
		reload_bspwm
	elif [[ "$current_window_manager" = "xmonad" ]]; then
		reload_xmobar
		reload_xmonad
	else
		echo "Warning: No window manager detected"
	fi
}

wal -i $(cat $HOME/.config/variety/wallpaper/wallpaper.jpg.txt)
$HOME/.local/bin/update_sublime_pywal.py
reload_window_manager
