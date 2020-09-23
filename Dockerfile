FROM debian:buster

RUN apt update && apt install -y mariadb-server \
	php-fpm php-mysql \
	nginx \
	wget \
	vim \
	&& wget -P / https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-english.tar.gz \
	&& wget -P / https://wordpress.org/latest.tar.gz

RUN mkdir /var/www/jle-corr.com /var/www/jle-corr.com/phpmyadmin \
	&& tar xf phpMyAdmin-5.0.2-english.tar.gz --strip-components=1 -C /var/www/jle-corr.com/phpmyadmin \
	&& tar xf latest.tar.gz -C /var/www/jle-corr.com \
	&& rm phpMyAdmin-5.0.2-english.tar.gz latest.tar.gz

COPY srcs /srcs

RUN mv /srcs/jle-corr.com /etc/nginx/sites-enabled/ \
	&& mv /srcs/info.php /srcs/index.html /var/www/jle-corr.com \
	&& rm /etc/nginx/sites-enabled/default \
	&& mv /srcs/wp-config.php /var/www/jle-corr.com/wordpress \
	&& rm /var/www/jle-corr.com/wordpress/wp-config-sample.php

ENV AUTOINDEX 1

ENTRYPOINT ["/srcs/setup.sh"]
CMD ["nginx", "-g", "daemon off;"]
