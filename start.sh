#!/bin/sh

docker compose build
docker compose up -d

docker exec -it nuxt //bin//sh -c "npm install --dev && npm install nuxt && npm run dev"