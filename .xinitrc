#!/bin/sh

# this file is run when calling startx

if [ -n "$DESKTOP_SESSION"  ];then
    for env_var in $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh 2>/dev/null); do
        # Exports GNOME_KEYRING_CONTROL and SSH_AUTH_SOCK
        export $env_var
     done
fi

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 > /tmp/polkit.xinitrc 2>&1 &

# default arch init scripts
if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
        [ -x "$f" ] && . "$f"
    done
fi

# user init scripts and settings
[ -r /etc/X11/xinit/.Xmodmap ] && xmodmap /etc/X11/xinit/.Xmodmap
[ -r ~/.Xmodmap ] && xmodmap ~/.Xmodmap
[ -r ~/.Xresources ] && xrdb -merge ~/.Xresources
[ -r ~/.xprofile ] && . ~/.xprofile

# lock the screen (no, i wont just use a display manager)
betterlockscreen -l blur &

# launch the session, commands below this line will be ignored
dbus-run-session xmonad