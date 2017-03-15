FROM php:7.1-apache
MAINTAINER Markus Krogh <markus@nordu.net>
RUN apt-get update && apt-get install -y \
        zlib1g-dev \
        libmcrypt-dev \
    && docker-php-ext-install -j$(nproc) mcrypt
RUN mkdir -p /var/simplesamlphp/www
COPY apache/php-limit.ini /usr/local/etc/php/conf.d/
COPY apache/box-sp.conf /etc/apache2/sites-available/
RUN a2ensite box-sp && a2dissite 000-default
ENV SP_BASENAME "https://box-idp.nordu.net"

