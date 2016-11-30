############################################
### setup colorscheme for gnome-terminal ###
############################################

terminalbg="#1d2021" #rgb(29,32,33)
terminalfg="#fbf1c7" #rgb(251,241,199)

bg="#282828"         #rgb(40,40,40)
red1="#9d0006"       #rgb(157,0,6)
green1="#79740e"     #rgb(121,116,14)
yellow1="#b57614"    #rgb(181,118,20)
blue1="#076678"      #rgb(7,102,120)
purple1="#8f3f71"    #rgb(143,63,113)
aqua1="#427b58"      #rgb(66,123,88)
gray1="#7c6f64"      #rgb(124,111,100)
gray2="#928374"      #rgb(146,131,116)
red2="#cc241d"       #rgb(204,36,29)
green2="#98971a"     #rgb(152,151,26)
yellow2="#d79921"    #rgb(215,153,33)
blue2="#458588"      #rgb(69,133,136)
purple2="#b16286"    #rgb(177,98,134)
aqua2="#8ec07c"      #rgb(142,192,124)
fg="#ebdbb2"         #rgb(235,219,178)

#get profileid and display the value of each key
profileid=`dconf list /org/gnome/terminal/legacy/profiles:/`
path="/org/gnome/terminal/legacy/profiles:/$profileid"
echo "\nprofileid = $profileid"
echo "path      = $path\n"
for i in `eval dconf list $path`; do
    value=$path$i
    echo "$i:"
    eval dconf read $value
    echo ""
done

#set terminal colorscheme

#foreground-color
foreground_color="'rgb(251,241,199)'"
foreground_path=$path"foreground-color"
#echo "dconf write $foreground_path $foreground_color"
eval dconf write $foreground_path \"$foreground_color\"

#background-color
background_color="'rgb(29,32,33)'"
background_path=$path"background-color"
#echo "dconf write $background_path $background_color"
eval dconf write $background_path \"$background_color\"

#palette
palette_color="['rgb(40,40,40)', 'rgb(157,0,6)', 'rgb(121,116,14)', 'rgb(181,118,20)', 'rgb(7,102,120)', 'rgb(143,63,113)', 'rgb(66,123,88)', 'rgb(124,111,100)', 'rgb(146,131,116)', 'rgb(204,36,29)', 'rgb(152,151,26)', 'rgb(215,153,33)', 'rgb(69,133,136)', 'rgb(177,98,134)', 'rgb(142,192,124)', 'rgb(235,219,178)']"
palette_path=$path"palette"
#echo "dconf write $palette_path $palette_color"
eval dconf write $palette_path \"$palette_color\"
