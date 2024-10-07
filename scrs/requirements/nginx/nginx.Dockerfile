FROM debian:buster

# Atuomatic installation 
RUN apt update
RUN apt install -y nginx \
    openssl

# nginx SSL + self signed ssl ceritifcate using Opne ssl
RUN mkdir /etc/nginx/ssl 
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
    -out /etc/nginx/ssl/maabdela.crt \
    -keyout /etc/nginx/ssl/maabdela.key \
    -subj "/C=PL/ST=Warsaw/L=Warsaw/O=42 School/OU=maabdela/CN=maabdela/"
COPY ./conf/nginx.conf /etc/nginx/conf.d 

RUN mkdir /run/nginx

# in our case since we assigned the posrt 443 for defualt HTTPS so
# we need to expose the same port 
EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]