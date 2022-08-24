export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

eval "$(gh completion -s zsh)"

if [[ "$(tty)" = "/dev/tty1" ]]; then
  pgrep bspwm || startx $HOME/.xinitrc
  echo "Welcome $USER"
fi

