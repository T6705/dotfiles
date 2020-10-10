#############
## aliases ##
#############
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

alias nethack-ascrun="ssh -Y nethack@ascension.run"

alias choregraphe='/opt/Softbank\ Robotics/Choregraphe\ Suite\ 2.5/bin/choregraphe-bin'

if command -v gem &> /dev/null ; then
    alias gemup="gem update --system && gem update && gem cleanup"
fi

if command -v lsd &> /dev/null ; then
    alias ls="lsd"
    alias la="ls -lah"
    alias lt='ls --tree'
elif command -v exa &> /dev/null ; then
    alias ls="exa"
    alias la="exa -lahgimuU"
else
    alias ll='ls -alF'
    alias la='ls -A'
    alias l='ls -CF'
fi

if command -v shasum &> /dev/null ; then
    alias sha1sum="shasum -a 1"
    alias sha1sum="shasum -a 1"
    alias sha224sum="shasum -a 224"
    alias sha256sum="shasum -a 256"
    alias sha384sum="shasum -a 384"
    alias sha512sum="shasum -a 512"
    alias sha512224sum="shasum -a 512224"
    alias sha512256sum="shasum -a 512256"
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

    alias gdst="git diff --stat"
fi

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
