#!/bin/bash

# We can't install percona-server repositories before in the process without hardcoding
# the required values in sources.list, so we're going to install the official repositories
# first of all in the whole setup process.

apt update
apt install git wget lsb-release -y
cd /tmp/
wget https://repo.percona.com/apt/percona-release_0.1-4.$(lsb_release -sc)_all.deb
dpkg -i percona-release_0.1-4.$(lsb_release -sc)_all.deb
