#!/bin/bash

#dconf reset -f /org/gnome/terminal/legacy/profiles:/

#########################################################################################
## source: https://raw.githubusercontent.com/elenapan/dotfiles/master/.xfiles/lovelace ##
#########################################################################################

path="/org/gnome/terminal/legacy/"
#echo "path      = $path"
#for i in $(eval dconf list $path); do
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

terminalbg:="#1D1F28"
terminalfg:="#FDFDFD"
cursorColor:="#C574DD"
color0:="#282A36"
color1:="#F37F97"
color2:="#5ADECD"
color3:="#F2A272"
color4:="#8897F4"
color5:="#C574DD"
color6:="#79E6F3"
color7:="#FDFDFD"
color8:="#414458"
color9:="#FF4971"
color10:="#18E3C8"
color11:="#FF8037"
color12:="#556FFF"
color13:="#B043D1"
color14:="#3FDCEE"
color15:="#BEBEC1"


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
background_color="'rgb(29,31,40)'"
cursor_background_color_value="'rgb(197,116,221)'"
cursor_foreground_color_value="'rgb(197,116,221)'"
foreground_color="'rgb(253,253,253)'"
palette_color="['rgb(40,42,54)', 'rgb(243,127,151)', 'rgb(90,222,205)', 'rgb(242,162,114)', 'rgb(136,151,244)', 'rgb(197,127,221)', 'rgb(121,230,243)', 'rgb(253,253,253)', 'rgb(65,68,88)', 'rgb(255,73,113)', 'rgb(24,227,200)', 'rgb(255,128,55)', 'rgb(85,111,255)', 'rgb(176,67,209)', 'rgb(63,220,238)', 'rgb(190,190,193)']"
eval dconf write "$path""background-color" \"$background_color\"
eval dconf write "$path""cursor-background-color" \"$cursor_background_color_value\"
eval dconf write "$path""cursor-foreground-color" \"$cursor_foreground_color_value\"
eval dconf write "$path""foreground-color" \"$foreground_color\"
eval dconf write "$path""palette" \"$palette_color\"

#############
## setting ##
#############
audible_bell_value="false"
bold_color_same_as_fg_value="true"
cursor_colors_set_value="true"
#font_value="'Hack Nerd Font Mono 10'"
font_value="'FiraCode Nerd Font 10'"
highlight_colors_set_value="false"
scroll_on_keystroke_value="false"
scroll_on_output_value="true"
scroll_policy_value="'never'"
scrollbar_policy_value="'never'"
use_system_colors_value="false"
use_system_font_value="false"
use_theme_colors_value="false"
use_transparent_background_value="false"
eval dconf write "$path""audible-bell" \"$audible_bell_value\"
eval dconf write "$path""bold-color-same-as-fg" \"$bold_color_same_as_fg_value\"
eval dconf write "$path""cursor-colors-set" \"$cursor_colors_set_value\"
eval dconf write "$path""font" \"$font_value\"
eval dconf write "$path""highlight-colors-set" \"$highlight_colors_set_value\"
eval dconf write "$path""scroll-on-keystroke" \"$scroll_on_keystroke_value\"
eval dconf write "$path""scroll-on-output" \"$scroll_on_output_value\"
eval dconf write "$path""scroll-policy" \"$scroll_policy_value\"
eval dconf write "$path""scrollbar-policy" \"$scrollbar_policy_value\"
eval dconf write "$path""use-system-colors" \"$use_system_colors_value\"
eval dconf write "$path""use-system-font" \"$use_system_font_value\"
eval dconf write "$path""use-theme-colors" \"$use_theme_colors_value\"
eval dconf write "$path""use-transparent-background" \"$use_transparent_background_value\"
