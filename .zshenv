# General config location
# export XDG_CURRENT_DESKTOP=bspwm
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}

# qt themeing
export QT_QPA_PLATFORMTHEME=qt5ct

if [ -n "$DESKTOP_SESSION"  ];then
    for env_var in $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh 2>/dev/null); do
        # Exports GNOME_KEYRING_CONTROL and SSH_AUTH_SOCK
        export $env_var
     done
fi

export USERBIN=$HOME/.local/bin
export PATH=$PATH:$USERBIN

export HADOOP_HOME=/tmp/hadoop/

export GOPATH=$HOME/.go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# Javascript
export PATH=$HOME/.fnm:$PATH

# PyEnv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

. "$HOME/.cargo/env"
