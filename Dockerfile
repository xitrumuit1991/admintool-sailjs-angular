#use image available of docker hub
FROM node:9-alpine
ENV NODE_VERSION 8.9.4

#FROM node:8.9
#ENV NODE_VERSION 8.9.4

# copy source to folder of docker
COPY . /admin

# cd into directory in docker
WORKDIR /admin
RUN rm -rf ./config/local.js
RUN cp ./config/local_production.js ./config/env/production.js

#if you want to install gem, sass, ruby for grunt-task (FROM node:8.9)
#RUN apt-get update
#RUN apt-get install -y rubygems ruby-dev

RUN chmod -R 777 ./
RUN node -v
RUN npm -v
RUN ls -la
#RUN npm update
RUN npm install

#if you want to install gem, sass, ruby for grunt-task (FROM node:8.9)
#RUN gem install sass

#port EXPOSE
EXPOSE 8080
ENV NODE_ENV production
RUN echo $NODE_ENV
#RUN /admin/node_modules/grunt/bin/grunt prod
ENTRYPOINT ["npm","start"]