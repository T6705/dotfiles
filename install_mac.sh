#!/bin/bash

set -x

########################
### Install Homebrew ###
########################
if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

########################
### Install packages ###
########################
time brew update
time brew install ack aircrack-ng automake awk bash bat bfg binutils binwalk cifer clamav cmake coreutils cquery cscope ctags curl dc3dd dcfldd dex2jar diff-so-fancy dns2tcp docker-compose docker-compose-completion dust easy-tag emacs exa exploitdb ext4fuse fcrackzip feh ffmpeg findutils fish foremost fx fzf gcc gettext git git-delta gnu-sed gnupg go grep hashcat hashpump hping htop httpie hydra iperf3 john jq knock kompose lens libtool llvm lsd macs-fan-control minikube mitmproxy moreutils mpv muesli/homebrew-tap/duf neofetch netpbm nikto nim ninja nmap node ntfs-3g openvpn p7zip pkg-config pngcheck prettier proxychains-ng pycharm-ce pypy3 qemu radare2 ranger rclone ripgrep rust screenfetch sd shellcheck socat sqlmap sshuttle starship stunnel tcpdump tcpflow tcpreplay tcptrace telnet tmux ucspi-tcp unrar vim watch wget xz

time brew install --cask alacritty another-redis-desktop-manager apenngrace/vulkan/vulkan-sdk burp-suite chromedriver chromium clipy cyberduck discord eul filezilla firefox font-noto-serif-cjk ghidra gimp gitahead gitup goneovim google-chrome iterm2 joplin joplin-cli krita macvim meld ngrok openvpn-connect postman sourcetrail stats tiles typora veracrypt virtualbox visual-studio-code vnc-viewer wine-stable

#########################
### Install nerd font ###
#########################
time brew tap homebrew/cask-fonts
time brew cask install font-fira-code-nerd-font font-hack-nerd-font font-jetbrainsmono-nerd-font

########################################################
### install useful key bindings and fuzzy completion ###
########################################################
$(brew --prefix)/opt/fzf/install

#####################################
### download gruvbox color scheme ###
#####################################
cd ~/Downloads && wget "https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/Gruvbox%20Dark.itermcolors"

############################
### Download curl config ###
############################
curl https://gitlab.com/T6705/dotfiles/raw/master/.curlrc > ~/.curlrc

############################
### Download bash config ###
############################
curl https://gitlab.com/T6705/dotfiles/raw/master/.bashrc > ~/.bashrc

###########################
### Download zsh config ###
###########################
curl https://gitlab.com/T6705/dotfiles/raw/master/.zshrc > ~/.zshrc
curl -fLo ~/.zsh/aliases.zsh --create-dirs \
https://gitlab.com/T6705/dotfiles/raw/master/.zsh/aliases.zsh
curl -fLo ~/.zsh/functions.zsh --create-dirs \
https://gitlab.com/T6705/dotfiles/raw/master/.zsh/functions.zsh

################################
### Download starship config ###
################################
curl -fLo ~/.config/starship.toml --create-dirs \
https://gitlab.com/T6705/dotfiles/raw/master/.config/starship.toml

###################
### install zsh ###
###################
if [[ -d ~/.oh-my-zsh ]]; then
    time cd ~/.oh-my-zsh && time git pull
else
    time git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
fi

time mkdir -p ~/.oh-my-zsh/custom/plugins

if [[ -d ~/.oh-my-zsh/custom/plugins/alias-tips ]]; then
    time cd ~/.oh-my-zsh/custom/plugins/alias-tips && time git pull
else
    time git clone https://github.com/djui/alias-tips.git ~/.oh-my-zsh/custom/plugins/alias-tips
fi

if [[ -d ~/.oh-my-zsh/custom/plugins/k ]]; then
    time cd ~/.oh-my-zsh/custom/plugins/k && time git pull
else
    time git clone https://github.com/supercrabtree/k ~/.oh-my-zsh/custom/plugins/k
fi

if [[ -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]]; then
    time cd ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions && time git pull
else
    time git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
fi

if [[ -d ~/.oh-my-zsh/custom/plugins/zsh-completions ]]; then
    time cd ~/.oh-my-zsh/custom/plugins/zsh-completions && time git pull
else
    time git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
fi

if [[ -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]]; then
    time cd ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && time git pull
else
    time git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi

if [[ -d ~/.oh-my-zsh/custom/themes/spaceship-prompt ]]; then
    time cd ~/.oh-my-zsh/custom/themes/spaceship-prompt && time git pull
    if [[ ! -h ~/.oh-my-zsh/custom/themes/spaceship.zsh-theme ]]; then
        ln -s ~/.oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme ~/.oh-my-zsh/custom/themes/spaceship.zsh-theme
    fi
else
    time git clone https://github.com/denysdovhan/spaceship-prompt.git ~/.oh-my-zsh/custom/themes/spaceship-prompt
    ln -s ~/.oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme ~/.oh-my-zsh/custom/themes/spaceship.zsh-theme
fi

######################
### install neovim ###
######################
if [ -d ~/git/hub/neovim ]; then
    time cd ~/git/hub/neovim && time git pull
else
    time mkdir -p ~/git/hub
    time cd ~/git/hub
    time git clone https://github.com/neovim/neovim
fi

time cd ~/git/hub/neovim
time make CMAKE_BUILD_TYPE=RelWithDebInfo
time sudo make install
time nvim -v

################################
### Download vim/nvim config ###
################################
curl -fLo ~/.config/nvim/augroups.vim --create-dirs \
    https://gitlab.com/T6705/dotfiles/raw/master/.config/nvim/augroups.vim
curl -fLo ~/.config/nvim/functions.vim --create-dirs \
    https://gitlab.com/T6705/dotfiles/raw/master/.config/nvim/functions.vim
curl -fLo ~/.config/nvim/general.vim --create-dirs \
    https://gitlab.com/T6705/dotfiles/raw/master/.config/nvim/general.vim
curl -fLo ~/.config/nvim/mappings.vim --create-dirs \
    https://gitlab.com/T6705/dotfiles/raw/master/.config/nvim/mappings.vim
curl -fLo ~/.config/nvim/plugins.vim --create-dirs \
    https://gitlab.com/T6705/dotfiles/raw/master/.config/nvim/plugins.vim
curl -fLo ~/.config/nvim/plugins_config.vim --create-dirs \
    https://gitlab.com/T6705/dotfiles/raw/master/.config/nvim/plugins_config.vim
curl -fLo ~/.config/nvim/coc-settings.json --create-dirs \
    https://gitlab.com/T6705/dotifles/raw/master/.config/nvim/coc-settings.json
curl -fLo ~/.config/nvim/.ycm --create-dirs \
    https://gitlab.com/T6705/dotifles/raw/master/.config/nvim/.ycm_extra_conf.py

### vim
curl https://gitlab.com/T6705/dotfiles/-/raw/master/minimal.vimrc > ~/.vimrc

### nvim
curl -fLo ~/.config/nvim/init.vim --create-dirs \
    https://gitlab.com/T6705/dotfiles/raw/master/.config/nvim/init.vim

############################
### Download tmux config ###
############################
curl https://gitlab.com/T6705/dotfiles/raw/master/.tmux.conf > ~/.tmux.conf
curl https://gitlab.com/T6705/dotfiles/raw/master/.tmux.conf.local > ~/.tmux.conf.local

if command -v diff-so-fancy &> /dev/null; then
    git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
fi

go get -u github.com/jingweno/ccat
