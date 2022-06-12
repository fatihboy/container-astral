FROM composer:1.10.19 as composer

RUN git clone https://github.com/astralapp/astral.git
WORKDIR astral

RUN git checkout 6f5b706 && \
    composer install

FROM node:14.17-alpine3.14 as node

COPY --from=composer /app/astral/ /astral/

WORKDIR /astral
RUN yarn && \
    yarn prod && \
    rm -rf node_modules/

FROM php:7.4.5-apache-buster

RUN a2enmod rewrite && \
    echo "ServerName localhost" >> /etc/apache2/apache2.conf && \
    docker-php-ext-install mysqli pdo pdo_mysql && \
    sed -ri -e 's!/var/www/html!/var/www/html/public!g' /etc/apache2/sites-available/*.conf && \
    sed -ri -e 's!/var/www/!/var/www/html/public!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

COPY --from=node --chown=www-data:www-data /astral/ /var/www/html/
