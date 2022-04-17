# Dockerfile
FROM node:14.16.1-alpine

# Create destination directory
RUN mkdir -p /usr/src/nuxt
WORKDIR /usr/src/nuxt

# Update and install vim and git
RUN apk update && apk upgrade
RUN apk add git
RUN apk add vim

# Copy package.json to install dependencies
COPY ./nuxt/package.json /usr/src/nuxt/
RUN npm install

# Set port
EXPOSE 3000

ENV NUXT_HOST=0.0.0.0
ENV NUXT_PORT=3000

#CMD [ "npm", "run", "dev" ]