#!/bin/bash
cd /tmp 
apt update
apt install git wget -y 
git clone https://github.com/pega/server-setup
cd server-setup/debian-stretch/scripts/ 
./install-repos.sh
./install-basetools.sh
cd /tmp
wget https://repo.percona.com/apt/percona-release_0.1-4.$(lsb_release -sc)_all.deb
dpkg -i percona-release_0.1-4.$(lsb_release -sc)_all.deb
apt update
apt full-upgrade -y
