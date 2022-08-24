#!/bin/env bash

reload_bar() {

	# Terminate already running bar instances
	pkill polybar 

	# Wait until the processes have been shut down
	echo "Waiting for Polybar to shutdown"
	while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
	
	# Launch new instance
	echo "Launching New Instance"
	$HOME/.config/polybar/launch.sh --shapes > ~/.config/polybar/logs/polybar.log 2>&1 &
}

wal -i $(cat $HOME/.config/variety/wallpaper/wallpaper.jpg.txt)
$HOME/.local/bin/pywal_sublime.py
$HOME/.local/bin/update_polybar_pywal.sh
reload_bar
