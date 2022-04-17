FROM node:16

# Installing libvips-dev for sharp compatability
RUN apt-get update && apt-get install -y libvips-dev
ARG NODE_ENV=development
ENV NODE_ENV=${NODE_ENV}
WORKDIR /opt/
COPY ../backend/package.json ./
#COPY ../backend/yarn.lock ./
ENV PATH /opt/node_modules/.bin:$PATH
RUN yarn config set network-timeout 600000 -g
RUN yarn install
WORKDIR /opt/app
COPY ../backend .
RUN yarn build
EXPOSE 1337
CMD ["yarn", "develop"]