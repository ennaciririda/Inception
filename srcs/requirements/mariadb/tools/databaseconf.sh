#!/bin/bash

mysqld_safe &

until mysqladmin ping --silent; do
    echo "Waiting for MariaDB to be ready..."
    sleep 2
done

# mysql -e "ALTER USER 'root'@'%' IDENTIFIED BY '$DB_ROOT_PWD';"
mysql -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
mysql -e "CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';"
mysql -e "GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';"
mysql -e "FLUSH PRIVILEGES;"

mysqladmin shutdown
echo "Database configuration completed."
mysqld_safe