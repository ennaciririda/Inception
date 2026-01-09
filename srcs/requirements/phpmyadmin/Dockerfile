FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    php \
    php-fpm \
    php-mysql \
    php-mbstring \
    php-zip \
    php-gd \
    php-json \
    php-curl \
    wget \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

RUN wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz \
    && tar -xzf phpMyAdmin-latest-all-languages.tar.gz \
    && rm phpMyAdmin-latest-all-languages.tar.gz \
    && mv phpMyAdmin-*-all-languages/* . \
    && rm -rf phpMyAdmin-*-all-languages

COPY conf/config.inc.php /var/www/html/config.inc.php

RUN mkdir -p /var/www/html/tmp && chmod 777 /var/www/html/tmp

RUN sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf

RUN mkdir -p /run/php && chmod 755 /run/php

EXPOSE 9000

CMD ["php-fpm7.4", "-F"]
