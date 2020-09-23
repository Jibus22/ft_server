#!/bin/sh

chown -R www-data:www-data /var/www/jle-corr.com

openssl req -x509 -out /root/localhost.crt -keyout /root/localhost.key \
  -newkey rsa:2048 -nodes -sha256 \
  -subj '/CN=localhost'

service php7.3-fpm start
service mysql start

mysql -u root < /srcs/db_create.sql

if [ "$AUTOINDEX" != "1" ]; then
	sed -i '20 s/on/off/' /etc/nginx/sites-enabled/jle-corr.com
fi

exec "$@"
