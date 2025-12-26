import os
import subprocess
from libqtile import hook
from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from spotify import Spotify
@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~')
    subprocess.Popen([home + '/.config/qtile/autostart.sh'])


#funsion separadora
def fc_sep():
    return  widget.Sep(
                foreground=COLOR_FOREGROUND,
                background=COLOR_BACKGROUND,
                linewidth=0,
                padding=6,
            )
def make_spotify_widget():
    return Spotify(
        foreground=FONT_COLOR,
        background= COLOR_BACKGROUND,
        play_icon="",
        pause_icon="",
        font='UbuntuMono Nerd Font ',
        fontsize=13,
        max_chars=23,
        #format="{icon}{artist}-{track}"
        format="{icon}  {track}"
    )
#-----------------------------------------------------------------------------------------------
COLOR_ROJO = '#E64C66'  
COLOR_BLANCO = '#f1ffff'
COLOR_AZUL = '#2D3E50'
COLOR_VERDE = '#1CE400'
COLOR_HACKER = '#00FF41'
COLOR_NEGRO_HACKER = '#0D0208'
COLOR_TRASPARENTE = '#00000000'
COLOR_SPOTIFY = '#03A62C'
COLOR_NEGRO = '#040303'
#----------------------------------------------------------------------------------------------------
#COLORES PRINCIPALES
COLOR_FOREGROUND = [COLOR_HACKER, COLOR_HACKER]
COLOR_BACKGROUND = [COLOR_NEGRO_HACKER, COLOR_NEGRO_HACKER]
TRANSPARENTE = [COLOR_TRASPARENTE, COLOR_TRASPARENTE]
FONT_COLOR = [COLOR_BLANCO, COLOR_BLANCO]
SPOTIFY = [COLOR_SPOTIFY, COLOR_SPOTIFY]
#--------------------------------------------------------------------------------------------------------
Dispositivo_Red="wlan0"
mod = "mod4"
terminal = guess_terminal()
keys = [
    #cambio de patalla
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    #terminal
    Key([mod], "Return", lazy.spawn("lxterminal"), desc="Launch terminal"),
    #correr rofi
    Key([mod], "m", lazy.spawn("rofi -show drun")),
    Key([mod, "shift"], "m", lazy.spawn("rofi -show")),
    #Navegador
    Key([mod], "b", lazy.spawn("microsoft-edge-stable"), desc="Edge"),
    #Gestor de archivos
    Key([mod], "e", lazy.spawn("thunar")),
    #capturas de pantalla
    #Key([mod], "s", lazy.spawn("flameshot screen")),
    Key([mod, "shift"], "s", lazy.spawn("flameshot gui")),
    Key([mod], "v", lazy.spawn("xfce4-clipman-history")),
    #Dmemu
    Key([mod], "p", lazy.spawn("dmenu_run")),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    # Volume
    Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%")),
    Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")),
    # Brightness
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 5%-")),
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set +5%")),
    # Media Controls
    Key([], "XF86AudioNext", lazy.spawn("playerctl next"), desc="Skip to next"),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous"), desc="Skip to previous"),
    Key([], 'XF86AudioPlay', lazy.spawn('playerctl play-pause'), desc='Play/pause playback.'),
]
#Layouts 
#1.-navegador
#2.- terminal
#3.- Media
#4.- Spotify
#5.- Media
groups = [Group(i) for i in [" "," 󰇩 "," 󰙯 "," ","  "]]
for i, group in enumerate(groups):
    actual_key = str(i + 1)
    keys.extend([
        # Switch to workspace N
        Key([mod], actual_key, lazy.group[group.name].toscreen()),
        # Send window to workspace N
        Key([mod, "shift"], actual_key, lazy.window.togroup(group.name))
    ])
loyout_conf={
    'border_focus': COLOR_HACKER,
    'border_width': 1,
    'margin': 0
}
loyout_confXD={
    'border_focus': COLOR_HACKER
}
layouts = [
    layout.Columns(**loyout_conf),  #border_focus_stack="#E64C66", border_width=4),
    layout.Max(**loyout_conf),
    layout.Floating(
        border_focus="#E64C66"
    ),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    #layout.Bsp(),
    #layout.Matrix(),
    layout.MonadTall(**loyout_conf),
    #layout.MonadWide(),
    #layout.RatioTile(),
    #layout.Tile(),
    #layout.TreeTab(),
    #layout.VerticalTile(),
    #layout.Zoomy(),
]
widget_defaults = dict(
    font="UbuntuMono Nerd Font ",
    fontsize=17,
    padding=0,
)
extension_defaults = widget_defaults.copy()
  
screens = [
    Screen(
        top=bar.Bar(
            [
                widget.TextBox(
                    text="  ", 
                    foreground=COLOR_FOREGROUND,
                    background=TRANSPARENTE, 
                    fontsize=30, 
                    mouse_callbacks={"Button1" : lazy.spawn("rofi -show drun")}
                ),
                widget.TextBox(
                    text="",
                    foreground=COLOR_BACKGROUND,    
                    background=TRANSPARENTE,
                    fontsize=26,
                ),
                widget.CurrentLayoutIcon(
                    foreground=FONT_COLOR,
                    background=COLOR_BACKGROUND,
                    scale=0.65,
                ),
                fc_sep(),
                widget.TextBox(
                    text="",
                    foreground=COLOR_FOREGROUND,
                    background=COLOR_BACKGROUND,
                    fontsize=30,
                ),
                widget.Clock(
                    foreground=FONT_COLOR, 
                    background=COLOR_BACKGROUND,
                    font='UbuntuMono Nerd Font Bold',
                    fontsize=10,
                    #format=' %d/%m/%Y - %H:%M'
                    format=" %H:%M\n%d/%m/%Y"
                ),
                fc_sep(),
                widget.TextBox(
                    text="",
                    foreground=COLOR_FOREGROUND,
                    background=COLOR_BACKGROUND,
                    fontsize=30,
                ),
                widget.TextBox(
                    text="  ",
                    foreground=COLOR_FOREGROUND,
                    background=COLOR_BACKGROUND,
                    fontsize=23,
                    mouse_callbacks={"Button1":  lazy.spawn("pavucontrol")}
                ),
                #Volume(),
                widget.Volume(
                    foreground=FONT_COLOR,
                    background=COLOR_BACKGROUND,
                    limit_max_volume=True,
                    mouse_callbacks={"Button1":  lazy.spawn("pavucontrol")}
                ),
                widget.TextBox(
                    text="",
                    foreground=COLOR_FOREGROUND,
                    background=COLOR_BACKGROUND,
                    fontsize=30,
                ),
                widget.TextBox(
                    text="",
                    foreground=COLOR_SPOTIFY,
                    background=COLOR_BACKGROUND,
                    fontsize=20,
                ),
               
                fc_sep(),
#make_spotify_widget(),
                widget.TextBox(
                    text="",
                    foreground=COLOR_BACKGROUND,
                    background=TRANSPARENTE,
                    fontsize=26,
                ),
                widget.Spacer(length=bar.STRETCH),
                widget.TextBox(
                    text="",
                    foreground=COLOR_BACKGROUND,
                    background=TRANSPARENTE,
                    fontsize=30,
                ),
                widget.GroupBox(
                    foreground=FONT_COLOR, 
                    background=COLOR_BACKGROUND,
                    font='UbuntuMono Nerd Font',
                    fontsize=19,
                    margin_y=3,
                    margin_x=5,
                    padding_y=10,
                    padding_x=3,
                    borderwidth=4,
                    active=COLOR_FOREGROUND, #EL color de petana activa
                    inactive=FONT_COLOR, #EL color de petana inactiva
                    rounded=True,
                    highlight_method='line',
                    highlight_color="#00000000",
                    hide_unused=False,
                    urgent_alert_method='block',
                    urgent_border=["#F07178","#F07178"],
                    this_current_screen_border=COLOR_FOREGROUND, #borde de groupbox
                    other_screen_border=["#AEAEAE","#AEAEAE"],
                    disable_drag=True
                ),
                widget.TextBox(
                    text="",
                    foreground=COLOR_BACKGROUND, 
                    background=TRANSPARENTE,
                    fontsize=26,
                ),
                widget.Spacer(length=bar.STRETCH),
                #end on speed test conexion
                widget.TextBox(
                    text="",
                    foreground=COLOR_BACKGROUND,
                    background=TRANSPARENTE,
                    fontsize=30,
                ),
                fc_sep(),
                widget.TextBox(
                    text=" ",
                    foreground=FONT_COLOR,
                    background=COLOR_BACKGROUND,
                    fontsize=17,
                ),
                widget.Net(
                    foreground=FONT_COLOR,
                    background=COLOR_BACKGROUND,
                    fontsize=17,
                    format='{up}',
                    interface =Dispositivo_Red,
                    radius=4,
                    filled=True, 
                    #padding_y=2, 
                    #padding_x=7,
                    #use_bits= 'true'
                ),
                widget.TextBox(
                    text="",
                    foreground=COLOR_FOREGROUND,
                    background=COLOR_BACKGROUND,
                    fontsize=30,
                ),
                widget.TextBox(
                    text="󰇚",
                    foreground=FONT_COLOR,
                    background=COLOR_BACKGROUND,
                    fontsize=20,
                ),
                fc_sep(),
                widget.CheckUpdates(
                    background=COLOR_BACKGROUND,       
                    colour_have_updates=[COLOR_ROJO, COLOR_ROJO],
                    colour_no_updates=FONT_COLOR,
                    no_update_string='0',
                    display_format='{updates}',
                    update_interval=86400,
                    custom_command='checkupdates',
                 ),
                widget.TextBox(
                    text="",
                    foreground=COLOR_FOREGROUND,
                    background=COLOR_BACKGROUND,
                    fontsize=30,
                ),
                
                widget.TextBox(
                    text=" ",
                    foreground=FONT_COLOR,
                    background=COLOR_BACKGROUND,
                    fontsize=20,
                ),
                widget.ThermalSensor(
                    foreground=FONT_COLOR,
                    background=COLOR_BACKGROUND,
                    threshold= 60.0,
                    tag_sensor='Core 0'
                ),
                widget.TextBox(
                    text="",
                    foreground=COLOR_FOREGROUND,
                    background=COLOR_BACKGROUND,
                    fontsize=30,
                ),
                widget.TextBox(
                    text=" 󰗉",
                    foreground=FONT_COLOR,
                    background=COLOR_BACKGROUND,
                    fontsize=20,
                ),
                widget.Memory(
                    foreground=FONT_COLOR,
                    background=COLOR_BACKGROUND,
                    font='UbuntuMono Nerd Font',
                    fontsize=16,
                    measure_mem='G',
                    format="{MemUsed: .2f} GB"
                ),

                widget.TextBox(
                    text="",
                    foreground=COLOR_BACKGROUND,
                    background=TRANSPARENTE,#["#040303", "#040303"],
                    fontsize=30,
                ),
                 widget.Systray(),
                #widget.QuickExit(),
            ],
            30,
            border_width=[0, 0, 0, 0],  # Draw top and bottom borders
            #border_color=["#1BBC9B", "#000000", "#1BBC9B", "#000000"], # Borders are magenta
            background=TRANSPARENTE,
        ),
    ),
    Screen(
        top=bar.Bar(
            [
                #widget.TextBox(
                #    text="  ", 
                #    foreground=["#E64C66","#E64C66"],
                #    background=["#00000000","#00000000"],
                #    fontsize=30, 
                #    mouse_callbacks={"Button1" : lazy.spawn("rofi -show drun")}
                #    #mouse_callbacks={"Button1" : lazy.spawn("nwg-drawer &")}
                #),
                widget.TextBox(
                    text="",
                    foreground=["#2D3E50","#2D3E50"], 
                    background=["#00000000","#00000000"],
                    fontsize=26,
                ),
                widget.CurrentLayoutIcon(
                    foreground=["#f1ffff", "#f1ffff"],
                    background=["#2D3E50","#2D3E50"],
                    scale=0.65,
                ),
                fc_sep(),
                widget.TextBox(
                    text="",
                    foreground=["#E64C66","#E64C66"], 
                    background=["#2D3E50","#2D3E50"],
                    fontsize=26,
                ),
                widget.Clock(
                    foreground=["#f1ffff", "#f1ffff"],
                    background=["#2D3E50","#2D3E50"],
                    font='UbuntuMono Nerd Font Bold',
                    fontsize=15,
                    format=' %d/%m/%Y - %H:%M'
                ),
                widget.TextBox(
                    text="",
                    foreground=["#E64C66","#E64C66"], 
                    background=["#2D3E50","#2D3E50"],
                    fontsize=26,
                ),
                #fc_sep(),
                widget.TextBox(
                    text="",
                    foreground=["#2D3E50","#2D3E50"], 
                    background=["#00000000","#00000000"],
                    fontsize=26,
                ),
                widget.TextBox(
                    text="",
                    foreground=["#00000000","#00000000"], 
                    background=["#00000000","#00000000"],
                    fontsize=26,
                ),
                widget.Spacer(length=bar.STRETCH),
                widget.TextBox(
                    text="",
                    foreground=["#2D3E50","#2D3E50"],
                    background=["#00000000","#00000000"],
                    fontsize=30,
                ),
                widget.GroupBox(
                    foreground=["#f1ffff", "#f1ffff"],
                    background=["#2D3E50","#2D3E50"],
                    font='UbuntuMono Nerd Font',
                    fontsize=19,
                    margin_y=3,
                    margin_x=5,
                    padding_y=10,
                    padding_x=3,
                    borderwidth=4,
                    active=["#E64C66","#E64C66"], #EL color de petana activa
                    inactive=["#f1ffff", "#f1ffff"], #EL color de petana inactiva
                    rounded=True,
                    highlight_method='line',
                    highlight_color="#00000000", #color tranparente
                    hide_unused=False,
                    urgent_alert_method='block',
                    urgent_border=["#F07178","#F07178"],
                    #this_current_screen_border=["#E64C66","#E64C66"], #borde de groupbox
                    #other_screen_border=["#AEAEAE","#AEAEAE"],
                    this_screen_border=["#E64C66","#E64C66"],
                    other_current_screen_border=["#AEAEAE","#AEAEAE"],
                    disable_drag=True
                ),
                widget.TextBox(
                    text="",
                    foreground=["#2D3E50","#2D3E50"], 
                    background=["#00000000","#00000000"],
                    fontsize=26,
                ),
                widget.Spacer(length=bar.STRETCH),
                widget.TextBox(
                    text="",
                    foreground=["#2D3E50","#2D3E50"],
                    background=["#00000000","#00000000"],
                    fontsize=30,
                ),
                widget.TextBox(
                    text="",
                    foreground=["#E64C66","#E64C66"],
                    background=["#2D3E50","#2D3E50"],
                    fontsize=30,
                ),
                #end on speed test conexion
                widget.TextBox(
                    text=" ",
                    foreground=["#f1ffff","#f1ffff"], 
                    background=["#2D3E50","#2D3E50"],
                    fontsize=17,
                ),
                widget.Net(
                    foreground=["#f1ffff", "#f1ffff"],
                    background=["#2D3E50","#2D3E50"],
                    fontsize=17,
                    format='{up}',
                    interface =Dispositivo_Red,
                    radius=4,
                    filled=True, 
                    #padding_y=2, 
                    #padding_x=7,
                    #use_bits= 'true'
                ),
                widget.TextBox(
                    text="",
                    foreground=["#E64C66","#E64C66"],
                    background=["#2D3E50","#2D3E50"],
                    fontsize=30,
                ),
                
                widget.TextBox(
                    text=" ",
                    foreground=["#f1ffff", "#f1ffff"],
                    background=["#2D3E50","#2D3E50"],
                    fontsize=20,
                ),
                widget.ThermalSensor(
                    foreground=["#f1ffff", "#f1ffff"],
                    background=["#2D3E50","#2D3E50"],
                    threshold= 50.0,
                    tag_sensor='Core 0'

                ),
                fc_sep(),
                widget.TextBox(
                    text=" 󰗉",
                    foreground=["#f1ffff", "#f1ffff"],
                    background=["#2D3E50","#2D3E50"],
                    fontsize=20,
                ),
                widget.Memory(
                    foreground=["#f1ffff", "#f1ffff"],
                    background=["#2D3E50","#2D3E50"],
                    font='UbuntuMono Nerd Font',
                    fontsize=16,
                    measure_mem='G',
                    format="{MemUsed: .2f} GB"
                ),

                widget.TextBox(
                    text="",
                    foreground=["#2D3E50","#2D3E50"],
                    background=["#040303", "#040303"],
                    fontsize=30,
                ),
                #widget.QuickExit(),
            ],
            30,
            border_width=[0, 0, 0, 0],  # Draw top and bottom borders
            #border_color=["#1BBC9B", "#000000", "#1BBC9B", "#000000"], # Borders are magenta
            background=["#00000000","#00000000"],
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
