#!/bin/bash

# PHP 7.0 and related libs
# nginx-extras
# composer

# cd to /tmp so we can grab composer.phar at a predictable location
cd /tmp/

phpPackages="
nginx-extras
php7.0-fpm
php7.0-cli
php7.0-common
php7.0-xml
php7.0-mbstring
php7.0-mysql
"
apt install -y $phpPackages

wget https://raw.githubusercontent.com/composer/getcomposer.org/1b137f8bf6db3e79a38a5bc45324414a6b1f9df2/web/installer -O - -q | php  -- --quiet

mv /tmp/composer.phar /usr/local/bin/composer

# PHP doesn't create its own /run/php directory! Working it around.

mkdir -p /run/php

# Cloning latest laravel source from official repo

rm -rf /var/www/html

git clone https://github.com/laravel/laravel /var/www/html
