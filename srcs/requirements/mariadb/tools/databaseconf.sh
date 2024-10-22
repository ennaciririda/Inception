#!/bin/bash

# Create socket directory and set permissions
mkdir -p /run/mysqld
chown mysql:mysql /run/mysqld

# Initialize MariaDB data directory if it does not exist
if [ ! -d /var/lib/mysql/mysql ]; then
    echo "Initializing MariaDB data directory..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

# Start MariaDB server in the background
echo "Starting MariaDB server..."
/usr/bin/mysqld_safe --datadir=/var/lib/mysql --socket=/run/mysqld/mysqld.sock &

# Wait for MariaDB to start
sleep 5

# Check for required environment variables
if [ -z "$DB_NAME" ] || [ -z "$DB_USER" ] || [ -z "$DB_PASSWORD" ]; then
    echo "Error: Required environment variables DB_NAME, DB_USER, or DB_PASSWORD are not set."
    exit 1
fi

# Create SQL commands to set up the database and user
echo "Setting up database and user..."
{
    echo "CREATE DATABASE IF NOT EXISTS \`$DB_NAME\`;"
    echo "CREATE USER IF NOT EXISTS '\`$DB_USER\`'@'%' IDENTIFIED BY '\`$DB_PASSWORD\`';"
    echo "GRANT ALL PRIVILEGES ON \`$DB_NAME\`.* TO '\`$DB_USER\`'@'%';"
    echo "FLUSH PRIVILEGES;"
} > /tmp/setup.sql

# Execute SQL commands
mysql --socket=/run/mysqld/mysqld.sock < /tmp/setup.sql

# Cleanup
rm /tmp/setup.sql

# # Stop MariaDB server gracefully
# echo "Stopping MariaDB server..."
# mysqladmin --socket=/run/mysqld/mysqld.sock -u root shutdown

# # Keep the container running indefinitely
# sleep infinity

echo "MariaDB setup complete. Keeping server running..."
wait
