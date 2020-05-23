FROM php:7.2-apache

ENV APACHE_DOCUMENT_ROOT /var/www/html/public

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

COPY ./php/php.ini /etc

RUN apt-get update \
  && apt-get install -y zlib1g-dev libpq-dev unzip git vim curl\
  && docker-php-ext-install pdo_mysql zip

# Composer入れる
# マルチステージビルドを採用cpm
COPY --from=composer /usr/bin/composer /usr/bin/composer