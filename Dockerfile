# -------- build env --------
FROM node:8.9.3 as build-env
RUN mkdir ~/.ssh/
RUN ssh-keyscan github.com >> ~/.ssh/known_hosts

# -------- build landing --------
FROM build-env as landing-build
WORKDIR /landing
RUN git clone https://github.com/21-23/2123.io.git ./
RUN npm i
RUN npm run build

# -------- build _qd --------
FROM build-env as lodashqd-build
WORKDIR /_qd
RUN git clone https://github.com/21-23/_qd-ui.git ./
RUN npm i
RUN npm run build

# -------- build cssqd --------
FROM build-env as cssqd-build
WORKDIR /cssqd
RUN git clone --branch v1.2.0 https://github.com/21-23/cssqd-ui.git ./
RUN npm i
RUN npm run build:prod

# -------- build jsqd --------
FROM build-env as jsqd-build
WORKDIR /jsqd
RUN git clone https://github.com/21-23/jsqd-ui.git ./
RUN npm i
RUN npm run build:prod

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
# ui-s
COPY --from=landing-build /landing/dist /usr/share/nginx/2123/
COPY --from=lodashqd-build /_qd/dist /usr/share/nginx/2123/_qd/
COPY --from=cssqd-build /cssqd/dist-prod /usr/share/nginx/2123/cssqd/
COPY --from=jsqd-build /jsqd/dist-prod /usr/share/nginx/2123/jsqd/


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
