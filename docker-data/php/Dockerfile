FROM php:8.3-fpm

# Install dependencies
RUN apt-get update && apt-get install -y \
    git curl libpng-dev libonig-dev libxml2-dev zip unzip default-mysql-client \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

RUN usermod -u 1000 www-data

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www

#COPY ./app .
# Instala as dependências do Laravel
#RUN composer install --no-dev --optimize-autoloader
# Adjust www folder owner
#RUN chown -R 1000:1000 /var/www
# Adjust www folder permissions
RUN chmod 755 -R /var/www

CMD ["php-fpm"]
