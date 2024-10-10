FROM alpine:3.17
RUN apk update && apk upgrade && apk add mariadb
COPY ./conf/mariadb.conf /etc/mysql/
COPY ./conf/databaseconf.sh /
RUN chmod +x /databaseconf.sh
CMD ["./databaseconf.sh"]