#!/bin/bash

# Create socket directory and set permissions
mkdir -p /run/mysqld
chown mysql:mysql /run/mysqld

# Initialize MariaDB data directory if it does not exist
if [ ! -d /var/lib/mysql/mysql ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

# Start MariaDB server
/usr/bin/mysqld_safe --datadir=/var/lib/mysql --socket=/run/mysqld/mysqld.sock &

# Wait for MariaDB to start
sleep 5

# Check for required environment variables
if [[ -z "$SQL_DATABASE" || -z "$MYSQL_USER" || -z "$MYSQL_PASSWORD" ]]; then
    echo "Required environment variables SQL_DATABASE, MYSQL_USER, or MYSQL_PASSWORD are not set."
    exit 1
fi

# Create SQL commands
{
    echo "CREATE DATABASE IF NOT EXISTS \`$SQL_DATABASE\`;"
    echo "CREATE USER IF NOT EXISTS '\`$MYSQL_USER\`'@'%' IDENTIFIED BY '\`$MYSQL_PASSWORD\`';"
    echo "GRANT ALL PRIVILEGES ON \`$SQL_DATABASE\`.* TO '\`$MYSQL_USER\`'@'%';"
    echo "FLUSH PRIVILEGES;"
} > file

# Execute SQL commands
mysql --socket=/run/mysqld/mysqld.sock < file

# Cleanup
rm file

# Stop MariaDB server
kill $(pgrep mysqld)

# Wait for mysqld to exit
wait
sleep infinity