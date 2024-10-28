FROM debian:bullseye

# Update package list and install MariaDB server and client
RUN apt update && apt upgrade -y && \
    apt install -y mariadb-server
# Copy configuration file and setup script
COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf

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
