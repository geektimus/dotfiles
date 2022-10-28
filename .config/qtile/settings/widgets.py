from libqtile import widget
from .theme import colors

# Get the icons at https://www.nerdfonts.com/cheat-sheet (you need a Nerd Font)

def base(fg='foreground', bg='background'):
    return {
        'foreground': getattr(colors, fg),
        'background': getattr(colors, bg)
    }

def separator():
    return widget.Sep(**base(), linewidth=0, padding=5)

def icon(fg='foreground', bg='background', fontsize=26, text="?"):
    return widget.TextBox(
        **base(fg, bg),
        fontsize=fontsize,
        text=text,
        padding=2
    )

def workspaces():
    return [
        separator(),
        widget.GroupBox(
            **base(fg='foreground'),
            font='Iosevka Term',
            fontsize=12,
            margin_y=3,
            margin_x=0,
            padding_y=8,
            padding_x=5,
            borderwidth=1,
            active=colors.color1,
            inactive=colors.color2,
            rounded=False,
            highlight_method='line',
            #highlight_color=[colors.background, colors.foreground],
            urgent_alert_method='block',
            urgent_border=colors.color3,
            this_current_screen_border=colors.color4,
            this_screen_border=colors.color5,
            other_current_screen_border=colors.color6,
            other_screen_border=colors.color7,
            disable_drag=True
        ),
        separator(),
    ]

primary_widgets = [
    *workspaces(),
    widget.WindowName(**base(fg='color1'), fontsize=13, padding=5),
    separator(),
    icon(bg="color2", text=''), # Icon: nf-fa-download
    widget.CheckUpdates(
        background=colors.color2,
        colour_have_updates=colors.foreground,
        colour_no_updates=colors.foreground,
        no_update_string='0 ',
        display_format='{updates}',
        update_interval=1800,
        custom_command='checkupdates',
        format='{} '
    ),
    icon(bg="color3", text='ﯱ'),  # Icon: nf-fa-feed
    widget.Net(**base(bg='color3'), interface='enp0s3'),
    widget.CurrentLayoutIcon(**base(bg='color4'), scale=0.5),
    widget.CurrentLayout(**base(bg='color4'), padding=5),
    icon(bg="color5", text=''), # Icon: nf-mdi-calendar_clock
    widget.Clock(**base(bg='color5'), format='%d/%m/%Y - %H:%M '),
    icon(bg="color6", text=''),  # nf-fa-keyboard_o
    widget.KeyboardLayout(**base(bg='color6'), configured_keyboards=['es', 'us']),
    widget.Systray(**base(bg='color7'), padding=5),
]

widget_defaults = {
    'font': 'Iosevka Term Bold',
    'fontsize': 12,
    'padding': 1,
}
extension_defaults = widget_defaults.copy()
