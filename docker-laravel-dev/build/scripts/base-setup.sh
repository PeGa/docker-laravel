#!/bin/bash

# Definition of required tools and helpers for development

packageList="
git
apt-file
apt-transport-https
apt-utils
aptitude
aria2
axel
bash-completion
bind9utils
build-essential
bwm-ng
cmake
colordiff
curl
dialog
dstat
geoip-bin
geoip-database-contrib
htop
iftop
iptraf
less
locales
locate
logrotate
lsb-release
mailutils
man-db
mc
ncdu
nmap
openssh-client
openssh-server
pkg-config
psmisc
rcconf
rsync
ssmtp
strace
tmux
vim
whois
"

# Remember, percona-sever repositories are already installed!

apt install -y $packageList
