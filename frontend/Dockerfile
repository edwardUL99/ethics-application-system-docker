FROM node:12.2.0-alpine

RUN mkdir -p /home/ethics/ &&\
  chmod 777 /home/ethics &&\
  npm install express --no-save

COPY dist/ /home/ethics/dist
COPY server.js /home/ethics

WORKDIR /home/ethics

CMD [ "node", "server.js" ]