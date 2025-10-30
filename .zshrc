export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_PAPER="en_US.UTF-8"
export LC_NAME="en_US.UTF-8"
export LC_ADDRESS="en_US.UTF-8"
export LC_TELEPHONE="en_US.UTF-8"
export LC_MEASUREMENT="en_US.UTF-8"
export LC_IDENTIFICATION="en_US.UTF-8"
export LC_ALL=

export BETTER_EXCEPTIONS=1

# improved less option
export LESS='--tabs=4 --no-init --LONG-PROMPT --ignore-case --quit-if-one-screen --RAW-CONTROL-CHARS'

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
 zstyle ':omz:update' frequency 1

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="false"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    alias-finder
    archlinux
    brew
    catimg
    command-not-found
    docker
    docker-compose
    encode64
    flutter
    fzf
    git
    gitignore
    golang
    httpie
    kubectl
    macos
    microk8s
    nmap
    npm
    pip
    pipenv
    pyenv
    python
    rsync
    systemadmin
    systemd
    tmux
    vi-mode
    vscode
    zsh-autosuggestions
    zsh-completions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

ZSH_ALIAS_FINDER_AUTOMATIC=true

autoload -U compinit && compinit

# User configuration
if command -v go &> /dev/null; then
    [ ! -d $HOME/go ] && mkdir -p $HOME/go
    [ ! -d $HOME/go/bin ] && mkdir -p $HOME/go/bin
    [ -d $HOME/go ] && export GOPATH="$HOME/go"
    [ -d $HOME/go/bin ] && export GOBIN="$GOPATH/bin" && export PATH="$PATH:$GOPATH/bin"
fi

# export MANPATH="/usr/local/man:$MANPATH"
[ -d $HOME/.cargo/bin ] && export PATH="$HOME/.cargo/bin:$PATH"
[ -d $HOME/.cargo/env ] && export PATH="$HOME/.cargo/env:$PATH"
[ -d $HOME/.gem/ruby/3.0.0/bin ] && export PATH="$PATH:$HOME/.gem/ruby/3.0.0/bin"
[ -d $HOME/.local/share/gem/ruby/3.4.0/bin ] && export PATH="$HOME/.local/share/gem/ruby/3.4.0/bin:$PATH"
[ -d $HOME/.local/share/nvim/mason/bin ] && export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"
[ -d $HOME/.pub-cache/bin ] && export PATH="$PATH":"$HOME/.pub-cache/bin"
[ -d $HOME/.pyenv ] && export PYENV_ROOT="$HOME/.pyenv" && export PATH="$PYENV_ROOT/bin:$PATH"
[ -d $HOME/.yarn ] && export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
[ -d $HOME/bin ] && export PATH="$HOME/bin:$PATH"
[ -d $HOME/git/hub/flutter/bin ] && export PATH="$HOME/git/hub/flutter/bin:$PATH"
[ -d /usr/games ] && export PATH="$PATH:/usr/games"
[ -d /usr/lib/jvm/default ] && export JAVA_HOME=/usr/lib/jvm/default
[ -d /usr/local/bin ] && export PATH="/usr/local/bin:$PATH"
[ -d /usr/local/opt/heroku-node/bin ] && export PATH="/usr/local/opt/heroku-node/bin:$PATH"
[ -d /usr/local/opt/openjdk/bin ] && export PATH="/usr/local/opt/openjdk/bin:$PATH"
[ -d /usr/local/opt/python@3.9/Frameworks/Python.framework/Versions/3.9/bin ] && export PATH="/usr/local/opt/python@3.9/Frameworks/Python.framework/Versions/3.9/bin:$PATH"
[ -d /usr/local/opt/ruby@3.3/bin ] && export PATH="/usr/local/opt/ruby@3.3/bin:$PATH"
[ -d /usr/local/sbin ] && export PATH="/usr/local/sbin:$PATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    if command -v nvim &> /dev/null ; then
        export EDITOR='nvim'
    elif command -v vim &> /dev/null ; then
        export EDITOR='vim'
    elif command -v vi &> /dev/null ; then
        export EDITOR='vi'
    fi
else
    if command -v nvim &> /dev/null ; then
        export EDITOR='nvim'
    elif command -v vim &> /dev/null ; then
        export EDITOR='vim'
    elif command -v vi &> /dev/null ; then
        export EDITOR='vi'
    fi
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#setopt AUTO_CD                # No cd needed to change directories
#setopt BANG_HIST              # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicate entries first when trimming history.
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS   # Delete old recorded entry if new entry is a duplicate.
setopt HIST_IGNORE_DUPS       # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_SPACE      # Don't record an entry starting with a space.
setopt HIST_REDUCE_BLANKS     # Remove superfluous blanks before recording entry.
setopt HIST_SAVE_NO_DUPS      # Don't write duplicate entries in the history file.
setopt INC_APPEND_HISTORY     # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY          # Share history between all sessions.

####################################
## https://github.com/pyenv/pyenv ##
####################################
if command -v pyenv &> /dev/null; then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

####################################
## https://github.com/pypa/pipenv ##
####################################
#if command -v pipenv &> /dev/null; then
#    eval "$(pipenv --completion)"
#fi

##################################################
## https://github.com/milkbikis/powerline-shell ##
##################################################
if [[ -z $ZSH_THEME ]]; then
    function powerline_precmd {
        PS1="$(~/powerline-shell.py $? --shell zsh 2> /dev/null)"
    }

    function install_powerline_precmd {
        for s in "${precmd_functions[@]}"; do
            if [ "$s" = "powerline_precmd" ]; then
                return
            fi
        done
        precmd_functions+=(powerline_precmd)
    }

    if [ "$TERM" != "linux" ]; then
        install_powerline_precmd
    fi
fi

#####################################
## https://github.com/junegunn/fzf ##
#####################################
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

###########################################
## https://github.com/trapd00r/LS_COLORS ##
###########################################
[ -f $HOME/.dircolors ] && eval $(dircolors -b $HOME/.dircolors)

[ -f ~/.zsh/aliases.zsh ] && source ~/.zsh/aliases.zsh
[ -f ~/.zsh/functions.zsh ] && source ~/.zsh/functions.zsh

#if command -v neofetch &> /dev/null ; then
#    neofetch
#elif command -v screenfetch &> /dev/null ; then
#    screenfetch
#fi

#if command -v cowsay &> /dev/null && command -v fortune &> /dev/null && command -v lolcat &> /dev/null; then
#    cowsay `fortune` | lolcat
#fi

banner

# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
[[ -f $HOME/git/hub/gb-studio/node_modules/tabtab/.completions/electron-forge.zsh ]] && . $HOME/git/hub/gb-studio/node_modules/tabtab/.completions/electron-forge.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

#########################
## https://starship.rs ##
#########################
if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
fi

###################################
## https://github.com/github/hub ##
###################################
if command -v hub &> /dev/null; then
    eval "$(hub alias -s)"
fi
