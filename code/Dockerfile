######### LARAVEL SIDE ######### 

FROM php:8.1-fpm

# Install dependencies
RUN apt-get update && apt-get install -y \
    nginx \
    netcat-openbsd \
    unzip git \
    && docker-php-ext-install pdo_mysql

# Install Composer
COPY --from=composer /usr/bin/composer /usr/local/bin/composer

# Set working directory
WORKDIR /app

# Copy application files
COPY . /app

# Install dependencies
RUN composer install --no-dev --optimize-autoloader

# Set correct permissions
RUN chown -R www-data:www-data /app/storage /app/bootstrap/cache

# Generate application key
RUN php artisan key:generate

RUN cat .env




######### NGINX SIDE #########

# Copy Nginx configuration
COPY default.conf /etc/nginx/sites-available/default

# Expose ports
EXPOSE 80

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Gunakan entrypoint.sh sebagai entrypoint
ENTRYPOINT ["/entrypoint.sh"]

