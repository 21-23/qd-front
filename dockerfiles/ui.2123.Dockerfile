# -------- build landing ui --------
FROM node:8.9.3

RUN mkdir ~/.ssh/
RUN ssh-keyscan github.com >> ~/.ssh/known_hosts

WORKDIR /landing
RUN git clone --branch v2.0.0 https://github.com/21-23/2123.io.git ./
RUN npm i
RUN npm run build
