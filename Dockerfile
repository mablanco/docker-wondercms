FROM php:7.2-apache
WORKDIR /var/www/html
RUN apt-get update && \
    apt-get -y install git zlib1g-dev && \
    apt-get clean
RUN git clone https://github.com/robiso/wondercms.git .
RUN mv $PHP_INI_DIR/php.ini-development $PHP_INI_DIR/php.ini
RUN docker-php-ext-install -j$(nproc) zip
RUN apt-get -y --purge remove zlib1g-dev
RUN a2enmod rewrite
RUN chown -R www-data.www-data .
EXPOSE 80
