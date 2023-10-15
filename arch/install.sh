#!/bin/bash

# get .env variables
source ../.env

# add kanboard as a system user
useradd --system -s /usr/bin/nologin kanboard

# download kanboard app
wget $KANBOARD_RELEASE
tar xzvf v$KANBOARD_VERSION.tar.gz -C /srv/http/ 
mv /srv/http/kanboard-$KANBOARD_VERSION/ /srv/http/kanboard/
chown -R http:http /srv/http/kanboard/data/
rm v$KANBOARD_VERSION.tar.gz

# enable required php extensions
cp cfg/kanboard-php-extensions.ini /etc/php/conf.d/kanboard-extensions.ini

# add kanboard config files
cp data/kanboard-config.php /srv/http/kanboard/data/config.php
cp data/kanboard-nginx.conf /etc/nginx/sites-available/kanboard.conf

systemctl enable postgresql.service
systemctl enable php-fpm.service
systemctl enable nginx.service

systemctl start postgresql.service
systemctl start php-fpm.service
systemctl start nginx.service

ln -s /etc/nginx/sites-available/kanboard.conf /etc/nginx/sites-enabled/kanboard.conf
