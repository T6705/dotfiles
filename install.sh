#!/bin/bash

function install_zsh {
    if which apt-get &> /dev/null ; then
        sudo apt-get install -y zsh
    fi

    echo "========================="
    echo "== Download zsh config =="
    echo "========================="

    curl https://raw.githubusercontent.com/T6705/dotfile/master/.zshrc > ~/.zshrc

    echo "=========================="
    echo "== Download zsh plugins =="
    echo "=========================="

    git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

    .oh-my-zsh/custom
    git clone git://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    #git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
    #git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
}

function install_tmux {
    if which apt-get &> /dev/null ; then
        sudo apt-get install -y tmux
    fi

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
}

function install_vim {
    if which apt-get &> /dev/null ; then
        sudo apt-get install -y vim
    fi

    echo "========================================"
    echo "== Download vim-plugs and color theme =="
    echo "========================================"

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

    curl -fLo ~/.config/nvim/augroups.vim --create-dirs \
        https://raw.githubusercontent.com/T6705/dotfile/master/.config/nvim/augroups.vim
    curl -fLo ~/.config/nvim/functions.vim --create-dirs \
        https://raw.githubusercontent.com/T6705/dotfile/master/.config/nvim/functions.vim
    curl -fLo ~/.config/nvim/general.vim --create-dirs \
        https://raw.githubusercontent.com/T6705/dotfile/master/.config/nvim/general.vim
    curl -fLo ~/.config/nvim/mappings.vim --create-dirs \
        https://raw.githubusercontent.com/T6705/dotfile/master/.config/nvim/mappings.vim
    curl -fLo ~/.config/nvim/plugins.vim --create-dirs \
        https://raw.githubusercontent.com/T6705/dotfile/master/.config/nvim/plugins.vim
    curl -fLo ~/.config/nvim/plugins_config.vim --create-dirs \
        https://raw.githubusercontent.com/T6705/dotfile/master/.config/nvim/plugins_config.vim

    ### vim
    curl https://raw.githubusercontent.com/T6705/dotfile/master/.vimrc > ~/.vimrc

    ### nvim
    curl -fLo ~/.config/nvim/init.vim --create-dirs \
        https://raw.githubusercontent.com/T6705/dotfile/master/.config/nvim/init.vim

    echo "===================="
    echo "== Update Plugins =="
    echo "===================="

    curl https://raw.githubusercontent.com/T6705/dotfile/master/visincr.vba > /tmp/visincr.vba
    sudo npm -g install instant-markdown-d

    if which vim &> /dev/null ; then
        vim /tmp/visincr.vba +"so %" +qall
        vim +PlugUpdate
    fi

    if which nvim &> /dev/null ; then
        nvim /tmp/visincr.vba +"so %" +qall
        nvim +PlugUpdate
    fi
    reset
}

function install_spacemacs {
    if which apt-get &> /dev/null ; then
        sudo apt-get install -y emacs
    fi

    echo "==========================="
    echo "== Download emacs config =="
    echo "==========================="

    curl https://raw.githubusercontent.com/T6705/dotfile/master/.spacemacs > ~/.spacemacs
}

function install_i3 {
    if which apt-get &> /dev/null ; then
        sudo apt-get install -y i3
    fi

    echo "========================"
    echo "== Download i3 config =="
    echo "========================"

    curl -fLo ~/.config/i3/config --create-dirs \
        https://raw.githubusercontent.com/T6705/dotfile/master/.config/i3/config
    curl -fLo ~/.config/i3/i3blocks/i3blocks.conf --create-dirs \
        https://raw.githubusercontent.com/T6705/dotfile/master/.config/i3/i3blocks/i3blocks.conf
    curl -fLo ~/.config/i3/compton.conf --create-dirs \
        https://raw.githubusercontent.com/T6705/dotfile/master/.config/i3/compton.conf
    curl -fLo ~/.config/i3/polybar/config --create-dirs \
        https://raw.githubusercontent.com/T6705/dotfile/master/.config/i3/polybar/config
    curl -fLo ~/.config/i3/polybar/launch.sh --create-dirs \
        https://raw.githubusercontent.com/T6705/dotfile/master/.config/i3/polybar/launch.sh
}

ans=$1

if [ $ans == "zsh" ]; then
    install_zsh
elif [ $ans == "tmux" ]; then
    install_tmux
elif [ $ans == "vim" ]; then
    install_vim
elif [ $ans == "spacemacs" ]; then
    install_spacemacs
elif [ $ans == "i3" ]; then
    install_i3
else
    if which apt-get &> /dev/null ; then
        sudo apt-get install zsh tmux xclip xsel npm vim vim-athena vim-gnome vim-gtk vim-nox -y
    fi
    install_zsh
    install_tmux
    install_vim
    install_spacemacs
    install_i3
fi
