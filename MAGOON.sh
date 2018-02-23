#!/bin/bash

#dconf reset -f /org/gnome/terminal/legacy/profiles:/

####################################################
## source: https://github.com/NorthernTwig/Magoon ##
####################################################

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
background_color="'rgb(35,47,57)'"
cursor_background_color_value="'rgb(161,210,224)'"
cursor_foreground_color_value="'rgb(35,47,57)'"
foreground_color="'rgb(197,200,198)'"
palette_color="['rgb(35,47,57)', 'rgb(95,171,217)', 'rgb(109,198,228)', 'rgb(157,168,171)', 'rgb(161,209,157)', 'rgb(179,182,195)', 'rgb(161,210,224)', 'rgb(227,233,232)', 'rgb(109,198,228)', 'rgb(95,171,217)', 'rgb(109,198,228)', 'rgb(157,168,171)', 'rgb(161,209,157)', 'rgb(179,182,195)', 'rgb(161,210,224)', 'rgb(227,233,232)']"
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
font_value="'Knack Nerd Font 10'"
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
