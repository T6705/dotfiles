#############
## aliases ##
#############
alias zshconfig="$EDITOR ~/.zshrc"
alias ohmyzsh="$EDITOR ~/.oh-my-zsh"

alias cp="cp -v"
alias mv="mv -v"
alias du="du -c"

if which tr &> /dev/null ; then
    alias rot13='tr a-zA-Z n-za-mN-ZA-M'
fi

if which rkhunter &> /dev/null ; then
    alias checkrootkits="sudo rkhunter --update; sudo rkhunter --propupd; sudo rkhunter --check"
fi

if which clamscan &> /dev/null ; then
    alias checkvirus="clamscan --recursive=yes --infected ~/"
fi

if which freshclam &> /dev/null ; then
    alias updateantivirus="sudo freshclam"
fi

#Colorizing "cat" https://github.com/jingweno/ccat
if which ccat &> /dev/null ; then
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
