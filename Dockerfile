FROM debian:stretch
MAINTAINER PeGa! <dev@pega.sh>

WORKDIR	/tmp/

# Setting up dependencies and system tools

RUN	apt update && \
	apt install git wget -y
RUN	git clone https://github.com/pega/server-setup && \
	cd server-setup/debian-stretch/scripts/ && \
	./install-repos.sh && \
	./install-basetools.sh && \
	wget https://repo.percona.com/apt/percona-release_0.1-4.$(lsb_release -sc)_all.deb && \
	dpkg -i percona-release_0.1-4.$(lsb_release -sc)_all.deb && \
	apt update && \
	apt full-upgrade -y

# Install web services and related dependencies

RUN	apt install -y \
	nginx-extras \
	php7.0-fpm \
	php7.0-cli \
	php7.0-common \
	php7.0-xml \
	php7.0-mbstring \
	php7.0-mysql 

RUN	wget https://raw.githubusercontent.com/composer/getcomposer.org/1b137f8bf6db3e79a38a5bc45324414a6b1f9df2/web/installer -O - -q | php -- --quiet

# PHP doesn't create its own /run/php directory! Working it around.

RUN	mkdir -p /run/php

# Adding custom configurations to Nginx and PHP

ADD	build/virtualhost.conf /etc/nginx/sites-available/default
ADD	build/php-pool-www.conf /etc/php/7.0/fpm/pool.d/www.conf

# Cloning latest laravel source from official repo

RUN	rm -rf /var/www/html && \
	git clone https://github.com/laravel/laravel /var/www/html

# Setting up Laravel environment

RUN	cd /var/www/html && \
	su www-data -c "php artisan key:generate" && \
	chown www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache -R

# When the image becomes container, it will run by default the line below upon 
# "docker run" invocation.

CMD	/etc/init.d/nginx start && /usr/sbin/php-fpm7.0  --fpm-config /etc/php/7.0/fpm/php-fpm.conf -g /run/php/php7.0-fpm.pid -F
