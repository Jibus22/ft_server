server {
	listen 80;
	listen [::]:80;
	listen 443 ssl;

	ssl_certificate /root/localhost.crt;
	ssl_certificate_key /root/localhost.key;

	server_name jle-corr;

	root /var/www/jle-corr.com;
	index index.php;

	location ~ \.php$ {
	   include snippets/fastcgi-php.conf;
	   fastcgi_pass unix:/var/run/php/php7.3-fpm.sock;
		}

	location / {
		autoindex on;
		}
	}
