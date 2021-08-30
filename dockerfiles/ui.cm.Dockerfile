# -------- build jsqd ui --------
FROM node:16.8.0

RUN mkdir ~/.ssh/
RUN ssh-keyscan github.com >> ~/.ssh/known_hosts

WORKDIR /cm
RUN git clone https://github.com/21-23/cm-ui.git ./
RUN npm ci
RUN npm run build:prod
