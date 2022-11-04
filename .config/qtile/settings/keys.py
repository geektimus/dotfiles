# Qtile keybindings

from libqtile.config import EzKey as Key
from libqtile.command import lazy

mod = "mod4"

keys = [Key(key[0], *key[1:]) for key in [
    # ------------ Window Configs ------------

    # Switch between windows in current stack pane
    ("M-j", lazy.layout.down()),
    ("M-k", lazy.layout.up()),
    ("M-h", lazy.layout.left()),
    ("M-l", lazy.layout.right()),

    # Change window sizes (MonadTall)
    ("M-S-l", lazy.layout.grow()),
    ("M-S-h", lazy.layout.shrink()),

    # Toggle floating
    ("M-S-f", lazy.window.toggle_floating()),

    # Move windows up or down in current stack
    ("M-S-j", lazy.layout.shuffle_down()),
    ("M-S-k", lazy.layout.shuffle_up()),

    # Toggle between different layouts as defined below
    ("M-<Tab>", lazy.next_layout()),
    ("M-S-<Tab>", lazy.prev_layout()),

    # Kill window
    ("M-S-c", lazy.window.kill()),

    # Switch focus of monitors
    ("M-<period>", lazy.next_screen()),
    ("M-<comma>", lazy.prev_screen()),

    # Restart Qtile
    ("M-S-r", lazy.restart()),

    ("M-S-q", lazy.shutdown()),
    ("M-r", lazy.spawncmd()),

    # ------------ App Configs ------------

    # Menu
    ("M-m", lazy.spawn("rofi -show drun")),

    # Window Nav
    ("M-S-m", lazy.spawn("rofi -show")),

    # Browser
    ("M-b", lazy.spawn("google-chrome-stable")),

    # File Explorer
    ("M-e", lazy.spawn("thunar")),

    # Terminal
    ("M-<Return>", lazy.spawn("alacritty")),

    # Redshift
    ("M-r", lazy.spawn("redshift -O 2400")),
    ("M-S-r", lazy.spawn("redshift -x")),

    # Screenshot
    ("M-s", lazy.spawn("scrot")),
    ("M-S-s", lazy.spawn("scrot -s")),

    # Variety
    ("M-S-d", lazy.spawn("variety -t")),
    ("M-S-n", lazy.spawn("variety -n")),
    ("M-S-p", lazy.spawn("variety -p")),
    ("M-C-t", lazy.spawn("/home/geektimus/.local/bin/update_theme_from_wallpaper.sh")),

    # Utils
    ("M-z", lazy.spawn("Xephyr -br -ac -noreset -screen 1280x720 :1 &")),
    ("M-S-z", lazy.spawn("killall -KILL Xephyr")),

    # ------------ Hardware Configs ------------

    # Volume
    ("<XF86AudioLowerVolume>", lazy.spawn(
        "pactl set-sink-volume @DEFAULT_SINK@ -5%"
    )),
    ("<XF86AudioRaiseVolume>", lazy.spawn(
        "pactl set-sink-volume @DEFAULT_SINK@ +5%"
    )),
    ("<XF86AudioMute>", lazy.spawn(
        "pactl set-sink-mute @DEFAULT_SINK@ toggle"
    )),

    # Brightness
    ("<XF86MonBrightnessUp>", lazy.spawn("brightnessctl set +10%")),
    ("<XF86MonBrightnessDown>", lazy.spawn("brightnessctl set 10%-")),
]]
