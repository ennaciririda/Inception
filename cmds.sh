#!/bin/bash
docker stop wordpress nginx mariadb
docker rm wordpress nginx mariadb
docker volume rm srcs_wordpress srcs_mariadb
docker rmi wordpress:reda nginx:reda mariadb:reda