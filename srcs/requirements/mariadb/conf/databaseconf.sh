#!/bin/bash

service mariadb start

sleep 5

if [[ -z "$SQL_DATABASE" || -z "$MYSQL_USER" || -z "$MYSQL_PASSWORD" ]]; then
    echo "Required environment variables SQL_DATABASE, MYSQL_USER, or MYSQL_PASSWORD are not set."
    exit 1
fi


{
    echo "CREATE DATABASE IF NOT EXISTS \`$SQL_DATABASE\`;"
    echo "CREATE USER IF NOT EXISTS '\`$MYSQL_USER\`'@'%' IDENTIFIED BY '\`$MYSQL_PASSWORD\`';"
    echo "GRANT ALL PRIVILEGES ON \`$SQL_DATABASE\`.* TO '\`$MYSQL_USER\`'@'%';"
    echo "FLUSH PRIVILEGES;"
} > file

mysql < file

service mariadb stop

mysqld_safe
