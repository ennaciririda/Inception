FROM alpine:3.17
RUN apk update && apk upgrade && apk add --no-cache \
    php \
    php-fpm \
    php-mysqli \
    php-phar \
    mariadb-client \
    curl
COPY tools/wordpress.sh /usr/local/bin/wordpress.sh
RUN chmod +x /usr/local/bin/wordpress.sh
CMD ["sh", "/usr/local/bin/wordpress.sh"]