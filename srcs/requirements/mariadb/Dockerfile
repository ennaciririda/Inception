FROM debian:bullseye

# Update package list and install MariaDB server and client
RUN apt update && apt upgrade -y && \
    apt install -y mariadb-server mariadb-client

# Copy configuration file and setup script
COPY ./conf/mariadb.conf /etc/mysql/
COPY ./tools/databaseconf.sh /

# Make the setup script executable
RUN chmod +x /databaseconf.sh

# Ensure correct ownership for MySQL directories
RUN mkdir -p /var/lib/mysql /run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql /run/mysqld

# Expose MySQL port
EXPOSE 3306

# Start MariaDB using the setup script
CMD ["/bin/bash", "/databaseconf.sh"]
