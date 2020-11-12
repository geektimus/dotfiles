#!/usr/bin/env sh

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2

# polybar -c ~/.config/polybar/config.ini main &

# Launch a bar for each monitor

if command -v "xrandr" &> /dev/null; then
  SCREENS=$(xrandr --query | grep " connected" | wc -l)
  if [[ "$SCREENS" == "2" ]]; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
      if [[ "$m" == "HDMI-1" ]]; then
    	  MONITOR=$m polybar -c ~/.config/polybar/config.ini main &
      elif [[ "$m" == "eDP-1" ]]; then
    	  MONITOR=$m polybar -c ~/.config/polybar/config.ini secondary &
      fi
    done
  else
    MONITOR="eDP-1" polybar -c ~/.config/polybar/config.ini main &
  fi
else
  MONITOR="eDP-1" polybar -c ~/.config/polybar/config.ini main &
fi
