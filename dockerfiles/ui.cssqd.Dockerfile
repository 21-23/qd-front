# -------- build cssqd ui --------
FROM node:8.9.3

RUN mkdir ~/.ssh/
RUN ssh-keyscan github.com >> ~/.ssh/known_hosts

WORKDIR /cssqd
RUN git clone --branch v1.3.0 https://github.com/21-23/cssqd-ui.git ./
RUN npm i
RUN npm run build:prod