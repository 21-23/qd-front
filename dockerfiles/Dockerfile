# -------- start nginx --------
# https://wiki.alpinelinux.org/wiki/Nginx_as_reverse_proxy_with_acme_(letsencrypt)
FROM openresty/openresty:alpine

EXPOSE 80
EXPOSE 443
EXPOSE 3001

RUN apk update
RUN apk add acme-client libressl

# nginx-related
RUN rm -rf /etc/nginx/nginx.conf /etc/nginx/conf.d/*
COPY ./nginx/nginx.conf /usr/local/openresty/nginx/conf/
COPY ./nginx/scripts /usr/local/openresty/nginx/scripts
COPY ./nginx/conf.d /etc/nginx/conf.d
# cron
COPY ./cron/crontabs/root /etc/crontabs/


RUN openssl dhparam -dsaparam -out /etc/nginx/dhparam.pem 4096

# TODO: put default pem-s to run nginx; later acme-client will update
COPY ./cert/fullchain.pem /etc/ssl/acme/2123.io/fullchain.pem
COPY ./cert/privkey.pem /etc/ssl/acme/private/2123.io/privkey.pem

# certificate auto-refresh
COPY ./cert/acme-client /etc/periodic/weekly/
RUN chmod +x /etc/periodic/weekly/acme-client

# qd-front scripts
COPY ./qd-front-scripts/prod /usr/share/qd-front-scripts
RUN chmod -R +x /usr/share/qd-front-scripts
