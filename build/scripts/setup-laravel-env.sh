#!/bin/bash

# Composer needs full access to the repository and doesn't want to be run as root.

chmod 777 /var/www/html -R
chmod g+s /var/www/html -R

cd /var/www/html
mv .env.example .env
su www-data -s /bin/bash -c "composer install"
su www-data -s /bin/bash -c "php artisan key:generate"

# Allows writing everywhere

