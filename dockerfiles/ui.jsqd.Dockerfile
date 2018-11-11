# -------- build jsqd ui --------
FROM node:8.9.3

RUN mkdir ~/.ssh/
RUN ssh-keyscan github.com >> ~/.ssh/known_hosts

WORKDIR /jsqd
RUN git clone https://github.com/21-23/jsqd-ui.git ./
RUN npm i
RUN npm run build:prod