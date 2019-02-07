export QT_QPA_PLATFORMTHEME="qt5ct"
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


# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=1

# export MANPATH="/usr/local/man:$MANPATH"
[ -d $HOME/.cargo/bin ] && export PATH="$HOME/.cargo/bin:$PATH"
[ -d $HOME/.gem/ruby/2.5.0/bin ] && export PATH="$PATH:$HOME/.gem/ruby/2.5.0/bin"
[ -d $HOME/.pyenv ] && export PYENV_ROOT="$HOME/.pyenv" && export PATH="$PYENV_ROOT/bin:$PATH"
[ -d $HOME/go ] && export GOPATH="$HOME/go"
[ -d $HOME/go/bin ] && export GOBIN="$GOPATH/bin" && export PATH="$PATH:$GOPATH/bin"
[ -d /usr/games ] && export PATH="$PATH:/usr/games"
[ -d $HOME/bin ] && export PATH="$HOME/bin:$PATH"
[ -d /usr/local/bin ] && export PATH="/usr/local/bin:$PATH"

if command -v nvim &> /dev/null ; then
    export EDITOR='nvim'
elif command -v vim &> /dev/null ; then
    export EDITOR='vim'
elif command -v vi &> /dev/null ; then
    export EDITOR='vi'
fi

if command -v nvim &> /dev/null ; then
    export EDITOR='nvim'
elif command -v vim &> /dev/null ; then
    export EDITOR='vim'
elif command -v vi &> /dev/null ; then
    export EDITOR='vi'
fi
