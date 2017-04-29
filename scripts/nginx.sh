#!/bin/bash
export DEBIAN_FRONTEND=noninteractive

wget http://www.dotdeb.org/dotdeb.gpg -O - | apt-key add -

apt-get update

apt-get -qy install nginx curl
rm -f /etc/nginx/sites-available/default
rm -f /etc/nginx/sites-available/nginx.conf

apt-get -qy install \
    php5-fpm \
    php5-cli \
    php5-intl \
    php5-xhprof

curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
apt-get -qy install mysql-client mysql-server php5-mysqlnd

wget https://wordpress.org/latest.tar.gz -O /tmp/latest.tar.gz
mkdir /var/www
chown www-data:www-data /var/www
tar xfz /tmp/latest.tar.gz -C /var/www
mysql -uroot  -e 'create database wordpress'
mysql -uroot  -e 'show databases'|grep word
cp /tmp/www.conf /etc/php5/fpm/pool.d/www.conf
cp /tmp/php.ini /etc/php5/fpm/php.ini
cp /tmp/nginx.conf /etc/nginx/nginx.conf
chown -R www-data:www-data /var/www