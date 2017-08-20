#dconf reset -f /org/gnome/terminal/legacy/profiles:/

####################################################################
## source: https://github.com/arcticicestudio/nord-gnome-terminal ##
####################################################################

terminalbg="#2E3440" #rgb(46,52,64)
terminalfg="#D8DEE9" #rgb(216,222,233)
color0="#3B4252"     #rgb(59,66,82)
color1="#BF616A"     #rgb(191,97,106)
color2="#A3BE8C"     #rgb(163,190,140)
color3="#EBCB8B"     #rgb(235,203,139)
color4="#81A1C1"     #rgb(129,161,193)
color5="#B48EAD"     #rgb(180,142,173)
color6="#88C0D0"     #rgb(136,192,208)
color7="#E5E9F0"     #rgb(229,233,240)
color8="#4C566A"     #rgb(76,86,106)
color9="#BF616A"     #rgb(191,97,106)
color10="#A3BE8C"    #rgb(163,190,140)
color11="#EBCB8B"    #rgb(235,203,139)
color12="#81A1C1"    #rgb(129,161,193)
color13="#B48EAD"    #rgb(180,142,173)
color14="#8FBCBB"    #rgb(143,188,187)
color15="#ECEFF4"    #rgb(236,239,244)

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

foreground_color="'rgb(216,222,233)'"
foreground_path=$path"foreground-color"
eval dconf write $foreground_path \"$foreground_color\"

background_color="'rgb(46,52,64)'"
background_path=$path"background-color"
eval dconf write $background_path \"$background_color\"

palette_color="['rgb(59,66,82)', 'rgb(191,97,106)', 'rgb(163,190,140)', 'rgb(235,203,139)', 'rgb(129,161,193)', 'rgb(180,142,173)', 'rgb(136,192,208)', 'rgb(229,233,240)', 'rgb(76,86,106)', 'rgb(191,97,106)', 'rgb(163,190,140)', 'rgb(235,203,139)', 'rgb(129,161,193)', 'rgb(180,142,173)', 'rgb(143,188,187)', 'rgb(236,239,244)']"
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
