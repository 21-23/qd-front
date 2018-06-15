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
RUN git clone https://github.com/21-23/cssqd-ui.git ./
RUN npm i
RUN npm run build:prod

# -------- start nginx --------
# https://wiki.alpinelinux.org/wiki/Nginx_as_reverse_proxy_with_acme_(letsencrypt)
FROM nginx:alpine

EXPOSE 80
EXPOSE 443

RUN apk update
RUN apk add acme-client libressl openrc

RUN rm -rf /etc/nginx/nginx.conf /etc/nginx/conf.d/*
COPY ./nginx/nginx.conf /etc/nginx/
COPY ./nginx/conf.d /etc/nginx/conf.d
COPY --from=landing-build /landing/dist /usr/share/nginx/2123/
COPY --from=lodashqd-build /_qd/dist /usr/share/nginx/2123/_qd/
COPY --from=cssqd-build /cssqd/dist-prod /usr/share/nginx/2123/cssqd/


RUN openssl dhparam -dsaparam -out /etc/nginx/dhparam.pem 4096

# certificate auto-refresh
COPY ./cert/acme-client /etc/periodic/weekly/
RUN chmod +x /etc/periodic/weekly/acme-client
CMD ["/etc/periodic/weekly/acme-client"]
