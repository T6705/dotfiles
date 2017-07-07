#!/bin/zsh

function install_dots {
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

    echo "============================"
    echo "== Download ranger config =="
    echo "============================"

    curl -fLo ~/.config/ranger/rc.conf --create-dirs \
        https://raw.githubusercontent.com/T6705/dotfile/master/.config/ranger/rc.conf
    curl -fLo ~/.config/ranger/rifle.conf --create-dirs \
        https://raw.githubusercontent.com/T6705/dotfile/master/.config/ranger/rifle.conf

    echo "==============================="
    echo "== Download spacemacs config =="
    echo "==============================="

    curl https://raw.githubusercontent.com/T6705/dotfile/master/.spacemacs > ~/.spacemacs

    echo "=========================="
    echo "== Download tmux config =="
    echo "=========================="

    curl https://raw.githubusercontent.com/T6705/dotfile/master/.tmux.conf > ~/.tmux.conf
    curl https://raw.githubusercontent.com/T6705/dotfile/master/.tmux.conf.local > ~/.tmux.conf.local

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

    echo "========================="
    echo "== Download zsh config =="
    echo "========================="

    curl https://raw.githubusercontent.com/T6705/dotfile/master/.zshrc > ~/.zshrc

    curl -fLo ~/.zsh/aliases.zsh --create-dirs \
        https://raw.githubusercontent.com/T6705/dotfile/master/.zsh/aliases.zsh
    curl -fLo ~/.zsh/functions.zsh --create-dirs \
        https://raw.githubusercontent.com/T6705/dotfile/master/.zsh/functions.zsh


    TEST_CURRENT_SHELL=$(expr "$SHELL" : '.*/\(.*\)')
    if [[ "$TEST_CURRENT_SHELL" == "zsh" ]]; then
        . ~/.zshrc
    fi
}

function install_dependencies {
    if which apt-get &> /dev/null ; then
        sudo apt-get update
        suod apt-get upgrade -y
        suod apt-get dist-upgrade -y
        suod apt-get autoremove -y
        suod apt-get clean
        sudo apt-get install -y zsh ranger tmux xclip xsel npm vim vim-athena vim-gnome vim-gtk vim-nox
        # for building neovim
        sudo apt-get install libtool libtool-bin autoconf automake cmake g++ pkg-config unzip
        # for building i3-gaps (Ubuntu >= 14.04 LTS, <= 16.04)
        sudo add-apt-repository ppa:aguignard/ppa
        sudo apt-get update
        sudo apt-get install -y xdg-utils libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf libxcb-xrm-dev
        # for building i3-gaps (Ubuntu >= 16.10)
        #sudo apt-get install -y libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf libxcb-xrm0 libxcb-xrm-dev
    elif which pacman &> /dev/null ; then
        sudo pacman -Syu --noconfirm
        sudo pacman -Sy --noconfirm zsh ranger tmux xclip xsel npm vim neovim
    fi

    if which npm &> /dev/null ; then
        sudo npm install npm@latest -g
    fi
}

function install_i3 {
    if which apt-get &> /dev/null ; then
        sudo apt-get install -y i3
    elif which pacman &> /dev/null ; then
        sudo pacman -S --noconfirm i3-wm
    fi

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
    rm -rf i3lock-fancy
    git clone "https://github.com/meskarune/i3lock-fancy"
    cd ~/git/i3lock-fancy
    sudo cp -v lock /usr/local/bin/
    sudo cp -r -v icons /usr/local/bin/
}

function install_ranger {
    if which apt-get &> /dev/null ; then
        sudo apt-get install -y ranger
    elif which pacman &> /dev/null ; then
        sudo pacman -S --noconfirm ranger
    fi
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
    if [[ -d ~/.emacs.d ]]; then
        cd ~/.emacs.d && git pull
    else
        git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
    fi

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

    echo "===================="
    echo "== Update Plugins =="
    echo "===================="

    curl https://raw.githubusercontent.com/T6705/dotfile/master/visincr.vba > /tmp/visincr.vba

    if which npm &> /dev/null ; then
        sudo npm -g install instant-markdown-d
    fi

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

    echo "====================================="
    echo "== Download zsh plugins and themes =="
    echo "====================================="

    if [[ -d ~/.oh-my-zsh ]]; then
        cd ~/.oh-my-zsh && git pull
    else
        git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    fi

    mkdir -p ~/.oh-my-zsh/custom/plugins

    if [[ -d ~/.oh-my-zsh/custom/plugins/alias-tips ]]; then
        cd ~/.oh-my-zsh/custom/plugins/alias-tips && git pull
    else
        git clone https://github.com/djui/alias-tips.git ~/.oh-my-zsh/custom/plugins/alias-tips
    fi

    if [[ -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]]; then
        cd ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions && git pull
    else
        git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    fi

    if [[ -d ~/.oh-my-zsh/custom/plugins/zsh-completions ]]; then
        cd ~/.oh-my-zsh/custom/plugins/zsh-completions && git pull
    else
        git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
    fi

    if [[ -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]]; then
        cd ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && git pull
    else
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    fi

    curl -fLo ~/.oh-my-zsh/custom/themes/spaceship.zsh-theme --create-dirs \
        https://raw.githubusercontent.com/denysdovhan/spaceship-zsh-theme/master/spaceship.zsh

    echo "============================="
    echo "== install powerline fonts =="
    echo "============================="

    # clone
    git clone https://github.com/powerline/fonts.git
    # install
    cd fonts
    ./install.sh
    # clean-up a bit
    cd ..
    rm -rf fonts

    echo "======================="
    echo "== install powerline =="
    echo "======================="

    if which apt-get &> /dev/null ; then
        sudo apt-get install fonts-powerline -y
    elif which pacman &> /dev/null ; then
        sudo pacman -S --noconfirm powerline
    fi

    rm -rf ~/powerline-shell
    git clone https://github.com/milkbikis/powerline-shell ~/powerline-shell
    cd ~/powerline-shell
    cp -v config.py.dist config.py
    ./install.py
    #python ~/powerline-shell/install.py
    ln -s ~/powerline-shell/powerline-shell.py ~/powerline-shell.py

    echo "======================="
    echo "== install LS_COLORS =="
    echo "======================="
    # https://github.com/trapd00r/LS_COLORS
    wget https://raw.github.com/trapd00r/LS_COLORS/master/LS_COLORS -O $HOME/.dircolors

    echo "================="
    echo "== install fzf =="
    echo "================="
    if [ -f ~/.fzf/install ]; then
        cd ~/.fzf && git pull
        ~/.fzf/install
    else
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install
    fi

    echo "=================="
    echo "== install ccat =="
    echo "=================="
    # https://github.com/jingweno/ccat
    if which go &> /dev/null ; then
        export GOPATH=$HOME/go
        go get -u github.com/jingweno/ccat
        export PATH=$PATH:$GOPATH/bin
    fi

    echo "==================="
    echo "== install pyenv =="
    echo "==================="
    if [[ -d ~/.pyenv ]]; then
        cd ~/.pyenv && git pull
    else
        git clone https://github.com/pyenv/pyenv.git ~/.pyenv
    fi

    # If this user's login shell is not already "zsh", attempt to switch.
    TEST_CURRENT_SHELL=$(expr "$SHELL" : '.*/\(.*\)')
    if [[ "$TEST_CURRENT_SHELL" != "zsh" ]]; then
        # If this platform provides a "chsh" command (not Cygwin), do it, man!
        if which chsh &> /dev/null ; then
            echo "Time to change your default shell to zsh!"
            chsh -s $(grep /zsh$ /etc/shells | tail -1)
            # Else, suggest the user do so manually.
        else
            echo "I can't change your shell automatically because this system does not have chsh."
            echo "Please manually change your default shell to zsh!"
        fi
    elif [[ "$TEST_CURRENT_SHELL" == "zsh" ]]; then
        . ~/.zshrc
    fi
}

function main {
    if [[ $1 == "dots" ]]; then
        install_dots
    elif [[ $1 == "dependencies" ]]; then
        install_dependencies
    elif [[ $1 == "all" ]]; then
        install_dots
        install_dependencies
        install_i3
        install_ranger
        install_spacemacs
        install_tmux
        install_vim
        install_zsh
    else
        echo "dots/dependencies/all"
    fi
}

main $1
