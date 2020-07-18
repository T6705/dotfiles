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
time brew install ack aircrack-ng automake awk bash bat clamav cmake cscope ctags curl dc3dd dcfldd diff-so-fancy emacs exa exploitdb feh ffmpeg foremost fzf gcc gettext git gnupg go grep hashcat hping htop httpie hydra libtool llvm lsd md5sha1sum mpv neofetch nikto nim ninja nmap node ntfs-3g pkg-config prettier pypy3 qemu radare2 ranger rclone ripgrep rust screenfetch shellcheck sqlmap sshfs tcpdump tmux unrar vim watch wget
time brew cask install chromedriver chromium macvim visual-studio-code

#########################
### Install nerd font ###
#########################
time brew tap homebrew/cask-fonts
time brew cask install font-fira-code-nerd-font font-hack-nerd-font

########################################################
### install useful key bindings and fuzzy completion ###
########################################################
$(brew --prefix)/opt/fzf/install

#####################################
### download gruvbox color scheme ###
#####################################
cd ~/Downloads && wget "https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/Gruvbox%20Dark.itermcolors"

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
