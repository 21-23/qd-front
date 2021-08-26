# -------- build _qd ui --------
FROM node:8.9.3

RUN mkdir ~/.ssh/
RUN ssh-keyscan github.com >> ~/.ssh/known_hosts

WORKDIR /_qd
RUN git clone --branch v2.0.0 https://github.com/21-23/_qd-ui.git ./
RUN npm i
RUN npm run build
