#!/bin/bash

function install_i3 {
    if which apt-get &> /dev/null ; then
        sudo apt-get install -y i3
    elif which pacman &> /dev/null ; then
        sudo pacman -S --noconfirm i3-wm
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

    echo "======================"
    echo "== Download i3-gaps =="
    echo "======================"

    mkdir -p ~/git
    cd ~/git
    rm -rf i3-gaps

    # clone the repository
    git clone https://www.github.com/Airblader/i3 i3-gaps
    cd i3-gaps

    # compile & install
    autoreconf --force --install
    rm -rf build/
    mkdir -p build && cd build/

    # Disabling sanitizers is important for release versions!
    # The prefix and sysconfdir are, obviously, dependent on the distribution.
    ../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
    make
    sudo make install

    echo "==========================="
    echo "== Download i3lock-fancy =="
    echo "==========================="

    mkdir -p ~/git
    cd ~/git
    git clone "https://github.com/meskarune/i3lock-fancy"
    cd ~/git/i3lock-fancy
    sudo cp lock /usr/local/bin/
    sudo cp -r icons /usr/local/bin/
}

function install_ranger {
    if which apt-get &> /dev/null ; then
        sudo apt-get install -y ranger
    elif which pacman &> /dev/null ; then
        sudo pacman -S --noconfirm ranger
    fi

    echo "============================"
    echo "== Download ranger config =="
    echo "============================"

    curl -fLo ~/.config/ranger/rc.conf --create-dirs \
        https://raw.githubusercontent.com/T6705/dotfile/master/.config/ranger/rc.conf
    curl -fLo ~/.config/ranger/rifle.conf --create-dirs \
        https://raw.githubusercontent.com/T6705/dotfile/master/.config/ranger/rifle.conf
}

function install_spacemacs {
    if which apt-get &> /dev/null ; then
        sudo apt-get install -y emacs
    elif which pacman &> /dev/null ; then
        sudo pacman -S --noconfirm emacs
    fi

    echo "======================="
    echo "== install spacemacs =="
    echo "======================="

    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

    echo "==========================="
    echo "== Download emacs config =="
    echo "==========================="

    curl https://raw.githubusercontent.com/T6705/dotfile/master/.spacemacs > ~/.spacemacs
}

function install_tmux {
    if which apt-get &> /dev/null ; then
        sudo apt-get install -y tmux
    elif which pacman &> /dev/null ; then
        sudo pacman -S --noconfirm tmux
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
    elif which pacman &> /dev/null ; then
        sudo pacman -S --noconfirm vim neovim
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

function install_zsh {
    if which apt-get &> /dev/null ; then
        sudo apt-get install -y zsh
    elif which pacman &> /dev/null ; then
        sudo pacman -S --noconfirm zsh
    fi

    echo "========================="
    echo "== Download zsh config =="
    echo "========================="

    curl https://raw.githubusercontent.com/T6705/dotfile/master/.zshrc > ~/.zshrc

    echo "====================================="
    echo "== Download zsh plugins and themes =="
    echo "====================================="

    git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

    mkdir ~/.oh-my-zsh/custom/plugins
    git clone git://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    #git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
    #git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

    mkdir ~/.oh-my-zsh/custom/themes
    curl "https://raw.githubusercontent.com/denysdovhan/spaceship-zsh-theme/master/spaceship.zsh" > ~/.oh-my-zsh/custom/themes/spaceship.zsh-theme

    echo "======================="
    echo "== install powerline =="
    echo "======================="

    if which apt-get &> /dev/null ; then
        sudo apt-get install fonts-powerline -y
    elif which pacman &> /dev/null ; then
        sudo pacman -S --noconfirm powerline
    fi

    cd ~
    git clone https://github.com/milkbikis/powerline-shell
    python ~/powerline-shell/install.py
    ln -s ~/powerline-shell/powerline-shell.py ~/powerline-shell.py

    echo "======================="
    echo "== install LS_COLORS =="
    echo "======================="
    # https://github.com/trapd00r/LS_COLORS
    wget https://raw.github.com/trapd00r/LS_COLORS/master/LS_COLORS -O $HOME/.dircolors
}

if which apt-get &> /dev/null ; then
    sudo apt-get install -y zsh ranger tmux xclip xsel npm vim vim-athena vim-gnome vim-gtk vim-nox
    sudo apt-get install -y xdg-utils libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf libxcb-xrm-dev
elif which pacman &> /dev/null ; then
    sudo pacman -Sy --noconfirm zsh ranger tmux xclip xsel npm vim
fi
sudo npm install npm@latest -g

ans=$1

if [ $ans == "i3" ]; then
    install_i3
elif [ $ans == "ranger" ]; then
    install_ranger
elif [ $ans == "spacemacs" ]; then
    install_spacemacs
elif [ $ans == "tmux" ]; then
    install_tmux
elif [ $ans == "vim" ]; then
    install_vim
elif [ $ans == "zsh" ]; then
    install_zsh
else
    install_i3
    install_ranger
    install_spacemacs
    install_tmux
    install_vim
    install_zsh
fi
