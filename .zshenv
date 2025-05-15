# General config location
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}

if [ -n "$DESKTOP_SESSION"  ];then
    for env_var in $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh 2>/dev/null); do
        # Exports GNOME_KEYRING_CONTROL and SSH_AUTH_SOCK
        export $env_var
     done
fi

export USERBIN=$HOME/.local/bin
export PATH=$PATH:$USERBIN

export PATH=$HOME/.fnm:$PATH

. "$HOME/.cargo/env"
