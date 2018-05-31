#!/bin/sh

	echo 'installazione dashboard....'

	git clone https://github.com/dg9vh/MMDVMHost-Dashboard.git /var/www/html/MMDVMHost-Dashboard

	groupadd www-data
	usermod -G www-data -a pi
	chown -R www-data:www-data /var/www/html
	chmod -R 775 /var/www/html
	
	apt-get install php7.0-common php7.0-cgi php
	apt-get install sqlite3 php7.0-sqlite
	
	lighty-enable-mod fastcgi
	lighty-enable-mod fastcgi-php
	service lighttpd force-reload
	
exit 0
