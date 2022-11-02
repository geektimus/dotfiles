# Qtile workspaces

from libqtile.config import Key, Group
from libqtile.command import lazy
from .keys import mod, keys


# Get the icons at https://www.nerdfonts.com/cheat-sheet (you need a Nerd Font)
# Icons:
# nf-fa-firefox,
# nf-fae-python,
# nf-dev-terminal,
# nf-fa-code,
# nf-oct-git_merge,
# nf-linux-docker,
# nf-mdi-image,
# nf-mdi-layers

# groups = [Group(i) for i in [
#     "   ", "   ", "   ", "   ", "  ", "   ", "   ", "   ", "   ",
# ]]
#
# for i, group in enumerate(groups):
#     actual_key = str(i + 1)
#     keys.extend([
#         # Switch to workspace N
#         Key([mod], actual_key, lazy.group[group.name].toscreen()),
#         # Send window to workspace N
#         Key([mod, "shift"], actual_key, lazy.window.togroup(group.name))
#     ])

groups = [Group(i) for i in [
  "dev", "www", "sys", "doc", "vbox", "chat", "mus", "vid", "gfx"
]]

for idx, group in enumerate(groups):
    actual_key = str(idx + 1)
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                actual_key,
                lazy.group[group.name].toscreen(),
                desc="Switch to group {}".format(group.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            #Key(
            #    [mod, "shift"],
            #    actual_key,
            #    lazy.window.togroup(group.name, switch_group=True),
            #    desc="Switch to & move focused window to group {}".format(group.name),
            #),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            Key(
                [mod, "shift"],
                actual_key,
                lazy.window.togroup(group.name),
                desc="move focused window to group {}".format(group.name)
            ),
        ]
    )
