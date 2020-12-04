if [[ "$(tty)" = "/dev/tty1" ]]; then
  pgrep bspwm || startx $XDG_CONFIG_HOME/X11/xinitrc
fi

eval "$(gh completion -s zsh)"
