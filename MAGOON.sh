####################################################
## source: https://github.com/NorthernTwig/Magoon ##
####################################################

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
foreground_color="'rgb(197,200,198)'"
foreground_path=$path"foreground-color"
#echo "dconf write $foreground_path $foreground_color"
eval dconf write $foreground_path \"$foreground_color\"

#background-color
background_color="'rgb(35,47,57)'"
background_path=$path"background-color"
#echo "dconf write $background_path $background_color"
eval dconf write $background_path \"$background_color\"

#palette
palette_color="['rgb(35,47,57)', 'rgb(95,171,217)', 'rgb(109,198,228)', 'rgb(157,168,171)', 'rgb(161,209,157)', 'rgb(179,182,195)', 'rgb(161,210,224)', 'rgb(227,233,232)', 'rgb(109,198,228)', 'rgb(95,171,217)', 'rgb(109,198,228)', 'rgb(157,168,171)', 'rgb(161,209,157)', 'rgb(179,182,195)', 'rgb(161,210,224)', 'rgb(227,233,232)']"
palette_path=$path"palette"
#echo "dconf write $palette_path $palette_color"
eval dconf write $palette_path \"$palette_color\"
