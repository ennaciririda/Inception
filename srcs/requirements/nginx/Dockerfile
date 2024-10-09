FROM alpine:3.17
RUN apk update && apk upgrade && apk add nginx vim curl openssl
RUN mkdir -p /etc/nginx/ssl && openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=MA/ST=khouribga/O=1337/CN=rennacir.42.fr"
RUN mkdir -p /var/run/nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
