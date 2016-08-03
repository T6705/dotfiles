#!/bin/bash

function haha {
    echo "=============================="
    echo "== Please don't leave me =( =="
    echo "=============================="
}

trap haha SIGTERM SIGINT SIGHUP

function common {
    sudo apt-get update
    sudo apt-get upgrade -y
    sudo apt-get dist-upgrade -y

    list="
    ack-grep
    android
    arduino
    arduino-core
    arduino-mighty-1284p
    arduino-mk
    at
    bless
    bmon
    build-essential
    cewl
    chromium-browser
    chromium-chromedriver
    conky
    context
    crunch
    curl
    dcfldd
    dmsetup
    docky
    emacs
    etherape
    exif
    exuberant-ctags
    fcrackzip
    feh
    fonts-powerline
    g++
    gcc
    gcin
    gconf-editor
    gimp
    git
    gnome
    gnome-tweak-tool
    gparted
    hddtemp
    hime
    hping3
    htop
    hydra
    i3lock
    iftop
    inotify-hookable
    inotify-tools
    iotop
    john
    kdiff3
    krita
    lm-sensors
    lolcat
    macchanger
    macchanger-gtk
    meld
    memdump
    mpg123
    mupdf
    nautilus
    nmap
    npm
    p7zip
    pandoc
    pdfcrack
    proxychains
    psensor
    pv
    python
    python-matplotlib
    python-nmap
    python-scapy
    python-setuptools
    python-software-properties
    qemu-kvm
    radare2
    rar
    rarcrack
    ruby-dev
    rubygems-integration
    screenfetch
    sdb
    secure-delete
    silversearcher-ag
    skype
    slowhttptest
    slurm
    snort
    software-properties-common
    steam
    steghide
    tmux
    tor
    traceroute
    transmission
    tshark
    unity-tweak-tool
    unrar
    vim
    virtualbox
    visualboyadvance
    visualboyadvance-gtk
    vlc
    whois
    wicd-gtk
    wifite
    wine
    wireshark
    xclip
    xsel
    zenmap
    zsh
    "

    sudo apt-get install $list -y
    for i in $list; do sudo apt-get install $i -y ; done
    sudo apt-get autoremove -y
    sudo apt-get clean

    sudo apt-get install build-essential python3-dev -y
    sudo apt-get install python-pip python-dev libffi-dev libssl-dev libxml2-dev libxslt1-dev -y
    sudo easy_install pip
    sudo easy_install3 pip
    sudo pip install --upgrade pip
    sudo pip install -U dpkt
    sudo pip install -U jupyter
    sudo pip install -U jupyter
    sudo pip install -U mitmproxy
    sudo pip install -U selenium
    sudo pip3 install -U scapy-python3
    sudo pip3 install -U neovim

    sudo apt-get install build-essential curl git m4 ruby texinfo libbz2-dev libcurl4-openssl-dev libexpat-dev libncurses-dev zlib1g-dev -y

    #cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86" | tar xzf -
    #cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
    #~/.dropbox-dist/dropboxd

    # nodelist=`apt-cache search ^node | awk '{print $1}'`
    #javalist=`apt-cache search java | grep "java " | awk '{print $1}'`
    #latexlist=`apt-cache search ^texlive | awk '{print $1}'`
    jdklist=`apt-cache search java | grep jdk | grep -v "9" | awk '{print $1}'`
    jrelist=`apt-cache search java | grep jre | grep -v "9" | awk '{print $1}'`
    nautiluslist=`apt-cache search ^nautilus | awk '{print $1}'`
    virtualboxlist=`apt-cache search virtualbox | grep ^virtualbox | awk '{print $1}'`

    sudo apt-get install -fix-broken -fix-missing $jdklist $jrelist $latexlilst $virtualboxlist $nautiluslist

    #sudo apt-get install $javalist -y
    #for i in $javalist ; do sudo apt-get install $i -y ; done
    #sudo apt-get autoremove -y

    sudo apt-get install $nautiluslist -y
    for i in $nautiluslist ; do sudo apt-get install $i -y ; done
    sudo apt-get autoremove -y

    sudo apt-get install $jdklist -y
    for i in $jdklist ; do sudo apt-get install $i -y ; done
    sudo apt-get autoremove -y

    sudo apt-get install $jrelist -y
    for i in $jrelist ; do sudo apt-get install $i -y ; done
    sudo apt-get autoremove -y

    #sudo apt-get install $latexlist -y
    #for i in $latexlist ; do sudo apt-get install $i -y ; done
    #sudo apt-get autoremove -y

    sudo apt-get install $virtualboxlist -y
    for i in $virtualboxlist ; do sudo apt-get install $i -y ; done
    sudo apt-get autoremove -y
    # sudo apt-get install $node -y

    sudo apt-get autoremove -y
    sudo apt-get clean
}

function dwm {
    common
    sudo apt-get install dwm lightdm-gtk-greeter xinit -y # desktop environment
    sudo apt-get install cmus -y # audio players
    sudo apt-get install btpd -y # bittorrent clients
    sudo apt-get install ranger -y # file managers
    sudo apt-get install feh -y # image viewers
    sudo apt-get install mplayer -y # media players
    sudo apt-get install mupdf -y # pdf viewers
    sudo apt-get install dwb -y # web browsers
    sudo apt-get install surf -y # web browsers
    sudo apt-get install chromium-browser -y # web browsers
    sudo apt-get autoremove -y
    sudo apt-get clean
}

function ubuntu {
    common
    #sudo add-apt-repository ppa:noobslab/themes
    #sudo add-apt-repository ppa:tualatrix/ppa
    sudo add-apt-repository ppa:numix/ppa
    #sudo add-apt-repository ppa:gwibber-daily/ppa
    #sudo add-apt-repository ppa:nrbrtx/sysvinit-backlight
    sudo apt-get update
    #sudo apt-get install ubuntu-tweak -y
    sudo apt-get install numix-gtk-theme numix-icon-theme-circle -y
    sudo apt-get install numix-wallpaper-notd -y
    sudo apt-get install unity-tweak-tool -y
    sudo apt-get install gnome-tweak-tool -y
    #sudo apt-get install sysvinit-backlight -y
    #sudo apt-get install candra-unity-themes -y
    #sudo apt-get install zorinos-themes -y
    #sudo apt-get install vertex-theme -y
    #sudo apt-get install libra-theme -y
    sudo apt-get autoremove -y
    sudo apt-get clean
}

function kali {
    common
    kalilist=`apt-cache search kali-linux | awk '{print $1}'`
    sudo apt-get install $kalilist -y
    for i in $kalilist; do
        sudo apt-get install $i -y
    done
    sudo apt-get autoremove -y
    sudo apt-get clean
}

function i3 {
    sudo apt-get install `apt-cache search ^i3 | grep ^i3 | awk '{print $1}'` -y
    sudo apt-get install i3 gdm xinit -y # desktop environment
    sudo apt-get install cmus -y # audio players
    sudo apt-get install btpd -y # bittorrent clients
    sudo apt-get install ranger -y # file managers
    sudo apt-get install feh -y # image viewers
    sudo apt-get install mplayer -y # media players
    sudo apt-get install mupdf -y # pdf viewers
    sudo apt-get install dwb -y # web browsers
    sudo apt-get install surf -y # web browsers
    sudo apt-get install chromium-browser -y # web browsers
    sudo apt-get install -y rofi feh nautilus conky weechat mpd
    sudo apt-get install -y `apt-cache search ^nautilus | grep ^nautilus | awk '{print $1}'`
    liblist="
    libcairo2-dev
    libconfig-dev
    libev-dev
    libpango1.0-dev
    libstartup-notification0-dev
    libxcb-cursor-dev
    libxcb-ewmh-dev
    libxcb-icccm4-dev
    libxcb-keysyms1-dev
    libxcb-randr0-dev
    libxcb-util0-dev
    libxcb-xinerama0-dev
    libxcb-xkb-dev
    libxcb1-dev
    libxkbcommon-dev
    libxkbcommon-x11-dev
    libyajl-dev
    pkg-config
    "

    sudo apt-get install $liblist -y
    for i in $liblist; do sudo apt-get install $i -y; done

    if [ -d ~/git ];then
        echo "~/git already exists"
    else
        echo "create ~/git"
        cd
        mkdir git
    fi
    
    cd ~/git
    git clone https://www.github.com/Airblader/i3 i3-gaps
    cd i3-gaps
    git checkout gaps && git pull
    make
    sudo make install
    
    cd ~/git
    git clone https://github.com/geommer/yabar
    cd yabar
    make 
    sudo make install
    
    cd
    
    gsettings set org.gnome.desktop.background show-desktop-icons false
}

function neovim {
    echo "===================="
    echo "== Install packge =="
    echo "===================="

    sudo apt-get install build-essential cmake python-dev -y
    sudo apt-get install libtool libtool-bin lua-messagepack autoconf automake cmake g++ pkg-config unzip libmsgpack-dev libuv-dev libluajit-5.1-dev libmsgpackc2 -y
    sudo apt-get install python-pip -y
    sudo apt-get install python3-pip -y
    sudo easy_install pip
    sudo easy_install3 pip
    sudo pip3 install -U neovim

    #echo "==========================="
    #echo "== remove previous stuff =="
    #echo "==========================="
    #
    #sudo rm -rf ~/neovim
    #sudo rm -rf ~/.config/nvim
    #sudo rm -rf ~/.local/share/nvim
    #
    #echo "======================"
    #echo "== git clone neovim =="
    #echo "======================"
    #
    #cd ~
    #git clone https://github.com/neovim/neovim
    #cd ~/neovim
    #make
    #sudo make install

    echo "============================"
    echo "== apt-get install neovim =="
    echo "============================"

    sudo apt-get install python-dev python-pip python3-dev python3-pip -y
    sudo add-apt-repository ppa:neovim-ppa/unstable
    sudo apt-get update
    sudo apt-get install neovim -y

    #echo "=========================="
    #echo "== Download vim plugins =="
    #echo "=========================="

    #curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    #    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    #curl -fLo ~/.config/nvim/colors/molokai.vim --create-dirs \
    #	https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim

    #echo "=========================="
    #echo "== Download nvim config =="
    #echo "=========================="

    #curl https://raw.githubusercontent.com/T6705/dotfile/master/.config/nvim/init.vim > ~/.config/nvim/init.vim

    #echo "===================="
    #echo "== Update Plugins =="
    #echo "===================="

    #nvim +PlugUpdate 
    reset
}

function emacs {
    echo "==========================="
    echo "== apt-get install emacs =="
    echo "==========================="

    sudo apt-get install emacs -y

    echo "======================="
    echo "== install spacemacs =="
    echo "======================="

    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

    echo "================================"
    echo "== Download spacemacs config == "
    echo "================================"

    curl https://raw.githubusercontent.com/T6705/dotfile/master/.spacemacs > ~/.spacemacs

    echo "==================="
    echo "== run spacemacs =="
    echo "==================="

    emacs -nw
    emacs -nw
}

function zsh {
    ### install zsh
    sudo apt-get install zsh -y
    ### install oh-my-zsh
    git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    ### download config file
    curl https://raw.githubusercontent.com/T6705/dotfile/master/.zshrc > ~/.zshrc

    ### install powerline
    cd ~
    sudo apt-get install fonts-powerline -y
    git clone https://github.com/milkbikis/powerline-shell
    cd ~/powerline-shell
    python ~/powerline-shell/install.py
    cd ~
    ln -s ~/powerline-shell/powerline-shell.py ~/powerline-shell.py
}

function dotfile {
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
        echo "~/.config/i3 already exists"
    else
        echo "create ~/.config/i3/i3blocks"
        cd
        mkdir ~/.config/i3/i3blocks
    fi

    curl https://raw.githubusercontent.com/T6705/dotfile/master/.config/i3/config > ~/.config/i3/config
    curl https://raw.githubusercontent.com/T6705/dotfile/master/.config/i3/i3blocks/i3blocks.conf > ~/.config/i3/i3blocks/i3blocks.conf

}

while true ; do
    echo "normal/dwm/ubuntu-desktop/kali :"
    read ans
    if [ $ans == "normal" ]; then
        common
        break
    elif [ $ans == "dwm" ]; then
        dwm
        i3
        neovim
        zsh
        dotfile
        break
    elif [ $ans == "ubuntu-desktop" ]; then
        ubuntu
        i3
        neovim
        zsh
        dotfile
        break
    elif [ $ans == "kali" ]; then
        kali
        i3
        neovim
        zsh
        dotfile
        break
    else
        echo ""
        echo "==================================================="
        echo "please input *normal*/*dwm*/*ubuntu-desktop*/*kali*"
        echo "==================================================="
        echo ""
    fi
done

echo "You may need to install the followings by yourself:"
echo "Dropbox"
echo "Steam"
echo "Telegram"
echo "VeraCrypt"
