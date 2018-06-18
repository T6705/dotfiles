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
    else
        export EDITOR='vim'
    fi
else
    if command -v nvim &> /dev/null ; then
        export EDITOR='nvim'
    else
        export EDITOR='vim'
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

alias nethack-ascrun="ssh -Y nethack@ascension.run"

if command -v gem &> /dev/null ; then
    alias gemup="gem update --system && gem update && gem cleanup"
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

#Colorizing "cat" https://github.com/jingweno/ccat
if command -v ccat &> /dev/null ; then
    alias cat='ccat --bg=dark'
fi

# fast Vim that doesn't load a vimrc or plugins
alias vimn='vim -N -u NONE'
# fast Neovim that doesn't load a vimrc or plugins
alias nvimn='nvim -N -u NONE'

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

weather() {
    if [[ -n "$1" ]]; then
        curl wttr.in
    else
        curl wttr.in | tac | tac | head -n 7
    fi
}

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
    elif command -v ag &> /dev/null ; then
        export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
    fi

    # -----------------------------------------------------------------------------------------
    # Usage: fkill | kill process
    # -----------------------------------------------------------------------------------------
    fkill() {
      local pid
      pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

      if [ "x$pid" != "x" ]
      then
        echo $pid | xargs kill -${1:-9}
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
        include="yml,js,json,php,md,styl,pug,jade,html,config,py,cpp,c,go,hs,rb,conf,fa,lst"
        exclude=".config,.git,node_modules,vendor,build,yarn.lock,*.sty,*.bst,*.coffee,dist"
        rg_command='rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always" -g "*.{'$include'}" -g "!{'$exclude'}/*"'
        result=$(eval $rg_command $search | fzf --ansi --multi --reverse | awk -F ':' '{print $1":"$2":"$3}')
        files=$(echo $result | awk -F ':' '{print $1}')
        lines=$(echo $result | awk -F ':' '{print $2}')
        [[ -n "$files" ]] && ${EDITOR:-vim} +$lines $files
    }

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

# -----------------------------------------------------------------------------------------
# Usage: brightness <level> | adjust brightness
# -----------------------------------------------------------------------------------------
brightness() {
    if [[ -n "$1" ]]; then
        xrandr --output LVDS1 --brightness $1
    else
        echo "brightness <0-1>"
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

nerd-fonts-install() {
    time mkdir -p ~/git
    time rm -rf ~/git/nerd-fonts
    time git clone https://github.com/ryanoasis/nerd-fonts ~/git/nerd-fonts
    time ~/git/nerd-fonts/install.sh
}

nerd-fonts-update() {
    if [[ -d ~/git/nerd-fonts ]]; then
        time cd ~/git/nerd-fonts && time git pull
        time ./install.sh
    else
        nerd-fonts-install
    fi
}

edb-install() {
    echo "=============================================="
    echo "== edb - cross platform x86/x86-64 debugger =="
    echo "=============================================="
    currentdir=$(pwd)
    if command -v apt-get &> /dev/null ; then
        # install dependencies For Ubuntu >= 15.10
        sudo apt-get install -y    \
            cmake                  \
            build-essential        \
            libboost-dev           \
            libqt5xmlpatterns5-dev \
            qtbase5-dev            \
            qt5-default            \
            libqt5svg5-dev         \
            libgraphviz-dev        \
            libcapstone-dev
    elif command -v pacman &> /dev/null ; then
        sudo pacman -S --needed qt4 boost boost-libs capstone graphviz
        sudo pacman -S --needed $(pacman -Ssq qt | sort -u | grep -E "^qt5-")
    fi

    if [[ -d ~/git/edb-debugger ]]; then
        time rm -rf ~/git/edb-debugger && cd ~/git
    else
        mkdir -p ~/git && cd ~/git
    fi

    time git clone --recursive https://github.com/eteran/edb-debugger.git
    cd edb-debugger
    mkdir build && cd build
    time cmake -DCMAKE_INSTALL_PREFIX=/usr/local/ ..
    time make && time sudo make install && time edb --version && cd $currentdir
}

plasma-install() {
    echo "========================================================"
    echo "== plasma - interactive disassembler for x86/ARM/MIPS =="
    echo "========================================================"
    if command -v apt-get &> /dev/null ; then
        currentdir=$(pwd)
        if [[ -d ~/git/plasma ]]; then
            time rm -rf ~/git/plasma && cd ~/git
        else
            mkdir -p ~/git && cd ~/git
        fi
        time git clone https://github.com/plasma-disassembler/plasma
        cd plasma && time ./install.sh && cd $currentdir
    elif command -v pacman &> /dev/null ; then
        if command -v pacaur &> /dev/null ; then
            pacaur -S plasma-git
        else
            sudo pacman -S pacaur
            pacaur -S plasma-git
        fi
    fi
}

yuzu-install() {
    echo "======================================"
    echo "== yuzu -  Nintendo Switch Emulator =="
    echo "======================================"

    if command -v apt-get &> /dev/null ; then
        sudo apt-get install build-essential clang cmake libc++-dev libcurl4-openssl-dev libqt5opengl5-dev libsdl2-2.0-0 libsdl2-dev qtbase5-dev sdl2
    elif command -v pacman &> /dev/null ; then
        sudo pacman -S --needed base-devel clang cmake libcurl-compat qt5 sdl2
    fi

    currentdir=$(pwd)
    if [[ -d ~/git/yuzu ]]; then
        time rm -rf ~/git/yuzu && cd ~/git
    else
        mkdir -p ~/git && cd ~/git
    fi
    time git clone --recursive https://github.com/yuzu-emu/yuzu
    cd yuzu

    mkdir build && cd build
    cmake ../
    make
    sudo make install
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
# Docker functions
# -----------------------------------------------------------------------------------------
if command -v docker &> /dev/null ; then
    docker_alias_stop_all_containers() { docker stop $(docker ps -a -q); }
    docker_alias_remove_all_containers() { docker rm $(docker ps -a -q); }
    docker_alias_remove_all_empty_images() { docker images | awk '{print $2 " " $3}' | grep '^<none>' | awk '{print $2}' | xargs -I{} docker rmi {}; }
    docker_alias_docker_file_build() { docker build -t=$1 .; }
    docker_alias_show_all_docker_related_alias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }
    docker_alias_bash_into_running_container() { docker exec -it $(docker ps -aqf "name=$1") bash; }
fi

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
        docker run -d -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer

        if command -v firefox &> /dev/null; then
            firefox "http://127.0.0.1:9000"
        else
            echo "http://127.0.0.1:9000"
        fi
    }

    #Top-like interface for container metrics (https://github.com/bcicen/ctop)
    ctop() {
        docker run --rm -ti \
            --name=ctop \
            -v /var/run/docker.sock:/var/run/docker.sock \
            quay.io/vektorlab/ctop:latest
    }
fi
