FROM debian:bullseye

# Update package list and install necessary packages
RUN apt update && apt upgrade -y && apt install -y nginx vim curl openssl

# Create directory for SSL certificates and generate a self-signed certificate
RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=MA/ST=khouribga/O=1337/CN=reda.42.fr"

# Create the run directory for nginx
RUN mkdir -p /var/run/nginx

# Copy the nginx configuration file
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]
