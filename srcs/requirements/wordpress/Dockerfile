# Use Debian Bullseye as the base image
FROM debian:bullseye

# Install required packages for adding repositories and curl
RUN apt update && apt install -y \
    gnupg \
    curl \
    lsb-release \
    software-properties-common

# Add PHP repository and update package list
RUN curl -fsSL https://packages.sury.org/php/apt.gpg -o /usr/share/keyrings/php-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/php-archive-keyring.gpg] https://packages.sury.org/php/ $(lsb_release -cs) main" > /etc/apt/sources.list.d/php.list && \
    apt update

# Install PHP, PHP-FPM, MariaDB client, and other required packages
RUN apt install -y \
    php7.4 \
    php7.4-fpm \
    php7.4-mysql \
    mariadb-client \
    netcat

# Copy the WordPress setup script
COPY tools/wordpress.sh /usr/local/bin/wordpress.sh

# Make the script executable
RUN chmod +x /usr/local/bin/wordpress.sh

# Install wp-cli in the Docker image
RUN curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x /usr/local/bin/wp

# Command to run the WordPress setup script
CMD ["sh", "/usr/local/bin/wordpress.sh"]
