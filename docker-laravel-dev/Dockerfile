FROM debian:stretch
MAINTAINER PeGa! <dev@pega.sh>

ADD build/scripts/* /tmp/

# base-setup.sh
# install-web-services-dependencies.sh
# setup-laravel-env.sh

RUN 	/tmp/scripts/base-setup.sh && \
	install-web-services-dependencies.sh && \
	setup-laravel-env.sh

# Adding custom configurations to Nginx and PHP

ADD	build/config/nginx-block.conf /etc/nginx/sites-available/default
ADD	build/config/php-pool-www.conf /etc/php/7.0/fpm/pool.d/www.conf

# Establishing working dir to app directory

WORKDIR	/var/www/html

# When the image becomes container, it will run by default the line below upon 
# "docker run" invocation.

CMD	/etc/init.d/nginx start && \
	/usr/sbin/php-fpm7.0  --fpm-config /etc/php/7.0/fpm/php-fpm.conf -g /run/php/php7.0-fpm.pid -F
