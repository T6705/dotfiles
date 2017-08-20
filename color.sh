#dconf reset -f /org/gnome/terminal/legacy/profiles:/

############################################
### setup colorscheme for gnome-terminal ###
############################################

terminalbg="#1d2021" #rgb(29,32,33)
terminalfg="#fbf1c7" #rgb(251,241,199)
color0="#282828"     #rgb(40,40,40)
color1="#9d0006"     #rgb(157,0,6)
color2="#79740e"     #rgb(121,116,14)
color3="#b57614"     #rgb(181,118,20)
color4="#076678"     #rgb(7,102,120)
color5="#8f3f71"     #rgb(143,63,113)
color6="#427b58"     #rgb(66,123,88)
color7="#7c6f64"     #rgb(124,111,100)
color8="#928374"     #rgb(146,131,116)
color9="#cc241d"     #rgb(204,36,29)
color10="#98971a"    #rgb(152,151,26)
color11="#d79921"    #rgb(215,153,33)
color12="#458588"    #rgb(69,133,136)
color13="#b16286"    #rgb(177,98,134)
color14="#8ec07c"    #rgb(142,192,124)
color15="#ebdbb2"    #rgb(235,219,178)

#get profileid and display the value of each key
profileid=`dconf list /org/gnome/terminal/legacy/profiles:/`
path="/org/gnome/terminal/legacy/profiles:/$profileid"
echo "profileid = $profileid"
echo "path      = $path"
for i in `eval dconf list $path`; do
    echo "==========================================================="
    echo ""
    value=$path$i
    echo "$i:"
    eval dconf read $value
    echo ""
done

#################
## colorscheme ##
#################

foreground_color="'rgb(251,241,199)'"
foreground_path=$path"foreground-color"
eval dconf write $foreground_path \"$foreground_color\"

background_color="'rgb(29,32,33)'"
background_path=$path"background-color"
eval dconf write $background_path \"$background_color\"

palette_color="['rgb(40,40,40)', 'rgb(157,0,6)', 'rgb(121,116,14)', 'rgb(181,118,20)', 'rgb(7,102,120)', 'rgb(143,63,113)', 'rgb(66,123,88)', 'rgb(124,111,100)', 'rgb(146,131,116)', 'rgb(204,36,29)', 'rgb(152,151,26)', 'rgb(215,153,33)', 'rgb(69,133,136)', 'rgb(177,98,134)', 'rgb(142,192,124)', 'rgb(235,219,178)']"
palette_path=$path"palette"
eval dconf write $palette_path \"$palette_color\"

#############
## setting ##
#############
scroll_on_output_value="true"
scroll_on_output_path=$path"scroll-on-output"
eval dconf write $scroll_on_output_path \"$scroll_on_output_value\"

scroll_on_keystroke_value="false"
scroll_on_keystroke_path=$path"scroll-on-keystroke"
eval dconf write $scroll_on_keystroke_path \"$scroll_on_keystroke_value\"

scroll_policy_value="'never'"
scroll_policy_path=$path"scroll-policy"
eval dconf write $scroll_policy_path \"$scroll_policy_value\"

scrollbar_policy_value="'never'"
scrollbar_policy_path=$path"scrollbar-policy"
eval dconf write $scrollbar_policy_path \"$scrollbar_policy_value\"

use_transparent_background_value="false"
use_transparent_background_path=$path"use-transparent-background"
eval dconf write $use_transparent_background_path \"$use_transparent_background_value\"

use_theme_colors_value="false"
use_theme_colors_path=$path"use-theme-colors"
eval dconf write $use_theme_colors_path \"$use_theme_colors_value\"

use_system_colors_value="false"
use_system_colors_path=$path"use-system-colors"
eval dconf write $use_system_colors_path \"$use_system_colors_value\"

use_system_font_value="false"
use_system_font_path=$path"use-system-font"
eval dconf write $use_system_font_path \"$use_system_font_value\"

font_value="'Knack Nerd Font 10'"
font_path=$path"font"
eval dconf write $font_path \"$font_value\"
