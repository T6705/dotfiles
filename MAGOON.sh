#dconf reset -f /org/gnome/terminal/legacy/profiles:/

####################################################
## source: https://github.com/NorthernTwig/Magoon ##
####################################################

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

foreground_color="'rgb(197,200,198)'"
foreground_path=$path"foreground-color"
eval dconf write $foreground_path \"$foreground_color\"

background_color="'rgb(35,47,57)'"
background_path=$path"background-color"
eval dconf write $background_path \"$background_color\"

palette_color="['rgb(35,47,57)', 'rgb(95,171,217)', 'rgb(109,198,228)', 'rgb(157,168,171)', 'rgb(161,209,157)', 'rgb(179,182,195)', 'rgb(161,210,224)', 'rgb(227,233,232)', 'rgb(109,198,228)', 'rgb(95,171,217)', 'rgb(109,198,228)', 'rgb(157,168,171)', 'rgb(161,209,157)', 'rgb(179,182,195)', 'rgb(161,210,224)', 'rgb(227,233,232)']"
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

font_value="'Knack Nerd Font 11'"
font_path=$path"font"
eval dconf write $font_path \"$font_value\"
