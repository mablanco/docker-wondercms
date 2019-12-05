FROM php:7.3.12-apache-buster
WORKDIR /var/www/html
RUN apt-get update && \
    apt-get -y install git zip libzip-dev && \
    apt-get clean
RUN git clone https://github.com/robiso/wondercms.git .
RUN mv $PHP_INI_DIR/php.ini-development $PHP_INI_DIR/php.ini
RUN echo OK
RUN docker-php-ext-configure zip --with-libzip && \
    docker-php-ext-install -j$(nproc) zip
RUN a2enmod rewrite
RUN chown -R www-data.www-data .
EXPOSE 80
