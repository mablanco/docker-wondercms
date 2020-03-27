FROM php:7.4.4-apache-buster
ARG WONDERCMS_VERSION=3.0.7
WORKDIR /var/www/html
RUN apt-get update && \
    apt-get -yu dist-upgrade && \
    apt-get -y install git zip libzip-dev && \
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/{apt,dpkg,cache,log}
RUN git clone --depth 1 https://github.com/robiso/wondercms.git -b $WONDERCMS_VERSION .
RUN mv $PHP_INI_DIR/php.ini-development $PHP_INI_DIR/php.ini
RUN echo OK
RUN docker-php-ext-configure zip && \
    docker-php-ext-install -j$(nproc) zip
RUN a2enmod rewrite
RUN chown -R www-data.www-data .
EXPOSE 80
