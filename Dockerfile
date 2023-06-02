
FROM php:7.4-apache
WORKDIR /var/www/html
COPY . .
RUN apt-get update && apt-get install -y \
    zlib1g-dev \
    libzip-dev \
    && docker-php-ext-install zip \
    && a2enmod rewrite
EXPOSE 8000
CMD ["apache2-foreground"]

