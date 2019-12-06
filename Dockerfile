FROM alpine:3.10

# INSTALL SERVICES
RUN apk --no-cache update && apk --no-cache upgrade && apk add --no-cache \
	zip \
	unzip \
	curl \
	wget \
	apache2 \
	mysql-client

# INSTALL PHP AND MODULES
RUN apk add --no-cache \
	curl \
	php7 \
    php7-apache2 \
	php7-zip \
	php7-gd \
	php7-pgsql \
	php7-pdo \
	php7-pdo_pgsql \
	php7-pdo_mysql \
	php7-mysqli \
	php7-zlib \
	php7-curl \
	php7-redis \
	php7-soap \
	php7-json \
	php7-mbstring \
	php7-gd \
	php7-session \
	php7-openssl \
	php7-igbinary \
	php7-xml \
	php7-iconv \
	php7-dom \
	php7-tokenizer \
	php7-fileinfo \
	php7-xmlwriter \
	php7-simplexml \
	php7-posix \
	php7-pcntl \
	composer

RUN cp /usr/bin/php7 /usr/bin/php

# SET TIME TO Europe/Kiev
RUN apk --no-cache add tzdata \
	&& cp /usr/share/zoneinfo/Europe/Kiev /etc/localtime \
	&& echo "Europe/Kiev" >  /etc/timezone \
	&& apk del tzdata \
	&& sed -i "s/^;date.timezone =$/date.timezone = \"Europe\/Kiev\"/" /etc/php7/php.ini

# SET WORKDIR FOLDER
WORKDIR /var/www/html


# COPY LARAVEL FROM SOURCE
COPY . .

# Composer parallel install plugin
RUN composer global require hirak/prestissimo
# INSTALL LIBRARIES
RUN composer install

# COPY RUN SCRIPT
COPY scripts/start.sh /start.sh
RUN chmod +x /start.sh

# EXPOSE PORT
EXPOSE 80

CMD ["/start.sh"]
