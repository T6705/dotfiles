echo "=========================================="
echo "== Download vim plugins and color theme =="
echo "=========================================="

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -fLo ~/.vim/colors/molokai.vim --create-dirs \
    https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim

echo "================================="
echo "== Download config to ~/.vimrc =="
echo "================================="

curl https://raw.githubusercontent.com/tomtong1128/dotfile/master/.vimrc > ~/.vimrc

echo "===================="
echo "== Update Plugins =="
echo "===================="

vim +PlugUpdate 
