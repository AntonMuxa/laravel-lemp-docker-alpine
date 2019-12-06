#!/bin/sh

# CONFIGURE APACHE
sed -i "s/#LoadModule\ rewrite_module/LoadModule\ rewrite_module/" /etc/apache2/httpd.conf
sed -i "s/#LoadModule\ session_module/LoadModule\ session_module/" /etc/apache2/httpd.conf
sed -i "s/#LoadModule\ session_cookie_module/LoadModule\ session_cookie_module/" /etc/apache2/httpd.conf
sed -i "s/#LoadModule\ session_crypto_module/LoadModule\ session_crypto_module/" /etc/apache2/httpd.conf
sed -i "s/#LoadModule\ deflate_module/LoadModule\ deflate_module/" /etc/apache2/httpd.conf
sed -i "s#^DocumentRoot \".*#DocumentRoot \"/var/www/html/public\"#g" /etc/apache2/httpd.conf
sed -i "s#/var/www/localhost/htdocs#/var/www/html/public#" /etc/apache2/httpd.conf
printf "\n<Directory \"/var/www/html/public\">\n\tAllowOverride All\n</Directory>\n" >> /etc/apache2/httpd.conf

# CONFIGURE PHP
if [ ! -z "$PHP_UPLOAD_TMP_DIR" ]; then sed -i "s~\;upload_tmp_dir =~upload_tmp_dir = "$PHP_UPLOAD_TMP_DIR"~" /etc/php7/php.ini; fi
if [ ! -z "$PHP_UPLOAD_MAX_FILESIZE" ]; then sed -i "s/\;\?\\s\?upload_max_filesize = .*/upload_max_filesize = $PHP_UPLOAD_MAX_FILESIZE/" /etc/php7/php.ini; fi
if [ ! -z "$PHP_SESSION_NAME" ]; then sed -i "s/\;\?\\s\?session.name = .*/session.name = $PHP_SESSION_NAME/" /etc/php7/php.ini; fi
if [ ! -z "$PHP_SESSION_SAVE_PATH" ]; then sed -i "s~\;\?\\s\?session.save_path = .*~session.save_path = $PHP_SESSION_SAVE_PATH~" /etc/php7/php.ini; fi

# RUN OPTIMIZE LARAVEL
php artisan optimize

# PRINT START TIME
echo "Start Apache Webserver: $(date '+%Y-%m-%d %H:%M:%S')"

# EXEC NGINX DAEMON
exec httpd -D FOREGROUND
