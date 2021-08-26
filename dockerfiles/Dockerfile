# -------- start nginx --------
# https://www.nginx.com/blog/using-free-ssltls-certificates-from-lets-encrypt-with-nginx/
FROM openresty/openresty:alpine

EXPOSE 80
EXPOSE 443

RUN apk update
RUN apk add build-base openssl certbot certbot-nginx

# nginx-related
RUN rm -rf /etc/nginx/nginx.conf /etc/nginx/conf.d/*
COPY ./nginx/nginx.conf /usr/local/openresty/nginx/conf/
COPY ./nginx/scripts /usr/local/openresty/nginx/scripts
COPY ./nginx/conf.d /etc/nginx/conf.d
RUN ln -s /usr/local/openresty/nginx/conf/nginx.conf /etc/nginx/nginx.conf
RUN ln -s /usr/local/openresty/nginx/conf/mime.types /etc/nginx/mime.types

# qd-front scripts
COPY ./qd-front-scripts/prod /usr/share/qd-front-scripts
RUN chmod -R +x /usr/share/qd-front-scripts
