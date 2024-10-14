FROM alpine:3.17

# Update and install MariaDB and client
RUN apk update && apk upgrade && apk add mariadb mariadb-client openrc

# Copy configuration and script
COPY ./conf/mariadb.conf /etc/mysql/
COPY ./tools/databaseconf.sh /

# Make the script executable
RUN chmod +x /databaseconf.sh

# Set data directory permissions
RUN mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql

# Start MariaDB
CMD ["sh", "./databaseconf.sh"]
