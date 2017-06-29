###############
## functions ##
###############
# ---------------------------------------------------------------------
# usage: ipv4_in <filename> | grep ipv4 in file
# ---------------------------------------------------------------------
function ipv4_in {
    if [ -n "$1" ]; then
        regex='([0-9]{1,3}\.){3}[0-9]{1,3}'
        grep -oE "$regex" $1
    else
        echo "'$1' is not a valid file"
    fi
}

# ---------------------------------------------------------------------
# usage: ipv6_in <filename> | grep ipv4 in file
# ---------------------------------------------------------------------
function ipv6_in {
    if [ -n "$1" ]; then
        regex='(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))'
        grep -oE "$regex" $1
    else
        echo "'$1' is not a valid file"
    fi
}

# ---------------------------------------------------------------------
# usage: url_in <filename> | grep url in file
# ---------------------------------------------------------------------
function url_in {
    if [ -n "$1" ]; then
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
function ram {
    local sum
    local items
    local app="$1"
    if [ -z "$app" ]; then
        echo "First argument - pattern to grep from processes"
    else
        sum=0
        for i in `ps aux | grep -i "$app" | grep -v "grep" | awk '{print $6}'`; do
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

# ---------------------------------------------------------------------
# usage: extract <filename>
# ---------------------------------------------------------------------
function extract {
    echo Extracting $1 ...
    if [ -f $1 ] ; then
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

# ---------------------------------------------------------------------
# usage: colours | print available colors and their numbers
# ---------------------------------------------------------------------
function colours {
    for i in {0..255}; do
        printf "\x1b[38;5;${i}m colour${i}"
        if (( $i % 5 == 0 )); then
            printf "\n"
        else
            printf "\t"
        fi
    done
}
# ---------------------------------------------------------------------
# usage: base64key <keyname> <keysize>
# ---------------------------------------------------------------------
function base64key {
    if [[ ( -n $1 && -n $2 ) ]]; then
        keyname=$1
        size=$2
        openssl rand -base64 -out $keyname $size
    else
        echo "usage: base64key <keyname> <keysize>"
    fi
}

# ---------------------------------------------------------------------
# usage: rsakeypair <keyname> <keysize>
# ---------------------------------------------------------------------
function rsakeypair {
    if [[ ( -n $1 && -n $2 ) ]]; then
        pri=$1
        size=$2
        pub="$pri.pub"
        openssl genrsa -out $pri $size
        openssl rsa -in $pri -out $pub -outform PEM -pubout
    else
        echo "usage: rsakeypair <keyname> <keysize>"
    fi
}

# ---------------------------------------------------------------------
# usage: rsaencrypt <pubkey> <infile> <outfile>
# ---------------------------------------------------------------------
function rsaencrypt {
    if [[ ( -n $1 && -n $2 && -n $3) ]]; then
        pub=$1
        infile=$2
        outfile=$3
        openssl rsautl -encrypt -inkey $pub -pubin -in $infile -out $outfile
    else
        echo "usage: rsaencrypt <pubkey> <infile> <outfile>"
    fi
}

# ---------------------------------------------------------------------
# usage: rsadecrypt <prikey> <infile> <outfile>
# ---------------------------------------------------------------------
function rsadecrypt {
    if [[ ( -n $1 && -n $2 && -n $3) ]]; then
        pri=$1
        infile=$2
        outfile=$3
        openssl rsautl -decrypt -inkey $pri -in $infile -out $outfile
    else
        echo "usage: rsadecrypt <prikey> <infile> <outfile>"
    fi
}

# ---------------------------------------------------------------------
# usage: aesencrypt <infile> <outfile>
# ---------------------------------------------------------------------
function aesencrypt {
    if [[ ( -n $1 && -n $2 && -n $3 ) ]]; then
        infile=$1
        outfile=$2
        keyfile=$3
        #openssl aes-256-cbc -a -salt -in $infile -out $outfile -kfile $keyfile
        openssl enc -aes-256-cbc -a -salt -in $infile -out $outfile -pass file:$keyfile
    elif [[ ( -n $1 && -n $2 ) ]]; then
        infile=$1
        outfile=$2
        #openssl aes-256-cbc -a -salt -in $infile -out $outfile
        openssl enc -aes-256-cbc -a -salt -in $infile -out $outfile
    else
        echo "usage:"
        echo "aesencrypt <infile> <outfile>"
        echo "aesencrypt <infile> <outfile> <keyfile>"
    fi
}

# ---------------------------------------------------------------------
# usage: aesdecrypt <infile> <outfile>
# ---------------------------------------------------------------------
function aesdecrypt {
    if [[ ( -n $1 && -n $2 && -n $3 ) ]]; then
        infile=$1
        outfile=$2
        keyfile=$3
        #openssl aes-256-cbc -d -a -in $infile -out $outfile -kfile $keyfile
        openssl enc -aes-256-cbc -d -a -in $infile -out $outfile -pass file:$keyfile
    elif [[ ( -n $1 && -n $2 ) ]]; then
        infile=$1
        outfile=$2
        #openssl aes-256-cbc -d -a -in $infile -out $outfile
        openssl enc -aes-256-cbc -d -a -in $infile -out $outfile
    else
        echo "usage:"
        echo "aesdecrypt <infile> <outfile>"
        echo "aesdecrypt <infile> <outfile> <keyfile>"
    fi
}

