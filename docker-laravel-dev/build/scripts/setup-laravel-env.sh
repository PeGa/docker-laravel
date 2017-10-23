#!/bin/bash

# Cloning latest laravel source from official repo

rm -rf /var/www/html
git clone https://github.com/laravel/laravel /var/www/html

# Composer needs full access to the repository and doesn't want to be run as root.

cd /var/www/html
chown www-data:www-data . -R
mv .env.example .env
su www-data -s /bin/bash -c "composer install"
su www-data -s /bin/bash -c "php artisan key:generate"

# Allows writing only on public directories

chown root:root . -R
chown www-data:www-data storage bootstrap/cache -R
