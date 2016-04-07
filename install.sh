################
## vim / nvim ##
################

echo "==============================================="
echo "== Download vim/nvim plugins and color theme =="
echo "==============================================="

### vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -fLo ~/.vim/colors/molokai.vim --create-dirs \
    https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim

### nvim
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -fLo ~/.config/nvim/colors/molokai.vim --create-dirs \
	https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim

echo "=============================="
echo "== Download vim/nvim config =="
echo "=============================="

### vim
curl https://raw.githubusercontent.com/T6705/dotfile/master/.vimrc > ~/.vimrc

### nvim
curl https://raw.githubusercontent.com/T6705/dotfile/master/.config/nvim/init.vim > ~/.config/nvim/init.vim

echo "===================="
echo "== Update Plugins =="
echo "===================="

vim +PlugUpdate 
nvim +PlugUpdate 
reset

##########
## tmux ##
##########

echo "==================================="
echo "== Install requirements packages =="
echo "==================================="

sudo apt-get install xclip
sudo apt-get install xsel

echo "=========================="
echo "== Install tmux plugins =="
echo "=========================="

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "=========================="
echo "== Download tmux config =="
echo "=========================="

curl https://raw.githubusercontent.com/T6705/dotfile/master/.tmux.conf > ~/.tmux.conf
