if [[ "$(tty)" = "/dev/tty1" ]]; then
  pgrep bspwm || startx $HOME/xinitrc
  echo "Welcome $USER"
fi

eval "$(gh completion -s zsh)"
