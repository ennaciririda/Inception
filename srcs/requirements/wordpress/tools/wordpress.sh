#!/bin/bash

# Wait for MariaDB to be ready
sleep 20

# Download wp-cli.phar
curl -o wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# Make it executable and move to a directory in the PATH
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# Adjust PHP-FPM configuration for Alpine
sed -i 's|^listen =.*|listen = 9000|' /etc/php81/php-fpm.d/www.conf

# Create necessary directories
mkdir -p /run/php
mkdir -p /var/www/html

# Change to the web root directory
cd /var/www/html

# Download WordPress using wp-cli
wp core download --allow-root

# Move the sample config file to wp-config.php
mv wp-config-sample.php wp-config.php

# Set database configuration using environment variables
wp config set DB_NAME "$DB_NAME" --allow-root --path=/var/www/html
wp config set DB_USER "$DB_USER" --allow-root --path=/var/www/html
wp config set DB_PASSWORD "$DB_PASSWORD" --allow-root --path=/var/www/html
wp config set DB_HOST 'mariadb:3306' --allow-root --path=/var/www/html

# Install WordPress with provided environment variables
wp core install --allow-root --url="${DOMAIN_NAME}" --title="inception" \
    --admin_user="${WP_ADMIN_USER}" --admin_password="${WP_ADMIN_PASSWORD}" \
    --admin_email="${WP_ADMIN_EMAIL}" --skip-email --path='/var/www/html'

# Create a user with provided environment variables
wp user create "$WP_USER" "$WP_USER_EMAIL" --role=author --user_pass="$WP_USER_PASSWORD" \
    --allow-root --path=/var/www/html

# Start PHP-FPM service (use the correct path for Alpine Linux)
php-fpm81 -F
