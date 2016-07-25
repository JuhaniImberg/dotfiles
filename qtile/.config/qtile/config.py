import glob
import subprocess

from libqtile.config import Key, Screen, Group, Drag, Click, Match
from libqtile.command import lazy
from libqtile import layout, bar, widget

mod = "mod4"

keys = [
    # MonadTall bindings

    Key([mod], "Down", lazy.layout.down()),
    Key([mod], "Up", lazy.layout.up()),
    Key([mod], "Left", lazy.layout.left()),
    Key([mod], "Right", lazy.layout.right()),

    Key([mod, "shift"], "Down", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "Left", lazy.layout.swap_left()),
    Key([mod, "shift"], "Right", lazy.layout.swap_right()),

    Key([mod, "shift", "control"], "Down", lazy.layout.normalize()),
    Key([mod, "shift", "control"], "Up", lazy.layout.maximize()),
    Key([mod, "shift", "control"], "Left", lazy.layout.shrink()),
    Key([mod, "shift", "control"], "Right", lazy.layout.grow()),

    Key([mod, "shift"], "space", lazy.layout.flip()),

    # Applications

    Key([mod], "Return", lazy.spawn("urxvt")),
    Key([mod], "l", lazy.spawn("i3lock -c 000000")),

    # Application management

    Key([mod, "shift"], "r", lazy.restart()),
    Key([mod, "shift"], "e", lazy.shutdown()),
    Key([mod, "shift"], "q", lazy.window.kill()),
    Key([mod], "d", lazy.spawncmd()),

    # Media keys

    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -D pulse sset Master 5%+")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -D pulse sset Master 5%-")),
    Key([], "XF86AudioMute", lazy.spawn("amixer -D pulse set Master 1+ toggle")),
    Key([], "XF86AudioMicMute", lazy.spawn("amixer -D pulse set Capture 1+ toggle")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("xbacklight -dec 10")),
    Key([], "XF86MonBrightnessUp", lazy.spawn("xbacklight -inc 10")),
]

groups = [Group(i) for i in "123456789"]

for ind, group in enumerate(groups):
    group_key = str(ind + 1)
    keys.extend([
        Key([mod], group_key, lazy.group[group.name].toscreen()),
        Key([mod, "shift"], group_key, lazy.window.togroup(group.name))
    ])

groups[6].matches = [Match(wm_class=["Firefox"])]


# https://github.com/chriskempson/base16-builder/blob/master/schemes/monokai.yml
theme = dict(
    base00="272822",
    base01="383830",
    base02="49483e",
    base03="75715e",
    base04="a59f85",
    base05="f8f8f2",
    base06="f5f4f1",
    base07="f9f8f5",
    base08="f92672",
    base09="fd971f",
    base0A="f4bf75",
    base0B="a6e22e",
    base0C="a1efe4",
    base0D="66d9ef",
    base0E="ae81ff",
    base0F="cc6633",
)

layouts = [
    layout.MonadTall(
        border_focus=theme["base0A"],
        border_normal=theme["base02"],
        border_width=2,
        margin=0,
        ratio=0.5,
    )
]

widget_defaults = dict(
    font='Terminus',
    fontsize=12,
    padding=1,
    margin_y=1,
    margin_x=1,
    foreground=theme["base07"],
    foreground_alert=theme["base08"]
)

graph_defaults = dict(
    width=48,
    border_width=0,
    margin_x=1,
    line_width=1
)

sep_defaults = dict(
    foreground=[theme["base02"], theme["base03"]],
    padding=16,
    linewidth=2,
    size_percent=100,
)

widgets = [
    widget.GroupBox(
        borderwidth=1,
        disable_drag=True,
        rounded=False,
        padding_x=3,
        highlight_method="line",
        active=theme["base07"],
        inactive=theme["base02"],
        this_current_screen_border=theme["base00"],
        highlight_color=[theme["base09"], theme["base0A"]],
        urgent_border=theme["base08"]
    ),
    widget.Spacer(length=5),
    widget.Prompt(
        cursor_color=theme["base04"],
        bell_style="visual",
        visual_bell_color=theme["base08"],
        padding=6
    ),
    widget.Spacer(length=5),
    widget.WindowName(),
    widget.Systray(),
    widget.Sep(**sep_defaults),
    widget.CPUGraph(
        type="linefill",
        graph_color=theme["base08"],
        fill_color=theme["base08"],
        **graph_defaults
    ),
    widget.Sep(**sep_defaults),
    widget.MemoryGraph(
        type="linefill",
        graph_color=theme["base0D"],
        fill_color=theme["base0D"],
        **graph_defaults
    ),
    widget.Sep(**sep_defaults),
    widget.Volume(
        foreground=theme["base0B"],
        padding=6,
        device='pulse'
    ),
]

has_battery = not not glob.glob("/sys/class/power_supply/BAT*")
if has_battery:
    widgets.extend([
        widget.Sep(**sep_defaults),
        widget.Battery(
            foreground=theme["base0E"],
            low_foreground=theme["base0E"],
            discharge_char='▼',
            charge_char='▲',
            padding=6
        ),
    ])

has_wlan = hasattr(widget, "Wlan")
if has_wlan:
    interface_name = None
    interface_raw = subprocess.check_output(["iwconfig"], universal_newlines=True)
    if interface_raw:
        interface_name = (interface_raw.split("\n")[0]).split(" ")[0]

    if interface_name:
        widgets.extend([
            widget.Sep(**sep_defaults),
            widget.Wlan(
                interface=interface_name,
                format='{essid} {percent:2.0%}',
                foreground=theme["base0F"]
            ),
        ])

widgets.extend([
    widget.Sep(**sep_defaults),
    widget.Clock(
        padding=6,
        format='%Y-%m-%d %H:%M:%S'
    )
])


screens = [
    Screen(
        bottom=bar.Bar(
            widgets=widgets,
            size=16,
            background=[theme["base00"], theme["base01"]]
        ),
    ),
]


mouse = []

dgroups_key_binder = None
dgroups_app_rules = []
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating()
auto_fullscreen = True

wmname = "LG3D"
