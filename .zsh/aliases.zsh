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

alias nethack-ascrun="ssh -Y nethack@ascension.run"

if which gem &> /dev/null ; then
    alias gemup="gem update --system && gem update && gem cleanup"
fi

if which python3 &> /dev/null ; then
    alias pywebserver-cgi="python -m http.server --cgi"
    alias pywebserver-local="python3 -m http.server --bind 127.0.0.1"
    alias pywebserver="python3 -m http.server"
elif which python2 &> /dev/null ; then
    alias pywebserver="python -m SimpleHTTPServer"
fi

if which youtube-dl &> /dev/null ; then
    alias mp3="youtube-dl --extract-audio --audio-format mp3"
fi

if which xclip &> /dev/null ; then
	alias xcopy='xclip -selection clipboard'
	alias xpaste='xclip -selection clipboard -o'
fi

if which tr &> /dev/null ; then
    alias rot13='tr a-zA-Z n-za-mN-ZA-M'
fi

if which clamscan &> /dev/null ; then
    alias checkvirus="clamscan --recursive=yes --infected ~/"
fi

if which freshclam &> /dev/null ; then
    alias updateantivirus="sudo freshclam"
fi

if which rkhunter &> /dev/null ; then
    alias checkrootkits="sudo rkhunter --update; sudo rkhunter --propupd; sudo rkhunter --check"
fi

#Colorizing "cat" https://github.com/jingweno/ccat
if which ccat &> /dev/null ; then
    alias cat='ccat --bg=dark'
fi

# fast Vim that doesn't load a vimrc or plugins
alias vimn='vim -N -u NONE'
# fast Neovim that doesn't load a vimrc or plugins
alias nvimn='nvim -N -u NONE'

# ------------------------------------
# Docker functions
# ------------------------------------

docker_alias_stop_all_containers() { docker stop $(docker ps -a -q); }
docker_alias_remove_all_containers() { docker rm $(docker ps -a -q); }
docker_alias_remove_all_empty_images() {docker images | awk '{print $2 " " $3}' | grep '^<none>' | awk '{print $2}' | xargs -I{} docker rmi {}; }
docker_alias_docker_file_build() { docker build -t=$1 .; }
docker_alias_show_all_docker_related_alias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }
docker_alias_bash_into_running_container() { docker exec -it $(docker ps -aqf "name=$1") bash; }

# ------------------------------------
# Docker alias
# ------------------------------------
if which docker &> /dev/null ; then
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
