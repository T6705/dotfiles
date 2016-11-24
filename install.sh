#########
## zsh ##
#########

sudo apt-get install zsh tmux xclip xsel npm vim vim-athena vim-gnome vim-gtk vim-nox -y

echo "========================="
echo "== Download zsh config =="
echo "========================="

curl https://raw.githubusercontent.com/T6705/dotfile/master/.zshrc > ~/.zshrc

##########
## tmux ##
##########

echo "=================================="
echo "== Download Tmux Plugin Manager =="
echo "=================================="

sudo rm -rf ~/.tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "=========================="
echo "== Download tmux config =="
echo "=========================="

curl https://raw.githubusercontent.com/T6705/dotfile/master/.tmux.conf > ~/.tmux.conf
curl https://raw.githubusercontent.com/T6705/dotfile/master/.tmux.conf.local > ~/.tmux.conf.local

################
## vim / nvim ##
################

echo "========================================"
echo "== Download vim-plugs and color theme =="
echo "========================================"

### vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -fLo ~/.vim/colors/molokai.vim --create-dirs \
    https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim
curl -fLo ~/.vim/plugin/dragvisuals.vim --create-dirs \
    https://raw.githubusercontent.com/T6705/dotfile/master/.vim/plugin/dragvisuals.vim

### nvim
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -fLo ~/.config/nvim/colors/molokai.vim --create-dirs \
    https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim
curl -fLo ~/.config/nvim/plugin/dragvisuals.vim --create-dirs \
    https://raw.githubusercontent.com/T6705/dotfile/master/.config/nvim/plugin/dragvisuals.vim

echo "=============================="
echo "== Download vim/nvim config =="
echo "=============================="

### vim
curl https://raw.githubusercontent.com/T6705/dotfile/master/.vimrc > ~/.vimrc

### nvim
if [ -d ~/.config/nvim ];then
    echo "~/.config/nvim already exists"
else
    echo "create ~/.config/nvim"
    cd
    mkdir ~/.config/nvim
fi
curl https://raw.githubusercontent.com/T6705/dotfile/master/.config/nvim/init.vim > ~/.config/nvim/init.vim

echo "===================="
echo "== Update Plugins =="
echo "===================="

curl https://raw.githubusercontent.com/T6705/dotfile/master/visincr.vba > /tmp/visincr.vba
sudo npm -g install instant-markdown-d

vim /tmp/visincr.vba +"so %" +qall
vim +PlugUpdate 
nvim /tmp/visincr.vba +"so %" +qall
nvim +PlugUpdate 
reset

echo "==========================="
echo "== Download emacs config =="
echo "==========================="

curl https://raw.githubusercontent.com/T6705/dotfile/master/.spacemacs > ~/.spacemacs

echo "========================"
echo "== Download i3 config =="
echo "========================"

if [ -d ~/.config/i3 ];then
    echo "~/.config/i3 already exists"
else
    echo "create ~/.config/i3"
    cd
    mkdir ~/.config/i3
fi

if [ -d ~/.config/i3/i3blocks ];then
    echo "~/.config/i3/i3blocks already exists"
else
    echo "create ~/.config/i3/i3blocks"
    cd
    mkdir ~/.config/i3/i3blocks
fi

if [ -d ~/.config/i3/polybar ];then
    echo "~/.config/i3/polybar already exists"
else
    echo "create ~/.config/i3/polybar"
    cd
    mkdir ~/.config/i3/polybar
fi

curl https://raw.githubusercontent.com/T6705/dotfile/master/.config/i3/config > ~/.config/i3/config
curl https://raw.githubusercontent.com/T6705/dotfile/master/.config/i3/i3blocks/i3blocks.conf > ~/.config/i3/i3blocks/i3blocks.conf
curl https://raw.githubusercontent.com/T6705/dotfile/master/.config/i3/compton.conf > ~/.config/i3/compton.conf
curl https://raw.githubusercontent.com/T6705/dotfile/master/.config/i3/polybar/config > ~/.config/i3/polybar/config
curl https://raw.githubusercontent.com/T6705/dotfile/master/.config/i3/polybar/launch.sh > ~/.config/i3/polybar/launch.sh

echo "========="
echo "== git =="
echo "========="

if [ -d ~/git ];then
    echo "~/git already exists"
else
    echo "create ~/git"
    cd
    mkdir ~/git
fi

cd ~/git
git clone https://github.com/meskarune/i3lock-fancy/
git clone https://github.com/geommer/yabar
git clone https://www.github.com/Airblader/i3 i3-gaps

cd ~/git/i3lock-fancy
sudo cp ~/git/i3lock-fancy/lock /usr/local/bin/
sudo cp ~/git/i3lock-fancy/lock.png /usr/local/bin/
sudo cp ~/git/i3lock-fancy/lockdark.png /usr/local/bin/

cd ~/git/i3-gaps
git checkout gaps && git pull
make
sudo make install

cd ~/git/yabar
make 
sudo make install

cd

#gsettings set org.gnome.desktop.background show-desktop-icons false

