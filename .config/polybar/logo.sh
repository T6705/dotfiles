#!/bin/bash

#""
#""
#""
#""
#""
#""
#""
#""
#""
#""
linux=""
alpine=""
apple=""
arch=""
centos=""
debian=""
docker=""
elementary=""
fedoraA=""
fedoraB=""
freebsd=""
gentoo=""
linuxmintA=""
linuxmintB=""
manjaro=""
opensuse=""
raspberry_pi=""
slackwareA=""
slackwareB=""
ubuntu=""

distro=$(cat /etc/*-release | grep -E "^ID=" | sed 's/ID=//g' | sed 's/"//g'| sort -u | head -n 1)

case $distro in
    "alpine") echo "$alpine $distro";;
    "debian") echo "$debian $distro";;
    "arch") echo "$arch $distro";;
    "fedora") echo "$fedoraA $distro";;
    "centos") echo "$centos $distro";;
    "manjaro") echo "$manjaro $distro";;
    "ubuntu") echo "$ubuntu $distro";;
    *) echo "$linux $distro";;
esac
