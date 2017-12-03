#dconf reset -f /org/gnome/terminal/legacy/profiles:/

####################################################################
## source: https://github.com/arcticicestudio/nord-gnome-terminal ##
####################################################################

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
profileid=`dconf list /org/gnome/terminal/legacy/profiles:/ | grep -E '^:'`
path="/org/gnome/terminal/legacy/profiles:/$profileid"
echo "profileid = $profileid"
echo "path      = $path"
for i in `eval dconf list $path`; do
    echo "==========================================================="
    value=$path$i
    echo "$i:"
    eval dconf read $value
done

#################
## colorscheme ##
#################
background_color="'rgb(46,52,64)'"
foreground_color="'rgb(216,222,233)'"
palette_color="['rgb(59,66,82)', 'rgb(191,97,106)', 'rgb(163,190,140)', 'rgb(235,203,139)', 'rgb(129,161,193)', 'rgb(180,142,173)', 'rgb(136,192,208)', 'rgb(229,233,240)', 'rgb(76,86,106)', 'rgb(191,97,106)', 'rgb(163,190,140)', 'rgb(235,203,139)', 'rgb(129,161,193)', 'rgb(180,142,173)', 'rgb(143,188,187)', 'rgb(236,239,244)']"
eval dconf write $path"background-color" \"$background_color\"
eval dconf write $path"foreground-color" \"$foreground_color\"
eval dconf write $path"palette" \"$palette_color\"

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
eval dconf write $path"font" \"$font_value\"
eval dconf write $path"scroll-on-keystroke" \"$scroll_on_keystroke_value\"
eval dconf write $path"scroll-on-output" \"$scroll_on_output_value\"
eval dconf write $path"scroll-policy" \"$scroll_policy_value\"
eval dconf write $path"scrollbar-policy" \"$scrollbar_policy_value\"
eval dconf write $path"use-system-colors" \"$use_system_colors_value\"
eval dconf write $path"use-system-font" \"$use_system_font_value\"
eval dconf write $path"use-theme-colors" \"$use_theme_colors_value\"
eval dconf write $path"use-transparent-background" \"$use_transparent_background_value\"
