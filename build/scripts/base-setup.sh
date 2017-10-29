#!/bin/bash

. /tmp/settings.conf

case $ENV in

dev|DEV)
	ENV="dev"
	;;
prod|PROD)
	ENV="prod"
	;;
*)
	ENV="dev"
esac

# Definition of required tools and helpers for development

packageListprod="
git
wget
curl
"

packageListdev="
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

# We want an updated system

apt update && apt full-upgrade -y

if [ "prod" = "$ENV" ]; then
	apt install -y $packageListprod
else
	apt install -y $packageListprod $packageListdev
fi
