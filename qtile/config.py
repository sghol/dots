from subprocess import Popen
import os

from libqtile import bar, hook, layout, qtile, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile import hook

# ---------------
#   Bindings
# ---------------
# Modifiers
SUPER = "mod4"

# shortcut set
WIN = ["mod4"]
ALT = ["mod1"]
WIN_SHT = ["mod4", "shift"]
WIN_CTRL = ["mod4", "control"]

HOME = os.environ.get("HOME")
TERMINAL = os.environ.get("TERMINAL")
BROWSER = os.environ.get("BROWSER")
FILEMANAGER = os.environ.get("FILEMANAGER")
VIDEOEDITOR = os.environ.get("VIDEOEDITOR")
AUTOSTART_PATH = f"{HOME}/.local/bin/autostart"


def navigate_floating(qtile):
    qtile.current_group.next_window()
    qtile.current_window.bring_to_front()


# Keyboard bindings
keys = [
    # Window focus
    Key(WIN, "h", lazy.layout.left()),
    Key(WIN, "l", lazy.layout.right()),
    Key(WIN, "j", lazy.layout.down()),
    Key(WIN, "k", lazy.layout.up()),
    Key(WIN, "space", lazy.layout.next()),
    Key(WIN_SHT, "n", lazy.layout.normalize()),
    Key(WIN_SHT, "space", lazy.layout.swap_column_left()),
    Key(ALT, "tab", lazy.function(navigate_floating)),
    # Move window position
    Key(WIN_SHT, "h", lazy.layout.shuffle_left()),
    Key(WIN_SHT, "l", lazy.layout.shuffle_right()),
    Key(WIN_SHT, "k", lazy.layout.shuffle_up()),
    Key(WIN_SHT, "j", lazy.layout.shuffle_down()),
    Key(WIN_SHT, "Return", lazy.layout.toggle_split()),
    # Grow window
    Key(WIN, "comma", lazy.layout.grow_left()),
    Key(WIN, "period", lazy.layout.grow_right()),
    Key(WIN_SHT, "comma", lazy.layout.grow_down()),
    Key(WIN_SHT, "period", lazy.layout.grow_up()),
    # Qtile specific
    Key(WIN, "r", lazy.reload_config()),
    Key(WIN_SHT, "r", lazy.restart()),
    Key(WIN_SHT, "q", lazy.shutdown()),
    # Run specific program
    Key(WIN, "Return", lazy.spawn(TERMINAL)),
    Key(WIN, "p", lazy.spawn("launcher")),
    Key(WIN, "Print", lazy.spawn("shot")),
    Key(WIN, "b", lazy.spawn(BROWSER)),
    Key(WIN, "e", lazy.spawn(FILEMANAGER)),
    Key(WIN_SHT, "e", lazy.spawn(VIDEOEDITOR)),
    Key(
        ALT,
        "shift_l",
        lazy.widget["keyboardlayout"].next_keyboard(),
    ),
    # Window command
    Key(WIN, "q", lazy.window.kill()),
    Key(WIN, "f", lazy.window.toggle_floating()),
    Key(WIN_SHT, "f", lazy.window.toggle_fullscreen()),
    Key(WIN_SHT, "m", lazy.window.toggle_maximize()),
    Key(WIN_SHT, "s", lazy.window.toggle_sticky()),
    # Screen specific
    Key(WIN_SHT, "b", lazy.hide_show_bar()),
    # Layout specific
    Key(WIN, "grave", lazy.next_layout()),
    Key(WIN_SHT, "grave", lazy.prev_layout()),
    Key(WIN, "m", lazy.group.setlayout("max")),
    Key(WIN, "c", lazy.group.setlayout("columns")),
    # Group (workspace)
    Key(WIN, "bracketright", lazy.screen.next_group(skip_empty=True)),
    Key(WIN, "bracketleft", lazy.screen.prev_group(skip_empty=True)),
    Key(WIN, "Tab", lazy.screen.toggle_group()),
    Key(WIN, "1", lazy.group["1"].toscreen()),
    Key(WIN, "2", lazy.group["2"].toscreen()),
    Key(WIN, "3", lazy.group["3"].toscreen()),
    Key(WIN, "9", lazy.group["9"].toscreen()),
    Key(WIN, "0", lazy.group["0"].toscreen()),
    Key(WIN_SHT, "1", lazy.window.togroup("1", switch_group=False)),
    Key(WIN_SHT, "2", lazy.window.togroup("2", switch_group=False)),
    Key(WIN_SHT, "3", lazy.window.togroup("3", switch_group=False)),
    Key(WIN_SHT, "9", lazy.window.togroup("9", switch_group=False)),
    Key(WIN_SHT, "0", lazy.window.togroup("0", switch_group=False)),
]

# Mouse bindings
mouse = [
    Drag(
        WIN,
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        WIN,
        "Button3",
        lazy.window.set_size_floating(),
        start=lazy.window.get_size(),
    ),
    Click(WIN, "Button1", lazy.window.bring_to_front()),
]

# ---------------
#   Core
# ---------------

color = {
    "bg": "#000000",
    "alt_bg": "#2c2e33",
    "fg": "#E0E2EA",
    "active": "#EEF1F8",
    "inactive": "#9b9ea4",
    "primary": "#b4f6c0",
    "secondary": "#FCE094",
}

# ------------------
#     GROUP
# ------------------
# keyword arguments for `python` scratchpad
groups = [Group(name=name, label=name) for name in ["1", "2", "3", "9", "0"]]


# ------------------
#     LAYOUTS
# ------------------
layout_config = dict(
    border_focus=color.get("primary", "#ff000"),
    border_normal=color.get("bg", "#ff0000"),
    border_focus_stack=color.get("secondary", "#ff0000"),
    border_normal_stack=color.get("bg", "#ff0000"),
)

layouts = [
    layout.Max(**layout_config),
    layout.Columns(**layout_config),
]

# ---------------------
#    Floating Layout
# ---------------------
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="Tk"),  # tkinter
        Match(wm_class="vlc"),  # VLC media player
        Match(wm_class="simplescreenrecorder"),  # VLC media player
        Match(wm_class="pavucontrol"),  # VLC media player
        Match(wm_class="main.py"),  # Pygame zero
        Match(wm_class="xarchiver"),  # tkinter
        Match(wm_class="Toplevel"),  # tkinter toplevel window
        Match(wm_class="Places"),  # Firefox download window
        Match(wm_class="notification"),
        Match(wm_class="Dunst"),
        Match(wm_class="ffplay"),
        Match(wm_class="hiddify"),
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        Match(title="Blueman-manager"),  # GPG key password entry
        Match(title="flet"),
        Match(title="stab"),
    ],
    **layout_config,
)


# ---------------------
#    SCREEN WIDGETS
# ---------------------
def sep(bg=color.get("bg"), pad=1):
    return widget.Sep(background=bg, padding=pad, linewidth=0)


bar_widgets = [
    widget.GroupBox(
        highlight_method="block",
        background=color.get("alt_bg", "#ff0000"),
        active=color.get("active", "#ff0000"),
        inactive=color.get("inactive", "#ff0000"),
        this_current_screen_border=color.get("primary", "#ff0000"),
        block_highlight_text_color=color.get("bg", "#ff0000"),
        padding_x=5,
        padding_y=2,
    ),
    sep(),
    widget.CurrentLayout(
        background=color.get("alt_bg", "#ff0000"),
        foreground=color.get("fg", "#ff0000"),
        padding=10,
    ),
    sep(),
    widget.WindowCount(
        background=color.get("alt_bg", "#ff0000"),
        foreground=color.get("fg", "#ff0000"),
    ),
    widget.WindowName(
        foreground=color.get("fg", "#ff0000"),
    ),
    widget.Spacer(),
    widget.CheckUpdates(
        background=color.get("alt_bg", "#ff0000"),
        foreground=color.get("fg", "#ff0000"),
        colour_have_updates=color.get("fg", "#ff0000"),
        colour_no_updates=color.get("fg", "#ff0000"),
        no_update_string="",
    ),
    sep(),
    widget.Pomodoro(
        background=color.get("alt_bg", "#ff0000"),
        foreground=color.get("fg", "#ff0000"),
        color_active=color.get("active", "#ff0000"),
        color_inactive=color.get("fg", "#ff0000"),
        color_break=color.get("active", "#ff0000"),
        length_pomodori=55,
        length_short_break=5,
        length_long_break=5,
        prefix_inactive="POMO",
    ),
    sep(),
    widget.Wlan(
        interface="wlan0",
        format="{essid}",
        background=color.get("alt_bg", "#ff0000"),
        foreground=color.get("fg", "#ff0000"),
    ),
    sep(bg=color.get("bg", "#ff0000"), pad=0),
    widget.Net(
        prefix="k",
        background=color.get("alt_bg", "#ff0000"),
        foreground=color.get("fg", "#ff0000"),
        padding=10,
        format="{down:1.2f}{down_suffix} ↓↑ {up:1.2f}{up_suffix}",
    ),
    sep(),
    widget.KeyboardLayout(
        background=color.get("alt_bg", "#ff0000"),
        foreground=color.get("fg", "#ff0000"),
        configured_keyboards=["us", "ir"],
        padding=10,
    ),
    sep(),
    widget.Volume(
        background=color.get("alt_bg", "#ff0000"),
        foreground=color.get("fg", "#ff0000"),
        padding=10,
    ),
    sep(),
    widget.Clock(
        background=color.get("alt_bg", "#ff0000"),
        foreground=color.get("fg", "#ff0000"),
        format="%m-%d | %H:%M",
        padding=10,
    ),
    sep(),
    widget.Systray(
        background=color.get("alt_bg", "#ff0000"),
    ),
]

# Bars
bar_widgets = bar_widgets.copy()
bar = bar.Bar(
    bar_widgets,
    border_width=3,
    border_color=color["bg"],
    background=color.get("bg"),
    size=20,
    opacity=1,
    margin=[0, 0, 0, 0],
)

# Screens
screen = Screen(top=bar)
screens = [screen]

# ---------------
# Defult settings
# ---------------
dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = True
bring_front_click = True
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True
wl_input_rules = None
wmname = "Qtile"


# ---------------
# Hooks
# ---------------
@hook.subscribe.float_change
def float_change():
    window = qtile.current_window
    is_maximized = window.info().get("maximized")
    if not is_maximized:
        window.center()


@hook.subscribe.client_new
def float_centerize(window):
    window.center()


@hook.subscribe.startup_once
def autostart():
    Popen([AUTOSTART_PATH])
