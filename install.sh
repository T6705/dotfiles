#########
## zsh ##
#########

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

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "=========================="
echo "== Download tmux config =="
echo "=========================="

curl https://raw.githubusercontent.com/T6705/dotfile/master/.tmux.conf > ~/.tmux.conf

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

