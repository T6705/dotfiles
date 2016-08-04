#########
## zsh ##
#########

echo "========================="
echo "== Download zsh config =="
echo "========================="

sudo rm -rf ~/.zshrc
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

sudo rm -rf ~/.tmux.conf
curl https://raw.githubusercontent.com/T6705/dotfile/master/.tmux.conf > ~/.tmux.conf

################
## vim / nvim ##
################

echo "========================================"
echo "== Download vim-plugs and color theme =="
echo "========================================"

sudo rm -rf ~/.vim
### vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -fLo ~/.vim/colors/molokai.vim --create-dirs \
    https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim
curl -fLo ~/.vim/plugin/dragvisuals.vim --create-dirs \
    https://raw.githubusercontent.com/T6705/dotfile/master/.vim/plugin/dragvisuals.vim

sudo rm -rf ~/.config/nvim
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
sudo rm -rf ~/.vimrc
curl https://raw.githubusercontent.com/T6705/dotfile/master/.vimrc > ~/.vimrc

### nvim
sudo rm -rf ~/.config/nvim/init.vim
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

sudo rm -rf ~/.spacemacs
curl https://raw.githubusercontent.com/T6705/dotfile/master/.spacemacs > ~/.spacemacs

echo "========================"
echo "== Download i3 config =="
echo "========================"

sudo rm -rf ~/.config/i3
if [ -d ~/.config/i3 ];then
    echo "~/.config/i3 already exists"
else
    echo "create ~/.config/i3"
    cd
    mkdir ~/.config/i3
fi

if [ -d ~/.config/i3/i3blocks ];then
    echo "~/.config/i3 already exists"
else
    echo "create ~/.config/i3/i3blocks"
    cd
    mkdir ~/.config/i3/i3blocks
fi

curl https://raw.githubusercontent.com/T6705/dotfile/master/.config/i3/config > ~/.config/i3/config
curl https://raw.githubusercontent.com/T6705/dotfile/master/.config/i3/i3blocks/i3blocks.conf > ~/.config/i3/i3blocks/i3blocks.conf
crul https://raw.githubusercontent.com/T6705/dotfile/master/.config/i3/compton.conf > ~/.config/i3/compton.conf
