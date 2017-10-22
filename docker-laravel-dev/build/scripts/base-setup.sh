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

# Install web services and related dependencies

	apt install -y \
	nginx-extras \
	php7.0-fpm \
	php7.0-cli \
	php7.0-common \
	php7.0-xml \
	php7.0-mbstring \
	php7.0-mysql && \
#
	wget https://raw.githubusercontent.com/composer/getcomposer.org/1b137f8bf6db3e79a38a5bc45324414a6b1f9df2/web/installer -O - -q | php -- --quiet && \
	mv /tmp/composer.phar /usr/local/bin/composer && \
#
# PHP doesn't create its own /run/php directory! Working it around.
#
	mkdir -p /run/php && \
#
# Cloning latest laravel source from official repo
#
	rm -rf /var/www/html && \
	git clone https://github.com/laravel/laravel /var/www/html && \
#
# Setting up Laravel environment
#
	# Composer needs full access to the repository and doesn't want to be run as root.
	cd /var/www/html && \
	chown www-data:www-data . -R && \
	mv .env.example .env && \
	su www-data -s /bin/bash -c "composer install" && \
	su www-data -s /bin/bash -c "php artisan key:generate" && \
	# Allows writing only on public directories
	chown root:root . -R && \
	chown www-data:www-data storage bootstrap/cache -R
#
# Adding custom configurations to Nginx and PHP
#
ADD	build/config/nginx-block.conf /etc/nginx/sites-available/default
ADD	build/config/php-pool-www.conf /etc/php/7.0/fpm/pool.d/www.conf

# Establishing working dir to app directory

WORKDIR	/var/www/html

# When the image becomes container, it will run by default the line below upon 
# "docker run" invocation.

CMD	/etc/init.d/nginx start && \
	/usr/sbin/php-fpm7.0  --fpm-config /etc/php/7.0/fpm/php-fpm.conf -g /run/php/php7.0-fpm.pid -F
