#!/bin/bash

# install the software stack
pacman -S --noconfirm wget nginx postgresql php php-pgsql php-gd php-fpm

# add server config directories to nginx
mkdir -p /etc/nginx/sites-available/
mkdir -p /etc/nginx/sites-enabled/
