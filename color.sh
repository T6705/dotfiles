#!/bin/bash

#dconf reset -f /org/gnome/terminal/legacy/profiles:/

path="/org/gnome/terminal/legacy/"
#echo "path      = $path"
#for i in `eval dconf list $path`; do
#    echo "==========================================================="
#    value=$path$i
#    echo "$i:"
#    eval dconf read $value
#done

confirm_close_value="true"
default_show_menubar_value="false"
eval dconf write $path"confirm-close" \"$confirm_close_value\"
eval dconf write $path"default-show-menubar" \"$default_show_menubar_value\"

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
profileid=$(dconf list /org/gnome/terminal/legacy/profiles:/ | grep -E '^:')
path="/org/gnome/terminal/legacy/profiles:/$profileid"
echo "profileid = $profileid"
echo "path      = $path"
for i in $(eval dconf list "$path"); do
    echo "==========================================================="
    value=$path$i
    echo "$i:"
    eval dconf read "$value"
done

#################
## colorscheme ##
#################
background_color="'rgb(29,32,33)'"
foreground_color="'rgb(251,241,199)'"
palette_color="['rgb(40,40,40)', 'rgb(157,0,6)', 'rgb(121,116,14)', 'rgb(181,118,20)', 'rgb(7,102,120)', 'rgb(143,63,113)', 'rgb(66,123,88)', 'rgb(124,111,100)', 'rgb(146,131,116)', 'rgb(204,36,29)', 'rgb(152,151,26)', 'rgb(215,153,33)', 'rgb(69,133,136)', 'rgb(177,98,134)', 'rgb(142,192,124)', 'rgb(235,219,178)']"
eval dconf write "$path""background-color" \"$background_color\"
eval dconf write "$path""foreground-color" \"$foreground_color\"
eval dconf write "$path""palette" \"$palette_color\"

#############
## setting ##
#############
font_value="'Knack Nerd Font 10'"
scroll_on_keystroke_value="false"
scroll_on_output_value="true"
scroll_policy_value="'never'"
scrollbar_policy_value="'never'"
use_system_colors_value="false"
use_system_font_value="false"
use_theme_colors_value="false"
use_transparent_background_value="false"
eval dconf write "$path""font" \"$font_value\"
eval dconf write "$path""scroll-on-keystroke" \"$scroll_on_keystroke_value\"
eval dconf write "$path""scroll-on-output" \"$scroll_on_output_value\"
eval dconf write "$path""scroll-policy" \"$scroll_policy_value\"
eval dconf write "$path""scrollbar-policy" \"$scrollbar_policy_value\"
eval dconf write "$path""use-system-colors" \"$use_system_colors_value\"
eval dconf write "$path""use-system-font" \"$use_system_font_value\"
eval dconf write "$path""use-theme-colors" \"$use_theme_colors_value\"
eval dconf write "$path""use-transparent-background" \"$use_transparent_background_value\"
