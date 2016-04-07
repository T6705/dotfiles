## vim

echo "=========================================="
echo "== Download vim plugins and color theme =="
echo "=========================================="

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -fLo ~/.vim/colors/molokai.vim --create-dirs \
    https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim

echo "========================="
echo "== Download vim config =="
echo "========================="

curl https://raw.githubusercontent.com/tomtong1128/dotfile/master/.vimrc > ~/.vimrc

echo "===================="
echo "== Update Plugins =="
echo "===================="

vim +PlugUpdate 
reset

## tmux

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

curl https://raw.githubusercontent.com/tomtong1128/dotfile/master/.tmux.conf > ~/.tmux.conf
