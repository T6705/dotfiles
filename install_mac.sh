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

# morden unix command
time brew install bat broot dog duf dust exa fx fzf git-delta gping httpie jq lsd procs ripgrep sd

## latex
#time brew install basictex mactex texlive
#time brew install --cask texmaker

time brew install ack aircrack-ng automake awk bash binutils binwalk clamav cmake coreutils cscope ctags curl dc3dd dcfldd diff-so-fancy dns2tcp easy-tag exploitdb ext4fuse fcrackzip feh ffmpeg findutils fish foremost gcc gettext git gnu-sed gnupg go grep hashcat hashpump hping htop hub hydra iperf3 john knock libtool llvm macs-fan-control mitmproxy moreutils mpv neofetch netpbm nikto ninja nmap node ntfs-3g openvpn p7zip pkg-config podman prettier proxychains-ng pypy3 qemu radare2 ranger rclone rust screenfetch shellcheck socat sqlmap sshuttle starship stunnel tcpdump tcpflow tcpreplay tcptrace telnet tmux ucspi-tcp vim watch wget xz

time brew install --cask alacritty another-redis-desktop-manager apenngrace/vulkan/vulkan-sdk burp-suite chromedriver chromium clipy cyberduck discord firefox font-noto-serif-cjk ghidra gimp google-chrome iterm2 kitty macvim meld neovide openvpn-connect postman stats tiles veracrypt virtualbox visual-studio-code vnc-viewer wine-stable

#########################
### Install nerd font ###
#########################
time brew tap homebrew/cask-fonts
time brew install --cask font-fira-code-nerd-font font-hack-nerd-font font-jetbrainsmono-nerd-font

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
#curl https://gitlab.com/T6705/dotfiles/raw/master/.curlrc > ~/.curlrc

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
    time cd ~/.oh-my-zsh && time git pull -v --progress
else
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

time mkdir -p ~/.oh-my-zsh/custom/plugins

if [[ -d ~/.oh-my-zsh/custom/plugins/alias-tips ]]; then
    time cd ~/.oh-my-zsh/custom/plugins/alias-tips && time git pull -v --progress
else
    time git clone -v --progress https://github.com/djui/alias-tips.git ~/.oh-my-zsh/custom/plugins/alias-tips
fi

if [[ -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]]; then
    time cd ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions && time git pull -v --progress
else
    time git clone -v --progress https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
fi

if [[ -d ~/.oh-my-zsh/custom/plugins/zsh-completions ]]; then
    time cd ~/.oh-my-zsh/custom/plugins/zsh-completions && time git pull -v --progress
else
    time git clone -v --progress https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
fi

if [[ -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]]; then
    time cd ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && time git pull -v --progress
else
    time git clone -v --progress https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi

#if [[ -d ~/.oh-my-zsh/custom/themes/spaceship-prompt ]]; then
#    time cd ~/.oh-my-zsh/custom/themes/spaceship-prompt && time git pull -v --progress
#    if [[ ! -h ~/.oh-my-zsh/custom/themes/spaceship.zsh-theme ]]; then
#        ln -s ~/.oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme ~/.oh-my-zsh/custom/themes/spaceship.zsh-theme
#    fi
#else
#    time git clone -v --progress https://github.com/denysdovhan/spaceship-prompt.git ~/.oh-my-zsh/custom/themes/spaceship-prompt
#    ln -s ~/.oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme ~/.oh-my-zsh/custom/themes/spaceship.zsh-theme
#fi

######################
### install neovim ###
######################
if [ -d ~/git/hub/neovim ]; then
    time cd ~/git/hub/neovim && time git pull -v --progress
else
    time mkdir -p ~/git/hub
    time cd ~/git/hub
    time git clone -v --progress https://github.com/neovim/neovim
fi

time cd ~/git/hub/neovim
#time make CMAKE_BUILD_TYPE=RelWithDebInfo
make CMAKE_BUILD_TYPE=Release
time sudo make install
time nvim -v

################################
### Download vim/nvim config ###
################################
curl -fLo ~/.config/nvim/after/plugin/lsp.lua --create-dirs https://gitlab.com/T6705/dotfiles/-/raw/master/.config/nvim/after/plugin/lsp.lua
curl -fLo ~/.config/nvim/after/plugin/lualine.lua --create-dirs https://gitlab.com/T6705/dotfiles/-/raw/master/.config/nvim/after/plugin/lualine.lua
curl -fLo ~/.config/nvim/after/plugin/nvim-cmp.lua --create-dirs https://gitlab.com/T6705/dotfiles/-/raw/master/.config/nvim/after/plugin/nvim-cmp.lua
curl -fLo ~/.config/nvim/autoload/visincr.vim --create-dirs https://gitlab.com/T6705/dotfiles/-/raw/master/.config/nvim/autoload/visincr.vim
curl -fLo ~/.config/nvim/lua/general.lua --create-dirs https://gitlab.com/T6705/dotfiles/-/raw/master/.config/nvim/lua/general.lua
curl -fLo ~/.config/nvim/lua/neovide.lua --create-dirs https://gitlab.com/T6705/dotfiles/-/raw/master/.config/nvim/lua/neovide.lua
curl -fLo ~/.config/nvim/lua/plugins.lua --create-dirs https://gitlab.com/T6705/dotfiles/-/raw/master/.config/nvim/lua/plugins.lua
curl -fLo ~/.config/nvim/lua/mappings.lua --create-dirs https://gitlab.com/T6705/dotfiles/-/raw/master/.config/nvim/lua/mappings.lua

### vim
curl https://gitlab.com/T6705/dotfiles/-/raw/master/minimal.vimrc > ~/.vimrc

### nvim
curl -fLo ~/.config/nvim/init.lua --create-dirs \
    https://gitlab.com/T6705/dotfiles/raw/master/.config/nvim/init.lua

############################
### Download tmux config ###
############################
curl https://gitlab.com/T6705/dotfiles/raw/master/.tmux.conf > ~/.tmux.conf
curl https://gitlab.com/T6705/dotfiles/raw/master/.tmux.conf.local > ~/.tmux.conf.local

if command -v diff-so-fancy &> /dev/null; then
    git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
fi
