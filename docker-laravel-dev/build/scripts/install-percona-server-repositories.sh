#!/bin/bash

# We can't install percona-server repositories before in the process without hardcoding
# the required values in sources.list, so we're going to install the official repositories
# first of all in the whole setup process.

packageList="
wget
lsb-release
apt-transport-https
gnupg
"
apt update
apt full-upgrade -y

apt install $packageList -y

cd /tmp/

wget https://repo.percona.com/apt/percona-release_0.1-4.$(lsb_release -sc)_all.deb
dpkg -i /tmp/percona-release_0.1-4.$(lsb_release -sc)_all.deb
