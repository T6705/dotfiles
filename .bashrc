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

# improved less option
export LESS='--tabs=4 --no-init --LONG-PROMPT --ignore-case --quit-if-one-screen --RAW-CONTROL-CHARS'

export BETTER_EXCEPTIONS=1

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

PS1="\[\033[0;31m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]root\[\033[01;33m\]@\[\033[01;96m\]\h'; else echo '\[\033[0;39m\]\u\[\033[01;33m\]@\[\033[01;96m\]\h'; fi)\[\033[0;31m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;31m\]]\n\[\033[0;31m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]\[\e[01;33m\]\\$\[\e[0m\] "

if command -v go &> /dev/null; then
    [ ! -d $HOME/go ] && mkdir -p $HOME/go
    [ ! -d $HOME/go/bin ] && mkdir -p $HOME/go/bin
fi

[ -d $HOME/.cargo/bin ] && export PATH="$HOME/.cargo/bin:$PATH"
[ -d $HOME/.gem/ruby/2.5.0/bin ] && export PATH="$PATH:$HOME/.gem/ruby/2.5.0/bin"
[ -d $HOME/.pyenv ] && export PYENV_ROOT="$HOME/.pyenv" && export PATH="$PYENV_ROOT/bin:$PATH"
[ -d $HOME/go ] && export GOPATH="$HOME/go"
[ -d $HOME/go/bin ] && export GOBIN="$GOPATH/bin" && export PATH="$PATH:$GOPATH/bin"
[ -d /usr/games ] && export PATH="$PATH:/usr/games"
[ -d $HOME/bin ] && export PATH="$HOME/bin:$PATH"
[ -d /usr/local/bin ] && export PATH="/usr/local/bin:$PATH"

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

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

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

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias zshconfig="$EDITOR ~/.zshrc ~/.zsh/*"
alias ohmyzsh="$EDITOR ~/.oh-my-zsh"

alias cp="cp -v"
alias du="du -c"
alias mkdir='mkdir -p'
alias mv="mv -v"
alias rm='rm -v'

alias :q!="exit"
alias :q="exit"
alias :qa!="exit"
alias :qa="exit"
alias :qall!="exit"
alias :qall="exit"
alias fucking="sudo"

alias todo="$EDITOR ~/.todo"
alias notes="$EDITOR ~/.notes"

# Improve od for hexdump
alias od='od -Ax -tx1z'
alias hexdump='hexdump -C'

alias feh='feh -. -Z -B black'

if command -v tmux &> /dev/null ; then
    alias ta='tmux attach -t'
    alias tad='tmux attach -d -t'
    alias ts='tmux new-session -s'
    alias tl='tmux list-sessions'
    alias tksv='tmux kill-server'
    alias tkss='tmux kill-session -t'
fi

alias nethack-ascrun="ssh -Y nethack@ascension.run"

alias choregraphe='/opt/Softbank\ Robotics/Choregraphe\ Suite\ 2.5/bin/choregraphe-bin'

if command -v gem &> /dev/null ; then
    alias gemup="gem update --system && gem update && gem cleanup"
fi

if command -v exa &> /dev/null ; then
    alias ls="exa"
    alias la="exa -lahgimuU"
fi

if command -v firejail &> /dev/null ; then
    if command -v virtualbox &> /dev/null ; then alias virtualbox='firejail Virtualbox' ; fi
    if command -v mpv &> /dev/null ; then alias mpv='firejail mpv' ; fi
    if command -v vlc &> /dev/null ; then alias vlc='firejail vlc' ; fi
fi

if command -v python3 &> /dev/null ; then
    alias pywebserver-cgi="python -m http.server --cgi"
    alias pywebserver-local="python3 -m http.server --bind 127.0.0.1"
    alias pywebserver="python3 -m http.server"
elif command -v python2 &> /dev/null ; then
    alias pywebserver="python -m SimpleHTTPServer"
fi

if command -v youtube-dl &> /dev/null ; then
    alias mp3="youtube-dl --extract-audio --audio-format mp3"
fi

if command -v xclip &> /dev/null ; then
	alias xcopy='xclip -selection clipboard'
	alias xpaste='xclip -selection clipboard -o'
fi

if command -v tr &> /dev/null ; then
    alias rot13='tr a-zA-Z n-za-mN-ZA-M'
fi

if command -v clamscan &> /dev/null ; then
    alias checkvirus="clamscan --recursive=yes --infected ~/"
fi

if command -v freshclam &> /dev/null ; then
    alias updateantivirus="sudo freshclam"
fi

if command -v rkhunter &> /dev/null ; then
    alias checkrootkits="sudo rkhunter --update; sudo rkhunter --propupd; sudo rkhunter --check"
fi

if command -v bat &> /dev/null ; then
    alias cat='bat'
elif command -v ccat &> /dev/null ; then
    #Colorizing "cat" https://github.com/jingweno/ccat
    alias cat='ccat --bg=dark'
fi

if command -v vim &> /dev/null ; then
    if [ -f ~/minimal.vimrc ] ; then
        # fast Vim that doesn't load plugins
        alias vimn='vim -u ~/minimal.vimrc'
    fi
    # fast Vim that doesn't load a vimrc or plugins
    alias vimnn='vim -n -u NONE -i NONE -N'
fi

if command -v gvim &> /dev/null ; then
    if [ -f ~/minimal.vimrc ] ; then
        # fast gvim that doesn't load plugins
        alias gvimn='gvim -u ~/minimal.vimrc'
    fi
    # fast gvim that doesn't load a gvimrc or plugins
    alias gvimnn='gvim -n -u NONE -i NONE -N'
fi

if command -v nvim &> /dev/null ; then
    if [ -f ~/minimal.vimrc ] ; then
        # fast Neovim that doesn't load plugins
        alias nvimn='nvim -u ~/minimal.vimrc'
    fi
    # fast Neovim that doesn't load a vimrc or plugins
    alias nvimnn='nvim -u NONE -i NONE -N'
fi

if command -v git &> /dev/null ; then
    if command -v vim &> /dev/null ; then
        #vd - Edit all uncommitted files that have changes since the last commit (be they staged or unstaged)
        alias vd="vim \$(git diff HEAD --name-only --diff-filter=ACMR)"

        #vds - Edit all staged files that have changes since the last commit
        alias vds="vim \$(git diff --staged --name-only --diff-filter=ACMR)"

        #vdc - Edit all files that were altered in the last commit
        alias vdc="vim \$(git diff HEAD^ --name-only --diff-filter=ACMR)"
    fi

    if command -v nvim &> /dev/null ; then
        #vd - Edit all uncommitted files that have changes since the last commit (be they staged or unstaged)
        alias nvd="nvim \$(git diff HEAD --name-only --diff-filter=ACMR)"

        #nvds - Edit all staged files that have changes since the last commit
        alias nvds="nvim \$(git diff --staged --name-only --diff-filter=ACMR)"

        #nvdc - Edit all files that were altered in the last commit
        alias nvdc="nvim \$(git diff HEAD^ --name-only --diff-filter=ACMR)"
    fi
fi

# sshlf 1234:127.0.0.1:4321 name@127.0.0.1
alias sshlf="ssh -gNfL"
# sshrf 1234:127.0.0.1:4321 name@1.1.1.1
alias sshrf="ssh -NfR"

# ------------------------------------
# Docker alias
# ------------------------------------
if command -v docker &> /dev/null ; then
    # Stop all containers
    alias dstop='docker_alias_stop_all_containers'

    # Remove all containers
    alias drm='docker_alias_remove_all_containers'

    # Stop and Remove all containers
    alias drmf='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'

    # stop and remove all Exited containers
    alias drsc='docker rm $(docker ps -aq --filter status=exited)'

    # Docker remove image
    alias dri='docker rmi'

    # Remove all empty images
    alias drei='docker_alias_remove_all_empty_images'

    # Dockerfile build, e.g., $dbu tcnksm/test
    alias dbu='docker_alias_docker_file_build'

    # Show all alias related docker
    alias dalias='docker_alias_show_all_docker_related_alias'

    # Bash into running container
    alias dbash='docker_alias_bash_into_running_container'

    # Get latest container ID
    alias dl="docker ps -l -q"

    alias dp='docker ps --format="table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Status}}"'

    alias dclean='drmf && drei'

    # Get images
    alias di="docker images"

    # list all container
    alias dcla="docker container ls --all"

    # Get container IP
    alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"

    # Run deamonized container, e.g., $dkd base /bin/echo hello
    alias dkd="docker run -d -P"

    # Run interactive container, e.g., $dki base /bin/bash
    alias dki="docker run -i -t -P"

    # Run interactive container and then auto kill it
    alias drit='docker run --rm -i -t'

    # Execute interactive container, e.g., $dex base /bin/bash
    alias dex="docker exec -i -t"
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if [ -f "/google/devshell/bashrc.google" ]; then
  source "/google/devshell/bashrc.google"
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
eval $(dircolors -b $HOME/.dircolors)

#if ! command -v powerline-shell &> /dev/null ; then
#    curl "https://bootstrap.pypa.io/get-pip.py" > ~/get-pip.py
#    sudo python3 ~/get-pip.py
#    sudo pip install -U powerline-shell
#fi
#
#function _update_ps1() {
#    PS1="$(powerline-shell $?)"
#}
#
#if [ "$TERM" != "linux" ]; then
#    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
#fi

###############
## functions ##
###############
random_chiptune() {
    cat /dev/urandom | \
        hexdump -v -e '/1 "%u\n"' | \
        awk '{ split("0,3,5,6,7,10,12",a,","); \
        for (i = 0; i < 1; i+= 0.0001) \
        printf("%08X\n", 100*sin(1382*exp((a[$1 % 8]/12)*log(2))*i)) }' | \
        xxd -r -p | \
        aplay -c 2 -f S32_LE -r 24000
}

ramdisk_on() {
    if ! [[ -n "$1" ]]; then
        echo "ramdisk_on '<size>'"
        return
    fi

    if ! [[ -d "/mnt/ramdisk" ]]; then
        size=$1
        echo " * create mount point '/mnt/ramdisk'"
        sudo mkdir -p /mnt/ramdisk
    fi

    echo "create ramdisk with size: $size"
    sudo mount -t tmpfs tmpfs /mnt/ramdisk -o size=$size

    echo ""
    df -h | grep ramdisk
}

if ! command -v trim_string &> /dev/null ; then
    trim_string() {
        # Usage: trim_string "   example   string    "
        : "${1#"${1%%[![:space:]]*}"}"
        : "${_%"${_##*[![:space:]]}"}"
        printf '%s\n' "$_"
    }
fi

if ! command -v trim_all &> /dev/null ; then
    trim_all() {
        # Usage: trim_all "   example   string    "
        set -f
        set -- $*
        printf '%s\n' "$*"
        set +f
    }
fi

if ! command -v trim_quotes &> /dev/null ; then
    trim_quotes() {
        # Usage: trim_quotes "string"
        : "${1//\'}"
        printf '%s\n' "${_//\"}"
    }
fi


if ! command -v regex &> /dev/null ; then
    regex() {
        # Usage: regex "string" "regex"
        [[ $1 =~ $2 ]] && printf '%s\n' "${BASH_REMATCH[1]}"
    }
fi

if ! command -v split &> /dev/null ; then
    split() {
       # Usage: split "string" "delimiter"
       IFS=$'\n' read -d "" -ra arr <<< "${1//$2/$'\n'}"
       printf '%s\n' "${arr[@]}"
    }
fi

if ! command -v lower &> /dev/null ; then
    lower() {
        # Usage: lower "string"
        printf '%s\n' "${1,,}"
    }
fi

if ! command -v upper &> /dev/null ; then
    upper() {
        # Usage: upper "string"
        printf '%s\n' "${1^^}"
    }
fi


if ! command -v strip_all &> /dev/null ; then
    strip_all() {
        # Usage: strip_all "string" "pattern"
        printf '%s\n' "${1//$2}"
    }
fi


if ! command -v strip &> /dev/null ; then
    strip() {
        # Usage: strip "string" "pattern"
        printf '%s\n' "${1/$2}"
    }
fi

if ! command -v lstrip &> /dev/null ; then
    lstrip() {
        # Usage: lstrip "string" "pattern"
        printf '%s\n' "${1##$2}"
    }
fi

if ! command -v rstrip &> /dev/null ; then
    rstrip() {
        # Usage: rstrip "string" "pattern"
        printf '%s\n' "${1%%$2}"
    }
fi

if ! command -v reverse_array &> /dev/null ; then
    reverse_array() {
        # Usage: reverse_array "array"
        shopt -s extdebug
        f()(printf '%s\n' "${BASH_ARGV[@]}"); f "$@"
        shopt -u extdebug
    }
fi

if ! command -v random_array_element &> /dev/null ; then
    random_array_element() {
        # Usage: random_array_element "array"
        local arr=("$@")
        printf '%s\n' "${arr[RANDOM % $#]}"
    }
fi

if ! command -v head &> /dev/null ; then
    head() {
        # Usage: head "n" "file"
        mapfile -tn "$1" line < "$2"
        printf '%s\n' "${line[@]}"
    }
fi

if ! command -v head &> /dev/null ; then
    tail() {
        # Usage: tail "n" "file"
        mapfile -tn 0 line < "$2"
        printf '%s\n' "${line[@]: -$1}"
    }
fi

if ! command -v hex_to_rgb &> /dev/null ; then
    hex_to_rgb() {
        # Usage: hex_to_rgb "#FFFFFF"
        #        hex_to_rgb "000000"
        : "${1/\#}"
        ((r=16#${_:0:2},g=16#${_:2:2},b=16#${_:4:2}))
        printf '%s\n' "$r $g $b"
    }
fi

if ! command -v bkr &> /dev/null ; then
    bkr() {
        # Usage: bkr ./some_script.sh # some_script.sh is now running in the background
        (nohup "$@" &>/dev/null &)
    }
fi

repeat_cmd() {
    while [ -n "$2" ]; do
        eval "$2"
        sleep $1
    done
}

man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        man "$@"
}

screenshot() {
    if ! command -v maim &> /dev/null; then
        notify-send "maim is not installed"
        exit
    fi

    SCREENSHOTS_DIR=~/Screenshots
    TIMESTAMP="$(date +%Y.%m.%d-%H.%M.%S)"
    FILENAME=$SCREENSHOTS_DIR/$TIMESTAMP.screenshot.png
    PHOTO_ICON_PATH=/usr/share/icons/Papirus/64x64/devices/camera-photo.svg
    GIMP_ICON_PATH=/usr/share/icons/Papirus/64x64/apps/gimp.svg

    if ! [ -d ~/Screenshots ]; then
        mkdir ~/Screenshots
        #notify-send "Create dir '$HOME/Screenshots'" --urgency low
    fi

    if ! [ -f "$PHOTO_ICON_PATH" ]; then
        PHOTO_ICON_PATH=$(find /usr/share/icons -type f -iname "camera*" | grep -vE "16x16|22x22|24x24|32x32|symbolic" | shuf | tail -n 1)
        #notify-send "$PHOTO_ICON_PATH"
    fi

    if ! [ -f "$GIMP_ICON_PATH" ]; then
        GIMP_ICON_PATH=$(find /usr/share/icons -type f -iname "gimp*" | grep -vE "16x16|22x22|24x24|32x32|symbolic" | shuf | tail -n 1)
        #notify-send "$GIMP_ICON_PATH"
    fi

    # -u option hides cursor
    # -m option changes the compression level
    #   -m 3 takes the shot faster but the file size is slightly bigger

    if [[ "$1" = "-s" ]]; then
        # Area/window selection.
        notify-send 'Select area to capture.' --urgency low -i $PHOTO_ICON_PATH
        maim -u -m 3 -s "$FILENAME"
        if [[ "$?" = "0" ]]; then
            notify-send "Screenshot taken." --urgency low -i $PHOTO_ICON_PATH
        fi
    elif [[ "$1" = "-c" ]]; then
        notify-send 'Select area to copy to clipboard.' --urgency low -i $PHOTO_ICON_PATH
        # Copy selection to clipboard
        #maim -u -m 3 -s | xclip -selection clipboard -t image/png
        maim -u -m 3 -s /tmp/maim_clipboard
        if [[ "$?" = "0" ]]; then
            xclip -selection clipboard -t image/png /tmp/maim_clipboard
            notify-send "Copied selection to clipboard." --urgency low -i $PHOTO_ICON_PATH
            rm /tmp/maim_clipboard
        fi
    elif [[ "$1" = "-b" ]]; then
        # Browse with feh
        cd $SCREENSHOTS_DIR ; feh $(ls -t) &
    elif [[ "$1" = "-e" ]]; then
        # Edit last screenshot with GIMP
        cd $SCREENSHOTS_DIR ; gimp $(ls -t | head -n1) & notify-send 'Opening last screenshot with GIMP' --urgency low -i $GIMP_ICON_PATH
    elif [[ "$1" = "-h" ]]; then
        # help
        echo " -s   Area/window selection"
        echo " -c   Copy selection to clipboard"
        echo " -b   Browse with feh"
        echo " -e   Edit last screenshot with GIMP"
    else
        # Full screenshot
        maim -u -m 3 $FILENAME
        notify-send "Screenshot taken." --urgency low -i $PHOTO_ICON_PATH
    fi
}

banner() {
    if command -v figlet &> /dev/null ; then
        if command -v lolcat &> /dev/null ; then
            figlet " $(hostname)" | lolcat -f
        else
            figlet " $(hostname)"
        fi
    fi

    # get load averages
    IFS=" " read LOAD1 LOAD5 LOAD15 <<<$(/bin/cat /proc/loadavg | awk '{ print $1,$2,$3 }')
    # get free memory
    IFS=" " read USED FREE TOTAL <<<$(free -htm | grep "Mem" | awk {'print $3,$4,$2'})
    # get processes
    PROCESS=`ps -eo user=|sort|uniq -c | awk '{ print $2 " " $1 }'`
    PROCESS_ALL=`echo "$PROCESS"| awk {'print $2'} | awk '{ SUM += $1} END { print SUM }'`
    PROCESS_ROOT=`echo "$PROCESS"| grep root | awk {'print $2'}`
    PROCESS_USER=`echo "$PROCESS"| grep -v root | awk {'print $2'} | awk '{ SUM += $1} END { print SUM }'`

    W="\e[0;39m"
    G="\e[1;32m"

    echo -e "
  system info:
      Distro......: $W`cat /etc/*release | grep "PRETTY_NAME" | cut -d "=" -f 2- | sed 's/"//g'`
      Kernel......: $W`uname -sr`

      Uptime......: $W`uptime -p`
      Load........: $G$LOAD1$W (1m), $G$LOAD5$W (5m), $G$LOAD15$W (15m)
      Processes...:$W $G$PROCESS_ROOT$W (root), $G$PROCESS_USER$W (user) | $G$PROCESS_ALL$W (total)

      CPU.........: $W`cat /proc/cpuinfo | grep "model name" | cut -d ' ' -f3- | awk {'print $0'} | head -1`
      Memory......: $G$USED$W used, $G$FREE$W free, $G$TOTAL$W in total$W"

    mountpoints=('/')
    barWidth=50
    maxDiscUsage=90
    clear="\e[39m\e[0m"
    dim="\e[2m"
    barclear=""
    echo

    for point in "${mountpoints[@]}"; do
        line=$(df -h "${point}")
        usagePercent=$(echo "$line"|tail -n1|awk '{print $5;}'|sed 's/%//')
        usedBarWidth=$((($usagePercent*$barWidth)/100))
        barContent=""
        color="\e[32m"
        if [ "${usagePercent}" -ge "${maxDiscUsage}" ]; then
            color="\e[31m"
        fi
        barContent="${color}"
        for sep in $(seq 1 $usedBarWidth); do
            barContent="${barContent}|"
        done
        barContent="${barContent}${clear}${dim}"
        for sep in $(seq 1 $(($barWidth-$usedBarWidth))); do
            barContent="${barContent}-"
        done
        bar="[${barContent}${clear}]"
        echo "  ${line}" | awk  '{if ($1 != "Filesystem") printf("%-30s%+3s used out of %+5s\n", $1, $3, $2); }' | sed -e 's/^/      /'
        echo -e "  ${bar}" | sed -e 's/^/    /'
    done

    echo ""
}

weather() {
    if [[ -n "$1" ]]; then
        curl wttr.in
    else
        curl wttr.in | tac | tac | head -n 7
    fi
}

if command -v chromium &> /dev/null ; then
    proxy_chromium() {
        #ssh -CNTvD port user@host
        if [[ -n "$1" ]]; then
            port=$1
            chromium --proxy-server="socks://localhost:$port" &
            exit
        else
            echo "proxy_chromium <port>"
        fi
    }
fi

if command -v cower &> /dev/null ; then
    coweri() {
        if [[ -n "$1" ]]; then
            currentdir=$(pwd)
            if [[ ! ( -d ~/.cache/cower ) ]]; then
                mkdir -p -v ~/.cache/cower
            fi

            cd ~/.cache/cower
            if [[ ( -d ~/.cache/cower/$1 ) ]]; then
                whattodo="r"
                vared -p "~/.cache/cower/$1 already exists, (o)verwrite/(r)emove? : " -c whattodo
                [[ "$whattodo" == "o" ]] && cower -df $1 && cd $1
                [[ "$whattodo" == "r" ]] && rm -rf ~/.cache/cower/$1 && cower -d $1 && cd $1
            else
                cower -d $1 && cd $1
            fi
            $EDITOR PKGBUILD

            ans="y"
            vared -p "Install $1?: " -c ans
            [[ "$ans" == "y" ]] && makepkg -is && cd $currentdir
        fi
    }
fi

# -----------------------------------------------------------------------------------------
# fzf
# -----------------------------------------------------------------------------------------
if command -v fzf &> /dev/null ; then
    if command -v rg &> /dev/null ; then
        export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
    elif command -v fd &> /dev/null; then
        export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    elif command -v ag &> /dev/null ; then
        export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
    fi

    # -----------------------------------------------------------------------------------------
    # Usage: kp | kill Process
    # -----------------------------------------------------------------------------------------
    kp() {
        local pid
        pid=$(ps -ef | sed 1d | fzf -m --header='[kill:process]' | awk '{print $2}')

        if [ "x$pid" != "x" ]
        then
            echo $pid | xargs kill -${1:-9}
        fi
    }

    # -----------------------------------------------------------------------------------------
    # Usage: ks | kill Server
    # -----------------------------------------------------------------------------------------
    ks() {
        local pid
        pid=$(lsof -Pwni tcp | sed 1d | fzf -m --header="[kill:tcp]" | awk '{print $2}')

        if [ "x$pid" != "x" ]
        then
            echo $pid | xargs kill -${1:-9}
            ks
        fi
    }

    # -----------------------------------------------------------------------------------------
    # tm - create new tmux session, or switch to existing one. Works from within tmux too. (@bag-man)
    # `tm` will allow you to select your tmux session via fzf.
    # `tm irc` will attach to the irc session (if it exists), else it will create it.
    # -----------------------------------------------------------------------------------------

    tm() {
        [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
        if [ $1 ]; then
            tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
        fi
        session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
    }

    # -----------------------------------------------------------------------------------------
    # Usage: sf <keyword>
    # -----------------------------------------------------------------------------------------
    sf() {
        if [[ "$#" -lt 1 ]]; then echo "Supply string to search for!"; return 1; fi
        printf -v search "%q" "$*"
        rg_command='rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"'
        result=$(eval $rg_command $search | fzf --ansi --multi --reverse | awk -F ':' '{print $1":"$2":"$3}')
        files=$(echo $result | awk -F ':' '{print $1}')
        lines=$(echo $result | awk -F ':' '{print $2}')
        [[ -n "$files" ]] && ${EDITOR:-vim} +$lines $files
    }

    # -----------------------------------------------------------------------------------------
    # Usage: ea <keyword> | edit all file contain <keyword>
    # -----------------------------------------------------------------------------------------
    ea() {
        if [[ "$#" -lt 1 ]]; then echo "Supply string to search for!"; return 1; fi
        printf -v search "%q" "$*"
        rg_command='rg --ignore-case --no-ignore --hidden --follow --files-with-matches'
        result=$(eval $rg_command $search)
        [[ -n "$result" ]] && ${EDITOR:-vim} $(echo $result | xargs)
    }

    if [ "$EDITOR" = "nvim" ] || [ "$EDITOR" = "vim" ] ; then
        # -----------------------------------------------------------------------------------------
        # Usage: vimf | list subdirectories recursively with preview
        # -----------------------------------------------------------------------------------------
        vimf() {
            previous_file="$1"
            file_to_edit=$(select_file $previous_file)

            if [[ -n "$file_to_edit"  ]]; then
                $EDITOR "$file_to_edit"
                vimf "$file_to_edit"
            fi
        }

        select_file() {
            given_file="$1"
            fzf --preview-window right:70%:wrap --query "$given_file" --preview '[[ $(file --mime {}) =~ binary ]] &&
                                                                                    echo {} is a binary file ||
                                                                                    (rougify {} ||
                                                                                    highlight -O ansi -l {} ||
                                                                                    coderay {} ||
                                                                                    cat {}) 2> /dev/null | head -500'
        }
    fi
fi

# -----------------------------------------------------------------------------------------
# Usage: brightness <level> | adjust brightness
# -----------------------------------------------------------------------------------------
brightness() {
    if [[ -n "$1" ]] && [[ -n "$2" ]]; then
        xrandr --output $1 --brightness $2
    else
        connected_displays=$(xrandr | grep " connected" | awk '{print $1}')
        echo "brightness <connected_displays> <0-1>"
        echo ""
        echo "connected_display:"
        echo "$connected_displays"
    fi
}

2display() {
    # display screen information
    #xrandr
    # LVDS1 as primary monitor, HDMI1 right of LVDS1
    #xrandr --output LVDS1 --auto --primary --output HDMI1 --auto --right-of LVDS1
    connected_displays=$(xrandr | grep " connected" | awk '{print $1}')
    echo $connected_displays

    vared -p "main display : " -c main
    vared -p "second display : " -c second

    [[ $connected_displays =~ "$main" ]] &&
        [[ $connected_displays =~ "$second" ]] &&
            [[ "$main" != "$second" ]] &&
                xrandr --output $main --auto --primary --output $second --auto --right-of $main
}

mirrordisplay() {
    connected_displays=$(xrandr | grep " connected" | awk '{print $1}')

    echo $connected_displays

    vared -p "main display : "  -c main
    vared -p "second display : " -c second

    [[ $connected_displays =~ "$main" ]] &&
        [[ $connected_displays =~ "$second" ]] &&
            [[ "$main" != "$second" ]] &&
                xrandr --output $main --auto --primary --output $second --auto --same-as $main

    #[[ $connected_displays =~ "$main" ]] && echo "1ok"
    #[[ $connected_displays =~ "$second" ]] && echo "2ok"
    #[[ "$main" != "$second" ]] && echo "3ok"
}

# -----------------------------------------------------------------------------------------
# Usage: ipv4_in <filename> | grep ipv4 in file
# -----------------------------------------------------------------------------------------
ipv4_in() {
    if [[ -n "$1" ]]; then
        regex='([0-9]{1,3}\.){3}[0-9]{1,3}'
        grep -oE "$regex" $1
    else
        echo "'$1' is not a valid file"
    fi
}

# -----------------------------------------------------------------------------------------
# Usage: ipv6_in <filename> | grep ipv4 in file
# -----------------------------------------------------------------------------------------
ipv6_in() {
    if [[ -n "$1" ]]; then
        regex='(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))'
        grep -oE "$regex" $1
    else
        echo "'$1' is not a valid file"
    fi
}

# -----------------------------------------------------------------------------------------
# Usage: url_in <filename> | grep url in file
# -----------------------------------------------------------------------------------------
url_in() {
    if [[ -n "$1" ]]; then
        regex="(http[s]?|ftp|file)://[a-zA-Z0-9][a-zA-Z0-9_-]*(\.[a-zA-Z0-9][a-zA-Z0-9_-]*)*(:\d\+)?(\/[a-zA-Z0-9_/.\-+%?&=;@$,!''*~-]*)?(#[a-zA-Z0-9_/.\-+%#?&=;@$,!''*~]*)?"
        grep -oE "$regex" $1
    else
        echo "'$1' is not a valid file"
    fi
}

# -------------------------------------------------------------------
# Show how much RAM application uses.
# $ ram safari
# # => safari uses 154.69 MBs of RAM.
# from https://github.com/paulmillr/dotfiles
# -------------------------------------------------------------------
ram() {
    local sum
    local items
    local app="$1"
    if [[ -z "$app" ]]; then
        echo "First argument - pattern to grep from processes"
    else
        sum=0
        for i in $(ps aux | grep -i "$app" | grep -v "grep" | awk '{print $6}'); do
            sum=$(($i + $sum))
        done
        sum=$(echo "scale=2; $sum / 1024.0" | bc)
        if [[ $sum != "0" ]]; then
            echo "${fg[blue]}${app}${reset_color} uses ${fg[green]}${sum}${reset_color} MBs of RAM."
        else
            echo "There are no processes with pattern '${fg[blue]}${app}${reset_color}' are running."
        fi
    fi
}

# -----------------------------------------------------------------------------------------
# Usage: extract_frame <filename>
# -----------------------------------------------------------------------------------------
extract_frame() {
    echo "Extracting frame from $1 ..."
    if [[ -f $1 ]]; then
        mkdir -p frame
        time ffmpeg -i $1 frame/frame%09d.bmp
        cd frame
    else
        echo "'$1' is not a valid file"
    fi
}

# -----------------------------------------------------------------------------------------
# Usage: gz <filename> | get gzipped size
# -----------------------------------------------------------------------------------------
gz() {
    echo -n "\noriginal  size  (bytes): "
    cat "$1" | wc -c
    echo -n "\ngzipped   size  (bytes): "
    gzip -c "$1" | wc -c
    echo -n "\ngzipped -9 size (bytes): "
    gzip -c -9 "$1" | wc -c
}

# -----------------------------------------------------------------------------------------
# Usage: extract <filename>
# -----------------------------------------------------------------------------------------
extract() {
    echo Extracting $1 ...
    if [[ -f $1 ]]; then
        case $1 in
            *.7z)       7z x $1       ;;
            *.Z)        uncompress $1 ;;
            *.bz2)      bunzip2 $1    ;;
            *.gz)       gunzip $1     ;;
            *.rar)      unrar x $1    ;;
            *.tar)      tar xvf $1    ;;
            *.tar.bz2)  tar xjvf $1   ;;
            *.tar.gz)   tar xzvf $1   ;;
            *.tar.xz)   tar xvf $1    ;;
            *.tbz2)     tar xjvf $1   ;;
            *.tgz)      tar xzvf $1   ;;
            *.zip)      unzip $1      ;;
            *)        echo "'$1' cannot be extracted via extract" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# -----------------------------------------------------------------------------------------
# Usage: compress <file> (<type>)
# -----------------------------------------------------------------------------------------
compress() {
    if [[ -e $1 ]]; then
        if [[ $2 ]]; then
            case $2 in
                bz2 | bzip2)    bzip2           $1                 ;;
                gpg)            gpg -e --default-recipient-self $1 ;;
                gz | gzip)      gzip $1                            ;;
                tar)            tar -cvf $1.$2  $1                 ;;
                tar.Z)          tar -Zcvf $1.$2 $1                 ;;
                tbz2 | tar.bz2) tar -jcvf $1.$2 $1                 ;;
                tgz | tar.gz)   tar -zcvf $1.$2 $1                 ;;
                zip)            zip -r $1.$2    $1                 ;;
                *)
                    echo "Error: $2 is not a valid compression type"
                    ;;
            esac
        else
            compress $1 tar.gz
        fi
    else
        echo "File ('$1') does not exist!"
    fi
}

#sshlf() {
#    localport=$1
#    targethost=$2
#    targetport=$3
#    remoteaccount=$4
#    remotehost=$5
#    remotesshport=$6
#    keyfile=$7
#
#    if [[ "$#" -eq 5 ]]; then
#        echo "127.0.0.1:$localport --> $remotehost --> $targethost:$targetport"
#        ssh -gNfL $localport:$targethost:$targetport $remoteaccount@$remotehost
#    elif [[ "$#" -eq 6 ]]; then
#        echo "127.0.0.1:$localport --> $remotehost --> $targethost:$targetport"
#        ssh -p $remotesshport -gNfL $localport:$targethost:$targetport $remoteaccount@$remotehost
#    elif [[ "$#" -eq 7 ]]; then
#        echo "127.0.0.1:$localport --> $remotehost --> $targethost:$targetport"
#        ssh -i $keyfile -p $remotesshport -gNfL $localport:$targethost:$targetport $remoteaccount@$remotehost
#    else
#        echo "Usage: sshlf <localport> <targethost> <targetport> <remoteaccount> <remotehost> <remotesshport> <keyfile>"
#        echo "127.0.0.1:localport --> remotehost --> targethost:targetport"
#    fi
#}

#sshrf() {
#    localport=$1
#    remoteaccount=$2
#    remotehost=$3
#    remoteport=$4
#    remotepsshport=$5
#    keyfile=$6
#
#    if [[ "$#" -eq 4 ]]; then
#        echo "$remotehost:$remoteport --> 127.0.0.1:$localport"
#        ssh -NfR $remoteport:127.0.0.1:$localport $remoteaccount@$remotehost
#    elif [[ "$#" -eq 5 ]]; then
#        echo "$remotehost:$remoteport --> 127.0.0.1:$localport"
#        ssh -p $remotesshport -NfR $remoteport:127.0.0.1:$localport $remoteaccount@$remotehost
#    elif [[ "$#" -eq 6 ]]; then
#        echo "$remotehost:$remoteport --> 127.0.0.1:$localport"
#        ssh -i $keyfile -p $remotesshport -NfR $remoteport:127.0.0.1:$localport $remoteaccount@$remotehost
#    else
#        echo "Usage: sshrf <localport> <remoteaccount> <remotehost> <remoteport> <remotesshport> <keyfile>"
#        echo "remotehost:remoteport --> 127.0.0.1:localport"
#    fi
#}

# -----------------------------------------------------------------------------------------
# Usage: base64key <keyname> <keysize>
# -----------------------------------------------------------------------------------------
base64key() {
    if [[ ( -n $1 && -n $2 ) ]]; then
        keyname=$1
        size=$2
        time openssl rand -base64 -out $keyname $size
    else
        echo "Usage: base64key <keyname> <keysize>"
    fi
}

rsa() {
    if [[ $1 == "keygen" ]]; then
        if [[ ( -n $2 && -n $3 ) ]]; then
            pri=$2
            size=$3
            pub="$pri.pub"
            time openssl genrsa -out $pri $size
            time openssl rsa -in $pri -out $pub -outform PEM -pubout
        else
            echo "Usage: rsa keygen <keyname> <keysize>"
        fi
    elif [[ ( $1 == "encrypt" || $1 == "e" )]]; then
        if [[ ( -n $2 && -n $3 && -n $4) ]]; then
            pub=$2
            infile=$3
            outfile=$4
            time openssl rsautl -encrypt -inkey $pub -pubin -in $infile -out $outfile
        else
            echo "Usage: rsa encrypt <pubkey> <infile> <outfile>"
        fi
    elif [[ ( $1 == "decrypt" || $1 == "d" ) ]]; then
        if [[ ( -n $2 && -n $3 && -n $4) ]]; then
            pri=$2
            infile=$3
            outfile=$4
            time openssl rsautl -decrypt -inkey $pri -in $infile -out $outfile
        else
            echo "Usage: rsa decrypt <prikey> <infile> <outfile>"
        fi
    else
        echo "Usage:"
        echo "rsa keygen <keyname> <keysize>"
        echo "rsa encrypt <pubkey> <infile> <outfile>"
        echo "rsa decrypt <prikey> <infile> <outfile>"
    fi
}

aes() {
    if [[ ( $1 == "encrypt" || $1 == "e" ) ]]; then
        if [[ ( -n $2 && -n $3 && -n $4 ) ]]; then
            infile=$2
            outfile=$3
            keyfile=$4
            #time openssl aes-256-cbc -a -salt -in $infile -out $outfile -kfile $keyfile
            time openssl enc -aes-256-cbc -a -salt -in $infile -out $outfile -pass file:$keyfile
        elif [[ ( -n $2 && -n $3 ) ]]; then
            infile=$2
            outfile=$3
            #time openssl aes-256-cbc -a -salt -in $infile -out $outfile
            time openssl enc -aes-256-cbc -a -salt -in $infile -out $outfile
        else
            echo "Usage:"
            echo "aes encrypt <infile> <outfile>"
            echo "aes encrypt <infile> <outfile> <keyfile>"
        fi
    elif [[ $1 == "decrypt" || $1 == "d" ]]; then
        if [[ ( -n $2 && -n $3 && -n $4 ) ]]; then
            infile=$2
            outfile=$3
            keyfile=$4
            #time openssl aes-256-cbc -d -a -in $infile -out $outfile -kfile $keyfile
            time openssl enc -aes-256-cbc -d -a -in $infile -out $outfile -pass file:$keyfile
        elif [[ ( -n $2 && -n $3 ) ]]; then
            infile=$2
            outfile=$3
            #time openssl aes-256-cbc -d -a -in $infile -out $outfile
            time openssl enc -aes-256-cbc -d -a -in $infile -out $outfile
        else
            echo "Usage:"
            echo "aes decrypt <infile> <outfile>"
            echo "aes decrypt <infile> <outfile> <keyfile>"
        fi
    else
        echo "Usage:"
        echo "aes encrypt <infile> <outfile>"
        echo "aes encrypt <infile> <outfile> <keyfile>"
        echo "aes decrypt <infile> <outfile>"
        echo "aes decrypt <infile> <outfile> <keyfile>"
    fi
}

# -----------------------------------------------------------------------------------------
# Usage: viewimg <filename> | display image in terminal
# -----------------------------------------------------------------------------------------
if command -v w3m &> /dev/null && [[ -f /usr/lib/w3m/w3mimgdisplay ]]; then
    viewimg() {
        w3m -o imgdisplay=/usr/lib/w3m/w3mimgdisplay -o ext_image_viewer=N $1
    }
fi

# -----------------------------------------------------------------------------------------
# Usage: $ (tor-)transfer hello.txt | Function for upload file to https://transfer.sh/
# -----------------------------------------------------------------------------------------
tor-transfer() {
    torIp=127.0.0.1
    torPort=9050

    if [ $# -eq 0 ]; then
        echo -e "No arguments specified. Usage:\necho tor-transfer /tmp/test.md\ncat /tmp/test.md | tor-transfer test.md";
        return 1;
    fi

    torstatus=$(systemctl status tor | grep Active | cut -d":" -f2 | cut -d" " -f2)
    if [[ -n "$torstatus" ]] && [[ "$torstatus" == "active" ]];then
        tmpfile=$( mktemp -t transferXXX );
        if tty -s; then
            basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g');
            curl --socks5-hostname ${torIp}:${torPort} --retry 3 --connect-timeout 60 --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile;
        else
            curl --socks5-hostname ${torIp}:${torPort} --retry 3 --connect-timeout 60 --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ;
        fi;
        echo ""
        cat $tmpfile;
        echo ""
        rm -f $tmpfile;
    else
        echo "tor is inactive"
        return 1;
    fi
}

transfer() {
    if [ $# -eq 0 ]; then
        echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md";
        return 1;
    fi

    tmpfile=$( mktemp -t transferXXX );
    if tty -s; then
        basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g');
        curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile;
    else
        curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ;
    fi;
    echo ""
    cat $tmpfile;
    echo ""
    rm -f $tmpfile;
}

# -----------------------------------------------------------------------------------------
# nethack NAO
# -----------------------------------------------------------------------------------------
nethack-nao() {
    if [[ -z "$DGLAUTH" ]]; then
        echo "DGLAUTH is empty"
        echo "value : "
        read -r value
        export DGLAUTH="$value"
        ssh -Y -o SendEnv=DGLAUTH nethack@alt.org
    else
        ssh -Y -o SendEnv=DGLAUTH nethack@alt.org
    fi
}

nethack-nao-game-status() {
    if [[ -z "$1" ]]; then
        url="https://alt.org/nethack/mostrecent.php"
        if command -v firefox &> /dev/null ; then
            firefox $url
        else
            echo "$url"
        fi
    else
        url="https://alt.org/nethack/player-all.php?player=$1"
        if command -v firefox &> /dev/null ; then
            firefox $url
        else
            echo "$url"
        fi
    fi
}

# -----------------------------------------------------------------------------------------
# Dungeon Crawl Stone Soup (crawl.jorgrun.rocks [Montreal, Canada])
# -----------------------------------------------------------------------------------------
crawl-cjr() {
    if [[ -f ~/.ssh/jorgrun_key ]]; then
        ssh -Y -i ~/.ssh/jorgrun_key jorgrun@crawl.jorgrun.rocks
    else
        curl -fLo ~/.ssh/jorgrun_key --create-dirs https://crawl.jorgrun.rocks/ssh/jorgrun_key
        chmod 600 ~/.ssh/jorgrun_key
        crawl-cjr
    fi
}

# -----------------------------------------------------------------------------------------
# Dungeon Crawl Stone Soup (crawl.akrasiac.org [Arizona, United States of America])
# -----------------------------------------------------------------------------------------
crawl-cao() {
    if [[ -f ~/.ssh/cao_key ]]; then
        ssh -Y -i ~/.ssh/cao_key joshua@crawl.akrasiac.org
    else
        curl -fLo ~/.ssh/cao_key --create-dirs http://crawl.develz.org/cao_key
        chmod 600 ~/.ssh/cao_key
        crawl-cao
    fi
}

# ------------------------------------
# Docker functions
# ------------------------------------

if command -v docker &> /dev/null ; then
    docker_alias_stop_all_containers() { docker stop $(docker ps -a -q); }
    docker_alias_remove_all_containers() { docker rm $(docker ps -a -q); }
    docker_alias_remove_all_empty_images() { docker images | awk '{print $2 " " $3}' | grep '^<none>' | awk '{print $2}' | xargs -I{} docker rmi {}; }
    docker_alias_docker_file_build() { docker build -t=$1 .; }
    docker_alias_show_all_docker_related_alias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }
    docker_alias_bash_into_running_container() { docker exec -it $(docker ps -aqf "name=$1") bash; }

    #open-source lightweight management UI for Docker hosts or Swarm clusters
    portainer() {
        docker volume create portainer_data
        docker run -d --name=portainer -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer

        if command -v firefox &> /dev/null; then
            firefox "http://127.0.0.1:9000"
        else
            echo "http://127.0.0.1:9000"
        fi
    }

    # A visualizer for Docker Swarm Mode using the Docker Remote API, Node.JS, and D3
    visualizer() {
        $image="dockersamples/visualizer"

        cpu_architecture=$(lscpu | grep "Architecture:" | awk '{print $2}')

        if [[ $cpu_architecture =~ "*arm*" ]]; then
            $image="alexellis2/visualizer-arm:latest"
        fi

        docker run -rm -it -d \
            -name visualizer
            -p 8080:8080 \
            -v /var/run/docker.sock:/var/run/docker.sock \
            $image
    }

    #Top-like interface for container metrics (https://github.com/bcicen/ctop)
    ctop() {
        docker run --rm -ti \
            --name=ctop \
            -v /var/run/docker.sock:/var/run/docker.sock \
            quay.io/vektorlab/ctop:latest
    }
fi

banner
