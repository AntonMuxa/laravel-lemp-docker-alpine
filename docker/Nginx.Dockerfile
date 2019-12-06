FROM nginx:1.17.6-alpine

ADD docker/conf/vhost.conf /etc/nginx/conf.d/default.conf

WORKDIR /var/www/laravel-app

