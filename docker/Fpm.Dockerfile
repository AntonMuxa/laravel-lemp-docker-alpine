FROM php:7.2.25-fpm-alpine3.9

WORKDIR /var/www/laravel-app
RUN apk update \
&& docker-php-ext-install pdo pdo_mysql
